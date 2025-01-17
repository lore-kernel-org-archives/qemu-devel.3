Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 976B2C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 13:44:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYmdL-0001EP-Hr; Fri, 17 Jan 2025 08:43:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmcv-0000yR-Lj
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:43:10 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmcq-0002DL-9m
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:43:09 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-aa67ac42819so328474866b.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 05:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737121382; x=1737726182; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HMQ58Acbctk4+YTi9iqzJht+eWjui8AFJynO1iL5Mfg=;
 b=l+aJ8gVuW8CAE5GSMBQTjcjALr+Bc3agYqL8WCYxI6HXrLM8sSkrReUEKaAhhj+chd
 o5AyAkjZyHOfa9ZiWIx4mcuhZbUx+W17F7igYP9819pdjBKKN1KplfMWm5AOXYIKGQnC
 cQEcDtYGcUBwAyp88zoB2FuhjMgRk4B5fDCrg3vSE8zfyXgB58TnAySyztPCOozdPnS9
 e07qYQEyMnqMPDGlNHAcnpBDXn4NKjsckNQp16EUFDYqnxjE2Oi5QDkaTXbIEKhqQTMH
 co924p7hjdwpAUGXWG6dQkYDNwszHfDsA8MMTPXeNSeJFjicdTFfZUZeEvuiODnYhjC8
 lyKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737121382; x=1737726182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HMQ58Acbctk4+YTi9iqzJht+eWjui8AFJynO1iL5Mfg=;
 b=WlInPNj/x/EoOiZQ76s4AFRRqTj9oybux7GDmz5MsMXTlOC9/rE+XBG7AsxugGlZaQ
 N7iI7Fc3NYWo2d/tQ7w2yDX+nSJmekEMcQe1pPCudg52B1epClbTQK0Jl4mrZ4sEHOLl
 FbiVuv3EhA4Fj/qj4H3gjlfBLKLANbAje7FkJNosVWAYE/kI0ANEfEWt4cR5AqtspcXX
 H1WvguqlVdXCZ9Tn0B4YEgFpqIFwLlMs6Wj32L1cOpeWm7c68EgPT0lny9ZlYZ+H57Dh
 tE0oyRBlJpr/TfAn0GhQ5BQJEgvjehd4NLWfqg2w8lQ7ABVlP3u5bUH2C+GMjxj7ejSp
 3kUw==
X-Gm-Message-State: AOJu0YyBQRcs92kWqygl9o3wqykVirBJ8eoQgRch9DMVWuz3yArZDa+3
 8yDtIQ0bfriZkRNj21E0VaIEY/X7Wr3qMcXye/bABtdmUnZgohVR767xaEYLkwA=
X-Gm-Gg: ASbGnctvl+aTdYidyHCjYpO+bcEkxV83lzWf6Fr+q9j1HitqiH1KlQNQlQSN1+N3TuQ
 My1XoRRbTsOPlwAFYQUZ5KZ8O+RzN6R9L5XQpGe/KCRKBAUxevt/Q4uaVpw7rT7pvvOUh0C6v52
 PVJUTdTYNo2HJMliSYwBjjCMBOWdiKZOTRwzXdqv4gJX9CRPlntqVLq3iTlq2unQUq4K2549WNR
 l0ALKpzoVY2P9Qe+8qJxv99QSgqf7CvqHa6OkJ5Utw8gmrhOFYGTVE=
X-Google-Smtp-Source: AGHT+IGEm1FpSAymfJQwJVLxxPS047LGoXIZhmVZGh9Tm+6w6ppZN6+f0ty5Eyv7IB5iSbAf0EJwQA==
X-Received: by 2002:a17:907:8691:b0:aa6:7470:8efe with SMTP id
 a640c23a62f3a-ab38b10cf47mr233120366b.13.1737121382318; 
 Fri, 17 Jan 2025 05:43:02 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384c5c47bsm174136766b.16.2025.01.17.05.42.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 05:43:00 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9F3976086F;
 Fri, 17 Jan 2025 13:42:57 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 08/37] system/vl: more error exit into config enumeration code
Date: Fri, 17 Jan 2025 13:42:27 +0000
Message-Id: <20250117134256.2079356-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250117134256.2079356-1-alex.bennee@linaro.org>
References: <20250117134256.2079356-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x636.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250116160306.1709518-9-alex.bennee@linaro.org>

diff --git a/system/vl.c b/system/vl.c
index be029c52ef..22c1444da4 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1307,7 +1307,15 @@ static void add_device_config(int type, const char *cmdline)
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
+static void foreach_device_config_or_exit(int type,
+                                          int (*func)(const char *cmdline))
 {
     struct device_config *conf;
     int rc;
@@ -1319,10 +1327,10 @@ static int foreach_device_config(int type, int (*func)(const char *cmdline))
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
@@ -2044,12 +2052,9 @@ static void qemu_create_late_backends(void)
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
@@ -2667,8 +2672,7 @@ static void qemu_create_cli_devices(void)
 
     /* init USB devices */
     if (machine_usb(current_machine)) {
-        if (foreach_device_config(DEV_USB, usb_parse) < 0)
-            exit(1);
+        foreach_device_config_or_exit(DEV_USB, usb_parse);
     }
 
     /* init generic devices */
@@ -2715,10 +2719,8 @@ static bool qemu_machine_creation_done(Error **errp)
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


