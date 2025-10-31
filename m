Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D31CCFA02
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 18:38:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEtxC-0004x6-TM; Fri, 31 Oct 2025 14:34:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtxA-0004wh-HB
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:34:24 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtwb-0006Ik-Ov
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:34:24 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-47117f92e32so22486325e9.1
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 11:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761935626; x=1762540426; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1GsqUplheU28z2VHmMdZVSwjMXPlWcvaPd3oIL/UheI=;
 b=pPl8CV2dUJpBVgyUTYf8PI1ZhJFwfiOHkONrQvFBXouYqD6xss7ePGDSi8wr33jffZ
 /bOM9uuYlSgQYIKY1dzmrXhZUyiVkd0nFPFPAMfZHxSzFlD9AoIArMMEM8QihrfeqUkb
 2qtqviyAXYQ8U2EjK4oSt6GleBl7EnbJSD7jigL8EbXMi0/20EG7PmmKpiI6KSQCPxUW
 cC6WWin0P1zHFsdyyq6gwmbcSgn+yb5jeQJZFUnlasBOcKbky9edcEKja3mXAq/oJRlj
 xyCDmCD4WnwZdlAcxQ2vsOt9O579QkLcPYQeW0Zg/0flIOferVAj05cZVZtUc6ISZwpS
 v9cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761935626; x=1762540426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1GsqUplheU28z2VHmMdZVSwjMXPlWcvaPd3oIL/UheI=;
 b=Mv2pod1zf0Q9ocP8Y6sWD+MjVKP13NOYM5TYZqSjDzuBmxmcGNx6aaBKIPVFGU7jXW
 TR0XYli7leUE+XgroovlVErW983kVFREdCklLqCdvYsPB5DD07piLriRY7MuvQBaT5KA
 9hF3iD960NuY0/xxRvThYmJXhAkvQOqM1E99hHfDPhmC22sg545sCIQEXh7gv6GenOCR
 BeTn0UPKu2/AV1DlXKeOw7n0pPcRSf63DwMIFBDuhrf0rVCFpfbX5xQHrNb7G9FeE5BE
 M+h98m/Gl1sbLImDlyWQtfPwXuk8ZGg+aFsrJmjePzEX2qguTp5SVwuIxLfd7DAgKIuq
 0flw==
X-Gm-Message-State: AOJu0YwuD3iPO6exfBnPP3xU2GPtaqR9G0cH63KM4VVRj71f96kSz2he
 As1MXW8figzWAxEEUVfuju7B3uswrZxYl3HUGi3Ri2w6FKVRciUjQ9ZFMZILKNwGeTYpPxMtynr
 dQBqo
X-Gm-Gg: ASbGncs8LR9h6UO6ETXl2iX4Cyq63xWht+Xmzf6VwChxxBqyLhQe1+g6AU57TBeGUDx
 tljBnwSoWVOLlWms0NhKow2LlzkyoIQiQpH9cDEitGxnHy1PKX2YzmLU4K9+eEam6bmSWDmy59N
 eFeiwwRdrwMFMhL9OnFQWAKuzz/8KA4NtXBkqw7qmMlKhp1szZ+778Ou0IGCg+/33TW5dW3R1n5
 vFdcYx4X5yDWzbCnN3u+S5GNzmAk2bt8uzWRPMXt9QmPDG4TsM6oMYWnz8AEnTtXM+csm+0kmA3
 fv5Jc04i8RXoeAGvb32UBeYEHCDlgCUKP2r1yAG8OlUhui6La9VWxmmEZf0I29k9tnx9LH5Z3eC
 K6tXbnlJNNPdWM3Er7lYS68Iqw1xXt9qCvTy9w8jeXGORIVpvgKkhtqugoM5dAH432mIg8cgUPR
 6+Gv38l3rpWEpdN9ER
X-Google-Smtp-Source: AGHT+IGHbCBKBpCScV3qeEbK7X+6hToD1chbyL4j/wL9aEmduf9HOalQ2d0AynE37oMJQl0oG3uFaw==
X-Received: by 2002:a05:600c:5249:b0:456:1b6f:c888 with SMTP id
 5b1f17b1804b1-47730870ba1mr45148005e9.23.1761935626590; 
 Fri, 31 Oct 2025 11:33:46 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c114c944sm4859142f8f.20.2025.10.31.11.33.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 11:33:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 36/38] target/arm: Share ARM_PSCI_CALL trace event between TCG
 and HVF
Date: Fri, 31 Oct 2025 18:33:08 +0000
Message-ID: <20251031183310.3778349-37-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031183310.3778349-1-peter.maydell@linaro.org>
References: <20251031183310.3778349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

It is useful to compare PSCI calls of the same guest running
under TCG or HVF.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c    | 3 ++-
 target/arm/tcg/psci.c   | 3 +++
 target/arm/trace-events | 3 +++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index a3bb71e63b9..f31b6e54ee7 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -34,6 +34,7 @@
 #include "target/arm/internals.h"
 #include "target/arm/multiprocessing.h"
 #include "target/arm/gtimer.h"
+#include "target/arm/trace.h"
 #include "trace.h"
 #include "migration/vmstate.h"
 
@@ -1025,7 +1026,7 @@ static bool hvf_handle_psci_call(CPUState *cpu)
     int target_el = 1;
     int32_t ret = 0;
 
-    trace_hvf_psci_call(param[0], param[1], param[2], param[3],
+    trace_arm_psci_call(param[0], param[1], param[2], param[3],
                         arm_cpu_mp_affinity(arm_cpu));
 
     switch (param[0]) {
diff --git a/target/arm/tcg/psci.c b/target/arm/tcg/psci.c
index cabed43e8a8..2d409301578 100644
--- a/target/arm/tcg/psci.c
+++ b/target/arm/tcg/psci.c
@@ -25,6 +25,7 @@
 #include "internals.h"
 #include "arm-powerctl.h"
 #include "target/arm/multiprocessing.h"
+#include "target/arm/trace.h"
 
 bool arm_is_psci_call(ARMCPU *cpu, int excp_type)
 {
@@ -79,6 +80,8 @@ void arm_handle_psci_call(ARMCPU *cpu)
          */
         param[i] = is_a64(env) ? env->xregs[i] : env->regs[i];
     }
+    trace_arm_psci_call(param[0], param[1], param[2], param[3],
+                        arm_cpu_mp_affinity(cpu));
 
     if ((param[0] & QEMU_PSCI_0_2_64BIT) && !is_a64(env)) {
         ret = QEMU_PSCI_RET_NOT_SUPPORTED;
diff --git a/target/arm/trace-events b/target/arm/trace-events
index 72a2c7d0969..676d29fe516 100644
--- a/target/arm/trace-events
+++ b/target/arm/trace-events
@@ -23,3 +23,6 @@ arm_powerctl_set_cpu_on(uint64_t mp_aff, unsigned target_el, const char *mode, u
 arm_powerctl_set_cpu_on_and_reset(uint64_t mp_aff) "cpu %" PRIu64
 arm_powerctl_set_cpu_off(uint64_t mp_aff) "cpu %" PRIu64
 arm_powerctl_reset_cpu(uint64_t mp_aff) "cpu %" PRIu64
+
+# tcg/psci.c and hvf/hvf.c
+arm_psci_call(uint64_t x0, uint64_t x1, uint64_t x2, uint64_t x3, uint32_t cpuid) "PSCI Call x0=0x%016"PRIx64" x1=0x%016"PRIx64" x2=0x%016"PRIx64" x3=0x%016"PRIx64" cpuid=0x%x"
-- 
2.43.0


