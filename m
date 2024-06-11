Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0670C27C77
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 14:29:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH2S5-0007ok-9H; Tue, 11 Jun 2024 10:26:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sH2S1-0007gx-Vr
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 10:26:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sH2Rv-0006A6-Ad
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 10:26:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718115969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tQXoUrrHjx5CIJGz2h1sCl2p4DeMN0Aat7X8GP1Y0z4=;
 b=EHql9zM2Y0N7a+dQR9jgrIW0zTTbenBUrUROLypX5qJ4ni/6fmJJwPMUHPODnBxovezHWq
 DU7JBO8vqKBJS+xfKjyGeZYQnR6FbubAltlFqDV5BCG+K3x43VwWECrL0DlnifQ08Bpjof
 ljsDyyUHfpvQ4cH8T3TT5VWerCLIAVQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-ED955okFM4qE-D0D3vCndg-1; Tue, 11 Jun 2024 10:26:07 -0400
X-MC-Unique: ED955okFM4qE-D0D3vCndg-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-57c80b0d272so1976062a12.1
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 07:26:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718115965; x=1718720765;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tQXoUrrHjx5CIJGz2h1sCl2p4DeMN0Aat7X8GP1Y0z4=;
 b=aXvH8ZWZsTUVM7jRNGWjuRtO2DcTB0YvC0D+r7w21HUwDI/mBq8GZ7rl1bYLNWIfUw
 yUVD96PJbBMT4CmE52tBvdqqAVtzxzNBl2n2TR2Hk+N4lAdPIAm9R8fUYjDA1EtQo2ns
 FVStTgug53/yWbfJ5Tyhl5SDC3OUuKXxpk9UOpNUoR67haw571zCym5KMyxCo++PiAn4
 yJbCh/sXdU0bgPkOGyZpDaLliWTjitFp/KPRSqQNxNndMchtU3ZaDrdr18VC01csFMIr
 EiR3/u/fHYCz+jQ46XfU4gOhbWslvKNB3sVYde0ouHAeddC8FzBx/1nxRmHjGA+f6ELe
 2pkA==
X-Gm-Message-State: AOJu0YyKCqu8i6GqROLag4qb5MZCB/X9qBUF7e/XrwxzMd1cJOD+rYBc
 XITUknIy3PhtDH5TrDw61QOpy2+6rZjRSbOPHDOwzyAmjnrtHFN0IDotSX76QclAq+u6B/IKGX1
 0vCHPLRNP6fDcU4/8zVOPnGW/zRP9xceC0cSE9hhGtXk8EBcRgu4teAhHzLEMqQ6ZJNbGQCSZkg
 WyWB1c1KuFkmlOBrIHNw009MqYAkbcP09YUX6R
X-Received: by 2002:a50:8a91:0:b0:57c:6000:88e1 with SMTP id
 4fb4d7f45d1cf-57c60008a2bmr7403237a12.6.1718115965354; 
 Tue, 11 Jun 2024 07:26:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEn28NmacqUokVmmsGDwYgtzAfgBCmFM3eIUFDpyz1FJ6wYhf2saWbEAwjU273NAtWpqnAmlw==
X-Received: by 2002:a50:8a91:0:b0:57c:6000:88e1 with SMTP id
 4fb4d7f45d1cf-57c60008a2bmr7403220a12.6.1718115964735; 
 Tue, 11 Jun 2024 07:26:04 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57c71b6dcaesm5761373a12.78.2024.06.11.07.26.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 07:26:02 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 18/25] target/i386: convert non-grouped,
 helper-based 2-byte opcodes
Date: Tue, 11 Jun 2024 16:25:16 +0200
Message-ID: <20240611142524.83762-19-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240611142524.83762-1-pbonzini@redhat.com>
References: <20240611142524.83762-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

