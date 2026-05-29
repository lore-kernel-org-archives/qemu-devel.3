Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD128CD6E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 21:36:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT4rs-0004nc-S6; Fri, 29 May 2026 17:35:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wT4r2-0003cW-5L
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:35:01 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wT4qw-00032R-0z
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:34:51 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-8421f91c07eso227769b3a.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780090472; x=1780695272; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O/uEq0X68vqqCBKpIngN3jhiubOyQKw/LOIJ7bmC9HA=;
 b=sqDu+aG7hfLXqxEpYEFSakdadrAGevwWBvXw/s2ODGb+4qhhmaS1/3JO/HP+OYAKzj
 XZfv63RQcSsMx7wGQJgS6XmSkZ12MGsfIurDBcmkQPl0HJNDdRn0O6xkZY+oJ2/iRESs
 qxr6QumtA123wMsurcRcxTnf27SVn+jl3N5yhr7vgZzvXGIiD1/QCg4iVYKZdQg0Ha7D
 ooO/O7zUNmOv8f/Ap+Rp2S3BlH6SZEeBT787T+i4d50Vt4Y4y/qUN1xYX9jePYQ9+4La
 GNI7j3XjxpHkPCL+k0Viqr/T0A8Y+a7i/h/eJxto5r7IW+pBqnEBduc1CaZMZleTVJZe
 ti5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780090472; x=1780695272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=O/uEq0X68vqqCBKpIngN3jhiubOyQKw/LOIJ7bmC9HA=;
 b=O4Gul8Gu4nttVo1Tb0malrcHQbblKCDdzDqntkCi5qAqp5nNDUzQUZuynw68Qj3YCN
 84Doz7gK0QX4dGaWJYwz7C/Kr0sSDYKIvdBSuby2iHpZwVJMtq1wf+AAyceiiPUMacq9
 Fg1exyvSfebQNHHtqGi3fF/LY75qBHHyYHsVc/6LYbwNtXIDDfiukflFhs76h3CNP3gS
 KAPaHCL4UP2pJsNMpGIQriC/HDdbfio71ApfcqK19jpMNbvzt7iEldyxcK14X3SfRmZC
 3WqlNTlOmwV/dHCvAzE7mfyaQ6xpjddgXaF0jWY3fQomb7RjaRHoh9tmJzVpJW5Tzflr
 vYzQ==
X-Gm-Message-State: AOJu0Yy2r3JYgX74n0eEeDjQOWSINbG2Ybc20cLqH6GeMIxmeAn5byOT
 NI8JvVQX/a6NByuyHgxXdHq58JebjKDHBJZESQiKPSobIRdfWJer661f55rL9CfS2B4=
X-Gm-Gg: Acq92OF7MR/fVdRmtd90BNKZwJ8akWxZbExfTWXxs0Xvx6y4H9sww0d273FF4qN3heJ
 MrkF+BvyPAmSFyy43agNPbs2BRND8n5eIy6uMH8KVo+uyxpA6DfeisPZZvkYx2ZafZZ14l3bzqH
 tki2KBaNtf2OiT4zzA/Vl+7k34Wpab4Le3sMkB9cfdfsJR/IS5duK9rpjxy6hKq71XtX+i10rbr
 EZ5gh230N3Z7ELIu2KcxZyORxztBu2SzHY+HJjh2LlybIrPWfXgDKYBPoHtIeuxpZQ/S6O3Wcp1
 CoIeP5psNGVS+tpLUirTAPrkXH5usSUfhm80sdoH76iUBHjR+PU17eNS+mQAYfUCyRlYcks+KOi
 OSw+LdRlD26lAyXwU5VyM5p7CyRCFsA3QEwPnKTXX8NlxUumSRtzq+K9Hxon33wVYrZDG2w4z/6
 fEfEJ/njWP7CdnTQeGfCiOxqDOUCti7LSaOAuSs6XV65g7h63AcP1IHadPPSjnDOE=
