Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57AA7D13592
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 02:52:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5FqQ-0006C3-O0; Sun, 27 Oct 2024 22:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1t5FqN-0006Am-Vk
 for qemu-devel@nongnu.org; Sun, 27 Oct 2024 22:51:00 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1t5FqM-0003WX-81
 for qemu-devel@nongnu.org; Sun, 27 Oct 2024 22:50:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730083858; x=1761619858;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uqCmlBDPxdFAZ6R2ZOQQB24kZBtiSAMNmvoOZ1hr4Qc=;
 b=KCjMTPDvciymLMb0UyMjCIFiUWBi65fIpgD4/yGUVb/ZJb18Dgm2N25j
 LN+RSBuWylFarO7yLIPl5mwSZUPcgtsp4Xz7b4k4WZkzAAJz3XRKECBD1
 owTWCZhC+3JoBFsc7RxYoffwN+g3l2UTE597TPsdZ/HqXqiWmUdhPdumR
 Ek1d9z78nmNnOmA7AFT5ZFVe1bzQ6KhwK3H58RjCfD6JD77JuBI4App2Q
 qvJRje0KTBhprOJ1nPAeOsztyEMckniDV4IfIevZlafDHvPEkghw2pC7X
 voaj6t7JSkHUCpdS/A/zSRKwofB5JBLIxuupLCrhBGIYDbQDuLofipTCt A==;
X-CSE-ConnectionGUID: QVqsrDBoTA+bRfmyTq1oBg==
X-CSE-MsgGUID: c87oW06gT2C2Yy07rSicwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="40249467"
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; d="scan'208";a="40249467"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2024 19:50:57 -0700
X-CSE-ConnectionGUID: 9Otd87SjQHmeoChDXsobNg==
X-CSE-MsgGUID: /HdGcNmNTaexwUz97qs5Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; d="scan'208";a="81420936"
Received: from st-server.bj.intel.com ([10.240.193.102])
 by orviesa009.jf.intel.com with ESMTP; 27 Oct 2024 19:50:55 -0700
From: Tao Su <tao1.su@linux.intel.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, xiaoyao.li@intel.com,
 xuelian.guo@intel.com, tao1.su@linux.intel.com
Subject: [PATCH 2/6] target/i386: add avx10-version property
Date: Mon, 28 Oct 2024 10:45:08 +0800
Message-Id: <20241028024512.156724-3-tao1.su@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028024512.156724-1-tao1.su@linux.intel.com>
References: <20241028024512.156724-1-tao1.su@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.198.163.11;
 envelope-from=tao1.su@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.287,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Introduce avx10-version property so that avx10 version can be controlled
by user and cpu model. Per spec, avx10 version can never be 0, the default
value of avx10-version is set to 0 to determine whether it is specified by
user.

Tested-by: Xuelian Guo <xuelian.guo@intel.com>
Signed-off-by: Tao Su <tao1.su@linux.intel.com>
---
 target/i386/cpu.c | 1 +
 target/i386/cpu.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index d845ff5e4e..5b434a107a 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8343,6 +8343,7 @@ static Property x86_cpu_properties[] = {
     DEFINE_PROP_UINT32("min-level", X86CPU, env.cpuid_min_level, 0),
     DEFINE_PROP_UINT32("min-xlevel", X86CPU, env.cpuid_min_xlevel, 0),
     DEFINE_PROP_UINT32("min-xlevel2", X86CPU, env.cpuid_min_xlevel2, 0),
+    DEFINE_PROP_UINT8("avx10-version", X86CPU, env.avx10_version, 0),
     DEFINE_PROP_UINT64("ucode-rev", X86CPU, ucode_rev, 0),
     DEFINE_PROP_BOOL("full-cpuid-auto-level", X86CPU, full_cpuid_auto_level, true),
     DEFINE_PROP_STRING("hv-vendor-id", X86CPU, hyperv_vendor),
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 280bec701c..d845384dcd 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1920,6 +1920,8 @@ typedef struct CPUArchState {
     uint32_t cpuid_vendor3;
     uint32_t cpuid_version;
     FeatureWordArray features;
+    /* AVX10 version */
+    uint8_t avx10_version;
     /* Features that were explicitly enabled/disabled */
     FeatureWordArray user_features;
     uint32_t cpuid_model[12];
-- 
2.34.1


