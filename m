Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7402CD98E4
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 02:42:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa2hX-0003BP-Ue; Wed, 17 Jun 2026 22:41:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wa2hV-0003AT-8M; Wed, 17 Jun 2026 22:41:53 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wa2hR-0002aC-82; Wed, 17 Jun 2026 22:41:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781750509; x=1813286509;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=YrwcpQ0WvBz/1+z3tCzmFwH0nCWHbcXLoQuFZ9YQf+Y=;
 b=XpkMHSTgZ6DZHQSTVD57iarsv+9tM3IsNOBR0AOLg7aTQHjyUo9K6K7a
 rkY+BLwTQdJk7sun627eL1aNjHJXGSDiYvcubv5zOPRrCxBiK0RlnrC+c
 VXTxPtSOKDyfGuG/TNdd4l4SWYaFKsAeM7fulISOYNsIX0nGn1lUHxe4/
 796iKDwKiFm71eOZ1OVhDypKIlZwNoX3JAf3mwRQiakiLu4TNVCkHhLp5
 Zbiwq15g8dZ42sr6NtkwtZHKM4X4MStSZ4U+5LUmxmbwx7wp/SZJF2gg/
 6DyfRZxvlGQqMSmOtLVJOjOn29J//1N+PnIb0Z45uMNIVkOZx9lfGUpOB Q==;
X-CSE-ConnectionGUID: 9G+J9P1qQpSHJKP7xwaaUw==
X-CSE-MsgGUID: vg9FeIwGRASWt8Ivceshew==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="93229261"
X-IronPort-AV: E=Sophos;i="6.24,210,1774335600"; d="scan'208";a="93229261"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2026 19:41:45 -0700
X-CSE-ConnectionGUID: U2DXYIQjTNO4ofBf2UTmfQ==
X-CSE-MsgGUID: SF09PBIgR5OaK1yi3UvOuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,210,1774335600"; d="scan'208";a="245302087"
Received: from junjie-optiplex-micro-plus-7010.bj.intel.com ([10.238.152.98])
 by fmviesa007-auth.fm.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 19:41:43 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, linux-cxl@vger.kernel.org,
 Junjie Cao <junjie.cao@intel.com>
Subject: [PATCH] hw/cxl: Fix guest-triggerable QEMU exit on reserved
 interleave ways
Date: Thu, 18 Jun 2026 18:43:16 +0800
Message-ID: <20260618104316.557306-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.9; envelope-from=junjie.cao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DATE_IN_FUTURE_06_12=1.947,
 DKIMWL_WL_HIGH=-0.445, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

A buggy or malicious guest can program a committed HDM decoder with a
reserved Interleave Ways encoding (e.g. 0x5-0x7, 0xb-0xf).  Two call
sites pass &error_fatal to cxl_interleave_ways_dec(), which calls
exit(1) on the reserved encoding before the subsequent decoded_iw == 0
guards can run:

  - cxl-host.c update_non_interleaved(): called at commit time from
    hdm_decoder_commit() via cfmws_update_non_interleaved(), so a guest
    writing COMMIT with a reserved IW terminates QEMU immediately.  This
    is the primary trigger on the current tree.

  - cxl_type3.c cxl_type3_dpa(): called on memory access while iterating
    past committed decoders to accumulate dpa_base.  Once the commit-time
    exit is removed, the decoder stays committed with the reserved
    encoding, so a later guest access outside that decoder's range would
    otherwise hit this second &error_fatal; both are fixed here.

Pass NULL instead of &error_fatal at both sites so that the reserved
encoding returns zero and the existing guards handle it gracefully.

This can be reproduced by writing the HDM Decoder 0 Control register
with a reserved IW encoding and the COMMIT bit set (e.g. IW=0x5,
COMMIT=1).

Cc: qemu-stable@nongnu.org
Fixes: 680935c9a6ff ("hw/cxl: Add a performant (and correct) path for the non interleaved cases")
Fixes: 48461825af1b ("hw/mem/cxl_type3: Fix potential divide by zero reported by coverity")
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 hw/cxl/cxl-host.c  | 2 +-
 hw/mem/cxl_type3.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index 7e744312f1..768fdadc29 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -442,7 +442,7 @@ static int update_non_interleaved(Object *obj, void *opaque)
             }
         }
 
-        interleave_ways_dec = cxl_interleave_ways_dec(iw, &error_fatal);
+        interleave_ways_dec = cxl_interleave_ways_dec(iw, NULL);
         if (interleave_ways_dec == 0) {
             return 0;
         }
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index cba05ec57d..102afa1a19 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1197,7 +1197,7 @@ static bool cxl_type3_dpa(CXLType3Dev *ct3d, hwaddr host_addr, uint64_t *dpa)
         }
         if (((uint64_t)host_addr < decoder_base) ||
             (hpa_offset >= decoder_size)) {
-            int decoded_iw = cxl_interleave_ways_dec(iw, &error_fatal);
+            int decoded_iw = cxl_interleave_ways_dec(iw, NULL);
 
             if (decoded_iw == 0) {
                 return false;
-- 
2.43.0


