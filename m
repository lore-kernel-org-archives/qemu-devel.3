Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DC5AC71130
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 20:58:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYsuP-0003IH-Rx; Mon, 07 Jul 2025 16:57:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uYsL9-0005H6-G2
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 16:21:29 -0400
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uYsL7-0004Hl-U7
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 16:21:27 -0400
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-4a9bff7fc6dso11457061cf.1
 for <qemu-devel@nongnu.org>; Mon, 07 Jul 2025 13:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751919685; x=1752524485; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lcs5SBgIJAZ9jZMJeyubq/bXFbb8f0ayL+4aR6w4j6M=;
 b=VQd3TNWpaRLCTmZLcjGW4ZdDabUazZCcHV28npaDeJCloScpsvIKaWzB7WKml60+XZ
 DIbxF/F+pEYZY5gEjUXGygAJrWurCeQ/GTlD8U7THVXSh2A1KI3ju1cbBuQ9vG0LeK+/
 sYdhEShAzPBMpOYODTJSdVamrk1PId2znJF+RzZhkBvbmcHSMPBwclgS92qkZFztPGAV
 tJJkFme+jM98EpLAAdwN2lUSoYpJxplSTszbscDyM8riRxeAbx/6/nxR038ssPCOeOz5
 IIC7+imBw337ijZFALn1TIxVV+67YC0Wn7l6tj0rjDA1zWxYpu0QI1N3lxc2pE6RDrdt
 ehQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751919685; x=1752524485;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lcs5SBgIJAZ9jZMJeyubq/bXFbb8f0ayL+4aR6w4j6M=;
 b=Gmv6De/Qgor1mhcxRoRty59MUTfDYXAd3Ip9TQsgMdLm3nZT9KvQINvDLtL7dTDQzy
 vbuX8rEu2RsDUIsdgUXEyP3rp2hG+kiJ3S+aiw6UwRgh9QmpNZWV35z8W0qvP59aJ+4+
 k4XoWNWPjqBJ+1j11ekRHjtvigpFuzNs3yeqgFhFFYCECnt4odNTfZjIXLv4pb9v1W2Z
 YgeErsXEy/d6FAB+DIEXZVthdCagu+f4MaKYZGsXPhcC0P5dQI2/RIdeKtcgLQrHzAxG
 58kU+amzEqcl8kZIvsYtfAuYxCdJ+pbrQ973jCwu6mWeLR4ur4BbsWmz69OBWy6N3WcD
 k0aA==
X-Gm-Message-State: AOJu0Yyh/dodTyP3R5z6i8IN4VH1K2luy0qWgDbg4i0SkOUTbSfUbEXk
 LB3C/6RCCGuBg8yEz810ouKsqNdNkUNSqA4VeG2okFCmCJvwWGMnCgJYVVjBNVqUHUhLfk1EW2A
 j8RZmgvc=
X-Gm-Gg: ASbGncs6ORnvu3CVawAZYu7ZKbZynN9cBbhIKeGibaKRtSpUCE0o+0GH9b0gZox7YXY
 yip1THAnSBIjgNrgZ9F0Hay6wgfP1HRzZOV5sIuso2t2AXMsQqbe5WxAP2LTILZlyqPEstd7f6f
 xK0W2ieb0nMwoGDMSNcgtGM5zqQalyZfi3epGmwqrUly1C9lcM02VsYncNTRjID9UcLF6pTZAEn
 QBoPYf3SR7cCu4DqE+efqw7JWqgZ+CYhseieH9PyNCc32t2SxC9QUsrIpvzbrNehvAUYUxVsFem
 I0DIc/Shk0vuUBaNN2sMDsgA+Uj/UXuX4lRUn1vYCNYouvTg6Ya1Sy+DNi5xty/1F1WHvwqMx/e
 xRrMwlJijilen/PpT
X-Google-Smtp-Source: AGHT+IHcg99kHdal5tT5OsSoG4UYiUxEru/PPPPhEfsILtDe01ysQKrZsFBEUkc5macndgt4cwjc0w==
X-Received: by 2002:a05:622a:4109:b0:494:70e7:1528 with SMTP id
 d75a77b69052e-4a9ce6bba4emr476881cf.24.1751919684410; 
 Mon, 07 Jul 2025 13:21:24 -0700 (PDT)
Received: from stoup.. ([172.58.142.143]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a994a78dd4sm69050351cf.51.2025.07.07.13.21.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Jul 2025 13:21:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 05/20] target/arm: Convert get_phys_addr_pmsav7 to access_perm
Date: Mon,  7 Jul 2025 14:20:56 -0600
Message-ID: <20250707202111.293787-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250707202111.293787-1-richard.henderson@linaro.org>
References: <20250707202111.293787-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::830;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x830.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index adceeabfe4..b71c963f67 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -2350,7 +2350,7 @@ static bool pmsav7_use_background_region(ARMCPU *cpu, ARMMMUIdx mmu_idx,
 static bool get_phys_addr_pmsav7(CPUARMState *env,
                                  S1Translate *ptw,
                                  uint32_t address,
-                                 MMUAccessType access_type,
+                                 unsigned access_perm,
                                  GetPhysAddrResult *result,
                                  ARMMMUFaultInfo *fi)
 {
@@ -2537,7 +2537,7 @@ static bool get_phys_addr_pmsav7(CPUARMState *env,
 
     fi->type = ARMFault_Permission;
     fi->level = 1;
-    return !(result->f.prot & (1 << access_type));
+    return access_perm & ~result->f.prot;
 }
 
 static uint32_t *regime_rbar(CPUARMState *env, ARMMMUIdx mmu_idx,
@@ -3481,7 +3481,7 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
                                        result, fi);
         } else if (arm_feature(env, ARM_FEATURE_V7)) {
             /* PMSAv7 */
-            ret = get_phys_addr_pmsav7(env, ptw, address, access_type,
+            ret = get_phys_addr_pmsav7(env, ptw, address, 1 << access_type,
                                        result, fi);
         } else {
             /* Pre-v7 MPU */
-- 
2.43.0


