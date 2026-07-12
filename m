Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 961FEC43458
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2026 04:17:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wilcf-0001im-DI; Sun, 12 Jul 2026 00:16:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wilcO-0001d0-Le; Sun, 12 Jul 2026 00:16:41 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wilcM-0006Fa-Mn; Sun, 12 Jul 2026 00:16:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783829780; bh=zRD+QVA80sL83toDeo+Ol2aI282UyE5YlSlhUqOBuWg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=oMWMeTtbRBqiGBGXD53edSe4kJEcLqySw2sR9Djknmq9h/BUNV29JT2l+URpoOkqC
 6gNvWoAUtMX/9pm/4O2bxlih/qa2jxIcJzpdts/FWAFPIqLUynBMc746C5T2MMBapK
 4F3wLAHXjqGbTSSYryWov9At6XpFHmsfXXxXJSC9uCt1UpgfA8n6PLHc+2DiFoI50R
 bK0cy5awgPWygokeuwJLrou31yIivnZt02v/8H70lxBwxMIuVv2XmmSZzHRZozAUhB
 GSLz7VdRlaKyDKKqqbCofFj9cCXCB8JT2Xm3J3SKjddd5Y2uj5PIkMZ/2HYUPgzkDz
 lCJjh8MDgHSmw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B8EF61C0BE1;
 Sun, 12 Jul 2026 07:16:20 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id EBC173EB941;
 Sun, 12 Jul 2026 07:16:30 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 22E06133C5; Sun, 12 Jul 2026 07:16:31 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.12 06/75] 9pfs/virtio: implement msize_limit callback
Date: Sun, 12 Jul 2026 07:14:24 +0300
Message-ID: <20260712041539.108341-6-mjt@tls.msk.ru>
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
(cherry picked from commit 4a1a2fa4d351ba85628064e4a2a9cbc0c72cdbd4)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
index bb2843da0f6..c795afa6440 100644
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


