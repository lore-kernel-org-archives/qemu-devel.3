Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85A50C7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 07:46:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUhIl-0004Mb-Oa; Thu, 26 Jun 2025 03:45:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uUhIk-0004MK-FB
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 03:45:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uUhIi-0001te-7u
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 03:45:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750923938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/Hmx7hHYO+FQFa7w8a59ububIYSGd0vgwTzGpL6L7+g=;
 b=W/CZ8FKun6QdbZUD+8EZWfnoXywaMoiXCpCbQAcCVg3Of2ZVJyxz3uO/gUbTulm8RtOY/P
 kyc5hMhmfbHfo9AY8rpZPwoO3Xtxe8Ux58gkUjMeemP0qi8yNzBdOlOZiMpVhOAS1QCRkU
 fSIC8B6vmIqBFsti9FQz1eDZRR8txtE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-WOPoPL9-PcSRnX_1eyaj3Q-1; Thu,
 26 Jun 2025 03:45:35 -0400
X-MC-Unique: WOPoPL9-PcSRnX_1eyaj3Q-1
X-Mimecast-MFC-AGG-ID: WOPoPL9-PcSRnX_1eyaj3Q_1750923934
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 48E141956086
 for <qemu-devel@nongnu.org>; Thu, 26 Jun 2025 07:45:34 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.51])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6CF0E180035C; Thu, 26 Jun 2025 07:45:32 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 00/25] vfio queue
Date: Thu, 26 Jun 2025 09:45:04 +0200
Message-ID: <20250626074529.1384114-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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

The following changes since commit f9a3def17b2a57679902c33064cf7853263db0ef:

  Merge tag 'pull-tcg-20250623' of https://gitlab.com/rth7680/qemu into staging (2025-06-24 10:38:38 -0400)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-vfio-20250626

for you to fetch changes up to da198e8f0f99cd8539f3072ad2071f9dc01680d6:

  vfio-user: introduce vfio-user protocol specification (2025-06-26 08:55:38 +0200)

----------------------------------------------------------------
vfio queue:

* Added several small fixes and cleanups
* Added support for vfio-user client device

----------------------------------------------------------------
John Levon (21):
      vfio: add vfio_device_get_region_fd()
      vfio: add documentation for posted write argument
      vfio: add license tag to some files
      vfio-user: add vfio-user class and container
      vfio-user: connect vfio proxy to remote server
      vfio-user: implement message receive infrastructure
      vfio-user: implement message send infrastructure
      vfio-user: implement VFIO_USER_DEVICE_GET_INFO
      vfio-user: implement VFIO_USER_DEVICE_GET_REGION_INFO
      vfio-user: implement VFIO_USER_REGION_READ/WRITE
      vfio-user: set up PCI in vfio_user_pci_realize()
      vfio-user: implement VFIO_USER_DEVICE_GET/SET_IRQ*
      vfio-user: forward MSI-X PBA BAR accesses to server
      vfio-user: set up container access to the proxy
      vfio-user: implement VFIO_USER_DEVICE_RESET
      vfio-user: implement VFIO_USER_DMA_MAP/UNMAP
      vfio-user: implement VFIO_USER_DMA_READ/WRITE
      vfio-user: add 'x-msg-timeout' option
      vfio-user: support posted writes
      vfio-user: add coalesced posted writes
      docs: add vfio-user documentation

Rorie Reyes (1):
      hw/vfio/ap: attribute constructor for cfg_chg_events_lock

Thanos Makatos (1):
      vfio-user: introduce vfio-user protocol specification

Zhenzhong Duan (2):
      vfio/container: Fix SIGSEGV when open container file fails
      vfio/container: fails mdev hotplug if add migration blocker failed

 MAINTAINERS                           |   11 +-
 docs/interop/index.rst                |    1 +
 docs/interop/vfio-user.rst            | 1520 +++++++++++++++++++++++++++++++++
 docs/system/device-emulation.rst      |    1 +
 docs/system/devices/vfio-user.rst     |   26 +
 meson.build                           |    1 +
 hw/vfio-user/container.h              |   23 +
 hw/vfio-user/device.h                 |   24 +
 hw/vfio-user/protocol.h               |  242 ++++++
 hw/vfio-user/proxy.h                  |  135 +++
 hw/vfio-user/trace.h                  |    4 +
 hw/vfio/pci.h                         |    1 +
 hw/vfio/trace.h                       |    3 +
 include/hw/vfio/vfio-container-base.h |    1 +
 include/hw/vfio/vfio-device.h         |   15 +
 hw/vfio-user/container.c              |  370 ++++++++
 hw/vfio-user/device.c                 |  441 ++++++++++
 hw/vfio-user/pci.c                    |  475 +++++++++++
 hw/vfio-user/proxy.c                  | 1356 +++++++++++++++++++++++++++++
 hw/vfio/ap.c                          |   12 +-
 hw/vfio/container.c                   |   12 +-
 hw/vfio/device.c                      |    7 +
 hw/vfio/region.c                      |    5 +-
 hw/Kconfig                            |    1 +
 hw/meson.build                        |    1 +
 hw/vfio-user/Kconfig                  |    7 +
 hw/vfio-user/meson.build              |   11 +
 hw/vfio-user/trace-events             |   20 +
 hw/vfio/Kconfig                       |    2 +
 hw/vfio/meson.build                   |    2 +
 hw/vfio/trace-events                  |    2 +
 31 files changed, 4717 insertions(+), 15 deletions(-)
 create mode 100644 docs/interop/vfio-user.rst
 create mode 100644 docs/system/devices/vfio-user.rst
 create mode 100644 hw/vfio-user/container.h
 create mode 100644 hw/vfio-user/device.h
 create mode 100644 hw/vfio-user/protocol.h
 create mode 100644 hw/vfio-user/proxy.h
 create mode 100644 hw/vfio-user/trace.h
 create mode 100644 hw/vfio-user/container.c
 create mode 100644 hw/vfio-user/device.c
 create mode 100644 hw/vfio-user/pci.c
 create mode 100644 hw/vfio-user/proxy.c
 create mode 100644 hw/vfio-user/Kconfig
 create mode 100644 hw/vfio-user/meson.build
 create mode 100644 hw/vfio-user/trace-events


