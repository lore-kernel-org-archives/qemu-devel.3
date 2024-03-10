Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CDB2C54E58
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Mar 2024 11:55:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjHkf-0007tm-5b; Sun, 10 Mar 2024 07:54:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rjHkc-0007rf-Fo
 for qemu-devel@nongnu.org; Sun, 10 Mar 2024 07:53:58 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rjHkZ-00045S-N9
 for qemu-devel@nongnu.org; Sun, 10 Mar 2024 07:53:58 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6e5dddd3b95so2519652b3a.1
 for <qemu-devel@nongnu.org>; Sun, 10 Mar 2024 04:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710071633; x=1710676433; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=clxLarVfm96FQhFWe3+r/40YYNIvZDUOLCoWs9HtyxY=;
 b=aws87+E+q9iCAZ6Ij0AtYNWUaPWUPU2EsTZRPwyHeVAfs0IpV9R7yEjxCOUhEG8o0E
 5dX3V4IOBmtbcSSr1yWv+cRQbLkfDZVnyD+q5lY+TMIFinM/1vp5Vql1c4O8sjZF6XIS
 QQNydc0P5CSKgljw33b709qi2CYmVdqYgphEOU4PmH0VgBFvQEhOsYJ0qpZcEZ9eqYqz
 CjicSK0vooXNMGv6lmOc3TQf0wnvQylUpUqWwg0MuVKOyHsL4Rav3PA7VMLyeIuPRMF4
 QPptlvEX44owEpKat7ZIb1vHbHh63B8SyeQlmnibei/PsAq6/wRdSucCfJJeVHIE2OqJ
 Djwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710071633; x=1710676433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=clxLarVfm96FQhFWe3+r/40YYNIvZDUOLCoWs9HtyxY=;
 b=OnM4sBlt7ioWbtDC4hHFuiOIQk0n4kj5AwwQcCkBXMmagtbkkMj/bot/8ZCSSk3i9z
 Xuk4R1H7RhrbLcEx0wbHCj2zESVwHaOGG34/Z5pRwiApv3baQXev0sCBK/oy3yDBon5p
 gezpHabu5qrGWpp/gxFhR5S9N7qGvRvQ+UTSorrodndbD38xtkIMywSEdoyIYH5shyk4
 m4czp3nIDu1urcX81S1EAl4RlvbwG+TeuM7ScFwj3wqJMaBoISoc+YJTeUgRwBLw7MhQ
 edSA5gMo/guTnajBXebLag79xh/FXo7U0lUKwQR9OqCWNP2P1rvYsWGjdWV99xIrFEyr
 UaYQ==
X-Gm-Message-State: AOJu0YxXZFLTwKcJSNXmF+Y0FF/BTa+f6BP4mxOk/0iNTuTnaZOkw3F3
 4lphSmZKjTAkB75QVE/zUkafca+FSBhnHhXZIq3ANBfLV9+jSdBRinxp6XtJQzBzj9/kJYNlf8f
 v
X-Google-Smtp-Source: AGHT+IFScVmCozFgPJyT4vfSbawFNnfGwQ1oRPu/nIrqbPPwzXHcBXhjbv6iaA89tuerddQwT+wPvQ==
X-Received: by 2002:a05:6a00:6c9c:b0:6e6:5291:1779 with SMTP id
 jc28-20020a056a006c9c00b006e652911779mr6991406pfb.6.1710071633262; 
 Sun, 10 Mar 2024 04:53:53 -0700 (PDT)
Received: from grind.. ([177.94.15.159]) by smtp.gmail.com with ESMTPSA id
 g22-20020aa78196000000b006e647059cccsm2449253pfi.33.2024.03.10.04.53.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Mar 2024 04:53:52 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, philmd@linaro.org,
 Ivan Klokov <ivan.klokov@syntacore.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v10 09/10] target/riscv: enable 'vstart_qe_zero' in the end of
 insns
