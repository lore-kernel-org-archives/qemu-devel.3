Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 000A0D5C0F0
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 15:44:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9R9h-0004sI-MI; Fri, 08 Nov 2024 10:44:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t9R9b-0004AB-AJ
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 10:44:07 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t9R9Z-0005Z3-Lk
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 10:44:07 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-37d50fad249so1611626f8f.1
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 07:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731080644; x=1731685444; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bmr0v3iLPnKSpHQqj1VRxKqdFU6SVqzqYAxggI2sOXg=;
 b=t/CGg3dhdGeBikpyIb9hmtVOU0yCU4bTWqrflBl3miNWZpynUOiHp9DrCFJ/m6ifnI
 s/d7iFdxSMvMnUl9/oE+euIGSlbY9jMN7ml68LiqaKICkIETanZCmo/dlOuHV/S5CjBq
 f/hZTqFOx7K4WUO0+CUVukJgHIcKKKTsUuX1tPZaUHO5u7sg5/K2+JWo563lRLGgUIAR
 OOXWj2suNj8C9ynhFBIgnrhSo5Zu6vnM9eyoNC6sHdAfOMc0M4Hwrr8qw+ysxXtDqwNw
 j/81DqM3cx7sqeF/i3z5xnkkuPNTwHXADioeB89QHHfGDCw22tR5Samlkb5DgmARlv4t
 /znw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731080644; x=1731685444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bmr0v3iLPnKSpHQqj1VRxKqdFU6SVqzqYAxggI2sOXg=;
 b=RU4JhS4vPZx7WKWzAf1LVPTJj2tlB/ksumeYpZuAF1b7gEIxfCD5xC3tAACJaT1IRA
 kwJv8v1aOlWvlUYD97vtSllK/GqiFME+92Q77Emm/kdzMvgx2iLvk6LqkWGRUVewM82x
 5sc143P0mPrIkN5+6RqVNH0bZINKhljlZ3Pp6rbM5VaA/2sBpDR+W11WXwEPjW47TDu2
 hWsGLbMD3idT7rXWKilp/AktVwKXYeVo8KKnC14FiOfv9iBf44Lu6RU9GHmQekHDAYr9
 f5k2dwSIAt/0MP2ueP7kMDObk44IJo4neu5FRUaVLXS3RDotN2ImnwoumGAtgIJcCn8h
 AHNA==
X-Gm-Message-State: AOJu0YwLtyxXhYK/d6XoVQupuici1AvOXgmoZbkPGhwP68+wLKaT54Rt
 VH7tDxitW8cDw0TVJGI86ITMpIq62/7VHjlAlIYPetWUlcvqZKpsCJt0Dy1XJo4Z5tVfRW216yT
 J
X-Google-Smtp-Source: AGHT+IFtAZlWR2TxirU3JU2V4pk9EhrYUba3wH6j8ueetAigMa+MmHiH3l5dGLd0gwg97qYcn6k+Zg==
X-Received: by 2002:a5d:6da8:0:b0:37d:4846:42c3 with SMTP id
 ffacd0b85a97d-381f186cc3emr3136402f8f.22.1731080643723; 
 Fri, 08 Nov 2024 07:44:03 -0800 (PST)
Received: from localhost.localdomain ([89.101.134.25])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed9ec272sm5334799f8f.85.2024.11.08.07.44.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 08 Nov 2024 07:44:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Anton Johansson <anjo@rev.ng>
Cc: Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, devel@lists.libvirt.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 09/17] hw/ssi/xilinx_spips: Make device endianness
 configurable
Date: Fri,  8 Nov 2024 15:43:09 +0000
Message-ID: <20241108154317.12129-10-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241108154317.12129-1-philmd@linaro.org>
References: <20241108154317.12129-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Replace the DEVICE_NATIVE_ENDIAN MemoryRegionOps by a pair
of DEVICE_LITTLE_ENDIAN / DEVICE_BIG_ENDIAN.
Add the "little-endian" property to select the device
endianness, defaulting to little endian.
Set the proper endianness on the single machine using the
device.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/ssi/xilinx_spips.h |  1 +
 hw/arm/xilinx_zynq.c          |  1 +
 hw/ssi/xilinx_spips.c         | 36 ++++++++++++++++++++++-------------
 3 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/include/hw/ssi/xilinx_spips.h b/include/hw/ssi/xilinx_spips.h
