Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D43CC02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 23:31:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYCq4-0006CB-3s; Wed, 15 Jan 2025 18:30:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYCpv-0005sl-8r
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:30:13 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYCpr-0004x7-T3
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:30:10 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3863703258fso939192f8f.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 15:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736983804; x=1737588604; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=642TEQtW37S8xYU3EVMOt0HBBzzyTYdBusCSNo5Ytkw=;
 b=jGwUn6j1zUqj7NzaVbQ1zjMgPVPAe/wY5+Js1C0HHm8/yL7HJsEff/kSgPh/6hTRN2
 X0V4ddH+2DRW245x2a4Q3lux6vpGI6LeTpBnJsS9Z4EV8/3Xi/y1pb23mU0R2vP3R9Q2
 eCxliXP+RSPr6JU2MljxYQrQ1ETOePrDCesn/KuwWw2rcf6rZB2gVuzdRTQHP+X4rTm0
 83TdZjkjsBxzHDWVznoQNecdIjXFuspcKjmc+mFyciVvRgwsNCP+0W9RsZncD2AVyQo6
 mVoPkeprh0C3X6L+tB9QyU7AzggbkSynhrWS1EuNc6VcNL/ENqA5RaYCeEQja8dwvP5K
 /oTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736983804; x=1737588604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=642TEQtW37S8xYU3EVMOt0HBBzzyTYdBusCSNo5Ytkw=;
 b=EDjDskIUpjQ8JVwvgpoHIYw5JJsjww/mWzDFuyWaHE7JAO1ddLICCONf+GQqbK7Tzj
 h7teqHQELUEtIGiTXBmpIk21YEVBmml894svH4SdgHSGBX8jBx+AELy0u31F4S3HwUkW
 w/hAc1pN9jgfWjOelDqclkgYEnPo9/zu2NHNNtUaOIB1fKhKYr4nfNxEDSXdYpO9/662
 noML3ahIZHm1mFy21+WbhoQLFPn/h+jHF1oDdLbsyY380x20nlWFKOhgP+lwpTD9RmaU
 YBGOqWJUdgBC8doSLS2fV3+i5zcaiL2aH3vdIMmpBWYVsD9mi0BZ9MXTBulY+OcVyJPr
 ZCpA==
X-Gm-Message-State: AOJu0YyhQWP3Tdg7plW5vGhh/63muj/Yz5CRngKCDhBNaOJSDk+zjLkV
 xBOUYEThR9Sopg9HEGsP7OL2tBXvuuyLlcyIUs5rmSr3GRH6FWhgV1Fw4kU35Pe2zp2VQeYLZml
 ys6w=
X-Gm-Gg: ASbGncsSBzba0ovHmrt5y90+32dvUx3xBh+IeH+Z6hj5ZjpcnURDeRIJAU9q3TeHhb8
 29vFlvRWJ5QYSr3jwamibNOmf75E1KTOExcvEWL+lwqop9tpCnnPpavfCGkUDygBLCnIX/UdK+W
 Dx02/b8mFT3vVq5REUzrKyfHP7Vsd2NSpUoDyxPgSeSYSHJL3SSOi8A1H1BwIZdVC229mkJPiib
 BZJgyjREf/TuHFvW07tN98scTGkWnyeCHO6M0DR2fh96XWPy29S/ww01r9wQsCrE0J2yLp10GL1
 /XTj4mp65dYU4hXtNMIEEm84p+2GD1g=
X-Google-Smtp-Source: AGHT+IG/0Brsn/U67VMP5gilyuaj4yYaOKu8K28jvEwce46XWJgRfEWtb9yIh/IZVE2UYcJTNCq0hA==
X-Received: by 2002:a5d:47c4:0:b0:38a:5dc4:6dcd with SMTP id
 ffacd0b85a97d-38bec5075ebmr426747f8f.22.1736983804123; 
 Wed, 15 Jan 2025 15:30:04 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e37d090sm18658080f8f.2.2025.01.15.15.30.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Jan 2025 15:30:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>
Subject: [PATCH v2 02/11] hw/mips/loongson3_virt: Invert vCPU creation order
 to remove &first_cpu
Date: Thu, 16 Jan 2025 00:29:42 +0100
Message-ID: <20250115232952.31166-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250115232952.31166-1-philmd@linaro.org>
References: <20250115232952.31166-1-philmd@linaro.org>
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

Create vCPUs from the last one to the first one.
No need to use the &first_cpu global since we already
have it referenced.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/loongson3_virt.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index 47d112981a2..488eba495cd 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -494,7 +494,6 @@ static void mips_loongson3_virt_init(MachineState *machine)
     long bios_size;
     MIPSCPU *cpu;
     Clock *cpuclk;
-    CPUMIPSState *env;
     DeviceState *liointc;
     DeviceState *ipi = NULL;
     char *filename;
@@ -569,7 +568,7 @@ static void mips_loongson3_virt_init(MachineState *machine)
     cpuclk = clock_new(OBJECT(machine), "cpu-refclk");
     clock_set_hz(cpuclk, DEF_LOONGSON3_FREQ);
 
-    for (i = 0; i < machine->smp.cpus; i++) {
+    for (i = machine->smp.cpus - 1; i >= 0; --i) {
         int node = i / LOONGSON3_CORE_PER_NODE;
         int core = i % LOONGSON3_CORE_PER_NODE;
         int ip;
@@ -609,7 +608,6 @@ static void mips_loongson3_virt_init(MachineState *machine)
                                pin, cpu->env.irq[ip + 2]);
         }
     }
-    env = &MIPS_CPU(first_cpu)->env;
 
     /* Allocate RAM/BIOS, 0x00000000~0x10000000 is alias of 0x80000000~0x90000000 */
     memory_region_init_rom(bios, NULL, "loongson3.bios",
@@ -640,7 +638,7 @@ static void mips_loongson3_virt_init(MachineState *machine)
         loaderparams.kernel_filename = kernel_filename;
         loaderparams.kernel_cmdline = kernel_cmdline;
         loaderparams.initrd_filename = initrd_filename;
-        loaderparams.kernel_entry = load_kernel(env);
+        loaderparams.kernel_entry = load_kernel(&cpu->env);
 
         init_boot_rom();
         init_boot_param();
-- 
2.47.1


