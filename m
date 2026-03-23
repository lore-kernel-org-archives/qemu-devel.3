Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C5CF483EA
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 19:38:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4l5R-0005qZ-1B; Mon, 23 Mar 2026 15:37:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w4l5I-0005n4-0B
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 15:37:09 -0400
Received: from p-west3-cluster3-host4-snip4-10.eps.apple.com ([57.103.72.191]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w4l5A-0004XF-4X
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 15:37:03 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-7 (Postfix) with ESMTPS id
 AD9221800275; Mon, 23 Mar 2026 19:36:56 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774294618; x=1776886618;
 bh=vnPfBYcDBT/4rVJAt76jW+6cbBD4K0JEvtoQvDJO0ok=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=W6X4+Q+ckuJCZV6maqUCOVVxvXxDK2EmcL/VZURZhj4e91bdsbrVbLJb8qjVh7/C/dWuXx+DnQhUIZR2N0qEvHUCcDS+IT4RM0X90iebN+hMPaIjFLQd/5RK3aeKrZfFFCon6GW2+LzVN79qTclDudpe7yppWzloXJ1COi12BGGM2i9Zy1qqXQiUidOc4GNz4kJo5TMZcm18j4yKG9qs/2U/aEWaP3jm8xRrdZE+tj8FLCU5N0GVVKbM5tnGdgt0OAiYw5YOB7yd3CmrOd5ppShTbx4FHC3jg5oae9fwTETgwPlpvzwHYlQvnyJjg8GrSYftSuEMvqarCvglTzroAw==
mail-alias-created-date: 1752046281608
Received: from mac.home (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-7 (Postfix) with ESMTPSA id
 8AC9F180013A; Mon, 23 Mar 2026 19:36:54 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH 03/12] whpx: i386: skip TSC read for MMIO exits
Date: Mon, 23 Mar 2026 20:36:36 +0100
Message-ID: <20260323193645.82602-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260323193645.82602-1-mohamed@unpredictable.fr>
References: <20260323193645.82602-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=IZeKmGqa c=1 sm=1 tr=0 ts=69c19659
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NP4je1IWzm4tDGSucAQA:9
X-Proofpoint-ORIG-GUID: _XeI8KjePg5BDZ-NXO25DAuv8q7tS7Df
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE0NSBTYWx0ZWRfX9wFt0VMoFVXK
 0ys6j133ljdLG1pYs5vJfQPPV4gtHYhONG+kz+kZjyZYlz1B0zcsmQ/i7HTYzvkdG1892A7hQTA
 JCfZC2WTLYQUMiicifUG31jrWJdOdXlPHlc7xjnjw7Q9+1JjGV6a4txQtjEsAftEkAJnAKzl2F6
 X/dtJKfLA28A0yx1ooEjgMR8kodcca/tlnkJDRB1/nRFsMWagRPodtAshW6B9mczWf03C2ED2GS
 S/pDrZV1bxmPn7jOWCLIAc3k1Z7vmiit6dFMs82CWtAVcGummnRE2ZnoVKQuaG/a3YCb7tyX243
 WrMnHQ4fB2gdA8Ci6WwwqLmSIuToFO78dsEr6lyCjnOtBtySAvSf7MocI6+aBo=
X-Proofpoint-GUID: _XeI8KjePg5BDZ-NXO25DAuv8q7tS7Df
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=677
 spamscore=0 malwarescore=0 clxscore=1030 suspectscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603230145
Received-SPF: pass client-ip=57.103.72.191;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The TSC value isn't needed for vmexit processing.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 8f1835ee95..ac03445d9d 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -606,7 +606,7 @@ void whpx_get_registers(CPUState *cpu, WHPXStateLevel level)
 
     assert(cpu_is_stopped(cpu) || qemu_cpu_is_self(cpu));
 
-    if (!env->tsc_valid) {
+    if (level > WHPX_LEVEL_FAST_RUNTIME_STATE && !env->tsc_valid) {
         whpx_get_tsc(cpu);
         env->tsc_valid = !runstate_is_running();
     }
-- 
2.50.1 (Apple Git-155)


