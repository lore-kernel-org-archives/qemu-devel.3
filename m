Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FFBBC61DBE
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 03:36:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz4QQ-0004u3-6d; Tue, 25 Aug 2026 23:35:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kishen.maloor@intel.com>)
 id 1wz4QO-0004o2-3E
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 23:35:40 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kishen.maloor@intel.com>)
 id 1wz4QM-0006wq-Ef
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 23:35:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787715338; x=1819251338;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mKgfwYnh3Nxsc7j3MuW13LeqbxyzE/A3vdhb9NnzUFI=;
 b=V9tkyCuLbZdxPA42f2TK4OuFn3+g9xp8mO4yMEO2CqchPfbd9MT/SsOQ
 sUhYbH4ZccYWCsDBej0lxC9XAUfWwQOiSdYiJbtrh62TkXiHH4SJi7G3d
 Z9OdClv7Rl+yhAmmcdRo/Yi1JTv+RdejVfCXrzlYFb2PjSxKeLqA0LFaM
 hrR+gOFKMzF698nsvWJTCrpmRE2Khva1bmAIqDCtHYsdfwmJEUrl/F32r
 nwKmRyfqkTXFQqAL8VBVnlRi7BymMDnnTMaHDKj27Jq6fSxQGRVjoUEuQ
 ghIkPExFBmtKygI+lUT1PqGf7U0b73TEF76E5TeUFukf7UGUkv13XAp/D A==;
X-CSE-ConnectionGUID: GKaSlIJTT06HPwZFQSdMdQ==
X-CSE-MsgGUID: XVkJ09AFTjyOobt2GojHCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="75728374"
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; d="scan'208";a="75728374"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2026 20:35:31 -0700
X-CSE-ConnectionGUID: Zouley78REiWurQpir744w==
X-CSE-MsgGUID: +b4IBeoWQXm0LteFefmUYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; d="scan'208";a="297364011"
Received: from d404e69c8b80.jf.intel.com ([10.54.34.91])
 by orviesa002.jf.intel.com with ESMTP; 25 Aug 2026 20:35:31 -0700
From: Kishen Maloor <kishen.maloor@intel.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, kvm@vger.kernel.org,
 sohil.mehta@intel.com, xiaoyao.li@intel.com, binbin.wu@linux.intel.com,
 farrah.chen@intel.com, kishen.maloor@intel.com
Subject: [PATCH 1/5] target/i386: Add support for LASS in CPUID enumeration
Date: Tue, 25 Aug 2026 20:57:30 -0700
Message-ID: <20260826035734.114685-2-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260826035734.114685-1-kishen.maloor@intel.com>
References: <20260826035734.114685-1-kishen.maloor@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.16;
 envelope-from=kishen.maloor@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Isaku Yamahata <isaku.yamahata@intel.com>

Linear Address Space Separation (LASS) is a security feature that
prevents a class of side-channel attacks relying on speculative
accesses across the user/kernel boundary. Paging, along with SMEP
and SMAP, already provides mode-based access protection, but
enforcing it requires a page walk whose timing can leak the
layout of kernel memory.

LASS applies the equivalent protections during linear-address
pre-processing, before any page walk. Given the usual partitioning of
the linear address space into a user half (bit 63 clear) and a
supervisor half (bit 63 set), an access targeting the opposite half is
rejected on the basis of bit 63 alone, raising a #GP. LASS is enabled
via CR4.LASS[bit 27] and applies only in IA-32e mode.

Feature bit:
  CPUID.(EAX=7,ECX=1):EAX[6]

A CPUID_7_1_EAX_LASS macro was previously added in commit 31df29c532a9
("i386/tdx: Add supported CPUID bits related to TD Attributes"), but the
bit was left unnamed in feature_word_info[FEAT_7_1_EAX]. Add the "lass"
feature name to expose it via -cpu host, -cpu max, or an explicit +lass.

Exposing LASS to a guest also requires KVM support: KVM must validate
the CPUID bit and CR4.LASS, and enforce LASS violations in its
instruction emulator.

LASS is not implemented in TCG, so the bit is not added to
TCG_7_1_EAX_FEATURES.

More details can be found in the Intel 64 and IA-32 Architectures
Software Developer's Manual, Volume 3A, Section 4.3,
"Linear-Address-Space Separation (LASS)".

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
[kishen: rewrote commit message, rebased]
Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
---
KVM support for LASS is currently under review:
https://lore.kernel.org/kvm/20260806011536.4172258-1-sohil.mehta@intel.com/

 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 5805d33ab9..5496e9475b 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1243,7 +1243,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
             "sha512", "sm3", "sm4", NULL,
-            "avx-vnni", "avx512-bf16", NULL, "cmpccxadd",
+            "avx-vnni", "avx512-bf16", "lass", "cmpccxadd",
             NULL, NULL, "fzrm", "fsrs",
             "fsrc", NULL, NULL, NULL,
             NULL, "fred", "lkgs", "wrmsrns",
-- 
2.47.1


