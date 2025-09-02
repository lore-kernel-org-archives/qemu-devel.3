Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1353CA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 10:31:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utOHu-00073a-LR; Tue, 02 Sep 2025 06:30:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utOHM-0006hr-Ss
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 06:30:26 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utOHI-00011p-8T
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 06:30:19 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3ce4ed7a73fso2674973f8f.1
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756809014; x=1757413814; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jx0gaB1gsva7mID0JHrMFFkewSed//dl5d0ra2Fwoi0=;
 b=JPJsJadd113zowauFWQ+NFZKpWjcsHVfiOX8/56dj8AjfyWcOJev5gqjU8zXEL4lKr
 MXofboy5WzNmZMenYBWmHtuJUVlnj+aK1byiXn86TbiwWtt34nn0daNdDa8ou115YAIG
 IZ7NfoChKPcN060dqsxxTV7R6ck+KOCi0q0zOzSVBPPMvcd5ymWbidKfSF9nrYpoVlaR
 4fGRQ59PYBZY6Lv8OeB2oJzUsOLTzRfe1fp9k4OYwybJCiLQ18YlwP5GYWDsCWd0ksaH
 3yYuO2RHEo5hNIeRgwB0kKlk30Xh/ibv469gRuQXtJ1OuT60b7djatOEd4mE4G08ZcqJ
 KQEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756809014; x=1757413814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jx0gaB1gsva7mID0JHrMFFkewSed//dl5d0ra2Fwoi0=;
 b=Xg5iqxC1GXbIPKS20WZ6HXZ6lSnKEM3LtaVSyTWHzQ5L0GK9Dsj+7h0RkcIWZlMNyK
 hInVjqhbyeC/Khwgrto6Af0f26+71DQ8v19iPJrmc71PJNnkTXDDw4z+P+9H2vxUyNLz
 1OY40nInQQ33ro4WEWHzrW2hLUtGhmfC2A0dtBk57Ltdxbt1b0amIEEiBjwnIPUBeKK/
 t+O49uV3MAsf9Uh6812GbuR2CNgkqYjF4R3I1Mro7cVlRMUCoB9CSVvsAQm9D1/o2c5f
 TBtIfQ1QSjsmT1zZrUp3RgeAgNpL16Wt6Gaak+KDCcPQv2vOYlkFkCaN9lZjMdh85C+J
 4LGg==
X-Gm-Message-State: AOJu0YzsB1xOGGnQyrK5JEWInGjXM8sgKuD/Rbc4dL/K/Nl2biTt89KF
 XqHZItfFV/du0sf30c2tQS1Hwc7CXgSqUTEd8LIIGT9/v6bF1lWDbnhkWaGGuhkMNFH4cDy4Ta4
 MFEWl5N0=
X-Gm-Gg: ASbGncur5vFRuAb3tFoC9WWRJwJSG7TO4fUJINR0JJu92NW9UjNdf6rCsT7yj7QLyOD
 NnLglKvZkwqsOb3dyrIgd2z/ESEKNKTrIJYeuuAf45g45HGGLNA2zcwUf9H+HfzBxfeNpBJIIHn
 VUkIygIvfCIiOqTEkJMbc3haRgs2g3/IA39tGTWyhidCdIDW/1fehYecAbS+zrYTxZ9OwhxY2Eo
 +VrREhIVJCNHrbDrsuQyBXfpIoRl7XBBw2SCrSUPZgUmmqkYtEd6mTC/RxXBUsDZ3BPvKmb5Mx5
 P2MakhxTe/ATh12P+xm58QAvFmtGqMYaA6D3QhuzKFt5CYwfC/t/9Ry+Q/gwbEMlilcp9HJU3EU
 oseCzc7c6n5ZoLukd1SWPTBBcAbMlPtFagLkmKcDbKajT2roK7WYOhc6AxUmKOjd6apYeTNikPQ
 ==
X-Google-Smtp-Source: AGHT+IHhQWwo3VyernzucK4Mb+JHtbhYxaZlH3U+bgIl27N28RyrfR4HVViHvOCAWnTji6aSLf0IAg==
X-Received: by 2002:a05:6000:290b:b0:3c7:df1d:3d9 with SMTP id
 ffacd0b85a97d-3d1dfa19a4dmr9643779f8f.39.1756809013930; 
 Tue, 02 Sep 2025 03:30:13 -0700 (PDT)
Received: from stoup.. (151-0-205-164.ip282.fastwebnet.it. [151.0.205.164])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f0d32a2sm296470665e9.9.2025.09.02.03.30.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Sep 2025 03:30:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com
Subject: [RFC 1/4] util: Introduce LogOutput
Date: Tue,  2 Sep 2025 12:30:07 +0200
Message-ID: <20250902103010.309094-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250902103010.309094-1-richard.henderson@linaro.org>
References: <20250902103010.309094-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42a.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/monitor/monitor.h |  4 +++
 include/qemu/log-output.h | 14 ++++++++++
 monitor/monitor.c         | 54 +++++++++++++++++++++++++++++++--------
 stubs/error-printf.c      | 11 ++++++++
 util/log.c                |  7 +++++
 5 files changed, 79 insertions(+), 11 deletions(-)
 create mode 100644 include/qemu/log-output.h

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index c3740ec616..8c4d73592f 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -4,6 +4,7 @@
 #include "block/block.h"
 #include "qapi/qapi-types-misc.h"
 #include "qemu/readline.h"
