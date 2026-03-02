Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36AF0E9B34B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 10:18:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx0Hv-00051P-9B; Mon, 02 Mar 2026 05:14:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0HU-0004rt-Rj
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:13:42 -0500
Received: from mout.web.de ([217.72.192.78])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0HQ-000629-RS
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:13:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772446415; x=1773051215; i=lukasstraub2@web.de;
 bh=33sel1R6xmv+QDaM+Qknckw/SZLjCwKZac5wOjHfvAQ=;
 h=X-UI-Sender-Class:From:To:Subject:Date:Message-Id:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=FtXn3WvLLQqDuhvyGIyyAJ0hcSKkbrGBkx1wOKt3hZTFprbRpALfpbhEH40vmetl
 rTKoB1qu2bLMnCs8FT60wHMBwUvKalBMFqOb1t2b4kH1Q4SST7bJ6Bq5Lhjnj5zM9
 TQJlb5ApO133qDuqO6c6ZHDh9JCiXn9dtEB+mnCePWEUfmOnCR62A4wzFyIM3EL4a
 dynW9+tlxj/b2PyvVJSWOFMUUdmcNhJ6PT8vPtSwM9kJ15fERITcgjtMQfi35q+if
 TwwAMVvzD/2GccUF/KOrcNWhJlvYNWDu4/OgJ6jSn58aEZnnXmglg53wBxidnqA5L
 GbOCMXEzYqyuIN8PVQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mm9Zi-1vF6p44BAe-00miNq for
 <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 11:13:35 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Subject: [PATCH v11 08/21] multifd: Add COLO support
Date: Mon,  2 Mar 2026 11:13:19 +0100
Message-Id: <20260302-colo_unit_test_multifd-v11-8-3dae81d203ff@web.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260302-colo_unit_test_multifd-v11-0-3dae81d203ff@web.de>
References: <20260302-colo_unit_test_multifd-v11-0-3dae81d203ff@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7788; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=zU0pffC07Smwy5Vv0eISnBt0LkAaS5xWcGKzaE9qTeU=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppWAFBMiQCporRpDy+SYrNstTTiTEn7lAvHuAv
 vptwkSq2w2JAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaVgBQAKCRA1qwsonF2y
 WNxXEAC1DmnAYA+zJrlxxJtFYJ8IcELmxhnEBNnpjkHrIBM0GfjU2M8gCFmahk4COT/DUT0xG6d
 gyRTueboqvbsf5NwnRnx6nubYO8C0HKSbVDP7kg2Jnv59aU1mrWzEHC2sKobPsilrCQ2v9Am7eu
 uXGeV1Bostj/4+QHAx7ZzCesoYyb39dtITdcUb/zKTATdpxr6ip15P3LsC0W7EnE4jlKnsTkO8f
 zbD8BQkpHrR1iWdigjYMUL9WAvpgw1MnGnMOljLprNzC7gn1mRmq2zLCvFm+TUFZN59HMSSZ0Ug
 R9S7asTZlYQki01QzOwErXsuWp/R+l2Wry9Vt2sc7xhjlUzVrmcPp92UnaqRsedmfXbZXvKTwHo
 xUJuwrZKx4CKMNGRnrlbtoP6KoWxPDYzQeXQ7nttJ1oE0IY6WSp5bqweBvKChtyAbhIsROEQEse
 7rVdot605Bh8avGsmCoxSYbHm5mNF+bA8H5p6GHiY5h3Mt8Fy4ak1SunrMh9JWpujZBYttb7Ubf
 aiA0jokk5UXVSepPmct5Zufbu2Tuj3ZkwL6le5t7nNGy2hc29SvXcF+6/mFs+9HB63rjFkwN3XX
 meg9j0ZxdELd89Oqm01+GC09+kGp9KZI3ZbmEdCqL6tx4uzw9fVEaTsu02DXujnhkMNqG3QGOTh
 irltK6BP5nC9uig==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IVIjNhVEpYKqNfkgeXXJ+8R9oczJneMjHj7AHCdGIyQjgzZPb6e
 X7EnZIOHpcBf8iBhadkTu1jX92ljjvX2Qkd2uTtt34Y4WkJZxn+TGr8xvYMXMDIaxFEuwyx
 cnlIUUjMKPoyTSMVgcF8mp+4H1AkjUYv71LJZU84/1FyOY2vSUYWCOSHan92qmshx1nJJfD
 YmMaXEFx9QDKqSEx6VssQ==
