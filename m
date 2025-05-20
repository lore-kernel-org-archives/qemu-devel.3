Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB40FC3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 12:54:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHMSS-0000hL-An; Tue, 20 May 2025 08:52:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uHMSQ-0000fz-Og; Tue, 20 May 2025 08:52:34 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uHMSN-0000g8-Vp; Tue, 20 May 2025 08:52:34 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-30820167b47so4510967a91.0; 
 Tue, 20 May 2025 05:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747745547; x=1748350347; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YCCbP2uzO+MJ8NbcqqepaB7q1+AuafpCtigscHDquGQ=;
 b=IQGi1tifn3QhPTv/JIGKD0pYM3ppL4DvQDHPaLqlK0jq8VNwfQDq/s0BU+plW+IQVA
 t7fyc82jjZKUNWe+Juz1nhr+37CiJhTjeia1D7rtBrxTjcIY/BKZcC+76lsUO0dN5PPe
 uvwzwFvvj5XyHu5/vx896JNVC1Fr4zVLA20Wv4GByJEqT7FHFYljHHO2dBROc2rIBbGX
 /qSjh19Gs5/4cFAPYfTG17iL4fY99UILST93Fey8yADI0TIxX5cjR6zPH3/UstD+wQsx
 gjzblLpsSAkPDaHWF8BC7xtn5eN0o6eBL9WOZibHFDxh/b1eteV1dhhvMRQb/OCLHyX1
 oWaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747745547; x=1748350347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YCCbP2uzO+MJ8NbcqqepaB7q1+AuafpCtigscHDquGQ=;
 b=v6c2bXLgVX1t0zm35HFkS1ncD3Fhowh0+MbbL6I86pSYKjmjkhV5CUXaCxW54OH/zi
 6tpi/KEy8Kr53k7ujwTtD1RU30iZrHVAl/z5IdWpgl/GCFGBS0UX/ADv8s/wJ3DVA3/r
 v+swvm+x0MX7dTaveKvR5Ed8H32uAvMyj2ExNeefT4ceXIhUxhvsO0GlkClYFPPBgbfT
 IVmnhTzID8BZoIjKdB5XqdYHr+b1snxyitlz0zS839kMsxuyqe4ZMUb4+PFL9kOh5Vwu
 aezfYAvjOqiawDtrxcYVWzk170K1kFpU7Npt2DqoMfFdrLbqnaKVTXex8JETk0d0qXsl
 yQEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVw4xUqM2kFwUbheN6e/TPBC1qthK8UB2XjhQBcLjp8KF790+i5HGmpnT3qiOe0Bg7w6hB3dLuNMTgVgg==@nongnu.org,
 AJvYcCW9Q3Nn2u5apX2EKeV5zaxEspGLCaKvOx6hM8PtSrU2yUCVAdOxwHZKbN70KgGa3T8WpMdhMXSWBA==@nongnu.org
X-Gm-Message-State: AOJu0Yy1U2waPBo/EbRKsGmT0GfgOuEMD/P8LEjRq18dAvhRZaJ7z1a4
 oyLJ826bVhQG/OZJ9fgUMNjYrge0NZFDjLmY7ZYkFdrYrHsLl5M5YwEwroxY20Eo
X-Gm-Gg: ASbGncvI34Ipbn0fisJZnW7gncMcxUdFFMX5IeQPK0AUBWTWiVGVX3i3u7X5mHr/l0C
 blGyYchwzqwhQa/IgjKTezM8W0bCcOEWBhUVFxQ8QE1Ysy3kqV2ijZ8sM85WlFV2PBz/iVecHM+
 EncnzWlGwKZtKPYjp5rFjk8NkCZkODjibmO9Jl8lPU0Guj4a9WLa7Jz+N6JQVLpwWeWdClzlS3+
 r9/ggBgWVjZwBDdfVS0RYdI8l5n9XB7Kh7K9y0zv0UPI1hxHVQgCEmCoUvvTa3qS5N0kB9eMKEx
 nqEEviulfFwP8eTBYmt+p4+Z+GsH84u0nC0/RGI+YZBVoH4Gd7c=
