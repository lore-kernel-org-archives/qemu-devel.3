Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C143F606A319
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 00:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=JG1yzrG5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK2h0-0002pd-HF; Thu, 22 Oct 2026 19:59:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xK2gx-0002oK-Gj
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 19:59:27 -0400
Received: from mr-2004g-snip6-4.eps.apple.com ([2a01:b747:3000:203::41]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xK2gv-00029w-SP
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 19:59:27 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-9 (Postfix) with ESMTPS id
 DE0711800553; Thu, 22 Oct 2026 23:59:22 +0000 (UTC)
X-ICL-RepId: 01a1660e-1ae0-7488-bdc0-db9e9665d54e
X-ICL-Out-Info: HUtFAUMEWwJACUgATUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0PWFsIWwQPH0wMUQJCBVZeVAodBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkIJSgVcB1kAQgpNC1gORQpIDk0AQAZaHx1WEFIAUg9yBVcIQQhTAlEEWBpfCBkNQE4ZDEodUlZRBUoMXABoD10dWBFd
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1792713564; x=1824249564;
 bh=93j8GFn2aIN5NvK8Y1HIzwXcuknIx3xv/zkmLcn737g=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=JG1yzrG5BSa1GSC5Qs2gRqZ62ZrjsGL1HeOcg1HtolJZs2ap6dxcW71nzTk+4zi7qAQR/0B6T2VtlFdSgmCFhFhYPHaBpnv8tRhWYIMfSvlEh229beoQhtICRCMuHqPCC9l/4m+KFVFx7t8i2jYYADqsTUQAK2V3S8fCjyLBIkT3CgmBPq3pLieRn5upkafzz6hF3XpXaXNsn9dMwbW4XtZKbFZwGWanL5I9h0K6zhK4l+vDNuIADhjKIDvOlQx+elyQ0JJJnC0xNoFOgMseK4NESJ2mTsrmexER7y7nCrMO1SkYCm8Y+R5n2NLej/qJu8s5hu/eQ53IepuM2uM3qw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.156.200.36])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-9 (Postfix) with ESMTPSA id
 2B0321800106; Thu, 22 Oct 2026 23:59:18 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH 10/11] target/arm/whpx: handle processor reset
Date: Fri, 23 Oct 2026 01:58:58 +0200
Message-ID: <20261022235859.88753-11-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261022235859.88753-1-mohamed@unpredictable.fr>
References: <20261022235859.88753-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: -yVKV0vH8Hrfoj1Z_mCsq3ZXoCTn1Sj5
X-Proofpoint-ORIG-GUID: -yVKV0vH8Hrfoj1Z_mCsq3ZXoCTn1Sj5
X-Authority-Info-Out: v=2.4 cv=SOVPlevH c=1 sm=1 tr=0 ts=6adaa35b
 cx=c_apl:c_pps:t_out a=9mRn2PO/+PIrVdEbaIuMPg==:117
 a=9mRn2PO/+PIrVdEbaIuMPg==:17 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=loPyruWHUH_f1C729x8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA5NSBTYWx0ZWRfX5Pd+ZtlybILg
 qfd+lI5uXHw4X7hpPuPCESoynhUYJrc3YA1PlG8Axd1+V7HBnRvxAJc+LstpvPW/+uaWHAGQzt9
 6KTRNIjvscMIFD3Z3cfoNL2VLkqh3u0WENADBOw+HSqD4NQvpfzxdXrFk/S32bX9hrXmigaz2jf
 M4qqgWOGMHhhmt8EwycYV/JH6z6DuyFZHeNFxtZnW1rCgl6dUTgjleborzWB59bztSJxfpz6vLN
 uJ/Ysgc/WNLJPPjPZYQhvPY+My0QyrObxuGsOBQ6TlmVTXiMDceUjxmRWrO4NAhsQQB7dcljm4y
 WKrC5PF2zEkskC4ksP0EIyK854m44wbSEcBZcCdzdPwh5ebxrcW+1Js8cy/daE=
X-JNJ: AAAAAAABMfl3BWxmsc4DLINcjl5L3y0acdf7F8/3IU+ETfPNQMdL2JSaAUO4lnsa4Jf7OswLQbPwrhqrA1jVxfUwTDaHS0IDr8A6la+uKn54XOUCShrU3Xrxo1a8b57BMLwWduy5dv4zPjVEV6+AvGRVP4zp/UdzPSc9qNi9WHvRGtZKF5Qz2+daPMfC/xO8rCOsY4fR8RG2GJ4cuSkZWyfLQ/Vbsbg+/cNiAUFWE1vn5gsx79rIwgD18Dq+af1minzjfwT0kFWKQdQtxkH+kZm9zgzWlB+UO+dE+S8naUd2d4ozAXhVGvKd0GwdHekYW+4M7AqxDgIRSXPIuTlKBu7KfJZEJkJCiT6pWJYbiPP2dOzdPhqtH7dfxJV0MVR2YfqPNEbBpNf7Sk8Q1ugi9CNRkzD0FcZSkAIxRsHuxIWzXWLb3TZOu8tq/WNrn0yxU2PHzptpxGkxCaWKtXIZIoa+9loCRcShx1vpEFxkkc00Bzc4CBmaCYnsFNU5GehOnNvThkF5/xk047SuW/E/rUrI2heNvk8PcYg947YmVgr8NtJcqXy4Y94By6+mAxnQwJcZUpC4BiEqKY5Im2HhJuoRvw39d7DZZ+11ccz0xubZTf+oIZqwPfhAi6c8EXM70k+djCmgcnUKf1zAtc8I5ic6oGa60pQ+TNn3jPIzvHt+GhZuDWYZCeTB9Xg5MxaRNljsy5lrk1CSxWsr7adIy2TEc1QDMkuCJHqxbbi2i/JoyA8xuw6MFHI+p/BkjQUEBAF1j0F4pqRCNSF2OpDcU84zQgsYvqv790Hs8sbYKI8=
Received-SPF: pass client-ip=2a01:b747:3000:203::41;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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


