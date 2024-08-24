Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE6EC5472E
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2024 04:58:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shipa-0005xd-J7; Sat, 24 Aug 2024 00:56:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1shipZ-0005x9-EC
 for qemu-devel@nongnu.org; Sat, 24 Aug 2024 00:56:53 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1shipX-0002EQ-PQ
 for qemu-devel@nongnu.org; Sat, 24 Aug 2024 00:56:53 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-70b3b62025dso2192422a34.0
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2024 21:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724475409; x=1725080209; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vomkfUtAllK0ojM5LRPdvdVvl+rjfsjudu3AMP3f7gI=;
 b=UiEyRrqluZpgh5syvXwTRYg4zFPEne9F+nXfQCNyCUEkjTJ6+YMdowtxlGUxx4epwp
 fHWjlJHknZzeQXIwMmfCiBGNkdwjIdNwSXdtaQexegfhcUykNXwrgmSGV/4zCFEOtuSa
 YUEpyMptf0KsJlRSPuiBlhiWEzTheiQ2SSXzXNtTk9sCpOgNvsGhrOgXULkq2l7CUaCp
 dqxbL6mJihyLyOVWAdPsAokdSTe292ez6rQ2jaMP2xAqNHT8syOpHFK3ewEBulorTkUq
 ve/TXQdOvXC306wwfvD7fscKHHQ40SyoigFo3ww3Srejc3Op4A+X/6fJXlHZyS4wSD1T
 JRag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724475409; x=1725080209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vomkfUtAllK0ojM5LRPdvdVvl+rjfsjudu3AMP3f7gI=;
 b=axnC7Jw+k03gdAzYdTPmyK5fmG3cO24536LDi7FEZPTnlA0RcBYW5+fuC/wRKtkpUU
 i9B0hs+ccB9yt0lV3GxGfS+r6VpoF2foEpi/V9RRMeUwfnvuw6fgx8c+SoPiHjUW3UmV
 88IhsWqJRYl9Ni86hyXG2JSJMrdrIysbCtO62YxNZ4vAcjXAM/OsB90vjBhRdeH/UfY3
 8GksG0gB7a46qKVhFID/yeaMku3AIcYUb/FqzhVdqobOPnpBlQAqfFYIO7i0wTbw60Bf
 IrsErAGalJI9ENhEpKgSh5EnXCmdehFT7chOpK7/7EuBxpfntd8H7N8RPbxsr4yNbKQf
 X6tw==
X-Gm-Message-State: AOJu0Yz5Zm2Z+5YEJ9zwkU+E2vNw8jDi9+RNEM8i419CBd5+tivlvyBk
 1lju7X17Ny0voewMEWl0a/xOtQU0od3jKyzLJwEh2T7gPt1sDzSnwMlfX8UXMDE=
X-Google-Smtp-Source: AGHT+IFLdgBz6q0Mx+RG80CGDPINpdCR3FA/QoU5tRtjoh0ihEWOf9wYtyQEhxvqaGpf8WUbc4AUkA==
X-Received: by 2002:a05:6808:bca:b0:3d9:e22a:97a4 with SMTP id
 5614622812f47-3de2a8e1762mr4913264b6e.36.1724475409103; 
 Fri, 23 Aug 2024 21:56:49 -0700 (PDT)
Received: from localhost.localdomain ([220.253.126.131])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7143422ecedsm3805934b3a.25.2024.08.23.21.56.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 21:56:47 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Mark Corbin <mark@dibsco.co.uk>,
 Ajeet Singh <itachis@FreeBSD.org>, Jessica Clarke <jrtc27@jrtc27.com>
Subject: [PATCH v3 01/17] bsd-user: Implement RISC-V CPU initialization and
 main loop
Date: Sat, 24 Aug 2024 14:56:19 +1000
Message-Id: <20240824045635.8978-2-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240824045635.8978-1-itachis@FreeBSD.org>
References: <20240824045635.8978-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=itachis6234@gmail.com; helo=mail-ot1-x329.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Added the initial implementation for RISC-V CPU initialization and main
loop. This includes setting up the general-purpose registers and
program counter based on the provided target architecture definitions.

Signed-off-by: Mark Corbin <mark@dibsco.co.uk>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Co-authored-by: Jessica Clarke <jrtc27@jrtc27.com>
---
 bsd-user/riscv/target_arch_cpu.h | 39 ++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 bsd-user/riscv/target_arch_cpu.h

diff --git a/bsd-user/riscv/target_arch_cpu.h b/bsd-user/riscv/target_arch_cpu.h
new file mode 100644
index 0000000000..e17c910ae9
--- /dev/null
+++ b/bsd-user/riscv/target_arch_cpu.h
@@ -0,0 +1,39 @@
+/*
+ *  RISC-V CPU init and loop
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
+#ifndef TARGET_ARCH_CPU_H
+#define TARGET_ARCH_CPU_H
+
+#include "target_arch.h"
+
+#define TARGET_DEFAULT_CPU_MODEL "max"
+
+static inline void target_cpu_init(CPURISCVState *env,
+        struct target_pt_regs *regs)
+{
+    int i;
+
+    for (i = 1; i < 32; i++) {
+        env->gpr[i] = regs->regs[i];
+    }
+
+    env->pc = regs->sepc;
+}
+
+#endif /* TARGET_ARCH_CPU_H */
-- 
2.34.1


