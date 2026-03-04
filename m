Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A014EDEC04
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 03:01:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxcTH-0002Y8-Ga; Tue, 03 Mar 2026 22:00:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vxcSe-0002P4-P4; Tue, 03 Mar 2026 21:59:46 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vxcSd-0000XE-DA; Tue, 03 Mar 2026 21:59:44 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 623ExC501479574; Wed, 4 Mar 2026 02:59:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=b/aS1tLVCDH4kLdLB
 0fV8bpzAvHDnUaWyiKJHZQap4c=; b=maVQTHX4YStN7+BTizwB6FVHqtJ4wfGce
 Ml536aYHQ/IQtm5pRwkMgZnb5Sh6+TeU1ZX2kwpIIGG+k3hxIwvqo9pG7nGqW0h8
 yB6OpFNadavjvKFSX+2P0VJ5psIWf+a/ufWF20MT6rxfDrSD/vq90Dxe71/9Eqow
 evfN1vNVT2Ek6nxbyHBjivgvxlWfiOTtBOhdQYgxVNvpT3Yj4AN5/l740cYlSVef
 TyNuS4lf7MQMog+lBRDKVTpqv7IQ48F/iKpGe9oYx5S4oDC/eTHajmiQn4mVYgcr
 dBvCTrv+2bKDjoJX+oZQVGotFthB0s2elt9mv1pXgR4yP18hzbydw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksk3wc7c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Mar 2026 02:59:42 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62411T0H008782;
 Wed, 4 Mar 2026 02:59:41 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmdd1cpxm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Mar 2026 02:59:41 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6242xdis590726
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Mar 2026 02:59:39 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9D86758053;
 Wed,  4 Mar 2026 02:59:39 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 792B358043;
 Wed,  4 Mar 2026 02:59:38 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.180.105])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  4 Mar 2026 02:59:38 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com,
 mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, jrossi@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH v4 09/15] s390x: Add definitions for PCI IPL type
Date: Tue,  3 Mar 2026 21:59:11 -0500
Message-ID: <20260304025917.2157032-10-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260304025917.2157032-1-jrossi@linux.ibm.com>
References: <20260304025917.2157032-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YVhjo97yVW5KV1Dc1B21hq3WhXADXD5y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDAyMSBTYWx0ZWRfX5mbkk141ECOg
 fHSJlAjpEbEpz5ApZBtB7edtnchXsFba3+mx3oj1oLI78AW3YcTd+fNgHhKLiPXBLLWc5fhT5R+
 e9qZ6k1Z4fI/RbP4cP3mdF50SB03GsZNTGDRcGR9rW0n+e6vvT8odbBTK4OuIPJkf8Nq0umVySL
 EdKnp23pyT/zEarTCx7oJgCZWeTuDe3lROorcoEFT7/6A51+R3iCD7J7v0ppyS3aKnXexyUmX1k
 QHMLsk9oxSLbsHcvFbb/N25OEljbwWMCNH0OXCjqMQF/A3xPlsbTtF9DL3NeCAGQxHaCT+rA78L
 59ETksC+GrcpV8ySO6dUP8GTZ9oe/ww4rw9kQK/TDHbAGrLxQ0ZbQyjNYwjsamCKYD9LzxIaZby
 3X6zV0pecYVzxOvsrWc8BxTK3V3OxPER0X4Mex0ABFJ9Dr5TcXsHmG7+mgckN4Fny8P4hKL+top
 jnPt5vQXa/dOYxDQNpw==
X-Authority-Analysis: v=2.4 cv=csCWUl4i c=1 sm=1 tr=0 ts=69a7a01e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=XaWLD1doWqTlIUYI0tEA:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19
X-Proofpoint-GUID: YVhjo97yVW5KV1Dc1B21hq3WhXADXD5y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_01,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 bulkscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040021
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Jared Rossi <jrossi@linux.ibm.com>

Define a new PBT code and IPLB layout in preparation for supporting PCI device
IPL on s390x.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 include/hw/s390x/ipl/qipl.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/hw/s390x/ipl/qipl.h b/include/hw/s390x/ipl/qipl.h
index 6dc12dd859..8d3c83a80b 100644
--- a/include/hw/s390x/ipl/qipl.h
+++ b/include/hw/s390x/ipl/qipl.h
@@ -23,6 +23,7 @@
 enum S390IplType {
     S390_IPL_TYPE_FCP = 0x00,
     S390_IPL_TYPE_CCW = 0x02,
+    S390_IPL_TYPE_PCI = 0x04,
     S390_IPL_TYPE_PV = 0x05,
     S390_IPL_TYPE_QEMU_SCSI = 0xff
 };
@@ -108,6 +109,14 @@ struct IplBlockQemuScsi {
 } QEMU_PACKED;
 typedef struct IplBlockQemuScsi IplBlockQemuScsi;
 
+struct IplBlockPci {
+    uint32_t reserved0[76];
+    uint8_t  opt;
+    uint8_t  reserved1[3];
+    uint32_t fid;
+} QEMU_PACKED;
+typedef struct IplBlockPci IplBlockPci;
+
 union IplParameterBlock {
     struct {
         uint32_t len;
@@ -123,6 +132,7 @@ union IplParameterBlock {
             IplBlockFcp fcp;
             IPLBlockPV pv;
             IplBlockQemuScsi scsi;
+            IplBlockPci pci;
         };
     } QEMU_PACKED;
     struct {
-- 
2.52.0


