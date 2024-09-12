Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC93AEE644B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 05:44:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1socRu-0003U2-CK; Thu, 12 Sep 2024 01:33:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1socR7-0007xa-Mn
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:32:10 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1socR5-0003Ae-Cv
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:32:09 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-7d4f8a1626cso483641a12.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 22:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726119125; x=1726723925; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WaeqxvC3mnFGIbOSUJJaOixs9NZ+BPRonjXCXyhDCUI=;
 b=U+mMBKrfGttswZifVcHsoHYFtVbnp7qHkEhAd99+I8MIt/cdHufk5wdpLeK9SGENer
 BQAPvhH+vEeDs+clSEmouN/uI9wYYaVyxGymOxt4vOZsONcnON5pmOcQAREzpJCpr2Dl
 ytBwN+0jXySO0oDy/jgbnDbFH2qzvVqUIfSxh5veswvdZLephxeEDAPHro/3UtuJRfCX
 5+Erm5X26r19nGCBt5H6Aidj8KHXfd2rE2hHEZclaqt2evH0h+tVkOU9Lxui6H0WCNuT
 jqBd3uaK2voogN6z84SvryEZEmOiBj73JSRkN/8NX06Opzc3QaFAQmyNEYSnhrhonw3L
 2odQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726119125; x=1726723925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WaeqxvC3mnFGIbOSUJJaOixs9NZ+BPRonjXCXyhDCUI=;
 b=GdDfNEeIzDUmslgfg7L7EJDP+HwUF0bfwBbU4NkE8HMp8dc0J8EZW5umUZ7ByyXCOF
 jEzEzV4n5KrRnNhE5NIFIiaB0SUbRGFSf6bzUdLpgdjgkcPVSuP5BfgfuSwEP7juyIfs
 ElFsNnzNUdip6l00rRL8TaHks/mnfokD1uJSSzngsD4n8bDjHD8u76ULOhuU3HyhfZMo
 st3lP17SK4DXM55hg+poQ+hj4H4Z8wLm2EGn0AplEtMnbpZwzZpAccmgVCVA+lz19VHR
 4s4aWtr3dEYT0wWRyYVq834lPw+hPxNtEvyONsjaYZNO5qknfNw3N6nGRH3I50ZJBciw
 MtnA==
X-Gm-Message-State: AOJu0Yw4PszQQAAQYn5plGLEuNcn0Vk1eIrDt4tYyf1ZEoo8DjWvIDt5
 XD46z9xJzGEOnd6d+qxLc9GiVtjkvUV5riIBC6TPF7lMjk90lfWxqMUlxw==
X-Google-Smtp-Source: AGHT+IE938VDAYJJPaThw6CIJA4hwrb7XAg/5GUdYdZpz0jKMqYKetJACm9abNtJs0a0dlcTKyiUKQ==
X-Received: by 2002:a05:6a20:d81a:b0:1cf:21c7:2aff with SMTP id
 adf61e73a8af0-1cf75f1bfa2mr2293508637.23.1726119125518; 
 Wed, 11 Sep 2024 22:32:05 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fc8fdesm3833034b3a.1.2024.09.11.22.32.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 22:32:05 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Mark Corbin <mark@dibsco.co.uk>,
 Ajeet Singh <itachis@FreeBSD.org>, Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 39/47] bsd-user: Implement RISC-V signal trampoline setup
 functions
Date: Thu, 12 Sep 2024 15:29:44 +1000
Message-ID: <20240912052953.2552501-40-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912052953.2552501-1-alistair.francis@wdc.com>
References: <20240912052953.2552501-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52a.google.com
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

Added functions for setting up the RISC-V signal trampoline and signal
frame:

'set_sigtramp_args()': Configures the RISC-V CPU state with arguments
for the signal handler. It sets up the registers with the signal
number,pointers to the signal info and user context, the signal handler
address, and the signal frame pointer.

'setup_sigframe_arch()': Initializes the signal frame with the current
machine context.This function copies the context from the CPU state to
the signal frame, preparing it for the signal handler.

Signed-off-by: Mark Corbin <mark@dibsco.co.uk>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
Co-authored-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240907031927.1908-15-itachis@FreeBSD.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 bsd-user/riscv/signal.c | 63 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 bsd-user/riscv/signal.c

diff --git a/bsd-user/riscv/signal.c b/bsd-user/riscv/signal.c
new file mode 100644
index 0000000000..2597fec2fd
--- /dev/null
+++ b/bsd-user/riscv/signal.c
@@ -0,0 +1,63 @@
+/*
+ *  RISC-V signal definitions
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
+#include "qemu/osdep.h"
+
+#include "qemu.h"
+
+/*
+ * Compare with sendsig() in riscv/riscv/exec_machdep.c
+ * Assumes that target stack frame memory is locked.
+ */
+abi_long
+set_sigtramp_args(CPURISCVState *regs, int sig, struct target_sigframe *frame,
+    abi_ulong frame_addr, struct target_sigaction *ka)
+{
+    /*
+     * Arguments to signal handler:
+     *  a0 (10) = signal number
+     *  a1 (11) = siginfo pointer
+     *  a2 (12) = ucontext pointer
+     *  pc      = signal pointer handler
+     *  sp (2)  = sigframe pointer
+     *  ra (1)  = sigtramp at base of user stack
+     */
+
+     regs->gpr[xA0] = sig;
+     regs->gpr[xA1] = frame_addr +
+         offsetof(struct target_sigframe, sf_si);
+     regs->gpr[xA2] = frame_addr +
+         offsetof(struct target_sigframe, sf_uc);
+     regs->pc = ka->_sa_handler;
+     regs->gpr[xSP] = frame_addr;
+     regs->gpr[xRA] = TARGET_PS_STRINGS - TARGET_SZSIGCODE;
+     return 0;
+}
+
+/*
+ * Compare to riscv/riscv/exec_machdep.c sendsig()
+ * Assumes that the memory is locked if frame points to user memory.
+ */
+abi_long setup_sigframe_arch(CPURISCVState *env, abi_ulong frame_addr,
+                             struct target_sigframe *frame, int flags)
+{
+    target_mcontext_t *mcp = &frame->sf_uc.uc_mcontext;
+
+    get_mcontext(env, mcp, flags);
+    return 0;
+}
-- 
2.46.0


