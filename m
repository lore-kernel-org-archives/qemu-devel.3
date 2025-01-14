Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDBE6E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 11:39:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXfFf-00056C-Jk; Tue, 14 Jan 2025 06:38:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXfFd-00055E-Hr
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:38:29 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXfFb-0005PC-Rc
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:38:29 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5d90a5581fcso9127822a12.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 03:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736854706; x=1737459506; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=acFhJ3tFQm8tIYCY6Z3d4lTsupXAHuvOYJbU2nvujpY=;
 b=X4uD7h1fq/abbI1k+9JGfjx2D6tP67q+quCrV12byiXQ93Eou75ENGH3vX66eSepDF
 a1sD44Yfpjs7WQSxdst7UfdfilvJO+kZkMUuhW8DWWvvgUaGuo4WvDXw6L+Sl+yhmFMj
 xcv/XrLude483AiOi1fU84tm/dUI5m9d57hY6rmzQiHAJtTLnskntnTXogJJ4UwjqJnr
 6re81kahnO66bsyztFxu0smQV9n2Wj2TUl+8O1dTYeipJ3tfaaULJUsViftdHGjrjnhs
 PObSBPPx6RSkvEWRvIypjYHmRAHfbL3R3Cf3a5uS2cQ2UpzqZj8XoyXW3OjgUk4+Qrnb
 FHkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736854706; x=1737459506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=acFhJ3tFQm8tIYCY6Z3d4lTsupXAHuvOYJbU2nvujpY=;
 b=PmneoYlAks0BwXZrUPO1LWqN/I9GmrYmApQeEGTkBPKC68j/yUCaaAcD1zg8WyYx4z
 wGvSYMmOZ3uW+96H3QClWiGons7VZmTUTGx1jWp/W1hoNhTjjo0+VP7HU6u+zHLA5XCG
 Pl/agUW8gIRvKEqp0dDTSs7YofhpcyrXkS+b1jgnQfOwnbY8tqSZLcumthROAgnk6tEf
 /N6SxkLvrniRKeoxtnixCdP5m8xDPeC4RjOa+a/yzXEo8/B7jlMAvgVLLlLbbVXDfPzY
 nvd096G3jtryC7J87seuDgq04qc8F4LnQyQKq+OkEDyAU6qPis+Rr+L2R7qHtkFhxbw6
 5SdQ==
X-Gm-Message-State: AOJu0YytMXWT4YHmvoqAJYKLtmtbg09izGc1NzroF7q4q8XcCykeXe/b
 T+y05gdC1hIauqAsdZ27gEgks9zGfmE2QnMF4DbJNdpnjVhJC44p9YK5XtkjKrc=
X-Gm-Gg: ASbGnctRNeEkT4Xb/6KQj60htGGoRVvSZSBggvu4u9oFwvLYfdxuEDZYYDEAOmE36rV
 CD62w+52emmM2q0hW3rWYb2zEksJ0uy3GcdmXhm2T8RncoBUJWHhxKe9yrQ9v3MvXOxh/kSMgUB
 Cukksc1PhTjRw3qbBbJtSIe42gXvDj8hZ3PgN3uOy0e0GrSZIxjl0gCkS8HJpPF0CgktW4fC+NP
 IJoFVuaFnj9emi3W/mQ4GzjOjpNz4+xfuwQTrQn8FYvGhCuefL7wcc=
X-Google-Smtp-Source: AGHT+IFwr32JoqTQVdV3V41OUE/8gz//KOdU1cyXJOWda0AfQpjR9p0hylm10ivAoKDwQ51rzzH67g==
X-Received: by 2002:a05:6402:35d4:b0:5cf:e218:984f with SMTP id
 4fb4d7f45d1cf-5d972e4e6d1mr21820742a12.27.1736854706310; 
 Tue, 14 Jan 2025 03:38:26 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d99046d822sm5864624a12.56.2025.01.14.03.38.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 03:38:24 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7EE785F94C;
 Tue, 14 Jan 2025 11:38:22 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 08/37] system/vl: more error exit into config enumeration
 code
Date: Tue, 14 Jan 2025 11:37:52 +0000
Message-Id: <20250114113821.768750-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250114113821.768750-1-alex.bennee@linaro.org>
References: <20250114113821.768750-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x532.google.com
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

Message-Id: <20250109170619.2271193-9-alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/vl.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/system/vl.c b/system/vl.c
index be029c52ef..7e3e6fb353 100644
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
@@ -2667,8 +2671,7 @@ static void qemu_create_cli_devices(void)
 
     /* init USB devices */
     if (machine_usb(current_machine)) {
-        if (foreach_device_config(DEV_USB, usb_parse) < 0)
-            exit(1);
+        foreach_device_config_or_exit(DEV_USB, usb_parse);
     }
 
     /* init generic devices */
@@ -2715,10 +2718,8 @@ static bool qemu_machine_creation_done(Error **errp)
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


