Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54DC4C02183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 19:58:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXQXM-00060I-Nd; Mon, 13 Jan 2025 14:55:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXQXC-0005zM-W8
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 14:55:41 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXQXB-0007R8-HC
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 14:55:38 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3862d6d5765so2555624f8f.3
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 11:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736798133; x=1737402933; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e/OQZjDy+9AZ385RtNjGyKnjx3vgcN7yxotXGYLE1Pg=;
 b=M2Xs/ybAgMXrcGLjPrp3E0p6Pv/FQy2SvPmLDhKF1WIt/TtLw2Es6WqMzMUX8gLDoj
 P3kTes1f2zWunD2rxDcctgwI6kFq67CP31s5vX3AJwo7D3QOtdawuHWl44Es9AKtgrDU
 7ljj+VqBK6g/+WdAtR84aZBUf3sV2gcCzGnAZoe76KOAGFge1Z1jPLrYquH1GjM/LEX3
 QHu/BZdkcwmwXQx8uIzzsH74ft9TxcPeTv4RY1oOAwU8H1KU6Yv2esTRtfiOb9JVkH5F
 RCDfYGJYKnY4g2z4XlBd1/2sDZaaHlu9z80fQdVRrIXTwkhmi3Nk0dyy/E+DM2EZ6Hry
 X08g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736798133; x=1737402933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e/OQZjDy+9AZ385RtNjGyKnjx3vgcN7yxotXGYLE1Pg=;
 b=Auza0OPUlHKIaozoq2SAi+Ons1VuJEK0eczMABSXriWd59xJZHwb/U0hWbLuOd18Vt
 oHxB3bjbbZ+1fL9U9KYDizghU568q7xofdKuSwDMPKY7LEx5jX5G6D4uDgnTT7DksFjQ
 3LnQgDi/FZSLLylJb2AIVP1evxF+eheUd1WC4gBqDdV5pv9LCxhgvWesQA2U4f5NkeCC
 F06fF3aJ6ufE8n5KLQgnsY8Djf3HQRZcfarPab8CKxRIYH28LXMaDzffzk5dkpt8Mv/e
 1dpGre7wCPvAZA8WWe5fofyANW3dwBi7FWpp9Hq1DDcmoHuRazI84WyEE6gLDkSMBx2+
 3Rng==
X-Gm-Message-State: AOJu0YwgXmiMrP7goZAhYMx00NF1LaWCpjyvc8BYpmSIViPjNWtrD3aq
 jgEH7hkIN0ZZyIt6HBRAUglP/EQ9GWWpg93vr30WufDGAubjUTnP1qr/gx75dL10CJjFfFmtNGZ
 /PIE=
X-Gm-Gg: ASbGnctxin4J1zrbX+ZOwTuSSisYZbzrm/VcSXbF3fECzS7e3RfzOe1XWX/1AtoZNba
 B43kd9LQzulKW+/cYaRuCICxOVL1ocXRHuHl/A2nGFvctvItYcIKxdQPCj63vV6DKpibcKFJGfR
 2h26z2Ta419o0DymzZDqGkNWpDAM3LMHuyBpbqX4GsF7HBk8GyqdtS5U36gAzDqP0wo4dJpS6Qa
 b9rjhIWJyV7DJUSn9F9kilw7y8EZXw2BnUTV2B/sotxtAueqUUspqVUTgwg96JVo5OQEbOpviJ7
 cNczAM5XZf6RY7ECfwvLqXOnfdp46Q8=
X-Google-Smtp-Source: AGHT+IGf2jRHq2+qUSYG91bspjmFiix//DtVmpocHrVQFV+WcL9st176tARpaNkPTkAr1j7fyeeL2Q==
X-Received: by 2002:a5d:6da4:0:b0:385:de67:2269 with SMTP id
 ffacd0b85a97d-38a8730e04amr18285792f8f.36.1736798133101; 
 Mon, 13 Jan 2025 11:55:33 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2dc0babsm186910895e9.14.2025.01.13.11.55.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Jan 2025 11:55:32 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Burton <paulburton@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>
Subject: [PATCH v2 01/19] hw/mips/cps: Keep reference of vCPUs in MIPSCPSState
Date: Mon, 13 Jan 2025 20:55:07 +0100
Message-ID: <20250113195525.57150-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113195525.57150-1-philmd@linaro.org>
References: <20250113195525.57150-1-philmd@linaro.org>
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

When a QOM object create children with object_new(),
it is better to keep reference to them for further
use. In particular, this allow to remove one global
&first_cpu use.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/mips/cps.h | 1 +
 hw/mips/cps.c         | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/hw/mips/cps.h b/include/hw/mips/cps.h
index 05ef9f76b74..0968b57c5a0 100644
--- a/include/hw/mips/cps.h
+++ b/include/hw/mips/cps.h
@@ -40,6 +40,7 @@ struct MIPSCPSState {
     char *cpu_type;
     bool cpu_is_bigendian;
 
+    MIPSCPU **cpus;
     MemoryRegion container;
     MIPSGCRState gcr;
     MIPSGICState gic;
diff --git a/hw/mips/cps.c b/hw/mips/cps.c
index 293b405b965..494213b2ab6 100644
--- a/hw/mips/cps.c
+++ b/hw/mips/cps.c
@@ -73,6 +73,7 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    s->cpus = g_new(MIPSCPU *, s->num_vp);
     for (int i = 0; i < s->num_vp; i++) {
         MIPSCPU *cpu = MIPS_CPU(object_new(s->cpu_type));
         CPUMIPSState *env = &cpu->env;
@@ -91,6 +92,7 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
         if (!qdev_realize_and_unref(DEVICE(cpu), NULL, errp)) {
             return;
         }
+        s->cpus[i] = cpu;
 
         /* Init internal devices */
         cpu_mips_irq_init_cpu(cpu);
@@ -146,7 +148,7 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
                             sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->gic), 0));
 
     /* Global Configuration Registers */
-    gcr_base = MIPS_CPU(first_cpu)->env.CP0_CMGCRBase << 4;
+    gcr_base = s->cpus[0]->env.CP0_CMGCRBase << 4;
 
     object_initialize_child(OBJECT(dev), "gcr", &s->gcr, TYPE_MIPS_GCR);
     object_property_set_uint(OBJECT(&s->gcr), "num-vp", s->num_vp,
-- 
2.47.1


