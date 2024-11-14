Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E04CD68B33
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 16:21:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBcZu-0000mE-70; Thu, 14 Nov 2024 11:20:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1tBcZp-0000lv-Sb; Thu, 14 Nov 2024 11:20:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1tBcZm-0000Un-LA; Thu, 14 Nov 2024 11:20:12 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEEAY0e016593;
 Thu, 14 Nov 2024 16:20:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=Tk07lILItncrr6sZhJb856zOgOqXmG/lu3ZysekfA
 q4=; b=RaCgk8uYUbdtKDGkMJReiFPqwIs3cBrA4ggs0XYbeoOFPhKQFQDC0cZae
 lGf8new8vLQHcZzP3BjpYfQ7n1KPN7XsEd1BYo8ZuNri2SEr0yG/VXNB9op631vS
 LmI/tAnX1PeW8JycGEoJ7DSV7eSj8lupIi/6qu8uf/Qh/jUX8xYEHcRwZoIJvJf+
 T4LjRgzWTN1I2XYNSC7pr6qhz3jcBEiGQup0ChHj39sTbvEKS6v4xD6xTacL9+qB
 wVlzfIuPUHJRlKurS6xTG6rEoi7BBatZbn9qyPCHYA9ySUX4zy5rAt4ayiXvcrFS
 YTXWY4//T6HeDgCaXAge8EvkYRARA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42wjqrgk64-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 Nov 2024 16:20:07 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AE9wf9a017511;
 Thu, 14 Nov 2024 16:20:07 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42tk2n0mm7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 Nov 2024 16:20:07 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4AEGK6wp15991544
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Nov 2024 16:20:06 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EF3525804E;
 Thu, 14 Nov 2024 16:20:05 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4D19F58056;
 Thu, 14 Nov 2024 16:20:05 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.167.191])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 14 Nov 2024 16:20:05 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com
Cc: frankja@linux.ibm.com, jrossi@linux.ibm.com
Subject: [PATCH] pc-bios/s390x: Initialize machine loadparm before probing IPL
 devices
Date: Thu, 14 Nov 2024 11:19:52 -0500
Message-ID: <20241114161952.3508554-1-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: e8YLnXSEAPM2v1epFMoMF_PsBIaO-UCB
X-Proofpoint-GUID: e8YLnXSEAPM2v1epFMoMF_PsBIaO-UCB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=715 suspectscore=0 mlxscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411140125
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Jared Rossi <jrossi@linux.ibm.com>

Commit bb185de423 ("s390x: Add individual loadparm assignment to
CCW device") allowed boot devices to be assigned a loadparm value independent
of the machine value, however, when no boot devices are defined, the machine
loadparm becomes ignored. Therefore, let's check the machine loadparm
prior to probing the devices.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 pc-bios/s390-ccw/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index a4d1c05aac..a6cc6d7906 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -191,7 +191,7 @@ static void boot_setup(void)
 {
     char lpmsg[] = "LOADPARM=[________]\n";
 
-    if (memcmp(iplb.loadparm, NO_LOADPARM, LOADPARM_LEN) != 0) {
+    if (have_iplb && memcmp(iplb.loadparm, NO_LOADPARM, LOADPARM_LEN) != 0) {
         ebcdic_to_ascii((char *) iplb.loadparm, loadparm_str, LOADPARM_LEN);
     } else {
         sclp_get_loadparm_ascii(loadparm_str);
@@ -315,6 +315,7 @@ void main(void)
     css_setup();
     have_iplb = store_iplb(&iplb);
     if (!have_iplb) {
+        boot_setup();
         probe_boot_device();
     }
 
-- 
2.45.1


