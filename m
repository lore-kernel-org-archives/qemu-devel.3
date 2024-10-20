Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8473D3C912
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2024 01:30:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2KmS-0000Di-9C; Sat, 19 Oct 2024 21:30:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1t2Klu-0008Rv-70; Sat, 19 Oct 2024 21:30:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1t2Kls-0005PN-CF; Sat, 19 Oct 2024 21:30:17 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49K1FITP014652;
 Sun, 20 Oct 2024 01:30:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=wwcdyOly606xVnmlf
 CNEkDApGsEe+0KCkcWSXOBeygE=; b=psoBXoUZ3d3PX0e9yrV62OrtzSgtFlMTa
 qjyODvbIabgKKIRIXQggyHLwNJOy6ivp3WB9SqTJ1IHdsw7ZN15waE7H7XK3PoPu
 v54y+yx2ZFuZ44F/5GR9oe9Rx+InSAkW12RNvqFxs7VI/uJ1iAzw+pTT7B2MQ9E/
 mHbBPIFv0IJvjIA4cYU/cvaMIzzsqHxAVA9kA7ne9Ym4ej2XFG4EUfFHKcP0KRz4
 Iw3gq7S6tVVnHFL9fV6FO4+npGuJ/tNxqSb5KVSYFpH+Vv39vwS11KuQeELIs9MU
 hh/iINc/CvPqvM52et4uSGxAzHV4YsMu+IIeUGUnI0aEPO8V2WHCw==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42c5h2u6j6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 20 Oct 2024 01:30:14 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49JNJ3YR005218;
 Sun, 20 Oct 2024 01:30:13 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4285njubym-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 20 Oct 2024 01:30:13 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49K1UCPu14418672
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 20 Oct 2024 01:30:12 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 14D315805C;
 Sun, 20 Oct 2024 01:30:12 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 663B958054;
 Sun, 20 Oct 2024 01:30:11 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.54.50])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 20 Oct 2024 01:30:11 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com
Cc: frankja@linux.ibm.com, jrossi@linux.ibm.com
Subject: [PATCH v5 10/19] pc-bios/s390-ccw: Remove panics from DASD IPL path
Date: Sat, 19 Oct 2024 21:29:44 -0400
Message-ID: <20241020012953.1380075-11-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241020012953.1380075-1-jrossi@linux.ibm.com>
References: <20241020012953.1380075-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7b5Fe84NFPw88mXyNu-BwuDCDxUnkU2B
X-Proofpoint-ORIG-GUID: 7b5Fe84NFPw88mXyNu-BwuDCDxUnkU2B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=764
 adultscore=0 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410200009
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Remove panic-on-error from DASD IPL specific functions so that error recovery
may be possible in the future.

Functions that would previously panic now provide a return code.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/dasd-ipl.h |  2 +-
 pc-bios/s390-ccw/dasd-ipl.c | 66 ++++++++++++++++++++-----------------
 2 files changed, 37 insertions(+), 31 deletions(-)

diff --git a/pc-bios/s390-ccw/dasd-ipl.h b/pc-bios/s390-ccw/dasd-ipl.h
index c394828906..eb1898c84a 100644
--- a/pc-bios/s390-ccw/dasd-ipl.h
+++ b/pc-bios/s390-ccw/dasd-ipl.h
@@ -11,6 +11,6 @@
 #ifndef DASD_IPL_H
 #define DASD_IPL_H
 
-void dasd_ipl(SubChannelId schid, uint16_t cutype);
+int dasd_ipl(SubChannelId schid, uint16_t cutype);
 
 #endif /* DASD_IPL_H */
diff --git a/pc-bios/s390-ccw/dasd-ipl.c b/pc-bios/s390-ccw/dasd-ipl.c
index ae751adec1..babece95ea 100644
--- a/pc-bios/s390-ccw/dasd-ipl.c
+++ b/pc-bios/s390-ccw/dasd-ipl.c
@@ -111,38 +111,29 @@ static void make_readipl(void)
     ccwIplRead->count = 0x18; /* Read 0x18 bytes of data */
 }
 
-static void run_readipl(SubChannelId schid, uint16_t cutype)
+static int run_readipl(SubChannelId schid, uint16_t cutype)
 {
-    if (do_cio(schid, cutype, 0x00, CCW_FMT0)) {
-        panic("dasd-ipl: Failed to run Read IPL channel program\n");
-    }
+    return do_cio(schid, cutype, 0x00, CCW_FMT0);
 }
 
 /*
  * The architecture states that IPL1 data should consist of a psw followed by
  * format-0 READ and TIC CCWs. Let's sanity check.
  */
