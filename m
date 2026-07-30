Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17BF1C5516D
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 20:59:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpXqJ-00028G-DT; Thu, 30 Jul 2026 16:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wpXqI-000282-Hn
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 16:59:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wpXqH-0002YV-4e
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 16:59:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785445140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=dvMbqFBMdJmguuzweYRYmvsczOglGPjEuS3sINzhzJg=;
 b=K05WIc1yYkoKuD6/yFlF/b9QM6sERTwea/Z1oIa2MFsXTVg8xYh2eLNpho9btleoFoGyt8
 nnSWwoEgaKYxDan99wQ/1E9bt3fO9E2HMcgLqR95j+KVTC7zQ8SVWK9AAsuo9BwAWo1ZhB
 GuItkXwnFWbxC34w7xxoVrO3dtv/J0Q=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-195-wYQ_TpcDMP65IHuyeXC74g-1; Thu,
 30 Jul 2026 16:58:56 -0400
X-MC-Unique: wYQ_TpcDMP65IHuyeXC74g-1
X-Mimecast-MFC-AGG-ID: wYQ_TpcDMP65IHuyeXC74g_1785445132
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C3CE118004A9; Thu, 30 Jul 2026 20:58:50 +0000 (UTC)
Received: from localhost (unknown [10.2.16.217])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 786621800480; Thu, 30 Jul 2026 20:58:47 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 virtio-fs@lists.linux.dev, Hanna Reitz <hreitz@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Milan Zamazal <mzamazal@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Dorjoy Chowdhury <dorjoychy111@gmail.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Alexander Graf <graf@amazon.com>,
 Laurent Vivier <lvivier@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 David Hildenbrand <david@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 qemu-block@nongnu.org, Greg Kurz <groug@kaod.org>,
 Raphael Norwitz <rnorwitz@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Amit Shah <amit@kernel.org>
Subject: [PATCH v2 0/2] virtio: fix virtio_add_queue() queue size Coverity
 issue
Date: Thu, 30 Jul 2026 16:58:44 -0400
Message-ID: <20260730205846.19479-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

v2:
- Deal with x-override-queue-size, the root cause for the Coverity issue
  [Peter]

virtio_add_queue() uses int rather than unsigned int for the virtqueue size. It
also fails to validate the x-override-queue-size qdev property. Refactor the
code to solve these issues.

Patch 2 adds an Error **errp argument to virtio_add_queue() and changes all
callers to pass &error_abort. This solution requires many code changes, but
it's a step in the direction of propagating errors and that should be the
long-term goal.

Stefan Hajnoczi (2):
  virtio: make virtio_add_queue() queue_size an unsigned int
  virtio: use Error for queue size validation in virtio_add_queue()

 include/hw/virtio/virtio.h     |  4 ++--
 hw/9pfs/virtio-9p-device.c     |  2 +-
 hw/audio/virtio-snd.c          |  8 +++----
 hw/block/vhost-user-blk.c      |  3 ++-
 hw/block/virtio-blk.c          |  3 ++-
 hw/char/virtio-serial-bus.c    | 14 ++++++------
 hw/display/virtio-gpu-base.c   |  8 +++----
 hw/input/virtio-input.c        |  6 ++++--
 hw/net/virtio-net.c            | 15 ++++++++-----
 hw/scsi/virtio-scsi.c          |  9 +++++---
 hw/virtio/vdpa-dev.c           |  3 ++-
 hw/virtio/vhost-user-base.c    |  3 ++-
 hw/virtio/vhost-user-fs.c      |  8 +++++--
 hw/virtio/vhost-user-scmi.c    |  6 ++++--
 hw/virtio/vhost-vsock-common.c |  9 +++++---
 hw/virtio/virtio-balloon.c     | 15 ++++++++-----
 hw/virtio/virtio-crypto.c      |  6 ++++--
 hw/virtio/virtio-iommu.c       |  6 ++++--
 hw/virtio/virtio-mem.c         |  3 ++-
 hw/virtio/virtio-nsm.c         |  2 +-
 hw/virtio/virtio-pmem.c        |  2 +-
 hw/virtio/virtio-rng.c         |  2 +-
 hw/virtio/virtio-rtc.c         |  3 ++-
 hw/virtio/virtio.c             | 39 +++++++++++++++++++++++++++++-----
 24 files changed, 122 insertions(+), 57 deletions(-)

-- 
2.55.0


