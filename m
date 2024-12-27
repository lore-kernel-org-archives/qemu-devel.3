Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF2E9E7718F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Dec 2024 20:25:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRGt5-0004Fh-D0; Fri, 27 Dec 2024 15:24:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tRGt3-0004FM-En
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 15:24:45 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tRGt1-0004zw-Uw
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 15:24:45 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-385e3621518so3503927f8f.1
 for <qemu-devel@nongnu.org>; Fri, 27 Dec 2024 12:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735331082; x=1735935882; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xe+vcyPZJWzPRyHwRPCh0MVBHckAA2MYIwBQH2GfQr0=;
 b=bEsaKvVVe5X8+bFImiTQ5fJ176p49Mn8ZOjBz0MUb8IHhAStE+qse74pde9gJnBV8b
 qHpLxPImek/wzwJ2y7E0rONjpzgZUqUd3YjB5TySGskX8ishBHFXGaW9TAV5eK1om1IZ
 H0cjlEzh1cfttaKJ1aoNPuoB6kWiihr2t0Pky07UHhWjPbqjvg2HVZU7rZh5oJjQdgFG
 K/yOcjOe/HdzBtm5l945L9Tmo82YDRsvdkfPCGm+9dYGD85bpwCuxbU9esoaGMsplK8z
 vFWn3JnakBh1Lm0+kZ4GmKf/8Hm1XV00yzSTb6BlS+FSjcmLOKojDmyh8ZkCZMn2BYao
 UMgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735331082; x=1735935882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xe+vcyPZJWzPRyHwRPCh0MVBHckAA2MYIwBQH2GfQr0=;
 b=Zl78PdXK9RVexRFvNim0v8Oiw7DY9faikRKCp7kn59FP9iywLRoia7FsIl252BdBc8
 OOMtn22drIkaibSLrVhLh81zBGhZtM53Hft48NxN0EHOFGqrBIkc22sbxF5M3rnQW9D9
 dr4tWNQW3mYcPhoYTem/u0M5q6ShtgjTEdLe0x+ifBlsParTb1l8rB8F4vDgf97wwSh/
 Cv1/Q690UDq8xd08uceQMPuUVfgDUnYxASRG1wtx6Ycr6LZvA6b2m/CzUN0nj52m1j4O
 WA7GtPSwU4Z8pW5ydlTn22V50cUNYSWKyoAYPInWO4ZQu2NnbInSG4rH+k9eCJjrDhmg
 gH5g==
X-Gm-Message-State: AOJu0YwMCV0il5Kllk40BEY9fNeeN2aWITTLBMEUfb2TpVbi75206WVt
 a4xPLPhWgoDcey4rGEAqLlhMmZ5NCF+y5AfmDv2Gi02W1BOHlnPaFy1M96UuEAMtwkrE0jC8XZ8
 n
X-Gm-Gg: ASbGncvGzKueig+0LnhLw4I/xZxvsvqaNE6TNxzGRpHJMJlocYbZCyjOA6UgvRDryNy
 X1tb5tgbZvKPkz76dtgZAnt1ADZ2potf14h466gASqDALqGQoxBIDfcbXfTlL1p6FQAK+W/aWP4
 7IStevQI0G4L6Dkb0lvPr8CudEuWYqhy1ReqFD1LOOKvVkl0+wbP/8JFL+jgss8qSe3Cm85Z2Rm
 TLUAp1IgLHgo5tELSCzTD8SQ7Bv77rP5iPWyD9+kdAp2jenSChIxPw7Gs3i8OpEP4Xw/b4cPwAU
 ayt7VQmh05nM81QpPMZoCZz3pfd/fmU=
X-Google-Smtp-Source: AGHT+IF7VI5o5zK9VzVp9fsHGuwzMppUPfWWedn/AcwuIs7l5f5PQnnQVdLLESYuUFdNo9D4wsFP2g==
X-Received: by 2002:a5d:588b:0:b0:385:f573:1f78 with SMTP id
 ffacd0b85a97d-38a221f2042mr24720949f8f.24.1735331082158; 
 Fri, 27 Dec 2024 12:24:42 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8acadcsm22713871f8f.105.2024.12.27.12.24.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 27 Dec 2024 12:24:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/2] hw/intc: Remove TCG dependency on ARM_GICV3
Date: Fri, 27 Dec 2024 21:24:34 +0100
Message-ID: <20241227202435.48055-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241227202435.48055-1-philmd@linaro.org>
References: <20241227202435.48055-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

The TYPE_ARM_GICV3 model doesn't have any particular
dependency on TCG, remove it. Rename the Kconfig selector
ARM_GICV3_TCG -> ARM_GICV3.

Fixes: a8a5546798c ("hw/intc/arm_gicv3: Introduce CONFIG_ARM_GIC_TCG Kconfig selector")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/intc/Kconfig     | 6 +++---
 hw/intc/meson.build | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
index dd405bdb5d2..7547528f2c2 100644
--- a/hw/intc/Kconfig
+++ b/hw/intc/Kconfig
@@ -23,13 +23,13 @@ config APIC
 
 config ARM_GIC
     bool
-    select ARM_GICV3_TCG if TCG
+    select ARM_GICV3 if TCG
     select ARM_GIC_KVM if KVM
     select MSI_NONBROKEN
 
-config ARM_GICV3_TCG
+config ARM_GICV3
     bool
-    depends on ARM_GIC && TCG
+    depends on ARM_GIC
 
 config ARM_GIC_KVM
     bool
diff --git a/hw/intc/meson.build b/hw/intc/meson.build
index 510fdfb6886..602da304b02 100644
--- a/hw/intc/meson.build
+++ b/hw/intc/meson.build
@@ -6,7 +6,7 @@ system_ss.add(when: 'CONFIG_ARM_GIC', if_true: files(
   'arm_gicv3_common.c',
   'arm_gicv3_its_common.c',
 ))
-system_ss.add(when: 'CONFIG_ARM_GICV3_TCG', if_true: files(
+system_ss.add(when: 'CONFIG_ARM_GICV3', if_true: files(
   'arm_gicv3.c',
   'arm_gicv3_dist.c',
   'arm_gicv3_its.c',
@@ -39,7 +39,7 @@ endif
 
 specific_ss.add(when: 'CONFIG_APIC', if_true: files('apic.c', 'apic_common.c'))
 specific_ss.add(when: 'CONFIG_ARM_GIC', if_true: files('arm_gicv3_cpuif_common.c'))
-specific_ss.add(when: 'CONFIG_ARM_GICV3_TCG', if_true: files('arm_gicv3_cpuif.c'))
+specific_ss.add(when: 'CONFIG_ARM_GICV3', if_true: files('arm_gicv3_cpuif.c'))
 specific_ss.add(when: 'CONFIG_ARM_GIC_KVM', if_true: files('arm_gic_kvm.c'))
 specific_ss.add(when: ['CONFIG_ARM_GIC_KVM', 'TARGET_AARCH64'], if_true: files('arm_gicv3_kvm.c', 'arm_gicv3_its_kvm.c'))
 specific_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('armv7m_nvic.c'))
-- 
2.47.1


