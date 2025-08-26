Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0D4CCA0FF2
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 16:21:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqwJI-0006nu-PW; Tue, 26 Aug 2025 12:14:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uqwIf-0005Aj-5M; Tue, 26 Aug 2025 12:13:34 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uqwIZ-00087n-Rl; Tue, 26 Aug 2025 12:13:32 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-b47174aec0eso3798540a12.2; 
 Tue, 26 Aug 2025 09:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756224804; x=1756829604; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CBer79r/Ls20vq775qKqmqtwb2WginyZp8XTg46/REM=;
 b=U2MHkiW1I6t11ox6kGe4s3cZAakUxtcUtm04+XsqC3VKU7LCEOEYQVwkw75UOrHHjH
 nA5pOlpgVS72BqzwQPBCDCAYheKZ/xysvSXSIfi/q22OM31IC6bX10c+AIWpNECetgXT
 YX9izeQrinUEBdC2M/r6naDzWpv8tiE6W4P7F1OM2dFEvZFELkHrVSlDSBdhkHhPOcS/
 pk4quwmqjO0SjVmTCHG+98bI054ngDEL0TyhZp+ab6y7ogF/nE2yAKXv1ihPa52swySe
 Eaa2f5oz5GGn5gzMFEvczlSagp2zj3+E3TmMt7S8dnJAncshrsQ8QczUYbIxz5pJ9l4U
 GT9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756224804; x=1756829604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CBer79r/Ls20vq775qKqmqtwb2WginyZp8XTg46/REM=;
 b=UQysFYHUKE6z/pNW9y2FkDrF/2MJbLaXecexYrxd5MT93q+kSa700Dt9PmbR0rz4l/
 7lcKSIfHBNw3hxM+p4K/lGm1hBgfR7jeYyhfsPmBjzp3FwXNMMJatXSLJIE2ogWOvkF/
 31iE1ks+hf1OXWs+tzcYkQbl+L652Guaa0PD7JGxRbHDph8Bj2HneTgY5PireL1Xz+5T
 Qk0FQTBM9ALQjqrcUPOleiA7p4RoEIRDMeqMrx23NZdLxGS3+LnQxZyjQpNwWVGNXgpS
 3qEI3BNioROgQB8LUQsQ37uGNb2ZeCI7HQCM2tdXoJIsd03/rROefDahK0tOwskvJCJ6
 MQfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXPMD4Ld8GOpVlpEvHZq8MnoP4Wm5y9GgE6PLm6L7gtMO/EG/9zEIuWztLtcVu5Up15s9VeLSZXINDEA==@nongnu.org,
 AJvYcCXYnsqStEb98uISlNF03aOFVrKZ9N+45HuhlPXIvLTY7wfHwoV9VP/Ucmrk4RRGdSk5a7aYi+SH/A==@nongnu.org
X-Gm-Message-State: AOJu0Yz/v4hYBkR+xblcg44D7560XmBXl4F63BTAL2lenII6m15m0QIp
 HWte6MX/h5kWjCDDA5AOHGWmMCj9MQ9nFIQ93STJzD2wsmnrNAA+tdIh4CQJDg==
X-Gm-Gg: ASbGncvLD9F7QxniW1VSPIxtGG/XELryWpbyxSPEVocgt1n3U/blzbkIRsvbaDS6CJY
 +kpPFrsD7q2UDAUA2gZieHJbmNmlOXePZpto0wJlsjTDCnXaqodM67A6ki9aG0IfxeevlwtKhEg
 VnV888YALFsEy7MXSYy2rHXAJvLro+1w5qahBgJq74+IpW0f56AoSzFyg3SLCRrl+qe3Ea5/n6f
 Uq03l5VpoH9BpbC7rGMVed3Gaonw/8tUipMQCwPszluLC2soGfD+ErC2enx8zdwVtPjV8N/tXHg
 GHZvWMRsf3lxLruxfFhjf4SEfD2ti7S9c+8oExsONQrUdBy80I3rNU7oCb1ZGZiCFWnW6HxsJGh
 RMeHgPyqZKTg+4qA5YZR4pOrP89XRBSuq
