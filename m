Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0059BCA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 10:31:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utOHz-0007Me-RR; Tue, 02 Sep 2025 06:30:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utOHS-0006iQ-2p
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 06:30:26 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utOHL-00012N-3F
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 06:30:22 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-45b627ea685so44391065e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756809017; x=1757413817; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xQrZp/o3nVe5VIQl1WMbqwaLzlGBPHdSsPm8KVtBY6o=;
 b=vT7kHvtnAVd7yjLYmJ//8lTlUaNSnFo5EY6fLdbzDC8ulV1d60yatvys6me5zUdBM0
 vMmnGqexGHyTqKfwYdnnxuuKSo7cJMnMRNmaerIurv08qpk20qDxVJg1rsq7A39zUCEC
 6bWOZLa6F578JDcUzCWQ6lgyoq/u4FyauCdIujRlrD6yq6VaIb/FyDmfU69Ml6Fj7Xak
 Ags/QLe5mrq+8sGcbXKEyvjgUp7RCrypuOgXMgic/civsQdC3F4f++YANFK0stz3cuY4
 5ukMgEOGRyWebkXw3MMPzIOiUe8udrtzclVfpw8HwtBVMQejtUsSjWKCcRzklvfXtnbP
 YElw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756809017; x=1757413817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xQrZp/o3nVe5VIQl1WMbqwaLzlGBPHdSsPm8KVtBY6o=;
 b=SaaKegDbB16Z8itF44qEYycricb4uip17/fWcg3afNGO7iVI5HRCM399RVmjJPafWw
 uyOQptZVCJdeayfDE8dEW08OdGwc5KcK6uf9lxySl0GR7HBtt+eWFucNgDse122Kpk5I
 bdplhfri6KLAZKs2WarcGwVByeetjC2nujO4NkO3NyjAvnnZfSXtJVnLz/0kzo2KxNWn
 HhhvvveGRuhzMjU3U0k5yWbUkeilyCDNK5Tk0kwl6FXb3bX6SxHkwx8LO//EwhbL+igP
 3Irw7MlruyedFvxUscALanvliFihcRawV2YDKpLCIRsLgRgquSOW0hegzaGnvNxzT///
 5JhQ==
X-Gm-Message-State: AOJu0YytrjXQJ3kMiHRDx2Um97JVOZjxcp1ZxUPcvVWWu+ir+jV+LSl1
 COmqFHCyDwf/+FyOq+I7Qs9wN3SErsINU3kaS5K/q940vvVM6/lgOGqrD4KlVQF6RO7mYherIG9
 DN61qVZE=
X-Gm-Gg: ASbGncvwdp300LLEaly2YupWjCPUerDXWyAku+/TtP5BswbM/J63FtyL3pakUFLMv3Q
 B+O2W80vbw87AVWH6lReu2zVBF2MJTCJWK6J8M85+K+5c62ARAqwypdyX+O+2mn570o1K+12uJw
 Kt2PjmmjEVrUy4/O8zGxblMkYRD08aCZWbSs2I8M1dsJLRRhFOsXPb5eoq8I3PYeU9N7gq9FO9q
 4OMgjfmKzEI4QjpIFyDB/Fs0DFpMJjere8LO2Xad5/KQQRzp64WnAxTgy9nCQmlX9V94/sOfleX
 b5FV18qN63jzr2yj9CE5l2M+wK0ElNLRnRV+gybOAn1D30AXcNK8416s8CV8g4rHaU/LPugipP+
 XAcG23tXKuNiB/ExN3BngOEFjdcbm+IMYsXAhVVHd3pyEa4XCrnH/QRxGwA6a8/DeJkIq+ezjRA
 ==
X-Google-Smtp-Source: AGHT+IE8QeM8eGqgCZQOVwH0QH9cFIshjds/kkQ0aUrifjSIPCpaTztCKvnoe1lxUNZ156SuuPGFgQ==
X-Received: by 2002:a05:600c:3b84:b0:45b:89ef:65ae with SMTP id
 5b1f17b1804b1-45b89ef6623mr90153345e9.16.1756809017030; 
 Tue, 02 Sep 2025 03:30:17 -0700 (PDT)
Received: from stoup.. (151-0-205-164.ip282.fastwebnet.it. [151.0.205.164])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f0d32a2sm296470665e9.9.2025.09.02.03.30.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Sep 2025 03:30:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com
Subject: [RFC 3/4] util/message: Use LogOutput
Date: Tue,  2 Sep 2025 12:30:09 +0200
Message-ID: <20250902103010.309094-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250902103010.309094-1-richard.henderson@linaro.org>
References: <20250902103010.309094-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x331.google.com
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
 include/qemu/message.h | 12 +++++-------
 util/error-report.c    |  8 ++++----
 util/log.c             | 16 ++--------------
 util/message.c         | 40 ++++++++++++++++++----------------------
 4 files changed, 29 insertions(+), 47 deletions(-)

