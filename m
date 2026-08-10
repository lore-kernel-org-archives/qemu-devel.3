Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49404C5AC82
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 08:34:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtLS5-0001Rn-Jg; Mon, 10 Aug 2026 04:33:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang_wei@open-hieco.net>)
 id 1wtLRh-0001Pk-HC
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 04:33:22 -0400
Received: from [115.124.28.4] (helo=out28-4.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang_wei@open-hieco.net>)
 id 1wtLRd-0005CI-8c
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 04:33:21 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07985309|-1; CH=green;
 DM=|CONTINUE|false|; DS=CONTINUE|ham_alarm|0.0198397-0.00211061-0.97805;
 FP=16418793524219815007|1|1|1|0|-1|-1|-1;
 HT=maildocker-contentspam033068016216; MF=zhang_wei@open-hieco.net; NM=1;
 PH=DS; RN=8; RT=8; SR=0; TI=SMTPD_---.iiL7hQN_1786350664; 
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net
 fp:SMTPD_---.iiL7hQN_1786350664 cluster:ay29) by smtp.aliyun-inc.com;
 Mon, 10 Aug 2026 16:31:04 +0800
From: Tina Zhang <zhang_wei@open-hieco.net>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Yanjing Zhou <zhouyanjing@hygon.cn>,
 Tina Zhang <zhang_wei@open-hieco.net>
Subject: [PATCH v2 8/9] target/i386: Use AMD legacy cache fallback for Hygon
Date: Mon, 10 Aug 2026 16:29:55 +0800
Message-ID: <20260810082956.1768042-9-zhang_wei@open-hieco.net>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260810082956.1768042-1-zhang_wei@open-hieco.net>
References: <20260810082956.1768042-1-zhang_wei@open-hieco.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.28.4 (deferred)
Received-SPF: pass client-ip=115.124.28.4;
 envelope-from=zhang_wei@open-hieco.net; helo=out28-4.mail.aliyun.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, RDNS_NONE=0.793,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

When legacy-cache=on, x86_cpu_realizefn() builds a hardcoded cache
model.  It selected the AMD legacy cache table only for CPUs with the
AuthenticAMD vendor ID.  Dhyana uses the HygonGenuine vendor ID, so this
explicit compatibility path fell back to QEMU's old Intel legacy cache
table.

The wrong table is visible through AMD extended cache leaves.  With the
Intel legacy table, Dhyana reports 32 KiB, 8-way L1 caches in CPUID
0x80000005 and a 4 MiB, 16-way L2 cache in CPUID 0x80000006.  Linux
uses the AMD/Hygon cache enumeration path for Hygon and reads these AMD
extended cache leaves.

Use the AMD legacy cache table for Hygon in this fallback path when the
new vendor CPU ABI is enabled.  Keep the old fallback for pc-11.0 and
older machine types through x-hygon-vendor-abi-fixes=false.

The default Dhyana model is unchanged because it provides EPYC cache_info
and therefore defaults legacy-cache to off.  The guest-visible change is
limited to users who explicitly configure legacy-cache=on on new machine
types.

Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 569ef785ca..4d8364f1ef 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10329,7 +10329,8 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
             env->enable_legacy_vendor_cache = true;
         }
 
-        if (IS_AMD_CPU(env)) {
+        if (IS_AMD_CPU(env) ||
+            (IS_HYGON_CPU(env) && cpu->hygon_vendor_abi_fixes)) {
             env->cache_info = legacy_amd_cache_info;
         } else {
             env->cache_info = legacy_intel_cache_info;
-- 
2.43.7


