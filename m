Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D507ACD6E44
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 22:01:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSMI7-0003Us-GX; Wed, 27 May 2026 17:59:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <3a605806166cdbf6c451eef9e5544f7e5019708b@kylie.crudebyte.com>)
 id 1wSMI6-0003UK-4Y; Wed, 27 May 2026 17:59:54 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <3a605806166cdbf6c451eef9e5544f7e5019708b@kylie.crudebyte.com>)
 id 1wSMI4-0004HP-PS; Wed, 27 May 2026 17:59:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=alpHi4/PFoi3yPOlBsVk76F8rFaLq0t1rgSAqoTTaO0=; b=MB+BH
 Edee3RTwxhifFN4C/OJboNyWssyPWz1ckqTOghqBOGhuRpiEtGiJUpVPZHCZxX+dbES6p/4UCrvDE
 L9cM6Bvb3Vs90+8Cwk9DxRWzX1wAscV40MnJ4CPUr63hwN/rece+UaLadxuQvfifbWCOJbGfbWhBY
 PFqffabLoBRPNfTgTvbWSrniYJGJHafDl0zCy4xIcrUEqoELQ06A+5qGb2hDibmrw3sbgqO5jZ/HU
 upxysHCJlqNxl7oyqsDTSG7DSTARWNCYFqi+ZBDApT13ajKFvE0lBph0CbXYxqPSkigdMuOcgvRkM
 znnmIIzGM7vgAfmgPeAWgeqZoJd6TZp4oGvcDiTRXHSIHe3o6z32eiD9qW/01UKO474o5Mn+HoDyl
 KgH5K/IBD7iKHoUpDgYkLvvy+w9U6BuwNHUqKcRgIEX8BEbk7363uWe7j+ULywDl99AWP4GxzG3MN
 Mc4IceeTDiYtlV7QwwWo+5+k7Bs99elE2DPNdW+fqw2W1rJK3Y9JaYv7Q5lWL/E5uuAfjGkxAfebs
 AIgaPKk9Z8xb/OmBpOECVVA/T35J4AitOcbfZro6CdDnVNdx2wRXCmdU1Jy3TjAY2wXPyNbVEoe53
 mai28INzhe+Vvh/8JHNPVtfdPiuglRYpXzutNWNFFJgE0V4flhhd+FesmGfI90=;
Message-ID: <3a605806166cdbf6c451eef9e5544f7e5019708b.1779916560.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1779916560.git.qemu_oss@crudebyte.com>
References: <cover.1779916560.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Wed, 27 May 2026 23:15:32 +0200
Subject: [PATCH 6/8] 9pfs/virtio: implement response_buffer_size callback
To: qemu-devel@nongnu.org,
    qemu-stable@nongnu.org
Cc: Greg Kurz <groug@kaod.org>,
    Feifan Qian <bea1e@proton.me>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=3a605806166cdbf6c451eef9e5544f7e5019708b@kylie.crudebyte.com;
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


