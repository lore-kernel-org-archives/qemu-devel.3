Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C460FF885A
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 10:17:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIkuQ-00047U-Qx; Fri, 01 May 2026 06:15:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIkuL-00044j-1n
 for qemu-devel@nongnu.org; Fri, 01 May 2026 06:15:41 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIkuJ-0000Hm-AG
 for qemu-devel@nongnu.org; Fri, 01 May 2026 06:15:40 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488b0046078so14846445e9.1
 for <qemu-devel@nongnu.org>; Fri, 01 May 2026 03:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777630538; x=1778235338; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JNEtBvOkPyY2VflHuwbXWSp3/7gfXfuP2T8jg+5DLbA=;
 b=EkczOc64KN2Htjz+XLRDKhu8L9M/jkJ3wvkpqOUumaQ3aEYv+4aPk8YnPvmdED3LxZ
 FwI/yczuyAI+DoYhZafbB18XA54paNjhP/kLFyiT3KenIJlfiZFs3kALSpGbETgMAwTk
 kjYqbSJnOgwRXbjXIMMm6rPwQVdhao2FP9fVNicF8t1e5KhyErL8gBGpXELz6hC2Vble
 38HIskjwd62szXus35kHe9Ny8SOVjfKHm2bkQ0pTieNQSn4SiJp/fuDCi88N2UY7RMfn
 vChWKJuL1612UZzfHtzvpM5sBWU88LKdMKiHplquNa5TD5UdSgTPdvTYWa6sZO+x/GaX
 4+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777630538; x=1778235338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JNEtBvOkPyY2VflHuwbXWSp3/7gfXfuP2T8jg+5DLbA=;
 b=UpqI64NaWCPp3yIGfNsE29iWPJ9UpKkyhQ5iw6Y34zvL96fvvltMntcQ+OQ5iTeDzZ
 RJObcRnUSxOc0uqlYco0zZcZrWKKYObkBBfg3hWI3Xuk4S91TvOVsZQKzOYlzu+lHAuQ
 40KuV8V+hebgJvNv2xWlrDUMzB+m5nupBM4j3JOGvPQbalvgBb4kCjyV1yTVwLBABKZR
 dIyzXUs/Gazkc8Msp+LV9H0jJm6y4M0eWy2N4iGYZbsELANsRIfP578CZMqiNKq+ew7Z
 Lkf+4MET7Zo9wP0dwx0fcbru9Lphp+LZU0BELlSSelS/ydY82LYVAAnR+4TBKWNW0VKM
 uKag==
X-Gm-Message-State: AOJu0YwJfr7PxL5daDZr3pnFiOkVA3DdL82rpwcbQMojBw25ki1Rxxmn
 QtHS9S7spywSxfCuRuRKb7SHMX2lPo75eMGkSXDqAwB3ohd3GySJnW7zvuclwdKOmeW+DzhnDdD
 ZcD15
X-Gm-Gg: AeBDiess9JWusPOGBbFay9tHgoBqZzXiUK8LcOoJgEMGTi6PT7zJKHchQw2J1O78FR5
 bTAGwi8FQc6bN5SZPV4Gz2inCA2Qefc0D/vZF7Z9EMhtiQC72kDdPiL3VefKAJ7PzH+UDmW+W36
 jaV3cVVBFZkF/9pthWQYZt12i1Oh2IAAleAVquhsIXtc0puMj60O670II9SHr4EjwX2333buF6i
 P67cuhStJogfhv2ODb4TnbnhiumcGV8tSwDBJnbywIg66hU/OLDKV4msSEooB8JSGi3O8qpMDpZ
 OzhCCJ8O4PJQfM7rWuMLjXwJjMlpJtWJg/DZEP9AG23pr82jrdJ1dRKLFw/4iHedggJHGavJzZ2
 AArEzDvj2XpkJ8LuKwh17ggRE4K0i60i2V8JKxm3b+kbadc/TsO9SN8m9saZSuCulkK6OoAMLeG
 9d0rj1OUT6HkzCLb6k3lHrlmN0hINeetcDSsyjioW1U24MqcnAy+Xq4yaa0YrD3wFYJ5n/JFxqt
 0rOBKAJXLEUBsh24O+hUi44aPYYF3ubl2bX3CCaKw==
