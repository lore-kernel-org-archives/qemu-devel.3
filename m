Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB5CF30937
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 10:54:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy6Kv-0003sC-Nd; Thu, 05 Mar 2026 05:53:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vy6Kt-0003c5-NH
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 05:53:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vy6Kr-0005hd-RW
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 05:53:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772708021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YDtsxtTpETlFmjyggCTqKy4glvqXLb0PRcKFCo8tsRA=;
 b=Z+aU+MEJ1GnRWd4QUu5yl8aw+JxBrPVGbYKlgtcvStyYXmpWZwVtIom9T2dBkr9m/ywqZS
 zSlhS6jpwA1ybVGeVKaaUt9/gm1uzkjruB1bCGqSJNArBFirC1zJbEAafDjujiVKtDfQTq
 zevEYmfkY2kOnmrrYG/A52GNWN4kwig=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-39-8gwNAHW1NamWuDc0bvBNOA-1; Thu,
 05 Mar 2026 05:53:36 -0500
X-MC-Unique: 8gwNAHW1NamWuDc0bvBNOA-1
X-Mimecast-MFC-AGG-ID: 8gwNAHW1NamWuDc0bvBNOA_1772708016
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D71A0180034F; Thu,  5 Mar 2026 10:53:35 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.75])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 13C873003E98; Thu,  5 Mar 2026 10:53:33 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 24/28] hw/input/virtio-input: Remove VirtIOInputHID::wheel_axis
 field
Date: Thu,  5 Mar 2026 11:52:11 +0100
Message-ID: <20260305105215.302571-25-thuth@redhat.com>
In-Reply-To: <20260305105215.302571-1-thuth@redhat.com>
References: <20260305105215.302571-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The VirtIOInputHID::wheel_axis boolean was only set in the
hw_compat_2_10[] array, via the 'wheel-axis=false' property.
We removed all machines using that array, lets remove that
property and all the code around it. There is only one
virtio_input_config[] version for each device, rename it
removing the '_v2' suffix.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250501230129.2596-4-philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/virtio/virtio-input.h |   1 -
 hw/input/virtio-input-hid.c      | 102 ++-----------------------------
 2 files changed, 5 insertions(+), 98 deletions(-)

