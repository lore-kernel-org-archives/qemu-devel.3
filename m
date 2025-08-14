Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE08ECA0EE4
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 13:07:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umXXe-0001T3-0H; Thu, 14 Aug 2025 08:58:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXXa-0001Ra-8O
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 08:58:46 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXXU-0004Eb-2N
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 08:58:45 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-323266d74b0so802749a91.0
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 05:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755176317; x=1755781117; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5pyV9I1ab5c29rW3qcGtq+wHa18CtHBS8e6ckAGh5og=;
 b=aBVmYSDTH90lnrn/Oamdh7ZVnLQDp+3V4qUxGr1HQSdag4vajOfz4y4KrWIFeMgbxi
 8979vaCETboj07CHjn4cDixEC0X8vDMbHyJnYo/lzOPqOofoTEJ1wPUal/y1xkFkWcCT
 St5W5EuTyrQRN+p4ol5KHGyLzV2LMwbQLr+CmjURdDiieRYGDn+mEvbCJwUAoJEHOCXV
 AjR0VFAGhVxVD05oexKKn16Y3XytPbZnAOtQ0lyOKcqpD4kGGLRsoAUxAGIyfyOvFgsT
 cea0xxR8dx0hwSVR3ZScqTxQ4vVSKtc5TFWi8JpJtEC5Wz4QyWkGXU4JAcIdQnd2+ADW
 pIMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755176317; x=1755781117;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5pyV9I1ab5c29rW3qcGtq+wHa18CtHBS8e6ckAGh5og=;
 b=raW7y2nrZS4/SNk1wS5zYx0i6OGWhTF3xXCFLVmSf0Pv2meSzl/O44TErouxcIUHc7
 bydv0HrKt+gXtEy3L5fwbQv8P5cJjR5qEk/43GDeeWof2EESNXZFBlEM0ZCQTV+xhuuz
 vuy4Tvf4mhoV9NXpqnaNl30Kx6e3sOj0T/hGqw5WYO+G/j031tA7DiWo7cbEA4YLMvzO
 PfnuAW4BjcjQnAvS7q9vcYyzGg1Lg0MGmZ28I5LVmrNQAHTp+ZrqMsUmaeAjuRaLzEe1
 oAm8cdYC51NM7mvYl0yBtvyn7un5HuhA4WIFekHGTnqKJ6ALAp6F+Z3ri3dRFP8XpS8E
 pm8Q==
X-Gm-Message-State: AOJu0YyvtTKRcXbVplpX76E27nArdDj0I5naucpVg0bqSgLKRc1DefYr
 DPvXrwt9QVj4ja8xWtfGLpWsPQsM/3TOZsPKKsfEa1bavpnE9N9bxR4+HUMQnDNhRWt6Jp+Ckw2
 nvqNJ0zA=
X-Gm-Gg: ASbGncuVRNP2dafHeLvX+f11cCaVvwBcir5TrkvXaJnvpi+JcenJnHH+yzHKZHmOxv5
 k1dpTc8htJmGVmZgl33gGF+2ZAkTrFAdjrYDH3/Yq/vAnrzlKf0M+s+5ilz1mXqaU/MjUwC7iiC
 YwhI3C2JwVmCQGPu3YkxTO/crvfE2lUnpLnuD55Uo40xZ6e5aIzIXUl4FR/VLwNa4Va0gQHRgz7
 k5y+BE6NBrwHcVj2uHuYu05wvWvauu6WAIX7byvX3aIcPTYyJIBJzPqS3EC+ixyGvprYA026Tss
 hiE7DjJi72sxulxCEgVFsH5rweKl5sh87mrjiBR4ZTHRQJbS86B6UL9h+qXph23Ht2o7Lc9MPUd
 l/aIdf6S6fky8D+AhvpWTYzrIWEyebEZrcDIE5DzZo+OdmPU=
X-Google-Smtp-Source: AGHT+IHw/SYpKLV0B8loiRS8XqqSKUM+uNoE2b+an8n5OSmL3dnr3c8Ey072KF1FAmXDzJQm/HDhwg==
X-Received: by 2002:a17:90a:d403:b0:321:752b:6c95 with SMTP id
 98e67ed59e1d1-323279d75ddmr5259238a91.10.1755176316630; 
 Thu, 14 Aug 2025 05:58:36 -0700 (PDT)
Received: from localhost.localdomain ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3233100c994sm1766256a91.21.2025.08.14.05.58.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 05:58:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 11/85] target/arm: Remove outdated comment for ZCR_EL12
Date: Thu, 14 Aug 2025 22:56:38 +1000
Message-ID: <20250814125752.164107-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814125752.164107-1-richard.henderson@linaro.org>
References: <20250814125752.164107-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

The comment about not being included in the summary table
has been out of date for quite a while.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 20b69a12df..dc6c82b7e2 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4566,11 +4566,6 @@ static void define_arm_vh_e2h_redirects_aliases(ARMCPU *cpu)
         { K(3, 0, 14, 1, 0), K(3, 4, 14, 1, 0), K(3, 5, 14, 1, 0),
           "CNTKCTL", "CNTHCTL_EL2", "CNTKCTL_EL12" },
 
-        /*
-         * Note that redirection of ZCR is mentioned in the description
-         * of ZCR_EL2, and aliasing in the description of ZCR_EL1, but
-         * not in the summary table.
-         */
         { K(3, 0,  1, 2, 0), K(3, 4,  1, 2, 0), K(3, 5, 1, 2, 0),
           "ZCR_EL1", "ZCR_EL2", "ZCR_EL12", isar_feature_aa64_sve },
         { K(3, 0,  1, 2, 6), K(3, 4,  1, 2, 6), K(3, 5, 1, 2, 6),
-- 
2.43.0


