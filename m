Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDCADD3C912
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2024 01:31:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2KmU-0000Kz-Uf; Sat, 19 Oct 2024 21:30:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1t2Klu-0008SU-VY; Sat, 19 Oct 2024 21:30:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1t2Klt-0005Pe-BK; Sat, 19 Oct 2024 21:30:18 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49JLF21s026439;
 Sun, 20 Oct 2024 01:30:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=lCaKpUHICSjYrs1pN
 pFftZJ1KAFt7Waxtbbrrk948j0=; b=SM8wC5S5Z32cRjFARpP1dCxkDRukT6KcW
 TpYRbBA8NxDV2yvQHjgWX7Ae6Ed6g+J6BlCGjI5hYduALsjDX8++qBhmOZUgTZqq
 irp0qvDGwSzRWZn4NJcuHW/rdn+Bhh0KHDIrPCYXR+lHrxBgfTJe1koQBzJSzgyI
 WE40qSmOVmcCO/iLhQFTxABJ0CrqcEF/I6TzidHLAS8PgzGgDRXuU56n+SECC49X
 +SFYa9oWnbhaC3Fx4q5cBqkcEsXJuHSyuXF7Qzl+zMATcW7CmLQfMNA1gVSFsmj1
 8lSUoz/DL67JLGl13Js6zLgfku8BvESf2rU+MoEFFBKQNjAvF33zg==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42c5fsk1t9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 20 Oct 2024 01:30:15 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49K0BR7X026471;
 Sun, 20 Oct 2024 01:30:15 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 42cq3s07tv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 20 Oct 2024 01:30:15 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49K1UDwW28574272
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 20 Oct 2024 01:30:13 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 888E75805C;
 Sun, 20 Oct 2024 01:30:13 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D36D858054;
 Sun, 20 Oct 2024 01:30:12 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.54.50])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 20 Oct 2024 01:30:12 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com
Cc: frankja@linux.ibm.com, jrossi@linux.ibm.com
Subject: [PATCH v5 11/19] pc-bios/s390-ccw: Remove panics from Netboot IPL path
Date: Sat, 19 Oct 2024 21:29:45 -0400
Message-ID: <20241020012953.1380075-12-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241020012953.1380075-1-jrossi@linux.ibm.com>
References: <20241020012953.1380075-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lZyRe583N_--idwi2b-6uWJ1QKO2p3G0
X-Proofpoint-ORIG-GUID: lZyRe583N_--idwi2b-6uWJ1QKO2p3G0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 impostorscore=0 clxscore=1015 mlxscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 priorityscore=1501
 spamscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410200009
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

Remove panic-on-error from Netboot specific functions so that error recovery
may be possible in the future.

Functions that would previously panic now provide a return code.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 pc-bios/s390-ccw/s390-ccw.h   |  2 +-
 pc-bios/s390-ccw/bootmap.c    |  1 +
 pc-bios/s390-ccw/netmain.c    | 17 +++++++++++------
 pc-bios/s390-ccw/virtio-net.c |  7 +++++--
 4 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index 3e844abd71..344ad15655 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -57,7 +57,7 @@ unsigned int get_loadparm_index(void);
 void main(void);
 
 /* netmain.c */
-void netmain(void);
+int netmain(void);
 
 /* sclp.c */
 void sclp_print(const char *string);
diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index 652807a16a..95ef9104d0 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -1072,6 +1072,7 @@ void zipl_load(void)
 
     if (virtio_get_device_type() == VIRTIO_ID_NET) {
         netmain();
+        panic("\n! Cannot IPL from this network !\n");
     }
 
     if (ipl_scsi()) {
diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
index bc6ad8695f..d1a6c9a91c 100644
--- a/pc-bios/s390-ccw/netmain.c
+++ b/pc-bios/s390-ccw/netmain.c
@@ -464,7 +464,7 @@ static bool find_net_dev(Schib *schib, int dev_no)
     return false;
 }
 
-static void virtio_setup(void)
+static bool virtio_setup(void)
 {
     Schib schib;
     int ssid;
@@ -495,10 +495,10 @@ static void virtio_setup(void)
         }
     }
 
-    IPL_assert(found, "No virtio net device found");
+    return found;
 }
 
-void netmain(void)
+int netmain(void)
 {
     filename_ip_t fn_ip;
     int rc, fnlen;
@@ -506,11 +506,15 @@ void netmain(void)
     sclp_setup();
     puts("Network boot starting...");
 
-    virtio_setup();
+    if (!virtio_setup()) {
+        puts("No virtio net device found.");
+        return -1;
+    }
 
     rc = net_init(&fn_ip);
     if (rc) {
-        panic("Network initialization failed. Halting.");
+        puts("Network initialization failed.");
+        return -1;
     }
 
     fnlen = strlen(fn_ip.filename);
@@ -528,5 +532,6 @@ void netmain(void)
         jump_to_low_kernel();
     }
 
-    panic("Failed to load OS from network.");
+    puts("Failed to load OS from network.");
+    return -1;
 }
diff --git a/pc-bios/s390-ccw/virtio-net.c b/pc-bios/s390-ccw/virtio-net.c
index 2fcb0a58c5..f9854a22c3 100644
--- a/pc-bios/s390-ccw/virtio-net.c
+++ b/pc-bios/s390-ccw/virtio-net.c
@@ -54,8 +54,11 @@ int virtio_net_init(void *mac_addr)
     vdev->guest_features[0] = VIRTIO_NET_F_MAC_BIT;
     virtio_setup_ccw(vdev);
 
-    IPL_assert(vdev->guest_features[0] & VIRTIO_NET_F_MAC_BIT,
-               "virtio-net device does not support the MAC address feature");
+    if (!(vdev->guest_features[0] & VIRTIO_NET_F_MAC_BIT)) {
+        puts("virtio-net device does not support the MAC address feature");
+        return -1;
+    }
+
     memcpy(mac_addr, vdev->config.net.mac, ETH_ALEN);
 
     for (i = 0; i < 64; i++) {
-- 
2.45.1


