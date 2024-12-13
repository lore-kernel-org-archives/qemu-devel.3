Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CAF8E77180
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:39:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9aT-0000tZ-A0; Fri, 13 Dec 2024 12:36:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9YD-0000Ri-Ky
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:34:06 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9YB-0001nR-4F
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:34:05 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43628e97467so13716405e9.3
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111241; x=1734716041; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=N0xxKJ/gejC1AsfVGkch3u9PAoevYxIM+im6oAvRmIA=;
 b=w6UWYQ8cbjdt8AZjs36u0ytJCgLbS+k/czPlRh81A2IlXde8wiWw7oXpU7WanvljSL
 ePYD5Asu0Gq3NjRE0V2YwwQ7UBYxX5ch5P0yIx+VxHn1IEV1PH7Ft67g/LsN/PAUU5Lg
 XrdhjPhiKdaoZHOWca2F4qtcPQfagB2PzEREMTRIbizEw4hzvCjf+DkvuE3E+7QLoee6
 V9k2WG/Femzb4XgX39i3ILZft/3IpxwLUz9qgCPn0m/Tb50KRh5dICZOTbBdsDj3oc3/
 Mm7JuVcU7cpfcQtMJKMuv6Q5SHHVkpSlR/eLwr5mF2tFt1mqkMzAjwQHM3zRgZmF6IEA
 CdTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111241; x=1734716041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N0xxKJ/gejC1AsfVGkch3u9PAoevYxIM+im6oAvRmIA=;
 b=OjHqxeeBIysbZrEB4OEzuZRmgjljy2RDm3QctugO4qArTJr071aInxABkhrN6X4V0H
 j6umXDJ86jY6rQa0f5EFon40No0E+kddEgQwKmK11YjevrPb2iekl6ZbkdhvVmxlAJhZ
 uqyuC/kIj61LUSFd+FaQfPeP9C35PmKImk+Wv4Yo7q2UrtCmqWz8bRYCsZGVCo7zBy7C
 LWDR54/4RZ2xmksOY6bqZKR5sHCr8jYS8H5gsDm1U2OyrAYcocWsXkkkuVAySFQGKkZq
 dMLdpEOgiemfNWmIu1zVhPGTjybq/+Sx3+c1cnnIkHuQli49Ax6Sq/b4OKv6+sAaj2Ui
 24SQ==
X-Gm-Message-State: AOJu0YxmTx8kKaJnp3PMDtapWozX9D9iArS8O4+Gm/AcgabUY5zwmARo
 OJc1Tq3GaqoJe2YR+3Aw89G376zKBatFZc84BuzFTQQzGM27l7uIVky2wr1//wQeweX9lxMhDZw
 n
X-Gm-Gg: ASbGncud0QgqfltyeTpKnP3axJC/u85sJzAaKsLymbMbHo250HiYG1rwovmr5NMWm6T
 IOm5omieGws2a2U2+2opZQ2JyEoM0LGOkcQPW+Pb6crrJcycHrp0ko/cVWznljGXPd1vFFYEth5
 dVEnpLr692b1bPVbMYCCeP/+RUceJ76GGmNbiyfP0L7nanKk70yNHY65kVbsTTph6WXu8mAX/fb
 dgeCDaWDLL/PxYUEGPlWTGlqKk06vxTDBtJU3EmqTuGGmhR1jfqX3Qgm2tF5g==
X-Google-Smtp-Source: AGHT+IEhAyhFV3JQTB/a4H9VoduDwFoFFPAmVF8tGuOlu7hwq4LLg1l3qFiU1ut00icoLo3gvl4dHw==
X-Received: by 2002:a05:6000:4025:b0:385:e034:8d47 with SMTP id
 ffacd0b85a97d-3888e0b98f6mr2990104f8f.46.1734111241633; 
 Fri, 13 Dec 2024 09:34:01 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.34.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:34:00 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 85/85] target/arm: Simplify condition for tlbi_el2_cp_reginfo[]
Date: Fri, 13 Dec 2024 17:32:29 +0000
Message-Id: <20241213173229.3308926-86-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

We currently register the tlbi_el2_cp_reginfo[] TLBI insns if EL2 is
implemented, or if EL3 and v8 is implemented.  This is a copy of the
logic used for el2_cp_reginfo[], but for the specific case of the
TLBI insns we can simplify it.  This is because we do not need the
"if EL2 does not exist but EL3 does then EL2 registers should exist
and be RAZ/WI" handling here: all our cpregs are for instructions,
which UNDEF when EL3 exists and EL2 does not.

Simplify the condition down to just "if EL2 exists".
This is not a behaviour change because:
 * for AArch64 insns we marked them with ARM_CP_EL3_NO_EL2_UNDEF,
   which meant that define_arm_cp_regs() would ignore them if
   EL2 wasn't present
 * for AArch32 insns, the .access = PL2_W meant that if EL2
   was not present the only way to get at them was from AArch32
   EL3; but we have no CPUs which have ARM_FEATURE_V8 but
   start in AArch32

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241210160452.2427965-11-peter.maydell@linaro.org
---
 target/arm/tcg/tlb-insns.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/arm/tcg/tlb-insns.c b/target/arm/tcg/tlb-insns.c
index d20d32624da..0f67294edc4 100644
--- a/target/arm/tcg/tlb-insns.c
+++ b/target/arm/tcg/tlb-insns.c
@@ -1246,9 +1246,7 @@ void define_tlb_insn_regs(ARMCPU *cpu)
      * ops (i.e. matching the condition for el2_cp_reginfo[] in
      * helper.c), but we will be able to simplify this later.
      */
-    if (arm_feature(env, ARM_FEATURE_EL2)
-        || (arm_feature(env, ARM_FEATURE_EL3)
-            && arm_feature(env, ARM_FEATURE_V8))) {
+    if (arm_feature(env, ARM_FEATURE_EL2)) {
         define_arm_cp_regs(cpu, tlbi_el2_cp_reginfo);
     }
     if (arm_feature(env, ARM_FEATURE_EL3)) {
-- 
2.34.1


