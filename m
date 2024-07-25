Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32DE2C3DA70
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 23:48:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8Ac-0000vf-Mv; Thu, 25 Jul 2024 19:46:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sX8Aa-0000m8-7L
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 19:46:48 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sX8AX-0005OG-Uq
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 19:46:47 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-70d23caf8ddso378212b3a.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 16:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721951205; x=1722556005;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wy4f3pBGr8WQhxgyF2AP1zi0eDNpe0O/D4C+yvhRH7Q=;
 b=xKRTch5gGJVa5NuhOPaeNeBK9VWEiu6/BU/Kyqrq8GyTgzCOOZBmXawe4bpLdBHPF7
 eJhDSG27tQv6OCMT3ElQqZR9Y+2AuJOY10o4OV3hsG8LbTaX7Fa9u7jee/zMCg3q5czh
 u3GUgPQGwnaigscHnQdj+30aw4pDXobjBVucn09gmg2IKTxXzqrrHYwO3YsS/wO53HMp
 lbHzaNvxe6MUCn0QggUCHiYCCuL6SHPIxlHKwmK0J1MgJkBQwe7fHkZH+eCjmSgdKolq
 U7U59blavpQe3SGwPi+XS6H/LX0CAZybsqri+Nl7s2dEqStqfy17GwsZAXrZAJ/CRIML
 q8JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951205; x=1722556005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wy4f3pBGr8WQhxgyF2AP1zi0eDNpe0O/D4C+yvhRH7Q=;
 b=OwMZLmHknTYtiaw+MTH3eArZO2dosinxZVBrTCc6CeTFPF8UAtM2L792jlBpN8FTuo
 0OKhwUTs6y2Tph6i4BEt6IHPCs34QQPwyeVe1T1NwgdJOoHoShsTl4i5mHmDmURIoZ1c
 b9oMfXD+0YEIyPnJfkLNiYVDwW39NnYW+bqJdbusFSaWYQmMQVw3SnC450NqSk+Ky0Ak
 5R59nHetS3r/LekTVaOD0PRHyBmjFn0PkN7Ex8vPMShlglgwgN6YBYJwugJjHMDnGW9w
 IBIJf/LNJpyD9KcNHv8Q1w6YfCfTso/67cqzJEfndWkemKPpBI2yXt5v5JDfsKgbD1QH
 k6aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSJoMCDgfIRHQmEkG7iNlQB87yG2L5N4arkJmcoiOgfv+IKZaPBK8M9F4HrDFibCYV+CwdBuRZ6PoF+gQx12Sc9E4VSjE=
X-Gm-Message-State: AOJu0YwusBdk8IDSpz603yApXJxBwCK83EBxnW23DX+wRLmbQsOh+9eE
 mxQwdonoDOfHKYl2gRs4PggGEj2R72ua7j5DhJsjepbi5F80Ow1mX3+5c1Ryi7U=
X-Google-Smtp-Source: AGHT+IHbnbaPJYWuraVbzSGWArke8EI3kx7BS8Q4NKy8d3SiXcfWKEUrQzYpBFlC5hobXn8N+L9w0w==
X-Received: by 2002:a05:6a00:80a:b0:70c:f1fa:d7a3 with SMTP id
 d2e1a72fcca58-70eae8eb0cfmr4108411b3a.12.1721951204543; 
 Thu, 25 Jul 2024 16:46:44 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70ead8128d0sm1647565b3a.118.2024.07.25.16.46.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:46:44 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, jim.shu@sifive.com,
 andy.chiu@sifive.com, jesse.huang@sifive.com, kito.cheng@sifive.com
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH 16/24] target/riscv: shadow stack mmu index for shadow stack
 instructions
Date: Thu, 25 Jul 2024 16:46:05 -0700
Message-ID: <20240725234614.3850142-17-debug@rivosinc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240725234614.3850142-1-debug@rivosinc.com>
References: <20240725234614.3850142-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=debug@rivosinc.com; helo=mail-pf1-x42a.google.com
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

Shadow stack instructions shadow stack mmu index for load/stores.
`MMU_IDX_SS_ACCESS` at bit positon 3 is used as shadow stack index.
Shadow stack mmu index depend on privilege and SUM bit. If shadow stack
accesses happening in user mode, shadow stack mmu index = 0b1000. If
shaodw stack access happening in supervisor mode mmu index = 0b1001. If
shadow stack access happening in supervisor mode with SUM=1 then mmu
index = 0b1010

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 target/riscv/cpu.h                      | 13 +++++++++++++
 target/riscv/cpu_helper.c               |  3 +++
 target/riscv/insn_trans/trans_rva.c.inc |  8 ++++++++
 target/riscv/internals.h                |  1 +
 target/riscv/translate.c                | 25 +++++++++++++++++++++++++
 5 files changed, 50 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 0e0a9d2be1..82475490ab 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -614,6 +614,19 @@ FIELD(TB_FLAGS, AXL, 26, 2)
 FIELD(TB_FLAGS, FCFI_LP_EXPECTED, 28, 1)
 /* zicfiss needs a TB flag so that correct TB is located based on tb flags */
 FIELD(TB_FLAGS, BCFI_ENABLED, 29, 1)
