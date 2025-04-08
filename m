Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99576C369A1
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 11:27:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u275s-0007b9-Fb; Tue, 08 Apr 2025 07:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1u275p-0007aZ-Nz
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 07:26:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1u275n-0006OZ-Pv
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 07:26:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744111571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yq+SSWaeQzXTk76xvI7u2atw8L3iFrBBMkDgz0BDY5k=;
 b=AV7Gi/VoZ/rgumToQwvB69nPvnFcqG6Oyt/c/xG0FaGM8kLFlYTkvUmvc7L6a5XceGg4OE
 tte4ocvtkjIi/xL/nPDQO90qQ0Hs0zLonpameoFEng/yS2r6TuVfDAF5Cb/bF4h0krWB03
 SEYaFxFRuMnUKRyGVbrzdcAFDociyIc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-198-oqIzsSJPM3qH1lzLqmJ_Yw-1; Tue,
 08 Apr 2025 07:26:09 -0400
X-MC-Unique: oqIzsSJPM3qH1lzLqmJ_Yw-1
X-Mimecast-MFC-AGG-ID: oqIzsSJPM3qH1lzLqmJ_Yw_1744111568
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B42A419560AB; Tue,  8 Apr 2025 11:26:08 +0000 (UTC)
Received: from rh-jmarcin.redhat.com (unknown [10.44.34.27])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6D9AB195DF84; Tue,  8 Apr 2025 11:26:05 +0000 (UTC)
From: Juraj Marcin <jmarcin@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, vsementsov@yandex-team.ru,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 5/5] utils/qemu-sockets: Introduce inet socket options
 controlling TCP keep-alive
Date: Tue,  8 Apr 2025 13:25:04 +0200
Message-ID: <20250408112508.1638722-6-jmarcin@redhat.com>
In-Reply-To: <20250408112508.1638722-1-jmarcin@redhat.com>
References: <20250408112508.1638722-1-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.845,
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

With the default TCP stack configuration, it could be even 2 hours
before the connection times out due to the other side not being
reachable. However, in some cases, the application needs to be aware of
a connection issue much sooner.

This is the case, for example, for postcopy live migration. If there is
no traffic from the migration destination guest (server-side) to the
migration source guest (client-side), the destination keeps waiting for
pages indefinitely and does not switch to the postcopy-paused state.
This can happen, for example, if the destination QEMU instance is
started with the '-S' command line option and the machine is not started
yet, or if the machine is idle and produces no new page faults for
not-yet-migrated pages.

This patch introduces new inet socket parameters that control count,
idle period, and interval of TCP keep-alive packets before the
connection is considered broken. These parameters are available on
systems where the respective TCP socket options are defined
(TCP_KEEPCNT, TCP_KEEPIDLE, TCP_KEEPINTVL).

The default value for all is 0, which means the system configuration is
used.

Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
---
 meson.build         |  6 ++++
 qapi/sockets.json   | 15 ++++++++
 util/qemu-sockets.c | 88 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 109 insertions(+)

diff --git a/meson.build b/meson.build
index 41f68d3806..680f47cf42 100644
--- a/meson.build
+++ b/meson.build
@@ -2734,6 +2734,12 @@ if linux_io_uring.found()
   config_host_data.set('HAVE_IO_URING_PREP_WRITEV2',
                        cc.has_header_symbol('liburing.h', 'io_uring_prep_writev2'))
 endif
+config_host_data.set('HAVE_TCP_KEEPCNT',
+                     cc.has_header_symbol('netinet/tcp.h', 'TCP_KEEPCNT'))
+config_host_data.set('HAVE_TCP_KEEPIDLE',
+                     cc.has_header_symbol('netinet/tcp.h', 'TCP_KEEPIDLE'))
+config_host_data.set('HAVE_TCP_KEEPINTVL',
+                     cc.has_header_symbol('netinet/tcp.h', 'TCP_KEEPINTVL'))
 
 # has_member
 config_host_data.set('HAVE_SIGEV_NOTIFY_THREAD_ID',
diff --git a/qapi/sockets.json b/qapi/sockets.json
index 62797cd027..bb9d298635 100644
--- a/qapi/sockets.json
+++ b/qapi/sockets.json
@@ -59,6 +59,18 @@
 # @keep-alive: enable keep-alive when connecting to/listening on this socket.
 #     (Since 4.2, not supported for listening sockets until 10.1)
 #
+# @keep-alive-count: number of keep-alive packets sent before the connection is
+#     closed.  Only supported for TCP sockets on systems where TCP_KEEPCNT
+#     socket option is defined.  (Since 10.1)
+#
+# @keep-alive-idle: time in seconds the connection needs to be idle before
+#     sending a keepalive packet.  Only supported for TCP sockets on systems
+#     where TCP_KEEPIDLE socket option is defined.  (Since 10.1)
+#
+# @keep-alive-interval: time in secods between keep-alive packets.  Only
+#     supported for TCP sockets on systems where TCP_KEEPINTVL is defined.
+#     (Since 10.1)
+#
 # @mptcp: enable multi-path TCP.  (Since 6.1)
 #
 # Since: 1.3
@@ -71,6 +83,9 @@
     '*ipv4': 'bool',
     '*ipv6': 'bool',
     '*keep-alive': 'bool',
+    '*keep-alive-count': { 'type': 'uint32', 'if': 'HAVE_TCP_KEEPCNT' },
+    '*keep-alive-idle': { 'type': 'uint32', 'if': 'HAVE_TCP_KEEPIDLE' },
+    '*keep-alive-interval': { 'type': 'uint32', 'if': 'HAVE_TCP_KEEPINTVL' },
     '*mptcp': { 'type': 'bool', 'if': 'HAVE_IPPROTO_MPTCP' } } }
 
 ##
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index fed17a1ffb..8e355b097c 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -217,6 +217,45 @@ static int inet_set_sockopts(int sock, InetSocketAddress *saddr, Error **errp)
                              "Unable to set keep-alive option on socket");
             return -1;
         }
