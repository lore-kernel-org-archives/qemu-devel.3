Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5DEBC9832A
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Jan 2026 14:13:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vh70R-0007jb-U6; Sat, 17 Jan 2026 09:10:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vh6zo-0007Vx-Lb
 for qemu-devel@nongnu.org; Sat, 17 Jan 2026 09:09:44 -0500
Received: from mout.web.de ([212.227.17.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vh6zl-0002Y6-EL
 for qemu-devel@nongnu.org; Sat, 17 Jan 2026 09:09:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1768658975; x=1769263775; i=lukasstraub2@web.de;
 bh=w2r8bkR7RlW4NZ+SMP6LZqpIB8Sn/8gVNZAjtN04PI8=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=pQVrY491VrdaEQwYoMxa9uO8CrhL3hPWJL+a2ZA58dmzM1xU9nlVbHUnUp4f36Ye
 lhr79Mo7FX7av9BDiJjsq2/D3dVQ7MnW3hHQRc63FTB/P5v7kUTzlzqaLghaktkWp
 chu5wGm8huE8mzdm7WT66nOQLDWDts9NHJr6kAZ2cdclUtE8N1qjlq73D1LpLcgcE
 PgAmjLDj9LVdYlCFB1AeB5VAEsSRnNwMK74y1jxWxjhVo3NGwWm6HCtgLnkdk76lg
 Sa57g79nGLlXY3/jzUKfxmo8bkjgfqYm5p/RXtw5A59ebeUnK7UUpZyiq7yyQhGqR
 X7JBx3EJClPj+t8esg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.100.70]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MgANA-1wIu2r1W4k-00iMyk; Sat, 17
 Jan 2026 15:09:35 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Sat, 17 Jan 2026 15:09:11 +0100
Subject: [PATCH v2 4/8] multifd: Add COLO support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260117-colo_unit_test_multifd-v2-4-ab521777fa51@web.de>
References: <20260117-colo_unit_test_multifd-v2-0-ab521777fa51@web.de>
In-Reply-To: <20260117-colo_unit_test_multifd-v2-0-ab521777fa51@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Lukas Straub <lukasstraub2@web.de>, 
 Juan Quintela <quintela@trasno.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6500; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=SKX0paz3JMTU/nE8nfcjnRfRq9nlVBXZdFYjuY4Q1dI=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpa5gb7uMkvkFn6zkDQ7Pb5+0KH9i7bS/L0mF6H
 TDMJJwtz3yJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaWuYGwAKCRA1qwsonF2y
 WEN8EAC7wiYFiRfkzP3tiDgJieOJ2sYghmZQoVf76c1kgDkp57SBpeh+RhLDIrtoH6F1XqyG0RH
 Q8yN4gQFV/N062zeoJnJzHN1j8fNEqAvwD+nUn4vAPtglYToSd6mHLgbZtltPyYgqGEadCefLYy
 7DAWn2x23YD2WLhW0ivpcczs6QliqmvmafmEo6c/UG2g62FX2lQaHH1TktJ4BJeza/8cIJ3UAr7
 cB3NN5p07flBNC+bnOdngPEtrZBaqG+LjtuscbGaWHJUax/sQqsdh2dq7GQCNhbLBLL7eatqVom
 efnI/PfsP79fuMYvIyLuDvkX/iLYTllVN8toB7g7BBR6I60wFsVzewoTL7guF3zNVuwhyOipuR4
 vevTniwYwir9C3iBpVGeBOq+xQE/TEJOJs6hdsIshsaOqn7PKFkJsNNmGRZB9Y7ZqxBSR6ZVTOZ
 T8iaoGx8ELI2IZ1lZeTazUISe7qCf92axqwcGfDLMVbpb1vUJ4oeDLWQTeRxrRBM/6U0WI8J8KZ
 BW5c8FJ/nu6Nnw9JeXT7kg5zTMqVnrh19W9Nodvlez00dFFgsx2vquFwK0vgYUPBp4DnBbsz9H1
 5pCsN166+4O4rufjzXHE7PdVRO+YI30FLyQT4H0AEcPDfG+n4g9+hISNAwq/ErmePQgqLP053+u
 PvQN4UBxNM1VvCQ==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:pVMFzmchPVNPPlwBYkKL0f40ZjVFueBXDAg4qZvCW8JaPtyJ2Fh
 ITuRZvlR4tqDT4y3MzGBgrlWYsS2TnfnVXSWv9OD2rrV1NqTXCONLBdJUxPKRkoBErnBzLZ
 aVUpf4CekqXvZPIQ11NE+0kpUXv2UbvFlRQ67kBMg9wyE4DctNxi2Wl+Rf3MPimhD/IaDKT
 F73OUVWymA127jJf0m69A==
UI-OutboundReport: notjunk:1;M01:P0:ejBYPJfkpzU=;n14Rq6bgvYt2W5voX1svqh4BwX6
 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
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
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

Also, multifd migration is the preferred way to do migration nowadays and =
this
allows to use multifd compression with COLO.

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
 MAINTAINERS              |  1 +
 migration/meson.build    |  2 +-
 migration/multifd-colo.c | 49 +++++++++++++++++++++++++++++++++++++++++++=
+++++
 migration/multifd-colo.h | 26 +++++++++++++++++++++++++
 migration/multifd.c      | 12 ++++++++++++
 migration/multifd.h      |  1 +
 6 files changed, 90 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 563804345fec68ee72793dbb7c1b7e5be4c32083..dbb217255c2cf35dc0ce971c20=
21b130fac5469b 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3837,6 +3837,7 @@ COLO Framework
 M: Lukas Straub <lukasstraub2@web.de>
 S: Maintained
 F: migration/colo*
+F: migration/multifd-colo.*
 F: include/migration/colo.h
 F: include/migration/failover.h
 F: docs/COLO-FT.txt
diff --git a/migration/meson.build b/migration/meson.build
index 16909d54c5110fc5d8187fd3a68c4a5b08b59ea7..1e59fe4f1f0bbfffed90df38e8=
f39fa87bceb9b9 100644
=2D-- a/migration/meson.build
+++ b/migration/meson.build
@@ -40,7 +40,7 @@ system_ss.add(files(
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
index 0000000000000000000000000000000000000000..d8d98e79b12ed52c41f341052a=
682d7786e221b5
=2D-- /dev/null
+++ b/migration/multifd-colo.c
@@ -0,0 +1,49 @@
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
+    assert(p->block->colo_cache);
+
+    /*
+     * While we're still in precopy state (not yet in colo state), we cop=
y
+     * received pages to both guest and cache. No need to set dirty bits,
+     * since guest and cache memory are in sync.
+     */
+    if (migration_incoming_in_colo_state()) {
+        colo_record_bitmap(p->block, p->normal, p->normal_num);
+    }
+    p->host =3D p->block->colo_cache;
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
+    }
+    p->host =3D p->block->host;
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
diff --git a/migration/multifd.c b/migration/multifd.c
index 8e71171fb7a17726ba7eb0705e293c41e8aa32ec..6c85acec3bac134e85cfcee0d3=
2057134f5af8d1 100644
=2D-- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -29,6 +29,7 @@
 #include "qemu-file.h"
 #include "trace.h"
 #include "multifd.h"
+#include "multifd-colo.h"
 #include "threadinfo.h"
 #include "options.h"
 #include "qemu/yank.h"
@@ -1269,7 +1270,18 @@ static int multifd_ram_state_recv(MultiFDRecvParams=
 *p, Error **errp)
 {
     int ret;
=20
+    if (migrate_colo()) {
+        multifd_colo_prepare_recv(p);
+    }
+
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
index 9b6d81e7ede024f05d4cd235de95e73840d0bbc4..7036f438fade1baed2442bfdcf=
8b5d6397c4a448 100644
=2D-- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -280,6 +280,7 @@ typedef struct {
     /* ramblock */
     RAMBlock *block;
     /* ramblock host address */
+    /* or points to the corresponding address in the colo cache */
     uint8_t *host;
     /* buffers to recv */
     struct iovec *iov;

=2D-=20
2.39.5


