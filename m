Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F88C0218A
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 16:48:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teGZE-0000xK-It; Sat, 01 Feb 2025 11:42:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGYv-0007f8-Gt
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:41:41 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGYt-0001Om-Q6
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:41:41 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4362f61757fso30921595e9.2
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2025 08:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738428098; x=1739032898; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Yh1n6FmEPulTUWbKWOS6FNq8sYNNIAAaiYa9QDAAcD0=;
 b=wIQVascc+hbeUlYIh1FvLwQIw1eHAwVxdYYsi7cePHqPd4ketUfJ9SKqZbnEx8dOeB
 JF/EXfxcuqiExczN9acXtlm9qzYYikbmE7yubuputB9VynE9yzzhCZulFbdK8/I2bIdi
 4VoeOJm+M/d+5fmSuehTpGJF4vgZZyXDMPXzLwv/1N0F1fOy8lon8LaqbdUincgeZSHr
 HAXvwQQVX+8o84Hncf/gWahWbIKYmKrgPnSHFscuPZxbKpjtaLv+16uAqkDOq4kd/mNt
 ixYAp7O2ztGt2zaEE+prQ31343uPQPVaTx0kLToPUqNyUjA++MgjEWMkuQP60lhr5AIl
 wPLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738428098; x=1739032898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yh1n6FmEPulTUWbKWOS6FNq8sYNNIAAaiYa9QDAAcD0=;
 b=Rw3rHgI9jQB6tRqAQH22hPMv/VsKbfxdsrHwYFuvi4OzuCojsJO0F0BX72uqpUmWtN
 e2FlzvUQ3/v4xJqsG4sbvSev6NLAJuai9wBl5j5tnaBoVwoJ55z38YhvAMF8bIw0KIUD
 IWR4q071xFy97H/B7bCSKLmVfPKo0dSy1fZ6XLPsADsPUEdeMTkJRsRdmkK6bcFfbkCd
 jqy07ZZMuEi1cDMkzSUvkX1u1kRzknc3tPb/csuutH+cEUbtN1Pq8dhy7HmHepC+FOXr
 HvEf4ytHKVC7NLOsKqgNq3sWko3yn19C8h7B9vF9t9ubQJgtVaAc9Ztp1Pl04lQy8/24
 dSWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnINDRXa0S1q7R5g1uU6JfdJzJx6ggIY42rrXWmHP/SauWH30of8oqBo9PkqedytWj81L+xTofIjek@nongnu.org
X-Gm-Message-State: AOJu0YyWgYMChsl8jOJnFLrzFZrdz121a3RCnNK4+fWSpODlCm0w/fWK
 89gYudn8sIrlMLBKLv0bcAnk4OQPCgS5zQeZRlKHMyKfulvwgwaPhaID1DHK1P8=
X-Gm-Gg: ASbGncu7xasCH+tRLRc9VD2pGaOYLt2OFu1ea5xUwKsvc0Uo3YMwkeJO2OaU/5goH+J
 iGdWAjCap8R6W0hyii05pqecVBk8+13LZIj7CpzIXisfxIRGVmLMTn2V3kGkYq9EJVibcmOlfIC
 j/bm37IKtKPqJsp1fHG9RXMOj+szR9ugAwCymSCGWvIWMLuusKeo/Q9AU3pwiQcnP2F3b3KzXYj
 fARmnXQFjPYGR/uELRYL3GMnoL2P6MvVtLNimBOkw30SZ3nr7TnKg/3ITA36uxou6dO7+11Z+MK
 yKu3u8y62aReMBxI3iRO
X-Google-Smtp-Source: AGHT+IFheHpIcrfHiC0G4NOK6GMxhA7fcDJcwjoStLTaBM1sSVTXIkZ+ET+fq0kzYIFk+r0MUjG9/A==
X-Received: by 2002:a05:600c:35d1:b0:436:fb9e:26c with SMTP id
 5b1f17b1804b1-438dc3cb50fmr138595475e9.17.1738428098436; 
 Sat, 01 Feb 2025 08:41:38 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc81d74sm127401525e9.37.2025.02.01.08.41.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2025 08:41:37 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 67/69] target/arm: Simplify DO_VFP_cmp in vfp_helper.c
Date: Sat,  1 Feb 2025 16:40:10 +0000
Message-Id: <20250201164012.1660228-68-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250201164012.1660228-1-peter.maydell@linaro.org>
References: <20250201164012.1660228-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

Pass ARMFPStatusFlavour index instead of fp_status[FOO].

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250129013857.135256-17-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/vfp_helper.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index dd3f868a16e..ff4b25bf280 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -489,16 +489,16 @@ static void softfloat_to_vfp_compare(CPUARMState *env, FloatRelation cmp)
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
2.34.1


