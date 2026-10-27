Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6379860A2634
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 16:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=K8KfyWfq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLja1-0002F1-5x; Tue, 27 Oct 2026 11:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xLjYx-0000zs-Ld
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:58:13 -0400
Received: from ci-2002h-snip6-11.eps.apple.com ([2a01:b747:3005:206::53]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xLjYp-0005mW-3m
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:58:07 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-8 (Postfix) with ESMTPS id
 440A01801A4C; Tue, 27 Oct 2026 15:57:56 +0000 (UTC)
X-ICL-RepId: 01a17e15-2063-7338-aa69-c25445e79077
X-ICL-Out-Info: HUtFAUMEWwJACUgATUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0PWFsIWwQPH0wMUQJCBVZeWhEdBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkIJSgVcB1kFQQxNBF4ARQdJC08CQAZaHx1WEFIAUg9yBVcIQQhTAlEEWBpfCBkNQE4ZDEodUlZRBUoMXABoD10dWBFd
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1793116677; x=1824652677;
 bh=93j8GFn2aIN5NvK8Y1HIzwXcuknIx3xv/zkmLcn737g=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=K8KfyWfqm7KCFAKnZ0HYUsq+n/eoT4h2o5lpGwA+kSd9tOfIR2uTkLAguuDgYeDmIUoB3rEVj8/GrTA3rwLXIFF+jn2fxUbf9z7Z8IrSkZeqQnwWl6HtHzGxuFQTswXOEenmFkUl/rjO2Bf0nR216MfQ/13iS4zFeoMCh0bZPQo8yhxAw02Ev+RpVK+yw7SpyJsl33JjmZkTypEWIiTpUqrGsmEOKG7/lCZIRkOM5AVR6S0NEmbI/bNJL2Uug2Rb4nRtif6SeYsIwofv4akHeSo9XiizMAHHCooG/ENJ2nVB6wL87yqcfh8n0dPE/CZCBPg7DbAIhoF4QxgN021lUw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-8 (Postfix) with ESMTPSA id
 C870C180012A; Tue, 27 Oct 2026 15:57:54 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v2 10/18] target/arm/whpx: handle processor reset
Date: Tue, 27 Oct 2026 16:57:29 +0100
Message-ID: <20261027155737.59271-11-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261027155737.59271-1-mohamed@unpredictable.fr>
References: <20261027155737.59271-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Aoa6IriANDjy3cWLXlgRXHweopZrFFco
X-Authority-Info-Out: v=2.4 cv=CLYnnBrD c=1 sm=1 tr=0 ts=6ae0ca04
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=loPyruWHUH_f1C729x8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA2MyBTYWx0ZWRfX2uGwOBTNO5Cu
 gGDKdIYoMh5GX1XH5ywqvyLoNgp6LWn237yeewS/CtPnlEFOxG/lsfVCLJq7c02Ousjxmd9zqp3
 GB9GXyp0LwW8F+Wh8WdVK1qpU7aeaOgQMk8XdYovTGw1w9B+x8wqrEPcHk34GGpKRLC6HrBvVLf
 PjaDyLj4FCbN5+XmTMGwxuGR5hFls7Edsfz6q2+FHChlVotMjS+dxRp/zPC4n2/0wi7q8ort1Tb
 vRa/rUQEp0Zx6GqblJ7lgDuh3kafxRghwFfob1XEwgUl5loY7Q0BYO+2zZ50FuE2a7Gpwj+N7vw
 J4nxajjOhEMkEuYIs8pX5DODaySLCEqcKvKsW/83DzwdaKP+16wDwaqW7ORkTc=
X-Proofpoint-ORIG-GUID: Aoa6IriANDjy3cWLXlgRXHweopZrFFco
X-JNJ: AAAAAAABG8JYW8uvRVYoTLeF2EzSnXa8ZyHFOWGwSVZqfEEeoKkMSj0Q1cri4uzopsAYV5436A/3W8Hn7dek7ZTPtF8rxWVVVLW7M2NsA1/mA2egMDDZftNochVNI2quzJISv2G2FfU4p9JgJ81/BlcaHrclpdRy5VOFft7++dBxpxVvrn4ez/SA/ZQ3FTF1G7S+IKHgTsNmI2M1Ds6XqhRhO74leCs/DFiKElUGQc/2DC8BDL9SwRXhWQpUeQWPfhd2raazHhrcFqk/cMcLJecp1uCVthrKZvdtPHwcK0IbqS+iTpNkiWXsvek0ZH/wl3w+fwuT0Mfv2zVDID2nw1pOWKZFTbEkYBDFbPaXvMszIMM0KTxmXDrSO5eJaAR29b3jlv19eEVr0k4+Ppd8SUJiXLrIZS9gCrluWpII2/qHhBF1pwWC8e6xfTFQMtAFVj9S83Jy7tVAhHdjGMB9l3zrUHXsjCDe355kBAL57egAOVvy+8jMSMkD6HT9/p/Jfi5pV+X1r21nQEoYe1nzuI3Lw9i1F9hkv9ffYqECFyfO4Pl+jNOYXEuYZM07n0fUsqOM1MKe/XZUBOiGZ6GS1s7pYN4cENqJbmOJ6DslB9t7u+Y1rD7FxCQN8w+PUxHSWY+3c+7Q3aNCsvxmMaategHM6/HudszoIUmzCW355VQhUMr36zgQve9ESr2bqkUYq8/lTpG2JcClZ8L1FgoQmLqWuFnypesFSjxQ4OZVaggsiGBNU/ET4whZBODztE/CzEbXMl52Fo2V3RDXf0xOVVpjvt5jByBGzzsk70BRPyYz9D6JHz0oibHY
Received-SPF: pass client-ip=2a01:b747:3005:206::53;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Move WHvResetPartition to where it's effective on multi-core configurations.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/whpx/whpx-all.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 46f0b9524e..150a6326d7 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -471,8 +471,6 @@ int whpx_vcpu_run(CPUState *cpu)
             if (arm_cpu->power_state != PSCI_OFF) {
                 whpx_psci_cpu_off(arm_cpu);
             }
-            /* Partition-wide reset, to reset state for reboots to succeed. */
-            whp_dispatch.WHvResetPartition(whpx->partition);
             bql_unlock();
             break;
         case WHvRunVpExitReasonNone:
@@ -573,6 +571,14 @@ void whpx_set_registers(CPUState *cpu, WHPXStateLevel level)
 
     assert(cpu_is_stopped(cpu) || qemu_cpu_is_self(cpu));
 
+    /* Assumes that cpu_synchronize_all_post_reset() runs cpu 0 first. */
+    if (level == WHPX_LEVEL_RESET_STATE && cpu->cpu_index == 0) {
+        hr = whp_dispatch.WHvResetPartition(whpx->partition);
+        if (FAILED(hr)) {
+            error_report("WHPX: Failed to reset partition, hr=%08lx", hr);
+        }
+    }
+
     for (i = 0; i < ARRAY_SIZE(whpx_reg_match); i++) {
         val.Reg64 = *(uint64_t *)((char *)env + whpx_reg_match[i].offset);
         whpx_set_reg(cpu, whpx_reg_match[i].reg, val);
-- 
2.54.0 (Apple Git-157)