X-Received: by 2002:a05:600c:1f8f:b0:48a:8905:a500 with SMTP id
 5b1f17b1804b1-48a8eb74345mr34514715e9.12.1777630537886; 
 Fri, 01 May 2026 03:15:37 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8fede418sm12863335e9.6.2026.05.01.03.15.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 03:15:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/28] hvf: arm: physical timer emulation
Date: Fri,  1 May 2026 11:15:03 +0100
Message-ID: <20260501101505.3485916-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260501101505.3485916-1-peter.maydell@linaro.org>
References: <20260501101505.3485916-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Enable this through leveraging TCG's physical timer emulation.
This allows nested virtualisation to work with a kernel-irqchip=off + GICv2.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Message-id: 20260429190532.26538-14-mohamed@unpredictable.fr
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 6062e08c49..2252b96f83 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -189,7 +189,9 @@ void hvf_arm_init_debug(void)
 #define SYSREG_OSDLR_EL1      SYSREG(2, 0, 1, 3, 4)
 #define SYSREG_LORC_EL1       SYSREG(3, 0, 10, 4, 3)
 #define SYSREG_CNTPCT_EL0     SYSREG(3, 3, 14, 0, 1)
+#define SYSREG_CNTP_TVAL_EL0   SYSREG(3, 3, 14, 2, 0)
 #define SYSREG_CNTP_CTL_EL0   SYSREG(3, 3, 14, 2, 1)
+#define SYSREG_CNTP_CVAL_EL0   SYSREG(3, 3, 14, 2, 2)
 #define SYSREG_PMCR_EL0       SYSREG(3, 3, 9, 12, 0)
 #define SYSREG_PMUSERENR_EL0  SYSREG(3, 3, 9, 14, 0)
 #define SYSREG_PMCNTENSET_EL0 SYSREG(3, 3, 9, 12, 1)
@@ -1719,9 +1721,15 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
 
     switch (reg) {
     case SYSREG_CNTPCT_EL0:
-        *val = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) /
-              gt_cntfrq_period_ns(arm_cpu);
-        return 0;
+    case SYSREG_CNTP_CTL_EL0:
+    case SYSREG_CNTP_CVAL_EL0:
+    case SYSREG_CNTP_TVAL_EL0:
+        assert(!hvf_irqchip_in_kernel());
+        /* Call the TCG sysreg handler. */
+        if (hvf_sysreg_read_cp(cpu, "PTimer", reg, val)) {
+            return 0;
+        }
+        break;
     case SYSREG_OSLSR_EL1:
         *val = env->cp15.oslsr_el1;
         return 0;
@@ -2015,12 +2023,14 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
         env->cp15.oslsr_el1 = val & 1;
         return 0;
     case SYSREG_CNTP_CTL_EL0:
-        /*
-         * Guests should not rely on the physical counter, but macOS emits
-         * disable writes to it. Let it do so, but ignore the requests.
-         */
-        qemu_log_mask(LOG_UNIMP, "Unsupported write to CNTP_CTL_EL0\n");
-        return 0;
+    case SYSREG_CNTP_CVAL_EL0:
+    case SYSREG_CNTP_TVAL_EL0:
+        assert(!hvf_irqchip_in_kernel());
+        /* Call the TCG sysreg handler. */
+        if (hvf_sysreg_write_cp(cpu, "PTimer", reg, val)) {
+            return 0;
+        }
+        break;
     case SYSREG_OSDLR_EL1:
         /* Dummy register */
         return 0;
-- 
2.43.0