X-Google-Smtp-Source: AGHT+IEjBag9dXZJu+xHTsTGS7j8HoI7T587dh1AvKbVfugRzu2h05FUzil69GsAslX9TWOh2Ke26Q==
X-Received: by 2002:a17:90a:e7c2:b0:30e:8e0f:9bfc with SMTP id
 98e67ed59e1d1-30e8e0f9f15mr21819390a91.13.1747745547437; 
 Tue, 20 May 2025 05:52:27 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:1bde:8310:e993:5dcc])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30f36364f9asm1625916a91.4.2025.05.20.05.52.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 05:52:26 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 WANG Xuerui <git@xen0n.name>, Aurelien Jarno <aurelien@aurel32.net>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Stefan Weil <sw@weilnetz.de>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 02/33] tcg/wasm32: Do not use TCI disassembler in Wasm backend
Date: Tue, 20 May 2025 21:51:04 +0900
Message-ID: <ab67d558ed437ae7bbeb00721aca1e1aa1260c61.1747744132.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1747744132.git.ktokunaga.mail@gmail.com>
References: <cover.1747744132.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pj1-x1031.google.com
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

Wasm backend should implement its own disassember for Wasm
instructions.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm32.c | 243 +--------------------------------------------------
 1 file changed, 1 insertion(+), 242 deletions(-)

diff --git a/tcg/wasm32.c b/tcg/wasm32.c
index 6de9b26b76..4bc53d76d0 100644
--- a/tcg/wasm32.c
+++ b/tcg/wasm32.c
@@ -831,246 +831,5 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
 }
 
 /*
- * Disassembler that matches the interpreter
+ * TODO: Disassembler is not implemented
  */
