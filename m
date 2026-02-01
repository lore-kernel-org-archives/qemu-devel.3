Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93063D172A6
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Feb 2026 23:21:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmgkn-0006jL-W4; Sun, 01 Feb 2026 18:21:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmgkj-0006Pg-Sv
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 18:21:14 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmgkh-0000OY-3G
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 18:21:13 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-48068ed1eccso34673745e9.2
 for <qemu-devel@nongnu.org>; Sun, 01 Feb 2026 15:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769988069; x=1770592869; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XI4QauyUtUX66wtBIBxmVsjci7j411/fWovI3rGHj/g=;
 b=z8o5JHlBf9hJBWs5+RiVAXIpTBNzFUQ5oT1Yf7No8zbFpQj8z2h1/3KCVOT0WFV8YN
 fQld19qcAvLegjic2j/iGlQJGw6e0VWpbOxJCHAukczO+jm3y3cAR8dlqv2/9Bdraftf
 33027wEQpZnzdV6rzTRsF9MK1mo/wHbEgo1cm6xPb+eQ4VNJSi+/mySNeJ8ceWPdfVgy
 MBAfxR/on/2eMykIv4ANDlvQ0YLHzJO7ciubTwwD67ulrOE0t9gP4+YvmVPEsc5dPLtV
 UC61K8eXI0ydlJWt0M+DNHEF2nQ9MCLYHNLprTKoP+cmfDMUwKnmj4FHscLnhAGg98iQ
 5QBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769988069; x=1770592869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XI4QauyUtUX66wtBIBxmVsjci7j411/fWovI3rGHj/g=;
 b=ODo9lW28a3kgekuHGWZuyCGf5vgMajaaj+ZiGgoZrq2ecfcv1w2j9grdwpgNIA5Ji4
 +XVfFzB+JskBG3yDYaNwlO30jcBl1J2ym3C8/4g0xHNy6j9YRhEsCl/+cg8dS1zFP0Bg
 /LcKCOclIutICoOUkM43ZR6bEjRpO5eS/mF9uBCRgfOXFFwjH6haAdAMzQ5EDo3ua4fP
 rLuzWZP+lbuuHIq6OldYQLyMz0eVKCUZ3wxsjgD0CsMslnPKTnwZaseW0WpDBpfuIznY
 bPnMw1zuvawZy01wWOFA61MUYQSuQtNGKzj21Ya7kQ3EQFJdcmf5IQSDyKBo5rvMtfV0
 zTow==
X-Gm-Message-State: AOJu0Yy85D/8bnPVSEbaSBHLlCA3oacyzeYLyyS2sYbwcm7gii7Xg0Ri
 8qGbju8A5aF1dVusz8HlUQolXI6Kub8euFlo4ANWRH6hLzyRVlQsN6wHc/5+al468MlEv2zlKCL
 PeIO/8DI=
X-Gm-Gg: AZuq6aJqhbQnyHes/xXSNDyAoJkFZG1zg3Yyx5O49sq1p0h0oRMtXm0Jy2xvIm46cWX
 8O6QSP3u2tydfkHqnk+pMbOv3RodJwz7cn82CSDGsQIjhmshsNZRQsh+gvcm2/HDHykHtXkTdVz
 NH7mpezp5w1e/IHxbPqKm+U61KpnYDn/QHYkiQRLvo9L622YH2Pb1Yt4GnJclt6igQeKn+lWnHf
 lDYWlt96NVNiBAkKvoFpgFVv2+/kLWezaSUcoZp0wtpUNhoNsxCBO05Ia8xv4FG0ioRo5xmuLrf
 MNzrFHh8xjZQsgi/VE92nzHjn5nh8/C0ivUR9SjE7qYcLGWvWAb+iVo0Hah9iJ3vkCMnBX2YYOE
 8eyEh0dPmtMx11L56siw652DWPl40irTw4HkOQHioYGSFN9Il/AgZHUaRk8YYjU1kBkZTLAKk3h
 YYkS3Fd3CEujx1+WFggkFqwW+Qt4V6BU1nu89uB0Q6ZoxgD5ve4Rt5dcdAh7vTM/h0XRHyGGk=
X-Received: by 2002:a05:600c:6218:b0:477:7bca:8b2b with SMTP id
 5b1f17b1804b1-482db45cd74mr122841765e9.15.1769988069017; 
 Sun, 01 Feb 2026 15:21:09 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-482da91a227sm98532615e9.2.2026.02.01.15.21.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 01 Feb 2026 15:21:07 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v2 09/10] hw/virtio/virtio-qmp: make compilation unit common
Date: Mon,  2 Feb 2026 00:19:58 +0100
Message-ID: <20260201231959.88559-10-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260201231959.88559-1-philmd@linaro.org>
References: <20260201231959.88559-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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