X-Received: by 2002:a05:6a00:4f93:b0:83d:6c12:a632 with SMTP id
 d2e1a72fcca58-842257583d4mr1098649b3a.50.1780090471786; 
 Fri, 29 May 2026 14:34:31 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net ([104.168.88.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84214affe29sm2779564b3a.3.2026.05.29.14.34.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 29 May 2026 14:34:31 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V8 14/15] qapi: examine IOThread attachment status via
 query-iothreads
Date: Sat, 30 May 2026 05:33:20 +0800
Message-ID: <20260529213321.96271-15-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260529213321.96271-1-zhangckid@gmail.com>
References: <20260529213321.96271-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=zhangckid@gmail.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Extend the 'IOThreadInfo' structure to include attachment metrics.
This allows users to monitor the associated devices by identify them
by their QOM paths.

New fields added to IOThreadInfo:
 @holders: IOThreadHolder of the devices currently associated with
     this iothread.  Users can pre-allocate multiple iothread objects
     to serve as a persistent thread pool.  When a device is hot-unplugged,
     it is detached from its iothread, but the iothread remains available,
     allowing future hot-plugged devices to attach to it.  (Since 11.1)

These fields are also exposed via the Human Monitor Interface (HMP)
command 'info iothreads' to assist with manual debugging and
performance tuning.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 iothread.c         | 22 ++++++++++++++++++++++
 monitor/hmp-cmds.c | 26 ++++++++++++++++++++++++++
 qapi/misc.json     | 11 +++++++++++
 3 files changed, 59 insertions(+)

diff --git a/iothread.c b/iothread.c
index a85e960e45..5949785b32 100644
--- a/iothread.c
+++ b/iothread.c
@@ -24,6 +24,8 @@
 #include "qemu/error-report.h"
 #include "qemu/rcu.h"
 #include "qemu/main-loop.h"
+#include "qapi/clone-visitor.h"
+#include "qapi/qapi-visit-misc.h"
 
 /*
  * iothread_ref:
@@ -119,6 +121,25 @@ static void iothread_unref(IOThread *iothread, const IOThreadHolder *holder)
     object_unref(OBJECT(iothread));
 }
 
+static IOThreadHolderList *iothread_get_holders_list(IOThread *iothread)
+{
+    IOThreadHolderList *head = NULL;
+    IOThreadHolderList **prev = &head;
+    GList *l;
+
+    for (l = iothread->holders; l; l = l->next) {
+        IOThreadHolder *src = l->data;
+        IOThreadHolderList *entry = g_new0(IOThreadHolderList, 1);
+
+        entry->value = QAPI_CLONE(IOThreadHolder, src);
+
+        *prev = entry;
+        prev = &entry->next;
+    }
+
+    return head;
+}
+
 static void *iothread_run(void *opaque)
 {
     IOThread *iothread = opaque;
@@ -488,6 +509,7 @@ static int query_one_iothread(Object *object, void *opaque)
     info = g_new0(IOThreadInfo, 1);
     info->id = iothread_get_id(iothread);
     info->thread_id = iothread->thread_id;
+    info->holders = iothread_get_holders_list(iothread);
     info->poll_max_ns = iothread->poll_max_ns;
     info->poll_grow = iothread->poll_grow;
     info->poll_shrink = iothread->poll_shrink;
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 443b8c785d..1b5883147b 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -237,11 +237,37 @@ void hmp_info_iothreads(Monitor *mon, const QDict *qdict)
     IOThreadInfoList *info_list = qmp_query_iothreads(NULL);
     IOThreadInfoList *info;
     IOThreadInfo *value;
+    IOThreadHolderList *h;
 
     for (info = info_list; info; info = info->next) {
         value = info->value;
         monitor_printf(mon, "%s:\n", value->id);
         monitor_printf(mon, "  thread_id=%" PRId64 "\n", value->thread_id);
+        monitor_printf(mon, "  holders=");
+        if (value->holders) {
+            for (h = value->holders; h; h = h->next) {
+                IOThreadHolder *holder = h->value;
+
+                switch (holder->type) {
+                case IO_THREAD_HOLDER_KIND_BLOCK_NODE:
+                    monitor_printf(mon, "[block-node: %s]",
+                                   holder->u.block_node.node_name);
+                    break;
+                case IO_THREAD_HOLDER_KIND_QOM_OBJECT:
+                    monitor_printf(mon, "[qom-path: %s]",
+                                   holder->u.qom_object.qom_path);
+                    break;
+                case IO_THREAD_HOLDER_KIND_MONITOR_NAME:
+                    monitor_printf(mon, "[monitor-name: %s]",
+                                   holder->u.monitor_name.monitor_name);
+                    break;
+                default:
+                    monitor_printf(mon, "[unknown]");
+                    break;
+                }
+            }
+            monitor_printf(mon, "\n");
+        }
         monitor_printf(mon, "  poll-max-ns=%" PRId64 "\n", value->poll_max_ns);
         monitor_printf(mon, "  poll-grow=%" PRId64 "\n", value->poll_grow);
         monitor_printf(mon, "  poll-shrink=%" PRId64 "\n", value->poll_shrink);
diff --git a/qapi/misc.json b/qapi/misc.json
index d9f82f0922..4c16be3fd4 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -137,6 +137,13 @@
 #
 # @thread-id: ID of the underlying host thread
 #
+# @holders: IOThreadHolder of the devices currently associated with
+#     this iothread.  Users can pre-allocate multiple iothread objects
+#     to serve as a persistent thread pool.  When a device is
+#     hot-unplugged, it is detached from its iothread, but the
+#     iothread remains available, allowing future hot-plugged devices
+#     to attach to it.  (Since 11.1)
+#
 # @poll-max-ns: maximum polling time in ns, 0 means polling is
 #     disabled (since 2.9)
 #
@@ -159,6 +166,7 @@
 { 'struct': 'IOThreadInfo',
   'data': {'id': 'str',
            'thread-id': 'int',
+           'holders': ['IOThreadHolder'],
            'poll-max-ns': 'int',
            'poll-grow': 'int',
            'poll-shrink': 'int',
@@ -185,6 +193,8 @@
 #              {
 #                 "id":"iothread0",
 #                 "thread-id":3134,
+#                 "holders":[{"qom-path": "/machine/peripheral/blk1/virtio-backend", "type": "qom-object"},
+#                            {"qom-path": "/machine/peripheral/blk0/virtio-backend", "type": "qom-object"}],
 #                 "poll-max-ns":32768,
 #                 "poll-grow":0,
 #                 "poll-shrink":0,
@@ -193,6 +203,7 @@
 #              {
 #                 "id":"iothread1",
 #                 "thread-id":3135,
+#                 "holders":[{"qom-path": "/machine/peripheral/blk2/virtio-backend", "type": "qom-object"}],
 #                 "poll-max-ns":32768,
 #                 "poll-grow":0,
 #                 "poll-shrink":0,
-- 
2.49.0


