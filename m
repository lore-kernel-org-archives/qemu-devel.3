Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4EDBC021B7
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 14:03:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlTbU-0000FQ-Ks; Fri, 21 Feb 2025 09:02:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liuwe@linux.microsoft.com>)
 id 1tlOWv-0006Wc-7L
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:37:05 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liuwe@linux.microsoft.com>) id 1tlOWt-00017U-GB
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:37:04 -0500
Received: by linux.microsoft.com (Postfix, from userid 1031)
 id 310072054585; Fri, 21 Feb 2025 00:36:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 310072054585
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1740126990;
 bh=erb5rWE/+gsksSJoNRYoDKliuHhKlMd1pYrL4uHaK9M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XaXfLUCMVjz836sQ9M8Nm8qt9lPPjtKPoKqvK1ubBtZlwQQ2BDVK3puc4JXRS8grl
 RPkS3XDnx8Y4mIJESbJr5d3ymdfAV6vAkHLQ2XvX4B3ihSinaCP5gC6lSpZoY/8cqL
 HIF0RTq28dJfT9v4mNKdlKI+f5IdCPLcP+lvNhLk=
From: Wei Liu <liuwe@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: wei.liu@kernel.org, dirty@apple.com, rbolshakov@ddn.com,
 phil@philjordan.eu, jinankjain@linux.microsoft.com, liuwe@microsoft.com,
 muislam@microsoft.com, ziqiaozhou@microsoft.com,
 mukeshrathor@microsoft.com, magnuskulke@microsoft.com,
 prapal@microsoft.com, jpiotrowski@microsoft.com, deviv@microsoft.com,
 Wei Liu <liuwe@linux.microsoft.com>
Subject: [RFC PATCH v1 18/19] target/i386/x86-insn-emul: add a panic.h
Date: Fri, 21 Feb 2025 00:36:26 -0800
Message-Id: <1740126987-8483-19-git-send-email-liuwe@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1740126987-8483-1-git-send-email-liuwe@linux.microsoft.com>
References: <1740126987-8483-1-git-send-email-liuwe@linux.microsoft.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=liuwe@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 21 Feb 2025 09:01:13 -0500
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

The macros will be used by the instruction emulator. The code is the same as
the one under hvf.

Signed-off-by: Wei Liu <liuwe@linux.microsoft.com>
---
 target/i386/x86-insn-emul/panic.h | 45 +++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 target/i386/x86-insn-emul/panic.h

diff --git a/target/i386/x86-insn-emul/panic.h b/target/i386/x86-insn-emul/panic.h
new file mode 100644
index 0000000000..71c24874ba
--- /dev/null
+++ b/target/i386/x86-insn-emul/panic.h
@@ -0,0 +1,45 @@
+/*
+ * Copyright (C) 2016 Veertu Inc,
+ * Copyright (C) 2017 Google Inc,
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef X86_EMU_PANIC_H
+#define X86_EMU_PANIC_H
+
+#define VM_PANIC(x) {\
+    printf("%s\n", x); \
+    abort(); \
+}
+
+#define VM_PANIC_ON(x) {\
+    if (x) { \
+        printf("%s\n", #x); \
+        abort(); \
+    } \
+}
+
+#define VM_PANIC_EX(...) {\
+    printf(__VA_ARGS__); \
+    abort(); \
+}
+
+#define VM_PANIC_ON_EX(x, ...) {\
+    if (x) { \
+        printf(__VA_ARGS__); \
+        abort(); \
+    } \
+}
+
+#endif
-- 
2.39.5 (Apple Git-154)


