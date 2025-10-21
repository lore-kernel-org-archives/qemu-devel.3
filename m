Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00642CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 10:57:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBA2k-00063j-6R; Tue, 21 Oct 2025 06:56:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1vBA2H-0005go-MX; Tue, 21 Oct 2025 06:56:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1vBA2F-0001YR-6W; Tue, 21 Oct 2025 06:56:13 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59L8m0F2005743;
 Tue, 21 Oct 2025 10:56:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=FO1mcICwLiIn/LNi1
 WBqGKKba0QseRn08I3lIz2M2SE=; b=a0vQtHMpgB6WT9xXu+n1M/Tb0rWTtJAum
 oSEYW1PtSG6wYyyNePYO/5ZwNQ99aGDQe/mhkQ6S389JFbsudRYp5C4HRHlWZSOB
 lyZ8gJCON0/7eUVbRcU03G6QaJmNbr4KmBxLCJZ1/XWxhbQ8xUONDSusFapSfv1d
 NkJSpqxOErCXiTORhMIsaUtFiYstTqT1HI59QGlw/CTmS07SobBhkBnN4pt57fRe
 IhYtVm17qAxD7yEObBiSpJciwDdn/iP4orDLXdhbnQO9ARPn3W2lySGEWwBks0gI
 vpuVqMAC5HWj2K+5217+bEaXI+w5oIGIKEz6zc4Qpfv15ZQPCg43A==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31rxj8e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Oct 2025 10:56:04 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59LAhe94023457;
 Tue, 21 Oct 2025 10:56:04 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31rxj89-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Oct 2025 10:56:04 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59L81fsG032099;
 Tue, 21 Oct 2025 10:56:03 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vp7mt9mk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Oct 2025 10:56:03 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59LAtxj650725298
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Oct 2025 10:55:59 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 21D5F20043;
 Tue, 21 Oct 2025 10:55:59 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 41D012004B;
 Tue, 21 Oct 2025 10:55:56 +0000 (GMT)
Received: from vishalc-ibm.ibm.com (unknown [9.39.24.196])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 21 Oct 2025 10:55:56 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: adityag@linux.ibm.com, harshpb@linux.ibm.com, milesg@linux.ibm.com,
 npiggin@gmail.com, peter.maydell@linaro.org, alistair23@gmail.com,
 balaton@eik.bme.hu, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 berrange@redhat.com
Cc: Vishal Chourasia <vishalc@linux.ibm.com>
Subject: [Patch v5 3/6] hw/core/loader: add check for zero size in
 load_image_targphys_as
Date: Tue, 21 Oct 2025 16:24:42 +0530
Message-ID: <20251021105442.1474602-7-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021105442.1474602-2-vishalc@linux.ibm.com>
References: <20251021105442.1474602-2-vishalc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lGM34rt_6froou_mL19YpQ2b960sgBF0
X-Proofpoint-GUID: m_Ojn-USPqA8QCOwLFSJuWF2NoS1RZAB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX/4bzQJJh43wY
 SlStUyVficisa7ABQtzc+BjRZ5eZHMDrETczdsP8tAhHW1rEuOTBoCidkDAo26iP+YyP4S227DY
 hh+I+zH7fDYTnN1RHtk9fpbSGU2vC08PcYn+sa2SSa+g+EMdlx3cGhPhxqecDDm6tiLdy29H8ff
 gsSoYBVlwVqXvGn6oEHNcqGL9X7XoQQs5rQx3M8ya5Ct1ziFh+jAF63CRV3bc69ihvJbcGuBH84
 wH6zaMy7NAXhjpByLwfFOrrytOtS8jQdGab33gH2IM+hXV6CJeNS3ZEO0WoLpBBlDw61TnXuWbK
 pJcTC4izVhqihoSrkmSHMXrMaXheVGZjhkEju9rDNGVvBxjp1dpqM3JCl6UdDxjlqe8ebmEWc7q
 Rwtkq4nX58AuVKCaUEGIY2fXzPwGVQ==
X-Authority-Analysis: v=2.4 cv=IJYPywvG c=1 sm=1 tr=0 ts=68f766c4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=EMG23Z06JWfOmfJaRK0A:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.156.1; envelope-from=vishalc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Currently load_image_targphys_as() returns -1 on file open failure or
when max size is exceeded. Add an explicit check for zero-sized files
to catch this error early, since some callers check for size <= 0.

Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
---
 hw/core/loader.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index de35e40719..e1a30da2ac 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -141,6 +141,11 @@ ssize_t load_image_targphys_as(const char *filename,
         return -1;
     }
 
+    if (size == 0) {
+        error_setg(errp, "empty file");
+        return -1;
+    }
+
     if (size > max_sz) {
         error_setg(errp, "%s exceeds maximum image size (%" PRIu64 " MiB)",
                    filename, max_sz / MiB);
-- 
2.51.0


