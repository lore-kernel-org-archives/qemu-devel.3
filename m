Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 670F5C5AD68
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 19:53:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtWXo-0000WD-Su; Fri, 20 Feb 2026 14:52:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vtWXi-0000Uh-Ci
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 14:52:03 -0500
Received: from mout.web.de ([212.227.15.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vtWXf-0001Se-5j
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 14:52:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1771617109; x=1772221909; i=lukasstraub2@web.de;
 bh=PIeh9HHb7yZFZn9UaUBgAwp0Tvj8RNmFgHfSkQif19o=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=wnZqUeyhBqm8dnjyoS9Zn5gsQL0lh4u+HQrsEMyDXL575rV7T17v3+S9mXeEtqp8
 jDuvp+ptFESV5QY2yvPc/8DfjjnuCQe5yQU+6mYye+IDxa8Axg1WODglSXc1VfqAU
 ggoyjbQ0uQxRMSvFN1K0HwxDIJg0AiFWKlq+8H7tkrjPnUotrkzXgMOrpoSFYj0gv
 HZ4eH8xY9c3SMmcuyVgXeS/M2/nmBxzNriiLizRcFLy3Bqmi64eduGAH9M6jkSCLV
 zukA2fC/AW6O2j/oLWi7K8Qe2pLdxL2V2d8vfCmPub7o6vW8tfzAxHTndzabwv1so
 Ak72cK1FUYoOvIlEdQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([84.133.37.84]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N4eGJ-1vmY0w1KEx-011pJH; Fri, 20
 Feb 2026 20:51:49 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Fri, 20 Feb 2026 20:51:30 +0100
Subject: [PATCH v10 08/19] multifd: Add COLO support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260220-colo_unit_test_multifd-v10-8-bfe67d422ef1@web.de>
References: <20260220-colo_unit_test_multifd-v10-0-bfe67d422ef1@web.de>
In-Reply-To: <20260220-colo_unit_test_multifd-v10-0-bfe67d422ef1@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>, Juan Quintela <quintela@trasno.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7788; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=8r37wRUpxfxlZdZosdNFVkALib5KksA9QEkP7ns3l1Y=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpmLtOHdX2AXSxYLXGIKcMk+G42VXG8qbs2IDei
 EWMyAZo0meJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaZi7TgAKCRA1qwsonF2y
 WLiBD/9+7qorsWw5MRftiKPdaVkpsvJTACilLdZXe1opKQc6IbhD1SZlIg5BeWYKyXrqKWjLOU/
 pYX+nZ5U02V7iJcr7FgldmaKo9W6yD9McZkb/+DS8r0qaKW7gDng9pyhkdG+KxW0Y4Mx5su+FvR
 TtcKk0tVSQQP1xIBntZlbRZcKts34Z/CfloP2l658xm61Qw4wYqtKhdJMbHMl2yvov590EsviBr
 KQp7K/YZf18gAA3/6gCSMN6hpP13siBWcmR6ZZfBSxUqXVpsGRjYQAKFgfsIoxsUFjPmCuThcdx
 N86PnxNHS8VL89EB7WS/VYI5Wd1Pm6lRBmN1GXBt+srjsns+U9utnxJloCfIcbv3duvZ9IMv8Sd
 LuFYt0LdAyVYTk+ZntS4jM4u8h6nDcAt+KwxxoVCbeNYhI8y2HpTysReaZbV+01c4+0ODVpIGaV
 hNfUoRESH/XAzRLxK8J05JW0S58OolyMVnUyXERY7S/taeFt3Jx6yMz0fmCmW5jDxekwDFmAve0
 kEn8yIRjf0n6QghLMoF5mc0gBv4pupo2k9851tBL+WhrNz/+GEaAybNgzHcYsVYdbed/WbqW+j3
 b9G1kH3FxDqaKSRQJfeHXMt2LvIO5OGYJCPaMll44R2qgefjyaGjYKZkmybYC1pKeNhzxghEAyd
 oQtu0PDpz1K7lbg==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:QB1kQqnHiQ9e7RAFhbDTUzxsvfoGX2Apg8Op7aEuKWkiZWJ/BRz
 M7sYDEYc3U38etMiJCAQ8gpAyDB17RH7YiNzTrLuunDAwUXv/nXDAd0w3RWnx0PnW5BRsXM
 ftrzS7YdqqBorNbTUXv+3OOUlI/dJ5hVCD8oOVN+hWnmoLS/7hDGSz8kvcifbEQ4eq1nmGZ
 fLox8viCarj3/83R33Qdw==
UI-OutboundReport: notjunk:1;M01:P0:p1LJlTTqm4g=;lfDx9SuL09FXbSvUZYlXVnvuIFp
 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
 FQBInGSOvruMRj4c8+uoIR6OJuPjq
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
index 3c4eb3bc744e23dc3d49d14b24a0d576d7bd60d6..5519ea4e163229a9bbc06318a0=
ee06d88ba6a8a1 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3868,6 +3868,7 @@ COLO Framework
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


