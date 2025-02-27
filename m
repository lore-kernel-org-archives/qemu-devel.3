Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE2E2C021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 06:07:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnX1o-00036S-NX; Thu, 27 Feb 2025 01:05:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tnX1l-00035R-AV; Thu, 27 Feb 2025 01:05:45 -0500
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tnX1j-0001sV-I5; Thu, 27 Feb 2025 01:05:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740636343; x=1772172343;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=SL5vYkjO0DYNwfR7/iQmoM4de63ktHexSDHdd5OLntA=;
 b=laZhyfJDihRMJrCuZd5lLT6oSTINhqCjuw4E4emo0hJF4SRGCHVhvHjL
 b55w4Wqa9zqkw9bU9ShPPmY1JWRhZaklAwraF0aL00TNQ/lRrM2HREm+Y
 XmXM4dCDNOXp5+Xfl8B3FZJt6yQKFTNY8mqi0W3AuxKAprcc9dwyb5NXa
 x0zITYLMicEcqKnlgZs5vSqMG85cLBlw5iX4p9muI+UH9qeHZVuHiGFNB
 pHYN2wTLd4Rwj0yyHdQHjAadQfyj7mQ8TBNjxy/0E0gTqA0f+2AVt7SLe
 wua1CHDsPo8IxYLe/QwPzg7zsOp6hMdF005Oc/AyB1hKI1CMYsLJdW9D+ A==;
X-CSE-ConnectionGUID: D1zofCwiTfil98zM/FtpZw==
X-CSE-MsgGUID: DecF0311Si206S2GAhgaWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="52148181"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; d="scan'208";a="52148181"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2025 22:05:41 -0800
X-CSE-ConnectionGUID: eLuXgdDnTFikyYPZ44YMEA==
X-CSE-MsgGUID: 3ChQzsOtSfWqG6L2hidbyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; d="scan'208";a="121938276"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa004.jf.intel.com with ESMTP; 26 Feb 2025 22:05:38 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Chuang Xu <xuchuangxclwt@bytedance.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>, Babu Moger <babu.moger@amd.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Qian Wen <qian.wen@intel.com>, qemu-stable@nongnu.org
Subject: [PATCH 2/4] i386/cpu: Fix cpu number overflow in CPUID.01H.EBX[23:16]
Date: Thu, 27 Feb 2025 14:25:21 +0800
Message-Id: <20250227062523.124601-3-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250227062523.124601-1-zhao1.liu@intel.com>
References: <20250227062523.124601-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Signed-off-by: Qian Wen <qian.wen@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes since original v4 [*]:
 * Rebase on addressable ID fixup.
 * Drop R/b tags since the code base changes.

[*] original v4: https://lore.kernel.org/qemu-devel/20230829042405.932523-2-qian.wen@intel.com/
---
 target/i386/cpu.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b8a78276cd50..ae6c8bfd8b5e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6691,16 +6691,21 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         }
         *edx = env->features[FEAT_1_EDX];
         if (threads_per_pkg > 1) {
+            uint32_t num;
+
             /*
              * For CPUID.01H.EBX[Bits 23-16], AMD requires logical processor
              * count, but Intel needs maximum number of addressable IDs for
              * logical processors per package.
              */
             if (cpu->vendor_cpuid_only && IS_AMD_CPU(env)) {
-                *ebx |= threads_per_pkg << 16;
+                num = threads_per_pkg;
             } else {
-                *ebx |= 1 << apicid_pkg_offset(topo_info) << 16;
+                num = 1 << apicid_pkg_offset(topo_info);
             }
+
+            /* Fixup overflow: max value for bits 23-16 is 255. */
+            *ebx |= MIN(num, 255) << 16;
         }
         if (!cpu->enable_pmu) {
             *ecx &= ~CPUID_EXT_PDCM;
-- 
2.34.1


