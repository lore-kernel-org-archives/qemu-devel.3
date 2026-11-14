Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F6E606A329
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:19:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSGT1-0007bd-UU; Sat, 14 Nov 2026 11:19:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1xSGSD-00078W-Gk; Sat, 14 Nov 2026 11:18:22 -0500
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1xSGS8-0003EO-7F; Sat, 14 Nov 2026 11:18:13 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with UTF8SMTP id AQAAfwA3jdy7ifhqOBoGAg--.53541S2; 
 Sun, 15 Nov 2026 00:18:03 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8DwOHSyifhq4Nv6AA--.29617S11;
 Sun, 15 Nov 2026 00:18:02 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Mostafa Saleh <smostafa@google.com>,
 Chao Liu <chao.liu@processmission.com>,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Jim MacArthur <jim.macarthur@linaro.org>,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: [PATCH v6 18/35] hw/arm/smmuv3: Fix VMID tagging for Secure stage 1
Date: Sun, 15 Nov 2026 00:17:52 +0800
Message-Id: <20261114161753.3645568-9-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261114154623.3599750-1-tangtao1634@phytium.com.cn>
References: <20261114154623.3599750-1-tangtao1634@phytium.com.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DwOHSyifhq4Nv6AA--.29617S11
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQATBWr3ZUsBfAACsb
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvdXoWrtw4xZFWUKFyrZryrWrykXwb_yoWDKrg_ua
 18twn3Wr4kAr9xXFs2krs3t3W0934kJF4xW3W0qa129F9rGFyUGwnrX3ykZr1fZFW5WFnI
 ywsxWr43Jwn2gjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrnU
 Uv73VFW2AGmfu7jjvjm3AaLaJ3UjIYCTnIWjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUUUU
 UUUU=
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With Non-secure S2P set and Secure SEL2 clear, decode_ste() tags Secure
stage-1 entries with STE.S2VMID, while CMD_TLBI_NH_ASID matches -1.
The mismatch can leave stale translations cached in the IOTLB.

Use the internal no-VMID value -1 for Secure stage-1 entries, keeping
Non-secure VMID handling unchanged.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 hw/arm/smmuv3.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index fc5cd46d1a8..93d5b900806 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -643,11 +643,11 @@ static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
         goto bad_ste;
     }
 
-    if (STAGE2_SUPPORTED(s)) {
-        /* VMID is considered even if s2 is disabled. */
+    if (STAGE2_SUPPORTED(s) && !smmu_sec_sid_is_secure(sec_sid)) {
+        /* VMID is considered even if Non-secure stage 2 is disabled. */
         cfg->s2cfg.vmid = STE_S2VMID(ste);
     } else {
-        /* Default to -1 */
+        /* No VMID tagging without stage 2 in this Security state. */
         cfg->s2cfg.vmid = -1;
     }
 
-- 
2.34.1


