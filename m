Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B8F0C02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 16:36:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY6N0-0007VX-NR; Wed, 15 Jan 2025 11:35:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+fb641630334796bb9467+7815+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1tY6My-0007TP-Fv; Wed, 15 Jan 2025 11:35:52 -0500
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+fb641630334796bb9467+7815+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1tY6Mu-0001eA-OM; Wed, 15 Jan 2025 11:35:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
 To:From:Reply-To:Content-ID:Content-Description;
 bh=SDBjrinVc9mPM0Vf+Qh/Z25AxdVrPNHQdK2BMqfVAvY=; b=HSSPQup0WPxXmqL6G1JSX0Iytw
 Qg6gnJ5oiwf1F4ohSrXaK555HbOv4Q+jhfGx4nGwy6l3+9xlDjNgYBI7q6u9VsG9tdTQdpPfFEC67
 y/lglPtrF1E5x3TzUFrqD/ovG8dBbQGiJn1Gswlrd9HGMbzAXrxj9e1Y8Ft5JRaODxrKnYGODIs2s
 vL0OprNhQjzLYJ2HTQPpqO66PdeQjPxch8XXLVsky49x1fDl3HveLZb199nrUyls/69joB0nuhJ8+
 zweaKoqxodp0kOS06KvAfWVjKZPyoQCs8QThNHxBsL0qEu7Mh8XdNaGqkBMfR/bCTS3h/ef4jZ2RE
 tyy/w9dA==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
 id 1tY6Mq-0000000GF6I-0fLC; Wed, 15 Jan 2025 16:35:44 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat
 Linux)) id 1tY6Mp-00000001HhY-3icT; Wed, 15 Jan 2025 16:35:43 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 xen-devel@lists.xenproject.org, qemu-block@nongnu.org
Subject: [PATCH v3 2/7] xen: do not use '%ms' scanf specifier
Date: Wed, 15 Jan 2025 16:27:20 +0000
Message-ID: <20250115163542.291424-3-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250115163542.291424-1-dwmw2@infradead.org>
References: <20250115163542.291424-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1236::1;
 envelope-from=BATV+fb641630334796bb9467+7815+infradead.org+dwmw2@casper.srs.infradead.org;
 helo=casper.infradead.org
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

From: Roger Pau Monne <roger.pau@citrix.com>

The 'm' parameter used to request auto-allocation of the destination variable
is not supported on FreeBSD, and as such leads to failures to parse.

What's more, the current usage of '%ms' with xs_node_scanf() is pointless, as
it just leads to a double allocation of the same string.  Instead use
xs_node_read() to read the whole xenstore node.

Fixes: a783f8ad4ec9 ('xen: add a mechanism to automatically create XenDevice-s...')
Fixes: 9b7737469080 ('hw/xen: update Xen console to XenDevice model')
Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 hw/block/xen-block.c     |  3 ++-
 hw/char/xen_console.c    |  6 ++++--
 hw/xen/xen-bus.c         | 14 ++++++++++++--
 include/hw/xen/xen-bus.h |  1 +
 4 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index 306d38927c..034a18b70e 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -239,7 +239,8 @@ static void xen_block_connect(XenDevice *xendev, Error **errp)
         return;
     }
 
-    if (xen_device_frontend_scanf(xendev, "protocol", "%ms", &str) != 1) {
+    str = xen_device_frontend_read(xendev, "protocol");
+    if (!str) {
         /* x86 defaults to the 32-bit protocol even for 64-bit guests. */
         if (object_dynamic_cast(OBJECT(qdev_get_machine()), "x86-machine")) {
             protocol = BLKIF_PROTOCOL_X86_32;
diff --git a/hw/char/xen_console.c b/hw/char/xen_console.c
index ef0c2912ef..cb39b21504 100644
--- a/hw/char/xen_console.c
+++ b/hw/char/xen_console.c
@@ -550,7 +550,8 @@ static void xen_console_device_create(XenBackendInstance *backend,
         goto fail;
     }
 
-    if (xs_node_scanf(xsh, XBT_NULL, fe, "type", errp, "%ms", &type) != 1) {
+    type = xs_node_read(xsh, XBT_NULL, NULL, errp, "%s/%s", fe, "type");
+    if (!type) {
         error_prepend(errp, "failed to read console device type: ");
         goto fail;
     }
@@ -568,7 +569,8 @@ static void xen_console_device_create(XenBackendInstance *backend,
 
     snprintf(label, sizeof(label), "xencons%ld", number);
 
-    if (xs_node_scanf(xsh, XBT_NULL, fe, "output", NULL, "%ms", &output) == 1) {
+    output = xs_node_read(xsh, XBT_NULL, NULL, NULL, "%s/%s", fe, "output");
+    if (output) {
         /*
          * FIXME: sure we want to support implicit
          * muxed monitors here?
diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index adfc4efad0..85b92cded4 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -156,8 +156,8 @@ again:
             !strcmp(key[i], "hotplug-status"))
             continue;
 
-        if (xs_node_scanf(xenbus->xsh, tid, path, key[i], NULL, "%ms",
-                          &val) == 1) {
+        val = xs_node_read(xenbus->xsh, tid, NULL, NULL, "%s/%s", path, key[i]);
+        if (val) {
             qdict_put_str(opts, key[i], val);
             free(val);
         }
@@ -650,6 +650,16 @@ int xen_device_frontend_scanf(XenDevice *xendev, const char *key,
     return rc;
 }
 
+char *xen_device_frontend_read(XenDevice *xendev, const char *key)
+{
+    XenBus *xenbus = XEN_BUS(qdev_get_parent_bus(DEVICE(xendev)));
+
+    g_assert(xenbus->xsh);
+
+    return xs_node_read(xenbus->xsh, XBT_NULL, NULL, NULL, "%s/%s",
+                        xendev->frontend_path, key);;
+}
+
 static void xen_device_frontend_set_state(XenDevice *xendev,
                                           enum xenbus_state state,
                                           bool publish)
diff --git a/include/hw/xen/xen-bus.h b/include/hw/xen/xen-bus.h
index 38d40afa37..2adb2af839 100644
--- a/include/hw/xen/xen-bus.h
+++ b/include/hw/xen/xen-bus.h
@@ -91,6 +91,7 @@ void xen_device_frontend_printf(XenDevice *xendev, const char *key,
 int xen_device_frontend_scanf(XenDevice *xendev, const char *key,
                               const char *fmt, ...)
     G_GNUC_SCANF(3, 4);
+char *xen_device_frontend_read(XenDevice *xendev, const char *key);
 
 void xen_device_set_max_grant_refs(XenDevice *xendev, unsigned int nr_refs,
                                    Error **errp);
-- 
2.47.0


