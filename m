Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DECACCD128A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 22:34:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqKlD-0002av-5y; Fri, 29 Mar 2024 18:31:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rqKl1-0002Y6-Uf
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 18:31:36 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rqKkz-0003Wc-HF
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 18:31:30 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-5bdbe2de25fso1672392a12.3
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 15:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711751488; x=1712356288; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vnjhMc8AFUnASgt/GDELAcE24oYis+MaL1Mj1wovAY4=;
 b=RG1tjgffITsdDVYuB3zO8zD0pkUa30msVIMRLpIs9x17/FIVL4FkF722biIW8w1iuv
 5M8JiKvwjZSAPWppEvFbj44jhuityzume5REoaqjn36yf0XORA0DTiI117g6DM6lTpY1
 oUFyCr09YMpuV90KzXMeHNNVCv4ROxq2jI1Qu+Z6Gvoxn0FSHI+WOinyUFTvwLt4K/ri
 rL7a3wrPVwiro69sRhtxRrN0QwXpKMdXFZRlfsnR/jAc4OkfzeqbOBfN8Sp1xiJTdHig
 VnFQPF44WNohC67z571Ub2lDJnj/5/wwK8HPM9RlkfQ9WutZHyMopejpMLkipWp36rpA
 IOFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711751488; x=1712356288;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vnjhMc8AFUnASgt/GDELAcE24oYis+MaL1Mj1wovAY4=;
 b=D+8ZTfsvJsHwvn/zhj2cg9fMSGhX5TDISO4xBhrSN09LfzrDM8zh/mkSvafDjN+MuY
 OWGMLmUUYVicwV41v9/0Twi/kk0+WR42oEl6oj3YgSTarmjLJz7uUO+1vLgFK9d1HHCZ
 zIJhS5C2qgV4orD6T0BqSF4bRlBP57GItdikLFT5p7oqmDD5jhzThWZ1FapbX9uHJaul
 2nJOA7C35a9w+Zcxk/Q6pWfXMI30DE8kHRzNunMroZCnbxrhCZqrUZVllkaZXOj6qXiA
 ue/uXJG7PFSI1a7A/7bO+PUH8xjhbgtgETjbHqUVfF/ldoOaJ97E+fOM3CuD/ausNxs4
 CGRw==
X-Gm-Message-State: AOJu0YwbsaO2pX6CcuMzzoVlLGmvxrkjPdnbPtXmSufvGHL312V3u2am
 q85xUOGQKtx0Fjl2/86l3oAG3yXp6fItxIB32jxKujWdEcObTKmZOhvrCkKjm7rutQChnMbhTEB
 5
X-Google-Smtp-Source: AGHT+IG5sO14QMlmmrAfi8c1a+u0ntJLcJopT6SNzYxOuLD9zobw6DNgMXCi3nkKpl9fqw71yLP1bA==
X-Received: by 2002:a17:902:e94f:b0:1e2:306c:32e3 with SMTP id
 b15-20020a170902e94f00b001e2306c32e3mr4188941pll.2.1711751488327; 
 Fri, 29 Mar 2024 15:31:28 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 f8-20020a170902684800b001e09b636cafsm4000955pln.287.2024.03.29.15.31.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Mar 2024 15:31:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 10/18] target/hppa: Optimize UADDCM with no condition
Date: Fri, 29 Mar 2024 12:31:03 -1000
Message-Id: <20240329223111.1735826-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329223111.1735826-1-richard.henderson@linaro.org>
References: <20240329223111.1735826-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

With r1 as zero is by far the most common usage of UADDCM, as the
easiest way to invert a register.  The compiler does occasionally
use the addition step as well, and we can simplify that to avoid
a temp and write directly into the destination.

Tested-by: Helge Deller <deller@gmx.de>
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index a3f425d861..3fc3e7754c 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2763,9 +2763,29 @@ static bool do_uaddcm(DisasContext *ctx, arg_rrr_cf_d *a, bool is_tc)
 {
     TCGv_i64 tcg_r1, tcg_r2, tmp;
 
-    if (a->cf) {
-        nullify_over(ctx);
+    if (a->cf == 0) {
+        tcg_r2 = load_gpr(ctx, a->r2);
+        tmp = dest_gpr(ctx, a->t);
+
+        if (a->r1 == 0) {
+            /* UADDCM r0,src,dst is the common idiom for dst = ~src. */
+            tcg_gen_not_i64(tmp, tcg_r2);
+        } else {
+            /*
+             * Recall that r1 - r2 == r1 + ~r2 + 1.
+             * Thus r1 + ~r2 == r1 - r2 - 1,
+             * which does not require an extra temporary.
+             */
+            tcg_r1 = load_gpr(ctx, a->r1);
+            tcg_gen_sub_i64(tmp, tcg_r1, tcg_r2);
+            tcg_gen_subi_i64(tmp, tmp, 1);
+        }
+        save_gpr(ctx, a->t, tmp);
+        cond_free(&ctx->null_cond);
+        return true;
     }
+
+    nullify_over(ctx);
     tcg_r1 = load_gpr(ctx, a->r1);
     tcg_r2 = load_gpr(ctx, a->r2);
     tmp = tcg_temp_new_i64();
-- 
2.34.1


