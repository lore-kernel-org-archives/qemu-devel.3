Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68744C3ABAC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 05:33:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBRvJ-0002Pn-JH; Sun, 04 May 2025 01:29:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRv5-00029w-VX
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:44 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRv2-0004NJ-TR
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:43 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7403f3ece96so4545497b3a.0
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 22:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746336579; x=1746941379; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zr91VyD7KzMDPFf4g5hvijagOJ2GOeFDSpZ2RGMEaGY=;
 b=s7TGmfhtx8pPycu/NLoJ2vwPJ9gjfESw9PX3dqqMjgc2xYRpmG6LRG5/S1rpxYCMzP
 sqFGJhgq3w39142OnebnjVtIIiX6u9MBzMWMQjtzcIe/vFWNNSDxstxcMN3nHSy/jm0y
 B6H8MnqoIzDXqk6FEuKLu+MyeSfoGHQJzovQBMNGgrNWPixlyWFCuN2PFe+ufCFB4396
 BsnwP3KuFBP0l4F68F0xa0U//YmjPdtmmxQA3xmXsneSqWKiAEuCaVniUYV5QHi845FP
 pMqclDm+yjB75yZOr/YpKdCQ+3ZODLBs3WIgc8JfknGJWcoEPmQj3i1UjBrPc9OCTbmC
 DC5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746336579; x=1746941379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zr91VyD7KzMDPFf4g5hvijagOJ2GOeFDSpZ2RGMEaGY=;
 b=tPv5PPH/a+MR+rWP3UxxGy2+FPkjj2S0SAwsHRIIc8v+kUx2Y0jozjhWAQdiRkP7Zx
 RLvuXPSi3w+1Fq7m0WrFzAYzAlMdjjvU2xd8LWTqC2v2ETnblQIiVwxz501paTh7MEdn
 XjXkZsOTUAfvmPWidukizRI0LopygLAAxJb7rEztZpBORm5pU4I/H4C+EZURVrTdLK2U
 dg6yv8R34BhIYTWkIrAL1MLnWzleBxicBqao+0N9VeLQEMxH++/tdagd25kE81F8Nq8h
 xilB8yw9ilKo1/Kqn/ewmIeNUTSge1KZBRK0A+EaJNupZuE1BVQwKRJMC+dzM0tLOGPP
 Ri9w==
X-Gm-Message-State: AOJu0YyLwuN4QUbQqlNx7rvOqLdbCUsq3D1jH/wi+xlt0bYlHtveNHPB
 ygfrrtEKkPyCKH5/i2KNMH1bw6AIs+1wk3n9NCXXtFBAiCwpgIAKWCDfOhFAqd7HixX4yO+MFBS
 zpgk=
X-Gm-Gg: ASbGncv0VWZxbu8Otyv1Hs1QS/6ZG0jDywAwQ2EEVJoOvJhiPaLscR1n0eTxXddZvpj
 1Fhf7ZSUsvNIbbLl9Oimblar+G6DiUWLPN2KgKjuKTdPkDRhWM/SQmcm6sMKzNlgXzEqrtKWUQ7
 aFfsZtUYRhBv1HagIoXhhUbmVXlUGoip7U/sTDp/ALXcFXhz3Ekm3sn/uHnmVDQU7Cz/7do0B3x
 M5Zx6Mj/IGNl0+UQLQrfvXdN/SMKXnpSB9B5WMNGQBTpTWX9qub//pvl7ILlaLAxntR+2zGs06M
 +npaaYvvToAQx35PwOdEIcJmgRwW/Yj2a8x+6nKt
X-Google-Smtp-Source: AGHT+IFfySvOFkf5D+3E2z0KECvBrvExxDrnmyJ78lgoj5cX04fSE4cePI6QTcx4mVf5frJYla1Urw==
X-Received: by 2002:a05:6a00:1d0a:b0:736:46b4:bef2 with SMTP id
 d2e1a72fcca58-7406f09cfb1mr3647809b3a.6.1746336579517; 
 Sat, 03 May 2025 22:29:39 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740590207e3sm4400511b3a.94.2025.05.03.22.29.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 May 2025 22:29:39 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, anjo@rev.ng,
 kvm@vger.kernel.org, richard.henderson@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 22/40] target/arm/helper: replace target_ulong by vaddr
Date: Sat,  3 May 2025 22:28:56 -0700
Message-ID: <20250504052914.3525365-23-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
References: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 085c1656027..595d9334977 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10641,7 +10641,7 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
     unsigned int new_el = env->exception.target_el;
-    target_ulong addr = env->cp15.vbar_el[new_el];
+    vaddr addr = env->cp15.vbar_el[new_el];
     unsigned int new_mode = aarch64_pstate_mode(new_el, true);
     unsigned int old_mode;
     unsigned int cur_el = arm_current_el(env);
-- 
2.47.2


