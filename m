Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 572C1C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 15:41:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpqrS-0000Z0-Hw; Wed, 05 Mar 2025 10:40:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpqrF-0000Fe-EJ
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 10:40:31 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpqrD-0002Yw-Dy
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 10:40:28 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-38a25d4b9d4so4199817f8f.0
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 07:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741189225; x=1741794025; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h75Q8oFB88c1KxlztseXVkazErFGK1NRT/MtbJI0cyg=;
 b=CqqxoSQBo2gAujJYVlE9bT4K1R5IVnfaGIpvyn+fU11FMflWA6FkxGQlJgzGX2ZehC
 hG+iBBAEpVdRwVcwaOHEV6yehNxNkfJv4NpUzPVAXO7jEPqj24yt4QeEKXD/nH9CXWul
 Q9BBLJh7MAVn+KRJd88XHXTyC7UOIUlZJW4SCQEusVQt0QdEbDR732W/biXpDnHIGbYi
 SObWxLDuOGcghisjYGj60y0DnyIG6A3/ONlf09nL5g19H6PvH+DXR/5bg2CyYzDh06Uf
 SgjoN1UKwFQf6GoBA6k2IArCgj0UMkSGTC3ul+jZwCcZBxLZwzqTEKME1xyvmtHZzI4E
 07QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741189225; x=1741794025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h75Q8oFB88c1KxlztseXVkazErFGK1NRT/MtbJI0cyg=;
 b=MZ+VvvFLMYIVD9C/Tj9Dc7/FsfR4VqMIPc7NFF2C6KwQJikw4M7v6l+xBupZjfsJpt
 P+D7ySHq21CArkoybKque/+rDMo/MAze8NcIece/y4H/Zt3UVPfiMXQC2cQ78OUdfrXh
 Qm2wNVbIykUUIJlddYR+yMcsSZDG12kqH1jwq0KwhLG0HnGmuwrg1uBG9G64Cmmr3e+e
 UFGtuTEz7yRw1x/zebyx+za78ln5L0xjE7V5dwFOk/T1gbTMmgae35hrC5pO6+ExnzK6
 yTPGyMqD4OqvvQgeWG94QzjYQDKj49LHA0Tz8FwSsJoCzEfjIjBA3cAj4CjMY7e0pMNK
 teMw==
X-Gm-Message-State: AOJu0YxSjURCaLNWoXUGEJsYMWagH/1ZaPIwfKoMbDKqJfZj+MsoQEgF
 4PaY0VZM14ysom0pE2NneqC6BZTISG9FOpnNdgAirYRaggUR97wASko1wupZuQpMhHBVFCyOPpE
 S4AE=
X-Gm-Gg: ASbGncu9ULweRO+zZL74CsEPBCrw6d3kN1XInXK8rQ+bf23uf5hyg9MiqRlQZg2hnAL
 AGES5zc4MsoKl4/e/xy1hO2wXuIvNk2ci6zjon26JawZrmwvtcsy1dARGKX8TngnDb6+MI2jF/R
 KZZuvsI13nRQ8mJeXhQe6W+T5M6WTCXY70xMOAQMFn6kRMlivVnBYusssZyq3Aa/E101GCWQLGq
 E20lIs9ecgurKSKhpa+FotGaZ//vn0yf+IIeOtsa2TYP0i4rRFlaiJDMQ9ylenOwot6dnvDIWuE
 sgrsagvaFy7cYhibimKeMbSCeuXCsbeo1631/IvLjbfY39gifXbpOtFOUBryq18GgbBFpHzRPtY
 hFT1q1ZlqcwGy9zOUfB0=
X-Google-Smtp-Source: AGHT+IFSjbTE5HXp9KyZNAh82ePsMKy7upgs6ToOmvQCiPR00bzw/AMHbUAXgjxdLnjIMDCUPcKj1g==
X-Received: by 2002:a05:6000:2cf:b0:391:6fd:bb8a with SMTP id
 ffacd0b85a97d-3911f740597mr3342520f8f.14.1741189224730; 
 Wed, 05 Mar 2025 07:40:24 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-391288b54cbsm243197f8f.28.2025.03.05.07.40.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 05 Mar 2025 07:40:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 11/18] hw/mips/jazz: Replace TARGET_BIG_ENDIAN by
 legacy_binary_is_big_endian
