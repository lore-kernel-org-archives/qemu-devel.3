Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8CE2C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 07:10:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVnBL-000226-Lo; Mon, 22 Jul 2024 03:10:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sVnBB-0001J6-2w
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 03:09:54 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sVnB9-0007xL-3I
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 03:09:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721632191; x=1753168191;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=NeJIDVpTIuRzfncqfn+jkGFgfITXfizv8oIB8dMX+As=;
 b=KbK5ctX1kQrKuD3JnGVVkw97Wbkgd2bda7K0GW5BNJn+OBVsXShUOyxu
 3cEBwircJq3Oo4FxLiMl8UrddnHyutZYS8lNrNWIEcv39zgEoEPzBdG98
 uuq7KBH3CRHZN9Jk7Vgo41mpY/XinlFcphCZeAt0q3nXzFpsq0M1+yyVd
 4oicfgjHhktpo8+isVMBqxfHzvy3zF88yHyEJoOKpFpyD9HlIMKCj9MPD
 SDYEViqSB0T7CYnB/dW6mLWf4W8QwvremDun+PBUvNe9O0Of+V60liLNr
 J6IdWwBN7enPHn8CPaD4p1jFKRZyuMMyxYs/mHSxI0Ykz/v2hh1XBbeAx w==;
X-CSE-ConnectionGUID: 8TgW5l6CQYCCgI83ZyLZlQ==
X-CSE-MsgGUID: S5Iw+DRXTvin/ghwjFWhig==
X-IronPort-AV: E=McAfee;i="6700,10204,11140"; a="19332595"
X-IronPort-AV: E=Sophos;i="6.09,227,1716274800"; d="scan'208";a="19332595"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2024 00:09:48 -0700
X-CSE-ConnectionGUID: 5hgA+VTqQ+yq6mw9gymVMg==
X-CSE-MsgGUID: PPMlodlLSTWV0xnZVVsGHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,227,1716274800"; d="scan'208";a="82808727"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2024 00:09:46 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 joao.m.martins@oracle.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH 0/2] Don't initialize HOST_IOMMU_DEVICE with mdev
Date: Mon, 22 Jul 2024 15:07:11 +0800
Message-Id: <20240722070713.1342711-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.15;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

This fixes a potential issue with mdev that fails to initialize HOST_IOMMU_DEVICE.
Reason is mdev isn't physical device and doesn't support IOMMU_GET_HW_INFO.

I thought ap/ccw are all mdev type and need a fix.

This series depends on a patch from Joao which fixes the same for vfio-pci.
See https://lists.gnu.org/archive/html/qemu-devel/2024-07/msg04612.html

Not tested due to no ap/ccw environment. But build test pass.

Thanks
Zhenzhong

Zhenzhong Duan (2):
  vfio/ap: Don't initialize HOST_IOMMU_DEVICE with mdev
  vfio/ccw: Don't initialize HOST_IOMMU_DEVICE with mdev

 hw/vfio/ap.c  | 3 +++
 hw/vfio/ccw.c | 3 +++
 2 files changed, 6 insertions(+)

-- 
2.34.1


