Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E91CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 18:46:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9SyL-0001tg-9b; Thu, 16 Oct 2025 14:45:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9Sxu-0001iB-Jn
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 14:44:44 -0400
Received: from p-east3-cluster6-host8-snip4-7.eps.apple.com ([57.103.85.208]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9Sxj-00026v-Ty
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 14:44:41 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-9 (Postfix) with ESMTPS id
 C6C5B1800140; Thu, 16 Oct 2025 18:44:26 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=7ELmogO1rP/Q466oRv7Y0E5YhY0QvblNmMS2WwTWd7k=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=cJQZ9CfnFc5J8qCbqlEAzeSdz/JIJRrUX6bCj+dC4+TsXAHRJ/L+hmkG29Tcmmba3JDKvSca2Nd5xRwTRkNUCokHvjldaBdS/IdY7fC8fwLsIIPRcUjcGfrRUSSqqdDj735R+x/UAd88jkcs0w/5icX9/MAlU/AssTBRXQMdfaotUtmjXCdEC1EBwNjgJetWE5BQaTjnakABY+1ljeKYIOV9IePdO6nnAGgCEA0Bhd85NNpkIFQhOfWUpMd282NuAwonjRnLq2nhRi9OqqbsoSoAFmEPtxQBX/uH/0rDTwfQdVK7rhuUOmU/rmu8aZ/pMHD+v273EZKXEF6s956cdw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-9 (Postfix) with ESMTPSA id
 0C42518004CE; Thu, 16 Oct 2025 18:44:24 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Cameron Esfahani <dirty@apple.com>, Alexander Graf <agraf@csgraf.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, Mads Ynddal <mads@ynddal.dk>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v8 21/24] whpx: arm64: gicv3: add migration blocker
Date: Thu, 16 Oct 2025 20:44:10 +0200
Message-ID: <20251016184413.69870-7-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251016184413.69870-1-mohamed@unpredictable.fr>
References: <20251016184413.69870-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: yMhyXUugwA43UM_8stLXQy6gQqXApXE0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDEzNyBTYWx0ZWRfX8rzBDMoGvx0S
 1eY1aMsDRRb5p0FIZPqXsgNuSlq1A9qZuts/A29rVIFC3zZDf/wfy8/8MKfM1LLmdn5KiXksco2
 aME0xon0vyq/sziEXrvnMhR4ytmrZ/cANjNMMXcL5bb+KObKieGrvsAyF1zaxr720uvCXJfWQDp
 oWijY1qFXkDptny6UZEwIJH7udIdz+nWSSqQYs46iZtMve5eEok4AtP9OlVyHQdpnvPnxPa/jpz
 /jS5pBIBaTZL4vjjQmABnjC+J/8AuYYqKyIP+/bc8QoqBQZcIIezdyit0VTlJIKnvhSiiERys=
X-Proofpoint-GUID: yMhyXUugwA43UM_8stLXQy6gQqXApXE0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 clxscore=1030 suspectscore=0 malwarescore=0 spamscore=0
 mlxlogscore=864 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510160137
X-JNJ: AAAAAAABhFtEgRdZE7nYlIFgD+R1mXGg4ZeqMyRMdFon1HuTp6sb+8VLeLXRu2O7MBBPAlshoQaX6+5LRs9zuqSiFvsTOsmVkL7w5DuuFZyzdp8vCe5wQCWvLd2HXJx1mg7r/D16siDFLIIlfHwN8YRylp/CxTHmrCTYphwSDHHEfiN8lmjeAA+JHkV4Mn6Px619rOqtqAglnwe/RZTkNcOQa30ePtYkCaZKHKfmhCMutsbcMw/6DsqVPUSU6Vn17pKAYlk9IkWxuhLg3xZqxIE8GO6I+xYG8/BAKvUVzzx1fL9w/ZkTsD6hMdnJapSIFU+T7Vjiij2lw5DX17jp6gCgVS4BsdKzfQOVPfh8BtajqVodyJ6Zmshy7lpAPXPusEuC0YyK++ODwyDwHmSxi7vooJD/E2UaGDldqgmSTMqGutDgjNzsH13SLLkmxpPi/pNfReQ/IHJegrR+EDC2CKmSjNXuy9O32eJi8HgIrK2iLvI6kKD8WDQwHRJbqOyEREXR2A1idWGecFWRChEfwRvd+kcKrO/RvfGQuoVJ0gYWQ0J2iYjK1Zle/TLHcVspuZirhD/mi8Ne8tgdxjTULHRIYKLhKWfxVfN8Cz+8plsyIolpQUBOw01SwCEzieVn26/N4DExGtEEtiRvHG5J/cGjXdW1J8uUfEicN6tf2N/gbRoCYILx/m0AWkbdSzWUcfF75sielHBVPjHdOTQRA3KiGo6CDGtvO4ZtM/wDPVU=
Received-SPF: pass client-ip=57.103.85.208;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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


