Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64183D1CA01
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 21:54:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8515-000813-0T; Mon, 04 Nov 2024 16:53:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1t8512-0007z6-1L
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:53:40 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1t8510-00012d-9M
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:53:39 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43161e7bb25so36529515e9.2
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 13:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1730757216; x=1731362016;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rDpnK5746mg3pjW3oSgbbU+MRLj1bqe861uk/Dra88A=;
 b=LbX2Mx6w6/AV7OAnirsa0a8kPSYbSSyriitnFID+KWW8Eo3eLIO0xxfDdVYddngcVo
 9tMa7p/5eJUayXYmThpvbCl7bJE7T1VZ7d8FWOrfbLrwsQIwa+mtBRmvFO+vnGH9KH/7
 7TwvxwJvZ+DHk3bC3WmC7Ln0D38rhMWmWK8kEJ2mMvZOPiWlaV7/KhSKWBjwkD2+sL/K
 rfMXAjE74YVJynF9QLuCNIg3uF+iqz2e8Zf4RHmJOmTSq4t/J0GEusozg6KhecbE7R8F
 UQRTi5i7Y9Bn5U6uc4iABjaU9lr9NDnlU7rVwkvdOXHHe89YqgxExZPwlIr9FJC11Bii
 xZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730757216; x=1731362016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rDpnK5746mg3pjW3oSgbbU+MRLj1bqe861uk/Dra88A=;
 b=LRhf3r/B6ZbeOQq+9Lx6WOy3K1YnQKbgVxwreBtYlw6//JnjVe3CkycTp+AvIO3Zfm
 EWqnnh3dEqDoHDeXXjBeWU+CQIu3Mz2YoB5qxaixTdOe4KqGwzc6nMF1l2rFeFX7Rp6e
 9flAxqXsUKnwlu/RUoE/uFJCjejj8wUjmfqTog1iYZaFbcAT7gbsOBtMsaRmBYPlHw31
 uHOq5xgukRc5lLk1RVtsHHkE8g0OSeu6HN+3yPk8B0u1pLaPWKqrKFwsaQ65Fpg52boR
 MmXjteCmygoH03GpvPY39Kb4NeX0uKwW3BtqFVoi+lynRfgTkm3ql09eNE8GAHiUntI3
 MTbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmqqRsC/x/DyfYXy8JA/7xutoku09gjR737WU6T+Gcyq/dRFWFk53gn2k0TWKoeoc6X96Zyav95ztd@nongnu.org
X-Gm-Message-State: AOJu0Yx3weGnLCstKMsrRUn7BCqFLYji2Pkf+LxDQxJ/r1zUGh2kkIbe
 dvQtF55aY4mw5ikQcraAxOFqOBf3XXxpCKX7TajFGS+sKGobXZXXu6U1MNYpNaM=
X-Google-Smtp-Source: AGHT+IH/BSEqe5aKeYOZzd9yo/AGuOXcWgpygwDW/xhq7SsP0df/6CfnbK5wTDRUwKH/Z5G2Ne9htg==
X-Received: by 2002:a05:600c:a04:b0:42c:b80e:5e50 with SMTP id
 5b1f17b1804b1-431bb8a01dfmr199827505e9.0.1730757216637; 
 Mon, 04 Nov 2024 13:53:36 -0800 (PST)
