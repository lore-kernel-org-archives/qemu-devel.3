Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0E36C87FCC
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 08:07:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufwMM-0007Iu-Vb; Sun, 27 Jul 2025 04:03:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwLh-0005Bv-NZ
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:03:15 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwLg-00043z-46
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:03:13 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-234b9dfb842so30465085ad.1
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 01:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753603391; x=1754208191; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3cpS/rQKc/KiLSv/x9q7oUeyX2cxzb+6hLrCr5m20LI=;
 b=LaLk2N9r5WGVELKQflY0REHxc6IW7RCttUU8yeOjxFYYY3/Ca7CRpKS23mIV+p53Dh
 /QIBRBz6fSpmz4VPErtwJOaNkgBd16sH1YKlBTJ3s7/lZIZkIljL50N479km4NiMVCvs
 Pjur+M4BfUVz6zC82aA7sToxT33Fgc4BFl9GdFJeJ5jFPiU5nGKfXmT8GIssVPy1P3Nc
 o8RBpQkLZEDUlH7UQmBgeY8kpIeAgFNQmo3/shxlLOiOKnfFOKU+nUOEALwv6m5htt+2
 GDhLnVJ+0J03mLTNHg2rNQOAOEECZQS9X/ls/mD94+CzSvmtLQgSKDWwZ8VEIwWH10ka
 tRsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753603391; x=1754208191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3cpS/rQKc/KiLSv/x9q7oUeyX2cxzb+6hLrCr5m20LI=;
 b=FWCXLrVQ1zO8CNp3rc1vDT+k76DXOKzq6O/sijObFYuc3dI7h5jKwgfwSoYugiucGy
 xO68Rt3BUK9bFNafiVB9/VxyUdVIPZgf8FLG5xr3ZhFiQZ1L6yh6Fdr4effFQyNKov9Z
 on4xODq/L/dBG+ZRPISBFPLJ0HDYviym5RxnJZH5hjVYf05gcwlPo/HblFCsiAyqcBVc
 kTGGvdiq/f75zQE7ciyATDLzKWhUrhHbrDkDCXUNCDt8ve8sQh7DznkON0khRWafFB6S
 9SRPpeXLf+p4l3H3gJwqWUHDsYOmoFInXLLqLlEVdrv4YaLwLsHY2ysMjZoOSHxQL3nD
 i8Vw==
X-Gm-Message-State: AOJu0Yxw0oMrivbCC/RQ/eRyQnK6jpMxSx2Z5xcqDxNx+pxoaoXB6IxN
 Y4pkpSEeZxc7jFrtZRCNdWhspE/AxDOBgGcrC5Cg9KygEB9ZX0+O6cebXZoTbTj/0/8qa43U3o7
 ryrE6
X-Gm-Gg: ASbGncvZMpVw/8pGRtmhzPDN/ku0M3KGjsE37whLIHIOyNn1Wf0e97HTgUDAb7Hetw8
 3LZMsRhyoCCm0QB2m5yQCU9ReHeo8TdPKgSV/20WEwjZcrviU6Ztmkw9a85mhbwyMiEw1Jxk+zx
 YXKsWrxPZ26Wr+Ts2CAxdy2chTGaeXVF/AkrPn9zdGY259RChM55s5xJmtwCuaB5Ag360ocxlwu
 atn93uMGsdw6galMB8qG09JA0O2MquRgMCU3WZI69RJQYYTYiYgHtdcRY6zFzZt+6n4TNL75kPn
 PBo+5Y7mDwOW9vZgr5UXP39/crL37jxRwTLSjQJcLt0CLBG+YKJsm9QpFqfjBemRyqeESAJb/5e
 HNnL/eVN59aX96gbmk2WRJUabOKsQ2dRviKV45WfJHIxjNzwAgg9xKULjXXr+JukicguKLgFi7d
 fReYceoixJGQ==
X-Google-Smtp-Source: AGHT+IH+7Wbhl7q+tsyTaGSVUjkVhSeWJO75Vu4sJUBoMTEl3Jthz3XcGKZ/bxpWAZjkB5bDSo1JvQ==
X-Received: by 2002:a17:903:fa3:b0:235:f298:cbbd with SMTP id
 d9443c01a7336-23fb30ac008mr133704455ad.21.1753603390804; 
 Sun, 27 Jul 2025 01:03:10 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fbe333efesm30016415ad.65.2025.07.27.01.03.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 01:03:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 11/82] target/arm: Enable TCR2_ELx.PIE
Date: Sat, 26 Jul 2025 22:01:43 -1000
Message-ID: <20250727080254.83840-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250727080254.83840-1-richard.henderson@linaro.org>
References: <20250727080254.83840-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index dc6c82b7e2..61ba9ba5b2 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6202,8 +6202,12 @@ static CPAccessResult tcr2_el1_access(CPUARMState *env, const ARMCPRegInfo *ri,
 static void tcr2_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
                            uint64_t value)
 {
+    ARMCPU *cpu = env_archcpu(env);
     uint64_t valid_mask = 0;
 
+    if (cpu_isar_feature(aa64_s1pie, cpu)) {
+        valid_mask |= TCR2_PIE;
+    }
     value &= valid_mask;
     raw_write(env, ri, value);
 }
@@ -6211,11 +6215,15 @@ static void tcr2_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static void tcr2_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
                            uint64_t value)
 {
+    ARMCPU *cpu = env_archcpu(env);
     uint64_t valid_mask = 0;
 
-    if (cpu_isar_feature(aa64_mec, env_archcpu(env))) {
+    if (cpu_isar_feature(aa64_mec, cpu)) {
         valid_mask |= TCR2_AMEC0 | TCR2_AMEC1;
     }
+    if (cpu_isar_feature(aa64_s1pie, cpu)) {
+        valid_mask |= TCR2_PIE;
+    }
     value &= valid_mask;
     raw_write(env, ri, value);
 }
-- 
2.43.0


