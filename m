Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFD88E7719F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 00:52:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX8eJ-0006pL-TU; Sun, 12 Jan 2025 19:49:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX8eB-0006Vj-Tt
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 19:49:42 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX8e9-0000wZ-PH
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 19:49:39 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43626213fffso29001235e9.1
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 16:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736729374; x=1737334174; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yiNeuarA8r14N/udmX2Ti0NAodknr96nxpHCBqLhgpc=;
 b=oBB/VBv/cwKnZb977hJWQgeiL46FgCsSfLzM47xNBQFF9pmubUeVhRSyRhTeRCUE6X
 zU0m+v0EadbAK/pCdVdmj4vVU+l/RphoDHkko9coRG0cG+F2Yqz8UGyWfV69kVd8whp1
 ZZiXyc3Z3afDFnbkkDNJ1QJM6CcVEx1jC0+L2J+8My/8l361Vd5j2pjiMZ1l78xRuphr
 YFxFW6U2VEFAz7CxyjSH+bKlZeerkqRsDjLy/0R4/mfpgeqODokrH9GT8xar2+L42ep+
 vFzbRq3TFgtmhHmkxHOi/wmeS8p0/7a8jilQsAGmtw4SuCDKJfdZtBN3q+5qfrq95jNf
 vFCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736729374; x=1737334174;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yiNeuarA8r14N/udmX2Ti0NAodknr96nxpHCBqLhgpc=;
 b=KI41Rtp9bJ3UnYOtn/vLULkvl1Hs4qXAoEMLwOGVgixBK4471wuMo8dOY9oHJh+OeM
 D//TUg6R9Mj9AYFZq3xJywGlBdUpTwZaexMQ7O7kvUVm+j4GHRtogvGAuFZwU2E+/XT4
 71fnpvFDZPgUlZ/gZn9z0o3OaGPaHfTlYkSqR7F7L85O4gPD3Ya8LBco/13nDOFr7DMN
 uv+WTXOHXvCzg+m4pJQNOTTKeh9HjgYV1b1IqVLvRpHCK9ouDYwpi/TqNfaIquPD7pYA
 UF6EXP3KCkAIlgM1ggFXdDGW4U191axS/STVybjavKslqEPdDsYeMqxNhW+HZsGcgRaL
 U0Ig==
X-Gm-Message-State: AOJu0Ywnh4WjEJ05SVMPig0xpAVqzstvkf4889tT2IMF0zQzKDCW92kW
 z2qnFF7eO77fgwhpecBywivhQsZBB8MENkp7iFlgBenl1PQokDZbFQNW8YHgq1v44XwCvx0LOyP
 Z3jo=
X-Gm-Gg: ASbGnctV06ff8XUXrwUZO1Xo42zYkHkW5QwpxqtykQt0GWxGJuGV+enQX7mVaVU1dqk
 QdmPR19TWdccDGdgnO9ogNy2bAQ4F3sYzCUq311k6hO/94lfqvzPpOCDTPuCCb7/GDO2jrnBEua
 qcd9CO2khArT84mHaJ1OQvq0J8l3BnOPTZ5F60EG211VllDDkAEcD0ZDLcNPIP07Nt/k9P+IoAl
 Hg+m3wzxkhv1VWBjrGP6ER6ENUzAMTYouCRgKDyeuYp6PoZhbrHJjfkX6YNG9bjNNO/j9+uonPU
 Km+wSTwRdGonkByiM/COvhQZoqZeQOQ=
X-Google-Smtp-Source: AGHT+IHA8IR3LQ1tBqXSVtFx9JkhYUFGnYDYV/gyu/GFpS2rFqxKITNQAviUsUUkeI1VhArzHwQGBw==
X-Received: by 2002:a05:600c:1c11:b0:436:76bf:51cc with SMTP id
 5b1f17b1804b1-436e8843d76mr111840665e9.12.1736729373805; 
 Sun, 12 Jan 2025 16:49:33 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9dc8802sm125761915e9.10.2025.01.12.16.49.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 16:49:32 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 Paul Burton <paulburton@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 18/23] hw/mips/boston: Propagate CPU to gen_firmware()
Date: Mon, 13 Jan 2025 01:47:43 +0100
Message-ID: <20250113004748.41658-19-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113004748.41658-1-philmd@linaro.org>
References: <20250113004748.41658-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

In boston_mach_init(), resolves the first CPU from the CPS
container using the QOM "cpu[0]" path. Propagate it to
gen_firmware(), removing the &first_cpu use.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/boston.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 09c4dfade12..f2c0e335e73 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -323,25 +323,26 @@ static void boston_register_types(void)
 }
 type_init(boston_register_types)
 
-static void gen_firmware(void *p, hwaddr kernel_entry, hwaddr fdt_addr)
+static void gen_firmware(const MIPSCPU *cpu, void *p,
+                         hwaddr kernel_entry, hwaddr fdt_addr)
 {
     uint64_t regaddr;
 
     /* Move CM GCRs */
     regaddr = cpu_mips_phys_to_kseg1(NULL, GCR_BASE_ADDR + GCR_BASE_OFS),
-    bl_gen_write_u64(MIPS_CPU(first_cpu), &p, regaddr,
+    bl_gen_write_u64(cpu, &p, regaddr,
                      boston_memmap[BOSTON_CM].base);
 
     /* Move & enable GIC GCRs */
     regaddr = cpu_mips_phys_to_kseg1(NULL, boston_memmap[BOSTON_CM].base
                                            + GCR_GIC_BASE_OFS),
-    bl_gen_write_u64(MIPS_CPU(first_cpu), &p, regaddr,
+    bl_gen_write_u64(cpu, &p, regaddr,
                      boston_memmap[BOSTON_GIC].base | GCR_GIC_BASE_GICEN_MSK);
 
     /* Move & enable CPC GCRs */
     regaddr = cpu_mips_phys_to_kseg1(NULL, boston_memmap[BOSTON_CM].base
                                            + GCR_CPC_BASE_OFS),
-    bl_gen_write_u64(MIPS_CPU(first_cpu), &p, regaddr,
+    bl_gen_write_u64(cpu, &p, regaddr,
                      boston_memmap[BOSTON_CPC].base | GCR_CPC_BASE_CPCEN_MSK);
 
     /*
@@ -352,7 +353,7 @@ static void gen_firmware(void *p, hwaddr kernel_entry, hwaddr fdt_addr)
      * a2/$6 = 0
      * a3/$7 = 0
      */
-    bl_gen_jump_kernel(MIPS_CPU(first_cpu), &p,
+    bl_gen_jump_kernel(cpu, &p,
                        true, 0, true, (int32_t)-2,
                        true, fdt_addr, true, 0, true, 0,
                        kernel_entry);
@@ -825,7 +826,9 @@ static void boston_mach_init(MachineState *machine)
             }
         }
 
-        gen_firmware(memory_region_get_ram_ptr(flash) + 0x7c00000,
+        gen_firmware(MIPS_CPU(object_resolve_path_component(OBJECT(&s->cps),
+                                                            "cpu[0]")),
+                     memory_region_get_ram_ptr(flash) + 0x7c00000,
                      s->kernel_entry, s->fdt_base);
     } else if (!qtest_enabled()) {
         error_report("Please provide either a -kernel or -bios argument");
-- 
2.47.1


