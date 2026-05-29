Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E23ACD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 21:34:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT4q9-0003If-2J; Fri, 29 May 2026 17:34:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wT4q7-0003I1-7U
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:33:59 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wT4q5-0002nU-8c
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:33:58 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-82f8893bff3so6707726b3a.2
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780090436; x=1780695236; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H9zFq1iyzk05zoEMX2h9nWXYnORUY596qmXYMUCTaFo=;
 b=dqbeGDnm8aK6dWoVJYx63hKVfl6Oyf+VrKOX+JERDgvSNRe7ILxYrFQiLr8HRVootB
 F7N2oY3msd+7cANZbmsJ1q+kJSCBZs83xoDZ8+gqiHsTN2V7/wQtF5vomAG0FPNAZNlq
 K/ej1rPciat1ULC7fCVRtDpbRCq9kW90GVPVBCeEsrosP45Q6J6CLZmr24z/W/DriV0L
 ngn9atEYYwn4VM42Me3cE1IbO47hfBhKNVpc2ctsnSSOLpeVR6gPPmltWV2r3iDdUbVP
 gjbTUyd6HSU08IQ3vtq52PiuCHbjOmLzkxsweVYGT4pahewpU3o2s4m7wI92fIISCmxZ
 EeWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780090436; x=1780695236;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=H9zFq1iyzk05zoEMX2h9nWXYnORUY596qmXYMUCTaFo=;
 b=o5XSXPy8VjX7hVi7rFww/6qVenLYlZly3orZjZLK1+a2gb8VAzW0inf0/SEwo9wd3k
 Jl5c29/Qu1VGftyln9PlvIVVH73NRtWoh6h10XZzi6qtrejJuzuXTyCAAfzyApNH7h3F
 o8SsvhgTVDMBmHY9s7tCdWzSY0ixHiV5DH6KGc4Q1dPGQkrLx1Jy/bxkgqROaPuFnnfg
 p1YlturOlsHdWkDy9gm2E4a78nHSvak0uzvlI1AZ2Ao0Z+pVYXiiz9uXy+fh+hLs7yot
 /iobgmAJPP8jZyAlsXDZKTcBdr8HAJwTRTbzxZQrg1IWInY6O6VU/n4wnhDzAVZGIpZY
 uUSg==
X-Gm-Message-State: AOJu0YwvqohgrNSUtmJlBcgjyyIOc5QSGZMSrn73ZOUG4W1yn33FVFA6
 B+sVEf2dc/XiSwCOZWWWVjlW9WBBK9RFWNoaHOzHPHziU2mF0JTzcMRRVx6IRJWOp4g=
X-Gm-Gg: Acq92OFaJm4yQKSQ1Oj9Z/u8dA+s3msT2q37xj4/BvVYZiBQa2GG28MXitcefxL1Qga
 T+d5k6Ry2IkbMsoNq/ImA62ER5semb4aqY3mmSviJzfOF2eMbvsjQJvVZH02VPwF/4W/C09jxuz
 hN1kgaQEb+hhNsr+xv70w+mj0oR9C+rq2DR8RKn97raHKKjjdt8UKIQOkqGA5FFcYTWRa3i/mTJ
 yH9i9BlZqKzuvO0gTLjSjMx4a3BSeumhSICx/9iscm2s987Aaor2K6fcRdyw/ITCMEi5fabpHJc
 cX3hYltWBx1tbYSVR0hy/IeoayoNZf2vDSzOAp1jamWprBWEsh+Opk0xC/tlIatwMW7FPV6PRTg
 4Aic0CXOCGMkw+2igtd01zUEF97vUS0xCE9qOLBciJoC51AnBPsr/n57Cq1esVBmtAB/eviPo5N
 zz42CVgEPPDsJDNOTNjnEv0/2Kp/Wbhs5XkLnw+hITZFp6/Ko9/Y7qFkr8PftfmTPifL9Bs1dub
 Q==