Date: Sun, 10 Mar 2024 08:53:13 -0300
Message-ID: <20240310115315.187283-10-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240310115315.187283-1-dbarboza@ventanamicro.com>
References: <20240310115315.187283-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Ivan Klokov <ivan.klokov@syntacore.com>

The vstart_qe_zero flag is updated at the beginning of the translation
phase from the env->vstart variable. During the execution phase all
functions will set env->vstart = 0 after a successful execution, but the
vstart_eq_zero flag remains the same as at the start of the block. This
will wrongly cause SIGILLs in translations that requires env->vstart = 0
and might be reading vstart_eq_zero = false.

This patch adds a new finalize_rvv_inst() helper that is called at the
end of each vector instruction that will both update vstart_eq_zero and
do a mark_vs_dirty().

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1976
Signed-off-by: Ivan Klokov <ivan.klokov@syntacore.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_rvbf16.c.inc |  6 +-
 target/riscv/insn_trans/trans_rvv.c.inc    | 83 ++++++++++++----------
 target/riscv/insn_trans/trans_rvvk.c.inc   | 12 ++--
 target/riscv/translate.c                   |  6 ++
 4 files changed, 59 insertions(+), 48 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvbf16.c.inc b/target/riscv/insn_trans/trans_rvbf16.c.inc
index a842e76a6b..0a9cd1ec31 100644
--- a/target/riscv/insn_trans/trans_rvbf16.c.inc
+++ b/target/riscv/insn_trans/trans_rvbf16.c.inc
@@ -83,7 +83,7 @@ static bool trans_vfncvtbf16_f_f_w(DisasContext *ctx, arg_vfncvtbf16_f_f_w *a)
                            ctx->cfg_ptr->vlenb,
                            ctx->cfg_ptr->vlenb, data,
                            gen_helper_vfncvtbf16_f_f_w);
-        mark_vs_dirty(ctx);
+        finalize_rvv_inst(ctx);
         return true;
     }
     return false;
@@ -108,7 +108,7 @@ static bool trans_vfwcvtbf16_f_f_v(DisasContext *ctx, arg_vfwcvtbf16_f_f_v *a)
                            ctx->cfg_ptr->vlenb,
                            ctx->cfg_ptr->vlenb, data,
                            gen_helper_vfwcvtbf16_f_f_v);
-        mark_vs_dirty(ctx);
+        finalize_rvv_inst(ctx);
         return true;
     }
     return false;
@@ -135,7 +135,7 @@ static bool trans_vfwmaccbf16_vv(DisasContext *ctx, arg_vfwmaccbf16_vv *a)
                            ctx->cfg_ptr->vlenb,
                            ctx->cfg_ptr->vlenb, data,
                            gen_helper_vfwmaccbf16_vv);
-        mark_vs_dirty(ctx);
+        finalize_rvv_inst(ctx);
         return true;
     }
     return false;
diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index b0f19dcd85..b3d467a874 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -167,7 +167,7 @@ static bool do_vsetvl(DisasContext *s, int rd, int rs1, TCGv s2)
 
     gen_helper_vsetvl(dst, tcg_env, s1, s2);
     gen_set_gpr(s, rd, dst);
-    mark_vs_dirty(s);
+    finalize_rvv_inst(s);
 
     gen_update_pc(s, s->cur_insn_len);
     lookup_and_goto_ptr(s);
@@ -187,7 +187,7 @@ static bool do_vsetivli(DisasContext *s, int rd, TCGv s1, TCGv s2)
 
     gen_helper_vsetvl(dst, tcg_env, s1, s2);
     gen_set_gpr(s, rd, dst);
-    mark_vs_dirty(s);
+    finalize_rvv_inst(s);
     gen_update_pc(s, s->cur_insn_len);
     lookup_and_goto_ptr(s);
     s->base.is_jmp = DISAS_NORETURN;
@@ -657,6 +657,7 @@ static bool ldst_us_trans(uint32_t vd, uint32_t rs1, uint32_t data,
         tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
     }
 
