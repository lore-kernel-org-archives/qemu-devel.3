Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0842C5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 19:02:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww2bJ-0002rP-CN; Mon, 17 Aug 2026 15:02:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1ww2Zw-0006mB-Ob
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 15:01:10 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1ww2Zu-0006lB-A8
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 15:01:00 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-66c70e2904dso4085464d50.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 12:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786993257; x=1787598057; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Tc0VjzEQDHo8/Dm/bwwN45pmK61wlymDtBgaGkTeofs=;
 b=MWMvpT2HMRpSqo7CR6cUcsdq1lzhvJ3xCCC7YKSJpl31epID+LPI8VzDmd5is6lsLp
 aVpjZG/s8oVV8+tR3nrefK1uL2EaWThK11pJeu/xPEh2Z+F/UXmab3BSY2X9vVpH31c+
 z6Hs4gdnw4CE0pExF6M13h4sGO2PV0+j4e5gr/pPdcZ/aoFnT/+NVze7Z1vhoemCpTN0
 K8Eg2OIVN5stCzftx0vKZe4/tCc0WVzto9VGdRr7UXmVKbsHzlpSvON0MEVKlJQerQr5
 sRyvPV6WM/CPN8Uxv6eaRetv7SMSsS2RWU9kt9Y1egt4q7x8y/8ef49QastYGcZhoQ0J
 YSFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786993257; x=1787598057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Tc0VjzEQDHo8/Dm/bwwN45pmK61wlymDtBgaGkTeofs=;
 b=A/UQYMy6k1lodNzGnnR2B7NnlyoSt4F5dLjDViWtAIliARlq5EzaeY8ZgtdqgJLIDf
 b4SbZLkPZs8JR/uwtBs6sGiknQ0Nrmrw45D6HOZrMV7XVPtBJ2lZbZKGMrtvFDtsfohm
 uxFZEUQnjKP4i1yk49rNbmrefK8k2ixbvCmuutKI4YJv/e5OY73WS40zykdt10bcmUNS
 LhLVlt421ZyEdB8thDdrYdzICuOddguvARix+wdcL3WnWRn2bi5hV7e1kO+9g4cSIBIv
 LI8zWHp9WHeYsRqQJM7Ri8WeiRSoo/10Hl57OVcPWD1KICAL13lVp84YCnNqABrbJZAR
 do4w==
X-Gm-Message-State: AOJu0YzPD7eunYeXKHJ/43gmA+JTdrkITzE4tpf41mrzObJfkgnU/Ior
 CiBGnmphAuDE6G8msQx4iLberQvflZb6R4SsBvAC26Fv2yxEXIGVBWi8Y2UYvvWiWIs=
X-Gm-Gg: AR+sD10KFuXXDfbYP7qTkhHF6EwkJXoCou/YL9PoScN2x5Tx6DIiHs7aRUA06MgnoY+
 S2bwVNfu/TrAzJzj0gJLLN60mJFx12sxQ+bcmk261h3LARYMmTdeM1vKrTY0ggIiu4PC8uzP6bB
 YMxrsXDnTWluh596NiEZqgqGyjLSso29JayLUXQvuxeAxfegrPGMzf8sUWKbeLFT5KdoXw9fuLQ
 Dxm7jEikqzfd3GMedWU632DwUnGxZJLQQYVevQbLOjHZMlL1GP3AscrbkvwIrs4ezosi/qJgVjn
 VfYe4lwPYZCpLSWnjLE8XpY6bg6+iTAz3mMn6NTqq1hqdFLJRWX6BmtZLrsYedNI2UNaF9HYJvQ
 qJ05aLDJpOzZ9IuBbNSp3qUdoqRFjOJb4rGCYx1gEfWva5yqIyqzSfXw4zhVjKMdkxanTJxYmBT
 SFs6sYq6gGuEdgItJpJw/L25LX1UmZJuRcLpwQviGXPOTkXVR+iyGDgDv1SJkd
X-Received: by 2002:a05:690e:b89:b0:66b:354e:5202 with SMTP id
 956f58d0204a3-66c72b18b52mr8631640d50.7.1786993256866; 
 Mon, 17 Aug 2026 12:00:56 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66cb4780b7asm1261880d50.12.2026.08.17.12.00.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 12:00:55 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, philmd@mailo.com,
 zhao1.liu@intel.com, laurent@vivier.eu, deller@gmx.de,
 pierrick.bouvier@oss.qualcomm.com, Matt Turner <mattst88@gmail.com>
