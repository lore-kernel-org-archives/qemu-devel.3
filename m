Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C16ECAC5B9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 00:14:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1w4l-0002TR-8B; Thu, 25 Sep 2025 20:12:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1w4U-0002Om-8Q
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 20:12:23 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1w3z-0005E4-R8
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 20:12:21 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-b54a588ad96so1290384a12.1
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 17:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758845497; x=1759450297; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kcClI7m25dTyiPzuDzCn39Fl1dtWRkullkqKPyEzDJs=;
 b=rxWGCsqof37HVB+wcFHa0+JprHbwE8rEUXMQ0HN3c1RW4xGuGxykkGisSFMd+2aipZ
 Lq3rgKQeDDVgQUnhNSm/XJdRHaKmtIWfJDWwugvRGYvFhjEScyilokGDDm0v9D0G2x1t
 k67iQ7w9eRMtWnR5fbRfWRo0CsmSOQ894DeIbvQ+6NEtgvR6fUIQIubmib/kf2o8kPy9
 d+mo3i20pikoKOzLYt+VXbsJ75biNA+oquvju52DP88XxZKl/1xl7cEwjBQlr66ilgX/
 pJtolyzs2hoG+86obhXwYg2bVjWmg24kS3cu6gWUOQP9lVMjUDqaD+2RbjsTBgibsO9+
 6HHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758845497; x=1759450297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kcClI7m25dTyiPzuDzCn39Fl1dtWRkullkqKPyEzDJs=;
 b=X6bk57mW//+0KkxaxDoeT4m1JswVMjTlIK51ZexT9qI7eltlcN6IYdbRT8S0f5OClH
 e7jQvaBPHQAhS2zfQQQWztqfSxlUg8T8norJTv/xRCQMhZuwIt8+sS/K3w9Xtww/fBbe
 D3oTlOntBugcG8l16cqeghAh8m/JFe5Lzfc25XDoITZOKgVzDkGDWtO/s9cqeCr5ncAy
 s1BrZbl5C0Z7dmohV7gzB19a+k7XCR+fC6uRJ+ilfkn5ZSsxL7Y4M5UHrB75HeHv/g4/
 zgc3BQ9IkqG+ybkctDs3illv2RPh9R8P9R3iIPUVZiaTZnXfDzJnmksHB8x1ubFAIdQx
 UUUQ==
X-Gm-Message-State: AOJu0Yw18Fz7rlYBeq3KAPH3Duc16IHh/5t489qqpVOGmF1AaLLjRfeb
 KKksL1mzvK4VrJaX5h45GtDlCH/0B4h/whAicvKQ2l93npwKkEOMQHBHy45G1luwxJEmLVqyN0S
 f6X4Z
X-Gm-Gg: ASbGncu3cbKkyB7pEcOV48jZ1d5+DzdsQEs/l4+m+ip9Lp2csflt+YmvUOwyFOxxBAD
 0eJzzN7e5QAiJXwYZUfbhF/RLQKcbX4IhUedInAFIMNGNeYSnvgAzmQMUIzpO2YLTWV3VGi3tgI
 5I+ZaWi3HOlf1QlPjw7HXIjhiq0KlyNiqqiUm1MwzfNt/HE/fW4+ojUN7jRHuo52whgjtnEHLna
 xIQvfYmhJ9tsvy3r7Cnzygw0fdSvmyD4eOccV9wGzI2J6HJQRmK2Qe9g3Ya5Y75rWG7z7X88nIS
 a1Gy9apS+cURYPGgIXqFePxkDA/1KJ8r8gZd/SWEzkFNhLCTzsTBiJ0Nmm6+HIvXZZq/1sPnVIS
 hCTUwXi90gw9FzwQkJ/yOPfAfFW9b
X-Google-Smtp-Source: AGHT+IFsEyz5WlnAo6xTH1f52qGXXyp1Gl8gRzR7NDHh3yP+P0E+9biRYZiMYxGOCAIqXgyZhF37eA==
X-Received: by 2002:a17:903:1a07:b0:26c:4280:4860 with SMTP id
 d9443c01a7336-27ed6bdf53emr46166855ad.8.1758845497240; 
 Thu, 25 Sep 2025 17:11:37 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27ed6ac37efsm35829425ad.137.2025.09.25.17.11.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 17:11:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 02/10] target/arm: Add GPCCR fields from ARM revision L.b
Date: Thu, 25 Sep 2025 17:11:26 -0700
Message-ID: <20250926001134.295547-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926001134.295547-1-richard.henderson@linaro.org>
References: <20250926001134.295547-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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
 target/arm/cpu.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 1c0deb723d..c4235fa5ef 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2405,13 +2405,19 @@ FIELD(MVFR2, SIMDMISC, 0, 4)
 FIELD(MVFR2, FPMISC, 4, 4)
 
 FIELD(GPCCR, PPS, 0, 3)
+FIELD(GPCCR, RLPAD, 5, 1)
+FIELD(GPCCR, NSPAD, 6, 1)
+FIELD(GPCCR, SPAD, 7, 1)
 FIELD(GPCCR, IRGN, 8, 2)
 FIELD(GPCCR, ORGN, 10, 2)
 FIELD(GPCCR, SH, 12, 2)
 FIELD(GPCCR, PGS, 14, 2)
 FIELD(GPCCR, GPC, 16, 1)
 FIELD(GPCCR, GPCP, 17, 1)
+FIELD(GPCCR, TBGPCD, 18, 1)
+FIELD(GPCCR, NSO, 19, 1)
 FIELD(GPCCR, L0GPTSZ, 20, 4)
+FIELD(GPCCR, APPSAA, 24, 1)
 
 FIELD(MFAR, FPA, 12, 40)
 FIELD(MFAR, NSE, 62, 1)
-- 
2.43.0


