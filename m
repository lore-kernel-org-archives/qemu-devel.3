Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32980E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 11:16:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOEVy-0004lC-6b; Thu, 19 Dec 2024 06:16:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tOEVu-0004cD-4I
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 06:16:19 -0500
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tOEVs-0005Kx-Di
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 06:16:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734606977; x=1766142977;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MHgdNVgv8JU4EXomJN5hU+EHD1vfrDJJzg4gGCEl33Y=;
 b=CB5/rBGKLwHDOn+b9CWfz4Y8Y/EeCiWOb+bHbN+XsEIx15n4r4QjJV/E
 VWoBTS76/G5AW7G+EPEK2+eT6YFAhcQ9PywyWbs+5ki3h1a6rQS7wiql6
 K51DwDT7ciSX3VGUjep9YD3vVT9uK41TJFcVir7Y42PoIRSUwBeQ/lv9d
 816l2XwUbCvGtQ7HmHjiorAa9yWPj9mJixqTFXkrXYwmOspEdzAyIq12b
 uOiDMqXRYDmVtu+L1xnQOAyhnH/8jPpS1mSTEEFrLXaVLY3MbW6kB8KJw
 qDUOrUtfGssBTPSygRMfVdsQ/3jx7WD5l+gryzkArrJc6dP+NF4lId2Fu A==;
X-CSE-ConnectionGUID: WWiYbFKKTGGYWoJu9vYWUA==
X-CSE-MsgGUID: 1MW9reJDRV265Krrk8NEdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="34994988"
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; d="scan'208";a="34994988"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Dec 2024 03:16:16 -0800
X-CSE-ConnectionGUID: +MY+tXIkTxakM5AkCiefYg==
X-CSE-MsgGUID: KvXn05KtSXe/drhSwlIZ9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; d="scan'208";a="97956195"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa006.fm.intel.com with ESMTP; 19 Dec 2024 03:16:13 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Yanan Wang <wangyanan55@huawei.com>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, xiaoyao.li@intel.com
Subject: [PATCH v2 09/10] i386/cpu: Set up CPUID_HT in
 x86_cpu_expand_features() instead of cpu_x86_cpuid()
Date: Thu, 19 Dec 2024 06:01:24 -0500
Message-Id: <20241219110125.1266461-10-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241219110125.1266461-1-xiaoyao.li@intel.com>
References: <20241219110125.1266461-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.19; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
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

Currently CPUID_HT is evaluated in cpu_x86_cpuid() each time. It's not a
correct usage of how feature bit is maintained and evaluated. The
expected practice is that features are tracked in env->features[] and
cpu_x86_cpuid() should be the consumer of env->features[].

Track CPUID_HT in env->features[FEAT_1_EDX] instead and evaluate it in
cpu's realizefn().

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
There is one issue[1] of CPUID_HT being user settable that when
"-cpu xxx,-ht" with "-smp 2", HT flag is still exposed to guest.
However, the issue is not irrelevant to this patch. If anyone has
interest to reslove it please go ahead.

[1] https://lore.kernel.org/qemu-devel/Z1FUDGnenETEFV6Z@intel.com/
---
 target/i386/cpu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index fd59da5d445d..bee494bdd029 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6537,7 +6537,6 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         *edx = env->features[FEAT_1_EDX];
         if (threads_per_pkg > 1) {
             *ebx |= threads_per_pkg << 16;
-            *edx |= CPUID_HT;
         }
         if (!cpu->enable_pmu) {
             *ecx &= ~CPUID_EXT_PDCM;
@@ -7528,6 +7527,10 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
         }
     }
 
+    if (x86_threads_per_pkg(&env->topo_info) > 1) {
+        env->features[FEAT_1_EDX] |= CPUID_HT;
+    }
+
     for (i = 0; i < ARRAY_SIZE(feature_dependencies); i++) {
         FeatureDep *d = &feature_dependencies[i];
         if (!(env->features[d->from.index] & d->from.mask)) {
-- 
2.34.1


