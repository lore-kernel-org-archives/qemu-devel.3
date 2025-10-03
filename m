Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12177CAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 03:35:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4WTm-0007PH-4a; Thu, 02 Oct 2025 23:29:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4WTd-0007JX-0q
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 23:29:01 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4WTS-0001Ix-Jw
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 23:29:00 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-78af3fe5b17so1598966b3a.2
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 20:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759462123; x=1760066923; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pNKeCsU2F0IW0+Jf4l2B/lGuILSFPWkNAUsg1Jb21QM=;
 b=j/BQJlUSnAORQs7qsDK9H+CdZ2/BNAi63IokZm/BYUKzQCED+1PVNRgJFO8Oo+yKSd
 s2xCg5vaRywKvy+nmLB4OOe0GfC6JWa332SkiVrSjtiBez2BXgP1/YkEjhUOp0sAnhRF
 9WhElGZLc+UMz3kzI025Tjw/AniNw+vPcJfAZ/A7Zcu+PEajUsBDYp94+J1Fh3w6e1Hi
 c19OSZTI3yV6HpXU2FQgsCrR0fQd5+lr3ZLPn/CrRfDu9+XpC9lj2m7qCL6Vx8f+Dl9o
 g0kzMFzsfdUytX+oEND3czrXMk8RO6ikEdtmXAKEV+s3uwoCbfapfF8PQUbxOpRAQpXN
 3LtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759462123; x=1760066923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pNKeCsU2F0IW0+Jf4l2B/lGuILSFPWkNAUsg1Jb21QM=;
 b=CGWmE2jnqiUo3suSwoW1NQyGBQ4bKnuw1gqLqVK4tNXOx6M9Sk2ROTM2E1wotau9UE
 Pkvrjv/mowEiEXnq6Bx2pUkHo7DuhWbdMSzhk7sdF4cJtlVEHYQwdNkDhcqywUmOEa/g
 z0icomF/gP2ijYlzSLO5b0l8tBxK2afCqLGbrZ2HAzbYNXj7FV3LClD9jXqG70WCFT8m
 zWREHGiQmXV/VcnpbaacEW5nJXbFVaNzvJhFBTe7jcii4xD1TsouQkOEiKaaaoqAyPpf
 lwcecfRUaHXPk5MUr8Z530+tTKVeC4MbtdWa6iBrVO2h6aRb9lqP/mvScC1N7vt8b7+H
 5KMQ==
X-Gm-Message-State: AOJu0YxPzuz3PareIZk3HJp75TM8k15nxfNimLO9v6qA05/fA3nR8+uO
 xMwOz96mm5AUDoNrP70YW8OVHrBfyVa45QAwdkVgXfR3xerFqwT4JBJtETSaeA==
X-Gm-Gg: ASbGncsPJDz+Y7KIuPp658GuYs9Uaggu3TTHdYFP3l0u8AF1/L8nMV5JSvtliOmciZO
 IS/xtoZdH2y1MmWog/9SlEZ6Yj4XiNewR0+Ux9+Wk3kdfHPq7lGlGq66wPc2hgRg4HVABS3byyA
 JtQwwNj+JezuZXPVwra+eelhKR7fkHUnx/o1Mz9Rh8PSx4OT7jkcxKRLE0ZxRRPephWZw8H5am8
 aE1PtUZWI5lMXLTE8G61YfsVFs0WBPBFxn68Q7NR+UIGX4KQ6/3BaVJEjsHI/QfEhlOnbhf+9A0
 xB+8zexekdi/g5cBZb+5JjmnroIjajuJa7X7b8bhPJhSxn+oALP1wkcGZBEkpo7yci/Gw1VWQHl
 Gib4CABLD9pgQZJChqilkHdj2xG2hww4VRopFn3Tl5ant+0ISBMEDYgJgLID7ZYMAwD+0O/L01+
 rYG3NlDiX5xhvZ1Sw3wxBEV1k9GrI/oZWwx8jSmF9mduGVD5yB4jNc
X-Google-Smtp-Source: AGHT+IGr5Q0/EoqFq4ws9DbLExqFwxaAxo5TibecJjyWWwhWqwmEXuU5yHeQuFkbj5Zmogb/dmD47A==
X-Received: by 2002:a05:6a20:7287:b0:30b:2a99:4424 with SMTP id
 adf61e73a8af0-32b61e6efecmr2269597637.17.1759462123512; 
 Thu, 02 Oct 2025 20:28:43 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b62ce55205csm844202a12.18.2025.10.02.20.28.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 20:28:42 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Jim Shu <jim.shu@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 20/26] target/riscv: Fix ssamoswap error handling
