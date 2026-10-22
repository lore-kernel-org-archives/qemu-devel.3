Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6191606A319
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 00:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=Mqq2yDr/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK2gm-0002hy-2v; Thu, 22 Oct 2026 19:59:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xK2gl-0002hZ-2Z
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 19:59:15 -0400
Received: from mr-2003l-snip6-1.eps.apple.com ([2a01:b747:3000:202::72]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xK2gj-00026W-I0
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 19:59:14 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-9 (Postfix) with ESMTPS id
 5F7A21800337; Thu, 22 Oct 2026 23:59:10 +0000 (UTC)
X-ICL-RepId: 01a1660d-e9ec-71e1-ad13-5aa10814eed5
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0PWFsIWwQPH0wMUQJCBVZeVAodBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkIJSgVcB1kAQgpNC1gORQpIDk0AQAJGXx9RGV4IUytHHkkKVgleCEYRWxRWQ1EZDFBNAUMICghHA00XXjJTBF8RUBY=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1792713552; x=1824249552;
 bh=4MtoiGWVHD1ql7ktrdOMb3tf+OVOyyTmcQKxYtuN+0U=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Mqq2yDr/hNrtBJB9b3ymj11g99Rv9T74LnJYfc+4/U1k1uzAGXL1H0YWMm2rvazDfqhQH+KS1LdacPmrYIm1xV/BVixch41Ut9vHZa/ewrdxQ/fXLGhUEgHlnZ5O0trmNSicJq8l7G08QKzaXKusyvgjd7qZogBDDBzR5utK6qE1FPA11IlmQ8MUGhsIIU3jZKfUaXAl46ZMZeqFhFiIaxn3rJkb3hi8j/lp41FSVY/X2FuVERebqYfFNX9R93oiFmUS8NtyPVrH67r6xPF0+UgdsuCH2B2+7UCYV7HfyZyx6BDa+SZ6k3+7H837/mvskdJLdKtFRGGLRWuNX/g2pA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.156.200.36])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-9 (Postfix) with ESMTPSA id
 9D10918000B2; Thu, 22 Oct 2026 23:59:08 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH 04/11] whpx: i386: fix TPR encodings for local APIC
Date: Fri, 23 Oct 2026 01:58:52 +0200
Message-ID: <20261022235859.88753-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261022235859.88753-1-mohamed@unpredictable.fr>
References: <20261022235859.88753-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA5NSBTYWx0ZWRfX3c5s3ZM5Vc9z
 5B7gD6wh1gHHgbDjsRwTlFwMDmK5w4tFSFdBoXsQZM5G+l21AoqWdtes9Jz+Ch7m6QVucxQFFu+
 HtrESemsDUTxXFlr7HlNus5BQmk18VFYrPDfeJLY8VS4h06dDmFOoYaOnLlMiMM2OHMMfou5I3o
 a1RiESfT0CaNtGWIrmh3Ri4GRXu4bqbyR+/qK50oaBP2qvZ93SUCj5yt1umdv9JC730k9OY8OKT
 A9aYvysSN+n+Hu+99jeL3ZMC69BQc110yAHwhaZTeT7MuctD/co5R4ABSTQlhdPFh/mGKZ39ybH
 DnzEFDl2RrX+WFI5FxskTS5myXMwIu6m1HEWy4ZBANmTclQLehv1KUWMjYjFso=
X-Authority-Info-Out: v=2.4 cv=BqSQAIX5 c=1 sm=1 tr=0 ts=6adaa34e
 cx=c_apl:c_pps:t_out a=9mRn2PO/+PIrVdEbaIuMPg==:117
 a=9mRn2PO/+PIrVdEbaIuMPg==:17 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=YYz-tg3MKeN3tcD12NcA:9
X-Proofpoint-GUID: jlKHh7aTADjelRTIT8xFTU929dTQCPhC
X-Proofpoint-ORIG-GUID: jlKHh7aTADjelRTIT8xFTU929dTQCPhC
X-JNJ: AAAAAAAB9yzKMEuZXJsElmi0YL89QX0J996xSrp5PZ5oSzba8g8AsyO97ngP3q9ME0L2ylWh/l8Bd2YvdBGpLlh4EuzXUBGrL2vIf1xoU9bAtuP9iUlABFEu1QuzYQK1b44zYIdS4mn3yTpHDFNFHDRay9VmaK+dROUj/xVcU82QbBJSpVoIm9J8X0ZHLYihEBiMIAjut+incubeueXFsfQON/lI5xMhbI2gjeRSJ+sKGe0xEMl2kbR2OjzhVzH6lAHTEupzzCXiWQAGcfOXcUYCmCx8p8k5lsAIKVD6B27wiU0DKjtsT/bs5bDruu4BQolqqogi5tFrS+RyaeXA3jKCW/DfkePonqeid9w5BMjUJ4CIv4qVuNbvxdMw+I6BFmmfUEqIIEkwu2SCqN0oWUG3N6hzG5IYJoIO0RJFH8TQUnoIu+YYrRZrb1O33LUb9aVxpklW2wf9orq7CCtCU/PQ1xuAS6q36SU1VkJ12htNFEYz4ChY3hMrXXiyXC321+ZOvEo6jWdConx6Yg5t4hz2oncP/z8FDm0yYwBR4DTNsKlf4+7awUx6hMzelfuOZ4MXrp+0lvWwVvFiicglriv1FkHFjnE1jdKLj+pYA0BcYcRoAedG8G9fHtyTU73yM0Rp/uCVVTFuecrfmEMm1LWy9K3pz8/juc/APmDn5oh7wiZIva1Ts9ro8jezm8JxDVk4eop2G2Gybngwck2KpyHTCqszN6ivcYtkV00WlTbGupP1NjPvDloQTBqq3IsBW+mNC0Q89tP1KkehBBKJQn9jKYKaGq38hVGEvPr9AgELH7Q=
Received-SPF: pass client-ip=2a01:b747:3000:202::72;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Convert between the TPR and the APIC priority encodings.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-apic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/whpx/whpx-apic.c b/target/i386/whpx/whpx-apic.c
index efdedbcd77..2d83291fae 100644
--- a/target/i386/whpx/whpx-apic.c
+++ b/target/i386/whpx/whpx-apic.c
@@ -184,12 +184,12 @@ static void whpx_put_apic_base(CPUState *cpu, uint64_t val)
 
 static void whpx_apic_set_tpr(APICCommonState *s, uint8_t val)
 {
-    s->tpr = val;
+    s->tpr = (val & APIC_PR_SUB_CLASS) << APIC_PR_CLASS_SHIFT;
 }
 
 static uint8_t whpx_apic_get_tpr(APICCommonState *s)
 {
-    return s->tpr;
+    return s->tpr >> APIC_PR_CLASS_SHIFT;
 }
 
 static void whpx_apic_vapic_base_update(APICCommonState *s)
-- 
2.54.0 (Apple Git-157)


