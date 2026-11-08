Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC352606A321
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 09:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=FlPBgVXt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPzca-0005ry-Mp; Sun, 08 Nov 2026 04:55:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xPzbP-0005SA-0A
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 04:54:19 -0500
Received: from st-2004c-snip6-11.eps.apple.com ([2a01:b747:3001:201::1f]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xPzbM-0005zE-Hh
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 04:54:18 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id
 365C418000A0; Sun, 08 Nov 2026 09:54:14 +0000 (UTC)
X-ICL-RepId: 01a1ba94-75f9-7b32-9d28-7dfdee9b4b4b
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQtIBUMGWgReC0wHQwJZEhVdRV4CXwpfFV04RgNHGVcUUBtHDFUHV15fChMLU1ZHHkkKVgleCEYRWxRWQ1EZEgJaRQRNXw5eHwQXRhlVBEceXVZAGRkCURxWDVdDVARfUEkMQVBsWgBHF0gdXRlZb1BdHA4YWRtAFV0RUBlWCV4VFx5BTVoCVk0FSgNfAVoDQAFIClgDWwFeDkgLXARGC11UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIHWEcURw4PE0wLRwJaNFYfVBlaAw==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1794131655; x=1825667655;
 bh=wo2d6b0m6ni1wsjawaHa8l8pEvNeTotsxA456Vufm2I=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=FlPBgVXtPzA6B5TSGYfDukjEOywrDneoBvCOvswmdC0Z798mjcoqiw1/7bAid4ffmBnjlf7P/uv61vIa25GEOfWi94K/sxE2KeNoemwqg+GmOX08NDDVczdTTvDswJCXlixJHn4mhknz4ab/zY7otss8NaNiKOYvn8pVIODYiPP3blSD3CzTQM1JtLZL4tZFCfKbnzeqAUMBYIHMuxdvjDy8/WymZCTtPfqWJ2muLTJUpcQg2qU6T0FtWGNYV2o0hSWPJCUl2m7A/ZYIbv3WaAp63VlT7hHqXd2n4/vA8ZnAH8Cv7ug4TEqMY1LJ/oiNmqUTffSkeRqqD2hwn1dxrQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.156.216.30])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id
 E5EAE180019B; Sun, 08 Nov 2026 09:54:12 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "Doug Cook (WINDOWS)" <dcook@microsoft.com>
Subject: [PULL 08/13] target/i386/whpx: handle processor reset
Date: Sun,  8 Nov 2026 02:53:58 -0700
Message-ID: <20261108095403.70813-9-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261108095403.70813-1-mohamed@unpredictable.fr>
References: <20261108095403.70813-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 6hd7SpMIGGFtbFAMk20RfsFtAAmKlb18
X-Proofpoint-ORIG-GUID: 6hd7SpMIGGFtbFAMk20RfsFtAAmKlb18
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA4MDAzOSBTYWx0ZWRfX9Zr0lPXJas9J
 seO3Bj56Asol2zvgoOrN0eH6x6RuLMOF6GDXDVUuJtAdvneEWYrH3k1Aic1MyX/xPJa2jQDg2kK
 P9dcSZCP3aNIJbTwzbJx6pzG4y3W/vkWECuqV1kgmewVzMYAPzlzwShsASCcVlWlnneAbA69xmE
 fL/E7lgPweSkonJoKM/2xM9uKXI/BoLQf5fy/8PlZAVNi3DkMrmk+3whOvsDgha1dnrxBBrA5bn
 tSFxKRp9UO80s/FmMhPR4t5S4kzoCOHmtfBNCfXFDsbPgvC8BEwaf1HA7U7TpMGznOMBKHpS52/
 sX8dtqL95OEl/Cn6SlLXcBRWrK3qrriF1heQh7hrqCgyGGckdvX8Ax9oAltTXk=
X-Authority-Info-Out: v=2.4 cv=QfJrf8bv c=1 sm=1 tr=0 ts=6af046c6
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=p0WdMEafAAAA:8 a=yMhMjlubAAAA:8 a=eqzMyDhjfWJDk1Qr7fMA:9
X-JNJ: AAAAAAABWrmwPAwpnJQT9v130BeZygLoNiQo/rKAbMb03dwGzaFmwGpppma2FurMCgrKaD
 klZ4OQQC8w4y7PJ2o8W+XqqFC5Q3R/yMZ4pNmqpxCIVRU4P1C8bJSYVPgqCwr4frVMJPyD
 5VUugSXxoYTR5/ZxAaR2gjz2ybACq3xFC8ZJmfW/Ku9/aCh7N4r22x+J2ywo3jbpZ7rNIy
 clZ7JBKvgXTr9nMtGoEU2U/+myawLHmpEs4Zkmt8Vao8YM1YAAY2qKaIdThdeMX3eH6oYb
 +tzoigL7IdxCw/c0qS9tMI6fS0bkUW8CeoulChDvJlgEt+bjQESCL+jJiYXLzhuH8twq3B
 OD1iFBTaLkalXD7yv6hQBKOWwtIlfK0deG7rozsz0Ta8UQlhsDxIFQ+j3dqlFjLt95IUl4
 UR0JJxC3XSBItHVzyJA+CIH/u42jA5fZsAYK2kpfW5VYhAOj5rLJWO1kC3b+0lw9gMy5vD
 LEOko+0EHdYXcHMwLu83hBijRju/QTinoSHTKRtklxLGTKtvbIkgAB5Wtn+YCrQAqLICUA
 GgS1eiSca1iPRqsIN0Pejm9MsoEWl+1Lo7GjVrPLwgcdxfMpDOwiAJDQKlURlA3SfcMNxA
 OA/TvUDMxfjTO5wqZLR7goOQZ+uQDwMZaY6Sa5h0Al4oHLmcSrmEhMJCFev7Y3D10eViMh
 x14zyh/tqpSv/Qvk2LfNhONp0Epslg/dOTxkcyCOAgtr4ASuLu2Xvsi6n0kRGh06Ty2KdU
 lkGBRcndXh6XAk0o6sxKC5npdu4yYami/mWF0kfo7BCUAp0Z8o9tp9vkaE5Fj2ilo4vh3G
Received-SPF: pass client-ip=2a01:b747:3001:201::1f;
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
---
 target/i386/whpx/whpx-all.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 65e56d32fa..12c6c3001e 100644
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


