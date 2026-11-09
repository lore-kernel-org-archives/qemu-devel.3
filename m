Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A01606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 13:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=OLjmhE87
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQPT7-0004hS-5C; Mon, 09 Nov 2026 08:31:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xQPSc-0004dl-UI
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 08:30:59 -0500
Received: from st-2001b-snip6-11.eps.apple.com ([2a01:b747:3001:206::15]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xQPSY-0004Zy-LF
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 08:30:57 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-10 (Postfix) with ESMTPS id
 342671801362; Mon, 09 Nov 2026 13:30:41 +0000 (UTC)
X-ICL-RepId: 01a1c081-0023-77f7-926b-03e3e9828551
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQtIBUMGWgReC0wHQwJZEhVdRV4CXwpfFV04RgNHGVcUUBtHDFUHV15fChMLU1ZHHkkKVgleCEYRWxRWQ1EZEgJaRQdNXw5eHwQXRhlVBEceXVZAGRkCURxWDVdDVARfUEkMQVBsWgBHF0gdXRlZb1BdHA4YWRtAFV0RUBlWCV4VFx5BTVoCVk0FSgNfAVoDQABJAF4HWAdeDkELWBpeHx1WEFIAUg9yBVcIQQhTAlEEWBpfCBkNQE4ZDEodUlZRBUoMXABoD10dWBFd
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1794231045; x=1825767045;
 bh=+S++io4VssG+rPTlzHX32ycxfzct3zUCdoQhTzuuREU=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=OLjmhE87EJuA2IxTXZUkO2dl0TzyGXtfWQJWar9sBfRPlJqaUxFreyYlhZd+cJWp7kUv8bYz6zr04VfNrlblj16KNvrrN1Q0BIVzGMWFmVPYXa/KGtZUcE4wcMF270l2qyFB4O6oUsCT5x9CrAlFy7fxn73uHqJw7xsCtLrLqCEoztB/6F6YEnshdur1D50g8Es6R9fUN4xY4AVXJzC4dpmogOoOmx30NOZ2BlWC1pKKgnTKzpWKRn5OIgYpmvnwapWTZ3y1ROSYKdE4ZaXEVM7dCriowob7qoyJl9QTU6YOQYwM1kWAu3zTEHKNV+wbCXfGfucYvkiv3TMAxH0eIw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.156.216.30])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-10 (Postfix) with ESMTPSA id
 D925E180196E; Mon, 09 Nov 2026 13:30:40 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 "Doug Cook (WINDOWS)" <dcook@microsoft.com>
Subject: [PULL 4/7] target/i386/whpx: handle processor reset
Date: Mon,  9 Nov 2026 06:30:32 -0700
Message-ID: <20261109133035.7985-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261109133035.7985-1-mohamed@unpredictable.fr>
References: <20261109133035.7985-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Ol3aB5SxrWp76yC9kJlORhdYEpvGP5Lh
X-Authority-Info-Out: v=2.4 cv=ZbUQ98VA c=1 sm=1 tr=0 ts=6af1cb02
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=p0WdMEafAAAA:8 a=yMhMjlubAAAA:8 a=eqzMyDhjfWJDk1Qr7fMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA1MyBTYWx0ZWRfX7iBGErSbhvXi
 p71BqxC3fphCPAC7CiZ2fgSxbVLta4s32w7b/ulDLqZVXigw6cLGkxODT++3KqELSUEsZzwcMdK
 G1FdIGcID+lev/0FVX4CCQ6xZEZn7uMz5gSyzrmvWZhjkNFIt9djy10rA/eoGJ7h1ZfQPm6DydU
 WjR1wz4RWje/lV50f3KGdcLVigtcleRfMu4QOessZS/oPtb3Dv0l7IAa3/1CRGSaKtpfFf8vMQu
 DJ1Z+0XHuohCTt9+dn2+uGiWTHkCAm20yCnjsOzCU72rwRhPLekmidY9lfGsfn1nH2JLmu8unR1
 8Q+Y3eXW0ZQ98MVe5KizGY3XOgfADBjr901gf8A4CTbWkpQPNsJFZG9RSt2KgA=
X-Proofpoint-GUID: Ol3aB5SxrWp76yC9kJlORhdYEpvGP5Lh
X-JNJ: AAAAAAABfxVQY3/Ag7I9U8s7DWLPrIjiGxfEXEjIJtXatHfCkgc+mLGmH2/sLv6UWmNb/R
 Jsb46EoB6jwjNb1Nlfc+oel78ThLPxx27mhHkJCXkbtcqGQNWaZx+Y4gV7cEW9+W2I2dPh
 G/jbjajh7EiYUbA1m/TkL3mdgedR5CDUaiJifMYY+xMb/3mHQn/Vtp1UCIF2sAP3Vuc9of
 SUyOQPKMU609rOuVcvOK9w7sp2JybE+2NKBgOiJdVQ7245AO4T7gELE+236PPvNuFZcq4E
 fKSwc6zqLt5U9i4bmqm3ymXk82B73bGjxyPvw34aIiL8PLbcgQa9r5kJCJlMs+49AzB+sv
 0yXMxM8iqO8HhmJsLrr1IAppULd9bjvdh4xdGXe5iIHg3rytUlh9MYK27qNpFrtMWUdspd
 I1/w4Qg5EFb2JKke+PuOg4he1afGB+z4F9NIgSchKIB8XyNGPFMG5J3kjwESPDfLgah5QY
 PA5tCBnIZ/ni/q5MxIAGC/EqhT0iEvtgCoVB8iHdYJHbB03FS8GU31T4UavAgX9G5curiV
 jEoTQf3dLcHT1G393YK1acLiwzOeoqRTMHbvnGx8Al/0Yubal2ayxa99rzW2snkKGN4HwU
 onF1QQOAyC3GHdd9i6AoeA9xinp3KOL+tMSCyW+PgEeeioSC7wN8DKE3ivHaIXRUhKs1Ym
 7QLhysz8pwQpQKXIT+JG2IlMycJk5wyOF0NS0gePAP1a5zDFrwn1nhOjKgKO6o1U+9CqeS
 1Q
Received-SPF: pass client-ip=2a01:b747:3001:206::15;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
	autolearn=ham autolearn_force=no version=4.0.1
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index fd3b2acb58..366de31273 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -528,6 +528,35 @@ void whpx_set_registers(CPUState *cpu, WHPXStateLevel level)
 
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


