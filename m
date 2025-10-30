Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBFC7CCF9E3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 20:33:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEZJg-0000lf-4a; Thu, 30 Oct 2025 16:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEZJH-0000gM-Mp
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 16:31:52 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEZIx-0005vT-Tg
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 16:31:48 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id DC32280AAA;
 Thu, 30 Oct 2025 23:31:23 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:861::1:2b])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id HVmKdN0F6Cg0-ELmHcMW9; Thu, 30 Oct 2025 23:31:23 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761856283;
 bh=yr86GKt6fRLAn3ICldus7yhJBrk2W1GNN0v7ofSRZkc=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=1ys0C97pAv8i92Z5wOYIPnuD+ab3duSBZLtTAhmFs83DJ/umRKTrwo5MHXFlUXouL
 gCBoxMYY+BEx6/ayQHqLhFsVyaF4F2neCQ52IJCPTa8PgDw9GHZKjAsAzO2wg4YASN
 RR4SlkVL47dynmfar1K5FZJQvPxiJYdjFkUJJ2l8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, philmd@linaro.org, zhao1.liu@intel.com,
 qemu-devel@nongnu.org, leiyang@redhat.com, davydov-max@yandex-team.ru,
 yc-core@yandex-team.ru, vsementsov@yandex-team.ru,
 raphael.s.norwitz@gmail.com
Subject: [PATCH v9 4/8] net: introduce vmstate_net_peer_backend
Date: Thu, 30 Oct 2025 23:31:11 +0300
Message-ID: <20251030203116.870742-5-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251030203116.870742-1-vsementsov@yandex-team.ru>
References: <20251030203116.870742-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

To implement backend-transfer migration in virtio-net in the next
commit, we need a generic API to migrate net backend. Here is it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 include/net/net.h |  4 ++++
 net/net.c         | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/include/net/net.h b/include/net/net.h
index 3aa67db57c..8375ca89a7 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -5,6 +5,7 @@
 #include "qapi/qapi-types-net.h"
 #include "net/queue.h"
 #include "hw/qdev-properties-system.h"
+#include "migration/vmstate.h"
 
 #define MAC_FMT "%02X:%02X:%02X:%02X:%02X:%02X"
 #define MAC_ARG(x) ((uint8_t *)(x))[0], ((uint8_t *)(x))[1], \
@@ -115,6 +116,7 @@ typedef struct NetClientInfo {
     NetCheckPeerType *check_peer_type;
     GetVHostNet *get_vhost_net;
     NetBackendConnect *backend_connect;
+    const VMStateDescription *backend_vmsd;
 } NetClientInfo;
 
 struct NetClientState {
@@ -360,4 +362,6 @@ static inline bool net_peer_needs_padding(NetClientState *nc)
   return nc->peer && !nc->peer->do_not_pad;
 }
 
+extern const VMStateInfo vmstate_net_peer_backend;
+
 #endif
diff --git a/net/net.c b/net/net.c
index 4fc6b1d0a6..cca4fa0a6b 100644
--- a/net/net.c
+++ b/net/net.c
@@ -57,6 +57,7 @@
 #include "qapi/string-output-visitor.h"
 #include "qapi/qobject-input-visitor.h"
 #include "standard-headers/linux/virtio_net.h"
+#include "migration/vmstate.h"
 
 /* Net bridge is currently not supported for W32. */
 #if !defined(_WIN32)
@@ -2177,3 +2178,49 @@ bool net_backend_connect(NetClientState *nc, Error **errp)
 
     return nc->info->backend_connect(nc, errp);
 }
+
+static int get_peer_backend(QEMUFile *f, void *pv, size_t size,
+                       const VMStateField *field)
+{
+    NetClientState *nc = pv;
+    Error *local_err = NULL;
+    int ret;
+
+    if (!nc->peer) {
+        return -EINVAL;
+    }
+    nc = nc->peer;
+
+    ret = vmstate_load_state(f, nc->info->backend_vmsd, nc, 0, &local_err);
+    if (ret < 0) {
+        error_report_err(local_err);
+    }
+
+    return ret;
+}
+
+static int put_peer_backend(QEMUFile *f, void *pv, size_t size,
+                       const VMStateField *field, JSONWriter *vmdesc)
+{
+    NetClientState *nc = pv;
+    Error *local_err = NULL;
+    int ret;
+
+    if (!nc->peer) {
+        return -EINVAL;
+    }
+    nc = nc->peer;
+
+    ret = vmstate_save_state(f, nc->info->backend_vmsd, nc, 0, &local_err);
+    if (ret < 0) {
+        error_report_err(local_err);
+    }
+
+    return ret;
+}
+
+const VMStateInfo vmstate_net_peer_backend = {
+    .name = "virtio-net-nic-nc-backend",
+    .get = get_peer_backend,
+    .put = put_peer_backend,
+};
-- 
2.48.1


