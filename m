Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8561DFA1FFC
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 21:45:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFfLV-00081T-1J; Wed, 22 Apr 2026 17:42:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFfLU-000812-2q
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 17:42:56 -0400
Received: from p-east2-cluster5-host1-snip4-7.eps.apple.com ([57.103.79.10]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFfLS-0007D0-LX
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 17:42:55 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id
 ADF491800227; Wed, 22 Apr 2026 21:42:52 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRJAU1fDl4fBBdGGVUERx5dVkAZGQJRHFYNV0NUBF9QSQxBUGxaAEcXSB1dGVlvUF0cDhhZG0AVXRFQGVYJXhUXHkFNWgJWTQVKA18BWwZCC0oCWQVZB14LSgdfGloBXVQXWwxaDlYwTBZDH1IPWxNNGVEBUkVUAgdYRxRHDg8TTAtHAlo0Vh9UGVoD
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776894174; x=1779486174;
 bh=apFntVvXXg/DVOj5xArakcZd3i9aDzEc71pb/wAzo6Y=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=egAEdnIeG8trIl4eKUKGgGzSvum2ASsCsxbw8ioz+NDv+dtXm1GSZkKnLd43paGeVCudJCF9yp2HJ9Ca6NSRzlVSMG5bN7SlRdvfF2ObbVtVJvg44krD/++kBsyr8oDSqHx0wE0MBMecPg47XTrSFkCohozrbW/VToSc0PwVde81jfwd7qi8ejARabFH7rK/8G4SLskg+3qwNrrAi3yYhH2/+xLDb1Huf8UuyHrSyfr3gWNMSI5z0AG6/U6MosnKpk3Es/k17sTHzpjO3/4FvsMPmPphGNvMMHv9m0Lb2zMN0SDY/I0PvZmMu3tmguRvcWvclig9MFd5laOjfBQUVQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id
 7BFB51800956; Wed, 22 Apr 2026 21:42:50 +0000 (UTC)
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
Subject: [PATCH v3 12/37] whpx: i386: disable enlightenments and LAPIC for
 isapc
Date: Wed, 22 Apr 2026 23:42:00 +0200
Message-ID: <20260422214225.2242-13-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260422214225.2242-1-mohamed@unpredictable.fr>
References: <20260422214225.2242-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDIxMSBTYWx0ZWRfX+qfAd0S8tWWf
 EmEjNmdJA/Rz3i+WuLTeMi7HPyhavV6RRXA5KcY/6iORKlOPWlO2vM/Ab5PBk6nC1dPrwTOZeIq
 EcTmmGsjzKHcC4Ox57RI05qEPNMGWRujqj5TOUSfoUObrau0sqij7+YeHdYHsI1JYkWfBKLe/X+
 jcqynUDTjxiIOkP43dSKXMGMNzn4VQK782Mnytu7JTIHlu7YYqy0vuoBWrJ59I2cbbvAVVpn/GQ
 FBZ2WuFyMyHOKZAkk8krB8r3vahgrOCN7gv2QxVlJlCivapcVNbeGDY4I/3W17T3NOObN3U/8nl
 1/8gGKOxxUlghXhE2b1o1xmxw7lNPW7jAt3Tpf3DBeiwFC5yd3r3j6UVzdQFqc=
X-Proofpoint-ORIG-GUID: PLGO0EXBIkbd5RgXuv8gkrHcGzktycPG
X-Proofpoint-GUID: PLGO0EXBIkbd5RgXuv8gkrHcGzktycPG
X-Authority-Info-Out: v=2.4 cv=JeGxbEKV c=1 sm=1 tr=0 ts=69e940dd
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kaNVauZA35-AGszze7oA:9
Received-SPF: pass client-ip=57.103.79.10;
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The isapc machine doesn't have an APIC. And Hyper-V enlightenments
don't sound too useful to have there so disable those.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 75f0f062d4..cbcf1de7ae 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2546,6 +2546,14 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         goto error;
     }
 
+    /* for isapc, disable Hyper-V enlightenments and LAPIC */
+    if (!strcmp(MACHINE_GET_CLASS(ms)->name, "isapc")) {
+        whpx->kernel_irqchip_allowed = false;
+        whpx->kernel_irqchip_required = false;
+        whpx->hyperv_enlightenments_allowed = false;
+        whpx->hyperv_enlightenments_required = false;
+    }
+
     whpx->mem_quota = ms->ram_size;
 
     hr = whp_dispatch.WHvGetCapability(
-- 
2.50.1 (Apple Git-155)


