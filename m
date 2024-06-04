Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A9F0C27C52
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 07:39:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEOkO-0008Jd-7P; Tue, 04 Jun 2024 03:38:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sEOkM-0008Il-Si
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 03:38:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sEOkK-0006Jh-Rf
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 03:38:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717486696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UkkYK0qeJJY1pNn7NqxCZ0K5KnI9fVIwKynclROcpbw=;
 b=XYXPDbisxqTUBLCuCyLu/I3HBkVzZwKcb3gx4NKpYAESEIwqsaib0wG9kN3ITQ+PHUJ6oK
 JJsKqwr5r//fKfeQz52HHK0xWSGEI6UCdRuOdO/1vaEO0JhcGnCtTxBvGZkD8qES7bhkuw
 jAiqqzzO+mxW+ph5bjuwqtNkRtuXDH8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-vT4ARsqAN5yaaglcDQ2FAw-1; Tue,
 04 Jun 2024 03:38:12 -0400
X-MC-Unique: vT4ARsqAN5yaaglcDQ2FAw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BE9B628C9822;
 Tue,  4 Jun 2024 07:38:11 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.238])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AF881492BD4;
 Tue,  4 Jun 2024 07:38:09 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 03/20] net: Move virtio-net header length assertion
Date: Tue,  4 Jun 2024 15:37:38 +0800
Message-ID: <20240604073755.1859-4-jasowang@redhat.com>
In-Reply-To: <20240604073755.1859-1-jasowang@redhat.com>
References: <20240604073755.1859-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

The virtio-net header length assertion should happen for any clients.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/net.c | 5 +++++
 net/tap.c | 3 ---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/net.c b/net/net.c
index bd51037ebf..db096765f4 100644
--- a/net/net.c
+++ b/net/net.c
@@ -56,6 +56,7 @@
 #include "net/filter.h"
 #include "qapi/string-output-visitor.h"
 #include "qapi/qobject-input-visitor.h"
+#include "standard-headers/linux/virtio_net.h"
 
 /* Net bridge is currently not supported for W32. */
 #if !defined(_WIN32)
@@ -550,6 +551,10 @@ void qemu_set_vnet_hdr_len(NetClientState *nc, int len)
         return;
     }
 
+    assert(len == sizeof(struct virtio_net_hdr_mrg_rxbuf) ||
+           len == sizeof(struct virtio_net_hdr) ||
+           len == sizeof(struct virtio_net_hdr_v1_hash));
+
     nc->vnet_hdr_len = len;
     nc->info->set_vnet_hdr_len(nc, len);
 }
diff --git a/net/tap.c b/net/tap.c
index c848844955..49edf6c2b6 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -267,9 +267,6 @@ static void tap_set_vnet_hdr_len(NetClientState *nc, int len)
     TAPState *s = DO_UPCAST(TAPState, nc, nc);
 
     assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
-    assert(len == sizeof(struct virtio_net_hdr_mrg_rxbuf) ||
-           len == sizeof(struct virtio_net_hdr) ||
-           len == sizeof(struct virtio_net_hdr_v1_hash));
 
     tap_fd_set_vnet_hdr_len(s->fd, len);
     s->host_vnet_hdr_len = len;
-- 
2.42.0


