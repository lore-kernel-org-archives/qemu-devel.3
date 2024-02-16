Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 465A2C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 13:33:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rayKg-0008Cz-OL; Fri, 16 Feb 2024 08:32:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1rayK6-000848-NQ
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 08:32:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1rayK3-0006Dp-61
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 08:32:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708090325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7J3LwHjvXfp/0gMoISOYuYCZbcxJhpKjc71h88Jg4vI=;
 b=MQnwbEymR17QT27voZHRGqvr48IpgfvWqKnaKik9mUpVV9t56OreuIqN4tt0oyWPC15fBl
 a61H8WMKsihFMwqWO0HzqRlyvnUXjiKKG0QBZEYDxFDZ6cOtBYptREBEliF07ab+0ZTsDn
 Q8oW/j0phIoA4y8UjFWkCM3dR3SKCDM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-267-LpyI-bqLP5GW-Z7hkEJ_mQ-1; Fri,
 16 Feb 2024 08:32:02 -0500
X-MC-Unique: LpyI-bqLP5GW-Z7hkEJ_mQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AA9D41C05AFB;
 Fri, 16 Feb 2024 13:32:01 +0000 (UTC)
Received: from localhost (unknown [10.39.208.8])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 82AD314F0;
 Fri, 16 Feb 2024 13:31:59 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, peter.maydell@linaro.org,
 Fiona Ebner <f.ebner@proxmox.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 3/7] ui/clipboard: add asserts for update and request
Date: Fri, 16 Feb 2024 17:31:36 +0400
Message-ID: <20240216133140.3611100-4-marcandre.lureau@redhat.com>
In-Reply-To: <20240216133140.3611100-1-marcandre.lureau@redhat.com>
References: <20240216133140.3611100-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.364,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

From: Fiona Ebner <f.ebner@proxmox.com>

Should an issue like CVE-2023-6683 ever appear again in the future,
it will be more obvious which assumption was violated.

Suggested-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20240124105749.204610-2-f.ebner@proxmox.com>
---
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
2.43.1


