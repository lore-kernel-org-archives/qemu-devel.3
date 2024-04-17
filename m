Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74CE9C001CC
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 18:29:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxA2C-0001vT-CS; Wed, 17 Apr 2024 14:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxA2A-0001uJ-Po
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 14:29:26 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxA28-0003Vy-NL
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 14:29:26 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-418d1edcd4cso356145e9.1
 for <qemu-devel@nongnu.org>; Wed, 17 Apr 2024 11:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713378563; x=1713983363; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZshIaCnSYMR+iOE/aqIWZYs6swUMEabN3Qo8HFzzTJI=;
 b=bDtWhC1dbHTPHP686fHaNQU/xP48nLlKYqIScmeWRbACTCGQxwMysLkUGO1UNbDVLh
 CCpZgaJ4tmMhcUrm3dQ+RvE1xcirQOtN6zZj7Uxv+AN7IWHZ/llNkXMQeS2+kVRBk7uR
 kISLigrT0Jlo8cBnDlvHQ9Pvmqd2Lq9d10kyc1sqnMjoTxq/pApuhZtRRDFlNi2U4C4x
 Px7cQvtdLGzoc+pQbRUf96APMowdDnTMj3MLL+2Owx6HhakXKMsCNbzNBrKjOzGAIV3v
 gJAZhTB6NeqF7J/TrVnRcng9e1QdN8DiNsOFpoQNNhvyBpp4SHYHQMj2Ozmb57Ksygnk
 MPyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713378563; x=1713983363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZshIaCnSYMR+iOE/aqIWZYs6swUMEabN3Qo8HFzzTJI=;
 b=STyzvS2hosqTrutKodamOUCPKz1NRR/68NBV8yYERmsg7ZtykrlXQpxnXTViBFvLtL
 9zKasUBmtVDeNtJ722flRtP2+vpTIIiuqvuvMSQd+czhoyNhm63YdbdUN5hVhNtK9bsZ
 UHJ0a/hC1hcq/bqxfX/NWGV59oF7atri4EdCQzHo/TL9o/Jzlkd6w0a5WjSWlat3ZpYc
 EOu3OAqoE9ywLd4mfgDgyOh5DXKOE3E69AiUUyWCNH96wj32Qn8j9tf9amQ6JvCwFdBE
 k2/OJWbgCLP4ClpNBalp+J4CfQP5shWcYoTSJP+1pLuNDcrXW6dUHIZA8+TglB18ZRKQ
 2tYw==
X-Gm-Message-State: AOJu0YzMEtsNc32Rblty/aPOQBloh+7C3NctMwI7Jfpl44kwgBc58GPP
 SfV1s4ugRPbbodONINorU8HHVLZQr4kG8bnxFtAf3dDXFIx6KuQyMnCeb6k9fxHBovVUvc9nUJj
 P
X-Google-Smtp-Source: AGHT+IEgpVmXWcTo3cV1G6V6t1I8CnSWCLTBzbjqgH+992C9BTnZ86JvnM7BPFljQC+7YCVdqX6ISQ==
X-Received: by 2002:a05:600c:45c6:b0:416:3317:5951 with SMTP id
 s6-20020a05600c45c600b0041633175951mr292871wmo.6.1713378562840; 
 Wed, 17 Apr 2024 11:29:22 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.201.23])
 by smtp.gmail.com with ESMTPSA id
 g3-20020a05600c310300b00417bab31bd2sm3900751wmo.26.2024.04.17.11.29.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Apr 2024 11:29:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 13/21] accel/tcg: Un-inline retaddr helpers to 'user-retaddr.h'
Date: Wed, 17 Apr 2024 20:27:58 +0200
Message-ID: <20240417182806.69446-14-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240417182806.69446-1-philmd@linaro.org>
References: <20240417182806.69446-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

set_helper_retaddr() is only used in accel/tcg/user-exec.c.

clear_helper_retaddr() is only used in accel/tcg/user-exec.c
and accel/tcg/user-exec.c.

