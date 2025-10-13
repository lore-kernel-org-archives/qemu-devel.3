Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C4F7CCD185
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 07:24:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8Ctx-0000VG-Ee; Mon, 13 Oct 2025 03:23:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v8Ctv-0000V6-Qa
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 03:23:23 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v8Cts-00058y-LB
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 03:23:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760340200; x=1791876200;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=mKutKUbgY/xtptDEvgv9NoY88DHIyfgLLuLG8KUPfD4=;
 b=H6Mv01pSvdZSNHMk4j8vCASmiuv57dotcAxAEZo+9BRVrUUqyfQ43Saa
 t+vTz9RTaEduPAgeJQJeMgjcWyn7PD2FwN3HAF7thuFqx6hfcy5/1f755
 j6NLKPemjoOpfwt7bxwqj0av+NoNNuNyfZhY6U3rrAbi+a2WJO9gW6gyE
 XPATRx1yU/QuG+lTVwvblAX7M0+hlcUuN3diGSSFwGX3HYsY9VQNlz309
 GJI+9kHbcWUrrqoUdLdfs3SDCpWNUuxjsQuFqKiieTLDdSxIbTS8Yj8e0
 gNEy/TfQfoiLfHpx1PQNBQtTYhwP7Kea6k+x5m4XC/YgCUBRMUVoSQqRf A==;
X-CSE-ConnectionGUID: P3dsK8EVQPqocQBNGy+Q4A==
X-CSE-MsgGUID: wXPRLvLPT0aY1CmLdk+32g==
X-IronPort-AV: E=McAfee;i="6800,10657,11580"; a="79917938"
X-IronPort-AV: E=Sophos;i="6.19,224,1754982000"; d="scan'208";a="79917938"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2025 00:23:11 -0700
X-CSE-ConnectionGUID: PLAlZ8OhSrWA8+4WxUR3Og==
X-CSE-MsgGUID: FzXXhQGXTYG97hTeqSpUzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,224,1754982000"; d="scan'208";a="185940400"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 13 Oct 2025 00:23:09 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=83?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH] qapi/machine: Fix missing @modules in topology ordering
Date: Mon, 13 Oct 2025 15:45:11 +0800
Message-Id: <20251013074511.2030073-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

The module level is between core and cluster levels. Fix the QAPI
documentation to add the module level in topology ordering.

Reported-by: Markus Armbruster <armbru@redhat.com>
Fixes: 8ec0a4634798 ("hw/core/machine: Support modules in -smp")
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 qapi/machine.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 038eab281c78..5e268479e546 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1624,7 +1624,7 @@
 # containers.
 #
 # The ordering from highest/coarsest to lowest/finest is: @drawers,
-# @books, @sockets, @dies, @clusters, @cores, @threads.
+# @books, @sockets, @dies, @clusters, @modules, @cores, @threads.
 #
 # Different architectures support different subsets of topology
 # containers.
-- 
2.34.1


