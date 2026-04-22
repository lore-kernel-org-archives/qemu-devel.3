Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26412FA1FFC
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 21:46:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFfLM-0007vY-PM; Wed, 22 Apr 2026 17:42:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFfLL-0007uh-Dy
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 17:42:47 -0400
Received: from p-east2-cluster1-host7-snip4-3.eps.apple.com ([57.103.76.66]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFfLJ-0006ye-JS
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 17:42:47 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id
 36E4518006FB; Wed, 22 Apr 2026 21:42:39 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRJAU1fDl4fBBdGGVUERx5dVkAZGQJRHFYNV0NUBF9QSQxBUGxaAEcXSB1dGVlvUF0cDhhZG0AVXRFQGVYJXhUXHkFNWgJWTQVKA18BWwZCC0oCWQVZB14LSgdfGl0fHVYQUgBSD3IFVwhBCFMCUQRYGl8IGQ1AThkMSh1SVlEFSgxcAGgPXR1YEV0=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776894164; x=1779486164;
 bh=SWGvVkTUcfNdXmZWTM4NHwYFZfQcX/gulJR3Nj6SCmU=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=MltShFRs7LoQFjfgRl/cD6FdfBhD7SG9rXqTydIHWe7HX5MLIeP1/KQTq6ZBVjDTgQMDwlsguUj+YxZsVRc09DKYAFg1RmQdouJqMR5kVwJZTPMyISoErPzww8/JYnr/n5lShgt4m7tG9cdtkuHj2yX2R5Gh8BHOgyWrhF4DAGpDn188e6fVLy53USShZgsqKSwBBvIJBv+7gTCLVroo02+7ulTUrn8MMS0O3qS0LNKkMjFsqN5h4W8o5xrPTAcOLX6P5Lpz639n2F3hadLcs+1n/mluEa+uzrppdVnEkSNpW9wTRFgNnwyt6CmxqdCgY4LetwUXLFd4yzvbMvF1fg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id
 90929180020C; Wed, 22 Apr 2026 21:42:37 +0000 (UTC)
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
Subject: [PATCH v3 05/37] whpx: i386: enable x2apic by default for user-mode
 LAPIC
Date: Wed, 22 Apr 2026 23:41:53 +0200
Message-ID: <20260422214225.2242-6-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260422214225.2242-1-mohamed@unpredictable.fr>
References: <20260422214225.2242-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDIxMSBTYWx0ZWRfX7WdEKBMZyr9x
 +PXY/aAkxXPPDmaA4/I7PGRHttn2Cd9D93TsAm+7Q2zQLV4ZJdISfP3VKSjONvskhy0I6PrUNAf
 UbZcB8a1e5YBc/e/yStd9LH7nWGLYFRSE85cQwGLKQCAh2QapG7CHxY3RXbFHhScwKBwzzidw61
 N/RNoM0ryFr+TKRwObQNIKfFCK7pZyhDllaT6JjwTX4ev7otce8HejXSOM7mOkRziwffTQ3xxOK
 hOBYcMkkgpfvRm1lZufhQu1D7cPgjnGqdK15FPT6haqVrB7HmSvXcKKzpceHm14bhwNOjapzto2
 ZW4VO9JAk0jG82FrVVrkm4ushuTq8aTytqRVfLAk9qY6w+FSiIwteIHZ1UXcXg=
X-Proofpoint-GUID: naZfVawrzCuXQjXe9ezCKtYBB_xVcIPD
X-Proofpoint-ORIG-GUID: naZfVawrzCuXQjXe9ezCKtYBB_xVcIPD
X-Authority-Info-Out: v=2.4 cv=C4DkCAP+ c=1 sm=1 tr=0 ts=69e940d2
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=uAk9FrDoCeqUxh5yT_MA:9
Received-SPF: pass client-ip=57.103.76.66;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 target/i386/whpx/whpx-all.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 8f03616cb9..4954e0557a 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2366,11 +2366,18 @@ error:
     return ret;
 }
 
+static PropValue whpx_default_props[] = {
+    { "x2apic", "on" },
+    { NULL, NULL },
+};
+
+
 void whpx_cpu_instance_init(CPUState *cs)
 {
     X86CPU *cpu = X86_CPU(cs);
 
     host_cpu_instance_init(cpu);
+    x86_cpu_apply_props(cpu, whpx_default_props);
 }
 
 /*
-- 
2.50.1 (Apple Git-155)


