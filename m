Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE96C87FD1
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 21:38:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujPLQ-0002Jz-TF; Tue, 05 Aug 2025 17:37:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1ujPLO-0002JF-GY; Tue, 05 Aug 2025 17:37:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1ujPLM-0002IB-Iz; Tue, 05 Aug 2025 17:37:14 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 575IpRem012310;
 Tue, 5 Aug 2025 21:37:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=/WgAexyOruxCFbJjM7FYMM6rPEt3DbBAHj0zhiCOe
 ik=; b=cbm/YXrooAD/Sj22zijvytPQgqf/kCgpyJWv4kZh2HVplTGvO+9yRn0iL
 /RdmgT6i6sWr7s7XBa90jIeatClEsr4RogMhwRu6HLfr11hNcz7RLcNcT96O8lyq
 WrvUm3gKNWCbixh0/3FwcUbZULJg/ycubaLfE+tWsA7v5NniiGbVJH/qFXh5ntnB
 Lp1LD/c4QahDER9VLBy0KJwhKYIAP/YIlHzLEmuqYv7eoQ131/VlAOFRgeOfXBZ+
 B/uKEAfNkgIMwgH4l7SnjhcgPwMxrP5iMwwGvKb7YLuL9CIyNCwiOtvIG/ZudQPp
 tbCoMfM9RZnPXt52KFfAyw2Zi3T8w==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq63gr7f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Aug 2025 21:37:08 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 575Lb8wx019814;
 Tue, 5 Aug 2025 21:37:08 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq63gr7e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Aug 2025 21:37:08 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 575I4MqJ022668;
 Tue, 5 Aug 2025 21:37:07 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48bpwq8qvc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Aug 2025 21:37:07 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 575Lb7pv28508680
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 5 Aug 2025 21:37:07 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0F0765805A;
 Tue,  5 Aug 2025 21:37:07 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AB0015803F;
 Tue,  5 Aug 2025 21:37:06 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  5 Aug 2025 21:37:06 +0000 (GMT)
From: Glenn Miles <milesg@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>, npiggin@gmail.com, clg@redhat.com
Subject: [PATCH] MAINTAINERS: Add myself as reviewer for PowerNV and XIVE
Date: Tue,  5 Aug 2025 16:36:31 -0500
Message-ID: <20250805213646.3285026-1-milesg@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDE1MSBTYWx0ZWRfX3ZWNdX9uJY3t
 +C7agTFgMKOxgk4e+b1t8vDhasdyuQKyEVkvatXzNfX87Q2+oysGD0BFcounL2fX6pJnhLUlG77
 uIoXvNmjiub5c2q3WASUo8PWVrCFurX8zVFABvn6oWMEXawrCnzmrdMLevapY6Q9OEsW4SHNgYS
 d+sXijGL6b3pSv3pn8ucnRra9bD03szdLjsSSHdUHmLc0IjO0TpjNt0rTcYV1DFoquHk3KFjADz
 jRyf5sfF8+nDvOcMo3Fe5TzmkLazHD8EpAUSmznkVVLyT+OAHzn/u9BqW8cDokbjQe8mUCe0ZBI
 XpUroGYZSyF2u0E8NmsbBwd6ZU6khcawZayHdARxQxtDMWQOeHaou+bp9TOsmYyD9jijI/2gFid
 WHx+Ln3oheC5WsSDlKdDAl4cVQa6XkzXfUQDgI6GiUuEyIskOgM2IlJWhv0nc/5YEOfeSE/k
X-Proofpoint-ORIG-GUID: 7wGQK8Eu7jOQD99scIvQgHnv7GnKqtsw
X-Authority-Analysis: v=2.4 cv=LreSymdc c=1 sm=1 tr=0 ts=68927984 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=2OwXVqhp2XgA:10 a=NEAV23lmAAAA:8 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=69wJf7TsAAAA:8 a=hdCJvu6vi-O6ykQZt0QA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: YAKhwv4jk-fIKRvNCrY7ftor64XyQi70
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_04,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 mlxlogscore=898 bulkscore=0
 malwarescore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508050151
Received-SPF: pass client-ip=148.163.158.5; envelope-from=milesg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Adding myself as reviewer for PowerNV and XIVE areas.

Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a07086ed76..f1ab7b893d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1576,6 +1576,7 @@ F: tests/functional/test_ppc64_tuxrun.py
 PowerNV (Non-Virtualized)
 M: Nicholas Piggin <npiggin@gmail.com>
 R: Aditya Gupta <adityag@linux.ibm.com>
+R: Glenn Miles <milesg@linux.ibm.com>
 L: qemu-ppc@nongnu.org
 S: Odd Fixes
 F: docs/system/ppc/powernv.rst
@@ -2779,6 +2780,7 @@ T: git https://github.com/philmd/qemu.git fw_cfg-next
 
 XIVE
 R: Gautam Menghani <gautam@linux.ibm.com>
+R: Glenn Miles <milesg@linux.ibm.com>
 L: qemu-ppc@nongnu.org
 S: Odd Fixes
 F: hw/*/*xive*
-- 
2.43.5


