Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BB01C3ABAC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 05:46:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBRv2-00027F-1V; Sun, 04 May 2025 01:29:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRuu-00022Q-8h
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:32 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRus-0004J9-K6
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:31 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-22c33ac23edso38002255ad.0
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 22:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746336569; x=1746941369; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8+98FJCPUkZxLytRMJNRmc7jhTB2VJSy0tbuhiYCP08=;
 b=JRXjs6qyoFZyCZK5RWRnRra+eQ7T/xXBHsg4+FsV/Dwt52NYoF6vOZpu2WBk+mUjzv
 NwlMUjb9ZsCyn39c3H5drBJbL5gMMH9H5LGyvDDvNdVceOzjKgdx1M4BnGPrej0esR+W
 90QZztaIdISRHltmhgDruh0j+zUrCr5hlS6B1BF8BpOEUrSqUQc0c5fD+zWU208C9yWD
 L8IqdbI4e1YghObhNY0V0RuTJvxAK9Cj9EL8EvdjxPUwHh0BXDnBahoTiRQTWHansdBG
 eZgnRSeE8TgEr31nx433cB1uqHdDzqvw182TQ+KPpsY0tmHMkMPe1BfbRDB8oGd4mBzH
 QdfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746336569; x=1746941369;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8+98FJCPUkZxLytRMJNRmc7jhTB2VJSy0tbuhiYCP08=;
 b=sElluGpjUHLfHSaHXZifFgyp6g5+1+szps4vqS6csEHwrB1G2l5Biu16LkwKI31NTv
 GesTBMArlr9zeAsDRWhLfjHNDLnsWk+lSHoRDI/zRXi8bCZjpX/CiIWuqkLljwRqSIsu
 mpyVK2QMB+thdPEUWYCfuMxyeqhwAJ9RujBEn5YiurC7kfT0YX/sLaEe5a8G3Kij6Vk8
 za5TGTHFMWx8rnmQNLBMvM5MIKpiBgIyJPm88tIWBNAqsBIKsd3fGX8nSXqe7Pcxi34x
 /PHZBuZnIA1lbhdsM0VgjR5y/CiWyVr3NUcWGLR+uBrG8tz5N61embmcdu5CzHEQrSrk
 N+Eg==
X-Gm-Message-State: AOJu0YzRdkKW91LhrPU3n9HWW754gKhfqGYKF/hCFHJZQ1RQUNz74WwK
 9nn+0oULC79DN01qJozS/yf8g3Mn4rQEknlHHkPR218WPH83iycvg7yddLWalQyAzZx+CB5IrMp
 RiOQ=
X-Gm-Gg: ASbGncvOGqPyDvwuI4AF1uQamEm+fdyrDdZfJR3jQtu72brGrDSTbIUbXSsu+0cuF2n
 cd2o3NtGThKRwnkzeC7DZXuXAP4BPJHDhCPMvuSBE/sOSdRex4T176Y0OkjXpy8c3oIbGDz/0Tc
 R0EVkY0tU+FLjOeJ3OTWotvNtODKUNCcPJkW3tP+EhENB+Us/OdhFokX5rWhyKWb2WKGumU6ngZ
 GLKLhhZk2mm2jkEzMwLAfQDTrsGm+KuazOLPC4z5GKwdVKOaT4gbPynMSy8+otyedgL/yx9hf3h
 CscZccXi7b4w7sxn8X+OvHRvenmu1Lxxdg8RIIWz
X-Google-Smtp-Source: AGHT+IFljFPpmm9aEq/53ursjQGrDhfCp3IjU9vvxW7IWwdA3NjR6LQgS9h1HaQFPxGtz1FrTWBD5g==
X-Received: by 2002:a17:902:ce05:b0:224:1005:7280 with SMTP id
 d9443c01a7336-22e1ea67d6amr53346185ad.38.1746336569135; 
 Sat, 03 May 2025 22:29:29 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740590207e3sm4400511b3a.94.2025.05.03.22.29.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 May 2025 22:29:28 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, anjo@rev.ng,
 kvm@vger.kernel.org, richard.henderson@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 10/40] target/arm/cpu: remove TARGET_AARCH64 around
 aarch64_cpu_dump_state common
Date: Sat,  3 May 2025 22:28:44 -0700
Message-ID: <20250504052914.3525365-11-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
References: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

Call is guarded by is_a64(env), so it's safe to expose without needing
to assert anything.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/cpu.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 37b11e8866f..00ae2778058 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1183,8 +1183,6 @@ static void arm_disas_set_info(CPUState *cpu, disassemble_info *info)
 #endif
 }
 
-#ifdef TARGET_AARCH64
-
 static void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
     ARMCPU *cpu = ARM_CPU(cs);
@@ -1342,15 +1340,6 @@ static void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     }
 }
 
-#else
-
-static inline void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
-{
-    g_assert_not_reached();
-}
-
-#endif
-
 static void arm_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
     ARMCPU *cpu = ARM_CPU(cs);
-- 
2.47.2


