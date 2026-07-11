Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF80AC43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:00:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wifk2-0001ow-Na; Sat, 11 Jul 2026 18:00:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifjz-0001go-VY; Sat, 11 Jul 2026 18:00:08 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifjx-0007v0-CY; Sat, 11 Jul 2026 18:00:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783807180; bh=SqgggJubRVStc1gNTX7oPIDEaPV3dUMrYIYtU+T0x+w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=BdGxWPgEREx+H9LIntMa/jMUy0nr7DfHMBMTYhLJKhnYqn+mRvugHnoWpVJVTWmw4
 gtaFJIsRhLXorkJLx1nG+gvFcpWIPSbfBLfMhFMcqs9AUQGq/BIsuuIu+C0LmtPUbA
 sXKtZy/ry2IC7E8IKR5J/ifvHW6g7quEGpXtMNrYdgABw7hXBPObHLvBKyg5FZZ0KR
 dkS97xuLV6EB0EB203/ifBzGPKffyO5xf3WakIdO70kJ8TQ6A1TTWmQjNd5sRHwaDs
 n3LtXZCMkDJQK57ZnGeMHy/TxEivbOBMGwv9o/T5YD+pPGFZgvErYIkGkyV5xCHtDo
 xNZt7hjZz9X0Q==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3FE7D1C0A95;
 Sun, 12 Jul 2026 00:59:40 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id EAF753EAF20;
 Sun, 12 Jul 2026 00:59:49 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 4DD15132F7; Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 10/81] 9pfs/xen: implement response_buffer_size
 callback
Date: Sun, 12 Jul 2026 00:57:48 +0300
Message-ID: <20260711215904.3757-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
References: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
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
index e31124bcf51..24c90d97ec9 100644
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


