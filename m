Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD9ACC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 16:27:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfMis-0003sE-Rp; Wed, 28 Feb 2024 11:23:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rfMiq-0003qi-6y; Wed, 28 Feb 2024 11:23:56 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rfMin-0000kQ-7Q; Wed, 28 Feb 2024 11:23:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709137434; x=1740673434;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=0uVgekxIK5wyboVzgu8net2AZrmTW1lYWRw7Vo7AvW0=;
 b=YJ54xnCp83m4WjsPehBYNOL6YqnpMx0JiPLcRxnww8N2tFtAgUiWUngQ
 pyfM3llS91X0uMkYo4Ykptntg9GDVxXXcxLSeYFbSlqXVYl5L82tefkex
 /sv7yK0QGQDQyF55SW6UyBQjHA+b3QBDA5ZDz+3yW3+qcZe22sCMMq8tq
 Okjpo1HcWo7m4iLhQivO5icyYMZCOkYUSdFFu7xLYXLHgNN+dsJA18HLy
 GWTVnVRiKX1ZLlts0fvETtlT//Eeyz+bPHmTNEybw6I9pnUSyAAG1z75j
 ds7vlSSdvUCaoEvIlMif0HLRcR7yuWPVjRVYo5R/u+6s3PRi6WA9TyTNr w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="28982401"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; d="scan'208";a="28982401"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2024 08:23:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; d="scan'208";a="12144783"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa004.jf.intel.com with ESMTP; 28 Feb 2024 08:23:45 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 00/16 Part 1] Cleanup up to fix missing ERRP_GUARD() for
 error_prepend()
Date: Thu, 29 Feb 2024 00:37:07 +0800
Message-Id: <20240228163723.1775791-1-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.198.163.7;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H2=-0.001,
 SORTED_RECIPS=2.499, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Hi list,

This series is the follow-up of my previous @errp related patch set
[1].

The @errp's second restriction (in qapi/error) said:

* Without ERRP_GUARD(), use of the @errp parameter is restricted:
...
* - It should not be passed to error_prepend() or
*   error_append_hint(), because that doesn't work with &error_fatal.
* ERRP_GUARD() lifts these restrictions.

With this requirement, there are many places where ERRP_GUARD() needs to
be added, especially places where there is no way to ensure that the
incoming @errp is pointing to @errp_fatal or not.

To make review easier (and to make sure I'm doing the right thing), I
just post the first part here.

Welcome your feedback!

[1]: https://lore.kernel.org/qemu-devel/20240223085653.1255438-1-zhao1.liu@linux.intel.com/

Thanks and Best Regards,
Zhao
---
Zhao Liu (16):
  error: Add error_vprepend() in comment of ERRP_GUARD() rules
  backends/iommufd: Fix missing ERRP_GUARD() for error_prepend()
  block: Fix missing ERRP_GUARD() for error_prepend()
  block/cbw: Fix missing ERRP_GUARD() for error_prepend()
  block/nbd: Fix missing ERRP_GUARD() for error_prepend()
  block/nvme: Fix missing ERRP_GUARD() for error_prepend()
  block/qcow2-bitmap: Fix missing ERRP_GUARD() for error_prepend()
  block/qcow2: Fix missing ERRP_GUARD() for error_prepend()
  block/qed: Fix missing ERRP_GUARD() for error_prepend()
  block/snapshot: Fix missing ERRP_GUARD() for error_prepend()
  block/vdi: Fix missing ERRP_GUARD() for error_prepend()
  block/vmdk: Fix missing ERRP_GUARD() for error_prepend()
  block/virtio-blk: Fix missing ERRP_GUARD() for error_prepend()
  hw/char/xen_console: Fix missing ERRP_GUARD() for error_prepend()
  hw/core/loader-fit: Fix missing ERRP_GUARD() for error_prepend()
  hw/core/qdev-properties-system: Fix missing ERRP_GUARD() for
    error_prepend()

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
 hw/char/xen_console.c            | 1 +
 hw/core/loader-fit.c             | 2 ++
 hw/core/qdev-properties-system.c | 1 +
 include/qapi/error.h             | 2 +-
 16 files changed, 24 insertions(+), 1 deletion(-)

-- 
2.34.1


