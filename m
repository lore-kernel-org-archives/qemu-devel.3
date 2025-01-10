Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9EACE7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 10:03:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWBrY-0008Mx-IL; Fri, 10 Jan 2025 05:03:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+4f8727a5892a49e75626+7810+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1tWBrV-0008M1-VX; Fri, 10 Jan 2025 05:03:29 -0500
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+4f8727a5892a49e75626+7810+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1tWBrU-0003qy-IN; Fri, 10 Jan 2025 05:03:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=/Z+SKExdFg0yRN3g9ep614CHpa/f9VObKzKbkTp0cz4=; b=JixCnxZX+BaMP2NnJM4sbWF8Bo
 ko/UtMZH9wEpewOEOAw7KfknY98ai903BwaCCcOqoR8SiiUmnsygfCGudsLwaoIuOkvDEP6EP/uo9
 09UM6cCA8SpZK9lT8UsvrNPznYNvzqxz+5mRNpZBMhZzDlqamHM4RICQw5ph9GMalXXMMiulOKAi3
 TNIn2h+K2IUejRuuPLFpngzlF5ANtKAn+vJFknwv7UGsyuxTlT+l/OCTjIBH8/eQUPStFCRC7sc1N
 6M0qsPg6HGol0YG65WxcP+e8Gf5Ys1URR3xVczhle/Yhfar+gOYUa2zmeIni61g4XH2y1FAysu/U7
 PCVY3vdg==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
 id 1tWBrT-0000000ClKG-0bv4; Fri, 10 Jan 2025 10:03:27 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat
 Linux)) id 1tWBrS-00000002D8B-3mfx; Fri, 10 Jan 2025 10:03:26 +0000
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
Subject: [PATCH 3/4] hw/xen: Use xs_node_read() from xen_netdev_get_name()
Date: Fri, 10 Jan 2025 10:03:25 +0000
Message-ID: <20250110100326.527101-3-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250110100326.527101-1-dwmw2@infradead.org>
References: <fc9b22c55eaaa79a3ef9829c270bc4b4e93be7a0.camel@infradead.org>
 <20250110100326.527101-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1236::1;
 envelope-from=BATV+4f8727a5892a49e75626+7810+infradead.org+dwmw2@casper.srs.infradead.org;
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

Now that xs_node_read() can construct a node path, no need to open-code it.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 hw/net/xen_nic.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/hw/net/xen_nic.c b/hw/net/xen_nic.c
index 97ebd9fa30..5410039490 100644
--- a/hw/net/xen_nic.c
+++ b/hw/net/xen_nic.c
@@ -510,23 +510,22 @@ static char *xen_netdev_get_name(XenDevice *xendev, Error **errp)
 
     if (netdev->dev == -1) {
         XenBus *xenbus = XEN_BUS(qdev_get_parent_bus(DEVICE(xendev)));
-        char fe_path[XENSTORE_ABS_PATH_MAX + 1];
         int idx = (xen_mode == XEN_EMULATE) ? 0 : 1;
+        Error *local_err = NULL;
         char *value;
 
         /* Theoretically we could go up to INT_MAX here but that's overkill */
         while (idx < 100) {
-            snprintf(fe_path, sizeof(fe_path),
-                     "/local/domain/%u/device/vif/%u",
-                     xendev->frontend_id, idx);
-            value = qemu_xen_xs_read(xenbus->xsh, XBT_NULL, fe_path, NULL);
+            value = xs_node_read(xenbus->xsh, XBT_NULL, NULL, &local_err,
+                                 "/local/domain/%u/device/vif/%u",
+                                 xendev->frontend_id, idx);
             if (!value) {
                 if (errno == ENOENT) {
                     netdev->dev = idx;
+                    error_free(local_err);
                     goto found;
                 }
-                error_setg(errp, "cannot read %s: %s", fe_path,
-                           strerror(errno));
+                error_propagate(errp, local_err);
                 return NULL;
             }
             free(value);
-- 
2.47.0


