Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AFA9FA1FFC
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 21:44:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFfLq-0008Km-RD; Wed, 22 Apr 2026 17:43:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFfLn-0008DG-Ha
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 17:43:16 -0400
Received: from p-east2-cluster1-host11-snip4-1.eps.apple.com ([57.103.76.44]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFfLl-0007Ns-8f
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 17:43:15 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id
 BBB91180023C; Wed, 22 Apr 2026 21:43:10 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRJAU1fDl4fBBdGGVUERx5dVkAZGQJRHFYNV0NUBF9QSQxBUGxaAEcXSB1dGVlvUF0cDhhZG0AVXRFQGVYJXhUXHkFNWgJWTQVKA18BWwZCC0oCWQVZB14LSgdfGlkDXVQXWwxaDlYwTBZDH1IPWxNNGVEBUkVUAgdYRxRHDg8TTAtHAlo0Vh9UGVoD
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776894192; x=1779486192;
 bh=qSKqOpNTte0i6xqqaDhNVr4w7bOKGXgaVxqQVqgKXKc=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=SoiHHTzEqpyKzDW320VPR2k/hDU3F171eacAhiXahRURxOKUnF1SNGWQQ0GXgx/9a66UMmiey1KOivvQA0IZJ5KwXZPSwo80uQ91Zyd3V+nUpAzQXG4tyBuEw6nCzFNHDDwGtMJR/2XvtQi0scrwqwMft1hPZIPMSocx9APD+9xOOd7DZK50AEFu0dPywwTr9UCSr44MIrS7p3VbG0sItkuXHi0S6bgDO0Q/g0a8SCpEA0aq5sGO5s85+ax9pQ27rCvIUwoFYlt6nEvM7O2VrP2LU3kMKo+wsV+2ACZnSy/W0TVDADYjOpj9YH5PJqckpKzL/UOeGyF+nf4E+Pbg1w==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id
 65D7A1800950; Wed, 22 Apr 2026 21:43:05 +0000 (UTC)
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
Subject: [PATCH v3 20/37] whpx: i386: ignore vpassist when kernel-irqchip=off
Date: Wed, 22 Apr 2026 23:42:08 +0200
Message-ID: <20260422214225.2242-21-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260422214225.2242-1-mohamed@unpredictable.fr>
References: <20260422214225.2242-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 5cRCVzpbtauORHHMFe00oue436sL8EHP
X-Authority-Info-Out: v=2.4 cv=QJVlhwLL c=1 sm=1 tr=0 ts=69e940ef
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=HmN67jXOOwgiugJlUbgA:9
X-Proofpoint-ORIG-GUID: 5cRCVzpbtauORHHMFe00oue436sL8EHP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDIxMiBTYWx0ZWRfXxm8kEI6dczqo
 bb7nG8VjGgXgJZ2Eca196pXYoUZMkez8A5KT0Tk4Mo+NPm/kGwX2GfB9+/uH1ZdWz6sOtnoqQ8U
 g5QorsPU9BCmGkWAIIDp9QYcwCShwRjf5XQlY2N7WMwCJIfLoZpqNe9CF2L61dV4tPzInZ9ulO8
 9Ss/oeGHEPIB/AOsFmuhM/02mCHQyrd9rhSULVXW+5u5SeXBdAp5fmgzxUQMb+uzFkUZIqBNY4z
 jR39s8bfn57LeAcXQlDDS0DckmSYJKD3El6cIvS5o+vmp6EWh3zCPBC4D3FnuTuiGMQ8mgNkHu0
 KD18pZABajySuX5nYAjhoLgjmV/QFKDGL2wtj8u5QfT9W/PyD+Iz/TUizJX43c=
Received-SPF: pass client-ip=57.103.76.44;
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

Linux tries to set vpassist even when none of the enlightenments
using it are available.

So ignore the page it sets.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 521a94355d..cafcbf8bbb 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -51,6 +51,7 @@
 #define HYPERV_APIC_BUS_FREQUENCY      (200000000ULL)
 /* for kernel-irqchip=off */
 #define HV_X64_MSR_APIC_FREQUENCY       0x40000023
+#define HV_X64_MSR_VP_ASSIST_PAGE       0x40000073
 
 static bool is_modern_os = true;
 
@@ -2118,6 +2119,18 @@ int whpx_vcpu_run(CPUState *cpu)
                     }
                 }
             }
+
+            /*
+             * Linux tries to use it anyway even when not exposed.
+             * Ignore the write as the VP assist page is not used.
+             */
+            if (vcpu->exit_ctx.MsrAccess.MsrNumber == HV_X64_MSR_VP_ASSIST_PAGE
+                && vcpu->exit_ctx.MsrAccess.AccessInfo.IsWrite
+                && !whpx_irqchip_in_kernel()
+                && whpx->hyperv_enlightenments_enabled) {
+                is_known_msr = 1;
+            }
+
             /*
              * For all unsupported MSR access we:
              *     ignore writes
-- 
2.50.1 (Apple Git-155)


