Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A54BC44501
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2026 04:20:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wilcp-0002Im-Vo; Sun, 12 Jul 2026 00:17:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wilcX-0001hI-BF; Sun, 12 Jul 2026 00:16:51 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wilcU-0006Gr-HT; Sun, 12 Jul 2026 00:16:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783829780; bh=lyBZ07NxtE3rcnLIaPGI2DFdtsN8hOiuMjlmJt97RU0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=GlSfFFaA01R1IrwS9UNmpWmJmbW/CJlk6zO9HPjKRnlrmBKodlkt2Hdl/eB4DTjYo
 /bAyUVroKZPbvVyb1B9ybWbqG73+WWYlZNeahadOj/coBz7ryqHYYuLFjhvjFEfWY7
 HDvu7uKt1n/hWxqVaNXDy+URbOLza4XZL31IZCbYMJcH2JMb34sTFkFhnRVE3ZFFc8
 L3YJvEnrBPn8ZZPvZjmQN49KVRJgTCg2o+zIOLcD32NjGVNhY92RVCmtvD8U2fAkCu
 6M75pF84WjppEGaRrUVWGpKPLzSEthCDGj0SUKGKkonMUkowoGngOzj/FxMA7R//ay
 LX8ltMxYOeZlA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D44A11C0BE5;
 Sun, 12 Jul 2026 07:16:20 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 135A53EB945;
 Sun, 12 Jul 2026 07:16:31 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 2C06B133CD; Sun, 12 Jul 2026 07:16:31 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.12 10/75] 9pfs/virtio: implement response_buffer_size
 callback
Date: Sun, 12 Jul 2026 07:14:28 +0300
Message-ID: <20260712041539.108341-10-mjt@tls.msk.ru>
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

Add and implement the response_buffer_size callback for the virtio
transport.

Returns the actual current virtio response buffer size for the supplied
PDU, which will be used as safety guard for limiting the response size
when generating a 9p response.

Link: https://lore.kernel.org/qemu-devel/5bbed2768f7a0da8fa2be183e75928c5d1ef691d.1781287774.git.qemu_oss@crudebyte.com
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
(cherry picked from commit 12bcbdca8ae9fcd5fec093e8ef5e70521e85e889)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
index c795afa6440..f3fabf2abd3 100644
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


