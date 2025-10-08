Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 238D1CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 22:02:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6c9G-0003tF-3a; Wed, 08 Oct 2025 17:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6c9F-0003t4-2N
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:56:37 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6c8z-0006cT-Sb
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:56:35 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-27eceb38eb1so3163285ad.3
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 14:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759960576; x=1760565376; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6SQAAU0LUd+YJ4w3rVEYpCD6XNIllbO9nR7KElVuTa0=;
 b=jZY9nQNY3Fvk5OI+JzkZ0a8tQV3Z3aF1YoRXtyebTN8MyowidecGnJGgiSjwTDf0vP
 6Qy47kx7heMzyoSjr7vCYPwA2C4kJB/dtKSLjbuahXrK9ugPuEUT4Q+Hgr2L+G8oIxls
 3E+0c82hFHpUXpWLVU5Us3TNDsHEqEGA4YlhbODYuy4XRz6usB4MPTDxe8ok5iC05tNZ
 Eskr7J80yo6NW6kyr7cTsa1+69GrCNmZV0Hb6LHfyvHXSOEyDu9OX3vZXEfrghVecIJ4
 83GuT/41VREjSp5eI37jg3EaEhKlE14WfKD556rHiZeVRelpK0+QTXRTKmCwBFpeZQE/
 dj9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759960576; x=1760565376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6SQAAU0LUd+YJ4w3rVEYpCD6XNIllbO9nR7KElVuTa0=;
 b=EQjBGOJ1o/fx2mpz4YlPYRmRRb7DfmzQWgz/F8n4AK2/wWxmr/38gFmJlT1U/mI+PT
 EKXNLvFZIsVW8VO8eAMo7lrYadtsCevlvCv5ioep2u0a5lq3RSFQptGh7El1yP+VrWBb
 6nBbZw2b4DLRl7zN8v5W+6ucZYJCiJpMNajI6xYhk6lIo8ZcmgRTBLvqF4zkh9e5MWQS
 +NqgidGDusjp23AXifmyLiWoz5a1gUrIp9mJCEmo4d5Gq1sMbgN7Cs2pjp1IOfYy0xKB
 +wbP391lTfNJWr+g7BKr98vsKxR+bAt5lgfnq1P4e5xGCiCUmqF/kCW986L9rQOBwNTs
 kw8w==
X-Gm-Message-State: AOJu0YxBIjGVzYCrK3N1N26Et6HSqdeCyKPsgTow6rartrVZEfBH08wZ
 Gc/k0kDJBUO3b/eGyFIek9PLS4IeZSdpMztGNRKEteOYvDUEsT/9sGtg6px/GKdQrs/SS18AxK5
 RFyS2lnM=
X-Gm-Gg: ASbGncvdi2cRtnF3VH/F90te4EtbDkdWC8nhf/+AALWj4Nq0IgZa8FDTFz1FNe20rog
 Ne9jgWYP+m4dIxBb5q1PTWBNmbexIfFkzH1Cq4IKyQ8m2PwNtXFzczLC5b65oCZBsvGoqA/B2bC
 6JPML6oSZNJbdXsZtiLSyMxHwFzOTV3rQRcYhqExI6gWkIB6gin0aSGpX4Prsysy1T5bCq9/DPl
 CmF36JnAyltN66bCHgW/J4cT/dOOJURi6lbNPcXwE2O3CQPRkmYPdn4Bco5ANLKp0bZoDCgQX2h
 WD9/JSBBNlZ7uiPqcNdLHSVTFlF/RRUt4aK/dAWHaJipKEoJdk1rCSRNcrCP40dnyvqwkz+AY07
 k9US3G6huMYjfbJvzlgNS6qBTGerBW8f95ugIHPJFsm3L1I8xGCJpsjzE
X-Google-Smtp-Source: AGHT+IH6btP/21lQ4QAi54Y29iKhyNTAJKPbBZY3akXiWVz6M94tk3uBCAQBX64ZMjMVJm8tEv2pjA==
X-Received: by 2002:a17:903:948:b0:249:37ad:ad03 with SMTP id
 d9443c01a7336-290273ee21fmr66086965ad.34.1759960575974; 
 Wed, 08 Oct 2025 14:56:15 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034e44ef9sm7354285ad.52.2025.10.08.14.56.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 14:56:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 02/73] target/arm: Add isar feature test for FEAT_S1PIE,
 FEAT_S2PIE
Date: Wed,  8 Oct 2025 14:55:02 -0700
Message-ID: <20251008215613.300150-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251008215613.300150-1-richard.henderson@linaro.org>
References: <20251008215613.300150-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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
index f59c18b6ef..f3e90408f7 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1349,6 +1349,16 @@ static inline bool isar_feature_aa64_sctlr2(const ARMISARegisters *id)
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
 static inline bool isar_feature_aa64_pmuv3p1(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64DFR0, PMUVER) >= 4 &&
-- 
2.43.0


