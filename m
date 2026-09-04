Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDFA1C79F80
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 04:38:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Lgc-0003lk-4q; Fri, 04 Sep 2026 00:37:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1x2Lgb-0003kU-2e
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 00:37:57 -0400
Received: from pv-2001b-snip6-11.eps.apple.com ([2a01:b747:3003:200::15]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1x2LgY-0003in-Ms
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 00:37:56 -0400
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-11 (Postfix) with ESMTPS id
 B57C618000E3; Fri, 04 Sep 2026 04:37:48 +0000 (UTC)
X-ICL-RepId: 01a06ab5-67fd-7bd0-92f9-5931be412536
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0OWFsIWwQPH0wMUQJCBVZeSQ4dBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkIJSgVdDlsGQA1LBFkFRQtGD0kAQAVGXx9RGV4IUytHHkkKVgleCEYRWxRWQ1EZDFBNAUMICghHA00XXjJTBF8RUBY=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1788496670; x=1791088670;
 bh=w/0h1F7lLj4GVLQTQQjPrUbmnfLN71VsnNwG2wgM5J0=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Ekis5jYi9y6eE1ZUqOpTDEUWg92HpG9P5ttQJMR9pm2KY1zForpmhczhZzgElEPMBFSvYMrWJinDhV2I7OL27t9bGgh+MQyZBcRdxpx9skKEBmx2gqXJZVTYP7lb+ov5rc3MVqH/vT8IL0kbTD9dVTiMa0muzRQgPXxZpObU34jdBWys1TGO7dC9dqfIYk79wFM3D8ZOOO5E6Ne+wHLz1yuHBK9P3zrK6Caoh05DAfTOyxHbNS96RdbXBokfBGWjyQYBo53UhhacV/ZAhMz48MRF/yvwyPRb6Eqn5Ws1BgRismfCZRYm3VHtiv2TeL3k84pw1fIqvAHFA+tbxYvrSA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.156.192.29])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-11 (Postfix) with ESMTPSA id
 C109B18000D0; Fri, 04 Sep 2026 04:37:46 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v2 1/5] hvf: arm: advertise ID_AA64PFR0_EL1.GIC
Date: Fri,  4 Sep 2026 06:37:38 +0200
Message-ID: <20260904043742.96613-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260904043742.96613-1-mohamed@unpredictable.fr>
References: <20260904043742.96613-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA0MSBTYWx0ZWRfX7a8qAZJWHick
 5uN5v7M1Q3sC9u4c9QWgVL8GUc/xJhWDz/MMB0EAyZkDIfh5qCNOXPXRKABf6ky4E6fCTot3u0a
 L90gdL/tgKnUWABLJocXmtjfoyodSvwoJkBJ6PNgg8AS4NN1dc+KlzENe8IBkPLygVzZfLDj4gF
 admZqrrV46zSGQWXakwPcZO1z/+P7+xOdQXBj+huPmM/H/DQDSTGfvs3cQ1Gh1C9HPN8Zz6nWvh
 njVdqQqSg4uZArPKFpQ0Xj3/7fuJB/eamiPfziqD0MCqkTecXseKH4rszJyyUp2docHgQHVY1gc
 KFxbUtmLJRISkBpm0AUOVA+UARcjsJ4Ifeo+aEo346BTHizUHjCZnG5jU38nOA=
X-Authority-Info-Out: v=2.4 cv=L98QguT8 c=1 sm=1 tr=0 ts=6a9a4b1d
 cx=c_apl:c_pps:t_out a=aW9mcIavGNWWFvFFKOxBSA==:117
 a=aW9mcIavGNWWFvFFKOxBSA==:17 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=PxskMMFkHs8dM-QmR_QA:9
X-Proofpoint-GUID: eGZUGH6g_xW4fGpbsjZKjf90SAMyRelw
X-Proofpoint-ORIG-GUID: eGZUGH6g_xW4fGpbsjZKjf90SAMyRelw
X-JNJ: AAAAAAABjv/OGCgs6OqNvW7UDHBPRS0UPqGu5waoN64aCgt9YPlNTDYYq+TzK7BOFXhzOnHNlSVljvOexOHH9nYzB3sug77AbZuOZzDVUE6nqyO6tIZKvAuGePORNw5wuXexbH7Sy0eWXvVu/9Pzq+dWga0PMyuDYGupMPlcwolEZKylQcwK5+AnV1odSRwRhSJIw5qek7E/+dhQipGxN+sY5ySIHR6DyV1qYldeUI8pcE36R1n21ui5PkUDiPS1DVyFtKszYMhDDDyFtfGZ4QbgUJPlLdeN2pxvSRyHYV/xZA5+cGmciWtbGzLRBwYM3fQ8BSYCixIt/BQk3EiPOFreSHOh4rH7zFe9Q8pqvr7a7/xCtuCnKbpxY9zyuiLMdL9cYSc1rsf1Al6KCfkOpGC7T+XJ2ce2HW5h2UP3Pz4293QANUDnWrGT5TFMsKbkqetHLnMG0Y3ixj/0KHglwIz/pUfQETnn5ra9i9beiVBzGRObPNIrePDLJYCH7wBHgSqUgkfyTaDOnuiEnCTuJkd6hdTQqdCFS8A/85iNGwRfqrC6YdkZ7/gUipH8n2aKQPMtSZHvK68PumIIhbmJLD+ozGDN7dU8B0NImbaizFvw5pivHE9CKTe/cjN2mo78Yf+QNGzVKs2YVlT8bc5PC7oMDfzcLDzvCSNzfQryhBMATUPsABzvZvXJUhvtNYFiGtsAjrJ75y5r8PIWcy267la6I6OmJxmDbttFyAG27MQTAinX+bsM8eMeVefM1QanP3bO14GmUIETdn1B7omkIzIhcf5842dSourNfIq6ZDTexBpiRJVsqpqLE9mequU/AGwXs43q
Received-SPF: pass client-ip=2a01:b747:3003:200::15;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

For the kernel-irqchip=on case, advertise ID_AA64PFR0_EL1.GIC.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/hvf/hvf.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index da3ec521fc..f881d6cc67 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1229,6 +1229,18 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
         FIELD_DP64_IDREG(&host_isar, ID_AA64PFR1, SME, 0);
     }
 
+    /*
+     * On HVF, kernel-irqchip implies GICv3.
+     * The kernel-irqchip=off,gic-version=3 legacy case also supports
+     * the host CPU interface but advertising it in ID_AA64PFR0_EL1
+     * is not implemented yet.
+     */
+
+    if (hvf_irqchip_in_kernel()) {
+        /* Advertise the GIC system register interface */
+        FIELD_DP64_IDREG(&host_isar, ID_AA64PFR0, GIC, 1);
+    }
+
     ahcf->isar = host_isar;
 
     /*
-- 
2.54.0 (Apple Git-156)


