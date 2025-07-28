Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F795C87FCF
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 06:00:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugGtJ-0001Bc-Ia; Mon, 28 Jul 2025 01:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ugGri-0007P3-Fc
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 01:57:41 -0400
Received: from p-east3-cluster3-host6-snip4-10.eps.apple.com ([57.103.86.63]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ugGrf-0007HP-8T
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 01:57:36 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-7 (Postfix) with ESMTPS id
 DBEDC180009A; Mon, 28 Jul 2025 05:57:33 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=+KR+AMbaWt7Dx4BYurEMHPtPRCgp9lEz5QbIz2+1RBM=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:x-icloud-hme;
 b=ciLaMX871hDh2TTvWEayGPvLmpH9HCIbP7O5wEvp2PKPnrnX+h+dykKJdQwXG/qi9Z3ShFPGkPekXOatpBtD4Ncj/mgVJomlx4mRFt04ISNFd6LlFMi09nWVyTeNodKkM9peSBGP7eEQaERKxMcdHuxVYWEzL8g0WTtUZqfd0IODikS38rxm8W7jpS4iNntV0wqnM4d+3SNxtTr3PjyIF7eYrn/HUIbIX+jbjhYFBUqSoozhqG4s/9NP5JEVXRGMFUr1+viYyCJ7l1L7WeBaMo0bT30HDAnI/mFmEI/yuU7PmNFadoQl4ebQqPz0dEU2o5Bh1n0YQ7dJXcj0MrqwUw==
X-Client-IP: 46.189.47.18
Received: from localhost.localdomain (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-7 (Postfix) with ESMTPSA id
 01EC31800139; Mon, 28 Jul 2025 05:57:31 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cameron Esfahani <dirty@apple.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v4 15/15] hw/intc: hvf: add migration blocker when using
 multiple vCPUs with the Apple GIC
Date: Mon, 28 Jul 2025 07:57:01 +0200
Message-Id: <20250728055701.38975-16-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250728055701.38975-1-mohamed@unpredictable.fr>
References: <20250728055701.38975-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDA0MyBTYWx0ZWRfXza1e44twkMYv
 0FkTlbOr46B6dC+zyRCroqHHkJA3kCPmFa6lowguCYpS+MD8dYQSA+jCVJwwPkHYgdCXLP7HTj9
 rl4xBRYOoOWA42PHdCrI05t4qQ4n7WkQrLZyOD26RZTV2D38QLfxAu/fPo42AC8Bizm+v2atiaE
 N/lLLk2UbDQ9m5KSqjl6klbj8Etpmu2M0c0XxkUFUoKlMiyF+3FOWG5LRR0cI14UzGb2Sk6CSIZ
 dwwe2hSkoLmWu1FmeZB17HKUF7YQVtJ4inOlQQ4kJISn5qcqGb9AP5Ih28z0/B+oGNIz7/Tdo=
X-Proofpoint-GUID: hPGQXMacA3npR4211D55ZO7dYyxNLADF
X-Proofpoint-ORIG-GUID: hPGQXMacA3npR4211D55ZO7dYyxNLADF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 suspectscore=0 phishscore=0 clxscore=1030
 malwarescore=0 spamscore=0
 adultscore=0 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2507280043
Received-SPF: pass client-ip=57.103.86.63;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Current state known to be broken, still figuring things out...

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 hw/intc/arm_gicv3_hvf.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/intc/arm_gicv3_hvf.c b/hw/intc/arm_gicv3_hvf.c
index 30362540f2..151020edd6 100644
--- a/hw/intc/arm_gicv3_hvf.c
+++ b/hw/intc/arm_gicv3_hvf.c
@@ -18,6 +18,7 @@
 #include "hvf_arm.h"
 #include "gicv3_internal.h"
 #include "vgic_common.h"
+#include "migration/blocker.h"
 #include "qom/object.h"
 #include "target/arm/cpregs.h"
 #include <Hypervisor/Hypervisor.h>
@@ -703,6 +704,17 @@ static void hvf_gicv3_realize(DeviceState *dev, Error **errp)
         error_setg(errp, "vGIC maintenance IRQ mismatch with the hardcoded one in HVF.");
         return;
     }
+
+    /* Temporary: current state known to be incomplete. */
+    if (s->num_cpu > 1) {
+        Error *hvf_mcpu_migration_blocker = NULL;
+        error_setg(&hvf_mcpu_migration_blocker,
+           "Live migration disabled because multiple CPUs are exposed.");
+        if (migrate_add_blocker(&hvf_mcpu_migration_blocker, errp)) {
+            error_free(hvf_mcpu_migration_blocker);
+            return;
+        }
+    }
 }
 
 static void hvf_gicv3_class_init(ObjectClass *klass, const void *data)
-- 
2.39.5 (Apple Git-154)


