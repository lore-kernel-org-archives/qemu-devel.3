Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 705E2C48260
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 13:08:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSzRs-0005Gh-Gh; Thu, 25 Jan 2024 08:07:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1rSzRq-0005CI-2b
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 08:07:14 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1rSzRl-0001lv-On
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 08:07:13 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-558f523c072so7996311a12.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 05:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1706188028; x=1706792828;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JqwuUhHTfJM1dU1KqgMP6mkmdZlMoeSxWaekhK9AsAE=;
 b=NBGS4AQr/ADm6AiVMxIx0Vwej+M19EqWM1srmdIQI5VOON9JK3dM78BuARep4nPDfH
 0tWD5h9RqYLrrSETTLy3YerF/jzYtAM2+La42y5XIOYX9nkNsPoVVC+sk8i1ZpDBONXQ
 zkXPoDo/F2sMhKmCUkXOCMzFmsLOyVF82C+W9hHYWMzLFR+aaR/VYEwGyhBPG52IO2Mx
 PuyUjvgMf9/Q33c1bnw9gVcM2m1aa6jG4rXe8SOaUBAZkrP5wdoEy8R/1D0/JVxn8Z8L
 l6gd0DpQBaC1TU5Z318ur894l4YI9CzCfPcj8mIOdT3s63CsldnG/w8jRAIs6EygrK2P
 /ftA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706188028; x=1706792828;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JqwuUhHTfJM1dU1KqgMP6mkmdZlMoeSxWaekhK9AsAE=;
 b=GE6XYFdjFeobUQbRrRVpIDMmIlzn+FV6/wLgjzT0bu0G7vT0Xu7rypba+CmcY/EV2e
 nuapIf6XsJ+9F1kVtsDp/gE03VbY7LksZ9bHGvJSuXSbeHXHyBVqAuvASy7iF6t2BlrZ
 u9pLhtG0W9vuPQ0KIkHH7cYcwmsmFi+gjulr9RxClvwViqgduZfAEhFoOqKKivrEzfeT
 vjHlKh+amtzhWikoTKB47XtA30bzBpBTGtNCGWY5+q+BbDcZTry0LztMZHvD9CIVckUo
 uMu1/msPmf4hLMYdRBpHoQSTUQvQm1LQ4Wext/MhGTcGnRZkuAuWExRwhG7ZrQiLkEUN
 iL1A==
X-Gm-Message-State: AOJu0Yyb54S/Dv2wNYSRYd7Mv1Tudbz+DKb3mj3/EC3igif3kyhddkcf
 Ke+ISHOjA0lE6OFABtVMQMDPzqtTzPYKHiGfVHpvlsIcRWeltEFon4ZZwoEhGcQ=
X-Google-Smtp-Source: AGHT+IHdSDUR1/X9W5hHsTgCZA3FvtPvUzuVhOSyamEs8I8Qoxv0fTJiWLvWjiWieBpvQPp/ZEV0Cw==
X-Received: by 2002:a50:a454:0:b0:55c:7048:72c1 with SMTP id
 v20-20020a50a454000000b0055c704872c1mr331853edb.127.1706188027741; 
 Thu, 25 Jan 2024 05:07:07 -0800 (PST)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id
 er25-20020a056402449900b0055a829811ddsm6558709edb.48.2024.01.25.05.07.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 05:07:07 -0800 (PST)
From: Andrew Melnychenko <andrew@daynix.com>
To: jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, eblake@redhat.com,
 qemu-devel@nongnu.org, berrange@redhat.com
Cc: yuri.benditovich@daynix.com,
	yan@daynix.com,
	akihiko.odaki@daynix.com
Subject: [PATCH v8 4/5] qmp: Added new command to retrieve eBPF blob.
Date: Thu, 25 Jan 2024 15:06:53 +0200
Message-ID: <20240125130656.425607-5-andrew@daynix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125130656.425607-1-andrew@daynix.com>
References: <20240125130656.425607-1-andrew@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::52e;
 envelope-from=andrew@daynix.com; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Now, the binary objects may be retrieved by id.
It would require for future qmp commands that may require specific
eBPF blob.

Added command "request-ebpf". This command returns
eBPF program encoded base64. The program taken from the
skeleton and essentially is an ELF object that can be
loaded in the future with libbpf.

The reason to use the command to provide the eBPF object
instead of a separate artifact was to avoid issues related
to finding the eBPF itself. eBPF object is an ELF binary
that contains the eBPF program and eBPF map description(BTF).
Overall, eBPF object should contain the program and enough
metadata to create/load eBPF with libbpf. As the eBPF
maps/program should correspond to QEMU, the eBPF can't
be used from different QEMU build.

