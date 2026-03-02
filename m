Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5614D58E7E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:51:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyvi-0008IV-6s; Mon, 02 Mar 2026 03:47:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyup-0005NE-Fw
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:46:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyug-0001we-K1
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:46:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hCNjFaHfGWm9J+niU5Zr/XHC0Ap5Ar81+fQxuYcO5Zs=;
 b=UPlTeJpVeggib4QrhqMdL9/t4f1wlZdiyogCb5Xd3UFueWC2PyZ/pHLI662c6+ojcEfOts
 /dlnVjjwTv7JLYOUrlsDQu8eocOtDEW+1iAVPhu8uhwwJYkVDfoNX2ynbJDF2ZxhK6qVaI
 FXok2QhU/Ni6EQmXmjoWG5j2NB4zKbg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-t8nX8KSMP8-0TqSQwMG-YQ-1; Mon, 02 Mar 2026 03:45:15 -0500
X-MC-Unique: t8nX8KSMP8-0TqSQwMG-YQ-1
X-Mimecast-MFC-AGG-ID: t8nX8KSMP8-0TqSQwMG-YQ_1772441114
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-48378c4a79fso35148685e9.0
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441113; x=1773045913; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hCNjFaHfGWm9J+niU5Zr/XHC0Ap5Ar81+fQxuYcO5Zs=;
 b=i8yROFo29/HApAjzV5H7OOZ9qEuUIsRShQjvCNrSBWfaHN1IkkivPa9rD7ih1MyD7H
 WONfv0FS7SWlc+mT2haSS04psuM6PsKuqQ5mHBwz9Xnr2F1Kte9oYMa5YMVO3o+w+j+q
 RRggeS/dlPoEIh9Hmgc8ucWsZCf0YDDY2V17j9q4yqP+0FY4Jx2wXmXLiv/q6YvU+iqt
 1Zia2CCu9oP/7kW773TvIg2IOPBVx3Yp3cRcnxuBueyVM1UVgv807buJUz+E01ESBSUW
 kZCvBg6dScCXBDVw+DQGML016w0QUhl+qvqkc7hA2GtyfZlB278025AQlrPh/CxeJPUX
 jAPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441113; x=1773045913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hCNjFaHfGWm9J+niU5Zr/XHC0Ap5Ar81+fQxuYcO5Zs=;
 b=KFxheRxg+NVptrxb7MMRZepXGzh2YnSdDSQ4tlsavbAGsl62eZI7/XkhPSLbVnUC08
 JXxIij8BlgR3bXMTHNWL/5CtGvsaxx0Q3DtzmKBffgc5GOiKfzB60lCiHMYgsfDurOnE
 Ogoyed9yJgkIoDqddMScIRq3ME68Uho2/r31HXTeqdQXloqnfYNzD+nOAkmF0M2Vo6v3
 9POAXSLGNYUergH+WTIO+jptGiRdW7R/ihE9u0qnZhUR5U4uhOXqblAdmpCqnNyZERIf
 ggmGFur4SH+ykG3gjTVT0QuQ15MgnIY+G7g/vRiwmL0Agabf2QWIfqEa4yDcAjjqPim7
 MwXQ==
X-Gm-Message-State: AOJu0YxnkTnWmapHdCWMMRUSMO5z5oEFl/JaURIV2HMhhU4hsa4Gsoav
 I1mAlGdHjP/N1L+Kb0FF/+WqlQYQWJ54O1fIh36T6/Ua71BCJMqWcEp3ICq48uNVTKJEnYfSXTs
 MtuGfXRC13JttHp+wLqrqnV/EGPOwx8Uj/4DXIoWKizN3E+Fi/2mA53O+WWvLm+G0wP4Vpak1ms
 3vhczNL/uA6mRcRbzHJ2TU/TWiHY8WThDjZMyd1+Tw
