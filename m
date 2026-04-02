Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A19CC6B00
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 05:35:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8AgV-0002R7-TB; Thu, 02 Apr 2026 01:33:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8AgR-0002Ke-T3
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 01:33:35 -0400
Received: from qs-2007b-snip4-11.eps.apple.com ([57.103.84.151]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8AgP-0004uC-Vv
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 01:33:35 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-0 (Postfix) with ESMTPS id
 CFC251800366; Thu, 02 Apr 2026 05:33:31 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1775108012; x=1777700012;
 bh=jSFEY3OW57r5Gmf0SB6G349rIgUNCT10rXc1M/CBSww=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=L/GJCZ7BgV+3qVQaSruGqWJTLAuuJYsZmuWpHZdnQ70OoccBI0+wqGXXkhRuWCc2FxhBbOb6B84Dpc67nhXtO0uBwRaeQTaqlU5iypN8NG8Q8h/Q8kjemsBu2SX73vDoTMi5SifUN3bvS4wdXtlyUS1BfsJtbjvAbikphVZhqCDOVT7qO3DAY7XAMlVLnOKWtRkefipzg19idfqI/M8Te1kiGVUnueB9pSMhmpyHZvoNbHHvYBInpnePuXwSExgcVg7YTt370lFs5oYFuB6RsTTm1VUxOWBUz1VBZJnWutJFus0YK/3tLB3+6j9oLNQEbLpAXeuVDWn0fKiLwnyNEg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-0 (Postfix) with ESMTPSA id
 78CAC1800371; Thu, 02 Apr 2026 05:33:30 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Wei Liu <wei.liu@kernel.org>, Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 1/4] target/i386: emulate: include name of unhandled
 instruction
Date: Thu,  2 Apr 2026 07:33:23 +0200
Message-ID: <20260402053326.23402-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260402053326.23402-1-mohamed@unpredictable.fr>
References: <20260402053326.23402-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: acwzu_coFQu3PKfPr84e0Au8U0fUzjy9
X-Authority-Info-Out: v=2.4 cv=T72BjvKQ c=1 sm=1 tr=0 ts=69cdffac
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=x0iqa3ucmZZh0HPruXgA:9
X-Proofpoint-ORIG-GUID: acwzu_coFQu3PKfPr84e0Au8U0fUzjy9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA0NyBTYWx0ZWRfX9B0Vp1a1TFH+
 Lbh0k2NYcJqQ5FaISCrY7y/XhLdyr28ZAZspBK9EVPAH7+zzkIRfGX2LZ6mXaZTHth+uv2SfeuD
 UxhhIoH2+6WOrpadK0AjXVL983vU4oJJaiSNt1pUwl7B3dDdxSUTogFdnKsIG1Q8WRqlMLG4WRM
 3cH3OAIZun7m8JKN4RrfozZr0eX/XZrbzYRIoZKmXbNhNE4msjnwUVBMa89PEO5d/j4gpX8TS+l
 1dWadxHqlk2aSv11Dkh9Igg5stNUVGB9kHiun7PCZCW55Anw9/cljL9J9QGek1Z7687OQ15lLfL
 K/5wdwT3y6hVVk51uXruRqpAGWNzwvijl6F9zLPOcgEEe116kCFcHOKPgfYlYA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 suspectscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=903 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604020047
Received-SPF: pass client-ip=57.103.84.151;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Instead of just the command number, include the instruction name to make debugging easier.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/emulate/x86_emu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/emulate/x86_emu.c b/target/i386/emulate/x86_emu.c
index 55b1a68eb6..c2da1a133f 100644
--- a/target/i386/emulate/x86_emu.c
+++ b/target/i386/emulate/x86_emu.c
@@ -1399,8 +1399,8 @@ static void init_cmd_handler(void)
 bool exec_instruction(CPUX86State *env, struct x86_decode *ins)
 {
     if (!_cmd_handler[ins->cmd].handler) {
-        printf("Unimplemented handler (" TARGET_FMT_lx ") for %d (%x %x)\n",
-                env->eip,
+        printf("Unimplemented handler (" TARGET_FMT_lx ") for %s - %d (%x %x)\n",
+                env->eip, decode_cmd_to_string(ins->cmd),
                 ins->cmd, ins->opcode[0],
                 ins->opcode_len > 1 ? ins->opcode[1] : 0);
         env->eip += ins->len;
-- 
2.50.1 (Apple Git-155)


