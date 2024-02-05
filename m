Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41BBFC48297
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 17:27:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rX2kU-0008T2-PH; Mon, 05 Feb 2024 12:27:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rX2kT-0008SS-6N
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 12:27:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rX2kR-0006OK-On
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 12:27:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707154030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kka7TxXxf07Y0G8FWpyDAIm/nDR/GQGEu5kXBK6b0P8=;
 b=OI6IKSdvQPB51R0iguTFbmC8cwZL/KXqYDkno/TzCJ9KANydtdC78d6j4VaqGGOFWZAY8r
 yzX/x0uiOwbnQmdD1VErRVN7Z7bPnNMJnewY8KSD7eFyEganDOvo/k+w8O2heeY0Cd72vW
 r/PaJ0inqROH6bVgsu4NLTNURY2zmo0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-357-Q02IBcttM-aduO3i-vy56A-1; Mon,
 05 Feb 2024 12:27:06 -0500
X-MC-Unique: Q02IBcttM-aduO3i-vy56A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8FDE31C05EC0;
 Mon,  5 Feb 2024 17:27:06 +0000 (UTC)
Received: from localhost (unknown [10.39.192.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0DFAA492BC6;
 Mon,  5 Feb 2024 17:27:05 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org
Subject: [PATCH 2/5] virtio-blk: clarify that there is at least 1 virtqueue
Date: Mon,  5 Feb 2024 12:26:56 -0500
Message-ID: <20240205172659.476970-3-stefanha@redhat.com>
In-Reply-To: <20240205172659.476970-1-stefanha@redhat.com>
References: <20240205172659.476970-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.285,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

It is not possible to instantiate a virtio-blk device with 0 virtqueues.
The following check is located in ->realize():

  if (!conf->num_queues) {
      error_setg(errp, "num-queues property must be larger than 0");
      return;
  }

Later on we access s->vq_aio_context[0] under the assumption that there
is as least one virtqueue. Hanna Czenczek <hreitz@redhat.com> noted that
it would help to show that the array index is already valid.

Add an assertion to document that s->vq_aio_context[0] is always
safe...and catch future code changes that break this assumption.

Suggested-by: Hanna Czenczek <hreitz@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/block/virtio-blk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index e8b37fd5f4..a0735a9bca 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1825,6 +1825,7 @@ static int virtio_blk_start_ioeventfd(VirtIODevice *vdev)
      * Try to change the AioContext so that block jobs and other operations can
      * co-locate their activity in the same AioContext. If it fails, nevermind.
      */
+    assert(nvqs > 0); /* enforced during ->realize() */
     r = blk_set_aio_context(s->conf.conf.blk, s->vq_aio_context[0],
                             &local_err);
     if (r < 0) {
-- 
2.43.0


