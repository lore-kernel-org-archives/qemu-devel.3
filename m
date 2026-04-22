Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B32F94CC1
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 21:46:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFfLy-0008UN-Ic; Wed, 22 Apr 2026 17:43:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFfLx-0008Tr-As
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 17:43:25 -0400
Received: from p-east2-cluster5-host1-snip4-1.eps.apple.com ([57.103.79.4]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFfLv-0007VX-UO
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 17:43:25 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id
 35D781800216; Wed, 22 Apr 2026 21:43:21 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRJAU1fDl4fBBdGGVUERx5dVkAZGQJRHFYNV0NUBF9QSQxBUGxaAEcXSB1dGVlvUF0cDhhZG0AVXRFQGVYJXhUXHkFNWgJWTQVKA18BWwZCC0oCWQVZB14LSgdfGlkFXVQXWwxaDlYwTBZDH1IPWxNNGVEBUkVUAgdYRxRHDg8TTAtHAlo0Vh9UGVoD
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776894203; x=1779486203;
 bh=zKgMP02e3B1vI1/Ihfo5NS9pcmEl5Ljw2zF+qf50GhQ=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=fjUPfhCXFe/HgxHMf7MxJ7pcZRgNfUpobemzVBOlv9NDaeONudRkQjmqML6VKsuWqWfYg7yUACBSKTi9OCmG0KESaIG59/JGHKWGulWm0fhH8lHf457tmSMln+keHkVh5970J1fwfFVtD9b43PRwbr2PqMu2JWGtmlhsUJ/oZK8goX1fAJOikO4svFL82r+1vMOojA87G+v5J4IrtLNb1ITQLRcs4EZYsp4vpeeCPsZpGER3Z1FjPsrLz+FJ+rb58ewCsuZSeXXlkJ5nN9/+zGv2fD9NnnxuTS5cuveDJZfO4MmSFdBTFPnBuP5e0GtAun2Ts0ZwSenBaF9gLyDqDw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id
 8211E1800C40; Wed, 22 Apr 2026 21:43:16 +0000 (UTC)
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
Subject: [PATCH v3 26/37] target/i386: emulate: use exception_payload for
 fault address
Date: Wed, 22 Apr 2026 23:42:14 +0200
Message-ID: <20260422214225.2242-27-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260422214225.2242-1-mohamed@unpredictable.fr>
References: <20260422214225.2242-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=H4TWAuYi c=1 sm=1 tr=0 ts=69e940f9
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=YcyI-53RcdBlrF1VUN8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDIxMiBTYWx0ZWRfX9n/SoLoOaaS5
 XYpo/us7gfy5iQmfejXtji3jsvMZqRS1zI0NMC3pJY2PCdISWMWBVrWnAPUXz+k01zzYPJIpwfs
 b+f1eb/lRAl/IH1XfoqyzvG0bYC0wgYOamGRH2Du3hCEBaZQp+SxoamQ+cZdqQ1XRu4YMGWGxC1
 oLy+8pTUDxmNiqYethFY1IPnSISRb5TuesLL3AkHmq8mxhUfbrSjjjFmQ1AT2eDk/npJQIiFL8+
 M2o24MMj4WphqLoSgAnBiQ7pyBuxDPFbToUdOi48hew+O+3AwVZ4w73AvWtskoZPySrieuWdaUE
 HKBa6LrbI1rKocy8zjfzJf707fxcfrUDdMDaCSq1UY0ttSHVUn4pdf2PfMdHOY=
X-Proofpoint-GUID: FEZx6ml0LN3-x_7yjDOEaMdblcv7DaxG
X-Proofpoint-ORIG-GUID: FEZx6ml0LN3-x_7yjDOEaMdblcv7DaxG
Received-SPF: pass client-ip=57.103.79.4;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Instead of directly putting it in cr[2], put it in exception_payload.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/emulate/x86_mmu.c | 3 ++-
 target/i386/whpx/whpx-all.c   | 6 +++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/i386/emulate/x86_mmu.c b/target/i386/emulate/x86_mmu.c
index 007de582de..8d4371467f 100644
--- a/target/i386/emulate/x86_mmu.c
+++ b/target/i386/emulate/x86_mmu.c
@@ -277,7 +277,8 @@ static MMUTranslateResult x86_write_mem_ex(CPUState *cpu, void *data, target_ulo
         translate_res = mmu_gva_to_gpa(cpu, gva, &gpa, translate_flags);
         if (translate_res) {
             int error_code = translate_res_to_error_code(translate_res, true, is_user(cpu));
-            env->cr[2] = gva;
+            env->exception_has_payload = 1;
+            env->exception_payload = gva;
             x86_emul_raise_exception(env, EXCP0E_PAGE, error_code);
             return translate_res;
         }
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 8e54fcc403..8d51293384 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1903,11 +1903,11 @@ static void whpx_inject_exceptions(CPUState* cpu)
         WHV_REGISTER_VALUE reg = {};
         reg.ExceptionEvent.EventPending = 1;
         reg.ExceptionEvent.EventType = WHvX64PendingEventException;
-        reg.ExceptionEvent.DeliverErrorCode = 1;
+        reg.ExceptionEvent.DeliverErrorCode = env->has_error_code;
         reg.ExceptionEvent.Vector = env->exception_nr;
         reg.ExceptionEvent.ErrorCode = env->error_code;
-        if (env->exception_nr == EXCP0E_PAGE) {
-            reg.ExceptionEvent.ExceptionParameter = env->cr[2];
+        if (env->exception_has_payload) {
+            reg.ExceptionEvent.ExceptionParameter = env->exception_payload;
         }
         whpx_set_reg(cpu, WHvRegisterPendingEvent, reg);
     }
-- 
2.50.1 (Apple Git-155)


