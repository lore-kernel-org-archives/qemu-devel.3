Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86275CD4F26
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 08:35:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMiZM-00023V-9G; Tue, 12 May 2026 04:34:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1wMiZK-00022h-5t
 for qemu-devel@nongnu.org; Tue, 12 May 2026 04:34:22 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1wMiZH-00005Q-JD
 for qemu-devel@nongnu.org; Tue, 12 May 2026 04:34:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778574860; x=1810110860;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7RIfmRFxhE7Bt/J8eFND2kVyc/t5pAosMx3RGwcy/aE=;
 b=WseB3Z7TOAg/X8Vno6T5T255iN1i0sFiPggK/hphXvTyGIAxzWUkkNAV
 Gs85rmYddF1/GH4TLoVuiLCEvMfN4qL8qPU5oI2etmRhpZgtuLBPccBt8
 sh5Kw0AcFOa06TLqdnu1U2xQFJJCjGoN/Rj0OMttwFEMe2OOTbha4Pol3
 s57huAtj7V7I2epDTJTX2jZ5p1WCPwmqez0z+wrnVgsVpzL1L7eqLdsm6
 8vGGNONqGnGkGQSnlQKWlX6uospcpO/cDBQfNKNM1H7ClylCsKIrSl3tQ
 ES/u6l7TBaUor1atYft+zLk7MQpW/EtVJ+xx71SI2dwHKLyBPOo/MjAbk g==;
X-CSE-ConnectionGUID: tOJEXnH+TpWwYLnTFn+S7g==
X-CSE-MsgGUID: 7gEY+i70TR+vHt+pIkWNJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="90060001"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; d="scan'208";a="90060001"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2026 01:34:16 -0700
X-CSE-ConnectionGUID: RNyc/RtFRHy57Z/Obm7dhg==
X-CSE-MsgGUID: JMvop23qQ4CVT13LZ67/aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; d="scan'208";a="237947177"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.22])
 by orviesa007.jf.intel.com with ESMTP; 12 May 2026 01:34:13 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, xiaoyao.li@intel.com
Subject: [PATCH 1/3] i386/tdx: Use .has_gpa field to check if the gpa is valid
Date: Tue, 12 May 2026 16:21:06 +0800
Message-ID: <20260512082108.621596-2-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512082108.621596-1-xiaoyao.li@intel.com>
References: <20260512082108.621596-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.11; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

When translating the QAPI type GuestPanicInformationTdx into its C
struct, the generated code provides a .has_gpa boolean field to indicate
whether the optional gpa field is present.

Replace the magic sentinel value -1ULL, previously used to signal "no
valid GPA", with the idiomatic .has_gpa field.  This removes the
implicit sentinel coupling and makes the validity check self-documenting.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
Refine the commit message when re-sending it.
---
 system/runstate.c     | 2 +-
 target/i386/kvm/tdx.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/system/runstate.c b/system/runstate.c
index 770253b467b5..2bb36b2a7247 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -704,7 +704,7 @@ void qemu_system_guest_panicked(GuestPanicInformation *info)
                           " error code: 0x%" PRIx32 " error message:\"%s\"\n",
                           info->u.tdx.error_code, message);
             g_free(message);
-            if (info->u.tdx.gpa != -1ull) {
+            if (info->u.tdx.has_gpa) {
                 qemu_log_mask(LOG_GUEST_ERROR, "Additional error information "
                               "can be found at gpa page: 0x%" PRIx64 "\n",
                               info->u.tdx.gpa);
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 4714c9d514ef..6f93997d62db 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -1403,7 +1403,7 @@ int tdx_handle_report_fatal_error(X86CPU *cpu, struct kvm_run *run)
     uint64_t reg_mask = run->system_event.data[R_ECX];
     char *message = NULL;
     uint64_t *tmp;
-    uint64_t gpa = -1ull;
+    uint64_t gpa = 0;
     bool has_gpa = false;
 
     if (error_code & 0xffff) {
-- 
2.43.0


