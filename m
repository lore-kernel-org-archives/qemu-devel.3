Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFDE9C83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 20:00:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubloo-0002O4-Ep; Tue, 15 Jul 2025 16:00:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ublbb-0003Dj-6D
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:46:36 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ublbU-0002k9-Tv
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:46:20 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-455fddfa2c3so36141855e9.2
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 12:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752608774; x=1753213574; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Er3wPoXaq/J9uxhbCCA2Xu9PBj7t0/pTGh9dFM7WpXI=;
 b=NXcFnUsnhgUikRBqeIa8YGwHKbudJCMrqQF5BLkKOpOdhMIVWoocrTTuFFDg5Ux+TW
 eipTilYNbbeqtQuOwENVVtHkCIQjffsv9/+6qjVNlfdPDgO9nQ5HdwS/xHB0EWtlVjGm
 aX8Oji+4Gar4gFlGqVn9RKPlMXrD1iMTDeCL5pJmzFdl2BdfZLH8hAx+2QR+wt1YWpLz
 bmichXVOhyqMwMZ93VWJ5LEnAzO60KmgYGfUb5wKwm1S1OnNGuQGVnhVg2W/eHtM9KG3
 CV8/2N0jmp55q2AQl8hZESrDNoWIuwtAKpmpAyGl6yUTofHYPqRWdSNOFq1BrN4sgBEm
 Kb3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752608774; x=1753213574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Er3wPoXaq/J9uxhbCCA2Xu9PBj7t0/pTGh9dFM7WpXI=;
 b=lsV71t1/Sf5eVtgjMY9O0H+Xg6XR+ApKubb1281MHwqXP81azxtB7joEZob/ugIINx
 v2EmUuRjarXG9EqrngHNELdSidYosp1RPT/ajrKgZTFRByhqdW1nDrb3nTnWJvMlTtMR
 moEVDBb4j6cR+Fny+jADIegucr4hd+h5N5qN6lEifNAjXdTpoiaEHQQj+6Jx/LcmBSXQ
 AmiJ5JH271j7Gr3Y756e8vN2WpdhbIjU0fq0KFVmGb5r/RRlkt732Rx6zfMl79ohShPM
 FalowkAnWq9blBS/sCHqRr3P9X+wzF3Ga8FhN4KsEK8oof+X8BFd2k27wL9UnaeR0Z3z
 KGxg==
X-Gm-Message-State: AOJu0YwTgDQ8SO0pCr0QaDpO0DnD2/dKHb1bHaAwfmEhS5HMvBT4Kqnn
 iIWB13BF+KYic1BbgUKFebpnTDRPh18advpd9idbzFcE8yl22vkpNIYYrIkK071GAbeif2jiuXV
 KOi/I
X-Gm-Gg: ASbGncv73GYgVo88ufHQqVN19Nq/qPnT0/AXl3883v68dmjqUinclt0ueiP51uS5dZ6
 wr4qCx7L1EamCY6SiK5xx8NLRU+kwY7YsCSgg7k1/yUEY0QOurbqHoEL/60KXq3zi8mSJ2Tkt2f
 eNHe7WOz9YjROadCyUlhp5vtlHqRDsMc46LxCSQ57hNA2gd5Y7YDEESdtgRaO2ZF91rhBpBqVW1
 8yrfSB1R69CL2OzD24/78N4ZVuSTVJortlC5YZ/koftkmJI/T49qznaVpxNJEQbwuFlN2ZPW1vC
 Mn8ih0tLksf0K9PurWPzSk/bt2W+o3MOM5gz5odIy1wFyhOwl1LUbnSt1xw63ZAv+ahlZJZL4fh
 9X1X8xyBsY8cLPNJRwAJoWdPd/nuSIg82irWfEYiV3DprUw7UVEiklsDO7kkFGMfCSoEi+6VtoU
 Nllg==
X-Google-Smtp-Source: AGHT+IG701mS12Jj5cAms28UWCl7snrD2WhapM0GNRAgJZTilUYiq4aMUrCm72HyQFLlzoHqXgOqRw==
X-Received: by 2002:a05:600c:c042:b0:43d:745a:5a50 with SMTP id
 5b1f17b1804b1-4562e5893f7mr95335e9.19.1752608774344; 
 Tue, 15 Jul 2025 12:46:14 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d5050d34sm211840735e9.9.2025.07.15.12.46.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Jul 2025 12:46:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/17] accel/system: Introduce @x-accel-stats QMP command
