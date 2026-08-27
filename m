Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51363C5DF9D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 05:04:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzSGa-0005qd-Co; Thu, 27 Aug 2026 01:03:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wzSGZ-0005qQ-HP
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 01:03:07 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wzSGW-0002JD-Je
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 01:03:07 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-66d1442b24eso2242609d50.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 22:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787806983; x=1788411783; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PtS9C6criMikEeHhjOAa2GbahJameLBPB99rYyPv+nQ=;
 b=rAFEoS/zoyLMld5tHBRcRobuqAteYFK6e6ZNydxJP9g57HOSGfo3+tccGoUWNq8RaG
 VpP1DtxK3yBJNMIp73KsMQigPd926kthyfHTyScY+OuPE9aVOguSNuSbjg58F/6pHYs4
 FVhBKziJy+fVsck2QM7EfC12Y3HItlXRlG4jZ7+Ris14h3h3qqvpR6cuFx+KetGNYpde
 mzffb3Q64LE75X1bxlTdH6R1RFuOMfI/eXVOIWnvPNdb2ugiEFKBtHBcn075Fo2EyYoh
 fn7iyGURJ9nLj7VdKe3f2f81kF9aEF/EhrkUn61LktECFa8ZP/vQ/vsie8S6ei63H0G0
 LRUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787806983; x=1788411783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PtS9C6criMikEeHhjOAa2GbahJameLBPB99rYyPv+nQ=;
 b=ARAmaGcEUuzg2y2BVStEitdGseDWNmwXI+QMRMBzcmaHQm7UYIreuCnS5kQbKe42D2
 HvSqAjQVfBnjoDvtLydngS/5VNf7dLluFl9OEl/vN8VkY6wY+zmcxPbshDLRDKYir8L4
 PHVYshw+Q78yUe8NHyOIg0pFOYGvwpRRDrS+3CqeTdDzKavCyMmWjYbfS65E+O48Fa+R
 Q5UTMexjaJnBLzJbWerABWKGETj/3Xr5PcawGx7wuezKIA8QdYDVmEmf17mCD+VlaljL
 YfmidwjTWgRWtp6VMc/L4dYDxEO9BOTCArst66VWUqZW1dqzGPdplP1E9HXZdeJxLZL8
 Ki6w==
X-Gm-Message-State: AFuF++m1azWTHcery0hNH4BJIhvo8/Z36JUmXw+gVEztP2NPd1R4yGE1
 hmSlwmSRCphaBbJbqm8wuAXEe1ZY0KuhVdc4JdC2vD0pKUEXki0qgbnQ9HuwHp/2
X-Gm-Gg: AR+sD10r8vjGs3GsynDEaDztxh+vAAtW2fRp7lrSnA7mmqz3OcI6EF4eJxTOEby9Gn0
 pjY5njb6b+rajdDX9FCVN//BxA7ruTejYhVwhlPAyQDykeiXsqks7dAq/uxKi96NmOZslLkhIpn
 de86mLIUNkKXwvOcboZLpi4eeJQagaWvro74heaJil7okfde62zLv8+kkQHswOWzEQtQerpKHKK
 ZxfFxZ0CnBpU6+OwJtWeXh3wifdFfinSO2F1/Z7flsk5/FwRdIIks2aagoxxFzcsoXftI0WLFkg
 17091ItzisBezg/T/KP5bDzHQSwG9Dp4X81Q0YAgD9OWXp0nEdcQMeP960ZSa5AsS3O2psxV6Rt
 O3dCq5ecjHWHXoHAm6Z3b7Wot5ExhL9YlNq9RDznXJBfkr/XUGUlShM2sjfEekzngBD0zME+xAZ
 TFD4mdgkEmLJIxe4Rs/7t/tAFHVgW3fiwCZX9EwhDVBD2GNIVKbjMKKNndEWfisbOmtp/2hu3/v
 BZuX55n7CziSvQzoV2WbIEwu2PdOGpNW/KGAITtiwZ0qeaCprg=
X-Received: by 2002:a53:ac9c:0:b0:668:9fa5:b9cc with SMTP id
 956f58d0204a3-66d2551013fmr4446592d50.0.1787806983083; 
 Wed, 26 Aug 2026 22:03:03 -0700 (PDT)
