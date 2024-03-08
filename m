Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40544C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 21:55:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riiAw-0007eF-IH; Fri, 08 Mar 2024 16:54:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1riiAu-0007dk-Im
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 16:54:44 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1riiAr-0001oJ-W4
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 16:54:44 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1dc75972f25so21166435ad.1
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 13:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1709934880; x=1710539680; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZwxXztLhb/arsxn2SdJV/ZyPitKjOZ21gt4fazWDuSc=;
 b=mkIiwnBNOdM/4mRdCS6mKWODYsXHLCmDRkGCBX9q216CcikFzzxgMYJt9O7tdXcgdw
 xyp8OmUjdUu9AYY16WzpCtjfOTaBxZXrzg32FzDXnef5eWKhd//4agYxj4ZRfRNISS8W
 eYGJ4YFZrE4kis+KkD8OF5ieWbeEPSppJkazRsboubYJTC/uwRHebbcfoSvbCiC7ePMu
 6G5AL5oWH2GP7OTKxWDu57HGx+LU/ypqLh+PZWkhpHkozs4JUOrNNA1qlj2ouyI586QY
 yGxfdTpT+0x/I+OrR2jAF/TUm/jZQTbgsAQ1i4okrdnY2mQo7mdw/ZQyAliu5yKmLnQu
 wpIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709934880; x=1710539680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZwxXztLhb/arsxn2SdJV/ZyPitKjOZ21gt4fazWDuSc=;
 b=fSb8xJs55v05UpVy/4VlpYmy25NIGMLUaHTCb9/KnOuWvQPZVc67OjMX8F5SLyGFZV
 BmGmJVFIYaQDygCAdqCSVz2qwjn4u6ZNJZGzTYpaE79qJ0FyNqpmpArwkr/S6FX+NRRQ
 F4byUH9H2I8DOaTpyydWslHkEjSLlOzlJOJ+CqJjSBUqJBceWNhhQ1gAAPuwfbzSwpWV
 9/I4Az98oix3gbYAvIAqVZsp+rRSEiKfWUxzNlX+cUvjk9evBqkVggI+cz2ySQb4myjG
 P3+kATm1c5Byl9bBOO8HqlR/8lCRZNhlynU6bQrU/efjNlbN793z4Sgv7h9BSRuHwBNf
 oAxQ==
X-Gm-Message-State: AOJu0YyicWTzS4XV9wAC/vLAd3a6yp/9DqshlJwESTNBjRiV+lzdKkdo
 uVo/oNJkp+iLNB6SWufFkiwM3lfZUUIzpBVhvvL6GaR1XHuK3eM4HeW+43gm1Za7Z9cB/BeJ0BG
 g
X-Google-Smtp-Source: AGHT+IE2t5xqgzM8i3/TdeIv2FEcaeZVFEi4G/NY7WVdEtYH0JNtmwxl4qQKgWv6BFJPgDPKNZDP1Q==
X-Received: by 2002:a17:902:ce12:b0:1dc:c633:e6b1 with SMTP id
 k18-20020a170902ce1200b001dcc633e6b1mr514112plg.49.1709934879981; 
 Fri, 08 Mar 2024 13:54:39 -0800 (PST)
Received: from grind.. ([177.94.15.159]) by smtp.gmail.com with ESMTPSA id
 d3-20020a170902b70300b001dd66e6ec91sm107702pls.140.2024.03.08.13.54.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 13:54:39 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, philmd@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v8 08/10] trans_rvv.c.inc: remove redundant mark_vs_dirty()
 calls
Date: Fri,  8 Mar 2024 18:53:48 -0300
Message-ID: <20240308215402.117405-9-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240308215402.117405-1-dbarboza@ventanamicro.com>
References: <20240308215402.117405-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62e.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 3ec18412fe..fb9795c9f7 100644
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
@@ -3567,12 +3563,11 @@ static bool trans_##NAME(DisasContext *s, arg_##NAME * a)               \
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


