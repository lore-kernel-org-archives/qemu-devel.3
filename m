Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D2C3C27C6E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 17:19:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sIAZV-0001AF-9N; Fri, 14 Jun 2024 13:18:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sIAZS-00018u-I7
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 13:18:38 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sIAZQ-00047g-KM
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 13:18:38 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0017220728;
 Fri, 14 Jun 2024 17:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718385515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QraaRodgcIYNu8jkrWwRQj/dxHjZULEGFRoh2RfEryk=;
 b=KHY/b444rPNGff9q5EDmIo5AZSyBwI1hYkp0eyN/5KiSoI/2wzzL3AUi8xbQshDCyz+lK4
 FMXI+dm3QHf90DNk4t501XKoXMguXmpfKS3QAO009sNb3unaC65V0HwU3dvFcsoyUZo0pQ
 48Lb3bZWXmZRRar9MklpiV5TPAxPHVA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718385515;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QraaRodgcIYNu8jkrWwRQj/dxHjZULEGFRoh2RfEryk=;
 b=WP4jw/PkHiAuphfR6s62H5V9jNXGokKy1+DPUF4GcqVngJwPOzWDLB/epBN2EpWFChIdWO
 fQH3kFrD92oCXLCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="KHY/b444";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="WP4jw/Pk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718385515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QraaRodgcIYNu8jkrWwRQj/dxHjZULEGFRoh2RfEryk=;
 b=KHY/b444rPNGff9q5EDmIo5AZSyBwI1hYkp0eyN/5KiSoI/2wzzL3AUi8xbQshDCyz+lK4
 FMXI+dm3QHf90DNk4t501XKoXMguXmpfKS3QAO009sNb3unaC65V0HwU3dvFcsoyUZo0pQ
 48Lb3bZWXmZRRar9MklpiV5TPAxPHVA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718385515;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QraaRodgcIYNu8jkrWwRQj/dxHjZULEGFRoh2RfEryk=;
 b=WP4jw/PkHiAuphfR6s62H5V9jNXGokKy1+DPUF4GcqVngJwPOzWDLB/epBN2EpWFChIdWO
 fQH3kFrD92oCXLCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1B9F513AB5;
 Fri, 14 Jun 2024 17:18:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UEn6NGh7bGaVAgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 14 Jun 2024 17:18:32 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Markus Armbruster <armbru@redhat.com>,
 Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PULL 14/18] migration/multifd: add uadk compression framework
Date: Fri, 14 Jun 2024 14:17:58 -0300
Message-Id: <20240614171802.28451-15-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240614171802.28451-1-farosas@suse.de>
References: <20240614171802.28451-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0017220728
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_FIVE(0.00)[6];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,linaro.org:email]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Adds the skeleton to support uadk compression method.
Complete functionality will be added in subsequent patches.

Acked-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 hw/core/qdev-properties-system.c |  2 +-
 migration/meson.build            |  1 +
 migration/multifd-uadk.c         | 20 ++++++++++++++++++++
 migration/multifd.h              |  5 +++--
 qapi/migration.json              |  5 ++++-
 5 files changed, 29 insertions(+), 4 deletions(-)
 create mode 100644 migration/multifd-uadk.c

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 6ccd7224f6..f13350b4fb 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -659,7 +659,7 @@ const PropertyInfo qdev_prop_fdc_drive_type = {
 const PropertyInfo qdev_prop_multifd_compression = {
     .name = "MultiFDCompression",
     .description = "multifd_compression values, "
-                   "none/zlib/zstd/qpl",
+                   "none/zlib/zstd/qpl/uadk",
     .enum_table = &MultiFDCompression_lookup,
     .get = qdev_propinfo_get_enum,
     .set = qdev_propinfo_set_enum,
diff --git a/migration/meson.build b/migration/meson.build
index 5f146fe8a9..5ce2acb41e 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -40,6 +40,7 @@ endif
 system_ss.add(when: rdma, if_true: files('rdma.c'))
 system_ss.add(when: zstd, if_true: files('multifd-zstd.c'))
 system_ss.add(when: qpl, if_true: files('multifd-qpl.c'))
+system_ss.add(when: uadk, if_true: files('multifd-uadk.c'))
 
 specific_ss.add(when: 'CONFIG_SYSTEM_ONLY',
                 if_true: files('ram.c',
diff --git a/migration/multifd-uadk.c b/migration/multifd-uadk.c
new file mode 100644
index 0000000000..c2bb07535b
--- /dev/null
+++ b/migration/multifd-uadk.c
@@ -0,0 +1,20 @@
+/*
+ * Multifd UADK compression accelerator implementation
+ *
+ * Copyright (c) 2024 Huawei Technologies R & D (UK) Ltd
+ *
+ * Authors:
+ *  Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/module.h"
+
+static void multifd_uadk_register(void)
+{
+    /* noop for now */
+}
+migration_init(multifd_uadk_register);
diff --git a/migration/multifd.h b/migration/multifd.h
index 5b7d9b15f8..0ecd6f47d7 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -34,13 +34,14 @@ MultiFDRecvData *multifd_get_recv_data(void);
 /* Multifd Compression flags */
 #define MULTIFD_FLAG_SYNC (1 << 0)
 
-/* We reserve 3 bits for compression methods */
-#define MULTIFD_FLAG_COMPRESSION_MASK (7 << 1)
+/* We reserve 4 bits for compression methods */
+#define MULTIFD_FLAG_COMPRESSION_MASK (0xf << 1)
 /* we need to be compatible. Before compression value was 0 */
 #define MULTIFD_FLAG_NOCOMP (0 << 1)
 #define MULTIFD_FLAG_ZLIB (1 << 1)
 #define MULTIFD_FLAG_ZSTD (2 << 1)
 #define MULTIFD_FLAG_QPL (4 << 1)
+#define MULTIFD_FLAG_UADK (8 << 1)
 
 /* This value needs to be a multiple of qemu_target_page_size() */
 #define MULTIFD_PACKET_SIZE (512 * 1024)
diff --git a/qapi/migration.json b/qapi/migration.json
index a35d0b5b83..470f746cc5 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -559,12 +559,15 @@
 #       In-Memory Analytics Accelerator(IAA) accelerated compression
 #       and decompression.  (Since 9.1)
 #
+# @uadk: use UADK library compression method.  (Since 9.1)
+#
 # Since: 5.0
 ##
 { 'enum': 'MultiFDCompression',
   'data': [ 'none', 'zlib',
             { 'name': 'zstd', 'if': 'CONFIG_ZSTD' },
-            { 'name': 'qpl', 'if': 'CONFIG_QPL' } ] }
+            { 'name': 'qpl', 'if': 'CONFIG_QPL' },
+            { 'name': 'uadk', 'if': 'CONFIG_UADK' } ] }
 
 ##
 # @MigMode:
-- 
2.35.3


