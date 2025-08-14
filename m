Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C03CA0EDC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 13:03:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umXXo-0001XL-QX; Thu, 14 Aug 2025 08:59:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXXj-0001Un-ME
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 08:58:55 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXXa-0004G0-0m
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 08:58:53 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-24458298aedso8005825ad.3
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 05:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755176323; x=1755781123; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Aml6O/ihqRQ5/Olxx3E4fWtWtO1GlytBAF8K5CE0V54=;
 b=m42BEU381FgNZ4SozdJtRDmgR3/KIjESREHcYSJtZE86Xg2BNC5yBSRoPUYvqTYFxn
 TCZFun8uv9x2xKJQvnWiu/OJCh8ua0RouiLxRcvY5p3mQGe4RB9IEBOBtPUkxWHBP3MD
 1FKRJ/jszg/TAnIYrvcJp4LW9fW7iVjZdw/RtHkpLm4ACUP7+rjtlmjwIyC2BFNcmjis
 X1p3TpZVj1xtiraqeggvxRxNR6+ewi4Czm+PFYJ34zgbJ/YaszDGUQWZ6OOcYcWoqsLX
 4gf19p/PRytdsMmOTBK0KtFh6ePQDr0lfcpAYetFkdl8wPvIxGO7S+ceMRDjqt/xZdVz
 25bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755176323; x=1755781123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Aml6O/ihqRQ5/Olxx3E4fWtWtO1GlytBAF8K5CE0V54=;
 b=l8ecxUHoaxLAMyZV95LwkcRwTe/mWfiC767feFhfKU4L60DIb1KzV/e77Mbf5Ifa+C
 WkTmsUWIyymotjND5rIB7JSGPuDtBG9RM6u/gWuvUFpErWJFa+NpyMuMFXP6shiFFU77
 v0v5LGwecdCWTdZ3yKy2vftdxFjMOqgxQI2aYiotjYqhsVp0iGD93cAr9QeT6erqg0Es
 iVGvzZPdkhZ0s8yx0WFdy50pZBT+VZU0UEVR7914eTGTt/MyxASjh3ueDncufnqYJlXp
 q5iahQag03uefQhIM6qyYu83aln1OdVd3oSMlXZ87jqljhKMKf7oxI79jWs9BV5LqZeG
 tCTg==
X-Gm-Message-State: AOJu0YxfVZ7FQNjDbXh+usDTBtg3DNbcLCoKQNxNo0HJ91+y7EVv8OHi
 WQQHH6kKf8W2HCjq5jqdsbhC/AF/fpMltf9OWdye0O047wlUf8pQpVImMfoGm8f6DYku7UNyF2V
 KeTs9++E=
X-Gm-Gg: ASbGnctrkJOHQL6PkhMFZSGmtT0fbFELx4+Ioww6lGgEgD+vbpmHkW+kbKEmTjrAGwB
 yyi37rQXm6M2/pLc12JvrSSzSPn4YV5ztYoCTvfmlXXd13bMXQnwRDdx+oNJ1Yep3KI1fxrRcWM
 N0YTiCD3Q7kSyFxyooP9fNRY1rYkfzFGUmjEHTTAXaMZOP8wuUgt2EJQqdrKVR9GAlc74Sg6M8z
 rOka+AvKeFg781Q+k6+ukKg2j0Zr5zscj8YhMmEsK/9sUuw+X9GU43FEEjb7SptSBpe/kGIJ4T2
 YfbCMucf6IR3wkgOcyq9JcLTyaTMfb7KkwAOZUG9BDa1FLaAMR7Mlcp3KJHFb17ERc8GB41QwdN
 bUguWsayRE227ljKyLsqpQPpqDPHRws5E6pBdX5WdszCr9kE=
X-Google-Smtp-Source: AGHT+IGj5yB0d1ShlTVoJsVLT8+9MrMZWzhgwawR9hoaK8Sv+u2CEFTzBYu8//3+dJCYYs5abF9VDg==
X-Received: by 2002:a17:902:e790:b0:240:9dd8:2194 with SMTP id
 d9443c01a7336-244584f4d84mr42849855ad.22.1755176323204; 
 Thu, 14 Aug 2025 05:58:43 -0700 (PDT)
Received: from localhost.localdomain ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3233100c994sm1766256a91.21.2025.08.14.05.58.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 05:58:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 13/85] target/arm: Add isar feature test for FEAT_S1PIE,
 FEAT_S2PIE
Date: Thu, 14 Aug 2025 22:56:40 +1000
Message-ID: <20250814125752.164107-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814125752.164107-1-richard.henderson@linaro.org>
References: <20250814125752.164107-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
 target/arm/cpu-features.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 7f2ca51b4c..83875c06bb 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -919,6 +919,16 @@ static inline bool isar_feature_aa64_sctlr2(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64MMFR3, SCTLRX) != 0;
 }
 
+static inline bool isar_feature_aa64_s1pie(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64MMFR3, S1PIE) != 0;
+}
+
+static inline bool isar_feature_aa64_s2pie(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64MMFR3, S2PIE) != 0;
+}
+
 static inline bool isar_feature_aa64_mec(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64MMFR3, MEC) != 0;
-- 
2.43.0


