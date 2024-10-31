Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF4AE68960
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 08:59:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6R0f-0000hh-NF; Thu, 31 Oct 2024 04:58:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1t6R0d-0000hL-2j
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 04:58:27 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1t6R0b-0003Ch-51
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 04:58:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730365105; x=1761901105;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=lRZzQVq8p17HtUDag7fZnAQIzKjeSuUtdrWJ5VusyUs=;
 b=j3L0cxqKAG/F2j/+3/wjldnpJvc6EEDaSfh5jF0fMyvkZJzHOka5CZSn
 OcWeFaJtwOBJFBfhvpX/LFkEl3jsD4EAQhic/PZwHHqIzWQLa76u70OdC
 KZHxfiOvnVoc6Mcydmx6uKwUzyrXTNnSnJ/y86utEYkGKhZN49DlUTrlg
 al8I48YppUhvRhablMZig9s82QjMGzaHfov4ZtNrQNceoPBIgIXWChS1S
 XZOUGH/nD34+KzcOMBKHxI/GxHnikHsZJcvPBQf0TNpIV6Ym2XkyJLEw3
 YtbAldjQaAah9zVvTskgGJgQd3AF5OW2UPikOJedDX92WtweDSAfYSK3L A==;
X-CSE-ConnectionGUID: tH1xrxiNSFuNeVsQNDIYvg==
X-CSE-MsgGUID: +REK96xGRlG+KYjy6QpEfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="55492659"
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; d="scan'208";a="55492659"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Oct 2024 01:58:21 -0700
X-CSE-ConnectionGUID: UY6ggORbTra4V6qzXajrVQ==
X-CSE-MsgGUID: TIcRc6toQKKFQUDh6+3TyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; d="scan'208";a="82489413"
Received: from st-server.bj.intel.com ([10.240.193.102])
 by orviesa010.jf.intel.com with ESMTP; 31 Oct 2024 01:58:19 -0700
From: Tao Su <tao1.su@linux.intel.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, xiaoyao.li@intel.com,
 zhao1.liu@intel.com, xuelian.guo@intel.com, tao1.su@linux.intel.com
Subject: [PATCH v3 0/8] Add AVX10.1 CPUID support and GraniteRapids-v2 model
Date: Thu, 31 Oct 2024 16:52:25 +0800
Message-Id: <20241031085233.425388-1-tao1.su@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.198.163.7;
 envelope-from=tao1.su@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Add AVX10.1 CPUID support, i.e. add AVX10 support bit via
CPUID.(EAX=07H, ECX=01H):EDX[bit 19] and new CPUID leaf 0x24H so that
guest OS and applications can query the AVX10 CPUIDs directly. The AVX10.1
spec can be found in [1], it is worth mentioning that
VL128 (CPUID.(EAX=24H, ECX=00H):EBX[bit 16]) was dropped in rev3.0, but it
will be added back and reserved as 1 (SDM and AVX10.2 spec[2] have already
described).

Since GraniteRapids (stepping 1) is the first platform to support AVX10,
introduce GraniteRapids-v2 CPU model to add AVX10 in this patch set, and
add some missing features as well.

[1] https://cdrdv2.intel.com/v1/dl/getContent/671200
[2] https://cdrdv2.intel.com/v1/dl/getContent/828965

---
Changelog:

v2->v3:
 - Move assigning avx10_version from max_x86_cpu_realize() to
   x86_cpu_expand_features().
 - Add CPUIDs of vector lengths back in cpu_x86_cpuid().
 - Update comment on x86_cpu_expand_features(). (Zhao)
 - Tell user about revised version if version is invalid. (Zhao)
 - Handle when AVX10 enable bit is disabled but user sets avx10-verion.
   (Zhao)
 - Add Zhao's Reviewed-by and Xuelian's Tested-by.

v2: https://lore.kernel.org/all/20241029151858.550269-1-pbonzini@redhat.com/
v1: https://lore.kernel.org/all/20241028024512.156724-1-tao1.su@linux.intel.com/

---
Paolo Bonzini (3):
  target/i386: cpu: set correct supported XCR0 features for TCG
  target/i386: do not rely on ExtSaveArea for accelerator-supported XCR0
    bits
  target/i386: return bool from x86_cpu_filter_features

Tao Su (5):
  target/i386: add AVX10 feature and AVX10 version property
  target/i386: add CPUID.24 features for AVX10
  target/i386: Add feature dependencies for AVX10
  target/i386: Add AVX512 state when AVX10 is supported
  target/i386: Introduce GraniteRapids-v2 model

 target/i386/cpu.c         | 177 ++++++++++++++++++++++++++++++++++----
 target/i386/cpu.h         |  16 ++++
 target/i386/kvm/kvm-cpu.c |   4 -
 target/i386/kvm/kvm.c     |   3 +-
 4 files changed, 176 insertions(+), 24 deletions(-)


base-commit: 58d49b5895f2e0b5cfe4b2901bf24f3320b74f29
-- 
2.34.1


