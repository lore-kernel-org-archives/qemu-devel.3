Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50324CCD1A2
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 17:39:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Rva-0005zx-ON; Thu, 16 Oct 2025 13:38:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1v9RvV-0005qI-8l; Thu, 16 Oct 2025 13:38:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1v9RvP-0007Wk-Rz; Thu, 16 Oct 2025 13:38:08 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GCT882001281;
 Thu, 16 Oct 2025 17:37:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Pd8abb14oKFstc5vx
 gLC0VDWMO/xweb9p+GtmIPBadM=; b=RBT5MLhbXou/+bjqf1lma2UIkjcdrpmCf
 4RwBweY4XK6lwTzLmQvjfBrfCpUKKvAD0rPtOrSKN45j7GLshP3r/rBtKnA4JPRR
 yMe8j+DGDmJ8ijkAdvY+no1ZSTBXqLit8/9GV3Lgmy49SUAPtQQMkwRXxixyHO2O
 StrdmQ77QO6TLysEl4+rAj8kAUKV0vnIvXQjBzkugjr+LLw7ZXg5Xes56EO52W+g
 6xuYreRbuvGhkC5VvjRkGDA/hI21XlFV4CYR+TMySXSPdZIPampso/Db7I7Elt5b
 3zx+9Hv+SG5D/eDPcbWn3yMmpTDKJytMTNerXu/rYWeJqciSdo+DA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49rfp875ua-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Oct 2025 17:37:51 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59GHYuvg004189;
 Thu, 16 Oct 2025 17:37:51 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49rfp875u4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Oct 2025 17:37:51 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59GGkXwf003663;
 Thu, 16 Oct 2025 17:37:49 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r1xy74c2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Oct 2025 17:37:49 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59GHbjRi18547018
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Oct 2025 17:37:45 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BCC32200E0;
 Thu, 16 Oct 2025 17:37:45 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0245B200DA;
 Thu, 16 Oct 2025 17:37:43 +0000 (GMT)
Received: from vishalc-ibm.ibm.com (unknown [9.39.26.252])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 Oct 2025 17:37:42 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: adityag@linux.ibm.com, harshpb@linux.ibm.com, milesg@linux.ibm.com,
 npiggin@gmail.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, berrange@redhat.com, alistair@alistair23.me,
 alex.bennee@linaro.org
Cc: Vishal Chourasia <vishalc@linux.ibm.com>
Subject: [PATCH 3/5] hw/core: Pass errp to load_image_targphys_as()
Date: Thu, 16 Oct 2025 23:05:01 +0530
Message-ID: <20251016173502.1261674-6-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016173502.1261674-1-vishalc@linux.ibm.com>
References: <20251016173502.1261674-1-vishalc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LXVY6J1pbjzhnvtAE8hoph5qKryLcY9Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEyMDA4NCBTYWx0ZWRfXxmVL2wmOiYk1
 dSshTyL1E2cT34iNMZacpdjN8uh1IMXHz5lqeKuk8vUK96gtXZAYqtdnejSnqqttu6aohKSfc52
 Pa+VtHyMJASQhUQLkc9V/I8LWBnXWfNZXsJ87hM+VIZoyALrvyEGZK6/RBIXUT5c/chrlh2Te/T
 NIb9/1Lprqb98TUPb7eYWC+Meh28yp8Zk8T/HUWGwF2AGHsn/iDbwfbOdse8hyeZZr4xgWb07Nl
 Jr5/QcfHqF1Q5FR4zo9tHON5euFtqYtV35iYw/us+dZDUGNGVo2sdbxaf8Z8ENqeGcwrcWcZ0L+
 pKu6GHOLygjQI2GgTaSHVmoPmUf0bcV/7rVbY78TOWiGXSFIB9c4yEzUJkzEdj3NRM8lMz5kJdT
 A6HsTQO7MpJ0almcQvemvugcuQOTEg==
X-Proofpoint-GUID: JqiFrQS4duCzoW7Ab0uDuQQb1V-UJ52K
X-Authority-Analysis: v=2.4 cv=af5sXBot c=1 sm=1 tr=0 ts=68f12d6f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=9QQsejfFni1f41aiRA8A:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510120084
Received-SPF: pass client-ip=148.163.156.1; envelope-from=vishalc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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
 hw/core/generic-loader.c | 4 ++--
 hw/core/guest-loader.c   | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
index 6689847c33..433efb7387 100644
--- a/hw/core/generic-loader.c
+++ b/hw/core/generic-loader.c
@@ -149,13 +149,13 @@ static void generic_loader_realize(DeviceState *dev, Error **errp)
         if (size < 0 || s->force_raw) {
             /* Default to the maximum size being the machine's ram size */
             size = load_image_targphys_as(s->file, s->addr,
-                    current_machine->ram_size, as, NULL);
+                    current_machine->ram_size, as, errp);
         } else {
             s->addr = entry;
         }
 
         if (size < 0) {
-            error_setg(errp, "Cannot load specified image %s", s->file);
+            error_prepend(errp, "Cannot load specified image %s: ", s->file);
             return;
         }
     }
diff --git a/hw/core/guest-loader.c b/hw/core/guest-loader.c
index 59f325ad9c..618455e556 100644
--- a/hw/core/guest-loader.c
+++ b/hw/core/guest-loader.c
@@ -101,9 +101,9 @@ static void guest_loader_realize(DeviceState *dev, Error **errp)
 
     /* Default to the maximum size being the machine's ram size */
     size = load_image_targphys_as(file, s->addr, current_machine->ram_size,
-                                  NULL, NULL);
+                                  NULL, errp);
     if (size < 0) {
-        error_setg(errp, "Cannot load specified image %s", file);
+        error_prepend(errp, "Cannot load specified image %s: ", file);
         return;
     }
 
-- 
2.51.0


