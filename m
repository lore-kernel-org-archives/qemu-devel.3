Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A6CBCCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 17:37:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9RuT-0005EN-PR; Thu, 16 Oct 2025 13:37:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1v9RuQ-0005E4-Uc; Thu, 16 Oct 2025 13:37:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1v9RuF-0007Pf-GZ; Thu, 16 Oct 2025 13:37:01 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GHHW0s001385;
 Thu, 16 Oct 2025 17:36:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=5/nEOG
 X2QHUVIeuE2goW1551E3hiYjficSQm8g+cY5Q=; b=NWXKyKVWYuu3R2k1ZHgypC
 sOssXqvfheiD8nYk5vFNutoLTwuYY+wLdQj6HPQl3t/ueNktLK2pSSARQ/Pu8KHT
 3AIKk7JdatfJ7l8BpM2AbL6vX/HfPvL+7lK2rziymo2Xj1ccAeHriWOZ2ddtqghG
 9d28/dBmyD1MDHj9a+Q4U16EqhWN4mIdS0VRAAD6aQBL4qMoSK8iQ01sWv1sc4Os
 H4pkQw+EGkECw1HRixqMND6qOTQgCwkGoJBDnDACXy1GFMUtrBftZ86V9j7g6DDo
 rpgaOdtKrEfaCcHCANP5rbfK1r02UkERvv9ZP8puYJDhhT9lFb1hjY+l4Mye2NHg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49rfp875me-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Oct 2025 17:36:47 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59GHalTG007412;
 Thu, 16 Oct 2025 17:36:47 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49rfp875md-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Oct 2025 17:36:47 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59GG54hV015259;
 Thu, 16 Oct 2025 17:36:46 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49r1jsf96y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Oct 2025 17:36:46 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59GHag8628311894
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Oct 2025 17:36:42 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 782CF200DD;
 Thu, 16 Oct 2025 17:36:42 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 072B2200DA;
 Thu, 16 Oct 2025 17:36:40 +0000 (GMT)
Received: from vishalc-ibm.ibm.com (unknown [9.39.26.252])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 Oct 2025 17:36:39 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: adityag@linux.ibm.com, harshpb@linux.ibm.com, milesg@linux.ibm.com,
 npiggin@gmail.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, berrange@redhat.com
Cc: Vishal Chourasia <vishalc@linux.ibm.com>
Subject: [PATCH 2/5] hw/core/loader: Use qemu_open() instead of open() in
 get_image_size()
Date: Thu, 16 Oct 2025 23:04:59 +0530
Message-ID: <20251016173502.1261674-4-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016173502.1261674-1-vishalc@linux.ibm.com>
References: <20251016173502.1261674-1-vishalc@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hcjiEhKtaqlFj8VLmKNJgHW1dVra9jWE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEyMDA4NCBTYWx0ZWRfX1TC3amouQS3p
 WtHhtV4i92VW3jRCFv5Y9F2vM2OrbLjmVXHzzLFgJ2ABYYgFBoHhb8AEr8N6tt59b/7aePTIaUE
 0qp/9KC+ZDzZd515SSD7V1ZJgU786vtPxPquiwImCZT4v5f2acMcWk6Jwfntwaczs5i0O0s3QGY
 SjLe5yQbmqvSJ1U97P0GsWnLXTpRXq2FhkodX0Q4AMwjRkghqT/C/amu6aujjaYksyjc56dnZe0
 2fuLIPw9F4TLaXBrd/+c6b9jGsdcVsac5UsgSYx62ztcTOUJs3h6zXJtPL9/DKrKxmh1TGy1N+3
 9jbuAbBsgOssnUnyf5oRWCs3N4ddDgHG16i+amJ/oTd57ec4Fhvga0U8Co1BsHlEobQbi0Mlgtt
 xU/7wxFtZs7Jvy75Xwe2ngOBYYwhxA==
X-Proofpoint-GUID: 4p0yFMskOOV_ckJ39IaF1dPi-JeuJSK2
X-Authority-Analysis: v=2.4 cv=af5sXBot c=1 sm=1 tr=0 ts=68f12d2f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=FjqQsbWZ5CoJ3T9912IA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510120084
Received-SPF: pass client-ip=148.163.156.1; envelope-from=vishalc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Replace open() with qemu_open() which provides better error handling
via the Error object, automatically sets O_CLOEXEC, and supports FD
passing with /dev/fdset.

Remove redundant error_setg_file_open() call since qemu_open() now
handles error reporting internally.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
---
 hw/core/loader.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index 63bb0578b1..31d6cbf493 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -77,9 +77,8 @@ int64_t get_image_size(const char *filename, Error **errp)
 {
     int fd;
     int64_t size;
-    fd = open(filename, O_RDONLY | O_BINARY);
+    fd = qemu_open(filename, O_RDONLY | O_BINARY, errp);
     if (fd < 0) {
-        error_setg_file_open(errp, errno, filename);
         return -1;
     }
     size = lseek(fd, 0, SEEK_END);
-- 
2.51.0


