Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4F6FCAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 17:20:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4Mve-00014R-7M; Thu, 02 Oct 2025 13:17:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v4Mus-0000li-KF
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 13:16:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v4MuW-0005j9-UH
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 13:16:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759425362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kRttI8LqJE5R4/hPKUJbIz7mchb821txk/PsshPhKrE=;
 b=Kl8o0d88qI3JFgyOR95EsuANvfDMPnqbIctEn4ZPxNpdZzJp6AEWspEYIkbMuInn0UJR7Q
 cHFqZDHDfgBC1o/gEh5B99RnNveQuiw27EmuDxQe/l1a1G+ADAFoJ990/EcOX9PU2HbdBK
 vDdttj+tXkQ5pEZbYrfv8ZRYZG23V5I=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-chcAAbb1MAq9EtGkOrkFkg-1; Thu, 02 Oct 2025 13:16:01 -0400
X-MC-Unique: chcAAbb1MAq9EtGkOrkFkg-1
X-Mimecast-MFC-AGG-ID: chcAAbb1MAq9EtGkOrkFkg_1759425360
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-b3a879bd254so115168766b.0
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 10:16:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759425359; x=1760030159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kRttI8LqJE5R4/hPKUJbIz7mchb821txk/PsshPhKrE=;
 b=QOSst7qUusKp+49s5tgbYO6l6YAppaXEsIS5gj5bNLUDkknZzFPwZRKvh1qiKbxhDY
 +D4krMGpwqJbJ7hbsZjWQVZm3X7xTWQ9Lb6jZsU2rP65OLcx5nhE6+2QcOvCEe6k0zLO
 9jw8neyf4GKno9HIHqNt/0S5Fwuwg5gMZ0mkfHe7EkBHO4XmUqxkZ4KoyMKTQ1NtxDJo
 9159XyRgLh4x217t0vqw53B5745KW9Xq3tqozLJ4z+OvRsd0ogRZ+KrC8qBwemRKkH9L
 GwSLboAmSbOQF8Vz8RmwAYvcGh+OVA1XQuPFSSO7Lw4NK4QJId/ZB7zqEI7Y0250ZlpR
 J86Q==
X-Gm-Message-State: AOJu0Yx3a6YJJDwDAGxfwfy6B8t/ewQThqSjXUTP8kxLua6mtQJ/JFdX
 px68hPLIEFAAfGYgLKxzw3pYB6QUIJs8KcJZfkidK5iMGRX5XOurUYozNiSd/XrS/VLWsDFTNiX
 cOifBbUfi3dJhkhdpfKCevg4E6zImcItHgkNOfJCYBmtwU77Fdu0GiriMzM3pLNzMk6r+QNLtsO
 giiiBBMz2iSOlxHPoySXsrIIikW1kLEzAQykueaPDY
X-Gm-Gg: ASbGncuJvigBcxkyugQ98TsQT59mA5AFLRglb68dxLC4DPJD6xKlLSrP8HmM2V/eHVP
 9ZAt48PE4+TvkxQhhDYlgVtjMQrHvfu1+ttselCutk0RT7QeTo42N1162/Za8y+TQik7120mlmo
 e7SVzxbqjX4YAuSBWRGWHdzFJwvRTYZzYfyXkHpBrc8C25ExcytZdV2nYeLU9RDKW4p1Wh0RZlg
 XAysq7+l8eHoj+IfneEqMChQXsbiCFEpbXQCoKUeHe1CpOKNgBrh1xrMAqhTv/EjHOFUXPEWnPi
 cpURUjCUM7gRQHXSIJTh6DbPy8AGb6bTkA3gU9H2K/bxs5/HbMO1xqT5A2c89dRfO3qwFxT9jTA
 rQ15cqPemnDSGGr/wQCVi+LJl9XH7Msccl5qMYlEAPoh1pXmW
X-Received: by 2002:a17:907:d23:b0:b0c:b51b:81f6 with SMTP id
 a640c23a62f3a-b49c4cddb5amr19442866b.43.1759425359332; 
 Thu, 02 Oct 2025 10:15:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyOljzEWMcQL4zKAVndf6Q4zCSjOQpHQkWSKRtf8N46E6vTt/ba5OyjaWuDoiN1aFzEGvytA==
X-Received: by 2002:a17:907:d23:b0:b0c:b51b:81f6 with SMTP id
 a640c23a62f3a-b49c4cddb5amr19439066b.43.1759425358766; 
 Thu, 02 Oct 2025 10:15:58 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.91.106])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b486a1785f2sm238204666b.94.2025.10.02.10.15.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 10:15:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, magnus.kulke@linux.microsoft.com, wei.liu@kernel.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PATCH 08/27] accel/mshv: Register memory region listeners
