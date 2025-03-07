Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A80CAC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 15:09:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqZIQ-0000zD-B6; Fri, 07 Mar 2025 10:07:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqZIJ-0000vz-Se
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:07:23 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqZIH-0008Eq-U0
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:07:23 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-39104c1cbbdso1017073f8f.3
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 07:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741360040; x=1741964840; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=h3NyAbjZw6t/Yl0m428z8/u6iBTIpIakfmeyR5Ut3i0=;
 b=WWU9FYpnF5hYq4neITsbMjN4CgKlTHoE8Lf12EisDK96sFCj72Ei8Rv/lEfQTdPay6
 +7IqD6tiDKt37pmeVJuLilkUF3M2fnCDINPECBuCaB/+xbc5Ue/8k6hitqYIq4PfoSDc
 PLCBEIVEtmBV51U/JhdPOUWoTgS0cfWOn81VKHPYBy6vq2H3yx/z8mQ6Tc5XrE+uATw1
 dogsVm/PVYm6Di/78oa9iuv33ITbvHV5tptcxaOEmSGyV1C/80rHUj8kCOr3VyjnT/vS
 nBwPTE9iNCBsatMQYLVcCynvvDIm++bkOcR21cynbStdn1NyZw3OeZQZ5k91Mnm7r6/p
 wKyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741360040; x=1741964840;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h3NyAbjZw6t/Yl0m428z8/u6iBTIpIakfmeyR5Ut3i0=;
 b=eIkIsLK1IRIAtno01Zu7w4DVnh3U1GS2M18Ljs+G342v57OEwvgCuJuVG1Iv+ccUk2
 +/ZxdIuMm8NO9xjsn062H0zC+nqiTetvuj8jvlJGQLeF+4QA+hEw+0RE1QNdHbw1E1dU
 9Jy6/WKCpfcG0+zCoqnc1lyoifoLX4J1H+5APdtMPntvUPCcBJWbQz+GB0V3hSXjo3fL
 jzotq18aoPihBbsy1r6PWnsMJYK8EIWUhtFovMLcfS324Bn7CuIFrDX8ZS0CGMWHdk1M
 mHUUTvUTEJIuT0gWsxRbsbf7e7SLvkMhk7voJtAXiT6KJjsC9rg+bUH1KmVg5CGtqJKz
 FwoA==
X-Gm-Message-State: AOJu0YxMBbxzB28TtWKvcbiHagPwXErvFoC30daI+vz6vwLoaXO6hp3d
 5kKcqFW79ejLUZ855PKBf9KmcY0gJZ6mpQedBat5CntafQF4atpVvCUgDAeOvs7HxtQs/wrVpsj
 D
X-Gm-Gg: ASbGncvg/8Ry150mdlrz9Z+sdzsFlLEiwUZU6rhBhaOqzfUYSMv/WVYTkJAR/GQore+
 +UJGVlh6RMx6islfnIYF27SmkLYvsIZHMqaLGff3L60ummr6EnKRpzkCPSKt0nGMGq66uiWUIPA
 iaySkkXllxGf8/lrfxcajgNXn7xMcBk/DlttW1sn2YLY02WVA9Zdk/o49dLDY4UFEJ1DE+UHLN+
 zNjcgv2TyRBuSgri/k6XdT8ZQPCaBnrrFjLn5eUn6+V+9FXytMAXYb28OO8es5Ku6OnF5hvoaJO
 pBYxEDMO6f76S7Hj1CQkVvr3Gw14B1OsTkGb3l+Si3zXtJClEwk=
X-Google-Smtp-Source: AGHT+IHx8zcV23/JTtMmIX/iHaZwae/xzp6R1AOsV8+6/viS4gfX+ocvXdlZIi5HR/M/zfqAifL5fQ==
X-Received: by 2002:a5d:47cc:0:b0:391:13ef:1b1b with SMTP id
 ffacd0b85a97d-39132d9a285mr2257111f8f.30.1741360040076; 
 Fri, 07 Mar 2025 07:07:20 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c1031fdsm5443627f8f.89.2025.03.07.07.07.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 07:07:19 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/21] target/arm: Always apply CNTVOFF_EL2 for CNTV_TVAL_EL02
 accesses