+    finalize_rvv_inst(s);
     return true;
 }
 
@@ -812,6 +813,7 @@ static bool ldst_stride_trans(uint32_t vd, uint32_t rs1, uint32_t rs2,
 
     fn(dest, mask, base, stride, tcg_env, desc);
 
+    finalize_rvv_inst(s);
     return true;
 }
 
@@ -913,6 +915,7 @@ static bool ldst_index_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
 
     fn(dest, mask, base, index, tcg_env, desc);
 
+    finalize_rvv_inst(s);
     return true;
 }
 
@@ -1043,7 +1046,7 @@ static bool ldff_trans(uint32_t vd, uint32_t rs1, uint32_t data,
 
     fn(dest, mask, base, tcg_env, desc);
 
-    mark_vs_dirty(s);
+    finalize_rvv_inst(s);
     return true;
 }
 
@@ -1100,6 +1103,7 @@ static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t nf,
 
     fn(dest, base, tcg_env, desc);
 
+    finalize_rvv_inst(s);
     return true;
 }
 
@@ -1189,7 +1193,7 @@ do_opivv_gvec(DisasContext *s, arg_rmrr *a, GVecGen3Fn *gvec_fn,
                            tcg_env, s->cfg_ptr->vlenb,
                            s->cfg_ptr->vlenb, data, fn);
     }
-    mark_vs_dirty(s);
+    finalize_rvv_inst(s);
     return true;
 }
 
@@ -1240,7 +1244,7 @@ static bool opivx_trans(uint32_t vd, uint32_t rs1, uint32_t vs2, uint32_t vm,
 
     fn(dest, mask, src1, src2, tcg_env, desc);
 
-    mark_vs_dirty(s);
+    finalize_rvv_inst(s);
     return true;
 }
 
@@ -1265,7 +1269,7 @@ do_opivx_gvec(DisasContext *s, arg_rmrr *a, GVecGen2sFn *gvec_fn,
         gvec_fn(s->sew, vreg_ofs(s, a->rd), vreg_ofs(s, a->rs2),
                 src1, MAXSZ(s), MAXSZ(s));
 
-        mark_vs_dirty(s);
+        finalize_rvv_inst(s);
         return true;
     }
     return opivx_trans(a->rd, a->rs1, a->rs2, a->vm, fn, s);
@@ -1398,7 +1402,7 @@ static bool opivi_trans(uint32_t vd, uint32_t imm, uint32_t vs2, uint32_t vm,
 
     fn(dest, mask, src1, src2, tcg_env, desc);
 
-    mark_vs_dirty(s);
+    finalize_rvv_inst(s);
     return true;
 }
 
@@ -1412,7 +1416,7 @@ do_opivi_gvec(DisasContext *s, arg_rmrr *a, GVecGen2iFn *gvec_fn,
     if (a->vm && s->vl_eq_vlmax && !(s->vta && s->lmul < 0)) {
         gvec_fn(s->sew, vreg_ofs(s, a->rd), vreg_ofs(s, a->rs2),
                 extract_imm(s, a->rs1, imm_mode), MAXSZ(s), MAXSZ(s));
-        mark_vs_dirty(s);
+        finalize_rvv_inst(s);
         return true;
     }
     return opivi_trans(a->rd, a->rs1, a->rs2, a->vm, fn, s, imm_mode);
@@ -1471,7 +1475,7 @@ static bool do_opivv_widen(DisasContext *s, arg_rmrr *a,
                            tcg_env, s->cfg_ptr->vlenb,
                            s->cfg_ptr->vlenb,
                            data, fn);
-        mark_vs_dirty(s);
+        finalize_rvv_inst(s);
         return true;
     }
     return false;
@@ -1543,7 +1547,7 @@ static bool do_opiwv_widen(DisasContext *s, arg_rmrr *a,
                            vreg_ofs(s, a->rs2),
                            tcg_env, s->cfg_ptr->vlenb,
                            s->cfg_ptr->vlenb, data, fn);
