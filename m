Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D32AFA1FEF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 20:03:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFdlM-00030V-3m; Wed, 22 Apr 2026 16:01:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdlA-0002hD-7v
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 16:01:21 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdl7-0002Ea-Ju
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 16:01:19 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488d2079582so69032995e9.2
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 13:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776888075; x=1777492875; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=y+UskPhN+mbciYewNeSZkuqlp20BuSuZzVlCKsLWNmQ=;
 b=DUf6by8pyEWUuKJ8NZK02nHux9dWaTg/u2BInlqKpVihAuA5eL9go0yVnnc7SuMu9x
 zksLuQj5iX0Jvgfy+UzaZOsZy7OsbwRKEVtQoMDmLzkOq3mG8XMn77FPFmvSH3lP7j03
 WT45SB7LvsJ9bcehoBPOv+dWretoe2YVqeh2dS7AQCqOwydwy4TiPChr6getDRuHduAs
 ZgNGCatzEHLtRpZNioGQ/XdKORzfKF4EdJ51Dopx6E/tR4XjL0mfBcfZj5ueheaLFu12
 KwetuO5J3PVzEKRwR1DbChLKfmgkR2CavD1o68nxAM8F02q9ccHqPSdhQXYfGielru7H
 i43w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776888075; x=1777492875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=y+UskPhN+mbciYewNeSZkuqlp20BuSuZzVlCKsLWNmQ=;
 b=o+LM+tyETxDeAaMPZXDLehTHiuSI26egrgb3oczt7Z+FmScWvbrgvwMC8UvLGXYL9o
 ON7gw1p2T1kMXRMg6uH+gZ6nVHM5bwyvWwae2VU2q5C0H+FCST980/12Ky5Gs2Ip/lCF
 UVJ0xZuZ641kjtuJegYcv48I2TS10+QPuAzmKc80u9IjGwSKH+YxVgOc2k9mqaTeClkH
 WWqrB4Loa5fF2WyHPs8DQM5AkwPsMVFKy6dIxL7nKFK0dyZTig2kW1aefkPebfdWTpLR
 +/itFDcqNSRqS7tSJc5E2m6VKKfrCBqh3x/vQyKTZHNVCk05h1v+VMAAK+mSkymOp13D
 zeBQ==
X-Gm-Message-State: AOJu0YzjLMA2zTczHyJ8h7KCwqqvxqPuMXitkW2b7fRse/BsKPG+rYAB
 0Ir1DwZazT0Fzx5yyGFKEIfM4alY2IFUSiHdOJ1ANk74vdpMrwUnNVl+VHFXepm2If+6hpIKWbx
 C5KMyiD8=
X-Gm-Gg: AeBDiesUTRLuOPkLF1yWsSqdveMAdkVoiEY/Jz/rgmVndIMlCkfM1+Cq2C5/lMQYtp+
 90gC5RWkyVDSK657OcjmvV5gYnSW/xyBELjj3gtjLPojTmP6amN9lKPXdT7zMfUAtlz9YxpyIZV
 dYp5mRQdnIcs8wybpz4xaDuOlCASfVG3I3R8I4g19hFLfkxGfRuWDMwM5j5BSJFIWR77BNczrlZ
 /3PetYxCpruq0Zz5jx3jdxXQpoWWxT4R60zWVtPKuUJHQZQ2ZGyyNoFlnEvgve5TgwxHrmgpmzv
 ANjvc4KRc8Uzr/fB9N307faOyMrSSbKcusIU2S7w+DDuZ9x4UmCjP1PCRjG0MNwzQBTEmgAmf0x
 qmDy71em/ZHeDf+hkOp3+/vffElhk0qOv8ivwJMqpa/qolNCOh4lKOhf79NZyehT0h3U4wyphGl
 k3jBvGwdJZ4lYEd2LEH/Z6npLhoGb1ZDRUVfhXlgKAYioqc8RQ3P7+2r0C/GSO1EezCHUAqkniz
 l0ZUgfXdWM=
X-Received: by 2002:a05:600c:1f83:b0:488:8840:e5ae with SMTP id
 5b1f17b1804b1-488fb787afemr338426545e9.24.1776888074792; 
 Wed, 22 Apr 2026 13:01:14 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a5c4b9e8dsm14480325e9.7.2026.04.22.13.01.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Apr 2026 13:01:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/48] qom: Declare compat properties API in
 'qom/compat-properties.h'
Date: Wed, 22 Apr 2026 21:57:27 +0200
Message-ID: <20260422195746.88865-30-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422195746.88865-1-philmd@linaro.org>
References: <20260422195746.88865-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

While most of QEMU files use the QOM concept, few of them
use the compatibility properties API (mostly use in system
emulation). Move its prototype to a new "qom/compat-properties.h"
header, keeping "qom/object.h" for generic QOM.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Message-Id: <20260325151728.45378-5-philmd@linaro.org>
---
 include/qom/compat-properties.h | 8 ++++++++
 include/qom/object.h            | 8 --------
 accel/accel-system.c            | 1 +
 backends/hostmem.c              | 1 +
 hw/core/machine.c               | 1 +
 hw/core/qdev-properties.c       | 1 +
 hw/core/qdev.c                  | 1 +
 hw/i386/pc_q35.c                | 1 +
 system/rtc.c                    | 1 +
 system/vl.c                     | 1 +
 target/i386/sev.c               | 1 +
 ui/vdagent.c                    | 1 +
 rust/bindings/qom-sys/lib.rs    | 2 +-
 13 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/include/qom/compat-properties.h b/include/qom/compat-properties.h