Received: from localhost (107-220-129-194.lightspeed.chrlnc.sbcglobal.net.
 [107.220.129.194]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-85b6143fe16sm4110607b3.29.2026.08.26.22.03.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 22:03:02 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, philmd@oss.qualcomm.com,
 alex.bennee@linaro.org, zhao1.liu@intel.com,
 Matt Turner <mattst88@gmail.com>
Subject: [PATCH v4 4/9] tcg: pass the destination to
 tcg_gen_lookup_and_goto_ptr()
Date: Thu, 27 Aug 2026 01:02:36 -0400
Message-ID: <20260827050241.3713332-5-mattst88@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260822190818.1829249-1-mattst88@gmail.com>
References: <20260822190818.1829249-1-mattst88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=mattst88@gmail.com; helo=mail-yx1-xb129.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

tcg_gen_lookup_and_goto_ptr() takes no arguments and emits a call to
helper_lookup_tb_ptr(), which recovers the destination PC from env by
calling back into the target through TCGCPUOps::get_tb_cpu_state(). At
translation time the caller already has the destination PC in a temp, and
knows the flags, cflags and cs_base any destination it may reach has to
match, because they are the ones the block being generated was translated
with.

Pass both, so that a later patch can use them to look the destination up
inline. Nothing reads them yet and the generated code does not change.

The contract on @pc is the whole of the interface: it must hold exactly
what get_tb_cpu_state() reports as the pc for the destination block. Five
targets keep their PC in a temp whose value is that pc by construction and
so can pass it: alpha, loongarch, mips, ppc and s390x. Everything else
passes NULL and keeps today's behavior.

For six of those the TB pc is derived and passing the PC temp would be
wrong: avr's TB pc is the word address doubled, i386's is eip before
segmentation, riscv masks it to 32 bits when xl is MXL_RV32, hppa derives
it from the IAQ, hexagon adjusts it inside a hardware loop, and sparc puts
npc in cs_base. The remaining seven -- arm, m68k, microblaze, or1k, rx, sh4
and tricore -- look like they could pass it, but I have not convinced
myself of the contract for them and have nothing to test them with. Each is
a one-line change for whoever wants it.

The common entry point takes a TCGTemp rather than a TCGv and reads the
width from it, because the translators that are built for both values of
TARGET_LONG_BITS -- arm, s390x, microblaze -- cannot include tcg-op.h.
tcg-op.h wraps it for everyone else. This is the same split as
tcg_gen_qemu_ld_*_chk().

v4: Split out of "tcg: probe the TB jump cache inline instead of calling a
    helper", which did the API change and the inline probe in one patch.
    Requested by Richard Henderson.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 include/tcg/tcg-op-common.h                       | 15 ++++++++++++---
 include/tcg/tcg-op.h                              | 12 ++++++++++++
 target/alpha/translate.c                          |  4 ++--
 target/arm/tcg/translate-a64.c                    |  4 ++--
 target/arm/tcg/translate.c                        | 10 +++++-----
 target/avr/translate.c                            |  4 ++--
 target/hexagon/translate.c                        |  4 ++--
 target/hppa/translate.c                           |  6 +++---
 target/i386/tcg/translate.c                       |  2 +-
 .../loongarch/tcg/insn_trans/trans_branch.c.inc   |  2 +-
 target/loongarch/tcg/translate.c                  |  4 ++--
 target/m68k/translate.c                           |  2 +-
 target/microblaze/translate.c                     |  4 ++--
 target/mips/tcg/nanomips_translate.c.inc          |  2 +-
 target/mips/tcg/translate.c                       |  6 +++---
 target/or1k/translate.c                           |  4 ++--
 target/ppc/translate.c                            |  4 ++--
 target/riscv/tcg/insn_trans/trans_rvzce.c.inc     |  4 ++--
 target/riscv/tcg/translate.c                      |  2 +-
 target/rx/translate.c                             |  4 ++--
 target/s390x/tcg/translate.c                      |  5 +++--
 target/sh4/translate.c                            |  4 ++--
 target/sparc/translate.c                          |  4 ++--
 target/tricore/translate.c                        |  4 ++--
 tcg/tcg-op.c                                      |  3 ++-
 25 files changed, 71 insertions(+), 48 deletions(-)

diff --git ./include/tcg/tcg-op-common.h ./include/tcg/tcg-op-common.h
index 9b321f959c..34102b3b7a 100644
--- ./include/tcg/tcg-op-common.h
+++ ./include/tcg/tcg-op-common.h
@@ -75,15 +75,24 @@ void tcg_gen_exit_tb(const TranslationBlock *tb, unsigned idx);
 void tcg_gen_goto_tb(unsigned idx);
 
 /**
- * tcg_gen_lookup_and_goto_ptr() - look up the current TB, jump to it if valid
- * @addr: Guest address of the target TB
+ * tcg_gen_lookup_and_goto_ptr() - look up the destination TB, jump to it
+ * @pc: temp holding the destination guest PC, or NULL
+ * @tb: the translation block being generated
  *
  * If the TB is not valid, jump to the epilogue.
  *
+ * The lookup is a call to helper_lookup_tb_ptr().  @pc and @tb describe the
+ * destination for a faster lookup that a later patch adds, and neither is
+ * used yet.  When @pc is non-NULL it must hold exactly the value
+ * get_tb_cpu_state() reports as the pc for the destination, and the
+ * destination must match @tb's flags, cflags and cs_base.  A target whose
+ * pc is derived rather than being that key -- avr's word address, i386's
+ * eip before segmentation -- must pass NULL.
+ *
  * This operation is optional. If the TCG backend does not implement goto_ptr,
  * this op is equivalent to calling tcg_gen_exit_tb() with 0 as the argument.
  */
-void tcg_gen_lookup_and_goto_ptr(void);
+void tcg_gen_lookup_and_goto_ptr_tmp(TCGTemp *pc, const TranslationBlock *tb);
 
 void tcg_gen_plugin_cb(unsigned from);
 void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
diff --git ./include/tcg/tcg-op.h ./include/tcg/tcg-op.h
index 3721164236..24d567bd2f 100644
--- ./include/tcg/tcg-op.h
+++ ./include/tcg/tcg-op.h
@@ -49,6 +49,18 @@ typedef TCGv_i64 TCGv;
 #error Unhandled TARGET_LONG_BITS value
 #endif
 
+/*
+ * See tcg_gen_lookup_and_goto_ptr_tmp().  @pc may be NULL, for a target
+ * whose guest PC is not directly the key a destination block is found by.
+ * A translator that is built for more than one value of TARGET_LONG_BITS,
+ * and so cannot include this header, calls the _tmp() form directly.
+ */
+static inline void
+tcg_gen_lookup_and_goto_ptr(TCGv pc, const TranslationBlock *tb)
+{
+    tcg_gen_lookup_and_goto_ptr_tmp(pc ? tcgv_tl_temp(pc) : NULL, tb);
+}
+
 #if TARGET_LONG_BITS == 64
 #define tcg_gen_movi_tl tcg_gen_movi_i64
 #define tcg_gen_mov_tl tcg_gen_mov_i64
diff --git ./target/alpha/translate.c ./target/alpha/translate.c
index c66e3f9c14..822f5cc120 100644
--- ./target/alpha/translate.c
+++ ./target/alpha/translate.c
@@ -449,7 +449,7 @@ static void gen_goto_tb(DisasContext *ctx, unsigned tb_slot_idx, int32_t disp)
         tcg_gen_exit_tb(ctx->base.tb, tb_slot_idx);
     } else {
         gen_pc_disp(ctx, cpu_pc, disp);
-        tcg_gen_lookup_and_goto_ptr();
+        tcg_gen_lookup_and_goto_ptr(cpu_pc, ctx->base.tb);
     }
 }
 
