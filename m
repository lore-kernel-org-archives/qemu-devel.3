Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0457C87FD3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 06:56:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukH13-0001fX-Pe; Fri, 08 Aug 2025 02:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ukH0c-0001Mc-UB
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 02:55:24 -0400
Received: from p-east3-cluster6-host6-snip4-5.eps.apple.com ([57.103.85.186]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ukH0a-0004KE-SB
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 02:55:22 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-10 (Postfix) with ESMTPS id
 6A887180012F; Fri,  8 Aug 2025 06:55:14 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=qoKo6hXi3dnbIX1eqBbBA0zVl4CHODddnjD0gvvDPK4=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:x-icloud-hme;
 b=E6CFljtXv0/F+lZYFqx/0QFpXLfRAmIhhA0wnI9j9xr6trSShYrt9/860i+OB5fBPlaLrHzoVOV+SKXll6Wv60duOJrsm7Fj8tczaAXEpBK+18Jc8sJ+ilj07BAGblojRJ/Kp+VDFFUmok9Mn4Mq0VdudRJ1F6291h4mdc7ZCeEqfst70kFpU9rURTlEpN2dJKr/5IffAUdLIOgv6SqBtxrKWyQhSnBFu0py1kfZXRsLVkoUa77Enr8s9qDJAnfSt6u8QdXzi8A8Z5toPxnjdDmzTtjKYAs4y2ZlMAMS9NofbP5hnTfEmWIyuML0Y13HwT6aQTC3wNUlcOROYkDMFw==
X-Client-IP: 46.189.47.18
Received: from localhost.localdomain (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-10 (Postfix) with ESMTPSA id
 F0AC81800107; Fri,  8 Aug 2025 06:55:10 +0000 (UTC)
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
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PATCH v5 17/18] whpx: arm64: gicv3: add migration blocker
Date: Fri,  8 Aug 2025 08:54:18 +0200
Message-Id: <20250808065419.47415-18-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250808065419.47415-1-mohamed@unpredictable.fr>
References: <20250808065419.47415-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 7YhJ2ghuLvay0Z8c99PfH6wYSuQSWLjb
X-Proofpoint-GUID: 7YhJ2ghuLvay0Z8c99PfH6wYSuQSWLjb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDA1NiBTYWx0ZWRfX5zj7xNmHIPwH
 CAWBiteU2JTIjgyWDkFbCKk6akMre+a49n+S2OrJubANNfBZZExXuFaFmAoxYLVhG794rl93ua+
 3DsiC9eyCjz1W5GNHnQWMTIfA+M8JPW0H1h+rO1EDcFjWOFuaoaoSDQU8fulZekQEde5KEP7ipK
 um9RsHfiZRa+Xkv6L8NW31z5JmQNV9PunrQDSJgQ2XwCQZZWKJdKe4r2JCZ19ZWTJJ4VSPVSOpW
 jnb6KNGzG+yBy3899KqIqYRXNtOHCk8qA/OrM28T8cEg5cKfMHCtYbSGF7BDrdFVVN0PdcS1c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 mlxlogscore=949 suspectscore=0 spamscore=0 phishscore=0
 malwarescore=0 clxscore=1030 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2508080056
Received-SPF: pass client-ip=57.103.85.186;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

GICv3 state save-restore is currently not implemented yet.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 hw/intc/arm_gicv3_whpx.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/intc/arm_gicv3_whpx.c b/hw/intc/arm_gicv3_whpx.c
index 35dc5ac531..700b2a1a2f 100644
--- a/hw/intc/arm_gicv3_whpx.c
+++ b/hw/intc/arm_gicv3_whpx.c
@@ -17,6 +17,7 @@
 #include "system/whpx-internal.h"
 #include "gicv3_internal.h"
 #include "vgic_common.h"
+#include "migration/blocker.h"
 #include "qom/object.h"
 #include "target/arm/cpregs.h"
 
@@ -228,6 +229,15 @@ static void whpx_gicv3_realize(DeviceState *dev, Error **errp)
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
2.39.5 (Apple Git-154)


