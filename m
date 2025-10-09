Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42AA3CCA470
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 04:04:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6hrV-0005pB-7O; Thu, 09 Oct 2025 00:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v6hrR-0005on-Lw
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 00:02:37 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v6hrO-0002b2-N6
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 00:02:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759982554; x=1791518554;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TzkxlI9egdrmunNPSgwi9HKMSBaqWR2wtWxaRxMmwsQ=;
 b=lj+dZJLKFGujPLWHPcidORvbT88abCeaLw9Vb+m0/bHOry6mO704jODf
 sl7WVBE8GT7lxPlJt4qdtnPEnedG/MWretwr1aN8xeS7ip2Zn3sj3UZ/V
 hXGLbXjGUUo9fNkHgKCzb8ZQ749JnpLDby/86kJQn+jXxmrl/Pt87yb8q
 12BXvOS+/FaNZLMmdXHjCHF95f1621wdIccTn44CVWgLwm6kYGg2VzoU1
 N8B+RLhkNLKfheWF+npuRV5lpFHX9bLR+iGp/4PtM1eaafHditZEMcDDl
 X4PcPhKnF0rx//nbPXrsS/84HjeSqKATDNt/6UgXGYlawE+oQ4Jsn5zrq w==;
X-CSE-ConnectionGUID: 3rAKCaFtSNOattLRp4LMhw==
X-CSE-MsgGUID: 2oUCAbUdSS++Znx9HfK3sw==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="84804140"
X-IronPort-AV: E=Sophos;i="6.19,215,1754982000"; d="scan'208";a="84804140"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2025 21:02:19 -0700
X-CSE-ConnectionGUID: REoNhCpSTrejJvw8ppHTlA==
X-CSE-MsgGUID: ZZggSNDkRDGI8QpW0HPtaQ==
X-ExtLoop1: 1
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2025 21:02:17 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 levon@movementarian.org, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 3/3] vfio/listener: Add an assertion for unmap_all
Date: Thu,  9 Oct 2025 00:01:34 -0400
Message-ID: <20251009040134.334251-4-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251009040134.334251-1-zhenzhong.duan@intel.com>
References: <20251009040134.334251-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Currently the maximum of iommu address space is 64bit. So when a maximum
iommu memory section is deleted, it's in scope [0, 2^64). Add a
assertion for that.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/listener.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index c6bb58f520..62766d8c46 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -715,6 +715,7 @@ static void vfio_listener_region_del(MemoryListener *listener,
         bool unmap_all = false;
 
         if (int128_eq(llsize, int128_2_64())) {
+            assert(!iova);
             unmap_all = true;
             llsize = int128_zero();
         }
-- 
2.47.1


