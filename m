Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E3B1CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 06:17:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDd0w-0007b6-It; Tue, 28 Oct 2025 02:17:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDd0t-0007ZW-J2
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:16:59 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDd0r-0007Fm-ML
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:16:59 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4711810948aso40481245e9.2
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 23:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761632215; x=1762237015; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MxV/2r9+8lCPChHU0lOXZfa15B9thwum86CBvfFa9fY=;
 b=D2V+LU5DTRDASeyJkUafW2xc/NHDd4r9my4+31wTqP7NMuxNON8JZA/DYKFF4/ewVU
 wbj/TcdXTm4rhIr2j9V4Sj1NtvcJcpaE5LiqvKBbAt1ks17hcTVKwAh07X3dP67A4Gmw
 t330un/SZmN/q+q1f785PZ226pWGyfyXJMmYFd6ICVywqlAJQDfvKpD5sq/Aey9zVQ/n
 moo2oIDaOQ1GPRvtUSigDLC7BJIeGx6D0LSnX24EXglRXZvd1W/2A9WoXow4AVXYaSD5
 uq7dj0W1epgK5OucGZyeQ4oPTuExGiO5Tw71vm+x7Xe4UvP1MXd12uDvvbQ873wDjr1w
 n5yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761632215; x=1762237015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MxV/2r9+8lCPChHU0lOXZfa15B9thwum86CBvfFa9fY=;
 b=DTctAhKr/J0H8Yk8R1FrJwzIA+xNCEB9679dk006wzYltFUc9o0DbAlHv/xEoYhQvR
 LFwUG60Pt1SdNKsBPHS8YBXVf44mkzlEhJkbcWyelVZOLd6K8IjAFdj+4Y1UzF1C88hO
 3BV8vO3wGL/5xkc0/ZnZg8H2/xidL1EkeN9D5L0eJc5KKsQRuH7zVjmuo23PKwO4DRfk
 /Iiyz0mBQLuWiklFaSe2od0x4Jitu28tWfbdUS0lIHA2ugmiSOMMK0qGoVF2XwBZFRmr
 J/vFBufLdzBjM16W9K7uUTYBtBavIplKbpBReLd6lmWNQ1zHSS5Yc60XjLhXBk4BpTY5
 u5CQ==
X-Gm-Message-State: AOJu0Yz323/OsgeSAJmpT89dE0zGpRj83NFr0lONiIdNvuhB6TO944Dy
 Ppnd07jmN/Pb2iJx8iOYi5fjDcmfbbKJBhy/BeQ6pTLgpvBnoDwNcwecyVD0keKw/0Q1IXgpqN8
 EbNJLkn8=
X-Gm-Gg: ASbGncuFNerUKEE0jXQbTyPal7uUJZHyLOrnHtF/TFmFlK7tcMEZYMvzJN1az3U9iCN
 nj8cuNw0XX6cuSi2qCcudKyyKU5GxqfLnsyufygs08xUdQ9sgEuCxmut17NDaktMUQ6whSogHUQ
 4AXJZHy/rdEB/Aq8pcTOAlAhMiPHmmF0SOUjDlm9ZxdbxZm+NL/iWDVRNwvu5TyQhSguvHTQZgD
 1447NUZFJKY5U0c0CPpBk26ZxrzkRt5g2eqBO68xNHl9Bo9jgMHdq+Gf5YorgiKB1ENBr6eW/JU
 ptSISIDMDTehDXmZEXq9fQwFjSE7tEdlTW++6SMqoo05D/RVSZg1nV3athdeg/sbRDKprW/ZX4Q
 D1Mro5nWGkVKD/RC0p5intJnVwhMMdNZ0qb2c5vOYx/GCm1/CdzqUs8yO8APQCelPz/tpGJwtaZ
 9apEyg2hrsygZZ5IAlQ6xipXDOHEE1FYAfcCymfsP5Bh3+n9seVZXjpZg=
X-Google-Smtp-Source: AGHT+IF1T3+EqgBz79aC6U9v/dDOF9H/syKTBguPltH3qws8/5CkahRPoBI6+cdDzT6gyea0Nn4VRw==
X-Received: by 2002:a05:600c:3b23:b0:46e:376c:b1f0 with SMTP id
 5b1f17b1804b1-47717deeb98mr16406715e9.7.1761632215560; 
 Mon, 27 Oct 2025 23:16:55 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952df3c7sm18048239f8f.40.2025.10.27.23.16.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Oct 2025 23:16:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Collingbourne <pcc@google.com>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 48/59] target/arm/hvf: Really set Generic Timer counter
 frequency
Date: Tue, 28 Oct 2025 06:42:24 +0100
Message-ID: <20251028054238.14949-49-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028054238.14949-1-philmd@linaro.org>
References: <20251028054238.14949-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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
 target/arm/hvf/hvf.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index b053bdd7cf2..0788b20cc05 100644
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
2.51.0


