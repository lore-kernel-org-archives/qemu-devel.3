Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DCF5C3ABA1
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2024 15:29:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spr96-0006ow-2T; Sun, 15 Sep 2024 11:26:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1spr94-0006ks-Ve
 for qemu-devel@nongnu.org; Sun, 15 Sep 2024 11:26:38 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1spr93-0008D5-8i
 for qemu-devel@nongnu.org; Sun, 15 Sep 2024 11:26:38 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2054feabfc3so29904915ad.1
 for <qemu-devel@nongnu.org>; Sun, 15 Sep 2024 08:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726413995; x=1727018795; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UhgZSr77cs856626csVUMKafDNElH2DCETLtbp74JlY=;
 b=AMSToZ9UjwoC8D9IKxAxOoZdt5ydqY7khAOpGuuPXK6AhqgIpAb6O5ACn9FVX9ySu+
 yuHcDUr5wdefDOtJe/+r58cndH+GkOlmg3UineeQ1DMIU7QCT/zVddB1B2whuyvKYOW1
 YqJ52j/kKh2lGPnB/vCmSvVbEmzC4J5zqzHIZh8J/gk8ENQtS9WEDIvsAM71FYvPBkQL
 OWz0MSFQ8O8q3dGkKA5xH/lOomakEWbdvEkAHgygr6ud9Pv3nZ7kI9nikPQ/CBCY/3Oo
 U0mLsDNa7XjlSvcCAZqDC5hhDvWo0JX0CIci3TgGCdv8T1xzCd/L1dneMODgrQoAEM5q
 XleQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726413995; x=1727018795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UhgZSr77cs856626csVUMKafDNElH2DCETLtbp74JlY=;
 b=asaM0InVYWohiMkNUj/XAXoySZwGcYc+To8AOov9u/gtdKjcisc4b/H3PuJIOdEDqR
 PonckuHPK23UFNsLgPYlrfFdcNja5Qjxf37bDk7FplkN9+KLXJGkNm90zId6uDok/Vb3
 B5qq45DWzWXxDlII+hLyaf1f1GFPYrwP73APaGs5SPWpjIYWlbVxFSQJmGdLkF5N2doC
 D7FwzOTKORWQ9+d/6iwXjqvpAj1iYmRA9pAtqhcmpIwRU4FcblkXLeJxGLmbMJmxiIMB
 +/VNPc1poxZmvxddon41KcBi0NB8EA806ENs0n0nRBzMOePdStHb4yA/PIlZF6wFCS0P
 7m4A==
X-Gm-Message-State: AOJu0YwQJXqG7FurafqBHd96vSUzU0/gPzYStB8lKwNcUO7OovIe5aau
 ii/BXbaKoGAzcL+cXAPlVKs5bpyzTLg28k0o54czqbqEE2t272vjmzTf4w==
X-Google-Smtp-Source: AGHT+IEJbXRt0/kGfVjZKKqguJX2pseBesfsDqFkqeoIcWDjoDoezZ2ZQWD8IRJ1/xK0JYe7pcZHRg==
X-Received: by 2002:a17:902:e2c2:b0:205:7574:3b87 with SMTP id
 d9443c01a7336-2076e347efdmr140700875ad.15.1726413995352; 
 Sun, 15 Sep 2024 08:26:35 -0700 (PDT)
Received: from localhost.localdomain (14-200-149-22.tpgi.com.au.
 [14.200.149.22]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-207946f34c1sm22554335ad.184.2024.09.15.08.26.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Sep 2024 08:26:34 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Mark Corbin <mark@dibsco.co.uk>, Warner Losh <imp@bsdimp.com>,
 Ajeet Singh <itachis@FreeBSD.org>, Jessica Clarke <jrtc27@jrtc27.com>,
 Kyle Evans <kevans@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v6 09/17] bsd-user: Add RISC-V thread setup and initialization
 support
Date: Mon, 16 Sep 2024 01:25:46 +1000
Message-Id: <20240915152554.8394-10-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240915152554.8394-1-itachis@FreeBSD.org>
References: <20240915152554.8394-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=itachis6234@gmail.com; helo=mail-pl1-x62e.google.com
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

From: Mark Corbin <mark@dibsco.co.uk>

Implemented functions for setting up and initializing threads in the
RISC-V architecture.
The 'target_thread_set_upcall' function sets up the stack pointer,
program counter, and function argument for new threads.
The 'target_thread_init' function initializes thread registers based on
the provided image information.

Signed-off-by: Mark Corbin <mark@dibsco.co.uk>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Co-authored-by: Jessica Clarke <jrtc27@jrtc27.com>
Co-authored-by: Kyle Evans <kevans@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/riscv/target_arch_thread.h | 47 +++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 bsd-user/riscv/target_arch_thread.h

diff --git a/bsd-user/riscv/target_arch_thread.h b/bsd-user/riscv/target_arch_thread.h
new file mode 100644
index 0000000000..95cd0b6ad7
--- /dev/null
+++ b/bsd-user/riscv/target_arch_thread.h
@@ -0,0 +1,47 @@
+/*
+ *  RISC-V thread support
+ *
+ *  Copyright (c) 2019 Mark Corbin
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef TARGET_ARCH_THREAD_H
+#define TARGET_ARCH_THREAD_H
+
+/* Compare with cpu_set_upcall() in riscv/riscv/vm_machdep.c */
+static inline void target_thread_set_upcall(CPURISCVState *regs,
+    abi_ulong entry, abi_ulong arg, abi_ulong stack_base,
+    abi_ulong stack_size)
+{
+    abi_ulong sp;
+
+    sp = ROUND_DOWN(stack_base + stack_size, 16);
+
+    regs->gpr[xSP] = sp;
+    regs->pc = entry;
+    regs->gpr[xA0] = arg;
+}
+
+/* Compare with exec_setregs() in riscv/riscv/machdep.c */
+static inline void target_thread_init(struct target_pt_regs *regs,
+    struct image_info *infop)
+{
+    regs->sepc = infop->entry;
+    regs->regs[xRA] = infop->entry;
+    regs->regs[xA0] = infop->start_stack;
+    regs->regs[xSP] = ROUND_DOWN(infop->start_stack, 16);
+}
+
+#endif /* TARGET_ARCH_THREAD_H */
-- 
2.34.1


