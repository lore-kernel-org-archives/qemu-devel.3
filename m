Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82D5CD12689
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 11:21:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8HbR-0004ZS-6V; Tue, 05 Nov 2024 06:20:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8HbP-0004Yl-8a
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:20:03 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8HbD-000774-6U
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:20:02 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4314fa33a35so41178045e9.1
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 03:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730805588; x=1731410388; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ysrDYNahrgAVHDeokOZCJEwZEZgWfdy4TG+aarln+ss=;
 b=yr25zUmjtdcyefnt4wvwLxjeyxZ3kBx2raaFGe45HJws/1d8d0Vv9821ynsA9x720K
 3KKQ5wsjvtaI3NNAeTqqbY0S8uClnQhXpV+gvzDfVJuJn9YGqTxmIbu808v1IzklPXur
 sYnNoejL9tU6zFUmdyY8FkaDmV/WT9L0HcNWaSE7NJdokBEHuB3ArhX/dT0dhZC8nNTP
 gWWXv3HBntJn6myEcuk7WBiKmpqrFoS5rQE+EAm85Q+v2o0clj+oYJwml8HyYr/8aPio
 PTdbzGZQO9aHSb+xjINz2+GdVAabKqOZ6bdbzmhLhAdUCn+CWH5glfpKpGRJBnL4y7MP
 /O2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730805588; x=1731410388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ysrDYNahrgAVHDeokOZCJEwZEZgWfdy4TG+aarln+ss=;
 b=xD4Fnjbq3psBFTDbM61/vMj/Df/IhZEpcDxdvnLXE9VeC+xZvv+7xZilz6pGJe/Dds
 jBju9jYVAVgBeGqP1b7NCS9dc7ATaJwhn4HgARYHuf0owkgcwkVXpknu/0by3mHlpOoh
 axOO6wt6JpE7yvELzU+sPYo4zv/J5RCp0hru2KKJx0gq7m1cLdu5/t0W+ZaOOe/s2luW
 vIrdQZ2jKVoe8gQUxFHOLZpEggZPwPQtLbA5UzJoSfgN1va0HGATjcrSQDtzUb2z2U0W
 aPUAVMjUkB6t9xWHaSyzzkUiis+0+6V8kzM6VqZxgr0hDLc0zDxVh1fEHjk1kwWhao0x
 FSGA==
X-Gm-Message-State: AOJu0YxwtJB3naufQOD0og391bGbWygazc1BI86o3DFEfKjqTsg9j79S
 +IKnZO92XekBNX3Y9ahkr7lrgPhAVpsqBD5FOjPIX6seuCp4nF+fhnOhrF+/dM67JJX83EszkcK
 I
X-Google-Smtp-Source: AGHT+IFu7LdsW6h4c1v4CrfHCxooSzvumknPpQezRX8foxcSmEd4rcTeej84b16jcMeYxeVxDMCsIA==
X-Received: by 2002:a05:600c:198a:b0:431:6153:a258 with SMTP id
 5b1f17b1804b1-431bb9855f6mr212117345e9.13.1730805588212; 
 Tue, 05 Nov 2024 03:19:48 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432a3688813sm16354555e9.1.2024.11.05.03.19.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 03:19:47 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/31] target/openrisc: Explicitly set 2-NaN propagation rule
Date: Tue,  5 Nov 2024 11:19:23 +0000
Message-Id: <20241105111935.2747034-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105111935.2747034-1-peter.maydell@linaro.org>
References: <20241105111935.2747034-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Set the NaN propagation rule explicitly for the float_status word
used in the openrisc target.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241025141254.2141506-20-peter.maydell@linaro.org
---
 target/openrisc/cpu.c          | 6 ++++++
 fpu/softfloat-specialize.c.inc | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index 6ec54ad7a6c..b96561d1f26 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -105,6 +105,12 @@ static void openrisc_cpu_reset_hold(Object *obj, ResetType type)
 
     set_float_detect_tininess(float_tininess_before_rounding,
                               &cpu->env.fp_status);
+    /*
+     * TODO: this is probably not the correct NaN propagation rule for
+     * this architecture.
+     */
+    set_float_2nan_prop_rule(float_2nan_prop_x87, &cpu->env.fp_status);
+
 
 #ifndef CONFIG_USER_ONLY
     cpu->env.picmr = 0x00000000;
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 40cbb1ab73b..ee5c73cad46 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -407,7 +407,7 @@ static int pickNaN(FloatClass a_cls, FloatClass b_cls,
     || defined(TARGET_S390X) || defined(TARGET_PPC) || defined(TARGET_M68K) \
     || defined(TARGET_SPARC) || defined(TARGET_XTENSA) \
     || defined(TARGET_I386) || defined(TARGET_ALPHA) \
-    || defined(TARGET_MICROBLAZE)
+    || defined(TARGET_MICROBLAZE) || defined(TARGET_OPENRISC)
         g_assert_not_reached();
 #else
         rule = float_2nan_prop_x87;
-- 
2.34.1


