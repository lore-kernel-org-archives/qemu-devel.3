Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7196FC3065C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 23:43:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOn8f-0007pw-VA; Tue, 02 Jul 2024 19:42:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sOn8O-0007lF-LM
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 19:42:05 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sOn8L-0006NJ-9c
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 19:42:04 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1f9e2affc8cso30183265ad.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 16:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719963720; x=1720568520; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C86LL5Jjwnhff3U2J7Sfodi1QBdh0ARwqCfrj06rmAw=;
 b=YC+fdWrHeqfKXDFSvjD7hHFs9c6tj3WG4Ys/PZzSFFfS98M5wiVkUxsmJe/KeuzdFS
 NfZyQgnHpoGzhffqoTD+3DXVebR8ZJ0RIEsUbGYw75KvnbikNyz8Wstu8N3XxToIQ/S/
 jygS2e8CBBeid9hJQDQHeE4fWKL5F9Yv86elXF/UYENCAkjPCcGgx6RmPjWSV5C9XT7m
 463XHtQtvu/aOvjkh3JXJQDhffPAuBkITMJAunEeAo83kO3ca+FjcMC+E0xFTQ2+aYuZ
 pYcE/NcX14FrnCViFMPMq5eTxZRnUkc5/fuUoYAoFY2hnRBganWlm2w1K/+OiyEYWTWL
 7cZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719963720; x=1720568520;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C86LL5Jjwnhff3U2J7Sfodi1QBdh0ARwqCfrj06rmAw=;
 b=pvUfjKMoRTbtl5w5PtkkvLJZwBILeJVLfjY70UvfhsfWugiO028IckwxwH1j5kmRW+
 GvSpK/anr1LLmYJbfToPctA7gNz8BP1q/qlli7fXqEEaSEct/iGxvXy866L+ceAmiRyO
 EKDOjh/RKLDsRROD5fZC4nnbiY5b5WphHuSsUmNZ/rsT9/b3QG+/b6snNHt8ReeJsDf0
 UD1LngH21mBz4dtjabqeH8mVki1iJIqSuGd/mx3WFCs1VxnJSW+l4KdyORPcBYeGR9Bk
 1kLQKX6ZWywO221Z36HjbCs2OaFZJ4SS5f6zKYJTCUKmTIOthd9yLi3M9iukk27PZ2QV
 fiCA==
X-Gm-Message-State: AOJu0Yz7KB35dH2dIQyohJygbBQjSO9x0rVMr0gJyrVX9QmxF5fZtVQJ
 vuo/PDH9codWvULxR6uMw3TYJfTzgL9OwbkSq232TQhyoBhjsIV0jGkIZ9W7OAkf1+k8e0oiD0n
 I
X-Google-Smtp-Source: AGHT+IHw7kNsK9w8JLVq5wc4q+FM54V2vahUJgbw13ReisVcVk6Pv8aIcjS2xFhmLeuk4naJCPPszQ==
X-Received: by 2002:a17:902:f682:b0:1f9:ddea:451d with SMTP id
 d9443c01a7336-1fadbc73712mr58478065ad.3.1719963719711; 
 Tue, 02 Jul 2024 16:41:59 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac15993c5sm90403755ad.244.2024.07.02.16.41.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 16:41:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, iii@linux.ibm.com,
 david@redhat.com, balaton@eik.bme.hu
Subject: [PATCH 2/2] target/arm: Use memset_ra, memmove_ra in helper-a64.c
Date: Tue,  2 Jul 2024 16:41:55 -0700
Message-Id: <20240702234155.2106399-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240702234155.2106399-1-richard.henderson@linaro.org>
References: <20240702234155.2106399-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Without this, qemu user will not unwind from the SIGSEGV
properly and die with

  qemu-aarch64: QEMU internal SIGSEGV {code=ACCERR, addr=0x7d1b36ec2000}
  Segmentation fault

Fill in the test case for ppc and s390x, which also use memset
from within a helper (but don't currently crash fwiw).

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-a64.c        | 10 ++--
 tests/tcg/multiarch/memset-fault.c | 77 ++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+), 5 deletions(-)
 create mode 100644 tests/tcg/multiarch/memset-fault.c

diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 0ea8668ab4..666bdb7c1a 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -971,7 +971,7 @@ void HELPER(dc_zva)(CPUARMState *env, uint64_t vaddr_in)
     }
 #endif
 
