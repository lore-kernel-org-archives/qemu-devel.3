Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 578F0CD98DE
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 10:52:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ4uj-0000X0-0C; Mon, 15 Jun 2026 06:51:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZ4tv-0000Qv-Jc
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 06:50:48 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZ4to-0001Sr-Jb
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 06:50:41 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-45ef56d9b67so2694431f8f.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 03:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781520635; x=1782125435; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=34QQgWxmqNmOcMc6dpEoeumYGJN8pWfi/blQdAPFyZI=;
 b=sThEwBPYOyUAd0kFI5dErVJFaei5O7PWTfBBlzpp2i58MVCoqobaA2MmxpIoLtVcSk
 H/+IvzyvHRcTfHeGBXY6dzhGVY3T3HhawgmNvLXD96EWMs0T4WksBRr6vUpvLYKTqC/y
 UWuUhsgWXgRTkQalQmP5BBklPfR6l3GDZlIGPDCXHicwBK7CG1EfbOd0Gqwgq303rBue
 yQGihHa0+I/6kTgmiFROc008+1qqG4CxaXiBPJfSFaY/a3sUR+4VVgKJtcHrH41CwiXD
 ryDVMp0qEso0kEGoj+kUzU+TUvnxeL0sPwWvY35lM6fA7f/Y7BxwDpcbtMcUNNvMOVug
 T1Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781520635; x=1782125435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=34QQgWxmqNmOcMc6dpEoeumYGJN8pWfi/blQdAPFyZI=;
 b=I7NtR7VqRrnxkCc+ZG3bNYrXoL4EYM1obiu+EFwDP5P4Ixs7deo/3fFN2PgoyB2Yp1
 kdUrJZlZVWd/Rp6Yz/3kg3WdK+9FPOwUvsjx08WUNaTMRqj2haCULjL5X22sMB4lR/qH
 6p0EyrnrgX4GrkhWscmoBC8bOuNw/blcsbdLV8KgE/b4HDzvJ5h200sAbUEiIqyHF2Mb
 BuJ9YXS4LvBJl0NCzoy50V3N9CZ7ZXfLH9bDM18x57/DSLTELqbL9q5GbC4QaKce5s8o
 krDY7LY5KMhKUyE5pPLYCpUu7kfEQz+QZFl0XD59fsFvCnQE2PaSKEy4Y4ZwIcKhQhJa
 5AUw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9O3gNEIlVkGLJMFEXp43MWi42LQBqm/TGVpMqmEaJADRMhQCg+cM12dE6qwvxbnpgRZRwMaeCVATCe@nongnu.org
X-Gm-Message-State: AOJu0Yyq7E3WOa6H+1p5tASKP01VObc7AmFfF4kwfvtjWTuI++gnyhGq
 9Iu9pHZWAeFLVHLiFHSKpk73+EULl1FGPM4GKD/qFzp1kZE0YykQiUPiPw7tKCDoOO0=
X-Gm-Gg: Acq92OE/kUF26Abbmtjl064xnnEarV3fcyhzgstuXSodqCDTl0mqXEwMhCL7moSWh1d
 v5UnTLhfBMHitoLGX4xP5ErG+VotM+9085/SZx9zWXhDSpBarv8Va8L+XQWyDJjfVOyAvVeV1fG
 2orZ/NqfunUJKaG9oN5lNrSP1QDt8Uri8XClrLbUH0l7t/OHk6gsJLmxr9dva7RECzk7pPRPBvQ
 FQzrmCrGI7x6b04sLCfhsWFapc6yFPeUhesnVXSJAtceVW0KKUL7aoD8d2a7rp5s1qr+BMf9Y5m
 awHyZXJeDAnWw5AuTE3s0/XEg7Jq3DyeTgYGY77ueoWh+ukOBEoPvaXoOVoLxpDGxDZyTuZL0Dx
 Dln06M7gufx5BjZBo2f3ZjOVyTrT6qG2h+qOF38tvcC+zPEOM70bkY4Cf46SjlypYoXcbYhPEs6
 96PGCAul2g6QednRnibMJt+RfAXELrBoFnjMl4S2Q0668SrZfp/Wb8sdMiQo73kYrElkiTFTMLg
 wlL5kN7S5qqMPro9M+x349Kt6CllbeZ
X-Received: by 2002:a5d:59aa:0:b0:45e:f2e1:9a20 with SMTP id
 ffacd0b85a97d-46077f2b060mr13330685f8f.27.1781520634775; 
 Mon, 15 Jun 2026 03:50:34 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f263945sm33863674f8f.8.2026.06.15.03.50.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 03:50:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 4/5] target/arm: GICv5 cpuif: Remove ICC_HAPR_EL1
Date: Mon, 15 Jun 2026 11:50:28 +0100
Message-ID: <20260615105029.2898872-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615105029.2898872-1-peter.maydell@linaro.org>
References: <20260615105029.2898872-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

The ICC_HAPR_EL1 register reported the current running priority of
the CPU. However this can be easily calculated by reading the
APR register, so it has been removed in the newly released A.a
version of the GICv5 spec (IHI 111701).

Remove QEMU's implementation of this register. (This is OK for
us to do without warning because our GICv5 support is listed
as "experimental"; we anticipated that this kind of spec change
might happen.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/gicv5-cpuif.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index 1aa4bde799..a868adca66 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -511,15 +511,6 @@ static void gic_icc_apr_el1_reset(CPUARMState *env, const ARMCPRegInfo *ri)
     }
 }
 
-static uint64_t gic_icc_hapr_el1_read(CPUARMState *env, const ARMCPRegInfo *ri)
-{
-    /*
-     * ICC_HAPR_EL1 reports the current running priority, which can be
-     * calculated from the APR register.
-     */
-    return gic_running_prio(env, gicv5_current_phys_domain(env));
-}
-
 /* ICC_CR0_EL1 is also banked */
 static uint64_t gic_icc_cr0_el1_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
@@ -928,11 +919,6 @@ static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
         .writefn = gic_icc_pcr_el1_write,
         .resetfn = gic_icc_pcr_el1_reset,
     },
-    {   .name = "ICC_HAPR_EL1", .state = ARM_CP_STATE_AA64,
-        .opc0 = 3, .opc1 = 1, .crn = 12, .crm = 0, .opc2 = 3,
-        .access = PL1_R, .type = ARM_CP_IO | ARM_CP_NO_RAW,
-        .readfn = gic_icc_hapr_el1_read, .raw_writefn = arm_cp_write_ignore,
-    },
 };
 
 void define_gicv5_cpuif_regs(ARMCPU *cpu)
-- 
2.43.0


