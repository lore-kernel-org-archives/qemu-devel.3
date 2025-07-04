Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5451C83F09
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:50:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhQJ-00048d-60; Fri, 04 Jul 2025 10:29:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhLu-00046b-KH
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:25:27 -0400
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhLo-0007wY-85
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:25:20 -0400
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-60bd30dd387so544883eaf.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751639112; x=1752243912; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NlTOBE4Jn2fkd9net09wcfWNBe1xruDmY2EOcz8YZIc=;
 b=hxI7lAi0QAJRML5nQfJ21KiHb54pbfqkxdPFyhc/P/8K8cbuwqmP1gpdPAFch7E6Tb
 ftYwLBxQnwN0nWlfKieq06qRHkC463dJzb2twig6b4d9vO4D5eC8w+O6wy7P5tyLSf3f
 YpZvphJuOs/N6ZC1NyRfpj4AeOb3W6/HhLdEt3SRXR/MFIRIFjk4djM4FOgP5rmeuyuS
 jMmYsn0b3erSH+I3/ao+4j92nta/KHm1HfzvpAFYR4qqAismAO4yrDauJ6bKZg2aRSrF
 RUZj/0L14aHF40RiOzdWTWJo82w3tjDJvZLE7Q911eSTmCk+eeDNcRHLlrwSHGxfPMRT
 T5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751639112; x=1752243912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NlTOBE4Jn2fkd9net09wcfWNBe1xruDmY2EOcz8YZIc=;
 b=vpeikXSRhGFXw8/iABnjk9jcUMjAoJP1lgRNI3yZXgGyv/101Xpjqyb2DegyDTy/N7
 xQoPYxQIhWCXtEmyvIQlENNQD75/6DMCx4e0lymmIv3fblZk2vvROgu4vTRaVOv5KGbU
 6QUuk56hKHEOr6/IqDQ1rbSYVnuPBwiJ05zAzxpsIsXsupGZNJlgKxajgXQ0bKIKLbR6
 YgIL0w8kPYW4K4NQuvlNVR5tUbxq+UZM6+i0tygMKNEhQSjR9H6/Rz0O7h9xc9z8wbvw
 rdEIR105ydzKPVCsBKnidNk3/f2SLsHKAPXyfVVg3xfr3SBHqkDg33ao1N01ZqUZbgVh
 03aA==
X-Gm-Message-State: AOJu0YzI43kdUc8VNrUg4Vei3lGxLfi3YcnzikUgay9mRdiAWmJ+EQlp
 bmho/yjQiFu5ToRwpjXTlMSDd5G3jDeMC+bkO/d1K+SoOomza2fBDzSa5ZKvbUsP87nLh5HXe+z
 Z22SnTCI=
X-Gm-Gg: ASbGncuc0fte5QSy4GraGcclkMD3BFEA5UoWXG2QWzr+2YDFoQCmdfJjvS75wG2eug4
 tR8UV/IAfUo2YTKZtpgZsbB4b0aS0o95Cwlr9SBdwKboHXvA5rD1F9ADE7ETEr//B1+L8HshuwU
 e7rpdaCOoeYhyuIHkkkMrHgFe5CGRMGtYwKNhPXQv1hEQ2vDztyeP3dsCQ4BfQueGJ2h4oh0iqw
 x/j+tWr1EzmybbMsS9cJpRWEEZLarLSPXE905E06JpTLfOi3OMo2HVRikgNzD6RMlAV8jrTfZjv
 BJPsFuKDyIXoIr3Go0nDA9u1u05DiYxnGswElZPAWXmxrZ0NcY/vIJWkB5m400/GDu4lfTXWLUM
 NH5I4mLZLpsu42c2c0RtMiZiwTtXmRBnMjAJBJEj/4tCSZRWG
X-Google-Smtp-Source: AGHT+IG5Klib1K5yEgWNleUK/rYnABe6JW19q3lqBilYNWqKZhDhfnehGQfEPrB/viKXzng1v9fVVA==
X-Received: by 2002:a05:6820:818f:b0:611:bdaa:5b01 with SMTP id
 006d021491bc7-6138fdb94c0mr2128064eaf.6.1751639112542; 
 Fri, 04 Jul 2025 07:25:12 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6138e5ac5eesm310233eaf.29.2025.07.04.07.25.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:25:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 054/108] target/arm: Implement SME2 FCVTZS, FCVTZU
Date: Fri,  4 Jul 2025 08:20:17 -0600
Message-ID: <20250704142112.1018902-55-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc29.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sme.c | 5 +++++
 target/arm/tcg/sme.decode      | 9 +++++++++
 2 files changed, 14 insertions(+)

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index d6167eafe1..3bf2b6935f 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1365,3 +1365,8 @@ TRANS_FEAT(FCVT_w, aa64_sme_f16f16, do_zz_fpst, a, 0,
            FPST_A64_F16, gen_helper_sme2_fcvt_w)
 TRANS_FEAT(FCVTL, aa64_sme_f16f16, do_zz_fpst, a, 0,
            FPST_A64_F16, gen_helper_sme2_fcvtl)
+
+TRANS_FEAT(FCVTZS, aa64_sme2, do_zz_fpst, a, 0,
+           FPST_A64, gen_helper_gvec_vcvt_rz_fs)
+TRANS_FEAT(FCVTZU, aa64_sme2, do_zz_fpst, a, 0,
+           FPST_A64, gen_helper_gvec_vcvt_rz_fu)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 5100ebaeba..79df2dcd2b 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -728,6 +728,10 @@ SUB_aaz_d       11000001 111 000010 .. 111 ...00 11 ...     @az_4x4_o3
                 &zz_n n=1 zn=%zn_ax2
 @zz_2x1         ........ ... ..... ...... zn:5  .....       \
                 &zz_n n=1 zd=%zd_ax2
+@zz_2x2         ........ ... ..... ...... .... . .....      \
+                &zz_n n=2 zd=%zd_ax2 zn=%zn_ax2
+@zz_4x4         ........ ... ..... ...... .... . .....      \
+                &zz_n n=4 zd=%zd_ax4 zn=%zn_ax4
 
 BFCVT           11000001 011 00000 111000 ....0 .....       @zz_1x2
 BFCVTN          11000001 011 00000 111000 ....1 .....       @zz_1x2
@@ -737,3 +741,8 @@ FCVTN           11000001 001 00000 111000 ....1 .....       @zz_1x2
 
 FCVT_w          11000001 101 00000 111000 ..... ....0       @zz_2x1
 FCVTL           11000001 101 00000 111000 ..... ....1       @zz_2x1
+
+FCVTZS          11000001 001 00001 111000 ....0 ....0       @zz_2x2
+FCVTZS          11000001 001 10001 111000 ...00 ...00       @zz_4x4
+FCVTZU          11000001 001 00001 111000 ....1 ....0       @zz_2x2
+FCVTZU          11000001 001 10001 111000 ...01 ...00       @zz_4x4
-- 
2.43.0