These have very simple generators and no need for complex group
decoding.  Apart from LAR/LSL which are simplified to use
gen_op_deposit_reg_v and movcond, the code is generally lifted
from translate.c into the generators.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.h     |   7 ++
 target/i386/tcg/seg_helper.c     |  16 ++--
 target/i386/tcg/translate.c      | 148 -----------------------------
 target/i386/tcg/decode-new.c.inc |  48 +++++++---
 target/i386/tcg/emit.c.inc       | 157 ++++++++++++++++++++++++++++++-
 5 files changed, 206 insertions(+), 170 deletions(-)

diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index b46a9a0ccb3..c9f958bb0e5 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -170,6 +170,13 @@ typedef enum X86InsnCheck {
     /* Fault outside protected mode, possibly including vm86 mode */
     X86_CHECK_prot_or_vm86 = 512,
     X86_CHECK_prot = X86_CHECK_prot_or_vm86 | X86_CHECK_no_vm86,
+
+    /* Fault outside SMM */
+    X86_CHECK_smm = 1024,
+
+    /* Vendor-specific checks for Intel/AMD differences */
+    X86_CHECK_i64_amd = 2048,
+    X86_CHECK_o64_intel = 4096,
 } X86InsnCheck;
 
 typedef enum X86InsnSpecial {
diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index 715db1f2326..aee3d19f29b 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -2265,11 +2265,11 @@ void helper_sysexit(CPUX86State *env, int dflag)
 target_ulong helper_lsl(CPUX86State *env, target_ulong selector1)
 {
     unsigned int limit;
-    uint32_t e1, e2, eflags, selector;
+    uint32_t e1, e2, selector;
     int rpl, dpl, cpl, type;
 
     selector = selector1 & 0xffff;
-    eflags = cpu_cc_compute_all(env);
+    assert(CC_OP == CC_OP_EFLAGS);
     if ((selector & 0xfffc) == 0) {
         goto fail;
     }
@@ -2301,22 +2301,22 @@ target_ulong helper_lsl(CPUX86State *env, target_ulong selector1)
         }
         if (dpl < cpl || dpl < rpl) {
         fail:
-            CC_SRC = eflags & ~CC_Z;
+            CC_SRC &= ~CC_Z;
             return 0;
         }
     }
     limit = get_seg_limit(e1, e2);
-    CC_SRC = eflags | CC_Z;
+    CC_SRC |= CC_Z;
     return limit;
 }
 
 target_ulong helper_lar(CPUX86State *env, target_ulong selector1)
 {
-    uint32_t e1, e2, eflags, selector;
+    uint32_t e1, e2, selector;
     int rpl, dpl, cpl, type;
 
     selector = selector1 & 0xffff;
-    eflags = cpu_cc_compute_all(env);
+    assert(CC_OP == CC_OP_EFLAGS);
     if ((selector & 0xfffc) == 0) {
         goto fail;
     }
@@ -2351,11 +2351,11 @@ target_ulong helper_lar(CPUX86State *env, target_ulong selector1)
         }
         if (dpl < cpl || dpl < rpl) {
         fail:
-            CC_SRC = eflags & ~CC_Z;
+            CC_SRC &= ~CC_Z;
             return 0;
         }
     }
-    CC_SRC = eflags | CC_Z;
+    CC_SRC |= CC_Z;
     return e2 & 0x00f0ff00;
 }
 
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index ebae745ecba..4b2f7488022 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -246,7 +246,6 @@ STUB_HELPER(mwait, TCGv_env env, TCGv_i32 pc_ofs)
 STUB_HELPER(outb, TCGv_env env, TCGv_i32 port, TCGv_i32 val)
 STUB_HELPER(outw, TCGv_env env, TCGv_i32 port, TCGv_i32 val)
 STUB_HELPER(outl, TCGv_env env, TCGv_i32 port, TCGv_i32 val)
-STUB_HELPER(rdmsr, TCGv_env env)
 STUB_HELPER(stgi, TCGv_env env)
 STUB_HELPER(svm_check_intercept, TCGv_env env, TCGv_i32 type)
 STUB_HELPER(vmload, TCGv_env env, TCGv_i32 aflag)