-static void check_ipl1(void)
+static bool check_ipl1(void)
 {
     Ccw0 *ccwread = (Ccw0 *)0x08;
     Ccw0 *ccwtic = (Ccw0 *)0x10;
 
-    if (ccwread->cmd_code != CCW_CMD_DASD_READ ||
-        ccwtic->cmd_code != CCW_CMD_TIC) {
-        panic("dasd-ipl: IPL1 data invalid. Is this disk really bootable?\n");
-    }
+    return (ccwread->cmd_code == CCW_CMD_DASD_READ &&
+            ccwtic->cmd_code == CCW_CMD_TIC);
 }
 
-static void check_ipl2(uint32_t ipl2_addr)
+static bool check_ipl2(uint32_t ipl2_addr)
 {
     Ccw0 *ccw = u32toptr(ipl2_addr);
 
-    if (ipl2_addr == 0x00) {
-        panic("IPL2 address invalid. Is this disk really bootable?\n");
-    }
-    if (ccw->cmd_code == 0x00) {
-        panic("IPL2 ccw data invalid. Is this disk really bootable?\n");
-    }
+    return (ipl2_addr != 0x00 && ccw->cmd_code != 0x00);
 }
 
 static uint32_t read_ipl2_addr(void)
@@ -188,52 +179,67 @@ static void ipl1_fixup(void)
     ccwSearchTic->cda = ptr2u32(ccwSearchID);
 }
 
-static void run_ipl1(SubChannelId schid, uint16_t cutype)
+static int run_ipl1(SubChannelId schid, uint16_t cutype)
  {
     uint32_t startAddr = 0x08;
 
-    if (do_cio(schid, cutype, startAddr, CCW_FMT0)) {
-        panic("dasd-ipl: Failed to run IPL1 channel program\n");
-    }
+    return do_cio(schid, cutype, startAddr, CCW_FMT0);
 }
 
-static void run_ipl2(SubChannelId schid, uint16_t cutype, uint32_t addr)
+static int run_ipl2(SubChannelId schid, uint16_t cutype, uint32_t addr)
 {
-    if (run_dynamic_ccw_program(schid, cutype, addr)) {
-        panic("dasd-ipl: Failed to run IPL2 channel program\n");
-    }
+    return run_dynamic_ccw_program(schid, cutype, addr);
 }
 
 /*
  * Limitations in vfio-ccw support complicate the IPL process. Details can
  * be found in docs/devel/s390-dasd-ipl.rst
  */
-void dasd_ipl(SubChannelId schid, uint16_t cutype)
+int dasd_ipl(SubChannelId schid, uint16_t cutype)
 {
     PSWLegacy *pswl = (PSWLegacy *) 0x00;
     uint32_t ipl2_addr;
 
     /* Construct Read IPL CCW and run it to read IPL1 from boot disk */
     make_readipl();
-    run_readipl(schid, cutype);
+    if (run_readipl(schid, cutype)) {
+        puts("Failed to run Read IPL channel program");
+        return -EIO;
+    }
+
     ipl2_addr = read_ipl2_addr();
-    check_ipl1();
+
+    if (!check_ipl1()) {
+        puts("IPL1 invalid for DASD-IPL");
+        return -EINVAL;
+    }
 
     /*
      * Fixup IPL1 channel program to account for vfio-ccw limitations, then run
      * it to read IPL2 channel program from boot disk.
      */
     ipl1_fixup();
-    run_ipl1(schid, cutype);
-    check_ipl2(ipl2_addr);
+    if (run_ipl1(schid, cutype)) {
+        puts("Failed to run IPL1 channel program");
+        return -EIO;
+    }
+
+    if (!check_ipl2(ipl2_addr)) {
+        puts("IPL2 invalid for DASD-IPL");
+        return -EINVAL;
+    }
 
     /*
      * Run IPL2 channel program to read operating system code from boot disk
      */
-    run_ipl2(schid, cutype, ipl2_addr);
+    if (run_ipl2(schid, cutype, ipl2_addr)) {
+        puts("Failed to run IPL2 channel program");
+        return -EIO;
+    }
 
     /* Transfer control to the guest operating system */
     pswl->mask |= PSW_MASK_EAMODE;   /* Force z-mode */
     pswl->addr |= PSW_MASK_BAMODE;   /* ...          */
     jump_to_low_kernel();
+    return -1;
 }
-- 
2.45.1