The first solution was a helper that comes with QEMU
and loads appropriate eBPF objects. And the issue is
to find a proper helper if the system has several
different QEMUs installed and/or built from the source,
which helpers may not be compatible.

Another issue is QEMU updating while there is a running
QEMU instance. With an updated helper, it may not be
possible to hotplug virtio-net device to the already
running QEMU. Overall, requesting the eBPF object from
QEMU itself solves possible failures with acceptable effort.

Links:
[PATCH 3/5] qmp: Added the helper stamp check.
https://lore.kernel.org/all/20230219162100.174318-4-andrew@daynix.com/

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 ebpf/ebpf.c           | 69 +++++++++++++++++++++++++++++++++++++++++++
 ebpf/ebpf.h           | 29 ++++++++++++++++++
 ebpf/ebpf_rss.c       |  6 ++++
 ebpf/meson.build      |  2 +-
 qapi/ebpf.json        | 66 +++++++++++++++++++++++++++++++++++++++++
 qapi/meson.build      |  1 +
 qapi/qapi-schema.json |  1 +
 7 files changed, 173 insertions(+), 1 deletion(-)
 create mode 100644 ebpf/ebpf.c
 create mode 100644 ebpf/ebpf.h
 create mode 100644 qapi/ebpf.json

diff --git a/ebpf/ebpf.c b/ebpf/ebpf.c
new file mode 100644
index 0000000000..2d73beb479
--- /dev/null
+++ b/ebpf/ebpf.c
@@ -0,0 +1,69 @@
+/*
+ * QEMU eBPF binary declaration routine.
+ *
+ * Developed by Daynix Computing LTD (http://www.daynix.com)
+ *
+ * Authors:
+ *  Andrew Melnychenko <andrew@daynix.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/queue.h"
+#include "qapi/error.h"
+#include "qapi/qapi-commands-ebpf.h"
+#include "ebpf/ebpf.h"
+
+typedef struct ElfBinaryDataEntry {
+    int id;
+    const void *data;
+    size_t datalen;
+
+    QSLIST_ENTRY(ElfBinaryDataEntry) node;
+} ElfBinaryDataEntry;
+
+static QSLIST_HEAD(, ElfBinaryDataEntry) ebpf_elf_obj_list =
+                                            QSLIST_HEAD_INITIALIZER();
+
+void ebpf_register_binary_data(int id, const void *data, size_t datalen)
+{
+    struct ElfBinaryDataEntry *dataentry = NULL;
+
+    dataentry = g_new0(struct ElfBinaryDataEntry, 1);
+    dataentry->data = data;
+    dataentry->datalen = datalen;
+    dataentry->id = id;
+
+    QSLIST_INSERT_HEAD(&ebpf_elf_obj_list, dataentry, node);
+}
+
+const void *ebpf_find_binary_by_id(int id, size_t *sz, Error **errp)
+{
+    struct ElfBinaryDataEntry *it = NULL;
+    QSLIST_FOREACH(it, &ebpf_elf_obj_list, node) {
+        if (id == it->id) {
+            *sz = it->datalen;
+            return it->data;
+        }
+    }
+
+    error_setg(errp, "can't find eBPF object with id: %d", id);
+
+    return NULL;
+}
+
+EbpfObject *qmp_request_ebpf(EbpfProgramID id, Error **errp)
+{
+    EbpfObject *ret = NULL;
+    size_t size = 0;
+    const void *data = ebpf_find_binary_by_id(id, &size, errp);
+    if (!data) {
+        return NULL;
+    }
+
+    ret = g_new0(EbpfObject, 1);
+    ret->object = g_base64_encode(data, size);
+
+    return ret;
+}
diff --git a/ebpf/ebpf.h b/ebpf/ebpf.h
new file mode 100644
index 0000000000..378d4e9c70
--- /dev/null
+++ b/ebpf/ebpf.h
@@ -0,0 +1,29 @@
+/*
+ * QEMU eBPF binary declaration routine.
+ *
+ * Developed by Daynix Computing LTD (http://www.daynix.com)
+ *
+ * Authors:
+ *  Andrew Melnychenko <andrew@daynix.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef EBPF_H
+#define EBPF_H
+
+
+void ebpf_register_binary_data(int id, const void *data,
+                               size_t datalen);
+const void *ebpf_find_binary_by_id(int id, size_t *sz,
+                                   struct Error **errp);
+
+#define ebpf_binary_init(id, fn)                                           \
+static void __attribute__((constructor)) ebpf_binary_init_ ## fn(void)     \
+{                                                                          \
+    size_t datalen = 0;                                                    \
+    const void *data = fn(&datalen);                                       \
+    ebpf_register_binary_data(id, data, datalen);                          \
+}
+
+#endif /* EBPF_H */
diff --git a/ebpf/ebpf_rss.c b/ebpf/ebpf_rss.c
index 20c44f2baa..2fa632a98c 100644
--- a/ebpf/ebpf_rss.c
+++ b/ebpf/ebpf_rss.c
@@ -12,6 +12,8 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "qapi/qapi-types-misc.h"
+#include "qapi/qapi-commands-ebpf.h"
 
 #include <bpf/libbpf.h>
 #include <bpf/bpf.h>
