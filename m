Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70E5FFA1FFF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 21:46:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFfLK-0007ta-RU; Wed, 22 Apr 2026 17:42:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFfLI-0007sb-2i
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 17:42:44 -0400
Received: from p-east2-cluster1-host4-snip4-10.eps.apple.com ([57.103.76.23]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFfLF-0006ww-Mf
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 17:42:43 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id
 DBBBE1800227; Wed, 22 Apr 2026 21:42:37 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRJAU1fDl4fBBdGGVUERx5dVkAZGQJRHFYNV0NUBF9QSQxBUGxaAEcXSB1dGVlvUF0cDhhZG0AVXRFQGVYJXhUXHkFNWgJWTQVKA18BWwZCC0oCWQVZB14LSgdfGl4fHVYQUgBSD3IFVwhBCFMCUQRYGl8IGQ1AThkMSh1SVlEFSgxcAGgPXR1YEV0=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776894160; x=1779486160;
 bh=V8p4axRuSSeu+sKKMx+ar98eGUS5hUC2c3mtFQ7SVOk=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=ejLVaPZThiBJvBhld6DZp6xLNk4D97MXP7fxOGrKu6ZskEx8KhlttWIG4feiDn0+OuM5UH4MjLCGeqJIYMJqRwWwskL58rPg5kWQMKXhXFxeO7acoqBU7ZP/h1uguGV3QRT+BH5obFpVmxFr/ClWSBMzLB6DDIsC27WBZDn7k1gb1qVl3bef+hYEomU0navy2zmXImIlA1ULv993tQ4hsGNp5CRuLTieIE3TC2VsEizFa1tBpCk6nUixBVNlYnExSomdShcbwVPhhTg7+OcELOWlNtbWKTAFIlc86Z0i0lW8qWXFYsBJ9EJqhmWnj1+Ftb5lAj/qc2v9lFzghWX4Ow==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id
 AFE181800232; Wed, 22 Apr 2026 21:42:35 +0000 (UTC)
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
Subject: [PATCH v3 04/37] whpx: i386: disable TbFlushHypercalls for emulated
 LAPIC
Date: Wed, 22 Apr 2026 23:41:52 +0200
Message-ID: <20260422214225.2242-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260422214225.2242-1-mohamed@unpredictable.fr>
References: <20260422214225.2242-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDIxMSBTYWx0ZWRfX6moWjjXhKEB9
 FnMhwoCJ8VOnV9+MBifVxtdGrMHm58RIonCeQGFnqzjCJOFgUbylAJUnENCeo5/jbd+Xh655G+S
 0LJQtHbZBwNPd2NMB6J+usbxEXCYntzYHPrftnVmnzPxgRArqYLZ1mlAnNL+LyBexPKpYpJNKrV
 iuGDjHMlO8f3J0uUoO7CzgCAhNycQYdwYism4ggjnOWAzw4lFoJ1xkXnPdLsG8w03fhWyU8SaDd
 ++LRabrnqpsZsBqLxoxUuYu/5ZNQ+ZX+jDpILCzJpaBPgl5PfqOmtDZC7Sq5xebWOMlI7bfoI+f
 eqiQ8T1rqzvMhhbtPU6Ke6IQzSj96STjSWg8LixhbNmTzpmvXzSjZHGCb4mSzM=
X-Authority-Info-Out: v=2.4 cv=cIbtc1eN c=1 sm=1 tr=0 ts=69e940ce
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Rm0zj2O9plGGl-KjdfMA:9
X-Proofpoint-ORIG-GUID: RhKjumfgKrSSxGXU2T-lGyPICLuSLEW4
X-Proofpoint-GUID: RhKjumfgKrSSxGXU2T-lGyPICLuSLEW4
Received-SPF: pass client-ip=57.103.76.23;
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

AccessHypercallRegs was present twice so clean that up.

Remove TbFlushHypercalls (and its extended Gva range sub-feature)
from the user-mode LAPIC case as it behaves oddly there.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index d211b3f2ef..8f03616cb9 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2577,10 +2577,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     synthetic_features.Bank0.AccessPartitionReferenceTsc = 1;
     synthetic_features.Bank0.AccessHypercallRegs = 1;
     synthetic_features.Bank0.AccessFrequencyRegs = 1;
-    synthetic_features.Bank0.EnableExtendedGvaRangesForFlushVirtualAddressList = 1;
     synthetic_features.Bank0.AccessVpIndex = 1;
-    synthetic_features.Bank0.AccessHypercallRegs = 1;
-    synthetic_features.Bank0.TbFlushHypercalls = 1;
 
     if (whpx_irqchip_in_kernel()) {
         synthetic_features.Bank0.AccessSynicRegs = 1;
@@ -2588,6 +2585,12 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         synthetic_features.Bank0.AccessIntrCtrlRegs = 1;
         synthetic_features.Bank0.SyntheticClusterIpi = 1;
         synthetic_features.Bank0.DirectSyntheticTimers = 1;
+        /*
+         * These technically work without the Hyper-V LAPIC
+         * but behave oddly for multi-core VMs.
+         */
+        synthetic_features.Bank0.TbFlushHypercalls = 1;
+        synthetic_features.Bank0.EnableExtendedGvaRangesForFlushVirtualAddressList = 1;
     }
 
     if (is_modern_os && whpx->hyperv_enlightenments_allowed) {
-- 
2.50.1 (Apple Git-155)


