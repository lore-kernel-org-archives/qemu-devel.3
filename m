Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7267FC5CFC1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 15:23:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wutk0-0006Wl-QF; Fri, 14 Aug 2026 11:22:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1wutjx-0006WB-8O; Fri, 14 Aug 2026 11:22:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1wutjv-0003rj-Ow; Fri, 14 Aug 2026 11:22:37 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67EE5bwG3660287; Fri, 14 Aug 2026 15:22:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=fTTI9zWdwIPPFc+WZvPddR0OnW436AnNkwsEL01PZ
 yM=; b=iNZjVJkkehiLG9Rq4QyKvsUJsh7vXBb+pC9RonYk1bfPbF+klOntYrSI1
 w1KbPU+gzfgPmfvNze0I6XO2qA1XnXQvZOa9Zp+g/67B1M7iqSNr3tfuBK1Z9X8f
 zBZoj/pJ1uKgbX66Te5wWd11NnL7vcaKMHcGg3acpW2ldFJc0CwR3Tt9CEgj90Qi
 DXf7c6a5uqGNZ9rF/g57+E62mg29AWBVmubLSKKqKKIU4NBHkNxUZ9VW2gw8GyUy
 2GP2NtrOQ4XXwVZ6LCcp82mhCbBeYVF8J8UFt7I9rNuM7WeTqCJvw9Ojtop8CkUT
 JPxC78omaCozwtlrDAFjcDeq5MvJA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvk0ddch-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Aug 2026 15:22:33 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67EFBaDI025648;
 Fri, 14 Aug 2026 15:22:32 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsk7stu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Aug 2026 15:22:32 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67EFMUXM22020686
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Aug 2026 15:22:31 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B052E58058;
 Fri, 14 Aug 2026 15:22:30 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6791258059;
 Fri, 14 Aug 2026 15:22:28 +0000 (GMT)
Received: from li-d98989cc-2c66-11b2-a85c-93ab83b7dd53.ehn-de.ibm.com (unknown
 [9.224.77.173]) by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 14 Aug 2026 15:22:28 +0000 (GMT)
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
Subject: [PATCH 1/1] s390x/css: Fix css stsch detection to go beyond 8192
 devices
Date: Fri, 14 Aug 2026 17:22:26 +0200
Message-ID: <20260814152226.1834819-1-borntraeger@de.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDExNCBTYWx0ZWRfX5AGvew2VWhbm
 os8TrkpYEh/dgAm8ecIZN3OQpAYi+OhkJPYYvvwDL+qnOAx1kTnJIiF8r2cnj5Vx9vmtCUb0Uiq
 RW5hakwkwYomBFuoJuoaQDSC+uuMHU/Wm6aeKp1/xcKed9ZgSgSZanJejn11kbH4HhXLYzdnfNf
 ArKEAJVa/DlE+YOprXaHUGJqJSWDHvvp4UBGp+eLPyfXD63JOcOuwhh8mDZveq0Y5LF7qsZNBOJ
 Lh31xfrEXtAH/43eB5XOuVx9q5rWNoiB3slw0AuMm6DyOzWY2CYY+JUz3gVdFguWMAVMCST0MPT
 KKL6sBrCYcUrDBSGflQPBtfY97fCUcXi0QMnqbcMD//fPHlwFuk1Jjn72Aw44eZYrKL/X4NrNhB
 sxf091pU74bCUqgV0P8DRd8XWUFi93KFGpWiAY0VkWzqplYWqHNhdm0iPUE4Q0jiHijVRe7KBXF
 c1e2E6QSdpm+nzmX/cA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDExNCBTYWx0ZWRfXx48aGO+6a4zm
 yISYyjF36oe9NjIeROey4g9VCxOI7afn42MhuI7zTMsk2hg6coAwhqe4mFX+KeS7kCGon306W5z
 RVOoRFc4T6FE53xrFWHdBu2P6fWDQic=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7f32b9 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=WHrucGKVQccoiEeWISEA:9
X-Proofpoint-GUID: 1cAyseq8U9vZ-B1eb9jpvlGtgFOWYVcV
X-Proofpoint-ORIG-GUID: 1cAyseq8U9vZ-B1eb9jpvlGtgFOWYVcV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608140114
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

find_last_bit expects a size in bits and not in words. the calculation
limits the number of guest devices to 8192.  This probably does not
matter in reality, its wrong anyway.

Fixes: df1fe5bb49241 ("s390: Virtual channel subsystem support")
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 hw/s390x/css.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 3a67b670531..76dbca3bb96 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -2023,8 +2023,7 @@ bool css_schid_final(int m, uint8_t cssid, uint8_t ssid, uint16_t schid)
         return true;
     }
     set = channel_subsys.css[real_cssid]->sch_set[ssid];
-    return schid > find_last_bit(set->schids_used,
-                                 (MAX_SCHID + 1) / sizeof(unsigned long));
+    return schid > find_last_bit(set->schids_used, (MAX_SCHID + 1));
 }
 
 unsigned int css_find_free_chpid(uint8_t cssid)
-- 
2.55.0


