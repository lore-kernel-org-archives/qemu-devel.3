Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B82C25B78
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 09:42:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7B8F-0006B7-AB; Wed, 15 May 2024 05:41:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B7y-0005hD-5E
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:40:50 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B7v-0001br-HL
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:40:49 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-420104e5336so24071995e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 02:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715766046; x=1716370846; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uUppVIcVxulNFKmt5JKoE50UNp9B197FkQ2pGAAJJ2A=;
 b=fR4FSPp2f+ol/8e7kkuPN+H1dBW5u6acizNnvHV8U8usHHX1RuboGu0uW2ND+djVhC
 WZN83JR8mhAIAoKLgBcAD85D2zx3uFlt8BnBETE+QZI/BIlqWxaZMP56Vi5IEkP6kxkN
 aBrPVDmhe9pCfPk+DD31R+4qJsUR48nspycCQkQcBSnmh53y2f4q6AIPQ9br8uR89faO
 Z99jXQx5WtB2HFAqnWlj6GTlGlyk0qydLQob/W2eedEjjKtlHJ7Xmi7trBX3Slk5XbRp
 uJWRjiB4JLsfiOR3zvAlvI6ktk/sVlHbNbmwNeDrxiuZ7aGoK3NcEdIjaf4KBfVaUnJf
 0h+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715766046; x=1716370846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uUppVIcVxulNFKmt5JKoE50UNp9B197FkQ2pGAAJJ2A=;
 b=wlBADTiWTyYgBRIAQyAT9w7W6O6G1CqE8aU/nEn0GpQgL/IDo69Ohli+YGJ2xzcRrK
 HGYRVXIMWEf1O1X6wIfUF/TTASWEp7guHBTwjrSSzkZOR/yn/HwdH2iep5jhFwVgSoz3
 8W31IAL6yG2X2d52sUDSSnaq6+Px/gNG+j96lP+MJCPYZT65uIWeEO9Dw+P7U9iizG+5
 9A8heV18mOBbkTPklH43m2uOfPByU9vkAndjnErpGfh6iztS/7VRBtWAb6En+8H2pDxR
 KKsOvLFMsKpRHGiyXBtaqVVA5Yj4lc+KU2Z7AUt3qQbwnij+cMu0siJvlc/WRWj4XdkY
 R2jQ==
X-Gm-Message-State: AOJu0Yxn6fdM6k8k6mF0NDScyQTuovY8ei7v0a0gU4IVQavq/4yVGdby
 TB1XN0ZPblxxiE0iRK43QvW4TKjDFm/VWVc97DfjLXRR4TWZEOZegfizkAPePJn1UtSAPoot0BG
 cAUg=
X-Google-Smtp-Source: AGHT+IFdLBhTozCeoe3kKdg/a1c9BKDfXkjCf+5AZwo8jsArxFYGiNyQYhBWz2up75Q1sqRNuw5qJw==
X-Received: by 2002:a05:600c:458f:b0:418:3d59:c13a with SMTP id
 5b1f17b1804b1-41fbcb4fe53mr166209065e9.9.1715766046001; 
 Wed, 15 May 2024 02:40:46 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbbefdsm15897058f8f.94.2024.05.15.02.40.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 02:40:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 02/43] target/hppa: Use hppa_form_gva_psw in hppa_cpu_get_pc
Date: Wed, 15 May 2024 11:40:02 +0200
Message-Id: <20240515094043.82850-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515094043.82850-1-richard.henderson@linaro.org>
References: <20240515094043.82850-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x332.google.com
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

This function is for log_pc(), which needs to produce a
similar result to cpu_get_tb_cpu_state().

Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 582036b31e..be8c558014 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -38,9 +38,10 @@ static void hppa_cpu_set_pc(CPUState *cs, vaddr value)
 
 static vaddr hppa_cpu_get_pc(CPUState *cs)
 {
-    HPPACPU *cpu = HPPA_CPU(cs);
+    CPUHPPAState *env = cpu_env(cs);
 
-    return cpu->env.iaoq_f;
+    return hppa_form_gva_psw(env->psw, (env->psw & PSW_C ? env->iasq_f : 0),
+                             env->iaoq_f & -4);
 }
 
 void cpu_get_tb_cpu_state(CPUHPPAState *env, vaddr *pc,
@@ -61,8 +62,7 @@ void cpu_get_tb_cpu_state(CPUHPPAState *env, vaddr *pc,
     flags |= env->psw & (PSW_W | PSW_C | PSW_D | PSW_P);
     flags |= (env->iaoq_f & 3) << TB_FLAG_PRIV_SHIFT;
 
-    *pc = hppa_form_gva_psw(env->psw, (env->psw & PSW_C ? env->iasq_f : 0),
-                            env->iaoq_f & -4);
+    *pc = hppa_cpu_get_pc(env_cpu(env));
     *cs_base = env->iasq_f;
 
     /* Insert a difference between IAOQ_B and IAOQ_F within the otherwise zero
-- 
2.34.1


