Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB7ECA5FC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 15:26:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBwAf-0008LT-CN; Wed, 30 Sep 2026 11:24:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xBwAc-0008Hw-J4; Wed, 30 Sep 2026 11:24:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xBwAa-00021S-HB; Wed, 30 Sep 2026 11:24:34 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UE64H91337364; Wed, 30 Sep 2026 15:24:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=pNlveaTCHRCKe+GYC
 OOMUxObmX8nQfGCKX/OLDVLVio=; b=Z3SgfYKq+UXOHdnPr9o9/UZ6Y/Bk9QUfR
 i5SFNlOKs5qnWkVB2gKmfo+YBq9OzJKQeIm0XB13wkirxamAGpIYfCEe4iMpQXc3
 mlwNAhA6yd3ORB+ZoeAaelwU4p5VBQYSK0VC/F0dZ3gBW5VtA8WHSX5uHbF2RXaE
 qTBGtBrALS9y9QVyqnaQ88b3U6j+8NYGmYkL28Ryz4+92Nlz7GDPXbABiyOKMutA
 QgaNcHmARYJ5u5swwDK3S85SZMtvUtTnx/tkIOO6Aqa7+ruI91ibvISLTSzQDj1A
 qrrycZMvPQB1L9O9g1xBjFGwLUHMhxQqvr7vEOMsPlCZd6hY0VwLQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5qrdtw4-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 15:24:30 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UE39S42287821; Wed, 30 Sep 2026 15:24:30 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h0q4pb3jj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 15:24:29 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68UFOSLS28770916
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Sep 2026 15:24:28 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 30F9F5805A;
 Wed, 30 Sep 2026 15:24:28 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ADD0F5805F;
 Wed, 30 Sep 2026 15:24:27 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.5.156]) by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 30 Sep 2026 15:24:27 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 11/23] pc-bios/s390-ccw: Move CCW net setup to virtio-ccw
Date: Wed, 30 Sep 2026 11:24:08 -0400
Message-ID: <20260930152420.1956230-12-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930152420.1956230-1-farman@linux.ibm.com>
References: <20260930152420.1956230-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA2MCBTYWx0ZWRfX0A6l9mb2Mk+p
 X9/+6uZiD0kJfN/mJQRVO/X/FNIh/vIQ/qjqsmJIQ3hYXLB0HBjBrNNO7ll8tDMbySR7f0JbY5v
 mE0QLTAVYmbccomKBInf89ZyeV/Ld+BvJZRrEmF968yQ1/kQT4L44oGkUftlKYE0kzNNAbBgP8R
 2f3JK3VYiYXHH45P8K1bWNsbd5sGSPejIKZ8aBZUYZXbRxpC0wszXTn1YxCspJV0xVwpNv3dAzy
 OVUa1MrBdjsS7dB7DqWrFO9BJjqh7W2tkauj7pKFVtrNcp8lTj1I6HjjswHED6pxSagaQYHFcqE
 SPTzfWp24DqICfFxFRfX8KfSLRkF1yMrnVQvhMIUdhrXZD5jaulRhfpvNyohcW6IsFK/f3uKtPN
 R/0Je84jfjWATNgKzUO5FSjy/GnouZPdkb78ko0+NN8JG+lSzQXeeqxECSlWx+VyzCqY+gmOSPV
 2+Y2OXeX0cYh3gWcmYQ==
X-Authority-Analysis: v=2.4 cv=SPbXx+vH c=1 sm=1 tr=0 ts=6abd29ae cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=Aak0X9c2SgglYLKd_28A:9
X-Proofpoint-ORIG-GUID: tOxaOnF3u6lUWjR1gU0kmRR3nfy1aEep
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA2MCBTYWx0ZWRfX36ehLZCXn15y
 s/cr5ZK4P10G+2S6+mmvZQk7zN3yfkJCtZiZcjhPOjPi3eHHvgigTfffpW/5JFpKumoSKuAYfrt
 /vz3K98aO7aw6FAp4+8EmI3MZ3p8GGo=
X-Proofpoint-GUID: tOxaOnF3u6lUWjR1gU0kmRR3nfy1aEep
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300060
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
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

From: Zhuoying Cai <zycai@linux.ibm.com>

Move CCW-specific virtio_setup() and find_net_dev() to virtio-ccw.c
to decouple the generic net boot logic from the CCW transport.
Also update the error message on failure to specify "ccw net device".

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>
Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260924222949.147720-2-zycai@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
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


