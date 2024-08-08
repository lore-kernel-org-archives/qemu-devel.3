Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 070ACC52D7B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 15:14:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc4pk-0007SX-Ua; Thu, 08 Aug 2024 11:13:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1sc4pg-0007RY-VD
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 11:13:40 -0400
Received: from esa7.hc1455-7.c3s2.iphmx.com ([139.138.61.252])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1sc4pe-0003aC-SR
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 11:13:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1723130018; x=1754666018;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=iFNP495OinJb2lktMcGqRGAhtEH6mWIcSw6cu316J9c=;
 b=YGLcuy+aibUR4CRouuznEkfjeah+0J/zzgKyMBomGB6Ysb57h0hik/kh
 HuZgNaCNVJcPG6zwcFp0NF7bDKe+hQPiJ1KLVKxUhxRJC0wuWYtrRjQ0Q
 NFSxTZ3a3EsFUBpoAyV/rlVx+zG3+AL6/EczpGUhNcwLQya2HiUg9W83V
 ZQlHKz6PE3p/k47xQJY/Mb+VrxoruJBllUGX8R9PssR0+z9YG4tlSJo3I
 chaOGM8f/sY1qgyFidgdddd8uvy76tEjZDncNqGdsQmMI9eGy2EyRh8CZ
 NkXUcRBvKFeCPndTmJExfc9z6QvJ5gJpb0jMWB57R8N2dwQFj8U7x7NgW A==;
X-CSE-ConnectionGUID: 5IV1yJHNQOipZCzwKSVlSQ==
X-CSE-MsgGUID: gbBeDVOISLuHRwCsZkkXeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="149069153"
X-IronPort-AV: E=Sophos;i="6.09,273,1716217200"; d="scan'208";a="149069153"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
 by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Aug 2024 00:13:33 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com
 [192.168.83.66])
 by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 376D6D4F54
 for <qemu-devel@nongnu.org>; Fri,  9 Aug 2024 00:13:32 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 5ACA4207FA
 for <qemu-devel@nongnu.org>; Fri,  9 Aug 2024 00:13:31 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id D15C222936B
 for <qemu-devel@nongnu.org>; Fri,  9 Aug 2024 00:13:30 +0900 (JST)
Received: from irides.g08.fujitsu.local (unknown [10.167.226.114])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 28E1D1A000A;
 Thu,  8 Aug 2024 23:13:29 +0800 (CST)
To: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
 linux-edac@vger.kernel.org, linux-mm@kvack.org, dan.j.williams@intel.com,
 vishal.l.verma@intel.com, Jonathan.Cameron@huawei.com,
 alison.schofield@intel.com
Cc: bp@alien8.de, dave.jiang@intel.com, dave@stgolabs.net, ira.weiny@intel.com,
 james.morse@arm.com, linmiaohe@huawei.com, mchehab@kernel.org,
 nao.horiguchi@gmail.com, rric@kernel.org, tony.luck@intel.com,
 ruansy.fnst@fujitsu.com
Subject: [PATCH v4 0/2] cxl: add device reporting poison handler
Date: Thu,  8 Aug 2024 23:13:26 +0800
Message-Id: <20240808151328.707869-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28584.000
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28584.000
X-TMASE-Result: 10--25.644800-10.000000
X-TMASE-MatchedRID: lHzeI+asw8M0b21ExFN2+kg5Iem1vm3HTFQnI+epPIbVYWFt1wbX7Eop
 D+RCCRBkvX+3OiqxW1kU/FrOclzESmD8e8nXbfYy0wmR34xRQc8v5vY1YvMqbujMOEZ5AL0SUZS
 Ad8uKlMfx79muHEGAix37L/Rv0wwcXOFTT+immjbfh7vdn2pP64zinsSc+o89H8jJDe3vPQN5GD
 v/ZOF4Nm5/m6vlvI+l/Iblp89iIQD1aPobg60YTKJVTu7sjgg1odQJXaDex6fWeQtrcncLfbIQd
 fMMKrFBCD9IcjSuAiPykYfoCiS47xyfGYp07KWZTbFVCYPBTqZZDdHiTk9OcLfYIuZsOQ0shj53
 gjhYKkQ8I7sVBmNJqozRCiL6QfeVNigjEI6ndRqJJ72DuZB0nDnOm2OHJgpYcdSPHEhb6Fe2NT1
 CGlQHxr/5yx5GCNXjb3JmPdq59vkfE8yM4pjsDwtuKBGekqUpPjKoPgsq7cA=
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

