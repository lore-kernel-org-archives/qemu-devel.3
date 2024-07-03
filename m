Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C4BDC2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 09:47:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOwZY-0004Hz-EU; Wed, 03 Jul 2024 05:46:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sOwZW-0004HB-5n
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 05:46:42 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sOwZU-0003fB-3g
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 05:46:41 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2c98660fc91so34116a91.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 02:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1719999998; x=1720604798; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T0cvegh9dJHLx7AZgX8kwOuw/aZvQuYKLzTnaKSvZwM=;
 b=kOrx2kfPWde9ANQOJNVx9gkcYM0yrS6pS2v8ZLOG7LtTHPlMeC19sAa4G8wo4rfUlr
 fvKHKoasK8wSZOnH/mjTJ/QBzrVTava5g8j6av+o+1cZA8cygtrUTtnAQdZLTIT2jzGQ
 DlmQTWu09euo6x+D4Cll2Jrnj41O4rQg3ug4v/4OdWz1cjoMGZT5AFQYckGLbG0tnK5K
 YA+86eikhOUwqtqdjF36WamuCI82INXTGcRivTWeQFR9UtvBp3gxzqj2EC7QTLHuwfC5
 IMC/EPzQ9HxMM67/XklcMAAMDKuG+Zk+Az5A0YW0kOllFdXwi4jB9irR7C9vVo6Y0ufl
 hpyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719999998; x=1720604798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T0cvegh9dJHLx7AZgX8kwOuw/aZvQuYKLzTnaKSvZwM=;
 b=Uls24beaFYv1goBkvQVFElTm0/FSxaCzVizKYi5Vc1X/KsS5c6TYGrCv0WI97km7Cn
 s+Kd99wxlpJIoRI/4lRZtioqWQ78dx/kDJwBa0pwZgOb4Www7yE2L4Vqbrhxpvs8rwSq
 yxHSw44/O+pJk2xp8OPZHcvn9t9vD44Yp+wmSmWdX5rzAKI44xefAoXr+lhmzOzexXSf
 j2qptAY/UaBmRJ0mmG0vuV0zeImdPel1+sjRryB740wtACe6n3p/h2Vgt8FKy/TdDwrJ
 myeEXlU+1OIWkhJdgZnzrUtK67e67tPIcNZgBrjAUz8tXWkSc1bSLHM5kNJpssUs6juw
 9T8w==
X-Gm-Message-State: AOJu0YyLMMrWuV7gWrLs+L7aesMXhIbgN8ZTUWK0vx80W8+1fdCzViaG
 abXCaDiM9qlvWXHlSGhgNfql1bRfGFeC8yuKKDWIM8M5aGjQnCujC5F/iOL/Alfo6tBgKF8Xd2D
 k
