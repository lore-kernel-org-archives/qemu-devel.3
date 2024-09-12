Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 969FDEE644B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 05:43:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1socR2-0007GL-Gg; Thu, 12 Sep 2024 01:32:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1socQg-0005Dd-5T
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:31:46 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1socQe-00038x-66
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:31:41 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-718e6299191so292203b3a.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 22:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726119098; x=1726723898; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1j2Ad7p2xrt5eoNNWaCw2vkgAgSrMVEmLQC+U7vNLW4=;
 b=bEG43uRSK7cAsysAvnDQd3o7UBOwl2Rhh2OG78GJWeCc5tFWf7eqoJIZou4tugG/E8
 SxSq+npEB4EllHLdoLAKkIidRTiX24frU4PrrrMcU38ZeNR47szcT128dHPX9yun+XpS
 BMH9FR7fIyCplZAN6wK+8HxdSnutSAgMuiZaVInBStjRvAPbpnEny0KCzVrXH3jiL73f
 ZJ6MVvOf0hFMn7kbdMH4eL/UI4aWCVueoSl/rlzPDkpVr+zoPyRKxyKZgaYgZ04ll3Sg
 tPSCAYZaS6qzJ1M3i8mCiVwzFGS3/uNtZzKKTzBoUWD4b0L/pvSxmvAMrf8++szJ46dI
 ZSVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726119098; x=1726723898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1j2Ad7p2xrt5eoNNWaCw2vkgAgSrMVEmLQC+U7vNLW4=;
 b=SuCWHSEkr2B/7AOZiV2LJ1ImMTRdar5823ngFJNug2JW9ryPYtaqJaZd1itsk89Zvq
 o9nVwcc8lEn3A09kw4ayq1qZtD0OmxtkaSuthqeKeeRHda6EXMLi8BxT+IvODIjmMeSh
 xHZPpZY1BssXrU9QwU0/jEAqLMuSEuQ0rUfz0lSVF0XxwXbftU03nt75wl3q1W3HwSvb
 kmhvcPoiciPGNd3y42IzTcxSQjWdhcYn+on2KFHoUlr/DkYC9G1nEuvYFEFVHAAH6TrY
 UiesJzFtcvR+3Bw0hIkgUagmaYkpzH+1hyqR7gLIptac1OAdGl2aSUQjvkFiJbbZf9wY
 F39A==
X-Gm-Message-State: AOJu0YxLAskttLW0cuYL53MS2qG/M9e9UZ383Hi5+NRuJJUNpJoPDKp3
 lzv4kHI1x6cj7V1OjKNEaIvdDr/Q5dRLbLxKk2EEd2gMx61eUpsRgg5M3A==
X-Google-Smtp-Source: AGHT+IHtgNVxIy7QkQG1DfSA+76sFMFlvDw4tmfxxnElxRH9GHWd/JbgYKXhdfx1QRjRN88iDe+5ug==
X-Received: by 2002:a05:6a00:2e11:b0:717:85a0:1ddb with SMTP id
 d2e1a72fcca58-7192606c443mr2937406b3a.10.1726119098438; 
 Wed, 11 Sep 2024 22:31:38 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fc8fdesm3833034b3a.1.2024.09.11.22.31.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 22:31:37 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Mark Corbin <mark@dibsco.co.uk>,
 Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 31/47] bsd-user: Define RISC-V register structures and register
 copying
Date: Thu, 12 Sep 2024 15:29:36 +1000
Message-ID: <20240912052953.2552501-32-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912052953.2552501-1-alistair.francis@wdc.com>
References: <20240912052953.2552501-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x433.google.com
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

From: Mark Corbin <mark@dibsco.co.uk>

Added definitions for RISC-V register structures, including
general-purpose registers and floating-point registers, in
'target_arch_reg.h'. Implemented the 'target_copy_regs' function to
copy register values from the CPU state to the target register
structure, ensuring proper endianness handling using 'tswapreg'.

Signed-off-by: Mark Corbin <mark@dibsco.co.uk>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240907031927.1908-7-itachis@FreeBSD.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
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
2.46.0


