Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EC16C47E49
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 10:59:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSaxn-00073F-4N; Wed, 24 Jan 2024 05:58:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rSaxl-00072a-4b
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 05:58:33 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rSaxj-0002zl-KG
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 05:58:32 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 9163349256;
 Wed, 24 Jan 2024 11:58:29 +0100 (CET)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, m.frank@proxmox.com, marcandre.lureau@redhat.com,
 berrange@redhat.com, mcascell@redhat.com
Subject: [PATCH v3 2/2] ui/clipboard: add asserts for update and request
Date: Wed, 24 Jan 2024 11:57:49 +0100
Message-Id: <20240124105749.204610-2-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240124105749.204610-1-f.ebner@proxmox.com>
References: <20240124105749.204610-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Should an issue like CVE-2023-6683 ever appear again in the future,
it will be more obvious which assumption was violated.

Suggested-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---

Changes in v3:
    * Turn check for update into an assertion.
    * Split out into a separate patch.

 ui/clipboard.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/ui/clipboard.c b/ui/clipboard.c
index b3f6fa3c9e..4264884a6c 100644
--- a/ui/clipboard.c
+++ b/ui/clipboard.c
@@ -65,12 +65,24 @@ bool qemu_clipboard_check_serial(QemuClipboardInfo *info, bool client)
 
 void qemu_clipboard_update(QemuClipboardInfo *info)
 {
+    uint32_t type;
     QemuClipboardNotify notify = {
         .type = QEMU_CLIPBOARD_UPDATE_INFO,
         .info = info,
     };
     assert(info->selection < QEMU_CLIPBOARD_SELECTION__COUNT);
 
+    for (type = 0; type < QEMU_CLIPBOARD_TYPE__COUNT; type++) {
+        /*
+         * If data is missing, the clipboard owner's 'request' callback needs to
+         * be set. Otherwise, there is no way to get the clipboard data and
+         * qemu_clipboard_request() cannot be called.
+         */
+        if (info->types[type].available && !info->types[type].data) {
+            assert(info->owner && info->owner->request);
+        }
+    }
+
     notifier_list_notify(&clipboard_notifiers, &notify);
 
     if (cbinfo[info->selection] != info) {
@@ -132,6 +144,8 @@ void qemu_clipboard_request(QemuClipboardInfo *info,
         !info->owner)
         return;
 
+    assert(info->owner->request);
+
     info->types[type].requested = true;
     info->owner->request(info, type);
 }
-- 
2.39.2



