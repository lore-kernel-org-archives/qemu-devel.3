Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A44CAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:28:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v298I-00079K-Mm; Fri, 26 Sep 2025 10:09:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v298F-00078a-Kd
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:09:07 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v2986-0005d0-2t
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:09:05 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3ee64bc6b85so2062968f8f.3
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 07:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758895730; x=1759500530; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eDFX7y4atdN+lmLu8Si4CvEkIGbpJPZtNB7piylWeSY=;
 b=ObcBZ9yUjUlKhEzGjNNdlUlF6BHlfkOjQsCA97VPMybnBOeH5P+pI46y8UIamfMrV7
 vjLZy+T6H2sQLVj6qiFtFdivPge5X7SYPSMvfBLnYG44Y676R7C9IL+9ejk7hntL5FXm
 4M1SPLSZRawJhpPEleHl02ym51FUZck+GpEOXnmoVxJr4LCcdOA0warUe6XQO+Sj6Pdf
 Fu/WMdCv57TDtsO+prU28XpO1tFwxro/RqQWJCPp7v1ROCAxqlZmRBHsg1Gl+epCx4em
 2AUfcfNz8qtrOg+zwhEnsrZUCETAHrkfjMfQB1vtqQWnHqPX0w7qaMOGfzp6tW1Vc0wp
 nSsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758895730; x=1759500530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eDFX7y4atdN+lmLu8Si4CvEkIGbpJPZtNB7piylWeSY=;
 b=geZf7ZZ0mLA1g/cBNSoqlePghgx7iYZRgbeAzLjKnrhoL48ZnBOXUMu5NpmCgCE+f5
 XVaTimLLnglETaNYUxjpu0fn/1cp1jyUOfVQ21ShW4Fr/bvao5yWtGhH1pjs2GSyRlH5
 yVQMBT5weWXHgu3A/GvWw4JnHQc2Q43DviFJWFd2BnMYZQTMsQdT4z1DCAHcYXa8eT62
 2Ur2Av64+gafxgL+Z20xPWQr0aeg9RDTuCj1S5NGIGxFaTYHj0CM0VtQKjpjejal13TN
 B6s3Y6p4xkrneqHAOH4T7xphmmuH+Ufbf58hqQkOo0D5RBDSsPnX4/pMNS0wcaIyjoZl
 UPFQ==
X-Gm-Message-State: AOJu0YxZK5OEWLklZYBe6XU1KVdTkY2HELzHmYrGbtwsJLU31jMH7lWW
 HPqWXzQU6fsOiCVwwST54NcrLvOxUC2xS1O+AKHNPZvsJEFvk2J4mAYyJf9y0odEjipgpYF0STd
 /pLqc
X-Gm-Gg: ASbGncubogUeVg0xZJ2i9S5XV4yL9mOL9FsxoO7kOe0uS/77AhqLhpkO77Aw7ca4f1y
 Gh3oarsMGpLHRzDKg+AUOkScbTBKPp9T3JKIQwKfFLlICqaX78e9rkwg+XjDxP8WP3Fq6H/cLhB
 mAFiv8oahiidCQix649N7ExSm6PEznLZDEKSHMmmvVj9N0Xn+tITMOKcEmqbJgqqBmST0FMeHjj
 6yNn8lF28sTzOFhFdhrsQm0k3fMMQtUPTtjjHNIyeSHK6soNb7GcWYTIBbKr3BN+pFs5b/gw1VB
 23vwptHrI+lMY/RFusRIq43CcO7KxTvlEE8paaTgTFX12VTL3t1GI8WttaQCBLZkKOokEiHUl9+
 IgsDRvRFNLzlSIaKRcMh+Ucxy5Lu9xQIK3l6lBPg=
X-Google-Smtp-Source: AGHT+IFlTbUdJ8ApgOD2m0UMPYCRAh/iL3YXXivP5feAPaZuKn2mHgpek8ysUQKXtZFRIGzKyLAOKA==
X-Received: by 2002:a05:6000:26ce:b0:3ee:141a:ede5 with SMTP id
 ffacd0b85a97d-40e4a42f3aemr6923075f8f.57.1758895729897; 
 Fri, 26 Sep 2025 07:08:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-410f2007372sm6338315f8f.16.2025.09.26.07.08.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 07:08:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/44] target/arm: Introduce KVMID_AA64_SYS_REG64
Date: Fri, 26 Sep 2025 15:08:03 +0100
Message-ID: <20250926140844.1493020-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926140844.1493020-1-peter.maydell@linaro.org>
References: <20250926140844.1493020-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Allow us to create kvm ids directly, rather than going
through ENCODE_AA64_CP_REG + cpreg_to_kvm_id.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm-consts.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/arm/kvm-consts.h b/target/arm/kvm-consts.h
index c44d23dbe79..fdb305eea1a 100644
--- a/target/arm/kvm-consts.h
+++ b/target/arm/kvm-consts.h
@@ -180,4 +180,15 @@ MISMATCH_CHECK(CP_REG_ARM64_SYSREG_OP2_SHIFT, KVM_REG_ARM64_SYSREG_OP2_SHIFT);
 
 #undef MISMATCH_CHECK
 
+#define KVMID_AA64_SYS_REG_(op0, op1, crn, crm, op2)    \
+    (CP_REG_AA64_MASK | CP_REG_ARM64_SYSREG |           \
+     ((op0) << CP_REG_ARM64_SYSREG_OP0_SHIFT) |         \
+     ((op1) << CP_REG_ARM64_SYSREG_OP1_SHIFT) |         \
+     ((crn) << CP_REG_ARM64_SYSREG_CRN_SHIFT) |         \
+     ((crm) << CP_REG_ARM64_SYSREG_CRM_SHIFT) |         \
+     ((op2) << CP_REG_ARM64_SYSREG_OP2_SHIFT))
+
+#define KVMID_AA64_SYS_REG64(op0, op1, crn, crm, op2)   \
+    (KVMID_AA64_SYS_REG_(op0, op1, crn, crm, op2) | CP_REG_SIZE_U64)
+
 #endif
-- 
2.43.0


