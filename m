Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45729F3ED40
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2026 13:19:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBYEG-0007V1-N0; Sat, 11 Apr 2026 09:18:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wBYE9-0007Sh-29
 for qemu-devel@nongnu.org; Sat, 11 Apr 2026 09:18:22 -0400
Received: from p-west3-cluster3-host9-snip4-8.eps.apple.com ([57.103.72.239]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wBYE6-0005qU-2G
 for qemu-devel@nongnu.org; Sat, 11 Apr 2026 09:18:20 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-8 (Postfix) with ESMTPS id
 A93DE18002A3; Sat, 11 Apr 2026 13:18:11 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1775913493; x=1778505493;
 bh=lF0jdyfsX2D7PN9TMkL5HOWX7JJ7u8+26yUNFPoFu10=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=bvf2a8I4RiHONEStDVJCoqvu+3ACapA8894YJW/R74tMZHFpA/UZ9Xj77lFPgpGZfqxSlQOvCRSNPsomN5/+aJZymtfAv+Hx6iv2QrnOJ3UXDKzqcJwRmqJ5+B3WQVygpfRRlzPuQJQx2flusRSTwZDSzVsDNxNCaEj13vGIwfGkv5rQ8bkbtAy4pT5SovKBa5Uz+RBGwr0DqbSENvefYFhZ7QWGpWumULIBvJ4rwDKwzRr5uOTO518Np/RItkeNdrcB0DRSZepwG+Ah1fL5gPXOigYJ3oetAOYM2pM0ekwfLNqjON4uJZ6OfJPe8/ijBLVNse5mixydfZeRNEoRgg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-8 (Postfix) with ESMTPSA id
 C991F18000D0; Sat, 11 Apr 2026 13:18:09 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH] hw/intc: apic: stop register accesses for invalid situations
Date: Sat, 11 Apr 2026 15:18:06 +0200
Message-ID: <20260411131806.94653-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDExMyBTYWx0ZWRfX6KuJnfN+jstx
 6j+i1jvrST3m/ebDjNlLd3H5cNhqGcT4WVN8/SPkO4uwquQi6zi4ALnQZckV2g6p7WDvWn3/GBj
 3y4aGuxYsMsQ5k/6BmhNocJkianZiGqqZa1m0zhMkq/fXi/f5YW4LmMJ1MTCP00rjNL4T4IZkOu
 OuScpcYR17UvWoQsGPvzE/oV4ejyfrmwz6UnMj6wDoJqBMU+OM28uPxtdv9eIvwViWeTdn+ukN0
 BVXj9/cE8E9jDrTiotau+zGrpMr54csY2DL/2OiCJLOZo+aV3lkmUFFivYfuYRzIPRpyLBHrL4Y
 qCfKX4KheKLgym4XAIsip9bgUSFmHTomMjECbWMbFwkl9Dvhuu8oO16EXqrw4o=
X-Proofpoint-GUID: gokvfFS0J8BPtV1u1cNTx0UxKfmIr46a
X-Proofpoint-ORIG-GUID: gokvfFS0J8BPtV1u1cNTx0UxKfmIr46a
X-Authority-Info-Out: v=2.4 cv=F9lat6hN c=1 sm=1 tr=0 ts=69da4a14
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=zBtDF0ibdIbUSHW8crcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 mlxscore=0 clxscore=1030 suspectscore=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=821 adultscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604110113
Received-SPF: pass client-ip=57.103.72.239;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
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

kvm-unit-tests's apic.c tests for:

!APICBASE_ENABLE + attempting to read xAPIC registers is not an allowed
 combination.

And neither is x2APIC enabled + attempting to read xAPIC registers

This was tested on WHPX with kernel-irqchip=off with x2APIC emulation
enabled (in a posted series) and TCG.

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


