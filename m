Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB01EE6B68
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 21:47:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voTfD-0006bf-Ph; Fri, 06 Feb 2026 16:46:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTdo-0005FX-CY
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:45:29 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTdl-0002al-BH
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:45:28 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-48068127f00so24152335e9.3
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 13:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770414323; x=1771019123; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FKICMMCiVUa2Gihxm7S+wHoIqYDV2UjOWOxCCmt/J8A=;
 b=hyH0Yxddlf4gVy6Hb5vm/9IMw7o68gxhbnuV9XeimoXkBrdxjmfAjZ0pzucyucsEEu
 p2KgFW8f62FGtH6ieANoTS1QRxnLB6oawZyI5Agw5vvjbjmGlD40/782DFrDFzo+AJ+K
 ivVgOrFq1XzM1OlrY0FnUospQPVCfTCUrioEJpWOFxi0cu9sVExf9+6tyzEhmfo3elxA
 dLdE8EQXj/8Ci7f/Hi3Nrkqvz3xpl9RlPSAr5L5htLlfrJWsXu0QAAoTA/WcrmMyC4ji
 I5ZP0SjD7v2yikM7zEJFsAis9poIWWPiz+PFLjZWyPnVphiSOhYqKCDjsVI6nUvz8piO
 A7bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770414323; x=1771019123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FKICMMCiVUa2Gihxm7S+wHoIqYDV2UjOWOxCCmt/J8A=;
 b=rPNskYTqLtXCemtUP4Ubt2suM97W+wctlnPFW96fP2twUh+O0QLJS1m16iU2sOqKnq
 u+PEpxVXqnLftU5oGiMeOXWj5o8DrU5XJI37Cln2AmLgvgMd3ZEuz4C2wSeYBiarNKo3
 +/Jr7IVJD7KVjQPsGRoNIvPxW8u1H5exmcCEpfWXR8o5R1p/LeN2Rj5CwHvgNeQRyuqJ
 DETLxNzzY+z2pAQb2FzZYzPhg01o3k5yGLXcf26zxk23LCaunshsnch7GyProQ6PzBfO
 u3tVuX75KEe1iuZ07TG27K7YzMBkz0VEN7nXo5t3nW3BYOouHRwnoeNEbUYNNyDAfxGv
 9HiQ==
X-Gm-Message-State: AOJu0YyLDffB1RTPNKgYMdQ0lP1RuNRwX6MHWC4EV+64AZplJciKAQcq
 hhTbgG5nmzS3s4PIUPqEY9V2LeBGl0sBXz9ETXh/lIUA+TkxkSSIIgf0JAjiR1bmSKSxS93sdlN
 QpLDclwU=
X-Gm-Gg: AZuq6aIIcSf5TitJnOtz52KeWvWRZUMNqXmKxGeNfZtu7B88rnFE702IzbspSyIPR/I
 ad3WqbBzaPNJVy1SfQoALExSUxjyndJT0wl5jbV8x1lPX0B/QyBk2rysORX2V+ut9/4deRWdoJr
 E7rDuLhGWeB6kuygQ44xMl6H0xOGBrSnYKm+j0UrPOQd8K/LugpaQw0KIbHhkaCsenr2ZPUkjjQ
 U+iJgU81kMw8lOnq7jRHxCYohLKz+aImy1utHGYAvyr9YdNJzqVz9Bxw2VVCfc3Egx3TuYdjr6s
 IW4HO+jWQrbCJ4U0jvOzy3tgSf4tY4KprICWZrPu0+CN/B2tL0Yj3e7D2OBes7cPJ56o4npSfxM
 aRD0bUSXPDHj71IFNojY9VCLjQGebcK6b29/9kCrdqP2YvmsGJNO/sAqjrBps0RzGlIBQSY+p+b
 4PJjmNb9C3H8U5LRr4CgaUi+3dC0/DlhRYHxeUF310svdJjdVRRblJwMHxN8XD
X-Received: by 2002:a05:600c:4fc8:b0:480:19ed:7efa with SMTP id
 5b1f17b1804b1-483203397fcmr68067175e9.36.1770414323416; 
 Fri, 06 Feb 2026 13:45:23 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48320961701sm53276755e9.5.2026.02.06.13.45.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Feb 2026 13:45:22 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org
Subject: [PULL 05/30] target/s390x: Replace %target_ulong -> %hwaddr where
 appropriate
Date: Fri,  6 Feb 2026 22:44:23 +0100
Message-ID: <20260206214448.22008-6-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260206214448.22008-1-philmd@linaro.org>
References: <20260206214448.22008-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Use the %hwaddr type for physical addresses.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20260206181953.18683-5-philmd@linaro.org>
---
 target/s390x/s390x-internal.h  | 11 ++++++-----
 target/s390x/helper.c          |  2 +-
 target/s390x/mmu_helper.c      | 18 +++++++++---------
 target/s390x/tcg/excp_helper.c |  2 +-
 4 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/target/s390x/s390x-internal.h b/target/s390x/s390x-internal.h
index 31e164c9b5a..40850bcdc45 100644
--- a/target/s390x/s390x-internal.h
+++ b/target/s390x/s390x-internal.h
@@ -10,6 +10,7 @@
 #ifndef S390X_INTERNAL_H
 #define S390X_INTERNAL_H
 
+#include "exec/hwaddr.h"
 #include "exec/vaddr.h"
 #include "cpu.h"
 #include "fpu/softfloat.h"
@@ -368,19 +369,19 @@ void ioinst_handle_sal(S390CPU *cpu, uint64_t reg1, uintptr_t ra);
 
 
 /* mem_helper.c */
-target_ulong mmu_real2abs(CPUS390XState *env, target_ulong raddr);
 void probe_write_access(CPUS390XState *env, uint64_t addr, uint64_t len,
                         uintptr_t ra);
 
 
 /* mmu_helper.c */
