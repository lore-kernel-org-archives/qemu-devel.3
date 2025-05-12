Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FEB1C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 18:08:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEXYZ-0005Hh-0A; Mon, 12 May 2025 14:07:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXWu-0002Uo-E7
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:40 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXWr-00004t-Pv
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:31 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-22fa47f295aso31234195ad.0
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 11:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747073127; x=1747677927; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fgtSyivanfJoltGbQqPmVVFicsFn6el5hIn8rUX6RjU=;
 b=iAFOlYFfUEL6B7I/K7OwvRlYdYnIUF17UN8DpcKVtDP6xJOFH7R1grLgif0MvsQ5nL
 FHuP4QzFtzuJBjrAcJy25IyRzeynzAsHeAr93U+1x8Dnqi8CvPkvrOMPn1U3q6wu5Lj1
 1GnCoq2kEBhpKo5xE+agKlJxHTYbauSE38nd7ZJ/Pcu2Ogw2noZKRdkmPnwks0ym71L/
 lZowHRiFzA6kuhM5EdEMU/C29FRv6TtAa0p2qDMT8BMb0AbdepTAk/jfNUI4/UQfAI/x
 jTeNguraQjKD2Q52dc/o92CUPhC1AxoUGpc6VLloeH54KSFgwoia3gefb3uEV91Awqfo
 W4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747073127; x=1747677927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fgtSyivanfJoltGbQqPmVVFicsFn6el5hIn8rUX6RjU=;
 b=YrV7Wss4w+/B4jNME/zpiD43o0weCG+CbotpG20f2CYiCUPrU6wuqetB8WZCcYPEEn
 AXy6YJJcAClF0xzTi6cBFK6gJkAi2mDKCqu44j4yWBz+NhRSaXyxSafKVGkXSMXmNgk7
 HAt8xpvIZTVwsh5B8b0HPBl5hMD7Stjv1pcs51lbRb0Pr+ZO9mNeqvqLkP2/oi8dhirH
 uZYYCiiR3VAYDkSmBdzOtom02Ngu3XFv8OgWYfdP/vyBJMXupy69BsFUHD7xLsJOWlZN
 7KCuTvIDWPSy4WxVBMRO63rRNQkaoZSzE1S47VdNiBkbIE1F74laJ6Q4J+WBQRKXaj+B
 gVCw==
X-Gm-Message-State: AOJu0Yy1ZhQw/z2x145YWviAO8FqlkwkJNYMi0gT9FsMplShUKP0bUdb
 mwNUn5q4GLtTD4DV/qrqJ3wJVmkpTYol2+5gXVV5opVI7SMjdjk3IwerTMKoM8DnJQJ1R2BI4a7
 G
X-Gm-Gg: ASbGncsAjiNn4MKG6nwphK/DWHjnAUzKUeTBYjhRFMM0KqxSBDwo4CSNz6j6bGV7Vmr
 J5VfC0/2z+gAZU3px9vjrKi0XnxH5JUglKdJB+spy37VkS22cGDxONcr4oBkS7HyYEQoJWu7pVz
 oexO/NIQRWpBwpOxCTq35KmGb9tI6uem/acCPl9S2wVLZMrcSEzpOExWfw0MSSinGoYpL3KYz0o
 B04E6n0FGgzgH1iIlw6P/rwu7pzyocGwlFCHC+egbwLPSnmh1l/4FN0AGFVGZ4QVQ3KtLnI2dgf
 fMLAoy6iB7wWEYpFnZdpbsreMcs8C+sxG4yJajxjREB/xolKlfk=
X-Google-Smtp-Source: AGHT+IFPFtd54s+F2aR6e/s2yggvKE9L9W2oRHkbhnFg6B45F2gxHU/Non/U4k/+HSNVb7YPTjYCXA==
X-Received: by 2002:a17:902:d581:b0:223:3b76:4e22 with SMTP id
 d9443c01a7336-22fc8b0b618mr179655835ad.6.1747073127211; 
 Mon, 12 May 2025 11:05:27 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc82a2e4fsm65792005ad.232.2025.05.12.11.05.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 11:05:26 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, alex.bennee@linaro.org, anjo@rev.ng,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v8 17/48] target/arm/debug_helper: remove target_ulong
Date: Mon, 12 May 2025 11:04:31 -0700
Message-ID: <20250512180502.2395029-18-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
References: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/debug_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
index cad0a5db707..69fb1d0d9ff 100644
--- a/target/arm/debug_helper.c
+++ b/target/arm/debug_helper.c
@@ -380,7 +380,7 @@ bool arm_debug_check_breakpoint(CPUState *cs)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
-    target_ulong pc;
+    vaddr pc;
     int n;
 
     /*
-- 
2.47.2


