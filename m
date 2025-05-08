Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0898EC3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 15:13:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD2rA-0002S6-Ik; Thu, 08 May 2025 11:08:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uD2r8-0002KH-RC
 for qemu-devel@nongnu.org; Thu, 08 May 2025 11:08:14 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uD2r3-0007UR-DY
 for qemu-devel@nongnu.org; Thu, 08 May 2025 11:08:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746716889; x=1778252889;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=x5pYL8yriUeHcJC0Spu1U1YR7f9qwaR9C4p6JrpuYzw=;
 b=jPXf3cqpHZqNKazURtLjn20iQjWLbp4D/MWZReqIuIa+XM6fxP2Mivey
 dReRktYf5TrlhTDKf5AJ41JnGLLRVr8LtHbGEVsuZrNUu6YJv9ldVCVZR
 B8nsNBPb/G0N8OEZiF81iU5QP5p7JZO6pGiRD/CovJT6ILNboZWE3vsz4
 IM6m+8diRxytQAiI7m4HQNAXCEMK9munZjomx71XfjLagq+szXG1xzDWp
 456GQ60mMOmpy3Cauf6TyNaSZH3aC9QJ4KKR8zUGEK2iiwYiTo9ZnvyVT
 HMKrGu1goF5roGuqYMrTTogphpXs9wZKY+WLntTunesnTuhlLWBGyzjXS w==;
X-CSE-ConnectionGUID: V/Yf27zGRvWAafufFJEyEw==
X-CSE-MsgGUID: dDnZlgSaQbKD1ii056MzzA==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="73888436"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; d="scan'208";a="73888436"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2025 08:07:04 -0700
X-CSE-ConnectionGUID: aBjHnwqFSTmbwwJV488puQ==
X-CSE-MsgGUID: H48PU95TRwutAvMxNKykNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; d="scan'208";a="141440385"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa005.jf.intel.com with ESMTP; 08 May 2025 08:07:01 -0700
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
Subject: [PATCH v9 42/55] cpu: Don't set vcpu_dirty when guest_state_protected
Date: Thu,  8 May 2025 10:59:48 -0400
Message-ID: <20250508150002.689633-43-xiaoyao.li@intel.com>
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

QEMU calls kvm_arch_put_registers() when vcpu_dirty is true in
kvm_vcpu_exec(). However, for confidential guest, like TDX, putting
registers is disallowed due to guest state is protected.

Only set vcpu_dirty to true with guest state is not protected when
creating the vcpu.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes in v7:
 - new patch to replace "i386/tdx: Don't get/put guest state for TDX VMs"
   in v6;
---
 accel/kvm/kvm-all.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 5835d840f3ad..9862d8ff1d38 100644
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
2.43.0


