Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8BE8C3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 21:54:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfQry-0001ZU-RW; Tue, 04 Feb 2025 16:54:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tfQrt-0001Xt-Vk
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 16:54:06 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tfQrr-0008TW-JD
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 16:54:05 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2f9ba87f5d4so2084023a91.3
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 13:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738706042; x=1739310842; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b0+vQ/EpH+1Ge24XXY5IBMPR1lS4eEvzXBLIAsOfJmA=;
 b=LTvYNsQRw3jc5rFBP5Ak3pWB++ahY/UpF6Pt1EXE7DVlZWM/w0r4cnFXlrqmD8q2zE
 lOI5lftN2sYOQT3MIdzMhWWK6IJeerzhdH1kIkEB282ZbbImM5L4t+0nf2xMm3McuNuE
 BZNpliaa1/Yrkj2UDMNODmCDS5bahSxEjdT0K8moK+FKQSEaGGzQJq7Az4yJq2gHplbJ
 IMB+fm+/Nyhf7eAVn7NvOFJZimf7PYXVjwdkGDtHTrVumSchNoCciPbPynWFeK0ACrX2
 EIhz++jbnZgWAXnPBjRGfThFaAVN2+RvtQ/T01U9HqkfX8f3gSraUVgXd8xRINGo+mMd
 1ZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738706042; x=1739310842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b0+vQ/EpH+1Ge24XXY5IBMPR1lS4eEvzXBLIAsOfJmA=;
 b=jSFTr2lIQ5Dj9Cntr/QTxzEUyQUe9IJgzJcQPMIJLSqad3Jiukn865xoW4mTzYy9IL
 f3Il8c5sG2XgY775sqy9HPhIuB7Dcek3P9+WA3W5mfJ0lxAf5l5ITICX7IZOajb9FmgN
 eFsBpHBs/052ST65TgoyGOOs6PwkJ7GJiRN8ZFWT+NIhxurvOQfN9DBa5VG5xSVtsOOm
 /8NAr4AA3klSV8sty1qLmf7BqBAyHlXWHcR9YDMx3pdUZnazsOqRPDV6TtokBPapYuC7
 8KddSyr8eGpprHzTUHIH7MlI0y7koo28htBv8GdS+155zqCsoUbQfiZZZwswPMTxDkQw
 9bgA==
X-Gm-Message-State: AOJu0YyYVD8ncAxwhYIMN4KdAggXsBwaBZR9/FgB7+G8WXLc//QB946/
 Q9h6j/yZeYiHJmisuVSNIHG9n/MkWQKRC+49bqfsnK1yE+2ZblB8S2JVUc4kyoIpGjkEyF/WBQ4
 o
X-Gm-Gg: ASbGncsNtMN9esysZfDU7KW1r20537xjbcc31AyBtA0GdORFYzIUzPzXBBS6umby+kM
 Oh7I2nRPa+QwZ0bM2rroUT7WMO/stNpOHjfEvJoJjKElWD/EEtNrYKyGrVUMtnUPCgxcQfgNXqF
 O0aFIusm9QHP1l7GiyE1Vh4tpP7J4ROorW8yzmg03V8n77yoAba2HoOWjFVZpYfrA3SnSrPtYao
 1/hMRsL7pfdILaKihz9jixqCTSQOJEqc2qMWn+lqXdFXOYHrV6HeNm/3r28Ud7MUXpJnKhlzq2l
 bDPKlarqDVV4IrwCRnsCF9egmmtZfJCGu4LY67V90uEkM3o=
X-Google-Smtp-Source: AGHT+IGKKmyDs1uGbvmgv1GySkEskEIY4B/ZbqNWBSGYhQgjWoQYDl7WH9HRMx2NoSVMHZQQdu/hhA==
X-Received: by 2002:a17:90b:1e43:b0:2ee:acb4:fecd with SMTP id
 98e67ed59e1d1-2f9e075c58amr631608a91.9.1738706042166; 
 Tue, 04 Feb 2025 13:54:02 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f9e1d60b57sm33888a91.9.2025.02.04.13.54.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 13:54:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, berrange@redhat.com,
 philmd@linaro.org, thuth@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 02/12] tcg: Move stubs in tcg/perf.h to tcg/perf-stubs.c
Date: Tue,  4 Feb 2025 13:53:49 -0800
Message-ID: <20250204215359.1238808-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250204215359.1238808-1-richard.henderson@linaro.org>
References: <20250204215359.1238808-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

These are not called so frequently as to be performance sensitive.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/perf.h | 23 -----------------------
 tcg/perf-stubs.c   | 26 ++++++++++++++++++++++++++
 tcg/meson.build    |  2 ++
 3 files changed, 28 insertions(+), 23 deletions(-)
 create mode 100644 tcg/perf-stubs.c

diff --git a/include/tcg/perf.h b/include/tcg/perf.h
index c96b5920a3..050ba855ab 100644
--- a/include/tcg/perf.h
+++ b/include/tcg/perf.h
@@ -7,7 +7,6 @@
 #ifndef TCG_PERF_H
 #define TCG_PERF_H
 
-#if defined(CONFIG_TCG) && defined(CONFIG_LINUX)
 /* Start writing perf-<pid>.map. */
 void perf_enable_perfmap(void);
 
@@ -23,27 +22,5 @@ void perf_report_code(uint64_t guest_pc, TranslationBlock *tb,
 
 /* Stop writing perf-<pid>.map and/or jit-<pid>.dump. */
 void perf_exit(void);
-#else
-static inline void perf_enable_perfmap(void)
-{
-}
-
-static inline void perf_enable_jitdump(void)
-{
-}
-
-static inline void perf_report_prologue(const void *start, size_t size)
-{
-}
-
-static inline void perf_report_code(uint64_t guest_pc, TranslationBlock *tb,
-                                    const void *start)
-{
-}
-
-static inline void perf_exit(void)
-{
-}
-#endif
 
 #endif
diff --git a/tcg/perf-stubs.c b/tcg/perf-stubs.c
new file mode 100644
index 0000000000..ce2dd1a4b7
--- /dev/null
+++ b/tcg/perf-stubs.c
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* TCG perf stubs */
+
+#include "qemu/osdep.h"
+#include "tcg/perf.h"
+
+void perf_enable_perfmap(void)
+{
+}
+
+void perf_enable_jitdump(void)
+{
+}
+
+void perf_report_prologue(const void *start, size_t size)
+{
+}
+
+void perf_report_code(uint64_t guest_pc, TranslationBlock *tb,
+                                    const void *start)
+{
+}
+
+void perf_exit(void)
+{
+}
diff --git a/tcg/meson.build b/tcg/meson.build
index 69ebb4908a..2977df5862 100644
--- a/tcg/meson.build
+++ b/tcg/meson.build
@@ -25,6 +25,8 @@ endif
 tcg_ss.add(when: libdw, if_true: files('debuginfo.c'))
 if host_os == 'linux'
   tcg_ss.add(files('perf.c'))
+else
+  tcg_ss.add(files('perf-stubs.c'))
 endif
 
 tcg_ss = tcg_ss.apply({})
-- 
2.43.0


