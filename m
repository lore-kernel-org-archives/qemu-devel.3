Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8BFCC67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 15:24:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtqqn-0004p9-67; Mon, 08 Apr 2024 11:24:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rtqqd-0004os-Sw
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 11:23:52 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rtqqb-0005QL-Vp
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 11:23:51 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4168a5d75c4so5386015e9.0
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 08:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712589828; x=1713194628; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wg/VXaENoh/xfxcfdFul6goMk1e8WqSCaau2y85GsNA=;
 b=HbB5OpS4rZi82KetqCHc8xP1JFkLmZodT8oH+K/LTai3hRBUshriuceeZwqvD1PsyO
 X4XOStsfAF5gOJB6Jve+IYF5O9lWAHfIQAKbQ006nKH6sc3Lae2ooBjVSjx1onh5fgoG
 aQFvignH13MDMSKZsay9VLmKYrKoaZS2+sR3RwRMQcwVaZCIJ4VbS4zlrh0V6c1Kf18S
 SuqEEGIMoKF5kMturVWLI7wzRzWKRYV58PMBTM95H/MCasH7MzA61HyfnukkCcDf39Nq
 1aM8JsI1IQtMbN2u3jfPgblgnDi4ImllqUUKJHEvBSQgFbtu1Mw1nExocTcVJ03SHell
 2iJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712589828; x=1713194628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wg/VXaENoh/xfxcfdFul6goMk1e8WqSCaau2y85GsNA=;
 b=hhrUyYF3XmNM6Twof3pc1uy2QPxO8Q8s6N1VmbENG7Jf6iWpgrxRFe+P2RDZuvJLWP
 Y87NiVqmdbsd8W55fLfBXIqPtTkAhAE1x5QDmljmDJzZwNRKS7j6H0LiVZN3KJ1B/pvi
 cHaZ1BslbWS/AZuk++EAsJ+w6HYm9vIHpdlsFlxTNxQQDJdCLd6qABDWUAMXExoa3zXm
 E/NuSgRXJ5khvMJwl6dRbW2b+NgFdVKUzHGJa80oUBrHFEEXGTfK/Qu7JMdWla0IRFm1
 dRNOn41CKtTX0n/YSYY3fmhdGr85sPQ+Czx7KNAXxF78aaUs7IWmUVd26SsKpVT+pQRK
 KQDQ==
X-Gm-Message-State: AOJu0Yw8R8eSEy2mfbeQMNXhQCwSCbGgHsrGSKCmBFZPpyUdnCGGbePR
 LrZR85XBzpRFKkEsthX1G6VT3KiSftWHff7/EsBds539leJjw+2Pyc5Fwd3gSrvrB8o+IJSmLcj
 p
X-Google-Smtp-Source: AGHT+IEFduUKcuCiMpKboYo+K/H6Bd/8ibb3Ycway3X3s9vlEewxM9X2hv1soh2HBKhhAfNz/ycK6w==
X-Received: by 2002:a05:600c:4451:b0:416:2441:eac6 with SMTP id
 v17-20020a05600c445100b004162441eac6mr8552268wmn.0.1712589828008; 
 Mon, 08 Apr 2024 08:23:48 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 je6-20020a05600c1f8600b0041496734318sm17298667wmb.24.2024.04.08.08.23.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 08:23:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 1/2] target/arm: Fix CNTPOFF_EL2 trap to missing EL3
Date: Mon,  8 Apr 2024 16:23:45 +0100
Message-Id: <20240408152346.3937318-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408152346.3937318-1-peter.maydell@linaro.org>
References: <20240408152346.3937318-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

From: Pierre-Clément Tosi <ptosi@google.com>

EL2 accesses to CNTPOFF_EL2 should only ever trap to EL3 if EL3 is
present, as described by the reference manual (for MRS):

  /* ... */
  elsif PSTATE.EL == EL2 then
      if Halted() && HaveEL(EL3) && /*...*/ then
          UNDEFINED;
      elsif HaveEL(EL3) && SCR_EL3.ECVEn == '0' then
          /* ... */
      else
          X[t, 64] = CNTPOFF_EL2;

However, the existing implementation of gt_cntpoff_access() always
returns CP_ACCESS_TRAP_EL3 for EL2 accesses with SCR_EL3.ECVEn unset. In
pseudo-code terminology, this corresponds to assuming that HaveEL(EL3)
is always true, which is wrong. As a result, QEMU panics in
access_check_cp_reg() when started without EL3 and running EL2 code
accessing the register (e.g. any recent KVM booting a guest).

Therefore, add the HaveEL(EL3) check to gt_cntpoff_access().

Fixes: 2808d3b38a52 ("target/arm: Implement FEAT_ECV CNTPOFF_EL2 handling")
Signed-off-by: Pierre-Clément Tosi <ptosi@google.com>
Message-id: m3al6amhdkmsiy2f62w72ufth6dzn45xg5cz6xljceyibphnf4@ezmmpwk4tnhl
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 3f3a5b55d4a..13ad90cac1e 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3452,7 +3452,8 @@ static CPAccessResult gt_cntpoff_access(CPUARMState *env,
                                         const ARMCPRegInfo *ri,
                                         bool isread)
 {
-    if (arm_current_el(env) == 2 && !(env->cp15.scr_el3 & SCR_ECVEN)) {
+    if (arm_current_el(env) == 2 && arm_feature(env, ARM_FEATURE_EL3) &&
+        !(env->cp15.scr_el3 & SCR_ECVEN)) {
         return CP_ACCESS_TRAP_EL3;
     }
     return CP_ACCESS_OK;
-- 
2.34.1


