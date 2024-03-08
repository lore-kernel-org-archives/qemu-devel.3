Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B99DC54E5D
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 15:52:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ricUU-0008Jd-AD; Fri, 08 Mar 2024 10:50:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ricUL-0007Uc-RP
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 10:50:25 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ricUF-0004GX-NH
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 10:50:25 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-33e17342ea7so617182f8f.2
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 07:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709913018; x=1710517818; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3cWuaoCkTQVu5qObgGDnDzWYB/sSDqmlrWjM/kbjq6Y=;
 b=YAMICA+YMQ08x0I5ifZP4dZOVXJGvGS0cbMWyVo5NEJcgAXkhz7VWGDUDopaQht967
 Yn6cI1rmoR8w+7dx8F7iEXnOsR0N9WXxk/UYixtsUXfARXDYYQ27L2hMxXPbvD7lOXML
 VTxyg6HNLTp/TE6yLJXEULYdtvjQa4hTKqymoVcVq55x+AH5jKGmc33Xi/zMW/Bw/fvQ
 LGoom9G74gyFDeuOS+qPDVNJotjPQHTeDDJSXXRBt9yiv4CjVsemMYH9jx838dP7/RXZ
 pnzu9SqSbfHtBav6Z+8lp07K7Nk8BInUPwMlPWmPSTvM9vnjtafnwhwFLSsGswaSSXTQ
 3G+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709913018; x=1710517818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3cWuaoCkTQVu5qObgGDnDzWYB/sSDqmlrWjM/kbjq6Y=;
 b=e6gVKCzQKvhHVeCb2h1LO38deahQep27Dp0h/rdGCC6TewSgHjm3dw2+jzspyMSa6x
 KLCaIt8gQ+u0e1Dx5zb+0Ge+lIr1DSfDiFDzQ+KrIOfJvChb+xmXfWD1yXe35niV7qco
 WNhyDqHW5wf5Q3a0vuvfnH68za1DP8MEBLFBHUL2nEL98NdfaBwYsyTxsxiu9ll4CShM
 f9msaDwrZl+2a5lBjTnZh1SvcFmp2SZb3ghUmQPtAyxn/QoqULjnrvyFLj0CLpZ1WFnN
 uxBXq4/xhhyNQYxQeKNmeEzRdvuL7XDif4HnVl3+rAD3fxCwq+PBoS1GoiPTvvoy7kqJ
 8Kuw==
X-Gm-Message-State: AOJu0Yx65+x5jLVo/EEsgSv+y1OVz6JEKuYwRfC3yaRW82kq0nZYPZ0f
 kW1tRq7vkCEnNhuTn4mHLg8oHts1YUMiDllOcCjlYtZPutxhGYalKVI8K4abfKCBB8ESbKWnkyR
 W
X-Google-Smtp-Source: AGHT+IEThre7/6PEGkb+BnZZJGbX3DXc0UHAF1SshUWoxiOtXgbuiQjFKrsG5CFrQyHHoZGodqvZYQ==
X-Received: by 2002:a5d:6e48:0:b0:33d:7e99:babc with SMTP id
 j8-20020a5d6e48000000b0033d7e99babcmr14603150wrz.50.1709913018058; 
 Fri, 08 Mar 2024 07:50:18 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f2-20020adff8c2000000b0033e7a204dc7sm856080wrq.32.2024.03.08.07.50.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 07:50:17 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/14] target/arm: use FIELD macro for CNTHCTL bit definitions
Date: Fri,  8 Mar 2024 15:50:04 +0000
Message-Id: <20240308155015.3637663-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240308155015.3637663-1-peter.maydell@linaro.org>
References: <20240308155015.3637663-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

