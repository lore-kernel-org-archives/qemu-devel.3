Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF688F4613E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 22:36:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4nrW-0005zs-4E; Mon, 23 Mar 2026 18:35:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w4nrT-0005yy-V6
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 18:35:03 -0400
Received: from qs-2001l-snip4-8.eps.apple.com ([57.103.87.121]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w4nrS-0002wf-Bz
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 18:35:03 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPS id
 86CF3180015B; Mon, 23 Mar 2026 22:34:53 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774305301; x=1776897301;
 bh=uAJ51zR7R15wIVlC530LHyYmi+UTEudXXGcCdwby+0E=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=AISWJbAqqZEhNboz+UMQy7vrK2JIEQuVCicv7m3CrGywUM1N7IAu3QCdcVv/8IJQumieku+HHv6lME7rcZEjc/kP/uwGA/7diQ6U8BRDqLuDc/7DgLiDh741QWk7WvH1YVFbUB5i2eC/oWNEYmKsbzq1KcqnPCqJPfbSiH4kVtccnXiTD+zR4iAtk0ptAC0n/H7qubNbxNhp1vdaqRH/TsRiqxst2QcQYXfVMN2mZSBelwXU8GSoubWGZvyM2kmLQwcI2B78YwOLTKL9KbpWhgMV5Ijg5Oa5+urMxfoHmPSxu3ORq/RoZHNS7Fp3SIxtLoTiJJaGP57FUa2bOjpGbA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPSA id
 A5CAC1800222; Mon, 23 Mar 2026 22:34:51 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>, Wei Liu <wei.liu@kernel.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v2 05/13] whpx: i386: don't restore segment registers after
 MMIO handling
Date: Mon, 23 Mar 2026 23:34:26 +0100
Message-ID: <20260323223434.81780-6-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260323223434.81780-1-mohamed@unpredictable.fr>
References: <20260323223434.81780-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=bZxmkePB c=1 sm=1 tr=0 ts=69c1c013
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=-4eTQGsHVEe5RITbnwAA:9
X-Proofpoint-ORIG-GUID: w-uH5WJELv-hxVlr5oqjA4ijwLxa5FP0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE2NyBTYWx0ZWRfXxzyEEsG+WiTR
 t1juyOEX7IGBmpjWmCWxV3YioLtzfT4fKuVxqHHbLTOzTwoH/jScQD/7RQZhDmepIfcg/b4+9r4
 umIRa1FxDeSySDa2lgKIb3Z8ljhjUqtV6bYvi91R7cA/H/azU/oTiu3G4ePhjBPrcdIlQO+CMiC
 3sqXX+bg+LM8D/2Om8ko82x62kpQpQ4uJxLv5wnHEvIWRNM9LK0P8ko7B6AA/AB/37eQM0oGAFb
 MlMKcXblMXwH43io/6p8BWcmS96zy2BxZY3P9y13ZBPstxDJ346FIV0rmOj9xcxCZR5PVRaNJhH
 f1F9ZrldlMDvRryorqwkJrEmrZof2n6MFj0hkpYakPWBxuqGzRbCuRFR8UbHJU=
X-Proofpoint-GUID: w-uH5WJELv-hxVlr5oqjA4ijwLxa5FP0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_06,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 clxscore=1030 adultscore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxlogscore=800 malwarescore=0 bulkscore=0 lowpriorityscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603230167
Received-SPF: pass client-ip=57.103.87.121;
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


