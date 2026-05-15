Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 963F6CD4F25
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 14:26:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNtUl-0006eW-8d; Fri, 15 May 2026 10:26:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNtUH-0005td-Jm
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:26:02 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNtUD-00010f-28
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:26:00 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-452169ae568so7146844f8f.3
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 07:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778855155; x=1779459955; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Z/7MUfTgV47m6A8fbfhuwF/fDPkNJxzNCWUG8nRDLD0=;
 b=EFk5TpolgdHdse0tcHqV5ABKapc7CvdPixXHcvWlQk9+dogcRplMkaBdorEJ/3jqip
 SHXByt5I8IRyoWHELSm3i2jrs6sJp8s1VNj0169ycxU5CVf8ZtUlTtOoiBAlVdOtOmD9
 Hn++PdRFz28yGrrFpogtVdmYMu/237isC/gIqD2j4sK8RZvKbveA+FRoOayq+K2Q7MDI
 z+O6Cs2qDdVxHtSSTu0me4DUJ4tDV5MEvq56L7QRuCDfOj7bavJaTB+E0hCX1c5ZMCxp
 oZ+Vu6aluErP+cjowgWOtAEB/p6cJ1odUGUaXoGHX31cEWQYZYtUpgCJob0nGXuZaeTt
 HeGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778855155; x=1779459955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Z/7MUfTgV47m6A8fbfhuwF/fDPkNJxzNCWUG8nRDLD0=;
 b=kqCfDWiPxRophLNn0tA3eWGG2QoMj4dNIV5DTbdFDwu/PtHiF7Y68tGDT9M+Jj6RJ0
 MovsBfGLQpCw33+GxrbYbxCHuO+S+wVkfhS4ia45/6h4g3q1TZfwn6Pz9RSgN3YiHn3v
 YclSA/q9Mn9N6i+VP7bjUaS1eqF3NjwVidZr4jawBMAIBHdVFIceiWi/lZlW2g848iZ2
 JOlFODKNMpvDSi3qxphFzUZ6Plu5lbTS3g/fjBDau7EtcrcpLadjKduVz+1ECFM0ymUK
 8Hvf6yS+nCTE1vtVc886cWLYxxb35YzGpeYeEXp/2wuDA1Bhp+MJ193emUaiteJncUPY
 1Pqg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9uOl6FOlLzLsrNBtEoAJ7r3FsO6BzkR0Bb9WIGh5ZdqKUJ9z8tWSNS6pqLfK0mrpx/Fg9HSYSfFOkI@nongnu.org
X-Gm-Message-State: AOJu0YxGWtbZTtQMmSCEs4s7xlwWAsgn8QokjOYObkDWw/iWWHfSaW2j
 jqnFZKLZek5d+yWc8E0xTUxXXZscKUTf7pe0K576XdjI3KVfZHrD7TjrhStXG6EMAcQ=
X-Gm-Gg: Acq92OE99fmKVEZSkpeQrAuR0xdXq2djMbmBiQlD5xi3fNO/0wi12uKPnUgLz6wbClp
 TkJ/5BFat7AumQwpdnIdYiVcJpkDEpkPTQ3DS9I16V+2oT12S6cKyGKwJl+Dg5PGXy0nnP0ZwbO
 w94vvthg5oE+REBxIcYUwfaTNYohTXdhMXEkQcP9JtqWst/KM2volfLp2bxd7gARlt74I1CQ73p
 ovBsyZKPD7prMZoQ1qIyl9AVMRSiW15Bo+7S9NMhx3WVmc1LPXAe7toR38cL1A/KY3zW9f7UwJs
 CmbBk9QsaoPvmh75bnGC5OOX8mIw4k36SDMg680bVDRCM8TSK4y6mc3M0XdJ7K1YZ6cdzCiouNb
 w2uvdxWRfJ3YXqflUbBA822chY3Kjk9/qBG70Dhy/ECuIWa4tfUhIkQlPqZ4k/zYkD/tcVlUE4V
 XDiN6b7eQKbKYGgIEh64C06hOTc75D3Qcy5cw8kiUTMVGoProZV9RVRI5TKmIzXWOmf7adsr/UB
 TA/L7eah/8w5QeCPNl/qsa6smGlVso=
X-Received: by 2002:a5d:5d01:0:b0:452:a293:4d91 with SMTP id
 ffacd0b85a97d-45e5c34b279mr6227012f8f.0.1778855154848; 
 Fri, 15 May 2026 07:25:54 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da15a666fsm13560603f8f.36.2026.05.15.07.25.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 07:25:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [RFC PATCH 12/14] target/arm/ptw: Flip sense of arm_cpu_get_phys_addr
 return value
Date: Fri, 15 May 2026 15:25:39 +0100
Message-ID: <20260515142541.571911-13-peter.maydell@linaro.org>
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
---
 target/arm/ptw.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index cb41146b9c..ea036a541c 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3964,7 +3964,7 @@ static bool arm_cpu_get_phys_addr(CPUARMState *env, vaddr addr,
         result->attrs = res.f.attrs;
         result->lg_page_size = res.f.lg_page_size;
     }
-    return !ok;
+    return ok;
 }
 
 bool arm_cpu_translate_for_debug(CPUState *cs, vaddr addr,
@@ -3974,12 +3974,7 @@ bool arm_cpu_translate_for_debug(CPUState *cs, vaddr addr,
     CPUARMState *env = &cpu->env;
     ARMMMUIdx mmu_idx = arm_mmu_idx(env);
 
-    /*
-     * Note that this function returns true on translation success,
-     * but arm_cpu_get_phys_addr() and all the other get_phys_addr
-     * style functions in this file return true on failure.
-     */
-    if (!arm_cpu_get_phys_addr(env, addr, result, mmu_idx)) {
+    if (arm_cpu_get_phys_addr(env, addr, result, mmu_idx)) {
         return true;
     }
 
@@ -3991,10 +3986,10 @@ bool arm_cpu_translate_for_debug(CPUState *cs, vaddr addr,
     switch (mmu_idx) {
     case ARMMMUIdx_E10_1:
     case ARMMMUIdx_E10_1_PAN:
-        return !arm_cpu_get_phys_addr(env, addr, result, ARMMMUIdx_E10_0);
+        return arm_cpu_get_phys_addr(env, addr, result, ARMMMUIdx_E10_0);
     case ARMMMUIdx_E20_2:
     case ARMMMUIdx_E20_2_PAN:
-        return !arm_cpu_get_phys_addr(env, addr, result, ARMMMUIdx_E20_0);
+        return arm_cpu_get_phys_addr(env, addr, result, ARMMMUIdx_E20_0);
     default:
         /* translation failed */
         return false;
-- 
2.43.0


