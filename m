Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B00C88E7F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 19:35:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6CSI-00072o-Lz; Mon, 14 Sep 2026 15:35:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1x6CS3-0006yI-7j; Mon, 14 Sep 2026 15:34:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1x6CS0-00046m-MB; Mon, 14 Sep 2026 15:34:50 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EJ1aTk1002278; Mon, 14 Sep 2026 19:34:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=w83zkwm/0a2Z6Q4GF
 2R5NDH6xjXFt0klZ73W3gyuc/8=; b=jZKXKHequ3q9RAGDIG8+JU1y/mjwDJ1z6
 x2tsH6OoHo/qmJq4IerKwbgqca1o+79VTGByEitIlb7lcOWtCkLWi2N8lRZBe8Eq
 8ahxiCUX0VjDB5VLgUSSDBHEIQzL1dsHDSPPQrt87RyHgCSx+sw5h3rfnVNqnrhf
 pRGrAOo9PCwgrKuTkf7DDR9qOQC/lLL+/NN7ajdyCbBAvSTv4e5bMs9QCV4vtn3b
 QNjMOMJfh2hLkhzYhq2QsQshzkDzlFD0PDpZgFiBgYgrliSua4jVs4oui7Np4jo4
 H+FFQmtsh2yjSfIg3GO/NegmVcAns+s7KYgg0Kvb6OPFM+VPYsrnQ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxdq3j8u-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2026 19:34:46 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EIoutX2784311; Mon, 14 Sep 2026 19:34:45 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gnkry7kdc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2026 19:34:45 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68EJYi4r15205058
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Sep 2026 19:34:44 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 12D0A58058;
 Mon, 14 Sep 2026 19:34:44 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5CCFC58059;
 Mon, 14 Sep 2026 19:34:42 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.78.15])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 14 Sep 2026 19:34:42 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, zycai@linux.ibm.com,
 borntraeger@linux.ibm.com, jjherne@linux.ibm.com, cohuck@redhat.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com,
 jdaley@linux.ibm.com
Subject: [PATCH v3 1/8] pc-bios/s390-ccw: Move CCW net setup to virtio-ccw
Date: Mon, 14 Sep 2026 15:34:31 -0400
Message-ID: <20260914193438.526407-2-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914193438.526407-1-zycai@linux.ibm.com>
References: <20260914193438.526407-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDI3OCBTYWx0ZWRfX46ALXrl2JpSr
 D+Qv+ieZ4k85Qst0q3RB7Ic5Q+ovSPxQlon6IS+KshVF8jPEGu/K33sj9xxv1Gg89posC74e389
 i+wDeZoU4PO8Jkr/uxBpao0dv3Ea7ZmvShouUJf+NCusJwB9bPnMyZDvE6cm3abxHVLr886eqqQ
 ESPditsakPhWd6XGHa0whmg6XlvZ4BQRIn+4olzTc84aD+Jp77T+OCYFsZS49jX5LBcZH7jPeLG
 4kPM4rFsnQH3CYs50TMfsmJ6+I/KF92uOoLKz9GLKyGCONfZbyEW1iDLSyJ9yUb8Jy0zortC+y+
 Ag8Xow2Ettt4GQ/X93AbLGHYOk9q+FyD9YPMrRQmohvAdtNsMEe2dEhj6rndgVxFTs2OytPAkdW
 FdofXAa4HIsx1N+36DKFLjcCt2lg1FZBj1rrjAH1le37HAiNIpHt5J7LxQVvyWuy3SFbPQvfGlW
 3zQ5zzM2KJMBgG8m5mg==
X-Proofpoint-GUID: bIjbG3OmA4iUrIJcOgespCXUmwVSLI5G
X-Authority-Analysis: v=2.4 cv=DobDa2/+ c=1 sm=1 tr=0 ts=6aa84c56 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=Aak0X9c2SgglYLKd_28A:9
X-Proofpoint-ORIG-GUID: bIjbG3OmA4iUrIJcOgespCXUmwVSLI5G
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDI3OCBTYWx0ZWRfXxEBaPw54H9cg
 6HrERiZfmLuvITumj0gtJtK8t/+ppPmkBlQUIGZ5FzuQat7U5PisarCnefphCevanYKbX0lfgcR
 Qx3Tr7aWT2duMkVZaegY1ulMba/hccI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140278
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

Move CCW-specific virtio_setup() and find_net_dev() to virtio-ccw.c
to decouple the generic net boot logic from the CCW transport.
Also update the error message on failure to specify "ccw net device".

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>
Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 pc-bios/s390-ccw/netmain.c    | 67 ++---------------------------------
 pc-bios/s390-ccw/virtio-ccw.c | 62 ++++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/virtio-ccw.h |  1 +
 3 files changed, 66 insertions(+), 64 deletions(-)

diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
index ccd1c30013..bcb62bf6ca 100644
--- a/pc-bios/s390-ccw/netmain.c
+++ b/pc-bios/s390-ccw/netmain.c
@@ -35,6 +35,7 @@
 #include "s390-ccw.h"
 #include "cio.h"
 #include "virtio.h"
+#include "virtio-ccw.h"
 #include "s390-time.h"
 
 #define DEFAULT_BOOT_RETRIES 10
@@ -489,68 +490,6 @@ static int net_try_direct_tftp_load(filename_ip_t *fn_ip)
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
-    if (have_iplb || store_iplb(iplb)) {
-        IPL_assert(iplb->pbt == S390_IPL_TYPE_CCW, "IPL_TYPE_CCW expected");
-        dev_no = iplb->ccw.devno;
-        debug_print_int("device no. ", dev_no);
-        net_schid.ssid = iplb->ccw.ssid & 0x3;
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
@@ -559,8 +498,8 @@ int netmain(void)
     sclp_setup();
     puts("Network boot starting...");
 
-    if (!virtio_setup()) {
-        puts("No virtio net device found.");
+    if (!virtio_ccw_net_setup()) {
+        puts("No valid virtio ccw net device found.");
         return -1;
     }
 
diff --git a/pc-bios/s390-ccw/virtio-ccw.c b/pc-bios/s390-ccw/virtio-ccw.c
index 5cb2158ed2..5bf67738e4 100644
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
+    if (have_iplb || store_iplb(iplb)) {
+        IPL_assert(iplb->pbt == S390_IPL_TYPE_CCW, "IPL_TYPE_CCW expected");
+        dev_no = iplb->ccw.devno;
+        debug_print_int("device no. ", dev_no);
+        net_schid.ssid = iplb->ccw.ssid & 0x3;
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
-- 
2.55.0


