Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E13DAC982C5
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 17:09:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Wda-0005YG-Ve; Tue, 15 Sep 2026 13:08:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6WdW-0005WK-CX
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 13:08:02 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6WdU-0003YJ-Mk
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 13:08:02 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-495437bb891so8541415e9.1
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 10:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789492079; x=1790096879; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Oh+Toh4lHF11EH3kFWZXvIijcF+VH8V1fVA86Y8W9KI=;
 b=eND6UvLwLgF4f66EoOCnsu+qGZi2YBbOREXY8hRoZ03/L5IGZidDXi8xu3epCktDTB
 Ag/biOELvhNV93hW8F6CmyeEddyxzvAu0pw+jjJg+IIJ4LHkJWUbAI+XSJqxVy6gbpcc
 CWtnc3634sA9KHpoMM/QZ1pu3tbL+lD90MxzCLHdGRRIJ+R30PZojMpbPYoH0gMowTNm
 9cWXNtbFLQf23E7jcYgXCdaDUIQYr81R/jT1YMNYoi3muHLygsSN+K1z8zomiLcSHICJ
 LtUwwZD/uygEBDEQ32V1SqzHHCYFgudrb5s1wmtuyEY+N+YiPKMPA7CLG0rxfiuFMXsj
 oyaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789492079; x=1790096879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Oh+Toh4lHF11EH3kFWZXvIijcF+VH8V1fVA86Y8W9KI=;
 b=zDFZtn08PENq8tNCb8+nVJ2Zu9oWR1/oaR1olGWjhsBJ5ZepmplHCmkoz3WEyJ1xx9
 IS4ok5UKJIjRxh0TVy+SKZslGmpNFkF4Iwlmoxax32hcYw9WCpltJCuYxNmAew254uq/
 GqMudbn1W/+MAvo+Z9MmjWDP4x29SA4dj1qSDkPgDmp7dzbU7GQTqE0+Viqtm/uW9EVN
 se2QHGWlCFpYSfGwrh77wzMafU/KB3gxlifuZfuMwt6aIorrrt+VNMXjMm5Kik7JeqP3
 9FAzOgh5KIzc+AOVUR0LiO2SZwztGyqU2ExxULEY5Uqy4hhMN8VS9UPJ70Q5so7n1qED
 xAFA==
X-Gm-Message-State: AFuF++k08Df7YuodfvolbY4SFxA/NGcQvFv+X7E5gP2giBaPdRY9HX8J
 aJklaJhuUZ2FsxptLP2pWnV4qi+ZStE6oMydeZ5n70WNKCC6U91mLMfOEbMGqbBpUAYI5mY1HCD
 BusOoMVU=
X-Gm-Gg: AYBFou2g7sGhrctN3yjX7LpwPOAsKx98drhKTYy0DGFNMb/nqe8T2FwU1aLUDgnjP8K
 AwmfNaNpnEAc3On/wGPWIAwjyCezUyQI+blGfuWlj9Fah5lryPrLICvgxQs4ez5R//vZqTOZ3li
 OTin8VbHbY7xNa3LWIJ35zxJ8EDtZCX6B0rXKSfliHiHE4TZouoJWWSt8s4hLsISRLIdx/QGD6C
 fohI1o4Wr/JfqWZkimEWr6C8eKYUXDEhOcIewSPKDwmyqJ7Z0Wjvq44HbFlj5yiEXZk+UUQHHFN
 oTO1QYnHxuIMQ/5HtDHrtEMbj3VfdTjU9XDcu+/UV+pcxAvKXDHPDAMtlHtyCPT2LFAvAdwxM8S
 NOtmd3QxAYV+CF5mcJcuZuudcIdiyWMdTGwngICxTvjpGSvX0DAtGyX6CYfLPS4N+EJyMlTfAXD
 G5zjof3K5aAtX1nnuKmiBLrmORsL3TF2n8e1QiAPJYnrH1BRw2maJZhDoAv3XaOSUbU3Cun0sbV
 ik67Pc3i/gJuP0F6aaAhYjXOf3DI49qg21gj+l6VpgZbisBP00mzxykMiEFxY72w9YmLETwpJZA
 oV6PIQ==
X-Received: by 2002:a05:600c:56ca:b0:49c:f13d:ffeb with SMTP id
 5b1f17b1804b1-49e7d757c18mr53184305e9.15.1789492079231; 
 Tue, 15 Sep 2026 10:07:59 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf33e01sm431826f8f.23.2026.09.15.10.07.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 10:07:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/20] target/arm: fix MPU SIZE min for v6-M/v7-M/v7-R
Date: Tue, 15 Sep 2026 18:07:34 +0100
Message-ID: <20260915170735.425445-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915170735.425445-1-peter.maydell@linaro.org>
References: <20260915170735.425445-1-peter.maydell@linaro.org>
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

From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>

The PMSAv7 walk accepted any non-zero region size field, but Armv6-M
requires a minimum of 7 (256 B), Armv7-M requires 4 (32 B) and v7-R
retains its current minimum of 1 (4 B). Introduce rsize_min based on
ARM_FEATURE_M and ARM_FEATURE_V7 and reject smaller values. The PMSAv8
path is handled earlier and remains unchanged.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/ptw.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index a29de0385f4..cb9e73fc0ad 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -2720,6 +2720,11 @@ static bool get_phys_addr_pmsav7(CPUARMState *env,
     ARMMMUIdx mmu_idx = ptw->in_mmu_idx;
     bool is_user = regime_is_user(mmu_idx);
     bool secure = arm_space_is_secure(ptw->in_space);
+    uint32_t rsize_min = 1;
+
+    if (arm_feature(env, ARM_FEATURE_M)) {
+        rsize_min = arm_feature(env, ARM_FEATURE_V7) ? 4 : 7;
+    }
 
     result->f.phys_addr = address;
     result->f.lg_page_size = TARGET_PAGE_BITS;
@@ -2748,11 +2753,13 @@ static bool get_phys_addr_pmsav7(CPUARMState *env,
                 continue;
             }
 
-            if (!rsize) {
+            if (rsize < rsize_min) {
                 qemu_log_mask(LOG_GUEST_ERROR,
-                              "DRSR[%d]: Rsize field cannot be 0\n", n);
+                              "DRSR[%d]: invalid Rsize field 0x%x\n",
+                              n, rsize);
                 continue;
             }
+
             rsize++;
             rmask = (1ull << rsize) - 1;
 
-- 
2.43.0


