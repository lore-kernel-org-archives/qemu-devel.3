Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7961DC3601A
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 00:01:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0UUh-0005n9-GJ; Thu, 03 Apr 2025 20:01:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UUO-0005Hf-VZ
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 20:00:55 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UUN-00033L-5o
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 20:00:52 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cf628cb14so18154475e9.1
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 17:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743724849; x=1744329649; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TP105EOAJeVHdN1BZY7s+jUHXieu6gJKrsZ9gC9TZqY=;
 b=Xe/iBpF7Jji64IrtJEhEpXiNTAj3VnbLJvXYFh3hhRwbF6odbzlOOV/18b8tPzJz0T
 tnTFqnZq8K9zMbbTNpSN+utPigB6dqC2HRQalS9fIRvN1P41wYOPy0vxdqMTlKDuR4Us
 WKv0pZ93A3scedeZMDYqUIViHSyXXKtBJBrEs6RbE7SCiMVSmseDQipaqinIeL/tH0Lj
 3gUjwksKULcbDHLqd6CKqE2yTXFz+/gtYOpO/zHvu4k/mBW0x2EULkYWxgC+2De4KTbs
 MOdp4CFnxCuWy78xCoiY5kpWD2P4UdgJqacYg819Hd6WD00d1q8xYRQfZGpKCPSqShLr
 rwOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743724849; x=1744329649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TP105EOAJeVHdN1BZY7s+jUHXieu6gJKrsZ9gC9TZqY=;
 b=fru/VDpFBc5g4pQbjYiNmYqt2IvcxQc/l+v6xRxbdfbX1RSmifQ5Wvp6CevwPELNJc
 obvK7hz/T34xyCyA9WOdxZKpoykUk00RmJtsK+PuqtwZC4yyuWcfALkJ3WXS2HChmfrP
 yUhZvCb/pq6+fFjABv25B8lNip+8Y/yu0VSeJX/LT6Xx7+VDNTzBCbTr1ozqdRumxihq
 CezyEfuSBH/IWqW19v20q9T2lB1BCwGlBIt8EUrYdKa/16stB7QRre5mMvY1XlE8v1Ke
 2j3S1VauHQ1Gf3x0zbrQTqBOIsoqQMyuzem2cN2nQ2uxK7TxSuNGxU8Ax4mXVdhpXB70
 NW4A==
X-Gm-Message-State: AOJu0Yw9lisl9swMMvFaAu1RMkmiA7BGGfjWW3Dfg1rnK72iiZR1GuKK
 +dA2ELz94sCgJe3QyFKKcJ/FQIJCQiDaM2errHZXIHQO23q9xdiFY7cM/bLfil6NSRvmjyoQw/P
 f
X-Gm-Gg: ASbGnctz5ObIZBZeCkWjUS2dxpqWuGMwIuWzRRn2jsVPQ4GcDzQ6sw9ajvX/EUw3uqP
 Krx6zvEO7/JvqWflTogrQJQ/jg3VuN3HDNuX2Lm4NvuDFDw/RJ6FUab8qDvRoTYJzgzli85QH3b
 yLgjFS4HyWwSg9kiW8VaUqjRCIkEgrFC/lJc9+7qlEUGvpTmrWBkW/L99RlVfJQz2gw0sIpgg8z
 rATaebpnMqvg16ReYKsSqdMFD/5JxwpDyDBeni/byTJX0B/EW0OHmUpsW5mNYY6zdiG/PUcs4RN
 pe2kFC90FZhvXSzCG24iM7Eh6mkrwVsWjKfnfkhAgzuWMxxlWueA22NUIXX2wZRl1ibA/nxlp+M
 kSeZY1q73at6Yx/UxBts=
X-Google-Smtp-Source: AGHT+IH3dHRiC6deYZ2yxOUlEwDOJ+CG1G5m1SWXjXDMG26gT+K7OlPKw0PKaBz+jNHNVvP4hb7yKw==
X-Received: by 2002:a05:6000:4027:b0:39c:140c:308 with SMTP id
 ffacd0b85a97d-39c2e5f50b6mr4084817f8f.3.1743724849120; 
 Thu, 03 Apr 2025 17:00:49 -0700 (PDT)
Received: from localhost.localdomain (184.170.88.92.rev.sfr.net.
 [92.88.170.184]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec3428298sm31329365e9.8.2025.04.03.17.00.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 17:00:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [RFC PATCH-for-10.1 22/39] target/arm: Add arm_cpu_has_feature()
 helper
Date: Fri,  4 Apr 2025 01:58:04 +0200
Message-ID: <20250403235821.9909-23-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403235821.9909-1-philmd@linaro.org>
References: <20250403235821.9909-1-philmd@linaro.org>
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

arm_cpu_has_feature() is equivalent of arm_feature(), however
while the latter uses CPUARMState so is target-specific, the
former doesn't and can be called by target-agnostic code in hw/.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/cpu_has_feature.h | 2 ++
 target/arm/cpu.c             | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/target/arm/cpu_has_feature.h b/target/arm/cpu_has_feature.h
index 2adfccd9208..352f9d75bed 100644
--- a/target/arm/cpu_has_feature.h
+++ b/target/arm/cpu_has_feature.h
@@ -62,4 +62,6 @@ typedef enum arm_features {
     ARM_FEATURE_BACKCOMPAT_CNTFRQ, /* 62.5MHz timer default */
 } ArmCpuFeature;
 
+bool arm_cpu_has_feature(ARMCPU *cpu, ArmCpuFeature feature);
+
 #endif
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 6f62745d7f6..66a58916fcc 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -55,6 +55,13 @@
 #include "target/arm/gtimer.h"
 #include "target/arm/multiprocessing.h"
 
+bool arm_cpu_has_feature(ARMCPU *cpu, ArmCpuFeature feature)
+{
+    CPUARMState *env = &cpu->env;
+
+    return arm_feature(env, feature);
+}
+
 static void arm_cpu_set_pc(CPUState *cs, vaddr value)
 {
     ARMCPU *cpu = ARM_CPU(cs);
-- 
2.47.1


