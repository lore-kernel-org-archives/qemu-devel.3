Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3701C54E68
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 00:34:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmjsj-00005s-RC; Tue, 19 Mar 2024 20:32:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmjsh-0008WV-Uc
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 20:32:35 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmjsg-0005XS-FM
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 20:32:35 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6e780830bdcso237683b3a.1
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 17:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710894753; x=1711499553; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zJMpmIWK2dum6qCC+4K2slypl3etpIyoaJqh1QCO4fw=;
 b=G2kDDZ3b4/wwumYWRsELKF0iV5J+KDRae70gJ5XLzWkkUvxIShFx3hezHVLNDyBux6
 MHUHjzi9cEdfQQe2B1gmaxD0Ev5IAW/MkCDy/4FvurZsRDq8DP4Q1Ifk4GFCJDLlRRaD
 VmakxDpcvY9/q7W/TNJ3UvWAzg1m7BRAGV+pDM3T73R5XpgHa1qOdZPIaS6EVjpvlHUx
 ut1ZCLfvkaQNnfnGCO8vbub9S3ZQoodV9dU+TQo60vIgO3q7rnPQCslYIcSlM7BI4+pC
 njSag7Hj25t7bIEIBSs65Q7N37kg/iDrYXPZUBsQFB6LeJVcpk5FAGcdM1bHZEPS8Pp3
 mtrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710894753; x=1711499553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zJMpmIWK2dum6qCC+4K2slypl3etpIyoaJqh1QCO4fw=;
 b=k0BAYbdQ4+Tlv000Hm3TVNcNR5oUaImfNM3OKH37GrrJn6xfK970Hw0yLC98Q23QY8
 Vp4CH0jNSXzHW+Mt3Pb0ZaoelAePRjeSdlxJEoNOk+ILB4JzVKB9zYvSRwPe/B68xQJx
 vMlNRmjEMpTuzUnPQVKUUPNARmBm4IBnOlIsWx3QUh4vrUXAIzfZ7zeex9mzgiPHjUUD
 pb0u8sxlNwtTgw/iCxo4FOcgblBxw1pIze/blHVF6TV1lOr/Fl2TGfBH5ug8mVzGqbnp
 ljLhJcDUBQUuQm4DORHm1n1cljKWekTsrhPXkvx3VYTV0Cl3IiETpG+EeGbchRTZ66DH
 CdrQ==
X-Gm-Message-State: AOJu0YzStt1lp+8CIbr+fw2rktp/H2z5I84bkTxouoEIFB7rxtKt4AFw
 PdCbxDZ3rEOnGWc3WsfEl587m6rGEL31oHK/tKuniT3CAf25tABIE63qYsXD1bjurFMhsGGrs2B
 q
X-Google-Smtp-Source: AGHT+IGGM7JHf1/BgqObM7QIeygLZeAN+w0mClCfvFK1RNTHhgFGslhEtCg3xX4IVqVh4MWQLh9G0Q==
X-Received: by 2002:a05:6a20:3ca4:b0:1a3:5402:d5bd with SMTP id
 b36-20020a056a203ca400b001a35402d5bdmr1476982pzj.1.1710894753055; 
 Tue, 19 Mar 2024 17:32:33 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 d19-20020a63d653000000b005d553239b16sm8475645pgj.20.2024.03.19.17.32.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 17:32:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Sven Schnelle <svens@stackframe.org>,
	Helge Deller <deller@gmx.de>
Subject: [PULL 5/9] target/hppa: fix shrp for wide mode
Date: Tue, 19 Mar 2024 14:32:19 -1000
Message-Id: <20240320003223.554145-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320003223.554145-1-richard.henderson@linaro.org>
References: <20240320003223.554145-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

From: Sven Schnelle <svens@stackframe.org>

Fixes: f7b775a9c075 ("target/hppa: Implement SHRPD")
Signed-off-by: Sven Schnelle <svens@stackframe.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Helge Deller <deller@gmx.de>
Message-Id: <20240319161921.487080-3-svens@stackframe.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 47c6db78c7..29ef061baf 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3512,7 +3512,7 @@ static bool trans_shrp_sar(DisasContext *ctx, arg_shrp_sar *a)
     /* Install the new nullification.  */
     cond_free(&ctx->null_cond);
     if (a->c) {
-        ctx->null_cond = do_sed_cond(ctx, a->c, false, dest);
+        ctx->null_cond = do_sed_cond(ctx, a->c, a->d, dest);
     }
     return nullify_end(ctx);
 }
@@ -3555,7 +3555,7 @@ static bool trans_shrp_imm(DisasContext *ctx, arg_shrp_imm *a)
     /* Install the new nullification.  */
     cond_free(&ctx->null_cond);
     if (a->c) {
-        ctx->null_cond = do_sed_cond(ctx, a->c, false, dest);
+        ctx->null_cond = do_sed_cond(ctx, a->c, a->d, dest);
     }
     return nullify_end(ctx);
 }
-- 
2.34.1


