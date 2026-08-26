Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA15C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 03:36:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz4QQ-0004wM-Oz; Tue, 25 Aug 2026 23:35:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kishen.maloor@intel.com>)
 id 1wz4QP-0004rg-9H
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 23:35:41 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kishen.maloor@intel.com>)
 id 1wz4QN-00074B-3z
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 23:35:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787715339; x=1819251339;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=r8OGA1E4Kgzq5lM4GWV1Y2V9ktJQGlzkwRiX5qY63q4=;
 b=afIdmBBDrcjeBEO1lA4APcPT3x78slxBEu3p6Hw25vHHV413IRuHorSY
 8WaFylgjNsfYitDYAORbuRK+BhNE32xdDywizSZzV+6DAH6WM8epAb1eM
 QqSov/34mZYX8dVDjw5QrEONHDxpI7BTGg/EpW0T7eVAVjI7Bq0vOeLqv
 uInN+oHhUauOatPg6znpT2o6fWX4+8UFYcaWSWw/4v6LdRhIy3rkeWe23
 g63DWugLv+UVP3vrMvvYKLi1crNb/q9yoKSfr3NC7Nm7vAaphemUDsDk6
 qbj52kEKtD3D6W7aVNBQsn6sUNAg6DceDdBGKEICN8ls2f24YI3t3iiUL g==;
X-CSE-ConnectionGUID: ciAojpdYRParvy/BYZpLfw==
X-CSE-MsgGUID: kiShrs1IQYOlJG3WbuGJdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="75728377"
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; d="scan'208";a="75728377"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2026 20:35:31 -0700
X-CSE-ConnectionGUID: VecMJVsPRamcTwE1P4SDxA==
X-CSE-MsgGUID: abejyrZwQ+WzXLKojnlnMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; d="scan'208";a="297364014"
Received: from d404e69c8b80.jf.intel.com ([10.54.34.91])
 by orviesa002.jf.intel.com with ESMTP; 25 Aug 2026 20:35:31 -0700
From: Kishen Maloor <kishen.maloor@intel.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, kvm@vger.kernel.org,
 sohil.mehta@intel.com, xiaoyao.li@intel.com, binbin.wu@linux.intel.com,
 farrah.chen@intel.com, kishen.maloor@intel.com
Subject: [PATCH 2/5] target/i386: Add LASS support in CR4
Date: Tue, 25 Aug 2026 20:57:31 -0700
Message-ID: <20260826035734.114685-3-kishen.maloor@intel.com>
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

CR4.LASS[bit 27] enables Linear Address Space Separation, and may be set
only when CPUID.(EAX=7,ECX=1):EAX[6] enumerates LASS.

Recognize CR4.LASS as a valid bit by adding CR4_LASS_MASK to the known
bits, i.e. clearing it from CR4_RESERVED_MASK. Mark it reserved in
cr4_reserved_bits() and clear it in cpu_x86_update_cr4() when the guest
CPUID does not enumerate LASS. This keeps CR4 handling consistent on
paths that reach cpu_x86_update_cr4(), such as gdbstub register writes.

LASS is not emulated by TCG, so it is not added to TCG_7_1_EAX_FEATURES
and cannot be set under TCG (helper_write_crN() and helper_vmrun() both
reject reserved bits via cr4_reserved_bits()).

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
[kishen: rewrote commit message, rebased, fixed formatting]
Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
---
 target/i386/cpu.h    | 7 ++++++-
 target/i386/helper.c | 4 ++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index e6a197602d..98c406db32 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -277,6 +277,7 @@ typedef enum X86Seg {
 #define CR4_PKE_MASK   (1U << 22)
 #define CR4_CET_MASK   (1U << 23)
 #define CR4_PKS_MASK   (1U << 24)
+#define CR4_LASS_MASK  (1U << 27)
 #define CR4_LAM_SUP_MASK (1U << 28)
 
 #ifdef TARGET_X86_64
@@ -293,7 +294,8 @@ typedef enum X86Seg {
                 | CR4_LA57_MASK \
                 | CR4_FSGSBASE_MASK | CR4_PCIDE_MASK | CR4_OSXSAVE_MASK \
                 | CR4_SMEP_MASK | CR4_SMAP_MASK | CR4_PKE_MASK | CR4_CET_MASK \
-                | CR4_PKS_MASK | CR4_LAM_SUP_MASK | CR4_FRED_MASK))
+                | CR4_PKS_MASK | CR4_LASS_MASK | CR4_LAM_SUP_MASK \
+                | CR4_FRED_MASK))
 
 #define DR6_BD          (1 << 13)
 #define DR6_BS          (1 << 14)
@@ -3064,6 +3066,9 @@ static inline uint64_t cr4_reserved_bits(CPUX86State *env)
     if (!(env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_PKS)) {
         reserved_bits |= CR4_PKS_MASK;
     }
+    if (!(env->features[FEAT_7_1_EAX] & CPUID_7_1_EAX_LASS)) {
+        reserved_bits |= CR4_LASS_MASK;
+    }
     if (!(env->features[FEAT_7_1_EAX] & CPUID_7_1_EAX_LAM)) {
         reserved_bits |= CR4_LAM_SUP_MASK;
     }
diff --git a/target/i386/helper.c b/target/i386/helper.c
index 6836214162..43cfcfdafe 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -229,6 +229,10 @@ void cpu_x86_update_cr4(CPUX86State *env, uint32_t new_cr4)
         new_cr4 &= ~CR4_PKS_MASK;
     }
 
+    if (!(env->features[FEAT_7_1_EAX] & CPUID_7_1_EAX_LASS)) {
+        new_cr4 &= ~CR4_LASS_MASK;
+    }
+
     if (!(env->features[FEAT_7_1_EAX] & CPUID_7_1_EAX_LAM)) {
         new_cr4 &= ~CR4_LAM_SUP_MASK;
     }
-- 
2.47.1


