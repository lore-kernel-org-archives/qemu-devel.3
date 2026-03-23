Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E099DF4613E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 22:36:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4nre-00061T-La; Mon, 23 Mar 2026 18:35:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w4nrd-00060h-Hd
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 18:35:13 -0400
Received: from qs-2007e-snip4-1.eps.apple.com ([57.103.84.172]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w4nrb-00038j-EI
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 18:35:13 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPS id
 7551F180026D; Mon, 23 Mar 2026 22:35:08 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774305310; x=1776897310;
 bh=zodV20KljGzIfu43VRyDL9cMkLVaJYP9ThhIqUxnyaU=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=IDf7DjTH0Wy9aLXaC+XJq5uKrnKVjR5SsuyYFR4e9t4AFYPn5MrI0sA8zy3OMSHp1MSuEP8dQSocjER1dHCZ5UN+UgC7QQQU4IfNW/799IsEn7wp4UK2Rs4iIqHWDzyWAIChDk/xA5yYwiUnfWFWJkLDD/knLwfn29sdhwf+JS85+36ravA7wUXSEcsvV70InD1OxoLsTSKxm85BvRn6pEALpFtSAm4M3diZlSzHaAnxfJUioVg08g1PA1WFqBExHfAqdsJPonn/I6OU+nMfg+scGCPOUZL6Uru27VNIgPxz1CR6I7FxaCnDQnOGkJF2RzWMaBqyBEUl1RtBrMZPvw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPSA id
 2A06A180012D; Mon, 23 Mar 2026 22:34:59 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>, Wei Liu <wei.liu@kernel.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v2 09/13] whpx: i386: indirect access to CRs
Date: Mon, 23 Mar 2026 23:34:30 +0100
Message-ID: <20260323223434.81780-10-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260323223434.81780-1-mohamed@unpredictable.fr>
References: <20260323223434.81780-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 22tdzJW43Dm3lE-G9mhduYTMRRYL8GfZ
X-Proofpoint-ORIG-GUID: 22tdzJW43Dm3lE-G9mhduYTMRRYL8GfZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE2NyBTYWx0ZWRfX7pSFO+hiIDlR
 09piyW6R3QTp1P5Uz/1kWZkKTjcRPwNTT9B90E2upOkkxVW/bSV/clhZhmHiFyH5wlNDVukHWLo
 R+T+4csQZumvHF3DRSwZwCjkxGx/BCuQQc1gUUrapMXS/8wmGk+GWLMftoq8KDL7mPonJUkH8vN
 KOdnl6g7RnIopNO0IJw9ZLZtwSIYkh+pVLejPJM4//efo7P2UOpxkRvikCxGSLyiBMAzawEFmbB
 POgRuvWkmybg6BPVK6pmQACz17HPMdESbH4eNYs5j8rOy5ZqNfygnTcb+Wf6nPylqFjdybysojJ
 3sM7FdYmHaow9HC9vTGkF6A3oUC56HN7xuQq3IhX4FbDn9EkYhOeWdVReEqIdE=
X-Authority-Info-Out: v=2.4 cv=K+Av3iWI c=1 sm=1 tr=0 ts=69c1c01c
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kcTmfTs-UkjvTY61EfIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_06,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 malwarescore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=848 phishscore=0
 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603230167
Received-SPF: pass client-ip=57.103.84.172;
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
 target/i386/whpx/whpx-all.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index b97dc9fd51..71b33a632a 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -905,12 +905,42 @@ static bool is_user_mode(CPUState *cpu)
     return vcpu->exit_ctx.VpContext.ExecutionState.Cpl == 3;
 }
 
+static target_ulong read_cr(CPUState *cpu, int cr)
+{
+    WHV_REGISTER_NAME whv_cr;
+    WHV_REGISTER_VALUE val;
+
+    switch (cr) {
+    case 0:
+        whv_cr = WHvX64RegisterCr0;
+        break;
+    case 2:
+        whv_cr = WHvX64RegisterCr2;
+        break;
+    case 3:
+        whv_cr = WHvX64RegisterCr3;
+        break;
+    case 4:
+        whv_cr = WHvX64RegisterCr4;
+        break;
+    case 8:
+        whv_cr = WHvX64RegisterCr8;
+        break;
+    default:
+        abort();
+    }
+    whpx_get_reg(cpu, whv_cr, &val);
+
+    return val.Reg64;
+}
+
 static const struct x86_emul_ops whpx_x86_emul_ops = {
     .read_segment_descriptor = read_segment_descriptor,
     .handle_io = handle_io,
     .is_protected_mode = is_protected_mode,
     .is_long_mode = is_long_mode,
-    .is_user_mode = is_user_mode
+    .is_user_mode = is_user_mode,
+    .read_cr = read_cr
 };
 
 static void whpx_init_emu(void)
-- 
2.50.1 (Apple Git-155)


