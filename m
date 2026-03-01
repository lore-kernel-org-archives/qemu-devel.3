Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 976C3FD0047
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 19:18:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwmIE-0001Xt-Nt; Sun, 01 Mar 2026 14:17:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwmHs-0001BN-W8
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 14:17:10 -0500
Received: from mout.web.de ([212.227.17.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwmHo-0003Xc-Cc
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 14:17:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772392611; x=1772997411; i=lukasstraub2@web.de;
 bh=33sel1R6xmv+QDaM+Qknckw/SZLjCwKZac5wOjHfvAQ=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=sUKRx59A0S4UXzDzoyVVMsKsBt3DApPrDxFHLs9x/SmaSSO6p5BAXx5lUU9ShLOw
 5NFCZ27wdQ7M+AmKitVjXrj3TgYjbrhSCBXNhRCw/uOGyQ5ssRiluKZxCm0PhIeZ5
 hP5mRsd+ZEiwBc5DjA0lmq4jsV3mP3auXrXQBgNJdj0xVVK2n9Og5O1aZF8v1KXPa
 94/dfoZbZ7BE0XLNLnUtOxgSEcMlrYODinCWcPGYJtSiiCfyqcJXMkHZAiSjhrhs8
 x5mOr3ENjwLBuWnevTnn99Ugt2VCv1yIoHuOVn9I32LeswVvFHh3eMOQm/W8ti0K1
 yGmffyh2rRksX1Ne7A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MTOha-1w6nFP1ezE-00YcWs; Sun, 01
 Mar 2026 20:16:51 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Sun, 01 Mar 2026 20:16:33 +0100
Subject: [PATCH v11 08/21] multifd: Add COLO support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260301-colo_unit_test_multifd-v11-8-a9701e795d7a@web.de>
References: <20260301-colo_unit_test_multifd-v11-0-a9701e795d7a@web.de>
In-Reply-To: <20260301-colo_unit_test_multifd-v11-0-a9701e795d7a@web.de>
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
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppJCdZPGTqqgXWo7zTEF9hiwG31wR6rpA3gTdk
 bxgf5tlGOiJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaSQnQAKCRA1qwsonF2y
 WBv9D/9BVonMKqKg+RI9XC8Nz/y71bLrO0O0MXRP4DxZ9XxzJW4uY43VNyWk7F17ofHLLjUkFBU
 96n6JL7bsUQmvFG6hk5cOIQR7XNgiOHY78sB6pGyS2i+ktPoCOMVSZ1YgJSWfZZtnGAOWFeP9Ne
 fYc2P81T6RVWt2umiwloiJ+k8tWAYVPWt4mNb6LinIxMZg2BRAQR2NPYcbSxXtoxfLZlN0yal2N
 Dy3w4DFm8+9K/dtJ80ulhmLzHdVK9eGJXekeHzNJLjscB5DBNUgScIUq+TpHgZeTr5irktw94M0
 VKfMcJd4wERV230JKagcvDPGqWHyISpVL0CVjDhuRL5uaZUBpwpxykw1Nd5hLq03MbDuogRxSQy
 NZ0XVwdJ71gqN0pl73L8zTzk8/ffctTUMzh/APaJbKE4LvmI9x9Dm1VjHU93sow3oUwXDSkSwNA
 20mOUhFOT2LXmaiQ/CD7CzECFDb6drKh+DEszF+Cvu5VeiSVit8NC3RqBRedd0z/7GYw60IFzx0
 ZQqfn99kXbYmCZAFBxLkjU4gEfvqkN976z/YnuuzKOaoAEndW70ZGceUvMBIUDO6tdcgHCQjwsS
 fWUhYL4wJsCVvThWh+xeWOp8LublpEc8wjRjQmdPJjAGCpi1JEeNorvhwytpyKPBk2AhYWdMO9R
 XOE4QmbZGys6f9w==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:h1eCkNsSZXb8XWgF+qw5Pckk7s1zGzNgLWeD8sG+b/OZK3gCVvG
 WlS59+cLHK31VmExpfqoBQjgzg6wNkb5Bmg8SLO3FqNVzMlzHhNBB0ymZvsAhxhsFVwTy/M
 d5v9JdDhVLwZrCISoCxVkDjz/RcEIKBYW4V3ORu+HIP3BcF2mZFCvtMFU2PzRsBm+FzSD8L
 Cz+lg9amgqPW7YQ817CJA==
UI-OutboundReport: notjunk:1;M01:P0:5oY/tzs66Mc=;UBDvW2+vCOTdl0m6G5chKf3mWOv
 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
 fjjRCMVA=
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


