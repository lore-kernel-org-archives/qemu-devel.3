Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0AD1E74908
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 03:48:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYFqN-0008PO-R2; Tue, 23 Dec 2025 22:47:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vYFqL-0008Nu-BC; Tue, 23 Dec 2025 22:47:21 -0500
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vYFqJ-0007t3-Fo; Tue, 23 Dec 2025 22:47:21 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwAnL5tEYktp8rxUBA--.611S2;
 Wed, 24 Dec 2025 11:47:16 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwAXce4yYktpv0wOAA--.32229S8;
 Wed, 24 Dec 2025 11:47:09 +0800 (CST)
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
Subject: [RFC v8 5/7] hw/arm/smmuv3-common: Add STE/CD set helpers for
 repeated field setup
Date: Wed, 24 Dec 2025 11:46:45 +0800
Message-Id: <20251224034647.2596434-6-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251224034647.2596434-1-tangtao1634@phytium.com.cn>
References: <20251224034647.2596434-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwAXce4yYktpv0wOAA--.32229S8
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAOBWlK96sBqwAAsf
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxuF43Cr4kJrWkWry3ZrWxCrg_yoWrKr47pr
 yxAryDXw17CF12kw1fJF4UKFsxZrn2q34DGryxKrsrC3ZxJrn7WFZ7KFWrJFyUuanYqFy0
 krsIgrWUWa9rCrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=209.97.181.73;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmja5ljk3lje4ms43mwaa.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This change introduces STE_SET_* and CD_SET_* helpers to centralize and
simplify repeated field setting logic.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/hw/arm/smmuv3-common.h | 79 ++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/include/hw/arm/smmuv3-common.h b/include/hw/arm/smmuv3-common.h
index 7f7dd02221..0c6c162288 100644
--- a/include/hw/arm/smmuv3-common.h
+++ b/include/hw/arm/smmuv3-common.h
@@ -100,6 +100,37 @@ REG32(STE_7, 28)
 #define STE_CFG_ABORT(config)      (!(config & 0x4))
 #define STE_CFG_BYPASS(config)     (config == 0x4)
 
+/* Update STE fields */
+#define STE_SET_VALID(ste, v)                                                 \
+    ((ste)->word[0] = FIELD_DP32((ste)->word[0], STE_0, VALID, (v)))
+#define STE_SET_CONFIG(ste, v)                                                \
+    ((ste)->word[0] = FIELD_DP32((ste)->word[0], STE_0, CONFIG, (v)))
+
+#define STE_SET_CTXPTR(ste, v) do {                                           \
+    (ste)->word[0] = FIELD_DP32((ste)->word[0], STE_0, CTXPTR_LO, (v) >> 6);  \
+    (ste)->word[1] = FIELD_DP32((ste)->word[1], STE_1, CTXPTR_HI, (v) >> 32); \
+} while (0)
+#define STE_SET_S2T0SZ(ste, v)                                                \
+    ((ste)->word[5] = FIELD_DP32((ste)->word[5], STE_5, S2T0SZ, (v)))
+#define STE_SET_S2SL0(ste, v)                                                 \
+    ((ste)->word[5] = FIELD_DP32((ste)->word[5], STE_5, S2SL0, (v)))
+#define STE_SET_S2TG(ste, v)                                                  \
+    ((ste)->word[5] = FIELD_DP32((ste)->word[5], STE_5, S2TG, (v)))
+#define STE_SET_S2PS(ste, v)                                                  \
+    ((ste)->word[5] = FIELD_DP32((ste)->word[5], STE_5, S2PS, (v)))
+#define STE_SET_S2AA64(ste, v)                                                \
+    ((ste)->word[5] = FIELD_DP32((ste)->word[5], STE_5, S2AA64, (v)))
+#define STE_SET_S2ENDI(ste, v)                                                \
+    ((ste)->word[5] = FIELD_DP32((ste)->word[5], STE_5, S2ENDI, (v)))
+#define STE_SET_S2AFFD(ste, v)                                                \
+    ((ste)->word[5] = FIELD_DP32((ste)->word[5], STE_5, S2AFFD, (v)))
+#define STE_SET_S2S(ste, v)                                                   \
+    ((ste)->word[5] = FIELD_DP32((ste)->word[5], STE_5, S2S, (v)))
+#define STE_SET_S2TTB(ste, v) do {                                            \
+    (ste)->word[6] = FIELD_DP32((ste)->word[6], STE_6, S2TTB_LO, (v) >> 4);   \
+    (ste)->word[7] = FIELD_DP32((ste)->word[7], STE_7, S2TTB_HI, (v) >> 32);  \
+} while (0)
+
 /* CD fields */
 
 REG32(CD_0, 0)
