Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED369F419BB
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 13:31:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD0JQ-0007IA-2M; Wed, 15 Apr 2026 09:29:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wD0JP-0007Hr-49
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 09:29:47 -0400
Received: from pv-2002f-snip4-4.eps.apple.com ([57.103.64.225]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wD0JN-0004B5-NY
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 09:29:46 -0400
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-11 (Postfix) with ESMTPS id
 9E31518000BA; Wed, 15 Apr 2026 13:29:43 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgDTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRNEwVSB11NVg1HD1geXBQXCEVDXgheH0wcHQ5YBhIATQoONgZZBV4JVgNDBTYSFF1FRgNHGVcUUBtHDFUHV15fChMAXg8PTAtIAVsHXwNFCEsBVAVdHEUBQARVGloCXVQXWwxaDlYwTBZDH1IPWxNNGVEBUkVUAgdYRxRHDg8TTAtHAlo0Vh9UGVoD
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776259784; x=1778851784;
 bh=9xbxyGGfjNH/HWQDHlAQCg/qgFyvlvlu7VNj5bZOFog=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=YcabFpKCC+ajmEvqJpjjbCmMFHEdMy44d8hXMr/uQhisoThgdUV+Jhc/onoQvLP3LlimyQ9rrQQmdy9BGb+Cn/YCyvKEfR9RyKr+kGZYUuGo7qw3cyim2vKckt+qDvXX0LSou8aevNwXoueX8jg36/0GL7Zvc0+/wi5aF09hySiCuLP8/dzv7dSqr9kxgX5YpHGBmYgh+LynN8QmujOMpWDjSsbBWE0jMvhT3bzbPreHkQhDpCMNoVFCSoqmPxHy/910ENf1pHlLH2WeDMunfI4gC1mm8MSTa7nW2/Jfexpjv2ZpAg6bfEnxPmaGUQGxtL5H0AWlyqgXvnPkY3VYyA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-11 (Postfix) with ESMTPSA id
 426061800362; Wed, 15 Apr 2026 13:29:42 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH v2 09/10] whpx: i386: some x2APIC awareness
Date: Wed, 15 Apr 2026 15:29:25 +0200
Message-ID: <20260415132926.58878-10-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260415132926.58878-1-mohamed@unpredictable.fr>
References: <20260415132926.58878-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: phjAUR7gjixZphf7-73Sn1SPhLrDNdQD
X-Authority-Info-Out: v=2.4 cv=QsdTHFyd c=1 sm=1 tr=0 ts=69df92c7
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=IZZkQHPJHa8VUPCOrf4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDEyNSBTYWx0ZWRfX57tFaMmCYQzt
 0VN3WVyVpH+HEyxvSFxSfF1sA24zMtgwboS3Rx58/r6J3jyDfDDtv3IS2S2+QebHCPBwGcRSGzV
 mZP4yDp10LJ1c1HeDFQkUY08AbuunmTH75Jaw3A83kKqOCcYDMuFUWR8x+swGu4EzgjE4/rz3JS
 1dJQOg4mJvk/meul9FnOxCm0EVUXbHN1cKA0b1JgXyBq6mMOg1We/fyFCDOhoEjOU5bILk7vMAA
 kL0WtNJxjzJh0j1iAM7IGWYGfrqDgKJ3guxB3V8a0Fol0KzcQ+QM5VxtXi7HPsJC/p2lz4BgTVS
 axSE/BUN8vfB8yeFcUregygUrlm6s9dQ4IAnH5tuhe3XZSX5ExiNgHkiOO9C/Q=
X-Proofpoint-GUID: phjAUR7gjixZphf7-73Sn1SPhLrDNdQD
Received-SPF: pass client-ip=57.103.64.225;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


