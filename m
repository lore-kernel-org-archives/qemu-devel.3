Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55EA4CCD1AB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 06:36:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCBOX-0003Ym-Bt; Fri, 24 Oct 2025 02:35:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vCBOR-0003Xu-4q
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 02:35:19 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vCBOP-0003kG-BG
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 02:35:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761287717; x=1792823717;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=q1llAB51wlYD8DExeRchjbchwIbqPcgnJ8aGmhooIHs=;
 b=By965o7DuvBgMG7lNCDnN96JwA8X67cTSlUpv4cY7C/8UD1ga60SZ9fp
 NmAMUnZF5BYnQWt7PPPvwEl9Srlm9YV3OZCSFg1NRTvmwpEhnXC3GBNt5
 7QMQc889PC2u/ZEBBuFwkixk3BY+5eIHajLUheQbQWGUme6St0abk0OMi
 dqMTTv/l+q+3BnQwRn9AGHqnuPP6c6PkVZZGRSmP1nPrAVjA84GrXC99S
 0P5ekR2dBcKQEk3rTuuWG0bZxTIFzhlBt2TEpBigAUn2AJpm6WICXeKIZ
 N0aLE1QgGIe/dbgm78ce9EC+Mdgevap9DOVL2KSmHFnBwQz30S1pU/ANx Q==;
X-CSE-ConnectionGUID: AEUk+y4fT52k7fLQJR8Y6g==
X-CSE-MsgGUID: kFxMChShQimR3bbxMo5ZTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74137891"
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; d="scan'208";a="74137891"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2025 23:35:17 -0700
X-CSE-ConnectionGUID: zdda8MoeRuaoDINh3c/nxA==
X-CSE-MsgGUID: mKBG2dchQsOb/9ZT/rM9Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; d="scan'208";a="184276073"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa006.fm.intel.com with ESMTP; 23 Oct 2025 23:35:14 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Chao Gao <chao.gao@intel.com>,
 John Allen <john.allen@amd.com>, Babu Moger <babu.moger@amd.com>,
 Mathias Krause <minipli@grsecurity.net>, Dapeng Mi <dapeng1.mi@intel.com>,
 Zide Chen <zide.chen@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 10/20] i386/cpu: Add missing migratable xsave features
Date: Fri, 24 Oct 2025 14:56:22 +0800
Message-Id: <20251024065632.1448606-11-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251024065632.1448606-1-zhao1.liu@intel.com>
References: <20251024065632.1448606-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Xtile-cfg & xtile-data are both user xstates. Their xstates are cached
in X86CPUState, and there's a related vmsd "vmstate_amx_xtile", so that
it's safe to mark them as migratable.

Arch lbr xstate is a supervisor xstate, and it is save & load by saving
& loading related arch lbr MSRs, which are cached in X86CPUState, and
there's a related vmsd "vmstate_arch_lbr". So it's also safe to mark it
as migratable (even though KVM hasn't supported it - its migration
support is completed in QEMU).

PT is still unmigratable since KVM disabled it and there's no vmsd and
no other emulation/simulation support.

Tested-by: Farrah Chen <farrah.chen@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1917376dbea9..b01729ad36d2 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1522,7 +1522,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .migratable_flags = XSTATE_FP_MASK | XSTATE_SSE_MASK |
             XSTATE_YMM_MASK | XSTATE_BNDREGS_MASK | XSTATE_BNDCSR_MASK |
             XSTATE_OPMASK_MASK | XSTATE_ZMM_Hi256_MASK | XSTATE_Hi16_ZMM_MASK |
-            XSTATE_PKRU_MASK,
+            XSTATE_PKRU_MASK | XSTATE_ARCH_LBR_MASK | XSTATE_XTILE_CFG_MASK |
+            XSTATE_XTILE_DATA_MASK,
     },
     [FEAT_XSAVE_XCR0_HI] = {
         .type = CPUID_FEATURE_WORD,
-- 
2.34.1


