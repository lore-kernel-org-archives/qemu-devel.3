Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32718C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 06:36:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlMd2-0001R5-R6; Fri, 21 Feb 2025 01:35:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tlMd0-0001P7-PB
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 01:35:14 -0500
Received: from esa3.hc1455-7.c3s2.iphmx.com ([207.54.90.49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tlMcx-0003jw-IG
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 01:35:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1740119712; x=1771655712;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=NFZ130imF5fW0wdSanjdfL4l4XAPBO9qlA7Thl5i4Ow=;
 b=tAADYDdNLd25vv0ZOjuY51mcpTVB2N9VOf593w5cPeSv7YkEKrA0m2eh
 ahZ87Ko7RClq/XY0LTOIsAl5umiG88+uYhEbxUTp7r4mknPjJc5xZ68VU
 B72ifWb/C6pm2Y1iT5ypVdnORWGSorAwuq81V8/rUQkg1WDUpWs0/5CVM
 +lowBnGBkK5GYqrxc5slNRDLWjqv8/2knDOW29SIIV4Wzy/8jTZtR+4Jf
 udBMnHKgUvJfog5zfKNFv/AtetBo5bCKmLAmkN9TuG2JyqBmPTkhY1txi
 Qp8i/8aSotIKTWJ5wWEnKoiAPYNmF/fRF9uKf4uhZwWCww34QuZQZC1oY g==;
X-CSE-ConnectionGUID: +NQicSCpROGGwGTOT0277Q==
X-CSE-MsgGUID: Sgz5vIViRK6ddxRtUJTtnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="190741326"
X-IronPort-AV: E=Sophos;i="6.13,303,1732546800"; d="scan'208";a="190741326"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
 by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Feb 2025 15:35:06 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com
 [192.168.87.61])
 by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id F0E3BC2262
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 15:35:03 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id B480DD540A
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 15:35:03 +0900 (JST)
Received: from iaas-rdma.. (unknown [10.167.135.44])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id E6E4D1A000B;
 Fri, 21 Feb 2025 14:35:02 +0800 (CST)
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v2 0/8] migration/rdma: fixes, refactor and cleanup
Date: Fri, 21 Feb 2025 14:36:04 +0800
Message-ID: <20250221063612.695909-1-lizhijian@fujitsu.com>
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
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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
Reply-to:  Li Zhijian <lizhijian@fujitsu.com>
From:  Li Zhijian via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

- It fix the RDMA migration broken issue
- disable RDMA + postcopy
- some cleanups
- Add a qtest for RDMA at last

Changs since V1[0]:
Add some saparate patches to refactor and cleanup based on V1

[0] https://lore.kernel.org/qemu-devel/20250218074345.638203-1-lizhijian@fujitsu.com/

Li Zhijian (8):
  migration: Prioritize RDMA in ram_save_target_page()
  migration/rdma: Remove redundant RAM_SAVE_CONTROL_NOT_SUPP check
  migration: Kill RAM_SAVE_CONTROL_NOT_SUPP
  migration: Integrate control_save_page() logic into
    ram_save_target_page()
  migration: Add migration_capabilities_and_transport_compatible()
    helper
  migraion: disable RDMA + postcopy-ram
  migration/rdma: Remove redundant migration_in_postcopy checks
  migration: Add qtest for migration over RDMA

 MAINTAINERS                           |  1 +
 migration/migration.c                 | 40 ++++++++++++-----
 migration/ram.c                       | 41 +++++------------
 migration/rdma.c                      | 12 +++--
 migration/rdma.h                      |  3 +-
 scripts/rdma-migration-helper.sh      | 41 +++++++++++++++++
 tests/qtest/migration/precopy-tests.c | 64 +++++++++++++++++++++++++++
 7 files changed, 153 insertions(+), 49 deletions(-)
 create mode 100755 scripts/rdma-migration-helper.sh

-- 
2.44.0


