Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD6D2F94CBE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 21:44:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFfLq-0008It-A3; Wed, 22 Apr 2026 17:43:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFfLn-0008DI-L4
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 17:43:16 -0400
Received: from p-east2-cluster1-host12-snip4-3.eps.apple.com ([57.103.76.56]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFfLl-0007OM-K1
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 17:43:15 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id
 9C9B018000AF; Wed, 22 Apr 2026 21:43:12 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRJAU1fDl4fBBdGGVUERx5dVkAZGQJRHFYNV0NUBF9QSQxBUGxaAEcXSB1dGVlvUF0cDhhZG0AVXRFQGVYJXhUXHkFNWgJWTQVKA18BWwZCC0oCWQVZB14LSgdfGlkGXVQXWwxaDlYwTBZDH1IPWxNNGVEBUkVUAgdYRxRHDg8TTAtHAlo0Vh9UGVoD
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776894192; x=1779486192;
 bh=9xbxyGGfjNH/HWQDHlAQCg/qgFyvlvlu7VNj5bZOFog=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=XgEvEHGxgjt3ObOuI1V527PFdl4F0QOsl4hD+M9sF9pUtfWGq1G5i18PrNqZBraaMrrHcaI5hLVwUfTJcYxJZNp2jWGPTqv9KznVr/GZu9nTCQFH+JVH+nLNpVJFJLK6bp8AeHqguzbKHF+BLmMsU+BGpxSFjWNO04c6tqKnrDAY5T0+qjsG2u8iV9YN9XYqyw293J+VCyZgfIgITytiPhN+UCgL0q2PErNiJoF6vwX8psVBplqHXo5Ia510uMwgrcG9RvnzfSqQvrBF+QWiX0NocLJkMTnd6Zq3mvaDrC+MgD+1cYk5VVRg/27qxFusKiSsdbgmRls+bVja9e0GOw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id
 F20DE18000C7; Wed, 22 Apr 2026 21:43:10 +0000 (UTC)
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
Subject: [PATCH v3 23/37] whpx: i386: some x2APIC awareness
Date: Wed, 22 Apr 2026 23:42:11 +0200
Message-ID: <20260422214225.2242-24-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260422214225.2242-1-mohamed@unpredictable.fr>
References: <20260422214225.2242-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 6Ko38eZqYwASC_EF5TPIPWpCRzZKP_Cb
X-Proofpoint-ORIG-GUID: 6Ko38eZqYwASC_EF5TPIPWpCRzZKP_Cb
X-Authority-Info-Out: v=2.4 cv=GJUF0+NK c=1 sm=1 tr=0 ts=69e940f0
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=IZZkQHPJHa8VUPCOrf4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDIxMiBTYWx0ZWRfX2ja6vWTaQb/K
 RMS3VMFO/ljYvQWO0ixZcRNQUz/VzLjWarc3yuiUPYqGKgxDMo6znD68pLPah6vAqYixiZPUt5o
 wQUe1rmv3Q3dHV5uS7Y+hE9Hfi0u0g6NIQDmp8KF665+ZuW2fLknb6k7TnlL4oTpOLqqFF6ALKL
 8K79873XdfITRXmnotEebQsDPwStlBV/dgWGQotd3Mk14BrTWg2MbpwDJoPDkIcKdrrEUedf1Ne
 bN7zeNUrT9fOlLCYEwjOjNSw7O9zZyT4xi9AAEXOwENm8vrCFsPuX+S2BG+XwAm23E89mrAaXOT
 8QmY/ako8aRAUyprI0elYcAAqRq28cLFWFFF1bz4hBRiIjj0+ROIwONARuSVwU=
Received-SPF: pass client-ip=57.103.76.56;
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-apic.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/target/i386/whpx/whpx-apic.c b/target/i386/whpx/whpx-apic.c
index 65629ca45f..cc272f82a5 100644
--- a/target/i386/whpx/whpx-apic.c
+++ b/target/i386/whpx/whpx-apic.c
@@ -33,7 +33,11 @@ static void whpx_put_apic_state(APICCommonState *s,
     int i;
 
     memset(kapic, 0, sizeof(*kapic));
-    kapic->fields[0x2].data = s->id << 24;
+    if (s->apicbase & MSR_IA32_APICBASE_EXTD) {
+        kapic->fields[0x2].data = s->initial_apic_id;
+    } else {
+        kapic->fields[0x2].data = s->id << 24;
+    }
     kapic->fields[0x3].data = s->version | ((APIC_LVT_NB - 1) << 16);
     kapic->fields[0x8].data = s->tpr;
     kapic->fields[0xd].data = s->log_dest << 24;
@@ -61,7 +65,11 @@ static void whpx_get_apic_state(APICCommonState *s,
 {
     int i, v;
 
-    s->id = kapic->fields[0x2].data >> 24;
+    if (s->apicbase & MSR_IA32_APICBASE_EXTD) {
+        assert(kapic->fields[0x2].data == s->initial_apic_id);
+    } else {
+        s->id = kapic->fields[0x2].data >> 24;
+    }
     s->tpr = kapic->fields[0x8].data;
     s->arb_id = kapic->fields[0x9].data;
     s->log_dest = kapic->fields[0xd].data >> 24;
-- 
2.50.1 (Apple Git-155)


