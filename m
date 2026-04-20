Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 458B2F5580D
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 10:48:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEm6N-00077e-DY; Mon, 20 Apr 2026 06:43:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEm6H-0006y0-R5
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 06:43:35 -0400
Received: from p-west3-cluster5-host11-snip4-4.eps.apple.com ([57.103.72.107]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEm6F-0000bk-SW
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 06:43:33 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-1 (Postfix) with ESMTPS id
 21E2918000BC; Mon, 20 Apr 2026 10:43:28 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776681811; x=1779273811;
 bh=ZKPoujWieITU4lFOoYMwoz+Ev2hRigYtFeWxrkrjtmk=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=fC41+bjobamaLoNii7j/C1lXIHx+syO6jSROHnplmk1IwNbxSKguUZxL3T/uE3+C+a7Zwpq9HsiPvU1HvNrCEHz7hlyhkR+1IPyrA7fslgev8rSGXq2gRhkGG8/22LD6BLWfY+1CNrakLsBtTBG81l/Boi5PWw2RkYZshKXCE8vgzalbSvkBRaoduKZLJtE9PqdY+j4qfvILrhYPBBjXF8aDwVBqb3s8a1f9fV3hze53UbZM3PnkGVjhQFu6ZsTNwtrA2rwmbBUPVN6hSZ2tHzUbZW5hB1zc2Y/DpGYA5LNWhUxi/w88uTAIgszr6Jtrh70t51YWCT/bhxlDFoc0wA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-1 (Postfix) with ESMTPSA id
 564EF18000A8; Mon, 20 Apr 2026 10:43:26 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 14/38] hw/intc: apic: disallow APIC reads when disabled
Date: Mon, 20 Apr 2026 12:42:24 +0200
Message-ID: <20260420104248.86702-15-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260420104248.86702-1-mohamed@unpredictable.fr>
References: <20260420104248.86702-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=b4e/I9Gx c=1 sm=1 tr=0 ts=69e60352
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=JYwUPf56aOQolOdNqfgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDEwNCBTYWx0ZWRfX9DgcYt0tomOa
 ARX49ThUrj3kbjjlvxp+slIiNlI4M8YQYqmuv/RkrA+VjzTw8SXn7x86HVygB2rKxSzJkI2rfrd
 VOfbaJZ8cy1Uq5/CDlUk0Aip9+x/E7mS/40XQhn0IL6zedyIU0c+ltvBggM7STo/gsgWATA2cnc
 jl6ar+mMnS9EByhIeJd5tek7qE0NCtlH6vOu7b3ACVxh71qDeOqo087ntdPvh2VuFmY5r6uoGXo
 lmEvg7mgKEH6ksVz7tDzeUIrqGnPtYfcX7/BMaxaSlDKCpqj0GL+1yy8AyKddJyE9pcEyl1v19M
 ouN4DoaIpPGOQAMQ5u01LGZN2XgXDHyOjH33z6OQXuxegCNKJF1VG+tZV+Ercw=
X-Proofpoint-GUID: BDxHLjnW0i30Vvh8xCView2pLlXS9wfB
X-Proofpoint-ORIG-GUID: BDxHLjnW0i30Vvh8xCView2pLlXS9wfB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=821
 phishscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 suspectscore=0
 spamscore=0 mlxscore=0 malwarescore=0 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604200104
Received-SPF: pass client-ip=57.103.72.107;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
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


