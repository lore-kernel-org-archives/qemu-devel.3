Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A8DC83038
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 19:12:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX2fS-0004SR-0x; Wed, 02 Jul 2025 14:58:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2fO-0004Kv-D9
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:58:46 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2fG-0002vW-FV
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:58:45 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a6cd1a6fecso7746910f8f.3
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 11:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751482712; x=1752087512; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yvjGPIKQGEYeURH3HTUPhcPT6ROyPPS2REI2o53ZBAU=;
 b=ZxMXpKP0yR3q2l4ShVLW1YxcTX9CgRGwW6SrWAV1kdpwBU/2PiAoE/Rumq+huk3GSS
 DGQwpmjlEnwVeYnbLedvfiqzF6ZRZZ6CGwd18dRfxog0IXJs4QuqYc1LKUAk4C9U1Y7p
 bZN+F4dEze+ZjNv+FmjCn/IqnEDXCW3uSH8jx2EMp4yLl7EYt5eXtKz9mwPVEokcwQMz
 HJznvBJ9+SnrwSme2V0E+ovBndVZjkzp56WH2RTVNDn0515vg6FregLJ4H8YhYctw0qY
 HGRUDlpNXngBbH0K+AxMrOv6DTmNQIBWTiyH54bmAGN+wgs7Hk5eZXbLtasHTJ1rbWN7
 4Sew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751482712; x=1752087512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yvjGPIKQGEYeURH3HTUPhcPT6ROyPPS2REI2o53ZBAU=;
 b=LzrbpukolN7jQiWjWrsXuHQLGRiSP1RkLRgKaMSkcNnxhDjk2Udwdt7ARsrWSFiwNU
 jYGeyLYOMFUlBHQcCE3NzMDmfZwFm2Y1npSBxhEM7rkHt31ZNzxui5AJ48swbWJ30c9P
 uREjQQdkD9q9aOjwmUiiU0zh/qnyjfuzke2PdQhEstWwC2Hr0VXFYfbAIXm1SA4Yru9g
 pHVaF7O1CpTl4JXZQqFhAiBp4/RJpOnl47VCPiaseV1kJg22xiOwov3A3HBiZv6JETyk
 cMY99JEiMHnwKxYxoafew52GsHSELFn6R8R9QBql/PdqX65aYZqkDwUJPx/Oc4fmsCwN
 K7Lg==
X-Gm-Message-State: AOJu0YwGq8TIU/6FY101HUFbZaj+UHsE1DctSIi4XBCyjf31GmyOi8ff
 LO7PakXAGZoovaOsCsypEXxJqls0ZNNW3W23FU8kODgkEwmd/7Jetso+nkR2vTJoihhg+LyKyu+
 Z1AO1
X-Gm-Gg: ASbGncveI8vxQMhAg3nGXaFW5dsEoVj6tUdL2afxFEaaybVlXSV06NfRdYPAxls0LFC
 aHVAjM8NIeyOVZF2MBqMLwaqOy9LZXbo8ZjZyj3JxK13CGMlWi8CaQsaBgYkpAk3TKHtrEHh4LC
 5KNgZGA+SKtSiLUr1ytH/8ubuvI5bZZi43+NHsFJtxOdzdAKMj53KN+GIrXKow/ldnUv4arVI58
 TA3Hc6zaygG2aGLBb4Tp7fFpZ+UMYEVorQCNbvX1cRreraH2nb5YBcrtk3pyIXC6g73AzrsQSJl
 O4lSsGWzyeLuMjEr+vHSLw0b+zwCcwUoo92mV2CqFua2cife1D+XBdJb/b7bxiUaCKi1HxUQobU
 OPO6wXKYWwP1vp9MW1gkSgsjDImO2eElXD0Vx
X-Google-Smtp-Source: AGHT+IGG458iaMF8parhu+ZtJM0uYGLcHE60aD06QLyVrMn+s8nW5mOaOw+xBXUsgGvUYQ8BVh5iUQ==
X-Received: by 2002:a05:6000:4183:b0:3a5:3062:793a with SMTP id
 ffacd0b85a97d-3b2001ac8b4mr2800516f8f.33.1751482712242; 
 Wed, 02 Jul 2025 11:58:32 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e5f8a0sm16960908f8f.96.2025.07.02.11.58.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Jul 2025 11:58:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 41/65] accel/system: Introduce hwaccel_enabled() helper
Date: Wed,  2 Jul 2025 20:53:03 +0200
Message-ID: <20250702185332.43650-42-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702185332.43650-1-philmd@linaro.org>
References: <20250702185332.43650-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

hwaccel_enabled() return whether any hardware accelerator
is available.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/system/hw_accel.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/system/hw_accel.h b/include/system/hw_accel.h
index fa9228d5d2d..49556b026e0 100644
--- a/include/system/hw_accel.h
+++ b/include/system/hw_accel.h
@@ -39,4 +39,17 @@ void cpu_synchronize_pre_loadvm(CPUState *cpu);
 void cpu_synchronize_post_reset(CPUState *cpu);
 void cpu_synchronize_post_init(CPUState *cpu);
 
+/**
+ * hwaccel_enabled:
+ *
+ * Returns: %true if a hardware accelerator is enabled, %false otherwise.
+ */
+static inline bool hwaccel_enabled(void)
+{
+    return hvf_enabled()
+        || kvm_enabled()
+        || nvmm_enabled()
+        || whpx_enabled();
+}
+
 #endif /* QEMU_HW_ACCEL_H */
-- 
2.49.0


