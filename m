Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58E68C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 10:20:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXdSu-0007ro-FO; Fri, 04 Jul 2025 06:16:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXdSn-0007bp-FL
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:16:13 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXdSl-0006uX-Ah
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:16:13 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-450cf0120cdso5767535e9.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 03:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751624169; x=1752228969; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eLugPiCaiIPoDJ+xihdsj48/eAMyy0a5nMvy9lICya8=;
 b=yOBOCCDsD+2jcSoQzEOj2uOMP4eQGmWjlV8bXX9xZMJPTWdeYlH1Y/3zQNFcqDKZB+
 kDDn/dx0E9ymmHUYSPax7Y5MDLoFDhX7BJ4czxUyUw9dnpNn39IIbQvAT60mcfkGVMXl
 Z5q7AX3prAlWhkWJ0CQTZFezeWyOcefJBFz0/b9sxVs7R9ZNCc0F9/BWNOe/THi2e7Ec
 cZz/yzIHSR85wtyf9Nv4vD+YfDgNqlDAooKbz1DFaYKw09SxYepanSAFJH2PXC9iOyAj
 wo10Shuq6ZaCGmyisjo3ERtfnYY3VAzL8pUw/W+Qn+h75kXSUBbLy5xmmIiJ87kHW2sy
 3l0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751624169; x=1752228969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eLugPiCaiIPoDJ+xihdsj48/eAMyy0a5nMvy9lICya8=;
 b=hKi0CnDrH0tOjwEg4Cv/ScvIesYi6EaY2xOCv2QUp2MJymASqPlYLwQoLAvr55Da/S
 liI+mMEU2BZ2BfDtlBqhjjWtg88xOPkt4EYr4U414oYGLNKmrykK8HJzV3rApkYDXuJS
 AdVM1n6nankgGUMd7f2Dt9sdnVX2IfPeidvERm3LrU2DQ1mZQAaKp5kT2De/Vxdcc71t
 Oheq9BpcqGKdkdxmMnvWYj1HggETeMG8qfEeNDVL10R9NPgdbzXdJPmDL1qkEeAOFHcJ
 doZAinzj3Jt4kCc9Phbh1AkYJ2uzXlcDTAbmZ3P8Sdrmfwdsu27QIXngyzGzWBFqBhsz
 xTMg==
X-Gm-Message-State: AOJu0YzTw1KiMaQynZSzsNAANEbm6z1pOpky/oxqUvIXu9XundLCA0Hk
 jFm8fk6gbEjFi81CduZFk5wwnjWyM0iSwHjMyAfXTLVurbhcH7OyytNC8RsPNFZrMu+W8UtxAmh
 +6Il/2J8=
X-Gm-Gg: ASbGnctB+9aTM7ybF22FniYOTETp/+e+PScVF/bC/eRUU2VO2Ro9f2c9SKtjemUgQ9H
 RRe8Po6mOEc2p9zbtSTWPQKQ9xc8PvcxWpIEQLz4oBb/YKxHHWU/82U/F18KPENhNRHxHnpOX7o
 b85A0A1kt+3tQBCrZ1S4j4tV24Jq8wA3VATVPBM7w/OJLYRCS/Gl8XdUdtorQMwPAFN2hnkLKqV
 97pLomNz4XHOdxDoRd5pT1MMdjPIzxzwJtYQHyKlZDZXEO9jOdCa6FXx1EHM4aUzk3OVh+rYrHq
 3ER0MrW4cNKX01V9tCJfr/iyoFc9lZQAOSAUxW7Gu4tptriOE/sB4IUWQ03Q3vMOuLM5iCrYTtO
 UKTs4vTwkFnANgfqT/MOrOov/iazBcgP/Jy/X
X-Google-Smtp-Source: AGHT+IEJBADweT8GYL07R9mTSwjfLWLAHQeZ0BPabF17A6gc7gIOa03HH81Zaz21CYVuztClcwQNtQ==
X-Received: by 2002:a05:600c:3b11:b0:43d:ac5:11e8 with SMTP id
 5b1f17b1804b1-454b4ead65emr12792475e9.21.1751624168521; 
 Fri, 04 Jul 2025 03:16:08 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9be5bbfsm50663475e9.34.2025.07.04.03.16.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Jul 2025 03:16:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/31] accel/dummy: Extract 'dummy-cpus.h' header from
 'system/cpus.h'
