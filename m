Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55BD1FA1FFF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 21:47:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFfLr-0008Ls-BU; Wed, 22 Apr 2026 17:43:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFfLi-00087V-8n
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 17:43:10 -0400
Received: from p-east2-cluster1-host1-snip4-10.eps.apple.com ([57.103.76.33]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFfLg-0007L0-J0
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 17:43:09 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id
 00D1D1800C5C; Wed, 22 Apr 2026 21:43:05 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRJAU1fDl4fBBdGGVUERx5dVkAZGQJRHFYNV0NUBF9QSQxBUGxaAEcXSB1dGVlvUF0cDhhZG0AVXRFQGVYJXhUXHkFNWgJWTQVKA18BWwZCC0oCWQVZB14LSgdfGlkCXVQXWwxaDlYwTBZDH1IPWxNNGVEBUkVUAgdYRxRHDg8TTAtHAlo0Vh9UGVoD
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776894187; x=1779486187;
 bh=VwbCJMQOjdR/FYXB00bRp25vI47XadzN5iydMAM/HgY=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=dq2FKB8mCjD9MINwWiem2Gy9aOSMlGy3TfXyFYfuIkdZLPBJlStVstYkvYYUdMVpLy5srIfsOtjszScOoSdfB0b4sYL0Wma9AXMNGKNcole7akqhoolKgxKxpOECTw0pMOkUu5X0byYS1iTY41q5ugstbtl9gROZHgpZkY/9vEq8961TQ7A6pizlwCTYvt+ZTGFElb9Rw02VJIsI6E0Xl+YjAcJZMOMnDQMSUO4cfTln8G2tM5ZgXs/a6X+DMoWTi+d6ArlkN6X82fVj0Vk/65T5P6YiNJkrTtwlQplniixKZXfF4BSYpvihjKN9IvIBzSkzM5e2j4OxjeOwJ4qO7w==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id
 86A75180021C; Wed, 22 Apr 2026 21:43:03 +0000 (UTC)
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
Subject: [PATCH v3 19/37] whpx: i386: tighten APIC base validity check
Date: Wed, 22 Apr 2026 23:42:07 +0200
Message-ID: <20260422214225.2242-20-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260422214225.2242-1-mohamed@unpredictable.fr>
References: <20260422214225.2242-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDIxMSBTYWx0ZWRfXw0+xwYuvSptF
 RAv96mFmEuKyCO1ASgtbj7m39SwICKEAVzTzAqE9p03L5MhpIwIu6xwWPgX9MlRKps4nrTJexsn
 UWkMMp3vb77Zf+qOeH5bV1dO02MLg6LIlfXx1iHtBVFDLpJ1MHXe8wynnF/9Cxp31yVXP4Htmot
 Smfy2hT1ic+sNwk+2wp41l//HY37+T84fZuov135yecu7tRIfsCFwCELGA3tz0fBxGjgBd0TutT
 7uZM4Unr5IozBJAXGQCv4d6L3p3CLtiIjBtkyD2H5rK/MpwEq2btx3MxP35fvsNW9FN9s7u9Thv
 wdHg1uBvNqjIsgSF++N7VfPuP6N7gPhhbvazqafFZ3nFV75yp6hOBlpGYnDYuE=
X-Proofpoint-GUID: N_YulKQGm_yuOxyLLofGd58QM7H_uqQw
X-Proofpoint-ORIG-GUID: N_YulKQGm_yuOxyLLofGd58QM7H_uqQw
X-Authority-Info-Out: v=2.4 cv=VuUuwu2n c=1 sm=1 tr=0 ts=69e940eb
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=uh2sygq7LFHjsVUyvz4A:9
Received-SPF: pass client-ip=57.103.76.33;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index eecc7f48ed..521a94355d 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2078,6 +2078,9 @@ int whpx_vcpu_run(CPUState *cpu)
 
             if (vcpu->exit_ctx.MsrAccess.MsrNumber == MSR_IA32_APICBASE) {
                 is_known_msr = 1;
+                if (val & MSR_IA32_APICBASE_RESERVED) {
+                    x86_emul_raise_exception(&X86_CPU(cpu)->env, EXCP0D_GPF, 0);
+                }
                 if (!vcpu->exit_ctx.MsrAccess.AccessInfo.IsWrite) {
                     /* Read path unreachable on Hyper-V */
                     abort();
-- 
2.50.1 (Apple Git-155)


