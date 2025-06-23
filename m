Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06833C7EE2A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 12:23:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTg9W-0001cf-DJ; Mon, 23 Jun 2025 08:19:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uTg9I-0001WW-1w
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 08:19:47 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uTg9G-0000aB-1A
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 08:19:43 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-450cf214200so37508935e9.1
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 05:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750681179; x=1751285979; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=48R2YiPamWEGXpLD/SMOVBFSdD9dMYPDAhGM9B3qv/Y=;
 b=mXcOS97vqVAa1ZsWfnUWfAX4RvbSgyDCh2HLu+9znNTtBjghTC1vhq3jFfFSca0aWm
 92kYwRdp7E0xTonUSds+DomOrFRUMKwKUQny625KKk4C6ixkDZXBd0wANQErgf3CeWjY
 r0qx7QQb+Zltj6QVcrxWEBn+LAw0ILkqaUBTI1T4PISndDNoFICfw8Orss6yfBAuar/u
 Xt7MzHcqnsyePniYfnAyPR4JCGxeC21GGk7aoFxulf2HEVmjPLOn3hdTWxHMegsx6ECA
 Q0A0mYtTbUJIc/nPCZhg563kLof+hvLrrQqawB0PbOt8LIPl26GISsRm6HQNxWEadCwf
 Nlgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750681179; x=1751285979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=48R2YiPamWEGXpLD/SMOVBFSdD9dMYPDAhGM9B3qv/Y=;
 b=bPCpRid7eFkBD3rx3o2tGUrQmcnrMhatbobv51zm0mw+Zlk72wLmL6ycr5r7ZZAm8m
 BNf+TEMMkDzxokAcvEo7DVFUyVkpJ9RswGgIiAz3OLuCo3wqs+t8X7lRvVcyAqAvdjcT
 TWnATf9s44ucd+ttX7F0bsaII0Efkfqi8ktLuk687tQSoODa7ZuNI6DrxJzZxWQ4ZSsM
 r4jQxa+qJx0Hj1giIG+j7U0NFkcvZC91ldGgZRXhMqo1dyUi+W2y0udoF/qITp7GbftY
 rAlbKPf4Ger89cHqqzX/T0oGzAWzsGbZccOYG3nDN5k0U7QlNJbj6vpkEoVgIQpBhqF4
 8P1Q==
X-Gm-Message-State: AOJu0YzQWBrxO+mKKbrIDKoykFv0+enGBimSAe51OSS7Axntp99V5nt9
 BQkasrFSe/y6AQwyIxutnxMhKnJdy+YM0MdRTTpC43i4DqBYdodix5K4Q4R/0JHxQh4g0wJwoKr
 6kJCi
X-Gm-Gg: ASbGncuvkAt+rJi3aSC8oFs4njYT/ruh8baMRKq/+TPUlaa+J5o3QicHXd/sTf39GpQ
 KwzqReIss4uwQOfXI5JBc9Jcu22EwWwkNk2HOvie2lJQIvPg6Qtuyc61vrRDYyaVrgN3ZEjr03Q
 HUi9wYR/fnZ1LvJt8O7AhfwYVzOUG8ZXbBp7l6texty780W1BIktAgPy0F5aVgDseee9gxF8kSz
 m0oezwmCBnPmxdZtA0Qg+FDrnvk+JDxS+FdaO6UyZOwYa6whDjwGgIfAhDtL2qav4U572bmHQJK
 eO9ODvTc6E9MsdPQez8T+m37Q4xGDf/396mRPMRsltuomxNWmtENk9B9+D6dRxE6F4lVCuJWn+J
 jfFKdhJ6TlylVkDPuH1XOWESE3PXhgKuMa03Mb1x//x0AXF8=