-
-static const char *str_r(TCGReg r)
-{
-    static const char regs[TCG_TARGET_NB_REGS][4] = {
-        "r0", "r1", "r2",  "r3",  "r4",  "r5",  "r6",  "r7",
-        "r8", "r9", "r10", "r11", "r12", "r13", "env", "sp"
-    };
-
-    QEMU_BUILD_BUG_ON(TCG_AREG0 != TCG_REG_R14);
-    QEMU_BUILD_BUG_ON(TCG_REG_CALL_STACK != TCG_REG_R15);
-
-    assert((unsigned)r < TCG_TARGET_NB_REGS);
-    return regs[r];
-}
-
-static const char *str_c(TCGCond c)
-{
-    static const char cond[16][8] = {
-        [TCG_COND_NEVER] = "never",
-        [TCG_COND_ALWAYS] = "always",
-        [TCG_COND_EQ] = "eq",
-        [TCG_COND_NE] = "ne",
-        [TCG_COND_LT] = "lt",
-        [TCG_COND_GE] = "ge",
-        [TCG_COND_LE] = "le",
-        [TCG_COND_GT] = "gt",
-        [TCG_COND_LTU] = "ltu",
-        [TCG_COND_GEU] = "geu",
-        [TCG_COND_LEU] = "leu",
-        [TCG_COND_GTU] = "gtu",
-        [TCG_COND_TSTEQ] = "tsteq",
-        [TCG_COND_TSTNE] = "tstne",
-    };
-
-    assert((unsigned)c < ARRAY_SIZE(cond));
-    assert(cond[c][0] != 0);
-    return cond[c];
-}
-
-/* Disassemble TCI bytecode. */
-int print_insn_tci(bfd_vma addr, disassemble_info *info)
-{
-    const uint32_t *tb_ptr = (const void *)(uintptr_t)addr;
-    const TCGOpDef *def;
-    const char *op_name;
-    uint32_t insn;
-    TCGOpcode op;
-    TCGReg r0, r1, r2, r3, r4;
-    tcg_target_ulong i1;
-    int32_t s2;
-    TCGCond c;
-    MemOpIdx oi;
-    uint8_t pos, len;
-    void *ptr;
-
-    /* TCI is always the host, so we don't need to load indirect. */
-    insn = *tb_ptr++;
-
-    info->fprintf_func(info->stream, "%08x  ", insn);
-
-    op = extract32(insn, 0, 8);
-    def = &tcg_op_defs[op];
-    op_name = def->name;
-
-    switch (op) {
-    case INDEX_op_br:
-    case INDEX_op_exit_tb:
-    case INDEX_op_goto_tb:
-        tci_args_l(insn, tb_ptr, &ptr);
-        info->fprintf_func(info->stream, "%-12s  %p", op_name, ptr);
-        break;
-
-    case INDEX_op_goto_ptr:
-        tci_args_r(insn, &r0);
-        info->fprintf_func(info->stream, "%-12s  %s", op_name, str_r(r0));
-        break;
-
-    case INDEX_op_call:
-        tci_args_nl(insn, tb_ptr, &len, &ptr);
-        info->fprintf_func(info->stream, "%-12s  %d, %p", op_name, len, ptr);
-        break;
-
-    case INDEX_op_brcond:
-        tci_args_rl(insn, tb_ptr, &r0, &ptr);
-        info->fprintf_func(info->stream, "%-12s  %s, 0, ne, %p",
-                           op_name, str_r(r0), ptr);
-        break;
-
-    case INDEX_op_setcond:
-    case INDEX_op_tci_setcond32:
-        tci_args_rrrc(insn, &r0, &r1, &r2, &c);
-        info->fprintf_func(info->stream, "%-12s  %s, %s, %s, %s",
-                           op_name, str_r(r0), str_r(r1), str_r(r2), str_c(c));
-        break;
-
-    case INDEX_op_tci_movi:
-        tci_args_ri(insn, &r0, &i1);
-        info->fprintf_func(info->stream, "%-12s  %s, 0x%" TCG_PRIlx,
-                           op_name, str_r(r0), i1);
-        break;
-
-    case INDEX_op_tci_movl:
-        tci_args_rl(insn, tb_ptr, &r0, &ptr);
-        info->fprintf_func(info->stream, "%-12s  %s, %p",
-                           op_name, str_r(r0), ptr);
-        break;
-
-    case INDEX_op_tci_setcarry:
-        info->fprintf_func(info->stream, "%-12s", op_name);
-        break;
-
-    case INDEX_op_ld8u:
-    case INDEX_op_ld8s:
-    case INDEX_op_ld16u:
-    case INDEX_op_ld16s:
-    case INDEX_op_ld32u:
-    case INDEX_op_ld:
-    case INDEX_op_st8:
-    case INDEX_op_st16:
-    case INDEX_op_st32:
-    case INDEX_op_st:
-        tci_args_rrs(insn, &r0, &r1, &s2);
-        info->fprintf_func(info->stream, "%-12s  %s, %s, %d",
-                           op_name, str_r(r0), str_r(r1), s2);
-        break;
-
-    case INDEX_op_bswap16:
-    case INDEX_op_bswap32:
-    case INDEX_op_ctpop:
-    case INDEX_op_mov:
-    case INDEX_op_neg:
-    case INDEX_op_not:
-    case INDEX_op_ext_i32_i64:
-    case INDEX_op_extu_i32_i64:
-    case INDEX_op_bswap64:
-        tci_args_rr(insn, &r0, &r1);
-        info->fprintf_func(info->stream, "%-12s  %s, %s",
-                           op_name, str_r(r0), str_r(r1));
-        break;
-
-    case INDEX_op_add:
-    case INDEX_op_addci:
-    case INDEX_op_addcio:
-    case INDEX_op_addco:
-    case INDEX_op_and:
-    case INDEX_op_andc:
-    case INDEX_op_clz:
-    case INDEX_op_ctz:
-    case INDEX_op_divs:
-    case INDEX_op_divu:
-    case INDEX_op_eqv:
-    case INDEX_op_mul:
-    case INDEX_op_nand:
-    case INDEX_op_nor:
-    case INDEX_op_or:
-    case INDEX_op_orc:
-    case INDEX_op_rems:
-    case INDEX_op_remu:
-    case INDEX_op_rotl:
-    case INDEX_op_rotr:
-    case INDEX_op_sar:
-    case INDEX_op_shl:
-    case INDEX_op_shr:
-    case INDEX_op_sub:
-    case INDEX_op_subbi:
-    case INDEX_op_subbio:
-    case INDEX_op_subbo:
-    case INDEX_op_xor:
-    case INDEX_op_tci_ctz32:
-    case INDEX_op_tci_clz32:
-    case INDEX_op_tci_divs32:
-    case INDEX_op_tci_divu32:
-    case INDEX_op_tci_rems32:
-    case INDEX_op_tci_remu32:
-    case INDEX_op_tci_rotl32:
-    case INDEX_op_tci_rotr32:
-        tci_args_rrr(insn, &r0, &r1, &r2);
-        info->fprintf_func(info->stream, "%-12s  %s, %s, %s",
-                           op_name, str_r(r0), str_r(r1), str_r(r2));
-        break;
-
-    case INDEX_op_deposit:
-        tci_args_rrrbb(insn, &r0, &r1, &r2, &pos, &len);
-        info->fprintf_func(info->stream, "%-12s  %s, %s, %s, %d, %d",
-                           op_name, str_r(r0), str_r(r1), str_r(r2), pos, len);
-        break;
-
-    case INDEX_op_extract:
-    case INDEX_op_sextract:
-        tci_args_rrbb(insn, &r0, &r1, &pos, &len);
-        info->fprintf_func(info->stream, "%-12s  %s,%s,%d,%d",
-                           op_name, str_r(r0), str_r(r1), pos, len);
-        break;
-
-    case INDEX_op_tci_movcond32:
-    case INDEX_op_movcond:
-    case INDEX_op_setcond2_i32:
-        tci_args_rrrrrc(insn, &r0, &r1, &r2, &r3, &r4, &c);
-        info->fprintf_func(info->stream, "%-12s  %s, %s, %s, %s, %s, %s",
-                           op_name, str_r(r0), str_r(r1), str_r(r2),
-                           str_r(r3), str_r(r4), str_c(c));
-        break;
-
-    case INDEX_op_muls2:
-    case INDEX_op_mulu2:
-        tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
-        info->fprintf_func(info->stream, "%-12s  %s, %s, %s, %s",
-                           op_name, str_r(r0), str_r(r1),
-                           str_r(r2), str_r(r3));
-        break;
-
-    case INDEX_op_qemu_ld:
-    case INDEX_op_qemu_st:
-        tci_args_rrm(insn, &r0, &r1, &oi);
-        info->fprintf_func(info->stream, "%-12s  %s, %s, %x",
-                           op_name, str_r(r0), str_r(r1), oi);
-        break;
-
-    case INDEX_op_qemu_ld2:
-    case INDEX_op_qemu_st2:
-        tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
-        info->fprintf_func(info->stream, "%-12s  %s, %s, %s, %s",
-                           op_name, str_r(r0), str_r(r1),
-                           str_r(r2), str_r(r3));
-        break;
-
-    case 0:
-        /* tcg_out_nop_fill uses zeros */
-        if (insn == 0) {
-            info->fprintf_func(info->stream, "align");
-            break;
-        }
-        /* fall through */
-
-    default:
-        info->fprintf_func(info->stream, "illegal opcode %d", op);
-        break;
-    }
-
-    return sizeof(insn);
-}
-- 
2.43.0


