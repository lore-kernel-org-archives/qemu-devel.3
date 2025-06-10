Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D04DC5B543
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 12:37:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOyEP-00013M-0l; Tue, 10 Jun 2025 08:37:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uOyED-0000ul-RE
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:37:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uOyEB-0000KE-Gg
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:37:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749559038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LDYPUrZSM041r5zd1SLFuOFkjonSaCmdUDJKl2tDGvQ=;
 b=UxvUcGzcg82Se6coR3Nmv2FAKo3tFzZV+MdftZqcv+K04eFn+StoLxY/CSQHk5BHuBJMgK
 cVjDpBK3pMQeB7gJzIU7HPMH0Yl3kRuvAklGmw6ejHr79jlfnGr4yxw74Omudd7ZOICG2t
 +nw3TYS1AL2B4nSqMneeegQMISAmjxg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-222-Lj50koWQP6O-3mh6GQwAHw-1; Tue,
 10 Jun 2025 08:37:14 -0400
X-MC-Unique: Lj50koWQP6O-3mh6GQwAHw-1
X-Mimecast-MFC-AGG-ID: Lj50koWQP6O-3mh6GQwAHw_1749559033
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 703311808993; Tue, 10 Jun 2025 12:37:13 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.87])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F301E30001B1; Tue, 10 Jun 2025 12:37:10 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 00/31] Skip automatic zero-init of large arrays / structs in
 I/O paths
Date: Tue, 10 Jun 2025 13:36:38 +0100
Message-ID: <20250610123709.835102-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This series is an extension of Stefan's proposal:

  https://lists.nongnu.org/archive/html/qemu-devel/2025-06/msg00736.html

It used '-Wframe-larger-than=4096' to identify all code locations
with more than 4k on the stack. Any locations in the I/O paths
were chosen to avoid automatic zero-init, to eliminate the performance
overhead of the automatic initialization.

Note, although all the changed locations are I/O paths, this does not
imply that the changes make a measurement performance difference in
every case.

This is because many of the emulated devices are likely limited by the
emulation impl, rather than any implicit memory zero'ing overhead of
stack data.

None the less the memory zero'ing is still a redundant CPU burn in
all these cases, so I felt it worth setting the general precedent
that any data over 4k on a stack in a device I/O path should be
skipping zero-init.

I did reasonable review in each case to identify that the data was
indeed initialized explicitly later in the method.

Daniel P. Berrangé (29):
  block: skip automatic zero-init of large array in ioq_submit
  chardev/char-fd: skip automatic zero-init of large array
  chardev/char-pty: skip automatic zero-init of large array
  chardev/char-socket: skip automatic zero-init of large array
  hw/audio/ac97: skip automatic zero-init of large arrays
  hw/audio/cs4231a: skip automatic zero-init of large arrays
  hw/audio/es1370: skip automatic zero-init of large array
  hw/audio/gus: skip automatic zero-init of large array
  hw/audio/gus: skip automatic zero-init of large array
  hw/audio/sb16: skip automatic zero-init of large array
  hw/audio/via-ac97: skip automatic zero-init of large array
  hw/char/sclpconsole-lm: skip automatic zero-init of large array
  hw/dma/xlnx_csu_dma: skip automatic zero-init of large array
  hw/display/vmware_vga: skip automatic zero-init of large struct
  hw/hyperv/syndbg: skip automatic zero-init of large array
  hw/misc/aspeed_hace: skip automatic zero-init of large array
  hw/net/rtl8139: skip automatic zero-init of large array
  hw/net/tulip: skip automatic zero-init of large array
  hw/net/virtio-net: skip automatic zero-init of large arrays
  hw/net/xgamc: skip automatic zero-init of large array
  hw/nvme/ctrl: skip automatic zero-init of large arrays
  hw/ppc/pnv_occ: skip automatic zero-init of large struct
  hw/ppc/spapr_tpm_proxy: skip automatic zero-init of large arrays
  hw/usb/hcd-ohci: skip automatic zero-init of large array
  hw/scsi/lsi53c895a: skip automatic zero-init of large array
  hw/scsi/megasas: skip automatic zero-init of large arrays
  hw/ufs/lu: skip automatic zero-init of large array
  net/socket: skip automatic zero-init of large array
  net/stream: skip automatic zero-init of large array

Stefan Hajnoczi (2):
  include/qemu/compiler: add QEMU_UNINITIALIZED attribute macro
  hw/virtio/virtio: avoid cost of -ftrivial-auto-var-init in hot path

 block/linux-aio.c          |  2 +-
 chardev/char-fd.c          |  2 +-
 chardev/char-pty.c         |  2 +-
 chardev/char-socket.c      |  2 +-
 hw/audio/ac97.c            |  4 ++--
 hw/audio/cs4231a.c         |  4 ++--
 hw/audio/es1370.c          |  2 +-
 hw/audio/gus.c             |  2 +-
 hw/audio/marvell_88w8618.c |  2 +-
 hw/audio/sb16.c            |  2 +-
 hw/audio/via-ac97.c        |  2 +-
 hw/char/sclpconsole-lm.c   |  2 +-
 hw/display/vmware_vga.c    |  2 +-
 hw/dma/xlnx_csu_dma.c      |  2 +-
 hw/hyperv/syndbg.c         |  2 +-
 hw/misc/aspeed_hace.c      |  2 +-
 hw/net/rtl8139.c           |  2 +-
 hw/net/tulip.c             |  2 +-
 hw/net/virtio-net.c        |  6 +++---
 hw/net/xgmac.c             |  2 +-
 hw/nvme/ctrl.c             |  6 +++---
 hw/ppc/pnv_occ.c           |  2 +-
 hw/ppc/spapr_tpm_proxy.c   |  4 ++--
 hw/scsi/lsi53c895a.c       |  2 +-
 hw/scsi/megasas.c          |  7 ++-----
 hw/ufs/lu.c                |  2 +-
 hw/usb/hcd-ohci.c          |  2 +-
 hw/virtio/virtio.c         |  8 ++++----
 include/qemu/compiler.h    | 20 ++++++++++++++++++++
 net/socket.c               |  2 +-
 net/stream.c               |  2 +-
 31 files changed, 61 insertions(+), 44 deletions(-)

-- 
2.49.0


