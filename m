Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A303C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 17:48:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4lOJ-00051b-8A; Wed, 08 May 2024 13:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4lO8-0004YE-HH
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:47:34 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4lO6-0000sL-71
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:47:32 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a59b178b75bso2868666b.0
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 10:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715190448; x=1715795248; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=npbkiNQNqy3L7L6w2vAeVZgTjq5H6cLzlHY7iLgQ/Nk=;
 b=Vf4MDnqiuD/OX7m1MgNqEBWtopf3rTQrC8DLgzqREzt7lytBWJ8SvwLGXBQwZHUzzC
 LB5gHaqCMuKIF/ZoEniSC0L5ULTJCzZ+njzS96uPsE2AttFdnCxNq/V/5LpBIX+bKUxX
 gEr4rXrLVRCE4TjO9CmlhOwIcCF6belCcD0dfUlJC73AmyCIUCsepVVrvtxwx3qSHxOG
 PyzM9f/7UrA27pMG7eBW9mndU/RhH2Uy1WbNlDu/YuRE+iEYOW7bY04KAOlOmdlONM5g
 0dPfGjnqRwP5wvxVKMhLNxNcHt4aKsQy52WsPLV7MO2Fp/noFTxCOrPCVdtnTMOZFvOt
 d4fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715190448; x=1715795248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=npbkiNQNqy3L7L6w2vAeVZgTjq5H6cLzlHY7iLgQ/Nk=;
 b=gBfd/IpDA+e7JURf/TqL32yPe9XimjApeEYoGxxUbyWwsYmsCPfxN4/YHQTS7qcv+I
 BBikx8RLUz7HWD4t0FTjLtMyO/ZgAeFgsPm8c92vxmeaTtGo/SVqXbli5YP/AdoB9OGK
 cP+WkUv+9YdOHYbx1Z0qCiJVINVtP18O+v6el6E3Lb1TFvXbr3rCIrPiXzoi1uZHrMAQ
 O41Q6hkn7tFVgZdlYZCMt29Q+nbX4ua8gb7AXLr11sb1Daur/Ekxal4wavGC24oBvUVJ
 hTHis4hvcYrjvhlgUVcEwAyElBBMhx6LDsR9EtIt4QJ/VY/hVI9OQC+Xl45Pw//gx83H
 bqPw==
X-Gm-Message-State: AOJu0Yz6DbSZK1PXhFXkkAnRvYCiCGivmDFCHPx7UkrYaM3zQRlp0JCA
 /8VXbdwjGDWfbevGgnJEx3ZnMUNk9gkwF7NEHfwLcCqd8FUOANCUcsS/Dio31VI2Y2DJeb4TV/O
 s
X-Google-Smtp-Source: AGHT+IF3DpTVscXY7U8ySR2YjONVZTu7ImXYo2+cylfDeCKTjh9lUq67qz+Q5a0+xlH2iKgnT26GuQ==
X-Received: by 2002:a17:907:60e:b0:a59:a431:a8ce with SMTP id
 a640c23a62f3a-a59fb94a3fdmr233568166b.2.1715190448072; 
 Wed, 08 May 2024 10:47:28 -0700 (PDT)
Received: from m1x-phil.lan (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 c3-20020a170906528300b00a4e5866448bsm7833784ejm.155.2024.05.08.10.47.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 May 2024 10:47:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 25/26] hw/intc/loongson_ipi: Implement IOCSR address space for
 MIPS
Date: Wed,  8 May 2024 19:45:09 +0200
Message-ID: <20240508174510.60470-26-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240508174510.60470-1-philmd@linaro.org>
References: <20240508174510.60470-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
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

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

Implement IOCSR address space get functions for MIPS/Loongson CPUs.