-    memset(mem, 0, blocklen);
+    memset_ra(mem, 0, blocklen, GETPC());
 }
 
 void HELPER(unaligned_access)(CPUARMState *env, uint64_t addr,
@@ -1120,7 +1120,7 @@ static uint64_t set_step(CPUARMState *env, uint64_t toaddr,
     }
 #endif
     /* Easy case: just memset the host memory */
-    memset(mem, data, setsize);
+    memset_ra(mem, data, setsize, ra);
     return setsize;
 }
 
@@ -1163,7 +1163,7 @@ static uint64_t set_step_tags(CPUARMState *env, uint64_t toaddr,
     }
 #endif
     /* Easy case: just memset the host memory */
-    memset(mem, data, setsize);
+    memset_ra(mem, data, setsize, ra);
     mte_mops_set_tags(env, toaddr, setsize, *mtedesc);
     return setsize;
 }
@@ -1497,7 +1497,7 @@ static uint64_t copy_step(CPUARMState *env, uint64_t toaddr, uint64_t fromaddr,
     }
 #endif
     /* Easy case: just memmove the host memory */
-    memmove(wmem, rmem, copysize);
+    memmove_ra(wmem, rmem, copysize, ra);
     return copysize;
 }
 
@@ -1572,7 +1572,7 @@ static uint64_t copy_step_rev(CPUARMState *env, uint64_t toaddr,
      * Easy case: just memmove the host memory. Note that wmem and
      * rmem here point to the *last* byte to copy.
      */
-    memmove(wmem - (copysize - 1), rmem - (copysize - 1), copysize);
+    memmove_ra(wmem - (copysize - 1), rmem - (copysize - 1), copysize, ra);
     return copysize;
 }
 
diff --git a/tests/tcg/multiarch/memset-fault.c b/tests/tcg/multiarch/memset-fault.c
new file mode 100644
index 0000000000..0e8258a88f
--- /dev/null
+++ b/tests/tcg/multiarch/memset-fault.c
@@ -0,0 +1,77 @@
+#include <stdlib.h>
+#include <signal.h>
+#include <unistd.h>
+#include <sys/mman.h>
+#include <assert.h>
+
+#if defined(__powerpc64__)
+/* Needed for PT_* constants */
+#include <asm/ptrace.h>
+#endif
+
+static void *ptr;
+static void *pc;
+
+static void test(void)
+{
+#ifdef __aarch64__
+    void *t;
+    asm("adr %0,1f; str %0,%1; 1: dc zva,%2"
+        : "=&r"(t), "=m"(pc) : "r"(ptr));
+#elif defined(__powerpc64__)
+    void *t;
+    asm("bl 0f; 0: mflr %0; addi %0,%0,1f-0b; std %0,%1; 1: dcbz 0,%2"
+        : "=&r"(t), "=m"(pc) : "r"(ptr) : "lr");
+#elif defined(__s390x__)
+    void *t;
+    asm("larl %0,1f; stg %0,%1; 1: xc 0(256,%2),0(%2)"
+        : "=&r"(t), "=m"(pc) : "r"(ptr));
+#else
+    *(int *)ptr = 0;
+#endif
+}
+
+static void *host_signal_pc(ucontext_t *uc)
+{
+#ifdef __aarch64__
+    return (void *)uc->uc_mcontext.pc;
+#elif defined(__powerpc64__)
+    return (void *)uc->uc_mcontext.gp_regs[PT_NIP];
+#elif defined(__s390x__)
+    return (void *)uc->uc_mcontext.psw.addr;
+#else
+    return NULL;
+#endif
+}
+
+static void sigsegv(int sig, siginfo_t *info, void *uc)
+{
+    assert(info->si_addr == ptr);
+    assert(host_signal_pc(uc) == pc);
+    exit(0);
+}
+
+int main(void)
+{
+    static const struct sigaction sa = {
+        .sa_flags = SA_SIGINFO,
+        .sa_sigaction = sigsegv
+    };
+    size_t size;
+    int r;
+
+    size = getpagesize();
+    ptr = mmap(NULL, size, PROT_READ | PROT_WRITE,
+               MAP_ANON | MAP_PRIVATE, -1, 0);
+    assert(ptr != MAP_FAILED);
+
+    test();
+
+    r = sigaction(SIGSEGV, &sa, NULL);
+    assert(r == 0);
+    r = mprotect(ptr, size, PROT_NONE);
+    assert(r == 0);
+
+    test();
+    abort();
+}
-- 
2.34.1


