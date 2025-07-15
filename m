Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1DD5C83F2D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 14:43:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubgry-0004Vs-BM; Tue, 15 Jul 2025 10:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubgDb-0008U3-L8
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 10:01:21 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubgDZ-0004JK-Cm
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 10:01:15 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3a522224582so2798211f8f.3
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 07:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752588070; x=1753192870; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kTH2R2emY9oOZylCpjFlFocpeep/S4agDx3DNsL1BWQ=;
 b=jjTJFColD7ZeNaXoe82nTlpGmf15pNIaTOCXeAG+ViQDCNMaecC5ofzKgKa7cHqxe+
 X29golss0xghi5R9mys98sfqSv712xqu/dftzI2xjoV2HpucEZwewQq+cJkysLL4REd9
 58iOPGJ1tgkTpeLhKLOURbScrpg0ERXiJxTxoSctR508idtU6/Woj+bSHtKh/QiJXNKE
 K7Ac1tUzF9DXwfgdKMZ30MTk7rChe5cL9cr+LDO+LGuRVMOxOH3M0Hdrt++MWRNTBmKa
 wBBCBIdDdfsv2XpkN+TYU9W/QwUrojC3hJreRpHRDTS9gA3g2t22Mmb6huI1IiKOQcwt
 18cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752588070; x=1753192870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kTH2R2emY9oOZylCpjFlFocpeep/S4agDx3DNsL1BWQ=;
 b=VY+cHnvjJCmHvqgdfaPhkT3uKsSdMXI5t5qfXcKVuJeqstsaq2HGEZtMoTvrfb2hoc
 2zraJ97GF5LoHNVy0tz/lxZg27rJ+1R++EkcvYiuSdrJb4IcVlLCn3ovYEz2tI4k+88H
 Wxq9NHF6+Vj9/NYwRctMVABsfSRUWzYWRYAUVzzQvtmxSNlLjT1wsIDe6k6cvBhvrlhf
 bWUAyX95z+i7KLGHKTC1Rf4xPJ4ymigegh+LGGLwD1vDlUWZZltzfHGNNK+s53dToBaG
 1hHuyM6W4CJPQUNQsA0yyQYrDdsak8RtYbU1OGriyQPxrBmLtxziPR+d1nZv92iV4XTd
 a3fA==
X-Gm-Message-State: AOJu0YwAeIVi0FMAZYj+dczhUc11ZiADa9CW0iy9BtviHVDvF3WvZA7s
 cCO/gPjaZv6KQI++G+ix/PL9m1MsAxjb0s+T1jMQK6ISPjTXbloMC4t23cK6ynLEwFCefGsT6YB
 BUMCw
X-Gm-Gg: ASbGncsQnRCtrMf290Az/DF6ptHiqOnHwdqDThrjWZhLrgpyHlVzLWd6u81xZyVa6o/
 w3HsQCI972ZqU6ayHTSeQukkIofEnVKfYBMzAA1PUWrTjywtCJU+jHSvJFcRfvnf4HZQCY+EV/o
 Br7gL9unjzmWPQ1S14dXn/OApO6cqh6+EjcVSL72b80FL3qhHXW/2IASnlc0w8og88NzNk0KU1X
 N4N8nzZrjAPWW/pZcDvw1uPmZJsY1aZzDpegRdh/IaiI8M/+kRpzWcfOGOUnJy95FHhLbZBqdjH
 wgTJPGRUcAdzNlFsdh+4KOeKvggVVWCc//6DsUvRMlnHjKbbQOzfED01XcI+TC52DYrSetKe7MW
 U1Yh2E7ypUBk9R+zJlKCT43SIvZfId+K7xYhnke7dujZauMsvCuvcaN3ZdyJuHtCrP4EiwpaUBg
 7K9g==
X-Google-Smtp-Source: AGHT+IEdg5iTlyBNsqZZR/W2Y8EdD+BQWLrITiy3Mp8zJFW8F7a9UR1M1kn+ARiSurxEBq2MdpgbwA==
X-Received: by 2002:a05:6000:20c4:b0:3b5:f93a:bcc with SMTP id
 ffacd0b85a97d-3b5f93a0e5emr7690050f8f.35.1752588067928; 
 Tue, 15 Jul 2025 07:01:07 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454dd43906dsm164603535e9.3.2025.07.15.07.01.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Jul 2025 07:01:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH-for-10.1 v6 3/8] accel/system: Introduce @x-accel-stats QMP
 command
Date: Tue, 15 Jul 2025 16:00:43 +0200
Message-ID: <20250715140048.84942-4-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250715140048.84942-1-philmd@linaro.org>
References: <20250715140048.84942-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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


