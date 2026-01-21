Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F423C4453A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 13:46:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viYTu-0005yB-3B; Wed, 21 Jan 2026 08:42:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1viYTW-0005BV-AV
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 08:42:26 -0500
Received: from qs-2001h-snip4-11.eps.apple.com ([57.103.87.83]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1viYTQ-0001OO-Kr
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 08:42:20 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-14 (Postfix) with ESMTPS id
 81AD618003C2; Wed, 21 Jan 2026 13:42:12 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769002935; x=1771594935;
 bh=6sj2MTGR9DeD6ecUqy07jp7nwwk06hbw8XC/wHHnLFM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=REgM2oGA9Fc/1DghUB6WKJnajuZR+2CSDbNtTKnRuHegEe1TQoGxOwpJRaVMN8Nj4Y10jUxMwFzc6hOcUP8e3A9WFoRCSKSZUVFeXMh7bk+uR8pHX4ZzFJxGR6dIIZpYFbfSsdvgnw/lMJtnkIbWAHVYnXXu5WRuvDzcqguNmdmOAfFHZlv1PdhXeqiw1c4nMk/Mfg9r8Mh8sTePgQnLvBZMU5iGmquIkxCA1hpi+Zme8sVAxSmAJqwBnuGpyAVjO16NRZzwMEaLq2Ffg8lylb026uXz5gDSvdevj6HX+FNxTpxYkjDeC0+Fdv23LT4oqZeWyCcQm41kYpQ6ksnEjw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-14 (Postfix) with ESMTPSA id
 6599D1800126; Wed, 21 Jan 2026 13:42:09 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>,
 Igor Mammedov <imammedo@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Ani Sinha <anisinha@redhat.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v17 19/21] whpx: arm64: gicv3: add migration blocker
Date: Wed, 21 Jan 2026 14:41:10 +0100
Message-ID: <20260121134114.9781-20-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260121134114.9781-1-mohamed@unpredictable.fr>
References: <20260121134114.9781-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDExNSBTYWx0ZWRfXwYulBIdsACTW
 BGFr22DaKssmfNo90uK3+dVa7EyRyj1COScmHuCOITcMqf0zC4Mvy/ah29dumIHVZP/5DltJNWc
 ns/YhJTjm8jHBOwikwXGvUXAem3KTGkBlLO7uc1D/mXV5M/VKsIclWVY9hdn4zOsZoXrgCp3wAX
 QvD8xmXklw17KMOo9uE4LkMx2/gXLoXCPZJ96ZHH6Pp+7ZWAsZDZM8QZTtuR9YE3XxQLE2v5M6d
 upuxl2MW1lCBVXrLHSUmuXEMS+mQGGKwnRnYtsTSwrZp2vW3QXX5EZgtlAWDSFN5Fcw2XwYiWNF
 X2nedaIzZYdGuDTOD1M
X-Proofpoint-GUID: 6T-xkvzQjmYajEcDNU3Kf86vhLfd7iAE
X-Proofpoint-ORIG-GUID: 6T-xkvzQjmYajEcDNU3Kf86vhLfd7iAE
X-Authority-Info-Out: v=2.4 cv=N4Qk1m9B c=1 sm=1 tr=0 ts=6970d7b6
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=ZsnAEJ0dk2gu5naU1fIA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 malwarescore=0
 mlxscore=0 clxscore=1030 phishscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601210115
X-JNJ: AAAAAAABBCEu9MlsAihlKDQiMZZn3VMI7SKVD/PHzGomG7R6PIKW+uaw06JLantmqMNP10BK7hkGvByaa43IEISzFboFrkjjEKwl6atnZmJYSFfeaGjoSSHgmOtC9N7S8mo1WsDl/5a0FMk41Kl0OR3WYr21A6Lp4RGueCU/bNbzGbB4Df4S3jdtoZ5Grd8v4zpbSj648c5IBIa7pYqUl8DKx/4qGT4FCQ5i1xZF6xzHv4/+CyXdhfRK4J7l87dNiuybPKZieX2zJCFIYia8XJ9OnzDCxWP9x9pYil80FtBg/8uyz1Nz4BVImpI8cuH1WRzJv9RCOmeAac7zmYOMIW4h5FeGYoxVgRD/b8Wk5ZRrm0RdqJTCCfwWmSp+gC+x/kCNogpTPmMGPBbB7XztVNxrgY+m04mQ8Z3EqEhQiIufppiN4m0ypn3Tb5tUBqeMyDXHc9RWE9Oor0pXLTus9JpRUShmeLJk9pPxeplBd/9M5XFwqL6rwfCuk/ZmqTD671Tna4Xq4P2s5rhWg1TqMGGCK1Y3T5BtPm46cVLJdFqlRx1eZzpug3pzHayw+AJeVptDCohwf/jAwUGceBothVFoQ6CF/LWGmBvFQ+VkhqYZYb/wXRWC15qRTMzzkJp1qgE32Nh4SuanUf3mySxkY4RNypg2hP98Bh7q4dXo+o0U9B1rwelQ94S9MRdJ+5PHTgEaq+QRDXTe2q8R2gkuR1ShbQ5r4O74MTBdYUgwvZY1tT3MMlVWRXmHmV9mUCNto9HyaG9ePaW4h/2j4E2GwixrH2PD+YP2uip/TkH84MoTx4l74elAPXCOFIxPRB+xK1T6+1BR2oqwhddakaT1CFVGcCqIFREjxAoXWwXa8TGxxhupI0llGgwosjwlOPtatRuyfg8lgtqfYDzUEoO7gw==
Received-SPF: pass client-ip=57.103.87.83;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 hw/intc/arm_gicv3_whpx.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/intc/arm_gicv3_whpx.c b/hw/intc/arm_gicv3_whpx.c
index 9bc036d1ac..a2f8e3c5fb 100644
--- a/hw/intc/arm_gicv3_whpx.c
+++ b/hw/intc/arm_gicv3_whpx.c
@@ -17,6 +17,7 @@
 #include "system/whpx-internal.h"
 #include "gicv3_internal.h"
 #include "vgic_common.h"
+#include "migration/blocker.h"
 #include "qom/object.h"
 #include "target/arm/cpregs.h"
 
@@ -204,6 +205,14 @@ static void whpx_gicv3_realize(DeviceState *dev, Error **errp)
         error_setg(errp, "Nested virtualisation not currently supported by WHPX.");
         return;
     }
+
+    Error *whpx_migration_blocker = NULL;
+
+    error_setg(&whpx_migration_blocker,
+        "Live migration disabled because GIC state save/restore not supported on WHPX");
+    if (migrate_add_blocker(&whpx_migration_blocker, errp) < 0) {
+        error_report_err(*errp);
+    }
 }
 
 static void whpx_gicv3_class_init(ObjectClass *klass, const void *data)
-- 
2.50.1 (Apple Git-155)


