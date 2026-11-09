Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86653606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 00:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=M8vV56hH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQDS1-0005ml-49; Sun, 08 Nov 2026 19:41:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xQDRu-0005jJ-OL
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 19:41:27 -0500
Received: from ci-2003j-snip6-3.eps.apple.com ([2a01:b747:3005:200::60]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xQDRr-0006MO-F4
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 19:41:26 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-2 (Postfix) with ESMTPS id
 D98F61800159; Mon, 09 Nov 2026 00:41:17 +0000 (UTC)
X-ICL-RepId: 01a1bdc0-970e-70df-9e06-1466b9669911
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQtMHVUDRQtBF0AGTVIPDx1WEFIAUg9yBVcIQQhTAlEEWBpfCBkNQFBfHA4YWRtAFV0RUBlWCV4VFx5BTUUID0cZEFYBWFZdBU0aXBhZDxwTUFZaDlsERxQXG1wAFxtGAgQjAl8ARQJeCVYBMBcPVk1MFkMfUg9bE00ZUQFSRVQCGRVaCQpXAEALTgJcB1ICQA1JA1UZUwdICUAeVBoGXRhYFVYJdx5cAEsdVwRUH1MSVR0dC0VVEgRACFZQVB5BBFYVbAlYBlMZVw==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1794184878; x=1825720878;
 bh=7tPPnHKP+B9aIxYDisiG9Yiz7gpVwqI+5XekoasBmXY=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=M8vV56hHIDUr8JjjCZDqd7VD+o0ORTLDmDaWV7+whrZ13ompiW+Gr+OMljfQTo9JhbdD9qfpaDrURcnhDKY1p9QnMRytaEmsqJj8gf2kTj476xm298JtG7rBNzU+aTKSx+rr/OgEKj+qcKyxrUYay3vqS/ErCEu3NbCycVV64pFpxhRyO4LCnkqMiqhCGhPqkdj/K4BuRTGsz0unB/zXVmPpOGNIzwSskUHtGCNqNMxnmBXJ9AJToRg2JriUa5kiO3s9KheQW+EsVPnQPPm5pPw/GuCUng1nJDMAxwfKsugUZMfdOW7bON2L88iptDaMqt78Q1ukg4Dx1riXZp2ePw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-2 (Postfix) with ESMTPSA id
 0D83218000B6; Mon, 09 Nov 2026 00:41:17 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-arm@nongnu.org,
 "Doug Cook (WINDOWS)" <dcook@microsoft.com>
Subject: [PULL 08/13] target/i386/whpx: handle processor reset
Date: Sun,  8 Nov 2026 17:41:03 -0700
Message-ID: <20261109004108.85808-9-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261109004108.85808-1-mohamed@unpredictable.fr>
References: <20261109004108.85808-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: d07mPBDoiACopYbzC28vVFpFLzaWcQDo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAwMSBTYWx0ZWRfXwkZNn+HIp/dK
 y6f7vqmUqku2EKEg9vcdyA9M1K1nVw/92yCa8ANOVX7qKS8PFu9A/BOEmZbr3UJ8PkbTmWfa3+N
 9eYGIzbwmI3dsgUbDH0pgb9rP0VmwXjOnHq5YgEd0XFmE1WlN5/s6C8XxqgGKZpI9erI2KApQk+
 M9DlG2uNLodT2MKcbwP5o5kn+kqmO6S40DIRjy7iqYH/20XHJjcsIKf/0kuV/XjKluxX3u1hlcK
 +kpjsuwAYDVAcuS3KjAy23IprXLUwM26eV15EtTOGol4xxaTY/qn5+Zbu8iGxHtY/qSDlp1lM0D
 SV3BO81e7Mu1Sjgls9rOxJLSA2ZyrJVfD5Dfzl9/PfPM6rFO1SN4xXwol4yN7o=
X-Authority-Info-Out: v=2.4 cv=X5Zf6WTe c=1 sm=1 tr=0 ts=6af116ae
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=p0WdMEafAAAA:8 a=yMhMjlubAAAA:8 a=eqzMyDhjfWJDk1Qr7fMA:9
X-Proofpoint-ORIG-GUID: d07mPBDoiACopYbzC28vVFpFLzaWcQDo
X-JNJ: AAAAAAABd91ejgvxyE698n+C9h3a14zVZaMTlRTFK38coTUZCZ23ZbXuFphBJVeaesbOie
 ejnxhu94/p3TkbuWh2VLJXUA/WrodX864N1qRKdTT7FlqfAWswgoy1z520P4/5zAr7WNtD
 w0uF/bJfm5UNzRQujDxtbA4Mdh+Ns4BgF+OUzkET0b1SXu1cjPrUeqz8aH9TDNGZu5RQny
 QiyD+OgGopIq/hG+p3DT4ZfuIVzw7136+Pz+vWyKm4/8aIHaqb1r0798cwDLUCW6PHfk6E
 22Xl1pkh7p74Y8Vd6i2PLFwMOKba+R1VUzk7QZgNldZTjf8bAYEgcmDJduvknDMntgeDmX
 W5Hl16CiGogIzAii9ZSS6onotuqJdGb6CJKsCYnepH1i7jmwLnuMOQY3oBSO5UWtHMxZkn
 RTLT291cF/X8WO+RzdfZsf7u1rzuCZ+MXwmbeDMNc3sWcndKL8F+0xjUBOOOVY9n3R4Fbk
 YAAFdN53avOyuCRFcvGI2UVCN+kKW9+roo55wjBPs2igdm/9c25iefeI+4BtPnIJDpgu7K
 TWDmpHohNGcZIr52sqcLTY2Hsn8iP+6cpt2LdNnv6mjFtUjKD17n/W5MMfkeshg2T4RP7q
 6g1wYSkfvxfGMnMURavqHzURFTKUAttq6iileUbyP3fgBmrT2GfMY+fY+ZukwHGdw4Fwm8
 EuA5PF3sv746FYpKm/lH9/j7B+WSajjIh397XNK5qwYq7tNK7Ui/+ZVZgR8MhF8RQzmhh4
 PtzGIruADRUvJ8fkzx6xwuKSIeCR3HapjRjza2ucQ1rmTaQXpYU4/2SPR5mNudcg==
Received-SPF: pass client-ip=2a01:b747:3005:200::60;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 8807a7b95f..2a91eabc10 100644
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


