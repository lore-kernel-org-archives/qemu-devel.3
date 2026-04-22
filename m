Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC14FA1FFC
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 21:47:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFfLX-00082u-4j; Wed, 22 Apr 2026 17:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFfLV-00081V-Dd
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 17:42:57 -0400
Received: from p-east2-cluster1-host3-snip4-10.eps.apple.com ([57.103.76.13]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFfLT-0007FU-TI
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 17:42:57 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id
 47B5918000C7; Wed, 22 Apr 2026 21:42:50 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRJAU1fDl4fBBdGGVUERx5dVkAZGQJRHFYNV0NUBF9QSQxBUGxaAEcXSB1dGVlvUF0cDhhZG0AVXRFQGVYJXhUXHkFNWgJWTQVKA18BWwZCC0oCWQVZB14LSgdfGloAXVQXWwxaDlYwTBZDH1IPWxNNGVEBUkVUAgdYRxRHDg8TTAtHAlo0Vh9UGVoD
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776894175; x=1779486175;
 bh=90DXebKcXq4ywVPqb9VJW4/s7sJzsLUwFClfg34UOKo=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=f17MqGyU9Xgv6xU4nwNDGxv4KvF/7Hp9WeaK2G15mWw/23V5+xom7iLsz/bc2bEn5PLtO7J9paJIlQCXRcU4aEetZtJFKEkSMlUSNeandO+3iJp0zVJmeS6WJKeYHXNNFr6Ronntl/aEVoIUYx93iJXaHW6J6HvLvdzlmRhEFZm/iQNs/FKMN0AT49Q29pXO1/N5jEvbpG5nIf/iDH8azaCVhzBD0NzxvHGU4RFfSNWEbBYZYG4EdOslmStX7p3g+sq4jVfqfeJ4oj6dZimqXYsmRtyBoFdMJospndhcVfWwwEbAcyHefTgrIVBhZURno6s+GlAgTF9ZcTni3tXMmA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id
 A7D8C1800950; Wed, 22 Apr 2026 21:42:48 +0000 (UTC)
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
Subject: [PATCH v3 11/37] whpx: i386: IO port fast path cleanup
Date: Wed, 22 Apr 2026 23:41:59 +0200
Message-ID: <20260422214225.2242-12-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260422214225.2242-1-mohamed@unpredictable.fr>
References: <20260422214225.2242-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: O8y9kfFCfmBiRkUtlYAO9Zo12uvLL97i
X-Proofpoint-GUID: O8y9kfFCfmBiRkUtlYAO9Zo12uvLL97i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDIxMSBTYWx0ZWRfX31qEm/uhSh5F
 42bs5uJP1abdyf9e0APnvam52AFfb49AXdCpH+m5GiuNFIVafCfoyQ+WQB5v4XwGty7z6MsWRaT
 hJwCAFb1ngRsb4yDCCtIjTXDXwHOJ/Cd6QoFJjsMNemdkWYVQfPo/E0qbuBxyHqxLzH9EZ1E8Yj
 Nzda+Fwtx/666VZiJdWGf5+7MCAOj2rtpGt5zmBPuiATETdrCvijlK6djgALOdYKfZPolMK+hhh
 pmGDMPheigraiUMECPCU84hqITZk0Wu/jEvUmFc5a4kiOhuwkkAAQZtMneNCf9qW9wo5iF1Ipt9
 G/9VH6EGHEGjziGbbkBpLEUaMa6By+E7e0pQNf2JWTlBEbRuZbGrSIg6Vve+gY=
X-Authority-Info-Out: v=2.4 cv=I8Nohdgg c=1 sm=1 tr=0 ts=69e940dd
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Vrzv6M8N8vcM0KmfSJEA:9
Received-SPF: pass client-ip=57.103.76.13;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
index ab8e97787f..75f0f062d4 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -881,7 +881,6 @@ static void handle_io(CPUState *env, uint16_t port, void *buffer,
 static void whpx_bump_rip(CPUState *cpu, WHV_RUN_VP_EXIT_CONTEXT *exit_ctx)
 {
     WHV_REGISTER_VALUE reg;
-    whpx_get_reg(cpu, WHvX64RegisterRip, &reg);
     reg.Reg64 = exit_ctx->VpContext.Rip + exit_ctx->VpContext.InstructionLength;
     whpx_set_reg(cpu, WHvX64RegisterRip, reg);
 }
@@ -909,13 +908,23 @@ static int whpx_handle_portio(CPUState *cpu,
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


