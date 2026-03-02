Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E97E9B365
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 11:45:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx1gv-00057D-Sq; Mon, 02 Mar 2026 06:44:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx1gu-00055h-0y
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 06:44:00 -0500
Received: from mout.web.de ([217.72.192.78])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx1gs-0005kL-3a
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 06:43:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772451826; x=1773056626; i=lukasstraub2@web.de;
 bh=33sel1R6xmv+QDaM+Qknckw/SZLjCwKZac5wOjHfvAQ=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Dv6NISzgE0BmamKiIbG5MzRqzu5hsWhbUm/5jkmICvFzWAHb+Qzjje95xSTZZJ7z
 ygee5XbnrYBjmkMe26B+VZtbiBi6TICT25lFn+Sd4aGtPy3ZX/g31JVGakfP7f3QV
 fosg08YxWYrCQicS2T6Eos+dRUL2XCGJ8H9EJvJnjq1iH3wnn1o3sxA83oRW+GtD2
 ZN/GaXt7GYtPumbxP9Wt4OKPjYg/98YrTn4iLOrq+MApDtLs0rfjhDrADHu7NmMzL
 i1T5REuaKvtmx76yHqqLy9PeXwoMEGH5NYiA8qYAiRltA46NA5C2QW6wsmlyL2cxq
 4iNyKMLLrWicAyahjA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MTfol-1w6YBQ3LXp-00YLG3; Mon, 02
 Mar 2026 12:43:45 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Cc: Lukas Straub <lukasstraub2@web.de>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Juan Quintela <quintela@trasno.org>
Subject: [PATCH v11 08/21] multifd: Add COLO support
Date: Mon,  2 Mar 2026 12:43:38 +0100
Message-Id: <20260302-colo_unit_test_multifd-v11-8-d653fb3b1d80@web.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260302-colo_unit_test_multifd-v11-0-d653fb3b1d80@web.de>
References: <20260302-colo_unit_test_multifd-v11-0-d653fb3b1d80@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7788; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=zU0pffC07Smwy5Vv0eISnBt0LkAaS5xWcGKzaE9qTeU=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppW6TeUIMW2gFhasIIH5MVR5aEhCTeMBOdGyJ0
 Fn9FNQDUhWJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaVukwAKCRA1qwsonF2y
 WEzjEACttPX9PYhOwvzQqybhmM1YUHnBxXBz6qxc85M3wc4bvEQOmWKxEA5NgoPjEhmkHgq1PPB
 kIBJoxKQoucMtWJobFBk/vTxuUYQ3dUUaxpQhRChwQZ/HHtNR9TpfJdP9jNidiRudYA+A07SaJq
 5OtR1drmvIX8tGKQDxvxTtO6k+unppAQbQb3JMHZ7peSg2UZtYuV8cgDUFvNBHfcHHA/HoUUUX/
 xo2o4lE4pLfTZ8Pkx6f4O5Ey6X+qwIgxJc+eK8x43+H8YDk24cBrtgt5BqNK3f2dCGD5ZNBvLRw
 1MxTo4zmKSX0EtNZVob6f2pbR1LXkY8Kr6r6Jmh3QlcuOwUdJEPeIiH2SaspICGuJ1TQNd/Rqcw
 VsHtuOuqffol7UE65wJTfKtcZKr/XPSa7RewL4r9kxOHdZky/H254i/bHghxOG1k9joYFuwde/S
 w+mKYvhmFc45huokUIOvnKmVNiXSFpKBV+VstE4TiC8J7juwGSLvWiEx8kCafBuwU5lXhP6oaM+
 mMecOAWQAJVMRI9T+7D1lL0kOBn74yjvP1ia+fembBfes0UbRcpaCs6obU59f8vCmv7rJo/6Wq9
 eTyMrqDhyQtt12noPUZmc3yOx2ape3823Suy2/E56kZWOat4g5h1bmeFVRQ+45rfVNMJTI55J6h
 PkjLeF2NU/CpB9g==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4SAyOI7SmC3VjIlw6zY09aZuAejJZNbTXm2qI4+S1xCUx2lpwvP
 XZt7XmWPZ1UTuq3GeqFsjjevq7jTRXGOkwWX/CnuyhVtkVG2ZBDOCVJBzfOiijj2zc8oWwH
 wcVilGf5gA11cMQFyYK5uWgJ7y7sayoyL0/bXetypapCbUgq4yPomp+h3/wtvouuAtYoqKn
 lhf4J6yUg5S/RbWm288dA==
UI-OutboundReport: notjunk:1;M01:P0:XUvaF1PbexA=;lwdfGyc0sZE+y/VAQ6A+q6OiUS9
 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
 08JOXiH1F2OAAk0AAXRosv/QVbN8Y
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


