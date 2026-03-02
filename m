Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A4F2E9B357
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 10:22:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx0Pm-0008T8-Dv; Mon, 02 Mar 2026 05:22:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0OB-0006n9-La
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:20:41 -0500
Received: from mout.web.de ([212.227.15.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0O9-0007Rt-2P
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:20:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772446813; x=1773051613; i=lukasstraub2@web.de;
 bh=33sel1R6xmv+QDaM+Qknckw/SZLjCwKZac5wOjHfvAQ=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=DlcyB1Z0RjUBfPAjQa74zcfyLeFxdH9FnK2dX40jG8KdiH76hxYIftLu0hz/xj7p
 iNH7qZ4M64+Pr+XDIOmFCViX8aLbPd6HN7jFeljNS4UqLqu4REc9txyh84pmYXN2r
 XeiEIz8BXHaB05lUBbL1r5mc+6EfUkSflfTjUdRN06x8qdnRoIJsBy5uSUlA4xZ2t
 GvdB0QlvwTUyGc5d87OmYm466iy5tKPxDiILbqOyshALR5+X/jGQobu2QfeWWPC6D
 ZYiM4GtRUHzuBBF6FJJU56iKObEC6k7uxo41tM7WJsDUyZ+ezYKX14XP/ag9Zt5sa
 IzpfmR2svu9FmnXNcg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MiuSe-1vRG3t1ov6-00mwGW; Mon, 02
 Mar 2026 11:20:13 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Cc: Lukas Straub <lukasstraub2@web.de>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Juan Quintela <quintela@trasno.org>, Juan Quintela <quintela@redhat.com>
Subject: [PATCH v11 08/21] multifd: Add COLO support
Date: Mon,  2 Mar 2026 11:19:50 +0100
Message-Id: <20260302-colo_unit_test_multifd-v11-8-a2d96276c707@web.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260302-colo_unit_test_multifd-v11-0-a2d96276c707@web.de>
References: <20260302-colo_unit_test_multifd-v11-0-a2d96276c707@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7788; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=zU0pffC07Smwy5Vv0eISnBt0LkAaS5xWcGKzaE9qTeU=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppWQoy/ksYQIRAQoRJDkH4peWctQ+tzqYcEqCh
 hSjZv2khOSJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaVkKAAKCRA1qwsonF2y
 WKhgD/9ao79B52bmcnq9qA6UnDWAfZeDluSFtCj1ZCAa3LFXepM2yngDCwZQoWmNU1wI3uOmHnC
 U/1ogOBlySn7f8lLH3V9F/mdmTiAbmE33VhLA1kAe/uv7mqoP9bCwRQcRWQ0N55ckLkcDaOg63o
 yr6HJj/gFl2nvhKNSlEfqzLbyif/J4BiA78rOPhE/Csqn167rKiDoxmZAg83CHJ1rQT4vAjU30Q
 ZnTQuoVUJ9AG3MWIQBBvilhKZ8DP+bQh4S9a6XxgJHZPC0A3UaWEgZCmbjOHcRfLQMEj3B+FqHJ
 VrorfiG9w1J8Nl66R12Ky1qixKzVE726byhAl5we93QZjbvL0GEhnyeHk8Hd6bb6jsbxSStATVV
 8HG6oTH2RGbbgVQwmF6Ju91xS/5rsXs4H9VwcGXJZCZ1bzAg+vsvgP12GEpHdc0ONdTvHzD+5gd
 SdlYIO+yJ6JtTcoNC7mh6xsYTO2557uDIzfRhtGpKD+ibXr4DeDBYvOmMUsXRae0EJyLhP0arEO
 vk3TXXBjPk53IPL/FQSYIH9AgA0rT/+DlDBA3Knqppvj4V/cCvqjckcIHpiB6q/OLj3NYnUYVu7
 RsyTPS+rFI0RpxVnOGVw68rjh7Swl5GtQWy8PguWiw1+vhaVYQMCeyQddu8ObsnV7JN2Zw25QKW
 f+K59iG4IPZUT4Q==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8QmmU9zaJw6QIDu3O0pRcZNUiphYJO88rKem9JCQ8tFG+mv/OdW
 HB6dIhF4R3IP9s4DNZVeXKBx/fkrB4h2CGljcST6eah9o2WojObeqQis5iGw8mZMEaIlhxp
 1YMZu5VKhxzKxLThiWni6Z3ia/jKMtCiFqf3OzkQjgVjJRpEFn/TK5wHFiO/owwPiV4ylf7
 uDFfoNaZzoA1fr+C0rhlg==
UI-OutboundReport: notjunk:1;M01:P0:rDPMqkzcN30=;st0s3VonvhTCmt1ofpJJtfCkonB
 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
 OJIDxTAOGoZ26dGLgcGuLBTUOVmc+
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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


