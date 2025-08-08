Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C2DC87FD3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 06:59:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukH1K-0002F3-Qm; Fri, 08 Aug 2025 02:56:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ukH0J-0001GF-S2
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 02:55:09 -0400
Received: from p-east3-cluster1-host9-snip4-9.eps.apple.com ([57.103.87.92]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ukH0H-00046A-Kc
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 02:55:03 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-10 (Postfix) with ESMTPS id
 5094E18000BD; Fri,  8 Aug 2025 06:54:57 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=hcX1ouUoxA3rBBWpI8Ii03pvg8y4VXNW/PYQiybKFb0=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:x-icloud-hme;
 b=HLjig/oaeG54qmJs1/q20s1kw5Pvw9JziVUO6KbAje5LzXyKtdcI8GaPRoVnoTp1ZK2HffWM6L9QdgPjw33KaWcprNpdv7AdgmDcVxU0b1N7VzESvk4yiF2PbWF1DeU/hnCBKi3CPdsvqiEkccR5mkYbm7EgkIfcdawN/j4nlhokphKvuGaXVPkREIIJKETvSAF2dkMb8WqS94bqgdjn529kb9ltm++BahGgkFXcdW6NtNBGVbkITQePOwEg19W0nHEce/G9zrdDJreN6yYCDB2l2QlYY5LI5myqnCH1mb0+cZ3PFebhXcz/dgFSSZQi2a2PrKhkIkBMAOLzjzA/+Q==
X-Client-IP: 46.189.47.18
Received: from localhost.localdomain (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-10 (Postfix) with ESMTPSA id
 156BC18000A5; Fri,  8 Aug 2025 06:54:53 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Cameron Esfahani <dirty@apple.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-arm@nongnu.org,
 Yanan Wang <wangyanan55@huawei.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 11/18] target/arm: cpu: mark WHPX as supporting PSCI 1.1
Date: Fri,  8 Aug 2025 08:54:12 +0200
Message-Id: <20250808065419.47415-12-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250808065419.47415-1-mohamed@unpredictable.fr>
References: <20250808065419.47415-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDA1NiBTYWx0ZWRfXy/PIVSnAzlej
 L2RKC6YVOHc/QeFjoRWsJxPEZ5eRJiHD4UHk7zQkaC5xZgZtqFCVYwwQxRhsvATJbfJcOqfdjah
 9agcPW0+ggD0jrYLWgzC6caUMeu4aef2N9zw4m9gjUHxzeY5FjRI38q6fS2lsFHwepUOGTrJa/l
 oOdyFfbI12eGlcUzXnoVO9TwHocojDSEmNEInQDTmYhF37rsrp8ZbVXfJOJsufyUq9mTXwDMUQC
 4DWBzb7k831mWdFgfUZArL4Nba4ZT3JbMbqt/sKsE3CZ61a5XBontnsPuFz2NlvpIDeHvf2zk=
X-Proofpoint-ORIG-GUID: oNGFS7FDZfEDe27Fpj0sIHlhJCX40PkU
X-Proofpoint-GUID: oNGFS7FDZfEDe27Fpj0sIHlhJCX40PkU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=920 adultscore=0 malwarescore=0 clxscore=1030 suspectscore=0
 bulkscore=0 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2508080056
Received-SPF: pass client-ip=57.103.87.92;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hyper-V supports PSCI 1.3, and that implementation is exposed through
WHPX.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index e2b2337399..3b69c9786a 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -23,6 +23,7 @@
 #include "qemu/timer.h"
 #include "qemu/log.h"
 #include "exec/page-vary.h"
+#include "system/whpx.h"
 #include "target/arm/idau.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
@@ -1496,7 +1497,7 @@ static void arm_cpu_initfn(Object *obj)
     cpu->psci_version = QEMU_PSCI_VERSION_0_1; /* By default assume PSCI v0.1 */
     cpu->kvm_target = QEMU_KVM_ARM_TARGET_NONE;
 
-    if (tcg_enabled() || hvf_enabled()) {
+    if (tcg_enabled() || hvf_enabled() || whpx_enabled()) {
         /* TCG and HVF implement PSCI 1.1 */
         cpu->psci_version = QEMU_PSCI_VERSION_1_1;
     }
-- 
2.39.5 (Apple Git-154)


