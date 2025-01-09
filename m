Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A75E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 17:08:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVvzb-0004j6-1B; Thu, 09 Jan 2025 12:06:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVvzQ-0004hW-QP
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:06:37 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVvzP-0006zH-65
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:06:36 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ab2aea81cd8so164078466b.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 09:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736442393; x=1737047193; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m4HscSGSbgGDvVgJtmItkpjxqeI2JXO5tblvojQlyxc=;
 b=HeUPOBUYQQFyA25g4kvtKrB1ujRne8ADc2aJYvjaYbm0G3JmH0XW6LSBueQew/++gU
 RPlktqkiNFTcCsIPTQCUHcXxmuDTGkBAtH7bVk5i20nX3wcNEuBKQOI4zF3En983vWsw
 Snbzu8Z07VLPlecPuwAqEU+YRFV7gn0DgVAA3rvxw8N0o1maUg9X19jWW3Hhj6/08cuK
 NznReSjWdPOmP2FcOQq+3EXgJiDuJBTBYePJ4k9NyoGv0ifpWDqZ5Pu0RBIx4iZqVOrv
 /0Lz6rld7LVGZY5hEkeR3RVWb5u3Vpp5F4jAEF978inreU3RoP4X+yr3ZuX9aUQh/o16
 DNCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736442393; x=1737047193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m4HscSGSbgGDvVgJtmItkpjxqeI2JXO5tblvojQlyxc=;
 b=CM555AMAjX9bPkK8d554e4fdcY+aRz8jL+E21xCMNWwzBmRRZ3yiJdst6oY/Ux3jRh
 rpZUuT7r0CncUTrdqdbf1/27WZeDHj1fOAFdiRhFofHTIk7CFK8YeY3sytX+rWv3e0wz
 Q0XSDDSD111A4MyAlZSxjs/pZ4Clf3YEZTmFSqhg6apkUkGWyM4EzZsl8XO3Y7QoJL9T
 MFRIrZhMB7YZv8eBFk3ladb/pxpR+vBQIR6ZOXh1qM/ZlGylBVF4SbCjOKwNzOdtADOX
 LKqs8iXg4JSZNg7xMQ5P9iXsFjhocxTV/w2WzROgUx5e1sEqcJMINhEcFyRt9PCg08O8
 Fp+g==
X-Gm-Message-State: AOJu0YzEZE+DhbXffMK0ikeASCyLPPA/9qX+kfeYBf3difQ9nHnsQtIq
 hSSw5lztc51C8FiBjg8u3tPE2Hlj2y5/UHnmvihxbVKFxIMHKzTo+ZGxmaqtyDg=
X-Gm-Gg: ASbGncuzESmsoE1Qgy2rwj2qy9teQFU9OCfu5KI1ejVeFUn+ktdG59GiiCTakhZH5jP
 zZiYWcmlqih1mA/mUPMaE7fINeudVk0/FKVA+y4NzwUmfGoYrGJEkWfHZm739sJn4aHKrXVcIVC
 vzcQeQqYvMH0PhZ3MYS9W6HaSyDD3U5cjLyZ3ZZoUcrGixkPmgoZpi/x6S0E52dxV5SFlBI+/Yo
 P0tM/nox1KwPzsj+w4jS2ztR2hCdiGQZBtXcKJ/zQ4SMqh9DSYgyko=
X-Google-Smtp-Source: AGHT+IEdMW6yQgxXeq+98WR2f9UfOi5G/YrL93qHuoHlySuxq5eNwVouXjvQcF37CnK0NArneIrf9A==
X-Received: by 2002:a17:907:7e86:b0:aa6:92de:ddae with SMTP id
 a640c23a62f3a-ab2ab6a3fbemr654526166b.16.1736442393404; 
 Thu, 09 Jan 2025 09:06:33 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c9060a4fsm90134366b.15.2025.01.09.09.06.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 09:06:31 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 89A8C5FAA7;
 Thu,  9 Jan 2025 17:06:20 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 08/22] system/vl: more error exit into config enumeration code
Date: Thu,  9 Jan 2025 17:06:05 +0000
Message-Id: <20250109170619.2271193-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250109170619.2271193-1-alex.bennee@linaro.org>
References: <20250109170619.2271193-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x630.google.com
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

All of the failures to configure devices will result in QEMU exiting
with an error code. In preparation for passing Error * down the chain
re-name the iterator to foreach_device_config_or_exit and exit using
&error_fatal instead of returning a failure indication.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 system/vl.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/system/vl.c b/system/vl.c
index 0843b7ab49..25d9968ccc 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1307,7 +1307,14 @@ static void add_device_config(int type, const char *cmdline)
     QTAILQ_INSERT_TAIL(&device_configs, conf, next);
 }
 
-static int foreach_device_config(int type, int (*func)(const char *cmdline))
+/**
+ * foreach_device_config_or_exit(): process per-device configs
+ * @type: device_config type
+ * @func: device specific config function, returning pass/fail
+ *
+ * Any failure is fatal and we exit with an error message.
+ */
+static void foreach_device_config_or_exit(int type, int (*func)(const char *cmdline))
 {
     struct device_config *conf;
     int rc;
@@ -1319,10 +1326,10 @@ static int foreach_device_config(int type, int (*func)(const char *cmdline))
         rc = func(conf->cmdline);
         loc_pop(&conf->loc);
         if (rc) {
-            return rc;
+            error_setg(&error_fatal, "failed to configure: %s", conf->cmdline);
+            exit(1);
         }
     }
-    return 0;
 }
 
 static void qemu_disable_default_devices(void)
@@ -2044,12 +2051,9 @@ static void qemu_create_late_backends(void)
     qemu_opts_foreach(qemu_find_opts("mon"),
                       mon_init_func, NULL, &error_fatal);
 
-    if (foreach_device_config(DEV_SERIAL, serial_parse) < 0)
-        exit(1);
-    if (foreach_device_config(DEV_PARALLEL, parallel_parse) < 0)
-        exit(1);
-    if (foreach_device_config(DEV_DEBUGCON, debugcon_parse) < 0)
-        exit(1);
+    foreach_device_config_or_exit(DEV_SERIAL, serial_parse);
+    foreach_device_config_or_exit(DEV_PARALLEL, parallel_parse);
+    foreach_device_config_or_exit(DEV_DEBUGCON, debugcon_parse);
 
     /* now chardevs have been created we may have semihosting to connect */
     qemu_semihosting_chardev_init();
@@ -2670,8 +2674,7 @@ static void qemu_create_cli_devices(void)
 
     /* init USB devices */
     if (machine_usb(current_machine)) {
-        if (foreach_device_config(DEV_USB, usb_parse) < 0)
-            exit(1);
+        foreach_device_config_or_exit(DEV_USB, usb_parse);
     }
 
     /* init generic devices */
@@ -2718,10 +2721,8 @@ static bool qemu_machine_creation_done(Error **errp)
         exit(1);
     }
 
-    if (foreach_device_config(DEV_GDB, gdbserver_start) < 0) {
-        error_setg(errp, "could not start gdbserver");
-        return false;
-    }
+    foreach_device_config_or_exit(DEV_GDB, gdbserver_start);
+
     if (!vga_interface_created && !default_vga &&
         vga_interface_type != VGA_NONE) {
         warn_report("A -vga option was passed but this machine "
-- 
2.39.5


