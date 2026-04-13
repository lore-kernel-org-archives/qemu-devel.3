Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F1EF531CF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 20:53:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCOGu-0007V6-M7; Mon, 13 Apr 2026 16:52:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wCOGs-0007UY-Pi
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 16:52:38 -0400
Received: from ci-2004c-snip4-8.eps.apple.com ([57.103.89.31]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wCOGr-0007xb-6J
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 16:52:38 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-10-percent-2 (Postfix) with ESMTPS id
 4C161180016F; Mon, 13 Apr 2026 20:52:34 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776113556; x=1778705556;
 bh=SCqUAJvB1zqKRh44vHU0QIqywz/suuWsKXqtx/ZiPkM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Ay7pzWdc0PbCCWNrFy4wiemZN55xXOzSmmphEeKdeUEzOGCAvG0Lma4EfSWNlR2u1Pn3FyXlVlQRhL8jqAMk4pBmqCZ08CkswD79jgbZuwxdEtpSnuAywaO73gipHrcPhcXqU04oknnvFg06SNITekHNzjqwun2CKZUEcVGlKqlkF72v/PK4QoWbYLYKyDU+q4pL81tkE9Wrsed0ShWRNM+GegkUbU81CgWoDIpxcLEYD1DaX6ki7pooMxCrJ1YNLppZFPtZFvk67leLN3l9naMpqIsw/V0BMy28NgIbo9inz0xKFOfh72JkJPCz0MA62u815vYeH7KCvs+2LvxTZg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-10-percent-2 (Postfix) with ESMTPSA id
 5E19218000A1; Mon, 13 Apr 2026 20:52:32 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v12 14/15] hw/intc: apic: disallow APIC reads when disabled
Date: Mon, 13 Apr 2026 22:52:06 +0200
Message-ID: <20260413205208.50643-15-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260413205208.50643-1-mohamed@unpredictable.fr>
References: <20260413205208.50643-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: biXfL_zXGr4ZH8jeq-6SRLVgXCw7NV4Q
X-Proofpoint-GUID: biXfL_zXGr4ZH8jeq-6SRLVgXCw7NV4Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDIwNSBTYWx0ZWRfX6pLSp6DvRl7E
 hEvnDoGmY+DjKU0vZ2o0M4BNYvN2UTJ2E/4nZsq5wr/iZhoTGb1mXw7UDewNalQZqsH87GPWMHy
 IAo5yBU1fJiYmuaXP4oyg1OOqH5VWlDs+GghL5NfACCNGY3KwtFMFDxRLomtOsY5kq2mgvW1L25
 4ruAexlIeAi/U2NJ/ZJ0rWPvHWPwSEcmlifCnkZE2Okn67F7jln/EceNtrF/8ZF3nDR9YEeO0X1
 XR5pRxY9b8J6f0PSqClUHUhJUY4zLDKs0u4WnNvGMZASyQi76XG5YWzOqeOTtEg1HmSOc3xk8+2
 i1JIFpqjROwbo61Z5yot3JTPGR9Jf5f5gNBuJuvQ9joyrnVjt02VlycvU+UNiU=
X-Authority-Info-Out: v=2.4 cv=Rbidyltv c=1 sm=1 tr=0 ts=69dd5793
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Sz3nRv2TKcqVAncp5HQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0
 clxscore=1030 mlxlogscore=800 phishscore=0 bulkscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604130205
Received-SPF: pass client-ip=57.103.89.31;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
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

!APICBASE_ENABLE + attempting to read xAPIC registers is not an allowed combination.

And neither is x2APIC enabled + attempting to read xAPIC registers

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 hw/intc/apic.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/intc/apic.c b/hw/intc/apic.c
index 8766ed00b9..c09dddef39 100644
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
+    if (s->apicbase & MSR_IA32_APICBASE_EXTD) {
+        return 0xffffffff;
+    }
+
     index = (addr >> 4) & 0xff;
     apic_register_read(s, index, &val);
 
-- 
2.50.1 (Apple Git-155)


