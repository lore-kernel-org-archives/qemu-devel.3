Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 264E4C531CC
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 03:12:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn6Jz-0004q7-Px; Thu, 23 Jul 2026 23:11:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wn6Jw-0004ZN-T2
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 23:11:32 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wn6Jv-0000VF-BH
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 23:11:32 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-cb5b8572b70so1188476a12.2
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 20:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784862690; x=1785467490; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oFeXnH7MDXgLDPsf0NyTmkQzK0nNZ2yXHfQdFmWjb4I=;
 b=qyhIqvlyvMgxfoYShWvMp93g4JAW/qEImoZlNEmVqIigwC8gm5sNuMvbqDze/coyJq
 oF9MZhaBukBzTrxZPRnwP4RJ99JOII3gujwBu0XVeNAJmOWmA/AWsPz5f35/BAiFlJPQ
 kBLHFOD4jhWq6yhwHSXIPnxs+MIxfK5B7qQl9PiqBgbjDdJQEM7wKiptu1tOmooeuyVq
 04CWVPg1ddhjUGBjw5TGPirINt+sh0jK4UcPl10RE/Jon49Q1THzHRESVWqSTK+Cy9SS
 RaZ/sI6/Z2hHkoY7L9gdzn2YhqVPPguFknOsj9rVYFkNs2mE24fR2wSLeYfYSvmnvntW
 cgrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784862690; x=1785467490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oFeXnH7MDXgLDPsf0NyTmkQzK0nNZ2yXHfQdFmWjb4I=;
 b=YJu75GOO7yRRFB86ipT7gkCPPZXZDe8+1g75X64x1fwGjbyXMjJcjg3oZ2BIxBMumd
 Z/RSI06GtcxFyKCJF7XBSqHvENb5bFyAA91cmAiaiX7tJPyS2F0MwYrWI4Z14fK6PIsI
 JbU+Dy6XhpN9rs6KjPIz2IiCBA4DhyCtlV/aUvKz/uqadrxnLd+9Acx9+vsdeDI+Bp5A
 UM5AEfSW4nr3XC5fxUKQF6+8omYQjSqguwDuTFpS8iLe8T43mOdT8k6KzrSVscj1j/Qs
 2/uvqIRoEaPb/YfBcOQ87GDH3zuhGxrVOVdOBalxIw+9v14a1scxufgURAQEx4rKqiv1
 V8Ew==
X-Gm-Message-State: AOJu0Yw7WGYXyXuBjCf3CGuAf2Riwcra0DlVAl6ADJUuqpSP1oM2CZbl
 6Gsw9+5f5FpNc5f/ROsJCyBsHlBjIF0uF5c3uQlOmA+jrLRb+QHOsAFSp3qP6J2wg/rmCeK28Kb
 pzruF
X-Gm-Gg: AR+sD13nZWslHRnfknAigLcEcUA56pAM4y5Am/WD/VAuBcM9JjJcBSOOLjild/y3iyg
 SfH6k2Fen3LpHyYycNZf+4SyYCpU9zPywV2CsFpx7Bm0JABRwyjOT3jqxpDLyMFK2VzQ7A3Kz4H
 DLqMuvZKpliD4MxQTrKGTOTv4xVHocL537Mf8HL4uaVRtduDOejsAnuViEf+sav7Ex5MtafAA4T
 SeqPHKFLttrNpDVyvVtEnzh0zKpSpmTSe6aIpUYESh7I2CW07XNzABCbfoQI7Khw84PXvq3lWqC
 /sTh+wuL9Cio78MtASx3+c5zP9iGiu3+6NjLnscgPXZFShizVEnR3SnmjOYB5lF7J4uk39hXay7
 C+utHysrG7sPkboEAhAQ/U/QTyHfDzntk8xdxKaTFQaNJQRyVOYI3QG39lz3Fw/qjSj3/aWn+DR
 RhIpr3bpMEYAAK7hPXO62P7yanGj5Apih7Xg==
X-Received: by 2002:a05:6a20:9183:b0:3c0:9c19:6591 with SMTP id
 adf61e73a8af0-3c44b2c3b52mr7096432637.75.1784862689815; 
 Thu, 23 Jul 2026 20:11:29 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbb8f0d872bsm3617697a12.7.2026.07.23.20.11.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 20:11:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 6/6] target/arm: Enable FEAT_IDTE3 for -cpu max
Date: Thu, 23 Jul 2026 20:11:23 -0700
Message-ID: <20260724031123.76597-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724031123.76597-1-richard.henderson@linaro.org>
References: <20260724031123.76597-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/cpu64.c        | 2 +-
 docs/system/arm/emulation.rst | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index a0d8d0bac8..4d99fc87ee 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1342,7 +1342,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64MMFR2, NV, 2);       /* FEAT_NV2 */
     t = FIELD_DP64(t, ID_AA64MMFR2, ST, 1);       /* FEAT_TTST */
     t = FIELD_DP64(t, ID_AA64MMFR2, AT, 1);       /* FEAT_LSE2 */
-    t = FIELD_DP64(t, ID_AA64MMFR2, IDS, 1);      /* FEAT_IDST */
+    t = FIELD_DP64(t, ID_AA64MMFR2, IDS, 2);      /* FEAT_IDST, FEAT_IDTE3 */
     t = FIELD_DP64(t, ID_AA64MMFR2, FWB, 1);      /* FEAT_S2FWB */
     t = FIELD_DP64(t, ID_AA64MMFR2, TTL, 1);      /* FEAT_TTL */
     t = FIELD_DP64(t, ID_AA64MMFR2, BBM, 2);      /* FEAT_BBM at level 2 */
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 9528afbb18..6da07d9951 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -105,6 +105,7 @@ the following architecture extensions:
 - FEAT_HPMN0 (Setting of MDCR_EL2.HPMN to zero)
 - FEAT_I8MM (AArch64 Int8 matrix multiplication instructions)
 - FEAT_IDST (ID space trap handling)
+- FEAT_IDTE3 (Trapping ID register accesses to EL3)
 - FEAT_IESB (Implicit error synchronization event)
 - FEAT_IVIPT (The IVIPT Extension)
 - FEAT_JSCVT (JavaScript conversion instructions)
-- 
2.43.0


