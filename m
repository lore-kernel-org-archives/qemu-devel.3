Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD66ACCD187
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 07:52:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6lQZ-0008Fw-G8; Thu, 09 Oct 2025 03:51:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6lQY-0008Fg-7h
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:51:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6lQT-0004Og-UG
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:51:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759996260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BW2WJxOS4xr7mxNzCkKr1ZJuFLGZN8Iw793SnaBQLK8=;
 b=H98usYd4pFZU+8QKqStPAARX+6JfyqU1hPCsvFgJVWKjVN0evq4IzAkQ7eKnqbYxKhcNMO
 ExVnjexQfljbNFfaZi0w9sJXgEqcK8yhlj5afQmg+bcI6PqAap2ajKg6ZITZvRRMqa6dnO
 dUkFpsnLCIZ+xd7drvgRJXgyf2ccXO8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-rWOkIMncO8S-bk2RMLGxpQ-1; Thu, 09 Oct 2025 03:50:58 -0400
X-MC-Unique: rWOkIMncO8S-bk2RMLGxpQ-1
X-Mimecast-MFC-AGG-ID: rWOkIMncO8S-bk2RMLGxpQ_1759996258
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-46fb328a60eso569085e9.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 00:50:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759996256; x=1760601056;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BW2WJxOS4xr7mxNzCkKr1ZJuFLGZN8Iw793SnaBQLK8=;
 b=IA30PoYimcFXhGdVouYKYMbVTsoad6XAQS1M/JMpXnmcYT2wYm1XuyuUbWxgKkXhj3
 3f6gSBbV3Bi3v+gvmKxc1mi39ZVh2O1H1UabeGck21YeTuY+mUgW2iQwG8PkkgPGPJ4k
 OepX2dExqCzGZHyM3XdfJ4n1SSHZPyghspW/6hsBFU8Z/miYMU8hHmw6ko68WkjWrSTM
 Pxu3NbHfEyEa80izSpz0ckTxu+/NCGwtgmp/Zd0SRCPpENVa0phL3KNc/mAkQsq/E9/L
 UxEKmgYEhEtO5RP6r2SZnhmuhgJJHK7khODkOYvvZBU91fGwWv/jUA7LvLG9D0CNyTIv
 O4EQ==
X-Gm-Message-State: AOJu0YzuwhLZulqRdCP690a3PErD3wR0F3T0QB09z+TFcIKksjqFIOWW
 GRdtzTVe9EnpH2SOnqMG+FlabUPFZoyQK3X1oiqUoo5NwTaW3yGmhvzrgy/HmJRrR+T/UWYd5Ll
 YTfpHE+SbJMGxQasjWu4MWK3RNZMelX2jeCyHSzWCMZj+DzgBX52aQvCZ2GzAWxWuCdTKr8unhA
 0V2+punCgtHTMNSWlGH0RTX3fFbCptoVF1MFfz7ey3XKU=
X-Gm-Gg: ASbGncsvzucIQYN8LXiLaN133r/5KGJ3hw9G7+IbrwiZ9lFqJ34EtWjpX7k9geOYp/I
 NTxqTMidIE8wNJi3v3N1hkqNfjAzQwPHjfmBf+Q9CW5QaBI9dyP8MNEzCjHLnX2rGuPBbvnpb3X
 duBqEp1Ayiy1P5kV3q3sG7e/ZHRSkopLXP0txTgAY5fEZNeLCqTvtT7j57LoI3QoCd6HPYRjLrz
 Qwujf3lNOK71/hTzRC+v/fRiNusa+rCkL4Dg4W64JiFg2DxgJpYaiMDPWcjka2APoTfo2wG81LD
 Bqn8+kGbiJ9cutVc5mAyhrNNSwhZYLs7LSJ9l3sJvrhs5QZdbwWr/YTYXa4mzpsrOAmIXEph7Oa
 MKhSXB6LOoBeEvTUaGi2QdLq2iksZabEGsiIWkfFfz9j67Eer
X-Received: by 2002:a05:600d:41f3:b0:45b:7be1:be1f with SMTP id
 5b1f17b1804b1-46fa9b092ddmr39467895e9.32.1759996256413; 
 Thu, 09 Oct 2025 00:50:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0tg9xZoBoCQCZPtnXLx5EbmCPRivrDCwXTqh5lDdlWM3Ls/jihUcrTrjIwONfXuhEua7iww==
X-Received: by 2002:a05:600d:41f3:b0:45b:7be1:be1f with SMTP id
 5b1f17b1804b1-46fa9b092ddmr39467665e9.32.1759996255877; 
 Thu, 09 Oct 2025 00:50:55 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.36.217])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fab5250ddsm30255615e9.6.2025.10.09.00.50.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 00:50:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PULL 13/35] accel/mshv: Add accelerator skeleton