X-Google-Smtp-Source: AGHT+IEpdzFsDH/6SquqAJt+n0I4A28hQpTSU7a4onv2p5NiTy3wZqQLJuvaFNdME4jROxECnUVb/Q==
X-Received: by 2002:a17:90b:4f46:b0:312:ffdc:42b2 with SMTP id
 98e67ed59e1d1-32515ea1b15mr18629579a91.23.1756224803762; 
 Tue, 26 Aug 2025 09:13:23 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:561f:1400:11f5:714b])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-32750bc341asm1749747a91.19.2025.08.26.09.13.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 09:13:23 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 WANG Xuerui <git@xen0n.name>, Aurelien Jarno <aurelien@aurel32.net>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Stefan Weil <sw@weilnetz.de>,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, ktokunaga.mail@gmail.com
Subject: [PATCH v2 23/35] tcg/wasm: Add qemu_ld/qemu_st instructions
Date: Wed, 27 Aug 2025 01:10:28 +0900
Message-ID: <85196f153dd3d5c11c9b4701a4f56dc082348b31.1756216429.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756216429.git.ktokunaga.mail@gmail.com>
References: <cover.1756216429.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This commit adds qemu_ld and qemu_st by calling the helper functions
corresponding to MemOp.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm.c                |  70 ++++++++++++++++++
 tcg/wasm/tcg-target-has.h |   1 +
 tcg/wasm/tcg-target.c.inc | 145 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 216 insertions(+)

V2:
- This commit generates both Wasm and TCI instrucitons.

diff --git a/tcg/wasm.c b/tcg/wasm.c
index db0c213d92..793c1807c2 100644
--- a/tcg/wasm.c
+++ b/tcg/wasm.c
@@ -63,6 +63,14 @@ static void tci_args_ri(uint32_t insn, TCGReg *r0, tcg_target_ulong *i1)
     *i1 = sextract32(insn, 12, 20);
 }
 
+static void tci_args_rrm(uint32_t insn, TCGReg *r0,
+                         TCGReg *r1, MemOpIdx *m2)
+{
+    *r0 = extract32(insn, 8, 4);
+    *r1 = extract32(insn, 12, 4);
+    *m2 = extract32(insn, 16, 16);
+}
+
 static void tci_args_rrr(uint32_t insn, TCGReg *r0, TCGReg *r1, TCGReg *r2)
 {
     *r0 = extract32(insn, 8, 4);
@@ -190,6 +198,56 @@ static bool tci_compare64(uint64_t u0, uint64_t u1, TCGCond condition)
     return result;
 }
 
