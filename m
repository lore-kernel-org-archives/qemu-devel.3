Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21FC2C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 03:28:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjWJJ-0001uj-Jj; Sun, 10 Mar 2024 23:26:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rjWJH-0001g5-53; Sun, 10 Mar 2024 23:26:43 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rjWJE-00084P-ET; Sun, 10 Mar 2024 23:26:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710127600; x=1741663600;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DRmA9H8ISXlVE6l62evXpMS/+COxZZyFF9roexvNfSY=;
 b=E0ssjBz69Hhcx/d5ethT5xS0qiH2vSSb5d36nUkLXApFLMyKOKtWS62l
 bZRwV0Cojzeh8hzlmtREyqpXPGNgBR7a5zesqGsN7A6LwxhRLiQa9WlKB
 ekocKweJlqlmdEy1lsTLeSXqDARILagU0ja9wWGrp+ZYiBwsclPbInHW3
 RP3zt2as6MDnX72bBj5kCN1wVho5I/RwxSQmIbLvOMyyBvoLryV3Qzh5P
 BgiNcM9vNYXHP/gORd/p363shll8pEA7WOP8gcNpEf8fGKd9bCNC2N264
 1f8tqzHbR0TMU4PZK6SoP6OOt5rlCyVT+kqxzRSum5K4F/MLTuML8bTO9 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="22229826"
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; d="scan'208";a="22229826"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2024 20:25:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; d="scan'208";a="15594064"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa003.fm.intel.com with ESMTP; 10 Mar 2024 20:25:49 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 23/29] hw/vfio/pci: Fix missing ERRP_GUARD() for
 error_prepend()
Date: Mon, 11 Mar 2024 11:38:16 +0800
Message-Id: <20240311033822.3142585-24-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311033822.3142585-1-zhao1.liu@linux.intel.com>
References: <20240311033822.3142585-1-zhao1.liu@linux.intel.com>
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

As the comment in qapi/error, passing @errp to error_prepend() requires
ERRP_GUARD():

* = Why, when and how to use ERRP_GUARD() =
*
* Without ERRP_GUARD(), use of the @errp parameter is restricted:
...
* - It should not be passed to error_prepend(), error_vprepend() or
*   error_append_hint(), because that doesn't work with &error_fatal.
* ERRP_GUARD() lifts these restrictions.
*
* To use ERRP_GUARD(), add it right at the beginning of the function.
* @errp can then be used without worrying about the argument being
* NULL or &error_fatal.

ERRP_GUARD() could avoid the case when @errp is &error_fatal, the user
can't see this additional information, because exit() happens in
error_setg earlier than information is added [1].

In hw/vfio/pci.c, there are 2 functions passing @errp to error_prepend()
without ERRP_GUARD():
- vfio_add_std_cap()
- vfio_realize()

The @errp of vfio_add_std_cap() is also from vfio_realize(). And
vfio_realize(), as a PCIDeviceClass.realize method, its @errp is from
DeviceClass.realize so that there is no guarantee that the @errp won't
point to @error_fatal.

To avoid the issue like [1] said, add missing ERRP_GUARD() at their
beginning.

[1]: Issue description in the commit message of commit ae7c80a7bd73
     ("error: New macro ERRP_GUARD()").

Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: "Cédric Le Goater" <clg@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index a1522a011aa5..64780d1b7933 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2136,6 +2136,7 @@ static void vfio_check_af_flr(VFIOPCIDevice *vdev, uint8_t pos)
 
 static int vfio_add_std_cap(VFIOPCIDevice *vdev, uint8_t pos, Error **errp)
 {
+    ERRP_GUARD();
     PCIDevice *pdev = &vdev->pdev;
     uint8_t cap_id, next, size;
     int ret;
@@ -2942,6 +2943,7 @@ static void vfio_unregister_req_notifier(VFIOPCIDevice *vdev)
 
 static void vfio_realize(PCIDevice *pdev, Error **errp)
 {
+    ERRP_GUARD();
     VFIOPCIDevice *vdev = VFIO_PCI(pdev);
     VFIODevice *vbasedev = &vdev->vbasedev;
     char *tmp, *subsys;
-- 
2.34.1


