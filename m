Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 314FDC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 06:00:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYfN1-00087S-LJ; Fri, 17 Jan 2025 00:58:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfMb-0007kr-AV
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:57:54 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfMX-00065y-9I
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:57:48 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2163b0c09afso32084925ad.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 21:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737093463; x=1737698263; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PJ19PQmy4LCEjjWyg/YCbVrrw/y4TagiKur4hEqmvRc=;
 b=MBZX0r694+HeRwVbhjPW7MuiNMbIA9BMGEYbXOQngmJ2bidA65eB6MS5baypxeohJ7
 BvB8TLPxGga829LlJ+MbrwjqYzKQN+SEphwyAxRGPhfgcApSNqA8FjjbULT8Zyjn6xCw
 RlfNGACS5UNiSITLH97+1O36Hmcrafd7LtdBiO6JZZMbxyly+smsrcWFB2h3Qtr1XtB7
 XUF4g3dzpaLQIY6SDsMopsbnbNLe2fF/BuvuDJPHBwXTu5IA0Kx54guTII3aXLzJ//AF
 xSbToCzVV2v1hNUPijWKrUPgrWgFtgJiqiunt2tWc3vJMgGxZsLSPE+OepKs1L/U+5Sz
 7+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737093463; x=1737698263;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PJ19PQmy4LCEjjWyg/YCbVrrw/y4TagiKur4hEqmvRc=;
 b=xPwWwTQYWYsZ5DtVYQ7ERAD0stfnJtwvBK4+EgEk4qvs/miJm1yiLsIsQztPoyshdN
 XzqzAtr+A0giAhOxAbgH2gyuq/BNEgkWmlogMgZMnhElsSX11RJLJZ5Hq0xwc0Q02kM4
 TAu2CRd6JYXtZJd6+e5SjD/xLsvXC5Xa9wflpvIjbkSJ/Zyzg0KZlJ3ADGa7EnAZYDpr
 niOFitipjQavVaE9gkeUfgzxmgzS6qTTPFtIe+iocMFK3DdDKN3j938w4Z3I3NdXa791
 OeGeNKgEbsziNyYpgK2tM9Ku5Y9LpS4tmUC6uQ8MRvICwKC5/2zKO6d7DrHXvOE9oX8S
 HTNQ==
X-Gm-Message-State: AOJu0Yx8mjm6DrTr0G5Dc49V8Zr2KcFDQGOVKpOBqJaYXitL8RpbbLs/
 DUWGSoPFaJDsj+SJ0wEoXs9ARCQzBgAxmiHHwG97bCAze7TZuXbjoyDKZw==
X-Gm-Gg: ASbGncvVxPl5//cJ6x0XyQHI2hm18XNiWpIlKU3WAbG8zCrknJQC3VNVCZbY+zkLCtQ
 ZZ1XZhqEorHelUrb6Jvmjjh3fOBObaNI/KEPTEpaPAa3OjNIDIiV3tiPT2XfGRK25JLkmr/w4xl
 ScdJ1j2znuEagBbNi80QXAIBNat/zhxCMaEthzgAIzvv5jHQo0NkQbhNRMf9YXi7YfIQMPDLt+9
 tWohnxUuco2HkVJnOS8cEVv1L3dJzjuRm3XBNXUFJr8cishhojaYhPL5CDvf3imBpZEUM812A8l
 x3s5GAGEUiwn9D63akqFAK2CBxEGnOhNNPeSYzvZ4eS1BchnvmmqlatLeWji
X-Google-Smtp-Source: AGHT+IHJi45WSNURGjWU1t7Hbj5c4YwDHfLfl3KUhr49TLohbHtkA/XQZ4NwXM3SUUwa+o3QV+PQqw==
X-Received: by 2002:a17:903:2342:b0:215:cbbf:8926 with SMTP id
 d9443c01a7336-21c355b053fmr20990585ad.35.1737093463261; 
 Thu, 16 Jan 2025 21:57:43 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3d6fbbsm8563595ad.168.2025.01.16.21.57.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 21:57:42 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Atish Patra <atishp@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 30/50] target/riscv: Enable S*stateen bits for AIA
Date: Fri, 17 Jan 2025 15:55:32 +1000
Message-ID: <20250117055552.108376-31-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117055552.108376-1-alistair.francis@wdc.com>
References: <20250117055552.108376-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62a.google.com
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

From: Atish Patra <atishp@rivosinc.com>

As per the ratified AIA spec v1.0, three stateen bits control AIA CSR
access.

Bit 60 controls the indirect CSRs
Bit 59 controls the most AIA CSR state
Bit 58 controls the IMSIC state such as stopei and vstopei