+static uint64_t tci_qemu_ld(CPUArchState *env, uint64_t taddr,
+                            MemOpIdx oi, const void *tb_ptr)
+{
+    MemOp mop = get_memop(oi);
+    uintptr_t ra = (uintptr_t)tb_ptr;
+
+    switch (mop & MO_SSIZE) {
+    case MO_UB:
+        return helper_ldub_mmu(env, taddr, oi, ra);
+    case MO_SB:
+        return helper_ldsb_mmu(env, taddr, oi, ra);
+    case MO_UW:
+        return helper_lduw_mmu(env, taddr, oi, ra);
+    case MO_SW:
+        return helper_ldsw_mmu(env, taddr, oi, ra);
+    case MO_UL:
+        return helper_ldul_mmu(env, taddr, oi, ra);
+    case MO_SL:
+        return helper_ldsl_mmu(env, taddr, oi, ra);
+    case MO_UQ:
+        return helper_ldq_mmu(env, taddr, oi, ra);
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void tci_qemu_st(CPUArchState *env, uint64_t taddr, uint64_t val,
+                        MemOpIdx oi, const void *tb_ptr)
+{
+    MemOp mop = get_memop(oi);
+    uintptr_t ra = (uintptr_t)tb_ptr;
+
+    switch (mop & MO_SIZE) {
+    case MO_UB:
+        helper_stb_mmu(env, taddr, val, oi, ra);
+        break;
+    case MO_UW:
+        helper_stw_mmu(env, taddr, val, oi, ra);
+        break;
+    case MO_UL:
+        helper_stl_mmu(env, taddr, val, oi, ra);
+        break;
+    case MO_UQ:
+        helper_stq_mmu(env, taddr, val, oi, ra);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static uintptr_t tcg_qemu_tb_exec_tci(CPUArchState *env, const void *v_tb_ptr)
 {
     const uint32_t *tb_ptr = v_tb_ptr;
@@ -208,6 +266,8 @@ static uintptr_t tcg_qemu_tb_exec_tci(CPUArchState *env, const void *v_tb_ptr)
         uint8_t pos, len;
         TCGCond condition;
         uint32_t tmp32;
+        uint64_t taddr;
+        MemOpIdx oi;
         int32_t ofs;
         void *ptr;
 
@@ -496,6 +556,16 @@ static uintptr_t tcg_qemu_tb_exec_tci(CPUArchState *env, const void *v_tb_ptr)
             }
             tb_ptr = ptr;
             break;
+        case INDEX_op_qemu_ld:
+            tci_args_rrm(insn, &r0, &r1, &oi);
+            taddr = regs[r1];
+            regs[r0] = tci_qemu_ld(env, taddr, oi, tb_ptr);
+            break;
+        case INDEX_op_qemu_st:
+            tci_args_rrm(insn, &r0, &r1, &oi);
+            taddr = regs[r1];
+            tci_qemu_st(env, taddr, regs[r0], oi, tb_ptr);
+            break;
         default:
             g_assert_not_reached();
         }
diff --git a/tcg/wasm/tcg-target-has.h b/tcg/wasm/tcg-target-has.h
index a29ceb2ea5..8fe9b45403 100644
--- a/tcg/wasm/tcg-target-has.h
+++ b/tcg/wasm/tcg-target-has.h
@@ -4,6 +4,7 @@
 
 #define TCG_TARGET_HAS_tst 0
 #define TCG_TARGET_HAS_extr_i64_i32 0
+#define TCG_TARGET_HAS_qemu_ldst_i128 0
 
 #define TCG_TARGET_extract_valid(type, ofs, len) 0
 #define TCG_TARGET_sextract_valid(type, ofs, len) \
diff --git a/tcg/wasm/tcg-target.c.inc b/tcg/wasm/tcg-target.c.inc
index 0606b7de79..e1ee2f6485 100644
--- a/tcg/wasm/tcg-target.c.inc
+++ b/tcg/wasm/tcg-target.c.inc
@@ -985,6 +985,99 @@ static void tcg_wasm_out_call(TCGContext *s, intptr_t func,
     gen_call(s, info, func_idx);
 }
 
+static void *qemu_ld_helper_ptr(uint32_t oi)
+{
+    MemOp mop = get_memop(oi);
+    switch (mop & MO_SSIZE) {
+    case MO_UB:
+        return helper_ldub_mmu;
+    case MO_SB:
+        return helper_ldsb_mmu;
+    case MO_UW:
+        return helper_lduw_mmu;
+    case MO_SW:
+        return helper_ldsw_mmu;
+    case MO_UL:
+        return helper_ldul_mmu;
+    case MO_SL:
+        return helper_ldsl_mmu;
+    case MO_UQ:
+        return helper_ldq_mmu;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void tcg_wasm_out_qemu_ld(TCGContext *s, TCGReg data_reg,
+                                 TCGReg addr_reg, MemOpIdx oi)
+{
+    intptr_t helper_idx;
+    int64_t func_idx;
+
+    helper_idx = (intptr_t)qemu_ld_helper_ptr(oi);
+    func_idx = get_helper_idx(s, helper_idx);
+    if (func_idx < 0) {
+        func_idx = register_helper(s, helper_idx);
+    }
+
+    /* call the target helper */
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(TCG_AREG0));
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(addr_reg));
+    tcg_wasm_out_op_const(s, OPC_I32_CONST, oi);
+    tcg_wasm_out_op_const(s, OPC_I64_CONST, (intptr_t)s->code_ptr);
+
+    tcg_wasm_out_op_idx(s, OPC_CALL, func_idx);
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(data_reg));
+}
+
+static void *qemu_st_helper_ptr(uint32_t oi)
+{
+    MemOp mop = get_memop(oi);
+    switch (mop & MO_SIZE) {
+    case MO_8:
+        return helper_stb_mmu;
+    case MO_16:
+        return helper_stw_mmu;
+    case MO_32:
+        return helper_stl_mmu;
+    case MO_64:
+        return helper_stq_mmu;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void tcg_wasm_out_qemu_st(TCGContext *s, TCGReg data_reg,
+                                 TCGReg addr_reg, MemOpIdx oi)
+{
+    intptr_t helper_idx;
+    int64_t func_idx;
+    MemOp mop = get_memop(oi);
+
+    helper_idx = (intptr_t)qemu_st_helper_ptr(oi);
+    func_idx = get_helper_idx(s, helper_idx);
+    if (func_idx < 0) {
+        func_idx = register_helper(s, helper_idx);
+    }
+
+    /* call the target helper */
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(TCG_AREG0));
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(addr_reg));
+    switch (mop & MO_SSIZE) {
+    case MO_UQ:
+        tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(data_reg));
+        break;
+    default:
+        tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(data_reg));
+        tcg_wasm_out_op(s, OPC_I32_WRAP_I64);
+        break;
+    }
+    tcg_wasm_out_op_const(s, OPC_I32_CONST, oi);
+    tcg_wasm_out_op_const(s, OPC_I64_CONST, (intptr_t)s->code_ptr);
+
+    tcg_wasm_out_op_idx(s, OPC_CALL, func_idx);
+}
+
 static void tcg_out_op_l(TCGContext *s, TCGOpcode op, TCGLabel *l0)
 {
     tcg_insn_unit_tci insn = 0;
@@ -1054,6 +1147,19 @@ static void tcg_out_op_rr(TCGContext *s, TCGOpcode op, TCGReg r0, TCGReg r1)
     tcg_out32(s, insn);
 }
 
