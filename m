Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C11F55105
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 18:06:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyw0a-00025Y-9N; Sat, 07 Mar 2026 13:04:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyw0W-00024U-Da
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 13:04:08 -0500
Received: from p-west2-cluster4-host9-snip4-10.eps.apple.com ([57.103.69.181]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyw0U-0003Y4-Hy
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 13:04:08 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-5 (Postfix) with ESMTPS id
 145A51800132; Sat,  7 Mar 2026 18:04:03 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772906645; x=1775498645;
 bh=3yh5HIrcULHJxYVQbGGuriOXIl6oe39CV995zPmVByw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=BVyI896X7/325u6n8a1h8c78Bm+Cs4a2bRDoAxIbvuVnRy5UVDYZLubEs74Lqb185YHfSFkcOQJgulN/XxFtTW/reU+QzDlBwxjV4pT7AVnUpw5UDPG9HQsj4gdcKpEaO0uNEkOV/ozQQv+HAgisi6+95E8UrXLnpJKFd3ud60RIJcOtFfgZqQ0NuAIL6fG8rE8qv7w6GhksOs8VnZJzDCnsGuuobsTdoUV+//WCXk+uaxRDPPukIcuWBsCrsnNUdrFvpKA7IGLumWTULu414QOvamaBZ1rwzQVJS+lfoEimpAlzYueetq+SmJ9KCi81oqZQ5xcx8+fTps9UrX/M+w==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-5 (Postfix) with ESMTPSA id
 A3D811801265; Sat,  7 Mar 2026 18:04:01 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Phil Dennis-Jordan <phil@philjordan.eu>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v19 12/13] hvf: arm: disable SME when nested virt is active
Date: Sat,  7 Mar 2026 19:03:29 +0100
Message-ID: <20260307180330.75168-13-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260307180330.75168-1-mohamed@unpredictable.fr>
References: <20260307180330.75168-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=AZa83nXG c=1 sm=1 tr=0 ts=69ac6894
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=Nb5tGvShBxYZWtT_8e0A:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: m6PeLdvbBt8iA2-8st7p0y3MwLkL5oNZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA3MDE3MSBTYWx0ZWRfX8ewVzoD7Q7KT
 ibMC4g7whjQFB7Zib/we3bPoGov8SyM55uWb6hdRAsWLOPT+ACnGaYxMmLC0dlDxHnLZ9tqcBua
 xsTxhBURSKcqB81Uvnx9PNtFxsloW1XQ0AFkdOo56rb3L1YWREbXIKqVjrJP8XkT1D2xgdv9lfq
 QfOm/0LYdqIzduT/kUCiRcsUNfLYNjp8SFAQRdWvvTTI5vyM2udA+svsjQV98HKyd07UzPMT0cu
 RpiuTWMxO+pw4DdNp4iVIDs4ZedYq9wkwHO7aLrO0prBU1ZwEpmnU/oh8OwDpcyMkxA/i9pfpPF
 Rt8MTpkCUmtiw2YtSAf0VnVfTqjoYWvuvToTxSk6v/8o3BqYLbl0kJPWIv7IF0=
X-Proofpoint-GUID: m6PeLdvbBt8iA2-8st7p0y3MwLkL5oNZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-07_06,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 spamscore=0 mlxlogscore=753 lowpriorityscore=0 bulkscore=0
 mlxscore=0 clxscore=1030 malwarescore=0 suspectscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603070171
X-JNJ: AAAAAAABINOfCSBaUSxuMmtektptAqdO7K0yhXP6D4oUkdEmjTaJglavXXxzNZRV8zSlzbYu4J3jEeeHSBogkYI4pby8hG5A90COYVWtvjWSxqcBltUPgggBldjktUbC4KbtuKi0mwEu+y8vZs1R2S8VIRcubj6sbBudcPVuzpEk9G3zgXY1IYcJ8TE6MIVtuJEz2SrgVSmNSfUVIHEp5aqwAtDa/CNWCSjIWgfODOcNbGmVp01vybDpWo7m5KnIoy7qRCRLwGxg0hvszrYPEXqUS7ty/0NHKQ4l35jkydswKTA2c2cSTdKqNitYFG1K9IGv/BO2dl5fA14hWB3RaCF3H1dcZjL1hNe8TVMRKgdruz+1qqTGusUNhkFd28gPc17+jKjU356FW2SLtRk07Z402n6G7F6JzKAXrWEHN/pf5yBw1CSg1O6PlueAigadeH7lxCpoIkm/rr0EU7SabY6CYYGKNbgI0NQQ5rlLHmd8q3ennD/VV1UT3v+eUJlXspmcfiBH9JUVvs+h5YeKopJDZLbFKzwGSN+7M4mugkq29su0MmfdxJbbskMNx2+laM0zFDiRxTXhMLSsG/zQGm/WXQKqXPqzl9Q69ZMtqLf8/VGQhk/YoT9y21ECt3rjs0KfhyN6n4tGlq23kb/b4W01SnfF4HWmVh/fm6q6eSgE7RXQgQiVU7q4J3tqX5zsTLPheYKO9hvUhTUVYlf6bYBFS53swUJ/F0C8rvXvY6ZuBWBegDI5+A==
Received-SPF: pass client-ip=57.103.69.181;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 target/arm/hvf/hvf.c | 2 ++
 target/arm/hvf_arm.h | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 03b174a8d4..8aa59a1f77 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1189,6 +1189,8 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
 
     if (hvf_nested_virt_enabled()) {
         FIELD_DP64_IDREG(&host_isar, ID_AA64DFR0, PMUVER, 0x1);
+        /* SME is not implemented with nested virt on the Apple side */
+        FIELD_DP64_IDREG(&host_isar, ID_AA64PFR1, SME, 0);
     }
 
     ahcf->isar = host_isar;
diff --git a/target/arm/hvf_arm.h b/target/arm/hvf_arm.h
index 6b1c3b9792..9cb58ad9ab 100644
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


