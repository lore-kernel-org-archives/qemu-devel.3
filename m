Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83220C48BC4
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 13:59:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rayj1-0006fH-Lz; Fri, 16 Feb 2024 08:57:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rayit-0006PV-30
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 08:57:52 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rayig-0003eq-1e
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 08:57:50 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1d51ba18e1bso21359955ad.0
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 05:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1708091855; x=1708696655; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9OrXw+6O3YfHBgx/rcrbMpH4N4DiM1hCF2q4fYF8Wxg=;
 b=FqkTN44MQtqcuX/vOxhBrN7YTUrjnTmOZ3nsl3aa+0nArV4XGmV81fFmwPx1hO/4WE
 lpb4NUzxKUdE8BGLY6mp0nkXWOw9l8LWhsLZl1rHCoDA+FfXBzDr0WR7wwKcgQ/G3WfK
 Hs8FH3X2m0ZlogcF/ZVp00bsBYL9NWwefzMeRq7yhC8+t2rhAEDFH2tgU6D74l/OBLbX
 cfyplsUbb/z3fLtYZhRHsTpMtv8CmgoP24//CFWUrb5o4WmjgrljY5xyUM/3cUkjgum1
 GtOhX4uSmr+CC/BqJtJg7DYKmVbkRRUHMjHlpleeJqWDE7HR345DpJWGxenYeOY4jcmG
 3vCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708091855; x=1708696655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9OrXw+6O3YfHBgx/rcrbMpH4N4DiM1hCF2q4fYF8Wxg=;
 b=VGYDfp+Wv6JTbOXr9N/1XSv2MhjFlEoKBM7fxNZxcyPzJ5E9dsXsvyDAD83XUTNhtm
 8O+OjPUbZzM55ZkFAKvJWkVqgzi4gX+CDRdu/7Yyp6CIMFnGe0Ra6FwddMlQthYshkd8
 aIrcBEJmtysnOU3zsDBC16xPHjVVlclzj3tPyhJb4dRdFWmNiQ5R1vNoA+UVHtl/zt7y
 p8MFUcbCFSikBPiJMSgEf5wletr0QVIRkcPjHXqHbxOXzwONgHlBNLptVpVCujzMErFj
 2jkvr8opGjWNoo8Lgb2QMTHVlD40ZCdcXEBBdLIqh93O0koWN6BZdfQN/G7McGF99wzY
 SYKQ==
X-Gm-Message-State: AOJu0Yx7WOfffkDIc1TiPB1QndwCU36DnADCrWSC5xU92tl8u2PYPJ9R
 am91wMyI7geuirDx0ZR2cu4mNlUl8mCNjQ/zOcAFlssIupn9wrJjJ4ZSkhYIN39DQZo5CnSPzdj
 c
X-Google-Smtp-Source: AGHT+IFJF2oXWFQmk6xSFLyBlJHYiAxF5+BVNm1lZRmieSMhei1KpZsiSGuBo0CHEzogemPNtt7DtA==
X-Received: by 2002:a17:903:183:b0:1db:35b5:7e3e with SMTP id
 z3-20020a170903018300b001db35b57e3emr6520446plg.29.1708091854863; 
 Fri, 16 Feb 2024 05:57:34 -0800 (PST)
Received: from grind.. ([177.94.15.159]) by smtp.gmail.com with ESMTPSA id
 j18-20020a170902c3d200b001dbb06b6138sm889606plj.252.2024.02.16.05.57.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 05:57:34 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, max.chou@sifive.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 2/3] trans_rvv.c.inc: remove redundant mark_vs_dirty() calls
Date: Fri, 16 Feb 2024 10:57:18 -0300
Message-ID: <20240216135719.1034289-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240216135719.1034289-1-dbarboza@ventanamicro.com>
References: <20240216135719.1034289-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
 target/riscv/insn_trans/trans_rvv.c.inc | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 044c9c903e..778e2723dd 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -2094,7 +2094,6 @@ static bool trans_vmv_v_i(DisasContext *s, arg_vmv_v_i *a)
         if (s->vl_eq_vlmax && !(s->vta && s->lmul < 0)) {
             tcg_gen_gvec_dup_imm(s->sew, vreg_ofs(s, a->rd),
                                  MAXSZ(s), MAXSZ(s), simm);
-            mark_vs_dirty(s);
         } else {
             TCGv_i32 desc;
             TCGv_i64 s1;
@@ -2115,9 +2114,9 @@ static bool trans_vmv_v_i(DisasContext *s, arg_vmv_v_i *a)
             tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, a->rd));
             fns[s->sew](dest, s1, tcg_env, desc);
 
-            mark_vs_dirty(s);
             gen_set_label(over);
         }
+        mark_vs_dirty(s);
         return true;
     }
     return false;
@@ -2660,7 +2659,6 @@ static bool trans_vfmv_v_f(DisasContext *s, arg_vfmv_v_f *a)
 
             tcg_gen_gvec_dup_i64(s->sew, vreg_ofs(s, a->rd),
                                  MAXSZ(s), MAXSZ(s), t1);
-            mark_vs_dirty(s);
         } else {
             TCGv_ptr dest;
             TCGv_i32 desc;
@@ -2686,9 +2684,9 @@ static bool trans_vfmv_v_f(DisasContext *s, arg_vfmv_v_f *a)
 
             fns[s->sew - 1](dest, t1, tcg_env, desc);
 
-            mark_vs_dirty(s);
             gen_set_label(over);
         }
+        mark_vs_dirty(s);
         return true;
     }
     return false;
@@ -3632,15 +3630,14 @@ static bool trans_##NAME(DisasContext *s, arg_##NAME * a)               \
         if (s->vstart_eq_zero) {                                        \
             tcg_gen_gvec_mov(s->sew, vreg_ofs(s, a->rd),                \
                              vreg_ofs(s, a->rs2), maxsz, maxsz);        \
-            mark_vs_dirty(s);                                           \
         } else {                                                        \
             TCGLabel *over = gen_new_label();                           \
             tcg_gen_brcondi_tl(TCG_COND_GEU, cpu_vstart, maxsz, over);  \
             tcg_gen_gvec_2_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, a->rs2), \
                                tcg_env, maxsz, maxsz, 0, gen_helper_vmvr_v); \
-            mark_vs_dirty(s);                                           \
             gen_set_label(over);                                        \
         }                                                               \
+        mark_vs_dirty(s);                                               \
         return true;                                                    \
     }                                                                   \
     return false;                                                       \
-- 
2.43.0


