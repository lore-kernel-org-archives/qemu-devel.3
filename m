Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7161FC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 15:01:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7G6A-0005Eo-2k; Wed, 15 May 2024 10:59:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7G65-0005Dv-UV
 for qemu-devel@nongnu.org; Wed, 15 May 2024 10:59:13 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7G5y-0007CM-3z
 for qemu-devel@nongnu.org; Wed, 15 May 2024 10:59:13 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2e6f2534e41so15349781fa.0
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 07:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715785144; x=1716389944; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KkrM6eUfNQC4/ZxOfw3RoQ+l/U6+/yIajWSBPEUqefU=;
 b=C88AauUoq881icwjVGnJPqx6yy6DSU+DCZ9Wu1wb+Y0VqDO1xIG3b2cKd1DmSMYsm+
 +apMamKY6yHdwHcjIHDQJXjwV2gthHbaH1ahoelnQqfBq3T0R8C/ExrK6JXQkkCkyLp8
 TEyDeKHmJHKADd4rp01OOVeSHBU8/tDwyPakTc6DyQYUQThCRqoAByLynRq93EKCZTdZ
 U4MvtiVaPFcuMy00UsXe2KNpwfHQrwgeTIYcZHXBphC8hZe6hGmkG10MBnyBuFV8L0v4
 XL4sf5V5ZGczNLhlXKt91WeeQrh40JWKw1FyUKQd00/vyTn8cwpH07CIxZutkJNbmDBd
 HA9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715785144; x=1716389944;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KkrM6eUfNQC4/ZxOfw3RoQ+l/U6+/yIajWSBPEUqefU=;
 b=c2sOiw2xZUDmYKvxBD3bhXy8kqCfG10F7502rzJzBs7P+YTYQzxnKJnekQ0t6Bpj9k
 B0Nu3ab2Nt3dNVn2ssl3lPa35icsKpX5DVARnufLkT8p2UoHFJKWFyhsnyvPGWJkKivC
 e+XxQdfSxLYQvdRnC7DlOMd3oZZXAzwUkgihX7bL0uSsyMnF7EO58gvHzT1MKeQUa5Y1
 R/IKAiAIel77PxaiEBsUu1gs4a4WxBMf+AnUN6NR+O/cEJOZNcMoSRI3ueVc30xOOAP8
 qxOs6zICHZF41Q1ZXf9QE0k/vYzSFp+MIsXaBjY6v3kdvUQnuHPyyon66aPYZ2laWOeW
 +uuQ==
X-Gm-Message-State: AOJu0YwXsaQu1UgiM5cvPc7vJ0qy4HKXJlrTwkpwPBtePzi1Gjn+z0Co
 pMMY0l99KMlpsDaP/H6wUAnWuSV/g1x577YHyon5/m2xILtmN5mXlarjOOgxgknLbkrFn5kjmb6
 MBHc=
X-Google-Smtp-Source: AGHT+IGRIdnkdRCb8NSDcvJVINtg9t7iB+5jTsPzg1fP2TE7+pYlTB1cFFaimq/AOWCPU56zqg1srg==
X-Received: by 2002:a2e:9601:0:b0:2df:a177:58e3 with SMTP id
 38308e7fff4ca-2e51fe52bbemr103753461fa.13.1715785144444; 
 Wed, 15 May 2024 07:59:04 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41f88111033sm272134645e9.34.2024.05.15.07.59.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 07:59:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 5/5] target/arm: Use TCG_COND_TSTNE in gen_cmtst_vec
Date: Wed, 15 May 2024 16:59:00 +0200
Message-Id: <20240515145900.252870-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515145900.252870-1-richard.henderson@linaro.org>
References: <20240515145900.252870-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x231.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/gengvec.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/arm/tcg/gengvec.c b/target/arm/tcg/gengvec.c
index 1d6bc6021d..1895c3b19f 100644
--- a/target/arm/tcg/gengvec.c
+++ b/target/arm/tcg/gengvec.c
@@ -943,9 +943,7 @@ void gen_cmtst_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
 
 static void gen_cmtst_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec b)
 {
-    tcg_gen_and_vec(vece, d, a, b);
-    tcg_gen_dupi_vec(vece, a, 0);
-    tcg_gen_cmp_vec(TCG_COND_NE, vece, d, d, a);
+    tcg_gen_cmp_vec(TCG_COND_TSTNE, vece, d, a, b);
 }
 
 void gen_gvec_cmtst(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
-- 
2.34.1


