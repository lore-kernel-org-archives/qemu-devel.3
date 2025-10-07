Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 226D7CCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 12:59:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v67Fx-0004M6-DL; Tue, 07 Oct 2025 08:57:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1v63kd-000612-OL; Tue, 07 Oct 2025 05:12:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1v63kb-0007pU-Hd; Tue, 07 Oct 2025 05:12:55 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5978JsGc022980;
 Tue, 7 Oct 2025 09:12:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=CmklnRSGrSW3rgBlejfIWpgbOBYTBFkJjF/Zay4eV
 jQ=; b=RZSFv1DoNGJFvjueUxTWo4lQ6JMHZnog8qw4yRjER4MaElJ6EG9ghsXRn
 9PtNyXrec68vJaUiYvcYMG/M6Al0/BI3Mkox/av44mUeOVW3cw8ZL5aRv/yoCtpR
 uyB7SU8IeundkQLkdNR2bVeZZvD1pEAMs+oVwvb+hJcO8u406wOnAGNaxltsprrT
 QrI+vfhtyuPlKUMFHzZVjpwQPN0BGytlMYzmXDv16vfCiOKn8xjci8aYamVQtvUf
 YfX6glfhKoxgCIikuSFp7YY3Nc6vNe0zju1x3ih5uonqZCG4z31dq0ox20gOXLIb
 dotUUti3Q8wgxSBFQTbWvS6y34tbA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49ju3gx90h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Oct 2025 09:12:49 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5979Cjbr000893;
 Tue, 7 Oct 2025 09:12:49 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49ju3gx90e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Oct 2025 09:12:49 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5975hrUo028443;
 Tue, 7 Oct 2025 09:12:48 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49kewn2fk0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Oct 2025 09:12:47 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5979CijR58720658
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Oct 2025 09:12:44 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 08A422004B;
 Tue,  7 Oct 2025 09:12:44 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7B85820043;
 Tue,  7 Oct 2025 09:12:42 +0000 (GMT)
Received: from vishalc-ibm.ibm.com (unknown [9.39.19.130])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  7 Oct 2025 09:12:42 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: npiggin@gmail.com, adityag@linux.ibm.com, milesg@linux.ibm.com,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: Vishal Chourasia <vishalc@linux.ibm.com>
Subject: [PATCH] hw/ppc/pnv: Improve kernel/initrd load failure error messages
Date: Tue,  7 Oct 2025 14:42:15 +0530
Message-ID: <20251007091214.403430-2-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAxOCBTYWx0ZWRfX+7oQIj/h66Fm
 kPjY0pzCc3kuuB/BZu5HQKjTJ009J4+Y+FYUAfyg/YFQliS8//XmXys0WxuMf4qh/0vT5X3ULED
 Pj6hJgYc0DuA2SNcdIxQG5FMflqYn1c+8myz+AIa0oTtwoXmIgW3/a+mMeSTzd7aMtrUBXrOR31
 CogFI9rbnzJFQbt4GbeJ78eOHtzW9OAkvAbbG8WzkbQIgHIRAEnldUl57kC/3COWQpkQfNROfTj
 C0xKOgFkGATQo3Fvr7l7HSH57CFmmw+afyjMVmPIqi8jhUie/yMLygSQ/tL5RSYeCXaNdVPc4gd
 pURUTzGagAZmZOID5OOHzotIF20eb+HJyaUOY2ZGv/fD58lc+cGrM7eKl40faDjC9DIrKsr1GY3
 VJpvmIo9gWaa8e0KHnaS+9PEBKdd9A==
X-Authority-Analysis: v=2.4 cv=I4dohdgg c=1 sm=1 tr=0 ts=68e4d991 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=x6icFKpwvdMA:10 a=VnNF1IyMAAAA:8 a=xOXCjFplVI8foJ9e8lsA:9
X-Proofpoint-GUID: x9gxwmHsDYIBASOTquFEFz72KA19gcbr
X-Proofpoint-ORIG-GUID: XeGaJVXY9hcx-yeJagLrTWXjZwU8w9bF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_07,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 clxscore=1011 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040018
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
X-Mailman-Approved-At: Tue, 07 Oct 2025 08:57:25 -0400
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

When QEMU fails to load the kernel or initrd image, it previously emitted
a generic error message such as:

  qemu-system-ppc64: Could not load kernel 'vmlinux'

This provides little context on why the failure occurred, which can make
debugging difficult, especially for new users or when dealing with large
images.

The new messages also include the configured size limits (in MiB) to help
users verify that their image files are within acceptable bounds.

Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
---
 hw/ppc/pnv.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index f0469cdb8b..dbecb721c1 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1084,6 +1084,10 @@ static void pnv_init(MachineState *machine)
         if (kernel_size < 0) {
             error_report("Could not load kernel '%s'",
                          machine->kernel_filename);
+            error_report(
+                "Possible reasons: file not found, permission denied, or size "
+                "exceeds the maximum supported limit (%ld MiB).",
+                KERNEL_MAX_SIZE / 1024 / 1024);
             exit(1);
         }
     }
@@ -1096,6 +1100,10 @@ static void pnv_init(MachineState *machine)
         if (pnv->initrd_size < 0) {
             error_report("Could not load initial ram disk '%s'",
                          machine->initrd_filename);
+            error_report(
+                "Possible reasons: file not found, permission denied, or size "
+                "exceeds the maximum supported limit (%ld MiB).",
+                INITRD_MAX_SIZE / 1024 / 1024);
             exit(1);
         }
     }
-- 
2.51.0