Date: Thu,  9 Oct 2025 09:50:03 +0200
Message-ID: <20251009075026.505715-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009075026.505715-1-pbonzini@redhat.com>
References: <20251009075026.505715-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Magnus Kulke <magnuskulke@linux.microsoft.com>

Introduce the initial scaffold for the MSHV (Microsoft Hypervisor)
accelerator backend. This includes the basic directory structure and
stub implementations needed to integrate with QEMU's accelerator
framework.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Link: https://lore.kernel.org/r/20250916164847.77883-8-magnuskulke@linux.microsoft.com
[Move include of linux/mshv.h in the per-target section; create
 include/system/mshv_int.h. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/system/mshv.h     |  12 ++++
 include/system/mshv_int.h |  41 +++++++++++
 accel/mshv/mshv-all.c     | 144 ++++++++++++++++++++++++++++++++++++++
 accel/meson.build         |   1 +
 accel/mshv/meson.build    |   6 ++
 5 files changed, 204 insertions(+)
 create mode 100644 include/system/mshv_int.h
 create mode 100644 accel/mshv/mshv-all.c
 create mode 100644 accel/mshv/meson.build

diff --git a/include/system/mshv.h b/include/system/mshv.h
index 2a504ed81f2..434ea9682e1 100644
--- a/include/system/mshv.h
+++ b/include/system/mshv.h
@@ -14,8 +14,17 @@
 #ifndef QEMU_MSHV_H
 #define QEMU_MSHV_H
 
+#include "qemu/osdep.h"
+#include "qemu/accel.h"
+#include "hw/hyperv/hyperv-proto.h"
+#include "hw/hyperv/hvhdk.h"
+#include "qapi/qapi-types-common.h"
+#include "system/memory.h"
+#include "accel/accel-ops.h"
+
 #ifdef COMPILING_PER_TARGET
 #ifdef CONFIG_MSHV
+#include <linux/mshv.h>
 #define CONFIG_MSHV_IS_POSSIBLE
 #endif
 #else
@@ -30,6 +39,9 @@ extern bool mshv_allowed;
 #endif
 #define mshv_msi_via_irqfd_enabled() false
 
+typedef struct MshvState MshvState;
+extern MshvState *mshv_state;
+
 /* interrupt */
 int mshv_irqchip_add_msi_route(int vector, PCIDevice *dev);
 int mshv_irqchip_update_msi_route(int virq, MSIMessage msg, PCIDevice *dev);
diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
new file mode 100644
index 00000000000..132491b599d
--- /dev/null
+++ b/include/system/mshv_int.h
@@ -0,0 +1,41 @@
+/*
+ * QEMU MSHV support
+ *
+ * Copyright Microsoft, Corp. 2025
+ *
+ * Authors: Ziqiao Zhou  <ziqiaozhou@microsoft.com>
+ *          Magnus Kulke <magnuskulke@microsoft.com>
+ *          Jinank Jain  <jinankjain@microsoft.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#ifndef QEMU_MSHV_INT_H
+#define QEMU_MSHV_INT_H
+
+struct AccelCPUState {
+    int cpufd;
+    bool dirty;
+};
+
+typedef struct MshvMemoryListener {
+    MemoryListener listener;
+    int as_id;
+} MshvMemoryListener;
+
+typedef struct MshvAddressSpace {
+    MshvMemoryListener *ml;
+    AddressSpace *as;
+} MshvAddressSpace;
+
+struct MshvState {
+    AccelState parent_obj;
+    int vm;
+    MshvMemoryListener memory_listener;
+    /* number of listeners */
+    int nr_as;
+    MshvAddressSpace *as;
+};
+
+#endif
diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
new file mode 100644
index 00000000000..ae12f0f58b9
--- /dev/null
+++ b/accel/mshv/mshv-all.c
@@ -0,0 +1,144 @@
+/*
+ * QEMU MSHV support
+ *
+ * Copyright Microsoft, Corp. 2025
+ *
+ * Authors:
+ *  Ziqiao Zhou       <ziqiaozhou@microsoft.com>
+ *  Magnus Kulke      <magnuskulke@microsoft.com>
+ *  Jinank Jain       <jinankjain@microsoft.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "qemu/event_notifier.h"
+#include "qemu/module.h"
+#include "qemu/main-loop.h"
+#include "hw/boards.h"
+
+#include "hw/hyperv/hvhdk.h"
+#include "hw/hyperv/hvhdk_mini.h"
+#include "hw/hyperv/hvgdk.h"
+#include "linux/mshv.h"
+
+#include "qemu/accel.h"
+#include "qemu/guest-random.h"
+#include "accel/accel-ops.h"
+#include "accel/accel-cpu-ops.h"
+#include "system/cpus.h"
+#include "system/runstate.h"
+#include "system/accel-blocker.h"
+#include "system/address-spaces.h"
+#include "system/mshv.h"
+#include "system/mshv_int.h"
+#include "system/reset.h"
+#include "trace.h"
+#include <err.h>
+#include <stdint.h>
+#include <sys/ioctl.h>
+
+#define TYPE_MSHV_ACCEL ACCEL_CLASS_NAME("mshv")
+
+DECLARE_INSTANCE_CHECKER(MshvState, MSHV_STATE, TYPE_MSHV_ACCEL)
+
+bool mshv_allowed;
+
+MshvState *mshv_state;
+
+static int mshv_init(AccelState *as, MachineState *ms)
+{
+    error_report("unimplemented");
+    abort();
+}
+
+static void mshv_start_vcpu_thread(CPUState *cpu)
+{
+    error_report("unimplemented");
+    abort();
+}
+
+static void mshv_cpu_synchronize_post_init(CPUState *cpu)
+{
+    error_report("unimplemented");
+    abort();
+}
+
+static void mshv_cpu_synchronize_post_reset(CPUState *cpu)
+{
+    error_report("unimplemented");
+    abort();
+}
+
+static void mshv_cpu_synchronize_pre_loadvm(CPUState *cpu)
+{
+    error_report("unimplemented");
+    abort();
+}
+
+static void mshv_cpu_synchronize(CPUState *cpu)
+{
+    error_report("unimplemented");
+    abort();
+}
+
+static bool mshv_cpus_are_resettable(void)
+{
+    error_report("unimplemented");
+    abort();
+}
+
+static void mshv_accel_class_init(ObjectClass *oc, const void *data)
+{
+    AccelClass *ac = ACCEL_CLASS(oc);
+
+    ac->name = "MSHV";
+    ac->init_machine = mshv_init;
+    ac->allowed = &mshv_allowed;
+}
+
+static void mshv_accel_instance_init(Object *obj)
+{
+    MshvState *s = MSHV_STATE(obj);
+
+    s->vm = 0;
+}
+
+static const TypeInfo mshv_accel_type = {
+    .name = TYPE_MSHV_ACCEL,
+    .parent = TYPE_ACCEL,
+    .instance_init = mshv_accel_instance_init,
+    .class_init = mshv_accel_class_init,
+    .instance_size = sizeof(MshvState),
+};
+
+static void mshv_accel_ops_class_init(ObjectClass *oc, const void *data)
+{
+    AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
+
+    ops->create_vcpu_thread = mshv_start_vcpu_thread;
+    ops->synchronize_post_init = mshv_cpu_synchronize_post_init;
+    ops->synchronize_post_reset = mshv_cpu_synchronize_post_reset;
+    ops->synchronize_state = mshv_cpu_synchronize;
+    ops->synchronize_pre_loadvm = mshv_cpu_synchronize_pre_loadvm;
+    ops->cpus_are_resettable = mshv_cpus_are_resettable;
+    ops->handle_interrupt = generic_handle_interrupt;
+}
+
+static const TypeInfo mshv_accel_ops_type = {
+    .name = ACCEL_OPS_NAME("mshv"),
+    .parent = TYPE_ACCEL_OPS,
+    .class_init = mshv_accel_ops_class_init,
+    .abstract = true,
+};
+
+static void mshv_type_init(void)
+{
+    type_register_static(&mshv_accel_type);
+    type_register_static(&mshv_accel_ops_type);
+}
+
+type_init(mshv_type_init);
diff --git a/accel/meson.build b/accel/meson.build
index 6349efe682f..983dfd0bd55 100644
--- a/accel/meson.build
+++ b/accel/meson.build
@@ -10,6 +10,7 @@ if have_system
   subdir('kvm')
   subdir('xen')
   subdir('stubs')
+  subdir('mshv')
 endif
 
 # qtest
diff --git a/accel/mshv/meson.build b/accel/mshv/meson.build
new file mode 100644
index 00000000000..4c03ac79219
--- /dev/null
+++ b/accel/mshv/meson.build
@@ -0,0 +1,6 @@
+mshv_ss = ss.source_set()
+mshv_ss.add(if_true: files(
+  'mshv-all.c'
+))
+
+specific_ss.add_all(when: 'CONFIG_MSHV', if_true: mshv_ss)
-- 
2.51.0


