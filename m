Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5F17C02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 10:28:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcMKj-0001ou-3m; Mon, 27 Jan 2025 05:27:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcMKh-0001nl-Ik
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 05:27:07 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcMKg-00020L-08
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 05:27:07 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3862ca8e0bbso3740627f8f.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 02:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737973624; x=1738578424; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6f/oCQzbSHImCkqqj0iWpdHWh0qIumN7VF7msGHxoiQ=;
 b=WVsimMEr5Q8ALD1rQSewmMpV/y4QRt8cEACLKRFlhGjyZAPxGSWmCCjwRVFp82uW9g
 yuCFyCly6FPXXYDbl32vzpZGZ5XKYSViREQlJOnTbTs5V5WFaoglVoyARSTdhAWcPnfC
 FPaTkg/0vYtEnVlmJrdKEzoKLpETBeO/OPQyZliJ4Xmqag1HqiBpW+IvG2BFnZMwW8SR
 W92qC8/ryI1St5QN91mR43ceE0zR9Ho9m7FlSGET3zCbEHAK1//RTn4NpXiVCcpK+SfZ
 T+1HZk47s0BI1gIpE2Y6MG1LBFVwyuogeM4kixlN8Y1rBX6WB/vdeilwyu9o0p7BIIWO
 UqrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737973624; x=1738578424;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6f/oCQzbSHImCkqqj0iWpdHWh0qIumN7VF7msGHxoiQ=;
 b=fVZHmkFh5z640vOlsco3fMCrUv2Uy4fGxKLqNy5GGhZuSI2vt3nB10jmrNCgyLV6a1
 PJ6nBNaNFEehjcH1Dyay3kYO8X1XQXjhW6ImUx8yLOvKGxsSs8rdQcKQB4UNzj4Vo8Nb
 5PIh4HfjtFiD+HMZtwevg+ZGJxJQWiJ1LQA8qR/j6sH5Yglx/Eh6J/Peu2CmnYQnbC7u
 tmJCdLGexNRPd+z5c7rFc2tkfNIjgZzjMyAHvjx7PEjvy4JcKffaU01uk/MR1W0vlit4
 Y9LlDqrSOsiJfPnlyZxqSX3AczvVGjd+nV8lmtIoehHWUXZ9YxZlBELvMr74okpph5eQ
 kNcA==
X-Gm-Message-State: AOJu0YyqrSDE5gAL8ertdQMkdhc74c4uSmpOfeP7Et4+pVgp3X7vxjtj
 0K7Gkr7voomYT8nm5Xlym8NiXP3/T0CyB/EMWPcZga4BXHR8gc9k/H1vYAs+Dgejfq/iIhzdmwJ
 0XiA=
X-Gm-Gg: ASbGncvrARFXAocdaECYP7HpDMgsFIDKJs1+6S7GXMW4Wl/KCNZabg3gSObOhD0ebse
 dLm/27ZldzBzA+T7xIn13TT/siAYIqJ7A14SA9IRnDKfcRKHQVUj5LP2282dMx+3hpGoFywXE6D
 xomhxehDhkMkBiR0uCGSQxhkSxyNrmAh+EdPxRdFgyaJUxTmxie4IcL2RFxmCJPR6ywhD1tBKzI
 ZBaapG7CtPaiUWaZVqptA3FdM7YdGoKmMEXTCIMKAx4Wr2YzZUVGRfKGSwaQn+XrXGQJWEgBNzp
 8my3YiZ6yY7T1IXX1Vj5BzjA0ie8JtO+J+untKG36mY+wZDQypt8B9o=
X-Google-Smtp-Source: AGHT+IHKY4zpJ+Gd7D4UzSDXFDjqa/RMfwPhSQuRiDfLCbdZnsx5rGuZannld7SpPTG2q2HrZrxhCQ==
X-Received: by 2002:a5d:588f:0:b0:38a:418e:1179 with SMTP id
 ffacd0b85a97d-38bf5649b27mr38869506f8f.2.1737973624175; 
 Mon, 27 Jan 2025 02:27:04 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a17d6casm10931501f8f.30.2025.01.27.02.27.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Jan 2025 02:27:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 09/15] target/ppc: Restrict exception helpers to TCG
