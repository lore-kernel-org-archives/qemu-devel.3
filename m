Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0BE5C43602
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 11:22:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh3sO-0002EN-CD; Tue, 07 Jul 2026 07:22:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1wh3sI-0002Cg-M3
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 07:22:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1wh3sH-0002nr-8w
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 07:22:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783423318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mRPcGEawvvi+QEQ88pqboXZ3cX6ACsA7L83H+pdRsr8=;
 b=XO3yAoQET51soj08B/Jp7CF/dEcBK3zfNISkRAG1XyieZM6FThhR/xlfiOM1I9W0HJL36S
 SL9+cO3XE6eOGGZc9V0OUkDsGplDSAyuLzfNOPEnibsB+e0BSOhQCKyrUmiHSX3qJrtCYK
 F/uob2S2uNiOlaH47tTL5l6hfbcNVDM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-i-eoYUdaPvKTw3JZ9f4asw-1; Tue,
 07 Jul 2026 07:21:56 -0400
X-MC-Unique: i-eoYUdaPvKTw3JZ9f4asw-1
X-Mimecast-MFC-AGG-ID: i-eoYUdaPvKTw3JZ9f4asw_1783423316
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D68201954B3B
 for <qemu-devel@nongnu.org>; Tue,  7 Jul 2026 11:21:55 +0000 (UTC)
Received: from fedora (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7BA32180067C; Tue,  7 Jul 2026 11:21:54 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Albert Esteve <aesteve@redhat.com>
Subject: [PATCH 0/2] virtio: shmem map transaction cleanup
Date: Tue,  7 Jul 2026 13:21:47 +0200
Message-ID: <20260707112149.2867886-1-aesteve@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This series is a follow-up cleanup to [1], which introduced the
VHOST_USER_BACKEND_SHMEM_MAP request handler in vhost-user.c, and
addresses suggestions raised during its review.

The first patch wraps the raw memory_region_transaction_begin()/commit()
calls to hide implementation details behind dedicated helpers (see [2]).

The second patch builds on those helpes by replacing the manual begin/end
calls with a g_autoptr guard that commits the transaction automatically on
all exit paths, removing the send_reply_commit label which became redundant
as a result.

[1] https://lore.kernel.org/all/20260304165223.2166175-1-aesteve@redhat.com/
[2] https://lore.kernel.org/all/a74da624-8665-46d6-846d-15fc932775cc@redhat.com/

Albert Esteve (2):
  virtio: add shmem map transaction wrappers
  virtio: use g_autoptr guard for shmem map transaction

 hw/virtio/vhost-user.c     | 21 ++++-----------------
 hw/virtio/virtio.c         | 12 ++++++++++++
 include/hw/virtio/virtio.h | 29 +++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 17 deletions(-)

-- 
2.54.0


