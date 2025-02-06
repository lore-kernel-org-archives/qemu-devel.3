Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F20EC02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 11:36:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg08p-000779-K5; Thu, 06 Feb 2025 06:33:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg08l-00076R-2g
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 06:33:51 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg08j-0000qv-BZ
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 06:33:50 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4361b6f9faeso4309255e9.1
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 03:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738841627; x=1739446427; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X20R65gi2tCckItv1V/R89183LZ1ZNOLWFw83d9B9RI=;
 b=fTVFry/L3Z/M1se7dWdF3V2OXQxtjAvxLOJN36qmdQ1aInhKwbeqz2poczB/Vxzaf5
 dJDsjcvnnSCkAG5XPLlMw8IFEBH6w2PtUFjAVUzqXSKQ1qIIBr633hdSKbYhWgIK7cop
 /hj1rDjYBEw69dyHnPjG4Rltag7UZmRdw81NLsHaVT8Sovyrj6N2VQ90y+ohrYOIH1wy
 VY2nsQq88kEHWHlWetg0wHLaWLZgkrH98lW5o6UBprC/zPS62XsyNTaYR2F9d4wT9aeI
 2lfADfWeXL4HTsTjeWOl7URd/yBL31u9uDXAiLD0RnKWiYRZYkM+czgJgf9oSxd3fKE8
 kDmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738841627; x=1739446427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X20R65gi2tCckItv1V/R89183LZ1ZNOLWFw83d9B9RI=;
 b=dKAwZLdej6h9REJB1wV5dZYUTCn+fLqMV6SE0mtxe1Vu6C+kBg7P8cCHWYglCfycGT
 ojt3fbCa9vVF8EJO4td5M2n0nLcoWx9y5tpTJQcBGjroE/K/zzYiKBUeIlnO5c7B+CCb
 F3FX48qTRMSB0mxD6oQcsjYq6LWAd5IKq4T3L/SRFjyxyryNPfdUC/0wa2LfdBgw//DL
 1DAEJHyT+/FXvjZseHv+6/cCMwReSBYwrAl9oTA+hFd2E1uU0BV2INEI8qGMU5rZKEEz
 ZaEMN8IsYEx69IJjCtguUudPKpftG0NJsgC0P52C9sOCd0sjz1M+cY3hDtqYGYxq4k+R
 fQVw==
X-Gm-Message-State: AOJu0YyO/v74dPzD+vhBsZL3hkdUt+IqYAa83CXay3tn//KhDNi2Vud9
 HySISXazBLDu+bMmfMrnHictUNNkVz5u1/J//mjnQ5IVfSmvGo96zSlYoXxL1dQwi7djeMPL0Q/
 4vB0=
X-Gm-Gg: ASbGncshLMABEN1Bae0+g9qGm+kwRVGJ2os99BFC9y5rhDpOzXEGPhq/1L2yMpDQL9N
 mTQalBlc/F35ANybneBpTHlrxCoPOahQTmgldg0A17OutNt1IcLuFjeDM419nNUBlpmCknGMtnF
 PhMbEKGPUHHGZcD+SRGVD2VtnoN7WdE7EBG7BZfKzMvHvKR/SlqeLo43x68J00LezoyLOyIne+2
 7iR5AjVBgrnIHcZhVpDmyHw83CGffwAIXrOR/ALfrMQrmqY/tEN2CmV3c55wYowNyDgAu1GHsA9
 n6/2yu5f86UjkwA5NLYT88TimF0l2jt9RFfLWyZscF0emc1WoDYApZH6X/hisXviUQ==
X-Google-Smtp-Source: AGHT+IH0rWun/FyIFwo6uES3JX/EHEySC9+rrMqJFFqObX7Scfpd2vbwDmeMG5dGn3VpDXTsiZbBQw==
X-Received: by 2002:a05:600c:a089:b0:436:1b86:f05 with SMTP id
 5b1f17b1804b1-43912d3822cmr22096705e9.11.1738841627478; 
 Thu, 06 Feb 2025 03:33:47 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dbdd3856fsm1476849f8f.28.2025.02.06.03.33.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Feb 2025 03:33:47 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 05/16] hw/ssi/xilinx_spi: Make device endianness
 configurable
Date: Thu,  6 Feb 2025 12:33:10 +0100
Message-ID: <20250206113321.94906-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250206113321.94906-1-philmd@linaro.org>
References: <20250206113321.94906-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Replace the DEVICE_NATIVE_ENDIAN MemoryRegionOps by a pair
of DEVICE_LITTLE_ENDIAN / DEVICE_BIG_ENDIAN.
Add the "little-endian" property to select the device
endianness, defaulting to little endian.
Set the proper endianness on the single machine using the
device.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/microblaze/petalogix_ml605_mmu.c |  1 +
 hw/ssi/xilinx_spi.c                 | 24 +++++++++++++++---------
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
index bbda70aa93b..a795c6385b4 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -175,6 +175,7 @@ petalogix_ml605_init(MachineState *machine)
         SSIBus *spi;
 
         dev = qdev_new("xlnx.xps-spi");
+        qdev_prop_set_bit(dev, "little-endian", true);
         qdev_prop_set_uint8(dev, "num-ss-bits", NUM_SPI_FLASHES);
         busdev = SYS_BUS_DEVICE(dev);
         sysbus_realize_and_unref(busdev, &error_fatal);
diff --git a/hw/ssi/xilinx_spi.c b/hw/ssi/xilinx_spi.c
index fd1ff12eb1d..299004ff36d 100644
--- a/hw/ssi/xilinx_spi.c
+++ b/hw/ssi/xilinx_spi.c
@@ -83,6 +83,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(XilinxSPI, XILINX_SPI)
 struct XilinxSPI {
     SysBusDevice parent_obj;
 
+    bool little_endian_model;
     MemoryRegion mmio;
 
     qemu_irq irq;
@@ -313,14 +314,17 @@ done:
     xlx_spi_update_irq(s);
 }
 
-static const MemoryRegionOps spi_ops = {
-    .read = spi_read,
-    .write = spi_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
-    .valid = {
-        .min_access_size = 4,
-        .max_access_size = 4
-    }
+static const MemoryRegionOps spi_ops[2] = {
+    [0 ... 1] = {
+        .read = spi_read,
+        .write = spi_write,
+        .valid = {
+            .min_access_size = 4,
+            .max_access_size = 4,
+        },
+    },
+    [0].endianness = DEVICE_BIG_ENDIAN,
+    [1].endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static void xilinx_spi_realize(DeviceState *dev, Error **errp)
@@ -339,7 +343,8 @@ static void xilinx_spi_realize(DeviceState *dev, Error **errp)
         sysbus_init_irq(sbd, &s->cs_lines[i]);
     }
 
-    memory_region_init_io(&s->mmio, OBJECT(s), &spi_ops, s,
+    memory_region_init_io(&s->mmio, OBJECT(s),
+                          &spi_ops[s->little_endian_model], s,
                           "xilinx-spi", R_MAX * 4);
     sysbus_init_mmio(sbd, &s->mmio);
 
@@ -362,6 +367,7 @@ static const VMStateDescription vmstate_xilinx_spi = {
 };
 
 static const Property xilinx_spi_properties[] = {
+    DEFINE_PROP_BOOL("little-endian", XilinxSPI, little_endian_model, true),
     DEFINE_PROP_UINT8("num-ss-bits", XilinxSPI, num_cs, 1),
 };
 
-- 
2.47.1


