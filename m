Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27E8CCCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 13:27:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBYrA-0006XI-Px; Wed, 22 Oct 2025 09:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1vBYr3-0006Fw-Ti; Wed, 22 Oct 2025 09:26:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1vBYr0-0006Fh-6y; Wed, 22 Oct 2025 09:26:17 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M5XMLI004814;
 Wed, 22 Oct 2025 13:26:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=VsPixCQuXr0a3YA1K
 wWnXXRiIgqzlv8MPMc2bZkj0yA=; b=jyAyGS0pY+Ks7KHEsrWR4s/wJKriP1WZJ
 HdCMaBTQ0RZMKYPDe/z3TLfNfPCKp38zOn4xmVJva4qE76YPWrElpfTo3PViS6wV
 xemhq+43/1b66mKkNs8MF1g+CRhLquTYx9C2ZsLp3Oth4GWD5wsZjAvoFyvBlrZY
 xVwa5YyG4PzMbiK+3PzEzF1myrMlpd5mxYL6/t/TanbOP061JwrGOCdi1gfjVBYg
 AUCY2HuaSXwO9CZPbokrbvXkZUzqi2wktofHEPfrR3d+8Mwvmi5iR9wMMzzeXgnZ
 MrXSrmaoEAkkk8HJjDYC4POj4DA0XCibDvUppgHcagygAjJoa4hug==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v326vw4e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Oct 2025 13:26:09 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59MDPMI9017733;
 Wed, 22 Oct 2025 13:26:09 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v326vw4c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Oct 2025 13:26:09 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59MAM9TS014676;
 Wed, 22 Oct 2025 13:26:08 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vn7s8rcs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Oct 2025 13:26:08 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59MDQ2A053215610
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Oct 2025 13:26:02 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 811F720040;
 Wed, 22 Oct 2025 13:26:02 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 047572004B;
 Wed, 22 Oct 2025 13:26:00 +0000 (GMT)
Received: from vishalc-ibm.ibm.com (unknown [9.39.25.31])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 22 Oct 2025 13:25:59 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: adityag@linux.ibm.com, harshpb@linux.ibm.com, milesg@linux.ibm.com,
 npiggin@gmail.com, peter.maydell@linaro.org, alistair23@gmail.com,
 balaton@eik.bme.hu, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 berrange@redhat.com
Cc: Vishal Chourasia <vishalc@linux.ibm.com>
Subject: [Patch v6 4/6] hw/core: Pass errp to load_image_targphys_as()
Date: Wed, 22 Oct 2025 18:55:07 +0530
Message-ID: <20251022132507.1597232-10-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022132507.1597232-2-vishalc@linux.ibm.com>
References: <20251022132507.1597232-2-vishalc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EJELElZC c=1 sm=1 tr=0 ts=68f8db71 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=WwcbXC5amFkfT6oAP7YA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX81kAtkH3R2qp
 dfv1JU6hwDp1MmDF9Gi/AV086KIYgjt5Beqe4Lw4fOZhllv9UuAdqjSa5V2zXcOcZ1LJOmAAk6h
 /vmZu/FoOjxmJ3nUSSUv/g0kl2xnrcPDY4CCZEpDPor9JPdN4hmMP5pqgRsbOCiJ+OcDAGnvrvt
 siKFuWnVgCILZV9r1XGMtKblsyWK5STRrCDa9k0UBCMDHD1qcn28ZKK/jAOgpsomCHxVhzbJo9+
 5KkT4ZIdqFSo0cPlv3A/CbuypuBDXIDVzkXsLsLkiUdSQhkYkUfZGTxbn7H2wcGSQV50KVtSk3h
 8oberJkLaVLlDzddPfX+ymU2vGH0/s/NcPGl/PsFepmR0eGgH2sEYCMtY3M4zstoWO873Z9PpQI
 RfaGv+juGF1MqLquxSns9qPV6j+2Lg==
X-Proofpoint-GUID: xgbr7_QugOKlIAEgSH5_OfGgRDuHpAZj
X-Proofpoint-ORIG-GUID: hlamQN6i3-txiJLOJEu7GE7D9cXDhhUj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.156.1; envelope-from=vishalc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


