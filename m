Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA81C43458
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2026 04:26:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wilcr-0002TO-SN; Sun, 12 Jul 2026 00:17:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wilcZ-0001lg-Or; Sun, 12 Jul 2026 00:16:55 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wilcX-0006Hc-JO; Sun, 12 Jul 2026 00:16:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783829780; bh=0LzW0jaYKGDQ4dkWaUYbNxBbsZkh2/L8H26i3L4a8Rc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=kDK0v/7dIFie0LCVUKzgAHk4b61Yt7n0ared8qCKXU4Xc0gZF/xeb3GMW8DBtE8Pl
 WUaOXEEfhN44QWYk4mL/yyMNFGDOzDBiSjoAs4+z9hYPeGz9Ajjk366Y/HL3zj0EKM
 l9vI6tg+yW0MuDAJHviMKUXtYUA33FVWqNPoTbq8ax/m/jRKPbbUWFXFC17j2gxnQF
 EfiWrD8n7fk6/8sIo3Ksp1DrDsITgdN3LGDfHOfFw1oRfftG0QGaXd3V7H3/YE9ULM
 w1UvPqdOnaQmgeOrvhEI1r++knqidGVwCNeG74Akzb2CNn0RzAGLoYi+6CIdnX7pOt
 RwKdjGUBPSEPA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DB2AF1C0BE6;
 Sun, 12 Jul 2026 07:16:20 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 190483EB946;
 Sun, 12 Jul 2026 07:16:31 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 2EA1B133CF; Sun, 12 Jul 2026 07:16:31 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.12 11/75] 9pfs/xen: implement response_buffer_size
 callback
Date: Sun, 12 Jul 2026 07:14:29 +0300
Message-ID: <20260712041539.108341-11-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.12-20260712071526@cover.tls.msk.ru>
References: <qemu-stable-10.0.12-20260712071526@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Christian Schoenebeck <qemu_oss@crudebyte.com>

Add and implement the response_buffer_size callback for the Xen
transport.

Returns the size of the response buffer from the rings in_sg, as limit
for 9p server while generating a response for supplied PDU.

We use a local iovec array variable in_sg[2] instead of ring->sg, as
ring->sg is only allocated by init_in_iov_from_pdu() and
init_out_iov_from_pdu() during request / response processing.
response_buffer_size() however may be called before those allocators,
which would dereference ring->sg as NULL pointer. The local array
avoids this.

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
Link: https://lore.kernel.org/qemu-devel/3b139769eb1d3f9d91ee5281228e6467f9a08b99.1781287774.git.qemu_oss@crudebyte.com
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
(cherry picked from commit 69c8f5e6946f76a70b141a340c7aeb9d6a8e3c27)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
index f168c6ef0ee..029a623bf76 100644
--- a/hw/9pfs/xen-9p-backend.c
+++ b/hw/9pfs/xen-9p-backend.c
@@ -268,6 +268,17 @@ static size_t xen_9p_msize_limit(V9fsState *s)
     return limit;
 }
 
+static size_t xen_9pfs_response_buffer_size(V9fsPDU *pdu)
+{
+    Xen9pfsDev *priv = container_of(pdu->s, Xen9pfsDev, state);
+    Xen9pfsRing *ring = &priv->rings[pdu->tag % priv->num_rings];
+    struct iovec in_sg[2];
+    int num;
+
+    xen_9pfs_in_sg(ring, in_sg, &num, pdu->idx, 0);
+    return iov_size(in_sg, num);
+}
+
 static const V9fsTransport xen_9p_transport = {
     .pdu_vmarshal = xen_9pfs_pdu_vmarshal,
     .pdu_vunmarshal = xen_9pfs_pdu_vunmarshal,
@@ -275,6 +286,7 @@ static const V9fsTransport xen_9p_transport = {
     .init_out_iov_from_pdu = xen_9pfs_init_out_iov_from_pdu,
     .push_and_notify = xen_9pfs_push_and_notify,
     .msize_limit = xen_9p_msize_limit,
+    .response_buffer_size = xen_9pfs_response_buffer_size,
 };
 
 static int xen_9pfs_init(struct XenLegacyDevice *xendev)
-- 
2.47.3