Date: Fri,  3 Oct 2025 13:27:12 +1000
Message-ID: <20251003032718.1324734-21-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003032718.1324734-1-alistair.francis@wdc.com>
References: <20251003032718.1324734-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x430.google.com
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

From: Jim Shu <jim.shu@sifive.com>

Follow the RISC-V CFI v1.0 spec [1] to fix the exception type
when ssamoswap is disabled by xSSE.

[1] RISC-V CFI spec v1.0, ch2.7 Atomic Swap from a Shadow Stack Location

Signed-off-by: Jim Shu <jim.shu@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250924074818.230010-4-jim.shu@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/helper.h                         |  5 ++
 target/riscv/op_helper.c                      | 49 +++++++++++++++++++
 target/riscv/insn_trans/trans_rvzicfiss.c.inc |  8 +++
 3 files changed, 62 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index f712b1c368..c82bacdc39 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1284,3 +1284,8 @@ DEF_HELPER_4(vgmul_vv, void, ptr, ptr, env, i32)
 DEF_HELPER_5(vsm4k_vi, void, ptr, ptr, i32, env, i32)
 DEF_HELPER_4(vsm4r_vv, void, ptr, ptr, env, i32)
 DEF_HELPER_4(vsm4r_vs, void, ptr, ptr, env, i32)
+
+/* CFI (zicfiss) helpers */
+#ifndef CONFIG_USER_ONLY
+DEF_HELPER_1(ssamoswap_disabled, void, env)
+#endif
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 110292e84d..8382aa94cb 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -717,4 +717,53 @@ target_ulong helper_hyp_hlvx_wu(CPURISCVState *env, target_ulong addr)
     return cpu_ldl_code_mmu(env, addr, oi, ra);
 }
 
+void helper_ssamoswap_disabled(CPURISCVState *env)
+{
+    int exception = RISCV_EXCP_ILLEGAL_INST;
+
+    /*
+     * Here we follow the RISC-V CFI spec [1] to implement the exception type
+     * of ssamoswap* instruction.
+     *
+     * [1] RISC-V CFI spec v1.0, ch2.7 Atomic Swap from a Shadow Stack Location
+     *
+     * Note: We have already checked some conditions in trans_* functions:
+     *   1. The effective priv mode is not M-mode.
+     *   2. The xSSE specific to the effictive priv mode is disabled.
+     */
+    if (!get_field(env->menvcfg, MENVCFG_SSE)) {
+        /*
+         * Disabled M-mode SSE always trigger illegal instruction when
+         * current priv mode is not M-mode.
+         */
+        exception = RISCV_EXCP_ILLEGAL_INST;
+        goto done;
+    }
+
+    if (!riscv_has_ext(env, RVS)) {
+        /* S-mode is not implemented */
+        exception = RISCV_EXCP_ILLEGAL_INST;
+        goto done;
+    } else if (env->virt_enabled) {
+        /*
+         * VU/VS-mode with disabled xSSE will trigger the virtual instruction
+         * exception.
+         */
+        exception = RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
+        goto done;
+    } else {
+        /*
+         * U-mode with disabled S-mode SSE will trigger the illegal instruction
+         * exception.
+         *
+         * Note: S-mode is already handled in the disabled M-mode SSE case.
+         */
+        exception = RISCV_EXCP_ILLEGAL_INST;
+        goto done;
+    }
+
+done:
+    riscv_raise_exception(env, exception, GETPC());
+}
+
 #endif /* !CONFIG_USER_ONLY */
diff --git a/target/riscv/insn_trans/trans_rvzicfiss.c.inc b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
index 45686af4d6..f4a1c12ca0 100644
--- a/target/riscv/insn_trans/trans_rvzicfiss.c.inc
+++ b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
@@ -91,7 +91,11 @@ static bool trans_ssamoswap_w(DisasContext *ctx, arg_amoswap_w *a)
     }
 
     if (!ctx->bcfi_enabled) {
+#ifndef CONFIG_USER_ONLY
+        gen_helper_ssamoswap_disabled(tcg_env);
+#else
         return false;
+#endif
     }
 
     TCGv dest = dest_gpr(ctx, a->rd);
@@ -116,7 +120,11 @@ static bool trans_ssamoswap_d(DisasContext *ctx, arg_amoswap_w *a)
     }
 
     if (!ctx->bcfi_enabled) {
+#ifndef CONFIG_USER_ONLY
+        gen_helper_ssamoswap_disabled(tcg_env);
+#else
         return false;
+#endif
     }
 
     TCGv dest = dest_gpr(ctx, a->rd);
-- 
2.51.0


