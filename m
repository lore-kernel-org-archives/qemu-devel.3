Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5500C02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 08:44:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYLTo-0006q2-Hf; Thu, 16 Jan 2025 03:43:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+cabf69696ff47aa9dee2+7816+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1tYLTl-0006oS-Ay; Thu, 16 Jan 2025 03:43:53 -0500
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+cabf69696ff47aa9dee2+7816+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1tYLTg-0006no-OU; Thu, 16 Jan 2025 03:43:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=rf4XQLZvATxaJ4ZS360lOa75wV7gwRBU9Wx/NrfpNKM=; b=sFlr5bcNd4N4BJ5gR3Jk2RMuSZ
 5ueFpFbkgmzLDSSjXJ4F7E+VBxywP+JIRlQoRKp3wkAY8M1RXh+2AgFkdaR0I+RJ/HbnrYMA+Z0zU
 2lmxNsy2Qy/lJdQ9rSRQOyDus7jTuvUOxbVmPxnvd+PQKO1ZzaiVWnoNH0DVgLxdULgr2CX7e6mvu
 QrD2RyTvgL5O6bdVak0nEQCYiMG6AHb8ODInb95f1z/eiaN9PgRwMoW9LxHdxLVJTzHvEJkOKa99m
 RL0y+rCcqZpKVNodam5HJp2Ry+5gdt3tdeSL9bekAURJVRyjXefSwKZWd44xr0u1/xBMze+9o1USG
 +58fvVNg==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
 id 1tYLTd-0000000AkbX-0VhX; Thu, 16 Jan 2025 08:43:45 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat
 Linux)) id 1tYLTc-00000007pIG-3SiW; Thu, 16 Jan 2025 08:43:44 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 xen-devel@lists.xenproject.org, qemu-block@nongnu.org,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 David Woodhouse <dwmw@amazon.co.uk>,
 Anthony PERARD <anthony.perard@vates.tech>
Subject: [PULL 7/8] hw/xen: Fix errp handling in xen_console
Date: Thu, 16 Jan 2025 08:43:31 +0000
Message-ID: <20250116084332.1864967-8-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250116084332.1864967-1-dwmw2@infradead.org>
References: <20250116084332.1864967-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1236::1;
 envelope-from=BATV+cabf69696ff47aa9dee2+7816+infradead.org+dwmw2@casper.srs.infradead.org;
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

From: David Woodhouse <dwmw@amazon.co.uk>

When attempting to read the 'output' node, interpret any error *other*
than ENOENT as a fatal error. For ENOENT, fall back to serial_hd() to
find a character device, or create a null device.

Do not attempt to prepend to errp when serial_hd() fails; the error
isn't relevant (and prior to this change, wasn't set anyway).

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Anthony PERARD <anthony.perard@vates.tech>
---
 hw/char/xen_console.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/hw/char/xen_console.c b/hw/char/xen_console.c
index e61902461b..d03c188d1d 100644
--- a/hw/char/xen_console.c
+++ b/hw/char/xen_console.c
@@ -569,7 +569,7 @@ static void xen_console_device_create(XenBackendInstance *backend,
 
     snprintf(label, sizeof(label), "xencons%ld", number);
 
-    output = xs_node_read(xsh, XBT_NULL, NULL, NULL, "%s/%s", fe, "output");
+    output = xs_node_read(xsh, XBT_NULL, NULL, errp, "%s/%s", fe, "output");
     if (output) {
         /*
          * FIXME: sure we want to support implicit
@@ -581,19 +581,27 @@ static void xen_console_device_create(XenBackendInstance *backend,
                        output);
             goto fail;
         }
-    } else if (number) {
-        cd = serial_hd(number);
-        if (!cd) {
-            error_prepend(errp, "console: No serial device #%ld found: ",
-                          number);
-            goto fail;
-        }
+    } else if (errno != ENOENT) {
+        error_prepend(errp, "console: No valid chardev found: ");
+        goto fail;
     } else {
-        /* No 'output' node on primary console: use null. */
-        cd = qemu_chr_new(label, "null", NULL);
-        if (!cd) {
-            error_setg(errp, "console: failed to create null device");
-            goto fail;
+        error_free(*errp);
+        *errp = NULL;
+
+        if (number) {
+            cd = serial_hd(number);
+            if (!cd) {
+                error_setg(errp, "console: No serial device #%ld found",
+                           number);
+                goto fail;
+            }
+        } else {
+            /* No 'output' node on primary console: use null. */
+            cd = qemu_chr_new(label, "null", NULL);
+            if (!cd) {
+                error_setg(errp, "console: failed to create null device");
+                goto fail;
+            }
         }
     }
 
-- 
2.47.0


