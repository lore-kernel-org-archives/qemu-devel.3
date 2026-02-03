Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65B1CE83071
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 10:16:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnDS7-0007FE-S3; Tue, 03 Feb 2026 05:16:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vnDRz-00078p-Vr
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 05:16:04 -0500
Received: from mout.web.de ([217.72.192.78])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vnDRs-00027v-CS
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 05:16:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770113750; x=1770718550; i=lukasstraub2@web.de;
 bh=v3IuNbgTvgjl+w//S7ZOGWW5S1O23Lcw+wRZ3fjyBzw=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=fosPf1Eu42xQDkBVz8CenMyUzXIb+laakSpQu8icmSFX62HW2P9X8ICoX47H/Rfn
 TaX1JzJn+U9S+8oHe7kRuD6Qfwb29fBQzPw2m3eIgTt2oZ+05QCmDX5VAAP9zCX1a
 h6raafL8pb6UGfuOFD2K0vaC1GrrtCRPnfYf+QEJxWYLm5VqUO4I7GLSz7GK52emz
 gIjFTgeUkAcDYq0CBgXaTI5b4cwnYQu/6R33bkw+Q/+5a/v7e8ESS5Aetv1UD6adZ
 0/sufuE7wo6dLki11aGrBWdxljx0BB2uLfC1C+XV3MAvMIurkxq5kXgCcBlGdnKKf
 IW0bO9p5WtiPcLf85A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.97.172]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MbkWK-1vHiup3ye6-00mGSO; Tue, 03
 Feb 2026 11:15:50 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Tue, 03 Feb 2026 11:15:15 +0100
Subject: [PATCH v5 09/16] multifd: Add COLO support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260203-colo_unit_test_multifd-v5-9-57508b7389f6@web.de>
References: <20260203-colo_unit_test_multifd-v5-0-57508b7389f6@web.de>
In-Reply-To: <20260203-colo_unit_test_multifd-v5-0-57508b7389f6@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>, Juan Quintela <quintela@trasno.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7699; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=2jsBEUVOcJ7WHyyQuBj2SG8zKOO1g31niSL8UYzmwwU=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpgcrQBvthg8pLiEMmJIh5xsyJUf2m0O4dEesqN
 dU5NhvGx22JAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYHK0AAKCRA1qwsonF2y
 WLooEACJK/6Qm+E7m0kblxg41yYprjaGg5vUBPbaoWdLPidgTsTKNKLrkt5OK4/qbwm9uWQ5jkB
 DFO7W2fkrsZRGpmGtibBW1IeSQCquMzCH1S2zbVqR6mZ5UWC24vSfNGIvohM+w0DhBIUY+YMhsV
 i7trggqEBtV7Mg+IZk77p3J7h1tLFhB+LX31tM90eLyknOEpyVerF+lFWIRXWx4wOeL7gBnEKAv
 7NzIVXze4kTwnltbDkxI/C1EfNwKDiAQLML0xUNqPe4NBOlgHARwOMHN3IZ1uhf/sMTLsvj2NTA
 ei3lpPfJINhjQbe+Th4Rqh+CGLKhDCHFcy/E9fTDAgBFvfDpLUutqxgD/XVnrcOpkbGnesy4VJI
 zmdoNBzPvWwOjSpQlpfYfamqAL6BU8QbYxxeD38kLdQag9gBUPDmzpdQ70eWEH1bCOvTeTRroQf
 RZSKX663/88zlAYz/vlGIrtQOcrBhep9YTfIZIVmxtNfijqIWBtsJOS6cJDpbft0IaLnzCNBd+Z
 aJlJCaBwYLBHpaai2N5hgKNBOnUNUSn7iEiugHp+1AnOYHjN/bvblUcTrvhjgFtqa17sMRNznqK
 ujg8qwvvECBrXNRpWmndFNaQXH2JKzjS7tUntSWSq53XHAGSZk33+raH9bA4NHTfGfvS1hudyX2
 c6xlapXGWSwTkBg==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:qkHsKdS/qp/9ItzpbSCRSmDUBbUPxsYswLHkvLLmzSHtEnMupiX
 YidwOJK7qK3gfJv8fyFlLvJHPc/ZR0dyfE7YM+aKdSNTSvIY2RrtDndCjutNdinRs9QbjtF
 HNdSm3xZkJecpX+r+ojbh5Spf7Mhogb2F7sZKRxn92H652FVJagUsILEBrdswEb0BEDumbk
 sRj64p9YELPWSprkBTiJQ==
UI-OutboundReport: notjunk:1;M01:P0:PIr6yuz2j4E=;+YoIWxPtxVb6EE+mOxXTNuhBDIR
 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
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
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


