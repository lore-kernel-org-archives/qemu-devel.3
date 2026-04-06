Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0325F46C45
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 15:07:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9lVi-000356-UB; Mon, 06 Apr 2026 11:05:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9lVh-00034R-Ub
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 11:05:05 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9lVg-0003zw-9Y
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 11:05:05 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2b23fcf90b2so39234965ad.3
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 08:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775487903; x=1776092703; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FGhpyO9gJO4O10TYeQgNeX96IysIFLL6455aGE1zsuw=;
 b=Z2bFQWjre+WEJltX4vGtJcFXD7rFrUGo5ddkiaAPtbowxdqRm0iJ0R9++G0lsvXyy9
 +FO2dz99A3eYomVxEE7DuszwwRTdDnOCsFCKAggXJNUJXYr2SIo6yMcoCLjFVLA+O7rL
 XLHwbmJgiINF7Jz53dZF8dBrQFI90c2LTHQ3hr7wY5S7fO3BHylwWumAMkaDS9lSs1Wa
 rD94RQOqtAqWTwueLnvH8aoq+mYfnMXpIcuNoHx9pqg97VB3x9Ogh1t5aDnRr92PMqYk
 J7/PoAbhFhm2X2Rqjh9mdpCRVDL9NdUCCYHMvG4jifMQr6SnymUEVpmq4gEWtnSHUeaK
 qryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775487903; x=1776092703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FGhpyO9gJO4O10TYeQgNeX96IysIFLL6455aGE1zsuw=;
 b=R9ONRYkJlrLsjkCWKKn8auh8VrGkNgASJuciAbPnqd0Qz6Gw1UhdXnnjrkvavuhthO
 +PRF+eqjR7FfIExMW4W2ARjTCK4S8w/O6ELEFaIhudbz5aJ1NaIPX/RICOdxU7u1V5s/
 agwpo5artxJo7Ao4g19JGYKquC3Dr2YuwIg/EUSb/J9knGhf+xbWgqCaKUKWJa7CyD5d
 /xQjlQFsbrXewMM+tvkAaYRlqZVBZYJ9klvJ45wHRU4OZi779bq7W2ZoUntSg5U4V0te
 StUD8lwAGS7rA64hoKqyl6hjhNKMziVTsB4TK5CE1UMPUiLv6DXDyhABhbNa84H/gcHa
 fNVA==
X-Gm-Message-State: AOJu0Yz8JxAGEgBp4+m3d27UHEe8zgX4YDvVOJi74CqSNNKWI46litDt
 N0ONVqJbYCjhWQJSHqUyImEyk6gBnNp2T1DAo3yLL+VoUfeFZ/aoHPWjZMq+7PP5/VuiAP8q1q2
 K7AHs3/BKrw==
X-Gm-Gg: AeBDietOZ6uCENScUh5SsBw3DBQQaGtz1tI4LnxN8ZRps5gzgZLEFvj9s2ZMEjtcD2T
 8QhoZo59fjfyilPMuTEgeUCMl6FFsAUK3PHzopSyR+B6tKoL9S4JaYm0KIwOTQ5O/cPODPTpZ9H
 uMFBFq3eH1h/vF9F3iDxDtT/E0nVQKN1Qy8Fyg+8kS+1bSRxPPZsomgZHY01fjbNklTC1w72eca
 Hsem/Ul/8EKXxkW5gVd6cCkJkE185f9CqG9N0eGDCrAhHX/sbI6j4jY1TxjYBWxGhveml5MuQzf
 x1gVXHu0N5VbWWwgZuElGrhJlSxTMnYHNb9wkhXTHMtydg19aP19tvw6yTQ7+/fePJu2+vw/AcV
 ym6nIb4lmPOv1qYoHrwBvV5oNFtkI7cObDTED2uz/U7S0ah6RzM+a+McJzsXVW/N4D8sd4YxbwH
 X2E6x7VZQ6jLamkBso+gxCDAyb+yjdmvM5Lr0K8wFspSGB6bJr/xetGjXYaz1edXstp1IniVQGX
 bKW
X-Received: by 2002:a17:902:d2c8:b0:2b2:523f:50d with SMTP id
 d9443c01a7336-2b281802cacmr137309205ad.29.1775487902680; 
 Mon, 06 Apr 2026 08:05:02 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b274979d72sm137770075ad.51.2026.04.06.08.05.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 08:05:02 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, philmd@linaro.org,
 jim.macarthur@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v7 09/14] target/arm/tcg/op_helper.c: make compilation unit
 common
Date: Mon,  6 Apr 2026 08:04:29 -0700
Message-ID: <20260406150434.407201-10-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260406150434.407201-1-pierrick.bouvier@linaro.org>
References: <20260406150434.407201-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

Remove unused header accel/tcg/cpu-ldst.h that has target specifics.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/op_helper.c | 1 -
 target/arm/tcg/meson.build | 3 ++-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index aa14f15eb62..75ad53ec6c6 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -23,7 +23,6 @@
 #include "helper.h"
 #include "internals.h"
 #include "cpu-features.h"
-#include "accel/tcg/cpu-ldst.h"
 #include "accel/tcg/probe.h"
 #include "cpregs.h"
 
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 70beec7a6c9..1fa26670587 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -37,7 +37,6 @@ arm_ss.add(files(
   'translate.c',
   'm_helper.c',
   'mve_helper.c',
-  'op_helper.c',
 ))
 
 arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
@@ -74,6 +73,7 @@ arm_common_system_ss.add(
   'debug.c',
   'hflags.c',
   'neon_helper.c',
+  'op_helper.c',
   'psci.c',
   'tlb_helper.c',
   'tlb-insns.c',
@@ -93,6 +93,7 @@ arm_user_ss.add(
   'debug.c',
   'hflags.c',
   'neon_helper.c',
+  'op_helper.c',
   'tlb_helper.c',
   'translate-m-nocp.c',
   'translate-mve.c',
-- 
2.47.3


