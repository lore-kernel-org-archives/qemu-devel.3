Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85466606A331
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 09:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eElnxxA+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQLKv-0002db-Db; Mon, 09 Nov 2026 04:06:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xQLKn-0002Xb-De
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 04:06:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xQLKl-0002rg-2z
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 04:06:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794215193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=dmIYvpVnV7ZGWNNgNVMbmf4KcxPrRvBtBUVwZKgxEgE=;
 b=eElnxxA+YYFu1mqAIZSgnydk+4V7erJJIAXXpLv3oqyZiOFI3DtuX5cIPGj1QX+/HAJl3Z
 EWLYfcCY2CmNZILvHxGk31FWBMfeeVwoeVVgMWOjnYvsBVYwIt4XIXKGdRS1/MrseRSp2M
 kQ+JOfUuSHKoCF6JHgL/ZVhgz1QT/iQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-UScejvgqMEeVJtjJBQFwFg-1; Mon,
 09 Nov 2026 04:06:30 -0500
X-MC-Unique: UScejvgqMEeVJtjJBQFwFg-1
X-Mimecast-MFC-AGG-ID: UScejvgqMEeVJtjJBQFwFg_1794215189
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 22D69180054D; Mon,  9 Nov 2026 09:06:29 +0000 (UTC)
Received: from circe.redhat.com (unknown [10.44.32.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7E42930000E5; Mon,  9 Nov 2026 09:06:27 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH for-12.0 0/9] vfio/pci: Split pci.c
Date: Mon,  9 Nov 2026 10:06:16 +0100
Message-ID: <20261109090625.908592-1-clg@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello,

hw/vfio/pci.c has grown into a large monolithic file. This series
extract interrupt handling, PCI capability setup and ROM management
into dedicated files and normalizes function names for consistency.
Other aspects, config space, BAR setup, VGA, could be addressed later.

A g_memdup deprecation fix is included as a standalone cleanup.

No functional changes.

Thanks,

C.

Cédric Le Goater (9):
  vfio/pci: Extract interrupt handling into pci-irq.c
  vfio/pci: Move vfio_mmap_set_enabled() to region.c
  vfio/pci: Rename IRQ functions
  vfio/pci: Replace deprecated g_memdup() with g_memdup2()
  vfio/pci: Extract PCI capability setup into pci-caps.c
  vfio/pci: Rename capability functions
  vfio/pci: Rename vfio_sub_page_bar_update_mappings() function
  vfio/pci: Extract ROM handling into pci-rom.c
  vfio/pci: Rename vfio_opt_rom_in_denylist() to
    vfio_quirk_rom_in_denylist()

 hw/vfio/pci.h         |   46 +-
 hw/vfio/vfio-region.h |    4 +-
 hw/vfio-user/pci.c    |    4 +-
 hw/vfio/cpr.c         |    4 +-
 hw/vfio/pci-caps.c    |  730 ++++++++++
 hw/vfio/pci-irq.c     | 1630 +++++++++++++++++++++
 hw/vfio/pci-quirks.c  |    2 +-
 hw/vfio/pci-rom.c     |  239 ++++
 hw/vfio/pci.c         | 3128 ++++-------------------------------------
 hw/vfio/region.c      |   12 +-
 hw/vfio/meson.build   |    3 +
 11 files changed, 2949 insertions(+), 2853 deletions(-)
 create mode 100644 hw/vfio/pci-caps.c
 create mode 100644 hw/vfio/pci-irq.c
 create mode 100644 hw/vfio/pci-rom.c

-- 
2.56.0