No need to expose their definitions to all user-emulation
files including "exec/cpu_ldst.h", move them to a new
"user-retaddr.h" header (restricted to accel/tcg/).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231211212003.21686-19-philmd@linaro.org>
---
 accel/tcg/user-retaddr.h | 28 ++++++++++++++++++++++++++++
 include/exec/cpu_ldst.h  | 28 ++--------------------------
 accel/tcg/cpu-exec.c     |  3 +++
 accel/tcg/user-exec.c    |  1 +
 4 files changed, 34 insertions(+), 26 deletions(-)
 create mode 100644 accel/tcg/user-retaddr.h

diff --git a/accel/tcg/user-retaddr.h b/accel/tcg/user-retaddr.h
new file mode 100644
index 0000000000..e0f57e1994
--- /dev/null
+++ b/accel/tcg/user-retaddr.h
@@ -0,0 +1,28 @@
+#ifndef ACCEL_TCG_USER_RETADDR_H
+#define ACCEL_TCG_USER_RETADDR_H
+
+#include "qemu/atomic.h"
+
+extern __thread uintptr_t helper_retaddr;
+
+static inline void set_helper_retaddr(uintptr_t ra)
+{
+    helper_retaddr = ra;
+    /*
+     * Ensure that this write is visible to the SIGSEGV handler that
+     * may be invoked due to a subsequent invalid memory operation.
+     */
+    signal_barrier();
+}
+
+static inline void clear_helper_retaddr(void)
+{
+    /*
+     * Ensure that previous memory operations have succeeded before
+     * removing the data visible to the signal handler.
+     */
+    signal_barrier();
+    helper_retaddr = 0;
+}
+
+#endif
diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index eb8f3f0595..82690d3947 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -300,31 +300,7 @@ Int128 cpu_atomic_cmpxchgo_be_mmu(CPUArchState *env, abi_ptr addr,
                                   Int128 cmpv, Int128 newv,
                                   MemOpIdx oi, uintptr_t retaddr);
 
-#if defined(CONFIG_USER_ONLY)
-
-extern __thread uintptr_t helper_retaddr;
-
-static inline void set_helper_retaddr(uintptr_t ra)
-{
-    helper_retaddr = ra;
-    /*
-     * Ensure that this write is visible to the SIGSEGV handler that
-     * may be invoked due to a subsequent invalid memory operation.
-     */
-    signal_barrier();
-}
-
-static inline void clear_helper_retaddr(void)
-{
-    /*
-     * Ensure that previous memory operations have succeeded before
-     * removing the data visible to the signal handler.
-     */
-    signal_barrier();
-    helper_retaddr = 0;
-}
-
-#else
+#if !defined(CONFIG_USER_ONLY)
 
 #include "tcg/oversized-guest.h"
 
@@ -376,7 +352,7 @@ static inline CPUTLBEntry *tlb_entry(CPUState *cpu, uintptr_t mmu_idx,
     return &cpu->neg.tlb.f[mmu_idx].table[tlb_index(cpu, mmu_idx, addr)];
 }
 
-#endif /* defined(CONFIG_USER_ONLY) */
+#endif /* !defined(CONFIG_USER_ONLY) */
 
 #if TARGET_BIG_ENDIAN
 # define cpu_lduw_data        cpu_lduw_be_data
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 5c70748060..225e5fbd3e 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -41,6 +41,9 @@
 #include "tb-context.h"
 #include "internal-common.h"
 #include "internal-target.h"
+#if defined(CONFIG_USER_ONLY)
+#include "user-retaddr.h"
+#endif
 
 /* -icount align implementation. */
 
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 3cac3a78c4..1c621477ad 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -31,6 +31,7 @@
 #include "tcg/tcg-ldst.h"
 #include "internal-common.h"
 #include "internal-target.h"
+#include "user-retaddr.h"
 
 __thread uintptr_t helper_retaddr;
 
-- 
2.41.0