UI-OutboundReport: notjunk:1;M01:P0:OKTE2LAaNsE=;QsR7U0vks1jWKtLuQTmxWjfCEQy
 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
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Like in the normal ram_load() path, put the received pages into the
colo cache and mark the pages in the bitmap so that they will be
flushed to the guest later.

Multifd with COLO is useful to reduce the VM pause time during checkpointi=
ng
for latency sensitive workloads. In such workloads the worst-case latency
is especially important.

Also, this is already worth it for the precopy phase as it helps with
converging. Moreover, multifd migration is the preferred way to do migrati=
on
nowadays and this allows to use multifd compression with COLO.

Benchmark:
Cluster nodes
 - Intel Xenon E5-2630 v3
 - 48Gb RAM
 - 10G Ethernet
Guest
 - Windows Server 2016
 - 6Gb RAM
 - 4 cores
Workload
 - Upload a file to the guest with SMB to simulate moderate
   memory dirtying
 - Measure the memory transfer time portion of each checkpoint
 - 600ms COLO checkpoint interval

Results
Plain
 idle mean: 4.50ms 99per: 10.33ms
 load mean: 24.30ms 99per: 78.05ms
Multifd-4
 idle mean: 6.48ms 99per: 10.41ms
 load mean: 14.12ms 99per: 31.27ms

Evaluation
While multifd has slightly higher latency when the guest idles, it is
10ms faster under load and more importantly it's worst case latency is
less than 1/2 of plain under load as can be seen in the 99. Percentile.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 MAINTAINERS                |  1 +
 migration/meson.build      |  2 +-
 migration/multifd-colo.c   | 44 +++++++++++++++++++++++++++++++++++++++++=
+++
 migration/multifd-colo.h   | 26 ++++++++++++++++++++++++++
 migration/multifd-nocomp.c | 10 +++++++++-
 migration/multifd.c        |  8 ++++++++
 migration/multifd.h        |  5 ++++-
 7 files changed, 93 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index aa8f795783ba936ce2521e08aaca8de4a112ed33..d2a1f4cc08223cb944b61e32a6=
d89e25bf82eacb 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3872,6 +3872,7 @@ COLO Framework
 M: Lukas Straub <lukasstraub2@web.de>
 S: Maintained
 F: migration/colo*
+F: migration/multifd-colo.*
 F: include/migration/colo.h
 F: include/migration/failover.h
 F: docs/COLO-FT.txt
diff --git a/migration/meson.build b/migration/meson.build
index c7f39bdb55239ecb0e775c77b90a1aa9e6a4a9ce..c9f0f5f9f2137536497e53e960=
ce70654ad1b394 100644
=2D-- a/migration/meson.build
+++ b/migration/meson.build
@@ -39,7 +39,7 @@ system_ss.add(files(
 ), gnutls, zlib)
=20
 if get_option('replication').allowed()
-  system_ss.add(files('colo-failover.c', 'colo.c'))
+  system_ss.add(files('colo-failover.c', 'colo.c', 'multifd-colo.c'))
 else
   system_ss.add(files('colo-stubs.c'))
 endif
