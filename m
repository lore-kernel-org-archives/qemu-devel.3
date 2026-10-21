Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89AF606A31B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 06:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Y8k2zjN1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJPkc-0003HB-Tj; Wed, 21 Oct 2026 02:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <afaria@redhat.com>) id 1xJPkR-0003FB-5Q
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 02:24:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <afaria@redhat.com>) id 1xJPkO-0003gu-Ag
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 02:24:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792563852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=lmxaYtKn9R8MYVd0EM1cBPVFBI0++frJcWr5hpFMXxg=;
 b=Y8k2zjN1YV1A1kgE2VStB5X6dj0YuhgqxjTOx32Auw3i7X7hLvcbQ9B4/tTIrHasvhQBau
 ENzAlIw9LqrjsHuuW3g+c4fKsxRwfhOVhf/7S1SXdNUnJ5y620eqsEmNNXSLqyWr0Ag1e0
 qDK1zRt6iZt6TMS45kmsq06DG6hx64g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-473-j3q8DLCNPECdf1PI0uUk-g-1; Wed,
 21 Oct 2026 06:23:03 +0000
X-MC-Unique: j3q8DLCNPECdf1PI0uUk-g-1
X-Mimecast-MFC-AGG-ID: j3q8DLCNPECdf1PI0uUk-g_1792563782
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 572D018002C8; Wed, 21 Oct 2026 06:23:02 +0000 (UTC)
Received: from desktop (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1C9E11800257; Wed, 21 Oct 2026 06:22:58 +0000 (UTC)
From: Alberto Faria <afaria@redhat.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alberto Faria <afaria@redhat.com>
Subject: [PATCH 0/2] virtio-blk: Add support for FUA write requests
Date: Wed, 21 Oct 2026 07:22:55 +0100
Message-ID: <20261021062257.735757-1-afaria@redhat.com>
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=afaria@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

virtio-blk FUA write support has been introduced to the virtio spec [1], and a
kernel patch is under review [2]. This patch enables FUA on the virtio-blk
device, so guests can submit FUA writes instead of the slower alternative of a
regular write followed by a flush.

A simple randwrite fio workload on a RAM disk (bs=4k, iodepth=1, direct=1,
sync=1) shows a throughput improvement of 17.1k IOPS to 27.7k IOPS (+62%).

[1] https://lore.kernel.org/virtio-comment/20251112055113.62207-1-afaria@redhat.com/
[2] https://lore.kernel.org/linux-block/20261021055235.648957-1-afaria@redhat.com/

Alberto Faria (2):
  include: Add virtio-blk request flag FUA definitions
  virtio-blk: Add support for FUA write requests

 hw/block/virtio-blk.c                       | 27 +++++++++++++++++++++
 hw/core/machine.c                           |  1 +
 hw/virtio/virtio-qmp.c                      |  4 +++
 include/hw/virtio/virtio-blk.h              |  1 +
 include/standard-headers/linux/virtio_blk.h | 13 ++++++++--
 5 files changed, 44 insertions(+), 2 deletions(-)

-- 
2.56.0