index 7a754bf67a..5d2cf6c7d7 100644
--- a/include/hw/ssi/xilinx_spips.h
+++ b/include/hw/ssi/xilinx_spips.h
@@ -91,6 +91,7 @@ struct XilinxSPIPS {
 struct XilinxQSPIPS {
     XilinxSPIPS parent_obj;
 
+    bool little_endian_model;
     uint8_t lqspi_buf[LQSPI_CACHE_SIZE];
     hwaddr lqspi_cached_addr;
     Error *migration_blocker;
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index fde4d946b7..bcc0022c17 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -142,6 +142,7 @@ static inline int zynq_init_spi_flashes(uint32_t base_addr, qemu_irq irq,
     int num_ss = is_qspi ? NUM_QSPI_FLASHES : NUM_SPI_FLASHES;
 
     dev = qdev_new(is_qspi ? "xlnx.ps7-qspi" : "xlnx.ps7-spi");
+    qdev_prop_set_bit(dev, "little-endian", true);
     qdev_prop_set_uint8(dev, "num-txrx-bytes", is_qspi ? 4 : 1);
     qdev_prop_set_uint8(dev, "num-ss-bits", num_ss);
     qdev_prop_set_uint8(dev, "num-busses", num_busses);
diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index aeb462c3ce..72929776e2 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -1251,18 +1251,21 @@ static MemTxResult lqspi_write(void *opaque, hwaddr offset, uint64_t value,
     return MEMTX_ERROR;
 }
 
-static const MemoryRegionOps lqspi_ops = {
-    .read_with_attrs = lqspi_read,
-    .write_with_attrs = lqspi_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
-    .impl = {
-        .min_access_size = 4,
-        .max_access_size = 4,
+static const MemoryRegionOps lqspi_ops[2] = {
+    [0 ... 1] = {
+        .read_with_attrs = lqspi_read,
+        .write_with_attrs = lqspi_write,
+        .impl = {
+            .min_access_size = 4,
+            .max_access_size = 4,
+        },
+        .valid = {
+            .min_access_size = 1,
+            .max_access_size = 4
+        },
     },
-    .valid = {
-        .min_access_size = 1,
-        .max_access_size = 4
-    }
+    [0].endianness = DEVICE_BIG_ENDIAN,
+    [1].endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static void xilinx_spips_realize(DeviceState *dev, Error **errp)
@@ -1325,8 +1328,9 @@ static void xilinx_qspips_realize(DeviceState *dev, Error **errp)
     s->num_txrx_bytes = 4;
 
     xilinx_spips_realize(dev, errp);
-    memory_region_init_io(&s->mmlqspi, OBJECT(s), &lqspi_ops, s, "lqspi",
-                          (1 << LQSPI_ADDRESS_BITS) * 2);
+    memory_region_init_io(&s->mmlqspi, OBJECT(s),
+                          &lqspi_ops[q->little_endian_model],
+                          s, "lqspi", (1 << LQSPI_ADDRESS_BITS) * 2);
     sysbus_init_mmio(sbd, &s->mmlqspi);
 
     q->lqspi_cached_addr = ~0ULL;
@@ -1432,12 +1436,18 @@ static Property xilinx_spips_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static Property xilinx_qspips_properties[] = {
+    DEFINE_PROP_BOOL("little-endian", XilinxQSPIPS, little_endian_model, true),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void xilinx_qspips_class_init(ObjectClass *klass, void * data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     XilinxSPIPSClass *xsc = XILINX_SPIPS_CLASS(klass);
 
     dc->realize = xilinx_qspips_realize;
+    device_class_set_props(dc, xilinx_qspips_properties);
     xsc->reg_ops = &qspips_ops;
     xsc->reg_size = XLNX_SPIPS_R_MAX * 4;
     xsc->rx_fifo_size = RXFF_A_Q;
-- 
2.45.2