-bool mmu_absolute_addr_valid(target_ulong addr, bool is_write);
+hwaddr mmu_real2abs(CPUS390XState *env, hwaddr raddr);
+bool mmu_absolute_addr_valid(hwaddr addr, bool is_write);
 /* Special access mode only valid for mmu_translate() */
 #define MMU_S390_LRA        -1
 int mmu_translate(CPUS390XState *env, vaddr vaddr, int rw, uint64_t asc,
-                  target_ulong *raddr, int *flags, uint64_t *tec);
-int mmu_translate_real(CPUS390XState *env, target_ulong raddr, int rw,
-                       target_ulong *addr, int *flags, uint64_t *tec);
+                  hwaddr *raddr, int *flags, uint64_t *tec);
+int mmu_translate_real(CPUS390XState *env, hwaddr raddr, int rw,
+                       hwaddr *addr, int *flags, uint64_t *tec);
 
 
 /* misc_helper.c */
diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index 5002eebd4c8..667d4a0da75 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -43,7 +43,7 @@ hwaddr s390_cpu_get_phys_page_debug(CPUState *cs, vaddr vaddr)
 {
     S390CPU *cpu = S390_CPU(cs);
     CPUS390XState *env = &cpu->env;
-    target_ulong raddr;
+    hwaddr raddr;
     int prot;
     uint64_t asc = env->psw.mask & PSW_MASK_ASC;
     uint64_t tec;
diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index 39ff42da3a3..246573ff642 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -86,7 +86,7 @@ static bool lowprot_enabled(const CPUS390XState *env, uint64_t asc)
  * Translate real address to absolute (= physical)
  * address by taking care of the prefix mapping.
  */
-target_ulong mmu_real2abs(CPUS390XState *env, target_ulong raddr)
+hwaddr mmu_real2abs(CPUS390XState *env, hwaddr raddr)
 {
     if (raddr < 0x2000) {
         return raddr + env->psa;    /* Map the lowcore. */
@@ -96,7 +96,7 @@ target_ulong mmu_real2abs(CPUS390XState *env, target_ulong raddr)
     return raddr;
 }
 
-bool mmu_absolute_addr_valid(target_ulong addr, bool is_write)
+bool mmu_absolute_addr_valid(hwaddr addr, bool is_write)
 {
     return address_space_access_valid(&address_space_memory,
                                       addr & TARGET_PAGE_MASK,
@@ -123,7 +123,7 @@ static inline bool read_table_entry(CPUS390XState *env, hwaddr gaddr,
 }
 
 static int mmu_translate_asce(CPUS390XState *env, vaddr vaddr,
-                              uint64_t asc, uint64_t asce, target_ulong *raddr,
+                              uint64_t asc, uint64_t asce, hwaddr *raddr,
                               int *flags)
 {
     const bool edat1 = (env->cregs[0] & CR0_EDAT) &&
@@ -296,7 +296,7 @@ static int mmu_translate_asce(CPUS390XState *env, vaddr vaddr,
     return 0;
 }
 
-static void mmu_handle_skey(target_ulong addr, int rw, int *flags)
+static void mmu_handle_skey(hwaddr addr, int rw, int *flags)
 {
     static S390SKeysClass *skeyclass;
     static S390SKeysState *ss;
@@ -382,7 +382,7 @@ static void mmu_handle_skey(target_ulong addr, int rw, int *flags)
  * @return       0 = success, != 0, the exception to raise
  */
 int mmu_translate(CPUS390XState *env, vaddr vaddr, int rw, uint64_t asc,
-                  target_ulong *raddr, int *flags, uint64_t *tec)
+                  hwaddr *raddr, int *flags, uint64_t *tec)
 {
     uint64_t asce;
     int r;
@@ -472,7 +472,7 @@ nodat:
  * the MEMOP interface.
  */
 static int translate_pages(S390CPU *cpu, vaddr addr, int nr_pages,
-                           target_ulong *pages, bool is_write, uint64_t *tec)
+                           hwaddr *pages, bool is_write, uint64_t *tec)
 {
     uint64_t asc = cpu->env.psw.mask & PSW_MASK_ASC;
     CPUS390XState *env = &cpu->env;
@@ -523,7 +523,7 @@ int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr, uint8_t ar, void *hostbuf,
 {
     const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
     int currlen, nr_pages, i;
-    target_ulong *pages;
+    hwaddr *pages;
     uint64_t tec;
     int ret;
 
@@ -584,8 +584,8 @@ void s390_cpu_virt_mem_handle_exc(S390CPU *cpu, uintptr_t ra)
  * @param flags  the PAGE_READ/WRITE/EXEC flags are stored to this pointer
  * @return       0 = success, != 0, the exception to raise
  */
-int mmu_translate_real(CPUS390XState *env, target_ulong raddr, int rw,
-                       target_ulong *addr, int *flags, uint64_t *tec)
+int mmu_translate_real(CPUS390XState *env, hwaddr raddr, int rw,
+                       hwaddr *addr, int *flags, uint64_t *tec)
 {
     const bool lowprot_enabled = env->cregs[0] & CR0_LOWPROT;
 
diff --git a/target/s390x/tcg/excp_helper.c b/target/s390x/tcg/excp_helper.c
index 292d130d03e..41b0017d767 100644
--- a/target/s390x/tcg/excp_helper.c
+++ b/target/s390x/tcg/excp_helper.c
@@ -148,7 +148,7 @@ bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 {
     CPUS390XState *env = cpu_env(cs);
     vaddr vaddr;
-    target_ulong raddr;
+    hwaddr raddr;
     uint64_t asc, tec;
     int prot, excp;
 
-- 
2.52.0


