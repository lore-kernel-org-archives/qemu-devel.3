Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C8E3C624D6
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 04:03:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1yeV-0003dq-AY; Thu, 03 Sep 2026 00:02:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1x1yeT-0003cX-EM
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 00:02:13 -0400
Received: from mr-2004a-snip6-7.eps.apple.com ([2a01:b747:3000:203::8]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1x1yeQ-0000Py-4J
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 00:02:13 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-10 (Postfix) with ESMTPS id
 3717518002AE; Thu, 03 Sep 2026 04:02:04 +0000 (UTC)
X-ICL-RepId: 01a0656e-52e9-78b4-9eb0-cd0a6c3252ad
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0OWFsIWwQPH0wMUQJCBVZeVAodBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkIJSgVdDlsBQA1IAlgARQVED0oEQAVGXx9RGV4IUytHHkkKVgleCEYRWxRWQ1EZDFBNAUMICghHA00XXjJTBF8RUBY=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1788408127; x=1791000127;
 bh=w/0h1F7lLj4GVLQTQQjPrUbmnfLN71VsnNwG2wgM5J0=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Ad2Ay/cKXNC0UxC7oM17xtS4cQ7v0jzc4nmFlaRvMfR8HIkp1CkNUDYmzAmP8VPIb9z185ofoBmeN0mSW+YibTHZjWT1pnB+5IL0nJh6dZf5qKgaJcs7OHhW6QpmxzZsO96qgkxJt9a3Sb74KZ38lnBODXU72mQtGWW/FbpmsuxEjBmJjBuzxOjaXKA36BYsAg0QSt3O8jIlEog8/YdmihGzf1u8D6ZwHuwnIHoF5sphrNPhU0ZFaf1UQDqeldoUkDGFrvCvSBi/T1mCnu7vOsYEWyBcIdsKF6ZONtL+S0IRV2SI6Y3aE9NwVSzO5IaFPm7kaS36U4yjT2JYKGbkaw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.156.200.36])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-10 (Postfix) with ESMTPSA id
 2433E18001C9; Thu, 03 Sep 2026 04:02:01 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>,
 Alexander Graf <agraf@csgraf.de>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH 1/3] hvf: arm: advertise ID_AA64PFR0_EL1.GIC
Date: Thu,  3 Sep 2026 06:01:55 +0200
Message-ID: <20260903040157.74627-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260903040157.74627-1-mohamed@unpredictable.fr>
References: <20260903040157.74627-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: f8E-sWt9joomc3_vqKfQXnPXND9p7w8w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDAzMyBTYWx0ZWRfXwX+1qyA3BiVL
 3vovdZfm0etIsMvVOV/5FKxJILRKyBtprrpkmDBYd6bgXOBZwN5USqZbsbWGBJV5ITSp15Bqkq4
 kkiMXot48X46sHnIimk+k998i6XnlZhPCO3CUxI/M3np/pzboNR3nITSBmtTTtSKDGCZy22c2TX
 hzpHGQT5r0CX3/zm5ixmE/ddwRztJsF/ePuVhpf6171JOZCuudiKr0u9bnk96ASEl/22ynxMlCe
 4+vug4lEDtkJwmkYbRm6ikrHfXx2H+JPlcAcLuJhENgEzdobpzRHnN7F2hFmrLihZfAaUPkpIGE
 0jfbslHpGcp169RHUdjX7S5NjC+5kYzkVvMuXPwgEotx1Hb06Abjnw5smB0FGI=
X-Authority-Info-Out: v=2.4 cv=DPSCIiNb c=1 sm=1 tr=0 ts=6a98f13c
 cx=c_apl:c_pps:t_out a=9mRn2PO/+PIrVdEbaIuMPg==:117
 a=9mRn2PO/+PIrVdEbaIuMPg==:17 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=PxskMMFkHs8dM-QmR_QA:9
X-Proofpoint-ORIG-GUID: f8E-sWt9joomc3_vqKfQXnPXND9p7w8w
X-JNJ: AAAAAAABA/rgA+nFyC6L3NILznoZajptUklH1nK4pNM/ooMLcxhDJUbUDCmyYNXiUoscelDWI+SrNHNRLLXNTlaFVVGkJpJMlrPyV2fnsb7664pTpPaDgXe+wS5oWDqHdKD2qkUkKYAxEBiz5rF01PxGCNJdFj7ggaS0s4O5Te9IrBgV3WjjWGHcAa33GnolgcOqoL++/4VJ6YfDA1NvYQXjG/nO9EfkrPLw0LBTmucTCbp7jv9lC5QGbmAUDBwOf5L+0rMHWJ6W+fSImQ3y/wLmnH6I/a5AKwqPXZAbaJfzK45L8AyJb4WONNnlxk1w5WhGR3ze4bSX1wtgGGUBY9w4Qygox0/bv1usCbWuprOCxGZO0Tb84OXLhbL3YQbe89qnRP2PBTnmqMm2uFcoboZoFJwazWdlnP0l2Z4Q5k8xuPVVtQ6G2OzwL8ubmf2saj5eqMyN25ubp4wCkmb2fMlg23TrH5QCAP06l6JF+jYZKvKwQHtTPR7NsKG6duvbiKqafpKdkEPc81ZPXiSo6tD4rw+TqnUdxl87FxvWIFI7XDRD6Jor4HvGhssACzauLmbxphq3Gv+UZdZlp23N/Z2LLT/Yt/yLq5N8Nshg/XFmJ9u7EGVkzGZuXgfVEWudXaXH+K2bZpdnpo8LkQULXRKJYBwzyDFs/Z/XGYRaVZSDwWHhnQy/055NlS+fqS7+KyuvRbKlOmYOiT03Gt8PopVfd1QHvcEqmHymlRo/3lOwp6my9QL5R6zcs2+1QiyqPE9zdGwODhyot1UGwcaPCX5JgL9w6yfawM9iDA8/7CSpxn7uWzdrODJ/
Received-SPF: pass client-ip=2a01:b747:3000:203::8;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
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