For MIPS/Loongson without IOCSR (i.e. Loongson-3A1000), get_cpu_iocsr_as
will return as null, and send_ipi_data will fail with MEMTX_DECODE_ERROR,
which matches expected behavior on hardware.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240508-loongson3-ipi-v1-3-1a7b67704664@flygoat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/intc/loongson_ipi.c | 39 ++++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/hw/intc/loongson_ipi.c b/hw/intc/loongson_ipi.c
index 8c888da3b2..93cc50a37a 100644
--- a/hw/intc/loongson_ipi.c
+++ b/hw/intc/loongson_ipi.c
@@ -15,7 +15,12 @@
 #include "qemu/log.h"
 #include "exec/address-spaces.h"
 #include "migration/vmstate.h"
+#ifdef TARGET_LOONGARCH64
 #include "target/loongarch/cpu.h"
+#endif
+#ifdef TARGET_MIPS
+#include "target/mips/cpu.h"
+#endif
 #include "trace.h"
 
 static MemTxResult loongson_ipi_readl(void *opaque, hwaddr addr,
@@ -56,18 +61,35 @@ static MemTxResult loongson_ipi_readl(void *opaque, hwaddr addr,
     return MEMTX_OK;
 }
 
-static void send_ipi_data(CPULoongArchState *env, uint64_t val, hwaddr addr,
+static AddressSpace *get_cpu_iocsr_as(CPUState *cpu)
+{
+#ifdef TARGET_LOONGARCH64
+    return LOONGARCH_CPU(cpu)->env.address_space_iocsr;
+#endif
+#ifdef TARGET_MIPS
+    if (ase_lcsr_available(&MIPS_CPU(cpu)->env)) {
+        return &MIPS_CPU(cpu)->env.iocsr.as;
+    }
+#endif
+    return NULL;
+}
+
+static MemTxResult send_ipi_data(CPUState *cpu, uint64_t val, hwaddr addr,
                           MemTxAttrs attrs)
 {
     int i, mask = 0, data = 0;
+    AddressSpace *iocsr_as = get_cpu_iocsr_as(cpu);
+
+    if (!iocsr_as) {
+        return MEMTX_DECODE_ERROR;
+    }
 
     /*
      * bit 27-30 is mask for byte writing,
      * if the mask is 0, we need not to do anything.
      */
     if ((val >> 27) & 0xf) {
-        data = address_space_ldl(env->address_space_iocsr, addr,
-                                 attrs, NULL);
+        data = address_space_ldl(iocsr_as, addr, attrs, NULL);
         for (i = 0; i < 4; i++) {
             /* get mask for byte writing */
             if (val & (0x1 << (27 + i))) {
@@ -78,8 +100,9 @@ static void send_ipi_data(CPULoongArchState *env, uint64_t val, hwaddr addr,
 
     data &= mask;
     data |= (val >> 32) & ~mask;
-    address_space_stl(env->address_space_iocsr, addr,
-                      data, attrs, NULL);
+    address_space_stl(iocsr_as, addr, data, attrs, NULL);
+
+    return MEMTX_OK;
 }
 
 static int archid_cmp(const void *a, const void *b)
@@ -130,8 +153,7 @@ static MemTxResult mail_send(uint64_t val, MemTxAttrs attrs)
     /* override requester_id */
     addr = SMP_IPI_MAILBOX + CORE_BUF_20 + (val & 0x1c);
     attrs.requester_id = cs->cpu_index;
-    send_ipi_data(&LOONGARCH_CPU(cs)->env, val, addr, attrs);
-    return MEMTX_OK;
+    return send_ipi_data(cs, val, addr, attrs);
 }
 
 static MemTxResult any_send(uint64_t val, MemTxAttrs attrs)
@@ -149,8 +171,7 @@ static MemTxResult any_send(uint64_t val, MemTxAttrs attrs)
     /* override requester_id */
     addr = val & 0xffff;
     attrs.requester_id = cs->cpu_index;
-    send_ipi_data(&LOONGARCH_CPU(cs)->env, val, addr, attrs);
-    return MEMTX_OK;
+    return send_ipi_data(cs, val, addr, attrs);
 }
 
 static MemTxResult loongson_ipi_writel(void *opaque, hwaddr addr, uint64_t val,
-- 
2.41.0