@@ -2917,7 +2917,7 @@ static void alpha_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
         gen_pc_disp(ctx, cpu_pc, 0);
         /* FALLTHRU */
     case DISAS_PC_UPDATED:
-        tcg_gen_lookup_and_goto_ptr();
+        tcg_gen_lookup_and_goto_ptr(cpu_pc, ctx->base.tb);
         break;
     case DISAS_PC_UPDATED_NOCHAIN:
         tcg_gen_exit_tb(NULL, 0);
diff --git ./target/arm/tcg/translate-a64.c ./target/arm/tcg/translate-a64.c
index 4f9a93950b..d1dd33a1af 100644
--- ./target/arm/tcg/translate-a64.c
+++ ./target/arm/tcg/translate-a64.c
@@ -562,7 +562,7 @@ static void gen_goto_tb(DisasContext *s, unsigned tb_slot_idx, int64_t diff)
         if (s->ss_active) {
             gen_step_complete_exception(s);
         } else {
-            tcg_gen_lookup_and_goto_ptr();
+            tcg_gen_lookup_and_goto_ptr(NULL, s->base.tb);
             s->base.is_jmp = DISAS_NORETURN;
         }
     }
@@ -11250,7 +11250,7 @@ static void aarch64_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
             gen_a64_update_pc(dc, 4);
             /* fall through */
         case DISAS_JUMP:
-            tcg_gen_lookup_and_goto_ptr();
+            tcg_gen_lookup_and_goto_ptr(NULL, dc->base.tb);
             break;
         case DISAS_NORETURN:
         case DISAS_SWI:
diff --git ./target/arm/tcg/translate.c ./target/arm/tcg/translate.c
index c866148383..ca701b9cbc 100644
--- ./target/arm/tcg/translate.c
+++ ./target/arm/tcg/translate.c
@@ -1306,9 +1306,9 @@ void write_neon_element64(TCGv_i64 src, int reg, int ele, MemOp memop)
     }
 }
 
-static void gen_goto_ptr(void)
+static void gen_goto_ptr(DisasContext *s)
 {
-    tcg_gen_lookup_and_goto_ptr();
+    tcg_gen_lookup_and_goto_ptr_tmp(NULL, s->base.tb);
 }
 
 /* This will end the TB but doesn't guarantee we'll return to
@@ -1336,7 +1336,7 @@ static void gen_goto_tb(DisasContext *s, unsigned tb_slot_idx, int64_t diff)
         tcg_gen_exit_tb(s->base.tb, tb_slot_idx);
     } else {
         gen_update_pc(s, diff);
-        gen_goto_ptr();
+        gen_goto_ptr(s);
     }
     s->base.is_jmp = DISAS_NORETURN;
 }
@@ -1373,7 +1373,7 @@ static void gen_jmp_tb(DisasContext *s, int64_t diff, int tbno)
          * and don't chain to another TB.
          */
         gen_update_pc(s, diff);
-        gen_goto_ptr();
+        gen_goto_ptr(s);
         s->base.is_jmp = DISAS_NORETURN;
         break;
     default:
@@ -6858,7 +6858,7 @@ static void arm_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
             gen_update_pc(dc, curr_insn_len(dc));
             /* fall through */
         case DISAS_JUMP:
-            gen_goto_ptr();
+            gen_goto_ptr(dc);
             break;
         case DISAS_UPDATE_EXIT:
             gen_update_pc(dc, curr_insn_len(dc));
diff --git ./target/avr/translate.c ./target/avr/translate.c
index 3c57606097..8f2e0baa67 100644
--- ./target/avr/translate.c
+++ ./target/avr/translate.c
@@ -992,7 +992,7 @@ static void gen_goto_tb(DisasContext *ctx, unsigned tb_slot_idx,
         tcg_gen_exit_tb(tb, tb_slot_idx);
     } else {
         tcg_gen_movi_i32(cpu_pc, dest);
-        tcg_gen_lookup_and_goto_ptr();
+        tcg_gen_lookup_and_goto_ptr(NULL, ctx->base.tb);
     }
     ctx->base.is_jmp = DISAS_NORETURN;
 }
@@ -2778,7 +2778,7 @@ static void avr_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
         /* fall through */
     case DISAS_LOOKUP:
         if (!force_exit) {
-            tcg_gen_lookup_and_goto_ptr();
+            tcg_gen_lookup_and_goto_ptr(NULL, ctx->base.tb);
             break;
         }
         /* fall through */
diff --git ./target/hexagon/translate.c ./target/hexagon/translate.c
index 06a8159d28..cc230b08d1 100644
--- ./target/hexagon/translate.c
+++ ./target/hexagon/translate.c
@@ -181,7 +181,7 @@ static void gen_goto_tb(DisasContext *ctx, unsigned tb_slot_idx,
         if (move_to_pc) {
             tcg_gen_movi_tl(hex_gpr[HEX_REG_PC], dest);
         }
-        tcg_gen_lookup_and_goto_ptr();
+        tcg_gen_lookup_and_goto_ptr(NULL, ctx->base.tb);
     }
 }
 
@@ -218,7 +218,7 @@ static void gen_end_tb(DisasContext *ctx)
         gen_set_label(skip);
         gen_goto_tb(ctx, 1, ctx->next_PC, false);
     } else {
-        tcg_gen_lookup_and_goto_ptr();
+        tcg_gen_lookup_and_goto_ptr(NULL, ctx->base.tb);
     }
 
     ctx->base.is_jmp = DISAS_NORETURN;
diff --git ./target/hppa/translate.c ./target/hppa/translate.c
index 002189ddfb..cf8f1a2c13 100644
--- ./target/hppa/translate.c
+++ ./target/hppa/translate.c
@@ -816,7 +816,7 @@ static void gen_goto_tb(DisasContext *ctx, int which,
         tcg_gen_goto_tb(which);
         tcg_gen_exit_tb(ctx->base.tb, which);
     } else {
-        tcg_gen_lookup_and_goto_ptr();
+        tcg_gen_lookup_and_goto_ptr(NULL, ctx->base.tb);
     }
 }
 