@@ -254,7 +253,6 @@ STUB_HELPER(vmmcall, TCGv_env env)
 STUB_HELPER(vmrun, TCGv_env env, TCGv_i32 aflag, TCGv_i32 pc_ofs)
 STUB_HELPER(vmsave, TCGv_env env, TCGv_i32 aflag)
 STUB_HELPER(write_crN, TCGv_env env, TCGv_i32 reg, TCGv val)
-STUB_HELPER(wrmsr, TCGv_env env)
 #endif
 
 static void gen_jmp_rel(DisasContext *s, MemOp ot, int diff, int tb_num);
@@ -3470,97 +3468,6 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
         }
         gen_op_mov_reg_v(s, ot, reg, s->T0);
         break;
-    case 0x130: /* wrmsr */
-    case 0x132: /* rdmsr */
-        if (check_cpl0(s)) {
-            gen_update_cc_op(s);
-            gen_update_eip_cur(s);
-            if (b & 2) {
-                gen_helper_rdmsr(tcg_env);
-            } else {
-                gen_helper_wrmsr(tcg_env);
-                s->base.is_jmp = DISAS_EOB_NEXT;
-            }
-        }
-        break;
-    case 0x131: /* rdtsc */
-        gen_update_cc_op(s);
-        gen_update_eip_cur(s);
-        translator_io_start(&s->base);
-        gen_helper_rdtsc(tcg_env);
-        break;
-    case 0x133: /* rdpmc */
-        gen_update_cc_op(s);
-        gen_update_eip_cur(s);
-        gen_helper_rdpmc(tcg_env);
-        s->base.is_jmp = DISAS_NORETURN;
-        break;
-    case 0x134: /* sysenter */
-        /* For AMD SYSENTER is not valid in long mode */
-        if (LMA(s) && env->cpuid_vendor1 != CPUID_VENDOR_INTEL_1) {
-            goto illegal_op;
-        }
-        if (!PE(s)) {
-            gen_exception_gpf(s);
-        } else {
-            gen_helper_sysenter(tcg_env);
-            s->base.is_jmp = DISAS_EOB_ONLY;
-        }
-        break;
-    case 0x135: /* sysexit */
-        /* For AMD SYSEXIT is not valid in long mode */
-        if (LMA(s) && env->cpuid_vendor1 != CPUID_VENDOR_INTEL_1) {
-            goto illegal_op;
-        }
-        if (!PE(s) || CPL(s) != 0) {
-            gen_exception_gpf(s);
-        } else {
-            gen_helper_sysexit(tcg_env, tcg_constant_i32(dflag - 1));
-            s->base.is_jmp = DISAS_EOB_ONLY;
-        }
-        break;
-    case 0x105: /* syscall */
-        /* For Intel SYSCALL is only valid in long mode */
-        if (!LMA(s) && env->cpuid_vendor1 == CPUID_VENDOR_INTEL_1) {
-            goto illegal_op;
-        }
-        gen_update_cc_op(s);
-        gen_update_eip_cur(s);
-        gen_helper_syscall(tcg_env, cur_insn_len_i32(s));
-        /* condition codes are modified only in long mode */
-        if (LMA(s)) {
-            assume_cc_op(s, CC_OP_EFLAGS);
-        }
-        /* TF handling for the syscall insn is different. The TF bit is  checked
-           after the syscall insn completes. This allows #DB to not be
-           generated after one has entered CPL0 if TF is set in FMASK.  */
-        s->base.is_jmp = DISAS_EOB_RECHECK_TF;
-        break;
-    case 0x107: /* sysret */
-        /* For Intel SYSRET is only valid in long mode */
-        if (!LMA(s) && env->cpuid_vendor1 == CPUID_VENDOR_INTEL_1) {
-            goto illegal_op;
-        }
-        if (!PE(s) || CPL(s) != 0) {
-            gen_exception_gpf(s);
-        } else {
-            gen_helper_sysret(tcg_env, tcg_constant_i32(dflag - 1));
-            /* condition codes are modified only in long mode */
-            if (LMA(s)) {
-                assume_cc_op(s, CC_OP_EFLAGS);
-            }
-            /* TF handling for the sysret insn is different. The TF bit is
-               checked after the sysret insn completes. This allows #DB to be
-               generated "as if" the syscall insn in userspace has just
-               completed.  */
-            s->base.is_jmp = DISAS_EOB_RECHECK_TF;
-        }
-        break;
-    case 0x1a2: /* cpuid */
-        gen_update_cc_op(s);
-        gen_update_eip_cur(s);
-        gen_helper_cpuid(tcg_env);
-        break;
     case 0x100:
         modrm = x86_ldub_code(env, s);
         mod = (modrm >> 6) & 3;
