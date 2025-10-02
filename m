Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96B5ECAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 10:19:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4GN4-0001TC-Q1; Thu, 02 Oct 2025 06:17:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v4GN1-0001ST-JD
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 06:17:08 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v4GMu-0003hk-Tn
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 06:17:07 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-46e37d10ed2so7338485e9.2
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 03:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759400212; x=1760005012; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Hn5hSkUALi0sJoe7dXUvj5XR+2qewvnu4SJoSHgRko=;
 b=A2N167GfFbh2q+CeoQeQcQUQtbZ5QxQm9GW6/zdJQL7+bCkt1gsdvaHq9zVAd/E5/G
 5VxHDwCxaZ99n1aIIQrm4RVoQA85WPNtjMo3CK2Qb3thKVXaRy0KIOlggZtgD5/A6I49
 cdGr+RTecQcM306bjmYCBTIcEop+Kdc9g5C6fmLuM679KCM+MMtj3mK2rdrt3yp9JZ4E
 lxyhkuHlxRlAJXrYDWRe+suvHenlqcm1bCbFGh2ajNKXkRKm+UctOjLenxXI0r+3iPOH
 8BkBUv8GMVvJ0Xgd/nPp4FEclLMmzw1o0kKNqJaiSsKrS0ANyp23mfuj5qtvzO4Kn7bO
 vGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759400212; x=1760005012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3Hn5hSkUALi0sJoe7dXUvj5XR+2qewvnu4SJoSHgRko=;
 b=Yp6haYKpe4Bx22TWAgYnuJGEYCtjHFJABXY1rGOA/InPCIJpJSvpiQqji3vSOZqdVr
 Stk2UoHpTHVvgCmUaG805kODOBeprlLBqr4BzakVVuP9ISnYx8A2IFPLF+uMN6/OSkXX
 F1eToEtEAeeK21dUmzdz+lKCCiy2E9OtVTDR0mMh080Zpn3upI8L2YRi5QdmHwk+xvch
 i+e9lS09lnoxuyBl8H7LRbv3Zu9HP3Jmrp4AGwXivGz2Q34TJTVJlI8bx5376iUs/FZd
 UUUYi2M4wYMJwcsHsarScqJnT1DgoKh8fcgg2/KqbVpqKVradqKA7PRXQOjKr7UvbKxA
 6N0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeOSaFyerwVbpJkoQN48fPIln3Jv4YkIDOly4q/AweOTRMEo429pIsxwlJfibBoiHh5xMcqvA+Eacd@nongnu.org
X-Gm-Message-State: AOJu0Yw0pRGIt+ko8cstzNctKVltEH+zzJcpKx8+kX0wa5RJKQtyvpsp
 DvpAGCaJM8QKqrLeeBYiR/zx4WmdieKQzgFOsmXWIICcSc89upsjTdP+fCRdXtFR9eM=
X-Gm-Gg: ASbGncsc0J/G3WMdxz4G3Wgd4239GjfW5CJ/1Jc7k8NomdBpPub9sQVuQ/Y/HJZszyc
 hdKfdlwQ2UJW3VOKhcVm3wYnnnhsyOQprb2h8AAatLAIud0W5GrJy7vuK44eDJxaaIQta9Xc3u1
 d9kCxnNovagmlk5jLwkjtBCqDoiJP3ndZtUHWAzZkqz8lCUY6LzfSY/T5EoHr4urCWudz5naZ2B
 scgxNjVmurRsxRatccl6aHUBBG98+0lobt22ez2Ez6lORka8w4ZcmzKaBaUEEWF6EhkZ4o5iuQv
 vOkQ+dqS50Ns7zhgL4Ix9UYT2OWK1d5RQodyHt5AXjxkdx/OQn6hnZYLeQGh/8rfmZalFGPCEjd
 Mdn065jSf7AwHlOs/8WWF6/oC/nwioooskqdXYw3Y16MLJyr/jlssHVYt
