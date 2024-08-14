Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A241C3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 08:04:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1se8yp-0003lo-Q4; Wed, 14 Aug 2024 04:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1se8yK-0002pR-Pw
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 04:03:17 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1se8xw-0007sl-Cs
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 04:03:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723622564; x=1755158564;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=l9ibDxi4pjx2BEry03rv9wc5np14WZq/dpLp+/IOpk4=;
 b=gY1BDT+ACDS1TcuZpq3P1DZ6wou0wTPcX1dRBhRQ9J6X/MXmCmbZwYdQ
 7Db86exWx3C+C9s2ItrkDflzObbMQRrMorF3tUCQvqNXNQEqsOawCuB4A
 CA2ds9zWjevLiMm+F70RqQOHoiElnIrONol7JORz/w0LlMSn1yzAOERWd
 Vyy6mytZaJHccBSN8tkMHufvZY/qmow6NInhtDVAKn/N64NhWcg0U+TUq
 u5u9FOBGDEkmKAs2PT84I2VZufAKiea6OdtpURtmBLML4npBqrhCpTqBN
 R9UbSoi368nu2e+LJADQXzalNeayDXh7PRbgwV7u2TwklyculDtiS1uEJ w==;
X-CSE-ConnectionGUID: wmIs9s2kQVy6s7ujJjR4PQ==
X-CSE-MsgGUID: GBZSj6Z4QjW5CvCE5X1xHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="25584481"
X-IronPort-AV: E=Sophos;i="6.09,288,1716274800"; d="scan'208";a="25584481"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2024 01:02:41 -0700
X-CSE-ConnectionGUID: w+NWm/qsQEObMRIL6k8yPQ==
X-CSE-MsgGUID: SZlHgF/pR8av3GAvF8+zDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,288,1716274800"; d="scan'208";a="59048955"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa010.fm.intel.com with ESMTP; 14 Aug 2024 01:02:38 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org,
	kvm@vger.kernel.org,
	xiaoyao.li@intel.com
Subject: [PATCH 5/9] i386/cpu: Construct CPUID 2 as stateful iff times > 1
Date: Wed, 14 Aug 2024 03:54:27 -0400
Message-Id: <20240814075431.339209-6-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814075431.339209-1-xiaoyao.li@intel.com>
References: <20240814075431.339209-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.15; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_MED=-2.3,
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

When times == 1, the CPUID leaf 2 is not stateful.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/kvm/kvm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index c168ff5691df..6618259f265c 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -1818,10 +1818,12 @@ static uint32_t kvm_x86_build_cpuid(CPUX86State *env,
             int times;
 
             c->function = i;
-            c->flags = KVM_CPUID_FLAG_STATEFUL_FUNC |
-                       KVM_CPUID_FLAG_STATE_READ_NEXT;
             cpu_x86_cpuid(env, i, 0, &c->eax, &c->ebx, &c->ecx, &c->edx);
             times = c->eax & 0xff;
+            if (times > 1) {
+                c->flags = KVM_CPUID_FLAG_STATEFUL_FUNC |
+                           KVM_CPUID_FLAG_STATE_READ_NEXT;
+            }
 
             for (j = 1; j < times; ++j) {
                 if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
-- 
2.34.1


