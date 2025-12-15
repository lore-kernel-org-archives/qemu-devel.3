Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A82AD59D99
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 07:15:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vV2ld-000362-Fo; Mon, 15 Dec 2025 02:13:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vV2lY-00031U-V3
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 02:13:09 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vV2lW-0008DC-Dz
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 02:13:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765782787; x=1797318787;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=+F1W5flgSC29AhZEjyUZFJ8828PLL7V8CxC1bXmkOf8=;
 b=iGUx2gZavG7uERD6OFgaBW3uPyFtkuQSBPwlLSRv2TUzlVmN0EyYOTi6
 8xb1cE/ZgK9sTuQvLHjdFmT00zCNCkbVQBLxrgQQl7pW7QrqAWWcNTRFC
 DVU6G1/71JbEZ7Dxv+K2+LylwSuZ1vvrjr3Glotohxppi4FeZTjD3P1Bw
 8oZg9BLZxL29eChWVAVzXYyxoiDK0GmH6AJgDplhw8Lz1RwINncHqMmex
 TX8ymjrReCxFuB7xw/VzoPFkvG6FEAJ+vpXpvWgX45yjVKXNKK5h5lQmS
 i+0c51agF0yYby/5359fqY9O03fEARkoNVh4ACknqNp7hw9SmFwt+rssN g==;
X-CSE-ConnectionGUID: mGxWk9T4RguJY5wU+bknXQ==
X-CSE-MsgGUID: sU9ws9ycTvedNO1nMq9zZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11642"; a="90332233"
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; d="scan'208";a="90332233"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Dec 2025 23:13:03 -0800
X-CSE-ConnectionGUID: wVo7qYCcQFuRnXXY7rqMiA==
X-CSE-MsgGUID: 5s3UOpIeQb6UhKlgxTEQ2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; d="scan'208";a="197265921"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 14 Dec 2025 23:13:01 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Xudong Hao <xudong.hao@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 00/11] i386/cpu: Add new instructions & CPU model for Intel
 Diamond Rapids
Date: Mon, 15 Dec 2025 15:37:32 +0800
Message-Id: <20251215073743.4055227-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Hi,

This series addes new instrucions and CPU model support for Intel
Diamond Rapids.

This series mainly includes:
 * MOVRS CPUID
 * new AMX CPUIDs
 * AVX10.2 & AVX10_VNNI_INT
 * DMR CPU model & topology documentation
   - The on-going cache-aware scheduling work could benefit such
     topology:
     https://lore.kernel.org/lkml/cover.1764801860.git.tim.c.chen@linux.intel.com/

This series is based on https://gitlab.com/bonzini/qemu i386 branch at
7c7e2f410b3d ("target/i386/tcg: mark APX as supported").

Compared with v1, v2 mainly did:
 * allow upsupported avx10 version when x-force-feature=on, for debug.
 * rename CPUID_7_1_EDX_APX to CPUID_7_1_EDX_APXF in DMR CPU model.


One More Thing
==============

About the AVX10 model (patch 4), in principle, AVX10.1 should be allowed
to run on an AVX10.2 host. For similar version drived features,
introducing a model might be a preferable way. However, PMU doesn't
serve as a good example here.


Thanks for your review!

Best Regards,
Zhao
---
Zhao Liu (11):
  i386/cpu: Add support for MOVRS in CPUID enumeration
  i386/cpu: Add CPUID.0x1E.0x1 subleaf for AMX instructions
  i386/cpu: Add support for AVX10_VNNI_INT in CPUID enumeration
  i386/cpu: Support AVX10.2 with AVX10 feature models
  i386/cpu: Add a helper to get host avx10 version
  i386/cpu: Allow unsupported avx10_version with x-force-features
  i386/cpu: Allow cache to be shared at thread level
  i386/cpu: Add an option in X86CPUDefinition to control CPUID 0x1f
  i386/cpu: Define dependency for VMX_VM_ENTRY_LOAD_IA32_FRED
  i386/cpu: Add CPU model for Diamond Rapids
  dosc/cpu-models-x86: Add documentation for DiamondRapids

 docs/system/cpu-models-x86.rst.inc |  20 ++
 target/i386/cpu.c                  | 462 +++++++++++++++++++++++++----
 target/i386/cpu.h                  |  27 ++
 3 files changed, 456 insertions(+), 53 deletions(-)

-- 
2.34.1


