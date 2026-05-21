Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A898CD5BAC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 12:01:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ24v-0000o7-0w; Thu, 21 May 2026 08:00:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wQ243-0008Dn-39
 for qemu-devel@nongnu.org; Thu, 21 May 2026 07:59:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wQ23z-0004jY-Bx
 for qemu-devel@nongnu.org; Thu, 21 May 2026 07:59:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779364781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T0U31hilbffMwpa0BEq59ZjijcKzDLFO9G55VI/Gf/k=;
 b=P8cpgta61eahwDAPKLfpsw+mex3C/sq6S0m/OEx9gzp49wDrEKi5vUyS/xRKJKLqv9ahIB
 YMklb4CjZGJQdoFQFUI3w0ow/E33UR8F63wATrm0zdEqKW9fzrWh8njbw1mLZY6I8MA74b
 5q3GuFh7S25FQM7z2t4TCFWSN+QV/LM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-312-uIDWFvsnMbKr2aOBzspkdQ-1; Thu,
 21 May 2026 07:59:36 -0400
X-MC-Unique: uIDWFvsnMbKr2aOBzspkdQ-1
X-Mimecast-MFC-AGG-ID: uIDWFvsnMbKr2aOBzspkdQ_1779364774
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3157C195605E; Thu, 21 May 2026 11:59:34 +0000 (UTC)
Received: from localhost (unknown [10.44.24.26])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C41FA1800352; Thu, 21 May 2026 11:59:32 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 22/38] hw/input/virtio-input: Use Linux key codes
Date: Thu, 21 May 2026 15:56:59 +0400
Message-ID: <20260521115717.1701482-23-marcandre.lureau@redhat.com>
In-Reply-To: <20260521115717.1701482-1-marcandre.lureau@redhat.com>
References: <20260521115717.1701482-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Message-ID: <20260520-input-v3-14-7c9e4c7abe34@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/input/virtio-input-hid.c | 40 +++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/hw/input/virtio-input-hid.c b/hw/input/virtio-input-hid.c
index 1d2e922567a..75fe45d89a2 100644
--- a/hw/input/virtio-input-hid.c
+++ b/hw/input/virtio-input-hid.c
@@ -83,23 +83,13 @@ static void virtio_input_handle_event(DeviceState *dev, QemuConsole *src,
 {
     VirtIOInput *vinput = VIRTIO_INPUT(dev);
     virtio_input_event event;
-    int qcode;
 
     switch (evt->type) {
     case INPUT_EVENT_KIND_KEY:
-        qcode = qemu_input_linux_to_qcode(evt->key.key);
-        if (qcode < qemu_input_map_qcode_to_linux_len &&
-            qemu_input_map_qcode_to_linux[qcode]) {
-            event.type  = cpu_to_le16(EV_KEY);
-            event.code  = cpu_to_le16(qemu_input_map_qcode_to_linux[qcode]);
-            event.value = cpu_to_le32(evt->key.down ? 1 : 0);
-            virtio_input_send(vinput, &event);
-        } else {
-            if (evt->key.down) {
-                fprintf(stderr, "%s: unmapped key: %d [%s]\n", __func__,
-                        qcode, QKeyCode_str(qcode));
-            }
-        }
+        event.type  = cpu_to_le16(EV_KEY);
+        event.code  = cpu_to_le16(evt->key.key);
+        event.value = cpu_to_le32(evt->key.down ? 1 : 0);
+        virtio_input_send(vinput, &event);
         break;
     case INPUT_EVENT_KIND_BTN:
         if ((evt->btn.button == INPUT_BUTTON_WHEEL_UP ||
@@ -293,12 +283,28 @@ static void virtio_keyboard_init(Object *obj)
 {
     VirtIOInputHID *vhid = VIRTIO_INPUT_HID(obj);
     VirtIOInput *vinput = VIRTIO_INPUT(obj);
+    virtio_input_config ext = {
+        .select = VIRTIO_INPUT_CFG_EV_BITS,
+        .subsel = EV_KEY,
+        .size = DIV_ROUND_UP(KEY_REPLY, 8)
+    };
+    unsigned int i;
 
     vhid->handler = &virtio_keyboard_handler;
     virtio_input_init_config(vinput, virtio_keyboard_config);
-    virtio_input_extend_config(vinput, qemu_input_map_qcode_to_linux,
-                               qemu_input_map_qcode_to_linux_len,
-                               VIRTIO_INPUT_CFG_EV_BITS, EV_KEY);
+
+    /*
+     * Cover as many keys as possible since we cannot tell what keys the host
+     * supports. This follows Linux xen-kbdfront's approach:
+     * https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/diff/drivers/input/xen-kbdfront.c?id=4ee36dc08e5c4d16d078f59acd6d9d536f9718dd
+     *
+     * Stop before KEY_REPLY for migration compatibility.
+     */
+    for (i = KEY_ESC; i < KEY_REPLY; i++) {
+        ext.u.bitmap[i / 8] |= (1 << (i % 8));
+    }
+
+    virtio_input_add_config(vinput, &ext);
 }
 
 static const TypeInfo virtio_keyboard_info = {
-- 
2.54.0


