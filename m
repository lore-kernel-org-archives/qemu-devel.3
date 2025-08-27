Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 547CBCA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 15:21:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urHnW-0006IW-3R; Wed, 27 Aug 2025 11:10:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urHjM-0006oU-QK; Wed, 27 Aug 2025 11:06:35 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urHjK-0005Ro-Tq; Wed, 27 Aug 2025 11:06:32 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CFF7914C54C;
 Wed, 27 Aug 2025 18:02:58 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id BA9E3269854;
 Wed, 27 Aug 2025 18:03:25 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Qian Wen <qian.wen@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.4 36/59] i386/cpu: Fix cpu number overflow in
 CPUID.01H.EBX[23:16]
Date: Wed, 27 Aug 2025 18:02:41 +0300
Message-ID: <20250827150323.2694101-36-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-10.0.4-20250827180051@cover.tls.msk.ru>
References: <qemu-stable-10.0.4-20250827180051@cover.tls.msk.ru>
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

From: Qian Wen <qian.wen@intel.com>

The legacy topology enumerated by CPUID.1.EBX[23:16] is defined in SDM
Vol2:

Bits 23-16: Maximum number of addressable IDs for logical processors in
this physical package.

When threads_per_socket > 255, it will 1) overwrite bits[31:24] which is
apic_id, 2) bits [23:16] get truncated.

Specifically, if launching the VM with -smp 256, the value written to
EBX[23:16] is 0 because of data overflow. If the guest only supports
legacy topology, without V2 Extended Topology enumerated by CPUID.0x1f
or Extended Topology enumerated by CPUID.0x0b to support over 255 CPUs,
the return of the kernel invoking cpu_smt_allowed() is false and APs
(application processors) will fail to bring up. Then only CPU 0 is online,
and others are offline.

For example, launch VM via:
qemu-system-x86_64 -M q35,accel=kvm,kernel-irqchip=split \
    -cpu qemu64,cpuid-0xb=off -smp 256 -m 32G \
    -drive file=guest.img,if=none,id=virtio-disk0,format=raw \
    -device virtio-blk-pci,drive=virtio-disk0,bootindex=1 --nographic

The guest shows:
    CPU(s):               256
    On-line CPU(s) list:  0
    Off-line CPU(s) list: 1-255

To avoid this issue caused by overflow, limit the max value written to
EBX[23:16] to 255 as the HW does.

Cc: qemu-stable@nongnu.org
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Qian Wen <qian.wen@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250714080859.1960104-6-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit a62fef58299562aae6667b8d8552247423e886b3)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index ed262edcc8..56af1857b9 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6835,6 +6835,8 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         }
         *edx = env->features[FEAT_1_EDX];
         if (threads_per_pkg > 1) {
+            uint32_t num;
+
             /*
              * For CPUID.01H.EBX[Bits 23-16], AMD requires logical processor
              * count, but Intel needs maximum number of addressable IDs for
@@ -6842,10 +6844,13 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
              */
             if (/*10.0: cpu->vendor_cpuid_only_v2*/ false &&
                 (IS_INTEL_CPU(env) || IS_ZHAOXIN_CPU(env))) {
-                *ebx |= 1 << apicid_pkg_offset(topo_info) << 16;
+                num = 1 << apicid_pkg_offset(topo_info);
             } else {
-                *ebx |= threads_per_pkg << 16;
+                num = threads_per_pkg;
             }
+
+            /* Fixup overflow: max value for bits 23-16 is 255. */
+            *ebx |= MIN(num, 255) << 16;
         }
         break;
     case 2:
-- 
2.47.2


