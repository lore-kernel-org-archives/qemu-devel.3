Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABE42C021B2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 22:50:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlFMY-0000WH-IB; Thu, 20 Feb 2025 17:49:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tlFMW-0000Vr-H4
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 17:49:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tlFMU-0007gy-Uq
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 17:49:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740091780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=rMaUBJ8pOH1XgnG3SraC+c6XRu4GO4ioMNCxqR+800M=;
 b=DM1kHPDmVHGhdoN4JvJEDagCOov+FW8+tckPy3Q2sUEMYcHgi1hN4CF/g9xgimmUHmthu5
 vYprIy7zU8YSxqA2v+lWTNpiHKQrvwTqAkr53TaQ+oDlw3xBkFxIb5SjMgAyB2RdXux2fy
 VPLRbxun6OIkvKUs4EqQkihb93XJ3bo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-79-4U1IKSc9Nw62fPIQ8H8Itg-1; Thu,
 20 Feb 2025 17:49:36 -0500
X-MC-Unique: 4U1IKSc9Nw62fPIQ8H8Itg-1
X-Mimecast-MFC-AGG-ID: 4U1IKSc9Nw62fPIQ8H8Itg_1740091775
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 849311800874; Thu, 20 Feb 2025 22:49:35 +0000 (UTC)
Received: from omen.home.shazbot.org (unknown [10.22.88.77])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D30331944CC4; Thu, 20 Feb 2025 22:49:32 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, eric.auger.pro@gmail.com,
 eric.auger@redhat.com, clg@redhat.com, zhenzhong.duan@intel.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com
Subject: [PATCH 0/5] PCI: Implement basic PCI PM capability backing
Date: Thu, 20 Feb 2025 15:48:53 -0700
Message-ID: <20250220224918.2520417-1-alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
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

Eric recently identified an issue[1] where during graceful shutdown
of a VM in a vIOMMU configuration, the guest driver places the device
into the D3 power state, the vIOMMU is then disabled, triggering an
AddressSpace update.  The device BARs are still mapped into the AS,
but the vfio host driver refuses to DMA map the MMIO space due to the
device power state.

The proposed solution in [1] was to skip mappings based on the
device power state.  Here we take a different approach.  The PCI spec
defines that devices in D1/2/3 power state should respond only to
configuration and message requests and all other requests should be
handled as an Unsupported Request.  In other words, the memory and
IO BARs are not accessible except when the device is in the D0 power
state.

To emulate this behavior, we can factor the device power state into
the mapping state of the device BARs.  Therefore the BAR is marked
as unmapped if either the respective command register enable bit is
clear or the device is not in the D0 power state.

In order to implement this, the PowerState field of the PMCSR
register becomes writable, which allows the device to appear in
lower power states.  This also therefore implements D3 support
(insofar as the BAR behavior) for all devices implementing the PM
capability.  The PCI spec requires D3 support.

An aspect that needs attention here is whether this change in the
wmask and PMCSR bits becomes a problem for migration, and how we
might solve it.  For a guest migrating old->new, the device would
always be in the D0 power state, but the register becomes writable.
In the opposite direction, is it possible that a device could
migrate in a low power state and be stuck there since the bits are
read-only in old QEMU?  Do we need an option for this behavior and a
machine state bump, or are there alternatives?

Thanks,
Alex

[1]https://lore.kernel.org/all/20250219175941.135390-1-eric.auger@redhat.com/

Alex Williamson (5):
  hw/pci: Basic support for PCI power management
  pci: Use PCI PM capability initializer
  vfio/pci: Delete local pm_cap
  pcie, virtio: Remove redundant pm_cap
  hw/vfio/pci: Re-order pre-reset

 hw/net/e1000e.c                 |  3 +-
 hw/net/eepro100.c               |  4 +-
 hw/net/igb.c                    |  3 +-
 hw/nvme/ctrl.c                  |  3 +-
 hw/pci-bridge/pcie_pci_bridge.c |  3 +-
 hw/pci/pci.c                    | 83 ++++++++++++++++++++++++++++++++-
 hw/pci/trace-events             |  2 +
 hw/vfio/pci.c                   | 29 ++++++------
 hw/vfio/pci.h                   |  1 -
 hw/virtio/virtio-pci.c          | 11 ++---
 include/hw/pci/pci.h            |  3 ++
 include/hw/pci/pci_device.h     |  3 ++
 include/hw/pci/pcie.h           |  2 -
 13 files changed, 112 insertions(+), 38 deletions(-)

-- 
2.48.1


