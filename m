Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68A27C41513
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 20:42:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP6nm-0006Rl-P5; Wed, 03 Jul 2024 16:42:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sP6nl-0006R1-E3
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 16:42:05 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sP6nj-00049B-J8
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 16:42:05 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2c8c6cc53c7so4052635a91.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 13:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1720039321; x=1720644121; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HzCi6fZiLkpynqwuxhQ2truwKbzSufAiF10zMorZH6c=;
 b=FylIp/lRejks5WUoOu7boS+ZjNzPDQ308MdmohKD0GuSLND5H1p6VtvT7zsYgfaMs4
 pxU9Chd7sSzoCUlUF27bk3ESl4DpUVkZUfHxQe7zC32+W8rf2N74b8i417usV77F2b1B
 z6D0Watwc1DePSOS+hvStmZCO8V7flxAdxtB8BVUsegdwCOfXZULTIx+Oj3uLSXNI/9i
 n9bUOOCz0HDk99iiHTKWjDqW+ykBWklwoo7sDi4caoZEWlvLHDp6dMF/k8YFCYQRJECp
 75IEcBNMHaZyDGoGuto1OmB7YikSge78c23KfpVO6+OmwOPGhWo8MLIz6PsFdE3AayP2
 4sKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720039321; x=1720644121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HzCi6fZiLkpynqwuxhQ2truwKbzSufAiF10zMorZH6c=;
 b=IaW7f7izXSt+6/YsB/ngX9WUlEimeHkUOii67HGdKj99Isekv2HWoj5Acu3YySSpDd
 JSc8Adbh8hpYqCY3zGeTPau2apfjn/IsNUzyQ7SmjktYEtr9M2eIUAS389E4qE5y4imt
 YM1cAxjCfNbBuBIpJuzRdt+wys/EpBDywdf1cNbheL9jUqpIlmuRe3j055LGYdhQMs3I
 cygO+1sQNL23NWX7FPe6fThX6kGB9yKOEWG4HJD4SOgwSmT3hSDjcy2M/ZQAVIQq5Sd4
 pzZLq6S7WQdyvnbKVnq90xF068t/skrvljhBo9Q10Nzq2iTg8vjibjR+vpSucGbTHVVA
 gNAQ==
X-Gm-Message-State: AOJu0Yyc9ca21STEXC5j3tnTl68b0aqr3zWeJyrv4vebBFpINHCxSWy2
 THAYP9jT2aX1o+gBh36xq/ysSUA26hKUkxa/wxOUW7NxHNyAfZ5jNgIdPl/J1Zy+hzbY8l8Wsn/
 Y
X-Google-Smtp-Source: AGHT+IGg+ob4Fhj2MH/KBWS65kKLGVthgeNn5xU4WmYEZgsIwQL7v2XZV7bufOC9DBgawi+t2QzCpQ==
X-Received: by 2002:a17:90a:6388:b0:2c8:716f:b46e with SMTP id
 98e67ed59e1d1-2c93d704341mr9851484a91.16.1720039321139; 
 Wed, 03 Jul 2024 13:42:01 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([179.193.8.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c91ce42667sm11284888a91.16.2024.07.03.13.41.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 13:42:00 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, berrange@redhat.com,
 eduardo@habkost.net, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v2 2/2] qom/object, accel-system: add support to Accel globals
Date: Wed,  3 Jul 2024 17:41:49 -0300
Message-ID: <20240703204149.1957136-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703204149.1957136-1-dbarboza@ventanamicro.com>
References: <20240703204149.1957136-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x102e.google.com
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

This is done by calling object_prop_set_globals() in
accel_init_machine(). As done in device_post_init(), user's global
props take precedence over compat props so object_prop_set_globals() is
called after object_set_accelerator_compat_props().

object_prop_check_globals() is then changed to recognize TYPE_ACCEL
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
 accel/accel-system.c |  2 ++
 qom/object.c         | 34 +++++++++++++++++++++++-----------
 2 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/accel/accel-system.c b/accel/accel-system.c
index f6c947dd82..8cb1eaa907 100644
--- a/accel/accel-system.c
+++ b/accel/accel-system.c
@@ -29,6 +29,7 @@
 #include "sysemu/cpus.h"
 #include "qemu/error-report.h"
 #include "accel-system.h"
+#include "qapi/error.h"
 
 int accel_init_machine(AccelState *accel, MachineState *ms)
 {
@@ -43,6 +44,7 @@ int accel_init_machine(AccelState *accel, MachineState *ms)
         object_unref(OBJECT(accel));
     } else {
         object_set_accelerator_compat_props(acc->compat_props);
+        object_prop_set_globals(OBJECT(accel), &error_fatal);
     }
     return ret;
 }
diff --git a/qom/object.c b/qom/object.c
index 60dbd00edd..8730e770e6 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -15,6 +15,7 @@
 #include "qapi/error.h"
 #include "qom/object.h"
 #include "qom/object_interfaces.h"
+#include "qemu/accel.h"
 #include "qemu/cutils.h"
 #include "qemu/memalign.h"
 #include "qapi/visitor.h"
@@ -516,27 +517,38 @@ int object_prop_check_globals(void)
 
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


