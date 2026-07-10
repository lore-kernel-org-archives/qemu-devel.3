Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CE9EC44506
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 02:57:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi1Q1-0000OT-2w; Thu, 09 Jul 2026 22:56:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1Py-00005q-If
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:56:46 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1Pw-0008Qr-7o
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:56:46 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2cc61541f8cso21452565ad.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 19:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783652203; x=1784257003; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8QAN2nte0nuVZykE4Mh1vjJtfpYyCafG5jysBVWbgXY=;
 b=T10yJowv4bk2Va228Bvcil0nSuf1I29i6XrXQ+X0pyQcy+J2ipMr45nuCka30TV6v8
 lV82SNZhU9Jl7LofrhmTQiGjEQC/iBI9GILXH0OKyeVQQvnUNgLv5DgKRVDYAyw4qIQw
 2KEsKkD8Mul9kUqry7MMCLija5mxDXJrGD2CnJ+z6vsAwDgp4iuZT8CqnQdPXlJdAdiG
 6gqjDla6qUPZl7J0X2wBNHET08oiK/Q+vGtHNQy/FO4jfIYsNiLKx5nMcGVJ5pPAgnWw
 OHXALhYoHWVMLML4LqAdsUIq4bldOy07IBzcfhCDMhKQ+E/xe7UZobB79aS29ZR9g2aG
 r4/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783652203; x=1784257003;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8QAN2nte0nuVZykE4Mh1vjJtfpYyCafG5jysBVWbgXY=;
 b=V1PXxxreqTIzY1h2z/UL7h8/6H4jpOhZ17AUMCzhiXWu0AdeK/9PqmVdeJCDzKPTM/
 V2OEURMk+N+vrCQBTMrqzwKZwYREG3W0sGH40vwTyAnZGikfbG6AL092ZeVE1YeQBcGH
 Xg73cVel5/hhvCXzo9ew07x2o/yFrOhsCrjCPwceHczg49zl8Wa1Jxt6+QUoHO3Aa/+X
 kZxJyQutD8+twt/OoxbMLhPYFistCJ79hf0+j4vAa1KNt1vFGzoSzJoDvBHg7XcBAPe6
 D5kahPY1eSoKNXfpWRzithk1di3CqJwJKrFmwBslKgF6oGo6IlirtKTsobfwHvar90BV
 h8vw==
X-Gm-Message-State: AOJu0YxbRH0qCtrysz1h+ccDAlR2NnjDi0vFdr2LC7/4Ern8NdKsmggC
 OH2lfPFZU3X0CzolOzTKgsneE0rcGoQrIPgZOP/SyBPR5Tya0SzPtebK7n1sVg==
X-Gm-Gg: AfdE7cmBnTV6x8pOymPd7DPGRcFyPVlDscpy7A+MjsF7MxT61aa7pX5zQ3azK+bZlKZ
 L9A1ImfJWWm3EBJ/zFiEEDsS39Eekq7XvR6NdYota4ecck4RATsQVK3xbpnC+Brjg4kKap+TiCU
 OTTrtAzLlzEuoGAXKiprQnslpe1/T//Gmnm0dwyP+aPnyZkvLfy7D5/M4GjZt6aKXQ2gpzuGzfe
 93RQUxIjiwalxeqR9JlG/IrvZce9KTRl2fh6u/X/+5SlsHMpe2H7drxvk+pRwxBH1YjgUHw4yEJ
 5c9mBHB/V+LiCACEtuRkM8H7Qsne1JCS0t9xWDFOvzFZvrqDCIi1bRdMYHiTDu3Rb3qprPPxnQY
 gtiqteE/IW2lttdWWcLrQRvuhSpAvNYUCjt0FIMJKsk7eMYzwKfkfNNXXutLoFA8y+IGTwrM4nq
 YuMFZ1G2NYkyEgFgVdqPeYiP9qXcZXVkQ=
X-Received: by 2002:a05:6a20:d4c:b0:3b4:8c67:51d4 with SMTP id
 adf61e73a8af0-3c0f0c4bf32mr2073505637.39.1783652202918; 
 Thu, 09 Jul 2026 19:56:42 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca5af6e04fcsm4576769a12.4.2026.07.09.19.56.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 19:56:42 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 20/40] target/riscv: move riscv_cpu_claim_interrupts to cpu.c
Date: Fri, 10 Jul 2026 12:55:05 +1000
Message-ID: <20260710025525.1704417-21-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710025525.1704417-1-alistair.francis@wdc.com>
References: <20260710025525.1704417-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x634.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

The function is used by hw/intc/ files that KVM cares about like
riscv_aplic.c.  Move it to cpu.c to be accessible for --disable-tcg
builds.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260703180538.3346781-15-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c            | 14 ++++++++++++++
 target/riscv/tcg/cpu_helper.c | 11 -----------
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index fe24751379..2741047769 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -573,6 +573,20 @@ target_ulong riscv_new_csr_seed(target_ulong new_value,
     return rval;
 }
 
+#ifndef CONFIG_USER_ONLY
+/* Used by lots of folks in hw/intc */
+int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint64_t interrupts)
+{
+    CPURISCVState *env = &cpu->env;
+    if (env->miclaim & interrupts) {
+        return -1;
+    } else {
+        env->miclaim |= interrupts;
+        return 0;
+    }
+}
+#endif
+
 static ObjectClass *riscv_cpu_class_by_name(const char *cpu_model)
 {
     ObjectClass *oc;
diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index 250bb20481..aded995a7f 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -572,17 +572,6 @@ void riscv_cpu_set_rnmi(RISCVCPU *cpu, uint32_t irq, bool level)
     }
 }
 
-int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint64_t interrupts)
-{
-    CPURISCVState *env = &cpu->env;
-    if (env->miclaim & interrupts) {
-        return -1;
-    } else {
-        env->miclaim |= interrupts;
-        return 0;
-    }
-}
-
 void riscv_cpu_interrupt(CPURISCVState *env)
 {
     uint64_t gein, vsgein = 0, vstip = 0, irqf = 0;
-- 
2.54.0


