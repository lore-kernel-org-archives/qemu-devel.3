Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A8E8C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:38:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnws-0004Wm-J0; Sun, 16 Feb 2025 18:21:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnwT-00042e-Ey
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:20:54 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnwR-0006Qc-Gs
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:20:53 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22101839807so36077725ad.3
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739748049; x=1740352849; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=q83w8Xallm3lqa4mcTd5yBe7/enj/IxNEYYygxKl8+I=;
 b=NwG659Nq2H0r9+mCqwwWWyZmQNetrnghaiV3cbqXR330KEuGiI/Z3VnFjJnTch6uVO
 14HjYEymCfcDIyP6eRQeDW+kf2bdFKRuMJ3j+QMECZmtflmCZRhZSk1/LlXAJmUFcISk
 VDiBqlMDFkdYOz81w/1LpDm8+VfCVOJwySUwOOeoWR8w8uJGh/X+zAxlRHyQpSbyX8dN
 UR925ApIv4zHxEsuMu3z0V0BrWpXVj+YaaKv8hq02f55HOJzDAA955frzf/CdgcZQR69
 hdFtF90Ft96V6osjsmiC/0jLDjvlbV33f99zvxl6K8KzvY+lH9u45LpdxoAFKVvpGuf4
 rUmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739748049; x=1740352849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q83w8Xallm3lqa4mcTd5yBe7/enj/IxNEYYygxKl8+I=;
 b=oZkIm8NHd4Jnndez+v5R2lacoxim1Atpi/JTRQLf2bkz8biAim3Mzxn6G2yIJP4NRz
 nnbzktCSAUOpbpVfBR2wj4H74qh3ekMaze5GnUHHzzOv8Wjis2ZYgxi2AcNyf2uDhtjB
 TF5SK5GDxZyjWPtEMPMJl1udKM211frjt/XknJIF1oi6Tf90l6MElv8Rcc2EMBM73ThP
 jLA6g+WvtOt9oHXRhrISaVVcEkj57YFMHGEJbUcIbH1KZhxjk6dEKBuETuDy9bEhn0Xa
 2vz9zL4wkE4SG47l5Z0KDhvm78L4cbXvU1Ak8Ep/W/dxcv94Jvc6LCFFJDP91g+1s9By
 hyGw==
X-Gm-Message-State: AOJu0YzeS2wjezsZhXj/I9/d3LWjY7tWIAalFX/Rv4lh/YwRC5cEXwPD
 s1dVdloNucg6QeKqOTvUfWnXA3iz+B/YI6A2OLvG2y+T9oeDj1J38YJLRdeOL6QI0OwlfEvKjpi
 H
X-Gm-Gg: ASbGnctspVDROwg/dd7HcmFZ4TcSHVskPlkOIPhL/B+lddsgRQyztWNiMCuoNyvs131
 sQPLMCw9jOmoQi8LX9QmBCFDqWxSlD9Nmtcc/G6lIzODK9y/ymOvky+8abTrd3MaXU0BABTPEjY
 /Ieadw0QGRMeSalTG8ZGcQcVWKx2o+BSAd8K04eZ0qfUfN/TUdPGspXSwA6MBbMbL+xyGqv98Kl
 vk9iEsna3mEBBRtB3uGrCbLdL3nBwy4JSQwQTS1APIim9xtCPP9ojDTV8DaLmlP9DoFWOQoh1Kc
 Zrz0Z+jBKYLjQ6c2y7l9NOzCuKvd0oTK+hAMsqVOf542O38=
X-Google-Smtp-Source: AGHT+IGBX7zyF7o+M2xPZpFQnMOS80d2dWob/hQJKUpv0sHDe54H5D8CYbN1uqJeadsEH1qdOzlRUQ==
X-Received: by 2002:a17:902:d483:b0:215:6e01:ad07 with SMTP id
 d9443c01a7336-22103efb5b1mr110652055ad.6.1739748049673; 
 Sun, 16 Feb 2025 15:20:49 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc13ad4391sm6783744a91.27.2025.02.16.15.20.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:20:48 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 126/162] target/openrisc: Use tcg_gen_addcio_* for ADDC
Date: Sun, 16 Feb 2025 15:09:35 -0800
Message-ID: <20250216231012.2808572-127-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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
 target/openrisc/translate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 7a6af183ae..c9856fdc88 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -220,8 +220,7 @@ static void gen_addc(DisasContext *dc, TCGv dest, TCGv srca, TCGv srcb)
     TCGv t0 = tcg_temp_new();
     TCGv res = tcg_temp_new();
 
-    tcg_gen_add2_tl(res, cpu_sr_cy, srca, dc->zero, cpu_sr_cy, dc->zero);
-    tcg_gen_add2_tl(res, cpu_sr_cy, res, cpu_sr_cy, srcb, dc->zero);
+    tcg_gen_addcio_tl(res, cpu_sr_cy, srca, srcb, cpu_sr_cy);
     tcg_gen_xor_tl(cpu_sr_ov, srca, srcb);
     tcg_gen_xor_tl(t0, res, srcb);
     tcg_gen_andc_tl(cpu_sr_ov, t0, cpu_sr_ov);
-- 
2.43.0


