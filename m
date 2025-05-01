Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22E79C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 18:40:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAYpA-0003S4-V9; Thu, 01 May 2025 14:39:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAYo6-0002pw-H7
 for qemu-devel@nongnu.org; Thu, 01 May 2025 14:38:52 -0400
Received: from mail-il1-x12c.google.com ([2607:f8b0:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAYo4-0008LM-Ri
 for qemu-devel@nongnu.org; Thu, 01 May 2025 14:38:50 -0400
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3d4436ba324so10399275ab.2
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 11:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746124727; x=1746729527; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/F9wfO6J1RL2avC/Q42x6BrmpISj7RT0yS78rOyo2P0=;
 b=uMye31R1iLvvLbO4tsNih+pI50YAluPlYoUOi9kBeBrU9w0/rgwZlSSpFWdudGY4Jw
 UDjq29lCQd5ZhjIYC6jWyuGq3lcYpZZECi4jea38fym29nrXXJiGFSjMo7b/0SdpAJnc
 ZxEIWmraZkdzQ6Vq273ICnrTZ3NLxR2w5mNQuI1l1Kj8DmM3Ns8rBqWU9YYiO+98eb29
 Ae8S8ARCGbXibryOtIHGr2wyRmjSr8UaqzI6LbW4stgmp9+5Wwuh8KcbSJywN65M23iM
 340bfhayr9vZe7uJC7UuY9jaMua47UH5m4c5BwOIrVjpcd/xywvz0oJu5/hjqPtVePFV
 vtJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746124727; x=1746729527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/F9wfO6J1RL2avC/Q42x6BrmpISj7RT0yS78rOyo2P0=;
 b=QGkQ2GOp6m1o+dR+HLSMvZlgCkFaMQNkX3PC6DUOCe2r4zG5J1uLAQdihiWVlonfaj
 xLsE6NHhXKYgdjKBF6tw9UUGG3oXpVzsqgzOJzEF70AQrhfdtsUQQI0lHUrof8Iq1jhG
 epHvPD1Fk3TsCfzLLyCALInWc2NUstSBBcXB2/9+4KZGDhKA0A5g52gbSTVhaXCXYZDB
 Ob0ccZmRW6ww9uz2xID+Yj0XXaxWZDYU2wyWeVKKtAk7aZsbzyetqpzDgu9hTMs9fWRy
 lN0UC4hCjqbDzSJqptDzr3GgRtzIjVcBvHOE2elV0obHc1thp9NR1h4UIxa+Wk+LcUYq
 Fq8Q==
X-Gm-Message-State: AOJu0Yyf0WbGDC/wZf+9NtWZO0dwURsGctnA+Dffz+Cpj69yNzUPoFTQ
 BLFwW+AEA6f219Rd8pAbPudx9p0UDSCVOJpw96f26venh6ekWY+sfqrL4ihd/QYsLhCqay5dT/+
 v
X-Gm-Gg: ASbGncs2XZ89pNXnS4uNssH5QZ863lz9+6UdW66NuJPVX2RCvkU/16Au0VkUOIumBV4
 FEebjUUZYjHpKa+2VuGjbybDUSD4RsAJn0aNpbukeqmNJzulRE7ea4d6S2BWXCDdUNV7nv9023y
 7qbELp+0kzOkuzin99F6nfxKeMO3uakSa0Z48rTesi5NDUjOOp7CzRR/ZGTjrlcmDDB7deo9E7x
 8xMoUwVgbxzYnBUkq8jrJwKHI7vVTmvXhN8n/0/yj2OqhhZNlViGTX6zMnrFT36WkU9z2sm7ikC
 a6ORhShS5me4pGSgyoa+g3JDLeKJo6qZFCFObIFFL2+OkKX/hk2jwFRuFzrCCQNCq9nrU4HpPDw
 Iw22K4Ne/LasBK2ESJonp
X-Google-Smtp-Source: AGHT+IGihOUFVAP0DR72yKqIEpdpdx5OoYnNI1fE/eelnPQAlRUYSe1da8rZZUKH7vTD3q9CAvlySQ==
X-Received: by 2002:a05:6e02:1fe8:b0:3d9:66ba:1ad2 with SMTP id
 e9e14a558f8ab-3d97be3aee1mr38235ab.0.1746124727244; 
 Thu, 01 May 2025 11:38:47 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f882ee3f65sm307854173.52.2025.05.01.11.38.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 May 2025 11:38:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Yi Liu <yi.l.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Amit Shah <amit@kernel.org>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sergio Lopez <slp@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ani Sinha <anisinha@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 15/16] hw/char/virtio-serial: Do not expose the
 'emergency-write' property
Date: Thu,  1 May 2025 20:36:27 +0200
Message-ID: <20250501183628.87479-16-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250501183628.87479-1-philmd@linaro.org>
References: <20250501183628.87479-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12c;
 envelope-from=philmd@linaro.org; helo=mail-il1-x12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The VIRTIO_CONSOLE_F_EMERG_WRITE feature bit was only set
in the hw_compat_2_7[] array, via the 'emergency-write=off'
property. We removed all machines using that array, lets remove
that property. All instances have this feature bit set and
it can not be disabled.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/virtio-serial-bus.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index eb79f5258b6..31bd1b7535d 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -1019,6 +1019,13 @@ static void virtser_port_device_unrealize(DeviceState *dev)
     }
 }
 
+static void virtio_serial_instance_init(Object *obj)
+{
+    VirtIOSerial *vser = VIRTIO_SERIAL(obj);
+
+    vser->host_features |= BIT_ULL(VIRTIO_CONSOLE_F_EMERG_WRITE);
+}
+
 static void virtio_serial_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
@@ -1155,8 +1162,6 @@ static const VMStateDescription vmstate_virtio_console = {
 static const Property virtio_serial_properties[] = {
     DEFINE_PROP_UINT32("max_ports", VirtIOSerial, serial.max_virtserial_ports,
                                                   31),
-    DEFINE_PROP_BIT64("emergency-write", VirtIOSerial, host_features,
-                      VIRTIO_CONSOLE_F_EMERG_WRITE, true),
 };
 
 static void virtio_serial_class_init(ObjectClass *klass, const void *data)
@@ -1186,6 +1191,7 @@ static void virtio_serial_class_init(ObjectClass *klass, const void *data)
 static const TypeInfo virtio_device_info = {
     .name = TYPE_VIRTIO_SERIAL,
     .parent = TYPE_VIRTIO_DEVICE,
+    .instance_init = virtio_serial_instance_init,
     .instance_size = sizeof(VirtIOSerial),
     .class_init = virtio_serial_class_init,
     .interfaces = (const InterfaceInfo[]) {
-- 
2.47.1


