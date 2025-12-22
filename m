Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F990E674A9
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Dec 2025 12:47:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXfJB-0006XZ-BM; Mon, 22 Dec 2025 07:46:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vXfIR-0006JA-FH; Mon, 22 Dec 2025 07:46:03 -0500
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vXfIO-000745-1W; Mon, 22 Dec 2025 07:45:54 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwCXn1N5PUlpEtTzAQ--.33049S2;
 Mon, 22 Dec 2025 20:45:45 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwBXr+xyPUlpieINAA--.25982S5;
 Mon, 22 Dec 2025 20:45:42 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: [RFC v7 2/7] hw/arm/smmuv3-common: Define STE/CD fields via
 registerfields
Date: Mon, 22 Dec 2025 20:45:12 +0800
Message-Id: <20251222124517.3948679-3-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251222124517.3948679-1-tangtao1634@phytium.com.cn>
References: <20251222124517.3948679-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwBXr+xyPUlpieINAA--.25982S5
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAMBWlIVJoHZwAAsH
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3XrWfKw4UCF4UAFW7ZrWkWFg_yoW3Zw4DpF
 1xCa4vg398WF4xCwn5tr45GrsxZws2yw1fJry3KrWxG3ZxG3s7Z3s2gFW5tF1Uurs5Z3W3
 ursY9rW5WFnIyrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Switch STE/CD bitfield definitions and accessors to the
'hw/registerfields.h' REG/FIELD API.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 include/hw/arm/smmuv3-common.h | 169 +++++++++++++++++++++++----------
 1 file changed, 120 insertions(+), 49 deletions(-)

diff --git a/include/hw/arm/smmuv3-common.h b/include/hw/arm/smmuv3-common.h
index 9da817f41a..b6da2fd62c 100644
--- a/include/hw/arm/smmuv3-common.h
+++ b/include/hw/arm/smmuv3-common.h
@@ -11,6 +11,8 @@
 #ifndef HW_ARM_SMMUV3_COMMON_H
 #define HW_ARM_SMMUV3_COMMON_H
 
+#include "hw/registerfields.h"
+
 /* Configuration Data */
 
 /* STE Level 1 Descriptor */
