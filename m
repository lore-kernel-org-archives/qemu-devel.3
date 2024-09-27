Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE62CEBF60
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 00:54:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stzCn-0002EC-BT; Thu, 26 Sep 2024 20:51:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1stzCl-0002C2-JN; Thu, 26 Sep 2024 20:51:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1stzCj-0007Ee-HB; Thu, 26 Sep 2024 20:51:31 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48QG9Xh4021418;
 Fri, 27 Sep 2024 00:51:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=Zc+UqtXlqTuKR
 1tNaSMpWLawwgcVbIxSBFOpo/f52TU=; b=hNNV4sLJkLV0JoOZPJQzLCohVUdZP
 V9XZB8swMBjYlTsJBBKAY9RGDAQb0YF5qE4VVk0VPq3zCMCUzmCCCdq6qYhclaVu
 l8+jpCOQ0j3sBYArDBfKd4HvAtmlEWOjIlHKtwHdFck9tZPde1Tyxf2QfdUqDpld
 vd9RWo0W3NLdntqMquBp0F15b3/yB+sXC1L0hBSKv5Jv8ouoZx2n7Y3ANGF3Itzs
 OawqC6/hpOWOcl9o0UjL+4WYFopt+n+j/OglGUJCz5I0wJwUrJFfZklV3Zlhqs/n
 J8llFBDD+HeKRDZ3pVnBA6SfSQgD8BHKyk0q531/xphzSURPORe6BJxXw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41skjs16bv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Sep 2024 00:51:25 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48R0pPN1008052;
 Fri, 27 Sep 2024 00:51:25 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41skjs16bt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Sep 2024 00:51:25 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48QNI7P3005862;
 Fri, 27 Sep 2024 00:51:24 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 41tapmsxgy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Sep 2024 00:51:24 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48R0pNT242598780
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Sep 2024 00:51:23 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8719358056;
 Fri, 27 Sep 2024 00:51:23 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1276958052;
 Fri, 27 Sep 2024 00:51:23 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.154.26])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 27 Sep 2024 00:51:22 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com
Cc: frankja@linux.ibm.com, jrossi@linux.ibm.com
Subject: [PATCH 01/18] hw/s390x/ipl: Provide more memory to the s390-ccw.img
 firmware
Date: Thu, 26 Sep 2024 20:51:00 -0400
Message-ID: <20240927005117.1679506-2-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240927005117.1679506-1-jrossi@linux.ibm.com>
References: <20240927005117.1679506-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8aWJQzDRegPG_k0ApsG660IcZvCf_IMB
X-Proofpoint-ORIG-GUID: uHGPOvqMKAGvYnr-WJbB52QRL6zIHuQv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-26_06,2024-09-26_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 priorityscore=1501
 spamscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 clxscore=1015 malwarescore=0 mlxlogscore=566 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409270002
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index dd71689642..c33a044d1d 100644
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


