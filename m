Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9353AC5321D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 22:12:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sihvl-0000r2-Ty; Mon, 26 Aug 2024 18:11:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sihvh-0000gf-Hy
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 18:11:18 -0400
Received: from mail-qk1-x732.google.com ([2607:f8b0:4864:20::732])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sihvc-0000mg-0n
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 18:11:14 -0400
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7a35eff1d06so325269185a.0
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 15:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724710271; x=1725315071; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kTnjesUH2NNf1bjjgBGv8s5R89ah5gTEHGN2lVVE7a4=;
 b=pHNvbcY4Evsp+IVznnhyI2YFEUz6Vp4U6AEwwiKK8CqvjWMo3PSKgCWWSs0rb4Ugs5
 oVFQ89wO/RohvKWHmQbDNQiohxakj2P1BgQI4HWJk+1bdY5mMeFMY+6NXr/ZGSiB8ix5
 J4OnkFgMh52ckqMYY1nM/ZQSUWvdB2s1uOUpVVhk2ON68d1499YMmky2RM8rSiA+gmOq
 S1Mbuo8cpLND8tN+DZN2tyE2hly02baYe5IDfsS7F6jTUCyzdtTCrif59NoLaQlraa5I
 +37d+db0drOcHZwHnY1C5RYh2FiL4ayqC4JsMstzs2QJE2yQekcTmWZvUehKjj3kiRhv
 4wfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724710271; x=1725315071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kTnjesUH2NNf1bjjgBGv8s5R89ah5gTEHGN2lVVE7a4=;
 b=kvU8CrkRt75lwHSD3dLHtPOZhXjtLtS1pXikFeUB9cSCqJl0rZM3FdADPnfG18OeVt
 3dNj0oSE3uUvCjhNctA01nupVeylXFO5Os2RpNeJn7f7l9JMM8fRD+eDOP8Og7rWsdc4
 q07E821UtcN0uPIBBQ6ZpNZpEDbw0tjbc62QPcsH1MBCpjEaJ9Ol7SPEQGtl+Pqh/wb0
 6NlSSdPwUA3ZBP4XZITM2Fm43oH6ILpZ8olw92DWqMBiZ7fS5JnmVgLibSt5c0ZNNldd
 D1z3Ynp1kPSgsFIS5SP9WFTGgVDHqsWU4oFJlf4sXuh+dtpZU64WNMDXIAoiPSpeQhjf
 FrCA==
X-Gm-Message-State: AOJu0Yx5Dl/2tMdgXmmD3EPOQdY/NH68DSrqDtJnT/LQ4WgoTRdugcTe
 pmTv4VCiyiPlCvslb13tg/t9EXxEET9w/v2hzHRQfFRgcpNGGSobgv32J1dNznDVDmgRSkUFl6f
 S
X-Google-Smtp-Source: AGHT+IGxyN0ScRvf8Afqwc/IGRknGR8/FbHVeE4F7/oUu2U17kpLLQExi0ONjRrLSpRsZO5+fo9o3w==
X-Received: by 2002:a05:620a:40d5:b0:79f:87c:a540 with SMTP id
 af79cd13be357-7a6897a8b02mr1492498685a.58.1724710270701; 
 Mon, 26 Aug 2024 15:11:10 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.216.241])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a67f3fbf22sm495614385a.103.2024.08.26.15.11.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Aug 2024 15:11:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Sergey Kambalin <sergey.kambalin@auriga.com>, qemu-arm@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/4] tests/functional: Add a class containing Linux kernel
 helpers
Date: Tue, 27 Aug 2024 00:10:55 +0200
Message-ID: <20240826221058.75126-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240826221058.75126-1-philmd@linaro.org>
References: <20240826221058.75126-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::732;
 envelope-from=philmd@linaro.org; helo=mail-qk1-x732.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Use the 'linux_kernel' namespace to provide common helpers
to functional tests booting a Linux kernel.

Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/functional/qemu_test/linux_kernel.py | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 tests/functional/qemu_test/linux_kernel.py

diff --git a/tests/functional/qemu_test/linux_kernel.py b/tests/functional/qemu_test/linux_kernel.py
new file mode 100644
index 0000000000..917beb7fb6
--- /dev/null
+++ b/tests/functional/qemu_test/linux_kernel.py
@@ -0,0 +1,19 @@
+# Linux kernel functional test helpers
+#
+# Copyright (c) 2024 Linaro Ltd.
+#
+# Author:
+#  Philippe Mathieu-Daudé <philmd@linaro.org>
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from . import wait_for_console_pattern
+
+KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
+
+KERNEL_PANIC_MESSAGE = 'Kernel panic - not syncing'
+
+def linux_kernel_wait_for_pattern(test, success_message):
+    wait_for_console_pattern(test,
+                             success_message=success_message,
+                             failure_message=KERNEL_PANIC_MESSAGE)
-- 
2.45.2


