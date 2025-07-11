Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79FEFC83F1D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 10:04:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaAaC-0005Rs-8S; Fri, 11 Jul 2025 06:02:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uaAZg-0003wv-Hg
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 06:01:48 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uaAZe-0005cy-9n
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 06:01:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752228106; x=1783764106;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XIdoThL/w+88qJ0nzFUPEXeYz1YyOXsdwaPKHQb2Un8=;
 b=KWwYyYp+fZQOFq7il7Dn2MCGAjOVp4c/ZmSMvavRKBcsLzXM339ERKQm
 maDgcJSWfcBTwbBPNBn1F9+VISMJXdgpNl51DqNagbl/9jutbb7dMINml
 sLfir4XS/nh8qglGTYZtrOLQ4JZl3cLGDR+K9edNd2gOBJ664QQjk5TWK
 P+s1zRKxpa2hV17C9chYVc0WqAbBSqZXBJXMDdOMcGI73Oe9+rprAGBps
 eGxSd50rY1VQnYMvH0vwvwIeFqEITOxAAq+7NB0jhFr89TvdIBAe/+n0i
 vPQT3skJ+uEvsQ9e3TibBuounzBTxKANfPCLn+KI2BAeoDZIQkr0H5wt0 A==;
X-CSE-ConnectionGUID: lw1veNEgSP2hv0gGIK9RFQ==
X-CSE-MsgGUID: w85HEczXSiyke0vmZ9p5rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="54496451"
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; d="scan'208";a="54496451"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jul 2025 03:01:45 -0700
X-CSE-ConnectionGUID: VE1FAdX3SfqhL5gNMRIQvQ==
X-CSE-MsgGUID: vdtHbcFEQEqYm/U0kIVTnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; d="scan'208";a="160662159"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 11 Jul 2025 03:01:40 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Babu Moger <babu.moger@amd.com>, Ewan Hai <ewanhai-oc@zhaoxin.com>,
 Pu Wen <puwen@hygon.cn>, Tao Su <tao1.su@intel.com>,
 Yi Lai <yi1.lai@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 17/18] i386/cpu: Select legacy cache model based on vendor
 in CPUID 0x8000001D
Date: Fri, 11 Jul 2025 18:21:42 +0800
Message-Id: <20250711102143.1622339-18-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711102143.1622339-1-zhao1.liu@intel.com>
References: <20250711102143.1622339-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

As preparation for merging cache_info_cpuid4 and cache_info_amd in
X86CPUState, set legacy cache model based on vendor in the CPUID
0x8000001D leaf. For AMD CPU, select legacy AMD cache model (in
cache_info_amd) as the default cache model like before, otherwise,
select legacy Intel cache model (in cache_info_cpuid4).

In fact, for Intel (and Zhaoxin) CPU, this change is safe because the
extended CPUID level supported by Intel is up to 0x80000008. So Intel
Guest doesn't have this 0x8000001D leaf.

Although someone could bump "xlevel" up to 0x8000001D for Intel Guest,
it's meaningless and this is undefined behavior. This leaf should be
considered reserved, but the SDM does not explicitly state this. So,
there's no need to specifically use vendor_cpuid_only_v2 to fix
anything, as it doesn't even qualify as a fix since nothing is
currently broken.

Therefore, it is acceptable to select the default legacy cache model
based on the vendor.

For the CPUID 0x8000001D leaf, in X86CPUState, a unified cache_info is
enough. It only needs to be initialized and configured with the
corresponding legacy cache model based on the vendor.

Tested-by: Yi Lai <yi1.lai@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index fe1c118b284f..df13dbc63a3f 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8082,7 +8082,22 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *edx = 0;
         }
         break;
-    case 0x8000001D:
+    case 0x8000001D: {
+        const CPUCaches *caches;
+
+        /*
+         * FIXME: Temporarily select cache info model here based on
+         * vendor, and merge these 2 cache info models later.
+         *
+         * Intel doesn't support this leaf so that Intel Guests don't
+         * have this leaf. This change is harmless to Intel CPUs.
+         */
+        if (IS_AMD_CPU(env)) {
+            caches = &env->cache_info_amd;
+        } else {
+            caches = &env->cache_info_cpuid4;
+        }
+
         *eax = 0;
         if (cpu->cache_info_passthrough) {
             x86_cpu_get_cache_cpuid(index, count, eax, ebx, ecx, edx);
@@ -8090,19 +8105,19 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         }
         switch (count) {
         case 0: /* L1 dcache info */
-            encode_cache_cpuid8000001d(env->cache_info_amd.l1d_cache,
+            encode_cache_cpuid8000001d(caches->l1d_cache,
                                        topo_info, eax, ebx, ecx, edx);
             break;
         case 1: /* L1 icache info */
-            encode_cache_cpuid8000001d(env->cache_info_amd.l1i_cache,
+            encode_cache_cpuid8000001d(caches->l1i_cache,
                                        topo_info, eax, ebx, ecx, edx);
             break;
         case 2: /* L2 cache info */
-            encode_cache_cpuid8000001d(env->cache_info_amd.l2_cache,
+            encode_cache_cpuid8000001d(caches->l2_cache,
                                        topo_info, eax, ebx, ecx, edx);
             break;
         case 3: /* L3 cache info */
-            encode_cache_cpuid8000001d(env->cache_info_amd.l3_cache,
+            encode_cache_cpuid8000001d(caches->l3_cache,
                                        topo_info, eax, ebx, ecx, edx);
             break;
         default: /* end of info */
@@ -8113,6 +8128,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *edx &= CACHE_NO_INVD_SHARING | CACHE_INCLUSIVE;
         }
         break;
+    }
     case 0x8000001E:
         if (cpu->core_id <= 255) {
             encode_topo_cpuid8000001e(cpu, topo_info, eax, ebx, ecx, edx);
-- 
2.34.1


