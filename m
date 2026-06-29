Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D626C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:39:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weCC5-0001ip-50; Mon, 29 Jun 2026 09:38:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <12bcbdca8ae9fcd5fec093e8ef5e70521e85e889@kylie.crudebyte.com>)
 id 1weCC3-0001f2-Rv; Mon, 29 Jun 2026 09:38:35 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <12bcbdca8ae9fcd5fec093e8ef5e70521e85e889@kylie.crudebyte.com>)
 id 1weCC2-0003tk-BA; Mon, 29 Jun 2026 09:38:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=wA5WgsgKQXyassqJxRXshSb0ETANhXBadc5QCGmjXfc=; b=eFABQ
 rR3hRakIqvrO+RRoc2U6Bv+Wst6//+VE6aJrUudZz0XBRbu671rP7kkGnSvxdpVOYyf88r0K3uUPn
 0QzLvW2JMmfjB8457rf6/nWLYNMcYtIve9yPW0L/d+BJJOvRRIxKubfCAeQf482KyGE64Rhc3eDuG
 EDCSrT6W3Oqi0RvTfVd+LChW9KT55/ydtxCP38aUEh4/Vj1CBVkuyM5r1hiK/CP9+o94YIjfrDREN
 GIvH8f6tukZQ8yiMVp2ONUTyfk8cUkVaxoT1GHJ3dNrVuQN2mmNjjkG/ZuZ7X/RLyYwoLsmz8jve0
 VtbY6kkK97wugcUSQENWix8JiODjBn5uzGoNnDwupKLd4v2JZnC+w9c5beDG52P7tDTj8mVU8xZnU
 KXYj8jMsNU2imHUCxHzVxALSvOw2/c3RYBYxT5cwES2Tiy77+PWQd+70f/JjhNBYM6IWQVDPmZBhX
 UgFtcaLu/mfyLab+bRdrXwQsR7LzfU84mDTp/mPKtkcJV3q2uskcni9dRHl4qvsF9MGNCE9Sq+LYY
 7R8Q9HyFjfLH7Qi/PkzGyq3Qen8WfxL3cZ/PHS9QHFUFY3XD+2vffA1hbm7txSATLcbwhP115xgn6
 ygIX2d0QN0BA0NEuROSKxtGNDu2M3U8FoclLm8ogdF8qbPoNuk2jIT4pTgjqxE=;
Message-ID: <12bcbdca8ae9fcd5fec093e8ef5e70521e85e889.1782739719.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1782739719.git.qemu_oss@crudebyte.com>
References: <cover.1782739719.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Mon, 29 Jun 2026 15:28:39 +0200
Subject: [PULL 06/23] 9pfs/virtio: implement response_buffer_size callback
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Feifan Qian <bea1e@proton.me>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=12bcbdca8ae9fcd5fec093e8ef5e70521e85e889@kylie.crudebyte.com;
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

Add and implement the response_buffer_size callback for the virtio
transport.

Returns the actual current virtio response buffer size for the supplied
PDU, which will be used as safety guard for limiting the response size
when generating a 9p response.

Link: https://lore.kernel.org/qemu-devel/5bbed2768f7a0da8fa2be183e75928c5d1ef691d.1781287774.git.qemu_oss@crudebyte.com
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/virtio-9p-device.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
index 8c5d86cb66..50dc93091d 100644
--- a/hw/9pfs/virtio-9p-device.c
+++ b/hw/9pfs/virtio-9p-device.c
@@ -198,6 +198,15 @@ static size_t virtio_9p_msize_limit(V9fsState *s)
     return (VIRTQUEUE_MAX_SIZE - 2) * guestPageSize;
 }
 
+static size_t virtio_9p_response_buffer_size(V9fsPDU *pdu)
+{
+    V9fsState *s = pdu->s;
+    V9fsVirtioState *v = container_of(s, V9fsVirtioState, state);
+    VirtQueueElement *elem = v->elems[pdu->idx];
+
+    return iov_size(elem->in_sg, elem->in_num);
+}
+
 static const V9fsTransport virtio_9p_transport = {
     .pdu_vmarshal = virtio_pdu_vmarshal,
     .pdu_vunmarshal = virtio_pdu_vunmarshal,
@@ -205,6 +214,7 @@ static const V9fsTransport virtio_9p_transport = {
     .init_out_iov_from_pdu = virtio_init_out_iov_from_pdu,
     .push_and_notify = virtio_9p_push_and_notify,
     .msize_limit = virtio_9p_msize_limit,
+    .response_buffer_size = virtio_9p_response_buffer_size,
 };
 
 static void virtio_9p_device_realize(DeviceState *dev, Error **errp)
-- 
2.47.3


