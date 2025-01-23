Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F341C0218B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 21:57:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tb5CB-00053A-8x; Thu, 23 Jan 2025 16:57:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb5CA-00052k-1V
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 16:57:02 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb5C7-0002pq-SW
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 16:57:01 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43618283d48so10535395e9.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 13:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737669418; x=1738274218; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6f/oCQzbSHImCkqqj0iWpdHWh0qIumN7VF7msGHxoiQ=;
 b=BTm3CAQ9gNi1mjL1hrGVYtOGJ303BmXw8wfU9snOgrLnYcfVXjnaq0Yh6QOR/Xcsfo
 KlpefdYKvlivcwOKrPCllTpAYiufDLNFmBbbigqMpUzRuqq+nmrJPer3YiHOCNGS5n3S
 icd5akML7bkilO6QKN+eI8TFawsrB2q7qj0uOvXR8Yqeh5ifDg3fZ7cC7db4MjSQ1omC
 co4wHky/f+RLZ3E5+O4wEKoPEcfhpMI4N78B3pL11Kygv6IeJu09GtoSfUSqMM4fcHEU
 3E8VG7RjdE3qGecFjA0FxOMqW4rDXJ1rzfWstsWqsaXFRAk3AaNVw12kUokrmT7M8533
 XF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737669418; x=1738274218;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6f/oCQzbSHImCkqqj0iWpdHWh0qIumN7VF7msGHxoiQ=;
 b=ZghVJKGE8u4AE4q5NsRqqLtN41jVupCv/NK3BmmYeN5a//dCc+eP/tkky4zqxdZyjh
 hSrlmJvjRWoN55FVh80y+l7DIoeLorJ+uGJbfB4kLAwO9QHfaPpv4jAXY/fP+DEDIL82
 AhPmvKBJEYW5zjt6ZKNzaaf/sN/JM8rSXV1PtzhJbVrrHFJKi9GDnFjp2IYO0qix85gh
 c7i2nVlJJxTuNWTIm1BlYrW8BldPm+qKDdOXuGF7sTGjg1MeP8ZflEPqAalRs+yi5WZV
 yrJanjBRYmjMIJeQZ2GOlQJv0cHhAmanaJuj9Y3yqGvTrD1bBUZG4AKftLu9v5dkxiZJ
 wBhw==
X-Gm-Message-State: AOJu0YzclEvTFi1ymghqdso1x/agdkRZWzHPiZhXjY//Ybm6oOYO0PL6
 fv9fIcd6DGWr5ebkJ0VOWiBpZbEJloxC1sTBiuFUu/tzFSNFImC2GlgZj6iDjkaAtliqAcGFa6V
 GDy0=
X-Gm-Gg: ASbGnct9covRYCLAHI+J/JVwMOPglmuf8cYf6g8qraWQpUiGVhJjLRX7e2yE9xAO+wq
 WRV5tOHSQs0Z/u42t2sOPlHUkUyfmVw/g5UrZGTUabQrcC2epmZ/3hU+sXOWs0NDEoJInAWh2EA
 6mFrhjsCVRdwStgARnec0dwEUBQGZ9SXL7C7CD1mtvvj+SZ6ZPG794NWKaMuz5G4Z48AAVF1UMj
 yeq9k0PHC3/WhL4lg0hrYGE8CI5G0qWedMDXwCBTNDvzLdKVg81b2wLRq20/AlTI1PAavhirTE2
 fszRQhieDpE7L2kQMIh/9LDwVkGxhPKeLpSVx4rY18qhiyoc18zOtCjg+kVmeUIkGQ==
X-Google-Smtp-Source: AGHT+IE9D9uF3hMFhk5DwbjzauucxAZ75BZP9UVMKTo5NU1iwvbbfmA9msQYyzjEQDbMrt5nkf1zXQ==
X-Received: by 2002:a5d:6a92:0:b0:386:3403:7b63 with SMTP id
 ffacd0b85a97d-38bf57b3d42mr17860596f8f.36.1737669418137; 
 Thu, 23 Jan 2025 13:56:58 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1bb040sm785629f8f.67.2025.01.23.13.56.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Jan 2025 13:56:57 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 09/15] target/ppc: Restrict exception helpers to TCG
Date: Thu, 23 Jan 2025 22:56:03 +0100
Message-ID: <20250123215609.30432-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250123215609.30432-1-philmd@linaro.org>
References: <20250123215609.30432-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