diff --git a/include/hw/virtio/virtio-input.h b/include/hw/virtio/virtio-input.h
index e097b0b5217..1e94f8a03db 100644
--- a/include/hw/virtio/virtio-input.h
+++ b/include/hw/virtio/virtio-input.h
@@ -89,7 +89,6 @@ struct VirtIOInputHID {
     const QemuInputHandler            *handler;
     QemuInputHandlerState             *hs;
     int                               ledstate;
-    bool                              wheel_axis;
 };
 
 struct VirtIOInputHost {
diff --git a/hw/input/virtio-input-hid.c b/hw/input/virtio-input-hid.c
index bcbfef0b905..14dde90a48b 100644
--- a/hw/input/virtio-input-hid.c
+++ b/hw/input/virtio-input-hid.c
@@ -81,7 +81,6 @@ static void virtio_input_extend_config(VirtIOInput *vinput,
 static void virtio_input_handle_event(DeviceState *dev, QemuConsole *src,
                                       InputEvent *evt)
 {
-    VirtIOInputHID *vhid = VIRTIO_INPUT_HID(dev);
     VirtIOInput *vinput = VIRTIO_INPUT(dev);
     virtio_input_event event;
     int qcode;
@@ -109,8 +108,7 @@ static void virtio_input_handle_event(DeviceState *dev, QemuConsole *src,
         break;
     case INPUT_EVENT_KIND_BTN:
         btn = evt->u.btn.data;
-        if (vhid->wheel_axis &&
-            (btn->button == INPUT_BUTTON_WHEEL_UP ||
+        if ((btn->button == INPUT_BUTTON_WHEEL_UP ||
              btn->button == INPUT_BUTTON_WHEEL_DOWN) &&
             btn->down) {
             event.type  = cpu_to_le16(EV_REL);
@@ -328,32 +326,7 @@ static const QemuInputHandler virtio_mouse_handler = {
     .sync  = virtio_input_handle_sync,
 };
 
-static struct virtio_input_config virtio_mouse_config_v1[] = {
-    {
-        .select    = VIRTIO_INPUT_CFG_ID_NAME,
-        .size      = sizeof(VIRTIO_ID_NAME_MOUSE),
-        .u.string  = VIRTIO_ID_NAME_MOUSE,
-    },{
-        .select    = VIRTIO_INPUT_CFG_ID_DEVIDS,
-        .size      = sizeof(struct virtio_input_devids),
-        .u.ids     = {
-            .bustype = const_le16(BUS_VIRTUAL),
-            .vendor  = const_le16(0x0627), /* same we use for usb hid devices */
-            .product = const_le16(0x0002),
-            .version = const_le16(0x0001),
-        },
-    },{
-        .select    = VIRTIO_INPUT_CFG_EV_BITS,
-        .subsel    = EV_REL,
-        .size      = 1,
-        .u.bitmap  = {
-            (1 << REL_X) | (1 << REL_Y),
-        },
-    },
-    { /* end of list */ },
-};
-
-static struct virtio_input_config virtio_mouse_config_v2[] = {
+static struct virtio_input_config virtio_mouse_config[] = {
     {
         .select    = VIRTIO_INPUT_CFG_ID_NAME,
         .size      = sizeof(VIRTIO_ID_NAME_MOUSE),
@@ -379,26 +352,13 @@ static struct virtio_input_config virtio_mouse_config_v2[] = {
     { /* end of list */ },
 };
 
-static const Property virtio_mouse_properties[] = {
-    DEFINE_PROP_BOOL("wheel-axis", VirtIOInputHID, wheel_axis, true),
-};
-
-static void virtio_mouse_class_init(ObjectClass *klass, const void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-
-    device_class_set_props(dc, virtio_mouse_properties);
-}
-
 static void virtio_mouse_init(Object *obj)
 {
     VirtIOInputHID *vhid = VIRTIO_INPUT_HID(obj);
     VirtIOInput *vinput = VIRTIO_INPUT(obj);
 
     vhid->handler = &virtio_mouse_handler;
-    virtio_input_init_config(vinput, vhid->wheel_axis
-                             ? virtio_mouse_config_v2
-                             : virtio_mouse_config_v1);
+    virtio_input_init_config(vinput, virtio_mouse_config);
     virtio_input_extend_config(vinput, keymap_button,
                                ARRAY_SIZE(keymap_button),
                                VIRTIO_INPUT_CFG_EV_BITS, EV_KEY);
@@ -409,7 +369,6 @@ static const TypeInfo virtio_mouse_info = {
     .parent        = TYPE_VIRTIO_INPUT_HID,
     .instance_size = sizeof(VirtIOInputHID),
     .instance_init = virtio_mouse_init,
-    .class_init    = virtio_mouse_class_init,
 };
 
 /* ----------------------------------------------------------------- */
@@ -421,44 +380,7 @@ static const QemuInputHandler virtio_tablet_handler = {
     .sync  = virtio_input_handle_sync,
 };
 
-static struct virtio_input_config virtio_tablet_config_v1[] = {
-    {
-        .select    = VIRTIO_INPUT_CFG_ID_NAME,
-        .size      = sizeof(VIRTIO_ID_NAME_TABLET),
-        .u.string  = VIRTIO_ID_NAME_TABLET,
-    },{
-        .select    = VIRTIO_INPUT_CFG_ID_DEVIDS,
-        .size      = sizeof(struct virtio_input_devids),
-        .u.ids     = {
-            .bustype = const_le16(BUS_VIRTUAL),
-            .vendor  = const_le16(0x0627), /* same we use for usb hid devices */
-            .product = const_le16(0x0003),
-            .version = const_le16(0x0001),
-        },
-    },{
-        .select    = VIRTIO_INPUT_CFG_EV_BITS,
-        .subsel    = EV_ABS,
-        .size      = 1,
-        .u.bitmap  = {
-            (1 << ABS_X) | (1 << ABS_Y),
-        },
-    },{
-        .select    = VIRTIO_INPUT_CFG_ABS_INFO,
-        .subsel    = ABS_X,
-        .size      = sizeof(virtio_input_absinfo),
-        .u.abs.min = const_le32(INPUT_EVENT_ABS_MIN),
-        .u.abs.max = const_le32(INPUT_EVENT_ABS_MAX),
-    },{
-        .select    = VIRTIO_INPUT_CFG_ABS_INFO,
-        .subsel    = ABS_Y,
-        .size      = sizeof(virtio_input_absinfo),
-        .u.abs.min = const_le32(INPUT_EVENT_ABS_MIN),
-        .u.abs.max = const_le32(INPUT_EVENT_ABS_MAX),
-    },
-    { /* end of list */ },
-};
-
-static struct virtio_input_config virtio_tablet_config_v2[] = {
+static struct virtio_input_config virtio_tablet_config[] = {
     {
         .select    = VIRTIO_INPUT_CFG_ID_NAME,
         .size      = sizeof(VIRTIO_ID_NAME_TABLET),
@@ -503,26 +425,13 @@ static struct virtio_input_config virtio_tablet_config_v2[] = {
     { /* end of list */ },
 };
 
-static const Property virtio_tablet_properties[] = {
-    DEFINE_PROP_BOOL("wheel-axis", VirtIOInputHID, wheel_axis, true),
-};
-
-static void virtio_tablet_class_init(ObjectClass *klass, const void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-
-    device_class_set_props(dc, virtio_tablet_properties);
-}
-
 static void virtio_tablet_init(Object *obj)
 {
     VirtIOInputHID *vhid = VIRTIO_INPUT_HID(obj);
     VirtIOInput *vinput = VIRTIO_INPUT(obj);
 
     vhid->handler = &virtio_tablet_handler;
-    virtio_input_init_config(vinput, vhid->wheel_axis
-                             ? virtio_tablet_config_v2
-                             : virtio_tablet_config_v1);
+    virtio_input_init_config(vinput, virtio_tablet_config);
     virtio_input_extend_config(vinput, keymap_button,
                                ARRAY_SIZE(keymap_button),
                                VIRTIO_INPUT_CFG_EV_BITS, EV_KEY);
@@ -533,7 +442,6 @@ static const TypeInfo virtio_tablet_info = {
     .parent        = TYPE_VIRTIO_INPUT_HID,
     .instance_size = sizeof(VirtIOInputHID),
     .instance_init = virtio_tablet_init,
-    .class_init    = virtio_tablet_class_init,
 };
 
 /* ----------------------------------------------------------------- */
-- 
2.53.0


