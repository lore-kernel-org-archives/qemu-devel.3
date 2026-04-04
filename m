Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A169E88D80
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2026 04:22:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8sUz-0006qF-IX; Sat, 04 Apr 2026 00:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8sUw-0006j2-Je
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 00:20:38 -0400
Received: from p-east2-cluster5-host1-snip4-1.eps.apple.com ([57.103.79.4]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8sUv-000664-1x
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 00:20:38 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-10-percent-0 (Postfix) with ESMTPS id
 13A2F1800148; Sat, 04 Apr 2026 04:20:34 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1775276436; x=1777868436;
 bh=XF3c7fudpu0e0TEiY2lChefEkznSH2lR6kP+JtXWkz4=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=U/tfDV2eVg4QZOVhxwvPEOKT4EsbDAxLDg5pg91SNf+1G9knwo057DuRM7alN3mfQXNqztJJJn6zpOqWRJHFZ/sDlchNDDqyU1Q0Y41GVI2ucyS/9SPOk2mSLsDA9a4L9mVkmj7nDn1k/jtU5xDfiGA9ZM5gAy/AYqGONcwpyJlVM9o83/spHJbqWF0tZHjbbq5Btquw1l9I684KNv/8naKsoT3XAZn51yDuUqPf99rszGuIr1Duefm37dEjvYO7qoDB0fcvz7qKsABl5lBPnvVvJO7DsgXLNQVu9uAU70PtcaOBJW6MVrbGnmfM3L7w3JAIO77sGmPOvf0xF8QpNA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-10-percent-0 (Postfix) with ESMTPSA id
 51D4F1800144; Sat, 04 Apr 2026 04:20:33 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Wei Liu <wei.liu@kernel.org>, Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v6 11/11] whpx: i386: IO port fast path cleanup
Date: Sat,  4 Apr 2026 06:20:15 +0200
Message-ID: <20260404042015.86580-12-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260404042015.86580-1-mohamed@unpredictable.fr>
References: <20260404042015.86580-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: CC1raVW39lRktLU8yaf4N8kamy5I5ksM
X-Authority-Info-Out: v=2.4 cv=J+2nLQnS c=1 sm=1 tr=0 ts=69d09193
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Vrzv6M8N8vcM0KmfSJEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA0MDAzNCBTYWx0ZWRfX6RIPgARou4Ox
 DPAETOpkCiSEjcMymtQPQO/UvPMUIe7syU4ZumCLYwrRonJPZPDTU0ZD7SrHk+6ip4r+XlHozcR
 yS54h7x7NDgPDTr3MIlsgbcGzABSi3TOfOfa/G+XmAWi2wAYjuoaAsKe/VUXySao4FM0yj1NJxW
 uTX3ZyTKW5lkKAo/b1BjDzRWBmS5e5j1F0KdUW8dBRFPt32lK+tb3i0Z8AE5zTuk9a2FFtAYw42
 xKnYUAbqMVwRvWAXrfqP5uGUz+3NXmAlSjKL0t5UFrFr2991mi2e1/GV16Y87LhDmd1S5YVht0S
 FVOakwXxCBYCGmyG9a/2araGw8UKt6A6jyOneJKPpLzR40eGpIL7moHYpNKr3M=
X-Proofpoint-GUID: CC1raVW39lRktLU8yaf4N8kamy5I5ksM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_07,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 clxscore=1030 mlxlogscore=805 phishscore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2604040034
Received-SPF: pass client-ip=57.103.79.4;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index 4810b6387d..ac2671745f 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -861,7 +861,6 @@ static void handle_io(CPUState *env, uint16_t port, void *buffer,
 static void whpx_bump_rip(CPUState *cpu, WHV_RUN_VP_EXIT_CONTEXT *exit_ctx)
 {
     WHV_REGISTER_VALUE reg;
-    whpx_get_reg(cpu, WHvX64RegisterRip, &reg);
     reg.Reg64 = exit_ctx->VpContext.Rip + exit_ctx->VpContext.InstructionLength;
     whpx_set_reg(cpu, WHvX64RegisterRip, reg);
 }
@@ -889,13 +888,23 @@ static int whpx_handle_portio(CPUState *cpu,
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


