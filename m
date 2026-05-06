Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 375D3CD342F
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 03:20:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKSo5-0005q4-OD; Tue, 05 May 2026 23:20:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wKSo4-0005pv-CL
 for qemu-devel@nongnu.org; Tue, 05 May 2026 23:20:16 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wKSo2-0002XZ-8m
 for qemu-devel@nongnu.org; Tue, 05 May 2026 23:20:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778037615; x=1809573615;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MDXT9lf6CDoqdSOjF6DbiS2Cd1kMrllejKp50qqAULk=;
 b=c2Vf/bwgSsN0NPVCJjeZsOzaBJ6xWHDelmQUzE1cqKhZjbzZifTpMiBM
 wnQZDQJAcA5DWZgELe4HdbWxvHmO68E6clnFwvOiaV+oyN+IUgE4HGWhz
 yXnUcWbShq5UDMP1R+KUgYJhh8kjKAog2WnneaWfkw8+tXVIAipZgqYMf
 cTSyjhkZJz612E8yIUR+kHP4X83Ma96dCQ1ugUl8rh81hUmTmB43AmHBz
 NZ7+Fw09Uc3+Z/f+Nnd1zbft5lgb6Tp+3a42kDMdraYOdreD3VkjJk/cD
 zyZ9jwuqEqRckun1YOJxx3yzW63eK8W2mXZbu8haECFlYley0pzKQAwOz w==;
X-CSE-ConnectionGUID: 1+JBPzhETpaV6qkkaSYfDQ==
X-CSE-MsgGUID: SgvCgX65Tqeq4U7s/1LSxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="78783031"
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; d="scan'208";a="78783031"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 20:20:10 -0700
X-CSE-ConnectionGUID: Gu2/PMOGTOKg7QUPtI3isQ==
X-CSE-MsgGUID: fKjEydPWRoGfNrBk1rwWhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; d="scan'208";a="231416999"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 20:20:06 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: qemu-devel@nongnu.org
Cc: junjie.cao@intel.com, zhenzhong.duan@intel.com, philmd@linaro.org,
 mst@redhat.com, jasowang@redhat.com, yi.l.liu@intel.com,
 clement.mathieu--drif@bull.com, marcel.apfelbaum@gmail.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, farosas@suse.de,
 lvivier@redhat.com
Subject: [PATCH v3 0/2] intel_iommu: fix guest-triggerable assert in MMIO
 handlers
Date: Wed,  6 May 2026 11:19:40 +0800
Message-ID: <20260506031942.251335-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <DS4PPF93A1BBECDC498B677FE8B259BCEAD92352@DS4PPF93A1BBECD.namprd11.prod.outlook.com>
References: <DS4PPF93A1BBECDC498B677FE8B259BCEAD92352@DS4PPF93A1BBECD.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17; envelope-from=junjie.cao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

An 8-byte guest access to a 32-bit-only VT-d register hits
assert(size == 4) and aborts QEMU.  Found by generic-fuzz.

v1: https://lore.kernel.org/all/20260420170523.17908-1-junjie.cao@intel.com/
v2: https://lore.kernel.org/all/20260424201842.176953-1-junjie.cao@intel.com/

Changes in v3:
  - Drop v2's min_access_size=8 approach: per Zhenzhong, it
    silently zero-extends 4-byte guest writes, wiping upper
    wmask bits of 64-bit registers and firing triggers gated
    on size==8.
  - Keep min_access_size=4.  Remove the 25 assert(size == 4)
    sites: 21 are unreachable (non-8-aligned), the 4 reachable
    (FECTL 0x38, IECTL 0xa0, IEADDR 0xa8, PECTL 0xe0) fall
    through to vtd_set_long() and log a guest error.

Junjie Cao (2):
  intel_iommu: fix guest-triggerable abort on oversized MMIO access
  tests/qtest: add 8-byte MMIO access sweep for intel-iommu

 hw/i386/intel_iommu.c          | 41 +++++++++++++---------------------
 tests/qtest/intel-iommu-test.c | 30 +++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 25 deletions(-)


base-commit: da6c4fe60fee30dd77267764d55b38af9cb89d4b
-- 
2.43.0


