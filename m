Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 774C9C27C77
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 17:19:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sIAZH-000169-Nq; Fri, 14 Jun 2024 13:18:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sIAZF-00015U-DP
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 13:18:25 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sIAZD-00043y-ML
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 13:18:25 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6200320724;
 Fri, 14 Jun 2024 17:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718385502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TrBSPx3LSmG3AYZQqHnKCZnzkS8srk2opnauqCWnh+w=;
 b=cGDEBWxyJ1RogZKRxBLMlnGi8rLNq6qClVN8Z0EL4OxAtkUtOg/KzbCUbppg80qv5N6NrS
 qiMlMGZJlYzluBJOxkWQB70B3yIBQK3AVFvTS+zRAijDl1Ghva1LbvqdMt94ARoxhvmFe6
 bmB0Coqda+pZP5JpcsdNwC3z5Crth3k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718385502;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TrBSPx3LSmG3AYZQqHnKCZnzkS8srk2opnauqCWnh+w=;
 b=u18y6pblX/I9vNPVAcC5nuGIjZzWbRw1N6kqaq+1qSgl2Q9dCyJIsGFWQ3fQOdf1hv0cmd
 aZsy/eFLeJ6nVpBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718385502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TrBSPx3LSmG3AYZQqHnKCZnzkS8srk2opnauqCWnh+w=;
 b=cGDEBWxyJ1RogZKRxBLMlnGi8rLNq6qClVN8Z0EL4OxAtkUtOg/KzbCUbppg80qv5N6NrS
 qiMlMGZJlYzluBJOxkWQB70B3yIBQK3AVFvTS+zRAijDl1Ghva1LbvqdMt94ARoxhvmFe6
 bmB0Coqda+pZP5JpcsdNwC3z5Crth3k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718385502;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TrBSPx3LSmG3AYZQqHnKCZnzkS8srk2opnauqCWnh+w=;
 b=u18y6pblX/I9vNPVAcC5nuGIjZzWbRw1N6kqaq+1qSgl2Q9dCyJIsGFWQ3fQOdf1hv0cmd
 aZsy/eFLeJ6nVpBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BB76A13AB1;
 Fri, 14 Jun 2024 17:18:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kBgyIFx7bGaVAgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 14 Jun 2024 17:18:20 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yuan Liu <yuan1.liu@intel.com>, Nanhai Zou <nanhai.zou@intel.com>
Subject: [PULL 08/18] migration/multifd: add qpl compression method
Date: Fri, 14 Jun 2024 14:17:52 -0300
Message-Id: <20240614171802.28451-9-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240614171802.28451-1-farosas@suse.de>
References: <20240614171802.28451-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,suse.de:email];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Yuan Liu <yuan1.liu@intel.com>

add the Query Processing Library (QPL) compression method

Introduce the qpl as a new multifd migration compression method, it can
use In-Memory Analytics Accelerator(IAA) to accelerate compression and
decompression, which can not only reduce network bandwidth requirement
but also reduce host compression and decompression CPU overhead.

How to enable qpl compression during migration:
migrate_set_parameter multifd-compression qpl

There is no qpl compression level parameter added since it only supports
level one, users do not need to specify the qpl compression level.

Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
[fixed docs spacing in migration.json]
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 hw/core/qdev-properties-system.c |  2 +-
 migration/meson.build            |  1 +
 migration/multifd-qpl.c          | 20 ++++++++++++++++++++
 migration/multifd.h              |  1 +
 qapi/migration.json              |  8 +++++++-
 5 files changed, 30 insertions(+), 2 deletions(-)
 create mode 100644 migration/multifd-qpl.c

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index d79d6f4b53..6ccd7224f6 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -659,7 +659,7 @@ const PropertyInfo qdev_prop_fdc_drive_type = {
 const PropertyInfo qdev_prop_multifd_compression = {
     .name = "MultiFDCompression",
     .description = "multifd_compression values, "
-                   "none/zlib/zstd",
+                   "none/zlib/zstd/qpl",
     .enum_table = &MultiFDCompression_lookup,
     .get = qdev_propinfo_get_enum,
     .set = qdev_propinfo_set_enum,
diff --git a/migration/meson.build b/migration/meson.build
index bdc3244bce..5f146fe8a9 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -39,6 +39,7 @@ endif
 
 system_ss.add(when: rdma, if_true: files('rdma.c'))
 system_ss.add(when: zstd, if_true: files('multifd-zstd.c'))
+system_ss.add(when: qpl, if_true: files('multifd-qpl.c'))
 
 specific_ss.add(when: 'CONFIG_SYSTEM_ONLY',
                 if_true: files('ram.c',
diff --git a/migration/multifd-qpl.c b/migration/multifd-qpl.c
new file mode 100644
index 0000000000..056a68a060
--- /dev/null
+++ b/migration/multifd-qpl.c
@@ -0,0 +1,20 @@
+/*
+ * Multifd qpl compression accelerator implementation
+ *
+ * Copyright (c) 2023 Intel Corporation
+ *
+ * Authors:
+ *  Yuan Liu<yuan1.liu@intel.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+#include "qemu/osdep.h"
+#include "qemu/module.h"
+
+static void multifd_qpl_register(void)
+{
+    /* noop */
+}
+
+migration_init(multifd_qpl_register);
diff --git a/migration/multifd.h b/migration/multifd.h
index c9d9b09239..5b7d9b15f8 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -40,6 +40,7 @@ MultiFDRecvData *multifd_get_recv_data(void);
 #define MULTIFD_FLAG_NOCOMP (0 << 1)
 #define MULTIFD_FLAG_ZLIB (1 << 1)
 #define MULTIFD_FLAG_ZSTD (2 << 1)
+#define MULTIFD_FLAG_QPL (4 << 1)
 
 /* This value needs to be a multiple of qemu_target_page_size() */
 #define MULTIFD_PACKET_SIZE (512 * 1024)
diff --git a/qapi/migration.json b/qapi/migration.json
index a351fd3714..a35d0b5b83 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -554,11 +554,17 @@
 #
 # @zstd: use zstd compression method.
 #
+# @qpl: use qpl compression method.  Query Processing Library(qpl) is
+#       based on the deflate compression algorithm and use the Intel
+#       In-Memory Analytics Accelerator(IAA) accelerated compression
+#       and decompression.  (Since 9.1)
+#
 # Since: 5.0
 ##
 { 'enum': 'MultiFDCompression',
   'data': [ 'none', 'zlib',
-            { 'name': 'zstd', 'if': 'CONFIG_ZSTD' } ] }
+            { 'name': 'zstd', 'if': 'CONFIG_ZSTD' },
+            { 'name': 'qpl', 'if': 'CONFIG_QPL' } ] }
 
 ##
 # @MigMode:
-- 
2.35.3


