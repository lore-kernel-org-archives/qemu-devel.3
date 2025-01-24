Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A64C0218B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 13:47:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbJvR-0003CT-Iw; Fri, 24 Jan 2025 08:40:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tbJuv-0001Xa-1x
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 08:40:16 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tbJus-00042W-4Z
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 08:40:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737726011; x=1769262011;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=R7oHs5ceEXGmP8urc22iTrcnB1GDDwG0Hw6Vg6gX3CI=;
 b=gBqg/6/UWy+lz0GDW5Ndzb+69l489t4SA5+0K3qlkbuC1+prj1iAAh9r
 vqR7rkFIRfvgOGcB1av9FJI+SehHLz69Ri6LJASYzN0Yu2gh7foyZg5K9
 6EJQ8Xf/RjmALSTCboe2hQjIBQGBByQICb/BbBnCvD4KAmSfP74vST14v
 fSqM7+GfCRrp00YTyQbVd4q2D6Ka4DPdJbUWGot/kIp8U6dwmDaDhWrpz
 F9U3GoyfUf3PFqAYIx3rqtou1Ck84RHNN+iR4iJzxCidFrTrLZkuJqU/b
 vYePBC+5PISpH8Au5bdnrao4MQz97Ch7qacvdBl6oGYGmp12Qf+Abvrxg Q==;
X-CSE-ConnectionGUID: NFhqUiS3QdetSELa485LZA==
X-CSE-MsgGUID: HzgAtFfZRyqsFP5b0ogmJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11325"; a="49246589"
X-IronPort-AV: E=Sophos;i="6.13,231,1732608000"; d="scan'208";a="49246589"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jan 2025 05:39:48 -0800
X-CSE-ConnectionGUID: s00mDXelRF6zUi7uycCu8A==
X-CSE-MsgGUID: C0Ay4mYCR+eHJGN2vje7rQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="111804462"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa003.fm.intel.com with ESMTP; 24 Jan 2025 05:39:44 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Huacai Chen <chenhuacai@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>, xiaoyao.li@intel.com,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: [PATCH v7 44/52] i386/cpu: Move CPUID_XSTATE_XSS_MASK to header file
 and introduce CPUID_XSTATE_MASK
Date: Fri, 24 Jan 2025 08:20:40 -0500
Message-Id: <20250124132048.3229049-45-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124132048.3229049-1-xiaoyao.li@intel.com>
References: <20250124132048.3229049-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.13; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

They will be used by TDX.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/cpu.c | 3 ---
 target/i386/cpu.h | 5 +++++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 4088bf63c48f..f1330627adbb 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1829,9 +1829,6 @@ static const X86RegisterInfo32 x86_reg_info_32[CPU_NB_REGS32] = {
 };
 #undef REGISTER
 
-/* CPUID feature bits available in XSS */
-#define CPUID_XSTATE_XSS_MASK    (XSTATE_ARCH_LBR_MASK)
-
 ExtSaveArea x86_ext_save_areas[XSAVE_STATE_AREA_COUNT] = {
     [XSTATE_FP_BIT] = {
         /* x87 FP state component is always enabled if XSAVE is supported */
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 4890424c3a9e..a4c0531262ce 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -623,6 +623,11 @@ typedef enum X86Seg {
                                  XSTATE_Hi16_ZMM_MASK | XSTATE_PKRU_MASK | \
                                  XSTATE_XTILE_CFG_MASK | XSTATE_XTILE_DATA_MASK)
 
+/* CPUID feature bits available in XSS */
+#define CPUID_XSTATE_XSS_MASK    (XSTATE_ARCH_LBR_MASK)
+
+#define CPUID_XSTATE_MASK       (CPUID_XSTATE_XCR0_MASK | CPUID_XSTATE_XSS_MASK)
+
 /* CPUID feature words */
 typedef enum FeatureWord {
     FEAT_1_EDX,         /* CPUID[1].EDX */
-- 
2.34.1


