Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24263F419B6
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 13:30:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD0JG-0007D4-Ic; Wed, 15 Apr 2026 09:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wD0JF-0007Cn-5E
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 09:29:37 -0400
Received: from pv-2002d-snip4-11.eps.apple.com ([57.103.64.251]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wD0JD-00046g-67
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 09:29:36 -0400
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-11 (Postfix) with ESMTPS id
 6C4A11800545; Wed, 15 Apr 2026 13:29:32 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgDTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRNEwVSB11NVg1HD1geXBQXCEVDXgheH0wcHQ5YBhIATQoONgZZBV4JVgNDBTYSFF1FRgNHGVcUUBtHDFUHV15fChMAXg8PTAtIAVsHXwNFCEsBVAVdHEUBQARVGlkfHVYQUgBSD3IFVwhBCFMCUQRYGl8IGQ1AThkMSh1SVlEFSgxcAGgPXR1YEV0=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776259773; x=1778851773;
 bh=aiXyhBzTJzaIzKx5bXgk3uW8CyShOVzrypP76mpg4o8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=N3LR8O1DJqmPRNt7BxesuylYQW3TnsP4HTObO3USvwjJFlq91c9OgxOjT5UTD7k/Yxc8rhTjWCRkkjvDiT1JG1xrZge9qQYSF0OFn3J2ZYatYXUQfG2c4piYmb/xs0qllMPr6I5oPpVN3nOFECt0VoBvk4fak4SModKdtvuxTx8TomvikZxJCVQGkyHxXiAT0Qw+lEfJDVd3Ktgjrf3Q6hnMJe+9AfmR2O31HWve8YGrP2Rfuyw9W5jTmdX/YqQ1eKfGhFHg+eEcV6BCKkESY719D3d1xT18hBadzAXUiJXF+qbcxn/kdj4+G+L9+r56qorIP5+P+drE8tkxaeKgJA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-11 (Postfix) with ESMTPSA id
 161D2180013A; Wed, 15 Apr 2026 13:29:30 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH v2 01/10] whpx: i386: set apicbase value only on success
Date: Wed, 15 Apr 2026 15:29:17 +0200
Message-ID: <20260415132926.58878-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260415132926.58878-1-mohamed@unpredictable.fr>
References: <20260415132926.58878-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: sFncb-C0KLGaTICGFUxnyqvT2knKKtoX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDEyNSBTYWx0ZWRfX833b+YWspKs8
 4UQYkNgikMSgZWYGns6AaTjyjvK9aonIhqb6RzKXHjF6ofunlvzZXwJOO6OZOkjOVDhhNVbGMhz
 JfEn9adg87c6EVxoXcHLgg9pLe78vBsM5pujkffTDJnLxytseIA6e1oLs2s7Emz2WLkXsN5MJhU
 xe6fLB9z7G9TNdbacArpcSM/f93E2w3WP5YJQly10a8WGHr+UfvhvzneBQf6IdktzR/2OJcg4Nq
 7vUWd9ERhbPdXKx7zCciXkJCHVjOZx+FLUAex0DZqzynlQbyuH2k8LVh6x64avAROFqLSXX9KhX
 w+JR2WFKHdVdXXuFktLSn6rzvYJb4LQcn22Xe+3xSQndana6AoJtUfVLv2mBpU=
X-Authority-Info-Out: v=2.4 cv=Xqr3+FF9 c=1 sm=1 tr=0 ts=69df92bc
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=uh2sygq7LFHjsVUyvz4A:9
X-Proofpoint-ORIG-GUID: sFncb-C0KLGaTICGFUxnyqvT2knKKtoX
Received-SPF: pass client-ip=57.103.64.251;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 86d2dc1df8..56a789c5fd 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2001,8 +2001,9 @@ int whpx_vcpu_run(CPUState *cpu)
                     int msr_ret = cpu_set_apic_base(X86_CPU(cpu)->apic_state, val);
                     if (msr_ret < 0) {
                         x86_emul_raise_exception(&X86_CPU(cpu)->env, EXCP0D_GPF, 0);
+                    } else {
+                        whpx_set_reg(cpu, WHvX64RegisterApicBase, reg);
                     }
-                    whpx_set_reg(cpu, WHvX64RegisterApicBase, reg);
                 }
             }
 
-- 
2.50.1 (Apple Git-155)


