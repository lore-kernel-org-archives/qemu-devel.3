Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4235DC5DF6D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 05:55:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwZFd-0001Rz-LY; Wed, 19 Aug 2026 01:54:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3QMSEagcKCjccTVdrebZhhZeX.VhfjXfn-WXoXeghgZgn.hkZ@flex--jackyli.bounces.google.com>)
 id 1wwQgB-00060l-3t
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 16:45:03 -0400
Received: from mail-pf1-x448.google.com ([2607:f8b0:4864:20::448])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3QMSEagcKCjccTVdrebZhhZeX.VhfjXfn-WXoXeghgZgn.hkZ@flex--jackyli.bounces.google.com>)
 id 1wwQg1-0007MK-Lu
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 16:44:57 -0400
Received: by mail-pf1-x448.google.com with SMTP id
 d2e1a72fcca58-84857446424so589028b3a.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 13:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1787085889; x=1787690689; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4FKKUj8w/BG3XrvFfnyuNucawzEx5NoiVOq2alPXUU0=;
 b=VpchsuTK9WAiCTb/m7jlmRCy6Jy8zZvE6Ma/hgNuiekvBLeXriDueZQ4TTvSxSPrvX
 i0wsdE29mpehfie5h2L5jQEI2fJBI9pDacs1dbqxLCg582/89y98wVr6ApDymKRhuiMn
 GXnbPcYOodX1tyKl5VdnjFgc7jsweszc9soOmzsVE/nYZ/SpPPwvOSGOQG45KmspLM+U
 U3riDdF4PbdwQDjBtbM14ZtTfcQKVb3Yv0TfCw7IY0/J+6644aisYirJHyb4LD2UXpvi
 BsF6HN0hppoKG+yTBfkCO9S/Nnq44ZPjrLbrk9C9+tz8SHPt794FhCf6raGwOjS9F03E
 1cZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787085889; x=1787690689;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4FKKUj8w/BG3XrvFfnyuNucawzEx5NoiVOq2alPXUU0=;
 b=fcq+WZbKQLWw+oVN3fYBxnwmxlZicJcFOEfXj8X65MHHN8tVaGOpWH8LjE9TMeYqDs
 cVCjaXgRsYdftZPv5oho4PtOxxvIk+/wT/ZDrertYPyCOaXaHOfgqRkIFGIq01wAE9bx
 f9hzDSBmm4Y6IBLOr0jw/cvczvTuNCZ07uQrwESeSXu84XLrjH0JJi4OXXLCu0KktqLA
 uk4GJlGpE8JLtEBRBpjm392567x8Lg15TwdsztwpTTXr8oT+VYg3/E19ll7JKQDvhv1M
 Ab2v+Ej3si2EK2nhTq/vERo0nUX8okRZHsdpWjbEZsSvo5pyWDra9PwaDz98J7EtTcIW
 j0PQ==
X-Gm-Message-State: AOJu0YzePayX+R4IXznI/F9rJCyPiuiojxxonBkBEuC9m9ttVVUM17e0
 lwtF+cw05hikI5ESLJn+CIfppZOyoBZxNgC4O18Oua9nz/mC/GK4WcWTCNBLRwaMB2kkc0ZdG+0
 AgiD3o7eBnjBxaH6CyCM9oaWk1ZyKKaAWzeGmgriNxhf/1Bho5BHp8XoQ7h7ehbK8xVGDB43ayE
 HO0Rk8tV0dXEqCk55lryK74mAumXydoTdvqYB26n8=
