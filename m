Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A3E3CEBF63
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 00:54:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stzCy-0002xl-Ad; Thu, 26 Sep 2024 20:51:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1stzCw-0002rj-QG; Thu, 26 Sep 2024 20:51:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1stzCu-0007HL-RN; Thu, 26 Sep 2024 20:51:42 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48QG5lbv014367;
 Fri, 27 Sep 2024 00:51:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=kL1/9Zg7tjEEC
 loppXvBDqcO54JCROh2bOPPLsOHDEE=; b=XsDe9HAs9juDjhe2/+Bf7PdN6fxY3
 0BIj02iTsMFLJ4c749ENHwUV1KMSepiQh6BR1uS4WCxIn1Mknun3jZCZEg0n/apB
 Zt58IenGMLLEBiI30nSnP3jnpNYzaU61KD/zCHfY0bK+MIFhq41QBTSrzBUwYVAi
 IAI+i1IfusNnr0MeSqjCf95POKowwR9JBdf35k5i/36PgqQYdLWtQccraTTzxzWU
 85JtgSqXQ+odAOK+Eo/1Ey68DhEI5IJrbTmQXO1LEcGwFind27ujKQf7rhwj1pSb
 IcrB86q1S0rIICRMRStjXYcWwYJUacxQF2xk52N6UVIP8ps5BnSsfQqPg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41smjk91rn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Sep 2024 00:51:39 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48R0pdPq006399;
 Fri, 27 Sep 2024 00:51:39 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41smjk91rk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Sep 2024 00:51:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48QLGRPw014077;
 Fri, 27 Sep 2024 00:51:38 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41t9yna5vs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Sep 2024 00:51:38 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48R0pbQ545810052
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Sep 2024 00:51:37 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4298D58056;
 Fri, 27 Sep 2024 00:51:37 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C25535805D;
 Fri, 27 Sep 2024 00:51:36 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.154.26])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 27 Sep 2024 00:51:36 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com
Cc: frankja@linux.ibm.com, jrossi@linux.ibm.com
Subject: [PATCH 11/18] pc-bios/s390-ccw: Remove panics from Netboot IPL path
Date: Thu, 26 Sep 2024 20:51:10 -0400
Message-ID: <20240927005117.1679506-12-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240927005117.1679506-1-jrossi@linux.ibm.com>
References: <20240927005117.1679506-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hdcAqKp4BmLA9Wjer8bZf1O5kbX3W4Nd
X-Proofpoint-GUID: SSjwmRVs2HoYCD0r06TbT25XXC6xFqyC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-26_06,2024-09-26_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 adultscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 spamscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409270002
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

Remove panic-on-error from Netboot specific functions so that error recovery
may be possible in the future.

Functions that would previously panic now provide a return code.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>

---
 pc-bios/s390-ccw/s390-ccw.h   |  2 +-
 pc-bios/s390-ccw/bootmap.c    |  1 +
 pc-bios/s390-ccw/netmain.c    | 22 +++++++++++++++-------
 pc-bios/s390-ccw/virtio-net.c |  7 +++++--
 4 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index cbd92f3671..8dac070257 100644
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
index dc7200c264..9459e19ffb 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -1059,6 +1059,7 @@ void zipl_load(void)
 
     if (virtio_get_device_type() == VIRTIO_ID_NET) {
         netmain();
+        panic("\n! Cannot IPL from this network !\n");
     }
 
     if (ipl_scsi()) {
diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
index bc6ad8695f..013f94d932 100644
--- a/pc-bios/s390-ccw/netmain.c
+++ b/pc-bios/s390-ccw/netmain.c
@@ -464,7 +464,7 @@ static bool find_net_dev(Schib *schib, int dev_no)
     return false;
 }
 
-static void virtio_setup(void)
+static int virtio_setup(void)
 {
     Schib schib;
     int ssid;
@@ -479,7 +479,10 @@ static void virtio_setup(void)
     enable_mss_facility();
 
     if (store_iplb(&iplb)) {
-        IPL_assert(iplb.pbt == S390_IPL_TYPE_CCW, "IPL_TYPE_CCW expected");
+        if (iplb.pbt != S390_IPL_TYPE_CCW) {
+            puts("IPL_TYPE_CCW expected");
+        }
+
         dev_no = iplb.ccw.devno;
         debug_print_int("device no. ", dev_no);
         net_schid.ssid = iplb.ccw.ssid & 0x3;
@@ -495,10 +498,10 @@ static void virtio_setup(void)
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
@@ -506,11 +509,15 @@ void netmain(void)
     sclp_setup();
     puts("Network boot starting...");
 
-    virtio_setup();
+    if (!virtio_setup()) {
+        puts("No virtio net device found.");
+        return 1;
+    }
 
     rc = net_init(&fn_ip);
     if (rc) {
-        panic("Network initialization failed. Halting.");
+        puts("Network initialization failed.");
+        return 1;
     }
 
     fnlen = strlen(fn_ip.filename);
@@ -528,5 +535,6 @@ void netmain(void)
         jump_to_low_kernel();
     }
 
-    panic("Failed to load OS from network.");
+    puts("Failed to load OS from network.");
+    return 1;
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


