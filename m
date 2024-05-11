Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C87AC04FFE
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2024 11:55:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5lIz-0000N4-I6; Sat, 11 May 2024 07:54:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s5lIx-0000Lo-86
 for qemu-devel@nongnu.org; Sat, 11 May 2024 07:54:19 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s5lIv-00070K-Mf
 for qemu-devel@nongnu.org; Sat, 11 May 2024 07:54:19 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-34da04e44a2so2095194f8f.1
 for <qemu-devel@nongnu.org>; Sat, 11 May 2024 04:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715428456; x=1716033256; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G/dRk75Xa2dli8e7P8dUDOHpTSk+dp2zsSzv4pGi5N4=;
 b=QD47BkWW9q96XcJcMaBATjXWSH81ks9IjNgK8qQ2XOETSOy++Zo5G4iPmyBiwaMFvX
 snFAHCeEQy58+9uuzNSNuRcNxV9ccV6Iih7qDB89AhgPXHoxI9je/SD1Jp6oEggXlAPq
 imEPJw1CdXNbSwUXVuhKyckmKH0MELbYWJ9RhZVxIPGy9L67XucXyT11PbHN0MzCsHmC
 q/0ZMPapjz9kTWMb+NdMlfCDo3Jrr3/VuNaEIkX4mcFVs2Wpthx6fe37RAELaKSvzcw2
 7xiySVMiE9yMGWDeV8Y5xxu+eqGPtXPAPyfioailaDl9EhjCN05iAMnp3aXPlS7eA8gq
 A2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715428456; x=1716033256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G/dRk75Xa2dli8e7P8dUDOHpTSk+dp2zsSzv4pGi5N4=;
 b=mGkYcV03+5t9GeIjFVrQg9MV/zKD8PldNA+TEF3Akc7KRNNMJmhM6Qunlt1tUJ2VJ4
 NgW3vgb4HET8ePZUffTyg3XYpuXsTU38rP3ZIpRccJAQuCcL/CvR6HfI9DW7Ycp+y1X5
 29EnWumnOibWPI76wPfPpR4/4+8dbDBtO1i0u1FVzVY0lZxdJ5Q7jwmlMVzGRPDDn3Pk
 79EIkcy6bm8KOwcudcUzLjQprS5i+8IQFNJzh2G7DIXNOoaG60o9J9MTb9SeeAwXQloy
 Qr+eU0BTO+5LQ7zOMOsBtL3B8+LLXhlhgJpgHqHRy1q38q8jO+tD/JRwD45tshuM3vsv
 a8XA==
X-Gm-Message-State: AOJu0Yzt/e/at2Xj716CHFeyBNkehg36jAcNKJFS1tpU2M5j8//ypH9z
 ddlpcR86ESCdEMPbi3jZVPoA75o0+/fYbdYWy3Cj4nyDncFcQSrB9X228K74HQXwbT5gaKOR8Nf
 aB4w=
X-Google-Smtp-Source: AGHT+IEo1X/3tbOuwLKXh8uynojPItWy1B1ixA7c78ZF8mRgb7G66oZm8q5Gkrryh8ZirwBoV3QsXg==
X-Received: by 2002:adf:f98e:0:b0:34f:4e40:c05c with SMTP id
 ffacd0b85a97d-3504a738b54mr3195196f8f.34.1715428456209; 
 Sat, 11 May 2024 04:54:16 -0700 (PDT)
Received: from stoup.. ([195.76.196.165]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbbf20sm6764797f8f.93.2024.05.11.04.54.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 May 2024 04:54:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH 14/17] aarch64: Use bool for sve_{z,p}reg_is_eq
Date: Sat, 11 May 2024 13:53:57 +0200
Message-Id: <20240511115400.7587-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240511115400.7587-1-richard.henderson@linaro.org>
References: <20240511115400.7587-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x435.google.com
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

The functions results are more naturally boolean.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 risu_reginfo_aarch64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/risu_reginfo_aarch64.c b/risu_reginfo_aarch64.c
index 55a9ef6..6323eef 100644
--- a/risu_reginfo_aarch64.c
+++ b/risu_reginfo_aarch64.c
@@ -268,12 +268,12 @@ bool reginfo_is_eq(struct reginfo *r1, struct reginfo *r2)
     return memcmp(r1, r2, reginfo_size(r1)) == 0;
 }
 
-static int sve_zreg_is_eq(int vq, const void *z1, const void *z2)
+static bool sve_zreg_is_eq(int vq, const void *z1, const void *z2)
 {
     return memcmp(z1, z2, vq * 16) == 0;
 }
 
-static int sve_preg_is_eq(int vq, const void *p1, const void *p2)
+static bool sve_preg_is_eq(int vq, const void *p1, const void *p2)
 {
     return memcmp(p1, p2, vq * 2) == 0;
 }
-- 
2.34.1


