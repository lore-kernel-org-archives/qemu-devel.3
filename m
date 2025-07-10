Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E860FC83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 14:29:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZsGE-0008SZ-Vb; Thu, 10 Jul 2025 10:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uZsB6-0003EX-Sc
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 10:23:13 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uZsB5-0007zH-3y
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 10:23:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752157391; x=1783693391;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=lBKfvaIJvzPZuEp20uyNOz1o+SCdP37C8oFsLm6xaFk=;
 b=j4kd0VF7CjKVDF3uNjLb/qlv9lPhaphiKTGGPir458yhYbXAFsl/GgJr
 zyjVgraJC4nuC217CiM6Fm5b5zV1/eNXRe/wxWtdH+js8Dt9P4McdsHLM
 Mbk/CHFjwsGG33Rn3ce9SgVMHrtwoZ4IX6p3xl95bHjPIgUENqcHG6Cvc
 Ca9i1vrIRnM4tGnrBtZ31jLqDIndG7lukD3V0zUU+RuqGj2h2Nh8JxUuQ
 2tIMWfA7MSdSAXfYoyjGxA+gniaO++oJdrGG2id8Jf2kwSwVGWBA29OSf
 zn1lxYlLreQ+w7rfyV/shd6z2oCQPnylkz3PUAuyRU9YXhh/imA2IMhSm g==;
X-CSE-ConnectionGUID: i1j6MwTZTh2NsqHlumgH8w==
X-CSE-MsgGUID: JI+ZqmwKSDuZkFEGu6yqTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="53660755"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; d="scan'208";a="53660755"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2025 07:23:09 -0700
X-CSE-ConnectionGUID: QTBx8lOQR2Wp8K0otRotCg==
X-CSE-MsgGUID: Ua1o670WR3+AFtF591sB3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; d="scan'208";a="155509418"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa006.jf.intel.com with ESMTP; 10 Jul 2025 07:23:07 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH] i386/tdx: Use .has_gpa field to check if the gpa is valid
Date: Thu, 10 Jul 2025 22:15:12 +0800
Message-ID: <20250710141512.170302-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.18; envelope-from=xiaoyao.li@intel.com;
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

There is actually the .has_gpa field when translating the QAPI data
type GuestPanicInformationTdx to C structure.

Stop using the magic number -1 as the indicator for no valid gpa.
Instead just use .has_gpa field.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 system/runstate.c     | 2 +-
 target/i386/kvm/tdx.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/system/runstate.c b/system/runstate.c
index 38900c935a35..87cdcab4f388 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -690,7 +690,7 @@ void qemu_system_guest_panicked(GuestPanicInformation *info)
                           " error code: 0x%" PRIx32 " error message:\"%s\"\n",
                           info->u.tdx.error_code, message);
             g_free(message);
-            if (info->u.tdx.gpa != -1ull) {
+            if (info->u.tdx.has_gpa) {
                 qemu_log_mask(LOG_GUEST_ERROR, "Additional error information "
                               "can be found at gpa page: 0x%" PRIx64 "\n",
                               info->u.tdx.gpa);
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 370a9b6e656c..14704eb523c5 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -1298,7 +1298,7 @@ int tdx_handle_report_fatal_error(X86CPU *cpu, struct kvm_run *run)
     uint64_t reg_mask = run->system_event.data[R_ECX];
     char *message = NULL;
     uint64_t *tmp;
-    uint64_t gpa = -1ull;
+    uint64_t gpa = 0;
     bool has_gpa = false;
 
     if (error_code & 0xffff) {
-- 
2.43.0


