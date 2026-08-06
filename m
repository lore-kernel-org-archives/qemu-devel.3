Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9519C5AC80
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 17:32:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ws1wL-0004nt-SV; Thu, 06 Aug 2026 13:31:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ws1wK-0004mK-78
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 13:31:32 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ws1wH-0001g6-Rx
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 13:31:31 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-3900e39d935so2367590a91.0
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 10:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786037488; x=1786642288; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K4N8HT3l2MMFg8Dw0/FAdhE00eZq2YWh3+0qZEwprOM=;
 b=yAJnFZFnBiUXeDT2XtCloXPLs7yofan7Rq2104nffTkOhJ4fpTG1TsV2W7RTwk1FUd
 hO1HZDrxtB0dpLCHCheOqo+beKi1ITu19bf8y25J//xQHawpr4qIv/W3ppfqbXfaDFWx
 LsMIEmQ2WPARS/Bg14xkZ/yFsJ8XMxTaJGuUHrKrvD4n/Sicv53Q5Nnf8xCSQh2TbX4E
 bCUU9Cka77TevtNbEQBZWPKep8KcoVot7NGj756G2AcYplZAIklnUEcVxXos4t9RA2k6
 bEwxlkEMvpIWLE4BLc/nVV1b2hnm5dKI0LBoSdYD4Lwz5T52VFlH8JHLAFsd89+gIKKq
 dR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786037488; x=1786642288;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=K4N8HT3l2MMFg8Dw0/FAdhE00eZq2YWh3+0qZEwprOM=;
 b=rY2Eruq2ka37e5LkdAQOZ9G6FC4tnrC4MQSQUdw9Zxdw2uSXniFRrBNAaBqNsH+ykq
 tLBtXvEpbXJDFIzKCVYBA8f+xbUroUaAgNMz/HE+trSlJXcJFvhpZooTPJ3nYqrRFi0T
 joXr9vjeDBYpxKnisbPz8ThklGdA7K18RhDQdxX+x5m1A4Qg2Y6f5AnLwoIIqyfFpN6P
 QqtGEgrnzjzi50XzCg/MM1zckcSdSW0dI9uIX2e6KhG6GNgK9/r1x61e/xUjCQ4nwf72
 aGMpP73IPl+NFsdAPpRXY5oVH36hDrOillAOXYaFm22+GB+cKBXSAi4xgqaP950snUeW
 Fw/Q==
X-Gm-Message-State: AOJu0YyrXTLW97Wseru8+njeq1E6u8O+TyTwu9G83lJBsvihR9WlBpdn
 Jzh+oBmoVoOcXqT7ARHQTj/CWC26TZsuQdxPTY+HN97foCwuMB3fVkHdMiAx2vmXV+/jSu7V9h3
 nIP2X
X-Gm-Gg: AR+sD10M2YLnsfyfbb/UncPqDCaEDm0YZIt91ZFH5BrtvQI+lRr5lxkChIkceVVfo1L
 voPjFrTEN/v3TrH0zIUCsn1ecCqckTttN6YUfx4qU8ERS+XkfEVTZUxtoGCCJgigENkwdN79sXH
 bpJbS2eq6CQDJFO5SeA0lcL7bkWDVhFX+1gRGBMpLdLCPxvQLmxGyoCt4uiZJcSpfMtMM0mlZhP
 fpHqqsyCz8/8SlwQ3fS5/whNk4K+SMtbcuQSkBBek7JFChEjhNl9tWlcHjDLfF4L5LlwDL1A0gB
 0pwrE7DEq40sqPP1Rsgsrlb4jwXN699Au/DDKpBV+426viLqHNoGuG8sGDpXSL5bOlJspwieZ87
 iAHLjT5p2AKz9M5vq5E1jMCVIrJ2EN2nmNp5AoTwojT5QFkZu45Zn6hkJTHv3BeB9LDzLa/A+1f
 XYXJ1U3JFw02XlThBHf8AxPCM3SlKMfzm0vLzxyPFw/ozSp7+uydODQojV9ZrABxhzOvPvtqkbo
 8APDeFqql1Yo53tdp1/6RY8hrZoNBI=
X-Received: by 2002:a17:90b:1843:b0:37f:bfa2:1887 with SMTP id
 98e67ed59e1d1-3903c53639amr18041847a91.8.1786037488273; 
 Thu, 06 Aug 2026 10:31:28 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39085e4a2a5sm1983711a91.14.2026.08.06.10.31.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 10:31:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 4/6] target/arm: Implement SCR_EL3.TID3
Date: Thu,  6 Aug 2026 10:31:21 -0700
Message-ID: <20260806173123.333423-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806173123.333423-1-richard.henderson@linaro.org>
References: <20260806173123.333423-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c        | 17 +++++++++++++++--
 target/arm/tcg/op_helper.c |  4 +++-
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8ab0075628..854c8902b8 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5894,8 +5894,21 @@ static CPAccessResult access_v7a_tid3(CPUARMState *env, const ARMCPRegInfo *ri,
      * Any other registers in the TID3 trap space should use access_tid3(),
      * so that they trap on v8 and above, but not on v7.
      */
-    if ((arm_current_el(env) < 2) && (arm_hcr_el2_eff(env) & HCR_TID3)) {
-        return CP_ACCESS_TRAP_EL2;
+    switch (arm_current_el(env)) {
+    case 1:
+        if (arm_hcr_el2_eff(env) & HCR_TID3) {
+            return CP_ACCESS_TRAP_EL2;
+        }
+        /* fall through */
+    case 2:
+        if (env->cp15.scr_el3 & SCR_TID3) {
+            return CP_ACCESS_TRAP_EL3;
+        }
+        break;
+    case 3:
+        break;
+    default:
+        g_assert_not_reached();
     }
 
     return CP_ACCESS_OK;
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 6d1feb5b33..a3486e87d5 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -1201,7 +1201,9 @@ void HELPER(tid3_udef_el1)(CPUARMState *env, uint32_t syndrome)
         target_el = 2;
         excp = EXCP_HYP_TRAP;
     } else if (is_a64(env)) {
-        if (!cpu_isar_feature(aa64_idst, env_archcpu(env))) {
+        if (env->cp15.scr_el3 & SCR_TID3) {
+            target_el = 3;
+        } else if (!cpu_isar_feature(aa64_idst, env_archcpu(env))) {
             syndrome = syn_uncategorized();
         }
     } else {
-- 
2.43.0