X-Gm-Gg: ATEYQzzWga47AdnyYDTwzxHXL1jy1OyseVSTaRR8J81p0Ai1o3riN5sxZVaCJc+4Ye/
 +Q7iQhzaw20syWiAdEv/DNRNxUtYItPd5xNHtf04YS4xv1c6K0Rqil8feuTBIktApUtTh6ArvJ7
 OeGKNpOkq3KhwhYRZeW5qeNsOuOIhbII1Vk7Xq8jQAj3QbBySCGbqI/Jj7ueFCIZ+lbE3plrVEa
 Zug/TATfnfVHz29PvTBMr1/G2o0OINq874wyB8F3i03NsmoVKxBBinBIxbrDQ9gj23EfZ4XCN8S
 +l9weNAAvn+s/LpiR5IfmUPB0mErUxjF5UwNWCjAJpdOkemuVOzMeDlRhTDxYKH8rIleP5b8AUe
 /fxP7QW8lBvifKZjtUNXXrot6XUy9EpWTFp8X1uSzR9WUjwS6KKNx9ThDuXj3a2gH8t4xSvObaG
 L7CsemyfoHRFAB3QOM1NFPj1/dBIs=
X-Received: by 2002:a05:600c:1909:b0:477:a219:cdb7 with SMTP id
 5b1f17b1804b1-483c9b545e0mr218184015e9.0.1772441112403; 
 Mon, 02 Mar 2026 00:45:12 -0800 (PST)
X-Received: by 2002:a05:600c:1909:b0:477:a219:cdb7 with SMTP id
 5b1f17b1804b1-483c9b545e0mr218183065e9.0.1772441111492; 
 Mon, 02 Mar 2026 00:45:11 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483c3addb3asm334356175e9.0.2026.03.02.00.45.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:45:08 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <graf@amazon.com>
Subject: [PULL 034/102] accel: Add Nitro Enclaves accelerator
Date: Mon,  2 Mar 2026 09:42:29 +0100
Message-ID: <20260302084338.473368-35-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Alexander Graf <graf@amazon.com>

Nitro Enclaves are a confidential compute technology which
allows a parent instance to carve out resources from itself
and spawn a confidential sibling VM next to itself. Similar
to other confidential compute solutions, this sibling is
controlled by an underlying vmm, but still has a higher level
vmm (QEMU) to implement some of its I/O functionality and
lifecycle.

Add an accelerator to drive this interface. In combination with
follow-on patches to enhance the Nitro Enclaves machine model, this
will allow users to run a Nitro Enclave using QEMU.

Signed-off-by: Alexander Graf <graf@amazon.com>

Link: https://lore.kernel.org/r/20260225220807.33092-5-graf@amazon.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS                   |   6 +
 meson.build                   |  12 ++
 accel/nitro/trace.h           |   2 +
 include/system/hw_accel.h     |   1 +
 include/system/nitro-accel.h  |  25 +++
 accel/nitro/nitro-accel.c     | 284 ++++++++++++++++++++++++++++++++++
 accel/stubs/nitro-stub.c      |  11 ++
 accel/Kconfig                 |   3 +
 accel/meson.build             |   1 +
 accel/nitro/meson.build       |   3 +
 accel/nitro/trace-events      |   6 +
 accel/stubs/meson.build       |   1 +
 meson_options.txt             |   2 +
 qemu-options.hx               |   8 +-
 scripts/meson-buildoptions.sh |   3 +
 15 files changed, 364 insertions(+), 4 deletions(-)
 create mode 100644 accel/nitro/trace.h
 create mode 100644 include/system/nitro-accel.h
 create mode 100644 accel/nitro/nitro-accel.c
 create mode 100644 accel/stubs/nitro-stub.c
 create mode 100644 accel/nitro/meson.build
 create mode 100644 accel/nitro/trace-events

diff --git a/MAINTAINERS b/MAINTAINERS
index d781fe59bb1..0458980d434 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -586,6 +586,12 @@ F: include/system/mshv.h
 F: include/hw/hyperv/hvgdk*.h
 F: include/hw/hyperv/hvhdk*.h
 
+Nitro Enclaves (native)
+M: Alexander Graf <graf@amazon.com>
+S: Maintained
+F: accel/nitro/
+F: include/system/nitro-accel.h
+
 X86 MSHV CPUs
 M: Magnus Kulke <magnus.kulke@linux.microsoft.com>
 R: Wei Liu <wei.liu@kernel.org>