X-Google-Smtp-Source: AGHT+IE3Hkwyh7IHQSR/56ceTw6IWQ8MUUwpxAvahjzBiGrJF3h/E7CD1jO63XIATv6xAu9TkuHytQ==
X-Received: by 2002:a17:90b:1fcf:b0:2c8:b576:2b7e with SMTP id
 98e67ed59e1d1-2c93d771fa4mr6266340a91.46.1719999997903; 
 Wed, 03 Jul 2024 02:46:37 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([179.193.8.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c91d3bc5a1sm10278621a91.36.2024.07.03.02.46.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 02:46:37 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, berrange@redhat.com,
 eduardo@habkost.net, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH 2/2] qdev, accel-system: add support to Accel globals
Date: Wed,  3 Jul 2024 06:46:26 -0300
Message-ID: <20240703094626.1704990-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703094626.1704990-1-dbarboza@ventanamicro.com>
References: <20240703094626.1704990-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x1036.google.com
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

We're not honouring KVM options that are provided by any -accel option
aside from the first. In this example:

qemu-system-riscv64 -accel kvm,riscv-aia=emul (...) \
    -accel kvm,riscv-aia=hwaccel

'riscv-aia' will be set to 'emul', ignoring the last occurrence of the
option that set 'riscv-aia' to 'hwaccel'.

A failed attempt to solve this issue by setting 'merge_lists' can be
found in [1]. A different approach was suggested in [2]: enable global
properties for accelerators. This allows an user to override any accel
setting by using '-global' and we won't need to change how '-accel' opts
are handled.

This is done by calling qdev_prop_set_globals() in accel_init_machine().
As done in device_post_init(), user's global props take precedence over
compat props so qdev_prop_set_globals() is called after
object_set_accelerator_compat_props().

qdev_prop_check_globals() is then changed to recognize TYPE_ACCEL
globals as valid.

Re-using the fore-mentioned example we'll be able to set
riscv-aia=hwaccel by doing the following:

qemu-system-riscv64 -accel kvm,riscv-aia=emul (...) \
    -global kvm-accel.riscv-aia=hwaccel

[1] https://lore.kernel.org/qemu-devel/20240701133038.1489043-1-dbarboza@ventanamicro.com/
[2] https://lore.kernel.org/qemu-devel/CABgObfbVJkCdpHV2uA7LGTbYEaoaizrbeG0vNo_T1ua5b=jq7Q@mail.gmail.com/

Reported-by: Andrew Jones <ajones@ventanamicro.com>
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 accel/accel-system.c      |  3 +++
 hw/core/qdev-properties.c | 34 +++++++++++++++++++++++-----------
 2 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/accel/accel-system.c b/accel/accel-system.c
index f6c947dd82..40c73ec62f 100644
--- a/accel/accel-system.c
+++ b/accel/accel-system.c
@@ -29,6 +29,8 @@
 #include "sysemu/cpus.h"
 #include "qemu/error-report.h"
 #include "accel-system.h"
+#include "qapi/error.h"
+#include "hw/qdev-properties.h"
 
 int accel_init_machine(AccelState *accel, MachineState *ms)
 {
@@ -43,6 +45,7 @@ int accel_init_machine(AccelState *accel, MachineState *ms)
         object_unref(OBJECT(accel));
     } else {
         object_set_accelerator_compat_props(acc->compat_props);
+        qdev_prop_set_globals(OBJECT(accel), &error_fatal);
     }
     return ret;
 }
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 4867d7dd9e..462a8f96e0 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -10,6 +10,7 @@
 #include "qemu/cutils.h"
 #include "qdev-prop-internal.h"
 #include "qom/qom-qobject.h"
+#include "qemu/accel.h"
 
 void qdev_prop_set_after_realize(DeviceState *dev, const char *name,
                                   Error **errp)
@@ -894,27 +895,38 @@ int qdev_prop_check_globals(void)
 
     for (i = 0; i < global_props()->len; i++) {
         GlobalProperty *prop;
-        ObjectClass *oc;
+        ObjectClass *globalc, *oc;
         DeviceClass *dc;
 
         prop = g_ptr_array_index(global_props(), i);
         if (prop->used) {
             continue;
         }
-        oc = object_class_by_name(prop->driver);
-        oc = object_class_dynamic_cast(oc, TYPE_DEVICE);
-        if (!oc) {
-            warn_report("global %s.%s has invalid class name",
-                        prop->driver, prop->property);
-            ret = 1;
+        globalc = object_class_by_name(prop->driver);
+        oc = object_class_dynamic_cast(globalc, TYPE_DEVICE);
+        if (oc) {
+            dc = DEVICE_CLASS(oc);
+            if (!dc->hotpluggable && !prop->used) {
+                warn_report("global %s.%s=%s not used",
+                            prop->driver, prop->property, prop->value);
+                ret = 1;
+            }
             continue;
         }
-        dc = DEVICE_CLASS(oc);
-        if (!dc->hotpluggable && !prop->used) {
+
+        /*
+         * At this point is either an accelerator global that is
+         * unused or an invalid global. Both set ret = 1.
+         */
+        ret = 1;
+
+        oc = object_class_dynamic_cast(globalc, TYPE_ACCEL);
+        if (oc) {
             warn_report("global %s.%s=%s not used",
                         prop->driver, prop->property, prop->value);
-            ret = 1;
-            continue;
+        } else {
+            warn_report("global %s.%s has invalid class name",
+                        prop->driver, prop->property);
         }
     }
     return ret;
-- 
2.45.2