-        mark_vs_dirty(s);
+        finalize_rvv_inst(s);
         return true;
     }
     return false;
@@ -1611,7 +1615,7 @@ static bool opivv_trans(uint32_t vd, uint32_t vs1, uint32_t vs2, uint32_t vm,
     tcg_gen_gvec_4_ptr(vreg_ofs(s, vd), vreg_ofs(s, 0), vreg_ofs(s, vs1),
                        vreg_ofs(s, vs2), tcg_env, s->cfg_ptr->vlenb,
                        s->cfg_ptr->vlenb, data, fn);
-    mark_vs_dirty(s);
+    finalize_rvv_inst(s);
     return true;
 }
 
@@ -1744,7 +1748,7 @@ do_opivx_gvec_shift(DisasContext *s, arg_rmrr *a, GVecGen2sFn32 *gvec_fn,
         gvec_fn(s->sew, vreg_ofs(s, a->rd), vreg_ofs(s, a->rs2),
                 src1, MAXSZ(s), MAXSZ(s));
 
-        mark_vs_dirty(s);
+        finalize_rvv_inst(s);
         return true;
     }
     return opivx_trans(a->rd, a->rs1, a->rs2, a->vm, fn, s);
@@ -1801,7 +1805,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
                            s->cfg_ptr->vlenb,                      \
                            s->cfg_ptr->vlenb, data,                \
                            fns[s->sew]);                           \
-        mark_vs_dirty(s);                                          \
+        finalize_rvv_inst(s);                                      \
         return true;                                               \
     }                                                              \
     return false;                                                  \
@@ -2004,7 +2008,7 @@ static bool trans_vmv_v_v(DisasContext *s, arg_vmv_v_v *a)
                                s->cfg_ptr->vlenb, data,
                                fns[s->sew]);
         }
-        mark_vs_dirty(s);
+        finalize_rvv_inst(s);
         return true;
     }
     return false;
@@ -2049,7 +2053,7 @@ static bool trans_vmv_v_x(DisasContext *s, arg_vmv_v_x *a)
             fns[s->sew](dest, s1_i64, tcg_env, desc);
         }
 
-        mark_vs_dirty(s);
+        finalize_rvv_inst(s);
         return true;
     }
     return false;
@@ -2083,7 +2087,7 @@ static bool trans_vmv_v_i(DisasContext *s, arg_vmv_v_i *a)
             tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, a->rd));
             fns[s->sew](dest, s1, tcg_env, desc);
         }
-        mark_vs_dirty(s);
+        finalize_rvv_inst(s);
         return true;
     }
     return false;
@@ -2231,7 +2235,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
                            s->cfg_ptr->vlenb,                      \
                            s->cfg_ptr->vlenb, data,                \
                            fns[s->sew - 1]);                       \
-        mark_vs_dirty(s);                                          \
+        finalize_rvv_inst(s);                                      \
         return true;                                               \
     }                                                              \
     return false;                                                  \
@@ -2265,7 +2269,7 @@ static bool opfvf_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
 
     fn(dest, mask, t1, src2, tcg_env, desc);
 
-    mark_vs_dirty(s);
+    finalize_rvv_inst(s);
     return true;
 }
 
@@ -2340,7 +2344,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)           \
                            s->cfg_ptr->vlenb,                    \
                            s->cfg_ptr->vlenb, data,              \
                            fns[s->sew - 1]);                     \
-        mark_vs_dirty(s);                                        \
+        finalize_rvv_inst(s);                                    \
         return true;                                             \
     }                                                            \
     return false;                                                \
@@ -2411,7 +2415,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
                            s->cfg_ptr->vlenb,                      \
                            s->cfg_ptr->vlenb, data,                \
                            fns[s->sew - 1]);                       \
