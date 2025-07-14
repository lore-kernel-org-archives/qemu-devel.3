Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C3BAC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 08:12:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubEF8-00082V-3U; Mon, 14 Jul 2025 04:08:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ubDul-0004hR-TA; Mon, 14 Jul 2025 03:47:57 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ubDuj-0007PE-4a; Mon, 14 Jul 2025 03:47:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752479273; x=1784015273;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=kyWOgqzyhXDVI0FLB8lOYszjGjxHQhFNvTwZMHeMzIw=;
 b=nymWJ6NkdYFm3rBAoZuzAlki4JYk06h+CUe3z5Mkhgy2lPnaRR3ReAeG
 tqibSDPx/krxULtfhsbLNoIrmECHxXSMQTONUbUKZs8IsmtN48JK6XjH2
 kvCptXMQPYo79nKYMaSwkxPdoqNOan9cAolioaAxYB5JFqE5NcAblfU13
 B80hIBGSxYGCAcug4f+WBKEoCau7S5/ZMtq8rtRPTMDB8kMPr/UxUHoKb
 6hslyuwuxCmA/E7QM6VImWTzdhg3ERjoLIhjjiVgriPR//sN6SjsycJ8u
 kjUDStBIoEN86Ta7t/sJ3Fuxl5QvCoj8xWVO54vXghuBxhHhZgW84RgHV w==;
X-CSE-ConnectionGUID: dfgEoJigSzmFh6ZttH/2BQ==
X-CSE-MsgGUID: YdZXevuiTgup7At/zr7t0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="58324678"
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; d="scan'208";a="58324678"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2025 00:47:49 -0700
X-CSE-ConnectionGUID: sMrB7yBiTE2zQzvZYzoTCQ==
X-CSE-MsgGUID: YSIESPIHRAyFGaaXISbsPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; d="scan'208";a="156952218"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 14 Jul 2025 00:47:46 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Cc: Ewan Hai <ewanhai-oc@zhaoxin.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Tao Su <tao1.su@intel.com>, Yi Lai <yi1.lai@intel.com>,
 Dapeng Mi <dapeng1.mi@intel.com>, qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Qian Wen <qian.wen@intel.com>,
 qemu-stable@nongnu.org
Subject: [PATCH v2 5/7] i386/cpu: Fix cpu number overflow in
 CPUID.01H.EBX[23:16]
Date: Mon, 14 Jul 2025 16:08:57 +0800
Message-Id: <20250714080859.1960104-6-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250714080859.1960104-1-zhao1.liu@intel.com>
References: <20250714080859.1960104-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
---
Changes Since New v1 [**]:
 * Rebase.

Changes Since Original v4 [*]:
 * Rebase on addressable ID fixup.
 * Drop R/b tags since the code base changes.

[*] original v4: https://lore.kernel.org/qemu-devel/20230829042405.932523-2-qian.wen@intel.com/
[**]: new v1: https://lore.kernel.org/qemu-devel/20250227062523.124601-3-zhao1.liu@intel.com/
---
 target/i386/cpu.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 7fcb6c144d94..67a371e23b22 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7869,6 +7869,8 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         }
         *edx = env->features[FEAT_1_EDX];
         if (threads_per_pkg > 1) {
+            uint32_t num;
+
             /*
              * For CPUID.01H.EBX[Bits 23-16], AMD requires logical processor
              * count, but Intel needs maximum number of addressable IDs for
@@ -7876,10 +7878,13 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
              */
             if (cpu->vendor_cpuid_only_v2 &&
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
     case 2: { /* cache info: needed for Pentium Pro compatibility */
-- 
2.34.1


