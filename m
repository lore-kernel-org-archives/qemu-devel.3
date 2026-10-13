Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 907E1CC6B03
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:54:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGY7r-0005sk-Al; Tue, 13 Oct 2026 04:44:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY4B-0000Ls-Al
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:59 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY49-00086h-7p
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:58 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4a172eb31f0so20441435e9.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791880856; x=1792485656; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ssQOKL4yIVf/4dvvQm7DObQY0a7iM7G4sOvZS6fl620=;
 b=IgQZtzhque9JHBcSC8AyxFUfkDXgrZyskzAFdOTkqLVvcmJbUPG12HCQcNtSVsuEhH
 tT53uPllwb7uhhTb/5vVmLmLXkv4sHevccBHHWXByVvCWabyQkHsEFVPoU52nsT1Sy4H
 UuVazVw4Qup2lv/LQXWAQ3fY5Crba5RX2KT+WJo2EyZgIHielt6FG5WOJ7MxGXNeKfZ3
 xBa8HK8RK7G3aeMVzs4rEk/Y+T5p7aB25uMvWW5bAxUWdf0CL5fiFxlAyA/ikvui+X2B
 fkeSMMFPxo/+/K2D+1KWAcLXJcmzoJZsiVcN6+FBwfTz6P3rq/YwaPhxqoyOwxPaPREp
 gwYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880856; x=1792485656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ssQOKL4yIVf/4dvvQm7DObQY0a7iM7G4sOvZS6fl620=;
 b=a02ntYAll5jOemDaUDHSwKjNg4Fuoawmi2Dd0BAXX3wksWzTbmYY0z5Br6PLh3Twkl
 hdVNyj9gdjGJoerhHhJgCIzSuFnpMwqO8n8LAs2yfElq06qY8nUSYWb3PKGlfDdycCFS
 F1zYIZuxRjn6v2DS6F4zK1FhjkCbrhZLG7Q/VES1QOEBdj5CqoNLn8iMVkOT84GCb+os
 qzl4J8rrDS0uTDPtYBtFKrcr4zKHZjjSxJaIBxA2zM0s7QAqCn1/wSOAk8ejivNTkdDZ
 ext3NFv2Qe1+AE+IxMgkOE0m5xgIaA618GcIMuWc1XgPCO6wsAINilMg0Iv9FEr2fEL/
 Itdg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz+fMIj4EDPAyen7DVOPrVPH+nfzzVHIbp9/GXhou09pumeUAY0ELnQSjpRpVKF8rQI3jrbcLvRawX5@nongnu.org
X-Gm-Message-State: AFq9FYLMlDt/zcNdDV0cGXjCBYnLeKMzH64mxzaUhVio1QHlhll30tyP
 L/xxe1uwZVq+CGELsLrRN6r4sd6pJgicl3kMv8touqkFv5L5D7yxqihelGRXza9O5IxQR9lvCre
 GusG+Kqg=
X-Gm-Gg: AYBFou3FwV9li3GCnaU1TSC1bdihkOLAeWmi8raLaUB8DUpaP6ASk+lD2njlcDO9y8d
 XkWPu+wkjWk/fJDGxlZtMBpzKStgVUAlaHqLEGzhQvC2svulATQyW7VyEu3/1xleV4g5hRiPuSQ
 nPIarVlr6CRX4xtR5KreLNIQxcX0PM/CCH/YniWVBrvPXCb0XZxgUhXGCso+DxHC4KHfWWBaQWi
 v/EYLuezGj1T4L+Yzqkg9jKA+PNls40Jey1SLkoe5YvvhiBPxmCTwWFPhfCKd3gNXhwRmCDDVOk
 xHv4QecFmwAO1qilI5AvNUrb0QKqMhiiqFOgP7MT4Hj2uRv20+C+gXvKyR0AwcdXd8wD2JLgflg
 44h7Dj30U0sXc5AGKVM6gaeUq1irLHl37MZN8IEhB4zslmvG8xAdQHbClzSY/MZMJPAn7VLYkXn
 ew4JYLYEg3/AI9yr6zbKSBb2ohDtR8LCtNNWo2oRgSShEOifnUm//0AdSrEFY/LXQ0Vwp3+MR57
 EOgP6HaYnX9rk3LOs3+6kDpAmWzHlPrHgC4YumDF8RIwUr+myRN8vHI6TzZuV656R58uz2fIIBy
 rAg=
X-Received: by 2002:a05:600c:4e8a:b0:4a1:78dd:dd28 with SMTP id
 5b1f17b1804b1-4a18e4d2b31mr235366395e9.27.1791880855762; 
 Tue, 13 Oct 2026 01:40:55 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm495086735e9.6.2026.10.13.01.40.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:40:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 61/86] hw/intc/arm_gicv5: Factor out "make an L2 IST valid"
 function
Date: Tue, 13 Oct 2026 09:39:08 +0100
Message-ID: <20261013083933.1024405-62-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013083933.1024405-1-peter.maydell@linaro.org>
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

irs_map_l2_istr_write() makes the L2 IST for a specified interrupt
valid by finding the L1 ISTE and setting its valid bit. For
virtualization, we want to do something similar for the ISTs
used for virtual LPIs and SPIs. Factor out the "do the work"
part of the function from the specifics of the IRS_MAP_L2_ISTR
register.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv5.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index 1d6f2767d02..3fac52012b1 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -1096,11 +1096,8 @@ static void initialize_ist_config(GICv5Common *cs, GICv5Domain domain,
     cfg->valid = true;
 }
 
-static void irs_map_l2_istr_write(GICv5 *s, GICv5Domain domain, uint64_t value)
+static void map_l2_istr(GICv5Common *cs, GICv5ISTConfig *cfg, uint32_t intid)
 {
-    GICv5Common *cs = ARM_GICV5_COMMON(s);
-    GICv5ISTConfig *cfg = &s->phys_lpi_config[domain];
-    uint32_t intid = FIELD_EX32(value, IRS_MAP_L2_ISTR, ID);
     hwaddr l1_addr;
     uint64_t l1_iste;
     MemTxResult res;
@@ -1138,6 +1135,15 @@ txfail:
                   "physical address 0x" HWADDR_FMT_plx "\n", intid, l1_addr);
 }
 
+static void irs_map_l2_istr_write(GICv5 *s, GICv5Domain domain, uint64_t value)
+{
+    GICv5Common *cs = ARM_GICV5_COMMON(s);
+    GICv5ISTConfig *cfg = &s->phys_lpi_config[domain];
+    uint32_t intid = FIELD_EX32(value, IRS_MAP_L2_ISTR, ID);
+
+    map_l2_istr(cs, cfg, intid);
+}
+
 bool gicv5_set_resident(GICv5Common *cs, GICv5Domain domain, bool valid,
                         uint32_t vpeid, bool db, uint8_t dbpm, uint32_t vmid,
                         uint32_t cpuidx)
-- 
2.43.0


