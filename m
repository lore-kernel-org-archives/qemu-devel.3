Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28AC4CCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 16:59:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9RJ1-0001OQ-F8; Thu, 16 Oct 2025 12:58:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9RIp-0001Eq-RY
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 12:58:12 -0400
Received: from p-east2-cluster1-host12-snip4-10.eps.apple.com ([57.103.76.63]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9RIR-0001g3-Ri
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 12:58:10 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPS id
 3066918015FE; Thu, 16 Oct 2025 16:57:39 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=nzWfz+yWdE38Km+dQsZKqvSOWpOIi0Tms+2rrM0SehM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=KGg3sgIOKcnQqiLDH2kAbjPth2rJxYcfhocZDr/O2uJWt+38QFuRoJ2Z97btAPo29Q+zzxC7eBMkT+EAi1g4K1JZgb2Xlv2g7huRMRbE4VxYJf/t7LCaYyL+bMR+HQ4TA/4Xsox2Cc5iCt6+x4SwE/d4Ro5bPvUWq5O4OXhJVt4+mXQHtEMlO/bnd+3uaQqcLjVMfut/He67wfEs+V8pRQMSuyXWzFiw3krcABCk6ACFyb7cluLQ065wADNZtBGXMm5Xf4Gqj7HWdoWYK8PPMJP5O/mdcZUOElt94TwJR+pffVXFLMh6a05z/oZJxLRsbav8IIn6IlGW1EyGmcH0yA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPSA id
 B98511800760; Thu, 16 Oct 2025 16:56:34 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mads Ynddal <mads@ynddal.dk>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH v7 21/24] whpx: arm64: gicv3: add migration blocker
Date: Thu, 16 Oct 2025 18:55:17 +0200
Message-ID: <20251016165520.62532-22-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251016165520.62532-1-mohamed@unpredictable.fr>
References: <20251016165520.62532-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: t8Aq89xlJQFujfMgbbyJbEK71dJavbvS
X-Proofpoint-GUID: t8Aq89xlJQFujfMgbbyJbEK71dJavbvS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDEyMiBTYWx0ZWRfX9bS4A67yelyI
 RPZX5eVoHpWWSdYypK3vWXGTViKzcX2/4idbfxJDkfAdGArRs6vyiQpr36nEs4CG2JSrlRe7Q6D
 YumVBJGNknG2eCK4aO+TI86SV85hJnGakdBTkt1Eu+EeSirI2mj3QaM6f1S7Vh4WIg8S4eGCKGI
 NWsoOhS3iq8tdrO1BEzyv3dOdiSfgoGk4aUx3evNaAVaGFX+UfhoBjBtE7I6eIlIxz5OWZg/ejV
 4T1IljcI877fYcQDHlgN6iZgnAufUReVSO5ZVUdNgEQqu7RGe+fvKmSkOc618w3KoZ8SjLa60=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=970 malwarescore=0 spamscore=0 mlxscore=0 bulkscore=0
 clxscore=1030 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510160122
X-JNJ: AAAAAAAB3vmBivw56P7Bq+mQdi6xqqxbZvPE6oYdlUtVh1HgBTGJ57lyY0GfbMa3g1KH7pCQ2RRoGbFUgraxGJxWjqRjDdkRourh9MFoo1iClsIFC3g6DAfGUrYhWW1RCp3X1bHeoqSqD0ORZYRTYXDqDoXk98EO13O4tOsSRlVH3zKwk3ISzBmwqT3IaFSDMaC+1f6kc4ja3lmqIKvZtDWk/RBu6M+QCshJswkctHBL3cBDl89scKxPkqoHSioxUy48MTwgW4KPjsSJ25hR/RyL4ipa7iREgyoyJ+cBWsopHllvMMZgdR4FWLB76U5fzZ83PzvHDOAzH+ttL0JxyRi3zfMWXCJTJSHSuumiNxHTr/kK7bOlQ3U4GikwDBSye5bGUAc0KrtPVNc/05sy6e0BSi9ocE61a65CivNSE5Th340ovOI9lcobB4lYNVHj6NE4XshUlQOKzT0x7apL6WoDB+e+cr+CtGKax/RkES1ORM01jrE4SSbvv73UwgvhBbdOwBAp9jv2ZF0O2Jraefj25y6kbCO1/nXSd8xIJLXd5eXXpIgfH4439cLk6GPy1OEoe8nfF42J3pjTDifzZQMivtkRy3j6wcaed8xDWMnykA8w3qC0H3MOMgowshEtYmR9gUae2kDEhk+BHhGUC392eph+rhTilAYmWeT1DDzlw8Ys71mcQpr2EQ12R4i1VE/7OHCTRnebf5//MtgFkpkUDozFwEW8eGOyGeQFGEH+mIbm0lDgOFHe06xXCeqoZJKDGixjd249y0X6GmVB/wqTzPeo3lEFRsscqsWfbEowzfP6HJr8oEh5O0rTBd0zHU/r0uufw62XbMCs/KTqhy3FJ/Uyic8rIbDWVPgY65hEcf45JLd4qIJR4F1mgK/qL/X4t4VmsJqNib+DDECcj+mJqKK7
Received-SPF: pass client-ip=57.103.76.63;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

GICv3 state save-restore is currently not implemented yet.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 hw/intc/arm_gicv3_whpx.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/intc/arm_gicv3_whpx.c b/hw/intc/arm_gicv3_whpx.c
index 88a05e5901..6ceae78483 100644
--- a/hw/intc/arm_gicv3_whpx.c
+++ b/hw/intc/arm_gicv3_whpx.c
@@ -17,6 +17,7 @@
 #include "system/whpx-internal.h"
 #include "gicv3_internal.h"
 #include "vgic_common.h"
+#include "migration/blocker.h"
 #include "qom/object.h"
 #include "target/arm/cpregs.h"
 
@@ -205,6 +206,15 @@ static void whpx_gicv3_realize(DeviceState *dev, Error **errp)
         error_setg(errp, "Nested virtualisation not currently supported by WHPX.");
         return;
     }
+
+    Error *whpx_migration_blocker = NULL;
+
+    error_setg(&whpx_migration_blocker,
+        "Live migration disabled because GIC state save/restore not supported on WHPX");
+    if (migrate_add_blocker(&whpx_migration_blocker, errp)) {
+        error_free(whpx_migration_blocker);
+        return;
+    }
 }
 
 static void whpx_gicv3_class_init(ObjectClass *klass, const void *data)
-- 
2.50.1 (Apple Git-155)


