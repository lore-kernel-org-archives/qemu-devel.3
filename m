Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04ABBC48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 13:59:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYROQ-0003IY-9S; Fri, 09 Feb 2024 08:58:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1rYPSi-0003Fd-J8
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:54:32 -0500
Received: from esa8.hc1455-7.c3s2.iphmx.com ([139.138.61.253])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1rYPSd-0001e6-Hc
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:54:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1707479667; x=1739015667;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=XoWz/xDITxz/TTRZGqnkPOs6y2KW9/A4GSpdl/TiHjQ=;
 b=DGDIRoxtuX7CcW3MZezqUx1333z0euhC7d1z7XmlJatoJR7JYYBZ3L2T
 azZNZUkoBaLDDstKx941x9p6rasS4a9V0YdPVIj/Ff0+HPMh0wyMx5r4r
 doMBLpYpbRxbEORq/I1nLpklO1SYcMZXBF90lPfPUsBFUVbAHX8pmgmeR
 N4MCLLS2qdNGFv8mEoHvdjfxOMe3Fv9vNngoDql2n6piBF+vNh+XF8Yi/
 xpBlr9eZlfbxE9ml1zjigJQ+MW45q18EgZIRZn5Ofsc1526YsN4DlS3x/
 FxTGojSQ7JnjYJnbIXVfsr9ZixMo25IS7NHDq6wYk3unBEop6UTbNTtHY g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="136939363"
X-IronPort-AV: E=Sophos;i="6.05,256,1701097200"; d="scan'208";a="136939363"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
 by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2024 20:54:21 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com
 [192.168.83.65])
 by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id B615ED4180
 for <qemu-devel@nongnu.org>; Fri,  9 Feb 2024 20:54:19 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id E07B9D5938
 for <qemu-devel@nongnu.org>; Fri,  9 Feb 2024 20:54:18 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 6F30F20097AC4
 for <qemu-devel@nongnu.org>; Fri,  9 Feb 2024 20:54:18 +0900 (JST)
Received: from irides.g08.fujitsu.local (unknown [10.167.226.114])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id B72A01A006A;
 Fri,  9 Feb 2024 19:54:17 +0800 (CST)
To: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org
Cc: Jonathan.Cameron@huawei.com,
	dan.j.williams@intel.com
Subject: [RFC PATCH SET] cxl: add poison event handler
Date: Fri,  9 Feb 2024 19:54:10 +0800
Message-Id: <20240209115417.724638-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28180.007
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28180.007
X-TMASE-Result: 10--8.310200-10.000000
X-TMASE-MatchedRID: JUGAxiLh1cPvjhWxSrUkKRFbgtHjUWLy/OuUJVcMZhsIdsUH0fXfURCc
 5GBROM2VCuUOawo+L53x0YmcL/AjYyWfqL2WP1wRWFHKJ2wSViQXivwflisSrDABh2rVVNejLXk
 gVQ0v4RO75T5NVSKqdYAy6p60ZV62yA7duzCw6dLdB/CxWTRRu25FeHtsUoHuDGrCD/Q6EU/+EB
 l7sckhDbfxLhB3CJZGLzsNEGymi1XrpcchznD6Bw==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=139.138.61.253;
 envelope-from=ruansy.fnst@fujitsu.com; helo=esa8.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 09 Feb 2024 08:57:58 -0500
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

Currently driver only trace cxl events, poison injection on cxl memdev
is silent.  OS needs to be notified then it could handle poison range
in time.  Per CXL spec, the device error event could be signaled through
FW-First and OS-First methods.

This draft patchset adds poison event handler in OS-First method:
  - qemu:
    - CXL device report POISON event to OS by MSI by sending GMER after
      injecting a poison record
  - CXL driver
    a. read the POISON event through GMER;
    b. get POISON list;
    c. translate DPA to HPA;
    d. construct a mce instance, then call mce_log() to queue this mce
       instance;

This patchset includes 2 patches for qemu, 5 patches for cxl driver.

Shiyang Ruan (5):
  cxl/core: correct length of DPA field masks
  cxl/core: introduce cxl_memdev_dpa_to_hpa()
  cxl/core: introduce cxl_mem_report_poison()
  cxl/core: add report option for cxl_mem_get_poison()
  cxl/core: add poison injection event handler

 arch/x86/kernel/cpu/mce/core.c |  1 +
 drivers/cxl/core/mbox.c        | 82 +++++++++++++++++++++++++++-------
 drivers/cxl/core/memdev.c      | 16 ++++++-
 drivers/cxl/core/region.c      |  8 ++--
 drivers/cxl/core/trace.h       |  6 +--
 drivers/cxl/cxlmem.h           | 11 ++---
 drivers/cxl/pci.c              |  4 +-
 7 files changed, 97 insertions(+), 31 deletions(-)

-- 
2.34.1


