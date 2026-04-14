Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7613BF9D0EF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 18:23:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCiPY-00068r-5s; Tue, 14 Apr 2026 14:22:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wCiPP-00066G-Q5
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 14:22:48 -0400
Received: from pv-2005d-snip4-10.eps.apple.com ([57.103.66.170]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wCiPO-0006Ty-DD
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 14:22:47 -0400
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-9 (Postfix) with ESMTPS id
 EFEB1180178C; Tue, 14 Apr 2026 18:22:42 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776190965; x=1778782965;
 bh=Yl0JdZN7K1dS8wO/C1JQWlTRVuBjUIl21ZEIdD6QW+U=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=S3JlQNt1J9S2fOdlLl1iuAKsTglBrP6QjMKa2JE0G87hy5Me7xMb1YaAJeCXENwqhlbNCDvIBqxV92pEKGW+q3R152zl72pk23c8Gx82cHXUX6bMQ5f+zExpUEd+La1SEcFhlS3ZWZRUOvkxN5t1rk+YYfaLNK2k4swBUTFpKOvzPc6570ueH69NdjPWYp3knYSpXmQkf8XMKNR5BwtTKvdos0F4Y2FyR4ju7dAHAX0OF+x27iblqadN0nETjmvf+MbL5IAVj79OTwqT9LVYBg8pjfXJ2SE8s85GXWc9EwOUl8MKLfypodFhf40gWs4JPYrHVINITI4jFdbnLPjO2A==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-9 (Postfix) with ESMTPSA id
 1636E1800C8F; Tue, 14 Apr 2026 18:22:40 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4/7] whpx: i386: tighten APIC base validity check
Date: Tue, 14 Apr 2026 20:22:28 +0200
Message-ID: <20260414182231.18776-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260414182231.18776-1-mohamed@unpredictable.fr>
References: <20260414182231.18776-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=MLJtWcZl c=1 sm=1 tr=0 ts=69de85f3
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=uh2sygq7LFHjsVUyvz4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDE3MiBTYWx0ZWRfXwMsVyrKu4tqP
 qf0ElzzvpAX6vh1vfsBdPuRtZmUoiWx3aiZ9OvDuXIu4VCSZnSU8HB2/zbbWP4KlYFSCeBYfJYV
 HURLJQzfPlPQMvGgZWd1T/c9IIqWkwPBfLV4ukj55dX0TZyneNgDFGj8ns4F9m+tS6CHVEwcQYD
 3diF9TZDsmS6Yr5n4Cv7wjrxIsxwUufcbtHIwFGLAgDqTo01XAbtaAXTQaLH/EkAlSfmU1aOvaN
 LsBuoiSAlCYMzPfnWuoWx0zvKT1PYwB779ZxIem/2x3XfNWFSKmoZqmhhQMrbULvwHKXTzV341j
 6c5WrMzPz++d7O4ion3oL0hvZ5F94k6wpC5b/iJc40cNs/jobCgmuf7MDfaHrc=
X-Proofpoint-GUID: lPMCG5uEgHaCkl_dxutepya9zpoL8ots
X-Proofpoint-ORIG-GUID: lPMCG5uEgHaCkl_dxutepya9zpoL8ots
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=662
 clxscore=1030 bulkscore=0 phishscore=0 spamscore=0
 malwarescore=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604140172
Received-SPF: pass client-ip=57.103.66.170;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
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
 target/i386/whpx/whpx-all.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 73066581d4..6c39168b06 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1993,6 +1993,9 @@ int whpx_vcpu_run(CPUState *cpu)
 
             if (vcpu->exit_ctx.MsrAccess.MsrNumber == MSR_IA32_APICBASE) {
                 is_known_msr = 1;
+                if (val & MSR_IA32_APICBASE_RESERVED) {
+                    x86_emul_raise_exception(&X86_CPU(cpu)->env, EXCP0D_GPF, 0);
+                }
                 if (!vcpu->exit_ctx.MsrAccess.AccessInfo.IsWrite) {
                     /* Read path unreachable on Hyper-V */
                     abort();
-- 
2.50.1 (Apple Git-155)


