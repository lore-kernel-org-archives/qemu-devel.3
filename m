Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54416C3ABAA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 19:01:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAvcD-0001mw-Ok; Fri, 02 May 2025 15:00:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAvat-0007WS-Dk
 for qemu-devel@nongnu.org; Fri, 02 May 2025 14:58:43 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAvar-0005iI-LB
 for qemu-devel@nongnu.org; Fri, 02 May 2025 14:58:43 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5f4d28d9fd8so3268052a12.3
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 11:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746212320; x=1746817120; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ns6abkUGaM6ukyij9Yk70LzU+Vns27nmI4rpIretkkk=;
 b=GjB5VlRJwG2MFEdyIm2nevJQf3UlnnEJhs2ykew65Leh2t8PluWMdUkmew2dJ7bUW9
 dtVGfeMYLEak9vyEBN0OaJ4ChMP7yTNDgrAQSHGIjbBvXAz28vyKH3PPxv2mwRxf2cIV
 VLrpyXYeIyQirhYxh5/lUkkqy1N2jrjExLUza+AIPZ0p/oESX6z4rtJ+2TGtSZ46Qo6+
 a0Ou/uGZDVdDKFCfSP9BU4RKIJz/p3p98YelowUUURGFAYinGp2m7DCv0Fht4gX1wglB
 v3IlYlkG62N6b/ovA22jxHsPbK23ZSVpo/RGm0nVx9yGqICKGxfnLhTEtTtRmOOEYe+n
 /gGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746212320; x=1746817120;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ns6abkUGaM6ukyij9Yk70LzU+Vns27nmI4rpIretkkk=;
 b=V9CsSGZ5fItVmBdkDnehzeYUkuRy1cs6xp6NWZQ21HDKFuLju0Xf4uUToNTIfeiHwq
 9EBeFFXHW+RzLNt5EuS//JhPoukeR93VdjLVVkiTowylFNcbf07gieTF4kZZkHBJ33BY
 qre/oXa57KUrqWDjwRDv2gaO5QJ7U3p0+MAGOkG8rhBIn91oMoRUIxwUVA4o8tsw/2rG
 Pbl9bTgRzzvSJnXjBD4au7uv2zdUIwCg39DHpdjMZ1NrZCl1lwTENMOQNzy/ex0IL6mq
 xfmFcM9PJEwk3//8iIRygTaGn0hGElmfV3knMRTqm/EEtIFEBHOPkJhAnRBG9UmaLMnm
 /Lrw==
X-Gm-Message-State: AOJu0Yx9vgMbwSu/rZ8CHIMvIo4tTrn/KiytM8Ib+cxcV1jwwem/YoyH
 hNtGNZqlmVCX5tcpOmRAmPQMxyFKgE3rXBKTGBjqmASsGuvEkk1e7CUNFsGhwkKG9wODVoPFwlq
 i
X-Gm-Gg: ASbGncsqjmz4ri4k3cvDJQHFYTg2YpZkKXx1E53LBr2FHh6Zeyl4WPYz+Jdms/GCN+A
 0zNCrBicGur89kXyZjoBWQdJZd8mFW41Lou4L1PxZvawgXNDApEY3B9aYkenzbUFpchpmVAh/OA
 Cr74t1AEXL2ZohhNYbMU3RywtdoXevtlIqFby71yv+QjQnHLAu3slvwEJo/9a1WXUKvyLtUqSnG
 9+Kmi3AdWXdAIyIw9TTYS2ZnfnJyIXAv0IJS+oMYfrpVQX1WA+o0P76Hm7Y49GvW7uGmiaMYRws
 Y1sz40YwMKCmy3CzKdPC9HUYjlBqNqQvdhu7mGeItYbuNA67UNPxIOAo4VkkkqNpWoLCqRLY4/O
 nzQiHiOEbgellIrBghI4p
X-Google-Smtp-Source: AGHT+IGfsIrdFbhprmcGkjN7nBsEbzpBtce/Ct00AnBiJYlS7w4X2H4GU7jTA1vXIeP2OEYtXHKkZQ==
X-Received: by 2002:a05:6402:84c:b0:5fa:82a4:4c03 with SMTP id
 4fb4d7f45d1cf-5fa82a44cc2mr2325996a12.13.1746212319716; 
 Fri, 02 May 2025 11:58:39 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5fa77816ffbsm1558875a12.34.2025.05.02.11.58.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 02 May 2025 11:58:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Amit Shah <amit@kernel.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v3 18/19] hw/char/virtio-serial: Do not expose the
 'emergency-write' property
Date: Fri,  2 May 2025 20:56:50 +0200
Message-ID: <20250502185652.67370-19-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502185652.67370-1-philmd@linaro.org>
References: <20250502185652.67370-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x529.google.com
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
it can not be disabled. VirtIOSerial::host_features mask is
now unused, remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/virtio/virtio-serial.h | 2 --
 hw/char/virtio-serial-bus.c       | 9 +++------
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/include/hw/virtio/virtio-serial.h b/include/hw/virtio/virtio-serial.h
index d87c62eab7a..e6ceacec309 100644
--- a/include/hw/virtio/virtio-serial.h
+++ b/include/hw/virtio/virtio-serial.h
@@ -185,8 +185,6 @@ struct VirtIOSerial {
     struct VirtIOSerialPostLoad *post_load;
 
     virtio_serial_conf serial;
-
-    uint64_t host_features;
 };
 
 /* Interface to the virtio-serial bus */
diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index eb79f5258b6..cfc8fa42186 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -557,7 +557,7 @@ static uint64_t get_features(VirtIODevice *vdev, uint64_t features,
 
     vser = VIRTIO_SERIAL(vdev);
 
-    features |= vser->host_features;
+    features |= BIT_ULL(VIRTIO_CONSOLE_F_EMERG_WRITE);
     if (vser->bus.max_nr_ports > 1) {
         virtio_add_feature(&features, VIRTIO_CONSOLE_F_MULTIPORT);
     }
@@ -587,8 +587,7 @@ static void set_config(VirtIODevice *vdev, const uint8_t *config_data)
     VirtIOSerialPortClass *vsc;
     uint8_t emerg_wr_lo;
 
-    if (!virtio_has_feature(vser->host_features,
-        VIRTIO_CONSOLE_F_EMERG_WRITE) || !config->emerg_wr) {
+    if (!config->emerg_wr) {
         return;
     }
 
@@ -1039,7 +1038,7 @@ static void virtio_serial_device_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    if (!virtio_has_feature(vser->host_features,
+    if (!virtio_has_feature(vdev->host_features,
                             VIRTIO_CONSOLE_F_EMERG_WRITE)) {
         config_size = offsetof(struct virtio_console_config, emerg_wr);
     }
@@ -1155,8 +1154,6 @@ static const VMStateDescription vmstate_virtio_console = {
 static const Property virtio_serial_properties[] = {
     DEFINE_PROP_UINT32("max_ports", VirtIOSerial, serial.max_virtserial_ports,
                                                   31),
-    DEFINE_PROP_BIT64("emergency-write", VirtIOSerial, host_features,
-                      VIRTIO_CONSOLE_F_EMERG_WRITE, true),
 };
 
 static void virtio_serial_class_init(ObjectClass *klass, const void *data)
-- 
2.47.1


