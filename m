Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39188C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 03:26:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjWHR-0005Wp-Fc; Sun, 10 Mar 2024 23:24:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rjWHP-0005W9-FV; Sun, 10 Mar 2024 23:24:47 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rjWHM-0007pt-SU; Sun, 10 Mar 2024 23:24:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710127484; x=1741663484;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=JAM6+G4yDz8y4QcV7DPPrucHLoQHW4LHLnC6OjZkHA8=;
 b=cknS6WIQKQxr873/aR/A9frsp7HlyXFL8z3P/Yw3al6nfWmIalPgwKgU
 RkC9eZIITVBz3zoMHTOs7qSqgAeM5CblCp7sy0RzfCcETg6v2dlw9y9a5
 uA0PLsyH8iFlcGqz8XRa1dGvy/ze6Mh2Kr/bXQz7O6OiI7EhIPCzxWR+r
 LylUnAsSqBduoBKfY4ZOqkBSlHXNFxfS4Op1IGTYV2r3j+Hk4/ot4jKzF
 64N8bFDzv6XNKz6nve9Zf169giXs9e0P3pN/b5BNLQ16/vU6cL+Md9Kys
 h1CRCVtjvrhvtWcQu9dHyWdgWmVXlekFH+SOpKOJOblXbjFylfi0Y94HL A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="22229571"
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; d="scan'208";a="22229571"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2024 20:24:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; d="scan'208";a="15593702"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa003.fm.intel.com with ESMTP; 10 Mar 2024 20:24:39 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 00/29] Cleanup up to fix missing ERRP_GUARD() for
 error_prepend()
Date: Mon, 11 Mar 2024 11:37:53 +0800
Message-Id: <20240311033822.3142585-1-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=198.175.65.10;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.945,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

Hi,

This series is the v2 to add missing ERRP_GUARD() for error_prepend(),
which collects the previous v1 part 1 [1] and v1 part 2 (and excludes
the 4 patches that have already been merged).

The @errp's second restriction (in qapi/error) said:

* Without ERRP_GUARD(), use of the @errp parameter is restricted:
...
* - It should not be passed to error_prepend() or
*   error_append_hint(), because that doesn't work with &error_fatal.
* ERRP_GUARD() lifts these restrictions.

With this series, all error_prepend() will follow the above usage rules.

In this series, 2 cases of error_prepend() with &error_fatal are
recognized (patch 30 & patch 31).

And there are some remaining TODOs:
* follow-up cleanup for related @err use cases. (Suggested by Thomas)
* continue to cleanup error_append_hint().


The cleanup looks very trivial and thanks for your review!

[1]: https://lore.kernel.org/qemu-devel/20240228163723.1775791-1-zhao1.liu@linux.intel.com/
[2]: https://lore.kernel.org/qemu-devel/20240229143914.1977550-1-zhao1.liu@linux.intel.com/

Thanks and Best Regards,
Zhao

---
Zhao Liu (29):
  error: Add error_vprepend() in comment of ERRP_GUARD() rules
  backends/iommufd: Fix missing ERRP_GUARD() for error_prepend()
  block: Fix missing ERRP_GUARD() for error_prepend()
  block/copy-before-write: Fix missing ERRP_GUARD() for error_prepend()
  block/nbd: Fix missing ERRP_GUARD() for error_prepend()
  block/nvme: Fix missing ERRP_GUARD() for error_prepend()
  block/qcow2-bitmap: Fix missing ERRP_GUARD() for error_prepend()
  block/qcow2: Fix missing ERRP_GUARD() for error_prepend()
  block/qed: Fix missing ERRP_GUARD() for error_prepend()
  block/snapshot: Fix missing ERRP_GUARD() for error_prepend()
  block/vdi: Fix missing ERRP_GUARD() for error_prepend()
  block/vmdk: Fix missing ERRP_GUARD() for error_prepend()
  block/virtio-blk: Fix missing ERRP_GUARD() for error_prepend()
  hw/core/loader-fit: Fix missing ERRP_GUARD() for error_prepend()
  hw/core/qdev-properties-system: Fix missing ERRP_GUARD() for
    error_prepend()
  hw/misc/ivshmem: Fix missing ERRP_GUARD() for error_prepend()
  hw/scsi/vhost-scsi: Fix missing ERRP_GUARD() for error_prepend()
  hw/vfio/ap: Fix missing ERRP_GUARD() for error_prepend()
  hw/vfio/container: Fix missing ERRP_GUARD() for error_prepend()
  hw/vfio/helpers: Fix missing ERRP_GUARD() for error_prepend()
  hw/vfio/iommufd: Fix missing ERRP_GUARD() for error_prepend()
  hw/vfio/pci-quirks: Fix missing ERRP_GUARD() for error_prepend()
  hw/vfio/pci: Fix missing ERRP_GUARD() for error_prepend()
  hw/vfio/platform: Fix missing ERRP_GUARD() for error_prepend()
  hw/virtio/vhost-vsock: Fix missing ERRP_GUARD() for error_prepend()
  hw/virtio/vhost: Fix missing ERRP_GUARD() for error_prepend()
  migration/option: Fix missing ERRP_GUARD() for error_prepend()
  net/vhost-vdpa: Fix missing ERRP_GUARD() for error_prepend()
  target/s390x/cpu_models: Fix missing ERRP_GUARD() for error_prepend()

 backends/iommufd.c               | 1 +
 block.c                          | 4 ++++
 block/copy-before-write.c        | 1 +
 block/nbd.c                      | 1 +
 block/nvme.c                     | 3 +++
 block/qcow2-bitmap.c             | 1 +
 block/qcow2.c                    | 2 ++
 block/qed.c                      | 1 +
 block/snapshot.c                 | 2 ++
 block/vdi.c                      | 1 +
 block/vmdk.c                     | 1 +
 hw/block/virtio-blk.c            | 1 +
 hw/core/loader-fit.c             | 2 ++
 hw/core/qdev-properties-system.c | 1 +
 hw/misc/ivshmem.c                | 1 +
 hw/scsi/vhost-scsi.c             | 1 +
 hw/vfio/ap.c                     | 1 +
 hw/vfio/container.c              | 1 +
 hw/vfio/helpers.c                | 3 +++
 hw/vfio/iommufd.c                | 1 +
 hw/vfio/pci-quirks.c             | 2 ++
 hw/vfio/pci.c                    | 2 ++
 hw/vfio/platform.c               | 1 +
 hw/virtio/vhost-vsock.c          | 1 +
 hw/virtio/vhost.c                | 2 ++
 include/qapi/error.h             | 2 +-
 migration/options.c              | 2 ++
 net/vhost-vdpa.c                 | 1 +
 target/s390x/cpu_models.c        | 2 ++
 29 files changed, 44 insertions(+), 1 deletion(-)

-- 
2.34.1


