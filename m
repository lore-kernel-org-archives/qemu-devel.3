Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0074F34C5C
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 15:25:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCJ90-00063a-Er; Mon, 13 Apr 2026 11:24:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wCJ8n-0005cA-Uc
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 11:23:59 -0400
Received: from qs-2005h-snip4-2.eps.apple.com ([57.103.86.203]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wCJ8k-0000Wf-2K
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 11:23:56 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-10 (Postfix) with ESMTPS id
 2D42D1800111; Mon, 13 Apr 2026 15:23:49 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776093833; x=1778685833;
 bh=SCqUAJvB1zqKRh44vHU0QIqywz/suuWsKXqtx/ZiPkM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=FZyetyY44Ph+mBFSFnmmiKimJ/NmiyZ5O+zcTbVejoorf4EEJuAXcXrC145Mp19c0kEUcAUgn6uFGwTfVAubwxMqEbPxxTwoCIOQEOTHQwCDtyDBTA21jn8+JmLAWkMzGm1275XU3eIXMeX0bls10iMp+9jo4HQlqxmsAcYVzdcYk95YsVm0VsHS4ssijXa8QDxyltt4tvxlkdJzrMnSZ3At9hI/TQBB5jf4hnYac3HHrGTO+csoMj23TWoHVC3fQR64ZtIO9LCcka+ZqEja/sD6oAMJvLBucHRLcmXh8tCIgRYW8kWvaGHoYjvDo/AVRykazZfIgjK1Zrd2/vAJjQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-10 (Postfix) with ESMTPSA id
 DB9A61800103; Mon, 13 Apr 2026 15:23:47 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v10 13/14] hw/intc: apic: disallow APIC reads when disabled
Date: Mon, 13 Apr 2026 17:23:25 +0200
Message-ID: <20260413152326.63738-14-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260413152326.63738-1-mohamed@unpredictable.fr>
References: <20260413152326.63738-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: jo6XZAgya5S1hpQad2hJpOZgwLCtAGsV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDE1MSBTYWx0ZWRfX5Eq1l4INaBew
 OZ86TkVTmiIvuuUibuyzHNYeVBVbA3oLT7xtz2oX6j8w2HO++qiAKYPT8D69n14YRycoZBJY1WI
 fcxxhGa76LqGDJDkbZ2WeOhCW/Xaxt8yyIclfjH/sxlW6K3DkuRckejKWJ3Vye3Oc6Ha4Kupvdx
 pJeFMtEzEyRH091c9n0ba+LLc0PtM9z3gozXK8CiqHGgEO2yqVNW6WAHA9fz+qgr/87/rx845Nd
 sCsSSueiIh4xJChu+P/FwAQWQx3QaIYi0gCbxziVKAQ0/H5ovLK5YBs8oAcjKou33deWx+2mn75
 ouU3yNv4phv6CnE8RevtVE6XQjxWUVsSCrBEY7oH1kyQCryDGjQi3yS5WvXZKA=
X-Proofpoint-ORIG-GUID: jo6XZAgya5S1hpQad2hJpOZgwLCtAGsV
X-Authority-Info-Out: v=2.4 cv=HdsZjyE8 c=1 sm=1 tr=0 ts=69dd0a87
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Sz3nRv2TKcqVAncp5HQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 mlxscore=0 adultscore=0 phishscore=0
 suspectscore=0 clxscore=1030
 mlxlogscore=800 bulkscore=0 lowpriorityscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604130151
Received-SPF: pass client-ip=57.103.86.203;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
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


