Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 875E5C369D7
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 21:45:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7huF-0005D7-MM; Wed, 23 Apr 2025 17:45:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1u7hu9-0005AU-A3; Wed, 23 Apr 2025 17:45:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1u7hu6-0002mG-Rb; Wed, 23 Apr 2025 17:45:16 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53NLh9mJ014934;
 Wed, 23 Apr 2025 21:45:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=vGKanFs/llgf5AvvC
 KwDpFDL2TMYbQ4sUcJ+mfE1oNg=; b=QqnoZjeaJj+4jkokInL61r+Asuc2CIOds
 Q+6Lx2asVNa5Pp7pMBipAawwilB+THL8/q1oqYJS5B+UEUMBB6y9PDTX7IoBwnf8
 C0Cg0TG+7oLebHaELShT6o+0/Zunf2XYo3DTJFhoXrESobE1a7ckAXE2QBiEVNPf
 1eYciwACPnhmPUHgItdDZ0AsaxNHABJe9LNTA7tdk61aBqfSSKJ7NNbU942C8T9e
 eyOk7k3lWxn6ZUv1bP6BpkgEnnk3COxqdCrstKrpuVqvYxpTI9oGjy2jVIpU+5DZ
 xEhsFeYLwBugZ3DuZAN3uL6TyjvcAQqru32fN81qtfKg5jpz8MBMA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4678bw80b6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Apr 2025 21:45:11 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53NIiDxj005884;
 Wed, 23 Apr 2025 21:45:11 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 466jfxd501-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Apr 2025 21:45:11 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53NLj7oD64815552
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Apr 2025 21:45:07 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B97BB58059;
 Wed, 23 Apr 2025 21:45:09 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 91C8658053;
 Wed, 23 Apr 2025 21:45:08 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.253.34])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 23 Apr 2025 21:45:08 +0000 (GMT)
From: Rorie Reyes <rreyes@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, clg@redhat.com, thuth@redhat.com,
 akrowiak@linux.ibm.com, rreyes@linux.ibm.com
Subject: [PATCH v6 1/7] linux-headers: NOTFORMERGE - placeholder uapi updates
 for AP config change
Date: Wed, 23 Apr 2025 17:45:00 -0400
Message-ID: <20250423214506.72728-2-rreyes@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250423214506.72728-1-rreyes@linux.ibm.com>
References: <20250423214506.72728-1-rreyes@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDE0NSBTYWx0ZWRfX4sa1Ir16L6/4
 VoDwHKi7EnrzIuWNWIT0U5f7n5gKL+qK0HcTA+McsQTFWmA1GR5ehKklAwKCQasCltFmd03cJ87
 P2GwT7gwFOqSUbfKmjkFmLCF8cwpRJBuMqoA12SgyNhOWiy8qwSP4D1LtTd4vP1f9TmSGa/GzwM
 0svBPLf1GPTSSH4lRALPPG85CL+vhDz21hFoUumVHLLJxU2esAPdnXp1Oxhi5gnS1Xw4TxAsHcd
 2ZjviFHhd7L9BEfDb0GLCa+ABd0aajPo9RNRD6cbs9TvbBn2IkdKRsuHuyBeBdlwpNpnrYeFkE6
 dQILwllFIIN7DNtkEGgUIhIBwhcg/waRuZRMGeVqlwKKyhLQXvUHRyoIphS+mOAmI4fJhcctFXn
 mSTjCmWs21VrOtd+lrOT3VHhSP5/xD7fo7LDwa+K4PkiBKkkXY+rg1myq7QER+/s65j/yEAK
X-Proofpoint-ORIG-GUID: fKWKftQYz_HRetToq9ZhE58jSoeS4hTr
X-Authority-Analysis: v=2.4 cv=KZzSsRYD c=1 sm=1 tr=0 ts=68095f67 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=_CxH22ki6sYGygkZA8AA:9
X-Proofpoint-GUID: fKWKftQYz_HRetToq9ZhE58jSoeS4hTr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-23_12,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 adultscore=0
 clxscore=1015 mlxscore=0 impostorscore=0 spamscore=0 malwarescore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504230145
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rreyes@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This patch adds enumeration constant VFIO_AP_CFG_CHG_IRQ_INDEX to specify
an IRQ index for signaling that a change has been made to the guest's AP
configuration. This is a placeholder for QEMU patches that use this value
since it is a linux-headers update which includes changes that aren't
merged into the kernel. Linux-headers patches should be generated using
scripts/update-linux-headers.sh.

Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>
---
 linux-headers/linux/vfio.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index 1b5e254d6a..d0426b5ec0 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -671,6 +671,7 @@ enum {
  */
 enum {
 	VFIO_AP_REQ_IRQ_INDEX,
+	VFIO_AP_CFG_CHG_IRQ_INDEX,
 	VFIO_AP_NUM_IRQS
 };
 
-- 
2.48.1


