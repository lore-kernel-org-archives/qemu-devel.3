Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73DD7C71136
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 18:27:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPQ9x-0001h0-4D; Wed, 11 Jun 2025 14:26:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uPQ9l-0001WY-Gt
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 14:26:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uPQ9b-0001FW-PV
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 14:26:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749666359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mkg1+W8RvAcUUgL/WOeKMGXWZeEOTEr6LlHLyMUvJ7w=;
 b=aZIMkkU0lMu6d1rNYaf339Ym8RsbMbvi19Ge0okeGlHRsNBAiGQOpltk5RTdldPG0f9A9j
 4o7GhROj/PJwA1VmfhDOnyxX5DHJpPQ5w27NMsRGHCaRsMcmEAM1TwpJxabAL8XX4AU0HW
 D/NMUCGwU0E1BmemEIHuRHeGntoxhsY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-502-K1nQ5IFnPbKDwG6aJtt7cw-1; Wed,
 11 Jun 2025 14:25:56 -0400
X-MC-Unique: K1nQ5IFnPbKDwG6aJtt7cw-1
X-Mimecast-MFC-AGG-ID: K1nQ5IFnPbKDwG6aJtt7cw_1749666352
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D6DE818002ED; Wed, 11 Jun 2025 18:25:48 +0000 (UTC)
Received: from localhost (unknown [10.2.16.122])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BA72619560AF; Wed, 11 Jun 2025 18:25:34 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 qemu-block@nongnu.org, Jesper Devantier <foss@defmacro.it>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Troy Lee <leetroy@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-trivial@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Fam Zheng <fam@euphon.net>, Sven Schnelle <svens@stackframe.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Joel Stanley <joel@jms.id.au>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org,
 Hannes Reinecke <hare@suse.com>, Klaus Jensen <its@irrelevant.dk>,
 Jeuk Kim <jeuk20.kim@samsung.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Rob Herring <robh@kernel.org>, Steven Lee <steven_lee@aspeedtech.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 00/31] Block patches
Date: Wed, 11 Jun 2025 14:25:02 -0400
Message-ID: <20250611182533.200590-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The following changes since commit bc98ffdc7577e55ab8373c579c28fe24d600c40f:

  Merge tag 'pull-10.1-maintainer-may-2025-070625-1' of https://gitlab.com/stsquad/qemu into staging (2025-06-07 15:08:55 -0400)

are available in the Git repository at:

  https://gitlab.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to dc0dfd00f428f7aed17ce2fd01a156186d5f76a3:

  net/stream: skip automatic zero-init of large array (2025-06-11 14:20:10 -0400)

----------------------------------------------------------------
Pull request

----------------------------------------------------------------

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

 include/qemu/compiler.h    | 20 ++++++++++++++++++++
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
 net/socket.c               |  2 +-
 net/stream.c               |  2 +-
 31 files changed, 61 insertions(+), 44 deletions(-)

-- 
2.49.0


