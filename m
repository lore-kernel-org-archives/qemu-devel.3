Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E28EC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 21:23:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYtnm-0004X1-FZ; Fri, 17 Jan 2025 16:22:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1tYtnj-0004Pg-EB; Fri, 17 Jan 2025 16:22:48 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1tYtnh-0000Zt-QR; Fri, 17 Jan 2025 16:22:47 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50HEkoY1026713;
 Fri, 17 Jan 2025 21:22:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=0MASglXxHIWlYiEr6
 WNNSYzQg10g57WhFF+Wndy8DuM=; b=LKDA1eotnk4exAaPEqAJ5e26ggI3K54F7
 y6B3s1pGTE2YOpNivNtQzf2MZlT8MczY9qEM+Bvm/p/zQFFmvFTWGfk3q9IaIFi+
 GOgtFcwv/JLRf3WLLoL7mCf25a7jGIqXSPKdVSQhh1NXeDNJNV2tAaZbkZRhNIMG
 aDsIVRPlwlAVx8h+H6SB5j9TzPwCFYZyKNiMh4inDI2dZxrcSB1cT/oUhV/X0DB4
 PVxGpr/DCmDsG/rYFKRHTose79wl9xlEPvQtC7L6hTWhehwtHy8cFl0C/OWzSd6B
 rYzOrVEGK23/a+UalASFlSdzL/sJdJauwnu4PiGYTSBXv/rs6US9Q==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 447fpcck5d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Jan 2025 21:22:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50HL4XSt004526;
 Fri, 17 Jan 2025 21:22:41 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4442yt51me-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Jan 2025 21:22:41 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50HLMeRR53281240
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Jan 2025 21:22:40 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ADE7858055;
 Fri, 17 Jan 2025 21:22:40 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 25DAC5804B;
 Fri, 17 Jan 2025 21:22:40 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.83.203])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 17 Jan 2025 21:22:40 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com
Cc: jrossi@linux.ibm.com
Subject: [PATCH 1/1] pc-bios/s390-ccw: Abort IPL on invalid loadparm
Date: Fri, 17 Jan 2025 16:22:35 -0500
Message-ID: <20250117212235.1324063-2-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250117212235.1324063-1-jrossi@linux.ibm.com>
References: <20250117212235.1324063-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pvdbNoNS0wNzlyEquggAYyEs4a2D9i95
X-Proofpoint-GUID: pvdbNoNS0wNzlyEquggAYyEs4a2D9i95
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-17_07,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 impostorscore=0 mlxlogscore=826 spamscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501170163
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1.79, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Because the loadparm specifies an exact kernel the user wants to boot, if the
loadparm is invalid it must represent a misconfiguration of the guest. Thus we
should abort the IPL immediately, without attempting to use other devices, to
avoid booting into an unintended guest image.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 pc-bios/s390-ccw/bootmap.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index 56f2f75640..0f8baa0198 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -336,8 +336,7 @@ static int run_eckd_boot_script(block_number_t bmt_block_nr,
 
     debug_print_int("loadparm", loadparm);
     if (loadparm >= MAX_BOOT_ENTRIES) {
-        puts("loadparm value greater than max number of boot entries allowed");
-        return -EINVAL;
+        panic("loadparm value greater than max number of boot entries allowed");
     }
 
     memset(sec, FREE_SPACE_FILLER, sizeof(sec));
@@ -348,8 +347,8 @@ static int run_eckd_boot_script(block_number_t bmt_block_nr,
 
     block_nr = gen_eckd_block_num(&bmt->entry[loadparm].xeckd, ldipl);
     if (block_nr == NULL_BLOCK_NR) {
-        puts("Cannot find Boot Map Table Entry");
-        return -EIO;
+        printf("The requested boot entry (%d) is invalid\n", loadparm);
+        panic("Invalid loadparm");
     }
 
     memset(sec, FREE_SPACE_FILLER, sizeof(sec));
@@ -792,8 +791,12 @@ static int ipl_scsi(void)
 
     debug_print_int("loadparm", loadparm);
     if (loadparm >= MAX_BOOT_ENTRIES) {
-        puts("loadparm value greater than max number of boot entries allowed");
-        return -EINVAL;
+        panic("loadparm value greater than max number of boot entries allowed");
+    }
+
+    if (!valid_entries[loadparm]) {
+        printf("The requested boot entry (%d) is invalid\n", loadparm);
+        panic("Invalid loadparm");
     }
 
     return zipl_run(&prog_table->entry[loadparm].scsi);
-- 
2.43.5