diff --git a/migration/multifd-colo.c b/migration/multifd-colo.c
new file mode 100644
index 0000000000000000000000000000000000000000..f160c6543414d3e157a444d613=
c96df4c5f0e602
=2D-- /dev/null
+++ b/migration/multifd-colo.c
@@ -0,0 +1,44 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * multifd colo implementation
+ *
+ * Copyright (c) Lukas Straub <lukasstraub2@web.de>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or lat=
er.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "multifd.h"
+#include "multifd-colo.h"
+#include "migration/colo.h"
+#include "system/ramblock.h"
+
+void multifd_colo_prepare_recv(MultiFDRecvParams *p)
+{
+    /*
+     * While we're still in precopy state (not yet in colo state), we cop=
y
+     * received pages to both guest and cache. No need to set dirty bits,
+     * since guest and cache memory are in sync.
+     */
+    if (migration_incoming_in_colo_state()) {
+        colo_record_bitmap(p->block, p->normal, p->normal_num);
+        colo_record_bitmap(p->block, p->zero, p->zero_num);
+    }
+}
+
+void multifd_colo_process_recv(MultiFDRecvParams *p)
+{
+    if (!migration_incoming_in_colo_state()) {
+        for (int i =3D 0; i < p->normal_num; i++) {
+            void *guest =3D p->block->host + p->normal[i];
+            void *cache =3D p->host + p->normal[i];
+            memcpy(guest, cache, multifd_ram_page_size());
+        }
+        for (int i =3D 0; i < p->zero_num; i++) {
+            void *guest =3D p->block->host + p->zero[i];
+            memset(guest, 0, multifd_ram_page_size());
+        }
+    }
+}
diff --git a/migration/multifd-colo.h b/migration/multifd-colo.h
new file mode 100644
index 0000000000000000000000000000000000000000..82eaf3f48c47de2f090f9de52f=
9d57a337d4754a
=2D-- /dev/null
+++ b/migration/multifd-colo.h
@@ -0,0 +1,26 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * multifd colo header
+ *
+ * Copyright (c) Lukas Straub <lukasstraub2@web.de>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or lat=
er.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef QEMU_MIGRATION_MULTIFD_COLO_H
+#define QEMU_MIGRATION_MULTIFD_COLO_H
+
+#ifdef CONFIG_REPLICATION
+
+void multifd_colo_prepare_recv(MultiFDRecvParams *p);
+void multifd_colo_process_recv(MultiFDRecvParams *p);
+
+#else
+
+static inline void multifd_colo_prepare_recv(MultiFDRecvParams *p) {}
+static inline void multifd_colo_process_recv(MultiFDRecvParams *p) {}
+
+#endif
+#endif
diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
index 9be79b3b8e00371ebff9e112766c225bec260bf7..9f7a792fa761b3bc30b971b35f=
464103a61787f0 100644
=2D-- a/migration/multifd-nocomp.c
+++ b/migration/multifd-nocomp.c
@@ -16,6 +16,7 @@
 #include "file.h"
 #include "migration-stats.h"
 #include "multifd.h"
+#include "multifd-colo.h"
 #include "options.h"
 #include "migration.h"
 #include "qapi/error.h"
@@ -269,7 +270,6 @@ int multifd_ram_unfill_packet(MultiFDRecvParams *p, Er=
ror **errp)
         return -1;
     }
=20
-    p->host =3D p->block->host;
     for (i =3D 0; i < p->normal_num; i++) {
         uint64_t offset =3D be64_to_cpu(packet->offset[i]);
=20
@@ -294,6 +294,14 @@ int multifd_ram_unfill_packet(MultiFDRecvParams *p, E=
rror **errp)
         p->zero[i] =3D offset;
     }
=20
+    if (migrate_colo()) {
+        multifd_colo_prepare_recv(p);
+        assert(p->block->colo_cache);
+        p->host =3D p->block->colo_cache;
+    } else {
+        p->host =3D p->block->host;
+    }
+
     return 0;
 }
=20
diff --git a/migration/multifd.c b/migration/multifd.c
index 332e6fc58053462419f3171f6c320ac37648ef7b..220ed8564960fdabc58e4baa06=
9dd252c8ad293c 100644
=2D-- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -29,6 +29,7 @@
 #include "qemu-file.h"
 #include "trace.h"
 #include "multifd.h"
+#include "multifd-colo.h"
 #include "options.h"
 #include "qemu/yank.h"
 #include "io/channel-file.h"
@@ -1258,6 +1259,13 @@ static int multifd_ram_state_recv(MultiFDRecvParams=
 *p, Error **errp)
     int ret;
=20
     ret =3D multifd_recv_state->ops->recv(p, errp);
+    if (ret !=3D 0) {
+        return ret;
+    }
+
+    if (migrate_colo()) {
+        multifd_colo_process_recv(p);
+    }
=20
     return ret;
 }
diff --git a/migration/multifd.h b/migration/multifd.h
index 89a395aef2b09a6762c45b5361e0ab63256feff6..fbc35702b062fdc3213ce92bae=
d35994f5967c2b 100644
=2D-- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -279,7 +279,10 @@ typedef struct {
     uint64_t packets_recved;
     /* ramblock */
     RAMBlock *block;
-    /* ramblock host address */
+    /*
+     * Normally, it points to ramblock's host address.  When COLO
+     * is enabled, it points to the mirror cache for the ramblock.
+     */
     uint8_t *host;
     /* buffers to recv */
     struct iovec *iov;

=2D-=20
2.39.5


