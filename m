Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 070A7E92FE3
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 00:13:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaNL8-0004XI-H1; Mon, 29 Dec 2025 19:11:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vaNFg-0007fH-Or
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 19:06:22 -0500
Received: from p-east2-cluster2-host6-snip4-10.eps.apple.com ([57.103.78.43]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vaNFc-00045N-Jx
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 19:06:13 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPS id
 A02831800457; Tue, 30 Dec 2025 00:06:07 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=kLQA6rv7sDQAG6jrMiTsp6VgPXcx5wZdDjsp3PZWbuo=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Hjbz4Yu5rfzbCAxL4fAhmch5WH1TTSED9qK2kpzcawe0usgBVNxNju6vuODk2R+OEStAA2W+APYwz6WM4K8IIdog2XJ9RNwsXO98pmM2+UFcEiB4YjArwxCG9SM41BHg9a7Jf5L0/7qu9l/QupHYq7rSyKKX9CmyIInJc53XLNfJ7PK5fWalgEjx4xz+HlhZX+R1b0qoQ58qG56DjstQYXN2sD9KEe6VAjNto/qtruUOic1a0JEsqUW5dXEHMsFuyJVsRjuVm50imqBAsfWrWOti6tseJ7pnNcQvnHZr8mDLUnrhkenQP1Z2Y5b2Dn9vw8pvNaqdPKCmUg4xQFbzxA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPSA id
 5BD181800101; Tue, 30 Dec 2025 00:06:01 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Eduardo Habkost <eduardo@habkost.net>, Mads Ynddal <mads@ynddal.dk>,
 Roman Bolshakov <rbolshakov@ddn.com>, Peter Xu <peterx@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <agraf@csgraf.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v13 23/28] whpx: arm64: gicv3: add migration blocker
Date: Tue, 30 Dec 2025 01:03:55 +0100
Message-ID: <20251230000401.72124-24-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251230000401.72124-1-mohamed@unpredictable.fr>
References: <20251230000401.72124-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: d6LOBbJu109QhCq6ZqylizmOFlNDTjOL
X-Proofpoint-ORIG-GUID: d6LOBbJu109QhCq6ZqylizmOFlNDTjOL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDIyMiBTYWx0ZWRfX3zcN4hxdnsKZ
 0G63sFATLLZy+ulRoBjjsHJq1OUITX3NgZG+CsyM6Mqv/llWPuR5YLYgN1C+b0ZmlR/K7HogI1v
 NXv0lScGp+slMR5nqbxOv4myEvGs0JDbh1mZ8j0htzRPoLm11tAp1NLU+8ovDgITf6xqA0y+7fB
 9KoMDRoMIjXI7KwtTiNwa1w9iL2BXDvlAzOrwVA8xtyPRTE2hq8jRAIbPlVZ7VHnvQX5YEsDYp6
 15bHf53XVzyKalQyH2rVAxq32wGd6ShLoiyRHvnT30Fipucumm/oMZoyMWAh+tYIdmdiJ9bp9Cv
 fTXwqMVAaFuLwsjc9QG
X-Authority-Info: v=2.4 cv=bpZBxUai c=1 sm=1 tr=0 ts=69531771 cx=c_apl:c_pps
 a=YrL12D//S6tul8v/L+6tKg==:117 a=YrL12D//S6tul8v/L+6tKg==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8
 a=ZsnAEJ0dk2gu5naU1fIA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_07,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999 clxscore=1030 bulkscore=0
 phishscore=0 spamscore=0 mlxscore=0
 adultscore=0 malwarescore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2510240001 definitions=main-2512290222
X-JNJ: AAAAAAABwOXzddytEomqzqT5iG+Le8wtQNp9eSnU7SyYetyjnqjWmnI1lvS2JIGOns/vN9ZTW1y/zFxrM8vK0qZIqJ5pk0bXfTqAeNetcHsrBP6iqWLlpLx+YugAF/8D11DWyIQSb5dr2c7WxthdsLr/kSppnMKmOk6tF2N9f71ZXr2lUKKpsJ1+HZ5kxfo/DyPXB/2sufM6iQWUuOSY8tRG/55xPU+8WRwty3Tt81QuH85nmA5H3Ej3xkyz2lcUTprCH7t55HM6Uk5K5k9/5in2kJuTrU7rBo6Z5K4eWDbjC4viQW8w3PNpiQstUAbAVecDwm5sg/4NMn6x9PjiWPJbVzYSfzaSDUBU0eZE1bf5cCHjr7+FgWkKzXG/cCMxwOnBoXdZjgVNg8s4kJ0cijWrxj0VHirZny2NqV8rwsN+zcUMzX91aFiIUvLh5Iwz3Hn2t+rgKqtnh2qaGVbCzFYRoIvLWUvLf4/JmCt7/pbrncbo8qY5G7vWNYnQBdkmZ2BZRZKFoMWf7KzJ/cIPkDRYtnu5WNuVzwWXq8/7/eIeWGyu+ni7uUf2vijC6jmNu8PEPKxaowIzhSvj6z6EYTJEeVZEO47McY5NlGZRZBtDm03Niw0KDvDumIILMgP1Z+wndxukzL26TAtOwB53ANehd9ArtOPfwi1rz6zMhGaOXYeg1XIqMXHPzC+d7iFcaKnQ/F4LtL0gs7IAtS/A7qnxNDH3x3Gqh4ri5Ir9l5+uR/imGPk1Fc5QJ5NwCr3Q1j66oCNO5FGoYg27FmQunpa4hkltblVvw24k8XJ+XD9XBWlt0Qugvw6ZKetH2A7DVvKFHFdAyE5a9pQMxUGrN5UIqtklFdEXSJkrvo26bvlfjCTIrysqWgk2344ncyKxQI0IVtI89cdDbYpAFDxlUPkgfKFRMgac3wsM+GhCtccFxegLMIi39r4EhXtK72fFGQEEwldGM3EEp0NytLI=
Received-SPF: pass client-ip=57.103.78.43;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index 4fe6305c89..3aa3b8bb6b 100644
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


