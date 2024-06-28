Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B9B4C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 14:58:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sND2e-0007BG-L1; Fri, 28 Jun 2024 10:57:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1sND2Z-0007AZ-TK
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 10:57:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1sND2X-00038R-BT
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 10:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719586645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=V9RUKIFtXdzZ3RWQjOxVMIzffGFa+x7jc27pv20LkH4=;
 b=Aokg6YntX1DtFvPq6EVFMlfkJumislVamIvJb2CYbjdjFaZVVh7wjIXv7GNGnuiiJhuHEK
 zg2HMEVbOaFLHMbkBSBvPe+9vGTxgK2nsEipKnA1JSf57XncZ/naSvAgUOq5CyqidHIDBf
 TTByk5PCB6nOtChoeRViTaTwbNT/vcU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-230-9WYA_QVzP7mklUtBQPEhFw-1; Fri,
 28 Jun 2024 10:57:21 -0400
X-MC-Unique: 9WYA_QVzP7mklUtBQPEhFw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 744AE19560AD; Fri, 28 Jun 2024 14:57:20 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.45.224.245])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D1ED419560A3; Fri, 28 Jun 2024 14:57:16 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, david@redhat.com, slp@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 stefanha@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
 Albert Esteve <aesteve@redhat.com>
Subject: [RFC PATCH v2 0/5] vhost-user: Add SHMEM_MAP/UNMAP requests
Date: Fri, 28 Jun 2024 16:57:05 +0200
Message-ID: <20240628145710.1516121-1-aesteve@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.206,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi all,

v1->v2:
- Corrected typos and clarifications from
  first review
- Added SHMEM_CONFIG frontend request to
  query VIRTIO shared memory regions from
  backends
- vhost-user-device to use SHMEM_CONFIG
  to request and initialise regions
- Added MEM_READ/WRITE backend requests
  in case address translation fails
  accessing VIRTIO Shared Memory Regions
  with MMAPs

This is an update of my attempt to have
backends support dynamic fd mapping into VIRTIO
Shared Memory Regions. After the first review
I have added more commits and new messages
to the vhost-user protocol.
However, I still have some doubts as to
how will this work, specially regarding
the MEM_READ and MEM_WRITE commands.
Thus, I am still looking for feedback,
to ensure that I am going in the right
direction with the implementation.

The usecase for this patch is, e.g., to support
vhost-user-gpu RESOURCE_BLOB operations,
or DAX Window request for virtio-fs. In
general, any operation where a backend
need to request the frontend to mmap an
fd into a VIRTIO Shared Memory Region,
so that the guest can then access it.

After receiving the SHMEM_MAP/UNMAP request,
the frontend will perform the mmap with the
instructed parameters (i.e., shmid, shm_offset,
fd_offset, fd, lenght).

As there are already a couple devices
that could benefit of such a feature,
and more could require it in the future,
the goal is to make the implementation
generic.

To that end, the VIRTIO Shared Memory
Region list is declared in the `VirtIODevice`
struct.

This patch also includes:
SHMEM_CONFIG frontend request that is
specifically meant to allow generic
vhost-user-device frontend to be able to
query VIRTIO Shared Memory settings from the
backend (as this device is generic and agnostic
of the actual backend configuration).

Finally, MEM_READ/WRITE backend requests are
added to deal with a potential issue when having
any backend sharing a descriptor that references
a mapping to another backend. The first
backend will not be able to see these
mappings. So these requests are a fallback
for vhost-user memory translation fails.

Albert Esteve (5):
  vhost-user: Add VIRTIO Shared Memory map request
  vhost_user: Add frontend command for shmem config
  vhost-user-dev: Add cache BAR
  vhost_user: Add MEM_READ/WRITE backend requests
  vhost_user: Implement mem_read/mem_write handlers

 docs/interop/vhost-user.rst               |  58 ++++++
 hw/virtio/vhost-user-base.c               |  39 +++-
 hw/virtio/vhost-user-device-pci.c         |  37 +++-
 hw/virtio/vhost-user.c                    | 221 ++++++++++++++++++++++
 hw/virtio/virtio.c                        |  12 ++
 include/hw/virtio/vhost-backend.h         |   6 +
 include/hw/virtio/vhost-user.h            |   1 +
 include/hw/virtio/virtio.h                |   5 +
 subprojects/libvhost-user/libvhost-user.c | 149 +++++++++++++++
 subprojects/libvhost-user/libvhost-user.h |  91 +++++++++
 10 files changed, 614 insertions(+), 5 deletions(-)

-- 
2.45.2