diff --git a/meson.build b/meson.build
index f3ee08772d4..cbd6d90ce64 100644
--- a/meson.build
+++ b/meson.build
@@ -302,11 +302,13 @@ accelerator_targets += { 'CONFIG_XEN': xen_targets }
 if cpu == 'aarch64'
   accelerator_targets += {
     'CONFIG_HVF': ['aarch64-softmmu'],
+    'CONFIG_NITRO': ['aarch64-softmmu'],
     'CONFIG_WHPX': ['aarch64-softmmu']
   }
 elif cpu == 'x86_64'
   accelerator_targets += {
     'CONFIG_HVF': ['x86_64-softmmu'],
+    'CONFIG_NITRO': ['x86_64-softmmu'],
     'CONFIG_NVMM': ['i386-softmmu', 'x86_64-softmmu'],
     'CONFIG_WHPX': ['i386-softmmu', 'x86_64-softmmu'],
     'CONFIG_MSHV': ['x86_64-softmmu'],
@@ -880,6 +882,11 @@ if get_option('hvf').allowed()
   endif
 endif
 
+nitro = not_found
+if get_option('nitro').allowed() and host_os == 'linux'
+  accelerators += 'CONFIG_NITRO'
+endif
+
 nvmm = not_found
 if host_os == 'netbsd'
   nvmm = cc.find_library('nvmm', required: get_option('nvmm'))
@@ -921,6 +928,9 @@ endif
 if 'CONFIG_HVF' not in accelerators and get_option('hvf').enabled()
   error('HVF not available on this platform')
 endif
+if 'CONFIG_NITRO' not in accelerators and get_option('nitro').enabled()
+  error('NITRO not available on this platform')
+endif
 if 'CONFIG_NVMM' not in accelerators and get_option('nvmm').enabled()
   error('NVMM not available on this platform')
 endif
@@ -3590,6 +3600,7 @@ if have_system
     'accel/hvf',
     'accel/kvm',
     'accel/mshv',
+    'accel/nitro',
     'audio',
     'backends',
     'backends/tpm',
@@ -4789,6 +4800,7 @@ endif
 summary_info = {}
 if have_system
   summary_info += {'KVM support':       config_all_accel.has_key('CONFIG_KVM')}
+  summary_info += {'Nitro support':     config_all_accel.has_key('CONFIG_NITRO')}
   summary_info += {'HVF support':       config_all_accel.has_key('CONFIG_HVF')}
   summary_info += {'WHPX support':      config_all_accel.has_key('CONFIG_WHPX')}
   summary_info += {'NVMM support':      config_all_accel.has_key('CONFIG_NVMM')}
diff --git a/accel/nitro/trace.h b/accel/nitro/trace.h
new file mode 100644
index 00000000000..8c5564725dc
--- /dev/null
+++ b/accel/nitro/trace.h
@@ -0,0 +1,2 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#include "trace/trace-accel_nitro.h"
diff --git a/include/system/hw_accel.h b/include/system/hw_accel.h
index 628a50e066e..f0c10b6d805 100644
--- a/include/system/hw_accel.h
+++ b/include/system/hw_accel.h
@@ -17,6 +17,7 @@
 #include "system/mshv.h"
 #include "system/whpx.h"
 #include "system/nvmm.h"
+#include "system/nitro-accel.h"
 
 /**
  * cpu_synchronize_state:
diff --git a/include/system/nitro-accel.h b/include/system/nitro-accel.h
new file mode 100644
index 00000000000..a93aa6fb00d
--- /dev/null
+++ b/include/system/nitro-accel.h
@@ -0,0 +1,25 @@
+/*
+ * Nitro Enclaves accelerator - public interface
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef SYSTEM_NITRO_ACCEL_H
+#define SYSTEM_NITRO_ACCEL_H
+
+#include "qemu/accel.h"
+
+extern bool nitro_allowed;
+
+static inline bool nitro_enabled(void)
+{
+    return nitro_allowed;
+}
+
+#define TYPE_NITRO_ACCEL ACCEL_CLASS_NAME("nitro")
+
+typedef struct NitroAccelState NitroAccelState;
+DECLARE_INSTANCE_CHECKER(NitroAccelState, NITRO_ACCEL,
+                         TYPE_NITRO_ACCEL)
+
+#endif /* SYSTEM_NITRO_ACCEL_H */
diff --git a/accel/nitro/nitro-accel.c b/accel/nitro/nitro-accel.c
new file mode 100644
index 00000000000..a1e97a9162e
--- /dev/null
+++ b/accel/nitro/nitro-accel.c
@@ -0,0 +1,284 @@
+/*
+ * Nitro Enclaves accelerator
+ *
+ * Copyright © 2026 Amazon.com, Inc. or its affiliates. All Rights Reserved.
+ *
+ * Authors:
+ *   Alexander Graf <graf@amazon.com>
+ *
+ * Nitro Enclaves are a confidential compute technology which
+ * allows a parent instance to carve out resources from itself
+ * and spawn a confidential sibling VM next to itself. Similar
+ * to other confidential compute solutions, this sibling is
+ * controlled by an underlying vmm, but still has a higher level
+ * vmm (QEMU) to implement some of its I/O functionality and
+ * lifecycle.
+ *
+ * This accelerator drives /dev/nitro_enclaves to spawn a Nitro
+ * Enclave. It works in tandem with the nitro_enclaves machine
+ * which ensures the correct backend devices are available and
+ * that the initial seed (an EIF file) is loaded at the correct
+ * offset in memory.
+ *
+ * The accel starts the enclave when the machine starts, after
+ * all device setup is finished.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
+#include "qapi/visitor.h"
+#include "qemu/module.h"
+#include "qemu/rcu.h"
+#include "qemu/accel.h"
+#include "qemu/guest-random.h"
+#include "qemu/main-loop.h"
+#include "accel/accel-ops.h"
+#include "accel/accel-cpu-ops.h"
+#include "accel/dummy-cpus.h"
+#include "system/cpus.h"
+#include "hw/core/cpu.h"
+#include "hw/core/boards.h"
+#include "hw/nitro/nitro-vsock-bus.h"
+#include "system/ramblock.h"
+#include "system/nitro-accel.h"
+#include "trace.h"
+
+#include <sys/ioctl.h>
+#include "standard-headers/linux/nitro_enclaves.h"
+
+bool nitro_allowed;
+
+typedef struct NitroAccelState {
+    AccelState parent_obj;
+
+    int ne_fd;
+    int enclave_fd;
+    uint64_t slot_uid;
+    uint64_t enclave_cid;
+    bool debug_mode;
+} NitroAccelState;
+
+static int nitro_init_machine(AccelState *as, MachineState *ms)
+{
+    NitroAccelState *s = NITRO_ACCEL(as);
+    uint64_t slot_uid = 0;
+    int ret;
+
+    s->ne_fd = open("/dev/nitro_enclaves", O_RDWR | O_CLOEXEC);
+    if (s->ne_fd < 0) {
+        error_report("nitro: failed to open /dev/nitro_enclaves: %s",
+                     strerror(errno));
+        return -errno;
+    }
+
+    ret = ioctl(s->ne_fd, NE_CREATE_VM, &slot_uid);
+    if (ret < 0) {
+        error_report("nitro: NE_CREATE_VM failed: %s", strerror(errno));
+        close(s->ne_fd);
+        return -errno;
+    }
+    s->enclave_fd = ret;
+    s->slot_uid = slot_uid;
+
+    return 0;
+}
+
+static int nitro_donate_ram_block(RAMBlock *rb, void *opaque)
+{
+    NitroAccelState *s = opaque;
+    struct ne_user_memory_region region = {
+        .flags = 0,
+        .memory_size = rb->used_length,
+        .userspace_addr = (uint64_t)(uintptr_t)rb->host,
+    };
+
+    if (!rb->used_length) {
+        return 0;
+    }
+
+    if (ioctl(s->enclave_fd, NE_SET_USER_MEMORY_REGION, &region) < 0) {
+        error_report("nitro: NE_SET_USER_MEMORY_REGION failed for %s "
+                     "(%" PRIu64 " bytes): %s", rb->idstr, rb->used_length,
+                     strerror(errno));
+        return -errno;
+    }
+    return 0;
+}
+
+/*
+ * Start the Enclave. At this point memory is set up and the EIF is loaded.
+ * This function donates memory, adds vCPUs, and starts the enclave.
+ */
+static void nitro_setup_post(AccelState *as)
+{
+    MachineState *ms = MACHINE(qdev_get_machine());
+    NitroAccelState *s = NITRO_ACCEL(as);
+    int nr_cpus = ms->smp.cpus;
+    int i, ret;
+    struct ne_enclave_start_info start_info = {
+        .flags = s->debug_mode ? NE_ENCLAVE_DEBUG_MODE : 0,
+        .enclave_cid = s->enclave_cid,
+    };
+
+    ret = qemu_ram_foreach_block(nitro_donate_ram_block, s);
+    if (ret < 0) {
+        error_report("nitro: failed to donate memory");
+        exit(1);
+    }
+
+    for (i = 0; i < nr_cpus; i++) {
+        uint32_t cpu_id = 0;
+        if (ioctl(s->enclave_fd, NE_ADD_VCPU, &cpu_id) < 0) {
+            error_report("nitro: NE_ADD_VCPU failed: %s", strerror(errno));
+            exit(1);
+        }
+    }
+
+    ret = ioctl(s->enclave_fd, NE_START_ENCLAVE, &start_info);
+    if (ret < 0) {
+        switch (errno) {
+        case NE_ERR_NO_MEM_REGIONS_ADDED:
+            error_report("nitro: no memory regions added");
+            break;
+        case NE_ERR_NO_VCPUS_ADDED:
+            error_report("nitro: no vCPUs added");
+            break;
+        case NE_ERR_ENCLAVE_MEM_MIN_SIZE:
+            error_report("nitro: memory is below the minimum "
+                         "required size. Try increasing -m");
+            break;
+        case NE_ERR_FULL_CORES_NOT_USED:
+            error_report("nitro: requires full CPU cores. "
+                         "Try increasing -smp to a multiple of threads "
+                         "per core on this host (e.g. -smp 2)");
+            break;
+        case NE_ERR_NOT_IN_INIT_STATE:
+            error_report("nitro: not in init state");
+            break;
+        case NE_ERR_INVALID_FLAG_VALUE:
+            error_report("nitro: invalid flag value for NE_START_ENCLAVE");
+            break;
+        case NE_ERR_INVALID_ENCLAVE_CID:
+            error_report("nitro: invalid enclave CID");
+            break;
+        default:
+            error_report("nitro: NE_START_ENCLAVE failed: %s (errno %d)",
+                         strerror(errno), errno);
+            break;
+        }
+        exit(1);
+    }
+
+    s->enclave_cid = start_info.enclave_cid;
+    trace_nitro_enclave_started(s->enclave_cid);
+
+    /*
+     * Notify all Nitro vsock bus devices that the enclave has started
+     * and provide them with the CID for vsock connections.
+     */
+    {
+        NitroVsockBridge *bridge = nitro_vsock_bridge_find();
+        Error *err = NULL;
+
+        if (bridge) {
+            nitro_vsock_bridge_start_enclave(bridge,
+                                             (uint32_t)s->enclave_cid, &err);
+            if (err) {
+                error_report_err(err);
+                exit(1);
+            }
+        }
+    }
+}
+
+/* QOM properties */
+
+static bool nitro_get_debug_mode(Object *obj, Error **errp)
+{
+    return NITRO_ACCEL(obj)->debug_mode;
+}
+
+static void nitro_set_debug_mode(Object *obj, bool value, Error **errp)
+{
+    NITRO_ACCEL(obj)->debug_mode = value;
+}
+
+static void nitro_get_enclave_cid(Object *obj, Visitor *v,
+                                  const char *name, void *opaque,
+                                  Error **errp)
+{
+    uint64_t val = NITRO_ACCEL(obj)->enclave_cid;
+    visit_type_uint64(v, name, &val, errp);
+}
+
+static void nitro_set_enclave_cid(Object *obj, Visitor *v,
+                                  const char *name, void *opaque,
+                                  Error **errp)
+{
+    uint64_t val;
+    if (visit_type_uint64(v, name, &val, errp)) {
+        NITRO_ACCEL(obj)->enclave_cid = val;
+    }
+}
+
+static void nitro_accel_class_init(ObjectClass *oc, const void *data)
+{
+    AccelClass *ac = ACCEL_CLASS(oc);
+    ac->name = "Nitro";
+    ac->init_machine = nitro_init_machine;
+    ac->setup_post = nitro_setup_post;
+    ac->allowed = &nitro_allowed;
+
+    object_class_property_add_bool(oc, "debug-mode",
+                                   nitro_get_debug_mode,
+                                   nitro_set_debug_mode);
+    object_class_property_set_description(oc, "debug-mode",
+        "Start enclave in debug mode (enables console output)");
+
+    object_class_property_add(oc, "enclave-cid", "uint64",
+                              nitro_get_enclave_cid,
+                              nitro_set_enclave_cid,
+                              NULL, NULL);
+    object_class_property_set_description(oc, "enclave-cid",
+        "Enclave CID (0 = auto-assigned by Nitro)");
+}
+
+static const TypeInfo nitro_accel_type = {
+    .name = TYPE_NITRO_ACCEL,
+    .parent = TYPE_ACCEL,
+    .instance_size = sizeof(NitroAccelState),
+    .class_init = nitro_accel_class_init,
+};
+module_obj(TYPE_NITRO_ACCEL);
+
+static bool nitro_cpus_are_resettable(void)
+{
+    return false;
+}
+
+static void nitro_accel_ops_class_init(ObjectClass *oc, const void *data)
+{
+    AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
+    ops->create_vcpu_thread = dummy_start_vcpu_thread;
+    ops->handle_interrupt = generic_handle_interrupt;
+    ops->cpus_are_resettable = nitro_cpus_are_resettable;
+}
+
+static const TypeInfo nitro_accel_ops_type = {
+    .name = ACCEL_OPS_NAME("nitro"),
+    .parent = TYPE_ACCEL_OPS,
+    .class_init = nitro_accel_ops_class_init,
+    .abstract = true,
+};
+module_obj(ACCEL_OPS_NAME("nitro"));
+
+static void nitro_type_init(void)
+{
+    type_register_static(&nitro_accel_type);
+    type_register_static(&nitro_accel_ops_type);
+}
+
+type_init(nitro_type_init);
diff --git a/accel/stubs/nitro-stub.c b/accel/stubs/nitro-stub.c
new file mode 100644
index 00000000000..186c8444f86
--- /dev/null
+++ b/accel/stubs/nitro-stub.c
@@ -0,0 +1,11 @@
+/*
+ * Nitro accel stubs for QEMU
+ *
+ * Copyright © 2026 Amazon.com, Inc. or its affiliates. All Rights Reserved.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+
+bool nitro_allowed;
diff --git a/accel/Kconfig b/accel/Kconfig
index a60f1149238..6d052875ee2 100644
--- a/accel/Kconfig
+++ b/accel/Kconfig
@@ -16,6 +16,9 @@ config KVM
 config MSHV
     bool
 
+config NITRO
+    bool
+
 config XEN
     bool
     select FSDEV_9P if VIRTFS
diff --git a/accel/meson.build b/accel/meson.build
index 289b7420ffa..7da12b9741f 100644
--- a/accel/meson.build
+++ b/accel/meson.build
@@ -12,6 +12,7 @@ if have_system
   subdir('xen')
   subdir('stubs')
   subdir('mshv')
+  subdir('nitro')
 endif
 
 # qtest
diff --git a/accel/nitro/meson.build b/accel/nitro/meson.build
new file mode 100644
index 00000000000..e01c1bab96d
--- /dev/null
+++ b/accel/nitro/meson.build
@@ -0,0 +1,3 @@
+nitro_ss = ss.source_set()
+nitro_ss.add(files('nitro-accel.c'))
+system_ss.add_all(when: 'CONFIG_NITRO', if_true: nitro_ss)
diff --git a/accel/nitro/trace-events b/accel/nitro/trace-events
new file mode 100644
index 00000000000..9673eb5aa22
--- /dev/null
+++ b/accel/nitro/trace-events
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# See docs/devel/tracing.rst for syntax documentation.
+
+# nitro-accel.c
+nitro_enclave_started(uint64_t cid) "nitro: enclave started, CID=%"PRIu64
diff --git a/accel/stubs/meson.build b/accel/stubs/meson.build
index 48eccd1b861..5de4a279ff9 100644
--- a/accel/stubs/meson.build
+++ b/accel/stubs/meson.build
@@ -3,6 +3,7 @@ system_stubs_ss.add(when: 'CONFIG_XEN', if_false: files('xen-stub.c'))
 system_stubs_ss.add(when: 'CONFIG_KVM', if_false: files('kvm-stub.c'))
 system_stubs_ss.add(when: 'CONFIG_TCG', if_false: files('tcg-stub.c'))
 system_stubs_ss.add(when: 'CONFIG_HVF', if_false: files('hvf-stub.c'))
+system_stubs_ss.add(when: 'CONFIG_NITRO', if_false: files('nitro-stub.c'))
 system_stubs_ss.add(when: 'CONFIG_NVMM', if_false: files('nvmm-stub.c'))
 system_stubs_ss.add(when: 'CONFIG_WHPX', if_false: files('whpx-stub.c'))
 system_stubs_ss.add(when: 'CONFIG_MSHV', if_false: files('mshv-stub.c'))
diff --git a/meson_options.txt b/meson_options.txt
index 2836156257a..31d5916cfce 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -79,6 +79,8 @@ option('whpx', type: 'feature', value: 'auto',
        description: 'WHPX acceleration support')
 option('hvf', type: 'feature', value: 'auto',
        description: 'HVF acceleration support')
+option('nitro', type: 'feature', value: 'auto',
+       description: 'Nitro acceleration support')
 option('nvmm', type: 'feature', value: 'auto',
        description: 'NVMM acceleration support')
 option('xen', type: 'feature', value: 'auto',
diff --git a/qemu-options.hx b/qemu-options.hx
index 4043e8ca22b..0da2b4d0348 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -28,7 +28,7 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
     "-machine [type=]name[,prop[=value][,...]]\n"
     "                selects emulated machine ('-machine help' for list)\n"
     "                property accel=accel1[:accel2[:...]] selects accelerator\n"
-    "                supported accelerators are kvm, xen, hvf, nvmm, whpx, mshv or tcg (default: tcg)\n"
+    "                supported accelerators are kvm, xen, hvf, nitro, nvmm, whpx, mshv or tcg (default: tcg)\n"
     "                vmport=on|off|auto controls emulation of vmport (default: auto)\n"
     "                dump-guest-core=on|off include guest memory in a core dump (default=on)\n"
     "                mem-merge=on|off controls memory merge support (default: on)\n"
@@ -67,7 +67,7 @@ SRST
 
     ``accel=accels1[:accels2[:...]]``
         This is used to enable an accelerator. Depending on the target
-        architecture, kvm, xen, hvf, nvmm, whpx, mshv or tcg can be
+        architecture, kvm, xen, hvf, nitro, nvmm, whpx, mshv or tcg can be
         available. By default, tcg is used. If there is more than one
         accelerator specified, the next one is used if the previous one
         fails to initialize.
@@ -228,7 +228,7 @@ ERST
 
 DEF("accel", HAS_ARG, QEMU_OPTION_accel,
     "-accel [accel=]accelerator[,prop[=value][,...]]\n"
-    "                select accelerator (kvm, xen, hvf, nvmm, whpx, mshv or tcg; use 'help' for a list)\n"
+    "                select accelerator (kvm, xen, hvf, nitro, nvmm, whpx, mshv or tcg; use 'help' for a list)\n"
     "                igd-passthru=on|off (enable Xen integrated Intel graphics passthrough, default=off)\n"
     "                kernel-irqchip=on|off|split controls accelerated irqchip support (default=on)\n"
     "                kvm-shadow-mem=size of KVM shadow MMU in bytes\n"
@@ -243,7 +243,7 @@ DEF("accel", HAS_ARG, QEMU_OPTION_accel,
 SRST
 ``-accel name[,prop=value[,...]]``
     This is used to enable an accelerator. Depending on the target
-    architecture, kvm, xen, hvf, nvmm, whpx, mshv or tcg can be available.
+    architecture, kvm, xen, hvf, nitro, nvmm, whpx, mshv or tcg can be available.
     By default, tcg is used. If there is more than one accelerator
     specified, the next one is used if the previous one fails to
     initialize.
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index e8edc5252a3..ca5b113119a 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -158,6 +158,7 @@ meson_options_help() {
   printf "%s\n" '  multiprocess    Out of process device emulation support'
   printf "%s\n" '  netmap          netmap network backend support'
   printf "%s\n" '  nettle          nettle cryptography support'
+  printf "%s\n" '  nitro           Nitro acceleration support'
   printf "%s\n" '  numa            libnuma support'
   printf "%s\n" '  nvmm            NVMM acceleration support'
   printf "%s\n" '  opengl          OpenGL support'
@@ -418,6 +419,8 @@ _meson_option_parse() {
     --disable-netmap) printf "%s" -Dnetmap=disabled ;;
     --enable-nettle) printf "%s" -Dnettle=enabled ;;
     --disable-nettle) printf "%s" -Dnettle=disabled ;;
+    --enable-nitro) printf "%s" -Dnitro=enabled ;;
+    --disable-nitro) printf "%s" -Dnitro=disabled ;;
     --enable-numa) printf "%s" -Dnuma=enabled ;;
     --disable-numa) printf "%s" -Dnuma=disabled ;;
     --enable-nvmm) printf "%s" -Dnvmm=enabled ;;
-- 
2.53.0