Date: Tue, 15 Jul 2025 21:45:10 +0200
Message-ID: <20250715194516.91722-12-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250715194516.91722-1-philmd@linaro.org>
References: <20250715194516.91722-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Unstable QMP 'x-accel-stats' dispatches to the
AccelOpsClass::get_stats() and get_vcpu_stats() handlers.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20250715140048.84942-4-philmd@linaro.org>
---
 qapi/accelerator.json         | 17 +++++++++++++++++
 include/accel/accel-cpu-ops.h |  3 +++
 include/accel/accel-ops.h     |  2 ++
 accel/accel-qmp.c             | 35 +++++++++++++++++++++++++++++++++++
 accel/accel-system.c          |  1 +
 accel/meson.build             |  2 +-
 6 files changed, 59 insertions(+), 1 deletion(-)
 create mode 100644 accel/accel-qmp.c

diff --git a/qapi/accelerator.json b/qapi/accelerator.json
index d55fe1aa0a3..6029e7307a7 100644
--- a/qapi/accelerator.json
+++ b/qapi/accelerator.json
@@ -37,3 +37,20 @@
 #     <- { "return": { "enabled": true, "present": true } }
 ##
 { 'command': 'query-kvm', 'returns': 'KvmInfo' }
+
+##
+# @x-accel-stats:
+#
+# Query accelerator statistics
+#
+# Features:
+#
+# @unstable: This command is meant for debugging.
+#
+# Returns: accelerator statistics
+#
+# Since: 10.1
+##
+{ 'command': 'x-accel-stats',
+  'returns': 'HumanReadableText',
+  'features': [ 'unstable' ] }
diff --git a/include/accel/accel-cpu-ops.h b/include/accel/accel-cpu-ops.h
index a9191dded7e..0674764914f 100644
--- a/include/accel/accel-cpu-ops.h
+++ b/include/accel/accel-cpu-ops.h
@@ -65,6 +65,9 @@ struct AccelOpsClass {
     /* handle_interrupt is mandatory. */
     void (*handle_interrupt)(CPUState *cpu, int mask);
 
+    /* get_vcpu_stats: Append statistics of this @cpu to @buf */
+    void (*get_vcpu_stats)(CPUState *cpu, GString *buf);
+
     /**
      * @get_virtual_clock: fetch virtual clock
      * @set_virtual_clock: set virtual clock
diff --git a/include/accel/accel-ops.h b/include/accel/accel-ops.h
index 86a27c30fa4..23a8c246e15 100644
--- a/include/accel/accel-ops.h
+++ b/include/accel/accel-ops.h
@@ -25,6 +25,8 @@ struct AccelClass {
     int (*init_machine)(AccelState *as, MachineState *ms);
     bool (*cpu_common_realize)(CPUState *cpu, Error **errp);
     void (*cpu_common_unrealize)(CPUState *cpu);
+    /* get_stats: Append statistics to @buf */
+    void (*get_stats)(AccelState *as, GString *buf);
 
     /* system related hooks */
     void (*setup_post)(AccelState *as);
diff --git a/accel/accel-qmp.c b/accel/accel-qmp.c
new file mode 100644
index 00000000000..5fb70c6631f
--- /dev/null
+++ b/accel/accel-qmp.c
@@ -0,0 +1,35 @@
+/*
+ * QMP commands related to accelerators
+ *
+ * Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/accel.h"
+#include "qapi/type-helpers.h"
+#include "qapi/qapi-commands-accelerator.h"
+#include "accel/accel-ops.h"
+#include "accel/accel-cpu-ops.h"
+#include "hw/core/cpu.h"
+
+HumanReadableText *qmp_x_accel_stats(Error **errp)
+{
+    AccelState *accel = current_accel();
+    AccelClass *acc = ACCEL_GET_CLASS(accel);
+    g_autoptr(GString) buf = g_string_new("");
+
+    if (acc->get_stats) {
+        acc->get_stats(accel, buf);
+    }
+    if (acc->ops->get_vcpu_stats) {
+        CPUState *cpu;
+
+        CPU_FOREACH(cpu) {
+            acc->ops->get_vcpu_stats(cpu, buf);
+        }
+    }
+
+    return human_readable_text_from_str(buf);
+}
diff --git a/accel/accel-system.c b/accel/accel-system.c
index 8df561b9539..76cf4e7ef7a 100644
--- a/accel/accel-system.c
+++ b/accel/accel-system.c
@@ -26,6 +26,7 @@
 #include "qemu/osdep.h"
 #include "qemu/accel.h"
 #include "hw/boards.h"
+#include "hw/core/cpu.h"
 #include "accel/accel-ops.h"
 #include "accel/accel-cpu-ops.h"
 #include "system/cpus.h"
diff --git a/accel/meson.build b/accel/meson.build
index 52909314bfa..25b0f100b51 100644
--- a/accel/meson.build
+++ b/accel/meson.build
@@ -1,6 +1,6 @@
 common_ss.add(files('accel-common.c'))
 specific_ss.add(files('accel-target.c'))
-system_ss.add(files('accel-system.c', 'accel-blocker.c'))
+system_ss.add(files('accel-system.c', 'accel-blocker.c', 'accel-qmp.c'))
 user_ss.add(files('accel-user.c'))
 
 subdir('tcg')
-- 
2.49.0


