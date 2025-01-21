Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E838C02181
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 02:16:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ta3nI-00023W-VD; Mon, 20 Jan 2025 21:15:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1ta3nH-000235-Ha
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 21:15:07 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1ta3nF-0002bj-4e
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 21:15:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737425705; x=1768961705;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=twlGqArSii9kEA2RCj+H8LMbUnuyTZAHn+IKIhMzHDg=;
 b=cWo1YumcKq2nUdndTfjhPJInPlPZEGJR1NqWdX2Kvw9nQfOMkYvIsNkq
 ic+9OII/8jSOIGzg2VMLqmcsdmf/U+iBqx9jEzZUuRQdVZjzQaYv2IyJk
 D3NMCuKKaoDu9fGukjUiOtx3iym3tkcp8eXyiWFDoQkeL82D34TzPuCIu
 tGnja8h+PE+6O94OJmj5gcPqIr+XLif+7BWoHQPXgoa0K6pWtJRXr3cbw
 ZiRMQcBiyuMi7fAclZCV4ffEIHDlZnlTjuGAXT97TtAxrfz6czTOJ8YDF
 Yd1tzJl7pm1ycpa9+Weo1wrTKfSnhWvyaq8k7E5a7KgWVWc2NPV68XSsU A==;
X-CSE-ConnectionGUID: lYIZ7kTdR7ijAdBvbAAYiA==
X-CSE-MsgGUID: fvCoycA2St6UgNfjfvK17Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11321"; a="48320153"
X-IronPort-AV: E=Sophos;i="6.13,220,1732608000"; d="scan'208";a="48320153"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jan 2025 18:15:01 -0800
X-CSE-ConnectionGUID: gCk7wlsdSxq94+X+UEIeDg==
X-CSE-MsgGUID: SmcL/aUlRfe5F8oeIdHJOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,220,1732608000"; d="scan'208";a="106599352"
Received: from st-server.bj.intel.com ([10.240.193.102])
 by fmviesa007.fm.intel.com with ESMTP; 20 Jan 2025 18:14:58 -0800
From: Tao Su <tao1.su@linux.intel.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, imammedo@redhat.com, xiaoyao.li@intel.com,
 zhao1.liu@linux.intel.com, xuelian.guo@intel.com, tao1.su@linux.intel.com
Subject: [PATCH 0/4] Introduce SierraForest-v2 and ClearwaterForest CPU model
Date: Tue, 21 Jan 2025 10:06:46 +0800
Message-Id: <20250121020650.1899618-1-tao1.su@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=198.175.65.11;
 envelope-from=tao1.su@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Sorry for resending this series, because it didn't seem to be received by
the mailing list before.

Update SierraForest CPU model to stepping 3 as adding LAM and missing
features.

Clearwater Forest is a new Intel Xeon processor, which will debut in the
market in 2025, add the new CPU model ClearwaterForest based on
SierraForest-v2 CPU model.

Tao Su (4):
  target/i386: Introduce SierraForest-v2 model
  target/i386: Export BHI_NO bit to guests
  target/i386: Add new CPU model ClearwaterForest
  docs: Add GNR, SRF and CWF CPU models

 docs/system/cpu-models-x86.rst.inc |  42 ++++++++
 target/i386/cpu.c                  | 156 ++++++++++++++++++++++++++++-
 target/i386/cpu.h                  |  33 ++++--
 3 files changed, 224 insertions(+), 7 deletions(-)


base-commit: 20fac491cfeebb042f59cc61ae76fed1b397d25c
-- 
2.34.1