+#ifdef HAVE_TCP_KEEPCNT
+        if (saddr->has_keep_alive_count &&
+            saddr->keep_alive_count) {
+            int keep_count = saddr->has_keep_alive_count;
+            ret = setsockopt(sock, IPPROTO_TCP, TCP_KEEPCNT, &keep_count,
+                             sizeof(keep_count));
+            if (ret < 0) {
+                error_setg_errno(errp, errno,
+                                 "Unable to set TCP keep-alive count option on socket");
+                return -1;
+            }
+        }
+#endif
+#ifdef HAVE_TCP_KEEPIDLE
+        if (saddr->has_keep_alive_idle &&
+            saddr->keep_alive_idle) {
+            int keep_idle = saddr->has_keep_alive_idle;
+            ret = setsockopt(sock, IPPROTO_TCP, TCP_KEEPIDLE, &keep_idle,
+                             sizeof(keep_idle));
+            if (ret < 0) {
+                error_setg_errno(errp, errno,
+                                 "Unable to set TCP keep-alive idle option on socket");
+                return -1;
+            }
+        }
+#endif
+#ifdef HAVE_TCP_KEEPINTVL
+        if (saddr->has_keep_alive_interval &&
+            saddr->keep_alive_interval) {
+            int keep_interval = saddr->has_keep_alive_interval;
+            ret = setsockopt(sock, IPPROTO_TCP, TCP_KEEPINTVL, &keep_interval,
+                             sizeof(keep_interval));
+            if (ret < 0) {
+                error_setg_errno(errp, errno,
+                                 "Unable to set TCP keep-alive interval option on socket");
+                return -1;
+            }
+        }
+#endif
     }
     return 0;
 }
@@ -628,6 +667,22 @@ static int inet_parse_flag(const char *flagname, const char *optstr, bool *val,
     return 0;
 }
 
+static int inet_parse_u32(const char *optname, const char *optstr,
+                          uint32_t max, uint32_t *val, Error **errp)
+{
+    int pos;
+    if (sscanf(optstr, "%" PRIu32 "%n", val, &pos) != 1 ||
+        (optstr[pos] != '\0' && optstr[pos] != ',')) {
+        error_setg(errp, "error parsing %s argument", optname);
+        return -1;
+    }
+    if (*val > max) {
+        error_setg(errp, "%s is too large", optname);
+        return -1;
+    }
+    return 0;
+}
+
 int inet_parse(InetSocketAddress *addr, const char *str, Error **errp)
 {
     const char *optstr, *h;
@@ -700,6 +755,39 @@ int inet_parse(InetSocketAddress *addr, const char *str, Error **errp)
         }
         addr->has_keep_alive = true;
     }
+#ifdef HAVE_TCP_KEEPCNT
+    begin = strstr(optstr, ",keep-alive-count=");
+    if (begin) {
+        if (inet_parse_u32("keep-alive-count",
+                           begin + strlen(",keep-alive-count="), INT_MAX,
+                           &addr->keep_alive_count, errp)) {
+            return -1;
+        }
+        addr->has_keep_alive_count = true;
+    }
+#endif
+#ifdef HAVE_TCP_KEEPIDLE
+    begin = strstr(optstr, ",keep-alive-idle=");
+    if (begin) {
+        if (inet_parse_u32("keep-alive-idle",
+                           begin + strlen(",keep-alive-idle="), INT_MAX,
+                           &addr->keep_alive_idle, errp)) {
+            return -1;
+        }
+        addr->has_keep_alive_idle = true;
+    }
+#endif
+#ifdef HAVE_TCP_KEEPINTVL
+    begin = strstr(optstr, ",keep-alive-interval=");
+    if (begin) {
+        if (inet_parse_u32("keep-alive-interval",
+                           begin + strlen(",keep-alive-interval="), INT_MAX,
+                           &addr->keep_alive_interval, errp)) {
+            return -1;
+        }
+        addr->has_keep_alive_interval = true;
+    }
+#endif
 #ifdef HAVE_IPPROTO_MPTCP
     begin = strstr(optstr, ",mptcp");
     if (begin) {
-- 
2.48.1


