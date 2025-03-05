Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A78F6C282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:22:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdSu-000824-64; Tue, 04 Mar 2025 20:22:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdSl-0007wJ-F2
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:22:20 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdSh-0006ux-3p
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:22:19 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4394a0c65fcso66888235e9.1
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741137733; x=1741742533; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iWTIGs3Go4pPr1LSJFmoU+Pe9bQjzTfRf/I5FzOXuf0=;
 b=yZuAppqB+n66CTZnuKDSWzLR+EXhHmPV9alGEhgWutXPeLcu0Z3V4iP+cqV0AMQtPG
 /CP0BX2UnlwyCziyc2/NggDChh35r1hFa6OODDePhpGCNslCFXYMXXFdk20e++qM/AOn
 BQiPWSpID+Wa/zjyA5HtEUk6OsY0H3PaybeO1lNJ6XOmv3u//YltPOH4AD2cm//YJKgm
 whB6EV7KWUMKTmmXOzrd0iwukMrSpC0HGbW07X4yYl/9Aq52qFOLkTo2uI+lDBeFygBK
 NA9zMCMA8zgcxpRCR0sw06VXBDZmRJ2ZMYtxq8gNpehjsUOcNE5UPwd9FxxGN1/0kjDa
 iRjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741137733; x=1741742533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iWTIGs3Go4pPr1LSJFmoU+Pe9bQjzTfRf/I5FzOXuf0=;
 b=HTMTgAzmXyfkL5a0JqXza09IDd3jTnjZzt5cBsFhtFLmmJdPZbhFtFvTlVBcrAQIjX
 2W7EtD+YPrFUh+CVNs7D49/hiY8koA9sujU/U6qtx9LSk/d3uGWgrnRifKDZf21CzFKF
 DRwL9rIDwOkb+j2+WbzLYO3b1EYhzRuZYBQfxd1IRZ8yekXHebPpcn//rrNU/kc00Pk7
 2cnlF8lttEr88BAJYQVYzQ/eU6HuRZxWMS+Zyaq7WIE+JGs5ABD4bb2O/sieqRN2VIec
 aYFnNAWT8wOpY3bGwOGxcHbIHPSOW80OooOJq0qeMLs5+WR2GUhBOw1huJUaC6qt0pO5
 LEfg==
X-Gm-Message-State: AOJu0YxGm050LO5BPTmYbmDDG5q77YLHExRZEZjGCEOXgYhrvDUZv9gd
 ki+K7g/7SqiPl1L0A5QzyaTTAdBkiGJO/9Sf9ANLp3Cs+NgLTmzibiNSfv4lV7jqZ5Q0tyzo+r7
 bZLk=
X-Gm-Gg: ASbGncuRMdZQTwr0z9Wu+yvkSg2udVbIaX9bq0LKD1AhJ6GUmBSqAk7jZIDemoHtlA+
 9GiXidZa9IgKX+ghMw0Y6XdkGzt+Y7tYruQA60vEUlNLHF4SzwSLY3axQOtPBhu+g7vl2Rm2p7y
 3H6vDuwtbVY6lhpFTUYjukZXFUpPPbcWVuB5Db0T0n9K1pT+ee9Zk3aetbd7MP2FrlsbfMUWuzG
 AoJXC42hwRfzl2Fk33OboaugSO3sLc7Apm8ILvgEGT7CUQSScXWIiJWMNRtgK/ICXQ1zcH5Bs2H
 rQCX2ro18iK4waajUHxop0MjmUs20a6tS7eh1HPpszEtJehdWgyO2cGOhqgdwAjQ1qjEurwKtZY
 sUR2DmHirDc8YiFkg2QQ=
X-Google-Smtp-Source: AGHT+IEEbN4IJPm5dko6OQSea20MdgZaCQFjySCZ2Ek9yxffFeGO01eU1R7zKfaUwXJMA/6HJtS7ug==
X-Received: by 2002:a5d:64e3:0:b0:391:888:f534 with SMTP id
 ffacd0b85a97d-3911f7403cfmr576579f8f.20.1741137733296; 
 Tue, 04 Mar 2025 17:22:13 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e47a66bcsm19090251f8f.21.2025.03.04.17.22.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Mar 2025 17:22:12 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <graf@amazon.com>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 03/41] hw: Add vmapple subdir
