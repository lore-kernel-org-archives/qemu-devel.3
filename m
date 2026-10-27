Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230B5606A336
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 15:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=lyqB4RVN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLjZn-0001de-GL; Tue, 27 Oct 2026 11:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xLjYp-0000vk-3w
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:58:03 -0400
Received: from ci-2002b-snip6-11.eps.apple.com ([2a01:b747:3005:206::17]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xLjYl-0005l9-Tz
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:58:02 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-8 (Postfix) with ESMTPS id
 E20A51800F72; Tue, 27 Oct 2026 15:57:49 +0000 (UTC)
X-ICL-RepId: 01a17e15-078c-7ba4-8155-f8fbcf4fe53d
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0PWFsIWwQPH0wMUQJCBVZeWhEdBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkIJSgVcB1kFQQxNBF4ARQdJC08CQAFGXx9RGV4IUytHHkkKVgleCEYRWxRWQ1EZDFBNAUMICghHA00XXjJTBF8RUBY=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1793116671; x=1824652671;
 bh=nVK8vDM8XzoQ7gU4FL1Cwxgq28hF7I8+bUQSMNiuXqA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=lyqB4RVNF7SfSCcCE2pmtmd0EUPQ2gl8k4yF2eI92tcusvzNdYpKO/ZDpILwBPEvzE7KCJ69qZ1bEskvoVC8QYo3cch33nHf6b/wQqVHoZPfdIQ1pQeyK630+f/gMh2UAnewq3Hn94E76x3zASm5xtv4r9uZ0FRuJnX42e0Ju6WtCEwzJ9jDED2+D6kSZi4m6nQiijuHjsSN3tZSttt0dld2/zD4Hkr8jNIHhaZgM3fkCwArSSqFA2oq2eKje91nuttp/wlEhPXR0I8eSnspBB756rIoFHXXefdmb6O0rh4z47JYA8RxlV7OdGf+MNvlbja/WMjmDo2LKez82vKDbg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-8 (Postfix) with ESMTPSA id
 186AA1800135; Tue, 27 Oct 2026 15:57:47 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v2 05/18] whpx: i386: save/restore xss
Date: Tue, 27 Oct 2026 16:57:24 +0100
Message-ID: <20261027155737.59271-6-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261027155737.59271-1-mohamed@unpredictable.fr>
References: <20261027155737.59271-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: WnJKPNFcv7s0zLxN77zkImLaU7AI_IQB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA2MyBTYWx0ZWRfX00VYKJIv/AOa
 TntIsjrXIg7dPKTSz96zaSGPaIbLh4BsvF9TztDjxiodEK927/xUyI+qFAKcUb1mWaShi4+pJl5
 qbiTZJKezN1Qr0GE10dziMxBMpQKAXv43lYrrxRHMWsOCHZPwi4o+Qa7Gg403B5OKRk4BDVpE1a
 A55HPnXL3tjBIupJRI0QrlZqtkcPFkn9vTOhTCi2/+hS3/MEUocHDAx+gB5Vmjp9Wnce3PCtiA/
 9AQKZSx4m0W/x7BxoB8xo6RbJ3VRb7RwRu17cFYKeY+H9n++s2FTRwZb/9H+84Pafyj8Lc6pZ5o
 f/Aq0J1xBY8gBeGaJ8iwfkT2CtGr/W+AnKq56DTWtYQ0ew+tM5Wh2Xv7PIxKJE=
