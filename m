Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2292FC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 18:10:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjk5b-00051P-JD; Mon, 11 Mar 2024 14:09:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rjk4y-0004tA-24
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 14:08:55 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rjk4s-0004PC-3I
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 14:08:51 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-5d8b887bb0cso4004579a12.2
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 11:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710180524; x=1710785324; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M1pgxbL4ext+eLfj8GE9V3VngjTMGW2LA/FcQ0QZgQg=;
 b=AfN93V7MDXQVkFpS6meX513W+zSYDn0t8+bLA+QficjyilXJlY/4uIa0xCeiFXI9RF
 u/V/C+LBF/Fad2q8PLwlnRpvXB06d9wcoqkv8qi1fTqaeqPnvIR/r0gUdtUSr1dRHYP7
 aTyV/Z6g8AMCrNfXkUi543HiENbmszVsGPR3zs+zKQEjNQk7AfjxwYCsMwsQOlmjNIDi
 9ZUsW0vZ7fMXyqdRyHuE7eQ1zjpeIJafwQmXnREBtUWbKVYzV66l7M7a+DE6ILm4ao6b
 G9bGKiUCLHnueRMVEc8Z+e6Pl2Gn92ENyNGNYYxjfoT5R5rEJsIWI1ULGK+cPzqefv2m
 DMnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710180524; x=1710785324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M1pgxbL4ext+eLfj8GE9V3VngjTMGW2LA/FcQ0QZgQg=;
 b=HO2mnxDfzQUxiZS92OjgX9qNG6Z7Y8JDJoV4Mg/UkBK3jVW5fjSmDc/rpjP8O9bCmC
 MErwVH3ojftOu4D52jM55A1ztLg/60B4ITR5enwaCe1QuilMB91+6qqiMUs+s/r0yJYQ
 SkSWqC3zVLLkSNGDU9Ngzg0vX9BKBNcjAcdjtj+TkXPPfnXEtvjgHK4AgIX5vWW39CFK
 DbabRNzZ5qQg8mi6Ttwait+1zXQ4zo3iNQvEexhr9j/5SgEaWXIfQ5FUtZUrP0MRopiW
 aXUfeQHFnLWAZyAGk5VeI45YmVk1MZ/RdnEfdHbVSbnRmZtIjH1ftfcb2rhPnlGI8XEZ
 xU0Q==
X-Gm-Message-State: AOJu0YwRN4GUkQ3qVJTovdzwqBkWnWtjz8JWuIhOK8veOR5KVvBEqw89
 i3Yj/rGoGujNB7voBolodaUMFeoxQ4mPDNq0n6T67Bv9r66px5h8vUE+olHXKWcS4z8QIL4W1fC
 y
X-Google-Smtp-Source: AGHT+IEErzsQ4Jp7IEbKjgBjkUOVvdzaX7AhrehCiFTo5NLkysLwZC5K5OcR8I9tyeidZusXQOgE9Q==
X-Received: by 2002:a17:90a:6bc5:b0:29b:8a9d:5eb8 with SMTP id
 w63-20020a17090a6bc500b0029b8a9d5eb8mr5706481pjj.22.1710180524365; 
 Mon, 11 Mar 2024 11:08:44 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 hk13-20020a17090b224d00b0029c2794d3f7sm525810pjb.7.2024.03.11.11.08.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 11:08:43 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 philmd@linaro.org, richard.henderson@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v12 5/7] trans_rvv.c.inc: remove redundant mark_vs_dirty()
 calls
Date: Mon, 11 Mar 2024 15:08:19 -0300
Message-ID: <20240311180821.250469-6-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240311180821.250469-1-dbarboza@ventanamicro.com>
References: <20240311180821.250469-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
index 4c1a064cf6..b0f19dcd85 100644
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
2.43.2


