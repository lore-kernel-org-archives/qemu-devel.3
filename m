Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5BDDEE0AE4
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Feb 2026 13:49:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voifZ-00038v-9O; Sat, 07 Feb 2026 08:48:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1voifK-00030Z-Bx
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 08:48:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1voifH-0003DH-Gs
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 08:48:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770472078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2fVgskyzccHmmwLOE9RNrMOJNpK9tOSvkgw1i8lrKc8=;
 b=YDvQbrNGvWWnNP83ceLST0PATVFaG7iDqPW6MroomCizufMRY9uUNeKB2G05dpztNWCYKz
 qn40bnJoBMfAgW4gZvTeriXyzYKpFG3Plga76wbqOqokCcF4qqljYrbn/aijzQKTca32JO
 IuIYVrGLQiODRYJWuWaNT1ZMjib164A=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-512-xkSe72syPeWh7WO8y79lEA-1; Sat,
 07 Feb 2026 08:47:54 -0500
X-MC-Unique: xkSe72syPeWh7WO8y79lEA-1
X-Mimecast-MFC-AGG-ID: xkSe72syPeWh7WO8y79lEA_1770472074
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BDEE419560A3; Sat,  7 Feb 2026 13:47:53 +0000 (UTC)
Received: from S2.redhat.com (unknown [10.72.112.15])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 80FA818004AD; Sat,  7 Feb 2026 13:47:50 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, zhangckid@gmail.com,
 lizhijian@fujitsu.com, qemu-devel@nongnu.org
Subject: [PATCH 03/12] net/filter: add statistics counters for netfilters
Date: Sat,  7 Feb 2026 21:47:19 +0800
Message-ID: <20260207134728.1495932-3-lulu@redhat.com>
In-Reply-To: <20260207134728.1495932-1-lulu@redhat.com>
References: <20260207134728.1495932-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
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

From: Jason Wang <jasowang@redhat.com>

Add packet and byte counters to NetFilterState to track traffic
passing through netfilters. The counters are updated in
qemu_netfilter_receive() for both TX and RX directions.

New QMP command 'query-netfilter-stats' and HMP command
'info netfilter-stats' are added to query the statistics.

The NetFilterStats structure includes:
- name: filter name
- netdev: attached netdev id
- type: filter type (e.g., filter-mirror)
- packets-tx/rx: packet counters
- bytes-tx/rx: byte counters

Example QMP usage:
  {"execute": "query-netfilter-stats"}

Example HMP usage:
  (qemu) info netfilter-stats

Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 hmp-commands-info.hx  | 13 +++++++++
 include/monitor/hmp.h |  1 +
 include/net/filter.h  |  6 +++++
 net/filter.c          | 16 ++++++++++-
 net/net-hmp-cmds.c    | 28 +++++++++++++++++++
 net/net.c             | 42 +++++++++++++++++++++++++++++
 qapi/net.json         | 63 +++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 168 insertions(+), 1 deletion(-)

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 41674dcbe1..d67df3f98a 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -44,6 +44,19 @@ SRST
     Show the network state.
 ERST
 
+    {
+        .name       = "netfilter-stats",
+        .args_type  = "",
+        .params     = "",
+        .help       = "show netfilter statistics",
+        .cmd        = hmp_info_netfilter_stats,
+    },
+
+SRST
+  ``info netfilter-stats``
+    Show netfilter statistics (packets and bytes counters).
+ERST
+
     {
         .name       = "chardev",
         .args_type  = "",
diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index 83721b5ffc..7150ca8514 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -56,6 +56,7 @@ void hmp_cont(Monitor *mon, const QDict *qdict);
 void hmp_system_wakeup(Monitor *mon, const QDict *qdict);
 void hmp_nmi(Monitor *mon, const QDict *qdict);
 void hmp_info_network(Monitor *mon, const QDict *qdict);
+void hmp_info_netfilter_stats(Monitor *mon, const QDict *qdict);
 void hmp_set_link(Monitor *mon, const QDict *qdict);
 void hmp_balloon(Monitor *mon, const QDict *qdict);
 void hmp_loadvm(Monitor *mon, const QDict *qdict);
diff --git a/include/net/filter.h b/include/net/filter.h
index f15f7932b2..04786e4e87 100644
--- a/include/net/filter.h
+++ b/include/net/filter.h
@@ -60,6 +60,12 @@ struct NetFilterState {
     char *position;
     bool insert_before_flag;
     QTAILQ_ENTRY(NetFilterState) next;
+
+    /* statistics */
+    uint64_t bytes_tx;
+    uint64_t bytes_rx;
+    uint64_t packets_tx;
+    uint64_t packets_rx;
 };
 
 ssize_t qemu_netfilter_receive(NetFilterState *nf,
diff --git a/net/filter.c b/net/filter.c
index c7cc6615dc..76345c1a9d 100644
--- a/net/filter.c
+++ b/net/filter.c
@@ -33,13 +33,27 @@ ssize_t qemu_netfilter_receive(NetFilterState *nf,
                                int iovcnt,
                                NetPacketSent *sent_cb)
 {
+    ssize_t ret;
+    size_t size;
+
     if (qemu_can_skip_netfilter(nf)) {
         return 0;
     }
     if (nf->direction == direction ||
         nf->direction == NET_FILTER_DIRECTION_ALL) {
-        return NETFILTER_GET_CLASS(OBJECT(nf))->receive_iov(
+        /* Update statistics */
+        size = iov_size(iov, iovcnt);
+        if (direction == NET_FILTER_DIRECTION_TX) {
+            nf->packets_tx++;
+            nf->bytes_tx += size;
+        } else {
+            nf->packets_rx++;
+            nf->bytes_rx += size;
+        }
+
+        ret = NETFILTER_GET_CLASS(OBJECT(nf))->receive_iov(
                                    nf, sender, flags, iov, iovcnt, sent_cb);
+        return ret;
     }
 
     return 0;
diff --git a/net/net-hmp-cmds.c b/net/net-hmp-cmds.c
index e7c55d2787..9bdd6d233f 100644
--- a/net/net-hmp-cmds.c
+++ b/net/net-hmp-cmds.c
@@ -168,3 +168,31 @@ void netdev_del_completion(ReadLineState *rs, int nb_args, const char *str)
         }
     }
 }
+
+void hmp_info_netfilter_stats(Monitor *mon, const QDict *qdict)
+{
+    NetFilterStatsList *stats_list, *entry;
+    Error *err = NULL;
+
+    stats_list = qmp_query_netfilter_stats(NULL, &err);
+    if (hmp_handle_error(mon, err)) {
+        return;
+    }
+
+    if (!stats_list) {
+        monitor_printf(mon, "No netfilters found\n");
+        return;
+    }
+
+    for (entry = stats_list; entry; entry = entry->next) {
+        NetFilterStats *stats = entry->value;
+        monitor_printf(mon, "%s: netdev=%s type=%s\n",
+                       stats->name, stats->netdev, stats->type);
+        monitor_printf(mon, "  tx: %" PRIu64 " packets, %" PRIu64 " bytes\n",
+                       stats->packets_tx, stats->bytes_tx);
+        monitor_printf(mon, "  rx: %" PRIu64 " packets, %" PRIu64 " bytes\n",
+                       stats->packets_rx, stats->bytes_rx);
+    }
+
+    qapi_free_NetFilterStatsList(stats_list);
+}
diff --git a/net/net.c b/net/net.c
index 27e0d27807..40966fbf8a 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1604,6 +1604,48 @@ RxFilterInfoList *qmp_query_rx_filter(const char *name, Error **errp)
     return filter_list;
 }
 
