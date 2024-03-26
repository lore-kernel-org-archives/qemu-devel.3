Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD6DDCD11DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 22:44:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpFWL-0006AV-VW; Tue, 26 Mar 2024 18:43:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bryan.zhang@bytedance.com>)
 id 1rpFWK-0006AF-LM
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 18:43:52 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bryan.zhang@bytedance.com>)
 id 1rpFWI-0007bq-HS
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 18:43:52 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6e6a5bd015dso2865306a34.2
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 15:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1711493029; x=1712097829; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E2+htT0Abm6Y4hPWnu3Iu305PtkzW44cwWugxR7RsCs=;
 b=UdDKIg84WjYOlF3vWLEjzoL8Tbxgo6KAWCB35Sxy3L5f7MO3vaVzqUGMeW3zQPlvHe
 otetl79JLx5zJ6xU+fv51LwpGjiaJlCaQJ9xsWlCmNNm6P2LK4uG0pIjd+BlIg89R8/K
 OizUGEd1rOpHC6BBdzt0b6dOTBSrPTg3YBDU4+0bJQU3J8Xw0Lw4s7YaRu9EZJBFj+Aj
 X10HzvwNdNdx7UlEOibyv7Lup0EiIFQyzPHNmozmESR9g78qpRJZLfunlHYy0DsWS1a1
 lZJscgDuPYJnpFoV3S0CWy7DQgtYWnNuAlG9vcj2QViJQxi9fOqwhggPK1SrvwMYvzIu
 Pkiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711493029; x=1712097829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E2+htT0Abm6Y4hPWnu3Iu305PtkzW44cwWugxR7RsCs=;
 b=mwiDszCO2HzdgaKUOObDS5ephqW/B0lUEkruU6ntimbgH6mZWn5lW2APR2DMILqyAf
 TBJlPDDSYNK10kJWh5Y2JExqUq1J7R/BTkSvI5zQKObZh3yoYIWxyIncPf02UxiAOfQO
 gLKZUX0WAqN+g7G/7QsunYyvCabz75LXKAntil2B7U9Oo94wAiKcOpeq2CsBioDFKChG
 drF5ob+Vjo6iXkGtUfvowbb4DYeeRmxRAEcd43uUsBm038ShXYIt1kui4MXfdWAo/SdW
 V9DFkOit9eoMnYoGVCQr4iOXY7AMustLKz86f4CHW/06uWhkWVxseU+mb3bcn6gzVyEm
 u0Qw==
X-Gm-Message-State: AOJu0YwxsVmFFV0Dnvz8RIJA5IlMUAMyNPrP+9KQXSLFkiUrRyC4vrE1
 wb0VDr6bUxYOD5DLciujuZ9841T74ykxlUQynAWajeQORrZr2UNwUsPAKUKtAHQpNcvOGTz7xR2
 z
X-Google-Smtp-Source: AGHT+IGQcacerCylv8HxykbNRfarkzrWBGTEbP/GOyYQp2UVoKstb7ui+hN+lhYJVgDKGTx1tvyHCQ==
X-Received: by 2002:a05:6830:10d0:b0:6e6:6c3b:58bd with SMTP id
 z16-20020a05683010d000b006e66c3b58bdmr916261oto.29.1711493029015; 
 Tue, 26 Mar 2024 15:43:49 -0700 (PDT)
Received: from n36-186-108.byted.org. ([147.160.184.146])
 by smtp.gmail.com with ESMTPSA id
 x15-20020a05620a0ecf00b007887d30dbb7sm3397816qkm.60.2024.03.26.15.43.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Mar 2024 15:43:48 -0700 (PDT)
From: Bryan Zhang <bryan.zhang@bytedance.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, yuan1.liu@intel.com,
 berrange@redhat.com, nanhai.zou@intel.com, hao.xiang@linux.dev,
 Bryan Zhang <bryan.zhang@bytedance.com>
Subject: [PATCH v2 3/5] migration: Introduce unimplemented 'qatzip'
 compression method
