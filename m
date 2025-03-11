Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E7D9C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 18:14:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts46s-0006Up-97; Tue, 11 Mar 2025 14:13:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ts46n-0006Ti-38
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 14:13:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ts46k-0006bg-3P
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 14:13:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741716815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=G3/BODQIzbQ8QOAIfUX0T8WMm247CUNQgAWw776qpVg=;
 b=AP2aQsUjCTR0GTI36j0a4C4SRh5XiF7Dfdy5vQE/1Hwuvj8I+9Xr7KuvBXO3ZfwVfERyI0
 8PLNVBGM1g4omCVEK6R0AtYaUc332ZgC23DYgqL68Exq2Di9C40QwvDIoxyUE1Sfpp3yVz
 ZF/pbtsgX2hdrBnYg9wtidHk9fnZSXs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-391-hm6hqzKwM4i5xXRT8AKMSA-1; Tue,
 11 Mar 2025 14:13:34 -0400
X-MC-Unique: hm6hqzKwM4i5xXRT8AKMSA-1
X-Mimecast-MFC-AGG-ID: hm6hqzKwM4i5xXRT8AKMSA_1741716814
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 201ED180AB1C
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 18:13:33 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9A7C318001EF; Tue, 11 Mar 2025 18:13:31 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 00/21] vfio queue
Date: Tue, 11 Mar 2025 19:13:07 +0100
Message-ID: <20250311181328.1200431-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The following changes since commit 825b96dbcee23d134b691fc75618b59c5f53da32:

  Merge tag 'migration-20250310-pull-request' of https://gitlab.com/farosas/qemu into staging (2025-03-11 09:32:07 +0800)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-vfio-20250311

for you to fetch changes up to 4d9607481560e6c8e1508a0aafe94f86a0503c8c:

  vfio/pci: Drop debug commentary from x-device-dirty-page-tracking (2025-03-11 19:04:58 +0100)

----------------------------------------------------------------
vfio queue:

* Fixed endianness of VFIO device state packets
* Improved IGD passthrough support with legacy mode
* Improved build
* Added support for old AMD GPUs (x550)
* Updated property documentation

----------------------------------------------------------------
Joao Martins (1):
      vfio/pci: Drop debug commentary from x-device-dirty-page-tracking

Maciej S. Szmigiero (1):
      vfio/migration: Use BE byte order for device state wire packets

Philippe Mathieu-Daudé (8):
      system: Declare qemu_[min/max]rampagesize() in 'system/hostmem.h'
      hw/vfio/spapr: Do not include <linux/kvm.h>
      hw/vfio/common: Include missing 'system/tcg.h' header
      hw/vfio/common: Get target page size using runtime helpers
      hw/vfio: Compile some common objects once
      hw/vfio: Compile more objects once
      hw/vfio: Compile iommufd.c once
      hw/vfio: Compile display.c once

Tomita Moeko (10):
      vfio/igd: Remove GTT write quirk in IO BAR 4
      vfio/igd: Do not include GTT stolen size in etc/igd-bdsm-size
      vfio/igd: Consolidate OpRegion initialization into a single function
      vfio/igd: Move LPC bridge initialization to a separate function
      vfio/pci: Add placeholder for device-specific config space quirks
      vfio/igd: Refactor vfio_probe_igd_bar4_quirk into pci config quirk
      vfio/igd: Decouple common quirks from legacy mode
      vfio/igd: Handle x-igd-opregion option in config quirk
      vfio/igd: Introduce x-igd-lpc option for LPC bridge ID quirk
      vfio/igd: Fix broken KVMGT OpRegion support

Vasilis Liaskovitis (1):
      vfio/pci-quirks: Exclude non-ioport BAR from ATI quirk

 hw/vfio/pci.h               |  11 +-
 include/exec/ram_addr.h     |   3 -
 include/system/hostmem.h    |   3 +
 hw/ppc/spapr_caps.c         |   1 +
 hw/s390x/s390-virtio-ccw.c  |   1 +
 hw/vfio/common.c            |   9 +-
 hw/vfio/igd.c               | 529 +++++++++++++++++++-------------------------
 hw/vfio/iommufd.c           |   1 -
 hw/vfio/migration-multifd.c |  15 +-
 hw/vfio/migration.c         |   1 -
 hw/vfio/pci-quirks.c        |  53 +----
 hw/vfio/pci.c               |  35 +--
 hw/vfio/spapr.c             |   4 +-
 hw/vfio/meson.build         |  27 ++-
 14 files changed, 288 insertions(+), 405 deletions(-)