index 6e44aabc26b..90f8320adfd 100644
--- a/include/qom/compat-properties.h
+++ b/include/qom/compat-properties.h
@@ -29,4 +29,12 @@ typedef struct GlobalProperty {
     bool optional;
 } GlobalProperty;
 
+void object_set_machine_compat_props(GPtrArray *compat_props);
+void object_set_accelerator_compat_props(GPtrArray *compat_props);
+void object_register_sugar_prop(const char *driver, const char *prop,
+                                const char *value, bool optional);
+void object_apply_compat_props(Object *obj);
+bool object_apply_global_props(Object *obj, const GPtrArray *props,
+                               Error **errp);
+
 #endif
diff --git a/include/qom/object.h b/include/qom/object.h
index 26df6137b91..510885218ba 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -700,14 +700,6 @@ Object *object_new_with_propv(const char *typename,
                               Error **errp,
                               va_list vargs);
 
-bool object_apply_global_props(Object *obj, const GPtrArray *props,
-                               Error **errp);
-void object_set_machine_compat_props(GPtrArray *compat_props);
-void object_set_accelerator_compat_props(GPtrArray *compat_props);
-void object_register_sugar_prop(const char *driver, const char *prop,
-                                const char *value, bool optional);
-void object_apply_compat_props(Object *obj);
-
 /**
  * object_set_props:
  * @obj: the object instance to set properties on
diff --git a/accel/accel-system.c b/accel/accel-system.c
index 150af05bf5b..9176665202d 100644
--- a/accel/accel-system.c
+++ b/accel/accel-system.c
@@ -25,6 +25,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/accel.h"
+#include "qom/compat-properties.h"
 #include "qapi/qapi-commands-accelerator.h"
 #include "monitor/monitor.h"
 #include "hw/core/boards.h"
diff --git a/backends/hostmem.c b/backends/hostmem.c
index 15d4365b697..cd2085fb3cd 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -18,6 +18,7 @@
 #include "qapi/qapi-builtin-visit.h"
 #include "qapi/visitor.h"
 #include "qemu/config-file.h"
+#include "qom/compat-properties.h"
 #include "qom/object_interfaces.h"
 #include "qemu/mmap-alloc.h"
 #include "qemu/madvise.h"
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 0aa77a57e95..cba50310948 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -21,6 +21,7 @@
 #include "qapi/qapi-visit-machine.h"
 #include "qapi/qapi-commands-machine.h"
 #include "qemu/madvise.h"
+#include "qom/compat-properties.h"
 #include "qom/object_interfaces.h"
 #include "system/cpus.h"
 #include "system/system.h"
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index ba8461e9a42..73539c727b3 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -10,6 +10,7 @@
 #include "qemu/units.h"
 #include "qemu/cutils.h"
 #include "qdev-prop-internal.h"
+#include "qom/compat-properties.h"
 #include "qom/qom-qobject.h"
 
 void qdev_prop_set_after_realize(DeviceState *dev, const char *name,
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index e48616b2c6f..b36101f3a75 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -32,6 +32,7 @@
 #include "qapi/visitor.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
+#include "qom/compat-properties.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/boards.h"
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index cb23322f5a4..6a0967ecd18 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -56,6 +56,7 @@
 #include "hw/usb/hcd-uhci.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "qom/compat-properties.h"
 #include "system/numa.h"
 #include "hw/hyperv/vmbus-bridge.h"
 #include "hw/mem/nvdimm.h"
diff --git a/system/rtc.c b/system/rtc.c
index 56951288c40..f13dd392a76 100644
--- a/system/rtc.c
+++ b/system/rtc.c
@@ -28,6 +28,7 @@
 #include "qemu/error-report.h"
 #include "qemu/option.h"
 #include "qemu/timer.h"
+#include "qom/compat-properties.h"
 #include "qom/object.h"
 #include "system/replay.h"
 #include "system/system.h"
diff --git a/system/vl.c b/system/vl.c
index 246623b3196..0e1fc217b4f 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -119,6 +119,7 @@
 #include "qapi/string-input-visitor.h"
 #include "qapi/opts-visitor.h"
 #include "qapi/clone-visitor.h"
+#include "qom/compat-properties.h"
 #include "qom/object_interfaces.h"
 #include "semihosting/semihost.h"
 #include "crypto/init.h"
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 9dde972c118..261b6aaa37b 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -36,6 +36,7 @@
 #include "system/reset.h"
 #include "trace.h"
 #include "migration/blocker.h"
+#include "qom/compat-properties.h"
 #include "qom/object.h"
 #include "monitor/monitor.h"
 #include "monitor/hmp.h"
diff --git a/ui/vdagent.c b/ui/vdagent.c
index bb0c4aa14ca..bb55cbefc9c 100644
--- a/ui/vdagent.c
+++ b/ui/vdagent.c
@@ -5,6 +5,7 @@
 #include "qemu/error-report.h"
 #include "qemu/option.h"
 #include "qemu/units.h"
+#include "qom/compat-properties.h"
 #include "hw/core/qdev.h"
 #include "hw/core/qdev-properties.h"
 #include "migration/blocker.h"
diff --git a/rust/bindings/qom-sys/lib.rs b/rust/bindings/qom-sys/lib.rs
index 464b9290344..21b996aeaa4 100644
--- a/rust/bindings/qom-sys/lib.rs
+++ b/rust/bindings/qom-sys/lib.rs
@@ -18,7 +18,7 @@
     clippy::too_many_arguments
 )]
 
-use glib_sys::{GHashTable, GHashTableIter, GPtrArray, GSList};
+use glib_sys::{GHashTable, GHashTableIter, GSList};
 use util_sys::{Error, QDict, QObject, Visitor};
 
 #[cfg(MESON)]
-- 
2.53.0