@@ -3964,39 +3871,6 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
         }
         break;
 
-    case 0x108: /* invd */
-    case 0x109: /* wbinvd; wbnoinvd with REPZ prefix */
-        if (check_cpl0(s)) {
-            gen_svm_check_intercept(s, (b & 1) ? SVM_EXIT_WBINVD : SVM_EXIT_INVD);
-            /* nothing to do */
-        }
-        break;
-    case 0x102: /* lar */
-    case 0x103: /* lsl */
-        {
-            TCGLabel *label1;
-            TCGv t0;
-            if (!PE(s) || VM86(s))
-                goto illegal_op;
-            ot = dflag != MO_16 ? MO_32 : MO_16;
-            modrm = x86_ldub_code(env, s);
-            reg = ((modrm >> 3) & 7) | REX_R(s);
-            gen_ld_modrm(env, s, modrm, MO_16);
-            t0 = tcg_temp_new();
-            gen_update_cc_op(s);
-            if (b == 0x102) {
-                gen_helper_lar(t0, tcg_env, s->T0);
-            } else {
-                gen_helper_lsl(t0, tcg_env, s->T0);
-            }
-            tcg_gen_andi_tl(s->tmp0, cpu_cc_src, CC_Z);
-            label1 = gen_new_label();
-            tcg_gen_brcondi_tl(TCG_COND_EQ, s->tmp0, 0, label1);
-            gen_op_mov_reg_v(s, ot, reg, t0);
-            gen_set_label(label1);
-            set_cc_op(s, CC_OP_EFLAGS);
-        }
-        break;
     case 0x11a:
         modrm = x86_ldub_code(env, s);
         if (s->flags & HF_MPX_EN_MASK) {
@@ -4188,28 +4062,6 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
         }
         gen_nop_modrm(env, s, modrm);
         break;
-
-    case 0x106: /* clts */
-        if (check_cpl0(s)) {
-            gen_svm_check_intercept(s, SVM_EXIT_WRITE_CR0);
-            gen_helper_clts(tcg_env);
-            /* abort block because static cpu state changed */
-            s->base.is_jmp = DISAS_EOB_NEXT;
-        }
-        break;
-    case 0x1aa: /* rsm */
-        gen_svm_check_intercept(s, SVM_EXIT_RSM);
-        if (!(s->flags & HF_SMM_MASK))
-            goto illegal_op;
-#ifdef CONFIG_USER_ONLY
-        /* we should not be in SMM mode */
-        g_assert_not_reached();
-#else
-        gen_helper_rsm(tcg_env);
-        assume_cc_op(s, CC_OP_EFLAGS);
-#endif /* CONFIG_USER_ONLY */
-        s->base.is_jmp = DISAS_EOB_ONLY;
-        break;
     case 0x1b8: /* SSE4.2 popcnt */
         if ((prefixes & (PREFIX_REPZ | PREFIX_LOCK | PREFIX_REPNZ)) !=
              PREFIX_REPZ)
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index f02f7c62647..1db9d1e2bc3 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -223,6 +223,8 @@
 #define vex13 .vex_class = 13,
 
 #define chk(a) .check = X86_CHECK_##a,
+#define chk2(a, b) .check = X86_CHECK_##a | X86_CHECK_##b,
+#define chk3(a, b, c) .check = X86_CHECK_##a | X86_CHECK_##b | X86_CHECK_##c,
 #define svm(a) .intercept = SVM_EXIT_##a, .has_intercept = true,
 
 #define avx2_256 .vex_special = X86_VEX_AVX2_256,
