Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B217C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 10:59:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSaxe-0006zw-IA; Wed, 24 Jan 2024 05:58:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rSaxd-0006zb-0B; Wed, 24 Jan 2024 05:58:25 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rSaxb-0002xm-5F; Wed, 24 Jan 2024 05:58:24 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id DAFF749264;
 Wed, 24 Jan 2024 11:58:19 +0100 (CET)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, m.frank@proxmox.com, marcandre.lureau@redhat.com,
 berrange@redhat.com, mcascell@redhat.com, qemu-stable@nongnu.org
Subject: [PATCH v3 1/2] ui/clipboard: mark type as not available when there is
 no data
Date: Wed, 24 Jan 2024 11:57:48 +0100
Message-Id: <20240124105749.204610-1-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.2
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

With VNC, a client can send a non-extended VNC_MSG_CLIENT_CUT_TEXT
message with len=0. In qemu_clipboard_set_data(), the clipboard info
will be updated setting data to NULL (because g_memdup(data, size)
returns NULL when size is 0). If the client does not set the
VNC_ENCODING_CLIPBOARD_EXT feature when setting up the encodings, then
the 'request' callback for the clipboard peer is not initialized.
Later, because data is NULL, qemu_clipboard_request() can be reached
via vdagent_chr_write() and vdagent_clipboard_recv_request() and
there, the clipboard owner's 'request' callback will be attempted to
be called, but that is a NULL pointer.

In particular, this can happen when using the KRDC (22.12.3) VNC
client.

Another scenario leading to the same issue is with two clients (say
noVNC and KRDC):

The noVNC client sets the extension VNC_FEATURE_CLIPBOARD_EXT and
initializes its cbpeer.

The KRDC client does not, but triggers a vnc_client_cut_text() (note
it's not the _ext variant)). There, a new clipboard info with it as
the 'owner' is created and via qemu_clipboard_set_data() is called,
which in turn calls qemu_clipboard_update() with that info.

In qemu_clipboard_update(), the notifier for the noVNC client will be
called, i.e. vnc_clipboard_notify() and also set vs->cbinfo for the
noVNC client. The 'owner' in that clipboard info is the clipboard peer
for the KRDC client, which did not initialize the 'request' function.
That sounds correct to me, it is the owner of that clipboard info.

Then when noVNC sends a VNC_MSG_CLIENT_CUT_TEXT message (it did set
the VNC_FEATURE_CLIPBOARD_EXT feature correctly, so a check for it
passes), that clipboard info is passed to qemu_clipboard_request() and
the original segfault still happens.

Fix the issue by handling updates with size 0 differently. In
particular, mark in the clipboard info that the type is not available.

While at it, switch to g_memdup2(), because g_memdup() is deprecated.

Cc: qemu-stable@nongnu.org
Fixes: CVE-2023-6683
Reported-by: Markus Frank <m.frank@proxmox.com>
Suggested-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---

Changes in v3:
    * Yet another new appraoch, setting available to false when
      no data is passed in when updating.
    * Update commit message to focus on the fact that non-extended
      VNC_MSG_CLIENT_CUT_TEXT messages with len=0 are problematic.

 ui/clipboard.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/ui/clipboard.c b/ui/clipboard.c
index 3d14bffaf8..b3f6fa3c9e 100644
--- a/ui/clipboard.c
+++ b/ui/clipboard.c
@@ -163,9 +163,15 @@ void qemu_clipboard_set_data(QemuClipboardPeer *peer,
     }
 
     g_free(info->types[type].data);
-    info->types[type].data = g_memdup(data, size);
-    info->types[type].size = size;
-    info->types[type].available = true;
+    if (size) {
+        info->types[type].data = g_memdup2(data, size);
+        info->types[type].size = size;
+        info->types[type].available = true;
+    } else {
+        info->types[type].data = NULL;
+        info->types[type].size = 0;
+        info->types[type].available = false;
+    }
 
     if (update) {
         qemu_clipboard_update(info);
-- 
2.39.2



