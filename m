Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60E2AFA1FFF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 21:43:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFfLG-0007rr-WD; Wed, 22 Apr 2026 17:42:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFfLF-0007qr-86
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 17:42:41 -0400
Received: from p-east2-cluster1-host9-snip4-10.eps.apple.com ([57.103.76.113]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFfLD-0006vo-3j
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 17:42:40 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id
 BDFFC18006F2; Wed, 22 Apr 2026 21:42:32 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRJAU1fDl4fBBdGGVUERx5dVkAZGQJRHFYNV0NUBF9QSQxBUGxaAEcXSB1dGVlvUF0cDhhZG0AVXRFQGVYJXhUXHkFNWgJWTQVKA18BWwZCC0oCWQVZB14LSgdfGlkfHVYQUgBSD3IFVwhBCFMCUQRYGl8IGQ1AThkMSh1SVlEFSgxcAGgPXR1YEV0=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776894156; x=1779486156;
 bh=jSFEY3OW57r5Gmf0SB6G349rIgUNCT10rXc1M/CBSww=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=PyQTwjt7pw3pQluYudZ9pi6yjQ9CKSqwDoEslECPrQIx0HVTGZQpMUU9jLoawpNIoN5VGM6gSeYPusC5inM9X0DHzmJMqhtUsRhhCchIbT/njtpEoVFqgY1+CRTe+MZw3y6+2Xmf0UHcuAPLXp2oyP1xs0Lf13OwST4hUKZkhBIIW6Ige+5Lvrvp4YAFInUH2XqD1yh78zHX1Tai61tVci+wEDDxs+k0SPhLz6nRAKVzFmgXe4/bchO8dBWTs+x/65AdmxAaSY5eRwqm1S8Q1g0PeFMmm2Tt0oFL8/xudQ+t62CmC+Uqn0Oc5bRwfe0Gjc+hF4hkOXrgKAeUbU2LRg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id
 1941C1800230; Wed, 22 Apr 2026 21:42:29 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 01/37] target/i386: emulate: include name of unhandled
 instruction
Date: Wed, 22 Apr 2026 23:41:49 +0200
Message-ID: <20260422214225.2242-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260422214225.2242-1-mohamed@unpredictable.fr>
References: <20260422214225.2242-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=JK02csKb c=1 sm=1 tr=0 ts=69e940ca
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=x0iqa3ucmZZh0HPruXgA:9
X-Proofpoint-ORIG-GUID: GVe91KvhnulYeeaoO6Q_eK2KMilNniQ3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDIxMSBTYWx0ZWRfXwMcxJoB08nlA
 Hanp3pf7eYOTt2z1IRMR/jCzNKnkuItlXWHH4BeKYpL7dRbAtiE0R0qtEfawdtwyMU6c4ltHG67
 aON74e3LPrjB1jKgtuuZI2WqKrMgHjvvoPqDQR4R/0zq+puuXvWqJSxLP2xlh5pL1dj6Nzf0QAB
 vsKNCOQPVwUUukFmoNa0X52LIYGGIx1ZarLv+A+g02pyWzrwHi+wRezA2F2rjg/GVSGtwVxLw5G
 85Kq3DaVLuU9yyAELojAhinsWB4lLD7CPQ2T6V2stBuvd1bDZYakqoDXvfxGwozKYg2M/iK0hUw
 yg/Hkih9442OihyckHIOi/PqP44blczh1CMsT9mgEcUKiFFoSxWULnxk97nQs0=
X-Proofpoint-GUID: GVe91KvhnulYeeaoO6Q_eK2KMilNniQ3
Received-SPF: pass client-ip=57.103.76.113;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


