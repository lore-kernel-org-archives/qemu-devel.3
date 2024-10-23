Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA451D2E00A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 03:38:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3S9V-0007PB-SQ; Tue, 22 Oct 2024 23:35:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3S96-00070J-AR
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 23:34:54 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3S92-0008L7-J1
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 23:34:51 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-71e74900866so4267837b3a.1
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 20:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729654476; x=1730259276; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n7/ieuf1Sfgsx1D01jF/RZfRXby31shptLEkFmD0Tv8=;
 b=Jceim6yXSyhrul6JHdyVSfBang0kEbuGU8RtWEqusM2PhQCv1/xbPxEQW0NQmpZS/V
 SIzHaC3yZgDV4940FJHhnSl9aF3ZLmx0MiPiKqHx692IL5YGhjAEqQQglnr6VpVhEKV0
 mkoXEyK6RNRdw0t3IfFtsIIRdpDLFFOu8HPGXryx2ppDefKr8kjMTYrOT+xzn7bj/meu
 mBmcpj+lCAWeCWOuiwACdUCYLbvm3SNk6UAM+srXhCvohq0JhsE63KBrSnoaiWPVjP5z
 cy0T7JNj9mo41gb67mAu6B/82FM+G9bw1veglOz7jeLQqPtTxP1cJuBkc+WI60wkH5vZ
 h9sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729654476; x=1730259276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n7/ieuf1Sfgsx1D01jF/RZfRXby31shptLEkFmD0Tv8=;
 b=Y8MPZP9T9dugGLOAdLHCXLr+nFpq5b3KQsfLy1tkOeUHJ2Z3gDHsrPqgQTIimeAZNh
 AWhwX2qx1kcEmid++Nrr73KgBc4l0MrbC8bvjoUBhTXh5oKe9/YvRBpBa3AS3qyjF622
 DKmvwtTAIGuPj8C2Nd717ssEC8Xk1Lb101o0mKsHWTMEnTtV7mIo9l9OqG31GeLpLmLs
 pALZ/YgVBoka5yR2vHbLo7SI5xH4jlPM1voH4ss9/4t9WeSw+c3MCaK7ji27wmWJDDVQ
 JTrJqxMdygAOmbaNd+l7FkqRseQYAAPEo9lhE8N/FCmwuYYnki5hT3ryh+itJ8ZRMof3
 3InA==
X-Gm-Message-State: AOJu0Yx+mKbKvYMO4McP+LeJwld3MlnC3ANRMNWYU5CNEQx0AOnYoUkn
 UYe5fwX6su/DSXHpGI++XMECKvY+erVTVnvj456duChCTEM700xrStV9By5vUE7pq1xU2oORM8m
 s
X-Google-Smtp-Source: AGHT+IGrfgnNLWn1TmIN1hovvN3cZY/aHuE58iAK+ZQ/UDdLnN5FPuJOoyB07QKjgtH/8bAX+q05dg==
X-Received: by 2002:a05:6a00:4f90:b0:71e:68ae:aae1 with SMTP id
 d2e1a72fcca58-72030b936f1mr2008282b3a.19.1729654476205; 
 Tue, 22 Oct 2024 20:34:36 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71ec13d73b1sm5438338b3a.105.2024.10.22.20.34.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 20:34:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 03/24] util: Add RISC-V vector extension probe in cpuinfo
Date: Tue, 22 Oct 2024 20:34:11 -0700
Message-ID: <20241023033432.1353830-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023033432.1353830-1-richard.henderson@linaro.org>
References: <20241023033432.1353830-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>

Add support for probing RISC-V vector extension availability in
the backend. This information will be used when deciding whether
to use vector instructions in code generation.

Cache lg2(vlenb) for the backend. The storing of lg2(vlenb) means
we can convert all of the division into subtraction.

While the compiler doesn't support RISCV_HWPROBE_EXT_ZVE64X,
we use RISCV_HWPROBE_IMA_V instead. RISCV_HWPROBE_IMA_V is more
strictly constrainted than RISCV_HWPROBE_EXT_ZVE64X. At least in
current QEMU implemenation, the V vector extension depends on the
zve64d extension.

Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Tested-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20241007025700.47259-2-zhiwei_liu@linux.alibaba.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/riscv/host/cpuinfo.h |  2 ++
 util/cpuinfo-riscv.c              | 34 ++++++++++++++++++++++++++++++-
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/host/include/riscv/host/cpuinfo.h b/host/include/riscv/host/cpuinfo.h
index 2b00660e36..cdc784e7b6 100644
--- a/host/include/riscv/host/cpuinfo.h
+++ b/host/include/riscv/host/cpuinfo.h
@@ -10,9 +10,11 @@
 #define CPUINFO_ZBA             (1u << 1)
 #define CPUINFO_ZBB             (1u << 2)
 #define CPUINFO_ZICOND          (1u << 3)
