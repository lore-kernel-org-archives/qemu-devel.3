Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3823EC48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 06:22:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raV7M-0002jO-Dg; Thu, 15 Feb 2024 01:21:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raV7J-0002aB-FP
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 01:21:05 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raV7H-0005aE-4q
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 01:21:04 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1d91397bd22so3785535ad.0
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 22:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707978062; x=1708582862; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n/bmjjPgt+4cAZDZblP4w6A7Xhw+0ftgWcgfLTUC2AM=;
 b=iAVlYPA3IK6ae7rQCI5dUhoCxdHv87BIiZR6rzuLU0BCkBApD2gktnpMnHlyol+P3U
 C9tMWKRcpHto4GSN81BqvnMPjrEAwHU5lxMYP8ulg+w33Hy+Fe394w49BWsUPzrs2eP/
 Picgqp6If7zZ3yUqMDgYKySdb5mt+oFk9ngduUf/fAEn3acHudRx9RLjTDTlopoTySxW
 ApdibbJHEtLzUTTTIoFN5bH4Crgt45+qyGk24TvdVRmk/Xypp3yN1ycTSa7L+9hi4jVP
 4TmZG6MyztUD3vAzcoBDbXeoo7qWZDV0HjQjKVyKk9i+WYC7WnEWA90knuIGt7AXxGte
 r/XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707978062; x=1708582862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n/bmjjPgt+4cAZDZblP4w6A7Xhw+0ftgWcgfLTUC2AM=;
 b=w7VeyvVbyGcbd9RNk88qTTPzRHu2sXTG4PeO0GiS//v9OL02mG5V4XNwXT7p9Ykata
 x2fqR/JNluKcot89bEOSfMQYhoY/yviDdJogedCNFINoIFAtvUz/6+fyYce4Czpg9CtP
 APxoKjT6LYCdvOPTiAeJ08EHB8Rsb5ROL1m6EHtYOCbDCb5I4OUyMx4L1DQ9lO2xow1B
 9GTJRI5xLN+zkAXZ/IFkmfAsgWjiSJiKKpq7G7+ZuNNjrTDjLUtYU4Vaix3rgWA3BMOH
 cj9YvPJrsbaw1VbB+XMD9YihoGj5VwaxnfJYkVaA7JW2HpTi7Y9uY7zGkDt0zEWWh4Ld
 pVoA==
X-Gm-Message-State: AOJu0YyBPZCoGx61tHmwhtAIeIwY7GyL7/L8ZbLWpY/EKqYWG/ORT9OG
 /LVQx4ZJx1Q1EzEdMKbQ0VKuizQFsrFWcdAykEXYzM6uizNboI7L5xTfyxsLS97jNmf5JScSXA6
 9
X-Google-Smtp-Source: AGHT+IFtt8DndZ0a6o9UnlIWG+rcYFPDVaMRlnbct6yM6wrlh/eav1cW1IdrVFH6ugdaYp27kSmA7Q==
X-Received: by 2002:a17:902:b686:b0:1d9:8f6e:86e8 with SMTP id
 c6-20020a170902b68600b001d98f6e86e8mr729039pls.69.1707978061977; 
 Wed, 14 Feb 2024 22:21:01 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 d5-20020a170902b70500b001d6f29c12f7sm464418pls.135.2024.02.14.22.21.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 22:21:00 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH v4 28/36] *-user: Deprecate and disable -p pagesize
Date: Wed, 14 Feb 2024 20:20:10 -1000
Message-Id: <20240215062018.795056-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215062018.795056-1-richard.henderson@linaro.org>
References: <20240215062018.795056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This option controls the host page size.  From the mis-usage in
our own testsuite, this is easily confused with guest page size.

The only thing that occurs when changing the host page size is
that stuff breaks, because one cannot actually change the host
page size.  Therefore reject all but the no-op setting as part
of the deprecation process.

Reviewed-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Helge Deller <deller@gmx.de>
Message-Id: <20240102015808.132373-27-richard.henderson@linaro.org>
---
 docs/about/deprecated.rst | 10 ++++++++++
 docs/user/main.rst        |  3 ---
 bsd-user/main.c           | 10 +++++-----
 linux-user/main.c         | 12 ++++++------
 4 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 5a2305ccd6..3074303b9c 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -63,6 +63,16 @@ as short-form boolean values, and passed to plugins as ``arg_name=on``.
 However, short-form booleans are deprecated and full explicit ``arg_name=on``
 form is preferred.
 
+User-mode emulator command line arguments
+-----------------------------------------
+
+``-p`` (since 9.0)
+''''''''''''''''''
+
+The ``-p`` option pretends to control the host page size.  However,
+it is not possible to change the host page size, and using the
+option only causes failures.
+
 QEMU Machine Protocol (QMP) commands
 ------------------------------------
 
diff --git a/docs/user/main.rst b/docs/user/main.rst
index 7e7ad07409..d5fbb78d3c 100644
--- a/docs/user/main.rst
+++ b/docs/user/main.rst
@@ -87,9 +87,6 @@ Debug options:
    Activate logging of the specified items (use '-d help' for a list of
    log items)
 
-``-p pagesize``
-   Act as if the host page size was 'pagesize' bytes
-
 ``-g port``
    Wait gdb connection to port
 
diff --git a/bsd-user/main.c b/bsd-user/main.c
index e5efb7b845..521b58b880 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -364,11 +364,11 @@ int main(int argc, char **argv)
         } else if (!strcmp(r, "L")) {
             interp_prefix = argv[optind++];
         } else if (!strcmp(r, "p")) {
-            qemu_host_page_size = atoi(argv[optind++]);
-            if (qemu_host_page_size == 0 ||
-                (qemu_host_page_size & (qemu_host_page_size - 1)) != 0) {
-                fprintf(stderr, "page size must be a power of two\n");
-                exit(1);
+            unsigned size, want = qemu_real_host_page_size();
+
+            if (qemu_strtoui(arg, NULL, 10, &size) || size != want) {
+                warn_report("Deprecated page size option cannot "
+                            "change host page size (%u)", want);
             }
         } else if (!strcmp(r, "g")) {
             gdbstub = g_strdup(argv[optind++]);
diff --git a/linux-user/main.c b/linux-user/main.c
index e540acb84a..bad03f06d3 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -332,11 +332,11 @@ static void handle_arg_ld_prefix(const char *arg)
 
 static void handle_arg_pagesize(const char *arg)
 {
-    qemu_host_page_size = atoi(arg);
-    if (qemu_host_page_size == 0 ||
-        (qemu_host_page_size & (qemu_host_page_size - 1)) != 0) {
-        fprintf(stderr, "page size must be a power of two\n");
-        exit(EXIT_FAILURE);
+    unsigned size, want = qemu_real_host_page_size();
+
+    if (qemu_strtoui(arg, NULL, 10, &size) || size != want) {
+        warn_report("Deprecated page size option cannot "
+                    "change host page size (%u)", want);
     }
 }
 
@@ -496,7 +496,7 @@ static const struct qemu_argument arg_table[] = {
     {"D",          "QEMU_LOG_FILENAME", true, handle_arg_log_filename,
      "logfile",     "write logs to 'logfile' (default stderr)"},
     {"p",          "QEMU_PAGESIZE",    true,  handle_arg_pagesize,
-     "pagesize",   "set the host page size to 'pagesize'"},
+     "pagesize",   "deprecated change to host page size"},
     {"one-insn-per-tb",
                    "QEMU_ONE_INSN_PER_TB",  false, handle_arg_one_insn_per_tb,
      "",           "run with one guest instruction per emulated TB"},
-- 
2.34.1


