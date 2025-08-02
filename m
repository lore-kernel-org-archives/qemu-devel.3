Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DFD7C87FDA
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:35:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLhh-0008LB-1D; Sat, 02 Aug 2025 19:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLgG-0006NO-HL
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:30:34 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLgE-0004q3-It
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:30:24 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-741a0ec1a05so314500a34.2
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754177421; x=1754782221; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H1X7tRIlbeJs7+JRFY3gIthkRvi/ERSg1idEqFWeh8k=;
 b=jToFdCTNL33DzQYf406yArFDaRlxtkPw6rdhKrz9O3IlphyimUT17GDqfY5tredpF/
 wft2sZqr9XHxJ7Xk3IamlyNMX/5HNs7nDkt1ggckKTcCi/uVtJR/yXDwPbu5glOPD4z3
 4p2PWu0p8xd0rCLRhaMaqb9UsHglFUn/YN4VTkG+KLalgBr+/8S7kw0TsrZ0cghPo6a1
 V6qcKMvPm2bMIi0JAvQuPlp7T6bPu49Ob7DYDLFMcpk1pQxiuImwq/hF6DIPVTF9FZ41
 msGIYxRvP5f73M9azSfmbtnpo/rTEqjEiQLa+nZj5epWsvFl3KNLgNFn5ta5vjrdS46n
 mmUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754177421; x=1754782221;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H1X7tRIlbeJs7+JRFY3gIthkRvi/ERSg1idEqFWeh8k=;
 b=YIhQBIWHBwohBhcwIcUyFe5OsyAklEczz9Jyyb3Vluok/sx9xUKjlIEy7tkLy62iQD
 YBEcuv1s0/mf+Skq4V2tIO6sSCHv6DHLiDUcWukycJjb3Z9tpvGQNGtlMkwbGn8hPMV7
 ZuW1ZVzIarpE5L7SLOW3rce3XOLD8WDdx7Pli+zBWCIv197cy4ydU/45OpMV+nie4HXB
 5Nu0Ce75adUKS5muGEjaPpuutLPDNuB0KlD3tcAqx9jKzsimrJ5pdRj2byrFvjiaFDkv
 kO852dhGJhOI7LY9dR7OuwG+DPBxtkonGyAJTyzgJGB80QCZ43E9yFrvtd3t00oyi1v1
 kzlQ==
X-Gm-Message-State: AOJu0Yxa6z88Rpm3wHMCleTS2ZOsMnNIegINm38rmPU4JTX1kAFawfdR
 kOzGkxPmKQxmSTElmIlEPYNQBgOtKR+srx+rqHo241W96/4tcikpOmhZOVHKfXJ9RBnVqCEGP7c
 1ihrAXm4=
X-Gm-Gg: ASbGncvHAQqUJgiCZEiUqS57Z2IQIqh8/6K9mnqszYshs/Ipzg8zwcnPql6cE04Srs4
 O+gYmUFZfEoUYBbdrJyS35TkkJLR0OuCUrTuk86EiLGWBjRpn2pvO5koX8kPcUm1F/TOAq1MWFl
 quDw0HazlD4TkvG+Z2o3KUtWSFeO1syy1FFtL//PJo62WceT6e7soevUf48l5PRtq/6BMt2xtRT
 eUU1Ekkg0HwATexoPwVLLOFagn1JkuVPYnd+JkR0gFz+MpM8UA1nSLUBE9ueah7+FUUZL9u9LHE
 h3IvZxK6+Q8Qo8qLai1zu8ohefNzRWaVYMhzs8I7ulw0+am4YiR9mZpsiGS2alGEvNQYAopyxS6
 dXukBN6xgSv2Bu6bGwsytFnLRcyUqBWtpiHvDKaNZdv+qXL2I622N
X-Google-Smtp-Source: AGHT+IHygjNW+d2R1dy85V2oE9VABBsZH3ztf6vNeH4dc9MrqYXjrdiLEVL7/J02fmLa2jkZywQsbw==
X-Received: by 2002:a05:6870:1e8e:b0:2d6:245:a9b3 with SMTP id
 586e51a60fabf-30b6755af2amr2513407fac.6.1754177421237; 
 Sat, 02 Aug 2025 16:30:21 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-30b8e3c9b32sm71031fac.24.2025.08.02.16.30.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:30:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 04/85] target/arm: Add prot_check parameter to
 pmsav8_mpu_lookup
Date: Sun,  3 Aug 2025 09:28:32 +1000
Message-ID: <20250802232953.413294-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802232953.413294-1-richard.henderson@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x329.google.com
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

Separate the access_type from the protection check.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h    |  5 +++--
 target/arm/ptw.c          | 11 ++++++-----
 target/arm/tcg/m_helper.c |  4 ++--
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 118659815f..326b5a73cf 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1626,8 +1626,9 @@ bool get_phys_addr_with_space_nogpc(CPUARMState *env, vaddr address,
     __attribute__((nonnull));
 
 bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
-                       MMUAccessType access_type, ARMMMUIdx mmu_idx,
-                       bool is_secure, GetPhysAddrResult *result,
+                       MMUAccessType access_type, unsigned prot_check,
+                       ARMMMUIdx mmu_idx, bool is_secure,
+                       GetPhysAddrResult *result,
                        ARMMMUFaultInfo *fi, uint32_t *mregion);
 
 void arm_log_exception(CPUState *cs);
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 561bf2678e..a914e7e23c 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -2561,8 +2561,9 @@ static uint32_t *regime_rlar(CPUARMState *env, ARMMMUIdx mmu_idx,
 }
 
 bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
-                       MMUAccessType access_type, ARMMMUIdx mmu_idx,
-                       bool secure, GetPhysAddrResult *result,
+                       MMUAccessType access_type, unsigned prot_check,
+                       ARMMMUIdx mmu_idx, bool secure,
+                       GetPhysAddrResult *result,
                        ARMMMUFaultInfo *fi, uint32_t *mregion)
 {
     /*
@@ -2750,7 +2751,7 @@ bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
     if (arm_feature(env, ARM_FEATURE_M)) {
         fi->level = 1;
     }
-    return !(result->f.prot & (1 << access_type));
+    return (prot_check & ~result->f.prot) != 0;
 }
 
 static bool v8m_is_sau_exempt(CPUARMState *env,
@@ -2952,8 +2953,8 @@ static bool get_phys_addr_pmsav8(CPUARMState *env,
         }
     }
 
-    ret = pmsav8_mpu_lookup(env, address, access_type, mmu_idx, secure,
-                            result, fi, NULL);
+    ret = pmsav8_mpu_lookup(env, address, access_type, 1 << access_type,
+                            mmu_idx, secure, result, fi, NULL);
     if (sattrs.subpage) {
         result->f.lg_page_size = 0;
     }
diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
index 28307b5615..d856e3bc8e 100644
--- a/target/arm/tcg/m_helper.c
+++ b/target/arm/tcg/m_helper.c
@@ -2829,8 +2829,8 @@ uint32_t HELPER(v7m_tt)(CPUARMState *env, uint32_t addr, uint32_t op)
         ARMMMUFaultInfo fi = {};
 
         /* We can ignore the return value as prot is always set */
-        pmsav8_mpu_lookup(env, addr, MMU_DATA_LOAD, mmu_idx, targetsec,
-                          &res, &fi, &mregion);
+        pmsav8_mpu_lookup(env, addr, MMU_DATA_LOAD, PAGE_READ, mmu_idx,
+                          targetsec, &res, &fi, &mregion);
         if (mregion == -1) {
             mrvalid = false;
             mregion = 0;
-- 
2.43.0


