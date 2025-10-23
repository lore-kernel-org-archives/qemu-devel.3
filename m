Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0441CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 12:37:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBuXL-0001Oe-7J; Thu, 23 Oct 2025 08:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBuU1-0005Hk-9T
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:32:00 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBuTz-0008OU-2i
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:31:57 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3ece1102998so525985f8f.2
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 05:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761222710; x=1761827510; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YDmYw54TK5jSiAes/7YC6P5tTS/ucyoXkoDxXUlAez4=;
 b=LjDZbiHpXzLv/ChTLfGlxK5q1aRkPphrtnrA//qkZ7hgWjzP2l8aIKxFkc4DTQ/AWM
 /D4nEpkXg6tAM6+Ty7X1hHZZu373Pm+sTgPvDgoEX7OBLpKnoBR1TPw2t5ru+kMJqt6R
 n/EgpXxgGZDkkWYhRObObYCAkeD04qjLKNtOdlozRK2SK4Abgd19NdbEA2i4QDB9731n
 /Ghrabu2OGnQp15FyvLqgQhkM2tZN8VR4UoZW0lFHdH2LrGTFhEVk5lafbO6hGFYrux+
 f+MisFnDijSb0GXytbQUDpTGcvtev3poqrXUxb/gCit6C7t5EMA1WBhVkAORiY/GaISd
 4pyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761222710; x=1761827510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YDmYw54TK5jSiAes/7YC6P5tTS/ucyoXkoDxXUlAez4=;
 b=KeiOcRdhuXcd0nDosBnKRzo45QROrPmvpHJ/rZ8o3UwiWgr++SAA39iNLsfWH9Nz5I
 uTafyU7zetSRaRbdvK+w2+6DHk8vVFJFYU+9PyzIM2V7+n8GqJdet2oU/fgeiekUmbAx
 DtLGCjdgnMfr18wUO4QtZs2vk8pGemdfMhnvo1hZ50YCfnDlbRplNWd0IG0LqsZ1xDag
 AG8mfk/hG8esB8+a1LcRoj/THnv0GRxrTjZwidKKK+OaCuxdtpeKsbRI9kmM9SZeqV11
 jhLYZfca4ip1cpYEljU7x2UmKZQILhCUtLLXbRxpbzUvkVqT/Y2c33DZEfcotFE0hW/C
 5zrQ==
X-Gm-Message-State: AOJu0YzgQkP8iLMzmK2dzkFltg7fP2p1df6Rhv4eDXr66+IS8BmXhpKo
 hRn+6MnBY4bop2lEKr9JugQqq/fjaSPrcVXJ4suu3OfrXMK4Gc0j1hyQ7wOW215HDP7OslwfOid
 5mrwPHvo=
X-Gm-Gg: ASbGncugSapoC/23FX4FTpFqkXpwI2dwZmQkPmxgMDAShEODxt3J1DuQB8YXx3qFifh
 +KMNqTbtdYyTMmhgWCsdtg136t+40r/S4iBGctEOlhLdtf2YfqycqPVSbPEVVx8W99oKC8qLNtO
 0Pt707DEmg2WWtoo6T8u/5s45qf9FE4bHu+iQMRjJsUd+wzSJfBC1pSBPv47HG3hRGrBLzOcveV
 LFL1TFsCvo7K9w+k0fYao/59pIkI/t17azQB4/QTeZIjLnBsDuBL7NXSCsI+0UCHcjO9VyY0y6I
 /0SoV3UNFDSh5X5Lkk+LmPhutLYeDbihmLUveiALF5qzQfpKcQM0xwnVYOzgzUBEI3CQ2BfjSku
 Iwoh06myy8FOiNJNCbbUz6c4+NpyBnj++/6KIq4uqdaEJ90j4IX4/5FHXo85KnE2Cm/ikvSpPBN
 s+ha4SzDyLtxdINyW3IPNX6w39yCMpwwqi8N7Q5agIW/Ic8PLsgw==
X-Google-Smtp-Source: AGHT+IGGIR/0SPECtQT4Jff1V+N/nTa9ysFMFejsJuRkzH7znWUcHtDVIOGN32PvjaO4+QCmua0g5A==
X-Received: by 2002:a05:6000:2510:b0:3ee:15c6:9a6b with SMTP id
 ffacd0b85a97d-4298a0c60e7mr1426429f8f.48.1761222710233; 
 Thu, 23 Oct 2025 05:31:50 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429898add96sm3716004f8f.30.2025.10.23.05.31.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Oct 2025 05:31:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Collingbourne <pcc@google.com>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Cameron Esfahani <dirty@apple.com>
Subject: [PATCH v2 51/58] accel/hvf: Model PhysTimer register
Date: Thu, 23 Oct 2025 14:31:35 +0200
Message-ID: <20251023123142.8062-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023114638.5667-1-philmd@linaro.org>
References: <20251023114638.5667-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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
index dbf6b83532d..cc3f22ac542 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -190,6 +190,7 @@ void hvf_arm_init_debug(void)
 #define SYSREG_LORC_EL1       SYSREG(3, 0, 10, 4, 3)
 #define SYSREG_CNTPCT_EL0     SYSREG(3, 3, 14, 0, 1)
 #define SYSREG_CNTP_CTL_EL0   SYSREG(3, 3, 14, 2, 1)
+#define SYSREG_CNTP_CVAL_EL0  SYSREG(3, 3, 14, 2, 2)
 #define SYSREG_PMCR_EL0       SYSREG(3, 3, 9, 12, 0)
 #define SYSREG_PMUSERENR_EL0  SYSREG(3, 3, 9, 14, 0)
 #define SYSREG_PMCNTENSET_EL0 SYSREG(3, 3, 9, 12, 1)
@@ -202,6 +203,8 @@ void hvf_arm_init_debug(void)
 #define SYSREG_PMCEID1_EL0    SYSREG(3, 3, 9, 12, 7)
 #define SYSREG_PMCCNTR_EL0    SYSREG(3, 3, 9, 13, 0)
 
+#define SYSREG_CNTP_TVAL_EL0  SYSREG(3, 3, 14, 2, 0)
+#define SYSREG_CNTP_CVAL_EL0  SYSREG(3, 3, 14, 2, 2)
 #define SYSREG_CNTV_CTL_EL0   SYSREG(3, 3, 14, 3, 1)
 #define SYSREG_CNTV_CVAL_EL0  SYSREG(3, 3, 14, 3, 2)
 #define SYSREG_PMCCFILTR_EL0  SYSREG(3, 3, 14, 15, 7)
@@ -1231,16 +1234,20 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
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
@@ -1553,19 +1560,20 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
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


