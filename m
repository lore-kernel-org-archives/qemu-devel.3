Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F01F4C83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 09:45:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubFj5-0002sG-2z; Mon, 14 Jul 2025 05:43:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ubFTj-00012M-Ox
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 05:28:16 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ubFTh-0003EU-23
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 05:28:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752485285; x=1784021285;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qn9gJigVS/thIyBLmze218xHraAxu/hvkldIETa3c+M=;
 b=AqUCWs4P1Xuc++0sDIXA6NPctdNaObQp22Vli2cSFAfRzqRj12ppmuPJ
 9bYXqLAgL1Ljk+AZLxlhY7IAg1LN3Hu0QTDlMgMmEkvwGu+4s+GbjvUQl
 fVskjN3LG7lNQDMgFZhFAVDkvl6rcvcnh0q61PydkkkNM1CG7ThJofhHA
 FJKTO+qdO2sBb6FbSPrRQbEdKVtxBONLXgt4L4MN4Y9Rpm8WwuwNILzNa
 sycQ/TlOUkYvKbUlqoM5JxmRQ2/AWFpHw9W1VmdfW3wQlpulIOMOT1Cyd
 AfJ41/VznLj5xcC4gNQ1OKd4HjBE2XEAgJ/lCO517XfMuL2GZzjHZLVuu A==;
X-CSE-ConnectionGUID: gkUi0Z6NSpKxRJ8a579ZEQ==
X-CSE-MsgGUID: lY5Cj03MT4SBO4hlgQZzDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="66029264"
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; d="scan'208";a="66029264"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2025 02:28:01 -0700
X-CSE-ConnectionGUID: CFL/ZywTTUyfOMt46S66MA==
X-CSE-MsgGUID: T+1Ues2TQW6OIOl5MUMI2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; d="scan'208";a="187882728"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa002.jf.intel.com with ESMTP; 14 Jul 2025 02:28:01 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
	Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH 1/5] qemu-options: Move sgx-epc options from "M" to "machine"
Date: Mon, 14 Jul 2025 17:19:49 +0800
Message-ID: <20250714091953.448226-2-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714091953.448226-1-xiaoyao.li@intel.com>
References: <20250714091953.448226-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

It's weird to only put sgx-epc option in "M" while leaving others to
"machine". Besides currently in qemu-manpage.html, the "sgx-epc" option
is listed at the same level of "-machine", which looks incorrect.

Move "sgx-epc" ontion to "-machine" to address all above.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 qemu-options.hx | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 1f862b19a676..740323f22bc2 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -43,7 +43,8 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
 #endif
     "                memory-backend='backend-id' specifies explicitly provided backend for main RAM (default=none)\n"
     "                cxl-fmw.0.targets.0=firsttarget,cxl-fmw.0.targets.1=secondtarget,cxl-fmw.0.size=size[,cxl-fmw.0.interleave-granularity=granularity]\n"
-    "                smp-cache.0.cache=cachename,smp-cache.0.topology=topologylevel\n",
+    "                smp-cache.0.cache=cachename,smp-cache.0.topology=topologylevel\n"
+    "                sgx-epc.0.memdev=memid,sgx-epc.0.node=numaid\n",
     QEMU_ARCH_ALL)
 SRST
 ``-machine [type=]name[,prop=value[,...]]``
@@ -200,17 +201,13 @@ SRST
         ::
 
             -machine smp-cache.0.cache=l1d,smp-cache.0.topology=core,smp-cache.1.cache=l1i,smp-cache.1.topology=core
-ERST
-
-DEF("M", HAS_ARG, QEMU_OPTION_M,
-    "                sgx-epc.0.memdev=memid,sgx-epc.0.node=numaid\n",
-    QEMU_ARCH_ALL)
 
-SRST
-``sgx-epc.0.memdev=@var{memid},sgx-epc.0.node=@var{numaid}``
-    Define an SGX EPC section.
+    ``sgx-epc.0.memdev=@var{memid},sgx-epc.0.node=@var{numaid}``
+        Define an SGX EPC section.
 ERST
 
+DEF("M", HAS_ARG, QEMU_OPTION_M, "", QEMU_ARCH_ALL)
+
 DEF("cpu", HAS_ARG, QEMU_OPTION_cpu,
     "-cpu cpu        select CPU ('-cpu help' for list)\n", QEMU_ARCH_ALL)
 SRST
-- 
2.43.0


