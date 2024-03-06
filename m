Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA3F0C54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 09:41:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhnlU-0007Qj-EM; Wed, 06 Mar 2024 04:40:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rhnlT-0007QH-4w
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 04:40:43 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rhnlQ-0002EH-Df
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 04:40:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709718040; x=1741254040;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=EwAYN36P3lzqN1glAqPGtpQAeH7zDs5xPFp9VL7Pp+Y=;
 b=GdQIK8mcrdr/Yx2yXM8xc2or3r1S/g+ksppSHr3GI/PfXlBF0rtzm7u1
 H26wSMnuWjuzpiP0PhiBXW5Ut6yIPoe8BCs2pld9XzEXTp6MxvPXkvCBQ
 upL1FKkn1o5pypAtQXm0wR7gSohCAaPylErm/TDkFqeXc50dur6fNCdbO
 vGF2k4blKoR5uQeBGokWM0f/TQhPrV9BiWsReB1d3eQXa+6rN+fmbbYlr
 Yt9hDMjDnGurv6zTY82hranKq5XEZp6hJr9ciruHnuyXbAvBId3xFS5mN
 Eg6moHlL4QAQMgKB69UpT44e6MFZSUIxfr3MFCHm95lNnuRfUSNFYZ3d1 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="14897840"
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; d="scan'208";a="14897840"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2024 01:40:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; d="scan'208";a="32854140"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa002.fm.intel.com with ESMTP; 06 Mar 2024 01:40:36 -0800
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
Subject: [PATCH 04/14] hw/core/machine-smp: Calculate total CPUs once in
 machine_parse_smp_config()
Date: Wed,  6 Mar 2024 17:53:57 +0800
Message-Id: <20240306095407.3058909-5-zhao1.liu@linux.intel.com>
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

In machine_parse_smp_config(), the number of total CPUs is calculated
by:

    drawers * books * sockets * dies * clusters * cores * threads

To avoid missing the future new topology level, use a local variable to
cache the calculation result so that total CPUs are only calculated
once.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/core/machine-smp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/core/machine-smp.c b/hw/core/machine-smp.c
index 3d9799aef039..0e398ef02666 100644
--- a/hw/core/machine-smp.c
+++ b/hw/core/machine-smp.c
@@ -91,6 +91,7 @@ void machine_parse_smp_config(MachineState *ms,
     unsigned cores    = config->cores;
     unsigned threads  = config->threads;
     unsigned maxcpus  = config->maxcpus;
+    unsigned total_cpus;
 
     /*
      * Specified CPU topology parameters must be greater than zero,
@@ -211,8 +212,8 @@ void machine_parse_smp_config(MachineState *ms,
         }
     }
 
-    maxcpus = maxcpus > 0 ? maxcpus : drawers * books * sockets * dies *
-                                      clusters * cores * threads;
+    total_cpus = drawers * books * sockets * dies * clusters * cores * threads;
+    maxcpus = maxcpus > 0 ? maxcpus : total_cpus;
     cpus = cpus > 0 ? cpus : maxcpus;
 
     ms->smp.cpus = cpus;
@@ -228,8 +229,7 @@ void machine_parse_smp_config(MachineState *ms,
     mc->smp_props.has_clusters = config->has_clusters;
 
     /* sanity-check of the computed topology */
-    if (drawers * books * sockets * dies * clusters * cores * threads !=
-        maxcpus) {
+    if (total_cpus != maxcpus) {
         g_autofree char *topo_msg = cpu_hierarchy_to_string(ms);
         error_setg(errp, "Invalid CPU topology: "
                    "product of the hierarchy must match maxcpus: "
-- 
2.34.1


