Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 819CE109C032
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 15:18:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5Pzn-0004qj-Fs; Wed, 25 Mar 2026 11:18:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w5Pzi-0004kv-PH
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 11:18:08 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w5Pzg-0008Q4-7S
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 11:18:05 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-486fd5360d4so30229295e9.1
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 08:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774451882; x=1775056682; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QxrAV8rmf30CF98liKz5B3rdomtAez5skkM9aGRME4I=;
 b=dgc7cLLR8UVmC8uoFDu+LeCwu1elh5cmVYIGeJgzF6Tq1+zSmFPD0O6ygCB7j9q3uH
 fBakTQojCGgCXRAqeJVulBp2cPbx7VwD2N4T3nvYarZkr86GyDKgopgZvH4IkPOYDdiO
 R5ZabHcAxRU3v+EF0IBwKVPGsQKrGJzf6637DgL5e8B5/hqFKtocdaBWdftZXZOuonfO
 GJQoxkviSqjqGiaVR2homItntotRoG8mX3RXr3tYEZ5j1boUhc5B1KnXnpxcmMPTVJrL
 KkB+mKVZDbvGCshwuo4OA48ojP6yDRNzaYgxykQgdyngTpqqoayyUNvJdypoTWOChYAh
 2Yww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774451882; x=1775056682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QxrAV8rmf30CF98liKz5B3rdomtAez5skkM9aGRME4I=;
 b=AU5AhuaFSpqjAtwE7UglxfiMR2nfOWrtA2wAR8rok6aq3YHGrIwg6JPpFkyJKzaequ
 0SW6JLCxnokHSRe5k86/n8elc+CfibsbLdwxecSpRy8tAC3JtUi5agcyNgzHuDs1/E4X
 lpxIWFfMwRh2PojkPCX0R0Wp+kNTDyan4d1rOYjSuh5EJZbkUx73eUSVY7jAbA7/IwKG
 GUrOGMhtO5npT5ugvsOoqkYPpgdNiEH3kMAr+lAim3GvQt4GH53+mk5qw2mUDSkDtBdY
 JtOUHWUJhZFR3wZXefL75sRioWSwrRfu1l3AbVHuoOEQ33fuCU5yRQrfI6CrLzb9hZj+
 ITsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgV6CqN6hPtRsWGTV40m+ZucHcs1h7yLsz6px4kDw8pUJm61kkznV3DleGD7QoMa41AWToKcW4Gwtx@nongnu.org
X-Gm-Message-State: AOJu0YwurXOccodE2SlxyPQeFv9vITIopKCFbkUcG0mVZvpU7lsUtUsP
 oFet//Xm38pJT8Shl9wLSv5A8zUJLL+6mXiGfJSmLI7wRFMY/cdJKN7HFLoaG7Aj0u0=
X-Gm-Gg: ATEYQzzMRwqaXs64hoIvO/EBoTwHY/p4FmGjh9C9Go3pxxPdz+A2L24YymakUqKuGgC
 176rUAHq03xQ9VGkZzl5cd9bzev3V6nC8xw4GiMKaHRuJ4euEAA+claYXaU+iIaneWM8csJrf4T
 HUcAeueteO3HO7UDjmRU9petxUmRsVBQiLIicJtrWLFKLiO/4S/Kxju80jY3W+Pl4buy03O4n4E
 cK9saNUzXoVohzqAwHqDLgeRxF+KpiAaiO7l3mKl9Wht3YwsvwOVB/IRkPz4YtXE7Wjbe83I5eJ
 GI3Sddm9rQMkXW+9OvR7n1rAXhenJktpcSQ2MAGUnrRH7NOa/3C5Ut3cHepi3bRZbC3SgSM+eNC
 AU+LUjgHzhzWzGClb+1aOgeFPPCNGlDF7ZgQRlyslxaW5xEYh487GK/cKsY8xo0ZA7BZjNpRoxA
 Vws3sqEhmgw0FTsV1uJJXXiN6nzCB8Akdl3/xsZaOn3vmwzsl1OB6Yc7FpMh6WKCOTiGapqy4I
X-Received: by 2002:a05:600c:1e2a:b0:487:18c:7acf with SMTP id
 5b1f17b1804b1-4871606d963mr61278415e9.25.1774451881686; 
 Wed, 25 Mar 2026 08:18:01 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919e265csm466393f8f.32.2026.03.25.08.17.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Mar 2026 08:18:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Michael Tokarev <mjt@tls.msk.ru>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 kvm@vger.kernel.org, David Hildenbrand <david@kernel.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH-for-11.0? 4/6] qom: Declare compat properties API in
 'qom/compat-properties.h'
Date: Wed, 25 Mar 2026 16:17:26 +0100
Message-ID: <20260325151728.45378-5-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325151728.45378-1-philmd@linaro.org>
References: <20260325151728.45378-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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
 12 files changed, 18 insertions(+), 8 deletions(-)

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
index 6cf0e2f404e..6290b3556ee 100644
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
index 38d7b849e0a..ec31fd76c0d 100644
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
-- 
2.53.0


