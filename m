Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF30EB64DE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 12:28:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snzxa-0000Fb-2w; Tue, 10 Sep 2024 08:27:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snzxY-00007n-6p
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 08:27:04 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snzxT-0003gt-8n
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 08:27:03 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5c3c30e6649so668635a12.2
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 05:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725971210; x=1726576010; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NxicRzYkmvOskoD/w+UVeNTJwRS2R7t5eol06ROza4s=;
 b=Lytm0O25CYaJEPtzl8PssjB07zGLrJuAmXSUnu9R5WP3kq9QxzG0HN3TDZjekfNJC6
 emYEL5KfljC0TQST7TKsbeB0eM0bcIKrPTzRgMwzkl3vhtPHiNZd6nGyCVbtba4SYHLJ
 jBqIjibrlVAVLJrYfc38k4SIQVi4Zb8ErJlW7ONngCXQrQWZOIh+++CQdX6BFCp9fOKZ
 78VaYhEoyBO9BGw3HSY2ROqPIF7pjE8AzQMaT5uCOQv87V5s77CtiM+vJwFZzfXrQL+M
 qyFDUdE5fr+p76UKLS/mj1Sl3253jtH/EevH5TP3hyMxtvsWCJ/pJl0+f0XIhUTudsCQ
 kHGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725971210; x=1726576010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NxicRzYkmvOskoD/w+UVeNTJwRS2R7t5eol06ROza4s=;
 b=si8zuBwcses/PPivMAYkQBxD4XX7axINAczWUNtj7RwKBhw0MsAT4EKfzQ8N29lfLT
 LNE/HBnKTGaea1wCySwiGsLUod86bJVGGKEp9Cr8o23zSkD2SIx1xKlt0pHPbJ5ezoH9
 P/nCEBv0UsDi79ItQQOfsY85uOloTFcXagt69dUwurCiTppmcbXoqkpO7Ls4KEbtn/HW
 EgOIwNNUL9YJwPS5XME2VZ8rGnfDRX9AVuwXl2JJLBv7LC5HHy30mJ/wDw+V7hrJ1SR9
 BQebVOIfDlqJRkWlLezeOajtRQn4EN40oeKZHlksrB3rIp6RPXRVLNtDcxzKuXekIief
 nsxA==
X-Gm-Message-State: AOJu0YzCAVJeDG49bNACMYCaQF5RSHfq0x0h8uFuJl0NLRSJCy5C6JSt
 M2Ya+JMeoueb5s7l1TvAwHbywEUG5qdfEy2C8OHUWAUlH/0IxdhiwAsVPZ6u2bwZyP2OWcUJfH9
 S
X-Google-Smtp-Source: AGHT+IEWbmqCW4isrelMC/Q812pWqlHTYlksWqqGqXgNFrfbtU0CScphGUh8LevT1TFKyigx8C4fuA==
X-Received: by 2002:a05:6402:3903:b0:5be:fdc0:e704 with SMTP id
 4fb4d7f45d1cf-5c3dc79323dmr9566347a12.10.1725971209820; 
 Tue, 10 Sep 2024 05:26:49 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.217.32])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd523casm4207838a12.58.2024.09.10.05.26.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Sep 2024 05:26:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Weil <sw@weilnetz.de>,
 qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 4/5] license: Update deprecated SPDX tag GPL-2.0+ to
 GPL-2.0-or-later
Date: Tue, 10 Sep 2024 14:26:17 +0200
Message-ID: <20240910122618.33056-5-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240910122618.33056-1-philmd@linaro.org>
References: <20240910122618.33056-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x529.google.com
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


