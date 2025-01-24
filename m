Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DFD0C0218C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 13:48:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbJvK-0002KV-2w; Fri, 24 Jan 2025 08:40:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tbJua-0001E5-VH
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 08:39:53 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tbJuZ-0003xi-BO
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 08:39:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737725992; x=1769261992;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Cg9zFgAAzu9TXNw0/8UbOMWfLRF5mK1sJR1xnM0x7yE=;
 b=J5CkxTuhyLFZ9LhR5hgn6iY/1dA4jP42yLt8QEIfP99mG21fdO369Y1C
 0lICjN+6pgvwqhmQo5i167iWHOMx8Ww4jlhul5cpxhscvIeGoH/uMYCtc
 WHxhtjtvERnWEK87DH6uPV/Hr1tRklUkrYyzXc4YY/dlkhPLIz+zefvG9
 XP2kVruFpNckPA/y3SsyZ/HS1eUp07UhsiXi7QJ2IEfwTZfYO3setnHaI
 dKvciwvnvauLwheTYuhCNMBYVuRbwY/8DZyzXfj3/eYufT4+67L8ub2Vj
 6u6fRVvHwCiBhslYk/3lCX2PWzFYrZfQbCao9q4XWK3XZGkmovQgWA/tc w==;
X-CSE-ConnectionGUID: sSajo9KVRQWQz7CY0kgcEQ==
X-CSE-MsgGUID: 8lP/CESKQo2nna0TSjafcg==
X-IronPort-AV: E=McAfee;i="6700,10204,11325"; a="49246542"
X-IronPort-AV: E=Sophos;i="6.13,231,1732608000"; d="scan'208";a="49246542"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jan 2025 05:39:29 -0800
X-CSE-ConnectionGUID: QgXs53yKRAimdFJ5U90NLA==
X-CSE-MsgGUID: zZ33BOzxQ56B2EFNvXjAYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="111804435"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa003.fm.intel.com with ESMTP; 24 Jan 2025 05:39:25 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Huacai Chen <chenhuacai@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>, xiaoyao.li@intel.com,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: [PATCH v7 39/52] cpu: Don't set vcpu_dirty when guest_state_protected
Date: Fri, 24 Jan 2025 08:20:35 -0500
Message-Id: <20250124132048.3229049-40-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124132048.3229049-1-xiaoyao.li@intel.com>
References: <20250124132048.3229049-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.13; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

QEMU calls kvm_arch_put_registers() when vcpu_dirty is true in
kvm_vcpu_exec(). However, for confidential guest, like TDX, putting
registers is disallowed due to guest state is protected.

Only set vcpu_dirty to true with guest state is not protected when
creating the vcpu.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
Changes in v7:
 - new patch to replace "i386/tdx: Don't get/put guest state for TDX VMs"
   in v6;
---
 accel/kvm/kvm-all.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index e35a9fbd687e..c1fea69d582e 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -466,7 +466,9 @@ int kvm_create_vcpu(CPUState *cpu)
 
     cpu->kvm_fd = kvm_fd;
     cpu->kvm_state = s;
-    cpu->vcpu_dirty = true;
+    if (!s->guest_state_protected) {
+        cpu->vcpu_dirty = true;
+    }
     cpu->dirty_pages = 0;
     cpu->throttle_us_per_full = 0;
 
-- 
2.34.1


