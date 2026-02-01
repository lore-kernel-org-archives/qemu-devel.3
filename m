Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F4DE6529E
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Feb 2026 23:32:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmgtt-0004zf-UX; Sun, 01 Feb 2026 18:30:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmgts-0004of-HY
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 18:30:40 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmgtq-0003Uv-6h
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 18:30:40 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-48068ed1eccso34710955e9.2
 for <qemu-devel@nongnu.org>; Sun, 01 Feb 2026 15:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769988636; x=1770593436; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XI4QauyUtUX66wtBIBxmVsjci7j411/fWovI3rGHj/g=;
 b=dNM8vRAVUEWF74F52Q4X/APcoifqvqZXI3YzS5eX5UjCUuxff0qBTjgLikgRuOQjpd
 EmTVwVT057nc39OgFN1tMIS13IQbvL2hkA9CqWSGuusGJnj2I60agDYE9vrIijHiO/Hs
 00GGW22fSIF1rqz5jL4jjb1JNCNWQ/9hQR20dm6B7P/+GhIz9wEcuY4e8pLDTsWknv6p
 UVVH3PpRLf9XpMAbz2MJ8j5CswQB7IINvIrkMrqJWNCKPGZj7ukYkOMMExErFUYHFAge
 h418qtj6IzaMyAOUufvDwtHj9y6ZF15Lv6HJsg7VqidO3J2K00KYNpRRMGms4e8coP6G
 j/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769988636; x=1770593436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XI4QauyUtUX66wtBIBxmVsjci7j411/fWovI3rGHj/g=;
 b=dyAK6yJ4/58+MzKnL2eQ/aWliR9E23IPIUd8U0ZAvgweIgrG1NMD82dWG7rOuRIkTp
 wplMnS/Rlx1jJ3xYazcyvz6/VCAjtsdYDNXZVP4+WsJmu0JNFTHaVDUCZ1wlSI3qK9AV
 XVpN9VTABoMGxjN244Y089zAHCgmhmr9tuFwFnk4XRF9hlqBF03fp30KmFZfyHVQ2p2y
 fdR/M3Q3t3YLbPmd5ifeD1kh6vupXRUlMaclKcVh5kTRU/kAvbLQ5UVofnno5hnygswI
 2j7IYMzppGta5nI5Bj5vIBqsmhdPtPapsQQ07pmk0iFPVnYo/Rmbfqm5nhSo6hY/x268
 LeYQ==
X-Gm-Message-State: AOJu0YzCXMglq+vIaUpRO+j2QYptI6XOCld3cRCeXBtWYuBgz7ql2mcM
 rY6sSThi7Ym/8RrI0WBu1u6pWu5WtY3G5NS3SJ8tVFgdK/FyKYaWpPVFjuMqGP3RILhdwkdzzMJ
 hQDGuGUY=
X-Gm-Gg: AZuq6aIYPBqVFS4SgtjpsrEJQV9lHix4Z5IMvJK2lNjCVbf+Rzuc72YKWiIcOeMQB7z
 eQeGByfCN+y+n4U8zHJmLu1DqYbY0l3qRmWfgHdHigWNTvAjF7o0tI8bhLs9N+nFPw4lUo6jllr
 3VwW2V+kBe0Opo98d/A2qvgKSgnQBFKUOSuP9z9QKkw0AwwCcaaGoVowXkfhcN6Hnf9gO9rbUD4
 9LfszY3KLRTZkqJ5uVLw2wRNN4sJrP3HpaoqHGUISNKpprUmKDN3HeX5CT1YDKp/2cIsq971/WG
 13qbSNy00csh6OBsIO0NmNQypyzHAiVonRrbyDR5Em9iX2xhzBmtm+h+veOrA5KCOTbSnW+wE23
 ZvcisIwhYRXEZHg7O1LVYPF85rTGCY5dcHR2cVbtFp6QawHEYqEbN/MPQ+pq885FSIHIF/ml4w1
 pn4hi//fxG3Rz7bp5duoE7XRkHoT4TI65tesaWOQiZ9OcWcU3bl+DvwtjCL5FHLxUw9zQHG5A=
X-Received: by 2002:a05:600c:1385:b0:480:3b4e:41b8 with SMTP id
 5b1f17b1804b1-482db497d9bmr124651885e9.33.1769988636083; 
 Sun, 01 Feb 2026 15:30:36 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-482e2545101sm72575905e9.10.2026.02.01.15.30.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 01 Feb 2026 15:30:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: [PATCH v3 10/11] hw/virtio/virtio-qmp: make compilation unit common
