Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E66EAC7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 13:17:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSF6g-00050K-Ob; Thu, 19 Jun 2025 09:15:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSF6P-0004Xy-6B
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:14:51 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSF6M-00044e-Da
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:14:48 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-45348bff79fso9543035e9.2
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 06:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750338882; x=1750943682; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4TTsVWGK24wAjdPt8HIDq+esVA7ZY3jqwbKqWeNJBVE=;
 b=ag2NNtCdPHKpDlA0ZzHtuoJzQUUMom3xc66a5RiWx6riH38JOEceyalaMdCvKvJhfn
 qHsAvvA7LCIMvkZbTRCwhzFqVHEXRJRBl9HXSYaxyu41v/KghTYdDr23jsbhq1y6RzD5
 zfJR6+7iUW2sdsp1A7ENUn74gdpG/m0V5MATwLCXr/BNt6sSBIOSJVybvJLLb/Yq7uQ/
 nIV6R68qH8itK4qwIbme9Q2g9xPgtRlUF+FDP02pI84dv//5Uzjn+SYlQ8LAyC8Qsj1U
 p9MjICD9a113f69HyDQ+tHWgv7D+fDvVX4uixSHO25NVYMFdHge0PzlSJ1iR7l3W/AT5
 lzJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750338882; x=1750943682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4TTsVWGK24wAjdPt8HIDq+esVA7ZY3jqwbKqWeNJBVE=;
 b=Z30dURnKyxAJ2LdfMRYh0qxYLLn7zdYxJuKtps2/dkGwbaEsO7ytp3fdWAa5V99fop
 rNYOVthKshlVbO4xiuqZVUjgVywQ+gLkFzPLf+w2ekPtMVFYb/Qy8uE8ufYd4heYTj3b
 fB5/anG5XZYDD5ynatBnRVZZbSbLD69Up6IGjrGQMcsRctmvQWqAxPNIBKq0muo57TBm
 vOHAxEvc5vevRPUgisk161tOvke/N0pu24c6i0VXeZxYyZGMkqMsSjCIDQiujiFEpSXH
 iskpeA/XLrhWk02srRFNJyH57Mb1jtuzV2HI/yacPC1+M49spHbmUuO4DCyoKuS6qV92
 7LPQ==
X-Gm-Message-State: AOJu0YyH3FCiq3QBJ7cUpqWntBfTJj/i2GQj413CcR46GhzsMP1fYcbF
 pwGm5Io7WrU/zxIz+KbsTvwxt9hJNb79gX9DoYj/rYf069GsUhIX1r/fKN+5G4pvvXufoHBT7l9
 rVQLRikc=
X-Gm-Gg: ASbGncubCbuVzs/Hj06bZSGi0T4AnbZLY4QMbpHmk0GKo3Xw7fBRrzSzSVXoXq78dR2
 NwdYepx710eFdhmX5xT+xsxuGqU8R61L5v/WQx79PoW1XhpepWiohwH20S5UXBYx0KBO0WBY359
 UCkaNr+hnXKfLhVc8KmWTVSn9CRq+Flp9Wr621VQh87iFfU3DD5tyuKeCqDIQIszALZ7bZPRhvl
 9fxJVLgv9xjxhB+aXs8f6/kSA0kf+4WaVmJeqrPlCjEZotfoapN+AAEN3NgbQfJmASebZZWZP/2
 d2Asehl7Gcj5Ef5nmAQfEtkt6aQrkhAHBsbUTQASNg94uAmQ+hyO5T+lQT1ZCngO0sKN4XbjNCB
 beW0mJFg4mGRcABVzbTMKxYcTNWX57aOOBkAStYI0bzgM0Uk=
X-Google-Smtp-Source: AGHT+IE0UJ/OKRN13EAAVAiGqkOfuQ3hywjomt6DtP+BfeCmZE/SGHvtR8ilW3FX7DRO6yFsM24vUQ==
X-Received: by 2002:a05:600c:1c28:b0:43c:ec97:75db with SMTP id
 5b1f17b1804b1-4533caa35c3mr199299745e9.11.1750338882244; 
 Thu, 19 Jun 2025 06:14:42 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535ef6edbesm26382285e9.20.2025.06.19.06.14.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Jun 2025 06:14:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>
Subject: [PATCH 15/20] target/arm/hvf: Really set Generic Timer counter
 frequency
Date: Thu, 19 Jun 2025 15:13:14 +0200
Message-ID: <20250619131319.47301-16-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250619131319.47301-1-philmd@linaro.org>
References: <20250619131319.47301-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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
---
 target/arm/hvf/hvf.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 632751d1eab..fce02d22ef9 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1008,12 +1008,16 @@ int hvf_arch_init_vcpu(CPUState *cpu)
     CPUARMState *env = &arm_cpu->env;
     uint32_t sregs_match_len = ARRAY_SIZE(hvf_sreg_match);
     uint32_t sregs_cnt = 0;
+    uint64_t freq_hz = 0;
     uint64_t pfr;
     hv_return_t ret;
     int i;
 
     env->aarch64 = true;
-    asm volatile("mrs %0, cntfrq_el0" : "=r"(arm_cpu->gt_cntfrq_hz));
+
+    /* system count frequency sanity check */
+    asm volatile("mrs %0, cntfrq_el0" : "=r"(freq_hz));
+    assert(arm_cpu->gt_cntfrq_hz == freq_hz);
 
     /* Allocate enough space for our sysreg sync */
     arm_cpu->cpreg_indexes = g_renew(uint64_t, arm_cpu->cpreg_indexes,
@@ -1080,6 +1084,10 @@ int hvf_arch_init_vcpu(CPUState *cpu)
 
 bool hvf_arch_cpu_realize(CPUState *cs, Error **errp)
 {
+    ARMCPU *cpu = ARM_CPU(cs);
+
+    asm volatile("mrs %0, cntfrq_el0" : "=r"(cpu->gt_cntfrq_hz));
+
     return true;
 }
 
-- 
2.49.0


