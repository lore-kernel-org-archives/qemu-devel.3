Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B53C021BC
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 06:30:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnAvF-0001ji-BH; Wed, 26 Feb 2025 01:29:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tnAv8-0001iP-R4
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 01:29:26 -0500
Received: from esa3.hc1455-7.c3s2.iphmx.com ([207.54.90.49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tnAv5-0001vA-2t
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 01:29:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1740551363; x=1772087363;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=oHfvnJne6HIvpelmLYxAyCZt0O2Gt8QVuuzmfG7aoyk=;
 b=ElATye1SY2kwqXddRsAxo3g9/yxP4zDGicCPVNEFO8n0BeBqwFcaXdra
 eUEqDyGQXxS9goGT2eCdv4GmE1E3X3IR9g7mVrZwtsWp2WEMblbL4DXDk
 DKqmmChpzqh+68/y4MH7nS86gsN8tFubqiOTCBv7FOYeM5MrvSHNS2DYG
 LMN+5P1Vg8ou7Yj9OQ1xFOi4PrrCoUC510881h2LISdqdiVtUC/anaI4F
 NiPdDZvo4pbxON8A3/aPz5KLN6wEaR/UTRKfLARBSh+AYIsEC291yE7eZ
 Va1VPdayYtvot/OO0AxzeFlS3RysVPADkef0ve9Gy96H89Rn+oPFulws6 A==;
X-CSE-ConnectionGUID: rUTkERI1T/KG+OIRleq6EQ==
X-CSE-MsgGUID: ERIYlcdwR0uHRVhm7rSHxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="191192462"
X-IronPort-AV: E=Sophos;i="6.13,316,1732546800"; d="scan'208";a="191192462"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
 by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2025 15:29:16 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com
 [192.168.87.61])
 by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 62351D480B
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 15:29:14 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 26678D4BF1
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 15:29:14 +0900 (JST)
Received: from iaas-rdma.. (unknown [10.167.135.44])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 50BE31A000B;
 Wed, 26 Feb 2025 14:29:13 +0800 (CST)
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v4 0/6] migration/rdma: fixes, refactor and cleanup
Date: Wed, 26 Feb 2025 14:30:37 +0800
Message-ID: <20250226063043.732455-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.54.90.49; envelope-from=lizhijian@fujitsu.com;
 helo=esa3.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Li Zhijian <lizhijian@fujitsu.com>
From:  Li Zhijian via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

- It fix the RDMA migration broken issue
- disable RDMA + postcopy
- some cleanups
- Add a qtest for RDMA at last

Changes since V3:
- check RDMA and capabilities are compatible on both sides # renamed from
  previous V3's "migration: Add migration_capabilities_and_transport_compatible()"

Changes since V2:
- squash previous 2/3/4 to '[PATCH v3 5/6] migration: Unfold  control_save_page()'
- reorder the patch layout to prevent recently added code from being deleted again.
- collect Reviewed tags from Peter

Changes since V1[0]:
Add some saparate patches to refactor and cleanup based on V1

[0] https://lore.kernel.org/qemu-devel/20250218074345.638203-1-lizhijian@fujitsu.com/


Li Zhijian (6):
  migration: Prioritize RDMA in ram_save_target_page()
  migration: check RDMA and capabilities are compatible on both sides
  migration: disable RDMA + postcopy-ram
  migration/rdma: Remove redundant migration_in_postcopy checks
  migration: Unfold control_save_page()
  migration: Add qtest for migration over RDMA

 MAINTAINERS                           |  1 +
 migration/migration.c                 | 30 ++++++++-----
 migration/options.c                   | 25 +++++++++++
 migration/options.h                   |  1 +
 migration/ram.c                       | 41 +++++------------
 migration/rdma.c                      | 11 ++---
 migration/rdma.h                      |  3 +-
 scripts/rdma-migration-helper.sh      | 41 +++++++++++++++++
 tests/qtest/migration/precopy-tests.c | 64 +++++++++++++++++++++++++++
 9 files changed, 168 insertions(+), 49 deletions(-)
 create mode 100755 scripts/rdma-migration-helper.sh

-- 
2.44.0


