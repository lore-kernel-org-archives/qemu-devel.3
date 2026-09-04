Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F7BC624DE
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:48:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TJO-0006CG-2F; Fri, 04 Sep 2026 08:46:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TJK-0006Aq-HP
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:46:26 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TJH-0006tJ-0f
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:46:26 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-499ac87c92bso10671715e9.1
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 05:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788525981; x=1789130781; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Bfljn+s2Wnq05dseDvNEV2VlwDUR1SUHuwTQSSUXeOU=;
 b=aYtDPtRCf+fziNiGccN0+e3mLlWrf9/jV9+m5vNy8rFtwGAcrevrW+DQFTpi2X/VpL
 5lgbYBkMenKxluHx0omE/GHo+1mMSJhJHQfI0wufiCL+Bu/pxdv3nxxAcG2lFH4b6NRj
 tlsBs4NGETDWjxkhf2e0Zkzovr+v8pRcM/kncgTRPMd0FWV5ovr/rBDAYJMk81DH66GQ
 uVNUh+nwqZSa74VCJIMBJNz2N8sHpRmt0iIcGw82bCUQ7RsY4B1rzZ0mmaeYFAx9IVZk
 6J+nKuGQBJtqJ32pnCJWi7tXCCOcIXB87cLfXA1BdDpLB6W6Rxg0tymsc/9Om7ey38Lr
 cahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788525981; x=1789130781;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Bfljn+s2Wnq05dseDvNEV2VlwDUR1SUHuwTQSSUXeOU=;
 b=CS8RRXQIM8TMrFjtsrhvswi9jjIuGY2igspsxyTKSD2rPH7ZC1kmpem9X09HpnC0CE
 XhcHazP8TdC7mVM3Yjwr6rqeVXsvW5MT9fnnJdR7g+gEUKTY3YL7G+LqDXNnLfKOnTJa
 iXucoMFLaqLiYKFz9twvcOcSCjj3s7gDIbzaSULwh1+Gpf+O9JehHcCCVcK0FSvSXJW9
 lyBPRYRValEUvlXc8r0waUrbX501rwq1NQDJGsuoMW1Q+/QlwqczV/wk/Gp21sDajFik
 1ceMaeWuPmaIfL/wkTOXuxSVzw/k0IK0yba69rNagZ2wBlJn86vd4ZRdfpGW4SNkssp3
 RCNg==
X-Gm-Message-State: AFuF++lPOZO7c0nzMLcEOZj6tIUV40mazUtUtnJ6ReaZYK6Txtme5zSV
 culutkNdMtLHlXd4Cx4FqpzGVp9XFO2rNw2vCLf5j7woPbPGFI0a6RnvnjT8152hORk=
X-Gm-Gg: AYBFou0Ks9ENMbQ8ml7hTazoMl6EsaUZ5f9B/vTknr2i6VYmDosfB5g1qe/iOIuAxlU
 +SadTpdlPBNaEtlwKpbaMo3pAdpLBCdjTSbpngQ5CaqH0nKW2wHsRk/yWm0zZiXGRcCif05Zp2Z
 OFXLVyrK4W3yrJcFhegsltk6My9lN9lItdcmpVUFzBupyzK3B5JPm8E/HQSEVf0uNKjo5stQXi7
 eiUyvyrnTXzevfZkVID/+2xL0Nge3/laVyaxhLbIZQj+fLahOLMOyACBrxclyGr+u/SeMIsoGDa
 qrnAh2KFZJ9Z4uGq/RYWExhVRW9SBUbv07Y20KhwvMfvOii6SKNghw0boH0gIvvyH5cxWdgAMST
 XgqTUJMIYEKdtbxptq2Bbtqfco0+rnStpHk7sXG5OOAAd83I8QVn4vfJOwSWbkZAIrYiDmZLQjx
 dKkKE2MPc+naRG4qJyZDIVpsIuRmHTAAPPCJFc0by4WF4eyiMvE7++GjEECDzA9NxdXUArUU0=
X-Received: by 2002:a05:600c:6383:b0:49c:f4ff:e872 with SMTP id
 5b1f17b1804b1-49cf820507cmr56993755e9.5.1788525981558; 
 Fri, 04 Sep 2026 05:46:21 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf7710aa5sm68090895e9.7.2026.09.04.05.46.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:46:19 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 55F8B618D5;
 Fri, 04 Sep 2026 13:46:08 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PULL 041/105] tests/tcg/aarch64/system/gpc-test.c: remove unused
 variables
Date: Fri,  4 Sep 2026 13:44:55 +0100
Message-ID: <20260904124604.2207440-42-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-42-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/aarch64/system/gpc-test.c b/tests/tcg/aarch64/system/gpc-test.c
index f26b23efafe..0ce0ffea277 100644
--- a/tests/tcg/aarch64/system/gpc-test.c
+++ b/tests/tcg/aarch64/system/gpc-test.c
@@ -28,7 +28,6 @@ const uint32_t gpis_per_64_bits = 16;
 
 int main(uint64_t sp)
 {
-    uint64_t out;
     uint64_t pfr0;
     uint64_t gpt_base;
     uint64_t rme_status;
@@ -38,10 +37,6 @@ int main(uint64_t sp)
     uint64_t gpt_table0_addr = (uint64_t) realms_gpt0;
     uint64_t gpt_table1_addr = (uint64_t) realms_gpt1;
 
-    /* Mask is FNG1, FNG0, and A2 */
-    const uint64_t feature_mask = (1ULL << 18 | 1ULL << 17 | 1ULL << 16);
-    const uint64_t in = feature_mask;
-
     get_sys_reg("CurrentEL", currentel_raw);
     currentel = (currentel_raw >> 2) & 0x3;
 
-- 
2.47.3