-        mark_vs_dirty(s);                                          \
+        finalize_rvv_inst(s);                                      \
         return true;                                               \
     }                                                              \
     return false;                                                  \
@@ -2523,7 +2527,7 @@ static bool do_opfv(DisasContext *s, arg_rmr *a,
                            vreg_ofs(s, a->rs2), tcg_env,
                            s->cfg_ptr->vlenb,
                            s->cfg_ptr->vlenb, data, fn);
-        mark_vs_dirty(s);
+        finalize_rvv_inst(s);
         return true;
     }
     return false;
@@ -2633,7 +2637,7 @@ static bool trans_vfmv_v_f(DisasContext *s, arg_vfmv_v_f *a)
 
             fns[s->sew - 1](dest, t1, tcg_env, desc);
         }
-        mark_vs_dirty(s);
+        finalize_rvv_inst(s);
         return true;
     }
     return false;
@@ -2705,7 +2709,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
                            s->cfg_ptr->vlenb,                      \
                            s->cfg_ptr->vlenb, data,                \
                            fns[s->sew - 1]);                       \
-        mark_vs_dirty(s);                                          \
+        finalize_rvv_inst(s);                                      \
         return true;                                               \
     }                                                              \
     return false;                                                  \
@@ -2753,7 +2757,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
                            s->cfg_ptr->vlenb,                      \
                            s->cfg_ptr->vlenb, data,                \
                            fns[s->sew]);                           \
-        mark_vs_dirty(s);                                          \
+        finalize_rvv_inst(s);                                      \
         return true;                                               \
     }                                                              \
     return false;                                                  \
@@ -2817,7 +2821,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
                            s->cfg_ptr->vlenb,                      \
                            s->cfg_ptr->vlenb, data,                \
                            fns[s->sew - 1]);                       \
-        mark_vs_dirty(s);                                          \
+        finalize_rvv_inst(s);                                      \
         return true;                                               \
     }                                                              \
     return false;                                                  \
@@ -2863,7 +2867,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
                            s->cfg_ptr->vlenb,                      \
                            s->cfg_ptr->vlenb, data,                \
                            fns[s->sew]);                           \
-        mark_vs_dirty(s);                                          \
+        finalize_rvv_inst(s);                                      \
         return true;                                               \
     }                                                              \
     return false;                                                  \
@@ -2949,7 +2953,7 @@ static bool trans_##NAME(DisasContext *s, arg_r *a)                \
                            vreg_ofs(s, a->rs2), tcg_env,           \
                            s->cfg_ptr->vlenb,                      \
                            s->cfg_ptr->vlenb, data, fn);           \
-        mark_vs_dirty(s);                                          \
+        finalize_rvv_inst(s);                                      \
         return true;                                               \
     }                                                              \
     return false;                                                  \
@@ -3048,7 +3052,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
                            tcg_env, s->cfg_ptr->vlenb,             \
                            s->cfg_ptr->vlenb,                      \
                            data, fn);                              \
-        mark_vs_dirty(s);                                          \
+        finalize_rvv_inst(s);                                      \
         return true;                                               \
     }                                                              \
     return false;                                                  \
@@ -3087,7 +3091,7 @@ static bool trans_viota_m(DisasContext *s, arg_viota_m *a)
                            vreg_ofs(s, a->rs2), tcg_env,
                            s->cfg_ptr->vlenb,
                            s->cfg_ptr->vlenb, data, fns[s->sew]);
-        mark_vs_dirty(s);
+        finalize_rvv_inst(s);
         return true;
     }
     return false;
@@ -3114,7 +3118,7 @@ static bool trans_vid_v(DisasContext *s, arg_vid_v *a)
                            tcg_env, s->cfg_ptr->vlenb,
                            s->cfg_ptr->vlenb,
                            data, fns[s->sew]);
-        mark_vs_dirty(s);
+        finalize_rvv_inst(s);
         return true;
     }
     return false;
