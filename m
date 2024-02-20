Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B5D0C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 19:28:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcVlK-0006Ua-74; Tue, 20 Feb 2024 14:26:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rcVlB-0006SS-1V
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 14:26:36 -0500
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rcVl7-0006Vv-0s
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 14:26:32 -0500
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-59a802ab9fdso1088563eaf.1
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 11:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1708457187; x=1709061987; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RP97G9uphpMqkCfn4ger4EfE4nuudJAXPqEJFx371X0=;
 b=eD4acb+oAr/Iydz8ikAb8mRpBT99kyE3hs3i9whZtK1HjqNCt+aFKmSSUrpOv8hxh5
 MMSwaV4pu5LrcafpU6b/uF7lzQf56K+0qYZ595vt7cG4FPO4tSaOEqWJZuMAwfJ/fOY3
 i5ICFmb/Wu4r3d0G1ZGWNFTgsuMnb/v/1P3bM37g6i36msm5MPBZYZzl1y/++XMnm8et
 CDlZqOI9YVeCIEWkP2NZ7MhtJevJyq5RXVZXMTAnN4SQc6dzjmDdeax/mJzekStaKoRx
 P3qBNUgmBUXqzCPCj8biKckB25EYhSoSrEW3dcJW/kh9U9CHcjP8QajxJu1SVMJTrtZM
 JIxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708457187; x=1709061987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RP97G9uphpMqkCfn4ger4EfE4nuudJAXPqEJFx371X0=;
 b=H3s/mygn0UTBJdp1nUeA/GREPBDRW3xfaYuVdXhh97q/YwbjI+GceZEhLEjK+DMWrl
 GM6w53LsQduVPNWwkGgavlQf8mopYHZqLbKe/OnXvirEOSwtIui61EyfhzIvRJxdshPZ
 XL1g4pkBYojWL2ed7a5+RM6TPvIwcDI1kjnnYBusz2Vsn6fEljFfjU6TBE+ncDQHehtB
 362q0eunYauzL7RzcEDVXxGCZDk9SlXYHv+mwPaeh9ySHjB4AL3uVbEAYeMXRwyu2RK1
 r6QH3CXnpb8zUbxgF+Ii+2uNHr2t13tdfSv2IPHzK0MQzoUWLFKXPOI9Wq4/cGjdWRro
 QZfg==
X-Gm-Message-State: AOJu0YynPM3rB3Dqy0YgsTs6YyoBrJzlKdf0x8oramPdR3phna+2c8BV
 r6BGoSY/HvVMmIhZumdiJoVw+VW7bZDGdTxhQkSVzA+qVJR1DtD7mE+RFO3tpA5iw41iXuqFMwU
 i
X-Google-Smtp-Source: AGHT+IEEASPJzlGErRsBKarwQWoVt/QKF+8Iz3ntcglkR1rFjZWQ3/YKgp6Ci7665OHYKCtozq+3Bw==
X-Received: by 2002:a05:6359:45a9:b0:17b:335c:fa07 with SMTP id
 no41-20020a05635945a900b0017b335cfa07mr10146355rwb.32.1708457187283; 
 Tue, 20 Feb 2024 11:26:27 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 i73-20020a636d4c000000b005b458aa0541sm6943005pgc.15.2024.02.20.11.26.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 11:26:26 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, max.chou@sifive.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 4/5] trans_rvv.c.inc: remove redundant mark_vs_dirty() calls
Date: Tue, 20 Feb 2024 16:26:06 -0300
Message-ID: <20240220192607.141880-5-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240220192607.141880-1-dbarboza@ventanamicro.com>
References: <20240220192607.141880-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc2c.google.com
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

trans_vmv_v_i , trans_vfmv_v_f and the trans_##NAME macro from
GEN_VMV_WHOLE_TRANS() are calling mark_vs_dirty() in both branches of
their 'ifs'. conditionals.

Call it just once in the end like other functions are doing.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index d80f50acdd..5436d9e3ef 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -2058,7 +2058,6 @@ static bool trans_vmv_v_i(DisasContext *s, arg_vmv_v_i *a)
         if (s->vl_eq_vlmax && !(s->vta && s->lmul < 0)) {
             tcg_gen_gvec_dup_imm(s->sew, vreg_ofs(s, a->rd),
                                  MAXSZ(s), MAXSZ(s), simm);
-            mark_vs_dirty(s);
         } else {
             TCGv_i32 desc;
             TCGv_i64 s1;
@@ -2076,9 +2075,8 @@ static bool trans_vmv_v_i(DisasContext *s, arg_vmv_v_i *a)
                                               s->cfg_ptr->vlenb, data));
             tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, a->rd));
             fns[s->sew](dest, s1, tcg_env, desc);
-
-            mark_vs_dirty(s);
         }
+        mark_vs_dirty(s);
         return true;
     }
     return false;
@@ -2605,7 +2603,6 @@ static bool trans_vfmv_v_f(DisasContext *s, arg_vfmv_v_f *a)
 
             tcg_gen_gvec_dup_i64(s->sew, vreg_ofs(s, a->rd),
                                  MAXSZ(s), MAXSZ(s), t1);
-            mark_vs_dirty(s);
         } else {
             TCGv_ptr dest;
             TCGv_i32 desc;
@@ -2628,9 +2625,8 @@ static bool trans_vfmv_v_f(DisasContext *s, arg_vfmv_v_f *a)
             tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, a->rd));
 
             fns[s->sew - 1](dest, t1, tcg_env, desc);
-
-            mark_vs_dirty(s);
         }
+        mark_vs_dirty(s);
         return true;
     }
     return false;
@@ -3538,12 +3534,11 @@ static bool trans_##NAME(DisasContext *s, arg_##NAME * a)               \
         if (s->vstart_eq_zero) {                                        \
             tcg_gen_gvec_mov(s->sew, vreg_ofs(s, a->rd),                \
                              vreg_ofs(s, a->rs2), maxsz, maxsz);        \
-            mark_vs_dirty(s);                                           \
         } else {                                                        \
             tcg_gen_gvec_2_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, a->rs2), \
                                tcg_env, maxsz, maxsz, 0, gen_helper_vmvr_v); \
-            mark_vs_dirty(s);                                           \
         }                                                               \
+        mark_vs_dirty(s);                                               \
         return true;                                                    \
     }                                                                   \
     return false;                                                       \
-- 
2.43.2


