Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A050D1CA3A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 06:45:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8DBT-0004Tt-8p; Tue, 05 Nov 2024 01:36:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8DBR-0004TS-Ji
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 01:36:57 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8DBQ-0001qk-0m
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 01:36:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730788616; x=1762324616;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=EMCLkioz6PKqWrBweYilnMeVfCok800taR5KSHSziyM=;
 b=ex7fURO97IP1Mnie9L9kaek2P6LE2N3bBmsgV40PoZ3slT5V0HZobbFk
 OHT/uGJS8NvuQFleHu9FXitG8Bw/a6y0jdFVjx6JuoLC2WXLKOotPDCnN
 lCQumcZQzuxSAOqqk/47sLKyTz/Cz1Hw0/mTqlRj4Og7MVrncHH+YKt8d
 mpjfb+8pkbWH++0KrTo+UhDkmfrmhzrZy6v5ubeQ52aTVXb/Tw/kHfKlc
 rdJRN0XvqchV00YG+MrEr+EaKBfdYOpFdKIwS/eMQPhwR4Q6rl9S6ah+B
 DLTOxF0ljV53TqBO6zH+gOKNHtWFuqATETSwgmdGEnLXWjrMRWsEzdP3t A==;
X-CSE-ConnectionGUID: EgG+jOotSNqpzsvQeUJ0vA==
X-CSE-MsgGUID: GdAGFcRNR9uw+qDFV2sr1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30689337"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="30689337"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2024 22:36:55 -0800
X-CSE-ConnectionGUID: /mqITyi7TM+2Y+yCpFQ9lQ==
X-CSE-MsgGUID: mzsjznpqSTuIPYeKU0/kIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; d="scan'208";a="83988646"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa009.fm.intel.com with ESMTP; 04 Nov 2024 22:36:51 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, rick.p.edgecombe@intel.com,
 kvm@vger.kernel.org, qemu-devel@nongnu.org, xiaoyao.li@intel.com
Subject: [PATCH v6 08/60] i386/kvm: Export cpuid_entry_get_reg() and
 cpuid_find_entry()
Date: Tue,  5 Nov 2024 01:23:16 -0500
Message-Id: <20241105062408.3533704-9-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105062408.3533704-1-xiaoyao.li@intel.com>
References: <20241105062408.3533704-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.781, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/kvm/kvm.c      | 8 ++++----
 target/i386/kvm/kvm_i386.h | 4 ++++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index b843de7f2379..afbf67a7fdaa 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -395,7 +395,7 @@ static bool host_tsx_broken(void)
 
 /* Returns the value for a specific register on the cpuid entry
  */
-static uint32_t cpuid_entry_get_reg(struct kvm_cpuid_entry2 *entry, int reg)
+uint32_t cpuid_entry_get_reg(struct kvm_cpuid_entry2 *entry, int reg)
 {
     uint32_t ret = 0;
     switch (reg) {
@@ -417,9 +417,9 @@ static uint32_t cpuid_entry_get_reg(struct kvm_cpuid_entry2 *entry, int reg)
 
 /* Find matching entry for function/index on kvm_cpuid2 struct
  */
-static struct kvm_cpuid_entry2 *cpuid_find_entry(struct kvm_cpuid2 *cpuid,
-                                                 uint32_t function,
-                                                 uint32_t index)
+struct kvm_cpuid_entry2 *cpuid_find_entry(struct kvm_cpuid2 *cpuid,
+                                          uint32_t function,
+                                          uint32_t index)
 {
     int i;
     for (i = 0; i < cpuid->nent; ++i) {
diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
index 7ac4c3a91171..efb0883bd968 100644
--- a/target/i386/kvm/kvm_i386.h
+++ b/target/i386/kvm/kvm_i386.h
@@ -67,6 +67,10 @@ bool kvm_has_waitpkg(void);
 uint64_t kvm_swizzle_msi_ext_dest_id(uint64_t address);
 void kvm_update_msi_routes_all(void *private, bool global,
                                uint32_t index, uint32_t mask);
+uint32_t cpuid_entry_get_reg(struct kvm_cpuid_entry2 *entry, int reg);
+struct kvm_cpuid_entry2 *cpuid_find_entry(struct kvm_cpuid2 *cpuid,
+                                          uint32_t function,
+                                          uint32_t index);
 
 #endif /* CONFIG_KVM */
 
-- 
2.34.1


