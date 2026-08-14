Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F66C5CFDB
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 13:00:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wurVE-0005Aq-Nw; Fri, 14 Aug 2026 08:59:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1wurVC-0005AJ-19; Fri, 14 Aug 2026 08:59:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1wurV8-0005T7-MG; Fri, 14 Aug 2026 08:59:13 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67EB1bZJ903560; Fri, 14 Aug 2026 12:59:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=/500p+CqkBphHrT0nsH8X9TjBuMOm+s2uXVTdRDP+
 EU=; b=k5Kd/0fT6bFfOjqnDly8ZCRweNXTLegqbiLwtMX3T8+4Bp4nA3F9Pr9hC
 HezyQa/6YeA27QifrhwxQIlEB/ZTV5t/5uQT62BrR7MXVFvi1P6tz77FgutMG7HI
 4Ny+kuSoCSi11JYS8bcJzrLUPbbs+fErWGmXHMNgFb1cwFc0vnZsOyHYvY+Df0SG
 CQItIPTtLeEs0p+4X90x1gQMHu0vCkbZbJbo/ZknbNOpVldxDPz2QjAFj4fQnx5s
 do+eCQ1Na6pdjpuV6Kgqu3GIa2CBk8h4WA7Z8dMQQWxqzxP7zkNpUI1SpARPM+st
 05OB1hMj/Ja6oS264JWAPK2DGyLnA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9vt90-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Aug 2026 12:59:04 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67ECuJkt028798;
 Fri, 14 Aug 2026 12:59:03 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsk7am5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Aug 2026 12:59:03 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67ECwNqm10748446
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Aug 2026 12:58:24 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3ED7758060;
 Fri, 14 Aug 2026 12:59:02 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4B0D75803F;
 Fri, 14 Aug 2026 12:59:00 +0000 (GMT)
Received: from li-d98989cc-2c66-11b2-a85c-93ab83b7dd53.ehn-de.ibm.com (unknown
 [9.224.77.173]) by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 14 Aug 2026 12:59:00 +0000 (GMT)
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Janosch Frank <frankja@linux.vnet.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH] s390x/sclp: pv: only copy the original SCCB buffer
Date: Fri, 14 Aug 2026 14:58:57 +0200
Message-ID: <20260814125857.1729543-1-borntraeger@de.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gUNc4vcnfS0j5QCyHcjjFHKtqW93gRJG
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7f1118 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=wqyRmatkV8wIHynnhxEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA5NSBTYWx0ZWRfXz5AOOsB05w+r
 og1YMsBza5S0lkwQOwaOi8av4f2NKF+MwD3jm27HRmwUINkMnlcwQcv61+/mGmfjdz5Q87pp9O3
 Nb9B49LnZdpmnOhp2UlNSzYBDZ0/RJIGwey6BL1scMRXjafea/fGZp+JDILR1Ndgv5lrRxJtz5X
 roV96I7fjUl/xH4y8jaofckxBJlc1AuY+KM64060CSYwmrFnwZEZcUTU4u1HoHZC4So8uMpwlIL
 7YWgSS10/ABG2EdxpNJFGZmrnAiih0CKMkcLe3v8Z+KitYyfHGfw3XyzP6ZD3RJ1yNNZShBr/Oe
 ZsloqwiMtChTN4BWz2QKcQAamlv3s4G3ti9trsLtbOEMClS8hDky89IdK9Rqo7FfghXmBUHf4YS
 sDqw4/UeCXPXb7ltW9d+0asxxEl1jJwopHsrbFR3pFnHc/G4EbteeokfQAe07SIMoEW9WooA0vU
 AIsPXNb1ed8LW+u+XVA==
X-Proofpoint-ORIG-GUID: gUNc4vcnfS0j5QCyHcjjFHKtqW93gRJG
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA5NSBTYWx0ZWRfX2/YJj1/IEB/y
 O4HCrinSeMoEVirbf4peJTquvi+NPdoCncBP77sJD5pTj/TWyBHZ1hulk5Q/OlPgEaK+qcrMBzp
 G7JzdVEJjWjDEwsQ37/S98i7VGKim7s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1011 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608140095
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

From: Christian Borntraeger <borntraeger@linux.ibm.com>

With variable length and EXTENDED_LENGTH_SCCB, some callbacks might
change the length field. For example read SCP info might write a new
length into the SCCB header. We must not use that new length for the
buffer copy, since the buffer was allocated with the original length.
Only the length field in the work SCCB is changed, to indicate the
"necessary" size. Using the new length reads past the allocation, so
tools like ASAN might detect a buffer overrun.

Secure guests do not have EXTENDED_LENGTH_SCCB, and the ultravisor checks
and sanitizes the length field, so no qemu heap contents are exposed to
the guest and the non pv-path already has the same header.length.

Fixes: 0f73c5b30b8b ("s390x: protvirt: SCLP interpretation")
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 hw/s390x/sclp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index 3c8cb164888..b452f2ce54d 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -287,7 +287,7 @@ int sclp_service_call_protected(S390CPU *cpu, uint64_t sccb, uint32_t code)
     sclp_c->execute(sclp, work_sccb, code);
 out_write:
     s390_cpu_pv_mem_write(env_archcpu(env), 0, work_sccb,
-                          be16_to_cpu(work_sccb->h.length));
+                          be16_to_cpu(header.length));
     sclp_c->service_interrupt(sclp, SCLP_PV_DUMMY_ADDR);
     return 0;
 }
-- 
2.55.0


