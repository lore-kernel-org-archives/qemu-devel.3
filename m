Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A80D5B16F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 08:45:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5hpG-00032j-I8; Tue, 29 Oct 2024 04:43:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t5hpD-00031U-Ag
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 04:43:39 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t5hpB-00083O-MW
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 04:43:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730191418; x=1761727418;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=b3ghL1kjS2+0w0jZmmgjLxWWfkCh8dYffVl5sBe8rfI=;
 b=feip1Mb2T8TEkpwLouXBY2ksVz6LobRsyTU6ar0Oe6TWVVFdWKqOEUCQ
 bcUGd3QAe9JXSwNgpnZs8Zay9BYppytBQCCUdXo7hA9W3GHCk9E5KovxZ
 xTPUT4Tcy4Cj8R+W5X65+wKkDONWxt9kfN4/P9nHNGiDu6WA5UyTMC577
 aeqwduv6TzdcuM/AVHIyS5P6RbMuUeeRfro+6bLfmsycQXIlgsmjTPCf/
 98ezze+VjTI/SuDVRt097y5G+0FE7hQPHSYT8dVuyvyDMwpv3ROrHCKEG
 GEtTxS0UtZ27S6XvSpQtCTCztwUzmCyH+hjvzUXvPijrcUVUaUdxsuYck g==;
X-CSE-ConnectionGUID: Zxq2saP5SMi2dG/CyV87Yw==
X-CSE-MsgGUID: Bwg9dMbURsC5yWR+0JjPeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29592807"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="29592807"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2024 01:43:36 -0700
X-CSE-ConnectionGUID: Gw1v7kf4RcOYYIbVXgxJOg==
X-CSE-MsgGUID: Ume+FI35ThWzhNDLcrc3Ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; d="scan'208";a="85847193"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa003.fm.intel.com with ESMTP; 29 Oct 2024 01:43:35 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 08/16] hw/usb: Replace type_register() with
 type_register_static()
Date: Tue, 29 Oct 2024 16:59:26 +0800
Message-Id: <20241029085934.2799066-9-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241029085934.2799066-1-zhao1.liu@intel.com>
References: <20241029085934.2799066-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.20; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Replace type_register() with type_register_static() because
type_register() will be deprecated.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/usb/hcd-ehci-pci.c | 2 +-
 hw/usb/hcd-uhci.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/usb/hcd-ehci-pci.c b/hw/usb/hcd-ehci-pci.c
index c94fc9f6c587..dd06451e234f 100644
--- a/hw/usb/hcd-ehci-pci.c
+++ b/hw/usb/hcd-ehci-pci.c
@@ -228,7 +228,7 @@ static void ehci_pci_register_types(void)
     for (i = 0; i < ARRAY_SIZE(ehci_pci_info); i++) {
         ehci_type_info.name = ehci_pci_info[i].name;
         ehci_type_info.class_data = ehci_pci_info + i;
-        type_register(&ehci_type_info);
+        type_register_static(&ehci_type_info);
     }
 }
 
diff --git a/hw/usb/hcd-uhci.c b/hw/usb/hcd-uhci.c
index 3d0339af7b9e..65c1f93cc9f3 100644
--- a/hw/usb/hcd-uhci.c
+++ b/hw/usb/hcd-uhci.c
@@ -1362,7 +1362,7 @@ static void uhci_register_types(void)
     for (i = 0; i < ARRAY_SIZE(uhci_info); i++) {
         uhci_type_info.name = uhci_info[i].name;
         uhci_type_info.class_data = uhci_info + i;
-        type_register(&uhci_type_info);
+        type_register_static(&uhci_type_info);
     }
 }
 
-- 
2.34.1


