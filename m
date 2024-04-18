Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AA13C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 19:28:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxXQ6-0000s0-Pr; Thu, 18 Apr 2024 15:27:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxXOi-0007te-PF
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 15:26:18 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxXOg-0007PT-8N
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 15:26:16 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a5269c3f9c7so134802866b.2
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 12:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713468372; x=1714073172; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9U+h/wZIc3z+oX/TXzP2qUKxN0wKW4ADsCvM3ymjRp0=;
 b=OXhY/Buhko3s7UunL/ForDhnDCXTzNZnT86h9tZD2ta+Z+fJ0d64GwRu2JZ30LcfzM
 WjRuXcIe7y/BrLfY/QGRhwIzOeDHbJa3sqZS1IFnj2rHeKQy/P3zXw+x1sYcQZC+uMPL
 6pu5jtSZJGgXHiYu0ZsmlVEVldbY+TWEJ0Mjr/RcmoGR83DbFcFNmKTm3Cg/erWPrrIk
 EwqC0YJOIvsqPzylwTXfMuxxRao7rhHw+NUMzqIBS5R6qMgSRen0KzSfdf0SwaNdGEaT
 6t2o7prZZQpvS45bC9j5SE1qGf1BUMlnp82rxA3NQaEjCTJMnKnhURWBkyah+Q6Os0sM
 Wd4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713468372; x=1714073172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9U+h/wZIc3z+oX/TXzP2qUKxN0wKW4ADsCvM3ymjRp0=;
 b=JVwMJPW2khuEtOMYuvRH6QNu1eGIAYs7dAVBorN5OhjrTB9jhP9u5h02UEbyVSo9RO
 aVtEcogJG76tauta0iTQmFI8qA7hInEqSqD35J2HKYBeT7R3bPRf3lZXdybsnEgEwprV
 KnuN9sH30NEfzniCdBjHhYm3TUx1IPqeLE66XJjcDwIeV/rgG6OL5wcYksPyuoh1uAmr
 sqJ/MjgbESf8W+ue/BIr1jGiY9/bBYYqrNA7xoLt8pCylQGBmKiWyHRZ3sgYiYW0uzSU
 CsbiILXFWL3AoBLHIrCjCE4h+Gsof4R7BM7FQykDAVjLJW0QLVGmhHTBP73LMZ54PsfK
 2iPw==
X-Gm-Message-State: AOJu0YxlwNmU9KGVWcKaYQ/Haon5tPQPtCGzVvI52ibFI9ufc1GIglHI
 q/+ad9Oe6vX++R76hdxwjbcLGXaPT37Kc9L+nrO++Rr7QI7likCMRlhwJ0fBPNWsq8eHirU1DEa
 G
X-Google-Smtp-Source: AGHT+IF3G8X24RbaYze8VdVZ1kx3UyNMM7AzihIFYhjXkguw8ljWqt1FoAzlNUd5Ds9C7eQQOymXBQ==
X-Received: by 2002:a17:906:2642:b0:a51:982e:b3f7 with SMTP id
 i2-20020a170906264200b00a51982eb3f7mr47184ejc.37.1713468371935; 
 Thu, 18 Apr 2024 12:26:11 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.151.213])
 by smtp.gmail.com with ESMTPSA id
 v18-20020a170906489200b00a46baba1a0asm1259512ejq.100.2024.04.18.12.26.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Apr 2024 12:26:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH 07/24] exec: Un-inline tlb_vaddr_to_host() and declare it in
 'exec/cputlb.h'
Date: Thu, 18 Apr 2024 21:25:06 +0200
Message-ID: <20240418192525.97451-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240418192525.97451-1-philmd@linaro.org>
References: <20240418192525.97451-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
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

Declare tlb_vaddr_to_host() in "exec/cputlb.h" with the CPU TLB
API. Un-inline the user emulation definition to avoid including
"exec/cpu_ldst.h" (which declares g2h) in "exec/cputlb.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/cpu_ldst.h      | 24 ------------------------
 include/exec/cputlb.h        | 18 ++++++++++++++++++
 accel/tcg/user-exec.c        |  7 +++++++
 target/arm/tcg/helper-a64.c  |  1 +
 target/riscv/vector_helper.c |  1 +
 target/sparc/mmu_helper.c    |  1 +
 6 files changed, 28 insertions(+), 24 deletions(-)

diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index 63186b07e4..7032949dba 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -418,28 +418,4 @@ static inline int cpu_ldsw_code(CPUArchState *env, abi_ptr addr)
     return (int16_t)cpu_lduw_code(env, addr);
 }
 
-/**
- * tlb_vaddr_to_host:
- * @env: CPUArchState
- * @addr: guest virtual address to look up
- * @access_type: 0 for read, 1 for write, 2 for execute
- * @mmu_idx: MMU index to use for lookup
- *
- * Look up the specified guest virtual index in the TCG softmmu TLB.
- * If we can translate a host virtual address suitable for direct RAM
- * access, without causing a guest exception, then return it.
- * Otherwise (TLB entry is for an I/O access, guest software
- * TLB fill required, etc) return NULL.
- */
-#ifdef CONFIG_USER_ONLY
-static inline void *tlb_vaddr_to_host(CPUArchState *env, abi_ptr addr,
-                                      MMUAccessType access_type, int mmu_idx)
-{
-    return g2h(env_cpu(env), addr);
-}
-#else
-void *tlb_vaddr_to_host(CPUArchState *env, abi_ptr addr,
-                        MMUAccessType access_type, int mmu_idx);
-#endif
-
 #endif /* CPU_LDST_H */
diff --git a/include/exec/cputlb.h b/include/exec/cputlb.h
index ef18642a32..173eb98b9a 100644
--- a/include/exec/cputlb.h
+++ b/include/exec/cputlb.h
@@ -20,10 +20,28 @@
 #ifndef CPUTLB_H
 #define CPUTLB_H
 
+#include "exec/abi_ptr.h"
 #include "exec/cpu-common.h"
+#include "exec/mmu-access-type.h"
 
 #ifdef CONFIG_TCG
 
+/**
+ * tlb_vaddr_to_host:
+ * @env: CPUArchState
+ * @addr: guest virtual address to look up
+ * @access_type: 0 for read, 1 for write, 2 for execute
+ * @mmu_idx: MMU index to use for lookup
+ *
+ * Look up the specified guest virtual index in the TCG softmmu TLB.
+ * If we can translate a host virtual address suitable for direct RAM
+ * access, without causing a guest exception, then return it.
+ * Otherwise (TLB entry is for an I/O access, guest software
+ * TLB fill required, etc) return NULL.
+ */
+void *tlb_vaddr_to_host(CPUArchState *env, abi_ptr addr,
+                        MMUAccessType access_type, int mmu_idx);
+
 #if !defined(CONFIG_USER_ONLY)
 /* cputlb.c */
 void tlb_protect_code(ram_addr_t ram_addr);
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 1c621477ad..54b35588b9 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -23,6 +23,7 @@
 #include "tcg/tcg.h"
 #include "qemu/bitops.h"
 #include "qemu/rcu.h"
+#include "exec/cputlb.h"
 #include "exec/cpu_ldst.h"
 #include "exec/translate-all.h"
 #include "exec/helper-proto.h"
@@ -138,6 +139,12 @@ bool handle_sigsegv_accerr_write(CPUState *cpu, sigset_t *old_set,
     }
 }
 
+void *tlb_vaddr_to_host(CPUArchState *env, abi_ptr addr,
+                        MMUAccessType access_type, int mmu_idx)
+{
+    return g2h(env_cpu(env), addr);
+}
+
 typedef struct PageFlagsNode {
     struct rcu_head rcu;
     IntervalTreeNode itree;
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index ebaa7f00df..9b3ae06207 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -29,6 +29,7 @@
 #include "internals.h"
 #include "qemu/crc32c.h"
 #include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "exec/cpu_ldst.h"
 #include "qemu/int128.h"
 #include "qemu/atomic128.h"
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index fa139040f8..d3d9c33597 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -22,6 +22,7 @@
 #include "cpu.h"
 #include "exec/memop.h"
 #include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "exec/cpu_ldst.h"
 #include "exec/helper-proto.h"
 #include "fpu/softfloat.h"
diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index ad1591d9fd..e79a33367a 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -21,6 +21,7 @@
 #include "qemu/log.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "qemu/qemu-print.h"
 #include "trace.h"
 
-- 
2.41.0