@@ -2027,7 +2027,7 @@ static bool do_ibranch(DisasContext *ctx, unsigned link,
         store_psw_xb(ctx, PSW_B);
     }
 
-    tcg_gen_lookup_and_goto_ptr();
+    tcg_gen_lookup_and_goto_ptr(NULL, ctx->base.tb);
     ctx->base.is_jmp = DISAS_NORETURN;
     return nullify_end(ctx);
 }
@@ -4838,7 +4838,7 @@ static void hppa_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
         }
         /* FALLTHRU */
     case DISAS_IAQ_N_UPDATED:
-        tcg_gen_lookup_and_goto_ptr();
+        tcg_gen_lookup_and_goto_ptr(NULL, ctx->base.tb);
         break;
     case DISAS_EXIT:
         tcg_gen_exit_tb(NULL, 0);
diff --git ./target/i386/tcg/translate.c ./target/i386/tcg/translate.c
index 2115c5cd24..66a0ee3cdf 100644
--- ./target/i386/tcg/translate.c
+++ ./target/i386/tcg/translate.c
@@ -2005,7 +2005,7 @@ gen_eob(DisasContext *s, int mode)
     } else if (mode == DISAS_JUMP &&
                /* give irqs a chance to happen */
                !inhibit_reset) {
-        tcg_gen_lookup_and_goto_ptr();
+        tcg_gen_lookup_and_goto_ptr(NULL, s->base.tb);
     } else {
         tcg_gen_exit_tb(NULL, 0);
     }
diff --git ./target/loongarch/tcg/insn_trans/trans_branch.c.inc ./target/loongarch/tcg/insn_trans/trans_branch.c.inc
index da07778658..57d9d47353 100644
--- ./target/loongarch/tcg/insn_trans/trans_branch.c.inc
+++ ./target/loongarch/tcg/insn_trans/trans_branch.c.inc
@@ -27,7 +27,7 @@ static bool trans_jirl(DisasContext *ctx, arg_jirl *a)
     tcg_gen_mov_tl(cpu_pc, addr);
     tcg_gen_movi_tl(dest, make_address_pc(ctx, ctx->base.pc_next + 4));
     gen_set_gpr(a->rd, dest, EXT_NONE);
-    tcg_gen_lookup_and_goto_ptr();
+    tcg_gen_lookup_and_goto_ptr(cpu_pc, ctx->base.tb);
     ctx->base.is_jmp = DISAS_NORETURN;
     return true;
 }
diff --git ./target/loongarch/tcg/translate.c ./target/loongarch/tcg/translate.c
index 124dce6269..a45a51852a 100644
--- ./target/loongarch/tcg/translate.c
+++ ./target/loongarch/tcg/translate.c
@@ -111,7 +111,7 @@ static void gen_goto_tb(DisasContext *ctx, unsigned tb_slot_idx, vaddr dest)
         tcg_gen_exit_tb(ctx->base.tb, tb_slot_idx);
     } else {
         tcg_gen_movi_tl(cpu_pc, dest);
-        tcg_gen_lookup_and_goto_ptr();
+        tcg_gen_lookup_and_goto_ptr(cpu_pc, ctx->base.tb);
     }
 }
 
@@ -311,7 +311,7 @@ static void loongarch_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
     switch (ctx->base.is_jmp) {
     case DISAS_STOP:
         tcg_gen_movi_tl(cpu_pc, ctx->base.pc_next);
-        tcg_gen_lookup_and_goto_ptr();
+        tcg_gen_lookup_and_goto_ptr(cpu_pc, ctx->base.tb);
         break;
     case DISAS_TOO_MANY:
         gen_goto_tb(ctx, 0, ctx->base.pc_next);
diff --git ./target/m68k/translate.c ./target/m68k/translate.c
index 138c89d3e5..73691bc0d1 100644
--- ./target/m68k/translate.c
+++ ./target/m68k/translate.c
@@ -6095,7 +6095,7 @@ static void m68k_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
         if (dc->ss_active) {
             gen_raise_exception_format2(dc, EXCP_TRACE, dc->pc_prev);
         } else {
-            tcg_gen_lookup_and_goto_ptr();
+            tcg_gen_lookup_and_goto_ptr(NULL, dc->base.tb);
         }
         break;
     case DISAS_EXIT:
diff --git ./target/microblaze/translate.c ./target/microblaze/translate.c
index 8b219afb5d..851b372f8f 100644
--- ./target/microblaze/translate.c
+++ ./target/microblaze/translate.c
@@ -127,7 +127,7 @@ static void gen_goto_tb(DisasContext *dc, unsigned tb_slot_idx, vaddr dest)
         tcg_gen_exit_tb(dc->base.tb, tb_slot_idx);
     } else {
         tcg_gen_movi_i32(cpu_pc, dest);
-        tcg_gen_lookup_and_goto_ptr();
+        tcg_gen_lookup_and_goto_ptr_tmp(NULL, dc->base.tb);
     }
     dc->base.is_jmp = DISAS_NORETURN;
 }