Date: Tue, 26 Mar 2024 22:42:19 +0000
Message-Id: <20240326224221.3623014-4-bryan.zhang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240326224221.3623014-1-bryan.zhang@bytedance.com>
References: <20240326224221.3623014-1-bryan.zhang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=bryan.zhang@bytedance.com; helo=mail-ot1-x335.google.com
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

Adds support for 'qatzip' as an option for the multifd compression
method parameter, but copy-pastes the no-op logic to leave the actual
methods effectively unimplemented. This is in preparation of a subsequent
commit that will implement actually using QAT for compression and
decompression.

Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
---
 hw/core/qdev-properties-system.c |   6 +-
 migration/meson.build            |   1 +
 migration/multifd-qatzip.c       | 117 +++++++++++++++++++++++++++++++
 migration/multifd.h              |   1 +
 qapi/migration.json              |   5 +-
 tests/qtest/meson.build          |   4 ++
 6 files changed, 132 insertions(+), 2 deletions(-)
 create mode 100644 migration/multifd-qatzip.c

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 1a396521d5..d8e48dcb0e 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -658,7 +658,11 @@ const PropertyInfo qdev_prop_fdc_drive_type = {
 const PropertyInfo qdev_prop_multifd_compression = {
     .name = "MultiFDCompression",
     .description = "multifd_compression values, "
-                   "none/zlib/zstd",
+                   "none/zlib/zstd"
+#ifdef CONFIG_QATZIP
+                   "/qatzip"
+#endif
+                   ,
     .enum_table = &MultiFDCompression_lookup,
     .get = qdev_propinfo_get_enum,
     .set = qdev_propinfo_set_enum,
diff --git a/migration/meson.build b/migration/meson.build
index 92b1cc4297..e20f318379 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -40,6 +40,7 @@ if get_option('live_block_migration').allowed()
   system_ss.add(files('block.c'))
 endif
 system_ss.add(when: zstd, if_true: files('multifd-zstd.c'))
+system_ss.add(when: qatzip, if_true: files('multifd-qatzip.c'))
 
 specific_ss.add(when: 'CONFIG_SYSTEM_ONLY',
                 if_true: files('ram.c',
diff --git a/migration/multifd-qatzip.c b/migration/multifd-qatzip.c
new file mode 100644
index 0000000000..f66336a4a7
--- /dev/null
+++ b/migration/multifd-qatzip.c
@@ -0,0 +1,117 @@
+/*
+ * Multifd QATzip compression implementation
+ *
+ * Copyright (c) Bytedance
+ *
+ * Authors:
+ *  Bryan Zhang <bryan.zhang@bytedance.com>
+ *  Hao Xiang   <hao.xiang@bytedance.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "exec/ramblock.h"
+#include "exec/target_page.h"
+#include "qapi/error.h"
+#include "migration.h"
+#include "options.h"
+#include "multifd.h"
+
+/*
+ * This is an intermediary file to introduce 'qatzip' as an option for multifd
+ * compression. The actual method implementations are no-ops.
+ */
+
+static int qatzip_send_setup(MultiFDSendParams *p, Error **errp)
+{
+    if (migrate_zero_copy_send()) {
+        p->write_flags |= QIO_CHANNEL_WRITE_FLAG_ZERO_COPY;
+    }
+
+    return 0;
+}
+
+static void qatzip_send_cleanup(MultiFDSendParams *p, Error **errp)
+{
+    return;
+}
+
+static int qatzip_send_prepare(MultiFDSendParams *p, Error **errp)
+{
+    bool use_zero_copy_send = migrate_zero_copy_send();
+    MultiFDPages_t *pages = p->pages;
+    int ret;
+
+    if (!use_zero_copy_send) {
+        /*
+         * Only !zerocopy needs the header in IOV; zerocopy will
+         * send it separately.
+         */
+        multifd_send_prepare_header(p);
+    }
+
+    for (int i = 0; i < pages->num; i++) {
+        p->iov[p->iovs_num].iov_base = pages->block->host + pages->offset[i];
+        p->iov[p->iovs_num].iov_len = p->page_size;
+        p->iovs_num++;
+    }
+
+    p->next_packet_size = pages->num * p->page_size;
+    p->flags |= MULTIFD_FLAG_NOCOMP;
+
+    multifd_send_fill_packet(p);
+
+    if (use_zero_copy_send) {
+        /* Send header first, without zerocopy */
+        ret = qio_channel_write_all(p->c, (void *)p->packet,
+                                    p->packet_len, errp);
+        if (ret != 0) {
+            return -1;
+        }
+    }
+
+    return 0;
+}
+
+static int qatzip_recv_setup(MultiFDRecvParams *p, Error **errp)
+{
+    return 0;
+}
+
+static void qatzip_recv_cleanup(MultiFDRecvParams *p)
+{
+}
+
+static int qatzip_recv_pages(MultiFDRecvParams *p, Error **errp)
+{
+    uint32_t flags = p->flags & MULTIFD_FLAG_COMPRESSION_MASK;
+
+    if (flags != MULTIFD_FLAG_NOCOMP) {
+        error_setg(errp, "multifd %u: flags received %x flags expected %x",
+                   p->id, flags, MULTIFD_FLAG_NOCOMP);
+        return -1;
+    }
+    for (int i = 0; i < p->normal_num; i++) {
+        p->iov[i].iov_base = p->host + p->normal[i];
+        p->iov[i].iov_len = p->page_size;
+    }
+    return qio_channel_readv_all(p->c, p->iov, p->normal_num, errp);
+}
+
+static MultiFDMethods multifd_qatzip_ops = {
+    .send_setup = qatzip_send_setup,
+    .send_cleanup = qatzip_send_cleanup,
+    .send_prepare = qatzip_send_prepare,
+    .recv_setup = qatzip_recv_setup,
+    .recv_cleanup = qatzip_recv_cleanup,
+    .recv_pages = qatzip_recv_pages
+};
+
+static void multifd_qatzip_register(void)
+{
+    multifd_register_ops(MULTIFD_COMPRESSION_QATZIP, &multifd_qatzip_ops);
+}
+
+migration_init(multifd_qatzip_register);
diff --git a/migration/multifd.h b/migration/multifd.h
index b3fe27ae93..ae73f1713c 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -33,6 +33,7 @@ bool multifd_queue_page(RAMBlock *block, ram_addr_t offset);
 #define MULTIFD_FLAG_NOCOMP (0 << 1)
 #define MULTIFD_FLAG_ZLIB (1 << 1)
 #define MULTIFD_FLAG_ZSTD (2 << 1)
+#define MULTIFD_FLAG_QATZIP (3 << 1)
 
 /* This value needs to be a multiple of qemu_target_page_size() */
 #define MULTIFD_PACKET_SIZE (512 * 1024)
diff --git a/qapi/migration.json b/qapi/migration.json
index 66ea6d32fc..9018166ac8 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -625,11 +625,14 @@
 #
 # @zstd: use zstd compression method.
 #
+# @qatzip: use qatzip compression method.
+#
 # Since: 5.0
 ##
 { 'enum': 'MultiFDCompression',
   'data': [ 'none', 'zlib',
-            { 'name': 'zstd', 'if': 'CONFIG_ZSTD' } ] }
+            { 'name': 'zstd', 'if': 'CONFIG_ZSTD' },
+            { 'name': 'qatzip', 'if': 'CONFIG_QATZIP'} ] }
 
 ##
 # @MigMode:
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 6ea77893f5..539104c06d 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -315,6 +315,10 @@ if gnutls.found()
   endif
 endif
 
+if qatzip.found()
+  migration_files += [qatzip]
+endif
+
 qtests = {
   'bios-tables-test': [io, 'boot-sector.c', 'acpi-utils.c', 'tpm-emu.c'],
   'cdrom-test': files('boot-sector.c'),
-- 
2.30.2


