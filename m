Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF4B5CCD187
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 09:52:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8bgm-0004h6-3W; Tue, 14 Oct 2025 05:51:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1v8bgf-0004gD-DC
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 05:51:22 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1v8bgc-0005WO-VE
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 05:51:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760435479; x=1791971479;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=kODwuhjN2HcqQGQLVeeaYZPYI8mczYYWB1DNFcR7uVE=;
 b=AoB+hywioRhXr6YmVDZcBPgHw+acQs31bMtlN7EEo04WX/FYLKfBe9kN
 O/FNXoUt4vd10xE5U3Liq9flWa/DOtHsJAL7wy9RvXJDliEjR/+P5uDjq
 Ow8euqq+YSZcZKQ9lHBYIImOTFhkjBpgvnfJ/L1xrp99l9p9Ob1wP0ba2
 UyrQP5RM5pS5j72lBjuFTCJ69xCqy/p1BKfK3+McJGPDzZKihDIVVQoT6
 TBoDRIUkK94I3sfhOrRSSAvFmNtH8Z9DN7O3vAbNa9hkrK9vtiA6Gm4ky
 2sLAcEXxSLL2epVVwHoODCl5eQi8ZMLabTxtIED/KmnmGQX/67U6WvDwN g==;
X-CSE-ConnectionGUID: EDegYHB1Rd+EAuP2rb38jw==
X-CSE-MsgGUID: uKQS4RDmQdumgZ3pUbDCcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="61627808"
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; d="scan'208";a="61627808"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 02:51:11 -0700
X-CSE-ConnectionGUID: 2EIox7ZNQ4mTEMqlnEwDlw==
X-CSE-MsgGUID: XhcVYLz6QF6VnOXF1qgIrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; d="scan'208";a="181068418"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.22])
 by orviesa010.jf.intel.com with ESMTP; 14 Oct 2025 02:51:10 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
	Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH 2/2] target/i386: Use X86ASIdx_MEM in kvm_init()
Date: Tue, 14 Oct 2025 17:42:15 +0800
Message-ID: <20251014094216.164306-3-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014094216.164306-1-xiaoyao.li@intel.com>
References: <20251014094216.164306-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.19; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

When the patch introduces 'enum X86ADIdx'[0] got merged, it somehow
missed the change to replace as id 0 with X86ASIdx_MEM in kvm_init().

Change the leftover in kvm_init() to make the usage consistent.

[0] https://lore.kernel.org/qemu-devel/20250730095253.1833411-3-xiaoyao.li@intel.com/

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 accel/kvm/kvm-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 58802f7c3cc1..3030c47d55b1 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2800,7 +2800,7 @@ static int kvm_init(AccelState *as, MachineState *ms)
     s->memory_listener.listener.coalesced_io_del = kvm_uncoalesce_mmio_region;
 
     kvm_memory_listener_register(s, &s->memory_listener,
-                                 &address_space_memory, 0, "kvm-memory");
+                                 &address_space_memory, X86ASIdx_MEM, "kvm-memory");
     memory_listener_register(&kvm_io_listener,
                              &address_space_io);
 
-- 
2.43.0


