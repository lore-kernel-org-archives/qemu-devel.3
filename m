Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F5D8C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 20:55:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwQoi-0007x1-2C; Tue, 18 Aug 2026 16:53:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wwQoV-0007u0-5Q; Tue, 18 Aug 2026 16:53:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wwQoS-0000hU-OB; Tue, 18 Aug 2026 16:53:38 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IJW3rA1260785; Tue, 18 Aug 2026 20:53:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=zZHSjUDRbQy3R/lg4
 K2vLvZyRzVCidnMH7FsNDwiG8g=; b=CA0sozAST32FmRBKr2tyYetxA12Hhn2hm
 e41jZOHQRD+1IhKxlwKW6Pbi1fkF+AOfYm4AUWsBQcvrW/sWZz1LOog6UdmMc/zO
 +YpTCFH3B+ss9v/unLB2/u1t4mFZUZaROzI0hj1QaZbNQed9fjZh0zxkAp+DFyLF
 5vp4MuPLiGHZn9nTcChAVpisGtCq5j8MAIdEmrxCzaHF99wRSwoiZpslLv+o8HYy
 ljWlKfYXykt4OFy2MEtcJifeNMtu4l5ZkTwi6TS4eWmHfu2DNfEVsXE58hXELK55
 9+xN6c97vaWH+v7l9BSOz5wDreIYekMz8Gv7aVe9m64q27zgTpXCQ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fu4twcf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 20:53:34 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IKfKbp012459;
 Tue, 18 Aug 2026 20:53:33 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xh5d6k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 20:53:33 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67IKrWDc3605300
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Aug 2026 20:53:32 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E273E58050;
 Tue, 18 Aug 2026 20:53:31 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6B15C58054;
 Tue, 18 Aug 2026 20:53:30 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.136.182])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 18 Aug 2026 20:53:30 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, zycai@linux.ibm.com,
 borntraeger@linux.ibm.com, jjherne@linux.ibm.com, cohuck@redhat.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com
Subject: [PATCH v1 1/7] pc-bios/s390-ccw: Split virtio-ccw and generic virtio
 net
Date: Tue, 18 Aug 2026 16:53:18 -0400
Message-ID: <20260818205324.580199-2-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260818205324.580199-1-zycai@linux.ibm.com>
References: <20260818205324.580199-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Z19lcsKBEMpRNGd4d-dSfD2rpe6oxb3l
X-Authority-Analysis: v=2.4 cv=NLLlPU6g c=1 sm=1 tr=0 ts=6a84c64e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=qfLpGqGhN9AccM6J-j0A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE1MCBTYWx0ZWRfX/F80vHqSYUuh
 v/6ESQw9ijBIHPs0xZ8diKytsuLUai6RUJEQJxxnL/jLme0gOVRZxKtXIaDOEpZf8+6a3YN74kC
 dqVOT4GV402hXQ3MDBGYivzU/u5J9CY=
X-Proofpoint-ORIG-GUID: Z19lcsKBEMpRNGd4d-dSfD2rpe6oxb3l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE1MCBTYWx0ZWRfX+WhcMKNWlGaw
 yZhETbmim9jGtxdqSydA51S+Dfz38IlV1MUZJq3T2rDzhj15ZmRdBvsVslHYr44hGolFXB+JoB3
 VEYQqA6kyq/Gfz+gt6gPIM+sqIjKV95oRNo9CF8AeeedGfFsdaDVLsNuZ7fqqr4OHrJGfJvtbII
 BVDp1WHUQpDLNU+XalUlqU4gzuETXXqjDj7q5wDnOIvjCsjPBc6ma71mjIe56e3BBZnSuST66sV
 V4IkZQxxutS9mJVbRerK4UvZkCsEtN8t0t6UNcpXR9EcLkPEESf1252S6CRPcWFD5srrgWm704E
 0toSpJOs8b/BZbgnhigqx450MJOkPUlx9HvQ2qttDvBB4Ui7IoxCEjxPKmJBP46xE10XYFTG8Bu
 aYWaq4kmDU4xo3Jj+Zte4+1nVOUdV0+Fshm2brPYval56TeROyD19I2HHthSJQWaphmG7fL2dtT
 1/9MJj7DP0jaOcVU9KA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_04,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 clxscore=1011 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180150
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Refactor network device setup to separate virtio-ccw from
generic virtio-net logic for easier reuse of existing virtio
functions with non-CCW devices.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
---
 pc-bios/s390-ccw/netmain.c    | 64 +----------------------------------
 pc-bios/s390-ccw/virtio-ccw.c | 62 +++++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/virtio-ccw.h |  1 +
 pc-bios/s390-ccw/virtio-net.c | 10 ++++++
 pc-bios/s390-ccw/virtio.h     |  1 +
 5 files changed, 75 insertions(+), 63 deletions(-)

diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
index 791854fce0..e2f2278b8d 100644
--- a/pc-bios/s390-ccw/netmain.c
+++ b/pc-bios/s390-ccw/netmain.c
@@ -489,68 +489,6 @@ static int net_try_direct_tftp_load(filename_ip_t *fn_ip)
     return rc;
 }
 
-static bool find_net_dev(Schib *schib, int dev_no)
-{
-    int i, r;
-
-    for (i = 0; i < 0x10000; i++) {
-        net_schid.sch_no = i;
-        r = stsch_err(net_schid, schib);
-        if (r == 3 || r == -EIO) {
-            break;
-        }
-        if (!schib->pmcw.dnv) {
-            continue;
-        }
-        enable_subchannel(net_schid);
-        if (!virtio_is_supported(virtio_get_device())) {
-            continue;
-        }
-        if (virtio_get_device_type() != VIRTIO_ID_NET) {
-            continue;
-        }
-        if (dev_no < 0 || schib->pmcw.dev == dev_no) {
-            return true;
-        }
-    }
-
-    return false;
-}
-
-static bool virtio_setup(void)
-{
-    Schib schib;
-    int ssid;
-    bool found = false;
-    uint16_t dev_no;
-
-    /*
-     * We unconditionally enable mss support. In every sane configuration,
-     * this will succeed; and even if it doesn't, stsch_err() can deal
-     * with the consequences.
-     */
-    enable_mss_facility();
-
-    if (have_iplb || store_iplb(&iplb)) {
-        IPL_assert(iplb.pbt == S390_IPL_TYPE_CCW, "IPL_TYPE_CCW expected");
-        dev_no = iplb.ccw.devno;
-        debug_print_int("device no. ", dev_no);
-        net_schid.ssid = iplb.ccw.ssid & 0x3;
-        debug_print_int("ssid ", net_schid.ssid);
-        found = find_net_dev(&schib, dev_no);
-    } else {
-        for (ssid = 0; ssid < 0x3; ssid++) {
-            net_schid.ssid = ssid;
-            found = find_net_dev(&schib, -1);
-            if (found) {
-                break;
-            }
-        }
-    }
-
-    return found;
-}
-
 int netmain(void)
 {
     filename_ip_t fn_ip;
@@ -559,7 +497,7 @@ int netmain(void)
     sclp_setup();
     puts("Network boot starting...");
 
-    if (!virtio_setup()) {
+    if (!virtio_net_setup()) {
         puts("No virtio net device found.");
         return -1;
     }
diff --git a/pc-bios/s390-ccw/virtio-ccw.c b/pc-bios/s390-ccw/virtio-ccw.c
index 5cb2158ed2..403bd8a785 100644
--- a/pc-bios/s390-ccw/virtio-ccw.c
+++ b/pc-bios/s390-ccw/virtio-ccw.c
@@ -237,3 +237,65 @@ int virtio_ccw_setup(VDev *vdev)
 
     return 0;
 }
+
+static bool find_ccw_net_dev(Schib *schib, int dev_no)
+{
+    int i, r;
+
+    for (i = 0; i < 0x10000; i++) {
+        net_schid.sch_no = i;
+        r = stsch_err(net_schid, schib);
+        if (r == 3 || r == -EIO) {
+            break;
+        }
+        if (!schib->pmcw.dnv) {
+            continue;
+        }
+        enable_subchannel(net_schid);
+        if (!virtio_is_supported(virtio_get_device())) {
+            continue;
+        }
+        if (virtio_get_device_type() != VIRTIO_ID_NET) {
+            continue;
+        }
+        if (dev_no < 0 || schib->pmcw.dev == dev_no) {
+            return true;
+        }
+    }
+
+    return false;
+}
+
+bool virtio_ccw_net_setup(void)
+{
+    Schib schib;
+    int ssid;
+    bool found = false;
+    uint16_t dev_no;
+
+    /*
+     * We unconditionally enable mss support. In every sane configuration,
+     * this will succeed; and even if it doesn't, stsch_err() can deal
+     * with the consequences.
+     */
+    enable_mss_facility();
+
+    if (have_iplb || store_iplb(&iplb)) {
+        IPL_assert(iplb.pbt == S390_IPL_TYPE_CCW, "IPL_TYPE_CCW expected");
+        dev_no = iplb.ccw.devno;
+        debug_print_int("device no. ", dev_no);
+        net_schid.ssid = iplb.ccw.ssid & 0x3;
+        debug_print_int("ssid ", net_schid.ssid);
+        found = find_ccw_net_dev(&schib, dev_no);
+    } else {
+        for (ssid = 0; ssid < 0x3; ssid++) {
+            net_schid.ssid = ssid;
+            found = find_ccw_net_dev(&schib, -1);
+            if (found) {
+                break;
+            }
+        }
+    }
+
+    return found;
+}
diff --git a/pc-bios/s390-ccw/virtio-ccw.h b/pc-bios/s390-ccw/virtio-ccw.h
index a506767eaa..c330e02f99 100644
--- a/pc-bios/s390-ccw/virtio-ccw.h
+++ b/pc-bios/s390-ccw/virtio-ccw.h
@@ -20,5 +20,6 @@ int virtio_ccw_run(VDev *vdev, int vqid, VirtioCmd *cmd);
 long virtio_ccw_notify(SubChannelId schid, int vq_idx, long cookie);
 int virtio_ccw_setup(VDev *vdev);
 int virtio_ccw_reset(VDev *vdev);
+bool virtio_ccw_net_setup(void);
 
 #endif
diff --git a/pc-bios/s390-ccw/virtio-net.c b/pc-bios/s390-ccw/virtio-net.c
index f58f7ffc55..0ee51653ab 100644
--- a/pc-bios/s390-ccw/virtio-net.c
+++ b/pc-bios/s390-ccw/virtio-net.c
@@ -146,3 +146,13 @@ void virtio_net_deinit(void)
 {
     virtio_reset(virtio_get_device());
 }
+
+bool virtio_net_setup(void)
+{
+    switch (virtio_get_device()->ipl_type) {
+    case S390_IPL_TYPE_CCW:
+        return virtio_ccw_net_setup();
+    default:
+        return false;
+    }
+}
diff --git a/pc-bios/s390-ccw/virtio.h b/pc-bios/s390-ccw/virtio.h
index aa307025e0..04dbc65dbd 100644
--- a/pc-bios/s390-ccw/virtio.h
+++ b/pc-bios/s390-ccw/virtio.h
@@ -290,6 +290,7 @@ int virtio_setup_ccw(VDev *vdev);
 /* virtio-net.c */
 int virtio_net_init(void *mac_addr);
 void virtio_net_deinit(void);
+bool virtio_net_setup(void);
 
 /* virtio-blkdev.c */
 int virtio_blk_setup_device(VDev *vdev);
-- 
2.55.0


