Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84530CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 04:18:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBmk2-00018c-7v; Thu, 23 Oct 2025 00:15:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBmjy-00016E-Lt
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:15:56 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBmjw-0007OX-V6
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:15:54 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-780fc3b181aso245858b3a.2
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 21:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761192951; x=1761797751; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=otDqyi4KcGYYeSRiH0WBEkbvf1wg7FPRPexsVZjLPww=;
 b=M0AXmQaqjky8ZIkiFtNI0V9nXAspwFkItqmTVQ/SJrsQJ4NTviL/kGbOQU+mHqXjn5
 dpRCCq6n2GY2EneDfZN/TZ03UVOut5hI3bc3Y9uGtIuuQ+rtUiZGIdX0itm5vKRBGZyO
 53jaA0iWz0zv5QeaR3oRLqzi9GF3ZaDMsHBlSM4vQ9MV+/0t4lBKFcdiB4asIR+tHhQD
 OjpNqO26hFkkVVGf8Z6UR66x2590fuaMJCHD7khiReZgFycLDfvcF7FWgyz4DMvP+z5J
 x7tWhjRGTVo7LeZASoXPVfdM+MbMO3hQ8iTcSzfjmejBjgNRJy1OM9nxkvF5C8zQE7lF
 tSrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761192951; x=1761797751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=otDqyi4KcGYYeSRiH0WBEkbvf1wg7FPRPexsVZjLPww=;
 b=Q76iVEGdLeE/uyHOk0qzma00FKlEQAdHN9WJHtud9kOmZOh35jCoB4EopntEBtPUWv
 Jw64Bzt6sMUbyQgkTKPW988SZDE6j1xXTUXA8mU8Bus+OuiNJc/12aILjYWnhPPg5aMS
 4FFrWTFKIPjU76VCpTNDrFNABIzAB17361ewTejYMtcWcYNeSeHnQyZQSXTX3Qs63GKU
 KPBnO5lnZ2EYvAQ+CQ6KWZvBGgibQxsqAdObB8dI/e+ZZNlgCYu6WKbRCKpK8Zi0exIq
 9Ogq3A4JWP3QOeuhFek/Owf0SKBFt6ZhCa+28dkbUO5/p5iSTZx65zWKASn+ZqWFMvB4
 LHpA==
X-Gm-Message-State: AOJu0YzUMyExP7HXxQH16xnFsrDV9qsoAtUJeZBRh9WczUIaRtpTTGiV
 jzlqdR/hyUTV6Qq6DC0RFLAsNFzi/Q5BbHSRpQ0wWT8k7nugfxEjpkaCfEvYew==
X-Gm-Gg: ASbGnctDxftWq7b3vq7NQ+1YxDrXkBFS4z6K7FMTBW/mDsxprAd9t+DZGKHx531YWxd
 /LKOHkDD9ozEQcEpzETNmegZM4uu5P68Atya6Hy0rkZ7rc/Sn2quyIWyYnR0skpYweFi5pphYw2
 mkfMkDRPULborlV2zGjh2evLUS3gPsRHrwrm5TI2UkG1Ztiosc46NBOxr/T6zvu1Z3R3AQalxhZ
 y7Hj+nPnYf4d2vzGPzSQUVD5X/qAKhNl4ZMRwAZqy0fcOdnkkPw/MyUpC+ubkU0FQLG0vMeuDC2
 ABDZs5BCov2/2+JZX9f6jGwnlwvidAg5CsZxRw6E7M0KmBE4R8W9LeH6+axacZ6V7F5G/St/+vl
 o6QJOAdiH9buG69oM3RH8YOV74bP+XRxsllH/fVh12NlleEcIzxBMB4v3ZoedQVnJMhRIvAPuh+
 T1cYlFkYqvgUPglaa77/b2osBUKWgOIMhjRl6fk1Pnphw8D3ejGbbRyQDeD1GqXnMkAqE1WYVyb
 l9qYTjhYhhqu6p/GkGw
X-Google-Smtp-Source: AGHT+IHXh0KsLriCBQVWC8yvm7DXhhb7gzyNOeCDy3uoJYiJZKWBs0afISabFsQllz6Nt39YagSvkQ==
X-Received: by 2002:a05:6a00:1404:b0:770:fd32:f365 with SMTP id
 d2e1a72fcca58-7a274e595demr1402219b3a.25.1761192951249; 
 Wed, 22 Oct 2025 21:15:51 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a274abe5f0sm961640b3a.34.2025.10.22.21.15.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 21:15:50 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Chao-ying Fu <cfu@mips.com>,
 Djordje Todorovic <djordje.todorovic@htecgroup.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 19/37] hw/intc: Allow gaps in hartids for aclint and aplic
