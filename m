Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D6BAEE49BC
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 15:22:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soP3K-0003ri-FS; Wed, 11 Sep 2024 11:14:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soP1J-0003gl-MV
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 11:12:44 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soP1H-0001Jz-1e
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 11:12:37 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a8d6d0fe021so466236766b.1
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 08:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726067553; x=1726672353; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RnEXofH39QOzGuHkMNSmPSGC7FdtUJnuQkfgBew8Hmo=;
 b=ad0jAWSaIy+wC9VaW8KbeWayvvHqsN0/KTX5x9Jsqh6aVIzN0OkXqfv7fVTI7OWroG
 jj2qCVSVMcLiQCj1jGatGp5DyQnMbL92uqKYsBrxYQGolS/N2QfPULV4XZ/ZwPG+X55I
 3sXDzyXvVEYbhtuQxoVmw+c7iseB3fmT0zSd1oaGi3lbPF7/hzQsONBpMkvud8KkzDk5
 /2GGF2hYBTsvEygttK7DRGDR1q3WR+sP7Hw7Ho4epM7jSM04sCA4WJPfSzUx5THPUpSe
 lXqUgBpXeFZFNhYbQy7uFj4Bu0bxa00OGEigze6g/d42YEXYNjbRNV7OeJED9dTh7BWC
 /nfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726067553; x=1726672353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RnEXofH39QOzGuHkMNSmPSGC7FdtUJnuQkfgBew8Hmo=;
 b=jikxtt34w3ra0PuOCo0ZuHK51CZY5IEodd4xSKk6ZmT9ZPI0GlLp4O3BASFNCZaHkU
 Liv0OvHRTEu/6ggEyYiiarPEvI/FCY/8lUItQIBKJ+c4CreUrpoXciwl0mv2WC7FnmYQ
 8T9bglHWrBn38GT+UiCCRVf8GFQvqnOiCJfNrytCAFJIKPrsBgcStB+P7RkFDmwR8Ans
 PPPM4ynJuCtLZOB3yCMULSjexqJLwLualEjCRngYgUttEwUp4puS/4AI9tutU3mwTFep
 zFCQn1gvNxjGWiP9F8EVpRm1HmmWfrG5yhV23MCDmjWUqBdLA5DVgwtqI3WzxGUdivjZ
 Fq9g==
X-Gm-Message-State: AOJu0Yy/D+eHeG00xul/hQLMDYkIuELRS/ZIgxfpWaQHBGoUdQtmxbB+
 dabUro8bdlIONfL7DB4HQME9yRzxodb9dYxawzwnsGlmJQII7T0Al7/zW8IN1jEB9phXM1uKv8M
 L
X-Google-Smtp-Source: AGHT+IEROw3Lzxj5s8aJR0x8RAiR6/KmarGjwk3SRoYGuKsUijTzfPw1jSdD7eW01NEVjpBYKvyGBA==
X-Received: by 2002:a17:906:d552:b0:a8d:555f:eed1 with SMTP id
 a640c23a62f3a-a8ffab6d5f6mr466952166b.31.1726067552890; 
 Wed, 11 Sep 2024 08:12:32 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.196.107])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25835a76sm625728966b.39.2024.09.11.08.12.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Sep 2024 08:12:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
Subject: [PATCH v3 4/5] license: Update deprecated SPDX tag GPL-2.0+ to
 GPL-2.0-or-later
Date: Wed, 11 Sep 2024 17:12:05 +0200
Message-ID: <20240911151206.60368-5-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240911151206.60368-1-philmd@linaro.org>
References: <20240911151206.60368-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The 'GPL-2.0+' license identifier has been deprecated since license
list version 2.0rc2 [1] and replaced by the 'GPL-2.0-or-later' [2]
tag.

[1] https://spdx.org/licenses/GPL-2.0+.html
[2] https://spdx.org/licenses/GPL-2.0-or-later.html

