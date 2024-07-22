Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D781C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 04:09:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVkLS-00025n-WD; Mon, 22 Jul 2024 00:08:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sVkLI-000253-5A
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 00:08:09 -0400
Received: from esa10.hc1455-7.c3s2.iphmx.com ([139.138.36.225])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sVkLG-0001jK-8c
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 00:08:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1721621286; x=1753157286;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=VE1aJnYMcd66+tBcZtRhuiGlfJnvBVykXStmYIUu+Kc=;
 b=DvRwDeLK7S6HdgsBpPPg3WvXQo9YpkEluqZj5l/PrIEpg0dq7yCw8+6R
 K7uvBRDWTwi1HN/AcDQ+7FYEZUM7gwdgOafmc84Zbo1VbjJU1dg413jPu
 qJEtg/CTlGzIwzTaugDNFTI/9NvE4UHbgXu225owdvLOBLEnelJ9a/NV2
 cpr+GVJt3VSiUj9wqg4pTuS+q63XhhR8mcxfyFQDphrUgnXiNvnjpK1dp
 5vV43005K61/ZnsG3qLeKZE7zE6KnMqv6b9UAcqz4ScGMd6UHPhFLzPps
 HPZU+S7cu1QeGFWs0EhHawNxXwTCeWKkYCc5M0lovztsp/zLohMrfdkTb A==;
X-IronPort-AV: E=McAfee;i="6700,10204,11140"; a="155452520"
X-IronPort-AV: E=Sophos;i="6.09,227,1716217200"; d="scan'208";a="155452520"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
 by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2024 13:08:02 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com
 [192.168.83.66])
 by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id C0509C944C
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 13:08:00 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 16373D968B
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 13:08:00 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id A11676BEE3
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 13:07:59 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.225.88])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 214401A000A;
 Mon, 22 Jul 2024 12:07:59 +0800 (CST)
To: qemu-devel@nongnu.org
Cc: Yao Xingtao <yaoxt.fnst@fujitsu.com>
Subject: [PATCH 00/13] make range overlap check more readable
Date: Mon, 22 Jul 2024 00:07:29 -0400
Message-ID: <20240722040742.11513-1-yaoxt.fnst@fujitsu.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28544.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28544.004
X-TMASE-Result: 10-6.052400-10.000000
X-TMASE-MatchedRID: TrF+XMB65PpnpJOZcTss/UhwlOfYeSqxJi9o/Zx5a4zWeQtrcncLfQcE
 3AwiiNlyF8FM3vCXBCbPTrwIsZMcOu2aXYCZD9Viuce7gFxhKa19LQinZ4QefPcjNeVeWlqY+gt
 Hj7OwNO3Dfx1dF4y1d8zdCZw6aENlLHsE4XIZ4oIAid+gD5sIPquxZ2PC5q8XNhKk9ok+9qEefT
 laTMShWTdqTXtiVQwdec0bkkodWaHGI3gPDvMGGw==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=139.138.36.225;
 envelope-from=yaoxt.fnst@fujitsu.com; helo=esa10.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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
Reply-to:  Yao Xingtao <yaoxt.fnst@fujitsu.com>
From:  Yao Xingtao via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Currently, some components still open-coding the range overlap check.
Sometimes this check may be fail because some patterns are missed.

To avoid the above problems and improve the readability of the code,
it is better to use the ranges_overlap() to do this check.

Yao Xingtao (13):
  range: Make ranges_overlap() return bool
  arm/boot: make range overlap check more readable
  core/loader: make range overlap check more readable
  cxl/mailbox: make range overlap check more readable
  display/sm501: make range overlap check more readable
  aspeed_smc: make range overlap check more readable
  qtest/fuzz: make range overlap check more readable
  sparc/ldst_helper: make range overlap check more readable
  system/memory_mapping: make range overlap check more readable
  block/vhdx: make range overlap check more readable
  crypto/block-luks: make range overlap check more readable
  dump: make range overlap check more readable
  block/qcow2-cluster: make range overlap check more readable

 block/qcow2-cluster.c           | 23 +++++++++++++----------
 block/vhdx.c                    | 12 +++++++-----
 crypto/block-luks.c             |  3 ++-
 dump/dump.c                     | 12 ++++++++----
 hw/arm/boot.c                   |  5 +++--
 hw/core/loader.c                |  4 +++-
 hw/cxl/cxl-mailbox-utils.c      |  8 ++++----
 hw/display/sm501.c              | 12 ++++++------
 hw/ssi/aspeed_smc.c             |  4 ++--
 include/qemu/range.h            |  4 ++--
 system/memory_mapping.c         |  4 ++--
 target/sparc/ldst_helper.c      |  5 ++---
 tests/qtest/fuzz/generic_fuzz.c |  3 ++-
 13 files changed, 56 insertions(+), 43 deletions(-)

-- 
2.41.0


