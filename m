Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 568FEC021B2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 16:25:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl9J0-0006lA-Vn; Thu, 20 Feb 2025 11:21:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9Iy-0006kE-PW
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:21:40 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9Ix-0008Bc-2r
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:21:40 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4399deda4bfso8249585e9.0
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 08:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740068497; x=1740673297; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Uaz0CXvJ+jRwAw9p9w2uUOsiAwOoUFB1H5GO76v3Lxo=;
 b=eMfNQIqrjI/okVVwFHs4l+331xHU38s4XX5HlHuAc5+3LzAe65hNFWoo8SjTIOjVm+
 L1d+a8jpitl+WYhjt8MhnpCssC1UJzjqH8psk0ultp0GGXYmVPLTp7y+1ZgTo+xosLQM
 DzyF8N5g8fBblIhLcBI3YhM7PftBQzMl4OVfhXqpRzoQSUPPIRZhdo04fOAzsDrVtaZY
 nlbeS2cU1yleb4Y0ceuicWq7fdcIFcUNsvy8oM0Omco0kU6+9AFW2oUW5esHBwHHxdVS
 ESBDrI68TYaa6b6g9+v11ako33R4FokdAnNEyylQwFKTY9cJwByw9wApqcq0b/dvW7Uy
 dPRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740068497; x=1740673297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Uaz0CXvJ+jRwAw9p9w2uUOsiAwOoUFB1H5GO76v3Lxo=;
 b=eoiGz++Bkbgz1J9MqNgdDpn5123AU3iXnFfQdcl6QV+1imYQnhmod++gsPlpnN/6+9
 nI5IhRnyIUhdwrrMHNWZgLHqFbKLAkhKEO+In/JCMkwP4RpvZjsEQu379214DABnxKgS
 fziHWOTh/BLbdSHqutzNqSy8t+Pp4zUluKVXm4XQGyw4M1JyEoCq6wEgUP8R1QoZ0o9c
 cFPMs0YBI8YuJSPKLLqEHDEWhOPV4Lj2kP64HMzs33DCXs8bsnTnheS9AoOGsZkW1wFa
 l1VrPrtbXPD68KdCO8u3wZCmzSR/QxjXuoLogZBH23oXNAZNU3iVisUQtaar3ACroC7o
 ydIQ==
X-Gm-Message-State: AOJu0YwSn9OGLPiO6Z1OVRLbznBeNWly4aSokjvX4bjQSetG8LHcFe18
 3Wp89MUdniQdZ7m+Z9DNU2Lpugy5GuuDQDcS3haex6I2w7k3jYE+wJdv64+UCGyLSiOkOvFJrh0
 E
X-Gm-Gg: ASbGnctK0jnFqzYsBGinuA57jqlllsvWWYhHcC8n1GRCHfW+1PpQLb3+krLprCdd9Ug
 O7MAWSXrpuNLGVl/gsL5+1ggLSp/cqmYpM1fycEEKxNb3KwYiUYxFjkSAt4YllqPdnLLlD3PyW2
 Q+qV9bw7WOcI90wgabbg4AZK+trU09r8Y4XozKy+rGNAx+5uigtSpiXzverr+UO9rTAxYaMMI2r
 RfUbHR0ebVcuyUM+JhRo+6QO71Z+G75VQ2JQG6ZXn1c/NgzTKF31ukk+jeW49tZZj9h1GIOPsuP
 OEaMA0Lfqx7l0Z5VEtF0Jw==
X-Google-Smtp-Source: AGHT+IFC3U6twhC50wG6U0TjIyBywndQHLwoBSMGcq7OTnU1Ipyh6XNA+I/nKsnTUwFgA7ciTBL4fg==
X-Received: by 2002:a05:600c:3b97:b0:439:a1ef:c242 with SMTP id
 5b1f17b1804b1-439a4932524mr32372645e9.0.1740068497504; 
 Thu, 20 Feb 2025 08:21:37 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4399d55fc1asm48806415e9.35.2025.02.20.08.21.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:21:36 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/41] target/arm: Support CP_ACCESS_TRAP_EL1 as a
 CPAccessResult
Date: Thu, 20 Feb 2025 16:20:50 +0000
Message-ID: <20250220162123.626941-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220162123.626941-1-peter.maydell@linaro.org>
References: <20250220162123.626941-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250130182309.717346-10-peter.maydell@linaro.org
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
2.43.0


