Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3202C8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:18:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgCH-00035P-Tw; Thu, 28 Aug 2025 13:14:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbW1-0007tu-Ao
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:14:06 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbVy-0008G4-3l
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:14:04 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-248c7f955a2so8135885ad.2
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756383237; x=1756988037; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jc1Hd4IAJ+hIHiSM2SjlYyCPHAEkMo+OJOYDdKf2WxY=;
 b=q5qmvGBHQkEtqHf77ru/tEgkakc3+PNvP7VjZi3EFPKf2tTpQcFQIkLdCtkyVuvATY
 LxlAm0y5oyNdQNK3izGlB6SePF4f2eU6KVg5DjMR1gImUZORhYm0tk4BKf0Z9Hfe3znc
 hsIY+MAuMgStwp4KSJX6AXTrbxK2KVfPAwQH3+L4XK/gcHe44xrdOsKPQNxpWQAur6lb
 vHQvQmOJdYI37s6z0LHapgIcNunpen88hL61e8tLLPPWEXTcnd7XqBDwbB26ozaM0aXc
 nCigsmqH42bfZReDqshEsDPXrAwGhygb0W8WkPTyAAQcw97vM/6DYy0eWwfUFff5iz4n
 6pSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756383237; x=1756988037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jc1Hd4IAJ+hIHiSM2SjlYyCPHAEkMo+OJOYDdKf2WxY=;
 b=OoWAp8DQuvyhu2bpSAF/S9+LtCyBft1mHhcSzsWvIm7mOzvKjKw4x+SX/WL1FQM32b
 AMFzf4MjDfEE2x1Bw7OACj68EC1g9DwZNGmvjDghrZh1HNu5bpU8jfKfWnmXGE8At7FO
 IDjmLMD9R1kjOGYGXSxJKDS2OjC796BJjMglWLnv3pe19gRzoJ33T2YRq6zppbjVhSe3
 zUdilF/Ntwe8eHZIFTlCPSSLOWFP+Q2m8Z2F3m1KpkEGi9rvmp5TDM+AWwOTbH9M9JGS
 HwlGSRvd/Db/vbD7ZILrzwlblQkxSv40cuRQkhTXtYMkwRKThZHi91WvaZ1PWuLfPgmm
 Yk4A==
X-Gm-Message-State: AOJu0YyEMEPCDCSYGUBvWT60hjf7a5mSYqB9Na2EwtjwxV+4GvI7IxZL
 WLtFPv+Q8Q8D/nPT0dcC7JZF4q1HGuzlXS5Z2jVYuk760qUvoL3qDNiqvFT7li++fUUAwpZo2ny
 cNilz8lk=
X-Gm-Gg: ASbGncvKXqPEClajLyaZQe9eQPwvYH/4o4JO1w9FWeLYLPlYicaalqQtsBsiKihDZBv
 dcEimSjvhPbraWYSPsmGJhTp5QOCeNbqWqokFWgbo8hMSeBFH0tYxgkJsQrVmJyRi6y9wwHDH54
 sWQgmi/W4QGorzRWB0ssk7qYBw6Ton9RPOy7488SSTOqsy3NnyFvIgizLckKDFtBndL6kC+XyEN
 lS9guVXj2GK3MojL0efife16E6PcYE+pPT3RxQAJ2/k7AkYPvmZ1OP7e6epj70shr/bwuKjKEuS
 /wrIfs20cyHFzC3Db9pemAEkLsYrQ3i82ICRg9PBAH0HCNJkoqS90JhJliYNkt4Gz6hmtuednfi
 v1VIBmWLfq6R3/CTwmQRb7Hj0u7L5MfzQ5Uec
X-Google-Smtp-Source: AGHT+IEIKH6TOH8AZaem44I3Qm/MOv3M/n5qe3tOpwC8BYL3Q0bZ5jF0KDlWTjP3B6KDkviOZ9PJog==
X-Received: by 2002:a17:903:19e5:b0:248:75da:f797 with SMTP id
 d9443c01a7336-24875dafbe1mr123918785ad.54.1756383237035; 
 Thu, 28 Aug 2025 05:13:57 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-248e3e0b75esm15129025ad.8.2025.08.28.05.13.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:13:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 50/87] linux-user/ppc: Expand target_elf_gregset_t
Date: Thu, 28 Aug 2025 22:07:59 +1000
Message-ID: <20250828120836.195358-51-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

Make use of the fact that target_elf_gregset_t is a proper structure.
Drop ELF_NREG, target_elf_greg_t, and tswapreg.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/ppc/target_elf.h | 16 +++++++++++-----
 linux-user/ppc/elfload.c    | 23 ++++++++---------------
 2 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/linux-user/ppc/target_elf.h b/linux-user/ppc/target_elf.h
index 72615553ea..2a61cd2896 100644
--- a/linux-user/ppc/target_elf.h
+++ b/linux-user/ppc/target_elf.h
@@ -8,16 +8,22 @@
 #ifndef PPC_TARGET_ELF_H
 #define PPC_TARGET_ELF_H
 
+#include "target_ptrace.h"
+
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_HWCAP2         1
 #define HAVE_ELF_CORE_DUMP      1
 
-typedef abi_ulong target_elf_greg_t;
-
-/* See linux kernel: arch/powerpc/include/asm/elf.h.  */
-#define ELF_NREG                48
+/*
+ * The size of 48 words is set in arch/powerpc/include/uapi/asm/elf.h.
+ * However PPC_ELF_CORE_COPY_REGS in arch/powerpc/include/asm/elf.h
+ * open-codes a memcpy from struct pt_regs, then zeros the rest.
+ */
 typedef struct target_elf_gregset_t {
-    target_elf_greg_t regs[ELF_NREG];
+    union {
+        struct target_pt_regs pt;
+        abi_ulong reserved[48];
+    };
 } target_elf_gregset_t;
 
 #endif
diff --git a/linux-user/ppc/elfload.c b/linux-user/ppc/elfload.c
index 114e40a358..0d54da9803 100644
--- a/linux-user/ppc/elfload.c
+++ b/linux-user/ppc/elfload.c
@@ -131,23 +131,16 @@ abi_ulong get_elf_hwcap2(CPUState *cs)
     return features;
 }
 
-#define tswapreg(ptr)   tswapal(ptr)
-
 void elf_core_copy_regs(target_elf_gregset_t *r, const CPUPPCState *env)
 {
-    int i;
-    target_ulong ccr = 0;
-
-    for (i = 0; i < ARRAY_SIZE(env->gpr); i++) {
-        r->regs[i] = tswapreg(env->gpr[i]);
+    for (int i = 0; i < ARRAY_SIZE(env->gpr); i++) {
+        r->pt.gpr[i] = tswapal(env->gpr[i]);
     }
 
-    r->regs[32] = tswapreg(env->nip);
-    r->regs[33] = tswapreg(env->msr);
-    r->regs[35] = tswapreg(env->ctr);
-    r->regs[36] = tswapreg(env->lr);
-    r->regs[37] = tswapreg(cpu_read_xer(env));
-
-    ccr = ppc_get_cr(env);
-    r->regs[38] = tswapreg(ccr);
+    r->pt.nip = tswapal(env->nip);
+    r->pt.msr = tswapal(env->msr);
+    r->pt.ctr = tswapal(env->ctr);
+    r->pt.link = tswapal(env->lr);
+    r->pt.xer = tswapal(cpu_read_xer(env));
+    r->pt.ccr = tswapal(ppc_get_cr(env));
 }
-- 
2.43.0


