Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08CE4C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 01:43:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcx2x-0000sA-Ex; Tue, 28 Jan 2025 20:39:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcx2u-0000q3-Op
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:39:12 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcx2t-0003X4-8c
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:39:12 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-216728b1836so104439885ad.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 17:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738114750; x=1738719550; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N9C9MHfxTmFfsV2AIVVMljAT4X/LA6EAwI6JuJhSI5E=;
 b=hd7jcJ5c7wo3JRb+IbBBpq+7E0MDelD/rhMtjhFY2tFiP31mmYu7yNnZly6XGQszj/
 76qQH6N2UxpWOfyooK6NOrltu7x467z6RrzsSxIHaTax6Smv9DVtuZVgEc1VZ/G9SRdJ
 92oICvIKZebFGLQfUV6JfhDj+oFBW0N/tNiysdgYorMZ/W5SshJ3N00rahz0Kj4+cA4f
 EVCRB+rJiAOOkj7dTP1+NFBgP5l2dpBLNGKZwaRjxeZPmT5nshM2iIUuzF9jYcl648Br
 NNp5ZNyWpxJwQC+SDHHtAY0RMOiIpFU6T+X872IaCa+03Kve48MEsP5JgYN4Eb2HhNhJ
 24JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738114750; x=1738719550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N9C9MHfxTmFfsV2AIVVMljAT4X/LA6EAwI6JuJhSI5E=;
 b=CL1zgI2Ggt5npLXKSoRy7jDSgbX/pXtQ/gjV/kGF9V48EZV40vzdUgXIiCIu1O+DPf
 C/nIRFpWBJ93MXcrxsSySwI9k7T5TX8uSAbMahr6EU8DwPNaXg/WXXppz469MCh7Ve3n
 +VK1Q0hyBoOs4zpYYLrFk2Ye/GiWCE8R3kQSnR4qOAbhcnMYKSQkvEQCwzBnlIjg+ij0
 wvngb2+sQ+BBlfK5CTmE6fjZGwEflZBAaI0/O/dyo2SesDegulBFD3roCclxtWSWT1q9
 6IfKkMjfn8tPAi/NelXbwganYb2y4pkHLHnRUjDElXlmtL0xBam3087HKzGLNpIzCW3T
 8eHw==
X-Gm-Message-State: AOJu0YzZpaelSNhzHVwdyT86G3U7I2EGpraZi55uUOKd3HLeR0VVARoP
 scwZIdixDDoC/WoLcFipa2GLkOzvna13bKRw/jktdYGvanUtNvUFLjCgHOu250HPtS2X2QjmOXU
 q
X-Gm-Gg: ASbGnct7bu4CnrB/z2FFbM8n4rVXiXYZn2xEKSbLLKH01LiOOxfBTOJ4Lc5pEtDiA/X
 I4DEXqLcxwpnyflBxgkrWZRj6CtksBSjqsplIt3fHDEGpbVU0X/LY8uuhJDkV4g/mEudKC6wsmP
 rSzLvjgfHdMwuarBubKOrQshF9NSSyOYMv3DnRArJkH74r9kMMva0JpOG1rJQVBt/ukm69HBjUk
 2Gb3SoKs+ZS/4BzXYmdmvIPlMK6oZYFrBDIMK3J5yEeKc/CGGwQM/pHAxom8AiROT4T/6VM02v4
 5swcVzFmj4XcgZvWZ0NuirQcKLTG6iZ7aF3sWyBzMgb9j96YYg==
X-Google-Smtp-Source: AGHT+IEhq7xhkbErDZoSfynCEYjPrD0h+HxgBUD4zWjJYo3cYmycGzraZqlogAWGSv1I8dhK2/+sGg==
X-Received: by 2002:a17:903:2406:b0:216:728b:15d8 with SMTP id
 d9443c01a7336-21dd7d7b0fcmr18423825ad.30.1738114749847; 
 Tue, 28 Jan 2025 17:39:09 -0800 (PST)
Received: from stoup.. (71-212-32-190.tukw.qwest.net. [71.212.32.190])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da3ea4200sm89341745ad.88.2025.01.28.17.39.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 17:39:09 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v2 16/34] target/arm: Simplify DO_VFP_cmp in vfp_helper.c
Date: Tue, 28 Jan 2025 17:38:39 -0800
Message-ID: <20250129013857.135256-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250129013857.135256-1-richard.henderson@linaro.org>
References: <20250129013857.135256-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Pass ARMFPStatusFlavour index instead of fp_status[FOO].

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/vfp_helper.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index a2775a2e8d..4e242275e7 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -487,16 +487,16 @@ static void softfloat_to_vfp_compare(CPUARMState *env, FloatRelation cmp)
 void VFP_HELPER(cmp, P)(ARGTYPE a, ARGTYPE b, CPUARMState *env)  \
 { \
     softfloat_to_vfp_compare(env, \
-        FLOATTYPE ## _compare_quiet(a, b, &env->vfp.FPST)); \
+        FLOATTYPE ## _compare_quiet(a, b, &env->vfp.fp_status[FPST])); \
 } \
 void VFP_HELPER(cmpe, P)(ARGTYPE a, ARGTYPE b, CPUARMState *env) \
 { \
     softfloat_to_vfp_compare(env, \
-        FLOATTYPE ## _compare(a, b, &env->vfp.FPST)); \
+        FLOATTYPE ## _compare(a, b, &env->vfp.fp_status[FPST])); \
 }
-DO_VFP_cmp(h, float16, dh_ctype_f16, fp_status[FPST_A32_F16])
-DO_VFP_cmp(s, float32, float32, fp_status[FPST_A32])
-DO_VFP_cmp(d, float64, float64, fp_status[FPST_A32])
+DO_VFP_cmp(h, float16, dh_ctype_f16, FPST_A32_F16)
+DO_VFP_cmp(s, float32, float32, FPST_A32)
+DO_VFP_cmp(d, float64, float64, FPST_A32)
 #undef DO_VFP_cmp
 
 /* Integer to float and float to integer conversions */
-- 
2.43.0