Subject: [RFC PATCH 5/8] RFC: accel/tcg: allow cross-page goto_tb chaining in
 user-only builds
Date: Mon, 17 Aug 2026 15:00:35 -0400
Message-ID: <20260817190038.580257-6-mattst88@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260817190038.580257-1-mattst88@gmail.com>
References: <20260817190038.580257-1-mattst88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=mattst88@gmail.com; helo=mail-yx1-xb12a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

translator_use_goto_tb() refuses to chain unless the destination is on the
same page as the start of the TB. For guests whose text is much larger than
a page this is expensive: an emulated alpha gcc compiling a 255k line
translation unit takes the indirect dispatch path for 8.4 billion of its
34.2 billion TB exits, and a large share of those are ordinary direct
branches that simply crossed an 8 KiB page boundary.

The restriction was made unconditional by d3a2a1d803 ("accel/tcg:
Introduce translator_use_goto_tb"), whose rationale was:

    Various targets avoid the page crossing test for CONFIG_USER_ONLY,
    but that is wrong: mmap and mprotect can change page permissions.

That is true, but in user-only builds the invalidation path already covers
it. There are no page tables: every mmap, mprotect and munmap reaches
page_set_flags(), which calls tb_invalidate_phys_range() whenever the flags
actually change, and tb_phys_invalidate() calls tb_jmp_unlink() to reset
incoming jumps. A chained cross-page jump is therefore broken whenever the
destination page's permissions change. This is not true in system mode,
where TBs are keyed by physical address and a page table change invalidates
nothing, so the restriction is kept there.

Add tests/tcg/alpha/test-xpage-chain.c to cover the hazard directly. It
places a direct branch near the end of one page targeting the next page,
runs it 200000 times so the chain is established, then checks that
mprotect(PROT_NONE) makes the next call fault, and that remapping the page
with different code runs the new code rather than a stale translation.

The test detects the hazard it is meant to detect: with the
tb_invalidate_phys_range() call in page_set_flags() commented out, it fails
both phases, executing page B after PROT_NONE and returning the stale
result.

Measured with qemu-alpha running an emulated alpha gcc 16.2.0 compiling the
SQLite 3.45.1 amalgamation on an x86-64 host, LTO build, on top of the
preceding patches:

    before: 890,713,633,237 instructions
    after:  869,178,598,378 instructions   -2.42%

    before: 84.44s wall clock
    after:  80.49s wall clock              -4.68%

Note that this is worth more in time than in instructions, the reverse of
the preceding patch: a chained jump replaces a cache probe whose loads can
miss, so the instructions it removes are more expensive than average.

Measured before the inline jump cache probe, when a missed chain cost a
helper call rather than an inline probe, the same change was worth -7.9%.

RFC because this reverses a deliberate decision and the reasoning above
wants review from someone who knows the invalidation paths better than I
do.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 accel/tcg/translator.c             |  12 ++++
 tests/tcg/alpha/Makefile.target    |   2 +-
 tests/tcg/alpha/test-xpage-chain.c | 111 +++++++++++++++++++++++++++++
 3 files changed, 124 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/alpha/test-xpage-chain.c

diff --git ./accel/tcg/translator.c ./accel/tcg/translator.c
index 29e609b2ec..4921bf978c 100644
--- ./accel/tcg/translator.c
+++ ./accel/tcg/translator.c
@@ -117,8 +117,20 @@ bool translator_use_goto_tb(DisasContextBase *db, vaddr dest)
         return false;
     }
 
+#ifdef CONFIG_USER_ONLY
+    /*
+     * There are no page tables in user-only mode.  Every mmap, mprotect and
+     * munmap goes through page_set_flags(), which calls
+     * tb_invalidate_phys_range() whenever the flags actually change, and
+     * tb_phys_invalidate() unlinks incoming jumps.  A chained cross-page
+     * jump is therefore broken whenever the destination page's permissions
+     * change, so the same-page restriction is not needed here.
+     */
+    return true;
+#else
     /* Check for the dest on the same page as the start of the TB.  */
     return translator_is_same_page(db, dest);
+#endif
 }
 
 void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
diff --git ./tests/tcg/alpha/Makefile.target ./tests/tcg/alpha/Makefile.target
index 36d8ed1eae..eee986bab6 100644
--- ./tests/tcg/alpha/Makefile.target
+++ ./tests/tcg/alpha/Makefile.target
@@ -5,7 +5,7 @@
 ALPHA_SRC=$(SRC_PATH)/tests/tcg/alpha
 VPATH+=$(ALPHA_SRC)
 
