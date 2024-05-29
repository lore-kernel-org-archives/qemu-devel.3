Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B504DC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 06:05:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCCQ5-0005We-Td; Wed, 29 May 2024 02:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sCCQ3-0005W9-E3
 for qemu-devel@nongnu.org; Wed, 29 May 2024 02:04:15 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sCCQ1-0002tM-UT
 for qemu-devel@nongnu.org; Wed, 29 May 2024 02:04:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716962654; x=1748498654;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RsdXYkRRI3rmURZbis55cmiquR+HjVYZWgtL+XP6yNo=;
 b=OnbJjY3R6FaRVc8o742OIr4/zXe8Icr+ojGvLq0mzOllAsk2We5y3tcj
 WA5JInqPUVMluyXgEDdS3q7Hd5pwAYixurODca2Y7NnHgFN3UjQpELcuN
 0qrmHEpq2jAlhPAYdR06siwzE5IMwBNLBU26B9DtnwcPYpqtZf5M3l0a9
 aW228M+RJlRRoKdg92sX/RT2JKSUBN6utY/eZH2iDlpW1R0J9SYX/mfwW
 8EtW1rJgmNdjKFIfjvwcE8eOO1sjzSVm6foZhp2MqncCCUIUFZPIM+pjd
 f//ZzJh9vVBvVKUpN316AMyqeW5t/rn4R7Ev5jn6idqBBtIfNtJ0eRIOp w==;
X-CSE-ConnectionGUID: UYTqTGcyThSWeXnLHei4OQ==
X-CSE-MsgGUID: vcEFS4RMTGm9vFZx1XJrKg==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13187477"
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; d="scan'208";a="13187477"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2024 23:04:13 -0700
X-CSE-ConnectionGUID: JcT+zxvFRAq4CHZumOWong==
X-CSE-MsgGUID: zK/fwobnRyCMKmWnShNNDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; d="scan'208";a="40144707"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa003.jf.intel.com with ESMTP; 28 May 2024 23:04:11 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
Cc: Yongwei Ma <yongwei.ma@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 3/8] tests/unit/test-smp-parse: Fix an invalid topology case
Date: Wed, 29 May 2024 14:19:20 +0800
Message-Id: <20240529061925.350323-4-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529061925.350323-1-zhao1.liu@intel.com>
References: <20240529061925.350323-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.20; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
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

Adjust the "cpus" parameter to match the comment configuration.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 tests/unit/test-smp-parse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/unit/test-smp-parse.c b/tests/unit/test-smp-parse.c
index c9cbc89c21b9..5d99e0d9234c 100644
--- a/tests/unit/test-smp-parse.c
+++ b/tests/unit/test-smp-parse.c
@@ -528,7 +528,7 @@ static const struct SMPTestData data_full_topo_invalid[] = {
          * config: -smp 1,drawers=3,books=5,sockets=2,dies=4,\
          *              clusters=2,cores=7,threads=3,maxcpus=5040
          */
-        .config = SMP_CONFIG_WITH_FULL_TOPO(3361, 3, 5, 2, 4, 2, 7, 3, 5040),
+        .config = SMP_CONFIG_WITH_FULL_TOPO(1, 3, 5, 2, 4, 2, 7, 3, 5040),
         .expect_error = "Invalid SMP CPUs 5040. The max CPUs supported "
                         "by machine '" SMP_MACHINE_NAME "' is 4096",
     },
-- 
2.34.1


