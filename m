Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D16ED58CBF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 22:36:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4nrU-0005zL-Hn; Mon, 23 Mar 2026 18:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w4nrS-0005yh-Nr
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 18:35:02 -0400
Received: from qs-2001g-snip4-7.eps.apple.com ([57.103.87.70]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w4nrR-0002wL-7X
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 18:35:02 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPS id
 847EE1800260; Mon, 23 Mar 2026 22:34:58 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774305300; x=1776897300;
 bh=xmiWoWUwFQC07+7l4Wa/YhNMVuZwBdr5x6NXirvfyaw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=OvYWV047tjkjK1Nij/w06Ntmx3nM932WujaqqC9+MtJB3KpKdeG+ga0YUzM4tMHfR5Wn4iBq2Jf6Q99rXdL2mtqDWYqsr+O9ek1rVbkqqCLT3AFtRRz3dJU3+OiqLeZMHbDmIs+MWGo/tzv5jPOlsW9iM/NB3kK1O9jMobXwepfKGgfqkiU9N8SKhMiM05aIg53Fb6ZlvcMu9BpCRp7dAKAfDkxU4ak2lszMCFF6KzKAyLl38Ez3n5e2D2RZZhpTmtFMXLQYZ+EBBbw8QRFpnKPHRUPaT6m5VtY4sCHpT+RjkJvoZEF5bCia+yBAEpkU62/LFx5xuuhcQ5+W1Vv5gA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPSA id
 3A61B1800158; Mon, 23 Mar 2026 22:34:55 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>, Wei Liu <wei.liu@kernel.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v2 07/13] whpx: i386: add implementation of new x86_emul_ops
Date: Mon, 23 Mar 2026 23:34:28 +0100
Message-ID: <20260323223434.81780-8-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260323223434.81780-1-mohamed@unpredictable.fr>
References: <20260323223434.81780-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE2NyBTYWx0ZWRfX/jCKsaYbBqkt
 G6yPLMP0ITUztGseeRl++pVTciFY+YCcJcrbJRzicrTD6jqiSaogSsh2m6+f1Bc+LH4d4RuERKR
 As9DqQ0qhYPE8un4Mk14DY5bTuzhqbLoBBrMdDTfLGF2ye/CsRrO0CSxnoaa2SqxDuEZLjtPggG
 IUSzx+tOwdtLhS/EpY8whIGxc8QEqz/iukVkV7dCUKxtHTDTFalcK69QwJQN2+XeAt2n1cAhK4b
 +ViAvyV9meui8/29n1dapDNIKyhV927AuVXMV8C5sa+0jMDR9sxhBWUwImC6YO0zcgafLoIgoxg
 uIAuwDm7TTP3yGfuOlVRkedqJ3ozJvVDe4C3CnVE+ifI4ctIvaQKbEo0i27YWU=
X-Proofpoint-GUID: UTn4qKWtrsKEfTsF-BTK5QtMTR0nDMoe
X-Proofpoint-ORIG-GUID: UTn4qKWtrsKEfTsF-BTK5QtMTR0nDMoe
X-Authority-Info-Out: v=2.4 cv=QuJTHFyd c=1 sm=1 tr=0 ts=69c1c012
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=od5n6cu0qASRTXmq4OYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_06,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 adultscore=0 suspectscore=0 malwarescore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=889 phishscore=0 bulkscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603230167
Received-SPF: pass client-ip=57.103.87.70;
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

target/i386/emulate now has new ops for fetching whether the guest is in
protected mode, long mode or user mode without fetching control
registers.

Use those for faster vmexits.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 69d141e7cc..b97dc9fd51 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -885,10 +885,32 @@ static void read_segment_descriptor(CPUState *cpu,
     }
 }
 
+static bool is_protected_mode(CPUState *cpu)
+{
+    AccelCPUState *vcpu = cpu->accel;
+
+    return vcpu->exit_ctx.VpContext.ExecutionState.Cr0Pe == 1;
+}
+
+static bool is_long_mode(CPUState *cpu)
+{
+    AccelCPUState *vcpu = cpu->accel;
+
+    return vcpu->exit_ctx.VpContext.ExecutionState.EferLma == 1;
+}
+
+static bool is_user_mode(CPUState *cpu)
+{
+    AccelCPUState *vcpu = cpu->accel;
+    return vcpu->exit_ctx.VpContext.ExecutionState.Cpl == 3;
+}
 
 static const struct x86_emul_ops whpx_x86_emul_ops = {
     .read_segment_descriptor = read_segment_descriptor,
-    .handle_io = handle_io
+    .handle_io = handle_io,
+    .is_protected_mode = is_protected_mode,
+    .is_long_mode = is_long_mode,
+    .is_user_mode = is_user_mode
 };
 
 static void whpx_init_emu(void)
-- 
2.50.1 (Apple Git-155)


