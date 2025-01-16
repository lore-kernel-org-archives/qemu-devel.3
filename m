Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE03C02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 16:11:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYSLn-0004FH-7u; Thu, 16 Jan 2025 11:04:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYSL6-0003Wh-MW
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:03:29 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYSKy-0001GA-1x
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:03:23 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4364a37a1d7so10412425e9.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 08:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737043394; x=1737648194; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W+FezEXpyW2Kwr3H0HaqemTH3nJWuwesjRNair6bvmQ=;
 b=YmpAE9BOL6OTCQDHiE/y9aysA8+UCDMTqVxzXTdHZLdZ+oDOL4SPY/aJwYPbTMEf5S
 2JalkiOHTs5U1Ku05SySnQ0C24Zu3z8m8bvUgLZwI44P9KT0Uh7l4l7RjAv0J5IY02JE
 4iayOQPSBDN9/wELpe5FXuzZDdhb9jYQeiKSpnoVE947bIgClOjmeW3N8OhRDq9aQXcc
 S6+m6NdAF15W7zseq/0SyGPkZ5tCbjrWMbyCI71aisskStFF+K8pcBbVqZ9omIimcFEu
 mqQf+p8Nwe3RdzI+dXeUc5M84EWm3YpgDa1XV3I+vc0ih2Q/u6vVMfCldvTDlunINsNb
 2eDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737043394; x=1737648194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W+FezEXpyW2Kwr3H0HaqemTH3nJWuwesjRNair6bvmQ=;
 b=bGZVzmwJ3X/a6b0MAJWSPJzG7L4FCWtWJiobLjInDq7iho2l92BziColsYRc1aTxkg
 8E7rGfPAcRXHeU+QcJ707Xg+dwIC93KfI13ij7JIrmzhjjM2JBFeOwrC9axonITLu0iJ
 ggLkyohOP5CcUrpsJ/kYCrtiCG1Dat/C1FwH1ZVyUn22MAFIOTTrvNe2lk21iUS+ILFo
 1qBAOAUQ4KQvjssdEg2PJoRbJOGFMlDF1Mib9hKAgarwry6QDlhqlAj+VkbpZOSD81G/
 sH4LWyT7LtbYfgFWEJI2z/6E3nCh3v12lLvxHCJ1dwscESwmjq5jeb+FTUk5dJQoFzOL
 aQbA==
X-Gm-Message-State: AOJu0YwbTFqzx9OPlJKgbEHRou/TTLb0HQkMZDa1ognzyM9l5yykJUZ5
 q1NuqQuCCzVl/ci8BkqOdYMF10B40xBsnImkm90N1/XnkUUT0SLzry0btxN+qsE=
X-Gm-Gg: ASbGncsQ6m36K39lR/f9uRWv2zXiCDk/qYfpP9Bsi/ucxYUVXqSwIs1AIiU3Q+T+QeN
 NOegzA5UbnkW6lw9ozwhHKQnINJOnwX60LFR9yUu9doX4MhtP7WbeYi6RXVkhpdbEqxHkY6Skh0
 6bmmA+nf2jqTD0D/WqPeEakRmrDjkMfKtNp77tIiHCWk5XNc+7yIV/ZbaIf6+CvmWfxMGrw8aMo
 w8KySdyUKEQntsFXFXfw9rRI8x20F2MbZTkNq8yrIJ4AQ4AZfllx14=
X-Google-Smtp-Source: AGHT+IEhiSK24tQserDcU3SAPgGkzdzaLaYvz+WCe0aIdmcmOZmnK7slAQ1ruQ3GuDz3wsCMzPZ0eA==
X-Received: by 2002:a05:6000:1a8a:b0:386:1cd3:8a07 with SMTP id
 ffacd0b85a97d-38a872fc363mr28367101f8f.7.1737043393988; 
 Thu, 16 Jan 2025 08:03:13 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c752910esm65449005e9.28.2025.01.16.08.03.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 08:03:10 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2E62060866;
 Thu, 16 Jan 2025 16:03:07 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Jason Wang <jasowang@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, Stefano Garzarella <sgarzare@redhat.com>,
 qemu-arm@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, David Hildenbrand <david@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Alexandre Iooss <erdnaxe@crans.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 08/37] system/vl: more error exit into config enumeration
 code
Date: Thu, 16 Jan 2025 16:02:37 +0000
Message-Id: <20250116160306.1709518-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250116160306.1709518-1-alex.bennee@linaro.org>
References: <20250116160306.1709518-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
v3
  - split overly long line
---
 system/vl.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

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


