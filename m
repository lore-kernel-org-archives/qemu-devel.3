Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C5ECCF9EA
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 06:25:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDd95-0001mt-HX; Tue, 28 Oct 2025 02:25:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDd8R-0000sT-0a
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:24:48 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDd8O-0000fV-Ub
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:24:46 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-475dab5a5acso18630375e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 23:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761632682; x=1762237482; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zTEh/LVQjVZus7c2C/VSTX9bICXV4YJB1vAsJnGdIZw=;
 b=eq/2yeCXs8kUQNfFnWs6T2979aS7QNcn36WKOjABmd6mTHvLMzUg7KvQuY+WeFff9G
 e/+H6e8KgitX4maCZf3ktp9ORP8x5d04PWnHLFW4+h16n7aRmWGYIQsH67dtrbnaaJRi
 y+elBqZs7d/GXU3D5+KK6qn/DqfHnngs0oqSOmuoG9lmzvO7oLLO3/B2StBDccmK+afh
 UsfDxaeMO5Oo8lx7qnKv17YCErbbiTi/tnep7QUJ1SWpCqRI96YaU/VIhBMxgOb1S9NO
 5G3gF4lPu7BGQZ8dlbow/HjWaIMRCk6FJW93U4eZVp5HD6zfG408i+uyTR6yPPGoarEr
 vMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761632682; x=1762237482;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zTEh/LVQjVZus7c2C/VSTX9bICXV4YJB1vAsJnGdIZw=;
 b=g9ghQ4UMJArPc6hiSqu3+P+TS0yqTXpqD4iIB2sxQuUomjIsaEAylTNN3kyBztOEy3
 dDQh1vXfu8bhpj+AUdq+k3xlAJmZU6ulGzSx+6KNwaZIfHsE3y8vMFTvcFuv6s4GlqUI
 Gl4WNuPygvIkFwgv2w/AyKelsAM+VNQ5iUdXap1DSrJb6eE+HDUoqLKUrpcJGEKlQilt
 0aVj4BpKu0jfjF4LOXhQ+3G38htP9UzznLT5m5T/uRwRIttzOEdL/Hq2VqLeuv2PdqUZ
 NeSgusrDxeNQRbPX8GdU/YnjCkNfpK0yTV/4M79wHcZWVhCuxqiXl4sGvjxJUjNDh531
 aVcA==
X-Gm-Message-State: AOJu0YzzfFNgsm8MZ/cXAkZmsuhR26RfXzfRNjqozXGpk6hksz91YJ1z
 iWYgl9MjQcHihIq6bDE4Lt4aSdE7Z25YH/vTg5jnqPIsTRoAEEsVOsAxJ2VcFR7o5duoIyckiPT
 JiTLhuCc=
X-Gm-Gg: ASbGncsn0tKNxdv+/CSWrMmHZ5U8emSFLhYIdqPzmtGCkykYWnQBmwTAm2l6QS4BPUd
 zWcX5XrRCUA9byyeotfKCTe9CrhoeEhOps286XrYyeQBk8oIaPBfj2MhjjD11TuH0XayuHnchY8
 Q9H1G60IAWb75nirZ7otCxDA9YxstdbnDk+PQXEEhtqegLjaQ6V86bIrchSaHy8be0TvNG2Ur55
 lksaXbfTFXk6SzpXjK5dVh5VBkk4vGnkpt3V3Pss3qT8fv5Wj1YJUs689Jo2shxSZfNbqrf+91p
 EWDLYcIWqZdLArCqm0KPW3XkrT627tL3jUyD9qsDYvR5/vgfRtSrItDiZIM9z3uy8WOHj0wmKeP
 M9EbsKmwdVZ+/OVUOycNfsNpZjO6XljSv6qaiUcut5s/HfIFVBczFhuB+dRCZ4mFmdlsN5kVYRd
 25VPlUnvcDA3Ip8g/2BWV9bu4UCYCH+t7miB3psNv9qjSpl/3YnSwfdpGKOIwG9+JAbg==
