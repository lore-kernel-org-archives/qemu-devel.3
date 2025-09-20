Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7885ECAC5A7
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Sep 2025 14:06:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzyBR-00070q-7U; Sat, 20 Sep 2025 10:03:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uzyBK-0006uO-6a
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 10:03:18 -0400
Received: from p-east3-cluster2-host4-snip4-10.eps.apple.com ([57.103.87.171]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uzyBE-000894-Hz
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 10:03:17 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-3 (Postfix) with ESMTPS id
 23E5F181724E; Sat, 20 Sep 2025 14:03:02 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=nzWfz+yWdE38Km+dQsZKqvSOWpOIi0Tms+2rrM0SehM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=VK9FdgUjFd3smwcY3QErpU6MvjivH3HabNJ6SaRk1Ya4SQmSwvwBhOt9vvT83YGjcVs1zLrfl73QUYNTXCyEjLJDw0VxMvPjCHcKEfVKNuvTbGVIRKpxfbxTgG5rKh0Sy5/e376NBWCgdU3Z1Nf4QslBVfhSTgtcFPMYbEkj/mu3TKP4zKbIxxKDvsilvvhadI9+lCd2y1KOp46emEOhv+nLe7m8oGQiw89cc3oneA6szLSsMPmyrhaFPEgUNi1q0L5OGRPYxRyNsV+FFq39mouh5MO2LnXiYPv2XE+Ujl8NnA7gWkw5Le19xjgMQGGnkvzo0hY4SDtbAHiXse+zjA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-3 (Postfix) with ESMTPSA id
 CB74C1817262; Sat, 20 Sep 2025 14:02:23 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Shannon Zhao <shannon.zhaosl@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 kvm@vger.kernel.org, Igor Mammedov <imammedo@redhat.com>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Alexander Graf <agraf@csgraf.de>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Eduardo Habkost <eduardo@habkost.net>, Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v6 19/23] whpx: arm64: gicv3: add migration blocker
Date: Sat, 20 Sep 2025 16:01:20 +0200
Message-ID: <20250920140124.63046-20-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250920140124.63046-1-mohamed@unpredictable.fr>
References: <20250920140124.63046-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ei8rLP-wJkFXibj2gQOtkn3cfl2_KHDC
X-Proofpoint-GUID: ei8rLP-wJkFXibj2gQOtkn3cfl2_KHDC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDEzNiBTYWx0ZWRfXxm55KNV+0r8u
 fGTPHiqgXfh9egDyWOWW0veXJGc2NdBfai1JG5WQo+kiu0Mbd37p/was85ahZW/+yyQ/C5MMG4k
 78luTBRmHS66y7M/tW7rHmow6664b8OPgpUspGSkKzu7IQm+zMSXB7SQaQLEsKWjB49N7bT1PPr
 LjZ0flABxxQUv/KMH6z/J555UzqQyZCmUSyj3an9qF8TAGrR/ScYwzfgoxqkOdmxdyxzVOaZrpv
 VKlueATVl2UaNhwg13ZWZzE9l03BP2e8H2k1bqwm5sq3eThaJ7/tuKSOZH9PnXQGkhaMQWH+A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-20_05,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=948
 malwarescore=0 adultscore=0 clxscore=1030
 suspectscore=0 bulkscore=0
 mlxscore=0 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2509200136
X-JNJ: AAAAAAAB2UXFWF2CpFrsCC8fx2zzk9xIBIFhyt2EYGYs8bVFB4IP9RVk4ffZFChdeXgdQAKMq0hxtuk8JYFsC6/oFL4QGhvsuT69WM8PVUY80SfZz9fXo7e8CX+v8D1rfuTSsP1qVCkEFedzLLDTtnGWoT//Kz5LAEEn6tNu6BizqufJK+U6sgLWcFqzwXGuB7ETGYvPn4D8Z7r+VZwgd9q28K3N8s66iD+QBeRCyzDtrWzLJwJGpJZS0N0NngkoDc3Udw9JDS9TRJotc6KXl9IauOHvi5Ao+XCOxW/xwE7ajPks1VnsuUPI5fnvRcCavMOZw0wbiH1XvQ4x2KkcLYCgc0Cqkrvnx4grpFZ3N3aUo0Euhah8gGZvzC5kmR0QJarc6Yj5uGwl2b5W3ekIYKkDNjXICtvbmkEUnSFdKGDYQAmMcGXsJb/oxL8BhwWqnaDRf/QOAtcpoX3LzN7rmaH2jSQc0N6QCoOY+2qdQ2fG0pUhlsmeYDOarUYAkL2VOAFP+z4wPZDDFfISdQ34yvGQNTWR3MtAqqHbkMFGYn1db3Ig8AmlljtDMwoX7keA+DyL7U+P6FzCyd4JNCaotvpvngcw+93Q+fs3VF8hi+eppmQuCDQFCgoBVD7B/dnHjs4G0FFqTDZp8eGUfCtyNkcJOjIHnvJ2YY1evHbLG7s1DLmxQfK/EBIALo+NtTyLzi3UI5fOyCy73rxWd+J0lgNK1yMKy08+iZDo/z+ErP34xeFXp/u8kCbZ6yoonxSvs/5C6y2I2W2SawfOAQEihiVXlfRcSd96N7m++gRV4fnvkR/CFchN8xQEyHV9ivYEP7nv421MSoqQ79wwUO7huwTML60R21ZBusWtr8xtL73SY37W9UQFsdIZiORcOCdQ0oLRZo5uua8=
Received-SPF: pass client-ip=57.103.87.171;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


