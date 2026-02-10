Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DCEDEB26E1
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 16:24:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpqWQ-0000g2-Os; Tue, 10 Feb 2026 11:23:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpqWN-0000fK-Gi
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 11:23:28 -0500
Received: from mout.web.de ([212.227.15.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpqWL-0006vp-EU
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 11:23:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770740604; x=1771345404; i=lukasstraub2@web.de;
 bh=EAb9TsMuWPPA3CZIfZr/ezHEKFwjsBr7eMTjDjKG9rc=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=CogfOhq3nv6AHZtb6tIwsMNLbZcfH8f+57bfeVhtyPnT/tz/6ZbvmShqV18Ea+Cg
 7qs8Hi/aZABYJr3I3LrHkhMtFmYohhdmLcmp0ohxYxKnpT91OEPQKppe5gEr/gNWa
 NGQ917IA4G++1ZdjrXdloptIep8ktsZ5+qfp8Z6d9ecXVSlZRSjIM+gyUvOCT4xuW
 Z24lJ7lWrLTZUswHs2qUNei00sJfVMb0jp/k01hENGaDJo0No83MghhcMRS68kumH
 YHNjz1+QJnlZDsy6FZkoJ5JxBo5T6qKpmKi0s51ttc5PDZemGiZ84UfETjx61MrZh
 XC+ysGsG+RRwmwlFSQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([141.58.43.188]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MKdLM-1w6GuN3oq4-00Kz1n; Tue, 10
 Feb 2026 17:23:23 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Tue, 10 Feb 2026 17:23:06 +0100
Subject: [PATCH v8 08/17] multifd: Add COLO support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260210-colo_unit_test_multifd-v8-8-7f9e5f7d082b@web.de>
References: <20260210-colo_unit_test_multifd-v8-0-7f9e5f7d082b@web.de>
In-Reply-To: <20260210-colo_unit_test_multifd-v8-0-7f9e5f7d082b@web.de>
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
 h=from:subject:message-id; bh=Abosr+xKE1nTrw2cz/Hd1u4moj2pYzHV7m3+DIZpG0A=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpi1t3akiO4XPayVO/ZeW+Imda47QqVoZbdv4S1
 Au5/P4ktwGJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYtbdwAKCRA1qwsonF2y
 WO4hD/wIQ/wKugs8g7S4QjiEf+/UDTYmNf2JBVsbtsT0Rq1bTLdTfP6M+dK7AcSw6E/55+cRpkp
 TajilrDGRGONMy7xJQrbQeLMhmXwqFRf9kwJhXWitZZDBCQzpj+sEN5y4dG7aO7TPawP2RExj3k
 5cHocQyUadW1nbv62S02cyRCmJNGX1gqpJNgTVR+4xFruM98Nvm6JJUX8DNqrLF/XXQOyTR28YF
 V2O7T788JrUTHdjTg9whCg2ymJ74ZR0vIlvpYobnWRQvAfmguwRfh8v6S2c2+4OAxz55E3zvAuv
 Dj1NqEt9DSz+knDxb+WMRPgIgemhlUPHQnNZIzDvH7apazX2KbXrJas6Q38bb5A3Bpneqh/QSsz
 e/7sMuiJKA9AKLIJ3fZZrXVAB7wwPnyl+wwTcGygFpK4mnlpPtK5KLN6clr4JIvzS1r5Ds8f9CY
 /8NgIpSD4iEAYt23tKMaxSDFYkWapEMG0ccjcUG7+ZIs3hE0h1dxXxEZpROI9UeZilrrTmWOw9m
 ez7ajdIyV2BeaW9vlSvNIAfgSHS3y5q2ToJqxQqaeIJQwaTdxWhcuM4QksMtkopchUGDgW+WiEt
 eS4p2+vRIk+VxWs8Jo9eALL9HO3WBplhNzUkz/2Mxp2pfRiSqS7plKNgWFcrM1SxUwi3eqNRKFG
 gXKpJPg4BnOgVNw==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:UKXQebaua0HOH98GwroeqaS24abTCJXGcbFuqsGJ/Xpy3OZiZAI
 ntepgYU5w2fCpprUVq8p+jkSIE98NcKpPBCM90ydANPQHsGJKK+Bt8az0ATs4fdgqg6zOC9
 8MkshctdpC9+xn6IybC39ETXBN5WnSaDnETVk3SKQ+x21Y0S9VECO8EIAVio8ZD0qBEitra
 YrtsnLVEQlol/1omdp9WA==
UI-OutboundReport: notjunk:1;M01:P0:dN42Qr5TSWc=;7ONqFroKBxjr7j5WIU4jfAlBlmj
 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
 YwMkw9v8=
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
index 356e3a7889f9ab45f002f165112322e6fb5a1967..e6e711ac8a333bb9bfa0d75c2c=
42dbe74b8523f2 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3859,6 +3859,7 @@ COLO Framework
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


