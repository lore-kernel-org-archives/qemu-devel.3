Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B84C3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 15:13:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD2qH-0005Yx-VP; Thu, 08 May 2025 11:07:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uD2q8-0005FN-Bx
 for qemu-devel@nongnu.org; Thu, 08 May 2025 11:07:12 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uD2q2-0007RF-Vn
 for qemu-devel@nongnu.org; Thu, 08 May 2025 11:07:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746716827; x=1778252827;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=kcNZXKELI150GHQdC8+dN8KzuEUlLn8C0fwinm/hIEo=;
 b=QA1iqMlpi2sjwzB7z7r9ha9K4HioLYUDUEwFsnaPM9iNK7y+ouEO/FGe
 wgt6zalp0Z/JE43mKbEYUibSrUsN8ADLpEVqU37y6m5u8Dz2961qilAG8
 rWzy4Ebvc7qCX0WA7ph+GtVrkSGFw95bMaRbyqleZ4Xd2L3Qu+mcq/XuX
 tItptzJBg5z7ZcWMWi7coCUUS+fEBHY9NuVANYY0NENadM5aFsMsBqKx5
 6VPFPfi1ppISVbfWTL2+/63AVlmPZCW3WAu025n3Xu9pk3g608M6sjyDu
 P7HU9RZxA/cByfu0kMYbQsa99nlDLAmsg70M+zWHE1Cmkzv/nF9fIztK/ A==;
X-CSE-ConnectionGUID: nTPj9wdTQcyL2hjc/epMng==
X-CSE-MsgGUID: aYp3+x8XR4uXBE6Yz44wQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="73888270"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; d="scan'208";a="73888270"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2025 08:06:28 -0700
X-CSE-ConnectionGUID: meB6+S9FSNuOXaTjGAxwGQ==
X-CSE-MsgGUID: I+OWwCUzS2WzW8SKiQ5M1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; d="scan'208";a="141440115"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa005.jf.intel.com with ESMTP; 08 May 2025 08:06:25 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH v9 30/55] kvm: Check KVM_CAP_MAX_VCPUS at vm level
Date: Thu,  8 May 2025 10:59:36 -0400
Message-ID: <20250508150002.689633-31-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250508150002.689633-1-xiaoyao.li@intel.com>
References: <20250508150002.689633-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
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

KVM with TDX support starts to report different KVM_CAP_MAX_VCPUS per
different VM types. So switch to check the KVM_CAP_MAX_VCPUS at vm level.

KVM still returns the global KVM_CAP_MAX_VCPUS when the KVM is old that
doesn't report different value at vm level.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 accel/kvm/kvm-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index df9840e53a35..5835d840f3ad 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2425,7 +2425,7 @@ static int kvm_recommended_vcpus(KVMState *s)
 
 static int kvm_max_vcpus(KVMState *s)
 {
-    int ret = kvm_check_extension(s, KVM_CAP_MAX_VCPUS);
+    int ret = kvm_vm_check_extension(s, KVM_CAP_MAX_VCPUS);
     return (ret) ? ret : kvm_recommended_vcpus(s);
 }
 
-- 
2.43.0