Received: from rkanwal-XPS-15-9520.Home
 ([2a02:c7c:7527:ee00:8a3a:7719:aa26:21cb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432a26a6da1sm1537595e9.0.2024.11.04.13.53.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:53:36 -0800 (PST)
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Rajnesh Kanwal <rkanwal@rivosinc.com>
Cc: alistair.francis@wdc.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 atishp@rivosinc.com, apatel@ventanamicro.com, beeman@rivosinc.com,
 tech-control-transfer-records@lists.riscv.org, jason.chien@sifive.com,
 frank.chang@sifive.com
Subject: [PATCH v3 5/6] target/riscv: Add CTR sctrclr instruction.
Date: Mon,  4 Nov 2024 21:51:09 +0000
Message-Id: <20241104-b4-ctr_upstream_v3-v3-5-32fd3c48205f@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104-b4-ctr_upstream_v3-v3-0-32fd3c48205f@rivosinc.com>
References: <20241104-b4-ctr_upstream_v3-v3-0-32fd3c48205f@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=rkanwal@rivosinc.com; helo=mail-wm1-x333.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

CTR extension adds a new instruction sctrclr to quickly
clear the recorded entries buffer.

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
---
 target/riscv/cpu.h                             |  1 +
 target/riscv/cpu_helper.c                      |  7 +++++++
 target/riscv/helper.h                          |  1 +
 target/riscv/insn32.decode                     |  1 +
 target/riscv/insn_trans/trans_privileged.c.inc | 11 ++++++++++
 target/riscv/op_helper.c                       | 29 ++++++++++++++++++++++++++
 6 files changed, 50 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 189dba78970c414bff8aa252507c4585844bd846..21147e0d1d96e6dd6b15867bc5975772a9dd4858 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -614,6 +614,7 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv, bool virt_en);
 
 void riscv_ctr_add_entry(CPURISCVState *env, target_long src, target_long dst,
     enum CTRType type, target_ulong prev_priv, bool prev_virt);
+void riscv_ctr_clear(CPURISCVState *env);
 
 void riscv_translate_init(void);
 G_NORETURN void riscv_raise_exception(CPURISCVState *env,
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 06defc870cf85ed7c646ca6b066ce556bab1e757..9324a5da6ac6a4ebac0446f7c4b7090731fa1bec 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -703,6 +703,13 @@ static void riscv_ctr_freeze(CPURISCVState *env, uint64_t freeze_mask,
     }
 }
 
+void riscv_ctr_clear(CPURISCVState *env)
+{
+    memset(env->ctr_src, 0x0, sizeof(env->ctr_src));
+    memset(env->ctr_dst, 0x0, sizeof(env->ctr_dst));
+    memset(env->ctr_data, 0x0, sizeof(env->ctr_data));
+}
+
 static uint64_t riscv_ctr_priv_to_mask(target_ulong priv, bool virt)
 {
     switch (priv) {
diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index b8fb7c87348d1f850628ab3769afda08158739be..a3b2d875276c3a0a4706716a8650d23cca0ff693 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -131,6 +131,7 @@ DEF_HELPER_6(csrrw_i128, tl, env, int, tl, tl, tl, tl)
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_2(sret, tl, env, tl)
 DEF_HELPER_2(mret, tl, env, tl)
+DEF_HELPER_1(ctr_clear, void, env)
 DEF_HELPER_1(wfi, void, env)
 DEF_HELPER_1(wrs_nto, void, env)
 DEF_HELPER_1(tlb_flush, void, env)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 66353a66786a1e2482dc248b7a4c480b17884808..728e1e272f4a0831313b7fcb76014e7efdd900ac 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -114,6 +114,7 @@
 # *** Privileged Instructions ***
 ecall       000000000000     00000 000 00000 1110011
 ebreak      000000000001     00000 000 00000 1110011
+sctrclr     000100000100     00000 000 00000 1110011
 uret        0000000    00010 00000 000 00000 1110011
 sret        0001000    00010 00000 000 00000 1110011
 mret        0011000    00010 00000 000 00000 1110011
diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/riscv/insn_trans/trans_privileged.c.inc
index 339d65915173482507849ad36ff4eb3d1403c148..d16aa7139a24421ba7df94c5aab02103320343c9 100644
--- a/target/riscv/insn_trans/trans_privileged.c.inc
+++ b/target/riscv/insn_trans/trans_privileged.c.inc
@@ -69,6 +69,17 @@ static bool trans_ebreak(DisasContext *ctx, arg_ebreak *a)
     return true;
 }
 
+static bool trans_sctrclr(DisasContext *ctx, arg_sctrclr *a)
+{
+#ifndef CONFIG_USER_ONLY
+    if (ctx->cfg_ptr->ext_smctr || ctx->cfg_ptr->ext_ssctr) {
+        gen_helper_ctr_clear(tcg_env);
+        return true;
+    }
+#endif
+    return false;
+}
+
 static bool trans_uret(DisasContext *ctx, arg_uret *a)
 {
     return false;
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 5a1e92c45ed108d038ad30f5c7031b05855ac110..9b70d423092e5798af1eb2883b8fab8b025cf023 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -475,6 +475,35 @@ void helper_ctr_branch(CPURISCVState *env, target_ulong src, target_ulong dest,
     }
 }
 
+void helper_ctr_clear(CPURISCVState *env)
+{
+    /*
+     * It's safe to call smstateen_acc_ok() for umode access regardless of the
+     * state of bit 54 (CTR bit in case of m/hstateen) of sstateen. If the bit
+     * is zero, smstateen_acc_ok() will return the correct exception code and
+     * if it's one, smstateen_acc_ok() will return RISCV_EXCP_NONE. In that
+     * scenario the U-mode check below will handle that case.
+     */
+    RISCVException ret = smstateen_acc_ok(env, 0, SMSTATEEN0_CTR);
+    if (ret != RISCV_EXCP_NONE) {
+        riscv_raise_exception(env, ret, GETPC());
+    }
+
+    if (env->priv == PRV_U) {
+        /*
+         * One corner case is when sctrclr is executed from VU-mode and
+         * mstateen.CTR = 0, in which case we are supposed to raise
+         * RISCV_EXCP_ILLEGAL_INST. This case is already handled in
+         * smstateen_acc_ok().
+         */
+        uint32_t excep = env->virt_enabled ? RISCV_EXCP_VIRT_INSTRUCTION_FAULT :
+            RISCV_EXCP_ILLEGAL_INST;
+        riscv_raise_exception(env, excep, GETPC());
+    }
+
+    riscv_ctr_clear(env);
+}
+
 void helper_wfi(CPURISCVState *env)
 {
     CPUState *cs = env_cpu(env);

-- 
2.34.1


