Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA6D6C83F0F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 03:57:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZiOF-0001fY-5p; Wed, 09 Jul 2025 23:56:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uZiOB-0001el-FY
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 23:56:03 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uZiO4-0002Zx-JO
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 23:56:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752119756; x=1783655756;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=mIduiIXmV1zIlymX0XsoBEgD5bSj+IkShTS52BTU3Zc=;
 b=NIjHwA3TEe21x41lB5mcJ8L/Hu+9IiDbX85/JyKZW1M/jxwPxglRs4X5
 rZ/ctOoilqSksvK9Q5K9yGkDQcKDruslXCLVNjAbqQo77dVxgG7qhojoS
 fFPXE5/CoEWz0YctAft4bvwbEwjMFRZfjCE7ateGboanmvFbV1dck/As8
 twlXeP94ZcidQJBTS/LvBFQVxfeeez4zH0rZQI7Wvh/F1JCbODrDQiLac
 ewI19MJAK44ogAwtw9rN2ZKztN90jZkj4Eee1C/CBXLA+ukED+kY7BD7G
 TyIwzFVg2ckoG6Y/D8TCvuyGLvfg1GJH5wpInA8wzKMBli+9WFUT7Zj3N w==;
X-CSE-ConnectionGUID: vnKYYOxkTpi6vehp2yydrw==
X-CSE-MsgGUID: vegc0BjIRCaOd5EIVrH4vQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="54537459"
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; d="scan'208";a="54537459"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2025 20:55:48 -0700
X-CSE-ConnectionGUID: SiwX7ojnSqadqm2TvuT1xQ==
X-CSE-MsgGUID: CmYpUlcVRKeyz17bsOn+og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; d="scan'208";a="159976458"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2025 20:55:47 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, xiaoyao.li@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH] i386/tdx: Fix the report of gpa in QAPI
Date: Wed,  9 Jul 2025 23:55:38 -0400
Message-ID: <20250710035538.303136-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.15;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=0.001,
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

Gpa is defined in QAPI but never reported to monitor because has_gpa is
never set to ture.

Fix it by setting has_gpa to ture when TDX_REPORT_FATAL_ERROR_GPA_VALID
is set in error_code.

Fixes: 6e250463b08b ("i386/tdx: Wire TDX_REPORT_FATAL_ERROR with GuestPanic facility")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 target/i386/kvm/tdx.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index e809e4b2df..370a9b6e65 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -1269,7 +1269,8 @@ void tdx_handle_get_tdvmcall_info(X86CPU *cpu, struct kvm_run *run)
 }
 
 static void tdx_panicked_on_fatal_error(X86CPU *cpu, uint64_t error_code,
-                                        char *message, uint64_t gpa)
+                                        char *message, bool has_gpa,
+                                        uint64_t gpa)
 {
     GuestPanicInformation *panic_info;
 
@@ -1278,6 +1279,7 @@ static void tdx_panicked_on_fatal_error(X86CPU *cpu, uint64_t error_code,
     panic_info->u.tdx.error_code = (uint32_t) error_code;
     panic_info->u.tdx.message = message;
     panic_info->u.tdx.gpa = gpa;
+    panic_info->u.tdx.has_gpa = has_gpa;
 
     qemu_system_guest_panicked(panic_info);
 }
@@ -1297,6 +1299,7 @@ int tdx_handle_report_fatal_error(X86CPU *cpu, struct kvm_run *run)
     char *message = NULL;
     uint64_t *tmp;
     uint64_t gpa = -1ull;
+    bool has_gpa = false;
 
     if (error_code & 0xffff) {
         error_report("TDX: REPORT_FATAL_ERROR: invalid error code: 0x%"PRIx64,
@@ -1329,9 +1332,10 @@ int tdx_handle_report_fatal_error(X86CPU *cpu, struct kvm_run *run)
 
     if (error_code & TDX_REPORT_FATAL_ERROR_GPA_VALID) {
         gpa = run->system_event.data[R_R13];
+        has_gpa = true;
     }
 
-    tdx_panicked_on_fatal_error(cpu, error_code, message, gpa);
+    tdx_panicked_on_fatal_error(cpu, error_code, message, has_gpa, gpa);
 
     return -1;
 }
-- 
2.47.1


