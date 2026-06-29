Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8841DC43602
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:38:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weCBd-0000pf-1v; Mon, 29 Jun 2026 09:38:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <4a1a2fa4d351ba85628064e4a2a9cbc0c72cdbd4@kylie.crudebyte.com>)
 id 1weCBa-0000kG-UY; Mon, 29 Jun 2026 09:38:06 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <4a1a2fa4d351ba85628064e4a2a9cbc0c72cdbd4@kylie.crudebyte.com>)
 id 1weCBZ-0003ms-FB; Mon, 29 Jun 2026 09:38:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=BchJh60RdKC4rAMRfu2I4YvaIkAxMEtxsBVDs3TagXw=; b=whUEC
 upYWNYcU1oonAsgmW4Q3ZNvuBlnUbzDcyt00mMUYlSCJN9KZktTyUAG+rcyCobMxcvCXs+CwtKy2Q
 RDuMoO2cF5Z2qVnp3iswvP4lnySHm0mtiFzb6hDhSId58943nlcUvoLvjzCNi78KFZvbFYQ4hdSZr
 rr0VfflbltV9yc/yuwqVi+oQd2k87ttqigUSbZrnjxgO56HrU6Iwro5whemEb5T9LvnbNjWOTD5Ss
 gm+XVo68aTXWTWe+SOddzwI8kRfcx3WHATSc9pjzQoCsSI0g+0ZxaV4Fz9iuAgRlFbsi6lAnrqPd2
 4H30KAj2j5uv9vF2G0A06ujFc7VWMgdTKD6anoMZGQBKp5HfQMfvZmwr2G5ww6/tyJ5pdLt1rsE91
 E6FKdOVH9cJEp+ppoMhVNvLRUvK+DbLqB5Qs1BLXI/6znSZrp3sT9qJFkyJxbXF741UtSDapMuhY0
 n/tnKTrlgmSpUeAoYWgzM8WAZy8Dk6KyIETGDfgIjLhLKMRbBgbcnGwtvpOXpO5vooPUNx0kp+4ss
 ozsx3HGfWs5kI1EdVCC+mmZmEQTFrJSfTlKT7BBifsz/3nTGCXLtvyVg+ewQenJDfNyK2E5w8eToV
 Jp7+F400jI4RTPsvAcB9Jy0lIkcZuC1N+d/0fhfxhGvxa813YgTk6NyggG8MjU=;
Message-ID: <4a1a2fa4d351ba85628064e4a2a9cbc0c72cdbd4.1782739719.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1782739719.git.qemu_oss@crudebyte.com>
References: <cover.1782739719.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Mon, 29 Jun 2026 15:28:39 +0200
Subject: [PULL 02/23] 9pfs/virtio: implement msize_limit callback
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Feifan Qian <bea1e@proton.me>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=4a1a2fa4d351ba85628064e4a2a9cbc0c72cdbd4@kylie.crudebyte.com;
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

Add and implement the msize_limit callback for the virtio transport.

This new callback function provides the theoretical maximum 'msize'
value supported by this virtio transport.

The limit is calculated as (VIRTQUEUE_MAX_SIZE - 2) * 4096 bytes,
where 2 virtio descriptors are lost exactly for:

  - 1 descriptor for the original request (typically being small)

  - 1 descriptor as indirect table pointer (when used), which just
    contains a pointer to the separate sglist containing the
    response's actual payload data

And 4096 bytes are assumed as standard page size used by Linux 9p
client. This results in a maximum 'msize' of 4186112 bytes.

Theoretically Linux client could support a much larger size, e.g. by
using multiple consecutive pages per sg entry / descriptor. However
that's currently not the case and unlikely to change any time soon.
And due to recent security issues, let's handle this limit
conservatively until really necessary to be raised.

Link: https://lore.kernel.org/qemu-devel/4c34426bc906e19423e7e2389c419c2e972d9b9b.1781287774.git.qemu_oss@crudebyte.com
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/virtio-9p-device.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
index 9f70e2338c..8c5d86cb66 100644
--- a/hw/9pfs/virtio-9p-device.c
+++ b/hw/9pfs/virtio-9p-device.c
@@ -192,12 +192,19 @@ static void virtio_init_out_iov_from_pdu(V9fsPDU *pdu, struct iovec **piov,
     *pniov = elem->out_num;
 }
 
+static size_t virtio_9p_msize_limit(V9fsState *s)
+{
+    const size_t guestPageSize = 4096;
+    return (VIRTQUEUE_MAX_SIZE - 2) * guestPageSize;
+}
+
 static const V9fsTransport virtio_9p_transport = {
     .pdu_vmarshal = virtio_pdu_vmarshal,
     .pdu_vunmarshal = virtio_pdu_vunmarshal,
     .init_in_iov_from_pdu = virtio_init_in_iov_from_pdu,
     .init_out_iov_from_pdu = virtio_init_out_iov_from_pdu,
     .push_and_notify = virtio_9p_push_and_notify,
+    .msize_limit = virtio_9p_msize_limit,
 };
 
 static void virtio_9p_device_realize(DeviceState *dev, Error **errp)
-- 
2.47.3


