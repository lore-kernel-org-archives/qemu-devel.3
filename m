Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A94C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 04:41:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYeel-0002S7-8a; Tue, 30 Jul 2024 00:40:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sYeek-0002Oe-8h
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 00:40:14 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sYeei-0006Bm-ET
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 00:40:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1722314413; x=1753850413;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=cO8APYbdqznN8knoscacJL2ZntmQ4Beu6oELSifWUR0=;
 b=iID1x1SzXT8DHjbkxKQL6qRO37kbd/O+kFQODiW1jeKMB5+AdvpEPf5d
 MI14kt8+o7Dm8HjD/1pJGRoNdhNcSGI9qmcujaI7STk4fswSVPp0wJz2F
 5V21q47WtBWbG23s6OsG3qjx3yWUmJzUl87nV1SdKmFp3hZoRzEvE2QZZ
 iAcuvRS5hAvBDYKQ/afo08TXwwzvny8GIKC5ig0p482wFyvUAYKsHADFB
 DczOXKrwwDi2+LbknB3kViwJVWNZ5Asg4r95N6lp4KR6kDM2v5j/oHD1f
 XJ5w2SO9RUc9XT7QmVgRqsLmSUw2pt8ZD5wE9QXEHy1XASBIPURf5+9bf g==;
X-CSE-ConnectionGUID: hdy3z9IMTg27qh62tFKXeg==
X-CSE-MsgGUID: /Fmg1SIsQROanHNfAeUA4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="20288541"
X-IronPort-AV: E=Sophos;i="6.09,247,1716274800"; d="scan'208";a="20288541"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2024 21:40:09 -0700
X-CSE-ConnectionGUID: enGiqNH0QJWTpJQtjwSJ7Q==
X-CSE-MsgGUID: a52CgpznQ3uw781Hg12p8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,247,1716274800"; d="scan'208";a="77429910"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa002.fm.intel.com with ESMTP; 29 Jul 2024 21:40:07 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 1/4] target/i386/cpu: Remove unnecessary SGX feature words
 checks
Date: Tue, 30 Jul 2024 12:55:41 +0800
Message-Id: <20240730045544.2516284-2-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730045544.2516284-1-zhao1.liu@intel.com>
References: <20240730045544.2516284-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

CPUID.0x7.0.ebx and CPUID.0x7.0.ecx leaves have been expressed as the
feature word lists, and the Host capability support has been checked
in x86_cpu_filter_features().

Therefore, such checks on SGX feature "words" are redundant, and
the follow-up adjustments to those feature "words" will not actually
take effect.

Remove unnecessary SGX feature words related checks.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 4688d140c2d9..2b3642c9b13c 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6537,8 +6537,6 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
     case 7:
         /* Structured Extended Feature Flags Enumeration Leaf */
         if (count == 0) {
-            uint32_t eax_0_unused, ebx_0, ecx_0, edx_0_unused;
-
             /* Maximum ECX value for sub-leaves */
             *eax = env->cpuid_level_func7;
             *ebx = env->features[FEAT_7_0_EBX]; /* Feature flags */
@@ -6548,20 +6546,8 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             }
             *edx = env->features[FEAT_7_0_EDX]; /* Feature flags */
 
-            /*
-             * SGX cannot be emulated in software.  If hardware does not
-             * support enabling SGX and/or SGX flexible launch control,
-             * then we need to update the VM's CPUID values accordingly.
-             */
-            x86_cpu_get_supported_cpuid(0x7, 0,
-                                        &eax_0_unused, &ebx_0,
-                                        &ecx_0, &edx_0_unused);
-            if ((*ebx & CPUID_7_0_EBX_SGX) && !(ebx_0 & CPUID_7_0_EBX_SGX)) {
-                *ebx &= ~CPUID_7_0_EBX_SGX;
-            }
-
             if ((*ecx & CPUID_7_0_ECX_SGX_LC)
-                    && (!(*ebx & CPUID_7_0_EBX_SGX) || !(ecx_0 & CPUID_7_0_ECX_SGX_LC))) {
+                    && (!(*ebx & CPUID_7_0_EBX_SGX))) {
                 *ecx &= ~CPUID_7_0_ECX_SGX_LC;
             }
         } else if (count == 1) {
-- 
2.34.1


