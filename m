Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34420CCF9EB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 18:43:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDoeC-0005WW-4k; Tue, 28 Oct 2025 14:42:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDodj-0005F8-HI
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 14:41:52 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDodP-0005oT-Ez
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 14:41:51 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-42557c5cedcso4097163f8f.0
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 11:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761676885; x=1762281685; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lIoBZbv7mBqCNJwjBiHWOo22r8zKTe2GN0MeWBRTiMU=;
 b=RGWToCDLWr1Q/lPxNTpG7oizwf2ZUPmyRjaVW9rSCLhTOiA2HxHUa9KhdVEm2Gx3W8
 x7qO/4+Ip4/jBGSvWlvqWQJUVinZT+vf5390X1jAD2LG90mnx1KWCe44tN0k2TBYFlAO
 ZLBJgQ2q0i3Y+E0JMVq+6Y2PNQIN0tpOJbnYVhKVn3Kzwts/CV8DthPo7FY10crbGS7a
 tUMuSn4E21PTXt/AlqV/8SzcbBRBtZeRL5PABr07LvVn1AG1mCsSqx2qdfqFX+Mbv+zZ
 /c3kwxI9bAEYpksHDjNkI/0F7LIyYP6VUL8s5J/vUw8uNPRoAxQZga/MhidhbGiO2dM2
 pb8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761676885; x=1762281685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lIoBZbv7mBqCNJwjBiHWOo22r8zKTe2GN0MeWBRTiMU=;
 b=BYZqHcslY1tYd9HIarzLDshjjwRkoBX6Ls+NgBdMH6eq3ASgOo+G1AAz36peseGxas
 tHJ3/M7xAyhgHrFTKX1DimaGhndscyEY91S+fTZGwHUfm3KMgsZ6kSs+kHq0rZKmUOL+
 HCSUD7nY13oJEyfxKcT/qVa16xciq1hd/JEvpJuOLV2mNd7+RTyvAUR9OesO1fH3b01E
 voge5M892cfZaScGvgJj0m/2XyIuBZG9as8bcFKlGUgo0gauCvOJMscO6ODbh0alI/qm
 /meGOZkz6YnGDB2Pw9jGs4ePPqE/6FmsfFcdr6pwCmF1ISGjaoYznTPKQpyYBY8Z2+f2
 VxIw==
X-Gm-Message-State: AOJu0YzRwseaw7Z9TUjSyIesQrKHoC5FX664pjwB6Kr7anyU6/eh2cNS
 vDr+lOxR9MTvgnQG6dzPWvH38iXiHatF2+0KcO2uMCBHyLOU8Q3UL2z7kclY8X25mJ3sMPWk9re
 p9LILt9M=
X-Gm-Gg: ASbGncsSCtgrMeTBnR77/iIo8bBmkrcEG0NJyOUFrIBeeHTdeXRnf/y3PsIAFtDN60U
 6BKKlr4/2qETZoBurm5oovFuImx5vq+T+0gveSHTtGtoDwaPaj4zktIUL863qod1IGwIlAVUG1d
 gXfvAk422R8cPhs7OIoFjZlSBW5D2NeIMv6jSnMqReBfved4nu2uxrrGJFGq1X2kZTg2qi/hO4j
 FMM0DOQzAfJ86UpzWL3a5+ALQURWkfB1WCb/qv6+PieEI4wMzgf8wGSW1cfwUdRtQnRSGGfgAiD
 HCXDSOJKvT9Jw0CXXQD+ZCTJd3bOFoAwwi5HSFM+rZTxwSCoAX3Pzc1ZDRNgi/axkRzzhg3nWXE
 aQ89TLCdjfk7ngICcKiyjzVa3Vhxjd4s7ov3X/BT6IQsiovvoakLc8H9NBQg+c08lwPC7ahLPaP
 EAJPVzAhzmYNu15ceYsU8w86yEXw/SjXfjmRGg4Yby3V/G6DGELw==
X-Google-Smtp-Source: AGHT+IE9Bg27htI7e9/HI71s8ONLKbXXTD8QFcUk7hl9xI6nX05rgKMPsTlhPJM2WGdvc6SN+XjgAw==
X-Received: by 2002:a05:6000:40e1:b0:429:8b01:c08c with SMTP id
 ffacd0b85a97d-429aef82eb8mr76573f8f.19.1761676884736; 
 Tue, 28 Oct 2025 11:41:24 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952b7b22sm21462186f8f.9.2025.10.28.11.41.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Oct 2025 11:41:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v3 25/25] hw/sysbus: Simplify SysBusDevice::mmio
Date: Tue, 28 Oct 2025 19:12:59 +0100
Message-ID: <20251028181300.41475-26-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028181300.41475-1-philmd@linaro.org>
References: <20251028181300.41475-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Directly access the MemoryRegion array, removing
the need for the embedded structure.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/sysbus.h | 4 +---
 hw/core/sysbus.c    | 8 ++++----
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/include/hw/sysbus.h b/include/hw/sysbus.h
index b2a2ea507ea..2cee5bcd44f 100644
--- a/include/hw/sysbus.h
+++ b/include/hw/sysbus.h
@@ -59,9 +59,7 @@ struct SysBusDevice {
     /*< public >*/
 
     int num_mmio;
-    struct {
-        MemoryRegion *memory;
-    } mmio[QDEV_MAX_MMIO];
+    MemoryRegion *mmio[QDEV_MAX_MMIO];
     int num_pio;
     uint32_t pio[QDEV_MAX_PIO];
 };
diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index b3060e02484..188a6ab055e 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -125,7 +125,7 @@ static void sysbus_mmio_map_common(SysBusDevice *dev, int n, hwaddr addr,
     MemoryRegion *mr;
 
     assert(n >= 0 && n < dev->num_mmio);
-    mr = dev->mmio[n].memory;
+    mr = dev->mmio[n];
 
     if (memory_region_is_mapped(mr)) {
         /* Unregister previous mapping.  */
@@ -143,7 +143,7 @@ void sysbus_mmio_map(SysBusDevice *dev, int n, hwaddr addr)
 int sysbus_mmio_map_name(SysBusDevice *dev, const char *name, hwaddr addr)
 {
     for (int i = 0; i < dev->num_mmio; i++) {
-        if (!strcmp(memory_region_name(dev->mmio[i].memory), name)) {
+        if (!strcmp(memory_region_name(dev->mmio[i]), name)) {
             sysbus_mmio_map(dev, i, addr);
             return i;
         }
@@ -175,13 +175,13 @@ void sysbus_init_mmio(SysBusDevice *dev, MemoryRegion *memory)
 
     assert(dev->num_mmio < QDEV_MAX_MMIO);
     n = dev->num_mmio++;
-    dev->mmio[n].memory = memory;
+    dev->mmio[n] = memory;
 }
 
 MemoryRegion *sysbus_mmio_get_region(const SysBusDevice *dev, int n)
 {
     assert(n >= 0 && n < QDEV_MAX_MMIO);
-    return dev->mmio[n].memory;
+    return dev->mmio[n];
 }
 
 void sysbus_init_ioports(SysBusDevice *dev, uint32_t ioport, uint32_t size)
-- 
2.51.0