Date: Wed,  5 Mar 2025 16:39:21 +0100
Message-ID: <20250305153929.43687-12-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305153929.43687-1-philmd@linaro.org>
References: <20250305153929.43687-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

For legacy binaries, legacy_binary_is_big_endian() is equivalent
of the compile time TARGET_BIG_ENDIAN definition.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/jazz.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/hw/mips/jazz.c b/hw/mips/jazz.c
index 1700c3765de..b6f7565f6c5 100644
--- a/hw/mips/jazz.c
+++ b/hw/mips/jazz.c
@@ -24,6 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/datadir.h"
+#include "qemu/legacy_binary_info.h"
 #include "hw/clock.h"
 #include "hw/mips/mips.h"
 #include "hw/intc/i8259.h"
@@ -59,12 +60,6 @@ enum jazz_model_e {
     JAZZ_PICA61,
 };
 
-#if TARGET_BIG_ENDIAN
-#define BIOS_FILENAME "mips_bios.bin"
-#else
-#define BIOS_FILENAME "mipsel_bios.bin"
-#endif
-
 static void main_cpu_reset(void *opaque)
 {
     MIPSCPU *cpu = opaque;
@@ -120,7 +115,8 @@ static const MemoryRegionOps dma_dummy_ops = {
 };
 
 static void mips_jazz_init_net(IOMMUMemoryRegion *rc4030_dma_mr,
-                               DeviceState *rc4030, MemoryRegion *dp8393x_prom)
+                               DeviceState *rc4030, MemoryRegion *dp8393x_prom,
+                               bool is_big_endian)
 {
     DeviceState *dev;
     SysBusDevice *sysbus;
@@ -136,7 +132,7 @@ static void mips_jazz_init_net(IOMMUMemoryRegion *rc4030_dma_mr,
     dev = qdev_new("dp8393x");
     qdev_set_nic_properties(dev, nd);
     qdev_prop_set_uint8(dev, "it_shift", 2);
-    qdev_prop_set_bit(dev, "big_endian", TARGET_BIG_ENDIAN);
+    qdev_prop_set_bit(dev, "big_endian", is_big_endian);
     object_property_set_link(OBJECT(dev), "dma_mr",
                              OBJECT(rc4030_dma_mr), &error_abort);
     sysbus = SYS_BUS_DEVICE(dev);
@@ -194,6 +190,9 @@ static void mips_jazz_init(MachineState *machine,
     MemoryRegion *bios2 = g_new(MemoryRegion, 1);
     SysBusESPState *sysbus_esp;
     ESPState *esp;
+    bool is_big_endian = legacy_binary_is_big_endian();
+    const char *default_bios_filename = is_big_endian ? "mips_bios.bin"
+                                                      : "mipsel_bios.bin";
     static const struct {
         unsigned freq_hz;
         unsigned pll_mult;
@@ -212,8 +211,7 @@ static void mips_jazz_init(MachineState *machine,
                          * ext_clk[jazz_model].pll_mult);
 
     /* init CPUs */
-    cpu = mips_cpu_create_with_clock(machine->cpu_type, cpuclk,
-                                     TARGET_BIG_ENDIAN);
+    cpu = mips_cpu_create_with_clock(machine->cpu_type, cpuclk, is_big_endian);
     env = &cpu->env;
     qemu_register_reset(main_cpu_reset, cpu);
 
@@ -245,7 +243,8 @@ static void mips_jazz_init(MachineState *machine,
     memory_region_add_subregion(address_space, 0xfff00000LL, bios2);
 
     /* load the BIOS image. */
-    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, machine->firmware ?: BIOS_FILENAME);
+    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, machine->firmware
+                                                   ?: default_bios_filename);
     if (filename) {
         bios_size = load_image_targphys(filename, 0xfff00000LL,
                                         MAGNUM_BIOS_SIZE);
@@ -329,7 +328,7 @@ static void mips_jazz_init(MachineState *machine,
     }
 
     /* Network controller */
-    mips_jazz_init_net(rc4030_dma_mr, rc4030, dp8393x_prom);
+    mips_jazz_init_net(rc4030_dma_mr, rc4030, dp8393x_prom, is_big_endian);
 
     /* SCSI adapter */
     dev = qdev_new(TYPE_SYSBUS_ESP);
-- 
2.47.1


