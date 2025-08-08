Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA16FC87FD2
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 12:02:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukLmF-0008AP-Cr; Fri, 08 Aug 2025 08:00:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1ukLlf-0005PG-VN; Fri, 08 Aug 2025 08:00:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1ukLle-0006vr-8F; Fri, 08 Aug 2025 08:00:15 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5783E5FB021001;
 Fri, 8 Aug 2025 12:00:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Xru3IO
 IOQa2JaHXuK3906K/qVFnhk0lup/RuWDRwA1o=; b=S9S8zmJ+oqgb2bI7VuzLQR
 9QrkBq74XcYeOf4I+ltJZ0PjASdghRAcfs0xCFwoX8LbWTt9fNpe4wN+Nikjyqqo
 /1B6Ur/ulpBf5ADICgn+NqwTck2pIx0kgrhGlq+YbsxNXMAitjQJrJpDqHBxxy1I
 MihmARadP5xHHUIdi7mJjBZnxZ/RHoALksBvAgN/c4TxwK0GTwrabJjtlSBdZMPO
 b+RjrHiqrVbOakMUmPaKzFTCdqaaQlHMzMRaYdAy7L9XoIkoUUwx+xeZZb68ibgr
 Vjn2OKBR++Ahv/+JNfHDJmA8qhr0FmkdGbP3FMt2Q9KRlHy3VApTd4Nl0ycVqoEw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq63fufa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Aug 2025 12:00:11 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 578C0AA6025580;
 Fri, 8 Aug 2025 12:00:10 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq63fuf8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Aug 2025 12:00:10 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 578B0IET031314;
 Fri, 8 Aug 2025 12:00:10 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48bpwnng9f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Aug 2025 12:00:09 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 578C06HV30802584
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 Aug 2025 12:00:06 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0563020043;
 Fri,  8 Aug 2025 12:00:06 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A907820040;
 Fri,  8 Aug 2025 12:00:02 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com.com (unknown
 [9.124.216.151])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  8 Aug 2025 12:00:02 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Subject: [PATCH v9 7/7] tests/powernv: Add PowerNV test for Power11
Date: Fri,  8 Aug 2025 17:29:29 +0530
Message-ID: <20250808115929.1073910-8-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250808115929.1073910-1-adityag@linux.ibm.com>
References: <20250808115929.1073910-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=NInV+16g c=1 sm=1 tr=0 ts=6895e6cb cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=aow-egSQAAAA:8 a=VnNF1IyMAAAA:8
 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=M_iqQ_o7Tyesht7ruFAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-GUID: JUpfRtSRRRXsPEKHRU7leh_WNNqvA2gv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDA5NiBTYWx0ZWRfX1IZXBjimJN9C
 +7o3hG0HJ8rsiZaGTzvbz7k6BXW1lf2gCweePyfh6mdDy6A2a8Mzh3dqq8E8fPz+/reOtGbymyi
 nbEYCahI1nAPavzYVGDFVgxnSs2Mb5u4a5Q5gviPNEMVU321EpWqII0kVus9CkYsucdQwoS1jIU
 cdih1jrYGXViSdjxFl8/muWw/qb0+e3w1F48VQrZCtb7li2zPuQXNWH/FV46FK9oZ8NtDe9ErcG
 Ir9dMqPlcfJWhskjFdUSttZwuGl06X6fGze4J6NAO7J82VUgzz6rS6lWcwySqBggvghVgMqBqmg
 ofUK7XitN6K/kZlQjCChCRyzUT8HHvvP/kqLvOYP68XxQoniws/T4eZqnSUTC7VcNaMhAojEEuN
 1Lbg8+9zsbj4SxHrN/n8MM0kztRGXlHayc+S0rsbiLml+EOo1CP8cRR/MFSnaAPNBr7R40kO
X-Proofpoint-ORIG-GUID: YYrFYMk7NjiA-hJnQh0b1RGy9HhJc6r6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_03,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 impostorscore=0 mlxlogscore=870
 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508080096
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
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

With all Power11 support in place, add Power11 PowerNV test.

Cc: Cédric Le Goater <clg@kaod.org>
Cc: Frédéric Barrat <fbarrat@linux.ibm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 tests/functional/test_ppc64_powernv.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/functional/test_ppc64_powernv.py b/tests/functional/test_ppc64_powernv.py
index 2b4db1cf99b4..9ada832b7816 100755
--- a/tests/functional/test_ppc64_powernv.py
+++ b/tests/functional/test_ppc64_powernv.py
@@ -116,5 +116,9 @@ def test_powernv10(self):
         self.set_machine('powernv10')
         self.do_test_ppc64_powernv('P10')
 
+    def test_powernv11(self):
+        self.set_machine('powernv11')
+        self.do_test_ppc64_powernv('Power11')
+
 if __name__ == '__main__':
     LinuxKernelTest.main()
-- 
2.50.1


