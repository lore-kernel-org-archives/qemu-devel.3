Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE7FD1CA3A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 06:48:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8DGu-000558-RS; Tue, 05 Nov 2024 01:42:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8DEw-0003X7-LE
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 01:40:44 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8DEn-0001w0-OO
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 01:40:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730788826; x=1762324826;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xs0CRmXKoLP85ntSNgfzBFyenj5am27Jk7rZikXTb+4=;
 b=U36pv/TlOWJa8NB1J4Kz6OzrBI39+xip/fh5irg7mzNU9Xf2yTPgPNdC
 Pvv8vQ1WCpbreRlMlmLo0hH1uxSbDnU5EcY80MZS/p5/v9SLg6TqhU6pf
 OnHiqxgkdUb4206yOqk0/iDgeXHQ96gsLxY5zrdAzU9v5ylBwtoaoP2wn
 fLG7HYhj7cr9IxpPO6WEK+99Md9kKyE8RTv/gVSyhtWlGhAaeJLHn2xQJ
 RKIvrUjyXIRX8NASFhTBV6FQkVuCrADImfECvD+UZHzoYig+moSxtqPTW
 fu1fPmV2/UWaxetUaXEdRrdu0OGkiIpI/eHGObY5eSfVLTuY70t7TW/Ty w==;
X-CSE-ConnectionGUID: yiR6peEyTDC8SG4abNdtXw==
X-CSE-MsgGUID: mmBd1LWWQOq+6gXqbiBbDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30689907"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="30689907"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2024 22:40:14 -0800
X-CSE-ConnectionGUID: +AXT2kK8SDWa5RYfBzoJxw==
X-CSE-MsgGUID: xLmUcX+pSb2KsI+RjIq5Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; d="scan'208";a="83989984"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa009.fm.intel.com with ESMTP; 04 Nov 2024 22:40:09 -0800
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
Subject: [PATCH v6 54/60] i386/cgs: Introduce
 x86_confidential_guest_check_features()
Date: Tue,  5 Nov 2024 01:24:02 -0500
Message-Id: <20241105062408.3533704-55-xiaoyao.li@intel.com>
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

To do cgs specific feature checking. Note the feature checking in
x86_cpu_filter_features() is valid for non-cgs VMs. For cgs VMs like
TDX, what features can be supported has more restrictions.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/confidential-guest.h | 13 +++++++++++++
 target/i386/kvm/kvm.c            |  8 ++++++++
 2 files changed, 21 insertions(+)

diff --git a/target/i386/confidential-guest.h b/target/i386/confidential-guest.h
index 2dde29889c23..3018f38e18bf 100644
--- a/target/i386/confidential-guest.h
+++ b/target/i386/confidential-guest.h
@@ -43,6 +43,7 @@ struct X86ConfidentialGuestClass {
     void (*cpu_realizefn)(X86ConfidentialGuest *cg, CPUState *cpu, Error **errp);
     uint32_t (*adjust_cpuid_features)(X86ConfidentialGuest *cg, uint32_t feature,
                                       uint32_t index, int reg, uint32_t value);
+    int (*check_features)(X86ConfidentialGuest *cg, CPUState *cs);
 };
 
 /**
@@ -103,4 +104,16 @@ static inline int x86_confidential_guest_adjust_cpuid_features(X86ConfidentialGu
     }
 }
 
+static inline int x86_confidential_guest_check_features(X86ConfidentialGuest *cg,
+                                                        CPUState *cs)
+{
+    X86ConfidentialGuestClass *klass = X86_CONFIDENTIAL_GUEST_GET_CLASS(cg);
+
+    if (klass->check_features) {
+        return klass->check_features(cg, cs);
+    }
+
+    return 0;
+}
+
 #endif
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index f067961fba43..42dc5b78faf0 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2086,6 +2086,14 @@ int kvm_arch_init_vcpu(CPUState *cs)
     int r;
     Error *local_err = NULL;
 
+    if (current_machine->cgs) {
+        r = x86_confidential_guest_check_features(
+                X86_CONFIDENTIAL_GUEST(current_machine->cgs), cs);
+        if (r < 0) {
+            return r;
+        }
+    }
+
     memset(&cpuid_data, 0, sizeof(cpuid_data));
 
     cpuid_i = 0;
-- 
2.34.1


