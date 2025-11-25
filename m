Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA25D0E6EC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 14:19:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNtsI-0003th-D9; Tue, 25 Nov 2025 09:18:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vNtrg-0003Tl-34
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 09:17:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vNtrd-0001Su-3h
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 09:17:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764080265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WwtKCnStzP+V89nQ6qZz+lPKbapT0JZlg+zSCasM/y4=;
 b=G/0yXvfiZLPfn+LJIOJgGvAsFxk/9P3qb/S4bGw1/j4K0mK7zG0FxC/XoyUz/GAi/fKhcJ
 6fkCc2bouKIfUvlGJHe8Ibu6QpXaPMWsTq/4jasQ0LXw6fHSmoMrJCTQYTL3aORCMO7ocC
 uP/I+ZbVeU8GKJVS8EqhbSTlnhtYqW4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-252-dxOVZDuvMw2HCE1O7zG9ng-1; Tue,
 25 Nov 2025 09:17:40 -0500
X-MC-Unique: dxOVZDuvMw2HCE1O7zG9ng-1
X-Mimecast-MFC-AGG-ID: dxOVZDuvMw2HCE1O7zG9ng_1764080258
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 48D101954197; Tue, 25 Nov 2025 14:17:38 +0000 (UTC)
Received: from localhost (unknown [10.44.22.27])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2EEDC180049F; Tue, 25 Nov 2025 14:17:36 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 1/4] ui/vdagent: fix windows agent regression
Date: Tue, 25 Nov 2025 18:17:23 +0400
Message-ID: <20251125141726.1755276-2-marcandre.lureau@redhat.com>
In-Reply-To: <20251125141726.1755276-1-marcandre.lureau@redhat.com>
References: <20251125141726.1755276-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 ui/vdagent.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/ui/vdagent.c b/ui/vdagent.c
index ddb91e75c6..660686c9c0 100644
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
2.51.1


