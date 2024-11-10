Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E26BCE6781C
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Nov 2024 14:52:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tA9Hc-0002MK-3P; Sun, 10 Nov 2024 09:51:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tA9HZ-0002LV-Lk
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 09:51:17 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tA9HX-0007wA-TE
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 09:51:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1731250276; x=1762786276;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=d9l7L0xCB5UR2k2nHxVrAPYNnYlVC0ryQ8tN0nsNAlI=;
 b=ldodhYj+pry7jVKGTaohLKsD2ILSy7yfkrzJ5iHDnXye/4F2T+HhR/R6
 qsNv0xmrQIe72tjrtTAijP9CjxwWxL7cxNX9mEZaAF2F3O1jbUbOWUzGh
 ttbncWPnIm1hVWAg930GDxDGmJ80UAuZ6H7YtcdQ9TImcLoWlVI9OpdNj
 nkIKXvDRmlC8IiKsh9q8XJep0jMIcFLTEKcobIVw/kRrFNyftBEsLmx04
 xYA1j9Z+VyJXqvUE8Z2A/3U0Lsnkg4xf7/XnWNRirmYR6eLZCADAcNh3k
 mBrcxHMc2T3m54KBsv8QI6kvrMp1+UqcfzS5oKdgEf4TdTAzXK+pRHMqk w==;
X-CSE-ConnectionGUID: Evmr1fKATtCGmkoqp2lzMA==
X-CSE-MsgGUID: qZeFHCT1SDaxXaCZDFyEfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11252"; a="56467600"
X-IronPort-AV: E=Sophos;i="6.12,143,1728975600"; d="scan'208";a="56467600"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2024 06:51:14 -0800
X-CSE-ConnectionGUID: lcG8gB3JTSuYwjtV9QX7tA==
X-CSE-MsgGUID: cGCVGWdDTfyyWCd0/8lXKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,143,1728975600"; d="scan'208";a="86467591"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa010.jf.intel.com with ESMTP; 10 Nov 2024 06:51:13 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH for 9.2 2/2] hw/core/machine-smp: Fix error message parameter
Date: Sun, 10 Nov 2024 23:09:01 +0800
Message-Id: <20241110150901.130647-3-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241110150901.130647-1-zhao1.liu@intel.com>
References: <20241110150901.130647-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.118,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

In the loop checking smp cache support, the error message should report
the current cache level and type.

Fix the parameter of error_setg() to ensure it reports the correct cache
level and type.

Resolves: Coverity CID 1565391
Fixes: f35c0221fef8 ("hw/core: Check smp cache topology support for machine")
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/core/machine-smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/core/machine-smp.c b/hw/core/machine-smp.c
index b87637c78f6f..b954eb849027 100644
--- a/hw/core/machine-smp.c
+++ b/hw/core/machine-smp.c
@@ -317,7 +317,7 @@ bool machine_parse_smp_cache(MachineState *ms,
             !mc->smp_props.cache_supported[props->cache]) {
             error_setg(errp,
                        "%s cache topology not supported by this machine",
-                       CacheLevelAndType_str(node->value->cache));
+                       CacheLevelAndType_str(props->cache));
             return false;
         }
 
-- 
2.34.1