@@ -1027,6 +1029,12 @@ static void decode_MOV_CR_DR(DisasContext *s, CPUX86State *env, X86OpEntry *entr
 }
 
 static const X86OpEntry opcodes_0F[256] = {
+    [0x02] = X86_OP_ENTRYwr(LAR,        G,v, E,w,             chk(prot)),
+    [0x03] = X86_OP_ENTRYwr(LSL,        G,v, E,w,             chk(prot)),
+    [0x05] = X86_OP_ENTRY0(SYSCALL,                           chk(o64_intel)),
+    [0x06] = X86_OP_ENTRY0(CLTS,                              chk(cpl0) svm(WRITE_CR0)),
+    [0x07] = X86_OP_ENTRY0(SYSRET,                            chk3(o64_intel, prot, cpl0)),
+
     [0x10] = X86_OP_GROUP0(0F10),
     [0x11] = X86_OP_GROUP0(0F11),
     [0x12] = X86_OP_GROUP0(0F12),
@@ -1042,6 +1050,13 @@ static const X86OpEntry opcodes_0F[256] = {
     [0x22] = X86_OP_GROUPwr(MOV_CR_DR,   C,y, R,y, zextT0 chk(cpl0) svm(WRITE_CR0)),
     [0x23] = X86_OP_GROUPwr(MOV_CR_DR,   D,y, R,y, zextT0 chk(cpl0) svm(WRITE_DR0)),
 
+    [0x30] = X86_OP_ENTRY0(WRMSR,                             chk(cpl0)),
+    [0x31] = X86_OP_ENTRY0(RDTSC),
+    [0x32] = X86_OP_ENTRY0(RDMSR,                             chk(cpl0)),
+    [0x33] = X86_OP_ENTRY0(RDPMC),
+    [0x34] = X86_OP_ENTRY0(SYSENTER,                          chk2(i64_amd, prot_or_vm86)),
+    [0x35] = X86_OP_ENTRY0(SYSEXIT,                           chk3(i64_amd, prot, cpl0)),
+
     [0x40] = X86_OP_ENTRY2(CMOVcc,     G,v, E,v, cpuid(CMOV)),
     [0x41] = X86_OP_ENTRY2(CMOVcc,     G,v, E,v, cpuid(CMOV)),
     [0x42] = X86_OP_ENTRY2(CMOVcc,     G,v, E,v, cpuid(CMOV)),
@@ -1098,6 +1113,7 @@ static const X86OpEntry opcodes_0F[256] = {
 
     [0xa0] = X86_OP_ENTRYr(PUSH, FS, w),
     [0xa1] = X86_OP_ENTRYw(POP, FS, w),
+    [0xa2] = X86_OP_ENTRY0(CPUID),
 
     [0xb2] = X86_OP_ENTRY3(LSS,    G,v, EM,p, None, None),
     [0xb4] = X86_OP_ENTRY3(LFS,    G,v, EM,p, None, None),
@@ -1138,6 +1154,8 @@ static const X86OpEntry opcodes_0F[256] = {
     [0xf6] = X86_OP_ENTRY3(PSADBW,   V,x, H,x, W,x,         vex4 mmx avx2_256 p_00_66),
     [0xf7] = X86_OP_ENTRY3(MASKMOV,  None,None, V,dq, U,dq, vex4_unal avx2_256 mmx p_00_66),
 
+    [0x08] = X86_OP_ENTRY0(NOP,           svm(INVD)),
+    [0x09] = X86_OP_ENTRY0(NOP,           svm(WBINVD)),
     [0x0b] = X86_OP_ENTRY0(UD),           /* UD2 */
     [0x0d] = X86_OP_ENTRY1(NOP,  M,v),    /* 3DNow! prefetch */
     [0x0e] = X86_OP_ENTRY0(EMMS,                              cpuid(3DNOW)), /* femms */
@@ -1221,6 +1239,7 @@ static const X86OpEntry opcodes_0F[256] = {
 
     [0xa8] = X86_OP_ENTRYr(PUSH,   GS, w),
     [0xa9] = X86_OP_ENTRYw(POP,    GS, w),
+    [0xaa] = X86_OP_ENTRY0(RSM,             chk(smm) svm(RSM)),
     [0xae] = X86_OP_GROUP0(group15),
     /*
      * It's slightly more efficient to put Ev operand in T0 and allow gen_IMUL3
@@ -2511,12 +2530,10 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
         if (b == 0x0f) {
             b = x86_ldub_code(env, s);
             switch (b) {
-            case 0x00 ... 0x03: /* mostly privileged instructions */
-            case 0x05 ... 0x09:
+            case 0x00 ... 0x01: /* mostly privileged instructions */
             case 0x1a ... 0x1b: /* MPX */
-            case 0x30 ... 0x35: /* more privileged instructions */
-            case 0xa2 ... 0xa5: /* CPUID, BT, SHLD */
-            case 0xaa ... 0xad: /* RSM, SHRD */
+            case 0xa3 ... 0xa5: /* BT, SHLD */
+            case 0xab ... 0xad: /* BTS, SHRD */
             case 0xb0 ... 0xb1: /* cmpxchg */
             case 0xb3:          /* btr */
             case 0xb8:          /* integer ops */
@@ -2548,13 +2565,18 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
 
     /* Checks that result in #UD come first.  */
     if (decode.e.check) {
-        if (decode.e.check & X86_CHECK_i64) {
-            if (CODE64(s)) {
+        if (CODE64(s)) {
+            if (decode.e.check & X86_CHECK_i64) {
                 goto illegal_op;
             }
-        }
-        if (decode.e.check & X86_CHECK_o64) {
-            if (!CODE64(s)) {
+            if ((decode.e.check & X86_CHECK_i64_amd) && env->cpuid_vendor1 != CPUID_VENDOR_INTEL_1) {
+                goto illegal_op;
+            }
+        } else {
+            if (decode.e.check & X86_CHECK_o64) {
+                goto illegal_op;
+            }
+            if ((decode.e.check & X86_CHECK_o64_intel) && env->cpuid_vendor1 == CPUID_VENDOR_INTEL_1) {
                 goto illegal_op;
             }
         }
@@ -2638,8 +2660,7 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
      * exceptions if there is no memory operand).  Exceptions are
      * vm86 checks (INTn, IRET, PUSHF/POPF), RSM and XSETBV (!).
      *
-     * RSM and XSETBV will be handled in the gen_* functions
-     * instead of using chk().
+     * XSETBV will check for CPL0 in the gen_* function instead of using chk().
      */
     if (decode.e.check & X86_CHECK_cpl0) {
         if (CPL(s) != 0) {
@@ -2651,6 +2672,9 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
                                        tcg_constant_i32(decode.e.intercept));
     }
     if (decode.e.check) {
+        if ((decode.e.check & X86_CHECK_smm) && !(s->flags & HF_SMM_MASK)) {
+            goto illegal_op;
+        }
         if ((decode.e.check & X86_CHECK_vm86_iopl) && VM86(s)) {
             if (IOPL(s) < 3) {
                 goto gp_fault;
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 709ef7b0cb2..92635f53cf4 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1410,6 +1410,13 @@ static void gen_CLI(DisasContext *s, X86DecodedInsn *decode)
     gen_reset_eflags(s, IF_MASK);
 }
 
+static void gen_CLTS(DisasContext *s, X86DecodedInsn *decode)
+{
+    gen_helper_clts(tcg_env);
+    /* abort block because static cpu state changed */
+    s->base.is_jmp = DISAS_EOB_NEXT;
+}
+
 static void gen_CMC(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_compute_eflags(s);
@@ -1534,6 +1541,13 @@ static void gen_CMPS(DisasContext *s, X86DecodedInsn *decode)
     }
 }
 
+static void gen_CPUID(DisasContext *s, X86DecodedInsn *decode)
+{
+    gen_update_cc_op(s);
+    gen_update_eip_cur(s);
+    gen_helper_cpuid(tcg_env);
+}
+
 static void gen_CRC32(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[2].ot;
@@ -1657,16 +1671,18 @@ static void gen_FXRSTOR(DisasContext *s, X86DecodedInsn *decode)
 {
     if ((s->flags & HF_EM_MASK) || (s->flags & HF_TS_MASK)) {
         gen_NM_exception(s);
+    } else {
+        gen_helper_fxrstor(tcg_env, s->A0);
     }
-    gen_helper_fxrstor(tcg_env, s->A0);
 }
 
 static void gen_FXSAVE(DisasContext *s, X86DecodedInsn *decode)
 {
     if ((s->flags & HF_EM_MASK) || (s->flags & HF_TS_MASK)) {
         gen_NM_exception(s);
+    } else {
+        gen_helper_fxsave(tcg_env, s->A0);
     }
-    gen_helper_fxsave(tcg_env, s->A0);
 }
 
 static void gen_HLT(DisasContext *s, X86DecodedInsn *decode)
@@ -1977,6 +1993,23 @@ static void gen_LAHF(DisasContext *s, X86DecodedInsn *decode)
     tcg_gen_deposit_tl(cpu_regs[R_EAX], cpu_regs[R_EAX], s->T0, 8, 8);
 }
 
+static void gen_LAR(DisasContext *s, X86DecodedInsn *decode)
+{
+    MemOp ot = decode->op[0].ot;
+    TCGv result = tcg_temp_new();
+    TCGv dest;
+
+    gen_compute_eflags(s);
+    gen_update_cc_op(s);
+    gen_helper_lar(result, tcg_env, s->T0);
+
+    /* Perform writeback here to skip it if ZF=0.  */
+    decode->op[0].unit = X86_OP_SKIP;
+    dest = gen_op_deposit_reg_v(s, ot, decode->op[0].n, result, result);
+    tcg_gen_movcond_tl(TCG_COND_TSTNE, dest, cpu_cc_src, tcg_constant_tl(CC_Z),
+                       result, dest);
+}
+
 static void gen_LDMXCSR(DisasContext *s, X86DecodedInsn *decode)
 {
     tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
@@ -2075,6 +2108,23 @@ static void gen_LOOPNE(DisasContext *s, X86DecodedInsn *decode)
     gen_conditional_jump_labels(s, decode->immediate, not_taken, taken);
 }
 
+static void gen_LSL(DisasContext *s, X86DecodedInsn *decode)
+{
+    MemOp ot = decode->op[0].ot;
+    TCGv result = tcg_temp_new();
+    TCGv dest;
+
+    gen_compute_eflags(s);
+    gen_update_cc_op(s);
+    gen_helper_lsl(result, tcg_env, s->T0);
+
+    /* Perform writeback here to skip it if ZF=0.  */
+    decode->op[0].unit = X86_OP_SKIP;
+    dest = gen_op_deposit_reg_v(s, ot, decode->op[0].n, result, result);
+    tcg_gen_movcond_tl(TCG_COND_TSTNE, dest, cpu_cc_src, tcg_constant_tl(CC_Z),
+                       result, dest);
+}
+
 static void gen_LSS(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_lxx_seg(s, decode, R_SS);
@@ -3118,6 +3168,41 @@ static void gen_RCR(DisasContext *s, X86DecodedInsn *decode)
     }
 }
 
+#ifdef CONFIG_USER_ONLY
+static void gen_unreachable(DisasContext *s, X86DecodedInsn *decode)
+{
+    g_assert_not_reached();
+}
+#endif
+
+#ifndef CONFIG_USER_ONLY
+static void gen_RDMSR(DisasContext *s, X86DecodedInsn *decode)
+{
+    gen_update_cc_op(s);
+    gen_update_eip_cur(s);
+    gen_helper_rdmsr(tcg_env);
+}
+#else
+#define gen_RDMSR gen_unreachable
+#endif
+
+static void gen_RDPMC(DisasContext *s, X86DecodedInsn *decode)
+{
+    gen_update_cc_op(s);
+    gen_update_eip_cur(s);
+    translator_io_start(&s->base);
+    gen_helper_rdpmc(tcg_env);
+    s->base.is_jmp = DISAS_NORETURN;
+}
+
+static void gen_RDTSC(DisasContext *s, X86DecodedInsn *decode)
+{
+    gen_update_cc_op(s);
+    gen_update_eip_cur(s);
+    translator_io_start(&s->base);
+    gen_helper_rdtsc(tcg_env);
+}
+
 static void gen_RDxxBASE(DisasContext *s, X86DecodedInsn *decode)
 {
     TCGv base = cpu_seg_base[s->modrm & 8 ? R_GS : R_FS];
@@ -3290,6 +3375,17 @@ static void gen_RORX(DisasContext *s, X86DecodedInsn *decode)
     }
 }
 
+#ifndef CONFIG_USER_ONLY
+static void gen_RSM(DisasContext *s, X86DecodedInsn *decode)
+{
+    gen_helper_rsm(tcg_env);
+    assume_cc_op(s, CC_OP_EFLAGS);
+    s->base.is_jmp = DISAS_EOB_ONLY;
+}
+#else
+#define gen_RSM gen_UD
+#endif
+
 static void gen_SAHF(DisasContext *s, X86DecodedInsn *decode)
 {
     if (CODE64(s) && !(s->cpuid_ext3_features & CPUID_EXT3_LAHF_LM)) {
@@ -3586,6 +3682,51 @@ static void gen_SUB(DisasContext *s, X86DecodedInsn *decode)
     prepare_update2_cc(decode, s, CC_OP_SUBB + ot);
 }
 
+static void gen_SYSCALL(DisasContext *s, X86DecodedInsn *decode)
+{
+    gen_update_cc_op(s);
+    gen_update_eip_cur(s);
+    gen_helper_syscall(tcg_env, cur_insn_len_i32(s));
+    if (LMA(s)) {
+        assume_cc_op(s, CC_OP_EFLAGS);
+    }
+
+    /*
+     * TF handling for the syscall insn is different. The TF bit is checked
+     * after the syscall insn completes. This allows #DB to not be
+     * generated after one has entered CPL0 if TF is set in FMASK.
+     */
+    s->base.is_jmp = DISAS_EOB_RECHECK_TF;
+}
+
+static void gen_SYSENTER(DisasContext *s, X86DecodedInsn *decode)
+{
+    gen_helper_sysenter(tcg_env);
+    s->base.is_jmp = DISAS_EOB_ONLY;
+}
+
+static void gen_SYSEXIT(DisasContext *s, X86DecodedInsn *decode)
+{
+    gen_helper_sysexit(tcg_env, tcg_constant_i32(s->dflag - 1));
+    s->base.is_jmp = DISAS_EOB_ONLY;
+}
+
+static void gen_SYSRET(DisasContext *s, X86DecodedInsn *decode)
+{
+    gen_helper_sysret(tcg_env, tcg_constant_i32(s->dflag - 1));
+    if (LMA(s)) {
+        assume_cc_op(s, CC_OP_EFLAGS);
+    }
+
+    /*
+     * TF handling for the sysret insn is different. The TF bit is checked
+     * after the sysret insn completes. This allows #DB to be
+     * generated "as if" the syscall insn in userspace has just
+     * completed.
+     */
+    s->base.is_jmp = DISAS_EOB_RECHECK_TF;
+}
+
 static void gen_UD(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_illegal_opcode(s);
@@ -4082,6 +4223,18 @@ static void gen_WAIT(DisasContext *s, X86DecodedInsn *decode)
     }
 }
 
+#ifndef CONFIG_USER_ONLY
+static void gen_WRMSR(DisasContext *s, X86DecodedInsn *decode)
+{
+    gen_update_cc_op(s);
+    gen_update_eip_cur(s);
+    gen_helper_wrmsr(tcg_env);
+    s->base.is_jmp = DISAS_EOB_NEXT;
+}
+#else
+#define gen_WRMSR gen_unreachable
+#endif
+
 static void gen_WRxxBASE(DisasContext *s, X86DecodedInsn *decode)
 {
     TCGv base = cpu_seg_base[s->modrm & 8 ? R_GS : R_FS];
-- 
2.45.1


