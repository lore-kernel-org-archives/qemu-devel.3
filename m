Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61C5DCAC5B9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 13:26:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v28LW-0008BL-9u; Fri, 26 Sep 2025 09:18:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v28LQ-00087h-27
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 09:18:40 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v28Kw-000437-18
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 09:18:38 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-46cf7bbfda8so11868725e9.2
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 06:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758892674; x=1759497474; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CoI6XSX4wJl5SW+3P8A8AhUt3YnoxIhpzdTpS8zDmoo=;
 b=UqC1xK0xVkKhyTcCmj9AEiOSrGZKx8P35MFnAx2YoMaAzaAcinbmIUSCcqd9b7Z1sg
 ir94kuOkdESRsOmTmobMjLI9qK7m32Ue4f5a2E65FBPl4Tm8rYKDBGwSc1z1IAI6h8dX
 6NS8ILzxWhtFrv0KZv6Jjh9phNCdd69frTA9Vm1iD+dRxcEvEjDhVhR34Wr2Hx909Fuu
 s/1HACXlosQjWjV+n8eWVEhzosRiEVt82HdxQVu0+mN/rbkgOG6v4XceIkosH7qj68Zy
 mj2ajxx7Z/P6+Eb6grwrywLIQAs/BVvgNW+ufi+hPEoji4GEr2m5uHMSlVkU3PsdEcbk
 7Mhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758892674; x=1759497474;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CoI6XSX4wJl5SW+3P8A8AhUt3YnoxIhpzdTpS8zDmoo=;
 b=tMH4OVQCdoWLmUTLPn7WSooiiliSn+ZtPOGe9IDeqph+wmaGmssv2UihhBckqLfIWi
 uQsDtfvE090Uz8uAt3aYqQy1uXx5OfHoVp4FgYFiYkNEN8IUJwyaLAIrC7n424lnYGpG
 CWyibqA6dvhHN/Gc9kafQ9sVqhRPIE2mRGHC3FrSZGJS+qqrBDpSteIEH0aWSjhRRHmK
 eX728JWApeVny1S2K8988m8X5HQ0t7/Pr1cDPOYdCXvkwrFemzkwE+FjL+xe6hnfbUQm
 dVAZbeUvvh0vpQAgT9bZ6zQk9xkcq/wKkd8f6veGq23ghB5z1IRx1DlP+gdHWen1EMSf
 4XZg==
X-Gm-Message-State: AOJu0YyHz75X0cg3FgGWod/P9f9tDX54s0tQZIidARhxO2MWg+ATfmz6
 8NQz7E93NR7dIXlv0ZJ7vwSXy+jpb0V6nZ7OnlInEdeaizNXC1tUdAmXu0hlK/g6HbQ=
X-Gm-Gg: ASbGncuiqAIrev7vUXOdTuL4gVI6e2ef+nBsxZTxY3pYKTgnq3W8SpX9EKZnvrWWwnd
 CDsfgDkbQBYD4J78AEJrJwdxbue6qnXFVJx80XEo6Wv+Fge8tN4lmp+8QJt1+95b2oirPeXkryp
 hDORHCpeIqgei92Wkg41MfU6vvuqWhzRKT/DaDMWGWk2egEO8DhhZTCvAz7Z6eHw8m+XYNx8Zl7
 cV02Z+6bS+r+LUkCALEq8HT8DZS0uTEwNtOTX+E+SvphVx82OLoVmvrhUfQFDM3BjDNIucP/54x
 MWvkIH8bwfL15UW2Vq4XYsAhmKo3JLm1voteLelEMBnD5M5N6umJplUc/IXTtN9dGLPRWiXtaBu
 qi3AvW9baftW3WmfJYeHfWIs+TzsxEJrbuw==
X-Google-Smtp-Source: AGHT+IF2tsE8C2j/Wkx4xevHOulu52oXeCpOX1K+U9LFkJikKwt/mlcTISonkAJJCXlnDj0Nav/uRw==
X-Received: by 2002:a05:600c:3f12:b0:46e:41e6:28c7 with SMTP id
 5b1f17b1804b1-46e41e6293fmr18245475e9.8.1758892673943; 
 Fri, 26 Sep 2025 06:17:53 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e33baa53dsm73737465e9.6.2025.09.26.06.17.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 06:17:50 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AE71B5F8EF;
 Fri, 26 Sep 2025 14:17:45 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 10/24] semihosting/arm-compat-semi: eradicate
 sizeof(target_ulong)
Date: Fri, 26 Sep 2025 14:17:29 +0100
Message-ID: <20250926131744.432185-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250926131744.432185-1-alex.bennee@linaro.org>
References: <20250926131744.432185-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

No semantic change.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20250822150058.18692-9-pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250922093711.2768983-12-alex.bennee@linaro.org>

diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
index 604a69e3646..6725dcf4ba7 100644
--- a/semihosting/arm-compat-semi.c
+++ b/semihosting/arm-compat-semi.c
@@ -786,7 +786,7 @@ void do_common_semihosting(CPUState *cs)
 
     case TARGET_SYS_ELAPSED:
         elapsed = get_clock() - clock_start;
-        if (sizeof(target_ulong) == 8) {
+        if (is_64bit_semihosting(env)) {
             if (SET_ARG(0, elapsed)) {
                 goto do_fault;
             }
-- 
2.47.3


