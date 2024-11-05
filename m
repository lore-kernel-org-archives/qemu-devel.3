Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81EE7D1CA38
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 06:43:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8DH4-0005lW-AZ; Tue, 05 Nov 2024 01:42:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8DEy-0003XE-F7
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 01:40:37 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8DEj-0001vj-Uy
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 01:40:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730788822; x=1762324822;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=P5Dpgnlq8pIkngj4xnDuBRfdAfvVDs1AjzLSgYZekNU=;
 b=hFQEwAiXqQKHSHvdCVtZDyi9zjvcHquIZ5uNuqBZ13qb0DbfV0H9IQlq
 aEoA7jlIzNVy+WZWzgrIUZF1K0i9qTUSAMy7B5/XOqJGOSRafhaVfTW+c
 C5JX5PqEbzRLuLt/1UhARBUcIrxv7l+NAb5AmME66qZASYmPKfGejuiJu
 n3nq5YPd8D6FKOHkXQamgnfDSV/DewUTY31HoAAbTkBtyiHWQ8AjcaNG2
 Rshw6krVem6LkNHUmv4glasP0APDxMZcw4HH9+n++Kzxnc72yRtIMzAmj
 Nw1Nsc3d6us90KMzI66cyi2PLLQvyzB7prUdXkMtKdA7oVROh+bRIJvbN A==;
X-CSE-ConnectionGUID: ogY3fIsVRC2g10wYBKtYvA==
X-CSE-MsgGUID: C4FHXc3vSI25WJ2dcJtwAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30689884"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="30689884"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2024 22:40:05 -0800
X-CSE-ConnectionGUID: c9TSTQY7QYKD76jrtTi9Dw==
X-CSE-MsgGUID: zpSR5Yn5SvKva1MN49xPSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; d="scan'208";a="83989906"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa009.fm.intel.com with ESMTP; 04 Nov 2024 22:40:01 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, rick.p.edgecombe@intel.com,
 kvm@vger.kernel.org, qemu-devel@nongnu.org, xiaoyao.li@intel.com
Subject: [PATCH v6 52/60] i386/cpu: Expose mark_unavailable_features() for TDX
Date: Tue,  5 Nov 2024 01:24:00 -0500
Message-Id: <20241105062408.3533704-53-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105062408.3533704-1-xiaoyao.li@intel.com>
References: <20241105062408.3533704-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.781, RCVD_IN_DNSWL_MED=-2.3,
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

Expose mark_unavailable_features() out of cpu.c so that it can be used
by TDX when features are masked off.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/cpu.c | 4 ++--
 target/i386/cpu.h | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 8c507ad406e7..e728fb6b9f10 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5479,8 +5479,8 @@ static bool x86_cpu_have_filtered_features(X86CPU *cpu)
     return false;
 }
 
-static void mark_unavailable_features(X86CPU *cpu, FeatureWord w, uint64_t mask,
-                                      const char *verbose_prefix)
+void mark_unavailable_features(X86CPU *cpu, FeatureWord w, uint64_t mask,
+                               const char *verbose_prefix)
 {
     CPUX86State *env = &cpu->env;
     FeatureWordInfo *f = &feature_word_info[w];
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 0cc88c470dfb..e70e7f5ced4b 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2444,6 +2444,8 @@ void cpu_set_apic_feature(CPUX86State *env);
 void host_cpuid(uint32_t function, uint32_t count,
                 uint32_t *eax, uint32_t *ebx, uint32_t *ecx, uint32_t *edx);
 bool cpu_has_x2apic_feature(CPUX86State *env);
+void mark_unavailable_features(X86CPU *cpu, FeatureWord w, uint64_t mask,
+                               const char *verbose_prefix);
 
 static inline bool x86_has_cpuid_0x1f(X86CPU *cpu)
 {
-- 
2.34.1


