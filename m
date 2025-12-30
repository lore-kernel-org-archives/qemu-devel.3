Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56BEAE95A95
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 14:07:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaaMU-00048m-8P; Tue, 30 Dec 2025 09:06:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vaaMR-000477-7z
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 09:06:07 -0500
Received: from mout.web.de ([217.72.192.78])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vaaMN-0000f3-Od
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 09:06:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1767103557; x=1767708357; i=lukasstraub2@web.de;
 bh=aEDt9j/ypr6P7eHORllvpkd1Ov+70gDWVLTQtJ9u6F0=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=jV5SFBQTui1DTj562vfspCUXgr+MntlS9o4VWVm0zwsUEc5bJ2krDPJFVx0mgZTj
 YhaggZUcjj/XAIA3wUvWZG0G69PWI82Orgw6y5o09KNCLLT+WGR8MtfDRAju25ZiU
 yHxWEX1xU/WzqIYsFBFft+2K/miuMNQms9GawI7xDDqVBB1qAJoqjUjF7TxpGu7Y8
 wr5nrmiRD6/4NaFbjucLX21TkK6QpRdG5jZwi2uBOw82kXkrtZkEbdRrVqhItsu2q
 GIU8k5ABg9VqHbJs8n2tYJcmWRIGFWstJ7K8NSGgvC3pMtvi2NHxnWKwaKu1TcDIx
 A7dGSLNis6GTp8/+iA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.110.28]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Ml4B4-1wLlcX1gbM-00cP2N; Tue, 30
 Dec 2025 15:05:57 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Tue, 30 Dec 2025 15:05:44 +0100
Subject: [PATCH 1/3] multifd: Add colo support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20251230-colo_unit_test_multifd-v1-1-f9734bc74c71@web.de>
References: <20251230-colo_unit_test_multifd-v1-0-f9734bc74c71@web.de>
In-Reply-To: <20251230-colo_unit_test_multifd-v1-0-f9734bc74c71@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, Lukas Straub <lukasstraub2@web.de>, 
 Juan Quintela <quintela@trasno.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4969; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=WEqMLIYGPbH277vwdaIfTsLN0MNJZBuipO7n2sS33ok=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpU9xDv4gBT2cp/vbG2BtogYaPdDnO7Mmkj2655
 G4Y+ETn9V6JAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaVPcQwAKCRA1qwsonF2y
 WEdxD/wNi7tEcfR5XqP3oBJJ7qeALgTNBdtM229n6XpV7TpN/NuZbnOh35HdGuG2Pp/qwYo5FX4
 aXkoD0Lq63wA5vzqEH+GQTlDJ1teBdLjzUMo+qlphEjHsZm9W3qST3h9VsH7UC9sUgh9G8lb7QU
 52Zzxaqosi8T2czsXuTIwSlwL1rNsF5Htnut6wVlYX6Nkw6M9aRtbjqQB9I8ECKEQpZMZMcCopk
 T7Rg9IDiu7C8lj6G40+flTek4i4AOAjnN7Ds4pmsTQlJHHveGUDkzkKZMrXvem2wIx6AS+p5Y1F
 CaMcO0xxLnpmZnQsb5bSDAuMRzTec/7SlgNxtWdAPDHVSR8yW5VJa40O9MMz0hiL50CvM6qc3Yg
 2dgJUq7sNdNMea6zfsDIF+QL0fFHk24E3urHRH3ReRxVkRsCeOAAeP+GJiQL6XeYZO/a+LGx0x9
 sBTetztOZFjRxFNWqiihGTTpQ3ZSNE/dFukxqWUUpbo40pbSbP0a3RtbTVYWrm6W8nSdlgDsMfo
 OK4X/2+U3E7RxeXLgdqX2vxdDVVT9S2sEElYqHahYhM93jS73nh6E0Ve1dkWPmz/FPF9hIfAGwx
 ST7eoePN9p4B1yKrNSFWuyESiZahZE1kkYIJsGUi/PMcUvpY152M5i5wQtm/UDQ63Sl2MxwtRDG
 D4v7I1dvsR2/WQQ==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:cQ4pVeDVEZ+LMnifMz0rm1auwcgJzZcmYixT5pimtpAEraF4yR+
 o19xKPmW4TxLXGuGMpJSmbPOnA+ohlWQO4ce/1BrPrhUW+Grf8qmXa06rAwWWCTZ3x11d4S
 rDlgtdG/bwwxCJnZirTVfPN6iN8KwYr83kS0rszwJ6anoYZrjgfEPXqluCYkTK1p90ig7hR
 Ua0IEWWOItvP6XF/q7MWQ==
UI-OutboundReport: notjunk:1;M01:P0:3ABiWVpGz7o=;moy6hoJkYtM3671C4gvQMsAQVRr
 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
 jFZzT1meMbXDrWJtPgdDfBx0rmwOVz2S2OXVB5
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
List-Id: <qemu-devel.nongnu.org>
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

Signed-off-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 migration/meson.build    |  2 +-
 migration/multifd-colo.c | 57 +++++++++++++++++++++++++++++++++++++++++++=
+++++
 migration/multifd-colo.h | 26 ++++++++++++++++++++++
 migration/multifd.c      | 14 +++++++++---
 4 files changed, 95 insertions(+), 4 deletions(-)

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
index 0000000000000000000000000000000000000000..05a81e57b2bda517cbc0844b4f=
03dc78453f6af8
=2D-- /dev/null
+++ b/migration/multifd-colo.c
@@ -0,0 +1,57 @@
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
+    if (!migrate_colo()) {
+        return;
+    }
+
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
+    if (!migrate_colo()) {
+        return;
+    }
+
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
index bf6da85af8a1e207235ce06b8dbace33beded6d8..9006f73cc5b52e8814da107c0b=
5c867ee6d03a95 100644
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
@@ -1398,11 +1399,18 @@ static void *multifd_recv_thread(void *opaque)
             if (is_device_state) {
                 assert(use_packets);
                 ret =3D multifd_device_state_recv(p, &local_err);
+                if (ret !=3D 0) {
+                    break;
+                }
             } else {
+                multifd_colo_prepare_recv(p);
+
                 ret =3D multifd_recv_state->ops->recv(p, &local_err);
-            }
-            if (ret !=3D 0) {
-                break;
+                if (ret !=3D 0) {
+                    break;
+                }
+
+                multifd_colo_process_recv(p);
             }
         } else if (is_device_state) {
             error_setg(&local_err,

=2D-=20
2.39.5