Date: Fri,  7 Mar 2025 15:06:54 +0000
Message-ID: <20250307150708.3222813-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307150708.3222813-1-peter.maydell@linaro.org>
References: <20250307150708.3222813-1-peter.maydell@linaro.org>
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

Currently we handle CNTV_TVAL_EL02 by calling gt_tval_read() for the
EL1 virt timer.  This is almost correct, but the underlying
CNTV_TVAL_EL0 register behaves slightly differently.  CNTV_TVAL_EL02
always applies the CNTVOFF_EL2 offset; CNTV_TVAL_EL0 doesn't do so if
we're at EL2 and HCR_EL2.E2H is 1.

We were getting this wrong, because we ended up in
gt_virt_cnt_offset() and did the E2H check.

Factor out the tval read/write calculation from the selection of the
offset, so that we can special case gt_virt_tval_read() and
gt_virt_tval_write() to unconditionally pass CNTVOFF_EL2.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20250204125009.2281315-5-peter.maydell@linaro.org
---
 target/arm/helper.c | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 5b6de446ace..acf77793c79 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2600,6 +2600,12 @@ static void gt_cval_write(CPUARMState *env, const ARMCPRegInfo *ri,
     gt_recalc_timer(env_archcpu(env), timeridx);
 }
 
+static uint64_t do_tval_read(CPUARMState *env, int timeridx, uint64_t offset)
+{
+    return (uint32_t)(env->cp15.c14_timer[timeridx].cval -
+                      (gt_get_countervalue(env) - offset));
+}
+
 static uint64_t gt_tval_read(CPUARMState *env, const ARMCPRegInfo *ri,
                              int timeridx)
 {
@@ -2614,8 +2620,16 @@ static uint64_t gt_tval_read(CPUARMState *env, const ARMCPRegInfo *ri,
         break;
     }
 
-    return (uint32_t)(env->cp15.c14_timer[timeridx].cval -
-                      (gt_get_countervalue(env) - offset));
+    return do_tval_read(env, timeridx, offset);
+}
+
+static void do_tval_write(CPUARMState *env, int timeridx, uint64_t value,
+                          uint64_t offset)
+{
+    trace_arm_gt_tval_write(timeridx, value);
+    env->cp15.c14_timer[timeridx].cval = gt_get_countervalue(env) - offset +
+                                         sextract64(value, 0, 32);
+    gt_recalc_timer(env_archcpu(env), timeridx);
 }
 
 static void gt_tval_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -2632,11 +2646,7 @@ static void gt_tval_write(CPUARMState *env, const ARMCPRegInfo *ri,
         offset = gt_phys_cnt_offset(env);
         break;
     }
-
-    trace_arm_gt_tval_write(timeridx, value);
-    env->cp15.c14_timer[timeridx].cval = gt_get_countervalue(env) - offset +
-                                         sextract64(value, 0, 32);
-    gt_recalc_timer(env_archcpu(env), timeridx);
+    do_tval_write(env, timeridx, value, offset);
 }
 
 static void gt_ctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -2768,13 +2778,21 @@ static void gt_virt_cval_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
 static uint64_t gt_virt_tval_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
-    return gt_tval_read(env, ri, GTIMER_VIRT);
+    /*
+     * This is CNTV_TVAL_EL02; unlike the underlying CNTV_TVAL_EL0
+     * we always apply CNTVOFF_EL2. Special case that here rather
+     * than going into the generic gt_tval_read() and then having
+     * to re-detect that it's this register.
+     * Note that the accessfn/perms mean we know we're at EL2 or EL3 here.
+     */
+    return do_tval_read(env, GTIMER_VIRT, env->cp15.cntvoff_el2);
 }
 
 static void gt_virt_tval_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                uint64_t value)
 {
-    gt_tval_write(env, ri, GTIMER_VIRT, value);
+    /* Similarly for writes to CNTV_TVAL_EL02 */
+    do_tval_write(env, GTIMER_VIRT, value, env->cp15.cntvoff_el2);
 }
 
 static void gt_virt_ctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
-- 
2.43.0


