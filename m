Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B4BAD1CA3A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 06:53:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8DHK-0006hx-TG; Tue, 05 Nov 2024 01:43:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8DEy-0003X1-Mc
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 01:40:45 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8DEl-0001vd-3i
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 01:40:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730788823; x=1762324823;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Cd6UQJeNLnYBe3u2FXzM6iswu2YcXGcY/0+XpTAWb5M=;
 b=HwK/YqSHttvDofiENIUswqt8RkZ09teQZ8gKtTDYCeuGvpreozuesbwG
 SW0MpAUA/s1ow5fRmCW5DvzLLOIIZp8v6xZ8H/Bo0OpHeJRMA4mrANKtc
 9o3JFdJHy3c+W147Vvaa1DY2VHVDX3xUPswoyhBwbHoxv/+u4HQJnjXiD
 4tShvjRpPppNzU1pXf9EHn7HZcCMp1PrLvfSiNFRDHmZ++HiW1gbyBvug
 C5IUOzoKdDPTK/H6SpP809EVC91e3xoKOGnACPuT20TH4uS3GPR16d9k/
 Nj8EeOikz0D6KXRBrgGSbN9QQVuUXWnV+2BCXlepdBlo7bSdDMV8Bv3et g==;
X-CSE-ConnectionGUID: yYQP5rIGRaeiwIxJjkonCA==
X-CSE-MsgGUID: OwR2/IsQTGyR6dX3SV6i0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30689896"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="30689896"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2024 22:40:09 -0800
X-CSE-ConnectionGUID: rHLLn7tpR9W0Ru67Q1UL8w==
X-CSE-MsgGUID: ttu57Bs2RkOUlOsMPVmdKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; d="scan'208";a="83989941"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa009.fm.intel.com with ESMTP; 04 Nov 2024 22:40:05 -0800
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
Subject: [PATCH v6 53/60] i386/cpu: introduce mark_forced_on_features()
Date: Tue,  5 Nov 2024 01:24:01 -0500
Message-Id: <20241105062408.3533704-54-xiaoyao.li@intel.com>
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

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/cpu.c | 29 +++++++++++++++++++++++++++++
 target/i386/cpu.h |  5 +++++
 2 files changed, 34 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index e728fb6b9f10..472ab206d8fe 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5507,6 +5507,35 @@ void mark_unavailable_features(X86CPU *cpu, FeatureWord w, uint64_t mask,
     }
 }
 
+void mark_forced_on_features(X86CPU *cpu, FeatureWord w, uint64_t mask,
+                             const char *verbose_prefix)
+{
+    CPUX86State *env = &cpu->env;
+    FeatureWordInfo *f = &feature_word_info[w];
+    int i;
+
+    if (!cpu->force_features) {
+        env->features[w] |= mask;
+    }
+
+    cpu->forced_on_features[w] |= mask;
+
+    if (!verbose_prefix) {
+        return;
+    }
+
+    for (i = 0; i < 64; ++i) {
+        if ((1ULL << i) & mask) {
+            g_autofree char *feat_word_str = feature_word_description(f, i);
+            warn_report("%s: %s%s%s [bit %d]",
+                        verbose_prefix,
+                        feat_word_str,
+                        f->feat_names[i] ? "." : "",
+                        f->feat_names[i] ? f->feat_names[i] : "", i);
+        }
+    }
+}
+
 static void x86_cpuid_version_get_family(Object *obj, Visitor *v,
                                          const char *name, void *opaque,
                                          Error **errp)
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index e70e7f5ced4b..b5b1c3917427 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2135,6 +2135,9 @@ struct ArchCPU {
     /* Features that were filtered out because of missing host capabilities */
     FeatureWordArray filtered_features;
 
+    /* Features that are forced enabled by underlying hypervisor, e.g., TDX */
+    FeatureWordArray forced_on_features;
+
     /* Enable PMU CPUID bits. This can't be enabled by default yet because
      * it doesn't have ABI stability guarantees, as it passes all PMU CPUID
      * bits returned by GET_SUPPORTED_CPUID (that depend on host CPU and kernel
@@ -2446,6 +2449,8 @@ void host_cpuid(uint32_t function, uint32_t count,
 bool cpu_has_x2apic_feature(CPUX86State *env);
 void mark_unavailable_features(X86CPU *cpu, FeatureWord w, uint64_t mask,
                                const char *verbose_prefix);
+void mark_forced_on_features(X86CPU *cpu, FeatureWord w, uint64_t mask,
+                             const char *verbose_prefix);
 
 static inline bool x86_has_cpuid_0x1f(X86CPU *cpu)
 {
-- 
2.34.1


