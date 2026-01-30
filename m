Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C30FCE6BF06
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 12:16:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlnOg-00034q-1e; Fri, 30 Jan 2026 07:14:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vlnOe-0002ka-9B
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 07:14:44 -0500
Received: from mout.web.de ([212.227.17.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vlnOb-0001rt-M0
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 07:14:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1769775276; x=1770380076; i=lukasstraub2@web.de;
 bh=t+qazfxv0cjsxkxdVS98c/ouTPF1FxzuKzQnSY2chj4=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=pKRtRB7scJAY5nUUHY/B6p0zCj6azB+Sv9mrRlcRqSZsXjKq0QAIcUUa5FktnBQP
 kjqBmYopUTHOlYpZ4qRBvZH/johJNZc7J+LvdByUsca4+GdwOE3HUW1FYDrJlP6CQ
 rSg44zNFWRS2+ngcfW5ol0FUkTQWLBVlrpTgr/IpExzrWmZelzD6ihOa/oR0qq66h
 oLrWYWOCQWYuT2i4heTVGzHeV9iNpanqSQX/X3yyM18o8RSK9guehKSbAPWnv7Nxh
 iHiNcbi232E+QKh8ghr4bkhilBUGt9obxD3H+HUlXHUnFwUSBFuorLA+lJ1wPb6cC
 ygvDSzQ83p7n+eS15w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.97.172]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MQPZj-1vQ9wj1SG9-00UthZ; Fri, 30
 Jan 2026 13:14:36 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Fri, 30 Jan 2026 13:14:17 +0100
Subject: [PATCH v4 09/16] multifd: Add COLO support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260130-colo_unit_test_multifd-v4-9-7115ab6f0e77@web.de>
References: <20260130-colo_unit_test_multifd-v4-0-7115ab6f0e77@web.de>
In-Reply-To: <20260130-colo_unit_test_multifd-v4-0-7115ab6f0e77@web.de>
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
 h=from:subject:message-id; bh=67tN50CybMgyFTANooutWoTFDcEJrHK4q1KysAqjbu8=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpfKClCRZyoZ5YMlV4t5FKncsnT97quVnSXh+Kd
 oJ6976EVY6JAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaXygpQAKCRA1qwsonF2y
 WGZzEACnY508UR5/CT0UphWZFioek52j4yTwRUReshRi0fWPwxcMjJN6YczHNhmPl+3eN1eQNy1
 HFwARg17E0VHUHIBap1u4jxOP9k3rZN6i1Nj1RY+WnDDVfTWdMEjSfSRQ+jVb8Ba1xmSJ/jrOot
 YYZE7OVr1s034itYSW1pSCdZ9qi7l6sc/HlYGMcxloR/0xOPs5TDPLkZE0C6sR/dM6jEsei7djj
 FekHTIJpIk8frhYKJb/x2JdnESd6Cqe+6fm4UN6xCyhAf1RXYSuifQzfhOg5cIce+f7aGEEBBug
 CjuYR+q/2T5t1/LFm/Jb1QcqILOrmmi6Q8KNo3VbeDsAuztzgYgLXdr4aYwYiFUuPcbUPg7+2b0
 /pjQN6268TRVeH9WEFDFjE8/goaKaHo+jxjxoJr23IiZoOku+V0olmbZ2CHONYR+DSacCjOiySP
 54Jgk1hE25RpQhYyDRkAZ5N3YiND4slm0Q5tWlSMSMATWpi2Lt+XhvdWfn+k7/MHzqr8/fclyvN
 GX5oaGHwjUySvyw3VikUXJCQbjx7l6NSPNuyEdHZEWHhfBES3fH6pEQmwO+YkMhA74/cUBC+3mW
 /peFDB43/GqKaymoAs7z7p2x2nqSkk7DLvASi7ECFkHM5+7fFJHrTRC45qbJp/4AxzzbpdedyMn
 8Lc8cuMlbXt9QEQ==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:d65ScU+GJsO2vZ8OS9xQihENJgrqVlsYoM28wnaq7wdP5mGr8V3
 wdYlskP1xN5PSmjJJRVWh3WFqekgohp/ibwNAPtt0/mlq7FC0n+U8iZ3JSuhu7CGdn1xsmL
 +Jw+Fiarn1pgnzKm/BSxiXAXILKOmNmSSx9f9A8vHLkArwGL9on2/WE4i6yd7pvBItTPTZi
 xe1z7D3fP5Po3RPsHL8Lw==
UI-OutboundReport: notjunk:1;M01:P0:oJ6W05yBGdE=;tigqAIvXMB2dUu5XsZwzBP0eNbH
 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
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index b239cf00f66f0683d481150ba27447316bcab72a..900d6b9436670515162eba4aec=
6ee0f023c9a2fc 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3850,6 +3850,7 @@ COLO Framework
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


