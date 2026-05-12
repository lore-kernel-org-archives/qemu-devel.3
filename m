Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A5FCD4F26
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 08:35:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMiZK-00022y-Pw; Tue, 12 May 2026 04:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1wMiZJ-00022R-S7
 for qemu-devel@nongnu.org; Tue, 12 May 2026 04:34:21 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1wMiZG-000055-PX
 for qemu-devel@nongnu.org; Tue, 12 May 2026 04:34:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778574859; x=1810110859;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=cB3fCsHbvTnlAz3Wi+dtYJRlua//7utu3r4AQnh/yU8=;
 b=hCSQzMX2yUHfMBfI50ymOTVpSlhT7o5eYOXLyz0oIN4nPrd+pDEV1B/m
 dLJwZJz1fb7f1nLSOX5UE0e12+a2Ent0BpGk460GzDSH3yklcQ72sCw+P
 Iv5k8oV35sb/wzbdJIxCORe1aRaw2OdIQqsv3D5zRPwnCO/eKunqy+J+p
 MeVvW3zu8630G1jgrZch5q0L+RSjYR/HseffAEy1rqLlnlQK/oGaoLFST
 Y0KOgx2/KVBGKeeS0qHFYI4diWsgG3zq3omcEh15b2ocZ1tQw81J2Ob1p
 2Rjo2sHM6nQ+Advx3V1xhhyw8MHDHT0NvquWr8qqOD2Uo1hqLdojWgMir g==;
X-CSE-ConnectionGUID: 8NrbPUEzQJmkOBMyz6IZFg==
X-CSE-MsgGUID: TPK/rE5xTUeVPC9GmWC7Tw==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="90059997"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; d="scan'208";a="90059997"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2026 01:34:15 -0700
X-CSE-ConnectionGUID: Tmzs7KHGQsaOqFa/lWl0AA==
X-CSE-MsgGUID: VSNOaAVbR0mla1ks+Pa8Sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; d="scan'208";a="237947164"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.22])
 by orviesa007.jf.intel.com with ESMTP; 12 May 2026 01:34:12 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, xiaoyao.li@intel.com
Subject: [PATCH 0/3] i386/tdx: TDX cleanup and CPUID fixes
Date: Tue, 12 May 2026 16:21:05 +0800
Message-ID: <20260512082108.621596-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
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

Patch 1 is the resend of a cleanup patch that was missed by the
community[1].

Patch 2 fixes the warnings when booting TDX guest on the platforms
(e.g., DMR) that support AMX alias bits.

Patch 3 allows AVX10 to be exposed/enabled for TDX guest.

[1] https://lore.kernel.org/qemu-devel/20250710141512.170302-1-xiaoyao.li@intel.com/

Xiaoyao Li (3):
  i386/tdx: Use .has_gpa field to check if the gpa is valid
  i386/tdx: Make AMX alias bits supported
  i386/tdx: Add CPUID_24_0_EBX_AVX10_VL_MASK as supported

 system/runstate.c     |  2 +-
 target/i386/kvm/tdx.c | 28 +++++++++++++++++++++-------
 2 files changed, 22 insertions(+), 8 deletions(-)

-- 
2.43.0


