Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F90CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 11:51:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9MNZ-0007Qp-AT; Thu, 16 Oct 2025 07:42:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v9MMt-00078y-6q; Thu, 16 Oct 2025 07:42:03 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v9MMi-0003Vg-4r; Thu, 16 Oct 2025 07:42:01 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 178FBC01D9;
 Thu, 16 Oct 2025 14:41:35 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a8c::1:19])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id LfP2M73FEmI0-8SW4HDUx; Thu, 16 Oct 2025 14:41:34 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760614894;
 bh=ATBOk7y2BkgORhsGkD3qM3CJxtTyEmK5hDTvCDCS0bI=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=DK2q2cFa+YysBJZ7APancKjLfoPdtnagj6nH30xp4wTDn4U07tbKBm57dk1Qk3R7Z
 qCcjZNhy/CYtrrAAawGohBAcECSEJ1J9X1GrigwLlBGerNwlJ+xdC94hc6Nu1mwGFi
 78Oi1lyUx157LRTtBeJ6mVv1GlNJ736m3eMiu2Sw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: raphael@enfabrica.net,
	pbonzini@redhat.com,
	farosas@suse.de
Cc: mst@redhat.com, sgarzare@redhat.com, marcandre.lureau@redhat.com,
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com,
 eblake@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, steven.sistare@oracle.com,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, jasowang@redhat.com,
 Peter Xu <peterx@redhat.com>
Subject: [PATCH v2 15/25] migration: introduce vmstate_event_notifier
Date: Thu, 16 Oct 2025 14:40:52 +0300
Message-ID: <20251016114104.1384675-16-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251016114104.1384675-1-vsementsov@yandex-team.ru>
References: <20251016114104.1384675-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

This will be used to support backend-transfer migration for
vhost-user-blk, we'll migrate event notifier fds through
migration stream, to avoid extra contact with backend.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 include/migration/vmstate.h        |  7 ++++
 migration/meson.build              |  1 +
 migration/vmstate-event-notifier.c | 54 ++++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+)
 create mode 100644 migration/vmstate-event-notifier.c

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index f243518fb5..7f1f1c166a 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -1294,4 +1294,11 @@ void vmstate_register_ram_global(struct MemoryRegion *memory);
 
 bool vmstate_check_only_migratable(const VMStateDescription *vmsd);
 
+extern const VMStateDescription vmstate_event_notifier;
+
+#define VMSTATE_EVENT_NOTIFIER(_field, _struct) \
+    VMSTATE_STRUCT(_field, _struct, 0, vmstate_event_notifier, \
+                   EventNotifier)
+
+
 #endif
diff --git a/migration/meson.build b/migration/meson.build
index 16909d54c5..b5341ae0cb 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -5,6 +5,7 @@ migration_files = files(
   'xbzrle.c',
   'vmstate-types.c',
   'vmstate.c',
+  'vmstate-event-notifier.c',
   'qemu-file.c',
   'yank_functions.c',
 )
diff --git a/migration/vmstate-event-notifier.c b/migration/vmstate-event-notifier.c
new file mode 100644
index 0000000000..2076eec961
--- /dev/null
+++ b/migration/vmstate-event-notifier.c
@@ -0,0 +1,54 @@
+/*
+ * Event notifier migration support
+ * Copyright (c) Yandex Technologies LLC, 2025
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/event_notifier.h"
+#include "migration/vmstate.h"
+
+static int event_notifier_pre_save(void *opaque)
+{
+    struct EventNotifier *e = opaque;
+
+    if (!e->initialized || e->rfd != e->wfd) {
+        return -1;
+    }
+
+    return 0;
+}
+
+static int event_notifier_pre_load(void *opaque)
+{
+    struct EventNotifier *e = opaque;
+
+    if (e->initialized) {
+        return -1;
+    }
+
+    return 0;
+}
+
+static int event_notifier_post_load(void *opaque, int version_id)
+{
+    struct EventNotifier *e = opaque;
+
+    if (e->rfd < 0) {
+        return -1;
+    }
+
+    e->wfd = e->rfd;
+    e->initialized = true;
+
+    return 0;
+}
+
+const VMStateDescription vmstate_event_notifier = {
+    .name = "event-notifier",
+    .pre_save = event_notifier_pre_save,
+    .pre_load = event_notifier_pre_load,
+    .post_load = event_notifier_post_load,
+    .fields = (const VMStateField[]){VMSTATE_FD(rfd, EventNotifier),
+                                     VMSTATE_END_OF_LIST()},
+};
-- 
2.48.1


