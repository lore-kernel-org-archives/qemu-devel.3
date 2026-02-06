Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1BC4EE6B4D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 20:06:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voS3Z-0004ME-Oi; Fri, 06 Feb 2026 15:03:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1voS3K-0004FU-Dj
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 15:03:45 -0500
Received: from mout.web.de ([212.227.15.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1voS3E-0008P0-Pg
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 15:03:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770408206; x=1771013006; i=lukasstraub2@web.de;
 bh=yWcG4ZKd7VFXYNv5ZZflkHaYCa852WOsGqGzjhpz0Z4=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=C2MmetjoNFNpI+0agd1YZ7OjxNIl0DwARI7Eu6EfgHPx6oriHoGEzOnuTzQeO7HS
 S32HDUEiLBPIkvKVWrjT6YY46xATecxpWwzP9/YOEcZb/eK887mdoM00RXMiwzn0W
 Xmlc5NiqMmHrNnRtsc5t1907SDgVW7HYk3DFgoe+NzRgOJX0SLMWS+S737kEX0i8o
 Vd7JC54Oa/ydVH1SA3VRH3ugMYCBCqfesPV2pha8K2tmLM9FsciIFlYhn6vEN0lGm
 IgK1vADAwSUgndTnWcAhtvuZkr3BOwe0IlAm1Fw0LyfJcrDfV0IB40+qwZTznG5/G
 AHrs8JdwXzRVrwQ+Gw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.97.172]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MMY1D-1w4c1K49DT-00Kj49; Fri, 06
 Feb 2026 21:03:26 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Fri, 06 Feb 2026 21:03:07 +0100
Subject: [PATCH v6 09/18] multifd: Add COLO support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260206-colo_unit_test_multifd-v6-9-27779dda139d@web.de>
References: <20260206-colo_unit_test_multifd-v6-0-27779dda139d@web.de>
In-Reply-To: <20260206-colo_unit_test_multifd-v6-0-27779dda139d@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>, Juan Quintela <quintela@trasno.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7745; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=2VG97uKxGhUSXRihk8MX99JK6n5WIo8H21nmUx0kshw=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBphkkFFp/UKC4H5eGqtaTg0sbaHmrtGGtiqFsGm
 p6R1rTgtGKJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYZJBQAKCRA1qwsonF2y
 WCtED/4gGJbi8Mvn88pPX1OnxsI4Rt24jTTvq5z7fD8gB+IkNW3rTVC4vwUih0Gyfa3ffkqb3+7
 BwSL7dwFau3SaP5Ap3wcEce26f3hwoHD4SohkmmPJAVcC/ZBkyvJUHPA3gZZQGYESyqMYUZXbkX
 TFLs1lNoZo7P/ABPpWl3hmCIPM5b1p2SgrMFIxfiySH4v7/aJJbTlybN4Nwdd0CdxgaM9DYjgG7
 AD8GJVs9mEDXrObewSZwN6ZaxirZhwuCmuOahbFimiYyXCH3H8dELiymhojhuMAIkfoLBmQnkUE
 Fzd13oNe++Iov2djDQJjVw/BBpOHbqjpdY8k04zBO64kE8vCNVgZDIGm6a/ibGm2/JRdbvnB+tf
 WIHp0UDIO7NfpFb5958Zq9TlcIw/EgMbOXHGmoN9sX3rIis/ljwu2uJXgJ+LW7lajdIRY/+NC2u
 4MlsvofBhlv6x8ox1+qOubEgHFucOmyVRWEcTxzWQ8xmvSG3eN6Bb6G/zul6o0EFUIzIz0f+KN8
 Ho3hA3//Tl5cFH5dfuQN0VzkTEl2lBMBC4viNV9ydqkC7ChFz8xcvszZoe+E77R8cpRtM5WKWQ7
 K4BDfO3HB0sK3lkDCwLBP8uOzr8j/Hhfnfky5R6s142Kmk6LecFwZw/UsUWqjHfv0/Kz5QnHuSw
 PywRJ6YWyj7lVkg==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:6j5cqORuIPIlUmz0ZzPtMOjCrHZ0RW1xZUBt6WY5H1b3Y2ltZfn
 SH4sVBmF0vfvSIhCEqAwmorjL2s/xM11lppyvzM6nohd2jT7rOoUUVBowh6AUidiNjSMBaG
 /m5DCwoMXXEpP+KErFFmmUD/Ga23VdYwbb6tM6XIvCMKVd8MgWho8X63U5ufSrR76fQI3eL
 He+aM5yMZyVS7aJwBXnig==
UI-OutboundReport: notjunk:1;M01:P0:wnvboGv40Do=;gox9pdyhR+PAaDKz3dSgQLulrz6
 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
Received-SPF: pass client-ip=212.227.15.14; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reviewed-by: Fabiano Rosas <farosas@suse.de>
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
index ea170280580af6e3ebc586c3cb9bf6e144b30c11..70e8b9cae59a1768ad9966d129=
1bd358a0712573 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3851,6 +3851,7 @@ COLO Framework
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


