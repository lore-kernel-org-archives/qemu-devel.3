Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAFF8C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 11:09:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raw2M-0003Mr-SU; Fri, 16 Feb 2024 06:05:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raw2H-0002kS-D4
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 06:05:41 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raw2E-0001W3-4p
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 06:05:41 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-41211097adcso13376235e9.3
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 03:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708081536; x=1708686336; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F6ajeUmTQmKHExarjmIHQmgeLAwEfZL4L6fDKfFyi0M=;
 b=dWLtbfh1Gmr6bwIP2lCRTT6tGAslqKGAd5oAfkaSRPDMUCRyTqrHaOGoSpQq9ioStb
 Zo9NDQ0ilplfg58JEJ9G+W8gDEftqg10W9VITYfrbK25DD40K2bPSp3PxxMd9p2DOKTi
 5zzyWXTpXBDo1MpFRnNRLiAI6AsdvhnaB0qVUMV72LrQ28NhRKR5SUgjSeGkLxxapIxr
 YxbG+y8RZW2ny7sivB4uNUYLOwlcXnr17Sc56bQYA+7CZ/XpoUaaCl6KUsGo5DqdP1cf
 Um63Hnh9nc7+vBnal5rnbsWfAr0KlvwWm4PMTM/9dDoQHcRTCRn0h6tl++kZ50gXV8Kw
 yP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708081536; x=1708686336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F6ajeUmTQmKHExarjmIHQmgeLAwEfZL4L6fDKfFyi0M=;
 b=LCSpljAMvxZIgpStSfmAF7n0hTY/1uCiLWxuhGt8MAirGYQwO8GlepFg6+7Pimvqep
 I+Zmye2yUEOpoOglANa6VV1h5pDr+8dJF6xk0fK0fnJzxSECXpRsh+QwMiuw2QL1UugL
 WfNdyLZDAZd7dwov/RBrSuEdJBriCa1qiUNNlnIrtxqMcILwN/qG8UyppyEcXXEeBrmx
 pQmBLJQCUVWMb8EfATyMUQbdpZXFqKvDpF+KJAGVc6WyYfwBimeXSmpYUUCk4WWrGuLG
 1HQFn1X2F48CrnrN17aE769Fb+Zc75dIFPmzWO/CPaP46lg94skT9uvx+RvVrYqaVxHy
 XR8w==
X-Gm-Message-State: AOJu0YyWgYVbqyUAb9Roke0s9LtEc8PYhyC1xHGxqXw/5egr7okA57KS
 2K0FoKaineQv0UpSRRrmWtpMpdyjsGT9xQunNwDOr0490bOZJdGjqJk826UZ/We5uYWHifUZIdR
 p
X-Google-Smtp-Source: AGHT+IH7KB2yafp1Cdch5vIutGT7LSLUakLOWcYOmzNAq8g5xI+ojLUoPdGge2xdRTTfyXPRuNhppQ==
X-Received: by 2002:a1c:7918:0:b0:411:a802:700f with SMTP id
 l24-20020a1c7918000000b00411a802700fmr3604707wme.39.1708081536016; 
 Fri, 16 Feb 2024 03:05:36 -0800 (PST)
Received: from m1x-phil.lan ([176.187.210.246])
 by smtp.gmail.com with ESMTPSA id
 13-20020a05600c020d00b00410dd253008sm1927267wmi.42.2024.02.16.03.05.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 16 Feb 2024 03:05:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH 21/21] hw: Add QOM parentship relation with CPUs
Date: Fri, 16 Feb 2024 12:03:12 +0100
Message-ID: <20240216110313.17039-22-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240216110313.17039-1-philmd@linaro.org>
References: <20240216110313.17039-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

