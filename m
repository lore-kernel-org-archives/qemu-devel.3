Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27EADCCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 19:30:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBeWx-0000qS-DY; Wed, 22 Oct 2025 15:29:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1vBeVw-0008EH-W7; Wed, 22 Oct 2025 15:28:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1vBeVu-0001hH-Lt; Wed, 22 Oct 2025 15:28:52 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MHBJkd030419;
 Wed, 22 Oct 2025 19:28:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=VsPixCQuXr0a3YA1K
 wWnXXRiIgqzlv8MPMc2bZkj0yA=; b=S+vQKdPbJR1YpgofXGctoAQlJMOBcMb20
 5Wd4G0bX5KWb6yttPof0UHnfrn0CCZcDiYqsLCSJqFO44jgMz8amQ/aYGn6mjAB5
 RfItUx1v3b0yN+yEmKgi7X9id1LufUpD5CPWUuPGlglVqwwwoSuwcml8w7qgCt8O
 ulKMTgaWK9M88uL5VoRV3nHbB/Z+AeB3PvMag+YiT/QXgna0IMLSVxJNOBT409/E
 HgFyJAZmBJdIIpxjeg+iXsPBN2Jmwuqn85QK7iEjdgHKYC+YBkVMnbAMi5ujZSX5
 EW5gv5X4bJRclB2bvgSz+q/kQAOSkgPzkbSsZN8aiv3q5NkeGetXg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31cdacp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Oct 2025 19:28:46 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59MJNxRv010495;
 Wed, 22 Oct 2025 19:28:45 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31cdacj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Oct 2025 19:28:45 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59MJKF08014658;
 Wed, 22 Oct 2025 19:28:44 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vn7sacep-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Oct 2025 19:28:44 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59MJSfOD33095976
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Oct 2025 19:28:41 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 23E0720043;
 Wed, 22 Oct 2025 19:28:41 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 671C920040;
 Wed, 22 Oct 2025 19:28:38 +0000 (GMT)
Received: from vishalc-ibm.ibm.com (unknown [9.39.25.30])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 22 Oct 2025 19:28:38 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: adityag@linux.ibm.com, harshpb@linux.ibm.com, milesg@linux.ibm.com,
 npiggin@gmail.com, peter.maydell@linaro.org, alistair23@gmail.com,
 balaton@eik.bme.hu, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 berrange@redhat.com
Cc: Vishal Chourasia <vishalc@linux.ibm.com>
Subject: [Patch v7 4/5] hw/core: Pass errp to load_image_targphys_as()
Date: Thu, 23 Oct 2025 00:57:20 +0530
Message-ID: <20251022192717.1644251-9-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022192717.1644251-1-vishalc@linux.ibm.com>
References: <20251022192717.1644251-1-vishalc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KVCclP0TaxmLJ3R8BY813wJUZX3vyeXS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX0oV3pcWyMzN6
 Xd74fRqB0CEdQgaQOXf6WCrFznBeFIX2WjRsCBl8CRhKc5FZhGW0FFoySckcFUGxszvuQtDCoVV
 JjKkarzOJ9XlbZRDe5ZUN759ad/ixpGUry1TgwFp8duP4qGa97lWj0nC8Pz1Z7bbscLpE6qq1Fs
 eng+Gj4Sbm94/xjdZ8oOHz76LjIsnWtTMkqmVgRrVRo15NU+JIHFZ0GvepN3P5UF8lhbFCnq7PZ
 xFZpwX83xN9TvlrHgydTOjRRyPWNXLp+6WT0rnEEpNiQp7CM5JTzDHL8s22nCp161VPNbDI1BsD
 tgVdK0SF12vhXjG5REESIczxu3nc/ofhfd1chJGWCWtx4uqUcbiGKqsLkuG9v/1BuyF1zMTuf0+
 gZqliiDxNI58ydr+oD5TFqiUGI9+/g==
X-Proofpoint-GUID: XsPPg0riW7_-6zuMtgGC6lj5AQ1QOlV_
X-Authority-Analysis: v=2.4 cv=SKNPlevH c=1 sm=1 tr=0 ts=68f9306e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=WwcbXC5amFkfT6oAP7YA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.158.5; envelope-from=vishalc@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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


