Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C9910AB82E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 23:32:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5uBB-00089E-2O; Thu, 26 Mar 2026 19:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w5uB5-00087W-8a
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 19:31:54 -0400
Received: from ci-2002d-snip4-8.eps.apple.com ([57.103.88.169]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w5uB3-0003qX-6T
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 19:31:50 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-10-percent-0 (Postfix) with ESMTPS id
 761BF180088B; Thu, 26 Mar 2026 23:31:46 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774567908; x=1777159908;
 bh=hKEJoh4ZK0FFxEPysK5m7KR7gOdokjPvbVT9IIB4jTk=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=N59A2/wHa7b9uxSCuece/GOCgaEDJvK+3TgSq9uTjZaIdRwjjpHUbBzuSewUoJhe7ZSKD7Pc9hcd8ocfqVoFQEc33o3zUwZzNEFMc8/lXkeLAS/E9TPhe+OmiHHTijgyD5K/Im3C2qYRBUmAwCim9aRZdM/Sj9hkv6aFdpa9OfxfqowMZTEXom5vLOt3YISLvHO3oOfQC+bYVDIfs3cvjeecpZgze/VeUEv5vp872Tx/o48hqhMIL1ECbBoamQnUVrFFCKTpaCdmf+j7zJGOVl/G0farSNvdcejFax75wpyV2udux4hYgNS/UsSBnE6L3MppmXrdPgOU2zHE540QrQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-10-percent-0 (Postfix) with ESMTPSA id
 44FC91800128; Thu, 26 Mar 2026 23:31:44 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v5 6/6] target/i386: emulate: emulate SLDT and STR
Date: Fri, 27 Mar 2026 00:31:30 +0100
Message-ID: <20260326233130.59392-7-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260326233130.59392-1-mohamed@unpredictable.fr>
References: <20260326233130.59392-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: sHnvFcskANbVaD-jyEe-y4qahMCdJ7dE
X-Authority-Info-Out: v=2.4 cv=PPsCOPqC c=1 sm=1 tr=0 ts=69c5c1e3
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=p0WdMEafAAAA:8 a=h0iFb2CXyTZTJYbVGV0A:9
X-Proofpoint-ORIG-GUID: sHnvFcskANbVaD-jyEe-y4qahMCdJ7dE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDE2NyBTYWx0ZWRfX9u0oB/qFs8/u
 4+vZwte520H0nbCOeIKIapX5SINcHLbUghESbj/hhsGcybo20r3TqI9aRPYgsjWrnP9hjWkUoXm
 2m4on3e7cid8DWpRBgm544c+U2fZot91I9IdJL4X6off4TSoxoCTT7WDSIOZ1Chldz4/NL6Pdpr
 XrfG8RekiEJMTJfcBqpRXbRmq2am7E30+E8CYLDJBgORPCw0S5KCeQFnjNNgDOxMmq8J/SclS2X
 wpbvES6KgEWe8Mud/q5BglbyGWxsZ8Rz0BmApYyRvANJQZgjFYR1bx5yNdENdlD2hUTj6w7E2vf
 aYd9Mw5cPbRCJGpfP3t8BWZjzeERJhJ8FTUXNzC0V1S5MZS16RxgaSsPf8adtE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=794 suspectscore=0 clxscore=1030 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603260167
Received-SPF: pass client-ip=57.103.88.169;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
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

Never saw that one being trapped and could not reproduce on AMD.
But from the QEMU bug tracker, that looks like another story on
Intel processors.

Present in "whpx_failures.txt" on
https://gitlab.com/qemu-project/qemu/-/work_items/3349#note_3195249254

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/emulate/x86_emu.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/target/i386/emulate/x86_emu.c b/target/i386/emulate/x86_emu.c
index c2da1a133f..e6e6500ea5 100644
--- a/target/i386/emulate/x86_emu.c
+++ b/target/i386/emulate/x86_emu.c
@@ -1338,6 +1338,22 @@ static bool exec_xadd(CPUX86State *env, struct x86_decode *decode)
     return 0;
 }
 
+static bool exec_sldt(CPUX86State *env, struct x86_decode *decode)
+{
+    x86_segment_selector seg = emul_ops->read_segment_selector(env_cpu(env), R_LDTR);
+    write_val_ext(env, &decode->op[0], seg.sel, 2);
+    env->eip += decode->len;
+    return 0;
+}
+
+static bool exec_str(CPUX86State *env, struct x86_decode *decode)
+{
+    x86_segment_selector seg = emul_ops->read_segment_selector(env_cpu(env), R_TR);
+    write_val_ext(env, &decode->op[0], seg.sel, 2);
+    env->eip += decode->len;
+    return 0;
+}
+
 static struct cmd_handler {
     enum x86_decode_cmd cmd;
     bool (*handler)(CPUX86State *env, struct x86_decode *ins);
@@ -1382,6 +1398,8 @@ static struct cmd_handler {
     {X86_DECODE_CMD_MOVSX, exec_movsx},
     {X86_DECODE_CMD_XCHG, exec_xchg},
     {X86_DECODE_CMD_XADD, exec_xadd},
+    {X86_DECODE_CMD_SLDT, exec_sldt},
+    {X86_DECODE_CMD_STR, exec_str}
 };
 
 static struct cmd_handler _cmd_handler[X86_DECODE_CMD_LAST];
-- 
2.50.1 (Apple Git-155)


