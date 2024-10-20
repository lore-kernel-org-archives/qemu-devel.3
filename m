Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76A31D3C931
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2024 01:30:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2Klj-0008IO-7S; Sat, 19 Oct 2024 21:30:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1t2Klh-0008HB-DU; Sat, 19 Oct 2024 21:30:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1t2Klf-0005AX-N9; Sat, 19 Oct 2024 21:30:05 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49K1H9RX018197;
 Sun, 20 Oct 2024 01:30:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=TS38svw3GIfh/UCeQ
 Y7JIwa367Mp4DNIwZtu7DSWuAU=; b=CB9f10SEz8KNz0a527/Jsax8j169WqfkB
 N8Q7aE6oIhxKeZth8IrsxM/vT5IXFJvzbsEGNGB3T1R49/ZKuv2Po+CB9P2w8/w1
 rb2e6ZepHid54Pp6UZfB+OihusovSeff5W1nhe4bDGlNiZKQ274CZd2cnTwij5bZ
 NTyYn1bkliEyfmJ5l01R1KDGGkyhrYylbSClUtwnvitQynTaTYNu19a4qlaTK8pz
 M0e/fTBfRbYHBl9L8DRR4dmsB8+cpIZB5KLKwBHEUOZRB4z5b8CwMqiO+yc+XqX6
 SDJsXv9Rnc3c8AjJvlN8PeCQlohfwi6WPiY/MRyPgYACpbVq2YMSA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42c5fcb19b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 20 Oct 2024 01:30:00 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49K1JKqW009293;
 Sun, 20 Oct 2024 01:29:59 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42cr3mg0xk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 20 Oct 2024 01:29:59 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49K1TwWh40043000
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 20 Oct 2024 01:29:58 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 57A625805A;
 Sun, 20 Oct 2024 01:29:58 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A83B458054;
 Sun, 20 Oct 2024 01:29:57 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.54.50])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 20 Oct 2024 01:29:57 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com
Cc: frankja@linux.ibm.com, jrossi@linux.ibm.com
Subject: [PATCH v5 01/19] hw/s390x/ipl: Provide more memory to the
 s390-ccw.img firmware
Date: Sat, 19 Oct 2024 21:29:35 -0400
Message-ID: <20241020012953.1380075-2-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241020012953.1380075-1-jrossi@linux.ibm.com>
References: <20241020012953.1380075-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4z37OupSRKol7IPbPFoftsh6X_FXKIHC
X-Proofpoint-GUID: 4z37OupSRKol7IPbPFoftsh6X_FXKIHC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 bulkscore=0 mlxscore=0 clxscore=1015 mlxlogscore=584 phishscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410200009
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

We are going to link the SLOF libc into the s390-ccw.img, and this
libc needs more memory for providing space for malloc() and friends.
Thus bump the memory size that we reserve for the bios to 3 MiB
instead of only 2 MiB. While we're at it, add a proper check that
there is really enough memory assigned to the machine before blindly
using it.

Co-authored by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 hw/s390x/ipl.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 5ab7433908..5f60977ceb 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -45,6 +45,7 @@
 #define INITRD_PARM_START               0x010408UL
 #define PARMFILE_START                  0x001000UL
 #define ZIPL_IMAGE_START                0x009000UL
+#define BIOS_MAX_SIZE                   0x300000UL
 #define IPL_PSW_MASK                    (PSW_MASK_32 | PSW_MASK_64)
 
 static bool iplb_extended_needed(void *opaque)
@@ -144,7 +145,14 @@ static void s390_ipl_realize(DeviceState *dev, Error **errp)
      * even if an external kernel has been defined.
      */
     if (!ipl->kernel || ipl->enforce_bios) {
-        uint64_t fwbase = (MIN(ms->ram_size, 0x80000000U) - 0x200000) & ~0xffffUL;
+        uint64_t fwbase;
+
+        if (ms->ram_size < BIOS_MAX_SIZE) {
+            error_setg(errp, "not enough RAM to load the BIOS file");
+            return;
+        }
+
+        fwbase = (MIN(ms->ram_size, 0x80000000U) - BIOS_MAX_SIZE) & ~0xffffUL;
 
         bios_filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, ipl->firmware);
         if (bios_filename == NULL) {
-- 
2.45.1


