Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1353FE7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 15:18:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLkpU-0003zw-RR; Thu, 12 Dec 2024 10:10:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tLkpQ-0003y7-3o
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 10:10:12 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tLkpO-0003Cu-As
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 10:10:11 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2324E21137;
 Thu, 12 Dec 2024 15:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734016209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TQe1/UfXpSagSi+xDbzcIbXo6oH8Dh8KdoWNwhc1ZSc=;
 b=lWxRkPOaNP69/KMQrFsIlTpZ1Hj3CKTp83mEJt+eQT3dRhZ6NUyls7fq1UoSP6Lf4zr72n
 3/XGNySNbxhZRpT9VzqcQcl0fLI5BVJCBfsQwMSveHh+Ro7MSsRbeTZ4rAraoT7bgaNBrr
 NL3CPMLqbPAVGxnFWC5J4HvX0jGcBOc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734016209;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TQe1/UfXpSagSi+xDbzcIbXo6oH8Dh8KdoWNwhc1ZSc=;
 b=Xe2oxSzbaDjpSc/rYivFcWPF1wITc2daYgCqBZWHIt66lHojUMTLLonE+JSRyq7FsUexDq
 WGYXD9IzILxONiAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lWxRkPOa;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Xe2oxSzb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734016209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TQe1/UfXpSagSi+xDbzcIbXo6oH8Dh8KdoWNwhc1ZSc=;
 b=lWxRkPOaNP69/KMQrFsIlTpZ1Hj3CKTp83mEJt+eQT3dRhZ6NUyls7fq1UoSP6Lf4zr72n
 3/XGNySNbxhZRpT9VzqcQcl0fLI5BVJCBfsQwMSveHh+Ro7MSsRbeTZ4rAraoT7bgaNBrr
 NL3CPMLqbPAVGxnFWC5J4HvX0jGcBOc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734016209;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TQe1/UfXpSagSi+xDbzcIbXo6oH8Dh8KdoWNwhc1ZSc=;
 b=Xe2oxSzbaDjpSc/rYivFcWPF1wITc2daYgCqBZWHIt66lHojUMTLLonE+JSRyq7FsUexDq
 WGYXD9IzILxONiAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F44013508;
 Thu, 12 Dec 2024 15:10:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MP4fOc/8WmcTfQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 12 Dec 2024 15:10:07 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 10/22] tests/qtest/migration: Rename migration-helpers.c
Date: Thu, 12 Dec 2024 12:09:37 -0300
Message-Id: <20241212150949.16806-11-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241212150949.16806-1-farosas@suse.de>
References: <20241212150949.16806-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2324E21137
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.de:email, suse.de:dkim, suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Rename migration-helpers.c to migration-util.c to make its purpose
more explicit and avoid the "helper" terminology.

Move the file to the qtest/migration/ directory along with the rest of
the migration files.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/meson.build                                     | 4 ++--
 tests/qtest/migration-test.c                                | 2 +-
 tests/qtest/migration/migration-qmp.c                       | 2 +-
 tests/qtest/migration/migration-qmp.h                       | 2 ++
 .../{migration-helpers.c => migration/migration-util.c}     | 4 ++--
 .../{migration-helpers.h => migration/migration-util.h}     | 6 +++---
 tests/qtest/virtio-net-failover.c                           | 2 +-
 7 files changed, 12 insertions(+), 10 deletions(-)
 rename tests/qtest/{migration-helpers.c => migration/migration-util.c} (99%)
 rename tests/qtest/{migration-helpers.h => migration/migration-util.h} (94%)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 0b113adc5c..ec809af0c8 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -333,9 +333,9 @@ endif
 tpmemu_files = ['tpm-emu.c', 'tpm-util.c', 'tpm-tests.c']
 
 migration_files = [files(
-  'migration-helpers.c',
   'migration/bootfile.c',
   'migration/migration-qmp.c',
+  'migration/migration-util.c',
 )]
 
 if gnutls.found()
