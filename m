Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0032C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 06:28:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpiDs-0002H2-Tn; Wed, 05 Mar 2025 01:27:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tpiDe-0002EN-H5
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 01:27:04 -0500
Received: from esa1.hc1455-7.c3s2.iphmx.com ([207.54.90.47])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tpiDb-0007ea-N2
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 01:27:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1741156019; x=1772692019;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=FF/7ych0r5b738SS8ODhapA+Ni50vGxt0xEzw+FXpi0=;
 b=DkQCVsbDbbu49DTH9qoJwECcG95KMDLtfPM85nRflUgT32ETxwk1ruzv
 PY2aGYHOnsuFSD2wCCy4NsA5YLhpGS0ICYa5s4Iu/eX2SLOfI44JySIuJ
 Rok2Pywr8N25mKC604KmG2Xi40ryjQo6LFXHUZ0GcSgjQr1pBEz+RAHyt
 cC9qRaytHcUixQZkydE4J6EEYIJdeMw51NrNp2lk5Ar/baA568Q31qBcG
 UVXGPdsUtVVZxIYjkiBYzZDEKMxWgTZamUOW1syeRuqNrgXki5Prwr78s
 cXo1A9CzJRWmC8bd/Htqqs/6PrgH5zf1j/Mdtza0ahxT8qk8fKf6DMI6z A==;
X-CSE-ConnectionGUID: znQ+5kWwR3GhS/LU9bjEVQ==
X-CSE-MsgGUID: V6S978B/TdaloscEF2BXhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="192059402"
X-IronPort-AV: E=Sophos;i="6.14,222,1736780400"; d="scan'208";a="192059402"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
 by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2025 15:26:53 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com
 [192.168.87.58])
 by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 32CCAB54C5
 for <qemu-devel@nongnu.org>; Wed,  5 Mar 2025 15:26:51 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id E9D52D8BAA
 for <qemu-devel@nongnu.org>; Wed,  5 Mar 2025 15:26:50 +0900 (JST)
Received: from iaas-rdma.. (unknown [10.167.135.44])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id D61FD1A0078;
 Wed,  5 Mar 2025 14:26:49 +0800 (CST)
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v5 0/6] migration/rdma: fixes, refactor and cleanup
Date: Wed,  5 Mar 2025 14:28:19 +0800
Message-ID: <20250305062825.772629-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.54.90.47; envelope-from=lizhijian@fujitsu.com;
 helo=esa1.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Changes since V4:
 - collect Reviewed-tags
 - Address comments in patch "migration: Add qtest for migration over RDMA" from Fabiano Rosas <farosas@suse.de>

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
 migration/migration.c                 | 30 ++++++++----
 migration/options.c                   | 25 ++++++++++
 migration/options.h                   |  1 +
 migration/ram.c                       | 41 +++++-----------
 migration/rdma.c                      | 11 ++---
 migration/rdma.h                      |  3 +-
 scripts/rdma-migration-helper.sh      | 48 +++++++++++++++++++
 tests/qtest/migration/precopy-tests.c | 67 +++++++++++++++++++++++++++
 9 files changed, 178 insertions(+), 49 deletions(-)
 create mode 100755 scripts/rdma-migration-helper.sh

-- 
2.44.0


