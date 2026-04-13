Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82360F34C65
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 16:55:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCKYK-0007Y0-1K; Mon, 13 Apr 2026 12:54:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wCKXl-0006wM-74
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 12:53:50 -0400
Received: from p-west2-cluster1-host6-snip4-7.eps.apple.com ([57.103.68.60]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wCKXj-0005bA-RA
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 12:53:48 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-1 (Postfix) with ESMTPS id
 1F0DB1800EBA; Mon, 13 Apr 2026 16:53:44 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776099226; x=1778691226;
 bh=SCqUAJvB1zqKRh44vHU0QIqywz/suuWsKXqtx/ZiPkM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=KM9nd+mzg2DuAAMpzJ9/tpGllWc3XQK533a1LrsD8mDgbRDK6UwCAo6A9hfWAtKYH6+Dp+S6jjJYyECFP5cjDTPYs+8MPgewGZMjPoTNx60gYi8Sv4c8/A3+T9Bcexq9w5IqpLl0NsxVabhltdVqqQB9M7niXcgtrY1Pk219/DYHqQVf3eNQPmlcw+e+T7R0GITOmcmwUg81Ge0GP8H7gIwO8k/F1hPP6fbIc80zyIyPQaOwxeqmSKXNwWEpo1ILfXzNQNy8OKYXyoRC93vpiKJZ1kLV/Zo7HiePfomEpeH56zWVMOt1V3qODq0zDyOAozx0GlNf0J4pZs4t7VodoA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-1 (Postfix) with ESMTPSA id
 4EA1118023A5; Mon, 13 Apr 2026 16:53:41 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v11 14/15] hw/intc: apic: disallow APIC reads when disabled
Date: Mon, 13 Apr 2026 18:52:16 +0200
Message-ID: <20260413165217.47105-15-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260413165217.47105-1-mohamed@unpredictable.fr>
References: <20260413165217.47105-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: NcsbE5_Bg3kp2_1-i5uRuQEyXNbecz4D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDE2NiBTYWx0ZWRfX43q0zF5F96mb
 0HcNCH5sSnKnfk71SLJ4kUIbnqLPwWPZVS8snrG+Zqwcv5ACnOs/DzVYxJY0Bmw40KWLCXr7oEq
 81rZFy3aAmoyav2R1ykUegP4kEBGJcrS4rpcgs2eTV6dyWxseEikdgKE3/18Wzm7JOmPHdPmKeH
 ovyU4tA1AMoYZKLb20WmqAT3UCy2Llb4uHA48bER8ZdlmRP/GDjdOUvXo91RWRGWFjw20vLV2uG
 5Y7as/wMsVURBZglsKWkKItPvDob4tGmx65f5ySX5qOMsDinUK2qtT2q+DFFquUkb0m2y4FYtuJ
 R0cB8E0IhuIU1jDie1V0/V+0LOLpjBtZUoFLuXUJQX89z2f86qqgpNe1MR6OBY=
X-Authority-Info-Out: v=2.4 cv=RpTI7SmK c=1 sm=1 tr=0 ts=69dd1f9a
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Sz3nRv2TKcqVAncp5HQA:9
X-Proofpoint-GUID: NcsbE5_Bg3kp2_1-i5uRuQEyXNbecz4D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 phishscore=0 bulkscore=0
 mlxlogscore=800 mlxscore=0 suspectscore=0 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604130166
Received-SPF: pass client-ip=57.103.68.60;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
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