We prefer the FIELD macro over ad-hoc #defines for register bits;
switch CNTHCTL to that style before we add any more bits.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240301183219.2424889-4-peter.maydell@linaro.org
---
 target/arm/internals.h | 27 +++++++++++++++++++++++++--
 target/arm/helper.c    |  9 ++++-----
 2 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index d8622c8e0f1..dd3da211a3f 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -224,8 +224,31 @@ FIELD(VTCR, SL2, 33, 1)
 #define HSTR_TTEE (1 << 16)
 #define HSTR_TJDBX (1 << 17)
 
-#define CNTHCTL_CNTVMASK      (1 << 18)
-#define CNTHCTL_CNTPMASK      (1 << 19)
+/*
+ * Depending on the value of HCR_EL2.E2H, bits 0 and 1
+ * have different bit definitions, and EL1PCTEN might be
+ * bit 0 or bit 10. We use _E2H1 and _E2H0 suffixes to
+ * disambiguate if necessary.
+ */
+FIELD(CNTHCTL, EL0PCTEN_E2H1, 0, 1)
+FIELD(CNTHCTL, EL0VCTEN_E2H1, 1, 1)
+FIELD(CNTHCTL, EL1PCTEN_E2H0, 0, 1)
+FIELD(CNTHCTL, EL1PCEN_E2H0, 1, 1)
+FIELD(CNTHCTL, EVNTEN, 2, 1)
+FIELD(CNTHCTL, EVNTDIR, 3, 1)
+FIELD(CNTHCTL, EVNTI, 4, 4)
+FIELD(CNTHCTL, EL0VTEN, 8, 1)
+FIELD(CNTHCTL, EL0PTEN, 9, 1)
+FIELD(CNTHCTL, EL1PCTEN_E2H1, 10, 1)
+FIELD(CNTHCTL, EL1PTEN, 11, 1)
+FIELD(CNTHCTL, ECV, 12, 1)
+FIELD(CNTHCTL, EL1TVT, 13, 1)
+FIELD(CNTHCTL, EL1TVCT, 14, 1)
+FIELD(CNTHCTL, EL1NVPCT, 15, 1)
+FIELD(CNTHCTL, EL1NVVCT, 16, 1)
+FIELD(CNTHCTL, EVNTIS, 17, 1)
+FIELD(CNTHCTL, CNTVMASK, 18, 1)
+FIELD(CNTHCTL, CNTPMASK, 19, 1)
 
 /* We use a few fake FSR values for internal purposes in M profile.
  * M profile cores don't have A/R format FSRs, but currently our
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 978df6f2823..1c82d12a883 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2652,8 +2652,8 @@ static void gt_update_irq(ARMCPU *cpu, int timeridx)
      * It is RES0 in Secure and NonSecure state.
      */
     if ((ss == ARMSS_Root || ss == ARMSS_Realm) &&
-        ((timeridx == GTIMER_VIRT && (cnthctl & CNTHCTL_CNTVMASK)) ||
-         (timeridx == GTIMER_PHYS && (cnthctl & CNTHCTL_CNTPMASK)))) {
+        ((timeridx == GTIMER_VIRT && (cnthctl & R_CNTHCTL_CNTVMASK_MASK)) ||
+         (timeridx == GTIMER_PHYS && (cnthctl & R_CNTHCTL_CNTPMASK_MASK)))) {
         irqstate = 0;
     }
 
@@ -2968,12 +2968,11 @@ static void gt_cnthctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     ARMCPU *cpu = env_archcpu(env);
     uint32_t oldval = env->cp15.cnthctl_el2;
-
     raw_write(env, ri, value);
 
-    if ((oldval ^ value) & CNTHCTL_CNTVMASK) {
+    if ((oldval ^ value) & R_CNTHCTL_CNTVMASK_MASK) {
         gt_update_irq(cpu, GTIMER_VIRT);
-    } else if ((oldval ^ value) & CNTHCTL_CNTPMASK) {
+    } else if ((oldval ^ value) & R_CNTHCTL_CNTPMASK_MASK) {
         gt_update_irq(cpu, GTIMER_PHYS);
     }
 }
-- 
2.34.1