X-Google-Smtp-Source: AGHT+IEXe4I5B9Ke/lPmm6yKL911KIFc6TFDbUCkl0BXXwXmGDLjh6AfC57olDM6XbzOca+1lNc8Xg==
X-Received: by 2002:a05:6000:41c5:b0:3a0:a0d1:1131 with SMTP id
 ffacd0b85a97d-3a6d12c4483mr9863735f8f.7.1750681178908; 
 Mon, 23 Jun 2025 05:19:38 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e2036094sm2260909f8f.99.2025.06.23.05.19.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Jun 2025 05:19:38 -0700 (PDT)
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
Subject: [PATCH v3 10/26] accel/hvf: Model PhysTimer register
Date: Mon, 23 Jun 2025 14:18:29 +0200
Message-ID: <20250623121845.7214-11-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623121845.7214-1-philmd@linaro.org>
References: <20250623121845.7214-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Emulate PhysTimer dispatching to TCG, like we do with GIC registers.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/hvf/hvf.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index bf59b17dcb9..5169bf6e23c 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -187,6 +187,7 @@ void hvf_arm_init_debug(void)
 #define SYSREG_OSDLR_EL1      SYSREG(2, 0, 1, 3, 4)
 #define SYSREG_CNTPCT_EL0     SYSREG(3, 3, 14, 0, 1)
 #define SYSREG_CNTP_CTL_EL0   SYSREG(3, 3, 14, 2, 1)
+#define SYSREG_CNTP_CVAL_EL0  SYSREG(3, 3, 14, 2, 2)
 #define SYSREG_PMCR_EL0       SYSREG(3, 3, 9, 12, 0)
 #define SYSREG_PMUSERENR_EL0  SYSREG(3, 3, 9, 14, 0)
 #define SYSREG_PMCNTENSET_EL0 SYSREG(3, 3, 9, 12, 1)
@@ -198,6 +199,7 @@ void hvf_arm_init_debug(void)
 #define SYSREG_PMCEID0_EL0    SYSREG(3, 3, 9, 12, 6)
 #define SYSREG_PMCEID1_EL0    SYSREG(3, 3, 9, 12, 7)
 #define SYSREG_PMCCNTR_EL0    SYSREG(3, 3, 9, 13, 0)
+#define SYSREG_CNTP_TVAL_EL0  SYSREG(3, 3, 14, 2, 0)
 #define SYSREG_PMCCFILTR_EL0  SYSREG(3, 3, 14, 15, 7)
 
 #define SYSREG_ICC_AP0R0_EL1     SYSREG(3, 0, 12, 8, 4)
@@ -1326,16 +1328,15 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
     }
 
     switch (reg) {
-    case SYSREG_CNTPCT_EL0:
-        *val = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) /
-              gt_cntfrq_period_ns(arm_cpu);
-        return 0;
     case SYSREG_OSLSR_EL1:
         *val = env->cp15.oslsr_el1;
         return 0;
     case SYSREG_OSDLR_EL1:
         /* Dummy register */
         return 0;
+    case SYSREG_CNTP_CTL_EL0:
+    case SYSREG_CNTP_TVAL_EL0:
+    case SYSREG_CNTPCT_EL0:
     case SYSREG_ICC_AP0R0_EL1:
     case SYSREG_ICC_AP0R1_EL1:
     case SYSREG_ICC_AP0R2_EL1:
@@ -1639,16 +1640,12 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
     case SYSREG_OSLAR_EL1:
         env->cp15.oslsr_el1 = val & 1;
         return 0;
-    case SYSREG_CNTP_CTL_EL0:
-        /*
-         * Guests should not rely on the physical counter, but macOS emits
-         * disable writes to it. Let it do so, but ignore the requests.
-         */
-        qemu_log_mask(LOG_UNIMP, "Unsupported write to CNTP_CTL_EL0\n");
-        return 0;
     case SYSREG_OSDLR_EL1:
         /* Dummy register */
         return 0;
+    case SYSREG_CNTP_CTL_EL0:
+    case SYSREG_CNTP_CVAL_EL0:
+    case SYSREG_CNTP_TVAL_EL0:
     case SYSREG_ICC_AP0R0_EL1:
     case SYSREG_ICC_AP0R1_EL1:
     case SYSREG_ICC_AP0R2_EL1:
-- 
2.49.0