+static void tcg_out_op_rrm(TCGContext *s, TCGOpcode op,
+                           TCGReg r0, TCGReg r1, TCGArg m2)
+{
+    tcg_insn_unit_tci insn = 0;
+
+    tcg_debug_assert(m2 == extract32(m2, 0, 16));
+    insn = deposit32(insn, 0, 8, op);
+    insn = deposit32(insn, 8, 4, r0);
+    insn = deposit32(insn, 12, 4, r1);
+    insn = deposit32(insn, 16, 16, m2);
+    tcg_out32(s, insn);
+}
+
 static void tcg_out_op_rrr(TCGContext *s, TCGOpcode op,
                            TCGReg r0, TCGReg r1, TCGReg r2)
 {
@@ -1786,6 +1892,45 @@ static void tcg_out_call(TCGContext *s, const tcg_insn_unit *func,
     tcg_wasm_out_call(s, (intptr_t)func, info);
 }
 
+static void tgen_qemu_ld(TCGContext *s, TCGType type, TCGReg data,
+                         TCGReg addr, MemOpIdx oi)
+{
+    tcg_out_op_rrm(s, INDEX_op_qemu_ld, data, addr, oi);
+    tcg_wasm_out_qemu_ld(s, data, addr, oi);
+}
+
+static const TCGOutOpQemuLdSt outop_qemu_ld = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_qemu_ld,
+};
+
+static void tgen_qemu_st(TCGContext *s, TCGType type, TCGReg data,
+                         TCGReg addr, MemOpIdx oi)
+{
+    tcg_out_op_rrm(s, INDEX_op_qemu_st, data, addr, oi);
+    tcg_wasm_out_qemu_st(s, data, addr, oi);
+}
+
+static const TCGOutOpQemuLdSt outop_qemu_st = {
+    .base.static_constraint = C_O0_I2(r, r),
+    .out = tgen_qemu_st,
+};
+
+bool tcg_target_has_memory_bswap(MemOp memop)
+{
+    return true;
+}
+
+static bool tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
+{
+    g_assert_not_reached();
+}
+
+static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
+{
+    g_assert_not_reached();
+}
+
 static void tcg_out_tb_start(TCGContext *s)
 {
     init_sub_buf();
-- 
2.43.0


