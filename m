Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 514A5C001CC
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 07:51:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rx04U-00056r-R4; Wed, 17 Apr 2024 03:51:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1rx04R-00056I-Jd
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 03:51:08 -0400
Received: from esa11.hc1455-7.c3s2.iphmx.com ([207.54.90.137])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1rx04N-000237-Ep
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 03:51:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1713340264; x=1744876264;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=lb9Pxp3Eza7fspbIatLUTROAMiPIxPeq3aIDRxd+Zfc=;
 b=NFMoCI8GMMOPztiw4mP1HR9NFxPKaUQDI+X/kjAeFned+hUjFpDE+RXy
 FdjlVQJBxE5Pmrh1VB1n+Q07OMGbPE58NQPV1DHMTAbhADPIRYjC0fSAX
 eBRl1jBriAM5rvMzH8kYfdgAgU/krHeeSe2v6RJkL9kiYDOc5VEKF69Z+
 6vaQayzyrCMTx+fhl+O1eflDbQ5jd7bAAWWwsHO/ZtfwywelXvoL4OybF
 7IlXT2+r+/kiGnDNSidgZyUk1nFWFCBBkltO4eD/KVixn8p85QJoXs735
 1UueS9hD1cckn8td4Kw0ffrhYrWe1fEAUuFtXZDBpzdC6teMgOZGCjACd g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="135213850"
X-IronPort-AV: E=Sophos;i="6.07,208,1708354800"; d="scan'208";a="135213850"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
 by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2024 16:50:58 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com
 [192.168.87.59])
 by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 6C963D4807
 for <qemu-devel@nongnu.org>; Wed, 17 Apr 2024 16:50:55 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 9692AD4222
 for <qemu-devel@nongnu.org>; Wed, 17 Apr 2024 16:50:54 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 295D320097CED
 for <qemu-devel@nongnu.org>; Wed, 17 Apr 2024 16:50:54 +0900 (JST)
Received: from irides.g08.fujitsu.local (unknown [10.167.226.114])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 577481A000A;
 Wed, 17 Apr 2024 15:50:53 +0800 (CST)
To: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org
Cc: Jonathan.Cameron@huawei.com, dan.j.williams@intel.com, dave@stgolabs.net,
 ira.weiny@intel.com, alison.schofield@intel.com
Subject: [PATCH v3 0/2] cxl: add poison creation event handler
Date: Wed, 17 Apr 2024 15:50:51 +0800
Message-Id: <20240417075053.3273543-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28326.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28326.005
X-TMASE-Result: 10--7.175000-10.000000
X-TMASE-MatchedRID: 4r2MyAYFTndlJTodqNqEzpV3j1zTOBYz/OuUJVcMZhvG5dXdQTj2OHG0
 XoqFERcpi70orB5wM5OhvbGMLMgkamULhS/RYteOEVuC0eNRYvL9XDMezlt/vCiJduasmgZhRpc
 31ddH+ShCIvvqgRmgughBeNJICtc+j2hRzH1UwuAURSScn+QSXmVV1G+Ck2l7+gtHj7OwNO35N/
 S1zEq4untHa4+L7o4W99dC03zAok3mnTE/jwuyozlvRXkWmame
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=207.54.90.137;
 envelope-from=ruansy.fnst@fujitsu.com; helo=esa11.hc1455-7.c3s2.iphmx.com
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
Reply-to:  Shiyang Ruan <ruansy.fnst@fujitsu.com>
From:  Shiyang Ruan via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Changes: RFCv2 -> v3:
1. patch1: removed changes for flags
2. changed the main idea of this patchset: not for injection event
     handling, but for creation;
3. removed GET_POISON_LIST command while receiving POISON event;
4. dropped poison report in debugfs;
5. added DER event handler to handle POISON event, in case POISON event is
     sent by DER;
After the above changes, this patchset becomes smaller.  Main code changes
are in patch2, which seems could't be divided smaller.


Currently driver only traces cxl events, poison creation (for both vmem
and pmem type) on cxl memdev is silent.  OS needs to be notified then it
could handle poison pages in time.  Per CXL spec, the device error event
could be signaled through FW-First and OS-First methods.

So, add poison creation event handler in OS-First method:
  - Qemu:
    - CXL device reports POISON creation event to OS by MSI by sending
      GMER/DER after injecting a poison record;
  - CXL driver:                                   <--- this patchset
    a. parse the POISON event from GMER/DER;
    b. translate poisoned DPA to HPA (PFN);
    c. enqueue poisoned PFN to memory_failure's work queue;

Shiyang Ruan (2):
  cxl/core: correct length of DPA field masks
  cxl/core: add poison creation event handler

 drivers/cxl/core/mbox.c   | 119 +++++++++++++++++++++++++++++++++-----
 drivers/cxl/core/trace.h  |   2 +-
 drivers/cxl/cxlmem.h      |   8 +--
 include/linux/cxl-event.h |  18 +++++-
 4 files changed, 126 insertions(+), 21 deletions(-)

-- 
2.34.1


