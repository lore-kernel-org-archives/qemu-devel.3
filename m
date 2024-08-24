Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93595C5472C
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2024 04:59:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shipq-0006oO-5Y; Sat, 24 Aug 2024 00:57:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1shipn-0006lg-Rs
 for qemu-devel@nongnu.org; Sat, 24 Aug 2024 00:57:07 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1shipm-0002Fq-3l
 for qemu-devel@nongnu.org; Sat, 24 Aug 2024 00:57:07 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7142a30e3bdso2670208b3a.0
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2024 21:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724475424; x=1725080224; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a+NCEiOZJzboz9w1INUibK6hoUbq+IVFPstbDaWXows=;
 b=delHw3fAlpp2BkL4WFwr3t9OnDndCEoPtu3e9N4+vv0yuWPxDAyFQVAuABk165gGGl
 CjMHm4HCcTWFuo8fR+LnI5IAHxWokRAjj1Zs9i1R7YpSlbyI9VnOOjRzzTjS9BhiAVwd
 apcJbYaUuW553rRFxqERkwzyoYBf26GI9xz6pbinzMG4FbVTetVgpzAxPpQzoRo/VRjh
 mWpiIDkTJh3qJl5cnvE6XozHz3PNixzD5+rcysUTI47D032xyGBlOHxTSPwvx1GSWAhj
 IcmP/392karpJbAu/IRQ/0IBLQ0KWiHl9Zck9ccZ3uJbkkdEspo6YaAco09xtp1oD+gf
 hwIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724475424; x=1725080224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a+NCEiOZJzboz9w1INUibK6hoUbq+IVFPstbDaWXows=;
 b=NbDX9YiCt03N1gI4gJ5wuC9MYb84jXCB+FlbzUo1kGPav5uEW+gufzlkSQBQVDMXjd
 But3s+NUycSeAgtbsiaDIbdLWDCzmBEifYDJZWKMkjOfGuSpiHqWtaE61CPHS09TBC4F
 WzO0fbIKClpMrGCYPM5TPx86Unf9phTw+ojIjsOUIRv9YyQWd9xavbAbXVcjjZP9MsDV
 OOnw4Jh+qAx6hXYzJBO17nWAqGliOr0cEIr/Y6z8s8eC2HOA7F9A4ZGu6lZYSlnemDGE
 0B+SCVpAv37Z02A3yi31G17dRTV7ji2UbczhdA5DJgj35SzhZXPIB1hTNF+i2BsPchBk
 5llg==
X-Gm-Message-State: AOJu0YxR5VKpr/WqcN8drCpVePlXfdWsvfCrATezEo4Z94PTxKYlhmqI
 4GvmuSXftOpuexQ4a3TzDJy6y6rAL4H7UzX5EwthDL8TEzlYmp+SZ4CH4sJNIoc=
X-Google-Smtp-Source: AGHT+IEV1x+3FxHtELDFDb+R93sm3yvxKWcAWHwrbgS+KZy6gHi4y+eFOG/jxfOfknD8UvmOIqWn/A==
X-Received: by 2002:aa7:8244:0:b0:710:d294:a2b with SMTP id
 d2e1a72fcca58-7143176773amr13918589b3a.8.1724475424246; 
 Fri, 23 Aug 2024 21:57:04 -0700 (PDT)
Received: from localhost.localdomain ([220.253.126.131])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7143422ecedsm3805934b3a.25.2024.08.23.21.57.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 21:57:03 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Mark Corbin <mark@dibsco.co.uk>,
 Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 06/17] bsd-user: Define RISC-V register structures and
 register copying
Date: Sat, 24 Aug 2024 14:56:24 +1000
Message-Id: <20240824045635.8978-7-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240824045635.8978-1-itachis@FreeBSD.org>
References: <20240824045635.8978-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=itachis6234@gmail.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Mark Corbin <mark@dibsco.co.uk>

Added definitions for RISC-V register structures, including
general-purpose registers and floating-point registers, in
'target_arch_reg.h'. Implemented the 'target_copy_regs' function to
copy register values from the CPU state to the target register
structure, ensuring proper endianness handling using 'tswapreg'.

