Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D142DC5DF85
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 05:55:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwZFh-0001TJ-En; Wed, 19 Aug 2026 01:54:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3PMSEagcKCjMYPRZnaXVddVaT.RdbfTbj-STkTacdcVcj.dgV@flex--jackyli.bounces.google.com>)
 id 1wwQfx-0005zM-It
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 16:44:51 -0400
Received: from mail-pg1-x547.google.com ([2607:f8b0:4864:20::547])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3PMSEagcKCjMYPRZnaXVddVaT.RdbfTbj-STkTacdcVcj.dgV@flex--jackyli.bounces.google.com>)
 id 1wwQfv-0007L3-T1
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 16:44:49 -0400
Received: by mail-pg1-x547.google.com with SMTP id
 41be03b00d2f7-cbbb9c9bfc3so129335a12.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 13:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1787085885; x=1787690685; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NzXfJ7GrXHwgFSyfN75/LYVcSrb54eTxnKJjh2ZDD8c=;
 b=Yv0P4pe56246bV6ZyvdREpwXX/0XCMK83XVa1mvRoCuL7J/0mGgUjSE/piKFOOlb7j
 H9nT1zbMrlbRWfWJsFShvvb0Aschi9GhrNp076Lb/KfQSJ0+5nOndQUtOlhqU3i9N525
 O6UcDb31AohUUANXbVyUKyyES8DilhKQ8qOEctD+exsIR35gLKE2KMnaCeRfcfovjkK8
 61ENYwJ97h+Lj8mQcKGwzKvf/TjskParbVYZ3MIr1OH/kd9eUAvUTZr1B39sgZwVOECF
 2pgXLybkyw8VIootBbPPojxUiZ4pXVt7txsLm09aeQMzYGAKkRIWDj6UotCkqFNF6MnD
 HDpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787085885; x=1787690685;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NzXfJ7GrXHwgFSyfN75/LYVcSrb54eTxnKJjh2ZDD8c=;
 b=rFUR9j5kFY2sTq8ZHBRt83ImytwNepTDCJiHoRMRnXCEQRBl0t8bysD5HEpVLMZN1e
 RNarJ1Qqkwz1OkAZSaZcag7v32gdWPOFQVmwnkFiqYqqCCn7JnYsR1B/GL3+rsrzdtEP
 B7DVNzcecNU9glJxoClgMLpyrvYXH0eNot51Abm7Vb04iCpu45v8VUxO+dFJulRj9m8w
 lCtF2UCKqQPFvl5fM7yypxmUtVWR7tOzlxlH24yzqV9mmy54kjEXUwienYPHgqWxiYIn
 M8BhBN6LkqkIY85mERzc6WCwGMIVARZMOFFRKJbKHc0s7k6ows9r4vLn/tiaZBBIzDH8
 yqmw==
X-Gm-Message-State: AOJu0Yzmy8yC2ng3NNi98OShF1JqMda+wp9ZowqhoTJ0t55XJ+UFInd1
 gN23y4CwKcUhDKw22c2OyrN1ypRS2BDWcLOPI4b4knnZhAilgSkkT16PYfeYgDcNGRqzcTRN3ox
 yvW7LAurqAyy+W6D1gHTO/TTT3v6woHw1lkAPNg3xkViL3xWxLtusYQuG+sVE/1dNKfUStFpto8
 elQAVMc6sWpL25iHe0ri4JA/TRTD0IDZGbvlW1NmA=