+NetFilterStatsList *qmp_query_netfilter_stats(const char *name, Error **errp)
+{
+    NetClientState *nc;
+    NetFilterState *nf;
+    NetFilterStatsList *stats_list = NULL, **tail = &stats_list;
+    bool found = false;
+
+    QTAILQ_FOREACH(nc, &net_clients, next) {
+        QTAILQ_FOREACH(nf, &nc->filters, next) {
+            NetFilterStats *stats;
+            const char *filter_name;
+
+            filter_name = object_get_canonical_path_component(OBJECT(nf));
+            if (name && strcmp(filter_name, name) != 0) {
+                continue;
+            }
+
+            found = true;
+            stats = g_new0(NetFilterStats, 1);
+            stats->name = g_strdup(filter_name);
+            stats->netdev = g_strdup(nf->netdev_id);
+            stats->type = g_strdup(object_get_typename(OBJECT(nf)));
+            stats->packets_tx = nf->packets_tx;
+            stats->packets_rx = nf->packets_rx;
+            stats->bytes_tx = nf->bytes_tx;
+            stats->bytes_rx = nf->bytes_rx;
+
+            QAPI_LIST_APPEND(tail, stats);
+
+            if (name) {
+                return stats_list;
+            }
+        }
+    }
+
+    if (name && !found) {
+        error_setg(errp, "netfilter '%s' not found", name);
+    }
+
+    return stats_list;
+}
+
 void colo_notify_filters_event(int event, Error **errp)
 {
     NetClientState *nc;
diff --git a/qapi/net.json b/qapi/net.json
index 118bd34965..277cdd9e32 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -1191,3 +1191,66 @@
 ##
 { 'event': 'NETDEV_VHOST_USER_DISCONNECTED',
   'data': { 'netdev-id': 'str' } }
+
+##
+# @NetFilterStats:
+#
+# Statistics for a network filter.
+#
+# @name: the name of the network filter
+#
+# @netdev: the netdev id attached to
+#
+# @type: the filter type
+#
+# @packets-tx: number of transmitted packets
+#
+# @packets-rx: number of received packets
+#
+# @bytes-tx: number of transmitted bytes
+#
+# @bytes-rx: number of received bytes
+#
+# Since: 10.1
+##
+{ 'struct': 'NetFilterStats',
+  'data': {
+    'name':       'str',
+    'netdev':     'str',
+    'type':       'str',
+    'packets-tx': 'uint64',
+    'packets-rx': 'uint64',
+    'bytes-tx':   'uint64',
+    'bytes-rx':   'uint64' } }
+
+##
+# @query-netfilter-stats:
+#
+# Return statistics for network filters.
+#
+# @name: Optional filter name to query.  If not specified, returns
+#     stats for all filters.
+#
+# Returns: A list of @NetFilterStats for each filter.
+#
+# Since: 10.1
+#
+# .. qmp-example::
+#
+#     -> { "execute": "query-netfilter-stats" }
+#     <- { "return": [
+#             {
+#                 "name": "f0",
+#                 "netdev": "net0",
+#                 "type": "filter-mirror",
+#                 "packets-tx": 12345,
+#                 "packets-rx": 0,
+#                 "bytes-tx": 1234567,
+#                 "bytes-rx": 0
+#             }
+#           ]
+#        }
+##
+{ 'command': 'query-netfilter-stats',
+  'data': { '*name': 'str' },
+  'returns': ['NetFilterStats'] }
-- 
2.52.0


