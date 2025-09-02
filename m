Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F7F4CA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 10:30:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utOHU-0006la-7U; Tue, 02 Sep 2025 06:30:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utOHN-0006ht-DU
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 06:30:26 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utOHK-00012E-1O
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 06:30:19 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-45b8b1a104cso19606105e9.2
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756809016; x=1757413816; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8DZzfloCVYfnawb+HNzXt3BHlSz81vZt+CpZ/An1bjc=;
 b=hYrPyl13PiqR4upuXQsRkEYS3pDLMjGCNv1aQ8nSTxmQLGCQoqlk/F7Im0O7iCGE0T
 I00/H1QgdbISiOAW5+kN34ClvR3Xtht5rOvMeD6SGqaT3kUXXRGmiu4hb8a4CdujgbIs
 aBzCQuCWQbMMYmUCFj63rJrM1qu+bdwkCQx2k5W1xXKFv8haYGVyV3J8pof5Braf6DA5
 H0bddKL46nvYrYRGIx8InR7+OfPfYnvJAzs83ROHnLABaC3hbJiMa/cPMMhBaLIfLUr0
 n1zS0XEk97nH+3JshTspgcvbwR7mEfEcB1Z7MEy3FQqB96N/CXX5lhLPK9AC/rwnXnA5
 QQLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756809016; x=1757413816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8DZzfloCVYfnawb+HNzXt3BHlSz81vZt+CpZ/An1bjc=;
 b=uJiWn/6ZBHjF8gz3my5aNQV8TCkJ5eQ7p5IPisqwGVXGwglubZ63Zcl5TrTkGCk9mN
 R5j3IRFw4ZHjZ19J2rZwRq4Hx+YgIvKcuNq31N2Asq5Ha4TMiEWV2Zxc+BfzHU4WX4pj
 NCltrBTA6fOTbeGAE9JslaL9X8bMXplOYjew+JjD9qrZJmFHJ95VMYifm2L44wuvcAUW
 FZwyeOh7FzTtV9MKBQTN4f2vhkGWC91zyuozxLQcwDyXSbf+EAL2RlwSx4kQS2XZrpdd
 Jw5U+RW55Bhf5Jopb69M1GIhCAkL3lOOmpHPZPGbdgwyV1sQP3Hp2V5y58InUjKNp1xZ
 XjCw==
X-Gm-Message-State: AOJu0YzAt4hvm+FsQW3y/zzyQ3CE6N3oJ69IHuzVpMHRWz8SSOOibrSV
 fKr2EPE5zdpQhtbTW6n4WK+L75osXv844LoIK3S4nvXbZNN0AeaCELVJKD6bYiul2hQBfw1yySx
 6terQb+Y=
X-Gm-Gg: ASbGnct+AySCjRKN4Lt+mGAIp45vKAxg4dkaIEoqvwL3XMcsqrVK9O1sRYpw+Ysy8re
 wIVtIYqNwsVDCXz9Sx3qZIGB2SGUJQYM/Tnf5w5gMT3DMKZzyK9JqzMoNiMbeD8+gRZhh3ymCjN
 QsouiWr6t26Bv+jv4fopqrgHSml86pbo2C3IVQbLQBzEHIFi2w9YJDtjcZABNyBccKeO8fI13AR
 Eu0uxEBhV88Hw86JbUA/N4x29EIDteWSzXoJ5uVakfmz3MAVIJ5TGM1zjcA4gwQZH/QmcgKWH2q
 PJVamZmw7bVLoBgGdPosU6C1TD+9607OuugZ3N/qsN7qnb+qMIFmpUZALv++cEmZCoDE9V8u72d
 d/ibCVzzEBruF87AENcYd8HSTdkZuLYKTLeLF8jDzvxsFbiLAVAUOuFFbNHCW8kE=
X-Google-Smtp-Source: AGHT+IFJw/io0xUn77SLs4ccx+FzaqLixdyicaC1K62fMKtpMUpQdL4j89LVAEXIdH95f6bUaunIWg==
X-Received: by 2002:a05:6000:4312:b0:3cf:3f1:acc3 with SMTP id
 ffacd0b85a97d-3d1df631895mr9852288f8f.60.1756809015716; 
 Tue, 02 Sep 2025 03:30:15 -0700 (PDT)
