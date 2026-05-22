Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D252FCD5BB1
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 12:06:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQOdR-0001k0-7e; Fri, 22 May 2026 08:05:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wQOdP-0001jL-FH
 for qemu-devel@nongnu.org; Fri, 22 May 2026 08:05:47 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wQOdL-0000Mb-Q9
 for qemu-devel@nongnu.org; Fri, 22 May 2026 08:05:47 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c08:7605:0:640:8d9a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 420E5807BE;
 Fri, 22 May 2026 15:05:42 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:55c::1:1d])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id Z5T7aO0g14Y0-JvpM5AvU; Fri, 22 May 2026 15:05:41 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1779451541;
 bh=dWPOBNVpPEKO36HL7TPi/xOVGfxiQTBjdMm7k6ej8o8=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=jXMVhWcHlu7XWY27vF2FUueuzpnPI8SrW0V+Kfs7WOC0X0wowlrgorJYoDPzHofUB
 /nqrHIIkLZOwbPoRLyAo1+7KWZoZpyBJ1ps8ITvwCpxZ24tlWELGnwE1QKX9+QCJHW
 HE8kQ/oHsYl2YwENPEq6zdfO2Qo6GOt3aTku84eI=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: armbru@redhat.com, peterx@redhat.com, farosas@suse.de,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org, berrange@redhat.com, pbonzini@redhat.com,
 yc-core@yandex-team.ru
Subject: [PATCH v16 4/8] net: introduce vmstate_net_peer_backend
Date: Fri, 22 May 2026 15:05:29 +0300
Message-ID: <20260522120534.77653-5-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260522120534.77653-1-vsementsov@yandex-team.ru>
References: <20260522120534.77653-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

To implement backend migration in virtio-net in the next commit, we need
a generic API to migrate net backend. Here is it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Ben Chaney <bchaney@akamai.com>
---
 include/net/net.h |  4 ++++
 net/net.c         | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/include/net/net.h b/include/net/net.h
index 45bc86fc86b..aa34043b1ac 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -5,6 +5,7 @@
 #include "qapi/qapi-types-net.h"
 #include "net/queue.h"
 #include "hw/core/qdev-properties-system.h"
+#include "migration/vmstate.h"
 
 #define MAC_FMT "%02X:%02X:%02X:%02X:%02X:%02X"
 #define MAC_ARG(x) ((uint8_t *)(x))[0], ((uint8_t *)(x))[1], \
@@ -110,6 +111,7 @@ typedef struct NetClientInfo {
     SetSteeringEBPF *set_steering_ebpf;
     NetCheckPeerType *check_peer_type;
     GetVHostNet *get_vhost_net;
+    const VMStateDescription *backend_vmsd;
 } NetClientInfo;
 
 struct NetClientState {
@@ -354,4 +356,6 @@ static inline bool net_peer_needs_padding(NetClientState *nc)
   return nc->peer && !nc->peer->do_not_pad;
 }
 
+extern const VMStateInfo vmstate_net_peer_backend;
+
 #endif
diff --git a/net/net.c b/net/net.c
index 2892f1730d1..8bccb1880a1 100644
--- a/net/net.c
+++ b/net/net.c
@@ -58,6 +58,7 @@
 #include "qapi/string-output-visitor.h"
 #include "qapi/qobject-input-visitor.h"
 #include "standard-headers/linux/virtio_net.h"
+#include "migration/vmstate.h"
 
 /* Net bridge is currently not supported for W32. */
 #if !defined(_WIN32)
@@ -2173,3 +2174,49 @@ int net_fill_rstate(SocketReadState *rs, const uint8_t *buf, int size)
     assert(size == 0);
     return 0;
 }
+
+static int get_peer_backend(QEMUFile *f, void *pv, size_t size,
+                            const VMStateField *field)
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
+                            const VMStateField *field, JSONWriter *vmdesc)
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
2.52.0


