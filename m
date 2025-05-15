Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC28FC2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 10:36:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFVpK-0000s3-W7; Thu, 15 May 2025 06:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVnT-0005HV-CR
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:44 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVnL-0008D7-Jq
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:35 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-442e9c00bf4so5681825e9.3
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 03:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747304789; x=1747909589; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8OqIAv12cBzD5xPq0tKwoeVHDMUht+s84ge6JHo6zJM=;
 b=GQLXccCASQTBXz1236JTe38t4uPAcTU4hz3vnLZEWm5tbYDJaEzxstoS9v1CPl2M/h
 tIQ4wtHLAHkzPfZvVBn/rDAJAiJSUP//0gUidC/MzUM36SgFwwDlWZa3J4VMnW79RBCw
 GQR0c3T8vWR8o6DiPFAgyefUvlQ3nn0DwJyaxz+kCh+sd2vrGbgNGJyig4SPBp2YaLBc
 5Pwf4JF/IPSAZ5RxndL0LwK7NyWE9DaVflVFmsO9vkrK8mgN12bSwqMuXfI7LXXgp0q6
 0Bv7PNFBD9XHKITHDzWsrh+0nkRaoAnuObBhee9YMUa47X0ehOKzgEl//+4IitR+VhI5
 Leag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747304789; x=1747909589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8OqIAv12cBzD5xPq0tKwoeVHDMUht+s84ge6JHo6zJM=;
 b=gEM9OOFKaQgCWlJGZK1PxzPGkGtiUDo/BNry8RK6kjEVao1LPPCzpyvWiVqN5soCgK
 Vjx1HCDk5FIBM7Kvnx2YqCcLtj1VEBW9RBQuHOEh9Oi8jqukR2c5jIYhcIHdA/V8kPCr
 tu+oxXGekm8fwSUokTvVuhVFPbOOa6ej4QgnF080bD7pAR3JbR1XQIY2Yi7poamZ92IG
 mweOoV6bZ1YNHs7xPqXNSnBAgFJM7VbTTf7NeplTzMTK88YHCSvJCMYM3LGDoVX424tk
 Z7mNIUMM51mmiF7t3put2MfV7ft+5DVdjxe+ECZTnI6XtbnBgsSxhw9LoU3o5LnA5Swx
 cscA==
X-Gm-Message-State: AOJu0YwRUrHg+nIQprWfv/QZAxuoWiwPyZd5z5EDQCJZNBim+SqxH4HI
 rPFp8q8UBBOYsre83ESSGRQ2gSPx+aUj+MuD5R4EjOw5DmKomxxC8xUht2IhtCoYBENljp3v7m4
 pYOU=
X-Gm-Gg: ASbGnctezxD1A8Qh01ZDu9cU1KUUEQVCNyNCfStSDmZUgcGwnjX91FaPP01AFonWdKJ
 Sj/EwgykoLjelitwt95khlKp7XK3CJZThDXfQw39WKwjqo3H+oOBbSzULcwh9OUhkRGNiE+j2HQ
 kqrdvAupZ7rR3Xl09FohLeiP4iacFjl5QHLi01nGKBEfDLwtsNwqwcnb934anjhpxlyjrlP9qLg
 M7pGHMEla0YSYIgJ2rIX3T93EPq+FieRsf85Ft2D2AZKMoUEk+9yX7/vjd3EYqMRilY70k1WxfD
 Za4WPBjmZxxJXIyKFAMFmoqqhc8AjLv1W1vkoDbmSwrPtJpwcOe+t+9/EA==
X-Google-Smtp-Source: AGHT+IGniFgyKidmYnMdPWLKyU6MMEEXV1x0pcGRwM/vqXcAPbhh1jW17tzUbKFT2tz+rx88DepEpw==
X-Received: by 2002:a05:600c:3f08:b0:43c:fd27:a216 with SMTP id
 5b1f17b1804b1-442f970b20dmr15728895e9.23.1747304788800; 
 Thu, 15 May 2025 03:26:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f396c3a4sm65657855e9.26.2025.05.15.03.26.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 03:26:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/58] target/arm/helper: expose aarch64 cpu registration
Date: Thu, 15 May 2025 11:25:19 +0100
Message-ID: <20250515102546.2149601-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515102546.2149601-1-peter.maydell@linaro.org>
References: <20250515102546.2149601-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

associated define_arm_cp_regs are guarded by
"cpu_isar_feature(aa64_*)", so it's safe to expose that code for arm
target (32 bit).

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20250512180502.2395029-22-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index d2607107eb9..92a975bbf78 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6590,7 +6590,6 @@ static const ARMCPRegInfo zcr_reginfo[] = {
       .writefn = zcr_write, .raw_writefn = raw_write },
 };
 
-#ifdef TARGET_AARCH64
 static CPAccessResult access_tpidr2(CPUARMState *env, const ARMCPRegInfo *ri,
                                     bool isread)
 {
@@ -6824,7 +6823,6 @@ static const ARMCPRegInfo nmi_reginfo[] = {
       .writefn = aa64_allint_write, .readfn = aa64_allint_read,
       .resetfn = arm_cp_reset_ignore },
 };
-#endif /* TARGET_AARCH64 */
 
 static void define_pmu_regs(ARMCPU *cpu)
 {
@@ -7016,7 +7014,6 @@ static const ARMCPRegInfo lor_reginfo[] = {
       .type = ARM_CP_CONST, .resetvalue = 0 },
 };
 
-#ifdef TARGET_AARCH64
 static CPAccessResult access_pauth(CPUARMState *env, const ARMCPRegInfo *ri,
                                    bool isread)
 {
@@ -7509,8 +7506,6 @@ static const ARMCPRegInfo nv2_reginfo[] = {
       .fieldoffset = offsetof(CPUARMState, cp15.vncr_el2) },
 };
 
-#endif /* TARGET_AARCH64 */
-
 static CPAccessResult access_predinv(CPUARMState *env, const ARMCPRegInfo *ri,
                                      bool isread)
 {
@@ -8951,7 +8946,6 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         define_one_arm_cp_reg(cpu, &hcrx_el2_reginfo);
     }
 
-#ifdef TARGET_AARCH64
     if (cpu_isar_feature(aa64_sme, cpu)) {
         define_arm_cp_regs(cpu, sme_reginfo);
     }
@@ -9012,7 +9006,6 @@ void register_cp_regs_for_features(ARMCPU *cpu)
     if (cpu_isar_feature(aa64_nmi, cpu)) {
         define_arm_cp_regs(cpu, nmi_reginfo);
     }
-#endif
 
     if (cpu_isar_feature(any_predinv, cpu)) {
         define_arm_cp_regs(cpu, predinv_reginfo);
-- 
2.43.0


