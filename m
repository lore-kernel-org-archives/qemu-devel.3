Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CAEEFD007C
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 21:39:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwoU9-0004Au-6q; Sun, 01 Mar 2026 16:37:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwoU6-00049O-TM
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 16:37:54 -0500
Received: from mout.web.de ([212.227.17.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwoU4-00043F-Vp
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 16:37:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772401063; x=1773005863; i=lukasstraub2@web.de;
 bh=33sel1R6xmv+QDaM+Qknckw/SZLjCwKZac5wOjHfvAQ=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=hlC48TsW7cTkHGbHmeeItdRDakHrxB4rXKA8KVfGW8wfP91TfwpLCtZBAKllQDNe
 zDHRD+qP8L2TZi7wsALyLqZ0+PqoboNQqjil8zpOCVZLyX1otjuvhNkBOsXevX12V
 HiML/rWJpxOy8gx3g/EoikoOcJM8H8mbZVFPhfgWhLoQQ4gnDKEXLFPLG/uE3qiUW
 PRIu7PkSHBZC0UskzaHQfGdm48eCoym/0zn/Dl9CdVTW5drj/nHTBf7rNnY0Tu4UB
 UQv2iCB663j0+zXrnMylaeD8Horqp4nBok/wUqKkan1ZadGhPPq+h7JIfdxJcpHd+
 XPXTuKme7jkqPTVI0g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MREzO-1wHlgJ2feG-00JCu4; Sun, 01
 Mar 2026 22:37:43 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Sun, 01 Mar 2026 22:37:28 +0100
Subject: [PATCH v11 08/21] multifd: Add COLO support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260301-colo_unit_test_multifd-v11-8-14c8a70c36df@web.de>
References: <20260301-colo_unit_test_multifd-v11-0-14c8a70c36df@web.de>
In-Reply-To: <20260301-colo_unit_test_multifd-v11-0-14c8a70c36df@web.de>
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
 h=from:subject:message-id; bh=zU0pffC07Smwy5Vv0eISnBt0LkAaS5xWcGKzaE9qTeU=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppLGhPemh5aIC/+F//TOX4TpIdAjX8rjLBChv1
 OBF4scM8NCJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaSxoQAKCRA1qwsonF2y
 WAZSD/9n8ULMC5onmoXJ0s+Zdlxt4xUZg0zlxYrpQSbA+r0Ip3vyHXpwWGibKZKlA1ZNO56TyRi
 3ut08w9yzSTWHdXCKL4qJyFI+AtKSHPGzO+T0UgFpDRWFHSIPjVj0DNHzJEyFEjfQ0FMULMIvoZ
 bPmKaPkQZ4RzvQqqxQaASN28QlOqtN9GRG2v7VzsVpYEFzDZSzTQ0AkyyEcTJsmsPcRYUURQisP
 4BL9FyrZ7XmtEn801aXFfnCqIQD+hd9fap+/LTtotC54uOPfmJCUpGHYmqayA1Qij5mL3i/RGy+
 O7H/ndMmuF9dae9pJHKnLTK1lbKnIyoXVF53FtZHt2u+C1wexO0avSMDuKh8lBDgKgJYXf0bkP5
 J7DOL+Edzhd7lSFD0gMm3NvFX0WeM5a4j7IFM84lmeff7Hdy1X69sHrYr/ETciLn6Idkioz1SXa
 4jXzmz5y6ssYmYQ6hxKGR9kkUbfpxkbtPe9bRxmsJjTDKBoZYlWtp4LkUp3ex/bJkagUH6aShFN
 H+Nydjo8nsDqa7mR8n83ZijdgQAVwBBuLU6e4Awz8fw40Idwetb+aP21aJ/2O+VInjm8chDq6dA
 kLUsIMW/amwXEb4HfTW2V3bUJ3RiYLX3THErxyPZK11iUOsYY9TYYkrGC5fnjFgHJnIIyzxFt4x
 SKOCksUsX+D3cCg==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:vn9A+zTTSuxD8YuDBrfLq22J6skMa+yi1QbhFE63MwKw0UQFaMC
 7VMIMFeGQUyiNP4qaV+tKdkkGN/i4d0lXFxmVQPzHoZIk/HfMpajKcHfpC2TwqixxJnOrGJ
 NxP0l+tXMVRS5wyVak7Lo3mWoptX8cRscQow/mC8fGsvsXlg7GTNLSFnYmpI8KrjTl2siTs
 6l04PkxZN4mXHYcptrjvw==
UI-OutboundReport: notjunk:1;M01:P0:74tBXPJyfOA=;fybAzsdmc75KPiExySFCGlW2MK/
 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
 1IMPnj8XNKhAlWA4HAeWIseROsrIO
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
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


