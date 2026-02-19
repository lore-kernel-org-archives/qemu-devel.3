Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDC3BE9A05A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 19:22:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt9ZS-00080Z-DN; Thu, 19 Feb 2026 14:20:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9ZQ-0007zU-FV
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:20:16 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9ZO-0007b5-AR
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:20:16 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4806f3fc50bso14837935e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 11:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771528812; x=1772133612; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ilvv/g4hVZUnKmansFQSWA+ymiFuxChSuZXIwbk1Apw=;
 b=mFNUbOZ8d8gKh3R2t1hUAGVwrDIEYE/YnZjbXWjNTYhjRAUo0pZlkOtdxqZljURwo4
 NuZBSWCxUUiBmO45ETcUxWeBr8BxUNvSMzFuZH63DeqGxRpRFDi5fllgxr2Mi5fGDioh
 3uhiN75eGoE0AxDBAnNzZmsT6zsv28xlG82eFzEFQaxTgEPFQnxQy25mRD0jobmRt6OJ
 8k9WO5j4GNJAF/e1GnHKAxcUCNcg3uqSfQs/MMOf72Ndv8vrw7CISe4h38ENFsL8EeJX
 9+tyPSaDoTT7fTawlOfIkU1Gjdd02z4WfolZbrjT5C5l3TZxSkyVc/rqULAPocRSXNcn
 TpXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771528812; x=1772133612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ilvv/g4hVZUnKmansFQSWA+ymiFuxChSuZXIwbk1Apw=;
 b=Lo7f7yvDtLYq2ioGOPONwY9LLLB4cgddtvmYql10sRRA3gfPbrwnixtfsSiSYt941f
 UMAfDwXSRqVz8bYMoes1QjSzhLfFdx5Ouw/koZwxBVPzNJOfX9zB/qm1zNJ5GhZWJGZB
 Id/3/JQX03zFeEUQPcPtnlTB5K41v/jlRB9VI7BwBkKfTthHwmda8OkbmssuJEPlFvtq
 ttS6wWaaiJMukF43M0LBWibMZupHMy/DESw9y03w92BrNKCgJJ3lWnM43KV49aSd0KRN
 i3yAfPxVaWnWsdWSLPSoPadPGJYkBWRkdNU8IA52CYxr9TlPUuKt6+zLskpg+FPz2/Vb
 q2xA==
X-Gm-Message-State: AOJu0YwfuBo34en2Ro12wUlQUneyyCOe5NXUrO7va28r+ZaVBfLBSZQr
 Wikr2VEQghHfOh0B8oWwEgpR+AgSDE65JegZ1yCG1Oa1/1r4UfZ9bBn0lIm2Ktt8MJwRisN8Tjj
 smefXF+e3Ag==
X-Gm-Gg: AZuq6aI/0Qucs/gp44gjhPoZLrIKGgyTzxfSIJO0FnsggYDwN9Jol4EySVmTPGY9Mva
 jDnZMCu9VdrrFk35uBzmRdwo7j9BJMQ4y4J0WL5eaJjAQoobVJ/7oRFRUCR5W6SzJElxsQ42VRN
 Ztyn647hit3+N/LgaA9tY6nkU/JsYGrKYF+At7SXjf94AQGxFtOewkoZMnHPjavkBOYKqRzTaxb
 4hnhXxqyOd2C2vWYESP25IBQwlUQNa3e5+jxatO5zpt0obAsCIa/12gpF53VBQDmfDF8UyZq2Am
 t0Rce6vhuoicH+LM8LFLuM1+4as3/xKPFsLaVJaU0PnrWguWu3bgLOxHP6sy7fjqD2P5HDSOzh4
 G/VVWQmvinaNg/+HOrbqXfOGY/UFZHwWGWdhRZYunFZQchWYGPTqY5P2RM/FwcWu+mEfjUTgoBA
 BXCJc2x5piHH6ejTU1GDRjn4jj5cfR157m8QIm0QUkuDcygzEGVikXj7g0vw0D7MyYYkAKdVq2
X-Received: by 2002:a05:600c:6098:b0:477:b734:8c53 with SMTP id
 5b1f17b1804b1-48379ba08a6mr305866375e9.12.1771528812409; 
 Thu, 19 Feb 2026 11:20:12 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a3d98fdcsm5270145e9.3.2026.02.19.11.20.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Feb 2026 11:20:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH v2 02/50] target/ppc: Remove PPC_DEBUG_SPR left-over comment
Date: Thu, 19 Feb 2026 20:19:04 +0100
Message-ID: <20260219191955.83815-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260219191955.83815-1-philmd@linaro.org>
References: <20260219191955.83815-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

The PPC_DEBUG_SPR definition was fully removed in commit
61135639821 ("target/ppc: Clean up _spr_register et al").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/cpu_init.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index c36fd118a99..c809c1f4d89 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -52,7 +52,6 @@
 #endif
 
 #include "cpu_init.h"
-/* #define PPC_DEBUG_SPR */
 /* #define USE_APPLE_GDB */
 
 static const Property powerpc_cpu_properties[] = {
-- 
2.52.0


