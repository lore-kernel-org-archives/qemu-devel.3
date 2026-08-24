Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34EFBC5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 04:56:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyMj6-0006Q0-E2; Mon, 24 Aug 2026 00:56:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang_wei@open-hieco.net>)
 id 1wyMj4-0006M1-AN
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 00:56:02 -0400
Received: from [115.124.28.147] (helo=out28-147.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang_wei@open-hieco.net>)
 id 1wyMiy-00039O-NY
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 00:56:02 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.09052175|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_regular_dialog|0.0319094-0.020085-0.948006;
 FP=7187561936658883669|1|1|1|0|-1|-1|-1; HT=maildocker-contentspam033032023038;
 MF=zhang_wei@open-hieco.net; NM=1; PH=DS; RN=8; RT=8; SR=0;
 TI=SMTPD_---.ivXOSs8_1787547223; 
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net
 fp:SMTPD_---.ivXOSs8_1787547223 cluster:ay29) by smtp.aliyun-inc.com;
 Mon, 24 Aug 2026 12:53:43 +0800
From: Tina Zhang <zhang_wei@open-hieco.net>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Cc: kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Yanjing Zhou <zhouyanjing@hygon.cn>,
 Tina Zhang <zhang_wei@open-hieco.net>
Subject: [PATCH v3 07/10] target/i386: Do not broadcast injected MCEs for Hygon
Date: Mon, 24 Aug 2026 12:53:11 +0800
Message-ID: <20260824045314.162941-8-zhang_wei@open-hieco.net>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260824045314.162941-1-zhang_wei@open-hieco.net>
References: <20260824045314.162941-1-zhang_wei@open-hieco.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.28.147 (deferred)
Received-SPF: pass client-ip=115.124.28.147;
 envelope-from=zhang_wei@open-hieco.net; helo=out28-147.mail.aliyun.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, RDNS_NONE=0.793,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01,
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

cpu_x86_support_mca_broadcast() excludes AMD CPUs because QEMU handles
AMD injected MCEs as local machine checks, not as Intel-style broadcast
MCEs.  Hygon Dhyana missed that exclusion: it is not an AMD vendor CPU
and its family is greater than 6, so QEMU reported MCA broadcast
support.

This affects QEMU's synthetic MCE injection paths.  KVM memory-failure
injection uses this helper to decide whether to set MCE_INJECT_BROADCAST.
HMP 'mce -b' uses it to decide whether a broadcast request is valid.
With a multi-vCPU Dhyana guest, QEMU could fan out an injected MCE to
secondary vCPUs and populate extra bank records.

Linux routes Hygon through the AMD MCE feature initialization path and
does not use Intel/Zhaoxin LMCE broadcast handling for Hygon.  Do not
advertise Intel-style MCA broadcast support for Hygon in QEMU's injected
MCE paths.

This is limited to the MCE broadcast-support decision.  It does not claim
that all Hygon MCE/MCA behavior is identical to AMD.

Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/helper.c b/target/i386/helper.c
index 6836214162..c5bbe9715b 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -95,7 +95,7 @@ int cpu_x86_support_mca_broadcast(CPUX86State *env)
     int family = 0;
     int model = 0;
 
-    if (IS_AMD_CPU(env)) {
+    if (IS_AMD_CPU(env) || IS_HYGON_CPU(env)) {
         return 0;
     }
 
-- 
2.43.7


