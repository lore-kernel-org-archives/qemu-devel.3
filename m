Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 420DBC04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 08:33:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8ySE-0001S3-SX; Mon, 20 May 2024 04:33:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s8yQO-0001Gw-7H
 for qemu-devel@nongnu.org; Mon, 20 May 2024 04:31:17 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s8yQG-0001Bv-De
 for qemu-devel@nongnu.org; Mon, 20 May 2024 04:31:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716193868; x=1747729868;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=MgKtIJpB3SVye3ScvSQAbCwtW81zlfq0s8XLgfs+Azs=;
 b=EDdDup3bGqPC6IkuGBXI3LRucen+QLf4Bw/H1tR96O5G/Z6cSDhF4ZZe
 YaLnT7jg+cM40modyKBGIMrtScOm5yQX1C+CQTv/VPD5nmFR9iaiGy05T
 4477fGtSAMTx+haj/UhvF653Y8PWzlVimzSKlMTrPMQjlIRb+0faTI32r
 oWu0Orl+HfLrgE4bToaM5YlTX08NFm5Y26LYvCgY+7Y66iXPDgUEDKCKu
 c7y/7edz1Sq6TyJO6/CT5iyIwGOj+o09KW2+FbY0bvelASid93C3/xSxM
 6QvvYtmCxLAMkErjTVIQdUO4Q5EZ2JmZ9ISNUZGIjoOGwtywSGNRu+UDS Q==;
X-CSE-ConnectionGUID: LpL+SBtHTf2wNC+IMe06Fw==
X-CSE-MsgGUID: jXRjwhWdSPyWaV0wZzMX8g==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="12106693"
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; d="scan'208";a="12106693"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2024 01:30:38 -0700
X-CSE-ConnectionGUID: CdX5FZtXTq2+vk1JEXl+Dw==
X-CSE-MsgGUID: UnRQtTHHQqKIWlRVBT0EtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; d="scan'208";a="63683656"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2024 01:30:36 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 0/2] intel_iommu: misc fixes
Date: Mon, 20 May 2024 16:28:13 +0800
Message-Id: <20240520082815.260745-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.18;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.383,
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

Hi,

Per Yi's suggestion, we sent some trivial changes separately so that
stage-1 emulation patchset can be simpler and more focused.

Thanks
Zhenzhong

Changelog:
v2:
- update version to 3.0 (Jason, Yi)
- s/pasidt/Pasid table/ (Clement, Yi)

Yu Zhang (1):
  intel_iommu: Update version to 3.0 and add the latest fault reasons

Zhenzhong Duan (1):
  intel_iommu: Make pasid entry type check accurate

 hw/i386/intel_iommu_internal.h |  9 +++++++-
 hw/i386/intel_iommu.c          | 39 ++++++++++++++++++----------------
 2 files changed, 29 insertions(+), 19 deletions(-)

-- 
2.34.1