@@ -3271,7 +3275,7 @@ static bool trans_vmv_x_s(DisasContext *s, arg_vmv_x_s *a)
         tcg_gen_trunc_i64_tl(dest, t1);
         gen_set_gpr(s, a->rd, dest);
         tcg_gen_movi_tl(cpu_vstart, 0);
-        mark_vs_dirty(s);
+        finalize_rvv_inst(s);
         return true;
     }
     return false;
@@ -3300,7 +3304,7 @@ static bool trans_vmv_s_x(DisasContext *s, arg_vmv_s_x *a)
         vec_element_storei(s, a->rd, 0, t1);
         gen_set_label(over);
         tcg_gen_movi_tl(cpu_vstart, 0);
-        mark_vs_dirty(s);
+        finalize_rvv_inst(s);
         return true;
     }
     return false;
@@ -3328,7 +3332,7 @@ static bool trans_vfmv_f_s(DisasContext *s, arg_vfmv_f_s *a)
 
         mark_fs_dirty(s);
         tcg_gen_movi_tl(cpu_vstart, 0);
-        mark_vs_dirty(s);
+        finalize_rvv_inst(s);
         return true;
     }
     return false;
@@ -3354,9 +3358,10 @@ static bool trans_vfmv_s_f(DisasContext *s, arg_vfmv_s_f *a)
         do_nanbox(s, t1, cpu_fpr[a->rs1]);
 
         vec_element_storei(s, a->rd, 0, t1);
+
         gen_set_label(over);
         tcg_gen_movi_tl(cpu_vstart, 0);
-        mark_vs_dirty(s);
+        finalize_rvv_inst(s);
         return true;
     }
     return false;
@@ -3462,7 +3467,7 @@ static bool trans_vrgather_vx(DisasContext *s, arg_rmrr *a)
 
         tcg_gen_gvec_dup_i64(s->sew, vreg_ofs(s, a->rd),
                              MAXSZ(s), MAXSZ(s), dest);
-        mark_vs_dirty(s);
+        finalize_rvv_inst(s);
     } else {
         static gen_helper_opivx * const fns[4] = {
             gen_helper_vrgather_vx_b, gen_helper_vrgather_vx_h,
@@ -3490,7 +3495,7 @@ static bool trans_vrgather_vi(DisasContext *s, arg_rmrr *a)
                                  endian_ofs(s, a->rs2, a->rs1),
                                  MAXSZ(s), MAXSZ(s));
         }
-        mark_vs_dirty(s);
+        finalize_rvv_inst(s);
     } else {
         static gen_helper_opivx * const fns[4] = {
             gen_helper_vrgather_vx_b, gen_helper_vrgather_vx_h,
@@ -3535,7 +3540,7 @@ static bool trans_vcompress_vm(DisasContext *s, arg_r *a)
                            tcg_env, s->cfg_ptr->vlenb,
                            s->cfg_ptr->vlenb, data,
                            fns[s->sew]);
-        mark_vs_dirty(s);
+        finalize_rvv_inst(s);
         return true;
     }
     return false;
@@ -3560,7 +3565,7 @@ static bool trans_##NAME(DisasContext *s, arg_##NAME * a)               \
             tcg_gen_gvec_2_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, a->rs2), \
                                tcg_env, maxsz, maxsz, 0, gen_helper_vmvr_v); \
         }                                                               \
-        mark_vs_dirty(s);                                               \
+        finalize_rvv_inst(s);                                           \
         return true;                                                    \
     }                                                                   \
     return false;                                                       \
@@ -3631,7 +3636,7 @@ static bool int_ext_op(DisasContext *s, arg_rmr *a, uint8_t seq)
                        s->cfg_ptr->vlenb,
                        s->cfg_ptr->vlenb, data, fn);
 
-    mark_vs_dirty(s);
+    finalize_rvv_inst(s);
     return true;
 }
 
