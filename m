Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64EFCC83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 11:20:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHdR-0004re-Gd; Thu, 03 Jul 2025 06:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHcI-00046v-9a
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:56:38 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHcG-00017K-FC
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:56:34 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a4fb9c2436so4581383f8f.1
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 03:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751540189; x=1752144989; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZLkTPhlZ6ATb7AAc3VGQov8gsRhAPF8MN9ZoezL4e2s=;
 b=eFVuVq7Kp1xZYqz/gHgDTr0J6fEzZjAIPBxTkRnHA7l8nB0CFmnMfbP24o2RuBuk0O
 pQxOBAQ5fql2e2O8fDAMYxhHTCo21eHT1fISMKrdGNF8vb4XXLFPMjKfx8tSyiNo3ezL
 jjHjKQ7r0fYYgCRgk3FC8cOpGBdrX6sxnSiBvBohiVJcMnQfIZj3FOT76kkCZbVPefrF
 ukP0DPEHtOkiTwhpJUWctqtXIaIVeo1KusqWL3BWOmDabdUrbP360hiM6gbbhLzWVMlt
 Suqvk2Xr5aNj5MLrYlzKIT+BGFKd2NbDsEqlrIcmVMLFTfmqGY5AoeDQGDMR9uPEf1Vn
 9EKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751540189; x=1752144989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZLkTPhlZ6ATb7AAc3VGQov8gsRhAPF8MN9ZoezL4e2s=;
 b=K7namGYWXPI2frmZGEKPa5NBzf5A6080Tw2VGfVBmvvXGPMpMAm6dTNrk7EPociq5z
 1nprZ288IRUJXbCb/dJWETrr5qfV2EfK9gH+k/c0zCHny2smW37r/jOEKRaeyb3XxCws
 8mYpboWBMIXShCeuSdxv3+ikHD7EY5wRlnp24xJCxjOIiH+qXn+gQWe2lSEhZgoLv6mu
 LXLMOfPo+e3S/Gw37Q+3DYD7Xm8Dovee4KER6dRA446Dsc8Z8wrOwkdaN/G8uUWI93Zm
 byq0tS+QjZ9eKp/pM92cEP+oAJuyDg0MvodqKTFTKwsRIBCLrPucIkFbe9q2zJP32/Ea
 8CTA==
X-Gm-Message-State: AOJu0Yw/cAfjJ8lTHDsuAVTqNSGanfAl+UmKvtFlQIuFC42k0S326oiz
 /i/JnHF/cTh0Zlpe6CB3YMNCkQXtPSZsQK2O7Uc8lc7NIiACMgUS9Gqjq8K494GoXMRl3AzFYlA
 PxloOp08=
X-Gm-Gg: ASbGncvsaTaWs+eUN7dNHgLaCeuSar4RvhvyIIEzvLIWvkX/W0muwbcRxoxLY7WUUL0
 fAr3TsGS84klkzLj8m0QvpAFnSk8TanrPhPoEg0xoYhYBRP+QDjryuMzZSQhNTM/4TUzvjYM32i
 1743UtI5vXgCr2F9vPVnoE2pFnTaEKhUO7D5HXP0At15fayaWshK+9u4drspiuMYm8jfv//doJp
 IkVrP2udm7WLo54GwHwbsHbcZap3YCdSHoM3H5TyCSaNfH80dI3ONpJ5zNxl0+WTVHRnew2NfZk
 uRpmFyYU8GjQhvSG9AbNeWz+bFJRE5LyqcJXbO/DODL3QNwTZRmEURmcIAqbv4mycdhgP3eLVXH
 UN45byixOySw=
X-Google-Smtp-Source: AGHT+IHuKoRl7IVxhklc+/5kCHwCdvXpAUKF7ZaqVxNvXsyGIXTaK/fKEVO6nr2FvIxQ868pijTYfg==
X-Received: by 2002:a05:6000:26c4:b0:3a4:c909:ce16 with SMTP id
 ffacd0b85a97d-3b32fb30d66mr2261011f8f.49.1751540189377; 
 Thu, 03 Jul 2025 03:56:29 -0700 (PDT)
Received: from localhost.localdomain ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9be5bbfsm23032435e9.34.2025.07.03.03.56.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 03:56:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 09/69] accel/kvm: Reduce kvm_create_vcpu() declaration scope
Date: Thu,  3 Jul 2025 12:54:35 +0200
Message-ID: <20250703105540.67664-10-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703105540.67664-1-philmd@linaro.org>
References: <20250703105540.67664-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

kvm_create_vcpu() is only used within the same file unit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/system/kvm.h | 8 --------
 accel/kvm/kvm-all.c  | 8 +++++++-
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/include/system/kvm.h b/include/system/kvm.h
index 7cc60d26f24..e943df2c09d 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -316,14 +316,6 @@ int kvm_create_device(KVMState *s, uint64_t type, bool test);
  */
 bool kvm_device_supported(int vmfd, uint64_t type);
 
-/**
- * kvm_create_vcpu - Gets a parked KVM vCPU or creates a KVM vCPU
- * @cpu: QOM CPUState object for which KVM vCPU has to be fetched/created.
- *
- * @returns: 0 when success, errno (<0) when failed.
- */
-int kvm_create_vcpu(CPUState *cpu);
-
 /**
  * kvm_park_vcpu - Park QEMU KVM vCPU context
  * @cpu: QOM CPUState object for which QEMU KVM vCPU context has to be parked.
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index d095d1b98f8..17235f26464 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -453,7 +453,13 @@ static void kvm_reset_parked_vcpus(KVMState *s)
     }
 }
 
-int kvm_create_vcpu(CPUState *cpu)
+/**
+ * kvm_create_vcpu - Gets a parked KVM vCPU or creates a KVM vCPU
+ * @cpu: QOM CPUState object for which KVM vCPU has to be fetched/created.
+ *
+ * @returns: 0 when success, errno (<0) when failed.
+ */
+static int kvm_create_vcpu(CPUState *cpu)
 {
     unsigned long vcpu_id = kvm_arch_vcpu_id(cpu);
     KVMState *s = kvm_state;
-- 
2.49.0