@@ -20,6 +22,8 @@
 
 #include "ebpf/ebpf_rss.h"
 #include "ebpf/rss.bpf.skeleton.h"
+#include "ebpf/ebpf.h"
+
 #include "trace.h"
 
 void ebpf_rss_init(struct EBPFRSSContext *ctx)
@@ -260,3 +264,5 @@ void ebpf_rss_unload(struct EBPFRSSContext *ctx)
     ctx->map_toeplitz_key = -1;
     ctx->map_indirections_table = -1;
 }
+
+ebpf_binary_init(EBPF_PROGRAMID_RSS, rss_bpf__elf_bytes)
diff --git a/ebpf/meson.build b/ebpf/meson.build
index 2f627d6c7d..c5bf9295a2 100644
--- a/ebpf/meson.build
+++ b/ebpf/meson.build
@@ -1 +1 @@
-system_ss.add(when: libbpf, if_true: files('ebpf_rss.c'), if_false: files('ebpf_rss-stub.c'))
+common_ss.add(when: libbpf, if_true: files('ebpf.c', 'ebpf_rss.c'), if_false: files('ebpf_rss-stub.c'))
diff --git a/qapi/ebpf.json b/qapi/ebpf.json
new file mode 100644
index 0000000000..f413d00154
--- /dev/null
+++ b/qapi/ebpf.json
@@ -0,0 +1,66 @@
+# -*- Mode: Python -*-
+# vim: filetype=python
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or later.
+# See the COPYING file in the top-level directory.
+
+##
+# = eBPF Objects
+#
+# eBPF object is an ELF binary that contains the eBPF
+# program and eBPF map description(BTF). Overall, eBPF
+# object should contain the program and enough metadata
+# to create/load eBPF with libbpf. As the eBPF maps/program
+# should correspond to QEMU, the eBPF can't be used from
+# different QEMU build.
+#
+# Currently, there is a possible eBPF for receive-side scaling (RSS).
+#
+##
+
+##
+# @EbpfObject:
+#
+# An eBPF ELF object.
+#
+# @object: the eBPF object encoded in base64
+#
+# Since: 9.0
+##
+{ 'struct': 'EbpfObject',
+  'data': {'object': 'str'},
+  'if': 'CONFIG_EBPF' }
+
+##
+# @EbpfProgramID:
+#
+# The eBPF programs that can be gotten with request-ebpf.
+#
+# @rss: Receive side scaling, technology that allows steering traffic
+#     between queues by calculation hash.  Users may set up
+#     indirection table and hash/packet types configurations.  Used
+#     with virtio-net.
+#
+# Since: 9.0
+##
+{ 'enum': 'EbpfProgramID',
+  'if': 'CONFIG_EBPF',
+  'data': [ { 'name': 'rss' } ] }
+
+##
+# @request-ebpf:
+#
+# Retrieve an eBPF object that can be loaded with libbpf.  Management
+# applications (g.e. libvirt) may load it and pass file descriptors to
+# QEMU, so they can run running QEMU without BPF capabilities.
+#
+# @id: The ID of the program to return.
+#
+# Returns: eBPF object encoded in base64.
+#
+# Since: 9.0
+##
+{ 'command': 'request-ebpf',
+  'data': { 'id': 'EbpfProgramID' },
+  'returns': 'EbpfObject',
+  'if': 'CONFIG_EBPF' }
diff --git a/qapi/meson.build b/qapi/meson.build
index f81a37565c..375d564277 100644
--- a/qapi/meson.build
+++ b/qapi/meson.build
@@ -33,6 +33,7 @@ qapi_all_modules = [
   'crypto',
   'cxl',
   'dump',
+  'ebpf',
   'error',
   'introspect',
   'job',
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index c01ec335e6..8304d45625 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -53,6 +53,7 @@
 { 'include': 'char.json' }
 { 'include': 'dump.json' }
 { 'include': 'net.json' }
+{ 'include': 'ebpf.json' }
 { 'include': 'rdma.json' }
 { 'include': 'rocker.json' }
 { 'include': 'tpm.json' }
-- 
2.43.0


