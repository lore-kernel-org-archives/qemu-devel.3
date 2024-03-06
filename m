Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E62C8C54E49
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 09:41:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhnlX-0007RP-BV; Wed, 06 Mar 2024 04:40:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rhnlU-0007Qw-SQ
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 04:40:44 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rhnlS-0002EH-NR
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 04:40:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709718043; x=1741254043;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NpfwA5T3qrlUwyebkr7jEf0KUNOVvZ9NryO2DTdXNt4=;
 b=Yhw37+7Cjfs7WZJzrwPW0A/6EeD/minCws0WYDVPcMgjRLGc5JK7rqew
 eBFrLAn8TJ47Fbh/6pBO4XUARuy92gZltQBDQfoAyCQi+zLCfKnZriAO/
 knsqh5QYgLTOsOZ9S7qlr9vARL/ifDGJ5VD7uRjOpJwQwSfs0psJk8AGf
 VXdWoI4r9lLkqL7qTGTWNzantdBa1RmeGgltaIuFJjybYK6fskMFlTd22
 uZK6OA3NsScgJOm1cjvwgJoxHWfKl+3MLO8X/tStYfPaFRS65omz+kFsl
 Tt+UXykDSCBgx2PasxDgC8ff3yF+FUB6vrz96yemUsDSeBQt0VQTfkfu5 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="14897848"
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; d="scan'208";a="14897848"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2024 01:40:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; d="scan'208";a="32854146"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa002.fm.intel.com with ESMTP; 06 Mar 2024 01:40:39 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, qemu-devel@nongnu.org
Cc: Xiaoling Song <xiaoling.song@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 05/14] tests/unit/test-smp-parse: Drop the unsupported
 "dies=1" case
Date: Wed,  6 Mar 2024 17:53:58 +0800
Message-Id: <20240306095407.3058909-6-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240306095407.3058909-1-zhao1.liu@linux.intel.com>
References: <20240306095407.3058909-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=198.175.65.11;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

Unsupported "parameter=1" SMP configurations is marked as deprecated,
so drop the related test case.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 tests/unit/test-smp-parse.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tests/unit/test-smp-parse.c b/tests/unit/test-smp-parse.c
index 24972666a74d..1874bea08609 100644
--- a/tests/unit/test-smp-parse.c
+++ b/tests/unit/test-smp-parse.c
@@ -607,11 +607,6 @@ static void test_generic_valid(const void *opaque)
         unsupported_params_init(mc, &data);
 
         smp_parse_test(ms, &data, true);
-
-        /* Unsupported parameters can be provided with their values as 1 */
-        data.config.has_dies = true;
-        data.config.dies = 1;
-        smp_parse_test(ms, &data, true);
     }
 
     object_unref(obj);
-- 
2.34.1


