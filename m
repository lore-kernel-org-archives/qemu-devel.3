Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF098C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 08:02:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfYqA-0004UP-HM; Fri, 03 Jul 2026 04:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wfYpy-0004Ql-Gt
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 04:01:27 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wfYpw-0001gX-EW
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 04:01:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783065684; x=1814601684;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=DMsHe08LLdFkjn5CUls4sliF0VMNmjWyKUrisuj/QnE=;
 b=B14I7rSkCGcQDVhryVvz7NCUD+VorXZczH1YbVKBUFCMdUZPH/a+52TK
 rTlzhaY93ZIJYnWoteVYHn4UzE2lMikZzP4z/xtlgwFiovWpXsHKbiYaV
 h3saVofSOgiSp/sLoi3CCF9MYMihK3ob72S2kehn1yqBgdwtKW8ZrTHEs
 hbq1ExVr/wbEMPcqugSNA5mIdjQRN/5gNdpbMHySJ88zMMg5MVDBizwvV
 WJYU7xqWIlYK0k+9BfKwMfdZoiTUstugE5JroArvHnbpXwReOPXEC9JO7
 jPmUkSkPu8lgWIsljf+OlvMoJNXGJnJEaVr+Vo9Em6SkNuzJZwTIoClLa A==;
X-CSE-ConnectionGUID: x4FrTxDdQU2yOrDE6afchg==
X-CSE-MsgGUID: vesHb063RAe98YkK8TNGBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="94464645"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; d="scan'208";a="94464645"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2026 01:01:20 -0700
X-CSE-ConnectionGUID: l6QU4cYcSkmosi037VG1IQ==
X-CSE-MsgGUID: 4QHsoytFS0uG9wS1avB6Kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; d="scan'208";a="277379526"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2026 01:01:17 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@bull.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Tao Tang <tangtao1634@phytium.com.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fengyuan Yu <15fengyuan@gmail.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, junjie.cao@intel.com
Subject: [PATCH v1 0/3] tests/qtest: add Intel IOMMU IOTLB invalidation test
Date: Fri,  3 Jul 2026 15:21:55 +0800
Message-ID: <20260703072200.463082-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.9; envelope-from=junjie.cao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

The iommu-testdev framework lets a qtest drive an emulated vIOMMU
without a guest, and Intel translation tests already build on it [1].
The next behaviour worth covering is invalidation: no in-tree qtest
checks that any vIOMMU actually flushes a stale IOTLB entry.  This
series adds that for VT-d.

Each case populates the IOTLB (map IOVA->PA_A, DMA), rewrites the leaf
PTE to PA_B without invalidating and confirms the stale entry still
serves PA_A, then invalidates and confirms a fresh walk reaches PA_B.
Without the stale check, a device that never cached would also pass.
Cases cover {legacy, scalable-slt, scalable-flt} x {global, domain,
page}, driving vtd_process_inv_desc -> vtd_process_iotlb_desc ->
vtd_iotlb_{global,domain,page}_invalidate.  Three more cases cache a
second page to check page-selective scope: it survives for second-level
and, as QEMU flushes first-stage entries domain-wide, is evicted for
scalable-flt.

Patch 1 moves the VT-d setup helpers out of iommu-intel-test.c into the
shared qos-intel-iommu module with no functional change; patch 2 adds
the invalidation helpers; patch 3 adds the test.

scalable-flt uses the legacy VTD_INV_DESC_IOTLB descriptor, the path
QEMU runs for its unified IOTLB; PASID-selective PIOTLB and domain-level
selectivity are left as follow-ups.

[1] https://lore.kernel.org/qemu-devel/cover.1774421649.git.15fengyuan@gmail.com/

Junjie Cao (3):
  tests/qtest/libqos: share Intel IOMMU test setup helpers
  tests/qtest/libqos: add Intel IOMMU invalidation helpers
  tests/qtest: add IOTLB invalidation test for Intel IOMMU

 MAINTAINERS                          |   1 +
 tests/qtest/iommu-intel-inv-test.c   | 346 +++++++++++++++++++++++++++
 tests/qtest/iommu-intel-test.c       |  78 +-----
 tests/qtest/libqos/qos-intel-iommu.c | 185 ++++++++++++++
 tests/qtest/libqos/qos-intel-iommu.h |  74 ++++++
 tests/qtest/meson.build              |   2 +-
 6 files changed, 608 insertions(+), 78 deletions(-)
 create mode 100644 tests/qtest/iommu-intel-inv-test.c


base-commit: b4bdad7dcef623d2874df4e79e0be01075096c3b
-- 
2.43.0


