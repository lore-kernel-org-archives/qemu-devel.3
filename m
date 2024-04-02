Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3246DC6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 10:31:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrbP5-0008ME-PZ; Tue, 02 Apr 2024 06:30:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rrbP2-0008KM-Uk
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 06:30:05 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rrbOy-0003er-F0
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 06:30:04 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-415446af364so24613455e9.0
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 03:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712053795; x=1712658595; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=91BZ+bUW9V0rFrI3CQ5Xh/5sgpFgV/x/ACLid6y7DpM=;
 b=hq6iGl0txrf58Hpo8/N+5s43bnhFAJ2xWkqiccWNH0Mzscb8olzmyuNiR8N4HMD4MF
 vRYPbfFiAdV+s6DBgi8RlEuFFPK/taiSaxwEnsyk4M9PiS634ZQX+tNt5pt3UCUsUPZM
 0psG1XzSPpIpkjZLLp0o0yPmpseeEzCBHOllIGn7Kxed+zzJ6ubFMnyolHU79dO1ZO1T
 C/Hi9bHiQaj2szIt/Msqy3nfQ1MM19g7pWzLPVARr6JWPiqKHnSzwuJYrv8wLfTdUwfr
 rF0FPOiDh9cXtUEPGeGbUS6+viM7+DNdx04cqXKrFEaEWwCRr+orHRUnc2wVXppxKasE
 LRhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712053795; x=1712658595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=91BZ+bUW9V0rFrI3CQ5Xh/5sgpFgV/x/ACLid6y7DpM=;
 b=GM9GGpw/EvHmAVmG4V9NFq0Up2orBafzIAAoaVruyHkFKL62un3q/SXDITATZ7HqLV
 RwINwPeckVWcG2YjxZbC3dlXoUUcHmgvOWVkDL0zfkMk2ZZL0sBIOyk4IhMKhYxqcTWf
 +zxCYmrLliqPRw4aButzZxooDf1eVZ0uNDtWwiA4glg0TYD9LSw1a/PSMepxsCqhHZY2
 Dndze+tuE2LsfuoK1VdrUxRv6BYL3S4jSdpEVV/1qznuyApjQHFr4mKD1DC45mpxSLei
 CvHpFXJEQF0fjdlDQrv5ZAnprCNR+Hq/guL6yRiz4cPWFjeWT9zu+KwE8NEWORkuJcRw
 hqyg==
X-Gm-Message-State: AOJu0Yw2gBahO+1fmECC+P3/feCnkFeNy5nTXEF6MKd5l6FyLwh49dLA
 s0jba8Gh6+lrU0D0kwowbrXy5lYH1g9zA2qZXDOEWoFUZSC7/xlYprFZH89ghFb3bKQivGH9IAD
 Y
X-Google-Smtp-Source: AGHT+IH3BfhMk5bty9oxx5kF1EE12S369V8AM6q2CsEupBNPmN4oL15EG6JqCTgCcwhBITBRwKAYqA==
X-Received: by 2002:a05:600c:4f05:b0:416:1ad7:f1b9 with SMTP id
 l5-20020a05600c4f0500b004161ad7f1b9mr1383866wmq.17.1712053794876; 
 Tue, 02 Apr 2024 03:29:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 o15-20020a05600c4fcf00b0041488895a37sm20586175wmq.33.2024.04.02.03.29.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Apr 2024 03:29:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 3/5] hw/intc/arm_gicv3: ICC_HPPIR* return SPURIOUS if int group
 is disabled
Date: Tue,  2 Apr 2024 11:29:49 +0100
Message-Id: <20240402102951.3099078-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240402102951.3099078-1-peter.maydell@linaro.org>
References: <20240402102951.3099078-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

If the group of the highest priority pending interrupt is disabled
via ICC_IGRPEN*, the ICC_HPPIR* registers should return
INTID_SPURIOUS, not the interrupt ID.  (See the GIC architecture
specification pseudocode functions ICC_HPPIR1_EL1[] and
HighestPriorityPendingInterrupt().)

Make HPPIR reads honour the group disable, the way we already do
when determining whether to preempt in icc_hppi_can_preempt().

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240328153333.2522667-1-peter.maydell@linaro.org
---
 hw/intc/arm_gicv3_cpuif.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index e1a60d8c15b..67d8fd07b7f 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -1067,7 +1067,7 @@ static uint64_t icc_hppir0_value(GICv3CPUState *cs, CPUARMState *env)
      */
     bool irq_is_secure;
 
-    if (cs->hppi.prio == 0xff) {
+    if (icc_no_enabled_hppi(cs)) {
         return INTID_SPURIOUS;
     }
 
@@ -1104,7 +1104,7 @@ static uint64_t icc_hppir1_value(GICv3CPUState *cs, CPUARMState *env)
      */
     bool irq_is_secure;
 
-    if (cs->hppi.prio == 0xff) {
+    if (icc_no_enabled_hppi(cs)) {
         return INTID_SPURIOUS;
     }
 
-- 
2.34.1


