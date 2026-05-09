Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D03CD37B2
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 10:55:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLfFb-0000NT-Qx; Sat, 09 May 2026 06:49:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wLfF2-0008KV-6s; Sat, 09 May 2026 06:49:05 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wLfEx-0001e6-Ib; Sat, 09 May 2026 06:49:02 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 649AlY2E090834
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 9 May 2026 19:47:59 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=jYzmLTbWax8JogN3WJf0BurekwSvWMhETlPn4yFttW0=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1778323680; v=1;
 b=iunl5CceMu7WtKDfvF4u1wtP4gK8f2BvxgidjHusJV9SVQMKD/7i69jH8M1ebFU3
 8OmeptkXILo4vLeHMJMqccFaQr/CGDspkHNnC1+ssA8QFjq/P5uJ0vBAaiCKvPld
 zsgVNMNyo9G6pG4aoAHSasB1Pnvjl/NUWeXFzCYsZHhXt0eF4nSnhrG9qhl8hysh
 4loo6PYKlcLs3l2b1hM7zIqjzB4+XHqgLFv2dKyXwVH1io0bD+rTTDBKC7l1+upV
 0xpR+OFd0lIwWXPJVgsDGC+nnmBRIu99BtWyPTXpQ9UC8CinnVfJfI8RB4QdU7PV
 fNDJbFAXY33ow3cKZaUMrA==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 09 May 2026 19:34:25 +0900
Subject: [PATCH RFC 13/28] hw/input/virtio-input: Use Linux key codes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260509-input-v1-13-66f18d2edde6@rsg.ci.i.u-tokyo.ac.jp>
References: <20260509-input-v1-0-66f18d2edde6@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260509-input-v1-0-66f18d2edde6@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jan Kiszka <jan.kiszka@web.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, xen-devel@lists.xenproject.org, qemu-ppc@nongnu.org,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-16047
X-Developer-Signature: v=1; a=openpgp-sha256; l=3015;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=EmtPHZ4VrwnBl0E92Q8PvtguFqdBkezuol02LtNVvV0=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ+Z/gSvzfv+xztew1A+df7T50dHW53turpq15NGvZXNlS
 vW/r47f1VHKwiDGxSArpsiSUrSbWyO69lNhQnwLzBxWJpAhDFycAjCRa2cYGS6cPLNlwn1OU/c2
 qY6GvRsP5i3et6l30cfC6DMc/2Y8dExn+CvGt4ndQ6pMOqLZK1Ohxn69sG3GNOMZhvZXdSpXbjF
 QZQIA
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
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

QemuInputEvent now stores Linux key codes for key events. Use those
codes directly instead of translating between internal key code
representations.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/input/virtio-input-hid.c | 40 +++++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/hw/input/virtio-input-hid.c b/hw/input/virtio-input-hid.c
index 1d2e922567ab..75fe45d89a2a 100644
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