X-Received: by 2002:a05:6a00:b8f:b0:838:a932:de26 with SMTP id
 d2e1a72fcca58-8422538611fmr1121728b3a.1.1780090435682; 
 Fri, 29 May 2026 14:33:55 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net ([104.168.88.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84214affe29sm2779564b3a.3.2026.05.29.14.33.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 29 May 2026 14:33:55 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V8 02/15] iothread: introduce iothread_ref/unref to track
 attached devices
Date: Sat, 30 May 2026 05:33:08 +0800
Message-ID: <20260529213321.96271-3-zhangckid@gmail.com>
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

Currently, IOThreads do not maintain a record of which devices are
associated with them. This makes it difficult to monitor the
workload distribution of IOThreads, especially in complex
hotplug scenarios involving multiple virtio-blk or virtio-scsi devices.

This patch introduces a reference counting and tracking mechanism
within the IOThread object:

- iothread_ref(): Prepends the device's IOThreadHolder to a list.
- iothread_unref(): Searches for the IOThreadHolder using a custom
  string comparison (g_strcmp0), releases the associated memory
  upon a successful match.
- holders: A GList storing the IOThreadHolder of attached devices
  for runtime introspection.

A later commit will add QMP commands to let management applications
query the attachment status of IOThreads.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 include/system/iothread.h |  5 +++
 iothread.c                | 94 +++++++++++++++++++++++++++++++++++++++
 qapi/misc.json            | 61 +++++++++++++++++++++++++
 3 files changed, 160 insertions(+)

diff --git a/include/system/iothread.h b/include/system/iothread.h
index a1ef7696cb..b9207ad829 100644
--- a/include/system/iothread.h
+++ b/include/system/iothread.h
@@ -50,6 +50,11 @@ struct IOThread {
     bool stopping;              /* has iothread_stop() been called? */
     bool running;               /* should iothread_run() continue? */
     int thread_id;
+    /*
+     * The list elements are of type IOThreadHolder, which can
+     * represent either a QOM path or a block node name.
+     */
+    GList *holders;
 
     /* AioContext poll parameters */
     int64_t poll_max_ns;
diff --git a/iothread.c b/iothread.c
index 3558535b40..3301b8d495 100644
--- a/iothread.c
+++ b/iothread.c
@@ -25,6 +25,92 @@
 #include "qemu/rcu.h"
 #include "qemu/main-loop.h"
 
+/*
+ * iothread_ref:
+ * @iothread: the iothread to track
+ * @holder: the IOThreadHolder object initialized by the caller
+ *
+ * Add the @holder to the iothread's tracking list.
+ */
+static void iothread_ref(IOThread *iothread, const IOThreadHolder *holder)
+{
+    assert(holder);
+    IOThreadHolder *h = g_new0(IOThreadHolder, 1);
+
+    h->type = holder->type;
+    switch (holder->type) {
+    case IO_THREAD_HOLDER_KIND_QOM_OBJECT:
+        h->u.qom_object.qom_path = g_strdup(holder->u.qom_object.qom_path);
+        break;
+    case IO_THREAD_HOLDER_KIND_BLOCK_NODE:
+        h->u.block_node.node_name =
+            g_strdup(holder->u.block_node.node_name);
+        break;
+    case IO_THREAD_HOLDER_KIND_MONITOR_NAME:
+        h->u.monitor_name.monitor_name =
+            g_strdup(holder->u.monitor_name.monitor_name);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    iothread->holders = g_list_prepend(iothread->holders, h);
+}
+
+static int iothread_holder_compare(gconstpointer a, gconstpointer b)
+{
+    const IOThreadHolder *holder_a = a;
+    const IOThreadHolder *holder_b = b;
+    const char *name_a, *name_b;
+
+    if (holder_a->type != holder_b->type) {
+        return -1;
+    }
+
+    switch (holder_a->type) {
+    case IO_THREAD_HOLDER_KIND_QOM_OBJECT:
+        name_a = holder_a->u.qom_object.qom_path;
+        name_b = holder_b->u.qom_object.qom_path;
+        break;
+    case IO_THREAD_HOLDER_KIND_BLOCK_NODE:
+        name_a = holder_a->u.block_node.node_name;
+        name_b = holder_b->u.block_node.node_name;
+        break;
+    case IO_THREAD_HOLDER_KIND_MONITOR_NAME:
+        name_a = holder_a->u.monitor_name.monitor_name;
+        name_b = holder_b->u.monitor_name.monitor_name;
+        break;
+    default:
+       /*
+        * This should not happen. If it does, name_a/b remains
+        * NULL and g_strcmp0 will handle it safely.
+        */
+        name_a = NULL;
+        name_b = NULL;
+    }
+
+    return g_strcmp0(name_a, name_b);
+}
+
+/*
+ * This function removes the @holder from the @iothread's tracking list.
+ * The @holder must match the one used previously in iothread_ref().
+ * It is a programming error to call this with a @holder that is not
+ * currently associated with the @iothread.
+ */
+static void iothread_unref(IOThread *iothread, const IOThreadHolder *holder)
+{
+    assert(holder);
+    GList *link = g_list_find_custom(iothread->holders, holder,
+                                     (GCompareFunc)iothread_holder_compare);
+
+    assert(link);
+
+    IOThreadHolder *h = (IOThreadHolder *)link->data;
+    qapi_free_IOThreadHolder(h);
+    iothread->holders = g_list_delete_link(iothread->holders, link);
+}
+
 static void *iothread_run(void *opaque)
 {
     IOThread *iothread = opaque;
@@ -356,6 +442,14 @@ char *iothread_get_id(IOThread *iothread)
 
 AioContext *iothread_get_aio_context(IOThread *iothread)
 {
+    /* Remove in next patch for build */
+    IOThreadHolder holder = {
+        .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+        .u.qom_object.qom_path = (char *)"tmp_path",
+    };
+    iothread_ref(iothread, &holder);
+    iothread_unref(iothread, &holder);
+
     return iothread->ctx;
 }
 
diff --git a/qapi/misc.json b/qapi/misc.json
index c71a5fe657..d9f82f0922 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -67,6 +67,67 @@
 ##
 { 'command': 'query-name', 'returns': 'NameInfo', 'allow-preconfig': true }
 
+
+##
+# @IOThreadHolderBlockNode:
+#
+# @node-name: A block node.
+#
+# Since: 11.1
+#
+##
+{ 'struct': 'IOThreadHolderBlockNode',
+  'data': { 'node-name': 'str' } }
+
+##
+# @IOThreadHolderQomObject:
+#
+# @qom-path: A QOM Object.
+#
+# Since: 11.1
+#
+##
+{ 'struct': 'IOThreadHolderQomObject',
+  'data': { 'qom-path': 'str' } }
+
+##
+# @IOThreadHolderMonitor:
+#
+# @monitor-name: A HMP/QMP monitor.
+#
+# Since: 11.1
+#
+##
+{ 'struct': 'IOThreadHolderMonitor',
+  'data': { 'monitor-name': 'str' } }
+
+##
+# @IOThreadHolderKind:
+#
+# @block-node: A block node.
+# @qom-object: A QOM Object.
+# @monitor-name: A HMP/QMP monitor.
+#
+# Since: 11.1
+##
+{ 'enum': 'IOThreadHolderKind',
+  'data': [ 'block-node', 'qom-object', 'monitor-name' ] }
+
+##
+# @IOThreadHolder:
+#
+# @type: the kind of I/O thread holder.
+#
+# Since: 11.1
+##
+{ 'union': 'IOThreadHolder',
+  'base': { 'type': 'IOThreadHolderKind' },
+  'discriminator': 'type',
+  'data': {
+    'block-node': 'IOThreadHolderBlockNode',
+    'qom-object': 'IOThreadHolderQomObject',
+    'monitor-name': 'IOThreadHolderMonitor' } }
+
 ##
 # @IOThreadInfo:
 #
-- 
2.49.0