+#include "qemu/log-output.h"
 #include "exec/hwaddr.h"
 
 typedef struct MonitorHMP MonitorHMP;
@@ -62,4 +63,7 @@ void monitor_register_hmp_info_hrt(const char *name,
 int error_vprintf_unless_qmp(const char *fmt, va_list ap) G_GNUC_PRINTF(1, 0);
 int error_printf_unless_qmp(const char *fmt, ...) G_GNUC_PRINTF(1, 2);
 
+const LogOutput *error_log_output(void **popaque);
+const LogOutput *error_log_output_unless_qmp(void **popaque);
+
 #endif /* MONITOR_H */
diff --git a/include/qemu/log-output.h b/include/qemu/log-output.h
new file mode 100644
index 0000000000..1d502aae77
--- /dev/null
+++ b/include/qemu/log-output.h
@@ -0,0 +1,14 @@
+#ifndef QEMU_LOG_OUTPUT_H
+#define QEMU_LOG_OUTPUT_H 1
+
+typedef int LogOutputVararg(void *, const char *, ...) G_GNUC_PRINTF(2, 3);
+typedef int LogOutputVaList(void *, const char *, va_list) G_GNUC_PRINTF(2, 0);
+
+typedef struct LogOutput {
+    LogOutputVararg *print;
+    LogOutputVaList *vprint;
+} LogOutput;
+
+extern const LogOutput log_output_stdio;
+
+#endif
diff --git a/monitor/monitor.c b/monitor/monitor.c
index da54e1b1ce..71a3d62e0f 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -268,28 +268,60 @@ void monitor_printc(Monitor *mon, int c)
     monitor_printf(mon, "'");
 }
 
+static const LogOutput log_output_monitor = {
+    /* Abuse the Monitor* argument of monitor_printf as void* opaque. */
+    (LogOutputVararg *)monitor_printf,
+    (LogOutputVaList *)monitor_vprintf,
+};
+
+const LogOutput *error_log_output(void **popaque)
+{
+    Monitor *cur_mon = monitor_cur();
+
+    if (cur_mon && !monitor_cur_is_qmp()) {
+        *popaque = cur_mon;
+        return &log_output_monitor;
+    }
+
+    *popaque = stderr;
+    return &log_output_stdio;
+}
+
+const LogOutput *error_log_output_unless_qmp(void **popaque)
+{
+    Monitor *cur_mon = monitor_cur();
+
+    if (!cur_mon) {
+        *popaque = stderr;
+        return &log_output_stdio;
+    }
+    if (!monitor_cur_is_qmp()) {
+        *popaque = cur_mon;
+        return &log_output_monitor;
+    }
+
+    *popaque = NULL;
+    return NULL;
+}
+
 /*
  * Print to current monitor if we have one, else to stderr.
  */
 int error_vprintf(const char *fmt, va_list ap)
 {
-    Monitor *cur_mon = monitor_cur();
+    void *opaque;
+    const LogOutput *l = error_log_output(&opaque);
 
-    if (cur_mon && !monitor_cur_is_qmp()) {
-        return monitor_vprintf(cur_mon, fmt, ap);
-    }
-    return vfprintf(stderr, fmt, ap);
+    return l->vprint(opaque, fmt, ap);
 }
 
 int error_vprintf_unless_qmp(const char *fmt, va_list ap)
 {
-    Monitor *cur_mon = monitor_cur();
+    void *opaque;
+    const LogOutput *l = error_log_output_unless_qmp(&opaque);
 
-    if (!cur_mon) {
-        return vfprintf(stderr, fmt, ap);
-    }
-    if (!monitor_cur_is_qmp()) {
-        return monitor_vprintf(cur_mon, fmt, ap);
+    if (l) {
+        return l->vprint(opaque, fmt, ap);
     }
     return -1;
 }
diff --git a/stubs/error-printf.c b/stubs/error-printf.c
index 0e326d8010..82e4756bda 100644
--- a/stubs/error-printf.c
+++ b/stubs/error-printf.c
@@ -21,3 +21,14 @@ int error_vprintf_unless_qmp(const char *fmt, va_list ap)
 {
     return error_vprintf(fmt, ap);
 }
+
+const LogOutput *error_log_output(void **popaque)
+{
+    *popaque = stderr;
+    return &log_output_stdio;
+}
+
+const LogOutput *error_log_output_unless_qmp(void **popaque)
+{
+    return error_log_output(popaque);
+}
diff --git a/util/log.c b/util/log.c
index fc900cde0c..4b5953dcc7 100644
--- a/util/log.c
+++ b/util/log.c
@@ -28,6 +28,7 @@
 #include "qemu/thread.h"
 #include "qemu/lockable.h"
 #include "qemu/rcu.h"
+#include "qemu/log-output.h"
 #ifdef CONFIG_LINUX
 #include <sys/syscall.h>
 #endif
@@ -592,3 +593,9 @@ ssize_t rust_fwrite(const void *ptr, size_t size, size_t nmemb, FILE *stream)
     return ret < 0 ? -errno : 0;
 }
 #endif
+
+const LogOutput log_output_stdio = {
+    /* Abuse the FILE* argument of fprintf as void* opaque. */
+    (LogOutputVararg *)fprintf,
+    (LogOutputVaList *)vfprintf,
+};
-- 
2.43.0