Date: Thu,  2 Oct 2025 19:15:17 +0200
Message-ID: <20251002171536.1460049-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002171536.1460049-1-pbonzini@redhat.com>
References: <20251002171536.1460049-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.451,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Add memory listener hooks for the MSHV accelerator to track guest
memory regions. This enables the backend to respond to region
additions, removals and will be used to manage guest memory mappings
inside the hypervisor.

Actually registering physical memory in the hypervisor is still stubbed
out.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Link: https://lore.kernel.org/r/20250916164847.77883-9-magnuskulke@linux.microsoft.com
[mshv.h/mshv_int.h split. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/system/mshv_int.h |  4 +++
 accel/mshv/mem.c          | 25 +++++++++++++++
 accel/mshv/mshv-all.c     | 67 +++++++++++++++++++++++++++++++++++++--
 accel/mshv/meson.build    |  1 +
 4 files changed, 95 insertions(+), 2 deletions(-)
 create mode 100644 accel/mshv/mem.c

diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index 132491b599d..cfa177ff72f 100644
--- a/include/system/mshv_int.h
+++ b/include/system/mshv_int.h
@@ -38,4 +38,8 @@ struct MshvState {
     MshvAddressSpace *as;
 };
 
+/* memory */
+void mshv_set_phys_mem(MshvMemoryListener *mml, MemoryRegionSection *section,
+                       bool add);
+
 #endif
diff --git a/accel/mshv/mem.c b/accel/mshv/mem.c
new file mode 100644
index 00000000000..9889918c31f
--- /dev/null
+++ b/accel/mshv/mem.c
@@ -0,0 +1,25 @@
+/*
+ * QEMU MSHV support
+ *
+ * Copyright Microsoft, Corp. 2025
+ *
+ * Authors:
+ *  Magnus Kulke      <magnuskulke@microsoft.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "system/address-spaces.h"
+#include "system/mshv.h"
+#include "system/mshv_int.h"
+
+void mshv_set_phys_mem(MshvMemoryListener *mml, MemoryRegionSection *section,
+                       bool add)
+{
+    error_report("unimplemented");
+    abort();
+}
+
diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index ae12f0f58b9..a684a366775 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -49,10 +49,73 @@ bool mshv_allowed;
 
 MshvState *mshv_state;
 
+static void mem_region_add(MemoryListener *listener,
+                           MemoryRegionSection *section)
+{
+    MshvMemoryListener *mml;
+    mml = container_of(listener, MshvMemoryListener, listener);
+    memory_region_ref(section->mr);
+    mshv_set_phys_mem(mml, section, true);
+}
+
+static void mem_region_del(MemoryListener *listener,
+                           MemoryRegionSection *section)
+{
+    MshvMemoryListener *mml;
+    mml = container_of(listener, MshvMemoryListener, listener);
+    mshv_set_phys_mem(mml, section, false);
+    memory_region_unref(section->mr);
+}
+
+static MemoryListener mshv_memory_listener = {
+    .name = "mshv",
+    .priority = MEMORY_LISTENER_PRIORITY_ACCEL,
+    .region_add = mem_region_add,
+    .region_del = mem_region_del,
+};
+
+static MemoryListener mshv_io_listener = {
+    .name = "mshv", .priority = MEMORY_LISTENER_PRIORITY_DEV_BACKEND,
+    /* MSHV does not support PIO eventfd */
+};
+
+static void register_mshv_memory_listener(MshvState *s, MshvMemoryListener *mml,
+                                          AddressSpace *as, int as_id,
+                                          const char *name)
+{
+    int i;
+
+    mml->listener = mshv_memory_listener;
+    mml->listener.name = name;
+    memory_listener_register(&mml->listener, as);
+    for (i = 0; i < s->nr_as; ++i) {
+        if (!s->as[i].as) {
+            s->as[i].as = as;
+            s->as[i].ml = mml;
+            break;
+        }
+    }
+}
+
 static int mshv_init(AccelState *as, MachineState *ms)
 {
-    error_report("unimplemented");
-    abort();
+    MshvState *s;
+    s = MSHV_STATE(as);
+
+    accel_blocker_init();
+
+    s->vm = 0;
+
+    s->nr_as = 1;
+    s->as = g_new0(MshvAddressSpace, s->nr_as);
+
+    mshv_state = s;
+
+    register_mshv_memory_listener(s, &s->memory_listener, &address_space_memory,
+                                  0, "mshv-memory");
+    memory_listener_register(&mshv_io_listener, &address_space_io);
+
+    return 0;
 }
 
 static void mshv_start_vcpu_thread(CPUState *cpu)
diff --git a/accel/mshv/meson.build b/accel/mshv/meson.build
index 4c03ac79219..8a6beb3fb1e 100644
--- a/accel/mshv/meson.build
+++ b/accel/mshv/meson.build
@@ -1,5 +1,6 @@
 mshv_ss = ss.source_set()
 mshv_ss.add(if_true: files(
+  'mem.c',
   'mshv-all.c'
 ))
 
-- 
2.51.0