@@ -1764,7 +1764,7 @@ static void mb_tr_tb_stop(DisasContextBase *dcb, CPUState *cs)
         /* Indirect jump (or direct jump w/ goto_tb disabled) */
         tcg_gen_mov_i32(cpu_pc, cpu_btarget);
         tcg_gen_discard_i32(cpu_btarget);
-        tcg_gen_lookup_and_goto_ptr();
+        tcg_gen_lookup_and_goto_ptr_tmp(NULL, dc->base.tb);
         return;
 
     default:
diff --git ./target/mips/tcg/nanomips_translate.c.inc ./target/mips/tcg/nanomips_translate.c.inc
index 4b0b01ba37..007e29f9ac 100644
--- ./target/mips/tcg/nanomips_translate.c.inc
+++ ./target/mips/tcg/nanomips_translate.c.inc
@@ -2406,7 +2406,7 @@ static void gen_compute_nanomips_pbalrsc_branch(DisasContext *ctx, int rs,
 
     /* unconditional branch to register */
     tcg_gen_mov_tl(cpu_PC, btarget);
-    tcg_gen_lookup_and_goto_ptr();
+    tcg_gen_lookup_and_goto_ptr(cpu_PC, ctx->base.tb);
 }
 
 /* nanoMIPS Branches */
diff --git ./target/mips/tcg/translate.c ./target/mips/tcg/translate.c
index e3467d1525..73abfbb5d4 100644
--- ./target/mips/tcg/translate.c
+++ ./target/mips/tcg/translate.c
@@ -4374,7 +4374,7 @@ static void gen_goto_tb(DisasContext *ctx, unsigned tb_slot_idx,
         tcg_gen_exit_tb(ctx->base.tb, tb_slot_idx);
     } else {
         gen_save_pc(dest);
-        tcg_gen_lookup_and_goto_ptr();
+        tcg_gen_lookup_and_goto_ptr(cpu_PC, ctx->base.tb);
     }
 }
 
@@ -11014,7 +11014,7 @@ static void gen_branch(DisasContext *ctx, int insn_bytes)
             } else {
                 tcg_gen_mov_tl(cpu_PC, btarget);
             }
-            tcg_gen_lookup_and_goto_ptr();
+            tcg_gen_lookup_and_goto_ptr(cpu_PC, ctx->base.tb);
             break;
         default:
             LOG_DISAS("unknown branch 0x%x\n", proc_hflags);
