Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 791B7D3E793
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 05:45:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTZUR-0005BC-Cc; Thu, 11 Dec 2025 00:45:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vTZU7-0004k6-3o
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 00:45:03 -0500
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vTZU5-0001ci-BS
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 00:45:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765431901; x=1796967901;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0uF8jj575zYxVcWmkztmsgjmlH5SFSks+bBKxFEAv3A=;
 b=NEsXGvmc/A+DgMj0wOX5tLuU3Vab32ONrPp5oFZ/KkgZjTcxsTcFW5x5
 e16wma0Xr96RW4zhCxplrguzQNqVW9zKDUm6muspKJA6CcjRnDiGW57zi
 PHSRaeaXBiYotTL0MdfnUZbjbJNYveYOpFp6tZ0soEPXGoLhL+1EmaS0+
 9nJlW7hg9SutW0xwnIQ/RjRUayNkqPb3Xox/cqv8UFy/X065lzpsqw1sx
 9DfKxjtVh+v1FlUL4eozmrdKeCRA0kutcWkFFlgFPL5EQwF9HnfyUxvjV
 RZobycvXhTH3MvNtxYa30wJZVRhGGjx8RCKM3Tyu3TEtvxTCf0e9Soa78 A==;
X-CSE-ConnectionGUID: d8MCDKTgRxKS8YiKLyU1pw==
X-CSE-MsgGUID: +F877dGCTS+PJkVTcf/2oQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="66410017"
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="66410017"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2025 21:44:48 -0800
X-CSE-ConnectionGUID: R+WptcuRQoWiK19k3FqoBQ==
X-CSE-MsgGUID: LYgSZ0qYRROV8ROnrBh0cQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="227366269"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa002.jf.intel.com with ESMTP; 10 Dec 2025 21:44:44 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Chao Gao <chao.gao@intel.com>,
 Xin Li <xin@zytor.com>, John Allen <john.allen@amd.com>,
 Babu Moger <babu.moger@amd.com>, Mathias Krause <minipli@grsecurity.net>,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 Farrah Chen <farrah.chen@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v5 22/22] i386/tdx: Add CET SHSTK/IBT into the supported CPUID
 by XFAM
Date: Thu, 11 Dec 2025 14:08:01 +0800
Message-Id: <20251211060801.3600039-23-zhao1.liu@intel.com>
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

From: Chenyi Qiang <chenyi.qiang@intel.com>

So that it can be configured in TD guest.

And considerring CET_U and CET_S bits are always same in supported
XFAM reported by TDX module, i.e., either 00 or 11. So, only need to
choose one of them.

Tested-by: Farrah Chen <farrah.chen@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes Since v3:
 - Refine the commit message.
---
 target/i386/kvm/tdx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index a3444623657f..01619857685b 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -526,6 +526,8 @@ TdxXFAMDep tdx_xfam_deps[] = {
     { XSTATE_OPMASK_BIT,    { FEAT_7_0_EDX, CPUID_7_0_EDX_AVX512_FP16 } },
     { XSTATE_PT_BIT,        { FEAT_7_0_EBX, CPUID_7_0_EBX_INTEL_PT } },
     { XSTATE_PKRU_BIT,      { FEAT_7_0_ECX, CPUID_7_0_ECX_PKU } },
+    { XSTATE_CET_U_BIT,     { FEAT_7_0_ECX, CPUID_7_0_ECX_CET_SHSTK } },
+    { XSTATE_CET_U_BIT,     { FEAT_7_0_EDX, CPUID_7_0_EDX_CET_IBT } },
     { XSTATE_XTILE_CFG_BIT, { FEAT_7_0_EDX, CPUID_7_0_EDX_AMX_BF16 } },
     { XSTATE_XTILE_CFG_BIT, { FEAT_7_0_EDX, CPUID_7_0_EDX_AMX_TILE } },
     { XSTATE_XTILE_CFG_BIT, { FEAT_7_0_EDX, CPUID_7_0_EDX_AMX_INT8 } },
-- 
2.34.1