Date: Thu, 23 Oct 2025 14:14:17 +1000
Message-ID: <20251023041435.1775208-20-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023041435.1775208-1-alistair.francis@wdc.com>
References: <20251023041435.1775208-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>

This is needed for riscv based CPUs by MIPS since those may have
sparse hart-ID layouts. ACLINT and APLIC still assume a dense
range, and if a hart is missing, this causes NULL derefs.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20251018154522.745788-2-djordje.todorovic@htecgroup.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/intc/riscv_aclint.c | 18 ++++++++++++++++--
 hw/intc/riscv_aplic.c  | 13 ++++++++++---
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
index 9f4c36e965..c6f13f647e 100644
--- a/hw/intc/riscv_aclint.c
+++ b/hw/intc/riscv_aclint.c
@@ -297,7 +297,12 @@ static void riscv_aclint_mtimer_realize(DeviceState *dev, Error **errp)
     s->timecmp = g_new0(uint64_t, s->num_harts);
     /* Claim timer interrupt bits */
     for (i = 0; i < s->num_harts; i++) {
-        RISCVCPU *cpu = RISCV_CPU(cpu_by_arch_id(s->hartid_base + i));
+        CPUState *cpu_by_hartid = cpu_by_arch_id(s->hartid_base + i);
+        if (cpu_by_hartid == NULL) {
+            /* Valid for sparse hart layouts - skip this hart ID */
+            continue;
+        }
+        RISCVCPU *cpu = RISCV_CPU(cpu_by_hartid);
         if (riscv_cpu_claim_interrupts(cpu, MIP_MTIP) < 0) {
             error_report("MTIP already claimed");
             exit(1);
@@ -489,7 +494,12 @@ static void riscv_aclint_swi_realize(DeviceState *dev, Error **errp)
 
     /* Claim software interrupt bits */
     for (i = 0; i < swi->num_harts; i++) {
-        RISCVCPU *cpu = RISCV_CPU(qemu_get_cpu(swi->hartid_base + i));
+        CPUState *cpu_by_hartid = cpu_by_arch_id(swi->hartid_base + i);
+        if (cpu_by_hartid == NULL) {
+            /* Valid for sparse hart layouts - skip this hart ID */
+            continue;
+        }
+        RISCVCPU *cpu = RISCV_CPU(cpu_by_hartid);
         /* We don't claim mip.SSIP because it is writable by software */
         if (riscv_cpu_claim_interrupts(cpu, swi->sswi ? 0 : MIP_MSIP) < 0) {
             error_report("MSIP already claimed");
@@ -553,6 +563,10 @@ DeviceState *riscv_aclint_swi_create(hwaddr addr, uint32_t hartid_base,
 
     for (i = 0; i < num_harts; i++) {
         CPUState *cpu = cpu_by_arch_id(hartid_base + i);
+        if (cpu == NULL) {
+            /* Valid for sparse hart layouts - skip this hart ID */
+            continue;
+        }
         RISCVCPU *rvcpu = RISCV_CPU(cpu);
 
         qdev_connect_gpio_out(dev, i,
diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index 6dccca73af..a2041e7022 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -910,9 +910,12 @@ static void riscv_aplic_realize(DeviceState *dev, Error **errp)
         if (!aplic->msimode) {
             /* Claim the CPU interrupt to be triggered by this APLIC */
             for (i = 0; i < aplic->num_harts; i++) {
-                RISCVCPU *cpu;
-
-                cpu = RISCV_CPU(cpu_by_arch_id(aplic->hartid_base + i));
+                CPUState *temp = cpu_by_arch_id(aplic->hartid_base + i);
+                if (temp == NULL) {
+                    /* Valid for sparse hart layouts - skip this hart ID */
+                    continue;
+                }
+                RISCVCPU *cpu = RISCV_CPU(temp);
                 if (riscv_cpu_claim_interrupts(cpu,
                     (aplic->mmode) ? MIP_MEIP : MIP_SEIP) < 0) {
                     error_report("%s already claimed",
@@ -1095,6 +1098,10 @@ DeviceState *riscv_aplic_create(hwaddr addr, hwaddr size,
         if (!msimode) {
             for (i = 0; i < num_harts; i++) {
                 CPUState *cpu = cpu_by_arch_id(hartid_base + i);
+                if (cpu == NULL) {
+                    /* Valid for sparse hart layouts - skip this hart ID */
+                    continue;
+                }
 
                 qdev_connect_gpio_out_named(dev, NULL, i,
                                             qdev_get_gpio_in(DEVICE(cpu),
-- 
2.51.0