diff --git a/target/riscv/insn_trans/trans_rvvk.c.inc b/target/riscv/insn_trans/trans_rvvk.c.inc
index 6d640e4596..ae1f40174a 100644
--- a/target/riscv/insn_trans/trans_rvvk.c.inc
+++ b/target/riscv/insn_trans/trans_rvvk.c.inc
@@ -174,7 +174,7 @@ GEN_OPIVX_GVEC_TRANS_CHECK(vandn_vx, andcs, zvkb_vx_check)
                                vreg_ofs(s, a->rs2), tcg_env,               \
                                s->cfg_ptr->vlenb, s->cfg_ptr->vlenb,       \
                                data, fns[s->sew]);                         \
-            mark_vs_dirty(s);                                              \
+            finalize_rvv_inst(s);                                          \
             return true;                                                   \
         }                                                                  \
         return false;                                                      \
@@ -266,7 +266,7 @@ GEN_OPIVI_WIDEN_TRANS(vwsll_vi, IMM_ZX, vwsll_vx, vwsll_vx_check)
             tcg_gen_addi_ptr(rd_v, tcg_env, vreg_ofs(s, a->rd));              \
             tcg_gen_addi_ptr(rs2_v, tcg_env, vreg_ofs(s, a->rs2));            \
             gen_helper_##NAME(rd_v, rs2_v, tcg_env, desc);                    \
-            mark_vs_dirty(s);                                                 \
+            finalize_rvv_inst(s);                                             \
             return true;                                                      \
         }                                                                     \
         return false;                                                         \
@@ -341,7 +341,7 @@ GEN_V_UNMASKED_TRANS(vaesem_vs, vaes_check_vs, ZVKNED_EGS)
             tcg_gen_addi_ptr(rd_v, tcg_env, vreg_ofs(s, a->rd));              \
             tcg_gen_addi_ptr(rs2_v, tcg_env, vreg_ofs(s, a->rs2));            \
             gen_helper_##NAME(rd_v, rs2_v, uimm_v, tcg_env, desc);            \
-            mark_vs_dirty(s);                                                 \
+            finalize_rvv_inst(s);                                             \
             return true;                                                      \
         }                                                                     \
         return false;                                                         \
@@ -405,7 +405,7 @@ GEN_VI_UNMASKED_TRANS(vaeskf2_vi, vaeskf2_check, ZVKNED_EGS)
                                s->cfg_ptr->vlenb, s->cfg_ptr->vlenb,          \
                                data, gen_helper_##NAME);                      \
                                                                               \
-            mark_vs_dirty(s);                                                 \
+            finalize_rvv_inst(s);                                             \
             return true;                                                      \
         }                                                                     \
         return false;                                                         \
@@ -457,7 +457,7 @@ static bool trans_vsha2cl_vv(DisasContext *s, arg_rmrr *a)
             s->sew == MO_32 ?
                 gen_helper_vsha2cl32_vv : gen_helper_vsha2cl64_vv);
 
-        mark_vs_dirty(s);
+        finalize_rvv_inst(s);
         return true;
     }
     return false;
@@ -488,7 +488,7 @@ static bool trans_vsha2ch_vv(DisasContext *s, arg_rmrr *a)
             s->sew == MO_32 ?
                 gen_helper_vsha2ch32_vv : gen_helper_vsha2ch64_vv);
 
-        mark_vs_dirty(s);
+        finalize_rvv_inst(s);
         return true;
     }
     return false;
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index ea5d52b2ef..9d57089fcc 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -676,6 +676,12 @@ static void mark_vs_dirty(DisasContext *ctx)
 static inline void mark_vs_dirty(DisasContext *ctx) { }
 #endif
 
+static void finalize_rvv_inst(DisasContext *ctx)
+{
+    mark_vs_dirty(ctx);
+    ctx->vstart_eq_zero = true;
+}
+
 static void gen_set_rm(DisasContext *ctx, int rm)
 {
     if (ctx->frm == rm) {
-- 
2.43.2


