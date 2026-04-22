Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8740CFA1FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 21:45:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFfMJ-0000Dn-Nq; Wed, 22 Apr 2026 17:43:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFfM5-00007X-0E
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 17:43:36 -0400
Received: from p-east2-cluster5-host8-snip4-1.eps.apple.com ([57.103.79.34]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFfM2-0007bS-OP
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 17:43:32 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id
 850CF180095E; Wed, 22 Apr 2026 21:43:26 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRJAU1fDl4fBBdGGVUERx5dVkAZGQJRHFYNV0NUBF9QSQxBUGxaAEcXSB1dGVlvUF0cDhhZG0AVXRFQGVYJXhUXHkFNWgJWTQVKA18BWwZCC0oCWQVZB14LSgdfGlgDXVQXWwxaDlYwTBZDH1IPWxNNGVEBUkVUAgdYRxRHDg8TTAtHAlo0Vh9UGVoD
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776894209; x=1779486209;
 bh=Yb8MZdG4bYTj2R/5rdlrYd3KIDfipgWFm4dgORDLS64=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=NiejURubwGAzPHgkH2zUURbDernhu4xp4grF89QpiIbsphH6lAelQGx9HTaRRhobBPDvIS7rh2XsphpmkAQn4vYOebJd9G82+3hThOpyq6AXaJXXZf1r6QcyvKW/s18AgfD/bkazLwFQntrpVegaqAJ3b5WOmexe/R/uP50gXt3TwcKBUkfifqHiZvXMZRG3WouYbmZkm9BygWhARMyoPwQQGRKpyjQX63s7mGlZXSCe181hmLtsFQ03n+xAg9qWP3LQaARqE7FT+ITo8EDWNzlYbOPKBRiTIOAaL8R2QOAUssYIRKwyf7T33vn/kcNCtzObcXSA4yV+9DHxU18uHA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id
 0758A18000C7; Wed, 22 Apr 2026 21:43:23 +0000 (UTC)
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
Subject: [PATCH v3 30/37] whpx: i386: set APIC ID only when APIC present
Date: Wed, 22 Apr 2026 23:42:18 +0200
Message-ID: <20260422214225.2242-31-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260422214225.2242-1-mohamed@unpredictable.fr>
References: <20260422214225.2242-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDIxMSBTYWx0ZWRfX8HXVzbI6fgpv
 Dc5pzPuTC9qMswKaBlfVtHcZeN/v9bRSGHkuFvd8eHLVX3tIO74z+FycHqP0GYp4FDU8Sb/2Niy
 xyU7S12kO8rw/haVpCfkphB1W0yvrClI/jxf2+d18TiA7B6gRykyOuzfkRA7OD8rcb3wtSCk31v
 hY5WFkmCkqpyroMWDFAisdsaAgo/vjyjue/eSktI6SMAV9EbRjx1LSjMSXRIY5/epwOr9/NwKMY
 8XL6cJinntoxfOLl2C7jiqwZS098pObZI+YADtjmlSW7TkpC+rvoZp4SOD9R82a/mmGa5LoXEbO
 sN0gMGRB+voo8ASN6khCytAeQpHxyxJ9IgaxuXtfap9OkE2ci18cGdFMTglBi8=
X-Authority-Info-Out: v=2.4 cv=PvGergM3 c=1 sm=1 tr=0 ts=69e94100
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=WHe3jrWR342bzmf78BwA:9
X-Proofpoint-GUID: ByAdUR_rIvyG8ygm3eGx0EJl1h2EMu4z
X-Proofpoint-ORIG-GUID: ByAdUR_rIvyG8ygm3eGx0EJl1h2EMu4z
Received-SPF: pass client-ip=57.103.79.34;
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

-M isapc doesn't have an APIC

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 3562decfaf..53ff0d3f7c 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2643,7 +2643,7 @@ int whpx_init_vcpu(CPUState *cpu)
         goto error;
     }
 
-    if (!whpx_irqchip_in_kernel()) {
+    if (!whpx_irqchip_in_kernel() && x86_cpu->apic_state != NULL) {
         WHV_REGISTER_VALUE apic_id = {.Reg64 = x86_cpu->apic_state->initial_apic_id};
         whpx_set_reg(cpu, WHvX64RegisterInitialApicId, apic_id);
     }
-- 
2.50.1 (Apple Git-155)


