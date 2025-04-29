Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE37C3ABA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 05:02:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9d5n-0008UA-8r; Tue, 29 Apr 2025 01:01:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9d4y-0007ZT-RA
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 01:00:27 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9d4w-0005zN-CY
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 01:00:24 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-223fd89d036so69119235ad.1
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 22:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745902821; x=1746507621; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2y4EwfHA2FmjYRfAFQnR46OcrZnAFzvzFB4cwR27V9E=;
 b=tu3nrhDG19IyRXkTgxJoaBuZ06NUmDjZkefReivDkYsjrI9iV9XccRsgG1owMA8Zx9
 39xO+d18/F/rIqLLetM/Yl2+aiQ5tqXAjVdLTrykC/HQXsFFm3tIb9f7smtX36nWdwdm
 IbYUNbL/PNEDxyk6thDGq50XaXH2Jxyh0y6prbdqEKnuotdWtWzIsd7On6WQUK/mzDVF
 i7PeEEmKB74KQpZ5qd/0CKLbQtH2CxSdtcW7lYP6scsNxbr3JpkaTRMrAUkIe+mcz32V
 41ilqjYPZ2zKi/pPiV4Ba7ztE5euHfSCSZvd2Husu45tRMcvXGceDKBFO4XiUXVuhi5R
 ZIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745902821; x=1746507621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2y4EwfHA2FmjYRfAFQnR46OcrZnAFzvzFB4cwR27V9E=;
 b=jEfuLjSi2UzAkTjEXXvLdaPss3cgV9lYokpyuQ7hYgihlqgSZjCx0pMqmyFdnDZmcV
 BPc4qWz07lqCMKgQGsBFkyBCuUCRQhGE4NWM0jhuclMt4jsW26bIj/BQx3QtSQJ0lnvF
 RvUog2TuEowyhVN/LOns1V0MCiwpys6x+onAdwpCnxdlPQmxmoHhhP9l1M4HZ8pfk5Mi
 izZSYTtizLufHUjtyZB5Nr7EvVIanB1+Hyc3JiJOrJ8p8Os8EGeIhSJ2Rx3FdZiQ/p+H
 77UZbXJB9ZzvkJGByKw6mJjOTLOcaSlpV3skxoIwYXrDYNe8fNQwP5a0vk9enx6zp/pu
 d7ww==
X-Gm-Message-State: AOJu0Yxvp1agOYN9hy/1zdCrmbuwXRkXIP9rv4yX+sBxxtr/fc+kGgd3
 4qVxDnxiSFrY/F0vqgXShzEz9M+/f6YK4MLyV61WUeVZLvPWO2G9AHguSa3dLyapMIpZWcNR2xw
 7
X-Gm-Gg: ASbGnctA+r7mxAluazn5ZkwXHAvIIQpCr0o52whsE5Z9LXAxwULvqgp0h7xLFy8ECIJ
 YB1p+9MdqXJu4VNyAyU1vYj1n/mwtEK9d66JwN/4/rFlvHX+dMz1OBOqtPrCp3Nf6ge3wpS830M
 Qi1qU0LhYOTPnPoaTcjwRBCQ911ieAYVr8y7jckI315jLz3pViOp32T5sNEYZ3zafbSg3n4gLcd
 /LccUAIKljxqtzcftaAqs1H0DxILcG/H4MkSVAF0t4SheJUPA3TqeWY6mRI5uaF5Lq8PW4dGTzL
 tXJRj+uw8ezfJkyboAOtSzlvVgTD/AhFv5FiiRxH
X-Google-Smtp-Source: AGHT+IEwNOFrIwMalkdJgnwDx51xMBl3mnoMGbe6Ccc+Gkl6QjJBvRKnrZDMFU0w1C5V9X0F1g8RmA==
X-Received: by 2002:a17:902:e841:b0:224:f12:3735 with SMTP id
 d9443c01a7336-22dc6a09655mr168001025ad.31.1745902820862; 
 Mon, 28 Apr 2025 22:00:20 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4dbd6f7sm93004015ad.76.2025.04.28.22.00.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 22:00:20 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, anjo@rev.ng, richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 05/13] target/arm/kvm_arm: copy definitions from kvm headers
Date: Mon, 28 Apr 2025 22:00:02 -0700
Message-ID: <20250429050010.971128-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250429050010.971128-1-pierrick.bouvier@linaro.org>
References: <20250429050010.971128-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

"linux/kvm.h" is not included for code compiled without
COMPILING_PER_TARGET, and headers are different depending architecture
(arm, arm64).
Thus we need to manually expose some definitions that will
be used by target/arm, ensuring they are the same for arm amd aarch64.

As well, we must but prudent to not redefine things if code is already
including linux/kvm.h, thus the #ifndef COMPILING_PER_TARGET guard.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/kvm_arm.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index c8ddf8beb2e..eedd081064c 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -16,6 +16,21 @@
 #define KVM_ARM_VGIC_V2   (1 << 0)
 #define KVM_ARM_VGIC_V3   (1 << 1)
 
+#ifndef COMPILING_PER_TARGET
+
+/* we copy those definitions from asm-arm and asm-aarch64, as they are the same
+ * for both architectures */
+#define KVM_ARM_IRQ_CPU_IRQ 0
+#define KVM_ARM_IRQ_CPU_FIQ 1
+#define KVM_ARM_IRQ_TYPE_CPU 0
+typedef unsigned int __u32;
+struct kvm_vcpu_init {
+    __u32 target;
+    __u32 features[7];
+};
+
+#endif /* COMPILING_PER_TARGET */
+
 /**
  * kvm_arm_register_device:
  * @mr: memory region for this device
-- 
2.47.2


