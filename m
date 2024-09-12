Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37F5CEED611
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 14:54:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1solCq-0000mJ-Bt; Thu, 12 Sep 2024 10:54:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1solCo-0000lH-BX
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 10:53:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1solCm-0000Gw-RB
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 10:53:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726152835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=J+R1uDfUWdPfJGfh1CVnssbVDLYqht9mPRJhakeXkfw=;
 b=TY7dU9REmXAjJKQ8bDDn49bZxT1JuFXiftuAwgHDzA0sbbjZpbgWHo5Dwv79wZrRL3dwaW
 VBerAuiFRHlW65ieg95kEtMgN0ZO0SdIJH/jOAbNiezJCTq7OkSKOEU7BP7IFjfopae0hh
 8+f9i8Vu1cvkg8PEDRdh9qMwxZ3xSX4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-346-aQQdPrdSMeag7LVMrg241w-1; Thu,
 12 Sep 2024 10:53:52 -0400
X-MC-Unique: aQQdPrdSMeag7LVMrg241w-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5FC9D1955F28; Thu, 12 Sep 2024 14:53:51 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.45.224.195])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9283D1956052; Thu, 12 Sep 2024 14:53:44 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, slp@redhat.com,
 hi@alyssa.is, mst@redhat.com, david@redhat.com, jasowang@redhat.com,
 stefanha@redhat.com, Stefano Garzarella <sgarzare@redhat.com>,
 stevensd@chromium.org, Albert Esteve <aesteve@redhat.com>
Subject: [PATCH v3 0/5] vhost-user: Add SHMEM_MAP/UNMAP requests
Date: Thu, 12 Sep 2024 16:53:30 +0200
Message-ID: <20240912145335.129447-1-aesteve@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

v2->v3:
- Add track for mapped memory in VIRTIO
  Shared memory regions, so that boundaries
  can be verified when a request for
  new mmap is received
- Use address_space_read/write() for
  MEM_READ/_WRITE handling methods.
- Improve/fix support for flexible
  array members for MEM_READ/_WRITE requests.
- Split documentation into a separate patch.
- Various small fixes from previous review.

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
  virtio: Track shared memory mappings
  vhost_user: Add frontend command for shmem config
  vhost-user-dev: Add cache BAR
  vhost_user: Add MEM_READ/WRITE backend requests

 hw/virtio/vhost-user-base.c               |  37 ++-
 hw/virtio/vhost-user-device-pci.c         |  39 +++-
 hw/virtio/vhost-user.c                    | 273 ++++++++++++++++++++--
 hw/virtio/virtio.c                        |  59 +++++
 include/hw/virtio/vhost-backend.h         |   6 +
 include/hw/virtio/vhost-user.h            |   1 +
 include/hw/virtio/virtio.h                |  26 +++
 subprojects/libvhost-user/libvhost-user.c | 144 ++++++++++++
 subprojects/libvhost-user/libvhost-user.h |  90 +++++++
 9 files changed, 648 insertions(+), 27 deletions(-)

-- 
2.45.2