Enable the corresponding bits in [m|h]stateen and enable corresponding
checks in the CSR accessor functions.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
Message-ID: <20250110-counter_delegation-v5-3-e83d797ae294@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 85 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 84 insertions(+), 1 deletion(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 123e9fd2bd..7f4348fe86 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -335,19 +335,42 @@ static RISCVException smode32(CPURISCVState *env, int csrno)
 
 static RISCVException aia_smode(CPURISCVState *env, int csrno)
 {
+    int ret;
+
     if (!riscv_cpu_cfg(env)->ext_ssaia) {
         return RISCV_EXCP_ILLEGAL_INST;
     }
 
+    if (csrno == CSR_STOPEI) {
+        ret = smstateen_acc_ok(env, 0, SMSTATEEN0_IMSIC);
+    } else {
+        ret = smstateen_acc_ok(env, 0, SMSTATEEN0_AIA);
+    }
+
+    if (ret != RISCV_EXCP_NONE) {
+        return ret;
+    }
+
     return smode(env, csrno);
 }
 
 static RISCVException aia_smode32(CPURISCVState *env, int csrno)
 {
+    int ret;
+
     if (!riscv_cpu_cfg(env)->ext_ssaia) {
         return RISCV_EXCP_ILLEGAL_INST;
     }
 
+    ret = smstateen_acc_ok(env, 0, SMSTATEEN0_AIA);
+    if (ret != RISCV_EXCP_NONE) {
+        return ret;
+    }
+
+    if (ret != RISCV_EXCP_NONE) {
+        return ret;
+    }
+
     return smode32(env, csrno);
 }
 
@@ -576,15 +599,38 @@ static RISCVException hgatp(CPURISCVState *env, int csrno)
 
 static RISCVException aia_hmode(CPURISCVState *env, int csrno)
 {
+    int ret;
+
     if (!riscv_cpu_cfg(env)->ext_ssaia) {
         return RISCV_EXCP_ILLEGAL_INST;
      }
 
-     return hmode(env, csrno);
+    if (csrno == CSR_VSTOPEI) {
+        ret = smstateen_acc_ok(env, 0, SMSTATEEN0_IMSIC);
+    } else {
+        ret = smstateen_acc_ok(env, 0, SMSTATEEN0_AIA);
+    }
+
+    if (ret != RISCV_EXCP_NONE) {
+        return ret;
+    }
+
+    return hmode(env, csrno);
 }
 
 static RISCVException aia_hmode32(CPURISCVState *env, int csrno)
 {
+    int ret;
+
+    if (!riscv_cpu_cfg(env)->ext_ssaia) {
+        return RISCV_EXCP_ILLEGAL_INST;
+     }
+
+    ret = smstateen_acc_ok(env, 0, SMSTATEEN0_AIA);
+    if (ret != RISCV_EXCP_NONE) {
+        return ret;
+    }
+
     if (!riscv_cpu_cfg(env)->ext_ssaia) {
         return RISCV_EXCP_ILLEGAL_INST;
     }
@@ -2033,6 +2079,12 @@ static RISCVException rmw_xiselect(CPURISCVState *env, int csrno,
                                    target_ulong wr_mask)
 {
     target_ulong *iselect;
+    int ret;
+
+    ret = smstateen_acc_ok(env, 0, SMSTATEEN0_SVSLCT);
+    if (ret != RISCV_EXCP_NONE) {
+        return ret;
+    }
 
     /* Translate CSR number for VS-mode */
     csrno = csrind_xlate_vs_csrno(env, csrno);
@@ -2203,6 +2255,11 @@ static RISCVException rmw_xireg(CPURISCVState *env, int csrno,
     int ret = -EINVAL;
     target_ulong isel;
 
+    ret = smstateen_acc_ok(env, 0, SMSTATEEN0_SVSLCT);
+    if (ret != RISCV_EXCP_NONE) {
+        return ret;
+    }
+
     /* Translate CSR number for VS-mode */
     csrno = csrind_xlate_vs_csrno(env, csrno);
 
@@ -2703,6 +2760,19 @@ static RISCVException write_mstateen0(CPURISCVState *env, int csrno,
         wr_mask |= SMSTATEEN0_P1P13;
     }
 
+    if (riscv_cpu_cfg(env)->ext_smaia) {
+        wr_mask |= SMSTATEEN0_SVSLCT;
+    }
+
+    /*
+     * As per the AIA specification, SMSTATEEN0_IMSIC is valid only if IMSIC is
+     * implemented. However, that information is with MachineState and we can't
+     * figure that out in csr.c. Just enable if Smaia is available.
+     */
+    if (riscv_cpu_cfg(env)->ext_smaia) {
+        wr_mask |= (SMSTATEEN0_AIA | SMSTATEEN0_IMSIC);
+    }
+
     return write_mstateen(env, csrno, wr_mask, new_val);
 }
 
@@ -2783,6 +2853,19 @@ static RISCVException write_hstateen0(CPURISCVState *env, int csrno,
         wr_mask |= SMSTATEEN0_FCSR;
     }
 
+    if (riscv_cpu_cfg(env)->ext_ssaia) {
+        wr_mask |= SMSTATEEN0_SVSLCT;
+    }
+
+    /*
+     * As per the AIA specification, SMSTATEEN0_IMSIC is valid only if IMSIC is
+     * implemented. However, that information is with MachineState and we can't
+     * figure that out in csr.c. Just enable if Ssaia is available.
+     */
+    if (riscv_cpu_cfg(env)->ext_ssaia) {
+        wr_mask |= (SMSTATEEN0_AIA | SMSTATEEN0_IMSIC);
+    }
+
     return write_hstateen(env, csrno, wr_mask, new_val);
 }
 
-- 
2.47.1


