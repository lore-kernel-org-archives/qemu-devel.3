Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45DF2F483E9
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 19:37:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4l5T-0005sU-SG; Mon, 23 Mar 2026 15:37:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w4l5O-0005oY-4g
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 15:37:15 -0400
Received: from p-west3-cluster3-host6-snip4-6.eps.apple.com ([57.103.72.147]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w4l5H-0004Xh-Pf
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 15:37:12 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-7 (Postfix) with ESMTPS id
 B05E71800139; Mon, 23 Mar 2026 19:36:59 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774294621; x=1776886621;
 bh=uAJ51zR7R15wIVlC530LHyYmi+UTEudXXGcCdwby+0E=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=eBcoB/kZVY2pj/3hXlWbAgeeXCBrbxMGPCs60uCQLCcAH4SrtIvBJapPCbDkKQjxfcPLxV+wCZSXqJ0g5ctJQrwND2797Oqj/udmQYI/8Qupz+jQPCAiLDMN4+m0bd6CEWnJnUEADYvhHG00e03wPVvHy9AbBOuTGpgGPj1viio9ldNB6308UdIKc9jCr5n9fY/S/mxfky9DwYUlgJouPU6QHM1iEIr7gIA9Gv84QJVlVnCi1DNzgSZhPXPCz4hs6eOz5+Wwlj536UEt1/LuDSxlgFDHnUlM+RjTRX75vZY3xhMjSJ2prWnQZtdhaO8YheWTn7ndbrpMBHs2LlQFzg==
mail-alias-created-date: 1752046281608
Received: from mac.home (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-7 (Postfix) with ESMTPSA id
 F16111800349; Mon, 23 Mar 2026 19:36:57 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH 05/12] whpx: i386: don't restore segment registers after MMIO
 handling
Date: Mon, 23 Mar 2026 20:36:38 +0100
Message-ID: <20260323193645.82602-6-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260323193645.82602-1-mohamed@unpredictable.fr>
References: <20260323193645.82602-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: GqHy4PuT02SD8aqlmo5uuDqelRaDUrJt
X-Authority-Info-Out: v=2.4 cv=fKA0HJae c=1 sm=1 tr=0 ts=69c1965c
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=-4eTQGsHVEe5RITbnwAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE0NSBTYWx0ZWRfX/DUXo2WweLu4
 JJ2NX904mAewHM6mYV6wBTQ/BfL4huaHfOvCBIv+dehS9ewKSOYqiYpNANV9aRImp5dEgyQWvue
 cXEQLw+4jrKJPgf0vsWaJmOI+y78ZMCBDnqotD0rsrrIP8IBYqZSJukaSImvl6MWPOjMvf87hjI
 EsnSO6+TrhG5HHQ6OFMcknu0nn1NMY76xRRgJhAV4OT/0JOMG4DcXvtKZvy0pUShlR2Q8aBEhv0
 OjPY2HcOTlBwTFz+HQ43mWx/f8kM0WhbW5iqEuaHPYOWpSoTITzS1/UEBVPzfPchSHY675TwZ/Z
 1UB7d1O5LpL2O7By+U5mPi8fN3xf4Xb3c0Zzg56CV1Vapuk5rXRVONMaZ8gvPg=
X-Proofpoint-GUID: GqHy4PuT02SD8aqlmo5uuDqelRaDUrJt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 mlxlogscore=801 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603230145
Received-SPF: pass client-ip=57.103.72.147;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index c0c7ba9177..69d141e7cc 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -416,19 +416,21 @@ void whpx_set_registers(CPUState *cpu, WHPXStateLevel level)
     assert(whpx_register_names[idx] == WHvX64RegisterRflags);
     lflags_to_rflags(env);
     vcxt.values[idx++].Reg64 = env->eflags;
-
-    /* Translate 6+4 segment registers. HV and QEMU order matches  */
     assert(idx == WHvX64RegisterEs);
-    for (i = 0; i < 6; i += 1, idx += 1) {
-        vcxt.values[idx].Segment = whpx_seg_q2h(&env->segs[i], v86, r86);
-    }
 
-    assert(idx == WHvX64RegisterLdtr);
-    /*
-     * Skip those registers for synchronisation after MMIO accesses
-     * as they're not going to be modified in that case.
-     */
     if (level > WHPX_LEVEL_FAST_RUNTIME_STATE) {
+
+        /* Translate 6+4 segment registers. HV and QEMU order matches  */
+        for (i = 0; i < 6; i += 1, idx += 1) {
+            vcxt.values[idx].Segment = whpx_seg_q2h(&env->segs[i], v86, r86);
+        }
+
+        assert(idx == WHvX64RegisterLdtr);
+        /*
+         * Skip those registers for synchronisation after MMIO accesses
+         * as they're not going to be modified in that case.
+         */
+
         vcxt.values[idx++].Segment = whpx_seg_q2h(&env->ldt, 0, 0);
 
         assert(idx == WHvX64RegisterTr);
-- 
2.50.1 (Apple Git-155)


