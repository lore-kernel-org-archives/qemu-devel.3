Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96EC606A32E
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:17:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSGQa-0004hL-Pn; Sat, 14 Nov 2026 11:16:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1xSGQQ-0004bw-6j; Sat, 14 Nov 2026 11:16:25 -0500
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1xSGQN-0003AD-TD; Sat, 14 Nov 2026 11:16:21 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with UTF8SMTP id AQAAfwBXX59Rifhqf1MqBg--.44256S2; 
 Sun, 15 Nov 2026 00:16:17 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8Dw43NPifhq0tv6AA--.29160S3;
 Sun, 15 Nov 2026 00:16:15 +0800 (CST)
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
Subject: [PATCH v6 07/35] hw/arm/smmuv3: Reject Secure STEs with stage-2
 enabled
Date: Sun, 15 Nov 2026 00:16:15 +0800
Message-Id: <20261114161615.3642821-1-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261114154623.3599750-1-tangtao1634@phytium.com.cn>
References: <20261114154623.3599750-1-tangtao1634@phytium.com.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dw43NPifhq0tv6AA--.29160S3
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQATBWr3ZUsBawAAsO
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7uFW5ur1kJr4fAr18WF1kGrg_yoW8WF13pr
 4DGwsYgr4ftF9avFsxZ3y8Za98Wa97Jr97GFy2k3s3AFWqvr1Utr1qka45K3sxurySyFyj
 qayIvFyDZw4UA37anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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

Pass sec_sid into decode_ste() and treat a Secure STE that enables stage-2
translation as an illegal STE.

The current model does not implement Secure stage-2 translation, so reject
Secure STE configurations that enable stage 2 and report BAD_STE. This
restriction can be relaxed when SEL2 and Secure stage-2 support are
implemented.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 hw/arm/smmuv3.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 06684f07242..a5210d845a3 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -596,7 +596,7 @@ static void decode_ste_config(SMMUTransCfg *cfg, uint32_t config)
 
 /* Returns < 0 in case of invalid STE, 0 otherwise */
 static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
-                      STE *ste, SMMUEventInfo *event)
+                      STE *ste, SMMUEventInfo *event, SMMUSecSID sec_sid)
 {
     uint32_t config;
     /* OAS field only presents on NS-IDR5 so we use hardcoded SMMU_SEC_SID_NS */
@@ -650,6 +650,11 @@ static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
         if (ret) {
             goto bad_ste;
         }
+
+        /* The model does not support Secure stage-2 translation. */
+        if (sec_sid == SMMU_SEC_SID_S) {
+            goto bad_ste;
+        }
     }
 
     /* Multiple context descriptors require SubstreamID support */
@@ -915,7 +920,7 @@ static int smmuv3_decode_config(IOMMUMemoryRegion *mr, SMMUTransCfg *cfg,
         return ret;
     }
 
-    ret = decode_ste(s, cfg, &ste, event);
+    ret = decode_ste(s, cfg, &ste, event, sec_sid);
     if (ret) {
         return ret;
     }
-- 
2.34.1


