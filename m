Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D7EAC77B7F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 12:30:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTgAD-0002ud-Nz; Mon, 23 Jun 2025 08:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uTg9w-0002CG-QC
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 08:20:25 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uTg9p-0000vh-Qg
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 08:20:22 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-451ebd3d149so21447425e9.2
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 05:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750681215; x=1751286015; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NW0Hu04oFurHIvjEpsNrwT15qBihdHLv3c5t8qKFRhE=;
 b=zP74SQHBdjUEUjjjBVAvJm2u8nRqZxe+Ertm9WgJn30t/CYBKYApUlz3RsyXqALheW
 xxHbYLypQRoxBSrEdfFGx0025urURyVxseog4HoM9oKDzS78c7K01cE9769CvP0q8ftH
 B1ScQqp77I1uan5dcIk2qpNAwDiWxUVDiLmBdQ6yXrqKWJX2aBpvidZYdxPInjvKYnTh
 oEdrQrVEN5egxl/p1eiziu3aWavoDv/W9IpDyrIIcZ+SZq677RRS6zPO5gi9lDdGrtAr
 WxHfd+Pa2vdaoJ9Tm+SbbdXewUYr/xsQccygajdA7NcFaFZjrhRpRNYA1fCUgBGn67Jn
 9XYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750681215; x=1751286015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NW0Hu04oFurHIvjEpsNrwT15qBihdHLv3c5t8qKFRhE=;
 b=oRjFdatl5G9tEMSx856tzqnlHeylHWFaW3p+fPjbqochO6sQKiPIow42ZdsidpJY0F
 aPO5ZLgzjX8XqaP303Bwn3vA1+PbyK4ai4o00KqCGgNEpZw9uUSR2x7Zxw7WTbCxJjUP
 joPX9AATPeLGMdaCjdk4WHmRr5PH1/7okjYS+nMyRG/Hn6FkNS+aj+UinGz40kmSayax
 VxvnSp0qK1eeSc73YlOhjfhlAjZkWHgFWz6qXmWFJLjeRNDH3iGo3qnOKhukOFRPQN9a
 X85qNgnlvF0CTcMj3KDKVRYNl1e5YHXo7u1qWgfnOA8MGmrqxbR/4YEIIrEZVKZ3SerF
 rerw==
X-Gm-Message-State: AOJu0YwEEHYeLK+BzlGhbKTDYvdawGxrzFng2s9xnKvrGILkRRBe+OQ3
 ANvE8w1Qvw4q934UKFblOyTibmy9giiBojsRIOe3T9GBFTbOmyM59U67inZvPvgh0ggK0rjYLWW
 GWJ1x
X-Gm-Gg: ASbGncuaiXBblC44ucLZ4yipYmI+2q/CJRVC3wiHtfihQ+nChC2WG38TDr+ktoq/BzZ
 4u+9eE8vKMyNJMGfNHgmBUKCiWjT8EiwQr7b/sQ2+/743ur9BpkNUA+L3VrZE6pLe6kPnvEM7Li
 qSN4woWQdwJgJgu/n8m2wbbu5VtE9RdKgzJv48/slMZdG6LGkioz2zZN1QIsAdnjYpgHZgnHDt3
 gCc0tnBNiOiHGai5A37mu4FoOYeWL+njnvrAadt6+FC032IivTAB3pBd/cgCTTQgUnO38Bts1MI
 vx/xZEOaL9WTljljHnql9piYPvnFwEoRXOs0wM0Xr9EHKCfSIKHLu/rJiBvDCuSYex7pQDD0oLO
 tmg/uQdf+qzxtZ16xNwsBE07SxSzf4iZoCP0p
X-Google-Smtp-Source: AGHT+IFf+qYjcOwhbvT72NmXzsm0w8Ys9vtpByCOFfjMZimo/xqX2xIjROq90NsVmzqznUgThHB+QQ==
X-Received: by 2002:a05:600c:548a:b0:442:e03b:589d with SMTP id
 5b1f17b1804b1-453656c2b8emr119430815e9.24.1750681214699; 
 Mon, 23 Jun 2025 05:20:14 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45365af83easm103189385e9.25.2025.06.23.05.20.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Jun 2025 05:20:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Bernhard Beschow <shentey@gmail.com>,
 John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 kvm@vger.kernel.org, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Cleber Rosa <crosa@redhat.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 17/26] target/arm/hvf: Really set Generic Timer counter
 frequency
Date: Mon, 23 Jun 2025 14:18:36 +0200
Message-ID: <20250623121845.7214-18-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623121845.7214-1-philmd@linaro.org>
References: <20250623121845.7214-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
index fd493f45af1..52199c4ff9d 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1004,6 +1004,13 @@ cleanup:
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
@@ -1015,7 +1022,9 @@ int hvf_arch_init_vcpu(CPUState *cpu)
     int i;
 
     env->aarch64 = true;
-    asm volatile("mrs %0, cntfrq_el0" : "=r"(arm_cpu->gt_cntfrq_hz));
+
+    /* system count frequency sanity check */
+    assert(arm_cpu->gt_cntfrq_hz == get_cntfrq_el0());
 
     /* Allocate enough space for our sysreg sync */
     arm_cpu->cpreg_indexes = g_renew(uint64_t, arm_cpu->cpreg_indexes,
@@ -1084,6 +1093,10 @@ int hvf_arch_init_vcpu(CPUState *cpu)
 
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


