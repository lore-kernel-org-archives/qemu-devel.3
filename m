Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B29CD4F3D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 14:01:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ3uJ-0001my-FO; Thu, 21 May 2026 09:57:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wQ3u9-0000ex-SR
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:57:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wQ3u8-00010p-8Z
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:57:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779371859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fh+6O/vHguV/OcDLo0aBOnAZWtT7udU3z87vtg+xsfM=;
 b=QOGGDUR4MqO1TGSoDp2bqP2FZ2ntoqGvdnp/zhO355hhPWWxMus57Rtu3oRfxRZvVJpKhW
 yA3RHePB6gcAuWQnDc0Evyf10vO3WAD3fYC14LXLjjlhqf6aHQAGoIdXJnVDCtb2oxdvc1
 2yJ/SdAOiINfy3Db50bywAsfOmF4eKs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-157-kGBeKMLWP7-DAKzY8pQ85g-1; Thu,
 21 May 2026 09:57:37 -0400
X-MC-Unique: kGBeKMLWP7-DAKzY8pQ85g-1
X-Mimecast-MFC-AGG-ID: kGBeKMLWP7-DAKzY8pQ85g_1779371856
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 534C21955D96; Thu, 21 May 2026 13:57:36 +0000 (UTC)
Received: from localhost (unknown [10.44.24.26])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F21321956056; Thu, 21 May 2026 13:57:34 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL v2 17/38] hw/char/escc: Use Linux key codes
Date: Thu, 21 May 2026 17:55:28 +0400
Message-ID: <20260521135551.1752945-18-marcandre.lureau@redhat.com>
In-Reply-To: <20260521135551.1752945-1-marcandre.lureau@redhat.com>
References: <20260521135551.1752945-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

QemuInputEvent now stores Linux key codes for key events. Use those
codes directly instead of translating between internal key code
representations.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260520-input-v3-9-7c9e4c7abe34@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/char/escc.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/char/escc.c b/hw/char/escc.c
index 39483ca03bf..7aae627fb48 100644
--- a/hw/char/escc.c
+++ b/hw/char/escc.c
@@ -30,6 +30,7 @@
 #include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "hw/char/escc.h"
+#include "standard-headers/linux/input-event-codes.h"
 #include "ui/console.h"
 
 #include "qemu/cutils.h"
@@ -804,7 +805,7 @@ static void sunkbd_handle_event(DeviceState *dev, QemuConsole *src,
     trace_escc_sunkbd_event_in(qcode, QKeyCode_str(qcode),
                                evt->key.down);
 
-    if (qcode == Q_KEY_CODE_CAPS_LOCK) {
+    if (evt->key.key == KEY_CAPSLOCK) {
         if (evt->key.down) {
             s->caps_lock_mode ^= 1;
             if (s->caps_lock_mode == 2) {
@@ -818,7 +819,7 @@ static void sunkbd_handle_event(DeviceState *dev, QemuConsole *src,
         }
     }
 
-    if (qcode == Q_KEY_CODE_NUM_LOCK) {
+    if (evt->key.key == KEY_NUMLOCK) {
         if (evt->key.down) {
             s->num_lock_mode ^= 1;
             if (s->num_lock_mode == 2) {
@@ -832,11 +833,11 @@ static void sunkbd_handle_event(DeviceState *dev, QemuConsole *src,
         }
     }
 
-    if (qcode >= qemu_input_map_qcode_to_sun_len) {
+    if (evt->key.key >= qemu_input_map_linux_to_sun_len) {
         return;
     }
 
-    keycode = qemu_input_map_qcode_to_sun[qcode];
+    keycode = qemu_input_map_linux_to_sun[evt->key.key];
     if (!evt->key.down) {
         keycode |= 0x80;
     }
-- 
2.54.0