Date: Fri,  4 Jul 2025 12:14:21 +0200
Message-ID: <20250704101433.8813-21-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250704101433.8813-1-philmd@linaro.org>
References: <20250704101433.8813-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

'dummy' helpers are specific to accelerator implementations,
no need to expose them via "system/cpus.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Message-Id: <20250703173248.44995-27-philmd@linaro.org>
---
 MAINTAINERS           |  1 +
 accel/dummy-cpus.h    | 14 ++++++++++++++
 include/system/cpus.h |  5 -----
 accel/dummy-cpus.c    |  1 +
 accel/qtest/qtest.c   |  1 +
 accel/xen/xen-all.c   |  1 +
 6 files changed, 18 insertions(+), 5 deletions(-)
 create mode 100644 accel/dummy-cpus.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 0fd8b2a4e61..fca98e12195 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -503,6 +503,7 @@ F: include/system/accel-*.h
 F: include/system/cpus.h
 F: include/accel/accel-cpu*.h
 F: accel/accel-*.?
+F: accel/dummy-cpus.?
 F: accel/Makefile.objs
 F: accel/stubs/Makefile.objs
 F: cpu-common.c
diff --git a/accel/dummy-cpus.h b/accel/dummy-cpus.h
new file mode 100644
index 00000000000..d18dd0fdc51
--- /dev/null
+++ b/accel/dummy-cpus.h
@@ -0,0 +1,14 @@
+/*
+ * Dummy cpu thread code
+ *
+ * Copyright IBM, Corp. 2011
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef ACCEL_DUMMY_CPUS_H
+#define ACCEL_DUMMY_CPUS_H
+
+void dummy_start_vcpu_thread(CPUState *cpu);
+
+#endif
diff --git a/include/system/cpus.h b/include/system/cpus.h
index 3226c765d01..69be6a77a75 100644
--- a/include/system/cpus.h
+++ b/include/system/cpus.h
@@ -7,11 +7,6 @@ void cpus_register_accel(const AccelOpsClass *i);
 /* return registers ops */
 const AccelOpsClass *cpus_get_accel(void);
 
-/* accel/dummy-cpus.c */
-
-/* Create a dummy vcpu for AccelOpsClass->create_vcpu_thread */
-void dummy_start_vcpu_thread(CPUState *);
-
 /* interface available for cpus accelerator threads */
 
 /* For temporary buffers for forming a name */
diff --git a/accel/dummy-cpus.c b/accel/dummy-cpus.c
index 867276144fa..03cfc0fa01e 100644
--- a/accel/dummy-cpus.c
+++ b/accel/dummy-cpus.c
@@ -17,6 +17,7 @@
 #include "qemu/guest-random.h"
 #include "qemu/main-loop.h"
 #include "hw/core/cpu.h"
+#include "accel/dummy-cpus.h"
 
 static void *dummy_cpu_thread_fn(void *arg)
 {
diff --git a/accel/qtest/qtest.c b/accel/qtest/qtest.c
index 92bed9264ce..612cede160b 100644
--- a/accel/qtest/qtest.c
+++ b/accel/qtest/qtest.c
@@ -24,6 +24,7 @@
 #include "qemu/guest-random.h"
 #include "qemu/main-loop.h"
 #include "hw/core/cpu.h"
+#include "accel/dummy-cpus.h"
 
 static int64_t qtest_clock_counter;
 
diff --git a/accel/xen/xen-all.c b/accel/xen/xen-all.c
index de52a8f882a..c150dd43cab 100644
--- a/accel/xen/xen-all.c
+++ b/accel/xen/xen-all.c
@@ -18,6 +18,7 @@
 #include "hw/xen/xen_igd.h"
 #include "chardev/char.h"
 #include "qemu/accel.h"
+#include "accel/dummy-cpus.h"
 #include "system/accel-ops.h"
 #include "system/cpus.h"
 #include "system/xen.h"
-- 
2.49.0