X-Authority-Info-Out: v=2.4 cv=M49A6iws c=1 sm=1 tr=0 ts=6ae0c9fe
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=vvjR5Bv0Qg6bciTORDEA:9
X-Proofpoint-ORIG-GUID: WnJKPNFcv7s0zLxN77zkImLaU7AI_IQB
X-JNJ: AAAAAAABCM5daH9OCSgytlhTGP1Tj7sBqUiQK5kt64lUOVAXHnN+jsTj0A4CinSLcPdW3Ig7qGbAhAt9i4PYmw7ViDPMvfJ7Lsg42/RBbBZdsOjPSlhGqAwhTK6CGJt9Io1+1cZ1z6tH+R1a6y6qwHhK4nYk3lHOEyi0b2eNJn6FFJSdiMfF1gDRD5yuRvlmnf1bCd5VXVcse44JqjiJaRCL6jyTGjZPCWUG5TWG2aIXljEw729vPQZwHT7068DDiIIAY+A86cIII5OsjbUe7UBdQOObKKuc/DtE2XEGPXy8ra+0r6fauoAUEGZb5bQNaH2BktalvvK5T5ku8lO8VcQ3o7tVKvjKjxp+UrvUPKFKFvdkXXe9HSVbiEWtE2Pr7wqo5GfCmJRHXW8flO6taP/nRavlIqJ6AXv7xAk9jFGnbUNPTRNWbqsOC9eDsxRZMutdNrL6nZ7iMQLjLuXbOmUaYc76k0O6oGLBiemm2Q0KPGlyZdsKmi7y8CVTWbD+BYY25WQ1JAbBXGcRp8Shb6pyhi0TrrniJQiMhR2WDzUSKqCM159X/uuZsMjE4W505Vp6mBrfRDDCvEW1zltSTPJJL7YZ9ISGgUz+DOf3G0X5+AzSvEHKTxadCCgEz3qM1MtdJLdkmaybnxMTfJKK1YN7mTKip7YAr7oYlL2uBO/zWzbhkZfS8W0JFJB8ceaiwm9v7O8ZSSH0iAd7tKgGetV7tkwogcpA3cdZQQvNoII0UzAdnR/D1DXa16vEX7Io6Map+1G1pbFdznJIyYZ7zU6ohBrl0S8=
Received-SPF: pass client-ip=2a01:b747:3005:206::17;
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

More work on VM save/restore

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 68272c5657..408a1667e0 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -346,6 +346,8 @@ static void whpx_set_xcrs(CPUState *cpu)
     struct whpx_state *whpx = &whpx_global;
     WHV_REGISTER_VALUE xcr0;
     WHV_REGISTER_NAME xcr0_name = WHvX64RegisterXCr0;
+    WHV_REGISTER_VALUE xss;
+    WHV_REGISTER_NAME xss_name = WHvX64RegisterXss;
 
     if (!whpx_has_xsave()) {
         return;
@@ -358,6 +360,17 @@ static void whpx_set_xcrs(CPUState *cpu)
     if (FAILED(hr)) {
         error_report("WHPX: Failed to set register xcr0, hr=%08lx", hr);
     }
+
+    if (!whpx_has_xsaves()) {
+        return;
+    }
+
+    xss.Reg64 = cpu_env(cpu)->xss;
+    hr = whp_dispatch.WHvSetVirtualProcessorRegisters(
+        whpx->partition, cpu->cpu_index, &xss_name, 1, &xss);
+    if (FAILED(hr)) {
+        error_report("WHPX: Failed to set register xss, hr=%08lx", hr);
+    }
 }
 
 static int whpx_set_tsc(CPUState *cpu)
@@ -691,6 +704,8 @@ static void whpx_get_xcrs(CPUState *cpu)
     struct whpx_state *whpx = &whpx_global;
     WHV_REGISTER_VALUE xcr0;
     WHV_REGISTER_NAME xcr0_name = WHvX64RegisterXCr0;
+    WHV_REGISTER_VALUE xss;
+    WHV_REGISTER_NAME xss_name = WHvX64RegisterXss;
 
     if (!whpx_has_xsave()) {
         return;
@@ -705,6 +720,19 @@ static void whpx_get_xcrs(CPUState *cpu)
     }
 
     cpu_env(cpu)->xcr0 = xcr0.Reg64;
+
+    if (!whpx_has_xsaves()) {
+        return;
+    }
+
+    hr = whp_dispatch.WHvGetVirtualProcessorRegisters(
+        whpx->partition, cpu->cpu_index, &xss_name, 1, &xss);
+    if (FAILED(hr)) {
+        error_report("WHPX: Failed to get register xss, hr=%08lx", hr);
+        return;
+    }
+
+    cpu_env(cpu)->xss = xss.Reg64;
 }
 
 static void whpx_get_registers_for_vmexit(CPUState *cpu, WHPXStateLevel level)
-- 
2.54.0 (Apple Git-157)


