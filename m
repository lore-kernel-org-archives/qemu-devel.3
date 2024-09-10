Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63462ECE564
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 11:53:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snzPm-0004Sn-7K; Tue, 10 Sep 2024 07:52:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snzPh-0004CJ-Nd
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 07:52:06 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snzPf-0006a6-UY
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 07:52:05 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5c2561e8041so6298446a12.2
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 04:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725969121; x=1726573921; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q0NBguyBRzjLDeNAbNyinwyekBYn7oqEADIiej2ZBjc=;
 b=am4icO5nyaH19qtBeLqZo81VoPfzA9srv6+EzrSNXMtVl9tQP9JMFtx5e2vzW5DdJm
 SpB/qZiVZNc3B+4h74+jtf5V4GPTVvA11IzW8tI9sY/pgvxDIsKiYGCOsgB1svf5lh5B
 S/QlVOP0dhJCqtyrz+s8pRgBaRB2gxAZ8Lcqnyl+XhOBIKU9/DRwLfMhI/LgqEXUENNP
 Ae/p3mBRZ457VLa19+2Va6NYqofVTeix6ONAMlZ7wVuN0hpp9XdVQqPP3xnvatGggKr8
 G9QdnSTAUrY3PTP5yOJS5KP5TdWA+0YnY5tePZctpwH/poN+wuDIRjs56LiEcuY6nbz+
 EwwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725969121; x=1726573921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q0NBguyBRzjLDeNAbNyinwyekBYn7oqEADIiej2ZBjc=;
 b=sIzhNw3WHzx02PVzj80Ewo6JGo0LRfqSdE3dafUHPOvlKvgsiyMG1sz7TcE+PUQYF9
 qvgJaW1sN+xlD4ci90N/VtvKocbtNoKBGIaaoDVJByV9s1TlaxgsGq1rKlfj/LApMkof
 t1RlLyKffia3eo29mCYAI7uX2HUsfCEaCr3A4lvVuXw25XY2ihP80YIEEJt25C82rZVM
 yeCOhIShfcvJ5pO94O/tC4/zsAXbMyZ+AtElMr7kRZZDPmRrs7WnotTlrx5phuwucCkm
 8IX+pKH3UuTTOuL/C7hAoil9uRM3tm0XoDPjLKn5jwLi9c0SwKQ/emoEo7H92zF+AsY8
 JwJg==
X-Gm-Message-State: AOJu0YyM4XJCvCwdMtrKYemxK30fyWKUcccHYzcz+skjgATBwxe1W1yr
 yEsVnzguX0Wl2OlI+sxb0+SMoN0C2MybLI1/amGDN4kmHGELrtZxwFgKSEC5ACiccbMpM8lv3cI
 Q
X-Google-Smtp-Source: AGHT+IFLUtKgiVKjTAiiToMM74KSl9Xr4BFBYXuqh8ijHDkCvBTxxIk9yWMmFlszalBiPSNuLFc6SA==
X-Received: by 2002:a05:6402:13d0:b0:5be:bcdf:4110 with SMTP id
 4fb4d7f45d1cf-5c3e94d397fmr9406221a12.0.1725969121581; 
 Tue, 10 Sep 2024 04:52:01 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.217.32])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd8ce50sm4170171a12.84.2024.09.10.04.51.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Sep 2024 04:52:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/5] license: Update deprecated SPDX tag GPL-2.0+ to
 GPL-2.0-or-later
Date: Tue, 10 Sep 2024 13:51:30 +0200
Message-ID: <20240910115131.28766-5-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240910115131.28766-1-philmd@linaro.org>
References: <20240910115131.28766-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
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
    $(git grep -l 'SPDX-License-Identifier: GPL-2.0+$')

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/cpu-param.h | 2 +-
 target/s390x/cpu-param.h | 2 +-
 hw/nvram/fw_cfg-acpi.c   | 2 +-
 hw/virtio/virtio-acpi.c  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

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


