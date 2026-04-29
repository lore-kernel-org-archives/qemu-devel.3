Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F38CD13D3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 19:06:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIAEj-00021v-1J; Wed, 29 Apr 2026 15:06:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wIAEh-00020o-NU
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 15:06:15 -0400
Received: from p-west3-cluster3-host5-snip4-9.eps.apple.com ([57.103.72.140]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wIAEg-0000Tv-7R
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 15:06:15 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-6 (Postfix) with ESMTPS id
 17BBB1800BC1; Wed, 29 Apr 2026 19:06:11 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRJAE1fDl4fBBdGGVUERx5dVl4eGQJRHFYNV0NUBF9QSQxBUGxaAEcXSB1dGVlvUF0cDhhZG0AVXRFQGVYJXhUXHkFNWgJWTQVKA18BWwZCAEkKXQJYAF4LTgZeD0YDQxQVXAVWBlcUeQ1dHUUOVhlaDFIPWw4cFktGExlOG1dNWg1AGVgGbRRWFVIEWQ==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1777489573; x=1780081573;
 bh=JKmKVUkd2EnQGVw0Fv4/3w/jcAP1s/vsdxXqtaqNyzo=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=fBM9tdItTXp11r9gm7GrtDeO2qSSZvdJ8J408GVtaVH0L6kiUnzHg7UvpQBVNDab/JpIW2OaagwfkQ8/nw/xJNixoNG2BXvEEs/Sm/iZ9wRjje7dEi9VzMdHXM8VyIcmhYLL8ygduzjF3Aq72mPrSrfk3bFwaCFAvDCV857jrBEdljxJrCBT4PwW2Wfl2+ZfVyRTtFRpeFYSetfumW17ZEENVjvENn+cCJD3MHW8xfTmMU1bnP9DTyrmbWHgaw773ARIe7JzpSSlEeAjV3EMl9DbV7W3DJzGYMydRASOcR3onOatIo1xeK1e+7JfBBsJqJqp2/6/Mc+c4wcOSz80zg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-6 (Postfix) with ESMTPSA id
 518D218005D1; Wed, 29 Apr 2026 19:06:09 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Alexander Graf <agraf@csgraf.de>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v21 12/15] hvf: arm: disable SME when nested virt is active
Date: Wed, 29 Apr 2026 21:05:29 +0200
Message-ID: <20260429190532.26538-13-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260429190532.26538-1-mohamed@unpredictable.fr>
References: <20260429190532.26538-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE5MCBTYWx0ZWRfXyg0N179KeJyh
 x8TYhx6RM0g1+4jcv4lCIwTf4q5aUgVMPY9i6y6mkztsdo/zu8SU/p5Jt8vF+vSRQamac/KAvh4
 kjpDOYRnzcfoqAIEMqhozIG8O7WgWdItIRT0kXBvz7hUPwloXYdTBh1sb4dN/QKsKfqtpdKsZ7o
 PxJA8obu6tXCssBch70WUS3FWsEXd5S9c8lEBK69BgPI4BxfrBpai27JH/XRJxfaHvHNrC9mAV+
 1TXVAYYJzVT9F6NVRqyy9e/H/BdnU4+rGJaK8GXC6U90QbA/tiXoMFBvFtA6HMtK4LGc9/ZlZO6
 0fegDmI23j1GUAuIvzMXzrJN4N3ofRMMPwzj5kVCv0Q6SxUdFi6rHdEWUd818Q=
X-Authority-Info-Out: v=2.4 cv=aoq/yCZV c=1 sm=1 tr=0 ts=69f256a4
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8
 a=x7Faj_LQiP2RIwM6i0UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: _PyNNLsqUmSEjIacjNZSMNMVxeihzJYK
X-Proofpoint-GUID: _PyNNLsqUmSEjIacjNZSMNMVxeihzJYK
Received-SPF: pass client-ip=57.103.72.140;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Currently, Apple doesn't support the nested virtualisation + SME combination.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c | 5 +++++
 target/arm/hvf_arm.h | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index ceeb61fbc0..51b37b3331 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1206,6 +1206,11 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
         FIELD_DP64_IDREG(&host_isar, ID_AA64DFR0, PMUVER, 0x1);
     }
 
+    if (hvf_nested_virt_enabled()) {
+        /* SME is not implemented with nested virt on the Apple side */
+        FIELD_DP64_IDREG(&host_isar, ID_AA64PFR1, SME, 0);
+    }
+
     ahcf->isar = host_isar;
 
     /*
diff --git a/target/arm/hvf_arm.h b/target/arm/hvf_arm.h
index 8029d48caf..59e19f6e84 100644
--- a/target/arm/hvf_arm.h
+++ b/target/arm/hvf_arm.h
@@ -11,6 +11,7 @@
 #ifndef QEMU_HVF_ARM_H
 #define QEMU_HVF_ARM_H
 
+#include "system/hvf.h"
 #include "target/arm/cpu-qom.h"
 
 /**
@@ -35,6 +36,10 @@ void hvf_arm_set_cpu_features_from_host(ARMCPU *cpu);
         if (__builtin_available(macOS 15.2, *)) {
             size_t svl_bytes;
             hv_return_t result = hv_sme_config_get_max_svl_bytes(&svl_bytes);
+            /* Nested virt not supported together with SME right now. */
+            if (hvf_nested_virt_enabled()) {
+                return false;
+            }
             if (result == HV_UNSUPPORTED) {
                 return false;
             }
-- 
2.50.1 (Apple Git-155)


