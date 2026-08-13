Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F34CCC5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 16:29:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuYHA-0004kz-D6; Thu, 13 Aug 2026 12:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1wuYGb-00043S-Fe; Thu, 13 Aug 2026 12:26:54 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1wuYGZ-0001QG-Ep; Thu, 13 Aug 2026 12:26:53 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with UTF8SMTP id AQAAfwCnrxtI8H1qNCVvAw--.34509S2; 
 Fri, 14 Aug 2026 00:26:48 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8DwoHJE8H1q7ywjAA--.56307S4;
 Fri, 14 Aug 2026 00:26:45 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Mostafa Saleh <smostafa@google.com>,
 Chao Liu <chao.liu@processmission.com>,
 Jim MacArthur <jim.macarthur@linaro.org>,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: [RFC v5 28/28] [NOT-MERGE] hw/arm/smmuv3: temporarily enable SEL2 bit
 and some other features
Date: Fri, 14 Aug 2026 00:26:44 +0800
Message-Id: <20260813162644.2810021-2-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DwoHJE8H1q7ywjAA--.56307S4
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAGBWp8yc0HtwABsh
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7KFyrCw1fXryxtF13Gr1xZrb_yoW8XryDpa
 1DAryDKayvkw43Z34UAw4xA3W3Gan5Gr12yr4DWrWrA3WYvr1DJw4vgw1rKryI9rWrAF47
 uF1I9a9Yqr1Fqr7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Temporarily:
- enable S_IDR1.SEL2,
- change AIDR to 0x2 to indicate SMMUv3.2,
- use smaller SID size and Cmd/Evt queue size.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 hw/arm/smmuv3.c                | 3 ++-
 include/hw/arm/smmuv3-common.h | 6 +++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 8e1de94fd17..19e080b6d25 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -350,6 +350,7 @@ static void smmuv3_init_id_regs(SMMUv3State *s)
                                SMMU_IDR1_SIDSIZE);
     sbank->idr[1] = FIELD_DP32(sbank->idr[1], S_IDR1, SECURE_IMPL,
                                s->secure_impl == ON_OFF_AUTO_ON);
+    sbank->idr[1] = FIELD_DP32(sbank->idr[1], S_IDR1, SEL2, 1);
     smmuv3_accel_idr_override(s);
 }
 
@@ -400,7 +401,7 @@ static void smmuv3_reset(SMMUv3State *s)
     sbank->gerrorn = 0;
     sbank->gbpa = SMMU_GBPA_RESET_VAL;
 
-    s->aidr = 0x1;
+    s->aidr = 0x2; /* SMMUv3.2 */
     s->statusr = 0;
 }
 
diff --git a/include/hw/arm/smmuv3-common.h b/include/hw/arm/smmuv3-common.h
index ec442a85586..1afaece3df7 100644
--- a/include/hw/arm/smmuv3-common.h
+++ b/include/hw/arm/smmuv3-common.h
@@ -311,9 +311,9 @@ REG32(IDR1,                0x4)
     FIELD(IDR1, TABLES_PRESET, 30, 1)
     FIELD(IDR1, ECMDQ,        31, 1)
 
-#define SMMU_IDR1_SIDSIZE 16
-#define SMMU_CMDQS   19
-#define SMMU_EVENTQS 19
+#define SMMU_IDR1_SIDSIZE 6
+#define SMMU_CMDQS   10
+#define SMMU_EVENTQS 10
 
 REG32(IDR2,                0x8)
      FIELD(IDR2, BA_VATOS, 0, 10)
-- 
2.34.1


