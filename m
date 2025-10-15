Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A0DCCD192
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 04:27:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8t5q-0000Um-MD; Wed, 15 Oct 2025 00:26:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v8t5o-0000Tn-OA; Wed, 15 Oct 2025 00:26:28 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v8t5k-0002th-Ln; Wed, 15 Oct 2025 00:26:28 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B987815D9D4;
 Wed, 15 Oct 2025 07:25:18 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5D45D29FE7B;
 Wed, 15 Oct 2025 07:25:40 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [Stable-10.0.6 01/13] Revert "target/i386: do not expose
 ARCH_CAPABILITIES on AMD CPU"
Date: Wed, 15 Oct 2025 07:25:25 +0300
Message-ID: <20251015042540.68611-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.6-20251014174303@cover.tls.msk.ru>
References: <qemu-stable-10.0.6-20251014174303@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

This reverts commit 24778b1c7ee7aca9721ed4757b0e0df0c16390f7
(v10.0.2-66-g24778b1c7ee7) from the 10.0.x branch.

The problem is that the change makes qemu 10.0.x non-migratable
to subsequent qemu versions, since it requires introducing a new
machine type.

This revert re-introduces the problem with windows guests (which
is already fixed in windows but not in prior versions).
Details: https://gitlab.com/qemu-project/qemu/-/issues/3001

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 70d6095be9..e88e5d17db 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -500,12 +500,8 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
          * Linux v4.17-v4.20 incorrectly return ARCH_CAPABILITIES on SVM hosts.
          * We can detect the bug by checking if MSR_IA32_ARCH_CAPABILITIES is
          * returned by KVM_GET_MSR_INDEX_LIST.
-         *
-         * But also, because Windows does not like ARCH_CAPABILITIES on AMD
-         * mcahines at all, do not show the fake ARCH_CAPABILITIES MSR that
-         * KVM sets up.
          */
-        if (!has_msr_arch_capabs || !(edx & CPUID_7_0_EDX_ARCH_CAPABILITIES)) {
+        if (!has_msr_arch_capabs) {
             ret &= ~CPUID_7_0_EDX_ARCH_CAPABILITIES;
         }
     } else if (function == 7 && index == 1 && reg == R_EAX) {
-- 
2.47.3


