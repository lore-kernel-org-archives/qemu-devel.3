Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FCB1E7316D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 13:37:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmu48-0006oI-42; Mon, 02 Feb 2026 08:34:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vmu46-0006nd-PO
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 08:34:06 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vmu45-0002eM-8A
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 08:34:06 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4806f9e61f9so22649865e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 05:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770039244; x=1770644044; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=56LjXDb4PPVvm50DRB3MZU7UUhroOyPSOJBt/6QB3aQ=;
 b=P9Vt8Vty9g9MF+eMuuYPjMbPWHEDdRNVLnrjnK/Y9bhAmQsECpWqmKySFh8T4L2LJq
 byFiJN5iar0FOKLRCw0836jfmxdCQxdb/65V/uHstxOUN4MJtWS83na8nWO2+gjHOvkZ
 9KLtiqINMSCssbyIewRBREBFDMPQFhL9jldrmvS1AEk5q739H/QybuISjMWg3Y6oilTb
 4YLr6LZ19zn1lAaJTgrE1XzOzVf9XoJw8Op6mHSiKR5xQnsjmPiM46N6A6ECfAIXjxna
 u18vjezGbzPJ7mFLIctb1MLbRhI6WGH6pPF1b+XQLk+jnXh2ruioeVJ79HYzofLbyNIe
 ngxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770039244; x=1770644044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=56LjXDb4PPVvm50DRB3MZU7UUhroOyPSOJBt/6QB3aQ=;
 b=aYa7fyKtbea9osMaAuNJDfb8+3UczVBqFzk1Yrl6kr4YhBz7Cvl9zTXlS6OHJCWSdT
 mn3qQIqB9K+DOnyAaWjP8THCgAEsBCN+Otb25xcd+9oxbl3t5ui319AoI9w9WpwYcNiO
 sY/mbGBYGLuqfO9jNJkDaZNOA6KO0+2JIHnclhFgZCaaxNRd4epGeWCFo7vGXVrrhWGn
 4yFi5hLK651HFAF1z9GX7A/6t9MML+uIZfK3Q+lLpuEgdnCNE4eYrJJPR4nNQtxsEQNx
 fOjl/arNzw1fCrPRWye1gl7XryJQLK71sXIaNzUIb2N2nOaVBnTMnHFvLVFXpxF+ZNYN
 BwXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWY98WY3NyI/bz2I5uRJKFCBOgoQ8MT27O+Drq4nFfL2tN8JCtQhxU8l2nZOh0cwbKe9x2YumNF/Ols@nongnu.org
X-Gm-Message-State: AOJu0YxdowMilBSArHvQdyLIEwskxFdDObC31CjKF2ikCwhpHlChIL0z
 xYbJzCVv9wbPqyWCUjbx6paw1y6RHQu3RO4O7CQMeN+DqyQfO/MfNYpilslhg0vTVks=
X-Gm-Gg: AZuq6aIt0leFqnLRqbesR+DEonOtrVEyK1GVTg04kegbvvgBLd00O/Na5xLdqXYEicM
 zLsDgFbllFIIDfQvVK4PI9cp7Q1psNYXJPzmH4YiU2yYvfZnCA9q+RvG5zwidpG/vcDem3eCFcf
 N1DVzqjgarLLT+uGF/k/G+35A+y8YoHozJ1l+EMly6HrRhkheSoqh5Qw1GjIi8DkgVZo0zkuMdA
 sPulih8AFJ/5QlWNM//ubDil5/8lMmGjXgXqUS0jg8UTTlc9nIrz4HFr8giwJfo3UJcv2LyuYCj
 31TtB/gEdaXvK0/ObybwjydLPrgmmvS/5GrjYHMFpECJW4l7u/z0kr6oY+DQpZghkt/kYtMp3Ux
 RrWVDhcz/ArCURk7GWoPdDJFCyXhlcfhEutkUpK/x7JxzJRH9D5uveJlk8nN+zSfbQBCKnbe6rB
 d3PWn2DuJl5YGdnchSTJMTsSy0ypWM4w==
X-Received: by 2002:a05:600c:6206:b0:47e:e970:b4e4 with SMTP id
 5b1f17b1804b1-482db48e90emr139415455e9.29.1770039243795; 
 Mon, 02 Feb 2026 05:34:03 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066c42895sm478054495e9.14.2026.02.02.05.34.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 05:34:03 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 07/15] target/arm: Handle SME-without-SVE on change of EL
Date: Mon,  2 Feb 2026 13:33:45 +0000
Message-ID: <20260202133353.2231685-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260202133353.2231685-1-peter.maydell@linaro.org>
References: <20260202133353.2231685-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

aarch64_sve_change_el() currently assumes that SME implies
SVE, and will return without doing anything if SVE is not
implemented, skipping a possible requirement to change
the vector register state because the SME vector length
has changed. Update it to handle SME also.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index e4a6ff17b1..390ea32c21 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10130,8 +10130,8 @@ void aarch64_sve_change_el(CPUARMState *env, int old_el,
     int old_len, new_len;
     bool old_a64, new_a64, sm;
 
-    /* Nothing to do if no SVE.  */
-    if (!cpu_isar_feature(aa64_sve, cpu)) {
+    /* Nothing to do if no SVE or SME.  */
+    if (!cpu_isar_feature(aa64_sve, cpu) && !cpu_isar_feature(aa64_sme, cpu)) {
         return;
     }
 
-- 
2.43.0


