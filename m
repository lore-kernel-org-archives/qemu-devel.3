Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 225D4CD4F25
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 14:28:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNtUi-0006Wr-U4; Fri, 15 May 2026 10:26:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNtUH-0005tY-Ha
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:26:02 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNtUB-0000zq-RU
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:25:59 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-441209fb77eso611552f8f.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 07:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778855154; x=1779459954; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lnHCoKfIHOU4NHMQe3Kj9Fosoqb2a9TyPNEWvgX/PmE=;
 b=iz/65VmB3ajRJmG1MFGIj3mGjENRTiG6B/9SlR458Wm6k8cLaJds/xtTDmbwuvCq6K
 AiTyHJCl0bhT/koNdTrIYbHhxFyfGJNtfzBFLGMk6JpkILZ4FgNqAqleH1hRZr8U0jkW
 rrX8Ahge8AkbcjAOT+pynakOacm3giROnN0xYeToqglQI6sXvOGYstuSlCvShqsDNRXf
 FBx4/Gmn/4eCW9TRzQ0pM/8t3hBXcXdYlqj3Ce5edxqyp8kWLDFJwyB0NBgw3goS3yJ7
 NO9OI+72uECGFpItTgg292aX0v1irDUT2PGZ1kMpfbUlPQYXc8cXs1d9kZfILKD7dkhP
 hLaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778855154; x=1779459954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lnHCoKfIHOU4NHMQe3Kj9Fosoqb2a9TyPNEWvgX/PmE=;
 b=QsOzMa/i/SHcbDZ1GioxcheK+Pg9VCj3Ca9j+QmvjNdhWiA/x/MkGDzObj90lbJaXf
 PyqAO/bJ8qgB48557u36ipwVhpfEnmQCRjztNVoLpb7sX+Gf7P77fGbm4tFh/CZ9Oi2M
 Y5lk5zlrSqTsQBGrixXN0xn5VbBd0LlVD56IhiP4b6iNaTfFRdskegy9b0rM5cGdfJ2F
 UFaVCqXg1LQJgCxKOKthSOIH72iTD344HQPbkSZt66r3sQbfDhChMNQfSP8lpgzAwH5f
 TZYj7izhNwKXZAg2dlLeHEscNO3nz0+Xht7Sk/6VNyOhWWZaPvpeYDhgXF9YBGB1DKoc
 N3uQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/BZvk42w1gAUF6fLUerGXY2IZPjfzG2FCvrA0tULPZFvXK9TVDB0aQTqWI13rJHyLaTKPVsC4cTArv@nongnu.org
X-Gm-Message-State: AOJu0Ywd/tnsuYwVp8YtMgyG7JvU2+C9OPv93lIgPF5ZEs07JNIblLs0
 AY/mHxnQXv63It7SgcSrAFc6pY7RjO5awkH3CQv51h0co6fEsa41vRGmhfDYEUXyk9TZwx4BCJj
 2WiIZ
X-Gm-Gg: Acq92OEXI5AFU+L4dv/HtiDz4d5Vj+A60AVtGQRLOcaOIgqAfoWCIuWOei+eddxJjp3
 66P0eXjzLt6cPWnxVlgp7awFzx3La2Fv+KTNWHM6MftCb93PH5YsR9L2wytJvOtRzC1JIEzoS1l
 LE2+ko4dFHPRVkeborYEjnLzMeb3Ior2LYzguXhHYQjMQFBV42ATe9aU31Xhetmb0cptsv6wlmM
 saaKbHARL3oHtrnKl/q1gN2BwDMbHi4m0lw8EcI1j+vsZFpgEvLzH1QRIQlT7qMwP+se1uiWdRO
 j65e7/sXMD5OGZTBVd+6+uQ0zuGUu3AMITbpIa4LNRVqpwd7O1vFiYojiEEgqkjop5tbrr3NC2u
 y3izABMytl+UtcgTadTRoU40ULdnpFZP6EsIbr0gs/Ty52a06CYXJsy7ggQj8exS1RZSHVRe2eK
 92qOY3rBBEZgCtGeX2ry6xvsJydRZjwrDY4yEjBehMACYcdeDDU+jvJ/6s0d0fSeBq3Hy0wQ7dk
 GESk+3Y/gj38VAABbrvWnxXZTN8wPY=
X-Received: by 2002:a05:6000:4b07:b0:44f:69f4:39b5 with SMTP id
 ffacd0b85a97d-45d9502e84dmr13423623f8f.29.1778855153946; 
 Fri, 15 May 2026 07:25:53 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da15a666fsm13560603f8f.36.2026.05.15.07.25.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 07:25:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [RFC PATCH 11/14] target/arm/ptw: Flip sense of get_phys_addr_gpc
 return value
Date: Fri, 15 May 2026 15:25:38 +0100
Message-ID: <20260515142541.571911-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515142541.571911-1-peter.maydell@linaro.org>
References: <20260515142541.571911-1-peter.maydell@linaro.org>
MIME-Version: 1.0
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
---
 target/arm/ptw.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 9ecb6238a7..cb41146b9c 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -667,7 +667,7 @@ static bool S1_ptw_translate(CPUARMState *env, S1Translate *ptw,
         };
         GetPhysAddrResult s2 = { };
 
-        if (get_phys_addr_gpc(env, &s2ptw, addr, MMU_DATA_LOAD, 0, &s2, fi)) {
+        if (!get_phys_addr_gpc(env, &s2ptw, addr, MMU_DATA_LOAD, 0, &s2, fi)) {
             goto fail;
         }
 
@@ -3806,7 +3806,7 @@ static bool get_phys_addr_gpc(CPUARMState *env, S1Translate *ptw,
 {
     if (!get_phys_addr_nogpc(env, ptw, address, access_type,
                             memop, result, fi)) {
-        return true;
+        return false;
     }
 
     if (FIELD_EX64(env->cp15.gpccr_el3, GPCCR, GPC)) {
@@ -3826,11 +3826,11 @@ static bool get_phys_addr_gpc(CPUARMState *env, S1Translate *ptw,
                                           result->f.attrs.space, ptw->in_space,
                                           fi)) {
             fi->type = ARMFault_GPCFOnOutput;
-            return true;
+            return false;
         }
     }
 
-    return false;
+    return true;
 }
 
 bool get_phys_addr_for_at(CPUARMState *env, vaddr address,
@@ -3939,7 +3939,7 @@ bool get_phys_addr(CPUARMState *env, vaddr address,
         .in_prot_check = 1 << access_type,
     };
 
-    return get_phys_addr_gpc(env, &ptw, address, access_type,
+    return !get_phys_addr_gpc(env, &ptw, address, access_type,
                              memop, result, fi);
 }
 
@@ -3956,15 +3956,15 @@ static bool arm_cpu_get_phys_addr(CPUARMState *env, vaddr addr,
     };
     GetPhysAddrResult res = {};
     ARMMMUFaultInfo fi = {};
-    bool fault = get_phys_addr_gpc(env, &ptw, addr, MMU_DATA_LOAD, 0, &res, &fi);
+    bool ok = get_phys_addr_gpc(env, &ptw, addr, MMU_DATA_LOAD, 0, &res, &fi);
 
-    if (!fault) {
+    if (ok) {
         /* translation succeeded */
         result->physaddr = res.f.phys_addr;
         result->attrs = res.f.attrs;
         result->lg_page_size = res.f.lg_page_size;
     }
-    return fault;
+    return !ok;
 }
 
 bool arm_cpu_translate_for_debug(CPUState *cs, vaddr addr,
-- 
2.43.0


