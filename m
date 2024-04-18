Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0295C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 09:50:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxOPf-0002KN-L8; Thu, 18 Apr 2024 05:50:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rxOPd-0002K3-Ss
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 05:50:37 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rxOPb-0000aD-IC
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 05:50:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713433835; x=1744969835;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=dC/pKk2Cm/jov/PMMdJcnnEYPgBJhCJXragUFfUC6Cw=;
 b=Jb2jJ1ABiwsz3tdyeV90aGV3cBVPkwl/tuPixFxqLtt6xuf+ATthpMfr
 UTS1ypT/qxZjV0JT9wAloIuBsN9VZ77lW7CQF7JIdUahekcKztT3IZjHJ
 11G/N0HF4KperN56McBkDfw53bHiBDap0yjX4M+J1J0JZQGhbR5/PDBlK
 QdbJRoSlyLchWpzCUUGcNlzTc4kSmcFvz8+MbfgJa0czpBPl2UaXTB0wC
 QZXHvfRQPyOeUAhqLAl6X47CQn/WmmtSQDZ4CIGHgqPDRHaVCtKxLjpVr
 hd9/TZ8fwHOtZux+GDxHt8ls19tr9uFFf/Il4w59yGWkz9rMBEekJKstk w==;
X-CSE-ConnectionGUID: M+n7weF+TcCg2NOKxyIYsA==
X-CSE-MsgGUID: VAjEpOY1TVi3y9HgEWT88g==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="8837574"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="8837574"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Apr 2024 02:50:32 -0700
X-CSE-ConnectionGUID: DMUTFTJfR4KW0WC4TA4rpg==
X-CSE-MsgGUID: QDywlOBuSJG3G6dTQoRZTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; d="scan'208";a="27506979"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa003.fm.intel.com with ESMTP; 18 Apr 2024 02:50:30 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 0/3] hw/cxl/cxl-cdat: Make cxl_doe_cdat_init() return boolean
Date: Thu, 18 Apr 2024 18:04:30 +0800
Message-Id: <20240418100433.1085447-1-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.198.163.17;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.719,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

This series is the followup of the previous fix [1] to improve the error
handling.

As error.h suggested, the best practice for callee is to return
something to indicate success / failure instead of dereferencing @errp.

Thus make cxl_doe_cdat_init() as well as ct3_load_cdat() and
ct3_build_cdat() return boolean.

[1]: https://lore.kernel.org/qemu-devel/20240221094317.994454-1-zhao1.liu@linux.intel.com/

Thanks,
Zhao

---
Zhao Liu (3):
  hw/cxl/cxl-cdat: Make ct3_load_cdat() return boolean
  hw/cxl/cxl-cdat: Make ct3_build_cdat() return boolean
  hw/cxl/cxl-cdat: Make cxl_doe_cdat_init() return boolean

 hw/cxl/cxl-cdat.c              | 28 +++++++++++++++-------------
 hw/mem/cxl_type3.c             |  3 +--
 hw/pci-bridge/cxl_upstream.c   |  3 +--
 include/hw/cxl/cxl_component.h |  2 +-
 4 files changed, 18 insertions(+), 18 deletions(-)

-- 
2.34.1


