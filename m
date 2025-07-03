Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72797C83F04
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 17:42:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXNqa-0000Rl-VF; Thu, 03 Jul 2025 13:35:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNq5-0008CT-C5
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:35:13 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNq3-0001ab-B6
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:35:13 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4535fbe0299so495555e9.3
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 10:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751564109; x=1752168909; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q2RhrPiz7//vskyUlSGbSsu4uaU4qA0h0V9+uZJcvBs=;
 b=o3Q+fczeOcfLnF0LHPEi/RHqBdGk48BQOwPQ/kZe1pH7+Rgmjc48W9XCML/EM1EbGN
 n0rWfwadRtclzLQExxiLY6VBD4bX8GKfnXqB7Jcf4QCdSRPrI3Z/RDnsf/+ylsQsebCr
 yZgBZOXWfDOk+06v7TTn9gPtHt9LDmTwF7D8FXsGzTbCeiZ8+NYDxccmpzRbywSkJkEk
 rwdaJXASx2oXQ3aZgfnOz3W+BQDaYv8bTWIW4j9ZQ9RUv3eDZ4sx8kYZg7xYvNjdvEjD
 8poaac4Pr9bFwSN7lwlCOBLesUcpugxaA1FowRI//lV0dHLMnLPKIkte4N5U1iGwalQd
 GjKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751564109; x=1752168909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q2RhrPiz7//vskyUlSGbSsu4uaU4qA0h0V9+uZJcvBs=;
 b=NNcdlKHasuEskR2nGtcM/iGx+7N5gVW85nAp5g2oiCU17eEHnq85FDd2wwsUjEkqGe
 3f3HwpPrUtGbzgXzvYthoo+55BPx0aX9ENHGDf+PmTewjq0cZ4slh6dJ+clk0ioJ/+4E
 q3FqFMpij4LKeYBr+u0sBabcRFcoHKQvYV1z+rDY2gh79PuUhbxDN+cJzxmfxIwFWj9C
 7KAvqwzTdO1By//wwQv3eGb7KzPXCQ+FgInNrvr++Gp/Rjcu35hYwqDo9DN2XNWcPaiP
 k9XUzNPBjoxgCIMWZnLAmzvLJKrqUUyL1xG9+S9ApXWMvzw6LxkoagFMHz+9SA1gch69
 9MuA==
X-Gm-Message-State: AOJu0YyeknWB1eLAeB+d5uMQ6/c3yjswNTrYhpGf4Wm8NzzPUVr2NpB/
 by6s2Dvm9pmd/ARCWeyov5V76ZABy7DEBIWeLD1sPMyjRjfEVBEG35k0jIrs4DogeApshQnZB9q
 TFLYuHts=
X-Gm-Gg: ASbGnctDyD2a2G6fwumHH3fWCxmY3aySk5lOZBveyvJ/qVFIbPk0+8TesZ/DeQ8v9C2
 4JdzUQojFoMK4b1XQotooLVt3xZHZSGM5vAkbazMYRNnd06C1wKKN5knMtDr6h1XqQoBylj3+pO
 WoAm1DTANxjQS1aJPZputdV7mmhGK9cO8QwuWsgQiIoWS1ClM9Ee3akjo42VfuSbJtvLpa5xsTC
 iXJiVB3u23UjMZQly7YxxYpaJ/4idfdjGVB6vKfpzelz3pYZ4c520vepwSCGCWcXhWswhmFaCqH
 bvcANszDV/DISYMIpQVP0IbTnl11a/nYVwmLH1RDn2poYwPkgBHFLVoPSV0VyMsZEjbdTVeKLwI
 fyOSAPj19NBAlT8Tlgo+qPVktwM5eImS6Z6D1
X-Google-Smtp-Source: AGHT+IF/UA/DtD6lXjiLszACK+Pk1isaks747knolJ87gw1k/av0EcLUiE+/w969+nBtehLwL7opBQ==
X-Received: by 2002:a05:600c:3593:b0:441:b3eb:570a with SMTP id
 5b1f17b1804b1-454a9c620e9mr53209265e9.2.1751564109257; 
 Thu, 03 Jul 2025 10:35:09 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454b1687196sm3427985e9.21.2025.07.03.10.35.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 10:35:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org
Subject: [PATCH v6 26/39] accel/dummy: Extract 'dummy-cpus.h' header from
 'system/cpus.h'
Date: Thu,  3 Jul 2025 19:32:32 +0200
Message-ID: <20250703173248.44995-27-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703173248.44995-1-philmd@linaro.org>
References: <20250703173248.44995-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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
index b1cbfe115bc..37d02b2313c 100644
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


