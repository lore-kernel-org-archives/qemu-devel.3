Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92085CD4F25
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 14:28:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNtUg-0006JH-SZ; Fri, 15 May 2026 10:26:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNtUB-0005o9-EO
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:25:57 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNtU7-0000wg-8p
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:25:54 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-43d734223e4so660338f8f.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 07:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778855150; x=1779459950; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3JaWcGkaE9fLWfSI8DU3cpDjO0IByAUy1JTs+IjAeEY=;
 b=EkrD13o4pmOBeroyHY964/H2db51/9CfMj1HhdMjSzUCP4dNLlmzUaIgcN8FRWix8n
 Qhknoy6jQhvE//5oYr/a2uSn/XZV3WN6JPXPS+BF27iyzVdUcnHPJeiv501OyTjtkOdc
 XTqcloNKr9Iqz5sfD6RUKyerNqnhrtmO8x75rcpSZr5eSGj1qIU0FygjVTU4wWYnlcdH
 eDXCOZrEuPSF9BVmt7cWVEyPFJcXvdv1Dmlh41rhjYmrvwxCAdsPqnK+vRxjlESOAWIh
 oF4uSoUOiT5JOzllxmJtAm/nZG8YnHLukWjqGoM/rWcXGgKWuwqKGOcVNSgTs9iJ5qVi
 8B6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778855150; x=1779459950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3JaWcGkaE9fLWfSI8DU3cpDjO0IByAUy1JTs+IjAeEY=;
 b=Gc1zhADg+xqkwhNcst1K7ZzcfcRZafSpxYw7pxTOKCszPstvxWuAKxAJ68xevnIsEH
 YdfyQUVtaYjpphlmZ0F0EeKAE/eGTrNfDmabgUx3ObeHqk3yS5eh/lf4+7/1MQka5K6u
 ynRO8+d3exZIPlDZZ3uG3E6/lPFlsenx2zAJ2XC4H2jZZXDjQdlLY+lL5/X/M5HmcBJz
 RbmVbQfQcqvmowZqHX3sW2DrM+0iaUpB0ESIPrNj5v/yAs0oU7efcmEzBYsacJD8xbuh
 go/Nl9iOTXPlNcsl2+/wbCrvDl+Y3AqyMGz06rgXnZjyqJNR3uIDfMB3bkN0X7ATD0cq
 Xtww==
X-Forwarded-Encrypted: i=1;
 AFNElJ+zWNIVzFGQx2PrlbjDi0quq8HP7asba+BGkTSq0hIWSFqNonXXLP5t7q6XlzlIVxgFmYt4KDBjf0vc@nongnu.org
X-Gm-Message-State: AOJu0YzTshX5Fzzq/dPOwy7dVK+gvqrPpn2MJOW4K0QkQSdqFaMayNJs
 T+u6cBDm2Ge5MySj0KE+LkbZzVuX3powzmPwbGxBcZLIj26gNAoUK14Nmt5BcC1xTrlYgDh6E22
 lk/bR
X-Gm-Gg: Acq92OFVys+8YXh9IH5nfqWGpCmo1G694aXkDmDNEYmeBSUYewxM0MEBeVIZsqSM6L7
 n2hRqphdHcv4Yol+k5RJwirub2JURog0a2IBSw5oFezuXHpgVyjmoPXP0JzENp9+NTxCMqLKiCK
 MMZPGfQFrqGamx1aEw/vHbPDl+3nfJdaa09gch4My/6oI97Y0dFlI8ewz9uygD0/SK3DXxALFC1
 h+v0qQXbW/BnfX0L9sspAWASmOjKRiWx0PcdWOutIcP2r3le/Vo7jOSwxRSdf5U7oyOnGHCYDDd
 up2iC1/CqVzUQty66XjIrCpPD6Ct5BGL+MrE6z1k8o+YFkpcVq2qKM5e6VuxEKFwthaTJdPjU/g
 o6SgYXbO3It0rrIkeiHGmD+Cq37gLfJaixFvMOOgPvKpzG2Ys3EcN8efZY5hd8souwAy3piAf54
 5QI26WYPo8xpzoaTatoDaP1NWBUDaZ3H1P238cg8J9LdL0UAmQEvVsoqa8pmBbzSSyZY32NLCcY
 Qzy7rKiqEXoHKZEVgxd6sOXi/FDSJU=
X-Received: by 2002:a05:6000:230b:b0:43f:e978:148f with SMTP id
 ffacd0b85a97d-45d941b0bcamr12909063f8f.25.1778855149681; 
 Fri, 15 May 2026 07:25:49 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da15a666fsm13560603f8f.36.2026.05.15.07.25.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 07:25:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [RFC PATCH 06/14] target/arm/ptw: Flip sense of get_phys_addr_pmsav7
 return value
Date: Fri, 15 May 2026 15:25:33 +0100
Message-ID: <20260515142541.571911-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515142541.571911-1-peter.maydell@linaro.org>
References: <20260515142541.571911-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
---
 target/arm/ptw.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index c9563557f9..12e700fe07 100644
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


