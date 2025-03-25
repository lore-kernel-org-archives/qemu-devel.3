Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBBDFC36005
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 22:50:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txD0d-0002xI-AG; Tue, 25 Mar 2025 18:44:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1txD0K-0001lj-R3
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 18:44:16 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1txD0I-000756-Au
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 18:44:16 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-227d6b530d8so51673125ad.3
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 15:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742942652; x=1743547452; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=my/amCjVPulkTASqhfbzg7kjMYbxalxX57V5rEPDp7E=;
 b=cqWuDF+2YwWSWcnajvmr+G2JCtfnDSgAlP7t0wkOBtKkuJeW/PDHgGU4lzxk2DFzIq
 pFoeoHeH21UrovO/v6Ip9Uceg+rN6OIqzFbsL9y3x07+JzRK4Bkq83fXcR16hV743MKh
 aXrmwBo2B4eavTvFxXkAOJIuCQ3menhWlWHjsr2UhAnGSeC0955obO99S/AQum9qPc8E
 vtSTwBEl+NelcdcbrcFV1I03QWGtJNs5qiLR5Qbl0748z6mtbFDhzTRPJThqo8uR+0dz
 vcYe2rdWBnsHmnA23AmiGboZ0YdD+V40AsXx4pfgYXw5WU9Xzkwsu3MJpexs929IQqKp
 YHgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742942652; x=1743547452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=my/amCjVPulkTASqhfbzg7kjMYbxalxX57V5rEPDp7E=;
 b=RZGnqLJDmwkOM0SrHcPDAh+hf8gcbycdy1047wisSd7x6d1XmEckNBwi+1ufDLXi3s
 4/6IPDl7B0HJMTPxM4LsCsXQPhGMnNfxw84jV6nm0SEGr9beycUiK7aplLmnHu/XUWw2
 zeVTvVTYGVDUZP2oJ7bWmzxtD1JVD7gYaeSPOqXNIznNOIjKX777sQuUsdUaa7FupZPd
 C7eQkP1hbFWyk07uvLeM2Ssi9yOf/JTthNCdbgNVHtg+PlE/tnDasf9hWaxoNORVfU+G
 yPgC4CfLXRFmv5lIYM3QCoO32Gr4spctEW4h+ijXBZImVWekzeV6Z3Ot255/5F/6exHs
 P02w==
X-Gm-Message-State: AOJu0YyJY8ifupy6ZNfG9SYZhh5B5MaLFa0AsPRlaIZBqKDs8fV6pO4N
 n4JktylLCJAFDjt3Bj3jyqDDjTJ/JLg2SUEdYs4AqNfdUbDyHROu/9sWq8koKzoUUGUy4MMqQG9
 7
X-Gm-Gg: ASbGncvuNJNdt3dUh4SSDL/PDSf2T0USdcBB/aoJ32/5KSc/BziYK4KGX1dfkRhvPkl
 X+6list+Zas53OReo/MqIr4/9+b42k4iYJCRY9nTiOQ8uY1BkXaYFmnrpA+TT57PBYmMp3dUxrP
 pI3uoiRiFezv+HbBg4zY2ESiL+R4NhrzFgAYIVlln3H78vWRcsn105MoWC34rrrFJOQUkPXiADb
 MapReLOJ7o6eNciZUrTm1gCFCGdLlLP87rIZ/GyhfQ1EauvE0R4KTnQkAjo0nlz0Ubd073HHZfX
 Z2OKPFbpuXdK5u8BZVa1zZVQXiz0NKa8/dAsYz76DtdhHRzmAfeOjMWPHm/sUKNp/tPVOwF72Oo
 7M3BaeqpKOpA=
X-Google-Smtp-Source: AGHT+IEszGH0V/rAOIia344CQu0LmDGG4ehRgPGlgICY3wuExP5TSQdw9x22gU+E54/rb4XuSFp8TQ==
X-Received: by 2002:a05:6a20:7347:b0:1ee:e2ac:5159 with SMTP id
 adf61e73a8af0-1fe42f53152mr31245781637.19.1742942651963; 
 Tue, 25 Mar 2025 15:44:11 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7390611d3d6sm11111321b3a.94.2025.03.25.15.44.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Mar 2025 15:44:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mrolnik@gmail.com,
	philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 10/11] hw/avr: Prepare for TARGET_PAGE_SIZE > 256
