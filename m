Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF4EACA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 18:25:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoQzK-0004zm-OU; Tue, 19 Aug 2025 14:23:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoQzJ-0004zA-4C; Tue, 19 Aug 2025 14:23:13 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoQzG-0003o0-Rh; Tue, 19 Aug 2025 14:23:12 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2430c5b1b32so1199235ad.1; 
 Tue, 19 Aug 2025 11:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755627789; x=1756232589; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9eMUDTlPd/3eddRITWEfvNp607+F5yB1eBk0tdgpi6Q=;
 b=UwhcOaYShUYLPL0AfqgyQNZt286/HVUDNybcbmv7SLO9YtlXaHgK/GUmFaqr/KA7dF
 gk5g/l25ah7XYyBiXJ1QdSWxlUY/TFdZ7r2LdrLOoZSPbn9bo7KmMnx8aLalNe/+wPk3
 yBvWbTK4VD6CxfuEBIjRqY/j7E1RoA8OFtQk5wwDj8B9hJTnn1ris0cgiyhOFqbYdHaI
 AJ4U2eVli1zqXoqbfGyFlfv3tLUyrLwJflRhO0hePDYQt50WHVxxjC2qg9q8mtRr1RD3
 W/vFSxLANTK+PMAW7vVOWZQtyu7Wjc3UyUzgWXyLo9hwWhR+ooe8y9F5OQqmfVQpT3Uk
 QNnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755627789; x=1756232589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9eMUDTlPd/3eddRITWEfvNp607+F5yB1eBk0tdgpi6Q=;
 b=BwECImHb9EzNaCLOUxsUaqOsimnYmCRgDwmiuNULiS/aAcNKnwIIJILkdk8CLBxami
 Old/yIaUJ301ZXbi5ndEZozOEaj3/Vy61sfEDLevwVnjzFxTdrcm39cVEtqbwd+J2yWk
 mU7XU0lmAv/OUAQR48jhb/6ClNDDOYxiTP8GuRPYHCLlIHivjyveTgr+JPC/j/iD7gSn
 PTcvbBNAm0clwWhc1gZrYMJbJTGmdPCd7aY9syLrc+zQul+9X1LyfsHIZsWpxZcQLFOk
 jeHZYE/BdVOaeBH4syJv3KPIYIwsDey8GApLqUZ2GCtInaefEszbYGM75BaZFI45V1d8
 iuoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW75Nw3PqOouaZL3WQ6hf2f25FlRixkHrL6s+IEfveAvhk5JbTVgSnEwJntoIW4QusI/5GZgW8Olg==@nongnu.org,
 AJvYcCX2CwMIfjG2tEU7eyPJGmww2mDcK5YD7LKmMqBYAEOSIXEVVKqQJ6lEylTogSnEtyXd6RGA75lwUNRArA==@nongnu.org
X-Gm-Message-State: AOJu0Yya//F6Yg/VcteQqLeuSBlbtK9XHF7vY6djX2RYAsEbRtM55whn
 AMtoKIjGu3Dk+Et9x3KpG9hfLsI1Z8GH4JmNEj52tdUTGZBEKPkQfmXPY01fE9JW
X-Gm-Gg: ASbGncvXYOGFKO9VrNcg01KBAnHfZah7BxLsEylXXnvqAegDM16JvAymgLKM0/kqqIs
 0wf9Q4oPXHZkzZRmesCj9XTlpn//N0JBBqnWx1L4dLrlY92a0tnvdXJlD2nLdIg+iSzgi1rdKwH
 0aMLDfU2bnJ+RqW0xWstzyqsGgUgIkiFL7T9De9RXVEAyuL7Xko6De3hI2U2llTcJ5n1YHPQkm0
 oI+f0xv52DNg399k9OLEn9v+/gTidEgngIF4ATMqHkGbI4lIdNYmzSX+Wy3+Pjy2E5PsjXNK7c4
 LaTRZWhiV4lzTe94iexQsGW6wzkmMXgmsIhJx0RxV8oajogwlCfbTLzjeBKfOZKRDYHw34uYgCx
 hgXgqva4nO0IfG2Gp6PDIjVOu6KHry9t9
X-Google-Smtp-Source: AGHT+IG8E7Oog9qP8xcCbUMzEgno04/0g+VD5DAsJlH9ff4zpLY/DUFetYwmN3rgpV9AMqiMyB7AKg==
X-Received: by 2002:a17:903:1a6f:b0:233:d3e7:6fd6 with SMTP id
 d9443c01a7336-245e0a01363mr46485895ad.19.1755627788652; 
 Tue, 19 Aug 2025 11:23:08 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:29ce:ef58:c2c9:e52f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed33b4c2sm3725125ad.25.2025.08.19.11.23.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 11:23:08 -0700 (PDT)
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
Subject: [PATCH 06/35] tcg/wasm: Do not use TCI disassembler in Wasm backend
Date: Wed, 20 Aug 2025 03:21:35 +0900
Message-ID: <331e4d5f47af18d9f26cfad41bf610f5044f37d1.1755623521.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1755623521.git.ktokunaga.mail@gmail.com>
References: <cover.1755623521.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x636.google.com
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

The Wasm backend should implement its own disassember for Wasm instructions.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm.c | 243 +----------------------------------------------------
 1 file changed, 1 insertion(+), 242 deletions(-)

diff --git a/tcg/wasm.c b/tcg/wasm.c
index 6de9b26b76..4bc53d76d0 100644
--- a/tcg/wasm.c
+++ b/tcg/wasm.c
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


