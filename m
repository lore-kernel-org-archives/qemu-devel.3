Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD44CD1283
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 06:36:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rq5ql-0004Vs-Kt; Fri, 29 Mar 2024 02:36:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1rq5qj-0004VG-BJ
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 02:36:25 -0400
Received: from esa7.hc1455-7.c3s2.iphmx.com ([139.138.61.252])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1rq5qh-0002V9-GO
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 02:36:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1711694183; x=1743230183;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=OV3u9PFPBxcZetPCHjdd1JxSRP+skqDSB/QGdHY7BKc=;
 b=pea5sSWBeKb6G5qeZXR5Lm8+5nu/mRS9Omge2zoLrwHMUKcfRamgUiCT
 8NnZLi2zZzFv+o/hdh+6VtYYixrXryZfAXnbS7AxQaFz/7Qsf6frAhMdU
 qUxaDsNGOVMq+reNHbPYz2zrtdI5UL2d+G4UMicKNk2qCKMzr6bL6zIeR
 YbbFHodCcG+ks9GY7t2M3re43Zh9r2Ca15zLuAQk0jHs5nSxgqx+duZ9m
 OCdJK0+dQH1nfJ1fwe1vE1xqxUE+zCQI8U38bqV//EOLtTO8+MCbPeQfi
 S1oCR62OqJrLD/zbyesMBRP+My5XkC0p3X4aZ5zO5fAx4eqHmhke2yytJ Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="132533100"
X-IronPort-AV: E=Sophos;i="6.07,164,1708354800"; d="scan'208";a="132533100"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
 by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2024 15:36:18 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com
 [192.168.87.59])
 by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id B60CCD4803
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 15:36:16 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id D625E20538E
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 15:36:15 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 6AAE022496C
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 15:36:15 +0900 (JST)
Received: from irides.g08.fujitsu.local (unknown [10.167.226.114])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 966DE1A006A;
 Fri, 29 Mar 2024 14:36:14 +0800 (CST)
To: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org
Cc: Jonathan.Cameron@huawei.com, dan.j.williams@intel.com, dave@stgolabs.net,
 ira.weiny@intel.com
Subject: [RFC PATCH v2 0/6] cxl: add poison event handler
Date: Fri, 29 Mar 2024 14:36:08 +0800
Message-Id: <20240329063614.362763-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28282.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28282.003
X-TMASE-Result: 10--8.993200-10.000000
X-TMASE-MatchedRID: JUGAxiLh1cMkinkyECdW8xlxrtI3TxRk1QQ6Jx/fflb+Aw16GgqpO0+j
 bx0gEqGpOQhWysfkZ0EbNNo/4MUKcPGCAvUPDMAJqhcdnP91eXGlLADMASK8x0+z00/C4DjDQiM
 ingSlKoK4W6HEaP3gfW9yZj3aufb5HxPMjOKY7A8LbigRnpKlKSPzRlrdFGDwTpZBKtCN9kSuD0
 NYznv/PLajWsk6DUHUm+9cshTl/b5FHiGvOIOu1w==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=139.138.61.252;
 envelope-from=ruansy.fnst@fujitsu.com; helo=esa7.hc1455-7.c3s2.iphmx.com
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

Changes:
RFCv1 -> RFCv2:
1. update commit message of PATCH 1
2. use memory_failure_queue() instead of MCE
3. also report poison in debugfs when injecting poison
4. correct DPA->HPA logic:
     find memdev's endpoint decoder to find the region it belongs to
5. distinguish transaction_type of GMER, only handle POISON related
     event for now


Currently driver only traces cxl events, poison injection (for both vmem
and pmem type) on cxl memdev is silent.  OS needs to be notified then it
could handle poison range in time.  Per CXL spec, the device error event
could be signaled through FW-First and OS-First methods.

So, add poison event handler in OS-First method:
  - qemu:
    - CXL device report POISON event to OS by MSI by sending GMER after
      injecting a poison record
  - CXL driver                                  <-- this patchset
    a. parse the POISON event from GMER;
    b. retrieve POISON list from memdev;
    c. translate poisoned DPA to HPA;
    d. enqueue poisoned PFN to memory_failure's work queue;


Shiyang Ruan (6):
  cxl/core: correct length of DPA field masks
  cxl/core: introduce cxl_mem_report_poison()
  cxl/core: add report option for cxl_mem_get_poison()
  cxl/core: report poison when injecting from debugfs
  cxl: add definition for transaction_type
  cxl/core: add poison injection event handler

 drivers/cxl/core/mbox.c   | 126 +++++++++++++++++++++++++++++++++-----
 drivers/cxl/core/memdev.c |   5 +-
 drivers/cxl/core/region.c |   8 +--
 drivers/cxl/core/trace.h  |   6 +-
 drivers/cxl/cxlmem.h      |  13 ++--
 include/linux/cxl-event.h |  17 ++++-
 6 files changed, 144 insertions(+), 31 deletions(-)

-- 
2.34.1


