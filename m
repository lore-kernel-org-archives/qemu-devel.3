Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0DF8CD5BD0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:31:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsoS-0003Eb-RN; Tue, 26 May 2026 10:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmy-0001ex-DN
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:50 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmw-0001Ve-0C
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:47 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-49056b9f04aso40329775e9.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779805784; x=1780410584; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=C8LTepMhdhYYWsj5ukZo6Hqe529dZMs/c5IW2NmqJJ4=;
 b=zDVclAYiRTMPIuuehi0pqD1CXJ8OMWuIq+to3kZLXVPaEau7QCcAvXk2XPDWjFjFHB
 O+WS0x5Dw/miSHGHaHf5FLlDI72dZU5DibVR2kajXNXoAMXWMpwd2/7CbaDJ+xzjB11m
 8PecvHkVMiUtZB7J+Si2tu0IWSko96H2ECy57X0Ayf4oIStZnJqbXs9DtCzHAAWH6h4r
 IAYsQTlff7d9rHuUe0UJSXZJ1FmdVLU42K3vFJ9HYEUFfd/2YTJHP1MK/I8OfxCeoaq8
 h7nK0vAelvGd4pATzWOtMDGP4C8nK547sEnXszdwD1RDeCqzWhX8DRc31ljmSwxjxtYO
 c9Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779805784; x=1780410584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=C8LTepMhdhYYWsj5ukZo6Hqe529dZMs/c5IW2NmqJJ4=;
 b=SwStxSFZBe+sppXpa0PZabwUC1pg5lTgiVl9V1oI+JgFUExh9PUEW0N25WN6B96AQN
 QAgjdtw5J0sFG2UnwQh7x04qbvEdFo2QDzupE9DQrKVOHY7riqZ7ix9NfcLHvjnXyA3X
 vGgxTHdabpRne0szhtlEU4dap+0pHOzPKpRjaGPHAb3GkXmlY9QgfcxMB2FBuqI/sIun
 kd82RUDlPHqGTDsg8qygJ1R6XYNoA/J8HinyP9QahsqhME6r2kvxB0SrHrTCdJxHQijr
 hwvt+7m4PcZzJlGPRytchae/MLiCUqdNk6SssrJitnSSDvaHkP2H7dT3lttKgju1lpC9
 QOtA==
X-Gm-Message-State: AOJu0Yw3eakUJV1u/21Ms+1TYRpo4p20Jpzpl1fsZ4hFS7alWLB6bojH
 3e5xVSP8AAASG6TBD+g1+SIIUtMYQ4/VyIQ/T3nBncBC86vT8FBJDZMDG/gsbsnGKvAmcX/FGav
 4KW7b
X-Gm-Gg: Acq92OHijUP07P6PE/MkGRtqXrDP++vzLxhXOjjbL8I5VQYA69GUnvYjO8dzWgVjxsZ
 N3ad1qX7HnnT52nBKyUg0oBJT124gmkXc9Ug6ebiKpuoZ5NHSM/R4hN5/oXDxxpO3xZ/jVzXfC1
 qrIeUf7pVVCUrxkPcrHSzDo+rHt8gAYjPOL/GlLFPwJFHFN3lvKezBPzawu0gtqaWFCgya+Yu88
 Yh2WKLyaRlyb/GBgEwiZRiGcFAXUvhvfF8+HPDhEb0ANsSJUtCnsAtRfFFZRh2t8B2PoxrXzSZ0
 zlBM5bdregTw2bmG29nyEX40xpycaxpEr8+RswuLY7cLam4LlrbKgmEpqNITn0IkxcpkRPWZvQh
 JiIYmvtQEmO8oMgUFw0xSPhjsytxcbeMqnSfeRAHt/UdFCqcICkdEbPlTE7tsCpLaz+ALEoKnur
 gWoscs0TpUZ4EbGTP9AjJGDuvtTzz6+KUGSHXHnCD7lWT63FHSyw1F6eGXCLTWJNPiT5GkFi25S
 HhHNj9ERUiFGxNijjXENac5CtblzT+4kHBbxzMrCg==
X-Received: by 2002:a05:6000:26c4:b0:44a:2555:f8a9 with SMTP id
 ffacd0b85a97d-45eb369072emr31076759f8f.10.1779805784330; 
 Tue, 26 May 2026 07:29:44 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d70c51sm38325225f8f.36.2026.05.26.07.29.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:29:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 54/54] target/arm: Move vectors_overlap to vec_internal.h
Date: Tue, 26 May 2026 15:28:50 +0100
Message-ID: <20260526142850.2326589-55-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526142850.2326589-1-peter.maydell@linaro.org>
References: <20260526142850.2326589-1-peter.maydell@linaro.org>
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

From: Richard Henderson <richard.henderson@linaro.org>

We will shortly need this outside of sme_helper.c.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260522220306.235200-24-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sme_helper.c   | 6 ------
 target/arm/tcg/vec_internal.h | 8 ++++++++
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index ab5999c592..0055e97a2b 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -33,12 +33,6 @@
 #define HELPER_H "tcg/helper-sme-defs.h"
 #include "exec/helper-info.c.inc"
 
-static bool vectors_overlap(ARMVectorReg *x, unsigned nx,
-                            ARMVectorReg *y, unsigned ny)
-{
-    return !(x + nx <= y || y + ny <= x);
-}
-
 void helper_set_svcr(CPUARMState *env, uint32_t val, uint32_t mask)
 {
     aarch64_set_svcr(env, val, mask);
diff --git a/target/arm/tcg/vec_internal.h b/target/arm/tcg/vec_internal.h
index 758e3db1c3..84f7f15228 100644
--- a/target/arm/tcg/vec_internal.h
+++ b/target/arm/tcg/vec_internal.h
@@ -21,6 +21,7 @@
 #define TARGET_ARM_VEC_INTERNAL_H
 
 #include "fpu/softfloat.h"
+#include "vector-type.h"
 
 typedef struct CPUArchState CPUARMState;
 
@@ -463,6 +464,13 @@ static inline void depositn(uint64_t *p, unsigned pos,
     }
 }
 
+/* Determine if [x, x+nx) overlaps [y, y+ny). */
+static inline bool vectors_overlap(ARMVectorReg *x, unsigned nx,
+                                   ARMVectorReg *y, unsigned ny)
+{
+    return !(x + nx <= y || y + ny <= x);
+}
+
 #define DO_3OP(NAME, FUNC, TYPE) \
 void HELPER(NAME)(void *vd, void *vn, void *vm,                            \
                   float_status * stat, uint32_t desc)                      \
-- 
2.43.0


