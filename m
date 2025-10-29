Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E915CCCF9F0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 17:39:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEA6S-0004PX-1n; Wed, 29 Oct 2025 13:36:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vEA5x-0003vK-DU
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 13:36:27 -0400
Received: from p-east2-cluster4-host7-snip4-10.eps.apple.com ([57.103.78.241]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vEA5U-0003Sk-Lu
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 13:36:24 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPS id
 16B6F180853D; Wed, 29 Oct 2025 17:35:39 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=7ELmogO1rP/Q466oRv7Y0E5YhY0QvblNmMS2WwTWd7k=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=AkPeHfz3q96+6VpTtBnyGlw2JeOATwJeQypvXJ1mMFwcl7s2uOR/n26og45HigShzXCszr8HXIsNIg6o6fWcDzmZ5icMeBd1Nrwn02UZawKwE002Xk6kAwp6a3IKMs+Yxte9SpnuyvT2YTzwgVzONhLKCM0GsfUiafAN/B3eL9IYQkwxFUCAo79zzoVgx+FnxrSxDvrO76YweHEDMZ6cw6WVvWbaGo/MH+F/cvvcYDO4M9Z76g0vTaeWCVrdhSYWTQ4cJPsPLIPr4ACz4mlsD+cE4y983rUGJtbNNAlKk2Q24zQxhfnCOvbJDgIR8vMP0jW4bH/N6X2TtnU5TeUvzw==
mail-alias-created-date: 1752046281608
Received: from mac.home (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPSA id
 85BDA186291B; Wed, 29 Oct 2025 16:55:58 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v10 23/28] whpx: arm64: gicv3: add migration blocker
Date: Wed, 29 Oct 2025 17:55:05 +0100
Message-ID: <20251029165510.45824-24-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251029165510.45824-1-mohamed@unpredictable.fr>
References: <20251029165510.45824-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: XLVWkQuWUAmtva20PGQCEJP3i3DHJtsA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDE0MCBTYWx0ZWRfX4fSt+JxTrBN6
 SCvDgRtTh06L/iMQWub8CCHyZHa+iOi+3NQyZeYDuY+LCwFWbUjolvHS+Amht+VEdzD1AvRRWOm
 x6B7KGEPsPSqbkQuVWK8tGC4oJQBHRhQPKDO5DN9RKdsUp+7hGXK9edBskf9cjz/3YaONAHLz5/
 NfkTt0296h2mgllYeqrc277mXqFvtbGQ5X954xw2dBk0/ZMeJHLPsWmiHhcanbEzWalQt/4BO4f
 wSoBM+erjTTJt6Nd8HB+H85Z1jZ6XEII5VMJO2chhnAJBwrxR9XkMNWQMzugU0Lk28PP+PUXc=
X-Proofpoint-GUID: XLVWkQuWUAmtva20PGQCEJP3i3DHJtsA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_07,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=763 malwarescore=0
 phishscore=0 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510290140
X-JNJ: AAAAAAABzf1XhVsFpObfHGCDSUXExjYbBwCdUjjpCxUA3Q+BkdS9DbL0gxSxJ/9cTM0OWq9btc5mGrTWMV/tJoqOPz1sZ9S21VW8AQPcqcoMUgWaoVJFWNVdAHosGGr1q0scSPkfFY3YHaqaoQMBCSQTUq79gBG67buqognz5li+toEP3fGSoBrArlAGXKeRNj+MnDDATUgBUZO8DOfsquPFxLrA3bDJ52Nuoavkx6a/PdBOI0fAB2Xfc64hqc+oU1X0EMxjUDeMsW2aG+tobIYqlFLFXUwGqh3ZBtLrNEp8CLGtoBKG2LoR48Vja1uCbECoOJPu5mYSxvGCDuv/QPsplkZZQ57U8QCZWEFXJyym4YRfGbA2wABcuRkVibe2TKNGz4Ebt/3yFpwy8a7v4L9cZkVB0WN5ZAguzinRIETRvQN1xoHTUOb6sKbNfFKpFJRq1VtqjzJtIwVe8+42dmWcS4iiRv6z9qcKDkx2Jpor6jOOoKeSbc06gU/pO68BtQYCbXkhm29oQM74eO6TxiCv+IhfUIZeP91a9EeIEznLVsbM/viNlfxJhdNNSVlLR+2hLtIRY1wQPXRBlMlotACmYo1gHhl+VQNOPYU89TI4Jx4ZBg2XGARA6Ldj1dyPUDc0u0Oqnq7AsvbCFrgztHsdANaAzHSscVn7A7/xpe0terDIAnLX20AeCfQS8Herd2QeMUfN7pi1QRUm4nYnOHVCzzWkhQw31ayZIQQb9R8yV7IodA3amjuwXPF1BkM8cX5wu920dmVW0X5JSjCk0kqZfH14
Received-SPF: pass client-ip=57.103.78.241;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


