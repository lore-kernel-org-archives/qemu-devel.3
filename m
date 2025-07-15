Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F14DDC83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 10:42:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubd5T-0004ec-Bn; Tue, 15 Jul 2025 06:40:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubd5R-0004cj-Nv
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 06:40:37 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubd5P-0005mx-Qy
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 06:40:37 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-45617887276so17109025e9.2
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 03:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752576034; x=1753180834; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kTH2R2emY9oOZylCpjFlFocpeep/S4agDx3DNsL1BWQ=;
 b=bACpss8iQpliGnI9Mjk8wecIQiRny91cMNPMREUbCodEWAlKSeoTmXSqSioWLRwSY/
 Bl5CiF0k3cxyXIHdn5iRQ9GaQ9gjJ9XCZVMBHMMU0jYwMkaRrwBhO3g79JIsuDsyPYAN
 0nAZYkLA4UvZBORP0AKlSEcjESH0TK6IhABZpNNQDZMtsBR1cSDEvTRvSrfOFnkt77yf
 5pJlc78jnh7tOvm3fRiKXB9Evijp6g7+y5blryvgm5x6vmwB4R2v8Btb1jvo2Z1wijGQ
 eZ961+aabrSBAOHzej9BAfdMbJ7un6TFARAdNaYVENCPRnZDsYo+eXdWypT2ZaGsKL05
 Qjvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752576034; x=1753180834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kTH2R2emY9oOZylCpjFlFocpeep/S4agDx3DNsL1BWQ=;
 b=IHC0dWtUntJyV8zj2NzclJKQIVREQSbe1BF42H/ijdBgxH3lwTiFQd5Ifbhz+5xwOf
 g5ZhRU7AzEOsB+eWEJHR+nnTNnmaX6N12M0HnaWCOY3KtKZX3nOHJCVkvRw0JUExom0o
 OwAuANMidXDgUE2Qung5Vqq68CloFqMeusZo1GUJ2A06kGbKkRsyh76ux9CD32KgF+gt
 tsNYYu79CHQ9RPhEeK+DMTmlE3jjwUTpHdKE/2LSH96pSsJY23YVlLvzD9+pj6Poi348
 Y35jE06+B5ogfmiP07C2RIE2WDNWpoi7YvE8qfzSdBOfX7Jx01hgj+sTJzeyjyRZ4OBk
 UwxA==
X-Gm-Message-State: AOJu0Yxbuisb6a2J40USBu1SehlBEcJa4cg5mlQF2oDaTrkQwbJlNr22
 mMZFu6ladRJw1eFm68h+649FKzxJoqJeoVZFJVr1YH2qLLyDtRJPkJ75RK0MvWcRU1xckKUnplj
 CdVnP
X-Gm-Gg: ASbGncuJlc3fCrpYJwI0wbDuxtrvc2E5YpuuoQXmso1FwRALRiTfIBCV9Tcu/gf/1vL
 xewPTDaJ+Yjhl453iSYWujilXSadvZUdybAXOMh0UIymvzy08sMSZ3wJU2kX7ILl/j9Jpe8GXQy
 k51UCQPb/7vnuDa1MqzV5vTCRb/BrBM78hAh2iUBgxLwbXpm/Xom1DBalLpnTRcHtGZx9SMtuS+
 gVmOETzAIS75IgDj10KZMHN2sft+DM5MOZcA0qbCRBdRMYVvsqRbA5IYeb2seGUlgCHdhw0bkft
 S3tX3oiQZprpiu7UYCIS5Cwszbnzq/6po9EObLaoGCS+a1/SoBSmILgMnoWE15yfP/XlEJN9KOb
 6dKM0a5MtCcDN07HbJj3vaecNr/NwYMBSdT3RNZIxZs8hCT3CRL0r+N3yKtlKLkyhpp29XMpPXp
 np7w==
X-Google-Smtp-Source: AGHT+IGU3ThX0L7n8EBDyWCebR7ykt2CDe/ZKTG3gbCZVw6vyEpNeK5DJDxAG7mU5ZME+toQPiZGlA==
X-Received: by 2002:a05:600c:670a:b0:456:1752:2b44 with SMTP id
 5b1f17b1804b1-456175234f1mr59233155e9.23.1752576034068; 
 Tue, 15 Jul 2025 03:40:34 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4561323a488sm75651795e9.1.2025.07.15.03.40.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Jul 2025 03:40:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH-for-10.1 v5 3/7] accel/system: Introduce @x-accel-stats QMP
 command
Date: Tue, 15 Jul 2025 12:40:11 +0200
Message-ID: <20250715104015.72663-4-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250715104015.72663-1-philmd@linaro.org>
References: <20250715104015.72663-1-philmd@linaro.org>
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