Date: Mon,  2 Feb 2026 00:29:22 +0100
Message-ID: <20260201232924.93399-11-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260201232924.93399-1-philmd@linaro.org>
References: <20260201232924.93399-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

All compile time conditionals have no impact at runtime, since they are
representing only possible features for devices present at runtime.

In case they are not present, associated features table will never be
used. In case they are present but some features are not, matching bits
will never be enabled, so those entries will be unused.

Thus, simply expose everything and call it a day.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/virtio/virtio-qmp.c | 70 ------------------------------------------
 hw/virtio/meson.build  |  2 +-
 2 files changed, 1 insertion(+), 71 deletions(-)

diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
index 968299fda0c..f9cdca50d99 100644
--- a/hw/virtio/virtio-qmp.c
+++ b/hw/virtio/virtio-qmp.c
@@ -33,21 +33,17 @@
 #include "standard-headers/linux/virtio_vsock.h"
 #include "standard-headers/linux/virtio_gpio.h"
 
-#include CONFIG_DEVICES
-
 #define FEATURE_ENTRY(name, desc) (qmp_virtio_feature_map_t) \
     { .virtio_bit = name, .feature_desc = desc }
 
 /* Virtio transport features mapping */
 static const qmp_virtio_feature_map_t virtio_transport_map[] = {
     /* Virtio device transport features */
-#ifndef VIRTIO_CONFIG_NO_LEGACY
     FEATURE_ENTRY(VIRTIO_F_NOTIFY_ON_EMPTY, \
             "VIRTIO_F_NOTIFY_ON_EMPTY: Notify when device runs out of avail. "
             "descs. on VQ"),
     FEATURE_ENTRY(VIRTIO_F_ANY_LAYOUT, \
             "VIRTIO_F_ANY_LAYOUT: Device accepts arbitrary desc. layouts"),
-#endif /* !VIRTIO_CONFIG_NO_LEGACY */
     FEATURE_ENTRY(VIRTIO_F_VERSION_1, \
             "VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)"),
     FEATURE_ENTRY(VIRTIO_F_IOMMU_PLATFORM, \
@@ -149,7 +145,6 @@ static const qmp_virtio_feature_map_t virtio_config_status_map[] = {
 };
 
 /* virtio-blk features mapping */
-#ifdef CONFIG_VIRTIO_BLK
 static const qmp_virtio_feature_map_t virtio_blk_feature_map[] = {
     FEATURE_ENTRY(VIRTIO_BLK_F_SIZE_MAX, \
             "VIRTIO_BLK_F_SIZE_MAX: Max segment size is size_max"),
@@ -173,7 +168,6 @@ static const qmp_virtio_feature_map_t virtio_blk_feature_map[] = {
             "VIRTIO_BLK_F_SECURE_ERASE: Secure erase supported"),
     FEATURE_ENTRY(VIRTIO_BLK_F_ZONED, \
             "VIRTIO_BLK_F_ZONED: Zoned block devices"),
-#ifndef VIRTIO_BLK_NO_LEGACY
     FEATURE_ENTRY(VIRTIO_BLK_F_BARRIER, \
             "VIRTIO_BLK_F_BARRIER: Request barriers supported"),
     FEATURE_ENTRY(VIRTIO_BLK_F_SCSI, \
@@ -183,7 +177,6 @@ static const qmp_virtio_feature_map_t virtio_blk_feature_map[] = {
     FEATURE_ENTRY(VIRTIO_BLK_F_CONFIG_WCE, \
             "VIRTIO_BLK_F_CONFIG_WCE: Cache writeback and writethrough modes "
             "supported"),
-#endif /* !VIRTIO_BLK_NO_LEGACY */
     FEATURE_ENTRY(VHOST_F_LOG_ALL, \
             "VHOST_F_LOG_ALL: Logging write descriptors supported"),
     FEATURE_ENTRY(VHOST_USER_F_PROTOCOL_FEATURES, \
@@ -191,10 +184,8 @@ static const qmp_virtio_feature_map_t virtio_blk_feature_map[] = {
             "negotiation supported"),
     { -1, "" }
 };
-#endif
 
 /* virtio-serial features mapping */
-#ifdef CONFIG_VIRTIO_SERIAL
 static const qmp_virtio_feature_map_t virtio_serial_feature_map[] = {
     FEATURE_ENTRY(VIRTIO_CONSOLE_F_SIZE, \
             "VIRTIO_CONSOLE_F_SIZE: Host providing console size"),
@@ -204,10 +195,8 @@ static const qmp_virtio_feature_map_t virtio_serial_feature_map[] = {
             "VIRTIO_CONSOLE_F_EMERG_WRITE: Emergency write supported"),
     { -1, "" }
 };
-#endif
 
 /* virtio-gpu features mapping */
-#ifdef CONFIG_VIRTIO_GPU
 static const qmp_virtio_feature_map_t virtio_gpu_feature_map[] = {
     FEATURE_ENTRY(VIRTIO_GPU_F_VIRGL, \
             "VIRTIO_GPU_F_VIRGL: Virgl 3D mode supported"),
@@ -227,10 +216,8 @@ static const qmp_virtio_feature_map_t virtio_gpu_feature_map[] = {
             "negotiation supported"),
     { -1, "" }
 };
-#endif
 
 /* virtio-input features mapping */
-#ifdef CONFIG_VIRTIO_INPUT
 static const qmp_virtio_feature_map_t virtio_input_feature_map[] = {
     FEATURE_ENTRY(VHOST_F_LOG_ALL, \
             "VHOST_F_LOG_ALL: Logging write descriptors supported"),
@@ -239,10 +226,8 @@ static const qmp_virtio_feature_map_t virtio_input_feature_map[] = {
             "negotiation supported"),
     { -1, "" }
 };
-#endif
 
 /* virtio-net features mapping */
-#ifdef CONFIG_VIRTIO_NET
 static const qmp_virtio_feature_map_t virtio_net_feature_map[] = {
     FEATURE_ENTRY(VIRTIO_NET_F_CSUM, \
             "VIRTIO_NET_F_CSUM: Device handling packets with partial checksum "
@@ -313,10 +298,8 @@ static const qmp_virtio_feature_map_t virtio_net_feature_map[] = {
             "device with same MAC addr. supported"),
     FEATURE_ENTRY(VIRTIO_NET_F_SPEED_DUPLEX, \
             "VIRTIO_NET_F_SPEED_DUPLEX: Device set linkspeed and duplex"),
-#ifndef VIRTIO_NET_NO_LEGACY
     FEATURE_ENTRY(VIRTIO_NET_F_GSO, \
             "VIRTIO_NET_F_GSO: Handling GSO-type packets supported"),
-#endif /* !VIRTIO_NET_NO_LEGACY */
     FEATURE_ENTRY(VHOST_NET_F_VIRTIO_NET_HDR, \
             "VHOST_NET_F_VIRTIO_NET_HDR: Virtio-net headers for RX and TX "
             "packets supported"),
@@ -341,10 +324,8 @@ static const qmp_virtio_feature_map_t virtio_net_feature_map[] = {
             "header"),
     { -1, "" }
 };
-#endif
 
 /* virtio-scsi features mapping */
-#ifdef CONFIG_VIRTIO_SCSI
 static const qmp_virtio_feature_map_t virtio_scsi_feature_map[] = {
     FEATURE_ENTRY(VIRTIO_SCSI_F_INOUT, \
             "VIRTIO_SCSI_F_INOUT: Requests including read and writable data "
@@ -364,10 +345,8 @@ static const qmp_virtio_feature_map_t virtio_scsi_feature_map[] = {
             "negotiation supported"),
     { -1, "" }
 };
-#endif
 
 /* virtio/vhost-user-fs features mapping */
-#ifdef CONFIG_VHOST_USER_FS
 static const qmp_virtio_feature_map_t virtio_fs_feature_map[] = {
     FEATURE_ENTRY(VHOST_F_LOG_ALL, \
             "VHOST_F_LOG_ALL: Logging write descriptors supported"),
@@ -376,10 +355,8 @@ static const qmp_virtio_feature_map_t virtio_fs_feature_map[] = {
             "negotiation supported"),
     { -1, "" }
 };
-#endif
 
 /* virtio/vhost-user-i2c features mapping */
-#ifdef CONFIG_VIRTIO_I2C_ADAPTER
 static const qmp_virtio_feature_map_t virtio_i2c_feature_map[] = {
     FEATURE_ENTRY(VIRTIO_I2C_F_ZERO_LENGTH_REQUEST, \
             "VIRTIO_I2C_F_ZERO_LEGNTH_REQUEST: Zero length requests supported"),
@@ -390,10 +367,8 @@ static const qmp_virtio_feature_map_t virtio_i2c_feature_map[] = {
             "negotiation supported"),
     { -1, "" }
 };
-#endif
 
 /* virtio/vhost-vsock features mapping */
-#ifdef CONFIG_VHOST_VSOCK
 static const qmp_virtio_feature_map_t virtio_vsock_feature_map[] = {
     FEATURE_ENTRY(VIRTIO_VSOCK_F_SEQPACKET, \
             "VIRTIO_VSOCK_F_SEQPACKET: SOCK_SEQPACKET supported"),
@@ -404,10 +379,8 @@ static const qmp_virtio_feature_map_t virtio_vsock_feature_map[] = {
             "negotiation supported"),
     { -1, "" }
 };
-#endif
 
 /* virtio-balloon features mapping */
-#ifdef CONFIG_VIRTIO_BALLOON
 static const qmp_virtio_feature_map_t virtio_balloon_feature_map[] = {
     FEATURE_ENTRY(VIRTIO_BALLOON_F_MUST_TELL_HOST, \
             "VIRTIO_BALLOON_F_MUST_TELL_HOST: Tell host before reclaiming "
@@ -424,19 +397,15 @@ static const qmp_virtio_feature_map_t virtio_balloon_feature_map[] = {
             "VIRTIO_BALLOON_F_REPORTING: Page reporting VQ enabled"),
     { -1, "" }
 };
-#endif
 
 /* virtio-crypto features mapping */
-#ifdef CONFIG_VIRTIO_CRYPTO
 static const qmp_virtio_feature_map_t virtio_crypto_feature_map[] = {
     FEATURE_ENTRY(VHOST_F_LOG_ALL, \
             "VHOST_F_LOG_ALL: Logging write descriptors supported"),
     { -1, "" }
 };
-#endif
 
 /* virtio-iommu features mapping */
-#ifdef CONFIG_VIRTIO_IOMMU
 static const qmp_virtio_feature_map_t virtio_iommu_feature_map[] = {
     FEATURE_ENTRY(VIRTIO_IOMMU_F_INPUT_RANGE, \
             "VIRTIO_IOMMU_F_INPUT_RANGE: Range of available virtual addrs. "
@@ -458,15 +427,11 @@ static const qmp_virtio_feature_map_t virtio_iommu_feature_map[] = {
             "available"),
     { -1, "" }
 };
-#endif
 
 /* virtio-mem features mapping */
-#ifdef CONFIG_VIRTIO_MEM
 static const qmp_virtio_feature_map_t virtio_mem_feature_map[] = {
-#ifndef CONFIG_ACPI
     FEATURE_ENTRY(VIRTIO_MEM_F_ACPI_PXM, \
             "VIRTIO_MEM_F_ACPI_PXM: node_id is an ACPI PXM and is valid"),
-#endif /* !CONFIG_ACPI */
     FEATURE_ENTRY(VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE, \
             "VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE: Unplugged memory cannot be "
             "accessed"),
@@ -475,10 +440,8 @@ static const qmp_virtio_feature_map_t virtio_mem_feature_map[] = {
             "plugged when suspending+resuming"),
     { -1, "" }
 };
-#endif
 
 /* virtio-rng features mapping */
-#ifdef CONFIG_VIRTIO_RNG
 static const qmp_virtio_feature_map_t virtio_rng_feature_map[] = {
     FEATURE_ENTRY(VHOST_F_LOG_ALL, \
             "VHOST_F_LOG_ALL: Logging write descriptors supported"),
@@ -487,10 +450,8 @@ static const qmp_virtio_feature_map_t virtio_rng_feature_map[] = {
             "negotiation supported"),
     { -1, "" }
 };
-#endif
 
 /* virtio/vhost-gpio features mapping */
-#ifdef CONFIG_VHOST_USER_GPIO
 static const qmp_virtio_feature_map_t virtio_gpio_feature_map[] = {
     FEATURE_ENTRY(VIRTIO_GPIO_F_IRQ, \
             "VIRTIO_GPIO_F_IRQ: Device supports interrupts on GPIO lines"),
@@ -499,7 +460,6 @@ static const qmp_virtio_feature_map_t virtio_gpio_feature_map[] = {
             "negotiation supported"),
     { -1, "" }
 };
-#endif
 
 #define CONVERT_FEATURES(type, map, is_status, bitmap)   \
     ({                                                   \
@@ -595,96 +555,66 @@ VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id,
 
     /* device features */
     switch (device_id) {
-#ifdef CONFIG_VIRTIO_SERIAL
     case VIRTIO_ID_CONSOLE:
         features->dev_features =
             CONVERT_FEATURES_EX(strList, virtio_serial_feature_map, bitmap);
         break;
-#endif
-#ifdef CONFIG_VIRTIO_BLK
     case VIRTIO_ID_BLOCK:
         features->dev_features =
             CONVERT_FEATURES_EX(strList, virtio_blk_feature_map, bitmap);
         break;
-#endif
-#ifdef CONFIG_VIRTIO_GPU
     case VIRTIO_ID_GPU:
         features->dev_features =
             CONVERT_FEATURES_EX(strList, virtio_gpu_feature_map, bitmap);
         break;
-#endif
-#ifdef CONFIG_VIRTIO_NET
     case VIRTIO_ID_NET:
         features->dev_features =
             CONVERT_FEATURES_EX(strList, virtio_net_feature_map, bitmap);
         break;
-#endif
-#ifdef CONFIG_VIRTIO_SCSI
     case VIRTIO_ID_SCSI:
         features->dev_features =
             CONVERT_FEATURES_EX(strList, virtio_scsi_feature_map, bitmap);
         break;
-#endif
-#ifdef CONFIG_VIRTIO_BALLOON
     case VIRTIO_ID_BALLOON:
         features->dev_features =
             CONVERT_FEATURES_EX(strList, virtio_balloon_feature_map, bitmap);
         break;
-#endif
-#ifdef CONFIG_VIRTIO_IOMMU
     case VIRTIO_ID_IOMMU:
         features->dev_features =
             CONVERT_FEATURES_EX(strList, virtio_iommu_feature_map, bitmap);
         break;
-#endif
-#ifdef CONFIG_VIRTIO_INPUT
     case VIRTIO_ID_INPUT:
         features->dev_features =
             CONVERT_FEATURES_EX(strList, virtio_input_feature_map, bitmap);
         break;
-#endif
-#ifdef CONFIG_VHOST_USER_FS
     case VIRTIO_ID_FS:
         features->dev_features =
             CONVERT_FEATURES_EX(strList, virtio_fs_feature_map, bitmap);
         break;
-#endif
-#ifdef CONFIG_VHOST_VSOCK
     case VIRTIO_ID_VSOCK:
         features->dev_features =
             CONVERT_FEATURES_EX(strList, virtio_vsock_feature_map, bitmap);
         break;
-#endif
-#ifdef CONFIG_VIRTIO_CRYPTO
     case VIRTIO_ID_CRYPTO:
         features->dev_features =
             CONVERT_FEATURES_EX(strList, virtio_crypto_feature_map, bitmap);
         break;
-#endif
-#ifdef CONFIG_VIRTIO_MEM
     case VIRTIO_ID_MEM:
         features->dev_features =
             CONVERT_FEATURES_EX(strList, virtio_mem_feature_map, bitmap);
         break;
-#endif
-#ifdef CONFIG_VIRTIO_I2C_ADAPTER
     case VIRTIO_ID_I2C_ADAPTER:
         features->dev_features =
             CONVERT_FEATURES_EX(strList, virtio_i2c_feature_map, bitmap);
         break;
-#endif
-#ifdef CONFIG_VIRTIO_RNG
     case VIRTIO_ID_RNG:
         features->dev_features =
             CONVERT_FEATURES_EX(strList, virtio_rng_feature_map, bitmap);
         break;
-#endif
-#ifdef CONFIG_VHOST_USER_GPIO
     case VIRTIO_ID_GPIO:
         features->dev_features =
             CONVERT_FEATURES_EX(strList, virtio_gpio_feature_map, bitmap);
         break;
-#endif
     /* No features */
     case VIRTIO_ID_9P:
     case VIRTIO_ID_PMEM:
diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index ee397aaf196..d913b94e1ca 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -11,7 +11,7 @@ system_virtio_ss.add(when: 'CONFIG_VHOST_VDPA_DEV', if_true: files('vdpa-dev.c')
 
 specific_virtio_ss = ss.source_set()
 specific_virtio_ss.add(files('virtio.c'))
-specific_virtio_ss.add(files('virtio-qmp.c'))
+system_virtio_ss.add(files('virtio-qmp.c'))
 
 if have_vhost
   system_virtio_ss.add(files('vhost.c'))
-- 
2.52.0