Mechanical patch running:

  $ sed -i -e s/GPL-2.0+/GPL-2.0-or-later/ \
    $(git grep -lP 'SPDX-License-Identifier: \W+GPL-2.0\+[ $]' \
        | egrep -v '^linux-headers|^include/standard-headers')

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/core/uboot_image.h           | 2 +-
 include/hw/nvram/fw_cfg_acpi.h  | 2 +-
 include/hw/usb/dwc2-regs.h      | 2 +-
 include/hw/virtio/virtio-acpi.h | 2 +-
 target/riscv/cpu-param.h        | 2 +-
 target/s390x/cpu-param.h        | 2 +-
 hw/nvram/fw_cfg-acpi.c          | 2 +-
 hw/virtio/virtio-acpi.c         | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/core/uboot_image.h b/hw/core/uboot_image.h
index 18ac293359..e4dcfb08f0 100644
--- a/hw/core/uboot_image.h
+++ b/hw/core/uboot_image.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  * (C) Copyright 2008 Semihalf
  *
diff --git a/include/hw/nvram/fw_cfg_acpi.h b/include/hw/nvram/fw_cfg_acpi.h
index b39eb0490f..dfd2a44ef0 100644
--- a/include/hw/nvram/fw_cfg_acpi.h
+++ b/include/hw/nvram/fw_cfg_acpi.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  * ACPI support for fw_cfg
  *
diff --git a/include/hw/usb/dwc2-regs.h b/include/hw/usb/dwc2-regs.h
index 0bf3f2aa17..523b112c5e 100644
--- a/include/hw/usb/dwc2-regs.h
+++ b/include/hw/usb/dwc2-regs.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
+/* SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-3-Clause) */
 /*
  * Imported from the Linux kernel file drivers/usb/dwc2/hw.h, commit
  * a89bae709b3492b478480a2c9734e7e9393b279c ("usb: dwc2: Move
diff --git a/include/hw/virtio/virtio-acpi.h b/include/hw/virtio/virtio-acpi.h
index cace2a315f..cdfbd943ae 100644
--- a/include/hw/virtio/virtio-acpi.h
+++ b/include/hw/virtio/virtio-acpi.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  * ACPI support for virtio
  */
diff --git a/target/riscv/cpu-param.h b/target/riscv/cpu-param.h
index 1fbd64939d..25686192c0 100644
--- a/target/riscv/cpu-param.h
+++ b/target/riscv/cpu-param.h
@@ -2,7 +2,7 @@
  * RISC-V cpu parameters for qemu.
  *
  * Copyright (c) 2017-2018 SiFive, Inc.
- * SPDX-License-Identifier: GPL-2.0+
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
 #ifndef RISCV_CPU_PARAM_H
diff --git a/target/s390x/cpu-param.h b/target/s390x/cpu-param.h
index 11d23b600d..a05ffcf78d 100644
--- a/target/s390x/cpu-param.h
+++ b/target/s390x/cpu-param.h
@@ -2,7 +2,7 @@
  * S/390 cpu parameters for qemu.
  *
  * Copyright (c) 2009 Ulrich Hecht
- * SPDX-License-Identifier: GPL-2.0+
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
 #ifndef S390_CPU_PARAM_H
diff --git a/hw/nvram/fw_cfg-acpi.c b/hw/nvram/fw_cfg-acpi.c
index 58cdcd3121..2e6ef89b98 100644
--- a/hw/nvram/fw_cfg-acpi.c
+++ b/hw/nvram/fw_cfg-acpi.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Add fw_cfg device in DSDT
  *
diff --git a/hw/virtio/virtio-acpi.c b/hw/virtio/virtio-acpi.c
index 230a669500..85becef03c 100644
--- a/hw/virtio/virtio-acpi.c
+++ b/hw/virtio/virtio-acpi.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * virtio ACPI Support
  *
-- 
2.45.2


