Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20946C54E41
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 14:29:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfhMM-0006RQ-2U; Thu, 29 Feb 2024 09:26:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rfhMI-0006HO-EP; Thu, 29 Feb 2024 09:26:02 -0500
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rfhMG-0005c2-PM; Thu, 29 Feb 2024 09:26:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709216760; x=1740752760;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tLTUDrHSuXuCOuB1SbDv4DvjgsV//tK+czNZPOeaW6Q=;
 b=nw+JRuXMFb0Vau1TeCDvCSdFNfwlNrMd4v9JRV+psxKFptAOM/QF5cPV
 9xwqmsb5h0C2IMW81GEqNJW+yydXPaLtQMbe6t+zTvFQ/I6cxlqumsn69
 iIjnzRzUKrmjpljeQnaz9K+S+vjUX+lHmk47POFmeFMNsoalpXqVxpBlU
 PmFmwSnMvyTRfkR+LwC90vn7ceMGZc1WGD0Imu4WDaut9lI7NTGSsKXpj
 qVQCzPDiPZD6CLAb9D7+GBIYcg3tb1Y+4xLKdCM4MCrTHQmKf3IbZrdm6
 IPTQbONLd2zeUe5/HpK+DtSbL1L/8XJHhe1EQzXZ3I0Hk1mSbfJbkwSRJ Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="14322801"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; d="scan'208";a="14322801"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Feb 2024 06:25:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="7793848"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa010.fm.intel.com with ESMTP; 29 Feb 2024 06:25:55 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 09/17] hw/vfio/pci-quirks: Fix missing ERRP_GUARD() for
 error_prepend()
Date: Thu, 29 Feb 2024 22:39:06 +0800
Message-Id: <20240229143914.1977550-10-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240229143914.1977550-1-zhao1.liu@linux.intel.com>
References: <20240229143914.1977550-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.198.163.11;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

ERRP_GUARD() could avoid the case when @errp is the pointer of
error_fatal, the user can't see this additional information, because
exit() happens in error_setg earlier than information is added [1].

In hw/vfio/pci-quirks.c, there're 2 functions passing @errp to
error_prepend() without ERRP_GUARD():
- vfio_add_nv_gpudirect_cap()
- vfio_add_vmd_shadow_cap()

Their @errp parameters are so widely sourced that it is necessary to
protect them with ERRP_GUARD().

To avoid the issue like [1] said, add missing ERRP_GUARD() at the
beginning of this function.

[1]: Issue description in the commit message of commit ae7c80a7bd73
     ("error: New macro ERRP_GUARD()").

Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: "Cédric Le Goater" <clg@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/vfio/pci-quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index 84b1a7b9485c..496fd1ee86bd 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -1538,6 +1538,7 @@ static bool is_valid_std_cap_offset(uint8_t pos)
 
 static int vfio_add_nv_gpudirect_cap(VFIOPCIDevice *vdev, Error **errp)
 {
+    ERRP_GUARD();
     PCIDevice *pdev = &vdev->pdev;
     int ret, pos;
     bool c8_conflict = false, d4_conflict = false;
@@ -1630,6 +1631,7 @@ static int vfio_add_nv_gpudirect_cap(VFIOPCIDevice *vdev, Error **errp)
 #define VMD_SHADOW_CAP_LEN 24
 static int vfio_add_vmd_shadow_cap(VFIOPCIDevice *vdev, Error **errp)
 {
+    ERRP_GUARD();
     uint8_t membar_phys[16];
     int ret, pos = 0xE8;
 
-- 
2.34.1


