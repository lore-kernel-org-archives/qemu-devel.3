Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7482DCCF9E1
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 12:19:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBXo1-0000yg-Lm; Wed, 22 Oct 2025 08:19:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vBXny-0000yR-Ka
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:19:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vBXnt-00071K-OY
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:19:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761135532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0FK+knJZayxg7BS7fbMe+D61WT87hhNpRhM5eVAqDYE=;
 b=X6YlvR+ptQVlwjufC5t6ML4I8K5jdcHT1x5rZdi8wTuDd6OAo4dEZS6nkarb2bFUxAvQKj
 LjyXAMA3Zstfbg/sisj4drsoCcU6cItl/MpEopm9Z0z560XQWgskxroGZIEibDWfGXwVGO
 Em+pIw6wgFX4g+IGGdq3qoJZ3eivlO4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-352-qtgLBfoTNi-S2xNL1343ww-1; Wed,
 22 Oct 2025 08:18:51 -0400
X-MC-Unique: qtgLBfoTNi-S2xNL1343ww-1
X-Mimecast-MFC-AGG-ID: qtgLBfoTNi-S2xNL1343ww_1761135530
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 60966195422F
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 12:18:50 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.12])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 80340180044F; Wed, 22 Oct 2025 12:18:48 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 00/12] vfio queue
Date: Wed, 22 Oct 2025 14:18:34 +0200
Message-ID: <20251022121846.874152-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 3c0b42c68f98fb276fa248012642be8cbf2cab70:

  Merge tag 'pull-request-2025-10-21' of https://gitlab.com/thuth/qemu into staging (2025-10-21 08:59:35 -0500)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-vfio-20251022

for you to fetch changes up to ecbe424a63c9f860a901d6a4a75724b046abd796:

  vfio: only check region info cache for initial regions (2025-10-22 08:12:52 +0200)

----------------------------------------------------------------
vfio queue:

* Fix CPR transfer
* Add support for VFIO_DMA_UNMAP_FLAG_ALL
* Fix vfio-user documentation
* Update Alex Williamson's email address
* Fix for vfio-region cache for the vGPU use case

----------------------------------------------------------------
Alex Williamson (1):
      MAINTAINERS: Update Alex Williamson's email address

John Levon (3):
      docs/system/devices/vfio-user: fix formatting
      vfio: rename field to "num_initial_regions"
      vfio: only check region info cache for initial regions

Zhenzhong Duan (8):
      vfio/container: Remap only populated parts in a section
      vfio/cpr-legacy: drop an erroneous assert
      vfio/iommufd: Set cpr.ioas_id on source side for CPR transfer
      vfio/iommufd: Restore vbasedev's reference to hwpt after CPR transfer
      accel/kvm: Fix an erroneous check on coalesced_mmio_ring
      vfio/container: Support unmap all in one ioctl()
      vfio/iommufd: Support unmap all in one ioctl()
      vfio/listener: Add an assertion for unmap_all

 MAINTAINERS                             |  4 ++--
 docs/system/devices/vfio-user.rst       |  2 +-
 include/hw/vfio/vfio-container-legacy.h |  1 +
 include/hw/vfio/vfio-cpr.h              |  2 +-
 include/hw/vfio/vfio-device.h           |  2 +-
 accel/kvm/kvm-all.c                     |  3 ++-
 hw/vfio-user/device.c                   |  2 +-
 hw/vfio/ccw.c                           |  4 ++--
 hw/vfio/container-legacy.c              | 38 ++++++++++++++++++--------------
 hw/vfio/cpr-legacy.c                    | 22 +++++++++++++------
 hw/vfio/device.c                        | 39 +++++++++++++++++++++------------
 hw/vfio/iommufd.c                       | 26 ++++++----------------
 hw/vfio/listener.c                      |  5 +++--
 hw/vfio/pci.c                           |  4 ++--
 .mailmap                                |  1 +
 15 files changed, 86 insertions(+), 69 deletions(-)


