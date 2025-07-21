Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FB33C83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 20:04:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udwjj-0005EB-9n; Mon, 21 Jul 2025 16:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1udwj9-0004qC-29; Mon, 21 Jul 2025 16:03:24 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1udwj6-0004da-IG; Mon, 21 Jul 2025 16:03:10 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E61E5139043;
 Mon, 21 Jul 2025 23:02:47 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id A32C724BECF;
 Mon, 21 Jul 2025 23:03:03 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Alexandre Chartre <alexandre.chartre@oracle.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.3 66/70] target/i386: do not expose ARCH_CAPABILITIES on
 AMD CPU
Date: Mon, 21 Jul 2025 23:02:53 +0300
Message-ID: <20250721200302.133559-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-10.0.3-20250721221446@cover.tls.msk.ru>
References: <qemu-stable-10.0.3-20250721221446@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Paolo Bonzini <pbonzini@redhat.com>

KVM emulates the ARCH_CAPABILITIES on x86 for both Intel and AMD
cpus, although the IA32_ARCH_CAPABILITIES MSR is an Intel-specific
MSR and it makes no sense to emulate it on AMD.

As a consequence, VMs created on AMD with qemu -cpu host and using
KVM will advertise the ARCH_CAPABILITIES feature and provide the
IA32_ARCH_CAPABILITIES MSR. This can cause issues (like Windows BSOD)
as the guest OS might not expect this MSR to exist on such cpus (the
AMD documentation specifies that ARCH_CAPABILITIES feature and MSR
are not defined on the AMD architecture).

A fix was proposed in KVM code, however KVM maintainers don't want to
change this behavior that exists for 6+ years and suggest changes to be
done in QEMU instead.  Therefore, hide the bit from "-cpu host":
migration of -cpu host guests is only possible between identical host
kernel and QEMU versions, therefore this is not a problematic breakage.

If a future AMD machine does include the MSR, that would re-expose the
Windows guest bug; but it would not be KVM/QEMU's problem at that
point, as we'd be following a genuine physical CPU impl.

Reported-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit d3a24134e37d57abd3e7445842cda2717f49e96d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 6c749d4ee8..141694f803 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -500,8 +500,12 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
          * Linux v4.17-v4.20 incorrectly return ARCH_CAPABILITIES on SVM hosts.
          * We can detect the bug by checking if MSR_IA32_ARCH_CAPABILITIES is
          * returned by KVM_GET_MSR_INDEX_LIST.
+         *
+         * But also, because Windows does not like ARCH_CAPABILITIES on AMD
+         * mcahines at all, do not show the fake ARCH_CAPABILITIES MSR that
+         * KVM sets up.
          */
-        if (!has_msr_arch_capabs) {
+        if (!has_msr_arch_capabs || !(edx & CPUID_7_0_EDX_ARCH_CAPABILITIES)) {
             ret &= ~CPUID_7_0_EDX_ARCH_CAPABILITIES;
         }
     } else if (function == 7 && index == 1 && reg == R_EAX) {
-- 
2.47.2