Date: Mon, 27 Jan 2025 11:26:13 +0100
Message-ID: <20250127102620.39159-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250127102620.39159-1-philmd@linaro.org>
References: <20250127102620.39159-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Move exception helpers to tcg-excp_helper.c so they are
only built when TCG is selected.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/excp_helper.c     | 34 --------------------------------
 target/ppc/tcg-excp_helper.c | 38 ++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 34 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 9e1a2ecc36f..6a12402b23a 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -2504,41 +2504,7 @@ bool ppc_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 
 #endif /* !CONFIG_USER_ONLY */
 
-/*****************************************************************************/
-/* Exceptions processing helpers */
-
-void raise_exception_err_ra(CPUPPCState *env, uint32_t exception,
-                            uint32_t error_code, uintptr_t raddr)
-{
-    CPUState *cs = env_cpu(env);
-
-    cs->exception_index = exception;
-    env->error_code = error_code;
-    cpu_loop_exit_restore(cs, raddr);
-}
-
-void raise_exception_err(CPUPPCState *env, uint32_t exception,
-                         uint32_t error_code)
-{
-    raise_exception_err_ra(env, exception, error_code, 0);
-}
-
-void raise_exception(CPUPPCState *env, uint32_t exception)
-{
-    raise_exception_err_ra(env, exception, 0, 0);
-}
-
 #ifdef CONFIG_TCG
-void helper_raise_exception_err(CPUPPCState *env, uint32_t exception,
-                                uint32_t error_code)
-{
-    raise_exception_err_ra(env, exception, error_code, 0);
-}
-
-void helper_raise_exception(CPUPPCState *env, uint32_t exception)
-{
-    raise_exception_err_ra(env, exception, 0, 0);
-}
 
 #ifndef CONFIG_USER_ONLY
 void helper_store_msr(CPUPPCState *env, target_ulong val)
diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
index 93c2d6b5a03..268a1614597 100644
--- a/target/ppc/tcg-excp_helper.c
+++ b/target/ppc/tcg-excp_helper.c
@@ -19,15 +19,53 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "exec/cpu_ldst.h"
+#include "exec/exec-all.h"
+#include "exec/helper-proto.h"
 #include "system/runstate.h"
 
+#include "helper_regs.h"
 #include "hw/ppc/ppc.h"
 #include "internal.h"
 #include "cpu.h"
 #include "trace.h"
 
+/*****************************************************************************/
+/* Exceptions processing helpers */
+
+void raise_exception_err_ra(CPUPPCState *env, uint32_t exception,
+                            uint32_t error_code, uintptr_t raddr)
+{
+    CPUState *cs = env_cpu(env);
+
+    cs->exception_index = exception;
+    env->error_code = error_code;
+    cpu_loop_exit_restore(cs, raddr);
+}
+
+void helper_raise_exception_err(CPUPPCState *env, uint32_t exception,
+                                uint32_t error_code)
+{
+    raise_exception_err_ra(env, exception, error_code, 0);
+}
+
+void helper_raise_exception(CPUPPCState *env, uint32_t exception)
+{
+    raise_exception_err_ra(env, exception, 0, 0);
+}
+
 #ifndef CONFIG_USER_ONLY
 
+void raise_exception_err(CPUPPCState *env, uint32_t exception,
+                                           uint32_t error_code)
+{
+    raise_exception_err_ra(env, exception, error_code, 0);
+}
+
+void raise_exception(CPUPPCState *env, uint32_t exception)
+{
+    raise_exception_err_ra(env, exception, 0, 0);
+}
+
 void ppc_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
                                  MMUAccessType access_type,
                                  int mmu_idx, uintptr_t retaddr)
-- 
2.47.1


