Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8836FC02180
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 19:56:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXQXS-00060o-Pw; Mon, 13 Jan 2025 14:55:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXQXK-000603-Lc
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 14:55:46 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXQXI-0007Rw-RO
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 14:55:46 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-435f8f29f8aso33979495e9.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 11:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736798143; x=1737402943; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4iArtLIkc1Hfsjezw19sEsPpI58c9SSiC6oECSiSyLM=;
 b=BTAl5rs5dddox8HbzbNsW6dxLsbdyb14nJOsn6pnG4n7TOlxE/H/RHwV+R50IBTSnB
 aibzlw/01g/i50vpPowT5XC1vvfzDebERyn7OVFcLCtLWHVcqN3I38KdjiMF+11B9+s/
 l0yQRITGwdp+E/WS6GeNdZnN1SsluWUeEke0Z/SZCLgSmhSQxXhl9Tu/YV4X28n3+9m2
 a1IXNuvH9d6wrFgQMgizfFHirEPhGUk5IcqLVnJkyCBQhHii2nkdYwVpmcB9wiHxOnp7
 TpLr2qSXTiHHvDS1Vh+W5TOAPqVFt4OlgxW/hCSqa2CBpXMxsM6OZxrZmg4N42l9RYjF
 2QBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736798143; x=1737402943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4iArtLIkc1Hfsjezw19sEsPpI58c9SSiC6oECSiSyLM=;
 b=TuXBPe8HudzyN7x3Jff1e5pNuKeVtFC2hRg9r32Qy15iAGvBAXT484iM6oaiIuLWU4
 5RUss/6LHkXYNxjS/vrnu7YCBGhC1+P28cMR2O3QsYnElyajINMGFM9DHNU2lwXIPhfh
 cxN+BjnvU35PWOkabFo2wwREnrdZHhmqu12I2yENTcWek9VrYJvPLkT7M9WqAWowjw/x
 qXtCViRlm3xSbDKWUEcxWbyFaJBH6dkI12/xNafIMK3u6Mi8JHE5IqAkFDFuiMNxDInA
 9NFhAFZXiRqoSD/6aS7nL8CefZoNBNUVFE/OImVHoG3Y4zcavuMRoe2+CD/W6/1W8s8v
 13oA==
X-Gm-Message-State: AOJu0YwbawZm3DxpwKWiEOhVbDB6Kw2HG/52w7IQyO70n/Oc8KHF9i29
 V2tdl79so/MPaqzK2m81TChrvNDUOOV3cdoAeMnWKH9mE8LY1uL9e4qNd7WWw6VetaYxE3CqByQ
 xVCA=
X-Gm-Gg: ASbGncs3sLQim1lRhjTj2GGAVUjqyl7CzNttjL3HCbGnKX8styLSDJzbDtJfbxkgzdV
 vykNN9r6Cx7At0WXjPenZCTPMw9nIQOm0xhK+WvU9fsRtWJvfc+JxU1wQxGx2iMh73ulBDQtifS
 Es7PXCvzD07hEJVZ0UZnbGEp5MHigAdFOznAA8dDmnzBAAABZ9hv+kRaHhjYWIPyPD6256Rloy/
 ATuJ5WZlH2/eNqGQ+iJG+n2K+58p8H4Yjmk53bS7Vl1KmOtQ51sEF3SKKgZlSLw4CpS/68CBLBL
 icXOGhtjPJyJtg7nR5Z0mz/wXWlThjA=
X-Google-Smtp-Source: AGHT+IHZKJBjb7nOiH6wqiOVE0CezqHNC5ZtM4YGC+kr007UH/Qe691IOb4VmUnrUqMYPa+EKIz4HQ==
X-Received: by 2002:a05:600c:198c:b0:436:1b08:4c78 with SMTP id
 5b1f17b1804b1-436e26f5fddmr206528845e9.31.1736798143022; 
 Mon, 13 Jan 2025 11:55:43 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2df3610sm186513515e9.20.2025.01.13.11.55.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Jan 2025 11:55:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Burton <paulburton@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>
Subject: [PATCH v2 03/19] hw/mips/malta: Keep reference of vCPUs in MaltaState
Date: Mon, 13 Jan 2025 20:55:09 +0100
Message-ID: <20250113195525.57150-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113195525.57150-1-philmd@linaro.org>
References: <20250113195525.57150-1-philmd@linaro.org>
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

When a QOM object create children with object_new(),
it is better to keep reference to them for further
use. This will be helpful to remove &first_cpu uses
in few commits.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/malta.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index 37be2330eda..090c2514354 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -107,6 +107,7 @@ struct MaltaState {
     SysBusDevice parent_obj;
 
     Clock *cpuclk;
+    MIPSCPU **cpus;
     MIPSCPSState cps;
 };
 
@@ -1037,6 +1038,7 @@ static void create_cpu_without_cps(MachineState *ms, MaltaState *s,
     for (i = 0; i < ms->smp.cpus; i++) {
         cpu = mips_cpu_create_with_clock(ms->cpu_type, s->cpuclk,
                                          TARGET_BIG_ENDIAN);
+        s->cpus[i] = cpu;
 
         /* Init internal devices */
         cpu_mips_irq_init_cpu(cpu);
@@ -1063,6 +1065,7 @@ static void create_cps(MachineState *ms, MaltaState *s,
                             &error_fatal);
     qdev_connect_clock_in(DEVICE(&s->cps), "clk-in", s->cpuclk);
     sysbus_realize(SYS_BUS_DEVICE(&s->cps), &error_fatal);
+    memcpy(s->cpus, s->cps.cpus, ms->smp.cpus * sizeof(MIPSCPU *));
 
     sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->cps), 0, 0, 1);
 
@@ -1070,9 +1073,11 @@ static void create_cps(MachineState *ms, MaltaState *s,
     *cbus_irq = NULL;
 }
 
-static void mips_create_cpu(MachineState *ms, MaltaState *s,
-                            qemu_irq *cbus_irq, qemu_irq *i8259_irq)
+/* Initialize MaltaState::cpus[] */
+static void mips_create_cpus(MachineState *ms, MaltaState *s,
+                             qemu_irq *cbus_irq, qemu_irq *i8259_irq)
 {
+    s->cpus = g_new(MIPSCPU *, ms->smp.cpus);
     if ((ms->smp.cpus > 1) && cpu_type_supports_cps_smp(ms->cpu_type)) {
         create_cps(ms, s, cbus_irq, i8259_irq);
     } else {
@@ -1111,7 +1116,7 @@ void mips_malta_init(MachineState *machine)
     sysbus_realize_and_unref(SYS_BUS_DEVICE(s), &error_fatal);
 
     /* create CPU */
-    mips_create_cpu(machine, s, &cbus_irq, &i8259_irq);
+    mips_create_cpus(machine, s, &cbus_irq, &i8259_irq);
 
     /* allocate RAM */
     if (ram_size > 2 * GiB) {
-- 
2.47.1


