Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF67CFA76A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 10:10:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMO22-0006zL-S8; Fri, 21 Nov 2025 05:06:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vMNzw-0004wl-Pc
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 05:04:12 -0500
Received: from p-east3-cluster4-host8-snip4-10.eps.apple.com ([57.103.84.83]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vMNzh-0007yq-3z
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 05:04:09 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPS id
 7D5D71801108; Fri, 21 Nov 2025 10:03:26 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=7ELmogO1rP/Q466oRv7Y0E5YhY0QvblNmMS2WwTWd7k=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=BlolwnY2EYQP42CE8VBnwAfAFHRena9kzy36Gqz3kdnXhf4zfVfr3NsbP4c/e8EVEnrxutbeKDcA6+K6HQ3i1Xg25+zHvSAxe/Sl2Pz5tiQ3/cUjDXeYpJMOQamXcZf3TycWxMD44nG6P9j8qjrbxnWvUBHI5Q8RO8aD0sx0YQGkXUz3rwlMLOIHWuDoamEk/bLkgtKpgmNjHtRR9vwbGGg891nlA+8txo0nUesNAuIYLQA6G8moTgADET9shKIBFTtLq+pk+wnp/4jDXFds4wEt8GI5RQu9YJsMvl0ldAMRGMahPzJcjebC9xce4nzQ3yeqtj673I2vWMDMlUVcYQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPSA id
 48F0D1800143; Fri, 21 Nov 2025 10:03:24 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, Peter Xu <peterx@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v11 24/28] whpx: arm64: gicv3: add migration blocker
Date: Fri, 21 Nov 2025 11:02:36 +0100
Message-ID: <20251121100240.89117-25-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251121100240.89117-1-mohamed@unpredictable.fr>
References: <20251121100240.89117-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 2Mpt1Z3AeGDGFjN2Lg_pALNYp4_q5Dee
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIxMDA3NiBTYWx0ZWRfX3lkwocf8/8Hm
 rCWRvflikjq6nemf54D0MhJ858Iz8tf/6b5TOZ+xalNmrO9yxC7I5LzOchJh/7A//GjiHuDOLUX
 Szx+NYnJf/y+BQpD10zVEwzkWAAkKEpovwI/LqmiFmmNStWEj8C1D7W7g2KB29HBy5xfLbOSk7E
 I2O5CTD4dUrp6rcOnRETcFPUMkypZJrCIoGfGRfCy1h3D1CS5Kyd4epddDzW1ocyxxLHUWcy3VN
 KfE3JXh9vL++7oAM2Q2l8OKXpRSTPF+PFe2aerhIi/sq42qMRXfkwbejHqVzILexAlaCTMdbSmz
 mezlAd9u3fdkGwW9dTb
X-Proofpoint-ORIG-GUID: 2Mpt1Z3AeGDGFjN2Lg_pALNYp4_q5Dee
X-Authority-Info: v=2.4 cv=HYIZjyE8 c=1 sm=1 tr=0 ts=692038ef cx=c_apl:c_pps
 a=bsP7O+dXZ5uKcj+dsLqiMw==:117 a=bsP7O+dXZ5uKcj+dsLqiMw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8
 a=ZsnAEJ0dk2gu5naU1fIA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_03,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 clxscore=1030 suspectscore=0
 spamscore=0 adultscore=0 mlxlogscore=898 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511210076
X-JNJ: AAAAAAAB0RQYXcQvQOMmSXamNAkEWO9lh5nNrHftor8gL3oNxxUPBQwzGQlJbysb+Am+ksMIV578EUzfGwcGm0zr8Jb6u6FrtLJLKbXZrF+CpBzueVx+WtAmiklXWoo2Ajn/HePzamiguoRH9kqjAKtn/9IB0pkefLRbktkSreUKpadCsZNO3b8Fkoc5dcLDfwF1CZo0ORG4JPtusCieYNVWZ2or+gTEpJceLGwziVK6m7K5+vTxc0a7kgf9rRmxJxuR5LP58MWNbnnc13jR6UThprmojerI+DeqsnCcas4WbmmYc5mj4l5twe9Cfdl0flv58QPR0dIZ0FdqKnBYKq/Y6X6w5pbnEMnTyyKMrop5nvfkVkfsz+qz+lUZEF6PobTuc857zCYMkduompkLgD+QmioCwJcJH/eSU8kdu7fcJHvnM5TqIBWSPLXcUtjocrlV40uxeG5wmgpGQuzcgDQGA2fxzMQjWfx3Ga22oM4HGJyaXgouTTWancJE1xlrpWijnshyUyPNxePQuXoPHwJQ/6+04dUdM+GSNThMNsVcM2T7gTaimVGv1JMi5/hPu7Uws+eSgLRQzrJlQJLrqkcejmPHcLcKaORYvmiNuifXR2O2VTsjbuT+u4dIjqpOVUDhvEC2Mu1HKao0PNXzHiAo/5pPnCI/kobewnXtN892yE07NVKCBd36hZ3j1hZnqFCoR0FYFQIdw2kiDMveVyWvsg2wSguItueUBN7e8p43UCNlRFOJSMdtAVVafU36QZSKCdzYWxC5A9JupDFWEmGsy5tuaiJc
Received-SPF: pass client-ip=57.103.84.83;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
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


