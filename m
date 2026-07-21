Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F34C4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 17:07:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmDuM-0004kv-F8; Tue, 21 Jul 2026 13:05:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wmDuK-0004kb-Pt
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 13:05:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wmDuI-00071w-8X
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 13:05:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784653524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gcIXii4aBhaergOfCax/+OzYXHSEzGYJ1YDhjJNR7jM=;
 b=IvswisSDp+xv2KOVBOtma3PPzUCuw3U+uyp3wM9/q2ejgqvuPlUO7QwSAgl0v+aM+lHwcg
 K/mx5rNFwLcfdvbHDULg+ggNA+5YuJstPV6YoeOVPlMJvE5YJMwDgAxAqkla4Z/+69LQxj
 X7/Xwnol2o1Xz+dpCxg4wR5HZXDi9sA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-222-jqrP8i_8MnylESJBjqp10A-1; Tue,
 21 Jul 2026 13:05:22 -0400
X-MC-Unique: jqrP8i_8MnylESJBjqp10A-1
X-Mimecast-MFC-AGG-ID: jqrP8i_8MnylESJBjqp10A_1784653522
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C8B9E1955F19
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 17:05:21 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.82])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B08BD1598; Tue, 21 Jul 2026 17:05:20 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 00/13] vfio queue
Date: Tue, 21 Jul 2026 19:05:05 +0200
Message-ID: <20260721170518.4160785-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: permerror client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

The following changes since commit ad14439be5731e872d8448a04664a9c0e66624a8:

  gitlab: remove gdb from MacOS jobs (2026-07-21 10:09:47 -0400)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-vfio-20260721

for you to fetch changes up to aef1e7c5ec80ee7a4484e4903c9e4c47d80535de:

  vfio-user: vfio_user_device_io_set_irqs: prevent excessive malloc (2026-07-21 18:02:47 +0200)

----------------------------------------------------------------
vfio queue:

* Fix IGD legacy VBIOS ROM to clear saved BDSM at load time, avoiding
  garbled BIOS POST output
* Clarify dma-buf failure messages for P2P DMA
* Fix config read error handling and reject invalid PCI_INTERRUPT_PIN
  values in vfio/pci
* Harden vfio-user: prevent buffer overflows, excessive mallocs, and
  fix region info capability check

----------------------------------------------------------------
Cédric Le Goater (1):
      vfio/region: Clarify dma-buf failure messages

Denis V. Lunev (2):
      vfio/pci: don't narrow a failed config read to a plausible value
      vfio/pci: reject invalid PCI_INTERRUPT_PIN values

Thanos Makatos (9):
      vfio-user: vfio_user_get_region_info: prevent buffer overflow
      vfio-user: vfio_user_get_region_info: respect max_xfer_size
      vfio-user: vfio_user_get_region_info: reject unreasonably short struct
      vfio-user: vfio_user_get_region_info: prevent excessive malloc
      vfio-user: vfio_user_device_io_get_region_info: fix capability check
      vfio-user: vfio_user_device_io_device_feature: prevent buffer overflow
      vfio-user: vfio_user_device_io_device_feature: prevent excessive malloc
      vfio-user: vfio_user_device_io_set_irqs: prevent buffer overflow
      vfio-user: vfio_user_device_io_set_irqs: prevent excessive malloc

Tomita Moeko (1):
      vfio/igd: Clear saved BDSM in legacy VBIOS ROM at load time

 hw/vfio/pci.h         |   3 ++
 hw/vfio-user/device.c |  54 ++++++++++++++++++++++--
 hw/vfio/igd-stubs.c   |   5 +++
 hw/vfio/igd.c         | 115 ++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/pci-quirks.c  |   5 +++
 hw/vfio/pci.c         |  39 ++++++++++++++---
 hw/vfio/region.c      |  11 +++--
 hw/vfio/trace-events  |   1 +
 8 files changed, 216 insertions(+), 17 deletions(-)