This patchset includes "cxl/core: introduce poison creation hanlding"
and "cxl: avoid duplicated report from MCE & device", which were posted
separately.  Here are changes since last version of each patch:
 P1: 1. since its async memory_failure(), set the flag to 0
     2. also handle CXL_EVENT_TRANSACTION_SCAN_MEDIA type
 P2: 1. use XArray instead of list_head
     2. add guard() lock for cxl device iteration
 P1&P2: Rebase to v6.11-rc1


As is known to us, CXL spec defines POISON feature to notify its status 
when CXL memory device got a broken page.  Basically, there are two 
major paths for the notification.

1. CPU handling error
   When a process is accessing this broken page, CXL device returns data
   with POISON.  When CPU consumes the POISON, it raises a kind of error
   notification.
   To be precise, "how CPU should behave when it consumes POISON" is
   architecture dependent.  In my understanding, x86-64 raises Machine
   Check Exception(MCE) via interrupt #18 in this case.
2. CXL device reporting error
   When CXL device detects the broken page by itself and sends memory
   error signal to kernel in two optional paths.
   2.a. FW-First
     CXL device sends error via VDM to CXL Host, then CXL Host sends it
     to System Firmware via interrupt, finally kernel handles the error.
   2.b. OS-First
     CXL device directly sends error via MSI/MSI-X to kernel.

Note: Since I'm now focusing on x86_64, basically I'll describe about 
x86-64 only.

The following diagram should describe the 2 major paths and 2 optional 
sub-paths above.
```
1.  MCE (interrupt #18, while CPU consuming POISON)
     -> do_machine_check()
       -> mce_log()
         -> notify chain (x86_mce_decoder_chain)
           -> memory_failure()
2.a FW-First (optional, CXL device proactively find&report)
     -> CXL device -> Firmware
       -> OS: ACPI->APEI->GHES->CPER -> CXL driver -> trace
2.b OS-First (optional, CXL device proactively find&report)
     -> CXL device -> MSI
       -> OS: CXL driver -> trace
```

For "1. CPU handling error" path, the current code seems to work fine. 
When I used error injection feature on QEMU emulation, the code path is 
executed certainly.  Then, if the CPU certainly raises a MCE when it 
consumes the POISON, this path has no problem.

So, I'm working on making for 2.a and 2.b path, which is CXL device 
reported POISON error could be handled by kernel.  This path has two 
advantages.

- Proactively find&report memory problems

   Even if a process does not read data yet, kernel/drivers can prevent
   the process from using corrupted data proactively.  AFAIK, the current
   kernel only traces POISON error event from FW-First/OS-First path, but
   it doesn't handle them, neither notify processes who are using the
   POISON page like MCE does.  User space tools like rasdaemon reads the
   trace and log it, but as well, it doesn't handle the POISON page.  As
   a result, user has to read the error log from rasdaemon, distinguish
   whether the POISON error is from CXL memory or DDR memory, find out
   which applications are effected.  That is not an easy work and cannot
   be handled in time.  Thus, I'd like to add a feature to make the work
   done automatically and quickly. Once CXL device reports the POISON
   error (via FW-First/OS-First), kernel handles it immediately, similar
   to the flow when a MCE is triggered.  This is my first motivation.

- Architecture independent

   As the mentioned above, "1. CPU handling error" path is architecture
   dependent.  On the other hand, this route can be architecture
   independent code.  If there is a CPU which does not have similar
   feature like MCE of x86-64, my work will be essential.  (To be honest,
   I did not notice this advantage at first as mentioned later, but I
   think this is also important.)


Shiyang Ruan (2):
  cxl/core: introduce device reporting poison hanlding
  cxl: avoid duplicated report from MCE & device

 arch/x86/include/asm/mce.h |   1 +
 drivers/cxl/core/mbox.c    | 190 ++++++++++++++++++++++++++++++++++---
 drivers/cxl/core/memdev.c  |   6 +-
 drivers/cxl/cxlmem.h       |  11 ++-
 drivers/cxl/pci.c          |   4 +-
 include/linux/cxl-event.h  |  16 +++-
 6 files changed, 207 insertions(+), 21 deletions(-)

-- 
2.34.1


