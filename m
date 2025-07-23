Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFCCFC83F1A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 13:58:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueZxq-0004pJ-O2; Wed, 23 Jul 2025 09:56:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ueZtP-00030V-45
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 09:52:23 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ueZtN-0002to-6k
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 09:52:22 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3a528243636so4057915f8f.3
 for <qemu-devel@nongnu.org>; Wed, 23 Jul 2025 06:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753278739; x=1753883539; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+HZCiXqJ6zZg/VWStToH24eJmWXqFdiiJ1PQISWWaS0=;
 b=f4ZzV5dg1vtfb9264gnO7OcbEY9NbXksEpi+eTqoOt7TEVV+4jCMQzZ/PLOWBsLyuJ
 bDWQkEbjUFKagvWay9lvnV6iIO3A3eu9ir1PCVGiBaonM7kjjWHY0TLKYqyACHAfk8/m
 N/M4UeSMJLTCjf015QFFrhTuYQulXGutw7xD+ZiRPZJB9a0/VBQl3k7iYwHPMV7O9vqO
 51AIHwZxYUlEbh7fbcyp6qP7Ghnfz/ENtI184G0SPOEf9lg6Zy4vyXRcpCkHxAdu0Ffy
 mBP6BLbY38FBPGS5ZPkZAtsVCOz5KE/HXGq5GpU1bZyo3yaUOeE51V1nH/W29iuhiEo+
 UDEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753278739; x=1753883539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+HZCiXqJ6zZg/VWStToH24eJmWXqFdiiJ1PQISWWaS0=;
 b=eHWY6UNbSfHwz8i3TJk4gZYcXY97IMruoXDyniK4ilGtQs8niOr5cph94fVpNGsjLZ
 hdXOgbeMwIAQ9/ueetFqnzccbIQwVwEkjWiQoqE6Hlbk74MM4dAIzrHuqUSKr28kor81
 ueNBLtJLmORBvK8H0m5AcwUkNsdXlggVwpc44ooosqsFoUTiWxEl8VBeC8O/DcgCId2L
 uEa7iagWp4QDQu8HMEtMbyeJ10XmL/FEHqBWgYsEK2ASoRuQGBGrr4nYUXL3IWqC6YcX
 BPHyqupxgeoVUgId0Ahmyyt+t23F6lh2TZ1VmFXrodLu+4UeFTh45K68mJNHAGZBkV5/
 Z3nw==
X-Gm-Message-State: AOJu0YxQCG3mSBYtVXw8k57W1Qf76iRcMBgZj/0DCNA7+x429PjebATp
 gYy+WqDDndMXaeym/gbfWMtOdCfnK5QSVP1Ky/E4nh8FAVhadhRlTIoCskGkdVYtbIsFxg058CA
 wd5io
X-Gm-Gg: ASbGnctyNh7hjeU04ky8cuLctPL7IsF688/kZe2VKURndSJK4WdNBJrPEc2q1eHwfpp
 qfbatVWkyo7Olu6BBmO8dYWZ4usN6KTZu7BinAe0D14HNFnrgvP0bE31u3nBXrTC5CU/oDzNUub
 LYAjeUa80Q8Z5Q+G42lq/9A75FnCsnp+PumQAzmgQ0WOz59M25wDjwFuCCEiq95cxcCtNHytjBq
 v/iH3QuL0Rypw2I13sy26O/bF/y95BEJsuIm3RdmgYOxT+QLyAUlE6QCHsqD8hUiA4QuWVuUycu
 YlYcY//txAk9kXg4ShGbH6HMTmNhw95udeok0nee8djYSG8BCC7aZQiqUfYg5N4pbFFurUX5EzA
 9HvSEPVdD8L8A/VdcpFzmTLm3oN+Z05a7A4wrVwVz3DsnTXBf0MWZ6oC0fBNiP3AVnVyXZuWP
X-Google-Smtp-Source: AGHT+IHDwvvKSwdTtXPkM65Zb4e5VGlOb0fOueXxV3lHOJmaYtgt5pDH+n2dlWWjSnAG8Oh/0ZWrUA==
X-Received: by 2002:a5d:5f89:0:b0:3a4:e841:b236 with SMTP id
 ffacd0b85a97d-3b768f1ab75mr2724398f8f.33.1753278738629; 
 Wed, 23 Jul 2025 06:52:18 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca48719sm16582343f8f.47.2025.07.23.06.52.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 23 Jul 2025 06:52:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 v4 4/4] target/arm/hvf: Really set Generic Timer
 counter frequency
Date: Wed, 23 Jul 2025 15:51:56 +0200
Message-ID: <20250723135156.85426-5-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250723135156.85426-1-philmd@linaro.org>
References: <20250723135156.85426-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Setting ARMCPU::gt_cntfrq_hz in hvf_arch_init_vcpu() is
not correct because the timers have already be initialized
with the default frequency.

Set it earlier in the AccelOpsClass::cpu_target_realize()
handler instead, and assert the value is correct when
reaching hvf_arch_init_vcpu().

Fixes: a1477da3dde ("hvf: Add Apple Silicon support")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/hvf/hvf.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 7de770da4f3..ea9e6b1c0c6 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1007,6 +1007,13 @@ cleanup:
     return ret;
 }
 
+static uint64_t get_cntfrq_el0(void)
+{
+    uint64_t freq_hz = 0;
+    asm volatile("mrs %0, cntfrq_el0" : "=r"(freq_hz));
+    return freq_hz;
+}
+
 int hvf_arch_init_vcpu(CPUState *cpu)
 {
     ARMCPU *arm_cpu = ARM_CPU(cpu);
@@ -1018,7 +1025,9 @@ int hvf_arch_init_vcpu(CPUState *cpu)
     int i;
 
     env->aarch64 = true;
-    asm volatile("mrs %0, cntfrq_el0" : "=r"(arm_cpu->gt_cntfrq_hz));
+
+    /* system count frequency sanity check */
+    assert(arm_cpu->gt_cntfrq_hz == get_cntfrq_el0());
 
     /* Allocate enough space for our sysreg sync */
     arm_cpu->cpreg_indexes = g_renew(uint64_t, arm_cpu->cpreg_indexes,
@@ -1083,6 +1092,10 @@ int hvf_arch_init_vcpu(CPUState *cpu)
 
 bool hvf_arch_cpu_realize(CPUState *cs, Error **errp)
 {
+    ARMCPU *cpu = ARM_CPU(cs);
+
+    cpu->gt_cntfrq_hz = get_cntfrq_el0();
+
     return true;
 }
 
-- 
2.49.0


