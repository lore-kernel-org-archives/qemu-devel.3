Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79F1CC369CA
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 17:30:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5pWw-0002IN-2p; Fri, 18 Apr 2025 13:29:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5pWu-0002Hz-9C
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 13:29:32 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5pWs-0008Jq-NO
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 13:29:32 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43cf58eea0fso9929605e9.0
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 10:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744997369; x=1745602169; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uIjCSbCe+xVMM2h4HZinaSvNRlvaZ1fRogQpwRBXWYs=;
 b=kW50kzh6c52jKQu1a5T1D5JeLlVqBIpbToDz2boA+NUFd+Mi363ssM2xS6szjBPG+a
 YUk7bKCe/O8BfwMKSxPKzdf7ZUDyPmIKN3JgREkSPEDrnQ3HhxULERNZ78ZwkKbfK6w3
 4AQhNMnB2k+jd5iTRr5CJGmXrS7bMisRvECAIM+eSLYtIix50qdkLUPCzv0k+E1XXqAH
 QqDMHT8OnnA4sridQAhXDdxlGjRzdfbOsZOJNF3CZgGdoUqKnYNzbILEyWTF0/ZjC7uR
 C8MWawRBZ/+MsUNdaUyD8TY83dawl6uZ+fR75xIR7gaAzqREOrlZChLykZFf2Yjr/l4h
 XlcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744997369; x=1745602169;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uIjCSbCe+xVMM2h4HZinaSvNRlvaZ1fRogQpwRBXWYs=;
 b=WWjTpv3WnsdscnzsxWpafSMZ28V2SxUW/WP6bRb/BAF+dkojuOl3QO4cxmxPZorXBy
 FeXst11ZPWlyhpFIHmlB1prfEPCGZ5Y1QyU4mb0Ybab0JkduSbjvg45oV5rJK9GjquPn
 CGBmaObuHNW2FQh1RGuui/v6davuKxDFkGF012p7+DZu0FXgZ9IfJcUPtnK/LyZquiGX
 Z6BM+m+lQ3PSJLU3aSkn6njHKyxYO5HhA7hnqPHHs+qKQNkVCOcY5sHUvc+RQlRZ3fU6
 PMk+mQx+/wzQ2DIEKXOsji2y8ZzQyTKip5qz8ircKqSu8f938OY1JB9QZvFl4GfmzEwP
 V/DQ==
X-Gm-Message-State: AOJu0Yz1mPtFLGh3N1KFIZx+7qGG8NRs1JCxc65jfYHxfW1GBnfxNV5g
 JDXrcW7T28js1fLAooYZ3+U0nZ4TXKbK/DRt/3hfg92vl96mgaozfCu1CdOrIDZ3JZB2QfnWUuE
 1
X-Gm-Gg: ASbGncve9/y3yEdGjAnclD3c6RrRTAekcUefl7fU5AmA1xwDtJRnSAKGmFfpIs14bii
 CM9+3NCIn0M4hfTrMHP7nNimYImgVyD0BEARDgY1MPB6/nq0R9FILlKKcoISzim2E7ZkdIYaZAa
 1yC2GSjjlixXbxvCtwB4exwW9DB+FQh56MfU6ErZAMET9HfyX1QSFP0glisyjVMNCrQJM+OpfnP
 NahTZysrfLsyEx9qvGALzuezpiOgrze1m+NFNAGv4r7NK3HNlH1af5m2F0j+FW0EjYbTYP64h0M
 ijqc9EvArdTsrwkudFbTSSuNy09fNVG2i1KGnhpEx0WNYRpE3GutZ0Fk559B2m0rOdQKY6WtSsc
 PeFGJqUTJcwx34dY=
X-Google-Smtp-Source: AGHT+IFUy7rXUgAbm3iStiBZCaM+q9WK5KCYwS2u10DEkC2A/4en5YNTfYaCr00f8Zoqfd/3DhT2ZA==
X-Received: by 2002:a05:600c:1f0b:b0:43b:ca39:6c75 with SMTP id
 5b1f17b1804b1-4406aba7c24mr30934115e9.16.1744997368710; 
 Fri, 18 Apr 2025 10:29:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d6e0364sm28822525e9.38.2025.04.18.10.29.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 18 Apr 2025 10:29:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [RFC PATCH v3 04/14] hw/arm: Register TYPE_TARGET_ARM/AARCH64_MACHINE
 QOM interfaces
Date: Fri, 18 Apr 2025 19:28:58 +0200
Message-ID: <20250418172908.25147-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250418172908.25147-1-philmd@linaro.org>
References: <20250418172908.25147-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Define the TYPE_TARGET_ARM_MACHINE and TYPE_TARGET_AARCH64_MACHINE
QOM interface names to allow machines to implement them.

Register these interfaces in common code in target_info-qom.c used
by all binaries because QOM interfaces must be registered before
being checked (see next commit with the 'none' machine).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/machines-qom.h | 18 ++++++++++++++++++
 target_info-qom.c             |  9 +++++++++
 2 files changed, 27 insertions(+)
 create mode 100644 include/hw/arm/machines-qom.h

diff --git a/include/hw/arm/machines-qom.h b/include/hw/arm/machines-qom.h
new file mode 100644
index 00000000000..a17225f5f92
--- /dev/null
+++ b/include/hw/arm/machines-qom.h
@@ -0,0 +1,18 @@
+/*
+ * QOM type definitions for ARM / Aarch64 machines
+ *
+ *  Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_ARM_MACHINES_QOM_H
+#define HW_ARM_MACHINES_QOM_H
+
+#define TYPE_TARGET_ARM_MACHINE \
+        "target-info-arm-machine"
+
+#define TYPE_TARGET_AARCH64_MACHINE \
+        "target-info-aarch64-machine"
+
+#endif
diff --git a/target_info-qom.c b/target_info-qom.c
index a6fd8f1d5a3..7fd58d24818 100644
--- a/target_info-qom.c
+++ b/target_info-qom.c
@@ -8,8 +8,17 @@
 
 #include "qemu/osdep.h"
 #include "qom/object.h"
+#include "hw/arm/machines-qom.h"
 
 static const TypeInfo target_info_types[] = {
+    {
+        .name           = TYPE_TARGET_ARM_MACHINE,
+        .parent         = TYPE_INTERFACE,
+    },
+    {
+        .name           = TYPE_TARGET_AARCH64_MACHINE,
+        .parent         = TYPE_INTERFACE,
+    },
 };
 
 DEFINE_TYPES(target_info_types)
-- 
2.47.1