X-Received: from pfbfn22.prod.google.com
 ([2002:a05:6a00:2fd6:b0:84c:2e88:693d])
 (user=jackyli job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4fc9:b0:847:982e:cca0
 with SMTP id d2e1a72fcca58-851cda94536mr1368944b3a.19.1787085888702; Tue, 18
 Aug 2026 13:44:48 -0700 (PDT)
Date: Tue, 18 Aug 2026 20:44:20 +0000
In-Reply-To: <20260818-feature-pkey-dev-v1-0-8c0ef96a4da9@google.com>
Mime-Version: 1.0
References: <20260818-feature-pkey-dev-v1-0-8c0ef96a4da9@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260818-feature-pkey-dev-v1-6-8c0ef96a4da9@google.com>
Subject: [RFC PATCH 6/6] kvm: Implement SIGSEGV sentinel for Pkey recovery
From: Jacky Li <jackyli@google.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 "=?utf-8?q?Philippe_Mathieu-Daud=C3=A9?=" <philmd@mailo.com>,
 Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org, 
 James Houghton <jthoughton@google.com>, Mingwei Zhang <mizhang@google.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>,
 Brendan Jackman <jackmanb@google.com>, 
 Reiji Watanabe <reijiw@google.com>, Jacky Li <jackyli@google.com>
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::448;
 envelope-from=3QMSEagcKCjccTVdrebZhhZeX.VhfjXfn-WXoXeghgZgn.hkZ@flex--jackyli.bounces.google.com;
 helo=mail-pf1-x448.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 19 Aug 2026 01:54:09 -0400
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

Implement a fallback `SIGSEGV` signal handler
(`qemu_pkey_sigsegv_handler`) to recover from legitimate host accesses
to Pkey-protected guest memory when locked.

Signed-off-by: Jacky Li <jackyli@google.com>
---
 util/pkey.c | 157 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 155 insertions(+), 2 deletions(-)

diff --git a/util/pkey.c b/util/pkey.c
index 21b41f928e..689fec8003 100644
--- a/util/pkey.c
+++ b/util/pkey.c
@@ -123,7 +123,7 @@ struct fpstate_64 {
 
 static int pkru_offset = -2; /* -2 means uninitialized */
 
-static int __attribute__((unused)) get_pkru_offset(void)
+static int get_pkru_offset(void)
 {
     uint32_t eax, ebx, ecx, edx;
     __cpuid_count(0xd, XFEATURE_PKRU, eax, ebx, ecx, edx);
@@ -133,7 +133,7 @@ static int __attribute__((unused)) get_pkru_offset(void)
     return (int)ebx;
 }
 
-static int __attribute__((unused)) qemu_get_pkru_offset(void)
+static int qemu_get_pkru_offset(void)
 {
     if (pkru_offset == -2) {
         pkru_offset = get_pkru_offset();
@@ -141,6 +141,155 @@ static int __attribute__((unused)) qemu_get_pkru_offset(void)
     return pkru_offset;
 }
 
+static __attribute__((target("pku"))) bool do_qemu_pkey_sigsegv_recovery(
+    const siginfo_t *si, ucontext_t *ucontext, int pkey)
+{
+    if (pkey < 0 || pkey >= KEY_COUNT) {
+        return false;
+    }
+
+    if (!ucontext) {
+        return false;
+    }
+
+    void *fpstate = ucontext->uc_mcontext.fpregs;
+    if (fpstate == NULL) {
+        return false;
+    }
+
+    struct fpstate_64 *fpstate_64 = (struct fpstate_64 *)fpstate;
+
+    if (fpstate_64->sw_reserved.magic1 != FP_XSTATE_MAGIC1) {
+        return false;
+    }
+
+    uint32_t *magic2 =
+            (uint32_t *)((char *)fpstate + fpstate_64->sw_reserved.xstate_size);
+    if (*magic2 != FP_XSTATE_MAGIC2) {
+        return false;
+    }
+
+    if ((fpstate_64->sw_reserved.xstate_bv & XSTATE_PKRU) == 0) {
+        return false;
+    }
+
+    int pkr_offset = qemu_get_pkru_offset();
+    if (pkr_offset < 0 || pkr_offset >= fpstate_64->sw_reserved.xstate_size) {
+        return false;
+    }
+
+    uint32_t *pkru = (uint32_t *)((char *)fpstate + pkr_offset);
+
+    uint32_t access_rights = (*pkru >> (pkey * BITS_PER_KEY)) & KEY_MASK;
+    if (access_rights == 0) {
+        return false;
+    }
+
+    /*
+     * Flush microarchitectural state (IBPB) before returning to avoid
+     * speculative execution.
+     */
+    prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_INDIRECT_BRANCH, PR_SPEC_DISABLE, 0,
+                0);
+
+    /*
+     * Clear bits in the saved PKRU so that access is unrestricted upon
+     * returning from the signal handler.
+     */
+    *pkru &= ~(KEY_MASK << (pkey * BITS_PER_KEY));
+
+    return true;
+}
+
+static void (*old_sigaction_func)(int, siginfo_t *, void *);
+static void (*old_sighandler_func)(int);
+
+static int pkey_recovery_handler_installed;
+static int pkey_for_recovery = -1;
+
+static void qemu_pkey_sigsegv_handler(int si_signo, siginfo_t *si,
+                                      void *raw_ucontext)
+{
+    ucontext_t *const ucontext = (ucontext_t *)raw_ucontext;
+
+    if (si_signo == SIGSEGV && si != NULL && si->si_code == SEGV_PKUERR) {
+        int pkey = qatomic_read(&pkey_for_recovery);
+        if (pkey >= 0 && do_qemu_pkey_sigsegv_recovery(si, ucontext, pkey)) {
+            return;
+        }
+    }
+
+    void (*old_sigaction)(int, siginfo_t *, void *) =
+            qatomic_read(&old_sigaction_func);
+    if (old_sigaction != NULL) {
+        old_sigaction(si_signo, si, raw_ucontext);
+        return;
+    }
+
+    void (*old_sighandler)(int) = qatomic_read(&old_sighandler_func);
+    if (old_sighandler != NULL && old_sighandler != SIG_DFL &&
+            old_sighandler != SIG_IGN)
+{
+        old_sighandler(si_signo);
+        return;
+    }
+
+    /* Fallback: abort */
+    const char msg[] = "QEMU: Received unexpected Pkey SIGSEGV\n";
+    int unused __attribute__((unused)) =
+        write(STDERR_FILENO, msg, sizeof(msg) - 1);
+    abort();
+}
+
+static void qemu_register_pkey_recovery_handler(void)
+{
+    struct sigaction old_sigact = {0};
+    struct sigaction new_sigact = {0};
+
+    if (qatomic_xchg(&pkey_recovery_handler_installed, 1)) {
+        return; /* Already installed */
+    }
+
+    if (sigaction(SIGSEGV, NULL, &old_sigact) < 0) {
+        error_report("QEMU Pkey: Failed to get current SIGSEGV handler");
+        qatomic_set(&pkey_recovery_handler_installed, 0);
+        return;
+    }
+
+    if (old_sigact.sa_flags & SA_RESETHAND) {
+        error_report(
+            "QEMU Pkey: Incompatible SA_RESETHAND flags in old handler");
+        qatomic_set(&pkey_recovery_handler_installed, 0);
+        return;
+    }
+
+    if (old_sigact.sa_flags & SA_SIGINFO) {
+        qatomic_set(&old_sigaction_func, old_sigact.sa_sigaction);
+    } else {
+        qatomic_set(&old_sighandler_func, old_sigact.sa_handler);
+    }
+
+    new_sigact = old_sigact;
+    new_sigact.sa_flags |= SA_SIGINFO;
+    new_sigact.sa_sigaction = &qemu_pkey_sigsegv_handler;
+
+    if (sigaction(SIGSEGV, &new_sigact, &old_sigact) < 0) {
+        error_report("QEMU Pkey: Failed to register SIGSEGV handler");
+        qatomic_set(&pkey_recovery_handler_installed, 0);
+        return;
+    }
+}
+
+static void qemu_add_pkey_for_recovery(int pkey)
+{
+    int expected = -1;
+    /* We only support one recovery pkey at a time */
+    if (qatomic_cmpxchg(&pkey_for_recovery, expected, pkey) != expected) {
+        error_report("QEMU Pkey: Recovery Pkey already set to %d",
+                     pkey_for_recovery);
+    }
+}
+
 __attribute__((target("pku"))) void qemu_init_guest_memory_pkey(void)
 {
     if (guest_memory_pkey != -1) {
@@ -154,6 +303,10 @@ __attribute__((target("pku"))) void qemu_init_guest_memory_pkey(void)
             error_report("pkey_alloc failed for guest memory: %s",
                          strerror(errno));
         } else {
+            /* Register recovery signal handler and add pkey for recovery. */
+            qemu_register_pkey_recovery_handler();
+            qemu_add_pkey_for_recovery(pkey);
+
             guest_memory_pkey = pkey;
         }
     }

-- 
2.55.0.737.g08866a6d13-goog


