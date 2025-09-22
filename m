Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E39E0CA100F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 19:05:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0ljB-0002Hm-88; Mon, 22 Sep 2025 14:57:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lgS-0006Ay-VI
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:54:49 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lfT-00052U-Na
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:54:36 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2445824dc27so50981155ad.3
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 11:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758567221; x=1759172021; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x7nV0Ak+FzJdflIEY7yKbyAYL5FePaOZ1XHx7vKnyo4=;
 b=y0+3BjEqZNfVpPK+00yjnCpSrxi8Sz9GztA4QK7qnrmLlbMATwGouw1hodDUCuiBea
 g9C5vPD1qClPdlwgMAg3WLH/ne1N05JTCffAJVEguXvym/8kKwCMeaE4Oe6kdGPJcdgh
 mWQAeXVzS4NNd0v2q/1Ck7mEJiS7RM4gkIPISXovVIYtp8DVJUj1bicA6t0lASlJhiuG
 M41ptGRzxs2OBW9m4iFpKji0tU3uC3fuE40shL2DlzgZPzyrlR/BrwBmA2rF3yzQlaC1
 5l/pr5HRVN0yPjJmv+akzwKksHtzzsokRnAwKrz0b3m2rkkXMN8VEWxYmxXvwmKhwf48
 5vwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758567221; x=1759172021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x7nV0Ak+FzJdflIEY7yKbyAYL5FePaOZ1XHx7vKnyo4=;
 b=EDTpAP0X18kzzqUvUZm9E2FV7oQfIvORBZxsuXse7dp6tlFDcCZKTtZB8KanwGv1Cm
 IgBCn1sftFt6e1By98q53aqxIfpbov/nW5U38gyRmGGxjtvsVEIswGj1wjdkhma3+Myh
 Yj0Rj9+jV0QTVck4rxEqNk3kv8gLhSTBZ9y4d3/UYlmjAXd4FhzwjfTI1maSiDKDHBMX
 MT70wYaNj8E072SClokF5EYtxzORUkoD3i8GTljWiGUMTyRpu6iT5SNrRcHvivG02c3a
 SFWRjk1/t2/KxmWKn9B4fYDEdQkSFFVWcGTrFPVbxiGv+79sE98fChSwOS6WPL8any27
 MpVg==
X-Gm-Message-State: AOJu0YzpNeJ2FyC/l0hKAnahbkojc8VRB3wbRAk+qdFeXqAmNeZcgEKX
 OUy3u2mtuDIhPwx5ufSnKe76zQ26IgltNb8HwwffNZvvo/ucRvcZzxsdC3tfvtqSiFvTiSR++zL
 YFnYC
X-Gm-Gg: ASbGncuin/VdNGRC5hXvDlxytMy4dDxhxiYnOzDubtxg3cu/3Yuwbb82f5Hj2XekHYh
 49OMMhLjwTRttdREMKSFemlbRVaZRX4Qo68yclgm/Ld9ZOtts2/TNOl/zFefxR2GA45nERyWbPi
 tM4wLkroIybEEH5A1U8N4b1bbbw0vUkl91w+mZ62IUFkTdKKvERN7CmzZQ0AICJezGY5RabsiPD
 IDkoa3LaTyppdwAGnnbZORSCfuNbpao5vEh7Yar1+fj7XTox10+MSSlBaUIeraU0dieKfhwUwdo
 NyNnrw6NFDQOv0YxMHPpg6CkYLcB3PFaceHSl4WeWNW8HcxLNf2Oz6Ft4tIaxUXnrMMWwEQHavY
 crMqb6Dp48xCJOGQJsVC+qWPzuY7B0jjthCJLagU=
X-Google-Smtp-Source: AGHT+IF1yXZm6ppXW7M2y5mnXlLaKY+H/GfFGoOF+b1wzpjcXgfOQx5PJ3wtR0zHhxn0i8EnTjegGg==
X-Received: by 2002:a17:902:8490:b0:269:8072:5be7 with SMTP id
 d9443c01a7336-269ba566c82mr124399245ad.56.1758567220755; 
 Mon, 22 Sep 2025 11:53:40 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2698018a472sm138554795ad.58.2025.09.22.11.53.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 11:53:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 70/76] target/arm: Enable GCSPR_EL0 for read in user-mode
Date: Mon, 22 Sep 2025 11:49:18 -0700
Message-ID: <20250922184924.2754205-71-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250922184924.2754205-1-richard.henderson@linaro.org>
References: <20250922184924.2754205-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 731b4d5725..09c27451fd 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -307,6 +307,10 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
         env->cp15.mdscr_el1 |= 1 << 12;
         /* Enable FEAT_MOPS */
         env->cp15.sctlr_el[1] |= SCTLR_MSCEN;
+        /* For Linux, GCSPR_EL0 is always readable. */
+        if (cpu_isar_feature(aa64_gcs, cpu)) {
+            env->cp15.gcscr_el[0] = GCSCRE0_NTR;
+        }
 #else
         /* Reset into the highest available EL */
         if (arm_feature(env, ARM_FEATURE_EL3)) {
-- 
2.43.0


