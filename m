Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A197CED24D
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 01:17:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxypr-00048a-3j; Mon, 07 Oct 2024 21:16:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1sxypl-000479-4C; Mon, 07 Oct 2024 21:16:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1sxypj-0008J0-BK; Mon, 07 Oct 2024 21:16:16 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4980pPTU013662;
 Tue, 8 Oct 2024 01:16:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=ZUUdu/c2klu/l
 gghMRDTGUq2UzLhPEPmvXFgnl1ycQA=; b=sxOoWR/1cWo08kvY+qTwql6sgYDoc
 osMbrQcIDLidWLPBNERapOC6qKO4TN0PSQVc8WkAUrWK22QD4BAKF8jQ4q+pLnp6
 oSE3cndKosa7MXpbl7Udm0Ao7pKEGrKrVFOP2INnByrUk8ta/7uv6jnwXthOnbH2
 AjNyvn42j1Iptt3wpzMoSU1jOcbnvG3izByHwbuYrogrqgkJIQa+N0RjxW3qd/sK
 EXNAsHX/e9FhV3pALYIrtFJaBKs/myeEA4ZOxUxNzBRvsguY7jgDONS1xzSGWhlu
 jjC/f2cheA5B2oboky5VJgqzDza9xIERvM5HGzLca3Sz/cJL8ifNPSoyw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 424thqr2wk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Oct 2024 01:16:13 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4981GDeS030761;
 Tue, 8 Oct 2024 01:16:13 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 424thqr2we-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Oct 2024 01:16:12 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 497KjDHj011524;
 Tue, 8 Oct 2024 01:16:11 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 423g5xhpvb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Oct 2024 01:16:11 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4981GAqx33947910
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 8 Oct 2024 01:16:10 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A44E158059;
 Tue,  8 Oct 2024 01:16:10 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 304D258043;
 Tue,  8 Oct 2024 01:16:10 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.51.58])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  8 Oct 2024 01:16:10 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com
Cc: frankja@linux.ibm.com, jrossi@linux.ibm.com
Subject: [PATCH v3 10/19] pc-bios/s390-ccw: Remove panics from DASD IPL path
Date: Mon,  7 Oct 2024 21:15:43 -0400
Message-ID: <20241008011552.2645520-11-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241008011552.2645520-1-jrossi@linux.ibm.com>
References: <20241008011552.2645520-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KTEfx9HVmMX1j-oasCHXz_QbMq6jlFJt
X-Proofpoint-GUID: uX891nM0c3uQWMTYMRTNJ2ieAtyl0xvL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-07_16,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=776 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410080006
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index 99c0b93083..cd4fb884d6 100644
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
+    return 1;
 }
-- 
2.45.1