+#define CPUINFO_ZVE64X          (1u << 4)
 
 /* Initialized with a constructor. */
 extern unsigned cpuinfo;
+extern unsigned riscv_lg2_vlenb;
 
 /*
  * We cannot rely on constructor ordering, so other constructors must
diff --git a/util/cpuinfo-riscv.c b/util/cpuinfo-riscv.c
index 8cacc67645..971c924012 100644
--- a/util/cpuinfo-riscv.c
+++ b/util/cpuinfo-riscv.c
@@ -4,6 +4,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/host-utils.h"
 #include "host/cpuinfo.h"
 
 #ifdef CONFIG_ASM_HWPROBE_H
@@ -13,6 +14,7 @@
 #endif
 
 unsigned cpuinfo;
+unsigned riscv_lg2_vlenb;
 static volatile sig_atomic_t got_sigill;
 
 static void sigill_handler(int signo, siginfo_t *si, void *data)
@@ -34,7 +36,7 @@ static void sigill_handler(int signo, siginfo_t *si, void *data)
 /* Called both as constructor and (possibly) via other constructors. */
 unsigned __attribute__((constructor)) cpuinfo_init(void)
 {
-    unsigned left = CPUINFO_ZBA | CPUINFO_ZBB | CPUINFO_ZICOND;
+    unsigned left = CPUINFO_ZBA | CPUINFO_ZBB | CPUINFO_ZICOND | CPUINFO_ZVE64X;
     unsigned info = cpuinfo;
 
     if (info) {
@@ -50,6 +52,10 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
 #endif
 #if defined(__riscv_arch_test) && defined(__riscv_zicond)
     info |= CPUINFO_ZICOND;
+#endif
+#if defined(__riscv_arch_test) && \
+    (defined(__riscv_vector) || defined(__riscv_zve64x))
+    info |= CPUINFO_ZVE64X;
 #endif
     left &= ~info;
 
@@ -69,11 +75,22 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
 #ifdef RISCV_HWPROBE_EXT_ZICOND
             info |= pair.value & RISCV_HWPROBE_EXT_ZICOND ? CPUINFO_ZICOND : 0;
             left &= ~CPUINFO_ZICOND;
+#endif
+            /* For rv64, V is Zve64d, a superset of Zve64x. */
+            info |= pair.value & RISCV_HWPROBE_IMA_V ? CPUINFO_ZVE64X : 0;
+#ifdef RISCV_HWPROBE_EXT_ZVE64X
+            info |= pair.value & RISCV_HWPROBE_EXT_ZVE64X ? CPUINFO_ZVE64X : 0;
 #endif
         }
     }
 #endif /* CONFIG_ASM_HWPROBE_H */
 
+    /*
+     * We only detect support for vectors with hwprobe.  All kernels with
+     * support for vectors in userspace also support the hwprobe syscall.
+     */
+    left &= ~CPUINFO_ZVE64X;
+
     if (left) {
         struct sigaction sa_old, sa_new;
 
@@ -113,6 +130,21 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
         assert(left == 0);
     }
 
+    if (info & CPUINFO_ZVE64X) {
+        /*
+         * We are guaranteed by RVV-1.0 that VLEN is a power of 2.
+         * We are guaranteed by Zve64x that VLEN >= 64, and that
+         * EEW of {8,16,32,64} are supported.
+         */
+        unsigned long vlenb;
+        /* csrr %0, vlenb */
+        asm volatile(".insn i 0x73, 0x2, %0, zero, -990" : "=r"(vlenb));
+        assert(vlenb >= 8);
+        assert(is_power_of_2(vlenb));
+        /* Cache VLEN in a convenient form. */
+        riscv_lg2_vlenb = ctz32(vlenb);
+    }
+
     info |= CPUINFO_ALWAYS;
     cpuinfo = info;
     return info;
-- 
2.43.0


