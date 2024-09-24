Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B17CF9C6B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 22:21:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stDtU-0005s6-QT; Tue, 24 Sep 2024 18:20:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1stDtB-0004f4-DL
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 18:20:12 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1stDt8-0001xp-7U
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 18:20:07 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7179802b8fcso4315953b3a.1
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2024 15:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727216404; x=1727821204; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DJwxZp62y1C27+GAPjWKTnxi+l8BSEYvPi6A+WTJHx8=;
 b=cif+PKt4py3vknXHT/w/fcj2j+TMwwPIhuLYaHAR4FEvSzCcGNmY06rxDWvfy+8D5B
 21/ozNKyaK27kxJg0DVckaKrIpsPuaksyK235QoIvi9qeDrnUh9OKAdE+zOUhNj14Qst
 eP91zXc7lkiigUqenN9Kn7s8cYf7ibnUpfs64RqHFAS9gRHnPJdob4gOMqOM1//9zF1Z
 Ffwp8cPoVoQ5rOJugn67dS63IZ39jmH8rEVk7kSFicXpy6MApdtkwp/R768sizFRLeGD
 L7cOja9swXcABymZ5Sh/l7WIZoW2b0EhyJ5nT5I56lYoBtoa2xYAT0ss9orJotlwEsia
 mXFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727216404; x=1727821204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DJwxZp62y1C27+GAPjWKTnxi+l8BSEYvPi6A+WTJHx8=;
 b=tbglnUksgG5L0yW3wX65DAorK2pNz/KI0bK0Ek+XlcZ5bYUg29LTywS+Dyuv4qcrLj
 CfPjrUcsVXmAeHz2dUPn++Zurxv6C+Slg+J5YhJ23qpR9BFnKFingQPukConWN67Q4hj
 zMlNp/gLfLmAiPVTYJG9qsZF4NVWSa4cXQ2s3bkjw9nGptRuNmDsL9dr7NAHtAaBKfZM
 mj4jB9t3UeYnvAbSo1rkKqCNX40s773Nxq37hbOUi2biyHJ57U+AdKoJu+xqPOP6tMst
 dNrrbc/NLAdMlqsjhBaUW+9wFcmlMp1vLDE5VPR5Tiq7iVHDPWITwBIibusQp6cQia4o
 3QPw==
X-Gm-Message-State: AOJu0Yytnv3xJc4RLxrwTfKWZSoPvCAYqpqnkiCAPn3XdmfPuUESN7On
 3QAxwCtBAxZc1z9806scTwSrACQTYhW//ZK52RPhLD8u3a80tNdyVBvweQ==
X-Google-Smtp-Source: AGHT+IFOAfKxP/14P6wU3JaShae6JLYdE66KljenOE7+Btxrhg+Y6rbII+gQuCllDAMmTvNENlXOGg==
X-Received: by 2002:a05:6a00:1827:b0:717:d4e3:df1a with SMTP id
 d2e1a72fcca58-71b0aab42a5mr946688b3a.9.1727216404455; 
 Tue, 24 Sep 2024 15:20:04 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71afc8342easm1665310b3a.11.2024.09.24.15.20.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2024 15:20:03 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Mark Corbin <mark@dibsco.co.uk>,
 Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 38/47] bsd-user: Implement RISC-V sysarch system call
 emulation
Date: Wed, 25 Sep 2024 08:17:39 +1000
Message-ID: <20240924221751.2688389-39-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240924221751.2688389-1-alistair.francis@wdc.com>
References: <20240924221751.2688389-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x429.google.com
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

Added the 'do_freebsd_arch_sysarch' function to emulate the 'sysarch'
system call for the RISC-V architecture.
Currently, this function returns '-TARGET_EOPNOTSUPP' to indicate that
the operation is not supported.

Signed-off-by: Mark Corbin <mark@dibsco.co.uk>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240916155119.14610-9-itachis@FreeBSD.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 bsd-user/riscv/target_arch_sysarch.h | 41 ++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 bsd-user/riscv/target_arch_sysarch.h

diff --git a/bsd-user/riscv/target_arch_sysarch.h b/bsd-user/riscv/target_arch_sysarch.h
new file mode 100644
index 0000000000..9af42331b4
--- /dev/null
+++ b/bsd-user/riscv/target_arch_sysarch.h
@@ -0,0 +1,41 @@
+/*
+ *  RISC-V sysarch() system call emulation
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
+#ifndef TARGET_ARCH_SYSARCH_H
+#define TARGET_ARCH_SYSARCH_H
+
+#include "target_syscall.h"
+#include "target_arch.h"
+
+static inline abi_long do_freebsd_arch_sysarch(CPURISCVState *env, int op,
+        abi_ulong parms)
+{
+
+    return -TARGET_EOPNOTSUPP;
+}
+
+static inline void do_freebsd_arch_print_sysarch(
+        const struct syscallname *name, abi_long arg1, abi_long arg2,
+        abi_long arg3, abi_long arg4, abi_long arg5, abi_long arg6)
+{
+
+    gemu_log("UNKNOWN OP: %d, " TARGET_ABI_FMT_lx ")", (int)arg1, arg2);
+}
+
+#endif /* TARGET_ARCH_SYSARCH_H */
-- 
2.46.1


