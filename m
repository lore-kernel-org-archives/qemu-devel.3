Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55BC3CCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 18:16:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9p09-0003zO-Fh; Fri, 17 Oct 2025 14:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1v9p06-0003ym-Sf; Fri, 17 Oct 2025 14:16:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1v9p04-0007Ll-FC; Fri, 17 Oct 2025 14:16:26 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59HGrrVB012398;
 Fri, 17 Oct 2025 18:16:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=VsPixCQuXr0a3YA1K
 wWnXXRiIgqzlv8MPMc2bZkj0yA=; b=L9pAaWG34T5Fa5q7h3Sv3gAt0J2OpDXdn
 jzRg76nAHT9AkuF6DUOZl2ZOGzFkJP1BPNjgLl33xFbth6S0t25GkThvo7FEZsjA
 Dar4lStYl6f8EPWCIEVXgKXrsidGkkq5joCRbdUZSJcoovBCWx5s0Ba6k9DnM4go
 6xcPZtGqMvZ+LdBtlv5I4tra5uFEITWEDX+9o/Bu7dszRQbXM/uHU5rccOY6KkQl
 a8eMrNHd+hHoAGER+z9xmUgw0CxtYJM2ZJa+abUEkeRdQ/D4qIfjRwfSabFuRROe
 7+umKuiKSea35ybYpGRMp7Ert4lWcv3pDIFFfkEnYQU4buZR4dVGg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qcnru7pd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Oct 2025 18:16:19 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59HIGIhu030417;
 Fri, 17 Oct 2025 18:16:18 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qcnru7pa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Oct 2025 18:16:18 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59HIEw3x003626;
 Fri, 17 Oct 2025 18:16:17 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r1xyevsv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Oct 2025 18:16:17 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59HIGESl31654652
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Oct 2025 18:16:14 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 05F8620040;
 Fri, 17 Oct 2025 18:16:14 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7A3762004B;
 Fri, 17 Oct 2025 18:16:11 +0000 (GMT)
Received: from vishalc-ibm.ibm.com (unknown [9.39.22.45])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 17 Oct 2025 18:16:11 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: adityag@linux.ibm.com, harshpb@linux.ibm.com, milesg@linux.ibm.com,
 npiggin@gmail.com, peter.maydell@linaro.org, alistair23@gmail.com,
 balaton@eik.bme.hu, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 berrange@redhat.com
Cc: Vishal Chourasia <vishalc@linux.ibm.com>
Subject: [Patch v4 3/5] hw/core: Pass errp to load_image_targphys_as()
Date: Fri, 17 Oct 2025 23:42:51 +0530
Message-ID: <20251017181250.1421446-8-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017181250.1421446-2-vishalc@linux.ibm.com>
References: <20251017181250.1421446-2-vishalc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M5ZA6iws c=1 sm=1 tr=0 ts=68f287f3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=WwcbXC5amFkfT6oAP7YA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: KeZ3cedI9TTVXvDEfEZu_FwWdPr2uRSX
X-Proofpoint-ORIG-GUID: WwjdRroBSZG-hIihs61MwHALgHfUJI3W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEwMDE0MCBTYWx0ZWRfX4kxmtIC1NGF8
 0w92Ujp+CCDVzBO38lbzZcdDpwtg2JVGBJHe26ahmotQrJsx6qdF2U90Xm3ad4lqaSJnb7i7noa
 +yYzdc/MTckHPOEq0/b61+OR5/0w062QULteFHqWRO2UteAJrwvL4Ay34uMDY1Mtc67p3MkyZK2
 hHeCD1EhjMMmKAgcmB9BkT6GHonAn5RX9LuJYFYkO9a3akxscr8CrMgdwGR9vlnxwRO7IL+y5lq
 EuTj/ncK0ffSXpL2ivuljuHVYhn+ArU4QM5DS1yfpl/pJi2iAvPjfnATSQWkOXrIINO4Zc/M4fF
 dUU9EvgnHTTx1UvwbWQZWOEYT1NkLA3TBFmwffrMf5U7loz8iHOciFgu0dNH7DcnJHjrBI8TLp8
 3PABQgG7wQ081+FXh2oc3XH1TPoaqg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510100140
Received-SPF: pass client-ip=148.163.158.5; envelope-from=vishalc@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Pass errp to load_image_targphys_as() in generic-loader and
guest-loader to capture detailed error information from the
loader functions.

Use error_prepend() instead of error_setg() to preserve the
underlying error details while adding context about which image
failed to load.

Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
---
 hw/core/generic-loader.c | 7 ++++---
 hw/core/guest-loader.c   | 7 ++++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
index 6689847c33..35d4e5f4ea 100644
--- a/hw/core/generic-loader.c
+++ b/hw/core/generic-loader.c
@@ -60,6 +60,7 @@ static void generic_loader_reset(void *opaque)
 
 static void generic_loader_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_GUARD();
     GenericLoaderState *s = GENERIC_LOADER(dev);
     hwaddr entry;
     ssize_t size = 0;
@@ -149,13 +150,13 @@ static void generic_loader_realize(DeviceState *dev, Error **errp)
         if (size < 0 || s->force_raw) {
             /* Default to the maximum size being the machine's ram size */
             size = load_image_targphys_as(s->file, s->addr,
-                    current_machine->ram_size, as, NULL);
+                    current_machine->ram_size, as, errp);
         } else {
             s->addr = entry;
         }
 
-        if (size < 0) {
-            error_setg(errp, "Cannot load specified image %s", s->file);
+        if (*errp) {
+            error_prepend(errp, "Cannot load specified image %s: ", s->file);
             return;
         }
     }
diff --git a/hw/core/guest-loader.c b/hw/core/guest-loader.c
index 59f325ad9c..dcbe8e4520 100644
--- a/hw/core/guest-loader.c
+++ b/hw/core/guest-loader.c
@@ -81,6 +81,7 @@ static void loader_insert_platform_data(GuestLoaderState *s, int size,
 
 static void guest_loader_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_GUARD();
     GuestLoaderState *s = GUEST_LOADER(dev);
     char *file = s->kernel ? s->kernel : s->initrd;
     int size = 0;
@@ -101,9 +102,9 @@ static void guest_loader_realize(DeviceState *dev, Error **errp)
 
     /* Default to the maximum size being the machine's ram size */
     size = load_image_targphys_as(file, s->addr, current_machine->ram_size,
-                                  NULL, NULL);
-    if (size < 0) {
-        error_setg(errp, "Cannot load specified image %s", file);
+                                  NULL, errp);
+    if (*errp) {
+        error_prepend(errp, "Cannot load specified image %s: ", file);
         return;
     }
 
-- 
2.51.0


