Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E2E3F4613F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 22:36:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4nrN-0005xd-4T; Mon, 23 Mar 2026 18:34:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w4nrL-0005xM-Pa
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 18:34:55 -0400
Received: from qs-2006k-snip4-7.eps.apple.com ([57.103.85.238]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w4nrK-0002vr-HM
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 18:34:55 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPS id
 BE3C81800247; Mon, 23 Mar 2026 22:34:51 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774305293; x=1776897293;
 bh=p3kP/TgGy9+75EyKQX7zRo14kGVxvhzT6oqhUrcGhLI=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Aij1PmX7jd2pdyDwc+vp+JcbG0cMj4YKgAfZWqjv4I2NIeEDftfFykRv3Vq6rx0yYnoLisOtOsIkEJZCEM21Wy4B21LPJSi/rrY5hKjPW8z7cSJ+sOwzsdLBaRzgUISDKWTex0eHL64YBEcmP4mHAwY40CMCw3L/ttEnB3pmd/ebiqk3g6eiThxqTW6wG0xh3tkjeWMSkguRmrmw6o59nX1ysXoV1d2cmBhqpD0qJdy1PrtJ5F/NwsKu+p9DrTdjSy6kqNxvCfQJXRFD7CyiHshBnI/GdcCIqITwwwJRZkEznEax0rvXNhSLO4xqRLKek/VS3xcPHuXpQpoIrTtaig==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPSA id
 8BB791800157; Mon, 23 Mar 2026 22:34:49 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>, Wei Liu <wei.liu@kernel.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v2 04/13] whpx: i386: skip XCRs read for MMIO exits
Date: Mon, 23 Mar 2026 23:34:25 +0100
Message-ID: <20260323223434.81780-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260323223434.81780-1-mohamed@unpredictable.fr>
References: <20260323223434.81780-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: vJUhQHvTtpMhkQ8BJlz1czl2LjkTx6pa
X-Proofpoint-ORIG-GUID: vJUhQHvTtpMhkQ8BJlz1czl2LjkTx6pa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE2NiBTYWx0ZWRfX2X8gBG5p701Q
 PnrdGnvhpKzyjgasoIwRAk5ggkSH+X3ZrJIBBK/M2mlPVVOt4Xr9yKUNpqjQBMk94C1uuf76Hvo
 cnWfYm27s/Blv25C0UYhhLCQxN8Z77sCcyJ4w0QchU6ZU8AB0JeRD5WAwvWNPmpA3YontaO9lbG
 jtGIsmHxQZs7pGgCv8bBnny21pl0zVTfjseh5BDig6FlbJ8dK/hzPTsBXBDAJYZYMe5vJlQ6QSg
 9EPVyPUyO8ASK8Gox5RAWZMz3HCsl25vpWadQ6Z+T2w7CdtckDmtsMfknwA9CIyIqzl7PdDfcK/
 MEif8raOa+5L7O6I6iNezWxS5qQTffz0jop/5ppXIHx6qgj0Zoch3XB2uXdDYE=
X-Authority-Info-Out: v=2.4 cv=T5yBjvKQ c=1 sm=1 tr=0 ts=69c1c00c
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=ytqdvofJqIjuNepkJhYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_06,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1030 mlxlogscore=761 spamscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603230166
Received-SPF: pass client-ip=57.103.85.238;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The XCR0 value isn't currently needed for vmexit processing.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index ac03445d9d..c0c7ba9177 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -689,7 +689,9 @@ void whpx_get_registers(CPUState *cpu, WHPXStateLevel level)
      * Extended control registers needs to be handled separately depending
      * on whether xsave is supported/enabled or not.
      */
-    whpx_get_xcrs(cpu);
+    if (level > WHPX_LEVEL_FAST_RUNTIME_STATE) {
+        whpx_get_xcrs(cpu);
+    }
 
     /* 16 XMM registers */
     assert(whpx_register_names[idx] == WHvX64RegisterXmm0);
-- 
2.50.1 (Apple Git-155)


