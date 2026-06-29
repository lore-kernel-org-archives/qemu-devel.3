Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0905CC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:39:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weCCO-00039e-UV; Mon, 29 Jun 2026 09:38:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <69c8f5e6946f76a70b141a340c7aeb9d6a8e3c27@kylie.crudebyte.com>)
 id 1weCCO-00035W-2n; Mon, 29 Jun 2026 09:38:56 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <69c8f5e6946f76a70b141a340c7aeb9d6a8e3c27@kylie.crudebyte.com>)
 id 1weCCM-0003xP-Ft; Mon, 29 Jun 2026 09:38:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=3J8Z3/ZuD35HVfkr5nQfyeSnezElwJXEdSzjILafr4E=; b=pzHUl
 0M5kZdTex5xN4tXUtB+tszTglZKuyg7z+fCCA94c2KrKGcCxL3zUj72uKMY9HnlX4RYWiL7jKjp2v
 KnBl8rOlNexdeYSz2aHed0kFiwTz+fsSfiY8BsHKUdvl5mil+6iGk+ufNbxnfYNQXMMaMJpKDIHNy
 GMeuyqCgXYP6aWvDPGwTnXQsC2Or6revRCIhQSENmoNGdwTvR5LoINw527tRWZ1CaKB3V5jliAadP
 AgB7Ay9AEKk3A+iCbo81fMuoQiqM8HJ3DsYk3XcEwSvfbL/hZlvcuE5CkPBBawuA9w1by1PB43dIN
 HhJsFSpYm2QBHOXdzJD3Uw6XC085aUkfE8jM4cS7FE5Ha3MKYesuWsWlSPdbQVv6n68YUXZn9fUFo
 /wH7vDyf8qn/VcgISqwKoPtPKhG91IiWKTtzWvTg+ruQ5Vidww5PPEr2IN0WbuITMbGKWJwJVt2ak
 J5fn/4WQLUlXCXJ2nBQrdabtkOSASmgSNhh1dm/02oIh/oH3Xj0Ox/GlkEuVODhmsheqTlcwFhVti
 QWdmQ7vHTy1xhwmMk8jw9ESjSVYZL/4IzeYV6w35HQ78ZEmoPmA42OUOkcju1HdWjzaC+rUS3GXBz
 R8yBUMWFLtN8xyTO/CFh5GzbCYey0qTDJdSUJ0PvTvlzxr4krm0KuBZ1JIqipg=;
Message-ID: <69c8f5e6946f76a70b141a340c7aeb9d6a8e3c27.1782739719.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1782739719.git.qemu_oss@crudebyte.com>
References: <cover.1782739719.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Mon, 29 Jun 2026 15:28:39 +0200
Subject: [PULL 07/23] 9pfs/xen: implement response_buffer_size callback
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Feifan Qian <bea1e@proton.me>,
 Stefano Stabellini <sstabellini@kernel.org>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=69c8f5e6946f76a70b141a340c7aeb9d6a8e3c27@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
---
 hw/9pfs/xen-9p-backend.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
index e31124bcf5..24c90d97ec 100644
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


