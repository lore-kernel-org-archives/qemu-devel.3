Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA27C54E41
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 14:26:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfhM5-0005w6-2P; Thu, 29 Feb 2024 09:25:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rfhLy-0005vL-DD; Thu, 29 Feb 2024 09:25:42 -0500
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rfhLu-0005O2-Lr; Thu, 29 Feb 2024 09:25:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709216738; x=1740752738;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=JNtIquFiPMnufpyiygWEAVgWfj54T6TYUXXsPdcksMU=;
 b=A2JBN6Ua0ytaS7n30Bfz6EiOptx6Ju86BIUCdtrom/+D+rNgJ+AuWFsR
 BhtR+5z5AutPykfQZia0wuzzImPcqs/AQrGnAAi7AI2v27gGUSxRgBRYO
 CVuGgoh7KGBlNwxKn1Cbdylkib5UotngVdzxMm3L6KbIub2XZPPuNsZt/
 2qqzGLBXfb7hv47HvZiVHgycB+TsJEeQRybrsTq9zQ03C9h4FSYMv5FR3
 hHC3J5jX6FCxXRksccxbqwUFvHKbLTOENQGAytprSNXheAm2vOdF4Q9rM
 Iq8jGHus2/+hIPKCmps+Ppe/AscELLJxsC6Gb1cmEzv/wrIL6ajSCWjow Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="14322716"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; d="scan'208";a="14322716"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Feb 2024 06:25:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="7793778"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa010.fm.intel.com with ESMTP; 29 Feb 2024 06:25:31 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 00/17 Part 2] Cleanup up to fix missing ERRP_GUARD() for
 error_prepend()
Date: Thu, 29 Feb 2024 22:38:57 +0800
Message-Id: <20240229143914.1977550-1-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.198.163.11;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SORTED_RECIPS=2.499,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

This series is the second part to add missing ERRP_GUARD() for
error_prepend(), which is based on my first part:
<20240228163723.1775791-1-zhao1.liu@linux.intel.com> [1]

The @errp's second restriction (in qapi/error) said:

* Without ERRP_GUARD(), use of the @errp parameter is restricted:
...
* - It should not be passed to error_prepend() or
*   error_append_hint(), because that doesn't work with &error_fatal.
* ERRP_GUARD() lifts these restrictions.

With this series and the part 1 [1], all error_prepend() will follow the
above usage rules.

I think it's particularly noteworthy that two cases of error_prepend()
with &error_fatal are recognized in this series (patch 14 & patch 15). 

In fact, error_append_hint() also need ERRP_GUARD(), but very
unfortunately, I realized that in most usage scenarios in QEMU, it
doesn't work with ERRP_GUARD() ;-( ... Maybe need to clean it up in the
future and add ERRP_GUARD() to error_append_hint() as well.

The cleanup looks very trivial and welcome your feedback!

[1]: https://lore.kernel.org/qemu-devel/20240228163723.1775791-1-zhao1.liu@linux.intel.com/

Thanks and Best Regards,
Zhao
---
Zhao Liu (17):
  hw/misc/ivshmem: Fix missing ERRP_GUARD() for error_prepend()
  hw/net/xen_nic: Fix missing ERRP_GUARD() for error_prepend()
  hw/remote/remote-obj: hw/misc/ivshmem: Fix missing ERRP_GUARD() for
    error_prepend()
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
  target/i386/sev: Fix missing ERRP_GUARD() for error_prepend()
  target/s390x/cpu_models: Fix missing ERRP_GUARD() for error_prepend()

 hw/misc/ivshmem.c         | 1 +
 hw/net/xen_nic.c          | 1 +
 hw/remote/remote-obj.c    | 1 +
 hw/scsi/vhost-scsi.c      | 1 +
 hw/vfio/ap.c              | 1 +
 hw/vfio/container.c       | 1 +
 hw/vfio/helpers.c         | 3 +++
 hw/vfio/iommufd.c         | 1 +
 hw/vfio/pci-quirks.c      | 2 ++
 hw/vfio/pci.c             | 2 ++
 hw/vfio/platform.c        | 1 +
 hw/virtio/vhost-vsock.c   | 1 +
 hw/virtio/vhost.c         | 2 ++
 migration/options.c       | 2 ++
 net/vhost-vdpa.c          | 1 +
 target/i386/sev.c         | 1 +
 target/s390x/cpu_models.c | 2 ++
 17 files changed, 24 insertions(+)

-- 
2.34.1


