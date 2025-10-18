Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A63CCD19F
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Oct 2025 19:08:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vACH8-0006Vx-OO; Sat, 18 Oct 2025 15:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vACGn-0006O9-Oi; Sat, 18 Oct 2025 15:07:21 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vACGl-000106-PE; Sat, 18 Oct 2025 15:07:13 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id ACAC715F79B;
 Sat, 18 Oct 2025 22:06:58 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 6E9C52F0604;
 Sat, 18 Oct 2025 22:07:02 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jon Kohler <jon@nutanix.com>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.2 14/23] i386/kvm: Expose ARCH_CAP_FB_CLEAR when
 invulnerable to MDS
Date: Sat, 18 Oct 2025 22:06:49 +0300
Message-ID: <20251018190702.1178893-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.2-20251018220623@cover.tls.msk.ru>
References: <qemu-stable-10.1.2-20251018220623@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

From: Jon Kohler <jon@nutanix.com>

Newer Intel hardware (Sapphire Rapids and higher) sets multiple MDS
immunity bits in MSR_IA32_ARCH_CAPABILITIES but lacks the hardware-level
MSR_ARCH_CAP_FB_CLEAR (bit 17):
    ARCH_CAP_MDS_NO
    ARCH_CAP_TAA_NO
    ARCH_CAP_PSDP_NO
    ARCH_CAP_FBSDP_NO
    ARCH_CAP_SBDR_SSDP_NO

This prevents VMs with fb-clear=on from migrating from older hardware
(Cascade Lake, Ice Lake) to newer hardware, limiting live migration
capabilities. Note fb-clear was first introduced in v8.1.0 [1].

Expose MSR_ARCH_CAP_FB_CLEAR for MDS-invulnerable systems to enable
seamless migration between hardware generations.

Note: There is no impact when a guest migrates to newer hardware as
the existing bit combinations already mark the host as MMIO-immune and
disable FB_CLEAR operations in the kernel (see Linux's
arch_cap_mmio_immune() and vmx_update_fb_clear_dis()). See kernel side
discussion for [2] for additional context.

[1] 22e1094ca82 ("target/i386: add support for FB_CLEAR feature")
[2] https://patchwork.kernel.org/project/kvm/patch/20250401044931.793203-1-jon@nutanix.com/

Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Jon Kohler <jon@nutanix.com>
Link: https://lore.kernel.org/r/20251008202557.4141285-1-jon@nutanix.com
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 00001a22d183ce96c110690987bf9dd6a8548552)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 96035c27cd..7137b46be1 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -653,6 +653,23 @@ uint64_t kvm_arch_get_supported_msr_feature(KVMState *s, uint32_t index)
         must_be_one = (uint32_t)value;
         can_be_one = (uint32_t)(value >> 32);
         return can_be_one & ~must_be_one;
+    case MSR_IA32_ARCH_CAPABILITIES:
+        /*
+         * Special handling for fb-clear bit in ARCH_CAPABILITIES MSR.
+         * KVM will only report the bit if it is enabled in the host,
+         * but, for live migration capability purposes, we want to
+         * expose the bit to the guest even if it is disabled in the
+         * host, as long as the host itself is not vulnerable to
+         * the issue that the fb-clear bit is meant to mitigate.
+         */
+        if ((value & MSR_ARCH_CAP_MDS_NO) &&
+            (value & MSR_ARCH_CAP_TAA_NO) &&
+            (value & MSR_ARCH_CAP_SBDR_SSDP_NO) &&
+            (value & MSR_ARCH_CAP_FBSDP_NO) &&
+            (value & MSR_ARCH_CAP_PSDP_NO)) {
+                value |= MSR_ARCH_CAP_FB_CLEAR;
+        }
+        return value;
 
     default:
         return value;
-- 
2.47.3


