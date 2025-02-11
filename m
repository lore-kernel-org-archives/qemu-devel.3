Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5954DC021A0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 14:35:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thrKm-0006Qi-F7; Tue, 11 Feb 2025 09:33:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1thrKl-0006QF-Ez
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 09:33:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1thrKj-0001rp-B1
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 09:33:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739284430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tJGZpw8AvCCxQVPgZI5VaVfATDGJSZGpUrOw3exR24A=;
 b=XHwa3uujpnMIdbEJdAfBOB5JCoadyYAuPn5B2BCbsFW+JtYGfAz5D6jJTqIy0gbaHJ8Lnh
 YwXKHfVvLaboK+lmDC2Bd5mTIA1lB/1YL6HbrCRqtXIRgNxTca+n/twxJOofQ+9xivri3p
 GmWQdKPst6AwG9LbceTJwLSUhyBnUmE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-227-37WzBITyMeuxRSpNLqvRmw-1; Tue,
 11 Feb 2025 09:33:48 -0500
X-MC-Unique: 37WzBITyMeuxRSpNLqvRmw-1
X-Mimecast-MFC-AGG-ID: 37WzBITyMeuxRSpNLqvRmw
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9B1FC180056F
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 14:33:47 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.39])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 45ED11800873; Tue, 11 Feb 2025 14:33:45 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 00/12] vfio queue
Date: Tue, 11 Feb 2025 15:33:28 +0100
Message-ID: <20250211143340.787996-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
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

The following changes since commit ffaf7f0376f8040ce9068d71ae9ae8722505c42e:

  Merge tag 'pull-10.0-testing-and-gdstub-updates-100225-1' of https://gitlab.com/stsquad/qemu into staging (2025-02-10 13:26:17 -0500)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-vfio-20250211

for you to fetch changes up to be7d8579eb5758c0edf81eb068017a56471a77e0:

  vfio: Remove superfluous error report in vfio_listener_region_add() (2025-02-11 14:15:19 +0100)

----------------------------------------------------------------
vfio queue:

* Coverity fix
* IGD cleanups using VFIOQuirk
* SIGSEV fix in IOMMUFD host IOMMU device
* Improved error reporting for MMIO region mapping failures

----------------------------------------------------------------
Cédric Le Goater (8):
      vfio/igd: Fix potential overflow in igd_gtt_memory_size()
      util/error: Introduce warn_report_err_once()
      vfio/pci: Replace "iommu_device" by "vIOMMU"
      vfio: Rephrase comment in vfio_listener_region_add() error path
      vfio: Introduce vfio_get_vfio_device()
      vfio: Improve error reporting when MMIO region mapping fails
      vfio: Remove reports of DMA mapping errors in backends
      vfio: Remove superfluous error report in vfio_listener_region_add()

Tomita Moeko (3):
      vfio/pci: declare generic quirks in a new header file
      vfio/pci: introduce config_offset field in VFIOConfigMirrorQuirk
      vfio/igd: use VFIOConfigMirrorQuirk for mirrored registers

Zhenzhong Duan (1):
      vfio/iommufd: Fix SIGSEV in iommufd_cdev_attach()

 hw/vfio/pci-quirks.h          |  72 ++++++++++++++++++++++++
 include/hw/vfio/vfio-common.h |   1 +
 include/qapi/error.h          |  12 ++++
 backends/iommufd.c            |   3 -
 hw/vfio/common.c              |  40 +++++++++----
 hw/vfio/container.c           |   2 -
 hw/vfio/helpers.c             |  10 ++++
 hw/vfio/igd.c                 | 127 +++++++++++-------------------------------
 hw/vfio/iommufd.c             |   5 +-
 hw/vfio/pci-quirks.c          |  57 ++-----------------
 hw/vfio/pci.c                 |   2 +-
 util/error.c                  |  11 ++++
 12 files changed, 177 insertions(+), 165 deletions(-)
 create mode 100644 hw/vfio/pci-quirks.h


