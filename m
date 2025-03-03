Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ACB0C282D1
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 14:34:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp6sW-0007HF-QN; Mon, 03 Mar 2025 09:34:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1tp6rf-0006t0-JE
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 09:33:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1tp6rd-0003Gx-Am
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 09:33:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741012427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ALVHmok+ZJdOQ2tcqIX7TrVFCvB91OaBNArCu7swjws=;
 b=NPtdG+2a0AcifJ1JVkdCU4Dd9NY9VUvAi2EMV49Cg+MBFVWx8cFNB9Cz2kGhd45b5K9xy9
 w+WTxVtJHaGj0QH/fNjomIx7ewN9kFFtldoIDF+B1zC4po8IeFTkXD11mqYhAmu7L+DRv/
 N5Z3f9L4i++XgNix1QA5H/HgEYuhwps=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-373-wFe-Jdp1O2-aakpqcxie1g-1; Mon,
 03 Mar 2025 09:33:37 -0500
X-MC-Unique: wFe-Jdp1O2-aakpqcxie1g-1
X-Mimecast-MFC-AGG-ID: wFe-Jdp1O2-aakpqcxie1g_1741012416
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AE322191815F; Mon,  3 Mar 2025 14:33:36 +0000 (UTC)
Received: from rh-jmarcin.redhat.com (unknown [10.44.34.124])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5BC9519560AB; Mon,  3 Mar 2025 14:33:33 +0000 (UTC)
From: Juraj Marcin <jmarcin@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, vsementsov@virtuozzo.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 1/2] util/qemu-sockets: Add support for keep-alive flag to
 passive sockets
Date: Mon,  3 Mar 2025 15:33:05 +0100
Message-ID: <20250303143312.640909-2-jmarcin@redhat.com>
In-Reply-To: <20250303143312.640909-1-jmarcin@redhat.com>
References: <20250303143312.640909-1-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Commit aec21d3175 (qapi: Add InetSocketAddress member keep-alive)
introduces the keep-alive flag, which enables the SO_KEEPALIVE socket
option, but only on client-side sockets. However, this option is also
useful for server-side sockets, so they can check if a client is still
reachable or drop the connection otherwise.

This patch enables the SO_KEEPALIVE socket option on passive server-side
sockets if the keep-alive flag is enabled. This socket option is then
inherited by active server-side sockets communicating with connected
clients.

This patch also fixes an issue in 'qio_dns_resolver_lookup_sync_inet()'
where the keep-alive flag is not copied together with other attributes.

Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
---
 io/dns-resolver.c   |  2 ++
 qapi/sockets.json   |  4 ++--
 util/qemu-sockets.c | 19 +++++++++++++------
 3 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/io/dns-resolver.c b/io/dns-resolver.c
index 53b0e8407a..ee7403b65b 100644
--- a/io/dns-resolver.c
+++ b/io/dns-resolver.c
@@ -126,6 +126,8 @@ static int qio_dns_resolver_lookup_sync_inet(QIODNSResolver *resolver,
             .has_mptcp = iaddr->has_mptcp,
             .mptcp = iaddr->mptcp,
 #endif
+            .has_keep_alive = iaddr->has_keep_alive,
+            .keep_alive = iaddr->keep_alive,
         };
 
         (*addrs)[i] = newaddr;
diff --git a/qapi/sockets.json b/qapi/sockets.json
index 6a95023315..eb50f64e3a 100644
--- a/qapi/sockets.json
+++ b/qapi/sockets.json
@@ -56,8 +56,8 @@
 # @ipv6: whether to accept IPv6 addresses, default try both IPv4 and
 #     IPv6
 #
-# @keep-alive: enable keep-alive when connecting to this socket.  Not
-#     supported for passive sockets.  (Since 4.2)
+# @keep-alive: enable keep-alive when connecting to/listening on this socket.
+#     (Since 4.2, not supported for listening sockets until 10.0)
 #
 # @mptcp: enable multi-path TCP.  (Since 6.1)
 #
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 77477c1cd5..c30e4ac2ce 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -220,12 +220,6 @@ static int inet_listen_saddr(InetSocketAddress *saddr,
     int saved_errno = 0;
     bool socket_created = false;
 
-    if (saddr->keep_alive) {
-        error_setg(errp, "keep-alive option is not supported for passive "
-                   "sockets");
-        return -1;
-    }
-
     memset(&ai,0, sizeof(ai));
     ai.ai_flags = AI_PASSIVE;
     if (saddr->has_numeric && saddr->numeric) {
@@ -344,6 +338,19 @@ listen_failed:
     return -1;
 
 listen_ok:
+    if (saddr->keep_alive) {
+        int val = 1;
+        int ret = setsockopt(slisten, SOL_SOCKET, SO_KEEPALIVE,
+                             &val, sizeof(val));
+
+        if (ret < 0) {
+            error_setg_errno(errp, errno, "Unable to set KEEPALIVE");
+            close(slisten);
+            slisten = -1;
+            goto exit;
+        }
+    }
+exit:
     freeaddrinfo(res);
     return slisten;
 }
-- 
2.48.1