X-Received: from pfbem53.prod.google.com
 ([2002:a05:6a00:3775:b0:851:8c82:93ea])
 (user=jackyli job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:9a1:b0:84e:24f:2667
 with SMTP id d2e1a72fcca58-851cd7a9ccemr1725750b3a.8.1787085884306; Tue, 18
 Aug 2026 13:44:44 -0700 (PDT)
Date: Tue, 18 Aug 2026 20:44:16 +0000
In-Reply-To: <20260818-feature-pkey-dev-v1-0-8c0ef96a4da9@google.com>
Mime-Version: 1.0
References: <20260818-feature-pkey-dev-v1-0-8c0ef96a4da9@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260818-feature-pkey-dev-v1-2-8c0ef96a4da9@google.com>
Subject: [RFC PATCH 2/6] kvm: Add guest memory Pkey initialization
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::547;
 envelope-from=3PMSEagcKCjMYPRZnaXVddVaT.RdbfTbj-STkTacdcVcj.dgV@flex--jackyli.bounces.google.com;
 helo=mail-pg1-x547.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 19 Aug 2026 01:54:07 -0400
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

Add initialization logic during early QEMU startup to allocate a
dedicated userspace protection key (Pkey) for protecting guest physical
memory when enabled via QEMU_ENABLE_PKEY_GUEST_MEMORY.

Signed-off-by: Jacky Li <jackyli@google.com>
---
 include/exec/cpu-common.h |  1 +
 system/vl.c               |  1 +
 util/meson.build          |  2 +-
 util/pkey.c               | 23 +++++++++++++++++++++++
 4 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 6594f7fa1b..5ede0c65dc 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -112,4 +112,5 @@ static inline CPUState *env_cpu(CPUArchState *env)
     return (CPUState *)env_cpu_const(env);
 }
 
+void qemu_init_guest_memory_pkey(void);
 #endif /* CPU_COMMON_H */
diff --git a/system/vl.c b/system/vl.c
index 061cbdf860..e49c6fed39 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2907,6 +2907,7 @@ void qemu_init(int argc, char **argv)
     module_allow_arch(target_name());
 
     qemu_init_subsystems();
+    qemu_init_guest_memory_pkey();
 
     /* first pass of option parsing */
     optind = 1;
diff --git a/util/meson.build b/util/meson.build
index fa174c07a5..682a078a3d 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -9,7 +9,7 @@ if host_os != 'windows'
   util_ss.add(files('compatfd.c'))
   util_ss.add(files('event_notifier-posix.c'))
   if host_os != 'emscripten'
-    util_ss.add(files('mmap-alloc.c'))
+    util_ss.add(files('mmap-alloc.c', 'pkey.c'))
   endif
   freebsd_dep = []
   if host_os == 'freebsd'
diff --git a/util/pkey.c b/util/pkey.c
index 4f14a72151..249e36d508 100644
--- a/util/pkey.c
+++ b/util/pkey.c
@@ -40,6 +40,8 @@
 #define PKEY_DISABLE_ACCESS 0x1
 #endif
 
+static int guest_memory_pkey = -1;
+
 /* Each protection key occupies exactly 2 bits in the PKRU register. */
 #define BITS_PER_KEY 2
 /* The mask used to extract/write the 2-bit permission flags. */
@@ -86,6 +88,24 @@ static inline __attribute__((always_inline)) intptr_t local_syscall3(
     return ret;
 }
 
+__attribute__((target("pku"))) void qemu_init_guest_memory_pkey(void)
+{
+    if (guest_memory_pkey != -1) {
+        return;
+    }
+
+    const char *enable_pkey = getenv("QEMU_ENABLE_PKEY_GUEST_MEMORY");
+    if (enable_pkey && strcmp(enable_pkey, "1") == 0) {
+        int pkey = pkey_alloc(0, 0);
+        if (pkey == -1) {
+            error_report("pkey_alloc failed for guest memory: %s",
+                         strerror(errno));
+        } else {
+            guest_memory_pkey = pkey;
+        }
+    }
+}
+
 #else
 /* Dummy implementations for all other configurations (non-x86_64 Linux, */
 /* Windows, macOS, etc.) */
@@ -93,4 +113,7 @@ static inline __attribute__((always_inline)) intptr_t local_syscall3(
 #include <linux/kvm.h>
 #include <sys/ioctl.h>
 #endif
+
+void qemu_init_guest_memory_pkey(void)
+{}
 #endif

-- 
2.55.0.737.g08866a6d13-goog