Received: from stoup.. (151-0-205-164.ip282.fastwebnet.it. [151.0.205.164])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f0d32a2sm296470665e9.9.2025.09.02.03.30.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Sep 2025 03:30:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com
Subject: [RFC 2/4] util: Drop QMESSAGE_CONTEXT_SKIP_MONITOR
Date: Tue,  2 Sep 2025 12:30:08 +0200
Message-ID: <20250902103010.309094-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250902103010.309094-1-richard.henderson@linaro.org>
References: <20250902103010.309094-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32e.google.com
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
 include/qemu/message.h | 11 +----------
 util/error-report.c    |  9 +++++----
 util/log.c             |  2 +-
 util/message.c         |  7 +------
 4 files changed, 8 insertions(+), 21 deletions(-)

diff --git a/include/qemu/message.h b/include/qemu/message.h
index 6dbb068ca9..68b08f0ea7 100644
--- a/include/qemu/message.h
+++ b/include/qemu/message.h
@@ -28,25 +28,16 @@ void qmessage_set_format(int flags);
  */
 void qmessage_set_workload_name(const char *name);
 
-enum QMessageContextFlags {
-    QMESSAGE_CONTEXT_SKIP_MONITOR = (1 << 0),
-};
-
 /**
  * qmessage_context:
- * @flags: the message formatting control flags
  *
  * Format a message prefix with the information
  * previously selected by a call to
  * qmessage_set_format.
  *
- * If @flags contains QMESSAGE_CONTEXT_SKIP_MONITOR
- * an empty string will be returned if running in
- * the context of a HMP command
- *
  * Returns: a formatted message prefix, or empty string;
  * to be freed by the caller.
  */
-char *qmessage_context(int flags);
+char *qmessage_context(void);
 
 #endif /* QEMU_MESSAGE_H */
diff --git a/util/error-report.c b/util/error-report.c
index 2e58ee1c50..fa34019dad 100644
--- a/util/error-report.c
+++ b/util/error-report.c
@@ -172,10 +172,11 @@ static void print_loc(void)
 G_GNUC_PRINTF(2, 0)
 static void vreport(report_type type, const char *fmt, va_list ap)
 {
-    g_autofree gchar *context = qmessage_context(QMESSAGE_CONTEXT_SKIP_MONITOR);
-
-    if (context != NULL) {
-        error_printf("%s", context);
+    if (!monitor_cur()) {
+        g_autofree gchar *context = qmessage_context();
+        if (context) {
+            error_printf("%s", context);
+        }
     }
 
     print_loc();
diff --git a/util/log.c b/util/log.c
index 4b5953dcc7..b129634708 100644
--- a/util/log.c
+++ b/util/log.c
@@ -161,7 +161,7 @@ void qemu_log(const char *fmt, ...)
      * acquiring the mutex
      */
     g_autofree const char *context =
-        incomplete ? NULL : qmessage_context(0);
+        incomplete ? NULL : qmessage_context();
 
     f = qemu_log_trylock();
     if (f) {
diff --git a/util/message.c b/util/message.c
index 6d3580b7be..8deba3940c 100644
--- a/util/message.c
+++ b/util/message.c
@@ -20,17 +20,12 @@ void qmessage_set_workload_name(const char *name)
 }
 
 
-char *qmessage_context(int flags)
+char *qmessage_context(void)
 {
     g_autofree char *timestr = NULL;
     const char *wknamestr = NULL;
     const char *pgnamestr = NULL;
 
-    if ((flags & QMESSAGE_CONTEXT_SKIP_MONITOR) &&
-        monitor_cur()) {
-        return NULL;
-    }
-
     if (message_format & QMESSAGE_FORMAT_TIMESTAMP) {
         g_autoptr(GDateTime) dt = g_date_time_new_now_utc();
         timestr = g_date_time_format_iso8601(dt);
-- 
2.43.0


