Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F60C44501
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:00:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wifjs-0001Xu-DQ; Sat, 11 Jul 2026 18:00:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifjr-0001XB-6p; Sat, 11 Jul 2026 17:59:59 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifjp-0007sk-Hz; Sat, 11 Jul 2026 17:59:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783807180; bh=nLadK8CU1IlBdX5sCh3ocS52jE9QwG6PesNSG3zaltM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=eZH8PncdO8CD7Mw0wouo8eKYDdM4NUvQ5IGQV6CmzHNQapmHF/63CRhwLsE+yXnbL
 T9Gxxe6sd0RpHwgyA1nugAq75DTtp/YA+lcG+mfCCr8+n9JJrC7GCrodGgq75aXCcc
 tYDSkBdChU5OqIAyBGSWJ8+wseN1GLXfbb887ZOv1H8ZevsgcnAKDx9vUriH+1w/Fo
 p0ZkTC//bXG8QImTh8BtirQft9DlftYmvwK/BYvdqTqFk7iL/KsqAwdNU3Is5KO9V2
 pBAEvi0zres5SbQr4rjFyuoLqoJohrphjL9UAPtc+wuz3gCfNFWxSkQD5qXGcYwfW4
 3K5mh24SsHgNg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 243A11C0A90;
 Sun, 12 Jul 2026 00:59:40 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id CFDC13EAF1B;
 Sun, 12 Jul 2026 00:59:49 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 424E8132ED; Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 05/81] 9pfs/virtio: implement msize_limit callback
Date: Sun, 12 Jul 2026 00:57:43 +0300
Message-ID: <20260711215904.3757-5-mjt@tls.msk.ru>
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
index 9f70e2338cd..8c5d86cb66a 100644
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


