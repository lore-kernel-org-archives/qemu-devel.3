Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F431C36000
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 16:38:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuwQ8-0003MB-Gj; Wed, 19 Mar 2025 12:37:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1tuwQ4-0003Lj-4t
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 12:37:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1tuwQ2-00074z-0j
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 12:37:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742402244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X2sunzIviv4HaQQb3X0yTUOV4nmX52tcxBKEXC5RH8E=;
 b=VfOUl6h8fVc+Z5oKWXsCi/6QmM0+Cr228ZqWG2zkAVUIb6rH2/sxrlBRS9WRI92YWCJfuT
 Fkipvmt6vqHRWzCPWQN1Kud7aR+bHxCGmPP4B2kgQ8nBjazFZ1L7V7nLnyCUS60viskCS7
 uY8MEIBSIFI58IO3wMEYINNNgztXUE8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-389-ATKPov9GN6qD4rdFZRr3vQ-1; Wed,
 19 Mar 2025 12:37:23 -0400
X-MC-Unique: ATKPov9GN6qD4rdFZRr3vQ-1
X-Mimecast-MFC-AGG-ID: ATKPov9GN6qD4rdFZRr3vQ_1742402242
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5C671180AF53; Wed, 19 Mar 2025 16:37:22 +0000 (UTC)
Received: from rh-jmarcin.redhat.com (unknown [10.45.225.145])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4D9781955BEE; Wed, 19 Mar 2025 16:37:19 +0000 (UTC)
From: Juraj Marcin <jmarcin@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, vsementsov@yandex-team.ru,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 2/2] utils/qemu-sockets: Introduce keep-alive-idle-period
 inet socket option
Date: Wed, 19 Mar 2025 17:36:20 +0100
Message-ID: <20250319163638.456417-3-jmarcin@redhat.com>
In-Reply-To: <20250319163638.456417-1-jmarcin@redhat.com>
References: <20250319163638.456417-1-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
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

The default idle period for TCP connection could be even 2 hours.
However, in some cases, the application needs to be aware of a
connection issue much sooner.

This is the case, for example, for postcopy live migration. If there is
no traffic from the migration destination guest (server-side) to the
migration source guest (client-side), the destination keeps waiting for
pages indefinitely and does not switch to the postcopy-paused state.
This can happen, for example, if the destination QEMU instance is
started with '-S' command line option and the machine is not started yet
or if the machine is idle and produces no new page faults for
not-yet-migrated pages.

This patch introduces a new inet socket parameter on platforms where
TCP_KEEPIDLE is defined and passes the configured value to the
TCP_KEEPIDLE socket option when a client-side or server-side socket is
created.

The default value is 0, which means system configuration is used, and no
custom value is set.

Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
---
 io/dns-resolver.c   |  4 ++++
 meson.build         |  2 ++
 qapi/sockets.json   |  5 +++++
 util/qemu-sockets.c | 29 +++++++++++++++++++++++++++++
 4 files changed, 40 insertions(+)

diff --git a/io/dns-resolver.c b/io/dns-resolver.c
index ee7403b65b..03c59673f0 100644
--- a/io/dns-resolver.c
+++ b/io/dns-resolver.c
@@ -128,6 +128,10 @@ static int qio_dns_resolver_lookup_sync_inet(QIODNSResolver *resolver,
 #endif
             .has_keep_alive = iaddr->has_keep_alive,
             .keep_alive = iaddr->keep_alive,
+#ifdef HAVE_TCP_KEEPIDLE
+            .has_keep_alive_idle_period = iaddr->has_keep_alive_idle_period,
+            .keep_alive_idle_period = iaddr->keep_alive_idle_period,
+#endif
         };
 
         (*addrs)[i] = newaddr;
diff --git a/meson.build b/meson.build
index 41f68d3806..e3440b09c8 100644
--- a/meson.build
+++ b/meson.build
@@ -2734,6 +2734,8 @@ if linux_io_uring.found()
   config_host_data.set('HAVE_IO_URING_PREP_WRITEV2',
                        cc.has_header_symbol('liburing.h', 'io_uring_prep_writev2'))
 endif
+config_host_data.set('HAVE_TCP_KEEPIDLE',
+                     cc.has_header_symbol('netinet/tcp.h', 'TCP_KEEPIDLE'))
 
 # has_member
 config_host_data.set('HAVE_SIGEV_NOTIFY_THREAD_ID',
diff --git a/qapi/sockets.json b/qapi/sockets.json
index eb50f64e3a..ddd82b1e66 100644
--- a/qapi/sockets.json
+++ b/qapi/sockets.json
@@ -59,6 +59,10 @@
 # @keep-alive: enable keep-alive when connecting to/listening on this socket.
 #     (Since 4.2, not supported for listening sockets until 10.0)
 #
+# @keep-alive-idle-period: time in seconds the connection needs to be idle
+#     before sending a keepalive packet.  Only supported for TCP sockets on
+#     systems where TCP_KEEPIDLE socket option is defined.  (Since 10.0)
+#
 # @mptcp: enable multi-path TCP.  (Since 6.1)
 #
 # Since: 1.3
@@ -71,6 +75,7 @@
     '*ipv4': 'bool',
     '*ipv6': 'bool',
     '*keep-alive': 'bool',
+    '*keep-alive-idle-period': { 'type': 'uint32', 'if': 'HAVE_TCP_KEEPIDLE' },
     '*mptcp': { 'type': 'bool', 'if': 'HAVE_IPPROTO_MPTCP' } } }
 
 ##
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 99357a4435..23c8a6cc2b 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -217,6 +217,19 @@ static int inet_set_sockopts(int sock, InetSocketAddress *saddr, Error **errp)
                              "Unable to set keep-alive option on socket");
             return -1;
         }
+#ifdef HAVE_TCP_KEEPIDLE
+        if (saddr->has_keep_alive_idle_period &&
+            saddr->keep_alive_idle_period) {
+            int keep_idle = saddr->has_keep_alive_idle_period;
+            ret = setsockopt(sock, IPPROTO_TCP, TCP_KEEPIDLE, &keep_idle,
+                             sizeof(keep_idle));
+            if (ret < 0) {
+                error_setg_errno(errp, errno,
+                                 "Unable to set TCP keep-alive idle option on socket");
+                return -1;
+            }
+        }
+#endif
     }
     return 0;
 }
@@ -697,6 +710,22 @@ int inet_parse(InetSocketAddress *addr, const char *str, Error **errp)
         }
         addr->has_keep_alive = true;
     }
+#ifdef HAVE_TCP_KEEPIDLE
+    begin = strstr(optstr, ",keep-alive-idle-period=");
+    if (begin) {
+        begin += strlen(",keep-alive-idle-period=");
+        if (sscanf(begin, "%" PRIu32 "%n", &addr->keep_alive_idle_period, &pos) != 1 ||
+            (begin[pos] != '\0' && begin[pos] != ',')) {
+            error_setg(errp, "error parsing keep-alive-idle-period argument");
+            return -1;
+        }
+        if (addr->keep_alive_idle_period > INT_MAX) {
+            error_setg(errp, "keep-alive-idle-period value is too large");
+            return -1;
+        }
+        addr->has_keep_alive_idle_period = true;
+    }
+#endif
 #ifdef HAVE_IPPROTO_MPTCP
     begin = strstr(optstr, ",mptcp");
     if (begin) {
-- 
2.48.1


