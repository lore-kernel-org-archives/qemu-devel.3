Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1FA5E77199
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 17:20:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVwCb-0002MQ-Dr; Thu, 09 Jan 2025 12:20:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVwCZ-0002LF-5p
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:20:11 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVwCW-0000e6-Oj
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:20:10 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-38a8b17d7a7so656598f8f.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 09:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736443206; x=1737048006; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=USByRXNnIcm1zr75pvlA/VQ1iSROrZwNJ1I9XsVsaz8=;
 b=BdJlwGWFoODLVfIRsUpCEsdwJG8DWP5ZCcVQhEconPBJEB5FTWJ2V0nSo7n9CU49u/
 jrAj4EWDmoF4HgJlCCjVDOn5DKLFc6cWlJjOoi1GlgdQTrUzn65lPmA+IHefmBpLsRrq
 cy30zDmqPsj+mGDwf3v0JsecigpO45W+a4x92E92kS+qQxjtNwaGuczlWd7MrDZz9amP
 /n7hO0U7+VeadGM7LC7tH7lMYFuEihtUabdhsTDhP6uBjXX94yLJOKn1HcpOzWFrsVDh
 YqW69WuYw4hqHo8MTOVXwKHKX7vu8Rr0URZrfbPegnIrckU+iD7Ngk/zjAEpYYiZDuW8
 V3Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736443206; x=1737048006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=USByRXNnIcm1zr75pvlA/VQ1iSROrZwNJ1I9XsVsaz8=;
 b=xCcadH1boEaV0DMa9De6zppKpuSvw04N5x2JLgWT19JYVKmPqW/FKKnkV8dAgJKQbh
 duKn8bFp9b+nQ6nDqcIsJ7c6ldgjnug5c9iw3+8L9iXEuxUHCU2ppOdF7jXhJQYDM/dW
 dkPexwomH+/09V1JqStmQH31KoOa9t0R7NhR+8m5p0q278M+GMjP8k8xjmq7Ob2PkC28
 pkQPQ+k7aamj20boo8xTeCt5wLsBz/0OgTL8ik8cogP2kCi3p6kYnLGOVi7gZ4PhLdmD
 /4mcwGQPJIr8aeYh2UJ8oCZ6ctWUrmjYCUfctrvFM+ZswucyaY9kty07S11o47weJT89
 /B1Q==
X-Gm-Message-State: AOJu0YwkXWHiCCWsRY/F5nIiaexgs5K3XTagmGKeiaK+/ht7Xxcex03d
 TB5mF3Id1N/Z6AFI6ahLkTLpzX2c1p+1JksXMwM7QCA+WSs8Fqu4zSEd8IOVfMGGlbeZv/Gd/nU
 V9pI=
X-Gm-Gg: ASbGncvAzZ+vQFqJf563wKbTWl6g0cSv6va30gJ93p+OGfPpNcXVzpir7/P96980aOm
 Zl+y2sU08v7jHliHZ4SdsvOSxr/M3DSmDkgxURquH2Sl2uBy7We+smo2FQePSA+rnPB6Yu6Vqtb
 8Zu5lU4UAmFy/FSBGd0e8Vlr69QXkGsqXLmLE5TAonbC6Vo3hxWSPFUva/DzRuIcZujrmV0s9hn
 b36yYu6sJKqG9gZiS1CIjJK1LrAszVmsjYBy5Qt56gC/1pwEsYwHrqhNWukMlEVPrnKTqA8kOQY
 TncOcWEg+C5Cjwjy8Qy0NzWpVjKR5C9+cnNa