Date: Tue, 25 Mar 2025 15:44:02 -0700
Message-ID: <20250325224403.4011975-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250325224403.4011975-1-richard.henderson@linaro.org>
References: <20250325224403.4011975-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

If i/o does not cover the entire first page, allocate a portion
of ram as an i/o device, so that the entire first page is i/o.

While memory_region_init_ram_device_ptr is happy to allocate
the RAMBlock, it does not register the ram for migration.
Do this by hand.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/avr/atmega.h |  1 +
 hw/avr/atmega.c | 39 ++++++++++++++++++++++++++++++++-------
 2 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/hw/avr/atmega.h b/hw/avr/atmega.h
index a99ee15c7e..9ac4678231 100644
--- a/hw/avr/atmega.h
+++ b/hw/avr/atmega.h
@@ -41,6 +41,7 @@ struct AtmegaMcuState {
     MemoryRegion flash;
     MemoryRegion eeprom;
     MemoryRegion sram;
+    MemoryRegion sram_io;
     DeviceState *io;
     AVRMaskState pwr[POWER_MAX];
     AVRUsartState usart[USART_MAX];
diff --git a/hw/avr/atmega.c b/hw/avr/atmega.c
index f6844bf118..11fab184de 100644
--- a/hw/avr/atmega.c
+++ b/hw/avr/atmega.c
@@ -19,6 +19,7 @@
 #include "hw/sysbus.h"
 #include "qom/object.h"
 #include "hw/misc/unimp.h"
+#include "migration/vmstate.h"
 #include "atmega.h"
 
 enum AtmegaPeripheral {
@@ -224,8 +225,6 @@ static void atmega_realize(DeviceState *dev, Error **errp)
     char *devname;
     size_t i;
 
-    assert(mc->io_size <= 0x200);
-
     if (!s->xtal_freq_hz) {
         error_setg(errp, "\"xtal-frequency-hz\" property must be provided.");
         return;
@@ -240,11 +239,37 @@ static void atmega_realize(DeviceState *dev, Error **errp)
     qdev_realize(DEVICE(&s->cpu), NULL, &error_abort);
     cpudev = DEVICE(&s->cpu);
 
-    /* SRAM */
-    memory_region_init_ram(&s->sram, OBJECT(dev), "sram", mc->sram_size,
-                           &error_abort);
-    memory_region_add_subregion(get_system_memory(),
-                                OFFSET_DATA + mc->io_size, &s->sram);
+    /*
+     * SRAM
+     *
+     * Softmmu is not able mix i/o and ram on the same page.
+     * Therefore in all cases, the first page exclusively contains i/o.
+     *
+     * If the MCU's i/o region matches the page size, then we can simply
+     * allocate all ram starting at the second page.  Otherwise, we must
+     * allocate some ram as i/o to complete the first page.
+     */
+    assert(mc->io_size == 0x100 || mc->io_size == 0x200);
+    if (mc->io_size >= TARGET_PAGE_SIZE) {
+        memory_region_init_ram(&s->sram, OBJECT(dev), "sram", mc->sram_size,
+                               &error_abort);
+        memory_region_add_subregion(get_system_memory(),
+                                    OFFSET_DATA + mc->io_size, &s->sram);
+    } else {
+        int sram_io_size = TARGET_PAGE_SIZE - mc->io_size;
+        void *sram_io_mem = g_malloc0(sram_io_size);
+
+        memory_region_init_ram_device_ptr(&s->sram_io, OBJECT(dev), "sram-as-io",
+                                          sram_io_size, sram_io_mem);
+        memory_region_add_subregion(get_system_memory(),
+                                    OFFSET_DATA + mc->io_size, &s->sram_io);
+        vmstate_register_ram(&s->sram_io, dev);
+
+        memory_region_init_ram(&s->sram, OBJECT(dev), "sram",
+                               mc->sram_size - sram_io_size, &error_abort);
+        memory_region_add_subregion(get_system_memory(),
+                                    OFFSET_DATA + TARGET_PAGE_SIZE, &s->sram);
+    }
 
     /* Flash */
     memory_region_init_rom(&s->flash, OBJECT(dev),
-- 
2.43.0


