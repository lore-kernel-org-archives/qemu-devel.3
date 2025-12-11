Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACE36D3E78F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 05:45:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTZU3-0004YG-9j; Thu, 11 Dec 2025 00:44:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vTZTz-0004U4-Ek
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 00:44:55 -0500
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vTZTx-0001fN-CQ
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 00:44:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765431893; x=1796967893;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3n7M74aqCkbEbKfoKd8BocgrGmHYDsrLyL1GwMNnx9I=;
 b=jnpNCcdMO+8wcTUHfb+kRLC+YZQI3N/zkvK3IUK9JCeRe95Wf1d+LxW4
 +9fa+FGg+wtlHCNcPZrOsNPxeeF8N6Pj/fWsElLfbpX3g1mHUcxtvCXFd
 9qXdxRuVI/6dax1rmrNfemoUYw5BiFHG4SyPbRy5biuPlflcCyCc3XlFz
 JxDaKuMq25wkKTGz6gTZ8d2DXvBgDBVbraUYYj8qVLWCRNRFfpclrjaSh
 9/wWdOnpx6h39l6F3f3wM/1+fwAzi74bGHQOCZOFeRg3KqX9Q4OM8ypDN
 ZmnU5GbWYYx5zrvwi9OZhvEcvHu2dTGQTUZp8Oykil8EjmXMDBLaakD85 g==;
X-CSE-ConnectionGUID: eDa1dgcnT9inuU2OMN6dKw==
X-CSE-MsgGUID: mXAqOGR9TFOeh48orWcMFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="66409996"
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="66409996"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2025 21:44:41 -0800
X-CSE-ConnectionGUID: To8OqnNtTYG1g9TZoEtznA==
X-CSE-MsgGUID: kSE9/iCvSb6AEMrKXA5BMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="227366241"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa002.jf.intel.com with ESMTP; 10 Dec 2025 21:44:37 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Chao Gao <chao.gao@intel.com>,
 Xin Li <xin@zytor.com>, John Allen <john.allen@amd.com>,
 Babu Moger <babu.moger@amd.com>, Mathias Krause <minipli@grsecurity.net>,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 Farrah Chen <farrah.chen@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v5 20/22] i386/cpu: Enable cet-ss & cet-ibt for supported CPU
 models
Date: Thu, 11 Dec 2025 14:07:59 +0800
Message-Id: <20251211060801.3600039-21-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251211060801.3600039-1-zhao1.liu@intel.com>
References: <20251211060801.3600039-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.19; envelope-from=zhao1.liu@intel.com;
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

Add new versioned CPU models for Sapphire Rapids, Sierra Forest, Granite
Rapids and Clearwater Forest, to enable shadow stack and indirect branch
tracking.

Tested-by: Farrah Chen <farrah.chen@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index a65fd4111c31..84adfaf99dc8 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5166,6 +5166,17 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                     { /* end of list */ },
                 }
             },
+            {
+                .version = 5,
+                .note = "with cet-ss and cet-ibt",
+                .props = (PropValue[]) {
+                    { "cet-ss", "on" },
+                    { "cet-ibt", "on" },
+                    { "vmx-exit-save-cet", "on" },
+                    { "vmx-entry-load-cet", "on" },
+                    { /* end of list */ },
+                }
+            },
             { /* end of list */ }
         }
     },
@@ -5328,6 +5339,17 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                     { /* end of list */ },
                 }
             },
+            {
+                .version = 4,
+                .note = "with cet-ss and cet-ibt",
+                .props = (PropValue[]) {
+                    { "cet-ss", "on" },
+                    { "cet-ibt", "on" },
+                    { "vmx-exit-save-cet", "on" },
+                    { "vmx-entry-load-cet", "on" },
+                    { /* end of list */ },
+                }
+            },
             { /* end of list */ },
         },
     },
@@ -5482,6 +5504,17 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                     { /* end of list */ },
                 }
             },
+            {
+                .version = 4,
+                .note = "with cet-ss and cet-ibt",
+                .props = (PropValue[]) {
+                    { "cet-ss", "on" },
+                    { "cet-ibt", "on" },
+                    { "vmx-exit-save-cet", "on" },
+                    { "vmx-entry-load-cet", "on" },
+                    { /* end of list */ },
+                }
+            },
             { /* end of list */ },
         },
     },
@@ -5617,6 +5650,17 @@ static const X86CPUDefinition builtin_x86_defs[] = {
         .model_id = "Intel Xeon Processor (ClearwaterForest)",
         .versions = (X86CPUVersionDefinition[]) {
             { .version = 1 },
+            {
+                .version = 2,
+                .note = "with cet-ss and cet-ibt",
+                .props = (PropValue[]) {
+                    { "cet-ss", "on" },
+                    { "cet-ibt", "on" },
+                    { "vmx-exit-save-cet", "on" },
+                    { "vmx-entry-load-cet", "on" },
+                    { /* end of list */ },
+                }
+            },
             { /* end of list */ },
         },
     },
-- 
2.34.1


