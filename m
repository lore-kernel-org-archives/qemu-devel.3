Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839D4606A325
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 16:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=J6pBzjkw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLja7-0002b3-L1; Tue, 27 Oct 2026 11:59:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xLjYx-0000zf-Fp
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:58:13 -0400
Received: from ci-2002g-snip6-1.eps.apple.com ([2a01:b747:3005:206::40]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xLjYn-0005mB-3r
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:58:05 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-8 (Postfix) with ESMTPS id
 4585C1800150; Tue, 27 Oct 2026 15:57:55 +0000 (UTC)
X-ICL-RepId: 01a17e15-1c73-74b8-8002-5b01377dd487
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0OWFsIWwQPH0wMUQJCBVZeWhEdBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkIJSgVcB1kFQQxNBF4ARQdJC08CQAZbHx1WEFIAUg9yBVcIQQhTAlEEWBpfCBkNQE4ZDEodUlZRBUoMXABoD10dWBFd
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1793116677; x=1824652677;
 bh=Wt2+v3A0tyjKXXqnXcrKOc0Tmb0Ro1PMc/HnebCbEeQ=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=J6pBzjkw+DrCV4fSks/PC4/gCky8wPe8ePVcAoulYvj3Yy8gRn/MGRAmxIOo/ABsSwCk0ZnDsojzMum3HFxgpVYb5Y005t/RXZ4PJmYn/yvblho9mFMAD0F9vj5+FJLLSLAyJ6lCSms81HDQolLbg2eOoGAEZ18JD/kzk/yu9Nj5GP+R0t9wVk30m2BIWmp5amfG0jCVHMi7mHuotRzRmBU6xV3pLMxTigoNZZFVmGt8iNw6+ADWHodQqse0DmCH5zQhyqqoXjJj5hCvZqLXc75hZrgSx5E4rrbECsscz/NbihxoSK+xP0xn2eVEnmcca0Exu/5npiZ6kMn6I16lUQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-8 (Postfix) with ESMTPSA id
 818C818004AF; Tue, 27 Oct 2026 15:57:53 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 "Doug Cook (WINDOWS)" <dcook@microsoft.com>
Subject: [PATCH v2 09/18] target/i386/whpx: handle processor reset
Date: Tue, 27 Oct 2026 16:57:28 +0100
Message-ID: <20261027155737.59271-10-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261027155737.59271-1-mohamed@unpredictable.fr>
References: <20261027155737.59271-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: kmC81Wva6BSvEoqy6qB-IMJOILSJK24o
X-Proofpoint-ORIG-GUID: kmC81Wva6BSvEoqy6qB-IMJOILSJK24o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA2MyBTYWx0ZWRfXyBwwIRILdNty
 GueiWfjTAw9n1aM89sS2xmeLN3pvc+GWA+IqUh7GeEhEgW5p6cG0u/OFgRm6na0etgi4zbjja1I
 Tcyq13kiAlH54+UHJl3h6oUwcudWu9tzEt8l2GyEYQBu/OvZ43pazVjT3E297WkXpgA7IdMmezc
 oROzqJt4kFU2VUpO9UB5UcsNLzAeB+yydgfGVhPtmVi4cKWV4HpVQm6XM6agpZ7rfUf7hYEgsiI
 sk8heE520W7kbKZQInoWz+hlpm0lgbB2vfBHkBQXZAsbTTcIsqNF+c+a1+OalIFPwdE8oWNMhnq
 GNrVwrS0tLaoIIFd3lu5K+w1pN8G6pk69IzcLHpwvakEZ+RjBGXzoMgtZYhlyQ=
X-Authority-Info-Out: v=2.4 cv=Uutu9uwB c=1 sm=1 tr=0 ts=6ae0ca04
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=p0WdMEafAAAA:8 a=yMhMjlubAAAA:8 a=eqzMyDhjfWJDk1Qr7fMA:9
X-JNJ: AAAAAAABYJ9Sz6Q445CGz/B0r6FgN8mokGtOZOjvAt31zeKbfQ/5pOhEF59IsNNaE5b2+a8PAvOZw4aOSMU4IBx+NAm7qztBlR/vOIo+rtTK/ScgoJsL0gnvl6MXhfdsub9SfWLBZpGGzPFACnS3a+CO3uI7Xcihepf6mBRcGgEdDqx1EBMdpDuHFl95B4WniaPgwYdBg72FRK1+gMboIGAKJnirB997jlVAXj6I0cO2i7TfMbGlzgEEdBglsyyJYlr7AG98z8rJRrJEEplYdPCeDBvObedd8f9lkBvfZvKEA5kcy/yvbvUDHPGbDpmKUtf62ikzdpE7nap01d02r8lpqk02x7mG3/KnAzTx6zamlGimCD8g21EfBW7A5tCyjck7dviQuFSeQCxLpd130IJQGroXlF5Oj5s/x6mYdc3y14juIjZXeB6TwipHWHQF/k+Z1Fl1kvDZL+KszqnWnuWzGeSqFkjHMxVu/+2hlYlhw8QtPFVEYrsdM6pOWNsgX3JBgNcdpngHX3DzCZsHy8ZsqnK0URCHXHDhX/kLY645frS+QjzLQYXIlrqKdA3QI5Q6Ouzgw1gVU+OHT2yojSetQcDVNc/Q57f2dz0O+D9ajWzYufKpYgijjQYlyEenU/YrhhuWbPWfiOuVhrbwy0aw5znF2ulKkYWPHMnMOUEa3ch2YQjknaMJYM0ooXzsCGlCH6vNI1oNnKTQFbeW017HEGee8LPwrAFzQbRH/w0Mu662xD5+mD4uXjb7ZpddykFSaEabHVchN68OwHaLszrv8X4KMCx289PVhhi4WJHzNUpFpn+Ok+0=
Received-SPF: pass client-ip=2a01:b747:3005:206::40;
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: "Doug Cook (WINDOWS)" <dcook@microsoft.com>

WHPX is not properly handling processor reset:

- Does not reset partition, so several registers (e.g. Hypercall,
  GuestOsId) carry values forward as "Locked" into the next session.
- Does not clear hypervisor-managed TSC deadline (live-lock).
- Does not re-arm the wait-for-SIPI trigger, so all CPUs start running
  immediately after reset.

Some firmware may tolerate this, but OVMF does not. Typical result is
that boot hangs or ends in triple-fault, e.g.

  qemu-system-x86_64: WHPX: Unexpected VP exit code 4

After this patch, I am able to boot to Windows desktop, reset, and boot
back to Windows desktop. Tried many times in sequence with no problems.
Used several different reset mechanisms (OS shutdown menu, external
"reset", watchdog reset) with no problems.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2402
Signed-off-by: Doug Cook <dcook@microsoft.com>
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 29a630b03c..6b00724ceb 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -541,6 +541,35 @@ void whpx_set_registers(CPUState *cpu, WHPXStateLevel level)
 
     assert(cpu_is_stopped(cpu) || qemu_cpu_is_self(cpu));
 
+    /* Assumes that cpu_synchronize_all_post_reset() runs cpu 0 first. */
+    if (level == WHPX_LEVEL_RESET_STATE && cpu->cpu_index == 0) {
+        hr = whp_dispatch.WHvResetPartition(whpx->partition);
+        if (FAILED(hr)) {
+            error_report("WHPX: Failed to reset partition, hr=%08lx", hr);
+        }
+    }
+
+    /* Reset hypervisor-owned TSC deadline. */
+    if (level == WHPX_LEVEL_RESET_STATE) {
+        WHV_REGISTER_VALUE tsc_deadline = {};
+
+        whpx_set_reg(cpu, WHvX64RegisterTscDeadline, tsc_deadline);
+    }
+
+    /*
+     * Re-arm partition's wait-for-SIPI state.
+     * whpx_vcpu_run() ignores cpu->halted, depends on SIPI for this.
+     * This must follow WHvResetPartition.
+     */
+    if (level == WHPX_LEVEL_RESET_STATE && whpx_irqchip_in_kernel()) {
+        WHV_REGISTER_VALUE activity = {};
+
+        whpx_get_reg(cpu, WHvRegisterInternalActivityState, &activity);
+        activity.InternalActivity.StartupSuspend = !cpu_is_bsp(x86_cpu);
+        activity.InternalActivity.HaltSuspend = 0;
+        whpx_set_reg(cpu, WHvRegisterInternalActivityState, activity);
+    }
+
     /*
      * Following MSRs have side effects on the guest or are too heavy for
      * runtime. Limit them to full state update.
-- 
2.54.0 (Apple Git-157)


