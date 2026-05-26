Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90166CD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:33:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsme-0000eS-JR; Tue, 26 May 2026 10:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmQ-0008N8-0n
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:14 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmN-0001Fj-V3
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:13 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-44a5174670eso5999023f8f.1
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779805750; x=1780410550; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8CL3ZuYZWbB37FI6q1udXhlxyZV70/cjFqaSmbtR4ik=;
 b=uWf2rhkjC/km1OI3Jty72lZg4Jz0msCix+ZY/T+n4Qi+qNeGDG3d8S/GOQRIZEgkDy
 icJfJTLfp82P4osdxt/bfmsGBoA3p8UYd5R0AgMMhUIwY1EWzi0jyjJkyibyQewWRFur
 1/fXu1ILHbkubl6515XQvwNRanILkrX2HeVQqrJMt82oa/gzlCOeLuK5l5CSHmmXuMIh
 S/GugmL4MU+GoOKw5oyQMr8rehffJZ1ZwGnv7u65AaJ8sCwWGUo0CPMYsHsUgleWW55c
 gXhT6o9cHI9Ggr5qIqWn7Q2BZcy0hTui+NucA0TL8LcwYJzSd48FLjs9/iH99lpjDyfm
 IHRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779805750; x=1780410550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8CL3ZuYZWbB37FI6q1udXhlxyZV70/cjFqaSmbtR4ik=;
 b=bxuKn0W67f/RouKxFxR1OO5QoK5f5rf7fT/IlNSGZG1zyh5QlhaftDiwGo6uJ+WiXE
 oxOyLbfhYnNlSKGpo/7rA8ZYHgQ81zeN3ndtUf1fVrx2kCniKvPilsEu3eDcXOezpFTk
 AAB9WufEl7GpPNPPLr0Ona3/s1bqODTWqvuJiDxDRPzIFiHF8mg1Clb9T1fI776wHpg7
 EcJ+7DNFwDjDfmFGymGfCHel/r13v5nzGKepIXt9GaLHSECqJduwxb0ZQEiUWmX5l2Fc
 Ivsr2SoSeYnS8iCjTt5u8K/yCzP0SanJlwMVDjTwoKJdZHkkhy4C0WNv77VblRGFenTL
 7fKQ==
X-Gm-Message-State: AOJu0YwAwgSBcMPkpc0g78XhTpnekWRdJhmAYW6TzoGScYEliJEbAkLo
 mqRAf/+zCpU61Tdjyig7+nSB2ISidgVXyi6Q2c9NKDz1Olb0gGeSkZX/gFija/1IEtrFRBAVf8z
 YRhxg
X-Gm-Gg: Acq92OHT8PGEI1WLgIZxHKajVz6SGQrtjA8J1EF0hYGHjOw6LsQ3c5kcr7ZqtayIvRj
 bkgYOvT6qdgEzgglAfOAR0zB8J3QKExq8Xfq4TNQk0kuq7PQt5lkh7vt4XQcKFV22nfraksAVxX
 JJNmKLt1sAZ5DxqabARV2ANRAQtG02QlG2Hs6yO8pPD57D7q5LsbRbdHxGqE/60dhpl/N4CNtLg
 J4WjSBqJPrH0aW74NAGTHwedEsu/TYQEtuijeShUOwcFMbhXggfekp6V325lAaPNQ1bbFWCz09/
 8042VSbe/THm4uAv6Mbn4/5x2aOcMWQz3Lrz+vFemV97txBRPkhWytr1vqSt8lCFfS0eeoSLOU6
 CzQIMzmLNcDFsJBg/O+udVHMeL0xyABZ7MSCardbx3Q0w4/+LWBmHOySXMPgvRaqw2k5Ut5ppqN
 axSKY+Rzl75HSmoI3p18hZTi4hDKGbGEWMj5kORDQBus3sLVyA7rbQGhsAmO02fh2RW9K6batT+
 zRCj985tUdcwU7eLYdOA9b/jPuPhbs=
X-Received: by 2002:a5d:5f41:0:b0:43d:7783:c684 with SMTP id
 ffacd0b85a97d-45eb38bc877mr33018175f8f.43.1779805750414; 
 Tue, 26 May 2026 07:29:10 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d70c51sm38325225f8f.36.2026.05.26.07.29.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:29:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/54] target/arm/ptw: Flip sense of get_phys_addr_pmsav7
 return value
Date: Tue, 26 May 2026 15:28:15 +0100
Message-ID: <20260526142850.2326589-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526142850.2326589-1-peter.maydell@linaro.org>
References: <20260526142850.2326589-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260515142541.571911-7-peter.maydell@linaro.org
---
 target/arm/ptw.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 94403e317e..5777747a98 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -2732,7 +2732,7 @@ static bool get_phys_addr_pmsav7(CPUARMState *env,
             if (!pmsav7_use_background_region(cpu, mmu_idx, secure, is_user)) {
                 /* background fault */
                 fi->type = ARMFault_Background;
-                return true;
+                return false;
             }
             get_phys_addr_pmsav7_default(env, mmu_idx, address,
                                          &result->f.prot);
@@ -2806,7 +2806,7 @@ static bool get_phys_addr_pmsav7(CPUARMState *env,
 
     fi->type = ARMFault_Permission;
     fi->level = 1;
-    return (ptw->in_prot_check & ~result->f.prot) != 0;
+    return (ptw->in_prot_check & ~result->f.prot) == 0;
 }
 
 static uint32_t *regime_rbar(CPUARMState *env, ARMMMUIdx mmu_idx,
@@ -3759,7 +3759,7 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
                                        result, fi);
         } else if (arm_feature(env, ARM_FEATURE_V7)) {
             /* PMSAv7 */
-            ret = get_phys_addr_pmsav7(env, ptw, address, access_type,
+            ret = !get_phys_addr_pmsav7(env, ptw, address, access_type,
                                        result, fi);
         } else {
             /* Pre-v7 MPU */
-- 
2.43.0