diff --git a/include/qemu/message.h b/include/qemu/message.h
index 68b08f0ea7..ac285a0021 100644
--- a/include/qemu/message.h
+++ b/include/qemu/message.h
@@ -3,6 +3,8 @@
 #ifndef QEMU_MESSAGE_H
 #define QEMU_MESSAGE_H
 
+#include "qemu/log-output.h"
+
 enum QMessageFormatFlags {
     QMESSAGE_FORMAT_TIMESTAMP = (1 << 0),
     QMESSAGE_FORMAT_WORKLOAD_NAME = (1 << 1),
@@ -31,13 +33,9 @@ void qmessage_set_workload_name(const char *name);
 /**
  * qmessage_context:
  *
- * Format a message prefix with the information
- * previously selected by a call to
- * qmessage_set_format.
- *
- * Returns: a formatted message prefix, or empty string;
- * to be freed by the caller.
+ * Format a message prefix with the information previously selected
+ * by a call to qmessage_set_format.
  */
-char *qmessage_context(void);
+void qmessage_context(const LogOutput *l, void *opaque);
 
 #endif /* QEMU_MESSAGE_H */
diff --git a/util/error-report.c b/util/error-report.c
index fa34019dad..6ef556af5f 100644
--- a/util/error-report.c
+++ b/util/error-report.c
@@ -173,10 +173,10 @@ G_GNUC_PRINTF(2, 0)
 static void vreport(report_type type, const char *fmt, va_list ap)
 {
     if (!monitor_cur()) {
-        g_autofree gchar *context = qmessage_context();
-        if (context) {
-            error_printf("%s", context);
-        }
+        void *opaque;
+        const LogOutput *l = error_log_output(&opaque);
+
+        qmessage_context(l, opaque);
     }
 
     print_loc();
diff --git a/util/log.c b/util/log.c
index b129634708..8bbd8e5dda 100644
--- a/util/log.c
+++ b/util/log.c
@@ -153,23 +153,11 @@ static __thread bool incomplete;
 
 void qemu_log(const char *fmt, ...)
 {
-    FILE *f;
-    /*
-     * Prepare the context *outside* the logging
-     * lock so any timestamp better reflects when
-     * the message was emitted if we are delayed
-     * acquiring the mutex
-     */
-    g_autofree const char *context =
-        incomplete ? NULL : qmessage_context();
-
-    f = qemu_log_trylock();
+    FILE *f = qemu_log_trylock();
     if (f) {
         va_list ap;
 
-        if (context != NULL) {
-            fwrite(context, 1, strlen(context), f);
-        }
+        qmessage_context(&log_output_stdio, f);
 
         va_start(ap, fmt);
         vfprintf(f, fmt, ap);
diff --git a/util/message.c b/util/message.c
index 8deba3940c..0c63d128fc 100644
--- a/util/message.c
+++ b/util/message.c
@@ -20,7 +20,7 @@ void qmessage_set_workload_name(const char *name)
 }
 
 
-char *qmessage_context(void)
+void qmessage_context(const LogOutput *l, void *opaque)
 {
     g_autofree char *timestr = NULL;
     const char *wknamestr = NULL;
@@ -43,26 +43,22 @@ char *qmessage_context(void)
         int thid = qemu_get_thread_id();
         const char *thname = qemu_thread_get_name();
 
-        return g_strdup_printf("%s%s%s%s%s%s(%d:%s): ",
-                               timestr ? timestr : "",
-                               timestr ? " " : "",
-                               wknamestr ? "[" : "",
-                               wknamestr ? wknamestr : "",
-                               wknamestr ? "] " : "",
-                               pgnamestr ? pgnamestr : "",
-                               thid, thname);
-    } else {
-        if (!timestr && !wknamestr && !pgnamestr) {
-            return NULL;
-        }
-
-        return g_strdup_printf("%s%s%s%s%s%s%s",
-                               timestr ? timestr : "",
-                               timestr ? " " : "",
-                               wknamestr ? "[" : "",
-                               wknamestr ? wknamestr : "",
-                               wknamestr ? "] " : "",
-                               pgnamestr ? pgnamestr : "",
-                               pgnamestr ? ": " : "");
+        l->print(opaque, "%s%s%s%s%s%s(%d:%s): ",
+                 timestr ? timestr : "",
+                 timestr ? " " : "",
+                 wknamestr ? "[" : "",
+                 wknamestr ? wknamestr : "",
+                 wknamestr ? "] " : "",
+                 pgnamestr ? pgnamestr : "",
+                 thid, thname);
+    } else if (timestr || wknamestr || pgnamestr) {
+        l->print(opaque, "%s%s%s%s%s%s%s",
+                 timestr ? timestr : "",
+                 timestr ? " " : "",
+                 wknamestr ? "[" : "",
+                 wknamestr ? wknamestr : "",
+                 wknamestr ? "] " : "",
+                 pgnamestr ? pgnamestr : "",
+                 pgnamestr ? ": " : "");
     }
 }
-- 
2.43.0


