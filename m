Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9699EC87FCA
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 06:29:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugdpt-0002XD-TU; Tue, 29 Jul 2025 02:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ugdpq-0002Fd-7B
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 02:29:14 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ugdpn-0007gk-Ok
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 02:29:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753770551; x=1785306551;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=72OAhHn3J20xzmEDXX9ginwaG9Aopaxd4L/E5HPW3SI=;
 b=inS4xoh8vw3gD9O8WaNLdNZSxn+p7JCumdjn7wAAQl9dkz0roQ8+Uyj/
 hXnZhS5rZtKg63B4SHVJ7qPtvRqshQKVWQQpexXfXEITd8ZdCpkEzhg8Y
 V8egSiNwb5t5SgXqYVAMjhwD07gGaGHoD/rooYh/+Nuev1PSskZDdxIbv
 SZun9+V6Ym8436TVOGxajuMVpAT3WNXAxw+u57JqwwSd7exVlrcKzuEzR
 rOMJcA+J8n/DM3CRDFL4yfuTX1ih9D6y2Q7sxLWWBkrop6Bp65p0waJi/
 2UqaH6rzxI7CWeTpoKhx6U5UhiTkOu+ZVrK9PvOwlXikGF1Sc6ZjdERcB Q==;
X-CSE-ConnectionGUID: Lx4PiFhKQ6OfI7+/9PoqQw==
X-CSE-MsgGUID: 7RlLwkhBRSeCQT2lP57XkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11505"; a="59854979"
X-IronPort-AV: E=Sophos;i="6.16,348,1744095600"; d="scan'208";a="59854979"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2025 23:29:10 -0700
X-CSE-ConnectionGUID: SWJfxwcQSn6eBUIYAY2hQw==
X-CSE-MsgGUID: dA0lcgUdTOy6txxwCsSQRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,348,1744095600"; d="scan'208";a="162492697"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa006.fm.intel.com with ESMTP; 28 Jul 2025 23:29:08 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 qemu-devel@nongnu.org
Subject: [PATCH 2/2] i386/kvm: Drop KVM_CAP_X86_SMM check in kvm_arch_init()
Date: Tue, 29 Jul 2025 14:20:14 +0800
Message-ID: <20250729062014.1669578-3-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250729062014.1669578-1-xiaoyao.li@intel.com>
References: <20250729062014.1669578-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.12; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.299, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

x86_machine_is_smm_enabled() checks the KVM_CAP_X86_SMM for KVM
case. No need to check KVM_CAP_X86_SMM specifically.

One benefit of checking it specifically is that it can return early when
KVM_CAP_X86_SMM is not supported. But considering KVM_CAP_X86_SMM was
added in KVM 10 year ago, it's unlikely the case.

So just drop the check of KVM_CAP_X86_SMM to simplify the code.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/kvm/kvm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index d145ad49e4e5..92025b8fcae9 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -3311,8 +3311,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         return ret;
     }
 
-    if (kvm_check_extension(s, KVM_CAP_X86_SMM) &&
-        x86_machine_is_smm_enabled(x86ms)) {
+    if (x86_machine_is_smm_enabled(x86ms)) {
         smram_machine_done.notify = register_smram_listener;
         qemu_add_machine_init_done_notifier(&smram_machine_done);
     }
-- 
2.43.0