+/*
+ * zicfiss shadow stack is special memory on which regular stores aren't
+ * allowed but shadow stack stores are allowed. Shadow stack stores can
+ * happen as `sspush` or `ssamoswap` instructions. `sspush` implicitly
+ * takes shadow stack address from CSR_SSP. But `ssamoswap` takes address
+ * from encoded input register and it will be used by supervisor software
+ * to access (read/write) user shadow stack for setting up rt_frame during
+ * signal delivery. Supervisor software will do so by setting SUM=1. Thus
+ * a TB flag is needed if SUM was 1 during TB generation to correctly
+ * reflect memory permissions to access shadow stack user memory from
+ * supervisor mode.
+ */
+FIELD(TB_FLAGS, SUM, 30, 1)
 
 #ifdef TARGET_RISCV32
 #define riscv_cpu_mxl(env)  ((void)(env), MXL_RV32)
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 7942587a56..b2bb1e4293 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -180,6 +180,9 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
     fs = EXT_STATUS_DIRTY;
     vs = EXT_STATUS_DIRTY;
 #else
+   flags = FIELD_DP32(flags, TB_FLAGS, SUM,
+                    ((env->mstatus & MSTATUS_SUM) == MSTATUS_SUM));
+
     flags = FIELD_DP32(flags, TB_FLAGS, PRIV, env->priv);
 
     flags |= riscv_env_mmu_index(env, 0);
diff --git a/target/riscv/insn_trans/trans_rva.c.inc b/target/riscv/insn_trans/trans_rva.c.inc
index db6c03f6a8..68b71339a3 100644
--- a/target/riscv/insn_trans/trans_rva.c.inc
+++ b/target/riscv/insn_trans/trans_rva.c.inc
@@ -132,6 +132,10 @@ static bool trans_ssamoswap_w(DisasContext *ctx, arg_amoswap_w *a)
 
     decode_save_opc(ctx);
     src1 = get_address(ctx, a->rs1, 0);
+#ifndef CONFIG_USER_ONLY
+    /* Shadow stack access and thus index is SS TLB index */
+    ss_mmu_idx = get_ss_index(ctx);
+#endif
 
     tcg_gen_atomic_xchg_tl(dest, src1, src2, ss_mmu_idx, (MO_ALIGN | MO_TESL));
     gen_set_gpr(ctx, a->rd, dest);
@@ -224,6 +228,10 @@ static bool trans_ssamoswap_d(DisasContext *ctx, arg_amoswap_w *a)
 
     decode_save_opc(ctx);
     src1 = get_address(ctx, a->rs1, 0);
+#ifndef CONFIG_USER_ONLY
+    /* Shadow stack access and thus index is SS TLB index */
+    ss_mmu_idx = get_ss_index(ctx);
+#endif
 
     tcg_gen_atomic_xchg_tl(dest, src1, src2, ss_mmu_idx, (MO_ALIGN | MO_TESQ));
     gen_set_gpr(ctx, a->rd, dest);
diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index dad0657c80..5147d6bf90 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -32,6 +32,7 @@
  *  - S+SUM+2STAGE      0b110
  *  - Shadow stack+U   0b1000
  *  - Shadow stack+S   0b1001
+ *  - Shadow stack+SUM 0b1010
  */
 #define MMUIdx_U            0
 #define MMUIdx_S            1
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 9152a963ee..ad0f841807 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -123,6 +123,8 @@ typedef struct DisasContext {
     bool fcfi_lp_expected;
     /* zicfiss extension, if shadow stack was enabled during TB gen */
     bool bcfi_enabled;
+    /* SUM was on during tb translation? */
+    bool sum;
 } DisasContext;
 
 static inline bool has_ext(DisasContext *ctx, uint32_t ext)
@@ -1128,6 +1130,29 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
     return translator_ldl(env, &ctx->base, pc);
 }
 
+#ifndef CONFIG_USER_ONLY
+static unsigned int get_ss_index(DisasContext *ctx)
+{
+    int ss_mmu_idx = MMU_IDX_SS_ACCESS;
+
+    /*
+     * If priv mode is S then a separate index for supervisor
+     * shadow stack accesses
+     */
+    if (ctx->priv == PRV_S) {
+        ss_mmu_idx |= MMUIdx_S;
+    }
+
+    /* If SUM was set, SS index should have S cleared */
+    if (ctx->sum) {
+        ss_mmu_idx &= ~(MMUIdx_S);
+        ss_mmu_idx |= MMUIdx_S_SUM;
+    }
+
+    return ss_mmu_idx;
+}
+#endif
+
 /* Include insn module translation function */
 #include "insn_trans/trans_rvi.c.inc"
 #include "insn_trans/trans_rvm.c.inc"
-- 
2.44.0