@@ -350,7 +350,7 @@ qtests = {
   'bios-tables-test': [io, 'boot-sector.c', 'acpi-utils.c', 'tpm-emu.c'],
   'cdrom-test': files('boot-sector.c'),
   'dbus-vmstate-test': files('migration/migration-qmp.c',
-                             'migration-helpers.c') + dbus_vmstate1,
+                             'migration/migration-util.c') + dbus_vmstate1,
   'erst-test': files('erst-test.c'),
   'ivshmem-test': [rt, '../../contrib/ivshmem-server/ivshmem-server.c'],
   'migration-test': migration_files,
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 489fca7071..e295bd3081 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -22,9 +22,9 @@
 #include "crypto/tlscredspsk.h"
 #include "ppc-util.h"
 
-#include "migration-helpers.h"
 #include "migration/bootfile.h"
 #include "migration/migration-qmp.h"
+#include "migration/migration-util.h"
 #ifdef CONFIG_GNUTLS
 # include "tests/unit/crypto-tls-psk-helpers.h"
 # ifdef CONFIG_TASN1
diff --git a/tests/qtest/migration/migration-qmp.c b/tests/qtest/migration/migration-qmp.c
index 20be46fdf6..71b14b51b2 100644
--- a/tests/qtest/migration/migration-qmp.c
+++ b/tests/qtest/migration/migration-qmp.c
@@ -12,8 +12,8 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
-#include "migration-helpers.h"
 #include "migration-qmp.h"
+#include "migration-util.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qjson.h"
diff --git a/tests/qtest/migration/migration-qmp.h b/tests/qtest/migration/migration-qmp.h
index ed927cf408..caaa78722a 100644
--- a/tests/qtest/migration/migration-qmp.h
+++ b/tests/qtest/migration/migration-qmp.h
@@ -2,6 +2,8 @@
 #ifndef MIGRATION_QMP_H
 #define MIGRATION_QMP_H
 
+#include "migration-util.h"
+
 G_GNUC_PRINTF(4, 5)
 void migrate_qmp_fail(QTestState *who, const char *uri,
                       const char *channels, const char *fmt, ...);
diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration/migration-util.c
similarity index 99%
rename from tests/qtest/migration-helpers.c
rename to tests/qtest/migration/migration-util.c
index 218ee4e59f..8a974ded22 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration/migration-util.c
@@ -1,5 +1,5 @@
 /*
- * QTest migration helpers
+ * QTest migration utilities
  *
  * Copyright (c) 2016-2018 Red Hat, Inc. and/or its affiliates
  *   based on the vhost-user-test.c that is:
@@ -19,8 +19,8 @@
 #include "qemu/cutils.h"
 #include "qemu/memalign.h"
 
-#include "migration-helpers.h"
 #include "migration/bootfile.h"
+#include "migration/migration-util.h"
 
 static char *SocketAddress_to_str(SocketAddress *addr)
 {
diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration/migration-util.h
similarity index 94%
rename from tests/qtest/migration-helpers.h
rename to tests/qtest/migration/migration-util.h
index 2cb1f78d9e..0fa3676235 100644
--- a/tests/qtest/migration-helpers.h
+++ b/tests/qtest/migration/migration-util.h
@@ -10,8 +10,8 @@
  *
  */
 
-#ifndef MIGRATION_HELPERS_H
-#define MIGRATION_HELPERS_H
+#ifndef MIGRATION_UTIL_H
+#define MIGRATION_UTIL_H
 
 #include "libqtest.h"
 
@@ -51,4 +51,4 @@ void migration_test_add(const char *path, void (*fn)(void));
 char *migrate_get_connect_uri(QTestState *who);
 void migrate_set_ports(QTestState *to, QList *channel_list);
 
-#endif /* MIGRATION_HELPERS_H */
+#endif /* MIGRATION_UTIL_H */
diff --git a/tests/qtest/virtio-net-failover.c b/tests/qtest/virtio-net-failover.c
index 28a6147d9a..08365ffa11 100644
--- a/tests/qtest/virtio-net-failover.c
+++ b/tests/qtest/virtio-net-failover.c
@@ -11,8 +11,8 @@
 #include "libqtest.h"
 #include "libqos/pci.h"
 #include "libqos/pci-pc.h"
-#include "migration-helpers.h"
 #include "migration/migration-qmp.h"
+#include "migration/migration-util.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qlist.h"
 #include "qapi/qmp/qjson.h"
-- 
2.35.3


