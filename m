Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDA87D12695
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 09:37:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQjHi-0000Hz-2p; Wed, 03 Dec 2025 04:36:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vQjHg-0000GP-GP; Wed, 03 Dec 2025 04:36:28 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vQjHe-00074s-K6; Wed, 03 Dec 2025 04:36:28 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 94A7D1708B2;
 Wed, 03 Dec 2025 12:35:54 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7F0EF32B5A9;
 Wed, 03 Dec 2025 12:36:12 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Lucas Kornicki <lucas.kornicki@nutanix.com>,
 Fiona Ebner <f.ebner@proxmox.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.3 83/96] ui/vdagent: fix windows agent regression
Date: Wed,  3 Dec 2025 12:35:16 +0300
Message-ID: <20251203093612.2370716-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.3-20251203111246@cover.tls.msk.ru>
References: <qemu-stable-10.1.3-20251203111246@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Since commit f626116f ("ui/vdagent: factor out clipboard peer
registration"), the QEMU clipboard serial is reset whenever the vdagent
chardev receives the guest caps. This triggers a CHR_EVENT_CLOSED which
is handled by virtio_serial_close() to notify the guest.

The "reconnection logic" is there to reset the agent when a
client (dbus, spice etc) reconnects, or the agent is restarted.
It is required to sync the clipboard serials and to prevent races or
loops due to clipboard managers on both ends (but this is not
implemented by windows vdagent).

The Unix agent has been reconnecting without resending caps, thus
working with this approach.

However, the Windows agent does not seem to have a way to handle
VIRTIO_CONSOLE_PORT_OPEN=0 event and do not receive further data...

Let's not trigger this disconnection/reset logic if the agent does not
support VD_AGENT_CAP_CLIPBOARD_GRAB_SERIAL.

Fixes: f626116f ("ui/vdagent: factor out clipboard peer registration")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reported-by: Lucas Kornicki <lucas.kornicki@nutanix.com>
Tested-by: Fiona Ebner <f.ebner@proxmox.com>
Reviewed-by: Fiona Ebner <f.ebner@proxmox.com>
Tested-by: Lucas Kornicki <lucas.kornicki@nutanix.com>
(cherry picked from commit 4be62d311791bf9d318f5139439d170ad5112279)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/ui/vdagent.c b/ui/vdagent.c
index c0746fe5b1..a7c959e8ab 100644
--- a/ui/vdagent.c
+++ b/ui/vdagent.c
@@ -316,6 +316,15 @@ static bool have_selection(VDAgentChardev *vd)
     return vd->caps & (1 << VD_AGENT_CAP_CLIPBOARD_SELECTION);
 }
 
+static bool have_clipboard_serial(VDAgentChardev *vd)
+{
+#if CHECK_SPICE_PROTOCOL_VERSION(0, 14, 1)
+    return vd->caps & (1 << VD_AGENT_CAP_CLIPBOARD_GRAB_SERIAL);
+#else
+    return false;
+#endif
+}
+
 static uint32_t type_qemu_to_vdagent(enum QemuClipboardType type)
 {
     switch (type) {
@@ -345,8 +354,7 @@ static void vdagent_send_clipboard_grab(VDAgentChardev *vd,
         return;
     }
 
-#if CHECK_SPICE_PROTOCOL_VERSION(0, 14, 1)
-    if (vd->caps & (1 << VD_AGENT_CAP_CLIPBOARD_GRAB_SERIAL)) {
+    if (have_clipboard_serial(vd)) {
         if (!info->has_serial) {
             /* client should win */
             info->serial = vd->last_serial[info->selection]++;
@@ -356,7 +364,6 @@ static void vdagent_send_clipboard_grab(VDAgentChardev *vd,
         data++;
         msg->size += sizeof(uint32_t);
     }
-#endif
 
     for (q = 0; q < QEMU_CLIPBOARD_TYPE__COUNT; q++) {
         type = type_qemu_to_vdagent(q);
@@ -464,6 +471,9 @@ static void vdagent_clipboard_reset_serial(VDAgentChardev *vd)
 {
     Chardev *chr = CHARDEV(vd);
 
+    if (!have_clipboard_serial(vd)) {
+        return;
+    }
     /* reopen the agent connection to reset the serial state */
     qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
     /* OPENED again after the guest disconnected, see set_fe_open */
@@ -518,8 +528,7 @@ static void vdagent_clipboard_recv_grab(VDAgentChardev *vd, uint8_t s, uint32_t
 
     trace_vdagent_cb_grab_selection(GET_NAME(sel_name, s));
     info = qemu_clipboard_info_new(&vd->cbpeer, s);
-#if CHECK_SPICE_PROTOCOL_VERSION(0, 14, 1)
-    if (vd->caps & (1 << VD_AGENT_CAP_CLIPBOARD_GRAB_SERIAL)) {
+    if (have_clipboard_serial(vd)) {
         if (size < sizeof(uint32_t)) {
             /* this shouldn't happen! */
             return;
@@ -537,7 +546,6 @@ static void vdagent_clipboard_recv_grab(VDAgentChardev *vd, uint8_t s, uint32_t
         data += sizeof(uint32_t);
         size -= sizeof(uint32_t);
     }
-#endif
     if (size > sizeof(uint32_t) * 10) {
         /*
          * spice has 6 types as of 2021. Limiting to 10 entries
-- 
2.47.3


