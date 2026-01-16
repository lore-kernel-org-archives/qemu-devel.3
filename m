Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3F24C79FBC
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 14:00:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgkHK-0004mG-9V; Fri, 16 Jan 2026 08:54:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgkGl-0003eE-98
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 08:53:44 -0500
Received: from ci-2004g-snip4-11.eps.apple.com ([57.103.89.73]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgkGg-0002KY-Rh
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 08:53:40 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-15 (Postfix) with ESMTPS id
 002A0180F921; Fri, 16 Jan 2026 13:53:33 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=LSoZk/Ieo2Gxgsu0UDLYcCkL+4HMxr52m2AtfldXZ94=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=ERQpXBTa4qlWh9tr93DvyW/UG2oG6zfZpI0srdjMZOHRWCx75P86RM9yJjSamuH6oTooYkAcIiny9FcpF0mal6SlvUvvBpoQm9zjbyrbwNM84n4paZRYOeLyXjTdpaGPnSWuoIfv83OBleTvn7OwE6kU5PUHGvlgKdZVbkppIaP9LnRhh0PZYq5oQB09sJj1W74nvJ+sLEpCSeQWweRv+t7P1P2ZVlZOFdXbO+rH61NlPspxDrZzKKOPLHYL9YkA7//gsJFLms1tmEC+5/u5xpI3X4fc6YuIAaeNdThDFyBnkLS/FE4uwcyhZ0iV66s55mmXt9hC6boQPcTAkCKzXA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-15 (Postfix) with ESMTPSA id
 3F891180013D; Fri, 16 Jan 2026 13:53:31 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v16 22/26] whpx: arm64: gicv3: add migration blocker
Date: Fri, 16 Jan 2026 14:52:31 +0100
Message-ID: <20260116135235.38092-23-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260116135235.38092-1-mohamed@unpredictable.fr>
References: <20260116135235.38092-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info: v=2.4 cv=GagaXAXL c=1 sm=1 tr=0 ts=696a42df
 cx=c_apl:c_apl_out:c_pps a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=ZsnAEJ0dk2gu5naU1fIA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDA5NyBTYWx0ZWRfX6lEBAfRoVAKj
 5/qhfkdDbpKPwBqHjluekf5abDh9wfkUSQzQ6nxiX8Zfam/lSmBdKWhfEX8jVxSmEA3p3k95bZw
 9sVaNtTp/tnzx+4/EVtXzN1dm9lgySgLCXl3rT1y8H9Hm9mHGZUcqPsk813ZXALpLGNHYMVY5Eg
 aL6VsZtSLuIiI/yD3ziIAPrk7vcKra5M1KXzAnoEVmgJSCSPtC+kMyOWrMrgRbD1KSeHg0WwANs
 3UVrHLd33bEWLDA/hINgW12aahtr8lCR7W8WMhc3Bnys/FaswF1GQhV/wvgZ4MUf4zqzu8FVgy7
 dBrwF0JpoG5i6mxjnvO
X-Proofpoint-GUID: cONzmBsdmXB6x_awU1_jYf1cxTYO_7Hl
X-Proofpoint-ORIG-GUID: cONzmBsdmXB6x_awU1_jYf1cxTYO_7Hl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_05,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0 phishscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=905
 spamscore=0 adultscore=0 clxscore=1030 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601160097
X-JNJ: AAAAAAAByB9o6ovYiMuK/hrP29ukyawtNipBTrvICjxplc545SyW3WQ8uQXzKlli51tVQpiRKactwl1B31yXJnFjLE+WdVhG676XZKqsQ5TikOI9NHLdLUNbRgkQ6G/4Ce8V1ZZUP04K30UgS2BQjGPhHeEWOgamojgdt9/YFzGYB5AYcbfy+CTYr2JmGAwtYDXAVMjReK1DXWXzkOXD4S6wKJBXN2G7c3KUr3B3gj+AkCwliKD8Sh9+HikfdmSOFsM3BzMgGM9Z6Z7CKhjKAOoE5ocjqgdUIGVXs6Np+8nVPkTRURjYCLWPT58/qLOTQ2iNsHbEwxpDQexLoz0WQtrPqJltFsFJMESpYIHCAsXtRmD/ogrOCMO/2MGScVs3RHtak/H1vIDaj3iL9DF2U1itFLOBaTHCWTxeJ+I4bLC+rraZYWQGrd+dUd/FEY+7A4xY/L47AidI5M9/GtomXe7aJ2s7Jvxz9AL06Mn6B4bzOdOLbJ1NmbhtrlSkZqU076N6DTOWits5fPBzHBzOJMYFeSCvJMLo87WQ67slz/U0AAC+Gp0q8chP/Xgks8UbT+R8g/Cfx40haoEjNyNByiV7VXrBgs6ZWqudNlZI7a8RfkONsatwnKd6tV70OuaF3BijtzTuR/Xbw3VsIXieldn+GVFUqE1Geu82X0sYfqFnVHIenqx1DouCsa861QAQroyoZl582bvfbC/v1uG/v15aZZDxgm3yvmLM5xTP3AdLrzZvU45OeUL6jTWPRjFahWgVx3EPcD7EjCoGBzRRqMkrmElSwRuQ2D/7Caz/6ZIJx9HdXQe60vk0RlpJD+/XAWSg
Received-SPF: pass client-ip=57.103.89.73;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

GICv3 state save-restore is currently not implemented yet.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/intc/arm_gicv3_whpx.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/intc/arm_gicv3_whpx.c b/hw/intc/arm_gicv3_whpx.c
index 9bc036d1ac..84ef16d9b7 100644
--- a/hw/intc/arm_gicv3_whpx.c
+++ b/hw/intc/arm_gicv3_whpx.c
@@ -17,6 +17,7 @@
 #include "system/whpx-internal.h"
 #include "gicv3_internal.h"
 #include "vgic_common.h"
+#include "migration/blocker.h"
 #include "qom/object.h"
 #include "target/arm/cpregs.h"
 
@@ -204,6 +205,15 @@ static void whpx_gicv3_realize(DeviceState *dev, Error **errp)
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


