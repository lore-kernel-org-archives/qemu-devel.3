Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB59ECCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 11:47:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9MNb-0007Sk-Is; Thu, 16 Oct 2025 07:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v9MMx-00079V-5o; Thu, 16 Oct 2025 07:42:07 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v9MMk-0003WL-F9; Thu, 16 Oct 2025 07:42:02 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 510E7C01DF;
 Thu, 16 Oct 2025 14:41:37 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a8c::1:19])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id LfP2M73FEmI0-jWRYgAwK; Thu, 16 Oct 2025 14:41:36 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760614896;
 bh=bpYyRH+FH5+ms+TFU93oV6x9PSDyaNh07aiBxI/3YRc=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=Sqbpc+alHMEB7F5+LCy/2E+v4XokjaMKFtsNcShpufQqZBFPuScB3DtUzpfIAbaKu
 Xk/nI7wCrWm6LKqlkxpblLr5DineKaFJBXfIUzNL4ov6c6VD/z9VqRFQGZueuBQ38J
 /5qMcjOv4mG7lcUsWMv43JGPdnQNZlq4Xb6sX3o4=
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
 d-tatianin@yandex-team.ru, jasowang@redhat.com
Subject: [PATCH v2 18/25] chardev: introduce backend-transfer vmstate for
 chardev
Date: Thu, 16 Oct 2025 14:40:55 +0300
Message-ID: <20251016114104.1384675-19-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251016114104.1384675-1-vsementsov@yandex-team.ru>
References: <20251016114104.1384675-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We'll need to transfer the chardev attached to vhost-user-blk, to
support backend-transfer migration for vhost-user-blk. So, prepare
chardev vmsd now.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 chardev/char-backend-transfer.c         | 52 +++++++++++++++++++++++++
 chardev/meson.build                     |  1 +
 include/chardev/char-backend-transfer.h | 17 ++++++++
 3 files changed, 70 insertions(+)
 create mode 100644 chardev/char-backend-transfer.c
 create mode 100644 include/chardev/char-backend-transfer.h

diff --git a/chardev/char-backend-transfer.c b/chardev/char-backend-transfer.c
new file mode 100644
index 0000000000..f1a399c7fa
--- /dev/null
+++ b/chardev/char-backend-transfer.c
@@ -0,0 +1,52 @@
+/*
+ * Event notifier migration support
+ * Copyright (c) Yandex Technologies LLC, 2025
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "chardev/char-fe.h"
+#include "migration/vmstate.h"
+
+typedef struct CharBackendTransferTmp {
+    CharBackend *parent;
+    int fd;
+} CharBackendTransferTmp;
+
+static int char_backend_transfer_pre_save(void *opaque)
+{
+    CharBackendTransferTmp *tmp = opaque;
+
+    tmp->fd = qemu_chr_get_client(tmp->parent->chr);
+    if (tmp->fd < 0) {
+        return -1;
+    }
+
+    return 0;
+}
+
+static int char_backend_transfer_post_load(void *opaque, int version_id)
+{
+    CharBackendTransferTmp *tmp = opaque;
+
+    return qemu_chr_add_client(tmp->parent->chr, tmp->fd);
+}
+
+const VMStateDescription vmstate_backend_transfer_char_tmp = {
+    .name = "backend-transfer-char-tmp",
+    .pre_save = char_backend_transfer_pre_save,
+    .post_load = char_backend_transfer_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_FD(fd, CharBackendTransferTmp),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+const VMStateDescription vmstate_backend_transfer_char = {
+    .name = "backend-transfer-char",
+    .fields = (const VMStateField[]) {
+        VMSTATE_WITH_TMP(CharBackend, CharBackendTransferTmp,
+                         vmstate_backend_transfer_char_tmp),
+        VMSTATE_END_OF_LIST()
+    },
+};
diff --git a/chardev/meson.build b/chardev/meson.build
index 56ee39ac0b..239c8cd072 100644
--- a/chardev/meson.build
+++ b/chardev/meson.build
@@ -31,6 +31,7 @@ chardev_ss = chardev_ss.apply({})
 
 system_ss.add(files(
     'char-hmp-cmds.c',
+    'char-backend-transfer.c',
     'msmouse.c',
     'wctablet.c',
     'testdev.c'))
diff --git a/include/chardev/char-backend-transfer.h b/include/chardev/char-backend-transfer.h
new file mode 100644
index 0000000000..2c3da5f836
--- /dev/null
+++ b/include/chardev/char-backend-transfer.h
@@ -0,0 +1,17 @@
+/*
+ * Event notifier migration support
+ * Copyright (c) Yandex Technologies LLC, 2025
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef CHAR_BACKEND_TRANSFER_H
+#define CHAR_BACKEND_TRANSFER_H
+
+#include "qemu/typedefs.h"
+
+extern const VMStateDescription vmstate_backend_transfer_char;
+#define VMSTATE_BACKEND_TRANSFER_CHARDEV(_field, _state)                       \
+    VMSTATE_STRUCT(_field, _state, 0, vmstate_backend_transfer_char,           \
+                   CharBackend)
+
+#endif
-- 
2.48.1