Date: Wed,  5 Mar 2025 02:21:18 +0100
Message-ID: <20250305012157.96463-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305012157.96463-1-philmd@linaro.org>
References: <20250305012157.96463-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

From: Alexander Graf <graf@amazon.com>

We will introduce a number of devices that are specific to the vmapple
target machine. To keep them all tidily together, let's put them into
a single target directory.

Signed-off-by: Alexander Graf <graf@amazon.com>
Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <20241223221645.29911-7-phil@philjordan.eu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS             | 7 +++++++
 meson.build             | 1 +
 hw/vmapple/trace.h      | 2 ++
 hw/Kconfig              | 1 +
 hw/meson.build          | 1 +
 hw/vmapple/Kconfig      | 1 +
 hw/vmapple/meson.build  | 1 +
 hw/vmapple/trace-events | 2 ++
 8 files changed, 16 insertions(+)
 create mode 100644 hw/vmapple/trace.h
 create mode 100644 hw/vmapple/Kconfig
 create mode 100644 hw/vmapple/meson.build
 create mode 100644 hw/vmapple/trace-events

diff --git a/MAINTAINERS b/MAINTAINERS
index 2e7fc6fa912..0e160360918 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2820,6 +2820,13 @@ F: hw/misc/ivshmem-flat.c
 F: include/hw/misc/ivshmem-flat.h
 F: docs/system/devices/ivshmem-flat.rst
 
+VMapple
+M: Alexander Graf <agraf@csgraf.de>
+M: Phil Dennis-Jordan <phil@philjordan.eu>
+S: Maintained
+F: hw/vmapple/*
+F: include/hw/vmapple/*
+
 Subsystems
 ----------
 Overall Audio backends
diff --git a/meson.build b/meson.build
index 0a2c61d2bfa..d1b807aa53f 100644
--- a/meson.build
+++ b/meson.build
@@ -3605,6 +3605,7 @@ if have_system
     'hw/usb',
     'hw/vfio',
     'hw/virtio',
+    'hw/vmapple',
     'hw/watchdog',
     'hw/xen',
     'hw/gpio',
diff --git a/hw/vmapple/trace.h b/hw/vmapple/trace.h
new file mode 100644
index 00000000000..d099d5ecd9e
--- /dev/null
+++ b/hw/vmapple/trace.h
@@ -0,0 +1,2 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#include "trace/trace-hw_vmapple.h"
diff --git a/hw/Kconfig b/hw/Kconfig
index 1b4e9bb07f7..2871784cfdc 100644
--- a/hw/Kconfig
+++ b/hw/Kconfig
@@ -41,6 +41,7 @@ source ufs/Kconfig
 source usb/Kconfig
 source virtio/Kconfig
 source vfio/Kconfig
+source vmapple/Kconfig
 source xen/Kconfig
 source watchdog/Kconfig
 
diff --git a/hw/meson.build b/hw/meson.build
index b827c82c5d7..9c4f6d0d636 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -39,6 +39,7 @@ subdir('ufs')
 subdir('usb')
 subdir('vfio')
 subdir('virtio')
+subdir('vmapple')
 subdir('watchdog')
 subdir('xen')
 subdir('xenpv')
diff --git a/hw/vmapple/Kconfig b/hw/vmapple/Kconfig
new file mode 100644
index 00000000000..315c06b689c
--- /dev/null
+++ b/hw/vmapple/Kconfig
@@ -0,0 +1 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
diff --git a/hw/vmapple/meson.build b/hw/vmapple/meson.build
new file mode 100644
index 00000000000..315c06b689c
--- /dev/null
+++ b/hw/vmapple/meson.build
@@ -0,0 +1 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
diff --git a/hw/vmapple/trace-events b/hw/vmapple/trace-events
new file mode 100644
index 00000000000..21125794121
--- /dev/null
+++ b/hw/vmapple/trace-events
@@ -0,0 +1,2 @@
+# See docs/devel/tracing.rst for syntax documentation.
+# SPDX-License-Identifier: GPL-2.0-or-later
-- 
2.47.1


