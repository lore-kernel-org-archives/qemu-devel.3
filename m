Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61DF3C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 08:36:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3tpo-0000Vc-07; Mon, 06 May 2024 04:36:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s3tpk-0000SZ-Vh
 for qemu-devel@nongnu.org; Mon, 06 May 2024 04:36:29 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s3tpb-0000Ph-FM
 for qemu-devel@nongnu.org; Mon, 06 May 2024 04:36:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714984579; x=1746520579;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=8gppBe4HPRasMsk5TjYJ/K6juHzs9jT5l6J3TjgHbrE=;
 b=SUOvRyQ1tG0furWpByYQkoCNwgKyZ68BUmXdv5hup/l/K3TtwFU7AgwY
 SHQjeod3W3RD06EfRZBvhlMDfKQ6hxeOHCQOA/ePo3nwPCtEA0c2j+szT
 RJ8hSfNsh3EBG5FmzJA4GZsza957qdxZoLk9HCloxn6hFdXZR/boUAFWl
 Es0Rr1Zfkph4JcOxl57QN9gVxVTdfp3dHXf7APKgNONNoz3X7fzN1oJr/
 I1bBuvrD4e6cmeDc2XXOJzNbIn3C+bmQD6s36ZCIvsgnxHi+UxZsVeJ38
 8exNZp2Ymjalh0WA9Q26f8VaU/2wiEEUvvAgWuC3JkdDFTdctnpI4E1tI Q==;
X-CSE-ConnectionGUID: JMXuwq2/T/+dSrrIHUvnwg==
X-CSE-MsgGUID: hb5inSWFRDW6R1PNYNfZHw==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="10647843"
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; d="scan'208";a="10647843"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2024 01:36:16 -0700
X-CSE-ConnectionGUID: KAA7Y+RcReaSZGrhBl7otw==
X-CSE-MsgGUID: 7PrvbfalReah5LM3S5sDlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; d="scan'208";a="28606564"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2024 01:36:14 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH 0/3] Cleanup VFIOIOMMUClass callback return with bool
Date: Mon,  6 May 2024 16:33:49 +0800
Message-Id: <20240506083352.4037226-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
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

Hi

This is a cleanup series to change VFIOIOMMUClass callbacks to return
bool when the error is passed through errp parameter.

See discussion at https://lists.gnu.org/archive/html/qemu-devel/2024-04/msg04782.html

It looks many functions in VFIO sub-system need same change,
so this can be a very first series.

Test done on x86 platform:
vfio device hotplug/unplug with different backend
reboot

Thanks
Zhenzhong

Zhenzhong Duan (3):
  vfio: Make VFIOIOMMUClass::attach_device() and its wrapper return bool
  vfio: Make VFIOIOMMUClass::setup() return bool
  vfio: Make VFIOIOMMUClass::add_window() and its wrapper return bool

 include/hw/vfio/vfio-common.h         |  4 ++--
 include/hw/vfio/vfio-container-base.h | 18 ++++++++---------
 hw/vfio/ap.c                          |  6 ++----
 hw/vfio/ccw.c                         |  6 ++----
 hw/vfio/common.c                      |  6 +++---
 hw/vfio/container-base.c              |  8 ++++----
 hw/vfio/container.c                   | 24 +++++++++++------------
 hw/vfio/iommufd.c                     | 11 +++++------
 hw/vfio/pci.c                         |  8 +++-----
 hw/vfio/platform.c                    |  7 +++----
 hw/vfio/spapr.c                       | 28 +++++++++++++--------------
 11 files changed, 58 insertions(+), 68 deletions(-)

-- 
2.34.1


