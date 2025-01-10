Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 256F5E7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 10:04:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWBrj-0000Xe-WC; Fri, 10 Jan 2025 05:03:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+4d36ee5d223a5d86d66e+7810+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1tWBrc-0000Ch-6W; Fri, 10 Jan 2025 05:03:36 -0500
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+4d36ee5d223a5d86d66e+7810+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1tWBra-0003rJ-8e; Fri, 10 Jan 2025 05:03:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=KN/vJ32gBbSAX8GZerq/muMhqjU/qftUYdnqn8Z6Yn0=; b=KK+jmkp9uMAfKbBP17zM/QXfAh
 bODMZmPFLFjv6iKOGFosxjVZNvA4lDeColIFClm+nfxYwYJW6jVo1f3vmK4LVD7Vor2WN9ft6yGFS
 H2acwxNQyNkIZhsc7Y1E+Hcd9aZwaBdiqhpPBpzDKA1sRCum8YuvWK2y29C9v9rhaZV+YhgASmgeI
 AsIL+GYs2g/ggXEQnvCimZXqJHfpVIl7Nisvr5J9uHQHHqVuFihdNqCAVCMjw6nQH2pEPq34V93Cj
 PWWaLex2e/v0iNzRQ13NYiMI48qra5xCsCSn29zS5BIA85x0/PVhZkrGhqpTHYN5/HCuzfG42YILW
 1j8WK14Q==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
 id 1tWBrT-00000009jwj-47G9; Fri, 10 Jan 2025 10:03:28 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat
 Linux)) id 1tWBrS-00000002D80-3VgZ; Fri, 10 Jan 2025 10:03:26 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: Roger Pau Monne <roger.pau@citrix.com>,
	qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org,
 qemu-block@nongnu.org
Subject: [PATCH 1/4] hw/xen: Use xs_node_read() from xs_node_vscanf()
Date: Fri, 10 Jan 2025 10:03:23 +0000
Message-ID: <20250110100326.527101-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <fc9b22c55eaaa79a3ef9829c270bc4b4e93be7a0.camel@infradead.org>
References: <fc9b22c55eaaa79a3ef9829c270bc4b4e93be7a0.camel@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 desiato.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05;
 envelope-from=BATV+4d36ee5d223a5d86d66e+7810+infradead.org+dwmw2@desiato.srs.infradead.org;
 helo=desiato.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: David Woodhouse <dwmw@amazon.co.uk>

Reduce some duplication.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 hw/xen/trace-events     |  1 -
 hw/xen/xen-bus-helper.c | 15 ++++++---------
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/hw/xen/trace-events b/hw/xen/trace-events
index 461dee7b23..b67942d07b 100644
--- a/hw/xen/trace-events
+++ b/hw/xen/trace-events
@@ -38,7 +38,6 @@ xen_device_remove_watch(const char *type, char *name, const char *node, const ch
 xs_node_create(const char *node) "%s"
 xs_node_destroy(const char *node) "%s"
 xs_node_vprintf(char *path, char *value) "%s %s"
-xs_node_vscanf(char *path, char *value) "%s %s"
 xs_node_read(const char *path, const char *value) "%s %s"
 xs_node_watch(char *path) "%s"
 xs_node_unwatch(char *path) "%s"
diff --git a/hw/xen/xen-bus-helper.c b/hw/xen/xen-bus-helper.c
index 0fba7946c5..57697799f3 100644
--- a/hw/xen/xen-bus-helper.c
+++ b/hw/xen/xen-bus-helper.c
@@ -105,25 +105,22 @@ int xs_node_vscanf(struct qemu_xs_handle *h,  xs_transaction_t tid,
                    const char *node, const char *key, Error **errp,
                    const char *fmt, va_list ap)
 {
-    char *path, *value;
+    char *value;
     int rc;
 
-    path = (strlen(node) != 0) ? g_strdup_printf("%s/%s", node, key) :
-        g_strdup(key);
-    value = qemu_xen_xs_read(h, tid, path, NULL);
-
-    trace_xs_node_vscanf(path, value);
+    if (node && strlen(node) != 0) {
+        value = xs_node_read(h, tid, NULL, errp, "%s/%s", node, key);
+    } else {
+        value = xs_node_read(h, tid, NULL, errp, "%s", key);
+    }
 
     if (value) {
         rc = vsscanf(value, fmt, ap);
     } else {
-        error_setg_errno(errp, errno, "failed to read from '%s'",
-                         path);
         rc = EOF;
     }
 
     free(value);
-    g_free(path);
 
     return rc;
 }
-- 
2.47.0


