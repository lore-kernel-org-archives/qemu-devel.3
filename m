Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D7A10F6FDB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 22:08:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w83j7-0005sr-Oj; Wed, 01 Apr 2026 18:07:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w83im-0005Ls-Hk
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 18:07:33 -0400
Received: from p-east2-cluster5-host10-snip4-10.eps.apple.com ([57.103.79.123]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w83il-0002RR-62
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 18:07:32 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-7 (Postfix) with ESMTPS id
 A84CF1800377; Wed, 01 Apr 2026 22:07:25 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1775081247; x=1777673247;
 bh=0EBl2c3EMdJKzsEMuWPBcmVOioLhROJBtQLtLoE9Yeg=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=E4VBFS6TdtC0rk3mtvQ+89nwRZFn9C+a+jsbJmAhRlvMyqnxe373ROqz6HHVu1ZrjXyRMPRTu/JrnU1ROqPxbf8d87MWugXiQPWGLUBt4Ori9sGjJpq+MByNndUBYpPsJMZ1zh6N920Y54c9RhWTRj3KqTiHDhFjIFxPFUV9tVsKCRW0ygnpBS1mVyjTN8a2plQmYMnxLwlz5FFUOKYj/4GUzkjkkPDEOGvvrObMDRXwYabSKHe6M0w0wKrNq3mzGDlc5wCSc+fzCRyg5Lb19OJ0rTm3idF0KwLpxiKL9LrSjl8VTGC3vHDY1+xxIIvcYQi1xWkUF8TemxXbtbkYkA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-7 (Postfix) with ESMTPSA id
 92748180058A; Wed, 01 Apr 2026 22:07:23 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH] target/arm: cpu: add HCR_E2H on reset for EL2 + !E2H0
Date: Thu,  2 Apr 2026 00:07:20 +0200
Message-ID: <20260401220720.19555-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ZfBqEGIUaY7jHpVcWeoMtjwPJtpZ0y-0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDIwOSBTYWx0ZWRfXyogORmUFAd4X
 7pQmkLEPCaO73IwFPh4nqmD1ff114HPxEEXDXIO5TWI28XbI9253A5L7zpeT7jp6iWGbFLh/jeb
 41OQu0yVwgIlqb6MsSo0BuSd+eecxwCb5QXTL/8edGAtUzDQqwAEinI27qHL4NtNapZkkzk8yW5
 drmoY2R1ecxuJ0fgXNunSoQjwXRSjaoQCW14UsMowkA36+X6UmEn2KKpP7uaYdXYs+CZJHTMD/k
 ZdvYbUAjRAQAOYT3zNpTUtoDQybNhwXrK3rsvhLP9GuBzLPb0sBA68+QYZcK6GALHaZCRi4ChHN
 WzSIM3eD+lrEDpFjzZYhRHjZkiraFZUU5phuJIok69sQiYz425rXNkJ+cZ0+nE=
X-Proofpoint-ORIG-GUID: ZfBqEGIUaY7jHpVcWeoMtjwPJtpZ0y-0
X-Authority-Info-Out: v=2.4 cv=a4o9NESF c=1 sm=1 tr=0 ts=69cd971d
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=aH_TBEbXYK5kCjmaeM4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 spamscore=0 phishscore=0 clxscore=1030 mlxlogscore=750
 lowpriorityscore=0 mlxscore=0 suspectscore=0 malwarescore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604010209
Received-SPF: pass client-ip=57.103.79.123;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/cpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index ccc47c8a9a..5ffb1e3096 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -685,6 +685,10 @@ void arm_emulate_firmware_reset(CPUState *cpustate, int target_el)
         }
     }
 
+    if (have_el2 && !cpu_isar_feature(aa64_e2h0, cpu)) {
+        env->cp15.hcr_el2 |= HCR_E2H;
+    }
+
     /* Set the CPU to the desired state */
     if (env->aarch64) {
         env->pstate = aarch64_pstate_mode(target_el, true);
-- 
2.50.1 (Apple Git-155)


