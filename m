Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 581FFC25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 16:23:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD51L-0001m5-DZ; Fri, 31 May 2024 12:22:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ira.weiny@intel.com>)
 id 1sD51J-0001lb-6k
 for qemu-devel@nongnu.org; Fri, 31 May 2024 12:22:21 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ira.weiny@intel.com>)
 id 1sD51G-0001hB-62
 for qemu-devel@nongnu.org; Fri, 31 May 2024 12:22:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717172539; x=1748708539;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:to:cc;
 bh=x54UI51/BBH6kc4fJKTW/nyAZ/Nqg8AFfvccpZvV+ds=;
 b=eNYXuNwrVN3fUx9Dz2KQXinrML98LdBm/BYmDHN8bwGw85Eun64rVPox
 U6tJsFwyXLsIfw343n3UrdPIFmbp81Z10qhvPpWK1rxdIhZ+3fD0d9xW4
 5h9xKxLWArpTTt9qoFTdKSgtd6lgAjOI5Kie9bpxfIzSgS1H+wwt0Ovnb
 enZf6pDGE1JOqfX6l2LJBfbv6xZWReo7zmp4LaQNufn9LtBnI9FD3nUQ3
 90GPVmAOkA/fIkm5odVIuyfSdy3XvydzbKktivUkGhhcKBATgyHgKMHzu
 zws2Nqa1OZQ48nSuETG0QhGasm1aJekDZ8QpOoWv+WjAWiUyamuEJmGj7 A==;
X-CSE-ConnectionGUID: 1gSOcCoIQW+pxgZi5/3H5g==
X-CSE-MsgGUID: mIGdfGQNSOuAbqDPqhgP5Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="24354087"
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; d="scan'208";a="24354087"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2024 09:22:15 -0700
X-CSE-ConnectionGUID: ODpSXBHMQGWJdEdmAZafbA==
X-CSE-MsgGUID: gDLOZoXRQ429YhfjZ2s5Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; d="scan'208";a="73688666"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost)
 ([10.212.23.232])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2024 09:22:13 -0700
From: Ira Weiny <ira.weiny@intel.com>
Date: Fri, 31 May 2024 11:22:05 -0500
Subject: [PATCH] hw/cxl: Fix read from bogus memory
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240531-fix-poison-set-cacheline-v1-1-e3bc7e8f1158@intel.com>
X-B4-Tracking: v=1; b=H4sIACz5WWYC/x2M0QpAQBQFf0X32S27SPkVebDr4JZ2tVdS8u82j
 1Mz85AiCZT64qGES1RiyGDKgvw2hRUsc2aylW2qtja8yM1HFI2BFSf7yW/YJYBRW+cNusbZjnJ
 +JGT3Xw/j+35ytldaagAAAA==
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Fan Ni <fan.ni@samsung.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.13-dev-2d940
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717172532; l=1660;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=x54UI51/BBH6kc4fJKTW/nyAZ/Nqg8AFfvccpZvV+ds=;
 b=ptxwpytiGHM847AtxPW/uGX4I3ytsvqZH5rjUY3PIFWcjigPCoEiTo5oXWt9l2lyKqAVZPyVL
 BqOVysMBcrVCs2CW8+FFvuhfGhnDp3lmQkovyjDVhahTzFQqWNSfYp6
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=
Received-SPF: pass client-ip=192.198.163.11; envelope-from=ira.weiny@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Peter and coverity report:

	We've passed '&data' to address_space_write(), which means "read
	from the address on the stack where the function argument 'data'
	lives", so instead of writing 64 bytes of data to the guest ,
	we'll write 64 bytes which start with a host pointer value and
	then continue with whatever happens to be on the host stack
	after that.

Indeed the intention was to write 64 bytes of data at the address given.

Fix the parameter to address_space_write().

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Link: https://lore.kernel.org/all/CAFEAcA-u4sytGwTKsb__Y+_+0O2-WwARntm3x8WNhvL1WfHOBg@mail.gmail.com/
Fixes: 6bda41a69bdc ("hw/cxl: Add clear poison mailbox command support.")
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
Compile tested only.  Jonathan please double check me.
---
 hw/mem/cxl_type3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 3e42490b6ce8..582412d9925f 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1025,7 +1025,7 @@ static bool set_cacheline(CXLType3Dev *ct3d, uint64_t dpa_offset, uint8_t *data)
         as = &ct3d->hostpmem_as;
     }
 
-    address_space_write(as, dpa_offset, MEMTXATTRS_UNSPECIFIED, &data,
+    address_space_write(as, dpa_offset, MEMTXATTRS_UNSPECIFIED, data,
                         CXL_CACHE_LINE_SIZE);
     return true;
 }

---
base-commit: 3b2fe44bb7f605f179e5e7feb2c13c2eb3abbb80
change-id: 20240531-fix-poison-set-cacheline-e32bc1e74b27

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>


