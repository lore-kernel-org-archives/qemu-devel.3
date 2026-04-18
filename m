Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D76F99C9C
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2026 22:34:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEEEd-0006Fe-VB; Sat, 18 Apr 2026 18:33:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEEEc-0006EX-BJ
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 18:33:54 -0400
Received: from p-east2-cluster3-host12-snip4-10.eps.apple.com ([57.103.77.191]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEEEa-0004vR-WB
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 18:33:54 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id
 1425418000B4; Sat, 18 Apr 2026 22:33:50 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776551632; x=1779143632;
 bh=ZKPoujWieITU4lFOoYMwoz+Ev2hRigYtFeWxrkrjtmk=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=CxF8QgQW+tStUw6ukGlpap0waEGdhTnrkGVxquGmIRODwfjuQbNVAZnf+vsvigXaO5keIf8Rnb3owTmtC3d/KHhQ/U+6u612iI8y/uclPePEP//6S96UC2LK5S5WQ9T7eAOfoO1vLTmcZqqxFnJFiFnodp+xOJKl4jUsfN/urvJPKKz9TuPOBbg7AZG0JOTlWRMeM1Fzy6NiF3eC9t4Ntd9rn7lhyj1ts2Y8jrFjnypivZxpRwT80RejQ8y74Y+/9T/TD9qa2zn/H1DxEpRUus2TUIO5FDfWGxEbpYao3uceR1mN5a6lWBWsUJh8g6adKR32uHESdvWhvPO9wVtO1w==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id
 E83E31800208; Sat, 18 Apr 2026 22:33:48 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 14/38] hw/intc: apic: disallow APIC reads when disabled
Date: Sun, 19 Apr 2026 00:32:56 +0200
Message-ID: <20260418223320.51330-15-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260418223320.51330-1-mohamed@unpredictable.fr>
References: <20260418223320.51330-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: CoVy3Xd7475ZqhG64IkpEEKn__iMH0xs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE4MDIyOCBTYWx0ZWRfX6mgpljENIahD
 Euh/ON6z/z1qWQxFeftQyAdhwC2GBqJHjV8aJQ+yesn19jvfiGgfiY960l1ribU+7CKehv5DzNy
 Mu4MLz12jtK3lKED5NLL9WCSD+ENNlRwW4kKAh6AaQa2w3PnPUSmPeK/AYR+MdYrcKP/qh+alys
 OQjNrB6RzAt2WuTziG0HyLw4T9JMXgMT39qYOxbIsUo+eBLs9hk+XYzWTCJoIQYG4oaRfwUh4Np
 nPidC/04MkcUVEZp7pXtaQFrYQVMyRi+IQSQLRVd7TisopapFK4iHDw2gFS1UVUJo0oEfFBGY2x
 F9Sk40PO+Qzy803AhdN9uAsPLxsxOywBUMklc87Gasow7c+WMRia0F8yvsqmJo=
X-Proofpoint-ORIG-GUID: CoVy3Xd7475ZqhG64IkpEEKn__iMH0xs
X-Authority-Info-Out: v=2.4 cv=T9mBjvKQ c=1 sm=1 tr=0 ts=69e406d0
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=JYwUPf56aOQolOdNqfgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-18_06,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 mlxlogscore=821 clxscore=1030 lowpriorityscore=0 phishscore=0
 mlxscore=0 adultscore=0 malwarescore=0 suspectscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604180228
Received-SPF: pass client-ip=57.103.77.191;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