Signed-off-by: Mark Corbin <mark@dibsco.co.uk>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/riscv/target_arch_reg.h | 88 ++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 bsd-user/riscv/target_arch_reg.h

diff --git a/bsd-user/riscv/target_arch_reg.h b/bsd-user/riscv/target_arch_reg.h
new file mode 100644
index 0000000000..12b1c96b61
--- /dev/null
+++ b/bsd-user/riscv/target_arch_reg.h
@@ -0,0 +1,88 @@
+/*
+ *  RISC-V register structures
+ *
+ *  Copyright (c) 2019 Mark Corbin
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef TARGET_ARCH_REG_H
+#define TARGET_ARCH_REG_H
+
+/* Compare with riscv/include/reg.h */
+typedef struct target_reg {
+    uint64_t ra;            /* return address */
+    uint64_t sp;            /* stack pointer */
+    uint64_t gp;            /* global pointer */
+    uint64_t tp;            /* thread pointer */
+    uint64_t t[7];          /* temporaries */
+    uint64_t s[12];         /* saved registers */
+    uint64_t a[8];          /* function arguments */
+    uint64_t sepc;          /* exception program counter */
+    uint64_t sstatus;       /* status register */
+} target_reg_t;
+
+typedef struct target_fpreg {
+    uint64_t        fp_x[32][2];    /* Floating point registers */
+    uint64_t        fp_fcsr;        /* Floating point control reg */
+} target_fpreg_t;
+
+#define tswapreg(ptr)   tswapal(ptr)
+
+/* Compare with struct trapframe in riscv/include/frame.h */
+static inline void target_copy_regs(target_reg_t *regs,
+                                    const CPURISCVState *env)
+{
+
+    regs->ra = tswapreg(env->gpr[1]);
+    regs->sp = tswapreg(env->gpr[2]);
+    regs->gp = tswapreg(env->gpr[3]);
+    regs->tp = tswapreg(env->gpr[4]);
+
+    regs->t[0] = tswapreg(env->gpr[5]);
+    regs->t[1] = tswapreg(env->gpr[6]);
+    regs->t[2] = tswapreg(env->gpr[7]);
+    regs->t[3] = tswapreg(env->gpr[28]);
+    regs->t[4] = tswapreg(env->gpr[29]);
+    regs->t[5] = tswapreg(env->gpr[30]);
+    regs->t[6] = tswapreg(env->gpr[31]);
+
+    regs->s[0] = tswapreg(env->gpr[8]);
+    regs->s[1] = tswapreg(env->gpr[9]);
+    regs->s[2] = tswapreg(env->gpr[18]);
+    regs->s[3] = tswapreg(env->gpr[19]);
+    regs->s[4] = tswapreg(env->gpr[20]);
+    regs->s[5] = tswapreg(env->gpr[21]);
+    regs->s[6] = tswapreg(env->gpr[22]);
+    regs->s[7] = tswapreg(env->gpr[23]);
+    regs->s[8] = tswapreg(env->gpr[24]);
+    regs->s[9] = tswapreg(env->gpr[25]);
+    regs->s[10] = tswapreg(env->gpr[26]);
+    regs->s[11] = tswapreg(env->gpr[27]);
+
+    regs->a[0] = tswapreg(env->gpr[10]);
+    regs->a[1] = tswapreg(env->gpr[11]);
+    regs->a[2] = tswapreg(env->gpr[12]);
+    regs->a[3] = tswapreg(env->gpr[13]);
+    regs->a[4] = tswapreg(env->gpr[14]);
+    regs->a[5] = tswapreg(env->gpr[15]);
+    regs->a[6] = tswapreg(env->gpr[16]);
+    regs->a[7] = tswapreg(env->gpr[17]);
+
+    regs->sepc = tswapreg(env->pc);
+}
+
+#undef tswapreg
+
+#endif /* TARGET_ARCH_REG_H */
-- 
2.34.1


