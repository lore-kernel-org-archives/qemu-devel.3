Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E4A3E63CBE
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Jan 2026 20:41:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vk6us-0007Bc-W1; Sun, 25 Jan 2026 15:41:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vk6ur-0007Az-CK
 for qemu-devel@nongnu.org; Sun, 25 Jan 2026 15:41:01 -0500
Received: from mout.web.de ([212.227.17.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vk6up-0006ET-B2
 for qemu-devel@nongnu.org; Sun, 25 Jan 2026 15:41:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1769373643; x=1769978443; i=lukasstraub2@web.de;
 bh=kLBhPBWYzaKoPwfLjTwQF5oYW9XXHp64YnaKAvCdyls=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=vnbZC1HGya45FywiCPLRJnpM21FU0eK9mjsULPCUbUoyTm4K0WDwvwT5n4ESbSKT
 Rnu65IRX4aJT1xPu1Ee+F4azlSruD9nNLeb8JciYtPQ7UQemg9Gn0Yis1uhu/mjEL
 oimrn9Rh7S/OpnZx9O6Vvh6aRPWPrESCIU1B2DbGvH0Pnf/l+6vaaMKTEMIed0T+w
 YyuHXuz8Q+0flMBIyJgdi4UCubUIA1Q510v/kHO5ooS0qPGkf6NKeEhO6tupA1GoD
 PzMqXGudAygd3GJ/n0WdFlAalKTOiJ03ghuHTqHUKgCzUsMhY6xwwOCOp0MX4ChhG
 oUBj4Bz69wfa+lE1Hg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.97.172]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N5UkC-1vqALY3Tq6-00yThi; Sun, 25
 Jan 2026 21:40:42 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Sun, 25 Jan 2026 21:40:09 +0100
Subject: [PATCH v3 04/10] multifd: Add COLO support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260125-colo_unit_test_multifd-v3-4-ae926ccd8eae@web.de>
References: <20260125-colo_unit_test_multifd-v3-0-ae926ccd8eae@web.de>
In-Reply-To: <20260125-colo_unit_test_multifd-v3-0-ae926ccd8eae@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>, Juan Quintela <quintela@trasno.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7865; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=a605xyOmAua5AZKyFyjMddf8nm9ScheFryQcKTX5wqw=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpdn/FqLiSTjlu5QlwThYSb7FLIp6Y4yeyN5Sef
 Tt0LkrKHrWJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaXZ/xQAKCRA1qwsonF2y
 WGsHD/0SXH4j0iXrN/l/r5uJb5yNAj8eQzbbMB3gf7E/QBXghhYYdL5E3D91VHwVlxpQjLAeegS
 Uu8cz4IDNQ85z9JqH20+Yf0cjl3KtS1Mrh12NTRP8xNEj/EY3XcRJX0gx4GpVocUjAayH0n6mPF
 0jUDUueNIY14J9VQiprfHpTFWI+v+Qj4FQd06y06wFsyhEPR83t+m02uQGkfRcRkDApyzZYJydt
 N6PVjkmeEaO13OTOjAvSNjOQToazHleN2JDZWaBVLu0fdizy8CIfdKAOVflxPJF9xNporrdOu1N
 xUh+230h5SqBzBmPOy5uPSgWWEmem+WOWN480ttVtjn/Q73TcRllMUClH3DjMyXwl2bLdb1OQ1G
 wX/DOu7nHXGdjfWvPC5cul72POLKMqT1L/+PdV6z+koGoYPnwBNkjLgUHwyC8dTH68GiD51chPa
 cqk5wBB2s9UhcE6IGHVrV5fe7y9PsDMXjM7fWp7E56GYb02WWJBlizlmfZcZLx1rJ7odjEyFjfA
 5WqEpbYWYLvG3JHQdkEkxRvkVC0icHcBpMFaJvk6WzdYmcP+S0Lrq3VfhkapJX7tsPX3xbqRtQ4
 BOHLUNmojwoxjqPsXtvz1hWmBI/2d1Jq5WCVHG8Vzr7MtDCDLNNjcNsB3W9uCH3uYi342pUQT6c
 ohS9TNr4s5XAvbA==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:LB/MPAjG9esqO4COAlsMtWIjctYSrFo8e2lbFe2GSN2ilADPa5A
 J0gUwqAQGav/JgstInH8jDiLW5t0tragKEHCgRDHNmlCKClpqEfGru16qVtOosGiiicKRqj
 Sp0xmMObAID15H0ZORR52aIP6tgnAbQks/+Mk75Izl7pnNVqsqYmX6pvloXkwlMlxOwwUt4
 RSeAn8oC/vLpWgfMQVeew==
UI-OutboundReport: notjunk:1;M01:P0:JprofkRMUy8=;xvbcGOY0aUqHK0rAoSMgt6xnvCm
 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
 UlhHfg18GAo7e7/04mRD8v/uV8RU5
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 MAINTAINERS                |  1 +
 migration/meson.build      |  2 +-
 migration/multifd-colo.c   | 50 +++++++++++++++++++++++++++++++++++++++++=
+++++
 migration/multifd-colo.h   | 26 ++++++++++++++++++++++++
 migration/multifd-nocomp.c | 10 +++++++++-
 migration/multifd.c        |  8 ++++++++
 migration/multifd.h        |  5 ++++-
 7 files changed, 99 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1e9bdd87c3a2f84f3abfc56986cd793976810fdd..883f0a8f4eb92d0bf0f89fcab4=
674ccc4aed1cc1 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3853,6 +3853,7 @@ COLO Framework
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
index 0000000000000000000000000000000000000000..c47f5044663969e0c9af56da5e=
c34902d635810a
=2D-- /dev/null
+++ b/migration/multifd-colo.c
@@ -0,0 +1,50 @@
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
+#include "exec/target_page.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
+#include "ram.h"
+#include "multifd.h"
+#include "options.h"
+#include "io/channel-socket.h"
+#include "migration/colo.h"
+#include "multifd-colo.h"
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