@@ -35,63 +37,132 @@ typedef struct CD {
 
 /* STE fields */
 
-#define STE_VALID(x)   extract32((x)->word[0], 0, 1)
+REG32(STE_0, 0)
+    FIELD(STE_0, VALID, 0, 1)
+    FIELD(STE_0, CONFIG, 1, 3)
+    FIELD(STE_0, S1FMT, 4, 2)
+    FIELD(STE_0, CTXPTR_LO, 6, 26)
+REG32(STE_1, 4)
+    FIELD(STE_1, CTXPTR_HI, 0, 16)
+    FIELD(STE_1, S1CDMAX, 27, 5)
+REG32(STE_2, 8)
+    FIELD(STE_2, S1STALLD, 27, 1)
+    FIELD(STE_2, EATS, 28, 2)
+    FIELD(STE_2, STRW, 30, 2)
+REG32(STE_4, 16)
+    FIELD(STE_4, S2VMID, 0, 16)
+REG32(STE_5, 20)
+    FIELD(STE_5, S2T0SZ, 0, 6)
+    FIELD(STE_5, S2SL0, 6, 2)
+    FIELD(STE_5, S2TG, 14, 2)
+    FIELD(STE_5, S2PS, 16, 3)
+    FIELD(STE_5, S2AA64, 19, 1)
+    FIELD(STE_5, S2ENDI, 20, 1)
+    FIELD(STE_5, S2AFFD, 21, 1)
+    FIELD(STE_5, S2HD, 23, 1)
+    FIELD(STE_5, S2HA, 24, 1)
+    FIELD(STE_5, S2S, 25, 1)
+    FIELD(STE_5, S2R, 26, 1)
+REG32(STE_6, 24)
+    FIELD(STE_6, S2TTB_LO, 4, 28)
+REG32(STE_7, 28)
+    FIELD(STE_7, S2TTB_HI, 0, 16)
+
+/* Get STE fields */
+#define STE_VALID(x)      FIELD_EX32((x)->word[0], STE_0, VALID)
+#define STE_CONFIG(x)     FIELD_EX32((x)->word[0], STE_0, CONFIG)
+#define STE_S1FMT(x)      FIELD_EX32((x)->word[0], STE_0, S1FMT)
+#define STE_CTXPTR(x)                                               \
+    (((uint64_t)FIELD_EX32((x)->word[0], STE_0, CTXPTR_LO) << 6) |  \
+     ((uint64_t)FIELD_EX32((x)->word[1], STE_1, CTXPTR_HI) << 32))
+#define STE_S1CDMAX(x)    FIELD_EX32((x)->word[1], STE_1, S1CDMAX)
+#define STE_S1STALLD(x)   FIELD_EX32((x)->word[2], STE_2, S1STALLD)
+#define STE_EATS(x)       FIELD_EX32((x)->word[2], STE_2, EATS)
+#define STE_STRW(x)       FIELD_EX32((x)->word[2], STE_2, STRW)
+#define STE_S2VMID(x)     FIELD_EX32((x)->word[4], STE_4, S2VMID)
+#define STE_S2T0SZ(x)     FIELD_EX32((x)->word[5], STE_5, S2T0SZ)
+#define STE_S2SL0(x)      FIELD_EX32((x)->word[5], STE_5, S2SL0)
+#define STE_S2TG(x)       FIELD_EX32((x)->word[5], STE_5, S2TG)
+#define STE_S2PS(x)       FIELD_EX32((x)->word[5], STE_5, S2PS)
+#define STE_S2AA64(x)     FIELD_EX32((x)->word[5], STE_5, S2AA64)
+#define STE_S2ENDI(x)     FIELD_EX32((x)->word[5], STE_5, S2ENDI)
+#define STE_S2AFFD(x)     FIELD_EX32((x)->word[5], STE_5, S2AFFD)
+#define STE_S2HD(x)       FIELD_EX32((x)->word[5], STE_5, S2HD)
+#define STE_S2HA(x)       FIELD_EX32((x)->word[5], STE_5, S2HA)
+#define STE_S2S(x)        FIELD_EX32((x)->word[5], STE_5, S2S)
+#define STE_S2R(x)        FIELD_EX32((x)->word[5], STE_5, S2R)
+#define STE_S2TTB(x)                                                \
+    (((uint64_t)FIELD_EX32((x)->word[6], STE_6, S2TTB_LO) << 4) |   \
+     ((uint64_t)FIELD_EX32((x)->word[7], STE_7, S2TTB_HI) << 32))
 
-#define STE_CONFIG(x)  extract32((x)->word[0], 1, 3)
 #define STE_CFG_S1_ENABLED(config) (config & 0x1)
 #define STE_CFG_S2_ENABLED(config) (config & 0x2)
 #define STE_CFG_ABORT(config)      (!(config & 0x4))
 #define STE_CFG_BYPASS(config)     (config == 0x4)
 
-#define STE_S1FMT(x)       extract32((x)->word[0], 4 , 2)
-#define STE_S1CDMAX(x)     extract32((x)->word[1], 27, 5)
-#define STE_S1STALLD(x)    extract32((x)->word[2], 27, 1)
-#define STE_EATS(x)        extract32((x)->word[2], 28, 2)
-#define STE_STRW(x)        extract32((x)->word[2], 30, 2)
-#define STE_S2VMID(x)      extract32((x)->word[4], 0 , 16)
-#define STE_S2T0SZ(x)      extract32((x)->word[5], 0 , 6)
-#define STE_S2SL0(x)       extract32((x)->word[5], 6 , 2)
-#define STE_S2TG(x)        extract32((x)->word[5], 14, 2)
-#define STE_S2PS(x)        extract32((x)->word[5], 16, 3)
-#define STE_S2AA64(x)      extract32((x)->word[5], 19, 1)
-#define STE_S2ENDI(x)      extract32((x)->word[5], 20, 1)
-#define STE_S2AFFD(x)      extract32((x)->word[5], 21, 1)
-#define STE_S2HD(x)        extract32((x)->word[5], 23, 1)
-#define STE_S2HA(x)        extract32((x)->word[5], 24, 1)
-#define STE_S2S(x)         extract32((x)->word[5], 25, 1)
-#define STE_S2R(x)         extract32((x)->word[5], 26, 1)
-
-#define STE_CTXPTR(x)                                   \
-    ((extract64((x)->word[1], 0, 16) << 32) |           \
-     ((x)->word[0] & 0xffffffc0))
-
-#define STE_S2TTB(x)                                    \
-    ((extract64((x)->word[7], 0, 16) << 32) |           \
-     ((x)->word[6] & 0xfffffff0))
-
 /* CD fields */
 
-#define CD_VALID(x)   extract32((x)->word[0], 31, 1)
-#define CD_ASID(x)    extract32((x)->word[1], 16, 16)
-#define CD_TTB(x, sel)                                          \
-    ((extract64((x)->word[(sel) * 2 + 3], 0, 19) << 32) |       \
-     ((x)->word[(sel) * 2 + 2] & ~0xfULL))
-
-#define CD_HAD(x, sel)   extract32((x)->word[(sel) * 2 + 2], 1, 1)
-
-#define CD_TSZ(x, sel)   extract32((x)->word[0], (16 * (sel)) + 0, 6)
-#define CD_TG(x, sel)    extract32((x)->word[0], (16 * (sel)) + 6, 2)
-#define CD_EPD(x, sel)   extract32((x)->word[0], (16 * (sel)) + 14, 1)
-#define CD_ENDI(x)       extract32((x)->word[0], 15, 1)
-#define CD_IPS(x)        extract32((x)->word[1], 0 , 3)
-#define CD_AFFD(x)       extract32((x)->word[1], 3 , 1)
-#define CD_TBI(x)        extract32((x)->word[1], 6 , 2)
-#define CD_HD(x)         extract32((x)->word[1], 10 , 1)
-#define CD_HA(x)         extract32((x)->word[1], 11 , 1)
-#define CD_S(x)          extract32((x)->word[1], 12, 1)
-#define CD_R(x)          extract32((x)->word[1], 13, 1)
-#define CD_A(x)          extract32((x)->word[1], 14, 1)
-#define CD_AARCH64(x)    extract32((x)->word[1], 9 , 1)
+REG32(CD_0, 0)
+    FIELD(CD_0, TSZ0, 0, 6)
+    FIELD(CD_0, TG0, 6, 2)
+    FIELD(CD_0, EPD0, 14, 1)
+    FIELD(CD_0, ENDI, 15, 1)
+    FIELD(CD_0, TSZ1, 16, 6)
+    FIELD(CD_0, TG1, 22, 2)
+    FIELD(CD_0, EPD1, 30, 1)
+    FIELD(CD_0, VALID, 31, 1)
+REG32(CD_1, 4)
+    FIELD(CD_1, IPS, 0, 3)
+    FIELD(CD_1, AFFD, 3, 1)
+    FIELD(CD_1, TBI, 6, 2)
+    FIELD(CD_1, AARCH64, 9, 1)
+    FIELD(CD_1, HD, 10, 1)
+    FIELD(CD_1, HA, 11, 1)
+    FIELD(CD_1, S, 12, 1)
+    FIELD(CD_1, R, 13, 1)
+    FIELD(CD_1, A, 14, 1)
+    FIELD(CD_1, ASID, 16, 16)
+REG32(CD_2, 8)
+    FIELD(CD_2, HAD0, 1, 1)
+    FIELD(CD_2, TTB0_LO, 4, 28)
+REG32(CD_3, 12)
+    FIELD(CD_3, TTB0_HI, 0, 19)
+REG32(CD_4, 16)
+    FIELD(CD_4, HAD1, 1, 1)
+    FIELD(CD_4, TTB1_LO, 4, 28)
+REG32(CD_5, 20)
+    FIELD(CD_5, TTB1_HI, 0, 19)
+
+/* Get CD fields */
+#define CD_TSZ(x, sel)   ((sel) ?          \
+    FIELD_EX32((x)->word[0], CD_0, TSZ1) : \
+    FIELD_EX32((x)->word[0], CD_0, TSZ0))
+#define CD_TG(x, sel)    ((sel) ?          \
+    FIELD_EX32((x)->word[0], CD_0, TG1) :  \
+    FIELD_EX32((x)->word[0], CD_0, TG0))
+#define CD_EPD(x, sel)   ((sel) ?          \
+    FIELD_EX32((x)->word[0], CD_0, EPD1) : \
+    FIELD_EX32((x)->word[0], CD_0, EPD0))
+#define CD_ENDI(x)       FIELD_EX32((x)->word[0], CD_0, ENDI)
+#define CD_VALID(x)      FIELD_EX32((x)->word[0], CD_0, VALID)
+#define CD_IPS(x)        FIELD_EX32((x)->word[1], CD_1, IPS)
+#define CD_AFFD(x)       FIELD_EX32((x)->word[1], CD_1, AFFD)
+#define CD_TBI(x)        FIELD_EX32((x)->word[1], CD_1, TBI)
+#define CD_AARCH64(x)    FIELD_EX32((x)->word[1], CD_1, AARCH64)
+#define CD_HD(x)         FIELD_EX32((x)->word[1], CD_1, HD)
+#define CD_HA(x)         FIELD_EX32((x)->word[1], CD_1, HA)
+#define CD_S(x)          FIELD_EX32((x)->word[1], CD_1, S)
+#define CD_R(x)          FIELD_EX32((x)->word[1], CD_1, R)
+#define CD_A(x)          FIELD_EX32((x)->word[1], CD_1, A)
+#define CD_ASID(x)       FIELD_EX32((x)->word[1], CD_1, ASID)
+#define CD_HAD(x, sel)   ((sel) ?                                         \
+    FIELD_EX32((x)->word[4], CD_4, HAD1) :                                \
+    FIELD_EX32((x)->word[2], CD_2, HAD0))
+#define CD_TTB(x, sel)                                                    \
+    ((sel) ? (((uint64_t)FIELD_EX32((x)->word[5], CD_5, TTB1_HI) << 32) | \
+              ((uint64_t)FIELD_EX32((x)->word[4], CD_4, TTB1_LO) << 4)) : \
+             (((uint64_t)FIELD_EX32((x)->word[3], CD_3, TTB0_HI) << 32) | \
+              ((uint64_t)FIELD_EX32((x)->word[2], CD_2, TTB0_LO) << 4)))
 
 /* MMIO Registers */
 
-- 
2.34.1


