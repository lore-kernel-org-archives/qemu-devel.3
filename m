Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 863C2E8FDBE
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Dec 2025 23:59:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1va0eK-0001Kq-CV; Sun, 28 Dec 2025 18:58:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1va0eJ-0001Ew-3Z
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 18:58:11 -0500
Received: from p-west1-cluster5-host4-snip4-10.eps.apple.com ([57.103.66.171]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1va0eH-0007Rk-DM
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 18:58:10 -0500
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-5 (Postfix) with ESMTPS id
 ACEC41800759; Sun, 28 Dec 2025 23:58:02 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=kLQA6rv7sDQAG6jrMiTsp6VgPXcx5wZdDjsp3PZWbuo=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=NuZayDbPv8AN4MwMr/Y6oc3dao9Q47HNv/vZ8IeNH0BdsWedrD+oV9VK7Y72q/XIoAmdcpvGABo7yDymUEdinhahPDTju4iphzl33pNSD/GtfGYy5auonGhtWvCDE3wqaOU+i33XMtuQ1WkYyzEVkhQEsvgONkRnlntAsPcJmR3KvoEcejVZZqcUdZiGjU6A5fjzwny2z58N+URbSboveydpMypMsy65oBWqb5sTtxpTqRoP08pd7Fo04OTqs81w3xKuaxC19VCcU8go9V+RHgXLI5JQs3x+L88UI05erGpIbhxf4iMX2SxasSt5JhCT/OvQ9daCgLFb7PKaiqHuLg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-5 (Postfix) with ESMTPSA id
 E0E931800758; Sun, 28 Dec 2025 23:57:56 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Alexander Graf <agraf@csgraf.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 kvm@vger.kernel.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Xu <peterx@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v12 23/28] whpx: arm64: gicv3: add migration blocker
Date: Mon, 29 Dec 2025 00:54:17 +0100
Message-ID: <20251228235422.30383-24-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251228235422.30383-1-mohamed@unpredictable.fr>
References: <20251228235422.30383-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI4MDIyMyBTYWx0ZWRfX8/BFux9mqVRx
 xXbQfAi77jJEo6TnploVmGusPwFrnUYayA1KYeIEmSkPvsVon+LfAotE9yrUXCIcYw78LJmkVPa
 mlj0Fbw4CU2GvxAayG8UmZCMvsKdNKdDRm7M1kiQGYA7OermOEM107kJ9DDDNefJucPo8AlInIo
 wa5t+rA11ghLepHEPWl6fFrqRsbB0kokMdxxOz8Tx4R7gB0lIx+zC+1VzX51RPe+DXOKA4TUzE6
 FJVF9Pfk94xfDWYBwNLTEUeSgfBJnNt1m/F3rvMrhtCv1W0Nud23e3BQrBKxiwLxfcvaonUQOb0
 pBrRwh8MJ2eJ+8B3dcw
X-Proofpoint-ORIG-GUID: yTxwXTl9wsxJXGVz9NWPuhI47BW7-Ijb
X-Authority-Info: v=2.4 cv=EfrFgfmC c=1 sm=1 tr=0 ts=6951c40e cx=c_apl:c_pps
 a=azHRBMxVc17uSn+fyuI/eg==:117 a=azHRBMxVc17uSn+fyuI/eg==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8
 a=ZsnAEJ0dk2gu5naU1fIA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: yTxwXTl9wsxJXGVz9NWPuhI47BW7-Ijb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-28_07,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 adultscore=0 clxscore=1030 malwarescore=0 suspectscore=0
 mlxlogscore=911 spamscore=0 mlxscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512280223
X-JNJ: AAAAAAAB/tCRCsGoin7QIcNoebtRXIj3WUczFqkiutQj2wC2EKcDdy4kr0UlNCv9craj3RU3X6nBa7Zsafk+rmoXOwyK96UI1ldUWvhAqhbyx170xeTGm8wDXRAW2qSvquqS+ASYgtGSTYozrtw7qgvE/eKnA+0Dfg/soZeGw+usP581ukFmaPcU/AS1ux8ZX6liuvvfW2m6e88jKHixN2WCEPBuKMqagyXc+JSlitTojuGUYRy79QLfbXc5xCag8uU1UUvxGnSpa43hkY5pET54xf9ZyZkD1gFVy+pNvCFzX2JxKmOj07jsX+w6r2vRHa20Hz86DRXaMdKH/Q2coAQ9/nPRgcUcoN9kb6FBcY4/SWYDTdUO45I0uSX5hVstQBvlk5aiDIt+5fqDDUoEkQW0AWwBA16IetQF87Yz6J+1kT1lEhAxBujHZH36JN7T6VGYwDJM3/nRDj5kpLXs9O6p3eNiTtmPH202Np9J1IaydF3Xlgvnw/bWoTyaUdwMy1Xx/43BFc8boy2Kqdjm/eL/Bg3o2qXnpW2JgsmGo53Pbi9pd95si+JTSQOQlB9mWD0aFqeeg4gSJa68tKcWg7YgwNsV49omK3hq8Ijaf3ey2zBF5e0UmTjR3BdKqkcRz8ghf2F2jcbtiply+W7m8TS1V83Mj01+fnUKjw4J/0HmzqNCTrodx7iWNKL2wBPYUCNrCOkCVg1bFWIleOMon/xctFPfnKAENmxZNhuD5ZxNv1rqXUGQby+4b/EhidADgpGmAIThUUQlmwRt2HiBk+0NWxUFbqfDyILLemZ6xRuS+sOUcld51Z+FkLTI9kAwWr6QgQfhtH2KUcGFf7T/muKAjIFhHnM4EHjjvJKEQ8BeYJ880i3FXVtOCjK/jDqOp0JoNUbhiFzXbzg/vh2JyNcBVt8uBnpBZm0ICBYkFllBGIhdsBcVlTuedInqZI+nIDRA24D7oAvhbrH6qb3lojFTZWi5qbn
 Rf+Iuv5qO/KhzgSuq6Cgw
Received-SPF: pass client-ip=57.103.66.171;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


