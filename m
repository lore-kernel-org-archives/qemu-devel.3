Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 899E9C27C43
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 15:34:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sChmh-0005z4-IH; Thu, 30 May 2024 11:33:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1sChmf-0005ye-VX
 for qemu-devel@nongnu.org; Thu, 30 May 2024 11:33:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1sChmb-0001Zi-9i
 for qemu-devel@nongnu.org; Thu, 30 May 2024 11:33:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717083215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DjJaIgNzggM01GVD68SRlnIjO212fR49g4wFNa31m6I=;
 b=BOBQylkOqzzV4DVs/eaMpUX6KJvj6rebFSmrhrCB7J8O4kt7PNSyyCdnQjjyYqQ3G2s6PJ
 loeC9p4m3gKjK+hXATGUfpy2qwSlsaCGPaN1scD2cVJ57BZJIcx/5CEjKKvT00GVRbQ749
 sgpOZrkDPQORhEHjcb8AkEoqvg/KR2Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-xC9Hwk1KOSaxUxF4HpMgLA-1; Thu, 30 May 2024 11:22:27 -0400
X-MC-Unique: xC9Hwk1KOSaxUxF4HpMgLA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 34FF8101A525
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 15:22:27 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 569452026D68;
 Thu, 30 May 2024 15:22:24 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, slp@redhat.com, stefanha@redhat.com, jasowang@redhat.com,
 Albert Esteve <aesteve@redhat.com>
Subject: [RFC PATCH 0/1] vhost-user: Add SHMEM_MAP/UNMAP requests
Date: Thu, 30 May 2024 17:22:22 +0200
Message-ID: <20240530152223.780232-1-aesteve@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This is an early attempt to have backends
support dynamic fd mapping into shared
memory regions. As such, there are a few
things that need settling, so I wanted to
post this first to have some early feedback.

The usecase for this is, e.g., to support
vhost-user-gpu RESOURCE_BLOB operations,
or DAX Window request for virtio-fs. In
general, any operation where a backend
would need to mmap an fd to a shared
memory so that the guest can access it.
The request will be processed by the VMM,
that will, in turn, trigger a mmap with
the instructed parameters (i.e., shmid,
shm_offset, fd_offset, fd, lenght).

As there are already a couple devices
that could benefit of such a feature,
and more could require it in the future,
my intention was to make it generic.

To that end, I declared the shared
memory region list in `VirtIODevice`.
I could add a couple commodity
functions to add new regions to the list,
so that the devices can use them. But
I wanted to gather some feedback before
refining it further, as I am probably
missing some required steps/or security
concerns that I am not taking into account.

Albert Esteve (1):
  vhost-user: add shmem mmap request

 docs/interop/vhost-user.rst |  23 ++++++++
 hw/virtio/vhost-user.c      | 106 ++++++++++++++++++++++++++++++++++++
 hw/virtio/virtio.c          |   2 +
 include/hw/virtio/virtio.h  |   3 +
 4 files changed, 134 insertions(+)

-- 
2.44.0


