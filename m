Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB36C2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 15:17:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHlBe-0006BE-5Z; Wed, 21 May 2025 11:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uHlBc-0006Ai-2l
 for qemu-devel@nongnu.org; Wed, 21 May 2025 11:16:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uHlBY-0002fL-O8
 for qemu-devel@nongnu.org; Wed, 21 May 2025 11:16:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747840605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Shz/tZqIt2lGAR4MMQw16a29wqa0BbKrakqQWjPt//U=;
 b=KRw1owpP/V7670rS2E6op+xPNr/zWhPAqUrpd0Cgl3LGHuxspl/4vL+J09RQSaZhEbufy3
 VK2Psmyl56XvDuwPxk3dvqmMCxunn5MRzoSoxkvXyHAPLSFdUWD9/0A7TfzzKAEU0Jp5hl
 ROeNay0SH6EvU+QzTX/InpykvR0Kl3M=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-325-oQRwa7jiMwyT0pGEA8RjLQ-1; Wed,
 21 May 2025 11:16:44 -0400
X-MC-Unique: oQRwa7jiMwyT0pGEA8RjLQ-1
X-Mimecast-MFC-AGG-ID: oQRwa7jiMwyT0pGEA8RjLQ_1747840603
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A10A619560BF
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 15:16:43 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.2.64])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A94C830001AB; Wed, 21 May 2025 15:16:41 +0000 (UTC)
From: Juraj Marcin <jmarcin@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com, kraxel@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH] ui/vnc: Update display update interval when VM state changes
 to RUNNING
Date: Wed, 21 May 2025 17:16:13 +0200
Message-ID: <20250521151616.3951178-1-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Juraj Marcin <jmarcin@redhat.com>

If a virtual machine is paused for an extended period time, for example,
due to an incoming migration, there are also no changes on the screen.
VNC in such case increases the display update interval by
VNC_REFRESH_INTERVAL_INC (50 ms). The update interval can then grow up
to VNC_REFRESH_INTERVAL_MAX (3000 ms).

When the machine resumes, it can then take up to 3 seconds for the first
display update. Furthermore, the update interval is then halved with
each display update with changes on the screen. If there are moving
elements on the screen, such as a video, this can be perceived as
freezing and stuttering for few seconds before the movement is smooth
again.

This patch resolves this issue, by adding a listener to VM state changes
and changing the update interval when the VM state changes to RUNNING.
The update_displaychangelistener() function updates the internal timer,
and the display is refreshed immediately if the timer is expired.

Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
---
 ui/vnc.c | 12 ++++++++++++
 ui/vnc.h |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/ui/vnc.c b/ui/vnc.c
index 9e097dc4b4..32f8bfd1f9 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3384,6 +3384,16 @@ static const DisplayChangeListenerOps dcl_ops = {
     .dpy_cursor_define    = vnc_dpy_cursor_define,
 };
 
+static void vmstate_change_handler(void *opaque, bool running, RunState state)
+{
+    VncDisplay *vd = opaque;
+
+    if (state != RUN_STATE_RUNNING) {
+        return;
+    }
+    update_displaychangelistener(&vd->dcl, VNC_REFRESH_INTERVAL_BASE);
+}
+
 void vnc_display_init(const char *id, Error **errp)
 {
     VncDisplay *vd;
@@ -3420,6 +3430,8 @@ void vnc_display_init(const char *id, Error **errp)
     vd->dcl.ops = &dcl_ops;
     register_displaychangelistener(&vd->dcl);
     vd->kbd = qkbd_state_init(vd->dcl.con);
+    vd->vmstate_handler_entry = qemu_add_vm_change_state_handler(
+        &vmstate_change_handler, vd);
 }
 
 
diff --git a/ui/vnc.h b/ui/vnc.h
index acc53a2cc1..3bb23acd34 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -185,6 +185,8 @@ struct VncDisplay
 #endif
 
     AudioState *audio_state;
+
+    VMChangeStateEntry *vmstate_handler_entry;
 };
 
 typedef struct VncTight {
-- 
2.49.0


