Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C2B6C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 19:07:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX2fi-0005zW-Iq; Wed, 02 Jul 2025 14:59:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2fa-0005Gp-FU
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:58:59 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2fW-00030r-6R
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:58:56 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-451dbe494d6so51372515e9.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 11:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751482731; x=1752087531; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1uXIn8FF+VzmPqfa1+8428fM/RDSExpMjk/8h5CzpzY=;
 b=vsYlBTQSerjkSp1MHk8tqITuXljA3pVp7j1N6VLz/c76QJBSR/agcaAFXvtaGmqQE0
 BRAs/gsZj4UQqHDzzg2YQLwNFTpnnJpbxSfTae2aG8hymXJ+P7r8oJHkAZkNMIIewWLw
 QoBL+XvldWFTKOn9Ig3uzFsp3yeQUIjQ1Yf0HU+eU3Adabti3G605ub8F4rqxf4VgQS/
 oAaryRlUloY2u8opCIH+QkCvh5S1AO6aWjSR9BXU2RcGF+6KFXAGs/BtNDwGAS5U5mK8
 j+HtPJi7ISB9luEs2KRnZapPnJfpiGL6HGzFnzS4JFDz8Noy66odEVQBnFbr1UX9pKJL
 iHew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751482731; x=1752087531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1uXIn8FF+VzmPqfa1+8428fM/RDSExpMjk/8h5CzpzY=;
 b=GaGnc6RVUV2WdSsxgUdSntrvuQND+rZHyLcMDwTE8qOcjZsi2xiI52RCMQ+NFDqVmH
 XxJLzol2vftWFPSKKMzOI062EYq2l9ZhTLOuoksLYVo9lS3a/UlhWwmkHI86aieIwRgt
 5YKerpcDcofnulaDMpajWa5WvPejWaQMR8xsqu9erteLgexUEDzJKLgNfSzgL2Po++th
 GUXnu+oM7y1lqULlqpl3KzlkPDlJztHSaogp5EVV/OBNwxfH9SeiBni0MzfspQJdUZMt
 L7BC3out2M1gsQIIu7VKllKoRuJracuxNtpebIakIauZs21y2HWtZbXiw5P/u29gVByX
 Dt7w==
X-Gm-Message-State: AOJu0YwlPqcT/mvyVyymBoUiVfg6gtIUV3oKBIz9JPXroDWxSzLl5fOZ
 COVtWx2PvBoXvfR21oTv8D1FKHsWOLwZfi0+attlufE6hH/Wzs34yfdFOXThYKRkH2xYyxoc2sq
 59yTP
X-Gm-Gg: ASbGncutDakUPgJISRopui11ZU83odcOWtnz/G1jLVWPX5yZb+FpX4UV+TGXc9xrfvD
 +uW6eNPB71hh3Vb04UuQpOSKLm4J33Yu7EbgDF/8DbjCKwc8b/DX5wO6T1kh59Isuv1NULsU/Iq
 usKabT7KE+/w0k8DALlmn3/6kf8+PfIKaugJ1SfVrZ2TmWUXlzVwyVkWJlFiAYcwbfW159R+SYb
 sKjWQFiMUpYwRW06nK0ARgmpcTCwTgwr+xhX43tHzjQThwSPi7+GZy+hUDmZQGdlZl6wpRaXwX8
 lTIPkyiCHYt0uj7M6wnoWwu3DdtSGy5oCDSGazNN11hUxwW+QcL985wAJXl50Opr6MjXqlNQ+ma
 91FTUjZpIQqP7xRh6WUFR4vj7wWQ1qZ40Isui
X-Google-Smtp-Source: AGHT+IFcMaxcXN6l1JR93v82qQ/msbA7irNVRKuh7yXLBPpeLwsnRwam4h/82zJfO73D3dwnTRf+qw==
X-Received: by 2002:a05:600c:3504:b0:43c:ee3f:2c3 with SMTP id
 5b1f17b1804b1-454a36e7842mr36633135e9.7.1751482730663; 
 Wed, 02 Jul 2025 11:58:50 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9bde8c8sm5752785e9.31.2025.07.02.11.58.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Jul 2025 11:58:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org
Subject: [PATCH v4 43/65] accel/dummy: Extract 'dummy-cpus.h' header from
 'system/cpus.h'
Date: Wed,  2 Jul 2025 20:53:05 +0200
Message-ID: <20250702185332.43650-44-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702185332.43650-1-philmd@linaro.org>
References: <20250702185332.43650-1-philmd@linaro.org>
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
---
 accel/dummy-cpus.h    | 14 ++++++++++++++
 include/system/cpus.h |  5 -----
 accel/dummy-cpus.c    |  1 +
 accel/qtest/qtest.c   |  1 +
 accel/xen/xen-all.c   |  1 +
 5 files changed, 17 insertions(+), 5 deletions(-)
 create mode 100644 accel/dummy-cpus.h

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
index 8b109d4c03b..2606fe97b49 100644
--- a/accel/qtest/qtest.c
+++ b/accel/qtest/qtest.c
@@ -24,6 +24,7 @@
 #include "qemu/guest-random.h"
 #include "qemu/main-loop.h"
 #include "hw/core/cpu.h"
+#include "accel/dummy-cpus.h"
 
 static int64_t qtest_clock_counter;
 
diff --git a/accel/xen/xen-all.c b/accel/xen/xen-all.c
index ba752bbe5de..f412ea346bb 100644
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


