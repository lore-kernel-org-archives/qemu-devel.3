Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40BB3C982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 20:28:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Ii0-0005pn-Ab; Thu, 17 Sep 2026 16:27:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1x7Ihy-0005pS-HR; Thu, 17 Sep 2026 16:27:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1x7Ihw-0003NH-QM; Thu, 17 Sep 2026 16:27:50 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68HHVikN3156333; Thu, 17 Sep 2026 20:27:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=Y9ifuEC4mlZHuh3IWYyYEx+Pu3/b0sXHTw7Fo/IPO
 So=; b=D7seGcSKn6ZALWkxx8U1s+6wrjt+8odh0TFdHXxNLN0N01L3nOEKYgdHi
 tBMvHebH17zRpzbGdOjwzEKoW4e5IMyvqRyTdpZbmHgzumzaBgdnML/QGUdvLxQk
 v0IB8SiUoNOfMc6XCFWuHj4SkObnXF1ZX/mvCGIMpEUYSKQ7ZlrHsud0NE+HKEcj
 kCpsqRoR2wxCkl1LNQvsdNEp0WZMYn7QBQQuOS2Q+y7IONp2ok54Hwg6aPrsWs4d
 ED5MdfLTMFJY4BNm3u2TswWdxPb8ufsj5NiWLKrDeGYeXS9eCKb190RvATtmhx7i
 cCTlVj3vhtrYo+FOpPkeYUAokpcGg==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxf5cpt0-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 17 Sep 2026 20:27:42 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68HH93BC3474611; Thu, 17 Sep 2026 20:27:41 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gra3fb9yn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Sep 2026 20:27:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68HKRbcY48628222
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Sep 2026 20:27:37 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0BFF32004B;
 Thu, 17 Sep 2026 20:27:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F3C1120040;
 Thu, 17 Sep 2026 20:27:34 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.87.129.95]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 17 Sep 2026 20:27:34 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com
Cc: npiggin@gmail.com, amachhiw@linux.ibm.com, jasowangio@gmail.com,
 Chinmay Rath <rathc@linux.ibm.com>, Lazymio <mio@lazym.io>
Subject: [PATCH] hw/net/spapr_llan: validate RxBufPool fields on migration load
Date: Fri, 18 Sep 2026 01:58:41 +0530
Message-ID: <20260917202854.288439-1-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 79vKNTInEzxlPMnzthFhWZMT1pP7Lx8W
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDI4NyBTYWx0ZWRfX430O2ajc07ma
 jgPO+4XtdnGf6HEgv/hnWvYkKHjwG70Bu/XeLsmaFxXC6I3FVT58xEqO25JO84ouH2/btvxBEqY
 p6g7/aEYXlp/+0LO0hyaX+2tyUkAk7g=
X-Authority-Analysis: v=2.4 cv=cvgOAF4i c=1 sm=1 tr=0 ts=6aac4d3e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=p0WdMEafAAAA:8 a=VnNF1IyMAAAA:8
 a=X-KEfNhN3815lkfU2ToA:9
X-Proofpoint-ORIG-GUID: a7Eg-yPWY44R_S2zEaE8yuqZB9Dwnb50
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDI4NyBTYWx0ZWRfX3e9XW4558yFq
 hcYtE6cpPsUdP3B+o7QH+WbNoE4yi7ld2hGsnZpn1UJ1P00d0toGZSQpvbouAtnIHHdOH2zJ0Bu
 Wbdgh8eMKORdr8TETNUe4gxJTOwDdWbpqd0aqw8WzFGcT2v2zeKNE1PISvgjvZd43HQ0L7KbLxk
 t0OfJx78sUenQHLxtDtwhYAfnK4h5Q7VeX1sqx4qzwZqUvm2jjh9n9RUGGfoUgHj9plR1G8OGVF
 As4nlHJBwkEZJhiU9PPXt8Pp80YJMhVFKnFLfmSd+SL8Er66CLbBrRZ/IWOtaYpo5max2jZje+b
 MhdvEECXVrURl6prp172CI/UDzXWnNiB/92cDi3METPRHElz9OB6d9xlHRd1vV6OBKwzDQg5v3D
 aLX4kV/2Qv490JRCmFPsMLSXq0pYyhDHlFjK+TdQBVn7wmKUndEHgMsPq4UR1og8uQih64VXWnu
 fUVBqDNfPKVLE3h9ChA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1011 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170287
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

vmstate_rx_buffer_pool restores count and bufsize as raw int32 values
with no bounds checking.  A crafted migration stream can set count to
any int32 value.  spapr_vlan_get_rx_bd_from_pool() then passes the
count > 0 guard, decrements count, and uses the result as an array
index into bds[], a 4096-entry fixed heap allocation:

    dev->rx_pool[pool]->count--;
    bd  = dev->rx_pool[pool]->bds[dev->rx_pool[pool]->count];  /* OOB read  */
    dev->rx_pool[pool]->bds[dev->rx_pool[pool]->count] = 0;    /* OOB write */

With count == INT32_MAX this lands ~17 GiB past the start of a 32 KiB
heap object.  Additionally, a negative bufsize silently compares as a
huge value when widened to size_t, defeating the bufsize >= size + 8
pool-selection guard.

The hypercall path (spapr_vlan_add_rxbuf_to_pool) already enforces
0 <= count < RX_POOL_MAX_BDS; add a post_load hook to
vmstate_rx_buffer_pool that rejects any stream violating the same
invariant, failing the incoming migration.

Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4147
Reported-by: Lazymio <mio@lazym.io>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 hw/net/spapr_llan.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/hw/net/spapr_llan.c b/hw/net/spapr_llan.c
index 550848307d..a5b8906849 100644
--- a/hw/net/spapr_llan.c
+++ b/hw/net/spapr_llan.c
@@ -800,11 +800,29 @@ static bool spapr_vlan_rx_buffer_pools_needed(void *opaque)
     return (dev->compat_flags & SPAPRVLAN_FLAG_RX_BUF_POOLS) != 0;
 }
 
+static int spapr_vlan_rx_buffer_pool_post_load(void *opaque, int version_id)
+{
+    RxBufPool *rxp = opaque;
+
+    if (rxp->count < 0 || rxp->count > RX_POOL_MAX_BDS) {
+        return -EINVAL;
+    }
+    /*
+     * bufsize is compared against a size_t in spapr_vlan_get_rx_bd_from_pool(),
+     * so a negative value would compare as huge.
+     */
+    if (rxp->bufsize < 0) {
+        return -EINVAL;
+    }
+    return 0;
+}
+
 static const VMStateDescription vmstate_rx_buffer_pool = {
     .name = "spapr_llan/rx_buffer_pool",
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = spapr_vlan_rx_buffer_pools_needed,
+    .post_load = spapr_vlan_rx_buffer_pool_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_INT32(bufsize, RxBufPool),
         VMSTATE_INT32(count, RxBufPool),
-- 
2.55.0