X-Google-Smtp-Source: AGHT+IF+v9r7ePdpxEeqC3PjtWfvZ/u00EgEEc1Xd8cESZ71xEWTIk8RRfI4BJeteX4idN2TmMn8yQ==
X-Received: by 2002:adf:c08d:0:b0:38a:87cc:fb2c with SMTP id
 ffacd0b85a97d-38a87ccfc17mr4578783f8f.18.1736443205706; 
 Thu, 09 Jan 2025 09:20:05 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a9407fd62sm509369f8f.92.2025.01.09.09.20.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Jan 2025 09:20:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 03/11] qdev: Implement qdev_create_fake_machine() for user
 emulation
Date: Thu,  9 Jan 2025 18:19:40 +0100
Message-ID: <20250109171948.31092-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250109171948.31092-1-philmd@linaro.org>
References: <20250109171948.31092-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

When a QDev instance is realized, qdev_get_machine() ends up called.
In the next commit, qdev_get_machine() will require a "machine"
container to be always present. To satisfy this QOM containers design,
Implement qdev_create_fake_machine() which creates a fake "machine"
container for user emulation.

On system emulation, qemu_create_machine() is called from qemu_init().
For user emulation, since the TCG accelerator always calls
tcg_init_machine(), we use it to hook our fake machine creation.

Suggested-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250102211800.79235-2-philmd@linaro.org>
---
 include/hw/qdev-core.h | 10 ++++++++++
 accel/tcg/tcg-all.c    |  8 +++++++-
 hw/core/qdev-user.c    | 19 +++++++++++++++++++
 hw/core/meson.build    |  1 +
 4 files changed, 37 insertions(+), 1 deletion(-)
 create mode 100644 hw/core/qdev-user.c

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index c4d3dc39064..50cbbf81211 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -1023,6 +1023,16 @@ const char *qdev_fw_name(DeviceState *dev);
 void qdev_assert_realized_properly(void);
 Object *qdev_get_machine(void);
 
+/**
+ * qdev_create_fake_machine(): Create a fake machine container.
+ *
+ * .. note::
+ *    This function is a kludge for user emulation (USER_ONLY)
+ *    because when thread (TYPE_CPU) are realized, qdev_realize()
+ *    access a machine container.
+ */
+void qdev_create_fake_machine(void);
+
 /**
  * qdev_get_human_name() - Return a human-readable name for a device
  * @dev: The device. Must be a valid and non-NULL pointer.
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index c2565758876..95adaacee82 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -35,7 +35,9 @@
 #include "qemu/atomic.h"
 #include "qapi/qapi-builtin-visit.h"
 #include "qemu/units.h"
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_USER_ONLY)
+#include "hw/qdev-core.h"
+#else
 #include "hw/boards.h"
 #endif
 #include "internal-common.h"
@@ -124,6 +126,10 @@ static int tcg_init_machine(MachineState *ms)
     tcg_prologue_init();
 #endif
 
+#ifdef CONFIG_USER_ONLY
+    qdev_create_fake_machine();
+#endif
+
     return 0;
 }
 
diff --git a/hw/core/qdev-user.c b/hw/core/qdev-user.c
new file mode 100644
index 00000000000..3d421d8f4e5
--- /dev/null
+++ b/hw/core/qdev-user.c
@@ -0,0 +1,19 @@
+/*
+ * QDev helpers specific to user emulation.
+ *
+ * Copyright 2025 Linaro, Ltd.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+#include "qom/object.h"
+#include "hw/qdev-core.h"
+
+void qdev_create_fake_machine(void)
+{
+    Object *fake_machine_obj;
+
+    fake_machine_obj = object_property_add_new_container(object_get_root(),
+                                                         "machine");
+    object_property_add_new_container(fake_machine_obj, "unattached");
+}
diff --git a/hw/core/meson.build b/hw/core/meson.build
index ce9dfa3f4bf..65a1698ed1f 100644
--- a/hw/core/meson.build
+++ b/hw/core/meson.build
@@ -46,3 +46,4 @@ system_ss.add(files(
   'vm-change-state-handler.c',
   'clock-vmstate.c',
 ))
+user_ss.add(files('qdev-user.c'))
-- 
2.47.1


