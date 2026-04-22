Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAF1FFA1FFF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 21:44:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFfLY-00083G-6T; Wed, 22 Apr 2026 17:43:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFfLW-00082K-GX
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 17:42:58 -0400
Received: from p-east2-cluster1-host11-snip4-10.eps.apple.com ([57.103.76.53]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFfLV-0007G8-5c
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 17:42:58 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id
 017F9180096A; Wed, 22 Apr 2026 21:42:55 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRJAU1fDl4fBBdGGVUERx5dVkAZGQJRHFYNV0NUBF9QSQxBUGxaAEcXSB1dGVlvUF0cDhhZG0AVXRFQGVYJXhUXHkFNWgJWTQVKA18BWwZCC0oCWQVZB14LSgdfGloHXVQXWwxaDlYwTBZDH1IPWxNNGVEBUkVUAgdYRxRHDg8TTAtHAlo0Vh9UGVoD
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776894176; x=1779486176;
 bh=ZKPoujWieITU4lFOoYMwoz+Ev2hRigYtFeWxrkrjtmk=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=FYHd81PyOQQMFwzULiOUV6YrlrcCWSR86Y2vTU+3E7FTBXjQ0QJuONoPxFWYRyVcfXfPixyloA3FtEZDTP7SBJ15mj0c0LRaEQILYYPOwh8zXSIO6surH7lKJMqOC4mtXt6BQK9jrdAX1EL9R/hDlquSQeb52dt3S4t/jwIqmS+Nh5l56NFUkWQXeg/vu+yUrz4H5FMqbBP+2dPx1bTVum44rzUkdxlG+TwGjYNIg32/XSb3Pc5n9BSZd13zjlnYCJRIc8ehHxjM9cak/UHBG0JHRoMXTQNbtb6Tbxjiknj5Syy7XKn05u8Db9MuZ5ma0CW03okwioqx2jjQdclMDA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id
 431CC1800230; Wed, 22 Apr 2026 21:42:54 +0000 (UTC)
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
Subject: [PATCH v3 14/37] hw/intc: apic: disallow APIC reads when disabled
Date: Wed, 22 Apr 2026 23:42:02 +0200
Message-ID: <20260422214225.2242-15-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260422214225.2242-1-mohamed@unpredictable.fr>
References: <20260422214225.2242-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: hQesJzdeXIdUFCn6hT4rmvmdXjO4kuNg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDIxMSBTYWx0ZWRfX95RtQ0Ck+aY7
 0r3hzAc+R7noqmggXUJifgh0hs69C0Yl13m4S04Ag1Ipa4Er6tQhvXoKT1AM/YDsAQZ45w4Hl2M
 /6YrAdRX2sKVkU7ny5I7oa7O8NVQ/NKm/SncHo2wDcbWln7Bd072Q2uSCPJbLMlY6zeLI67WdrM
 20gLFq5OJk6cLI/8j0aA0hNA/VuX3Zb00YpQ59H2um9XAJRW9nfMxNZmKXXlTCPjkhKmlG9iiJT
 LrC7BOYr0JJFuWrXFJL2qMWjM60a9fb03/iepjzxQIjUXOi9zCoLVL+fYvPgP7oWr71PGhU411k
 6WFn2B4T1ppu/4cRqVFW/y8kulSuBMkuAg4tmV7dbixq2LoNdVErZ0B+DZR2Vo=
X-Authority-Info-Out: v=2.4 cv=BpmQAIX5 c=1 sm=1 tr=0 ts=69e940e0
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=JYwUPf56aOQolOdNqfgA:9
X-Proofpoint-GUID: hQesJzdeXIdUFCn6hT4rmvmdXjO4kuNg
Received-SPF: pass client-ip=57.103.76.53;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

!APICBASE_ENABLE + attempting to read xAPIC registers is not an allowed combination.

And neither is x2APIC enabled + attempting to read xAPIC registers

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 hw/intc/apic.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/intc/apic.c b/hw/intc/apic.c
index 8766ed00b9..e5ea831261 100644
--- a/hw/intc/apic.c
+++ b/hw/intc/apic.c
@@ -875,6 +875,15 @@ static uint64_t apic_mem_read(void *opaque, hwaddr addr, unsigned size)
         return -1;
     }
 
+    /* if the xAPIC is disabled, return early. */
+    if (!(s->apicbase & MSR_IA32_APICBASE_ENABLE)) {
+        return 0xffffffff;
+    }
+
+    if (is_x2apic_mode(s)) {
+        return 0xffffffff;
+    }
+
     index = (addr >> 4) & 0xff;
     apic_register_read(s, index, &val);
 
-- 
2.50.1 (Apple Git-155)


