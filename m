Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B86C54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 08:54:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnaf7-00040K-U4; Fri, 22 Mar 2024 04:54:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rnaf5-0003xF-Fk
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 04:54:03 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rnaf3-00011F-U9
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 04:54:03 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1dff837d674so14950935ad.3
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 01:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711097640; x=1711702440; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wWvKppuqYrGsgdS9wSeB9R/qpdaidAtK5C4zNP5nZZA=;
 b=bDKz51yG0hOwu5+WSY4qG6IYG8AbFkKm3W6KFiWjOlq5eNExgexsI2KlK0oAAo7pmI
 XQvd9LwnisPh36iK+kxa0FcQHPTICQ5ehfLaw3iR1Za+B2llnyvA3db7oPqd5zDIleTj
 i81Gy3q6FBNzSY30YFr9aV0O4FTWfVLcImlLU2UrpponHKsR4EDoVkwYHXXAkkyNurDD
 457f3fZoJ/Ixy6LMoqHu+530C5k7dseGCzTML/F4g0pX2KIayxY5Z6VqrxnhR9YVMbVG
 mjIIXCSm3sF/cmocK/u6kdRMgIV06G0HIylm68SN411H/JEwWK2dKzTkSoOS63meStLH
 fTYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711097640; x=1711702440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wWvKppuqYrGsgdS9wSeB9R/qpdaidAtK5C4zNP5nZZA=;
 b=crxuQui4I1RFGS1ilcKtyojF4FppCVLMdsEGRhTZwZmNlOb8ZcjOEg6bjweJuSEnJL
 LoZDNDSUTuamtccbmXYjLShg5HIwms9wm7LucZd4zvzuW2LkZ+LG8ZRKV621ePTfjZin
 T1OuEwvfzOpa5x401Ne2tzNA6IlqWEEJLnn1MGcw1kaqhMHc5aNXw6MyVnj6pMIwHZFp
 lO3lsblyDTOHPcWsg8bKDQsrLNZdCWbohB68A1XyqRksPyyEG/SgL2a9qyY2ecyNkVZe
 Mkge4TuUJvBNALaJPZbg99LXZ+5/3Xq5qH2VfKA4SY7HxzTrdlCqUj7BG2FEKpS81aeg
 PKFA==
X-Gm-Message-State: AOJu0Yyb48T/27NYzcijdL5WyuQLcvVlY54D0QoRCR/UTcbx0Roe1s59
 ItvkXR+QI94K6IE3ysvEkxA5a9KtcZEwH27Z+FWRBSwyHSsNc4joOzKAGPGT89PhBA==
X-Google-Smtp-Source: AGHT+IHwfKE7UJy/io8A9/WoYhVqJIA4aAgNzdojtA8wVpPjmoXZZSnZ+I0R6jz/KuLO3SyOnG37Pg==
X-Received: by 2002:a17:903:11c4:b0:1e0:64bd:51ac with SMTP id
 q4-20020a17090311c400b001e064bd51acmr2165727plh.22.1711097640023; 
 Fri, 22 Mar 2024 01:54:00 -0700 (PDT)
Received: from toolbox.wdc.com ([129.253.180.114])
 by smtp.gmail.com with ESMTPSA id
 h5-20020a170902680500b001ddde07af12sm1369048plk.143.2024.03.22.01.53.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Mar 2024 01:53:59 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/15] trans_rvv.c.inc: remove redundant mark_vs_dirty() calls
Date: Fri, 22 Mar 2024 18:53:13 +1000
Message-ID: <20240322085319.1758843-10-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322085319.1758843-1-alistair.francis@wdc.com>
References: <20240322085319.1758843-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x635.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

trans_vmv_v_i , trans_vfmv_v_f and the trans_##NAME macro from
GEN_VMV_WHOLE_TRANS() are calling mark_vs_dirty() in both branches of
their 'ifs'. conditionals.

Call it just once in the end like other functions are doing.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240314175704.478276-9-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 7931fb2f3f..401ee939b8 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -2065,7 +2065,6 @@ static bool trans_vmv_v_i(DisasContext *s, arg_vmv_v_i *a)
         if (s->vl_eq_vlmax && !(s->vta && s->lmul < 0)) {
             tcg_gen_gvec_dup_imm(s->sew, vreg_ofs(s, a->rd),
                                  MAXSZ(s), MAXSZ(s), simm);
-            mark_vs_dirty(s);
         } else {
             TCGv_i32 desc;
             TCGv_i64 s1;
@@ -2083,9 +2082,8 @@ static bool trans_vmv_v_i(DisasContext *s, arg_vmv_v_i *a)
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
@@ -2612,7 +2610,6 @@ static bool trans_vfmv_v_f(DisasContext *s, arg_vfmv_v_f *a)
 
             tcg_gen_gvec_dup_i64(s->sew, vreg_ofs(s, a->rd),
                                  MAXSZ(s), MAXSZ(s), t1);
-            mark_vs_dirty(s);
         } else {
             TCGv_ptr dest;
             TCGv_i32 desc;
@@ -2635,9 +2632,8 @@ static bool trans_vfmv_v_f(DisasContext *s, arg_vfmv_v_f *a)
             tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, a->rd));
 
             fns[s->sew - 1](dest, t1, tcg_env, desc);
-
-            mark_vs_dirty(s);
         }
+        mark_vs_dirty(s);
         return true;
     }
     return false;
@@ -3560,12 +3556,11 @@ static bool trans_##NAME(DisasContext *s, arg_##NAME * a)               \
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
2.44.0


