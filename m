Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02BDAC3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:53:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJXX-0003p1-38; Tue, 06 May 2025 10:44:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCJV5-0001Sc-AG
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:42:32 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCJV2-00025h-LV
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:42:26 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cfba466b2so48970045e9.3
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542541; x=1747147341; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VckgnWFHcXJaFRW3+b8g4WIpqvkRRSf9OGC46J//Dr8=;
 b=Zyi5WTfniajaBpCXH/FETnfGyDigmWcwN786Yoo8tPMiQbajeRJUjPwH7he9hQt5/A
 MFFAf05hh9+vLcKisnLOXf/9GiXyfJDYYx6MJbHJNSaX6zhZ2hwBc5In3otCR0/A+QR9
 LFDuzK3HuaVK8voaph/tXvChPbhoYFltb7bmPO1Sik2hMeJb8M99rxUyS1FX/zeYCwbZ
 nv2hMNuR1x+fh5492B5Y0NIkQiZzS1n+9YbhRKRiCylvAshzbiZW7UQwMOzZ7YFqSXaN
 OHthF+Wl2nRZ44n6mbOgHx6RDXA3t7dUt2h4+CbBWd0m6KJCybab8MBFBop1g6PWVlLn
 GW3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542541; x=1747147341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VckgnWFHcXJaFRW3+b8g4WIpqvkRRSf9OGC46J//Dr8=;
 b=qjzWZsKkF9lO0K/oeOOQZPJLtifEccNu7UQEdZopxjdS9Vi4cPRnu/7H9Z3mPOHDiV
 FPP5bB+jljID1U7dz64nEtBz6dwokhaf98dWSbRSsptK8Ex4PQFohNlhaGBIpI4wsX42
 nDQCeRyJOVFeDo+TJYX2WUJNZ258PPn7XemsqcsTAbZ9OpLOda2Qamv2ACfML+JOhbsW
 NLY5c0rDOGQfTQHKJHpg+WTGZxJQl6DhZeD7TA5yE8QpQOH045Kw94xlBzfcoqvNrrz5
 OX49CRRc0ASzJJ0B0D8LLpcmmGQVGrnN0JG6u5vkEBXJu+JuVtxSCr4vIZDOhV/C/1av
 4cuA==
X-Gm-Message-State: AOJu0YyfQFsVv4+DYhCm6TG902UgL9zfSbnOlIm14ZI3MdQ0SdOLIMob
 qpBoI80RVDiKIctNLM5BQfsqmpiKNY1mef5ERY4Q7v9px4Wqk8w7JUvdyUaRbCvLh2xBB4/+BDz
 0
X-Gm-Gg: ASbGncvFYzJBeMZEVO2PW1IwstAlOT0wFKEElv8kdjiEooKE3BnKIBjNfQ8sQ+u/Tpz
 tgV2TDsS+zZ9JjCDjD7+Y97KaMXgAO1vb47Ax3Su7XJGmuTduswZ/opArdasiCbqSfH5DJ8kPuT
 IkqxwAgR/06gJzchygtz0PgFqwZT+dB2NB0MltgIa5VcAnrmmACIk+R7B5Bb3f/USh76J1K1/Sf
 kT413RbYN1WcxmYar5bbOPmW7vGBiS/IZLh6TuyFUXZ+udFxpUw1jmW5aOp/PBVNrq5sdHmlSt/
 D7PAP4QPYVikYvjJIzc1EVttz2CB9k85uJqmblnoOw5qfI4=
X-Google-Smtp-Source: AGHT+IEY4kmvPge7QP88lEsJC3wayGEk6/6nwX6jr+KRTyViZO6KpMW+Z5IsFsuNyiA4L+BdLhaGBw==
X-Received: by 2002:a05:600c:4690:b0:43d:762:e0c4 with SMTP id
 5b1f17b1804b1-441d054c744mr33025205e9.27.1746542541347; 
 Tue, 06 May 2025 07:42:21 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b89edfc2sm169603435e9.20.2025.05.06.07.42.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 07:42:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/32] target/arm/ptw: extract arm_mmu_idx_to_security_space
Date: Tue,  6 May 2025 15:41:46 +0100
Message-ID: <20250506144214.1221450-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250506144214.1221450-1-peter.maydell@linaro.org>
References: <20250506144214.1221450-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

We'll reuse this function later.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20250414153027.1486719-2-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/ptw.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index e0e82ae507f..bdb4de7c047 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3551,13 +3551,9 @@ bool get_phys_addr_with_space_nogpc(CPUARMState *env, vaddr address,
                                memop, result, fi);
 }
 
-bool get_phys_addr(CPUARMState *env, vaddr address,
-                   MMUAccessType access_type, MemOp memop, ARMMMUIdx mmu_idx,
-                   GetPhysAddrResult *result, ARMMMUFaultInfo *fi)
+static ARMSecuritySpace
+arm_mmu_idx_to_security_space(CPUARMState *env, ARMMMUIdx mmu_idx)
 {
-    S1Translate ptw = {
-        .in_mmu_idx = mmu_idx,
-    };
     ARMSecuritySpace ss;
 
     switch (mmu_idx) {
@@ -3618,7 +3614,18 @@ bool get_phys_addr(CPUARMState *env, vaddr address,
         g_assert_not_reached();
     }
 
-    ptw.in_space = ss;
+    return ss;
+}
+
+bool get_phys_addr(CPUARMState *env, vaddr address,
+                   MMUAccessType access_type, MemOp memop, ARMMMUIdx mmu_idx,
+                   GetPhysAddrResult *result, ARMMMUFaultInfo *fi)
+{
+    S1Translate ptw = {
+        .in_mmu_idx = mmu_idx,
+        .in_space = arm_mmu_idx_to_security_space(env, mmu_idx),
+    };
+
     return get_phys_addr_gpc(env, &ptw, address, access_type,
                              memop, result, fi);
 }
-- 
2.43.0


