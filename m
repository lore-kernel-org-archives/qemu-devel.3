Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14311CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 23:55:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDtRw-0002L8-9n; Tue, 28 Oct 2025 19:50:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vDtRh-0002Dq-Iy
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:49:47 -0400
Received: from p-east1-cluster6-host3-snip4-10.eps.apple.com ([57.103.90.161]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vDtR4-0004pf-N6
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:49:44 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-20-percent-0 (Postfix) with ESMTPS id
 5CF3818034EA; Tue, 28 Oct 2025 23:48:58 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=7ELmogO1rP/Q466oRv7Y0E5YhY0QvblNmMS2WwTWd7k=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=c1hcz/LVoKxxQtp9ks15iMQRwRM4Oi/FTWQZEOO4jbKmPPRbezTuouPApukvuhzSV3x5afzsVKNN5dEIpouurjoUG+Sy/JcwU/t7F1kFf7JIdB4zBPf/2RUZ9b9ny0U71XbYSEApYqibkiLECtfjacrMeqk2K+EQ2GbPEonahYlI31w9aHoN7NgRRblEQKPSUKKe0TEM6B08nzLrioIRfBxS7FTwc6ZKkhO9MGFfvg+C2qOQCaze0NRqHGm4WB9SvS/R31MAwOq04z/v9Q2CcMIm+n9XWKJK96aPCYgJ62VNAS1bV+i6eArBDhQQdBcKTlermpGV/ugOsgEk1HIguQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-20-percent-0 (Postfix) with ESMTPSA id
 278011803127; Tue, 28 Oct 2025 23:48:55 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v9 23/27] whpx: arm64: gicv3: add migration blocker
Date: Wed, 29 Oct 2025 00:47:53 +0100
Message-ID: <20251028234757.39609-24-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251028234757.39609-1-mohamed@unpredictable.fr>
References: <20251028234757.39609-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: GKSs97pGUIcRYszt2pX5cuyMMDbIlGZn
X-Proofpoint-GUID: GKSs97pGUIcRYszt2pX5cuyMMDbIlGZn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDIwMiBTYWx0ZWRfX3bv0YHceBr3Z
 IkRKdqHSeJ9TMC9ZqllrG/G7htzaDzuE+wlSIJqaTLI/AdXOeudMUqDDeeFRfjsLInR+BDMGoWj
 EXH4gVHj0DVM7ateXTr4gs+NPaATcy/sQe+7T3icdGnsoWRD3BB+KFMKaG32R+4oa0ZKjT0ibmF
 C+Ridzj9GDVWKQsKEF4QIN+QFs5WGQSB+YwE/QwnvFptXZ2kg2tl25SMBETVKTo8YePxfr94HBG
 Z60/Xw8hXvdT0NIlsYAxtZTyjKKwIWH6+f41RlUOczLwD6UhNchBb69gGo1CQSAxhk7CXvn6M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_09,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 mlxlogscore=898 clxscore=1030 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2506270000 definitions=main-2510280202
X-JNJ: AAAAAAABGy1xSUx189Hac4E1+QhZmF00Nq+zUTJcn9VoD2Z/lxqiQ0iqA0e75k6ZmEnGokDICVA0s15J0qvoqPRxHtG1/sPR6Px5XxKNT8RbS+O4eV2Hc1iO/JRHxwRO0xyICxrTNCM8M17OJGaMCMzZUrmDq0Tz00yRaMOptX9ovhRWBnm9iKOxDZ+YrD8GE8F5DLn+bWflQ/EwqdgRAxsiPXQhDZxX9RgHPCEMMuEQ1q2FlPaGT7cGP535EIIKku+e6DG0fp3ABUbqvThmlL2HpgOv/XSdYvmO5APSrbLZjEVkQ5A9T59mlpVr1a1Yg5ntrQz5AoqUVt+hxMCqoG2nl6MtWu/tWknG46RMMXQzVsxyVm52HTHnk01iA3limpEpUr8qw2T37P7SY35f/CEDUV1pcL2pNMG+kocQVZcB85CwxdthEPyif/2Awqs4/dYcfRmoGlyTByji5UC+o9Pm8Fdm+wI/f8ArKnzQe+sMddKrz1Q8l+BHJn2mN3piE54UDA+deZs/lBcseV78onCGlpCNbpBBB/dKki6/CfIEyNOQtWu92OQxJBffr+Xyfhtv8T6vXiG4QaYvSgNWTqwtkwsCD9AxOWqQIAhrj8V8G4JimLGxGFOu4JjD7peghwcSFhnnQB/gv/D1+N2Y8oYj08MatVMcx60sZHdVGwWBk82KUuoVbYPxd2VhgbT7BaU2GanL2ewZRaddu37iISTrL71hHxOAaEbwV5YvensNjqGL3qEWcREdCdHkU/hOdyyu
Received-SPF: pass client-ip=57.103.90.161;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


