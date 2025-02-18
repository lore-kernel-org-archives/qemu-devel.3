Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF3BC02198
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 07:18:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkHrm-0002Uy-0c; Tue, 18 Feb 2025 02:18:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tkHrf-0002Sg-2j
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 02:17:55 -0500
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tkHrX-0002g2-TR
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 02:17:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739863068; x=1771399068;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=2pFVw/1jpooTFlIFglBnN9lZHev1m8x4A6ddS5fJGN0=;
 b=lnjjABHfXAuSHe00oi41tX/Jl6mqu5657XNbVDMw1/ovfzBrL/50I3kD
 Jki6RuddCua4tBBcOEfF3RadKdh1AR1wEwxMxRNg8EB8ws2p1OEwtcFYq
 YkXffEzAOXmEBtNtqVbPAdBLusIFfz79miMoUIL6d3c7QHFdVZNR+9PoV
 MBw901ILBrpOMS4J7dKKBgg5CPE+I0hIOKYTxldWhaWZ0dEPYSUdMW/VT
 EB73Yibc5OqSrlniK6oLcBICZX4Z1RlAKYQRkiM/DOYnYgBSAHAQCw/JR
 j1cSIMifq07rssE1pxJGe+SsuKAQdCLRITwMXPCFTxsHDPm12Q8yP3tsr A==;
X-CSE-ConnectionGUID: vIs5ru6NQaCegU+J2uiItQ==
X-CSE-MsgGUID: nfF6AiMfQNKE958a4Kdlcg==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="39781788"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; d="scan'208";a="39781788"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2025 23:17:38 -0800
X-CSE-ConnectionGUID: cHL6iajgQACMB7kqpu4SlA==
X-CSE-MsgGUID: I/6/NutbRQeaQo0CexVnaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; d="scan'208";a="114511854"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa008.fm.intel.com with ESMTP; 17 Feb 2025 23:17:36 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH] hw/timer/hpet: Detect invalid access to TN registers
Date: Tue, 18 Feb 2025 15:37:02 +0800
Message-Id: <20250218073702.3299300-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

"addr & 0x18" ignores invalid address, so that the trace in default
branch (trace_hpet_ram_{read|write}_invalid()) doesn't work.

Mask addr by "0x1f & ~4", in which 0x1f means to get the complete TN
registers access and ~4 means to keep any invalid address offset.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 * Note: This patch applies the changes from Rust HPET [*] to C HPET to
   ensure logic consistency.
   [*]: The original comment should use "(0x1f & ~4)":
        https://lore.kernel.org/qemu-devel/Z6edKxYFzA6suDlj@intel.com/
---
 hw/timer/hpet.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index dcff18a9871d..0f786047e54f 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -455,7 +455,7 @@ static uint64_t hpet_ram_read(void *opaque, hwaddr addr,
             return 0;
         }
 
-        switch (addr & 0x18) {
+        switch (addr & (0x1f & ~4)) {
         case HPET_TN_CFG: // including interrupt capabilities
             return timer->config >> shift;
         case HPET_TN_CMP: // comparator register
@@ -511,7 +511,8 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
             trace_hpet_timer_id_out_of_range(timer_id);
             return;
         }
-        switch (addr & 0x18) {
+
+        switch (addr & (0x1f & ~4)) {
         case HPET_TN_CFG:
             trace_hpet_ram_write_tn_cfg(addr & 4);
             old_val = timer->config;
-- 
2.34.1


