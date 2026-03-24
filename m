Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B9CF54ACC
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 15:15:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w53Ts-0006Xm-Hf; Tue, 24 Mar 2026 11:15:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w53Sz-0005vE-3Y
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 11:14:54 -0400
Received: from p-east2-cluster2-host1-snip4-7.eps.apple.com ([57.103.78.10]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w53Sq-0005tK-3m
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 11:14:45 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-7 (Postfix) with ESMTPS id
 DF6D51852A0C; Tue, 24 Mar 2026 15:14:31 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774365274; x=1776957274;
 bh=xmiWoWUwFQC07+7l4Wa/YhNMVuZwBdr5x6NXirvfyaw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=KNOYka9YgcZKTah1n5NV67T8959OyRrJ7xHv/dR5ImCyD7Op7mJ8zy7tTl0aSfpxiu0zHZfqVWC0kfyxKqaQ0Be1ffPiL+gLv8kdWHWkL97j1kJsiI/C7EyU+TvRhTrScHhJgdlYUDXsh98nDQURcxx+RKcl3xHliX5jnKR8iu99TgNt9tfctYYnvoM5e9F+m1L2R/NDlWm7XX4ZxRWGdI8r6fhpMNQFBW1G87AweUkctPqAq/wU/n5gyliiaVCccw2MRfcyf8ftNue0Zb4I5aVBTgjtUMtBAKC2Dn6I+lRR+PHNI96crwbu1RCvb4Z7seRfMQGwGzp8HCwLwb1Mxg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-7 (Postfix) with ESMTPSA id
 BABFE1814D21; Tue, 24 Mar 2026 15:13:49 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH v3 07/12] whpx: i386: add implementation of new x86_emul_ops
Date: Tue, 24 Mar 2026 16:13:18 +0100
Message-ID: <20260324151323.74473-8-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260324151323.74473-1-mohamed@unpredictable.fr>
References: <20260324151323.74473-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 6xZU7F-r9s6-5xQNGfxKGQHbDVc91LV2
X-Proofpoint-ORIG-GUID: 6xZU7F-r9s6-5xQNGfxKGQHbDVc91LV2
X-Authority-Info-Out: v=2.4 cv=f6dFxeyM c=1 sm=1 tr=0 ts=69c2aa58
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=od5n6cu0qASRTXmq4OYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDExOSBTYWx0ZWRfX1/AMjzSpGEKz
 pYl3p955YAfx8lD58t/ss+zNV6+5ezqMu1F+ujwF78BG72pRDRnvuyZSrRQ9vefMIrzfzNgVNdX
 BXx0mpJUdzjsmZ6wnfejtvbBTwGSqT2WhJYCeNGUjsjugB73COgcGzNuXFu/3MQ4Ckjxjw37l+1
 CKl/dPbFOqPOrWoE0212CpvWdli0dDcJjUntSw00IdwHQsbD8bSU0R6nyaxgFEuLIIxIx+a8abF
 x7iV1vR8suPVhqXjeM1Vywa8NFhw8PKQNQCT5/69FBQMcnqzpzZ9i0Vs5SLLLnto4jCwnwhpmA/
 3xMkT126np/E36nvkO1CpgnrTJWAcZJoBcrmmhahmqGp9SN/ooE6847ZVrADYQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=919 malwarescore=0 mlxscore=0
 adultscore=0 bulkscore=0 clxscore=1030 phishscore=0 spamscore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2603240119
Received-SPF: pass client-ip=57.103.78.10;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


