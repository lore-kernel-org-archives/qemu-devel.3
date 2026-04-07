Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76382FF5134
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:41:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABUs-0006ko-ES; Tue, 07 Apr 2026 14:49:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wABTD-0002LR-G5
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:48:17 -0400
Received: from qs-2004l-snip4-11.eps.apple.com ([57.103.84.123]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wA7GA-0005AF-49
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 10:18:31 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-9 (Postfix) with ESMTPS id
 3E8F81800160; Tue, 07 Apr 2026 14:18:27 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1775571509; x=1778163509;
 bh=G89W4sMC3YwwxzvqsgVypuGjICEkNIb9nBQsRfciAZw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=EGGfebCzgyYMeEvdGw3oYEGVJA+ru4SgFlZb1N8YVwKfo34LX+aPum4QT1H6ZdHMQ6tNti6xoymEuOcw4YtM9EaZ7l06YJ2veJiBhw1QLEpBrKbueb12i7uyGGaznXjx2Ud7iJmec/XTajRlMRBEPl5m1PWV4XRrJuj2k55MpeAsLyE2POKrv1jiI6rybHI6CDG3UmmfMF65Eunu7TKqjIaxjl/5Be4lc38CmsqeVboCPd/CWo5OWN1MJHVG2sLNpQLPmlk0aQJlGkCznW+eti0gBIc+aurrF+8HOJ8JuwjUJAQ0gS3tog0P9S5zLyt/pm2rDiCaB3O0HljD+9WPCw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-9 (Postfix) with ESMTPSA id
 860D41800184; Tue, 07 Apr 2026 14:18:25 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH v8 11/13] whpx: i386: IO port fast path cleanup
Date: Tue,  7 Apr 2026 16:18:07 +0200
Message-ID: <20260407141809.16862-12-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260407141809.16862-1-mohamed@unpredictable.fr>
References: <20260407141809.16862-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: JsqwFwGgBY1TkEDUFMLX8cDVEvBrponw
X-Proofpoint-GUID: JsqwFwGgBY1TkEDUFMLX8cDVEvBrponw
X-Authority-Info-Out: v=2.4 cv=T4eBjvKQ c=1 sm=1 tr=0 ts=69d51233
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Vrzv6M8N8vcM0KmfSJEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDEzMSBTYWx0ZWRfXzooscxe3CZgU
 iK8BZQSEBwQe/jZnlONXtqAMrh5hjKXn8/Pcv7m0leX6VvXeQp9HrziKipLq1G2SrlZzT01QmE9
 hZrzSj3ImPoqe3U27XHziYm5N6nMGPt8uLoOh369CypuxSwDVsQrs7VSivQzOwA2DmsJSYepR3H
 rCxYk3Otlq4G/EfgomR27XIb8gLeaFWX8oqsIxNIE87u+MqcwXORONvyzRbBik3H0GmfxHfhmi8
 xDPnfrbSIgo+iYIhenGeeDG1x8SYaC16NKxdNQAQmwSDoAbmmxkPRnfDC4SaZKGJvJWY57SnDAP
 2Q4+FN5p4q5GcqSGyme1sgMRT/CRuuBQqHj/CxgaW6UudoL2cb+LzxIH6YeC2s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_03,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 phishscore=0 mlxlogscore=812 spamscore=0 malwarescore=0
 mlxscore=0 clxscore=1030 suspectscore=0 lowpriorityscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604070131
Received-SPF: pass client-ip=57.103.84.123;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

vmport calls synchronise_state within an I/O port read.
Support that properly.

What was there before worked because of a side effect of
whpx_get_reg synchronising context if cpu->vcpu_dirty.

Remove that whpx_get_reg call in whpx_bump_rip too as it's no longer
needed now.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 7c80d653d1..61aec98e66 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -862,7 +862,6 @@ static void handle_io(CPUState *env, uint16_t port, void *buffer,
 static void whpx_bump_rip(CPUState *cpu, WHV_RUN_VP_EXIT_CONTEXT *exit_ctx)
 {
     WHV_REGISTER_VALUE reg;
-    whpx_get_reg(cpu, WHvX64RegisterRip, &reg);
     reg.Reg64 = exit_ctx->VpContext.Rip + exit_ctx->VpContext.InstructionLength;
     whpx_set_reg(cpu, WHvX64RegisterRip, reg);
 }
@@ -890,13 +889,23 @@ static int whpx_handle_portio(CPUState *cpu,
         } else {
             reg.Reg64 = (uint64_t)val;
         }
-        whpx_bump_rip(cpu, exit_ctx);
-        whpx_set_reg(cpu, WHvX64RegisterRax, reg);
+        /* vmport calls cpu_synchronize_state on an I/O port read */
+        if (!cpu->vcpu_dirty) {
+            whpx_bump_rip(cpu, exit_ctx);
+            whpx_set_reg(cpu, WHvX64RegisterRax, reg);
+        } else {
+            env->eip = exit_ctx->VpContext.Rip + exit_ctx->VpContext.InstructionLength;
+            env->regs[R_EAX] = reg.Reg64;
+        }
         return 0;
     } else if (!ctx->AccessInfo.StringOp && ctx->AccessInfo.IsWrite) {
         RAX(env) = ctx->Rax;
         handle_io(cpu, ctx->PortNumber, &RAX(env), 1, ctx->AccessInfo.AccessSize, 1);
-        whpx_bump_rip(cpu, exit_ctx);
+        if (!cpu->vcpu_dirty) {
+            whpx_bump_rip(cpu, exit_ctx);
+        } else {
+            env->eip = exit_ctx->VpContext.Rip + exit_ctx->VpContext.InstructionLength;
+        }
         return 0;
     }
 
-- 
2.50.1 (Apple Git-155)


