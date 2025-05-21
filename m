Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C222C54ED0
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 13:56:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHjux-0008MG-6Q; Wed, 21 May 2025 09:55:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uHjuo-0008D6-Oc
 for qemu-devel@nongnu.org; Wed, 21 May 2025 09:55:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uHjun-000754-0Q
 for qemu-devel@nongnu.org; Wed, 21 May 2025 09:55:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747835723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B3+EyUCTIK9FqId1wl+BA9m2aXuQYDWfJ5AScKo9HVI=;
 b=cNPzTLVqoVqxnhyVdopk+1Hk66Zy5EHrjuJ9r7cR3xgfr6BehON/VrGy738DDSGJXx+oqL
 yWSn/JZzLqPH1vN6N7OWQyksdXAEkxdiFgyYHMNor1a4/BbmMJkS3wUbNvySyukD68lfgQ
 jpMVVz61+TZmlPvVXu9jX+coQWGhwok=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-wTsbBlX3MB-rVFMW-97xmA-1; Wed,
 21 May 2025 09:55:22 -0400
X-MC-Unique: wTsbBlX3MB-rVFMW-97xmA-1
X-Mimecast-MFC-AGG-ID: wTsbBlX3MB-rVFMW-97xmA_1747835721
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 095FD18004AD; Wed, 21 May 2025 13:55:21 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.2.64])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 66A3F19560AB; Wed, 21 May 2025 13:55:19 +0000 (UTC)
From: Juraj Marcin <jmarcin@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, vsementsov@yandex-team.ru,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v5 4/6] util/qemu-sockets: Add support for keep-alive flag to
 passive sockets
Date: Wed, 21 May 2025 15:52:33 +0200
Message-ID: <20250521135240.3941598-5-jmarcin@redhat.com>
In-Reply-To: <20250521135240.3941598-1-jmarcin@redhat.com>
References: <20250521135240.3941598-1-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Juraj Marcin <jmarcin@redhat.com>

Commit aec21d3175 (qapi: Add InetSocketAddress member keep-alive)
introduces the keep-alive flag, which enables the SO_KEEPALIVE socket
option, but only on client-side sockets. However, this option is also
useful for server-side sockets, so they can check if a client is still
reachable or drop the connection otherwise.

This patch enables the SO_KEEPALIVE socket option on passive server-side
sockets if the keep-alive flag is enabled. This socket option is then
inherited by active server-side sockets communicating with connected
clients.

Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qapi/sockets.json   | 4 ++--
 util/qemu-sockets.c | 9 +++------
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/qapi/sockets.json b/qapi/sockets.json
index 6a95023315..62797cd027 100644
--- a/qapi/sockets.json
+++ b/qapi/sockets.json
@@ -56,8 +56,8 @@
 # @ipv6: whether to accept IPv6 addresses, default try both IPv4 and
 #     IPv6
 #
-# @keep-alive: enable keep-alive when connecting to this socket.  Not
-#     supported for passive sockets.  (Since 4.2)
+# @keep-alive: enable keep-alive when connecting to/listening on this socket.
+#     (Since 4.2, not supported for listening sockets until 10.1)
 #
 # @mptcp: enable multi-path TCP.  (Since 6.1)
 #
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 329fdbfd97..4fbf1ed5bf 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -236,12 +236,6 @@ static int inet_listen_saddr(InetSocketAddress *saddr,
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
@@ -349,6 +343,9 @@ static int inet_listen_saddr(InetSocketAddress *saddr,
                 goto fail;
             }
             /* We have a listening socket */
+            if (inet_set_sockopts(slisten, saddr, errp) < 0) {
+                goto fail;
+            }
             freeaddrinfo(res);
             return slisten;
         }
-- 
2.49.0


