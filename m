Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 585BAC369D1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:48:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JR7-0001Mf-KE; Tue, 22 Apr 2025 15:37:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JP8-0005Yn-6y
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:41 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JP6-00077W-7I
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:37 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-227a8cdd241so63289685ad.3
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350535; x=1745955335; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wn5IylCoa18B2xlwy66MANPbffZJqmOZqBLwmhwTcyY=;
 b=h6757D7X885MH8VcBXNVplANaMO8lzw060Pv1VvT+Ni+fKcE/eqOVx5be7u8YMXnJf
 WzDB3UtsCP/EiamG4c4ZSH53qEwmo8N554whDl1nriksqqWisY0JAwfvnckr9zO5HewU
 iggTsG/MLw+mpivaYV4Y1hhWWui+ztf90pKt6XKDgo/f2q1KUHT8BrCAA1vQD5mG1oEC
 oVTCdAj8g+YwnPtuj56H6F8mx+E5xAY9WJVo0SRILB6xFrws220mcC7XjJF6ulg1gpF9
 CFMX5l0p7q542b6M/7Xse1FUvYnq8BNwuDpyjQTqIqqI8ARk4kmRiSms9Og3fIR3n0+K
 A44A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350535; x=1745955335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wn5IylCoa18B2xlwy66MANPbffZJqmOZqBLwmhwTcyY=;
 b=Rz5toigIX7yHeKbnYUUDCJ4eWcvSBOqq1U3dC57EZM58q+d2chl491HL/D7gYeSQw1
 Pe0m916eQ6ilxHkdMq9surOgmsvFsX50+uqRoNbTMKIYGO+nUPVR9gurDZFMLsZvT5uE
 eMJprrfYe2u5+rDgLxehdvQhPhjeoFi/ZDWCqftPgAbA5SD3VHPQ6hDRHpxzBDGOb0Lj
 ed3p/ZLTKzxEVRF4QSGpYALah/cdTCZm3Lp0i30peR7PVP/d6XmNlYqhuTzTM3aF0P9u
 3aFc1RzGaccGDRxNHOPUmsiPL1jEXBFb0FST2V/QG1pbd5rGki3iyw8EmoSpDtMmZVwC
 XQBQ==
X-Gm-Message-State: AOJu0YxPJnXIlxrL4Jkly4TKTjhUmPd48NYBciJR0a/oHBi5RAQWGyty
 2+boxR3KqBWlGt1Jo5kqaPXGdbbM1wPT0XhOCA2W8+FYH13hAi45M6r7Fxpedym+H0TSPiZSIV+
 t
X-Gm-Gg: ASbGncv/CXSI7SE0cjXWWaCQRogL+5ktrviJaOh05NByO5EVxqDRDzwzqW4gUtIZbmh
 Hs4OiotsBxzDJVqynuEvyoksfu+tn92cv2y9o89Xvf1Cx3WM3Cdo65ErVKv+NPO5Kf/JoYLdU63
 3v+Z7QBB6ojGR22DDEheGUQ0Mi5dOjMRUiyzbxOb5yGcPGpqhdogvB0JHGKUW3G7iKPJJXV7yHu
 gPAiRGgMRbEz4qd9rW5l4/lBhSuUNy2MKVAGA2bjIkqCii8VbyiyPXQuwPSzrZ002GcNuSQ6qrS
 Ka7e1x2nJ+K0CTo+bIXhoC7NfDew4yrpwIdOT4P77bHCIz69w9qW6YRKFBJ/U98tBJn/H7dVc5E
 =
X-Google-Smtp-Source: AGHT+IFlBvkMt1G7216ASJCFO7WVr8eAppm2foPba+MYEAYV0lobGWmWxXkSwtrj8oopdfKOEPwWEw==
X-Received: by 2002:a17:902:f54c:b0:223:6180:1bea with SMTP id
 d9443c01a7336-22c53618770mr225353415ad.37.1745350534701; 
 Tue, 22 Apr 2025 12:35:34 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50fdf1f1sm88996795ad.237.2025.04.22.12.35.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:35:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 113/147] accel/kvm: move KVM_HAVE_MCE_INJECTION define to
 kvm-all.c
Date: Tue, 22 Apr 2025 12:27:42 -0700
Message-ID: <20250422192819.302784-114-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

This define is used only in accel/kvm/kvm-all.c, so we push directly the
definition there. Add more visibility to kvm_arch_on_sigbus_vcpu() to
allow removing this define from any header.

The architectures defining KVM_HAVE_MCE_INJECTION are i386, x86_64 and
aarch64.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250325045915.994760-18-pierrick.bouvier@linaro.org>
---
 include/system/kvm.h | 2 --
 target/arm/cpu.h     | 4 ----
 target/i386/cpu.h    | 2 --
 accel/kvm/kvm-all.c  | 5 +++++
 4 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/include/system/kvm.h b/include/system/kvm.h
index 21da3b8b05..18811cad6f 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -390,9 +390,7 @@ bool kvm_vcpu_id_is_valid(int vcpu_id);
 /* Returns VCPU ID to be used on KVM_CREATE_VCPU ioctl() */
 unsigned long kvm_arch_vcpu_id(CPUState *cpu);
 
-#ifdef KVM_HAVE_MCE_INJECTION
 void kvm_arch_on_sigbus_vcpu(CPUState *cpu, int code, void *addr);
-#endif
 
 void kvm_arch_init_irq_routing(KVMState *s);
 
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index ea9956395c..a8a1a8faf6 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -33,10 +33,6 @@
 #include "target/arm/multiprocessing.h"
 #include "target/arm/gtimer.h"
 
-#ifdef TARGET_AARCH64
-#define KVM_HAVE_MCE_INJECTION 1
-#endif
-
 #define EXCP_UDEF            1   /* undefined instruction */
 #define EXCP_SWI             2   /* software interrupt */
 #define EXCP_PREFETCH_ABORT  3
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index b5d68c796b..35c16302bd 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -35,8 +35,6 @@
 
 #define XEN_NR_VIRQS 24
 
-#define KVM_HAVE_MCE_INJECTION 1
-
 /* support for self modifying code even if the modified instruction is
    close to the modifying instruction */
 #define TARGET_HAS_PRECISE_SMC
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 0723a3933b..7c5d1a98bc 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -57,6 +57,11 @@
 #include <sys/eventfd.h>
 #endif
 
+#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__)
+# define KVM_HAVE_MCE_INJECTION 1
+#endif
+
+
 /* KVM uses PAGE_SIZE in its definition of KVM_COALESCED_MMIO_MAX. We
  * need to use the real host PAGE_SIZE, as that's what KVM will use.
  */
-- 
2.43.0


