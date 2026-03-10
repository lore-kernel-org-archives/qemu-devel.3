Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1BE6FD2D90
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 13:43:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzxM3-000718-73; Tue, 10 Mar 2026 09:42:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vzxLv-0006zt-PF
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 09:42:28 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vzxLs-0003DN-5s
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 09:42:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773150144; x=1804686144;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=HGuhg3SdIepTJXd4+RQ7R1nLV8fo/9a/WcteRK6zAng=;
 b=dRc43EMlX/uus/H8A1Gsvdlu4M3mkVAYyrqFQZ2kTIzpFRlGxqSGPijj
 qkjpKlTQkhTYUrpv//S8zNfC+ch1otOxuXVikmZI6K7FiQZz76KBjUi7y
 oD5cMxhNhJl4cZyaxYbHGZgREM1ytypGhXwgFqyEYX2Id4yuaiuGl8yz4
 UZSVnUdY7l3dPVdIUYqP/k0Ta1jM//jdB92OU+8RDI6xHk2izwUdHtytH
 uTl2+RjIEZJxV37o3zS0lJ9deoDtftPUsy5oDuMo3moQRR/cJ/bopYtAb
 Eok20mg4GQVvy1r4iyd/iDuFdqfngPh5u36NaN6/mjp0ppewYaAGzVNYN A==;
X-CSE-ConnectionGUID: NmaYYYUSSPa0MIDHgwspmg==
X-CSE-MsgGUID: qV5j0AlYThKy/DVw/zQmpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="78048231"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; d="scan'208";a="78048231"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2026 06:42:19 -0700
X-CSE-ConnectionGUID: f55dtzrvSTq1JOWMuNNKMw==
X-CSE-MsgGUID: 3nr+rOmdQzyBexByXQFtWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; d="scan'208";a="217647961"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 10 Mar 2026 06:42:18 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 0/5] i386/cpu: CPUID & CPU model cleanup and CWF cache model
Date: Tue, 10 Mar 2026 22:08:14 +0800
Message-Id: <20260310140819.1563084-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi,

This series is a bit trivial:
 1. rename AMX mirror features with the term "alias" instead of
    "mirror", which avoid redundant new term and align with KVM's name.
 2. slightly clean up its-no related CPU model.
 3. add cache model for cwf.

Thanks and Best Regards,
Zhao
---
Zhao Liu (5):
  i386/cpu: Rename AMX mirror cpuid macros with _ALIAS suffix
  i386/cpu: Rename AMX mirror feature words with -alias suffix
  i386/cpu: Remove unnecessary cache_info fields from builtin CPU model
  i386/cpu: Adjust the note for CPU models with its-no
  i386/cpu: Enable CPUID 0x1f & cache model for ClearwaterForest

 target/i386/cpu.c | 112 +++++++++++++++++++++++++++++++++++++++++-----
 target/i386/cpu.h |  16 +++----
 2 files changed, 109 insertions(+), 19 deletions(-)

-- 
2.34.1