X-Google-Smtp-Source: AGHT+IE7CvafJOn1UiuzdazWvKzNa7CMqmD/xKHx3huz99J26auwZwmSioQEW3Ocrr3YfI0QhlBuYQ==
X-Received: by 2002:a05:6000:22c3:b0:3f7:b7ac:f3d2 with SMTP id
 ffacd0b85a97d-42557819b52mr4780246f8f.43.1759400211676; 
 Thu, 02 Oct 2025 03:16:51 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e9780sm2978809f8f.29.2025.10.02.03.16.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 03:16:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
Subject: [RFC PATCH 1/2] target/arm: Clear AArch64 ID regs from
 ARMISARegisters if AArch64 disabled
Date: Thu,  2 Oct 2025 11:16:47 +0100
Message-ID: <20251002101648.2455374-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251002101648.2455374-1-peter.maydell@linaro.org>
References: <20251002101648.2455374-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

If we create a normally-AArch64 CPU and configure it with
aarch64=off, this will by default leave all the AArch64 ID register
values in its ARMISARegisters struct untouched.  That in turn means
that tests of cpu_isar_feature(aa64_something, cpu) will return true.

Until now we have had a design policy that you shouldn't check an
aa64_ feature unless you know that the CPU has AArch64; but this is
quite fragile as it's easy to forget and only causes a problem in the
corner case where AArch64 was turned off.  In particular, when we
extend the ability to disable AArch64 from only KVM to also TCG there
are many more aa64 feature check points which we would otherwise have
to audit for whether they needed to be guarded with a check on
ARM_FEATURE_AARCH64.

Instead, make the CPU realize function zero out all the 64-bit ID
registers if the CPU doesn't have AArch64; this will make aa64_
feature tests generally return false.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h |  3 ++-
 target/arm/cpu.c | 25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 2b9585dc80a..b9f5d70ea35 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1056,7 +1056,8 @@ struct ArchCPU {
      * Note that if you add an ID register to the ARMISARegisters struct
      * you need to also update the 32-bit and 64-bit versions of the
      * kvm_arm_get_host_cpu_features() function to correctly populate the
-     * field by reading the value from the KVM vCPU.
+     * field by reading the value from the KVM vCPU. If it is an AArch64
+     * ID register then you also must update arm_clear_aarch64_idregs().
      */
     struct ARMISARegisters {
         uint32_t mvfr0;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 30e29fd3153..e0376b02119 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1592,6 +1592,27 @@ void arm_cpu_finalize_features(ARMCPU *cpu, Error **errp)
     }
 }
 
+static void arm_clear_aarch64_idregs(ARMCPU *cpu)
+{
+    /* Zero out all the AArch64 ID registers in ARMISARegisters */
+    SET_IDREG(&cpu->isar, ID_AA64ISAR0, 0);
+    SET_IDREG(&cpu->isar, ID_AA64ISAR1, 0);
+    SET_IDREG(&cpu->isar, ID_AA64ISAR2, 0);
+    SET_IDREG(&cpu->isar, ID_AA64PFR0, 0);
+    SET_IDREG(&cpu->isar, ID_AA64PFR1, 0);
+    SET_IDREG(&cpu->isar, ID_AA64PFR2, 0);
+    SET_IDREG(&cpu->isar, ID_AA64MMFR0, 0);
+    SET_IDREG(&cpu->isar, ID_AA64MMFR1, 0);
+    SET_IDREG(&cpu->isar, ID_AA64MMFR2, 0);
+    SET_IDREG(&cpu->isar, ID_AA64MMFR3, 0);
+    SET_IDREG(&cpu->isar, ID_AA64DFR0, 0);
+    SET_IDREG(&cpu->isar, ID_AA64DFR1, 0);
+    SET_IDREG(&cpu->isar, ID_AA64AFR0, 0);
+    SET_IDREG(&cpu->isar, ID_AA64AFR1, 0);
+    SET_IDREG(&cpu->isar, ID_AA64ZFR0, 0);
+    SET_IDREG(&cpu->isar, ID_AA64SMFR0, 0);
+}
+
 static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
@@ -1718,6 +1739,10 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (!arm_feature(env, ARM_FEATURE_AARCH64)) {
+        arm_clear_aarch64_idregs(cpu);
+    }
+
 #ifdef CONFIG_USER_ONLY
     /*
      * User mode relies on IC IVAU instructions to catch modification of
-- 
2.43.0


