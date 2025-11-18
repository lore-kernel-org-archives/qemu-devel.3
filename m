Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47561CED245
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 03:23:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLCIH-00048I-NU; Mon, 17 Nov 2025 22:22:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLCI6-0003Lx-WD
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 22:22:03 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLCI5-0004Hi-40
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 22:22:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763436121; x=1794972121;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3n7M74aqCkbEbKfoKd8BocgrGmHYDsrLyL1GwMNnx9I=;
 b=lJ7C0Kg+fohBxbZgY1+OAXTMcPpBm/SS6ScRH4KZMSStMcffDo/YYKTi
 omHZ1yp5Uf2u4GeLm36KuIEs+i/ofPQW1qs7I4kCNa2nWUQ/7o1PhbZ4S
 vUaiN+K/yGEnJGyM+kqvEhYSLa7jb/dKzh4tQ/DnvhyN8gNpeZYpQ6MaK
 X6cUW3bOiv8wZEJqqsJw/68g0Y5DynFW4G/TCP7Rl2pVD/9nUbp7LAdLP
 Wpi9ZOldIZ9UsDknN24Qpzb9BGsdVhzazy9127ip+Plk8/lGn6xg2ZiJc
 QhpWLvCMe0GaBTQECyRMg3SQDQg8qU9Ikx6YrxTCCaD6QBWzlYCLg2gGD w==;
X-CSE-ConnectionGUID: KyUPKYTQQhqBhTMGD31jNA==
X-CSE-MsgGUID: J87WIvKJQjORo26u3JkzmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="68053938"
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; d="scan'208";a="68053938"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2025 19:21:31 -0800
X-CSE-ConnectionGUID: dWUJl04IQ1Wf6hyxk9tglg==
X-CSE-MsgGUID: dCgs5ufoR1mpahbrR5ykWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; d="scan'208";a="221537425"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 17 Nov 2025 19:21:27 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Chao Gao <chao.gao@intel.com>,
 Xin Li <xin@zytor.com>, John Allen <john.allen@amd.com>,
 Babu Moger <babu.moger@amd.com>, Mathias Krause <minipli@grsecurity.net>,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 Farrah Chen <farrah.chen@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v4 21/23] i386/cpu: Enable cet-ss & cet-ibt for supported CPU
 models
Date: Tue, 18 Nov 2025 11:42:29 +0800
Message-Id: <20251118034231.704240-22-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251118034231.704240-1-zhao1.liu@intel.com>
References: <20251118034231.704240-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
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