X-Google-Smtp-Source: AGHT+IEPV0mXk/DfIevFNGNmoexAS0FMcZZf/eG0BfO1U+bxdl+52y3h4avRzelcUezdGGty/i4rwA==
X-Received: by 2002:a05:600c:19c6:b0:45d:d353:a491 with SMTP id
 5b1f17b1804b1-47717def79fmr17324445e9.1.1761632682158; 
 Mon, 27 Oct 2025 23:24:42 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd4cba64sm175001005e9.14.2025.10.27.23.24.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Oct 2025 23:24:40 -0700 (PDT)
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
Subject: [PATCH v3 59/59] target/arm/hvf: Emulate PhysTimer registers
Date: Tue, 28 Oct 2025 06:42:35 +0100
Message-ID: <20251028054238.14949-60-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028054238.14949-1-philmd@linaro.org>
References: <20251028054238.14949-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Emulate PhysTimer dispatching to TCG, like we do with GIC registers.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
TODO: audit it is safe
---
 target/arm/hvf/hvf.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 113f1415011..a7b5e4711b0 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -189,6 +189,7 @@ void hvf_arm_init_debug(void)
 #define SYSREG_LORC_EL1       SYSREG(3, 0, 10, 4, 3)
 #define SYSREG_CNTPCT_EL0     SYSREG(3, 3, 14, 0, 1)
 #define SYSREG_CNTP_CTL_EL0   SYSREG(3, 3, 14, 2, 1)
+#define SYSREG_CNTP_CVAL_EL0  SYSREG(3, 3, 14, 2, 2)
 #define SYSREG_PMCR_EL0       SYSREG(3, 3, 9, 12, 0)
 #define SYSREG_PMUSERENR_EL0  SYSREG(3, 3, 9, 14, 0)
 #define SYSREG_PMCNTENSET_EL0 SYSREG(3, 3, 9, 12, 1)
@@ -201,6 +202,8 @@ void hvf_arm_init_debug(void)
 #define SYSREG_PMCEID1_EL0    SYSREG(3, 3, 9, 12, 7)
 #define SYSREG_PMCCNTR_EL0    SYSREG(3, 3, 9, 13, 0)
 
+#define SYSREG_CNTP_TVAL_EL0  SYSREG(3, 3, 14, 2, 0)
+#define SYSREG_CNTP_CVAL_EL0  SYSREG(3, 3, 14, 2, 2)
 #define SYSREG_CNTV_CTL_EL0   SYSREG(3, 3, 14, 3, 1)
 #define SYSREG_CNTV_CVAL_EL0  SYSREG(3, 3, 14, 3, 2)
 #define SYSREG_PMCCFILTR_EL0  SYSREG(3, 3, 14, 15, 7)
@@ -1249,16 +1252,20 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
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
+        /* Call the TCG sysreg handler. This is only safe for VTimer regs. */
+        if (hvf_sysreg_read_cp(cpu, "VTimer", reg, val)) {
+            return 0;
+        }
+        break;
     case SYSREG_ICC_AP0R0_EL1:
     case SYSREG_ICC_AP0R1_EL1:
     case SYSREG_ICC_AP0R2_EL1:
@@ -1571,19 +1578,20 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
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
     case SYSREG_LORC_EL1:
         /* Dummy register */
         return 0;
+    case SYSREG_CNTP_CTL_EL0:
+    case SYSREG_CNTP_CVAL_EL0:
+    case SYSREG_CNTP_TVAL_EL0:
+        /* Call the TCG sysreg handler. This is only safe for VTimer regs. */
+        if (hvf_sysreg_write_cp(cpu, "VTimer", reg, val)) {
+            return 0;
+        }
+        break;
     case SYSREG_ICC_AP0R0_EL1:
     case SYSREG_ICC_AP0R1_EL1:
     case SYSREG_ICC_AP0R2_EL1:
-- 
2.51.0


