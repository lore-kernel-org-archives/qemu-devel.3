Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C0B606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 23:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=ibdEtJ6H
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK2gq-0002k2-Qe; Thu, 22 Oct 2026 19:59:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xK2gm-0002iR-RP
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 19:59:17 -0400
Received: from mr-2003l-snip6-11.eps.apple.com ([2a01:b747:3000:202::79]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xK2gl-00026r-8k
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 19:59:16 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-9 (Postfix) with ESMTPS id
 E9EC31800151; Thu, 22 Oct 2026 23:59:11 +0000 (UTC)
X-ICL-RepId: 01a1660d-f00a-768b-8e62-b99ce02281f3
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0PWFsIWwQPH0wMUQJCBVZeVAodBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkIJSgVcB1kAQgpNC1gORQpIDk0AQAFGXx9RGV4IUytHHkkKVgleCEYRWxRWQ1EZDFBNAUMICghHA00XXjJTBF8RUBY=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1792713554; x=1824249554;
 bh=nVK8vDM8XzoQ7gU4FL1Cwxgq28hF7I8+bUQSMNiuXqA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=ibdEtJ6HmhBGmUi6v5mAzaDyitolNKV2GrW2OVif7COXLJYZq2HVmKVyG1xxbyCcWmBHQ0NmR/gEEpV6w91LHYF0XXciN2y7aKAWb6/PJ0iX63699Lr4bm5oboC4GUH0S2OworyYcR9xLOxOD4IQfrbQUoPiRpiNrOfbTPzsBpymYWAV3rmhrjpDoLWMciUVm/S9zF7BS45baY6hAhrwONwEmT6hk7s6r+yKg8cfJYifgR/YKR2N+LXzOdS3n8DVA29HhB02OkK2/kXlG8oiPWsa4QyrdDuR6jVrxYWcBisBzvhaJQUC5phQIKQ7/LRWwSE7ctpvKwYYTzuU9NwbSg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.156.200.36])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-9 (Postfix) with ESMTPSA id
 2771E1800169; Thu, 22 Oct 2026 23:59:10 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH 05/11] whpx: i386: save/restore xss
Date: Fri, 23 Oct 2026 01:58:53 +0200
Message-ID: <20261022235859.88753-6-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261022235859.88753-1-mohamed@unpredictable.fr>
References: <20261022235859.88753-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 8LHo2q9YIRPVEojcvH8wB7YBb_m4AK_2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA5NSBTYWx0ZWRfX9J6ci6URXsM0
 DJX+mb1X6tw0LFrFyp9aUebEykNvLaGBnwfJBU3mmxm4UNJYR9aOswDrZN9Z+GizIlp5XQk4Rd3
 kiVW9xQ4iGWAKBAjokpTqBFVxt7Fmt2xbDHVJdjhqqRNQg7wE8VS+Og9r/pcjXBkMsLKm2KOpka
 qXuHqHgygpM0iJ9jTmg8Xp/7Rm+kXD51wq4Q5Vm+NWJdLRoREy9Xy9W+iJ7cOtsFDBbBfptktiD
 kNrccBd6I/sFs1PvBO7jqaGiPXsaJvsgcVUtz6twZh6TN9WAZdH40a7wkTEOANotp0X9NO1xOip
 oMrnhTpEEe0+emvMFF9FaPkwVz7azJyH5lI9FZ5/jvlEMIhAOAnsMg7enddkio=
X-Proofpoint-ORIG-GUID: 8LHo2q9YIRPVEojcvH8wB7YBb_m4AK_2
X-Authority-Info-Out: v=2.4 cv=cJbtc1eN c=1 sm=1 tr=0 ts=6adaa350
 cx=c_apl:c_pps:t_out a=9mRn2PO/+PIrVdEbaIuMPg==:117
 a=9mRn2PO/+PIrVdEbaIuMPg==:17 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=vvjR5Bv0Qg6bciTORDEA:9
X-JNJ: AAAAAAABZBGcRMlGft7yI3Yzoi13+x+ZXIxkIUlIno+BcJOnw7Yti7FILCXheNUvbG3/jiVLdHd+a0hLqZfpEv+Kjap2lKohXMJDjN9RNhcyP7uNEEs5hee6SFcYLIwSXs/nKzeDOyamPucx5zzdN+emyw1MeN1adwj9StriLP9g8e2pqjalleC0ydt6thVRWyNxdpW4KBPjoW6BypKSofIntUT5wWxBNC43v+9itd0cbFoJqo52qr/t4LObDAB4Nd9OSemHElP973HQUSXiwNZv/YycOor7mEz2ZXVoMEUexVNzZ03349f8vnfsA3CGReZ7QYA6KoYyZiHGblLbFFM5oEJ/pnhP2qCYUXaqVYzMGWMg0qUkKFFMo064GrfUM4ym7shUUUJoUUQBgFGqxnRFSxETuRZRp0z4L5C6XRoHyaOAqAdq/GMM1qCBxmNJ1S7uE8IGP8LyjQpFfvvLzsDiKMZ1exzVmbiMqYQ7HmbPORwS5Js4CfIzHaXY39WFGsIQ+97uL8/Jz/JsqYApoG9MVga+bHi1XapafOJodMrAI+Wvk3Uz/UnO8+apwiK9TCSpj83DgWxuNZ1rvewhtFvM0R6Usp1VSi1IU4zhLqXQonlvfUlhkuJxzTrnimb3C1lU08KVf7K+Nb2naxO7WlMJsn87ZZt9WUXy1hl08skT/UjWFrL/n8ZnbmKbB/O4WgHI+5dx+zXh2EVR75Bw/tyK75i5s7ZJ8MH/D8CIc3fJ1iz2v6Nq0NSo+zycnLeGot9k
Received-SPF: pass client-ip=2a01:b747:3000:202::79;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
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


