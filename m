Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA16CD98CF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 19:00:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY770-00012H-3n; Fri, 12 Jun 2026 15:00:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <5bbed2768f7a0da8fa2be183e75928c5d1ef691d@kylie.crudebyte.com>)
 id 1wY76x-0000zO-No; Fri, 12 Jun 2026 15:00:11 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <5bbed2768f7a0da8fa2be183e75928c5d1ef691d@kylie.crudebyte.com>)
 id 1wY76w-0000GH-3L; Fri, 12 Jun 2026 15:00:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=alpHi4/PFoi3yPOlBsVk76F8rFaLq0t1rgSAqoTTaO0=; b=Gm2kf
 hqn3dvIZ0idm9wVpTrQwQwLr7ldCj0xjkf/MUaxXRFrNOlTjBWI4yteYg8zZD6yKoTa7Qy+Tcfer5
 YyIWOuSIIi/9sqviu/adFfoGL+5aj8SNzFZwDBCXU/hnBs/Qt6/KDo2VaJoUMl456axgJNYuMo/mM
 yK3gHfuS/HZxx0v50m1NlVtxXKIC14NuPpKNP4TY/gxx+T7m4zTqqy6OOWmMmRzx/vkcUxCxrIhOP
 3iKJuYSyDmt4acJmGRlh3SCCjp2H3rAsb6Yt48qud1p15n/M/wZaSgYe4N53c70Mf67YsdHUmwuEC
 TEwIBcE0LQDzMv89UyUB4QiLv0hVamUvDSEDgcvX7ISH7v34gwwdwdchxmm7b34ALuGkcrTmctmfb
 O0Of9vV+jtt233QBOnaPLl3OXb0tMJukxwKZMl43/BNEeSad7a+1ZQ64xp9WaEL03HkQ5C76zQcGd
 GeiQN1rgduiVvJL+ud1EYZs66jloGHgWqefDFMDEQyBbNKcSc9MQeI3Yj3/XUraQOrjvT46Ug/Ymt
 aqqLkiiORGp699wsScEL7jD5ndCnCAjBaZ692ToYaPOq27x4lm92g13wxgD0Kde2uO/wyL4afgYNj
 Ebyj1y2w2ld5rphV99q86ogcT/+DLG2BJXqf+5PpLhU60qFzzUH6D7ChAV3Cck=;
Message-ID: <5bbed2768f7a0da8fa2be183e75928c5d1ef691d.1781287774.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1781287774.git.qemu_oss@crudebyte.com>
References: <cover.1781287774.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Fri, 12 Jun 2026 20:22:52 +0200
Subject: [PATCH v2 6/8] 9pfs/virtio: implement response_buffer_size callback
To: qemu-devel@nongnu.org,
    qemu-stable@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Feifan Qian <bea1e@proton.me>,
 Stefano Stabellini <sstabellini@kernel.org>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=5bbed2768f7a0da8fa2be183e75928c5d1ef691d@kylie.crudebyte.com;
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


