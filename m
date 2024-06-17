Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E005C41513
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 19:03:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJHZD-0005am-FG; Mon, 17 Jun 2024 14:58:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sJHYv-0004aw-2U
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:58:43 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sJHYt-0004zr-Bx
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:58:40 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-705c739b878so3731839b3a.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 11:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718650718; x=1719255518; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CFGck5ZAtQivWI4UcF8No9idstaPGejMMjqzgwxQWSo=;
 b=jU9HNdRQVM/6WGGdnaJ1H0gzeSgy5ixX9XhISONvogun2Y7s/0dmEcqkAMCl5taeq7
 wCLdM643SUKeOS348ON9SnC3mHRALTWoVSkxzKK7+DAqxmrzJvmCD3U2gNtRPRpjY/15
 LckdCMAkayXKpOphnKmxjEgEleFaa6/m9nWbOYXTB6DUYN9lOweMUOEU+4Q+vKrr/zm2
 zFbp1VEhaUzLCuT8I2kTYpGGr5Rj202O7Eq3lJcs8CvGln4hsS9I/1mH4f0QlhIOSxsO
 6+9OOpWm3ORFSnpb8czKpGbO88+MNncWURFc7sbhJLCT0xRn7Ar+1dsrMcaD42QSm+lZ
 rnUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718650718; x=1719255518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CFGck5ZAtQivWI4UcF8No9idstaPGejMMjqzgwxQWSo=;
 b=Fce38joghTlIAP2NzHLzsOrRIEH/QygunOzpcIf4jN9wGVLPIDX5oppLBYMkBuTbj4
 n/FTeArrxWCJtoorR9mWCvxERp0yPGrW13oGpF+8dl1eYzekORei6KaJclpJtVgWPZES
 oyx18AiKmaAxhJDpdpreBnUrMKyuh5t9mPZuwevXJueUBmVDF7M39FjGoWuqeXSuX8jY
 RcEoaQsxF2ocfzeBIwn1PIK6nitssDGqUtuQf3CzdlFLAjXMKM7uFUuNJtKP0GkzNF6y
 70gaFCCIDw606EmSOEQ4GF7rLOMxdc8XwiUC04D5CS6ORM7FC8/ee3X6hAD20/5uhnQT
 fpMg==
X-Gm-Message-State: AOJu0YxEsxcu34JndOi9nnvUxH9TWIpVTt8lIwcvesmbY/WnFokN/Dqn
 VAkE0N3bxq9y+T/KOEvtu3WoOpi132Y83ZLN5ThHA9UELJZobNqYRE996kO1tqs=
X-Google-Smtp-Source: AGHT+IHICLmSRbKJLVYswBzwTbT1DC+Xy3kjeUSZxPKppfHbgt4tqPbp5cGP22gTyTfyYP3rHZ8zMA==
X-Received: by 2002:a05:6a20:dc90:b0:1b4:a478:2275 with SMTP id
 adf61e73a8af0-1bcab0a6537mr660857637.29.1718650717808; 
 Mon, 17 Jun 2024 11:58:37 -0700 (PDT)
Received: from localhost.localdomain ([106.222.222.115])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-705ccb4aa4fsm7660637b3a.131.2024.06.17.11.58.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 11:58:37 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Ajeet Singh <itachis@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>, Ajeet Singh <itachis@FreeBSD.org>
Subject: [PATCH 08/23] Add Aarch64 sysarch() system call emulation for BSD-USER
Date: Tue, 18 Jun 2024 00:27:49 +0530
Message-Id: <20240617185804.25075-9-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240617185804.25075-1-itachis@FreeBSD.org>
References: <20240617185804.25075-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=itachis6234@gmail.com; helo=mail-pf1-x42e.google.com
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

From: Stacey Son <sson@FreeBSD.org>

Initial implementation of sysarch() syscall and a printing function

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
---
 bsd-user/aarch64/target_arch_sysarch.h | 42 ++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 bsd-user/aarch64/target_arch_sysarch.h

diff --git a/bsd-user/aarch64/target_arch_sysarch.h b/bsd-user/aarch64/target_arch_sysarch.h
new file mode 100644
index 0000000000..b003015daf
--- /dev/null
+++ b/bsd-user/aarch64/target_arch_sysarch.h
@@ -0,0 +1,42 @@
+/*
+ * ARM AArch64 sysarch() system call emulation for bsd-user.
+ *
+ * Copyright (c) 2015 <sson at FreeBSD>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef TARGET_ARCH_SYSARCH_H
+#define TARGET_ARCH_SYSARCH_H
+
+#include "target_syscall.h"
+#include "target_arch.h"
+
+/* See sysarch() in sys/arm64/arm64/sys_machdep.c */
+static inline abi_long do_freebsd_arch_sysarch(CPUARMState *env, int op,
+        abi_ulong parms)
+{
+    int ret = -TARGET_EOPNOTSUPP;
+
+    fprintf(stderr, "sysarch");
+    return ret;
+}
+
+static inline void do_freebsd_arch_print_sysarch(
+        const struct syscallname *name, abi_long arg1, abi_long arg2,
+        abi_long arg3, abi_long arg4, abi_long arg5, abi_long arg6)
+{
+}
+
+#endif /* TARGET_ARCH_SYSARCH_H */
-- 
2.34.1


