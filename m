Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B6C4D37E33
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 13:44:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg19z-0002K5-KH; Wed, 14 Jan 2026 08:43:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vg19h-00029U-O6
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:43:26 -0500
Received: from p-east2-cluster4-host10-snip4-2.eps.apple.com ([57.103.78.223]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vg19g-0000dO-9c
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:43:25 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPS id
 A3A171800482; Wed, 14 Jan 2026 13:43:19 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=NqtcHJC/jmtg6zxYmtUDz1F7scGINBcHMu0R0Ue6BzE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Hjq9Cd9JM9Bsf4G/5LYVNEJJ3c4MuDoyfjDKhrAmdqrIUWMcFC6VNWiP9VAfh0FqOupihX/98JlYaytEodNkpr01ijo6INtlwuya+5Ugn+wAmvV9Njrp5oKeQT+8jkU+L+5bfwzaIMfIQqqE854iF248ZqwgcOPv4Dtv7BHwchPXM/AR3Tm0xZPnp+JE4t/2CXuchI+4CUvX7o7jtEcLqvcGPMfcUY+MkCNZqn/X1tzdHhDvwULS9OlqQ6SBuc694fIeOE15dZdd8mjR+qMbGisDFtuqMb0NcACBjYvvlkfIgGVfcZATT5330zICaREohhhAronej1O6VLIIuv34gQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPSA id
 62B6318004AE; Wed, 14 Jan 2026 13:43:15 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Igor Mammedov <imammedo@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v14 22/26] whpx: arm64: gicv3: add migration blocker
Date: Wed, 14 Jan 2026 14:41:39 +0100
Message-ID: <20260114134143.26198-23-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260114134143.26198-1-mohamed@unpredictable.fr>
References: <20260114134143.26198-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info: v=2.4 cv=YqIChoYX c=1 sm=1 tr=0 ts=69679d79
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=ZsnAEJ0dk2gu5naU1fIA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: zE4xKlPO5TCMGIQ_Ue3iUJk_5KtoqbZU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDExNCBTYWx0ZWRfXw+b45A0PdjHT
 dAn4vr2q+OO2CEKFm26TmcsQtYBsDEFGHuKPu8Ob1yvqBMcKWz976AF2cUg5VPJhsb/WLIllIPt
 VNJ8uTO2zZoc1uYxemCYl5qZgrsEJAzXYZPu80I/OMtw5piGpAFsxbHt9wbKqeWM9jsseo4XvlN
 ywklK1jeYsm/pTYPErjyCphYdNlhmGyUQrMhKLPzjM5xPUNzJ2Aq7VYewR/b4Hh81RtTriG7PGy
 4mR8ZYZ9A39APiji5fTureIOtfl2smI6Dfqu0vB1eT5guxdLOdvT4MtNhIp37HWIdFsjRoH6E70
 3hQpOb9rZrkyYsxwBYE
X-Proofpoint-GUID: zE4xKlPO5TCMGIQ_Ue3iUJk_5KtoqbZU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_04,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 mlxlogscore=999 clxscore=1030 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 bulkscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601140114
X-JNJ: AAAAAAAB5bdETkQb7CDyrlG1bt93SVH1O3p9q6roPmnC/pC/VykNrMhnSRm3/v5u5cxbe6bduy3NLQuXDRliv0njwF+iy5XfMNsgUtl/Wmk5eu2XFC20V2pBKk5ZCItxETsCWWBZQQQvmKhG4hgpbmOPGpYR2ctbp+0uGxvQBgrNwhuhR8VIMNABMV/WR4XWfuVYucVsEFAkltSdOMJWOBo4e2dTEmKaorsqlu34hcK2ituClokmtoOIOBey+mzdvnwLdodBg6xbExz1/E6pN/TyWljLASRDzbF4ijg6XxrCinWFd4WryPX/VsP3GBjRdcCE7ETkb1AeRMRIk/LcyuncQDaBC1MW44hrb91YVpZDlrXfYd8tfILKMp/b06FbE9gB9XG+qSxs03fUlyt7P65/ojpU8Kh2DJCtQsJT24IzKshzravqtuyT6z8fkAMEdGK2VVhn7rtbd56q7bB1jBkR+FpeCS8RJtyzYLY+XGc2/riClOsKKLV+mY4p2JEsFLlWmLO5WqrOyD+oVx7uahh9YLuY3xKkOkrcDFsgfd24GWBeiwmM3vd4Er9wGWUu0LVYtTai7WfStJOWT6mo60hKQime/Cb6C8YnkHzZBC6jBqTveBJn4qD3J2I96urFgzCQ/dDaFSXrt6kYfXPI06APFIPyu0D9CkgJ8jae9aSXrr1778IbviC5+LupDVe84i9xFGNQNaSj1xs31uqagekA0MF7hvDAZzUP1NRyIXn1Im4FCilCuZRD9mhIHR3B4lYJK7PM9L2sybOX1oGlUnggw/Zt6WcN1UpK4BaYsIzePzMQlbuKV6ow9F6aoy5juUgle+O93UqDREl34I7UGPF7kk+oGyQBYs4kVbqS9vKfXJZep/bySCY/t702b31TqhogILtIzb3d2AOHIMe/Jm1urJvK40eth/cOeixskmdnqVZauA==
Received-SPF: pass client-ip=57.103.78.223;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
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


