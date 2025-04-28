Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3711C369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 18:53:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9TbF-000364-AP; Mon, 28 Apr 2025 14:53:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u9TbB-00035i-It
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 14:53:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u9Tb8-0002pK-61
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 14:53:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745866377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DmYvrqJTlIdqmfqPJoYO+efNt7GyDo0tjvvvCwR53C0=;
 b=OjyZCTw2USzGQuy0S5p8gAOkxvpAyHfeNgox+sjlvxNHA8YJlx/72QvjLlUbzWUty9xM/s
 FfReWB/JscV3L8I5e0VHa4o9WQzRUaTsW2f/Rxnc1V2yq2KSamA4USyVcfnEsfv6h2cc4m
 OrN7dyYw/MFb57KXeaHhqo7BXuIJ584=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-473-m8CAJA3fM5egRc8l-3C8eA-1; Mon,
 28 Apr 2025 14:52:53 -0400
X-MC-Unique: m8CAJA3fM5egRc8l-3C8eA-1
X-Mimecast-MFC-AGG-ID: m8CAJA3fM5egRc8l-3C8eA_1745866372
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1A1AF18001E0; Mon, 28 Apr 2025 18:52:52 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.31])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7F6D3180045B; Mon, 28 Apr 2025 18:52:50 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Richard W.M. Jones" <rjones@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v2 1/4] nbd: Add multi-conn option
Date: Mon, 28 Apr 2025 13:46:44 -0500
Message-ID: <20250428185246.492388-7-eblake@redhat.com>
In-Reply-To: <20250428185246.492388-6-eblake@redhat.com>
References: <20250428185246.492388-6-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.484,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: "Richard W.M. Jones" <rjones@redhat.com>

Add multi-conn option to the NBD client.  This commit just adds the
option, it is not functional.

Setting this to a value > 1 permits multiple connections to the NBD
server; a typical value might be 4.  The default is 1, meaning only a
single connection is made.  If the NBD server does not advertise that
it is safe for multi-conn then this setting is forced to 1.

Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
[eblake: also expose it through QMP]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qapi/block-core.json |  8 +++++++-
 block/nbd.c          | 24 ++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 7f70ec6d3cb..5c10824f35b 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -4545,6 +4545,11 @@
 #     until successful or until @open-timeout seconds have elapsed.
 #     Default 0 (Since 7.0)
 #
+# @multi-conn: Request the number of parallel client connections to make
+#     to the server, up to 16.  If the server does not advertise support
+#     for multiple connections, or if this value is 0 or 1, all traffic
+#     is sent through a single connection.  Default 1 (Since 10.1)
+#
 # Features:
 #
 # @unstable: Member @x-dirty-bitmap is experimental.
@@ -4558,7 +4563,8 @@
             '*tls-hostname': 'str',
             '*x-dirty-bitmap': { 'type': 'str', 'features': [ 'unstable' ] },
             '*reconnect-delay': 'uint32',
-            '*open-timeout': 'uint32' } }
+            '*open-timeout': 'uint32',
+            '*multi-conn': 'uint32' } }

 ##
 # @BlockdevOptionsRaw:
diff --git a/block/nbd.c b/block/nbd.c
index d5a2b21c6d1..5eb00e360af 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -48,6 +48,7 @@

 #define EN_OPTSTR ":exportname="
 #define MAX_NBD_REQUESTS    16
+#define MAX_MULTI_CONN      16

 #define COOKIE_TO_INDEX(cookie) ((cookie) - 1)
 #define INDEX_TO_COOKIE(index)  ((index) + 1)
@@ -97,6 +98,7 @@ typedef struct BDRVNBDState {
     /* Connection parameters */
     uint32_t reconnect_delay;
     uint32_t open_timeout;
+    uint32_t multi_conn;
     SocketAddress *saddr;
     char *export;
     char *tlscredsid;
@@ -1840,6 +1842,15 @@ static QemuOptsList nbd_runtime_opts = {
                     "attempts until successful or until @open-timeout seconds "
                     "have elapsed. Default 0",
         },
+        {
+            .name = "multi-conn",
+            .type = QEMU_OPT_NUMBER,
+            .help = "If > 1 permit up to this number of connections to the "
+                    "server. The server must also advertise multi-conn "
+                    "support.  If <= 1, only a single connection is made "
+                    "to the server even if the server advertises multi-conn. "
+                    "Default 1",
+        },
         { /* end of list */ }
     },
 };
@@ -1895,6 +1906,10 @@ static int nbd_process_options(BlockDriverState *bs, QDict *options,

     s->reconnect_delay = qemu_opt_get_number(opts, "reconnect-delay", 0);
     s->open_timeout = qemu_opt_get_number(opts, "open-timeout", 0);
+    s->multi_conn = qemu_opt_get_number(opts, "multi-conn", 1);
+    if (s->multi_conn > MAX_MULTI_CONN) {
+        s->multi_conn = MAX_MULTI_CONN;
+    }

     ret = 0;

@@ -1949,6 +1964,15 @@ static int nbd_open(BlockDriverState *bs, QDict *options, int flags,

     nbd_client_connection_enable_retry(s->conn);

+    /*
+     * We set s->multi_conn in nbd_process_options above, but now that
+     * we have connected if the server doesn't advertise that it is
+     * safe for multi-conn, force it to 1.
+     */
+    if (!(s->info.flags & NBD_FLAG_CAN_MULTI_CONN)) {
+        s->multi_conn = 1;
+    }
+
     return 0;

 fail:
-- 
2.49.0