@@ -15244,7 +15244,7 @@ static void mips_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
     switch (ctx->base.is_jmp) {
     case DISAS_STOP:
         gen_save_pc(ctx->base.pc_next);
-        tcg_gen_lookup_and_goto_ptr();
+        tcg_gen_lookup_and_goto_ptr(cpu_PC, ctx->base.tb);
         break;
     case DISAS_NEXT:
     case DISAS_TOO_MANY:
diff --git ./target/or1k/translate.c ./target/or1k/translate.c
index eb4485312f..4907284a6d 100644
--- ./target/or1k/translate.c
+++ ./target/or1k/translate.c
@@ -1605,7 +1605,7 @@ static void openrisc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
             /* The jump destination is indirect/computed; use jmp_pc.  */
             tcg_gen_mov_i32(cpu_pc, jmp_pc);
             tcg_gen_discard_i32(jmp_pc);
-            tcg_gen_lookup_and_goto_ptr();
+            tcg_gen_lookup_and_goto_ptr(NULL, dc->base.tb);
             break;
         }
         /* The jump destination is direct; use jmp_pc_imm.
@@ -1622,7 +1622,7 @@ static void openrisc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
             break;
         }
         tcg_gen_movi_i32(cpu_pc, jmp_dest);
-        tcg_gen_lookup_and_goto_ptr();
+        tcg_gen_lookup_and_goto_ptr(NULL, dc->base.tb);
         break;
 
     case DISAS_EXIT:
diff --git ./target/ppc/translate.c ./target/ppc/translate.c
index 06ed2adf10..42924281b0 100644
--- ./target/ppc/translate.c
+++ ./target/ppc/translate.c
@@ -3664,7 +3664,7 @@ static void gen_lookup_and_goto_ptr(DisasContext *ctx)
             pmu_count_insns(ctx);
         }
 
-        tcg_gen_lookup_and_goto_ptr();
+        tcg_gen_lookup_and_goto_ptr(cpu_nip, ctx->base.tb);
     }
 }
 
@@ -6690,7 +6690,7 @@ static void ppc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
             pmu_count_insns(ctx);
         }
 
-        tcg_gen_lookup_and_goto_ptr();
+        tcg_gen_lookup_and_goto_ptr(cpu_nip, ctx->base.tb);
         break;
 
     case DISAS_EXIT_UPDATE:
diff --git ./target/riscv/tcg/insn_trans/trans_rvzce.c.inc ./target/riscv/tcg/insn_trans/trans_rvzce.c.inc
index 71b4ca5473..3f1e7c039e 100644
--- ./target/riscv/tcg/insn_trans/trans_rvzce.c.inc
+++ ./target/riscv/tcg/insn_trans/trans_rvzce.c.inc
@@ -213,7 +213,7 @@ static bool gen_pop(DisasContext *ctx, arg_cmpp *a, bool ret, bool ret_val)
         }
 #endif
         tcg_gen_mov_tl(cpu_pc, ret_addr);
-        tcg_gen_lookup_and_goto_ptr();
+        tcg_gen_lookup_and_goto_ptr(NULL, ctx->base.tb);
         ctx->base.is_jmp = DISAS_NORETURN;
     }
 
@@ -334,7 +334,7 @@ static bool trans_cm_jalt(DisasContext *ctx, arg_cm_jalt *a)
 
     tcg_gen_mov_tl(cpu_pc, addr);
 
-    tcg_gen_lookup_and_goto_ptr();
+    tcg_gen_lookup_and_goto_ptr(NULL, ctx->base.tb);
     ctx->base.is_jmp = DISAS_NORETURN;
     return true;
 }
diff --git ./target/riscv/tcg/translate.c ./target/riscv/tcg/translate.c
index 9684dbe752..8475ab43b4 100644
--- ./target/riscv/tcg/translate.c
+++ ./target/riscv/tcg/translate.c
@@ -287,7 +287,7 @@ static void lookup_and_goto_ptr(DisasContext *ctx)
         gen_helper_itrigger_match(tcg_env);
     }
 #endif
-    tcg_gen_lookup_and_goto_ptr();
+    tcg_gen_lookup_and_goto_ptr(NULL, ctx->base.tb);
 }
 
 static void exit_tb(DisasContext *ctx)
diff --git ./target/rx/translate.c ./target/rx/translate.c
index 132d495710..e5a9783d84 100644
--- ./target/rx/translate.c
+++ ./target/rx/translate.c
@@ -161,7 +161,7 @@ static void gen_goto_tb(DisasContext *dc, unsigned tb_slot_idx, vaddr dest)
         tcg_gen_exit_tb(dc->base.tb, tb_slot_idx);
     } else {
         tcg_gen_movi_i32(cpu_pc, dest);
-        tcg_gen_lookup_and_goto_ptr();
+        tcg_gen_lookup_and_goto_ptr(NULL, dc->base.tb);
     }
     dc->base.is_jmp = DISAS_NORETURN;
 }
@@ -2242,7 +2242,7 @@ static void rx_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
         gen_goto_tb(ctx, 0, dcbase->pc_next);
         break;
     case DISAS_JUMP:
-        tcg_gen_lookup_and_goto_ptr();
+        tcg_gen_lookup_and_goto_ptr(NULL, ctx->base.tb);
         break;
     case DISAS_UPDATE:
         tcg_gen_movi_i32(cpu_pc, ctx->base.pc_next);
diff --git ./target/s390x/tcg/translate.c ./target/s390x/tcg/translate.c
index 1b6023168b..607c039419 100644
--- ./target/s390x/tcg/translate.c
+++ ./target/s390x/tcg/translate.c
@@ -1162,7 +1162,7 @@ static DisasJumpType help_branch(DisasContext *s, DisasCompare *c,
         tcg_gen_goto_tb(0);
         tcg_gen_exit_tb(s->base.tb, 0);
     } else {
-        tcg_gen_lookup_and_goto_ptr();
+        tcg_gen_lookup_and_goto_ptr_tmp(tcgv_i64_temp(psw_addr), s->base.tb);
     }
 
     gen_set_label(lab);
@@ -6477,7 +6477,8 @@ static void s390x_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
         if (dc->exit_to_mainloop) {
             tcg_gen_exit_tb(NULL, 0);
         } else {
-            tcg_gen_lookup_and_goto_ptr();
+            tcg_gen_lookup_and_goto_ptr_tmp(tcgv_i64_temp(psw_addr),
+                                            dc->base.tb);
         }
         break;
     default:
diff --git ./target/sh4/translate.c ./target/sh4/translate.c
index 373950fd66..a4be456bd9 100644
--- ./target/sh4/translate.c
+++ ./target/sh4/translate.c
@@ -242,7 +242,7 @@ static void gen_goto_tb(DisasContext *ctx, unsigned tb_slot_idx, vaddr dest)
         if (use_exit_tb(ctx)) {
             tcg_gen_exit_tb(NULL, 0);
         } else {
-            tcg_gen_lookup_and_goto_ptr();
+            tcg_gen_lookup_and_goto_ptr(NULL, ctx->base.tb);
         }
     }
     ctx->base.is_jmp = DISAS_NORETURN;
@@ -258,7 +258,7 @@ static void gen_jump(DisasContext * ctx)
         if (use_exit_tb(ctx)) {
             tcg_gen_exit_tb(NULL, 0);
         } else {
-            tcg_gen_lookup_and_goto_ptr();
+            tcg_gen_lookup_and_goto_ptr(NULL, ctx->base.tb);
         }
         ctx->base.is_jmp = DISAS_NORETURN;
     } else {
diff --git ./target/sparc/translate.c ./target/sparc/translate.c
index 3156be6a94..2ae0a02c44 100644
--- ./target/sparc/translate.c
+++ ./target/sparc/translate.c
@@ -376,7 +376,7 @@ static void gen_goto_tb(DisasContext *s, unsigned tb_slot_idx,
         /* jump to another page: we can use an indirect jump */
         tcg_gen_movi_tl(cpu_pc, pc);
         tcg_gen_movi_tl(cpu_npc, npc);
