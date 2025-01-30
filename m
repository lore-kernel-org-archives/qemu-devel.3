Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C03C02194
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 18:25:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdZCV-00041L-5p; Thu, 30 Jan 2025 13:23:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tdZCG-0003to-Qi
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 13:23:25 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tdZCE-0000Wj-QM
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 13:23:24 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3863c36a731so907438f8f.1
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 10:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738261401; x=1738866201; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yzUgHg6nqtrTZvIz3ixC5Nt4RQVPQXOj6ckfC4T6pic=;
 b=HwcyNL3oMwBo+d5Cx9dtQLo2wPmBss2ueuuURUumi+3Pi+v5TssmC3JjyxVNl6B+SL
 JUOCaDUqjzsg3/8laYZShSPnBQKoBOeDQkGXXsJlg03ipUHJbbjzGF0WvTWIsNVI+tJT
 Z8NEziDt7k4qPVkPPWykLfO2+yUqO/uJNe9hzj8C/+96Zw3ZLEs8mD8SKaRd8VHE+KIw
 pfSmKRd477kWuUOlhivJQExP+GMElIOK3zTLVVwL4QdGv59n4lubsa1DPQlWBWJsOxiy
 pccfSMK5IicD28ypFNrJu2nUotBUA0nH+MYBglhMFdlqDPBsdm+RFuJzjgj+Kie/k683
 1VRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738261401; x=1738866201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yzUgHg6nqtrTZvIz3ixC5Nt4RQVPQXOj6ckfC4T6pic=;
 b=hHWBD8VRNMx7k3JSF2DJM9QkRxth+smVldhyP15wkopid/7DXl8oDK11QnU3ez4UqR
 X5ERbpi66I2K4w/A/PEcsjBP7+/UX/FBrXcDzdUQt2TCeeK9nngpX8bXOMGdiycikw0K
 VATCLzQT6q5sqSTFjR5hGfhMku4KnH/A1II72Gn8C15O96ghxPx1PW+GoR0SP5I9MCBT
 uzloTV35BfdbXWiRREuv3v7CueJs2gndTZ3LqAWjEKbAzFrQflDrdSTrbnZvA9gBfVUy
 GOncgwJuXO3ul7ORPPTSovxyPce1NFnyqdT2VoPQwTm7hFOgUKvE1LzTXcVyUa5XJcti
 FwoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTzQcK1ymi4Qt7iaUFuHPxGo3Lv572g0L3XLEJyq4BXGDlcI5LZl+WRXoIN2ceV96SkYMCoFRcWuVH@nongnu.org
X-Gm-Message-State: AOJu0YyCtvJIZRJ2ZAJ314pqx3Vq7AyBPiLxGhYznsetkU0iqfYDHQbk
 n/YY5UQpThWZkMwpUQx710HhsHqVfLmr1vt98w6VsM+pnbj9KBOn8xsgtjJWcCI=
X-Gm-Gg: ASbGncvV4IcZFAUfRCg+mc1llUsGrf97rvLoc9CxaqXEut0lXJgfHICpN2P7oDw6xPq
 ObZr4H1wD/j5/vOef/RJ0DCnX6vRdve14kd+rhMWGOVc42ov7b58FTsXK0/1whd8CPAT+8vVqCe
 YYIB/kmXG7Z2GjpgZxPaS38zhRoIKEvgs33Xhk4fQ661Pc2+acBIZarZFafeTd75syoYvM0jwG6
 ONMUT7QEJeskEke7yo9UYJ0AJTGMWtKC3LziiGkEIW6PRP9i2IG3q2P92lpA9N8n/YeZESEYn36
 9qSflfn+nRCzVT6zfm1lRA==
X-Google-Smtp-Source: AGHT+IE8KcPPbbX+/lcvomWZbLlt2xTmnRV4Djr3ywWNrv8azlYXfRd8F3odOCzEuERXlxchvO0xXQ==
X-Received: by 2002:a5d:64a1:0:b0:385:f0dc:c9f4 with SMTP id
 ffacd0b85a97d-38c51967de4mr6882576f8f.20.1738261400830; 
 Thu, 30 Jan 2025 10:23:20 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c101599sm2634426f8f.23.2025.01.30.10.23.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2025 10:23:20 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 09/14] target/arm: Support CP_ACCESS_TRAP_EL1 as a
 CPAccessResult
Date: Thu, 30 Jan 2025 18:23:04 +0000
Message-Id: <20250130182309.717346-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250130182309.717346-1-peter.maydell@linaro.org>
References: <20250130182309.717346-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

In the CPAccessResult enum, the CP_ACCESS_TRAP* values indicate the
equivalent of the pseudocode AArch64.SystemAccessTrap(..., 0x18),
causing a trap to a specified exception level with a syndrome value
giving information about the failing instructions.  In the
pseudocode, such traps are always taken to a specified target EL.  We
support that for target EL of 2 or 3 via CP_ACCESS_TRAP_EL2 and
CP_ACCESS_TRAP_EL3, but the only way to take the access trap to EL1
currently is to use CP_ACCESS_TRAP, which takes the trap to the
"usual target EL" (EL1 if in EL0, otherwise to the current EL).

Add CP_ACCESS_TRAP_EL1 so that access functions can follow the
pseudocode more closely.

(Note that for the common case in the pseudocode of "trap to
EL2 if HCR_EL2.TGE is set, otherwise trap to EL1", we handle
this in raise_exception(), so access functions don't need to
special case it and can use CP_ACCESS_TRAP_EL1.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpregs.h        | 1 +
 target/arm/tcg/op_helper.c | 6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 1759d9defbe..fbf5798069d 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -331,6 +331,7 @@ typedef enum CPAccessResult {
      * 0xc or 0x18).
      */
     CP_ACCESS_TRAP = (1 << 2),
+    CP_ACCESS_TRAP_EL1 = CP_ACCESS_TRAP | 1,
     CP_ACCESS_TRAP_EL2 = CP_ACCESS_TRAP | 2,
     CP_ACCESS_TRAP_EL3 = CP_ACCESS_TRAP | 3,
 
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 1ba727e8e9f..c427118655d 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -781,7 +781,7 @@ const void *HELPER(access_check_cp_reg)(CPUARMState *env, uint32_t key,
      * the other trap takes priority. So we take the "check HSTR_EL2" path
      * for all of those cases.)
      */
-    if (res != CP_ACCESS_OK && ((res & CP_ACCESS_EL_MASK) == 0) &&
+    if (res != CP_ACCESS_OK && ((res & CP_ACCESS_EL_MASK) < 2) &&
         arm_current_el(env) == 0) {
         goto fail;
     }
@@ -887,6 +887,9 @@ const void *HELPER(access_check_cp_reg)(CPUARMState *env, uint32_t key,
     case 0:
         target_el = exception_target_el(env);
         break;
+    case 1:
+        assert(arm_current_el(env) < 2);
+        break;
     case 2:
         assert(arm_current_el(env) != 3);
         assert(arm_is_el2_enabled(env));
@@ -895,7 +898,6 @@ const void *HELPER(access_check_cp_reg)(CPUARMState *env, uint32_t key,
         assert(arm_feature(env, ARM_FEATURE_EL3));
         break;
     default:
-        /* No "direct" traps to EL1 */
         g_assert_not_reached();
     }
 
-- 
2.34.1


