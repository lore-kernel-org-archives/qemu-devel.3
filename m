Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72D9AE9A02C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 21:33:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsp7T-0007B0-7d; Wed, 18 Feb 2026 16:30:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vsp7F-00077g-Gl
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 16:29:50 -0500
Received: from mout.web.de ([212.227.15.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vsp7D-0007Ls-91
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 16:29:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1771450180; x=1772054980; i=lukasstraub2@web.de;
 bh=PIeh9HHb7yZFZn9UaUBgAwp0Tvj8RNmFgHfSkQif19o=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=t2+AF8UsLdYuI8Ka7163gBgzOAC/bGWr8sQetIbYU08EBg/eg0X23seS5XyI3mmC
 kuOY6+J8Ryvki5/AO1uMHF2Nxwcd2HYwhDDaDxuthrBJrqfp1Bni06ppSgTb183do
 T9J5HHttCWU2oqZ56aXhULGbZVcT6NNi/1zjau0QzLxjy7N6XiIncVqdohdilODLx
 VO2Fz3BnpTAgySNbz1T8PAFLPb0OVhZh0tOuF8xNyRE62WqiqjDC6dXybzIId0wYs
 3mxD6mWbGRJv53tfpDm+LM7jgec9L8tLkkpiOJbWbiOODJKZsoqBR7URNEo4XAn45
 HVrJZErIssgztp0j6g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([84.133.37.84]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MI3t5-1vvp8G3buh-00FcZY; Wed, 18
 Feb 2026 22:29:39 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Wed, 18 Feb 2026 22:29:28 +0100
Subject: [PATCH v9 08/19] multifd: Add COLO support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260218-colo_unit_test_multifd-v9-8-d8dbdb0ca6f6@web.de>
References: <20260218-colo_unit_test_multifd-v9-0-d8dbdb0ca6f6@web.de>
In-Reply-To: <20260218-colo_unit_test_multifd-v9-0-d8dbdb0ca6f6@web.de>
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
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpli88vD/bW38ySS8GzMWZrwBvQH7E3wjwncH63
 HkRLvnicqGJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaZYvPAAKCRA1qwsonF2y
 WI3TD/wIxWn8qvC9KCOOhuw6Fyhp+uRAlanVO+CaLE9V7qJe5qDCbxxhAzHW+RMwRGyfEDF48Lx
 mEX2nB7F//XA9IcFowMNaS6bdaabsjmFHb0EAJXSIynv6s98+H9wbKmU83/zmov2CdRJTLECMam
 jfNeQc1+ewh1+UQ7tFHRjCfKPjjdE/TZ9tB6PN7E5R/VyLQWdKjl9bYFIQUP3Sob3nN7RXiegnA
 OZOMECv53pHgze5E4qatIkVLYUDymyEFF7NOWkKgSe+Pv8OIvj63uzH867W8qXPL3hnlFXeMj4A
 TGmM+Zwi5T9Ao3OsyDlluDO1Rm2aq5kd3dK7pXnHZSRV1UCBw/+MXMVKcLWUrREh0eqcFKfIqbB
 YiRoWLswom7kjgB+vCfihS4/YPUW5RenZezb07/IoqV3sRN/wbfpvXLUxA/7cZ6OBTV2pWeNT6y
 QJfOEMpkJMiRPmClj+SFgU3E4ftg+4UkyNIYztJEMeUxbCoCE6qhfJFZpd79ag70POiAx2rH7YA
 EKJMWJ6yBKuIX0xJgOkpWNauX0ltuvwE0sFbykEFO0ufLX6eGFNK+lJ6wr3TdbZJStQOyo41m8i
 hwuLUMUXMAJFdl0wbYa6/m8HzjAsl7M6faMos7sKww77oa7WTdEhd7NcYmlqNW4fV6sgvIf7EDD
 YrvDlBWbCSuCD+A==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:gKLk9GdrZSZf5pAD1stWvrf9pfPbYCOW7p6ad4QncuNmRaVeuVq
 meU6htVXdNCyNkOdEKf1BbC9OaGuDfXm+xQh+1LxdFwzhULnOlnofgpRUBAmPTLtbFRuU7V
 9WIbdfErCWDbRKvPldR07BVa3lRnaxFo8y4dA7+vcLrx9VTkhpA1fAwTUdWSxA/9QhxE6gC
 3kgD5RkRTpqGw3kUVYtqA==
UI-OutboundReport: notjunk:1;M01:P0:mOhsrbh1GwE=;Efra+hxJMHXFjRpc9RnhlaIisic
 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
 NJ8cS+N4=
Received-SPF: pass client-ip=212.227.15.4; envelope-from=lukasstraub2@web.de;
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


