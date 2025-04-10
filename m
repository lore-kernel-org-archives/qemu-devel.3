Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A0F2C3601E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 21:02:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2z0u-0005yt-4u; Thu, 10 Apr 2025 17:00:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u2z0r-0005xC-GY
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 17:00:42 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u2z0p-0001lb-Fq
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 17:00:41 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-224019ad9edso18111725ad.1
 for <qemu-devel@nongnu.org>; Thu, 10 Apr 2025 14:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744318838; x=1744923638; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PmeV86UWNxMTSPkNU4LeBxv7d2QnrBx0YubZlLs/qhU=;
 b=jgMVDr2bdgdohL8//DMrQBoIzFy/nWB3riBShponSud05c2Xik7TvRg2Lsmhmx71HT
 vIC8f9SGY1VPZ5h/EyijedNssgNrBY+zSNYHCq+gi7MsD8e93knRdmmV0inYOOcgLooc
 WzXKOK/rL0ibM54AVn128jVGeZdtO3UgDYyPLqIkBNL8bloNpb58ix6RlcaRH6kStryY
 VezNqXfP5550QG1Ox6OF24XWG3FXq3NTA79I+RTn4QewSVIp5xfE7dIs+7wuCMusbRx2
 J6cFzv1brczCxJcDInhbY0BG2YHHrg6cCop2WZddNmpQdanhQy+VkoES0LZUVUSBniQw
 Vejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744318838; x=1744923638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PmeV86UWNxMTSPkNU4LeBxv7d2QnrBx0YubZlLs/qhU=;
 b=Au277q/OP3MVMGW+alfjW6pL2DfotXNR/5LK0KvbmOTAb2xdqCWS0pb9jHpf9xGpDL
 gKn/nsPbcyBq6gm+PpHNHLM2j3d86GWg9XiKDnjH7ocY68h49tCAYOICflbRHaQxaHPd
 /rjg8U2N5ol/HoWcY3ZCrCdo/r+dJ3ldojctQz3BsZ+TPktxTBUUMqd+Nj8SdKZh9PHJ
 MzDHbubiQBpXtMDwHOkajbSODieTE6pkGFej4eumSNgNSbkSPB03WVgbxI54PKNI/RSC
 3hhwPqSuwiXHXvD/BAbzwU84ntKVZ7+XoNQ+d7uiv5ZhSGB6tw58GrPLeh70YT2Uj/mo
 Q/Aw==
X-Gm-Message-State: AOJu0YxJkLr+qhNLGE1H7z1xWclqxySUQOAcUDxru9DUXduybBXUiqHJ
 bjwoQaI8BmjSTCGGkX8R9byMytdPygFz+KafrbIE0nqJ5AkkHvQkHLftah9oUZgh/gJBBjVMLBc
 Z
X-Gm-Gg: ASbGncubDBwE01rHIkIb/rO5VQmXS3dDHP4oIQbiDZCk9yCk+7dBMl/jsqlRxqh072S
 8IRljsKFSLICEAYNY3EzoqetwGUDkZqo+Gg9ZZU3mXdlCsTEEQ1fC75OparmVBr4123qNic2P7N
 YfzxI4iNs4TqGSqFWDc6ZmAgHXrKVajaA9kvC+rfuBUdwOex9De1wN7MIOYaG2nDGkenJNk6aBu
 3CiPtUokjNcTc04Eg+vKEKEpZwET2Nist6UeIm+TWg90oyKCJvP+C1iMNBlfM2olYcjn61nDzqH
 1MU/eyZtkayl+3rcfxzJe1ApqX4xWsbBo55iNX4UIa1MzJSLOic=
X-Google-Smtp-Source: AGHT+IH9ApjVDIlbHEiORAEkYyrDKhJ0F9TX9kzkMWvWD3E2WfGbbgaIrvceXWKN9jCNTc4t82oH1Q==
X-Received: by 2002:a17:902:e5cf:b0:215:94eb:adb6 with SMTP id
 d9443c01a7336-22bea4efe58mr4867695ad.40.1744318838103; 
 Thu, 10 Apr 2025 14:00:38 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd22f82a3sm12431b3a.90.2025.04.10.14.00.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 14:00:37 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org,
 alex.bennee@linaro.org, qemu-arm@nongnu.org,
 Yannis Bolliger <yannis.bolliger@protonmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 3/4] target/arm/ptw: extract arm_cpu_get_phys_page
Date: Thu, 10 Apr 2025 14:00:21 -0700
Message-Id: <20250410210022.809905-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250410210022.809905-1-pierrick.bouvier@linaro.org>
References: <20250410210022.809905-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

Allow to call that function easily several times in next commit.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/ptw.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 754ef0d3a25..6ea39ee5755 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3629,23 +3629,17 @@ bool get_phys_addr(CPUARMState *env, vaddr address,
                              memop, result, fi);
 }
 
-hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
-                                         MemTxAttrs *attrs)
+static hwaddr arm_cpu_get_phys_page(CPUARMState *env, vaddr addr,
+                                    MemTxAttrs *attrs, ARMMMUIdx mmu_idx)
 {
-    ARMCPU *cpu = ARM_CPU(cs);
-    CPUARMState *env = &cpu->env;
-    ARMMMUIdx mmu_idx = arm_mmu_idx(env);
-    ARMSecuritySpace ss = arm_mmu_idx_to_security_space(env, mmu_idx);
     S1Translate ptw = {
         .in_mmu_idx = mmu_idx,
-        .in_space = ss,
+        .in_space = arm_mmu_idx_to_security_space(env, mmu_idx),
         .in_debug = true,
     };
     GetPhysAddrResult res = {};
     ARMMMUFaultInfo fi = {};
-    bool ret;
-
-    ret = get_phys_addr_gpc(env, &ptw, addr, MMU_DATA_LOAD, 0, &res, &fi);
+    bool ret = get_phys_addr_gpc(env, &ptw, addr, MMU_DATA_LOAD, 0, &res, &fi);
     *attrs = res.f.attrs;
 
     if (ret) {
@@ -3653,3 +3647,13 @@ hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
     }
     return res.f.phys_addr;
 }
+
+hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
+                                         MemTxAttrs *attrs)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+    ARMMMUIdx mmu_idx = arm_mmu_idx(env);
+
+    return arm_cpu_get_phys_page(env, addr, attrs, mmu_idx);
+}
-- 
2.39.5