-ALPHA_TESTS=hello-alpha test-cond test-cmov test-ovf test-cvttq
+ALPHA_TESTS=hello-alpha test-cond test-cmov test-ovf test-cvttq test-xpage-chain
 TESTS+=$(ALPHA_TESTS)
 
 test-cmov: EXTRA_CFLAGS=-DTEST_CMOV
diff --git ./tests/tcg/alpha/test-xpage-chain.c ./tests/tcg/alpha/test-xpage-chain.c
new file mode 100644
index 0000000000..7916d544af
--- /dev/null
+++ ./tests/tcg/alpha/test-xpage-chain.c
@@ -0,0 +1,111 @@
+/*
+ * Cross-page TB chaining hazard test.
+ *
+ * Phase 1: a direct branch (br) near the end of page A targets page B.
+ *          Run it enough times that QEMU chains TB_A -> TB_B.
+ * Phase 2: mprotect page B away. Re-running must fault.
+ * Phase 3: remap page B with different code. Re-running must execute the
+ *          NEW code, not a stale chained translation of the old code.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <setjmp.h>
+#include <signal.h>
+#include <sys/mman.h>
+#include <unistd.h>
+
+#define PS 8192
+
+static sigjmp_buf jb;
+/*
+ * Written by the SIGSEGV handler and read by main(), so it must not be
+ * cached in a register across the faulting call.
+ */
+static volatile sig_atomic_t caught;
+
+static void segv(int sig)
+{
+    caught = 1;
+    siglongjmp(jb, 1);
+}
+
+/* lda $0, imm($31)  -> v0 = imm */
+static unsigned int lda_v0(int imm)
+{
+    return 0x201F0000u | (unsigned short)imm;
+}
+
+int main(void)
+{
+    struct sigaction sa;
+    int rc = 0;
+    unsigned char *m = mmap(NULL, 2 * PS, PROT_READ | PROT_WRITE | PROT_EXEC,
+                            MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+    if (m == MAP_FAILED) {
+        perror("mmap");
+        return 2;
+    }
+
+    unsigned char *pa = m, *pb = m + PS;
+    unsigned int *entry = (unsigned int *)(pa + PS - 64);
+    unsigned int *tgt = (unsigned int *)(pb + 16);
+
+    entry[0] = lda_v0(1);
+    long disp = ((long)tgt - ((long)&entry[1] + 4)) / 4;
+    entry[1] = 0xC3E00000u | (unsigned int)(disp & 0x1FFFFF);  /* br $31,tgt */
+    tgt[0] = 0x6BFA8001u;                                      /* ret        */
+    __builtin___clear_cache((char *)m, (char *)m + 2 * PS);
+
+    long (*fn)(void) = (long (*)(void))entry;
+
+    for (int i = 0; i < 200000; i++) {
+        if (fn() != 1) {
+            printf("FAIL: phase 1 wrong result\n");
+            return 1;
+        }
+    }
+    printf("phase 1 ok (chained)\n");
+
+    memset(&sa, 0, sizeof(sa));
+    sa.sa_handler = segv;
+    sigemptyset(&sa.sa_mask);
+    if (sigaction(SIGSEGV, &sa, NULL) != 0) {
+        perror("sigaction");
+        return 2;
+    }
+    if (mprotect(pb, PS, PROT_NONE) != 0) {
+        perror("mprotect");
+        return 2;
+    }
+    if (sigsetjmp(jb, 1) == 0) {
+        fn();
+        printf("FAIL: phase 2 executed page B after mprotect(PROT_NONE)\n");
+        rc = 1;
+    } else if (!caught) {
+        printf("FAIL: phase 2 longjmp without entering the handler\n");
+        rc = 1;
+    } else {
+        printf("phase 2 ok (faulted)\n");
+    }
+
+    /* Phase 3: remap with different code, expect the new code to run. */
+    if (mprotect(pb, PS, PROT_READ | PROT_WRITE | PROT_EXEC) != 0) {
+        perror("mprotect back");
+        return 2;
+    }
+    tgt[0] = lda_v0(2);
+    tgt[1] = 0x6BFA8001u;
+    __builtin___clear_cache((char *)pb, (char *)pb + PS);
+
+    long r = fn();
+    if (r != 2) {
+        printf("FAIL: phase 3 returned %ld, expected 2 (stale chain)\n", r);
+        rc = 1;
+    } else {
+        printf("phase 3 ok (new code ran)\n");
+    }
+    return rc;
+}
-- 
2.54.0