@@ -169,6 +200,54 @@ REG32(CD_5, 20)
              (((uint64_t)FIELD_EX32((x)->word[3], CD_3, TTB0_HI) << 32) | \
               ((uint64_t)FIELD_EX32((x)->word[2], CD_2, TTB0_LO) << 4)))
 
+/* Update CD fields */
+#define CD_SET_VALID(cd, v)                                                   \
+    ((cd)->word[0] = FIELD_DP32((cd)->word[0], CD_0, VALID, (v)))
+#define CD_SET_ASID(cd, v)                                                    \
+    ((cd)->word[1] = FIELD_DP32((cd)->word[1], CD_1, ASID, (v)))
+#define CD_SET_TTB(cd, sel, v) do {                                           \
+    if (sel) {                                                                \
+        (cd)->word[4] = FIELD_DP32((cd)->word[4], CD_4, TTB1_LO, (v) >> 4);   \
+        (cd)->word[5] = FIELD_DP32((cd)->word[5], CD_5, TTB1_HI, (v) >> 32);  \
+    } else {                                                                  \
+        (cd)->word[2] = FIELD_DP32((cd)->word[2], CD_2, TTB0_LO, (v) >> 4);   \
+        (cd)->word[3] = FIELD_DP32((cd)->word[3], CD_3, TTB0_HI, (v) >> 32);  \
+    }                                                                         \
+} while (0)
+
+#define CD_SET_TSZ(cd, sel, v)                                                \
+    ((cd)->word[0] = (sel) ? FIELD_DP32((cd)->word[0], CD_0, TSZ1, (v)) :     \
+                             FIELD_DP32((cd)->word[0], CD_0, TSZ0, (v)))
+#define CD_SET_TG(cd, sel, v)                                                 \
+    ((cd)->word[0] = (sel) ? FIELD_DP32((cd)->word[0], CD_0, TG1, (v)) :      \
+                             FIELD_DP32((cd)->word[0], CD_0, TG0, (v)))
+#define CD_SET_EPD(cd, sel, v)                                                \
+    ((cd)->word[0] = (sel) ? FIELD_DP32((cd)->word[0], CD_0, EPD1, (v)) :     \
+                             FIELD_DP32((cd)->word[0], CD_0, EPD0, (v)))
+#define CD_SET_ENDI(cd, v)                                                    \
+    ((cd)->word[0] = FIELD_DP32((cd)->word[0], CD_0, ENDI, (v)))
+#define CD_SET_IPS(cd, v)                                                     \
+    ((cd)->word[1] = FIELD_DP32((cd)->word[1], CD_1, IPS, (v)))
+#define CD_SET_AFFD(cd, v)                                                    \
+    ((cd)->word[1] = FIELD_DP32((cd)->word[1], CD_1, AFFD, (v)))
+#define CD_SET_TBI(cd, v)                                                     \
+    ((cd)->word[1] = FIELD_DP32((cd)->word[1], CD_1, TBI, (v)))
+#define CD_SET_HD(cd, v)                                                      \
+    ((cd)->word[1] = FIELD_DP32((cd)->word[1], CD_1, HD, (v)))
+#define CD_SET_HA(cd, v)                                                      \
+    ((cd)->word[1] = FIELD_DP32((cd)->word[1], CD_1, HA, (v)))
+#define CD_SET_S(cd, v)                                                       \
+    ((cd)->word[1] = FIELD_DP32((cd)->word[1], CD_1, S, (v)))
+#define CD_SET_R(cd, v)                                                       \
+    ((cd)->word[1] = FIELD_DP32((cd)->word[1], CD_1, R, (v)))
+#define CD_SET_A(cd, v)                                                       \
+    ((cd)->word[1] = FIELD_DP32((cd)->word[1], CD_1, A, (v)))
+#define CD_SET_AARCH64(cd, v)                                                 \
+    ((cd)->word[1] = FIELD_DP32((cd)->word[1], CD_1, AARCH64, (v)))
+#define CD_SET_NSCFG(cd, sel, v)                                              \
+    ((sel) ? ((cd)->word[4] = FIELD_DP32((cd)->word[4], CD_4, NSCFG1, (v))) : \
+             ((cd)->word[2] = FIELD_DP32((cd)->word[2], CD_2, NSCFG0, (v))))
+
 /* MMIO Registers */
 
 REG32(IDR0,                0x0)
-- 
2.34.1