QDev objects created with object_new() need to manually add
their parent relationship with object_property_add_child().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/x86.c                            | 1 +
 hw/microblaze/petalogix_ml605_mmu.c      | 1 +
 hw/microblaze/petalogix_s3adsp1800_mmu.c | 1 +
 hw/mips/cps.c                            | 1 +
 hw/nios2/10m50_devboard.c                | 1 +
 hw/ppc/e500.c                            | 1 +
 hw/ppc/spapr.c                           | 1 +
 7 files changed, 7 insertions(+)

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 684dce90e9..7021419d91 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -102,6 +102,7 @@ void x86_cpu_new(X86MachineState *x86ms, int64_t apic_id, Error **errp)
     if (!object_property_set_uint(cpu, "apic-id", apic_id, errp)) {
         goto out;
     }
+    object_property_add_child(OBJECT(x86ms), "cpu[*]", OBJECT(cpu));
     qdev_realize(DEVICE(cpu), NULL, errp);
 
 out:
diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
index 0f5fabc32e..dfd881322d 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -83,6 +83,7 @@ petalogix_ml605_init(MachineState *machine)
 
     /* init CPUs */
     cpu = MICROBLAZE_CPU(object_new(TYPE_MICROBLAZE_CPU));
+    object_property_add_child(OBJECT(machine), "cpu", OBJECT(cpu));
     object_property_set_str(OBJECT(cpu), "version", "8.10.a", &error_abort);
     /* Use FPU but don't use floating point conversion and square
      * root instructions
diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
index dad46bd7f9..255d8d4d47 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -70,6 +70,7 @@ petalogix_s3adsp1800_init(MachineState *machine)
     MemoryRegion *sysmem = get_system_memory();
 
     cpu = MICROBLAZE_CPU(object_new(TYPE_MICROBLAZE_CPU));
+    object_property_add_child(OBJECT(machine), "cpu", OBJECT(cpu));
     object_property_set_str(OBJECT(cpu), "version", "7.10.d", &error_abort);
     qdev_realize(DEVICE(cpu), NULL, &error_abort);
 
diff --git a/hw/mips/cps.c b/hw/mips/cps.c
index 07b73b0a1f..6b4e918807 100644
--- a/hw/mips/cps.c
+++ b/hw/mips/cps.c
@@ -84,6 +84,7 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
         /* All cores use the same clock tree */
         qdev_connect_clock_in(DEVICE(cpu), "clk-in", s->clock);
 
+        object_property_add_child(OBJECT(dev), "cpu[*]", OBJECT(cpu));
         if (!qdev_realize_and_unref(DEVICE(cpu), NULL, errp)) {
             return;
         }
diff --git a/hw/nios2/10m50_devboard.c b/hw/nios2/10m50_devboard.c
index 6cb32f777b..f6a691d340 100644
--- a/hw/nios2/10m50_devboard.c
+++ b/hw/nios2/10m50_devboard.c
@@ -95,6 +95,7 @@ static void nios2_10m50_ghrd_init(MachineState *machine)
     cpu->exception_addr = 0xc8000120;
     cpu->fast_tlb_miss_addr = 0xc0000100;
 
+    object_property_add_child(OBJECT(machine), "cpu", OBJECT(cpu));
     qdev_realize_and_unref(DEVICE(cpu), NULL, &error_fatal);
 
     if (nms->vic) {
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 3bd12b54ab..77b7d2858c 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -956,6 +956,7 @@ void ppce500_init(MachineState *machine)
          */
         object_property_set_bool(OBJECT(cs), "start-powered-off", i != 0,
                                  &error_abort);
+        object_property_add_child(OBJECT(machine), "cpu[*]", OBJECT(cpu));
         qdev_realize_and_unref(DEVICE(cs), NULL, &error_fatal);
 
         if (!firstenv) {
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 0d72d286d8..b6e5caa0d2 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2715,6 +2715,7 @@ static void spapr_init_cpus(SpaprMachineState *spapr)
                                     &error_fatal);
             object_property_set_int(core, CPU_CORE_PROP_CORE_ID, core_id,
                                     &error_fatal);
+            object_property_add_child(OBJECT(spapr), "cpu[*]", OBJECT(core));
             qdev_realize(DEVICE(core), NULL, &error_fatal);
 
             object_unref(core);
-- 
2.41.0