-        tcg_gen_lookup_and_goto_ptr();
+        tcg_gen_lookup_and_goto_ptr(NULL, s->base.tb);
     }
 }
 
@@ -5807,7 +5807,7 @@ static void sparc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
             tcg_gen_movi_tl(cpu_npc, dc->npc);
         }
         if (may_lookup) {
-            tcg_gen_lookup_and_goto_ptr();
+            tcg_gen_lookup_and_goto_ptr(NULL, dc->base.tb);
         } else {
             tcg_gen_exit_tb(NULL, 0);
         }
diff --git ./target/tricore/translate.c ./target/tricore/translate.c
index 8cd6b58f66..1d7f54f6df 100644
--- ./target/tricore/translate.c
+++ ./target/tricore/translate.c
@@ -2857,7 +2857,7 @@ static void gen_goto_tb(DisasContext *ctx, unsigned tb_slot_index, vaddr dest)
         tcg_gen_exit_tb(ctx->base.tb, tb_slot_index);
     } else {
         gen_save_pc(dest);
-        tcg_gen_lookup_and_goto_ptr();
+        tcg_gen_lookup_and_goto_ptr(NULL, ctx->base.tb);
     }
     ctx->base.is_jmp = DISAS_NORETURN;
 }
@@ -8478,7 +8478,7 @@ static void tricore_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
         tcg_gen_exit_tb(NULL, 0);
         break;
     case DISAS_JUMP:
-        tcg_gen_lookup_and_goto_ptr();
+        tcg_gen_lookup_and_goto_ptr(NULL, ctx->base.tb);
         break;
     case DISAS_NORETURN:
         break;
diff --git ./tcg/tcg-op.c ./tcg/tcg-op.c
index 28d3b2a847..2fda6e5c07 100644
--- ./tcg/tcg-op.c
+++ ./tcg/tcg-op.c
@@ -2715,7 +2715,7 @@ void tcg_gen_goto_tb(unsigned idx)
     tcg_gen_op1i(INDEX_op_goto_tb, 0, idx);
 }
 
-void tcg_gen_lookup_and_goto_ptr(void)
+void tcg_gen_lookup_and_goto_ptr_tmp(TCGTemp *pc, const TranslationBlock *tb)
 {
     TCGv_ptr ptr;
 
@@ -2725,6 +2725,7 @@ void tcg_gen_lookup_and_goto_ptr(void)
     }
 
     plugin_gen_disable_mem_helpers();
+
     ptr = tcg_temp_ebb_new_ptr();
     gen_helper_lookup_tb_ptr(ptr, tcg_env);
     tcg_gen_op1i(INDEX_op_goto_ptr, TCG_TYPE_PTR, tcgv_ptr_arg(ptr));
-- 
2.54.0


