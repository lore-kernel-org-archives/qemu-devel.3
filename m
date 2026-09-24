Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33E7AC9831E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 22:30:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9rx6-0000OX-4d; Thu, 24 Sep 2026 18:30:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1x9rx3-0000Mr-KT; Thu, 24 Sep 2026 18:30:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1x9rx1-0005EI-LT; Thu, 24 Sep 2026 18:30:01 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OJ5o7k2914735; Thu, 24 Sep 2026 22:29:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=9mSq6xsBLquNSwtYk
 M6I7d/zmN6rHC7utExsMJJnObk=; b=p/Pa4OIf9hk3y8ZEhmXgAg1Bb17H01gbW
 sEpmI8NeIHLzgXSnPBpG9UqV2SzpU8AjH3X/LENvD89tyPlVrhBGkCaCPEzllKGS
 70W6CLGHDDHdBkiCTSbiqM+7up4rXaw6KRFW8HHj/1RUSrrl40EmkJJx79wbUS9l
 0MqDycj6KM/+q8QdQs86GktfoNyKMIYDcv6DBhHLNzUP+U5BST7uQJGjww+QWIi7
 oGMGa2MXMRLO/xIfLYEei1hXAAKHaa4trEU/89i8JHr5RQOiW3qHZJwdVJw44jCX
 d2cHXK8vsypnTkL4G9l9ZlBwSvgXr2ddtwRipr+BIKij8lv5ROgUw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1u6x1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 22:29:57 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OIlXLU2515971; Thu, 24 Sep 2026 22:29:57 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbu8ywa6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 22:29:57 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68OMTtG111534880
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2026 22:29:56 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C180658045;
 Thu, 24 Sep 2026 22:29:55 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4FABB58050;
 Thu, 24 Sep 2026 22:29:54 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.83.151])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Sep 2026 22:29:54 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, zycai@linux.ibm.com,
 borntraeger@linux.ibm.com, jjherne@linux.ibm.com, cohuck@redhat.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com,
 jdaley@linux.ibm.com
Subject: [PATCH v5 1/8] pc-bios/s390-ccw: Move CCW net setup to virtio-ccw
Date: Thu, 24 Sep 2026 18:29:42 -0400
Message-ID: <20260924222949.147720-2-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924222949.147720-1-zycai@linux.ibm.com>
References: <20260924222949.147720-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -vje_wqer_l7A4eBVHkMAq5fGpORCZpp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA5MCBTYWx0ZWRfX3AhuNz+p0Zbl
 pLLNXv4ia0wZ7gsqREY9EKd7kp6+0p/+oLJRiYR/nCmZk6ayXm+YYXlF4RCgnBc/Igv0NH3Jjin
 TV+Nhjx/aiIRc+c9luTeCsXd8GaaNak1Q3zKn3qFHDlToazD8QzCaPP8DgqL7b01t7zhM6VAbCN
 QXVUuE/J4sBVsFjEVvwzl+NSiCEO2zEfW/qZpPhLBervaLerIO9J0bBRZhbqLtiflEYTOOHQUeL
 w1VmeZrhXj9wpjMAecH8KhuTC845XcfP+Ma8QA14z0HnN63SDCnY+uuDp2ILorrX+3hb2bEqLuj
 OCr0xRCHG9y6uM4rRB0wTG3vdPVTKv6M7pLB1LYfDWRmIj+KXmQ731TwNiQ7gTfYi9bKx9pW2/q
 PqAU7wdGDkqOxoUMxmHrIbxSXE8REPXu/OLLcL5OVheMB1ebq/quvpcLh1L93Q87rAOFcaeT76P
 i+4GGRdlaCC/vMmhnXA==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab5a465 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=Aak0X9c2SgglYLKd_28A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA5MCBTYWx0ZWRfX07N5TM/b2Ydt
 EVU/BTciDgR9qgK+G4cS7aSUgJt/cB5Q7MXpFYEpI9oAOkymUaZOmQyHv9mRbCBiralN1iC6QfT
 1t9dKySUDUq3PqbNiaxbOpJ+gDzDN/U=
X-Proofpoint-GUID: -vje_wqer_l7A4eBVHkMAq5fGpORCZpp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240090
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
index ea5dbc2857..3c2c44529c 100644
--- a/pc-bios/s390-ccw/virtio-ccw.c
+++ b/pc-bios/s390-ccw/virtio-ccw.c
@@ -220,3 +220,65 @@ int virtio_ccw_setup(VDev *vdev)
 
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
index 43d21906e5..7768c152d0 100644
--- a/pc-bios/s390-ccw/virtio-ccw.h
+++ b/pc-bios/s390-ccw/virtio-ccw.h
@@ -19,5 +19,6 @@ bool virtio_ccw_is_supported(VDev *vdev);
 long virtio_ccw_notify(SubChannelId schid, int vq_idx, long cookie);
 int virtio_ccw_setup(VDev *vdev);
 int virtio_ccw_reset(VDev *vdev);
+bool virtio_ccw_net_setup(void);
 
 #endif
-- 
2.55.0


