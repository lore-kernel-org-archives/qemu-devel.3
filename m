Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92E7AD3CC8B
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 00:18:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgB3Z-0004Ir-6p; Wed, 14 Jan 2026 19:17:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgB3W-00041l-HB
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 19:17:42 -0500
Received: from p-west3-cluster5-host8-snip4-5.eps.apple.com ([57.103.72.18]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgB3V-0002GE-1p
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 19:17:42 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-0 (Postfix) with ESMTPS id
 912C81800462; Thu, 15 Jan 2026 00:17:36 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=NqtcHJC/jmtg6zxYmtUDz1F7scGINBcHMu0R0Ue6BzE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=V8hozmfhGkI0na0XLftap3dBJ9Gp77EIHdG+rlgn6NXRLFMZ+JJNesR9d4WzZ5A0sFIROgN4k0sjFHYS15sUajhZxF7FjCCxVe1UkjVH5fCsFbs69jTDRj5AhN8CMk1B/uif4C8pqPcgZpaD7Uo6KOyOj3F8h0PXc9T1LINdy5C9ByY8L+ruERAGXCFS7/3kfYQZEuX5JZQyw7l7Yl5CYQkujrpajWA2QO8eZIUw+qjr1leGDuAHiiF8WyjMP7Avly1bAeeVP3t3D9xiWJWt8diM6lrEU2A4zlaZS9AJdthXm9z4zga4zQy4Fzcpz2dict4sGbpH5Q2uuakrw3160w==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-0 (Postfix) with ESMTPSA id
 02AC9180040C; Thu, 15 Jan 2026 00:17:27 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Alexander Graf <agraf@csgraf.de>,
 Mads Ynddal <mads@ynddal.dk>, Peter Xu <peterx@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Cameron Esfahani <dirty@apple.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v15 22/26] whpx: arm64: gicv3: add migration blocker
Date: Thu, 15 Jan 2026 01:15:01 +0100
Message-ID: <20260115001505.57237-23-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260115001505.57237-1-mohamed@unpredictable.fr>
References: <20260115001505.57237-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: h9ko_pP5ovDxd5V6a8gEzwQKFYzeheCr
X-Authority-Info: v=2.4 cv=R9kO2NRX c=1 sm=1 tr=0 ts=69683223
 cx=c_apl:c_apl_out:c_pps a=qkKslKyYc0ctBTeLUVfTFg==:117 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=ZsnAEJ0dk2gu5naU1fIA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDAwMCBTYWx0ZWRfX/6CvAKPIskVw
 xpU+T1CoE6BIFCgCTtSc6qgib9Apmi2WBx5HGLjnlbgppwGtp3gBIkUxCzUcULv9YNWnHEVMhug
 PPPGZem56N3pTExdrH4bI53zNq2rwXt3ubNu5O/m8LXjMOyLvQoVVkHbA62lTs+N1SZTV429oZ5
 afXQ55mUYDkaR3S42XXMyNOltanvNJ7psRWCOLSVZK+hinIw36YFNtYXOR8Vxg4n+zg2tauo4sC
 jrOL0AQO8Y2SAgFRZ9XO/D/SskN/qPwnoy/iid4YHzJgtIFnXkcwCLVXMpykDoZMOJr7HYKz7AZ
 8YyUb97KQjIYvi666PF
X-Proofpoint-GUID: h9ko_pP5ovDxd5V6a8gEzwQKFYzeheCr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_07,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 clxscore=1030
 suspectscore=0 bulkscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2510240001 definitions=main-2601150000
X-JNJ: AAAAAAABajZq1bfHG3XADGJGy8J0qB9Oyslz0WK0KSdjK5Pg+eaJctKFQ1TOX6yfjLndE6ptgjj/D8zAs0fo56BhLd/M6Mlh95XFO3HbvKwVdOrbvZ3e3LapmX01TjjO1kP4bJBkQkZYMVABu0xVCCeMJUbB6wmYTDCEaPB/6vU+z4CxKRv1/OJ9tP14ddNf/XI0gNm7K/cjoWsZPUzOVmvPz2WqLWbanPn7ZTXcfYVfwjTa8epGIc96Ui8U328WyXQwtQND9QoEal31Zb6hsFpmq8kmKVavI2iA9To4n2OCRm/8YoEmZ0npJ52EqT+NmU62KWARy2ffSWy0MpEPy7fNi85M2IVzJ69/aJjpaYgQiy76sdzHbwpdNwhHW6vYrdIGX96gbL+JSpYySvMqSoICCfM3GNqKBItWh4qFUui8ko+1Qjg3gdTLs4jEkgC275sYBuOXP6j+Wc+o7ANo73vjwTeDKjBjb5DOd3F48nhjiTz87wJV8sX/UsdgtETsqwBP0wgNa1WKJLWZK6W3JL9R3vFb586Jp5qTjcdW34XkXnxUlE/AAQ45ge5AMk4O8CAX3vvOO0QsuEs4HN/xOtH/GWSWYdmDOXxU7zsCbTxkJHKZ1Z6fL079iHyR9Ml2mwraWA+SeHt+iIWWcwBEIo9cJS0FSYatZDF+3J5cXU60RGk4X9JI2GO2cTaSbMAmIal1nEqfghxINhhDKOOiefHQpdzF9E5C+BY78NL2vF3rugQllIyOT2hj2r7h9SVMLTu441L8LRxjEXZxcD323M8qvp/kzcb+4XVgZFQ7hFGiagjd+XmBJie+PFD8p/xi5ezjnv3md0gzim0CMEP5TsCywtWvyNEXpVNGGzvvuwZKtKv2YJnLPj9gxnxRjoosFIHnnBKUPIhBe1YtmpsVaLZewYQxVxm+zuduEbIXzqlIn8TzLFbidy8/IsTC1AXbVqgnLhG4Rx6uVvkRFmzp
Received-SPF: pass client-ip=57.103.72.18;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index f34f841a4a..bf21ceb454 100644
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


