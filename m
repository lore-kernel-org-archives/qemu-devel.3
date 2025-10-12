Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26546CCD184
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Oct 2025 15:16:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7xnm-00046d-OU; Sun, 12 Oct 2025 11:16:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v7xnf-00042C-1C; Sun, 12 Oct 2025 11:16:01 -0400
Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net ([162.243.161.220])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v7xnY-0002nm-QW; Sun, 12 Oct 2025 11:15:54 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwDnxyQhxutoyysrAA--.34862S2;
 Sun, 12 Oct 2025 23:15:45 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwBHq+ggxutocXhMAA--.3043S3;
 Sun, 12 Oct 2025 23:15:45 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>, Tao Tang <tangtao1634@phytium.com.cn>
Subject: [RFC v3 20/21] hw/arm/smmuv3: Initialize the secure register bank
Date: Sun, 12 Oct 2025 23:15:42 +0800
Message-Id: <20251012151542.4131398-1-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251012150701.4127034-1-tangtao1634@phytium.com.cn>
References: <20251012150701.4127034-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwBHq+ggxutocXhMAA--.3043S3
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQABBWjqskUBeAAAsJ
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7tFyDZF1Dur45ZrWrCrWDCFg_yoW8Gr18pa
 9rJwn8Kry5K3WSga9xJw48AF1Iqwsaqr1DZry7KF13A3W5Jr97XrWrKa4rKrZY9rZ8CF4U
 WF1S9rs5ZwsIvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.161.220;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjeumjiw.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Initialize the secure register bank (SMMU_SEC_SID_S) with sane default
values during the SMMU's reset sequence.

This change ensures that key fields, such as the secure ID registers,
GBPA reset value, and queue entry sizes, are set to a known-good state.
The SECURE_IMPL attribute of the S_IDR1 register will be introduced
later via device properties.

This is a necessary step to prevent undefined behavior when secure SMMU
features are subsequently enabled and used by software.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 hw/arm/smmuv3.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index b44859540f..0b366895ec 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -331,6 +331,15 @@ static void smmuv3_init_regs(SMMUv3State *s)
     bk->gerrorn = 0;
     s->statusr = 0;
     bk->gbpa = SMMU_GBPA_RESET_VAL;
+
+    /* Initialize Secure bank */
+    SMMUv3RegBank *sbk = &s->bank[SMMU_SEC_SID_S];
+
+    memset(sbk->idr, 0, sizeof(sbk->idr));
+    sbk->idr[1] = FIELD_DP32(sbk->idr[1], S_IDR1, S_SIDSIZE, SMMU_IDR1_SIDSIZE);
+    sbk->gbpa = SMMU_GBPA_RESET_VAL;
+    sbk->cmdq.entry_size = sizeof(struct Cmd);
+    sbk->eventq.entry_size = sizeof(struct Evt);
 }
 
 static int smmu_get_ste(SMMUv3State *s, dma_addr_t addr, STE *buf,
-- 
2.34.1


