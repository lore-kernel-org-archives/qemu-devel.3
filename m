Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1745C71159
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 17:26:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRDb6-00061l-01; Mon, 16 Jun 2025 13:26:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <root@wjsota.com>) id 1uRDRI-0002PK-3K
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 13:16:08 -0400
Received: from p-west1-cluster3-host8-snip4-10.eps.apple.com ([57.103.66.63]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <root@wjsota.com>) id 1uRDRB-0000hp-AV
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 13:16:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wjsota.com; s=sig1;
 bh=evBOl5rbfEcn1En9csBiLwPoXAIPY0sQhp6r0d0a+mY=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=PAcNiDeqDVxQwbss0cDDfUxhyRsyJ0iWIfZfpxotD21zgzI0CLO7LXKPPy5q8gfpD
 0mZgO4rQXubVVZ3FoAb/21Kgxn+oF9IJhn9tif63goD70TbwEEbKx/2EHObenH5X1I
 zdeMtyTaNNcmpzQxEucrPyz/Z9U+CVHmQzbAGuPwGydvLWIgrGr2BykB/6nrtBZbwB
 f3WLqwDZbPtweYGw/uubgA1M/8q0ODwSQWIAdgajmOtGVqfBECipYwDjqujl1FPW1f
 9yT5Bk+qL4iPnYqSN29iPzcRZFcZKcYWjcLl2LS7KbVW+I2ZPOBJh0VDLPPh7m4B4o
 QMnjBcugJYV0Q==
Received: from outbound.pv.icloud.com (localhost [127.0.0.1])
 by outbound.pv.icloud.com (Postfix) with ESMTPS id 7F601180030C;
 Mon, 16 Jun 2025 17:15:54 +0000 (UTC)
Received: from dell-op7020.. (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
 by outbound.pv.icloud.com (Postfix) with ESMTPSA id 3286D1800B55;
 Mon, 16 Jun 2025 17:15:53 +0000 (UTC)
From: Solomon Tan <root@wjsota.com>
To: 
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Solomon Tan <root@wjsota.com>
Subject: [PATCH] target/arm: Make RETA[AB] UNDEF when pauth is not implemented
Date: Tue, 17 Jun 2025 01:15:46 +0800
Message-ID: <20250616171549.59190-1-root@wjsota.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: jyJRFDUagL06QZIPT0DSlFADjHdhK3qA
X-Proofpoint-ORIG-GUID: jyJRFDUagL06QZIPT0DSlFADjHdhK3qA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_08,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=1
 clxscore=1030 malwarescore=0 mlxlogscore=734 mlxscore=0 phishscore=0
 suspectscore=0 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2503310001 definitions=main-2506160115
Received-SPF: pass client-ip=57.103.66.63; envelope-from=root@wjsota.com;
 helo=outbound.pv.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 16 Jun 2025 13:26:15 -0400
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

According to the Arm A-profile A64 Instruction Set Architecture,
RETA[AB] should be decoded as UNDEF if the pauth feature is not
implemented.

Fixes: 0ebbe9021254f ("target/arm: Convert BRA[AB]Z, BLR[AB]Z, RETA[AB] to decodetree")
Signed-off-by: Solomon Tan <root@wjsota.com>
---
 target/arm/tcg/translate-a64.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index ac80f572a2..d0719b5665 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1816,6 +1816,10 @@ static bool trans_RETA(DisasContext *s, arg_reta *a)
 {
     TCGv_i64 dst;
 
+    if (!dc_isar_feature(aa64_pauth, s)) {
+        return false;
+    }
+
     dst = auth_branch_target(s, cpu_reg(s, 30), cpu_X[31], !a->m);
     gen_a64_set_pc(s, dst);
     s->base.is_jmp = DISAS_JUMP;
-- 
2.48.1


