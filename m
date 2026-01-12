Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54BB1C9EC67
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 10:33:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfFE5-0007Ag-Vu; Mon, 12 Jan 2026 05:32:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfFE3-0006zN-Tr
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 05:32:43 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfFE2-0001xB-8a
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 05:32:43 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4779aa4f928so63850735e9.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 02:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768213960; x=1768818760; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O0DOizNYs3UPa9+lJDtLfBdhlsyXMboB2ENpO7Py5Ag=;
 b=jX39qEahLZvE4Oml5RskVSjhsVRP/SNaPrFgHOJQC31KoM7yNWRjFD0B3BMz8B0vcY
 m9q5RjBPa+QyLuEeW9eeeSFj5bmKTuG04QPaC0VCGBBJcDwHS84IX0GqvXw7T7I2ouIo
 GC8mOpoKijZSTWyKC3HSIaVLZ0dZDMoqH0eMXlTE5bEge5ryjGt5+pbTzDxTeC8COfIo
 g5NwWBFolWeXXXY8t/t32e9Q4jTYb1ljQDjzv31cE/zijka7ohfTLvjs6YejebggX/2l
 iE6Bfc6cyt73PiZ6zIr2EMfyuN8z30o+BXsKkYaaVU+MEk9MkKWF9iwnU9No1COIyKR9
 wV/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768213960; x=1768818760;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=O0DOizNYs3UPa9+lJDtLfBdhlsyXMboB2ENpO7Py5Ag=;
 b=dCYyLazi9kZk6sJRZFqrnWntztvFqR5tWg0MgwG0K6clkcJH7NeCaGse/8Zz0QfOT4
 MDZ1X/EEi1jOKVji5OY/gw2TG3Fc8DkPRDrhlU20u3ABonHFxRewCROUkFd2OkDZR6kc
 iw+wpV4uzappVLLqrFo//Anz5UxvT0pdXnkPxsg7fwv6FMB/Q+xXwiWBp6gli7C2xaM4
 Ii9PX9/0Dsg1K6zrrRtQ6MNasZLkrQZvGnHMHAyOUI31zqAZv9vnVpUxEOhi6jyOwBdZ
 dHuNlcVeUBVgIb5TVVn+7uhQb0KLBabs/Jzu//e2fXHtzYedLhGRsGRLrYbCP5Jx86SI
 BdAA==
X-Gm-Message-State: AOJu0YyoLLfBFa+mikxDnAiS30IzNFPcCeVxD1GVZ4LcfkQIuGSOJIDj
 7TltNO/8ji4hw+heriouMtJsBZIFWNlaZvtcJIp+yOqS2lhlb8SxIzRxOfhc2aOJWmUi5Kcshzh
 rzeIwJio=
X-Gm-Gg: AY/fxX58fSbqYLtpdvQm6dVYzqpiOUHtebKDjv2ZQCSZTTLwegzQHQoRcX+sQI+S4SL
 SyiUyWpm7/xRxS0JINyws8984ZvqF9TfvZICl9+uPCEBS853fv7Cz82FDS4/inmATkGeQ5KAOnR
 fmx2W0dJ3vPXO8ju0hbjOWe3DSkhvJg8JQ3z0jw4otWru6BJvmT02/ABxNbbKks+Hd7ec1pmH+v
 CYl5bJh5NhB1z3xJ1zatBXe/hgFV/07LziB81zbqUa6RPhkVKNytQOP/0C7n8MXjCgGsaYdCXxZ
 6r14HyOLuH9+icZP1r2/UU8n3AoZApSP7yF94ydmSCcJ6IeGeFa5D6Io7sMQj0b7Xsc5gMX0pnd
 cvefZynMVmrQKPg1KfRHjq3oPxOBr30HeehLxLO0NZYID1ONdiLrKUPqoWDQrzZ1PSqqkHPLVbr
 ojLPdAk1u0EwKDzUPxjjHwbzsGOdbEwO4NzEK+QvRkUEMDstsFT8jl+odrHetA
X-Google-Smtp-Source: AGHT+IGbiSyJ0w/Aqv3K13j9oAQ3PQ8IlZI+mIeWFoPwtrGwy09HAZAVqSNQ7z1HxKEziolaSfhfyA==
X-Received: by 2002:a05:600c:4f53:b0:477:7991:5d1e with SMTP id
 5b1f17b1804b1-47d84b3860fmr168540275e9.25.1768213960429; 
 Mon, 12 Jan 2026 02:32:40 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d865e3dfasm125106095e9.2.2026.01.12.02.32.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 02:32:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Joelle van Dyne <j@getutm.app>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Nguyen Dinh Phi <phind.uet@gmail.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Collingbourne <pcc@google.com>, qemu-arm@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 18/19] target/arm/hvf: Really set Generic Timer counter
 frequency
Date: Mon, 12 Jan 2026 11:30:32 +0100
Message-ID: <20260112103034.65310-19-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112103034.65310-1-philmd@linaro.org>
References: <20260112103034.65310-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Setting ARMCPU::gt_cntfrq_hz in hvf_arch_init_vcpu() is
not correct because the timers have already be initialized
with the default frequency.

Set it earlier in the AccelOpsClass::cpu_target_realize()
handler instead, and assert the value is correct when
reaching hvf_arch_init_vcpu().

Fixes: a1477da3dde ("hvf: Add Apple Silicon support")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 target/arm/hvf/hvf.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index bf8bed1495d..e4c0d936f1f 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -897,6 +897,13 @@ cleanup:
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
@@ -908,7 +915,9 @@ int hvf_arch_init_vcpu(CPUState *cpu)
     int i;
 
     env->aarch64 = true;
-    asm volatile("mrs %0, cntfrq_el0" : "=r"(arm_cpu->gt_cntfrq_hz));
+
+    /* system count frequency sanity check */
+    assert(arm_cpu->gt_cntfrq_hz == get_cntfrq_el0());
 
     /* Allocate enough space for our sysreg sync */
     arm_cpu->cpreg_indexes = g_renew(uint64_t, arm_cpu->cpreg_indexes,
@@ -974,6 +983,15 @@ int hvf_arch_init_vcpu(CPUState *cpu)
 
 bool hvf_arch_cpu_realize(CPUState *cs, Error **errp)
 {
+    ARMCPU *cpu = ARM_CPU(cs);
+
+    /*
+     * We must set the counter frequency HVF will be using
+     * early, before arm_cpu_realizefn initializes the timers
+     * with it.
+     */
+    cpu->gt_cntfrq_hz = get_cntfrq_el0();
+
     return true;
 }
 
-- 
2.52.0


