Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABCB0C3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 00:25:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCp4Q-00067o-0w; Wed, 07 May 2025 20:25:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <afaria@redhat.com>) id 1uCp4M-00064o-GS
 for qemu-devel@nongnu.org; Wed, 07 May 2025 20:24:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <afaria@redhat.com>) id 1uCp4K-0007TA-Uy
 for qemu-devel@nongnu.org; Wed, 07 May 2025 20:24:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746663896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=nrUiYLGuofZplWuxxJETdEH9HBEFopFfFhqIQ8yveHs=;
 b=fXUGuuyrR2iJZW1mqy3WBIBORQvtuDrQFnzGY0Ovk5BPyJ0JaGSxqjKrKoPUjK4aAX7w0g
 4/geLU4NV7XJrSxKbDfFb/Z2+4DUosIkvoeuDNOHzhOCnQnImovvsZDw3UHuvgEGhGlGA5
 lh4zM1KJktXLAS5ateIZ6nMHtlxbtSE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-1-LmMPc5lrNh-G8E_hmlhoCA-1; Wed,
 07 May 2025 20:24:52 -0400
X-MC-Unique: LmMPc5lrNh-G8E_hmlhoCA-1
X-Mimecast-MFC-AGG-ID: LmMPc5lrNh-G8E_hmlhoCA_1746663891
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 624361956086; Thu,  8 May 2025 00:24:50 +0000 (UTC)
Received: from desktop.redhat.com (unknown [10.45.224.21])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8FEBA19560A7; Thu,  8 May 2025 00:24:42 +0000 (UTC)
From: Alberto Faria <afaria@redhat.com>
To: qemu-devel@nongnu.org
Cc: Coiby Xu <Coiby.Xu@gmail.com>, Laurent Vivier <lvivier@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Raphael Norwitz <raphael@enfabrica.net>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Hanna Reitz <hreitz@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Xie Yongji <xieyongji@bytedance.com>, Yanan Wang <wangyanan55@huawei.com>,
 Alberto Faria <afaria@redhat.com>
Subject: [RFC 0/4] virtio-blk: Add support for FUA write requests
Date: Thu,  8 May 2025 01:24:36 +0100
Message-ID: <20250508002440.423776-1-afaria@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=afaria@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

There is a proposal to introduce virtio-blk fua write support to the virtio
spec [1], and a matching kernel RFC [2]. This series implements the proposal by
adding VIRTIO_BLK_{F,T}_OUT_FUA uapi definitions and corresponding virtio-blk,
vhost-user-blk, and vduse-blk support.

[1] https://lore.kernel.org/virtio-comment/20250507152602.3993258-1-afaria@redhat.com/
[2] https://lore.kernel.org/linux-block/20250508001951.421467-1-afaria@redhat.com/

Alberto Faria (4):
  include: Add tentative virtio-blk FUA write definitions
  virtio-blk: Add VIRTIO_BLK_T_OUT_FUA command support
  vhost-user-blk: Add VIRTIO_BLK_T_OUT_FUA command support
  vduse-blk: Add VIRTIO_BLK_T_OUT_FUA command support

 block/export/vduse-blk.c                    |  3 +-
 block/export/vhost-user-blk-server.c        |  1 +
 block/export/virtio-blk-handler.c           |  7 ++-
 contrib/vhost-user-blk/vhost-user-blk.c     | 16 ++++--
 hw/block/vhost-user-blk.c                   |  3 ++
 hw/block/virtio-blk.c                       |  2 +
 hw/core/machine.c                           |  5 +-
 hw/virtio/virtio-qmp.c                      |  2 +
 include/standard-headers/linux/virtio_blk.h |  4 ++
 tests/qtest/vhost-user-blk-test.c           | 56 +++++++++++++++++++++
 tests/qtest/virtio-blk-test.c               | 56 +++++++++++++++++++++
 11 files changed, 148 insertions(+), 7 deletions(-)

-- 
2.49.0


