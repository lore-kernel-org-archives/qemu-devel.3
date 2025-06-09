Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E8ABC5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 16:45:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOfc5-000240-SJ; Mon, 09 Jun 2025 12:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uOfbq-0001zY-El; Mon, 09 Jun 2025 12:44:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uOfbn-0003fi-Kg; Mon, 09 Jun 2025 12:44:30 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 559BTWOM020816;
 Mon, 9 Jun 2025 16:44:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=xJNPME4K4eUs1Wc/O
 VQFMYPPwja4yEUxcYLcrB16Ajk=; b=JCgID8Sh1hnuWJDEOu3TnOrBxdB5IzrwP
 yuBqzk1/8efM4AlFuSqIDq9NiFO1PaSSpPkZ4i8EXMJNVzEihv0VwWji8ijcqWwa
 8IGWec1arrITOYr87o1Dea/q5vgPx/rBb/28qVpvewYHvfM+uR9p/VEmyP2Dhx1u
 l2fPiNlzQEonrOAG3ydWbDg7yKAYt3Z5CAYd1KfyoScGWbq6WRwZBK051Mr1+3Z7
 oBwMMdnRnOzJulTrCMXkj9Ui37eDuNr/PbsCqB5/qIB/UDlojYieqGURwkj5wD6k
 g3urCeMxt9zSm2UB3wqg2/zRcdCrwHkAU+xA5QHnfV0We/GMDoGqg==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474bunste1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Jun 2025 16:44:25 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 559EECVC021879;
 Mon, 9 Jun 2025 16:44:24 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47504yppvt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Jun 2025 16:44:24 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 559GiNbc29229692
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Jun 2025 16:44:23 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 71D225805A;
 Mon,  9 Jun 2025 16:44:23 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 37DCC58054;
 Mon,  9 Jun 2025 16:44:22 +0000 (GMT)
Received: from MacBookPro.ibm.com (unknown [9.61.253.10])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Jun 2025 16:44:22 +0000 (GMT)
From: Rorie Reyes <rreyes@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, clg@redhat.com, thuth@redhat.com,
 akrowiak@linux.ibm.com, rreyes@linux.ibm.com
Subject: [RFC PATCH v13 2/4] hw/vfio/ap: store object indicating AP config
 changed in a queue
Date: Mon,  9 Jun 2025 12:44:16 -0400
Message-ID: <20250609164418.17585-3-rreyes@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250609164418.17585-1-rreyes@linux.ibm.com>
References: <20250609164418.17585-1-rreyes@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=H4Hbw/Yi c=1 sm=1 tr=0 ts=68470f69 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=n_lu--N5RhutrOJcQFMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDEyMSBTYWx0ZWRfX/JDFzmqruMul
 YXvSWnHST4v26tyASF+zONyeV/E/n4oKOp9g0AMqHZcL8lkWqbOO9CogOJQKgR9oNo1JSWFXA7n
 J0j54ajOTySxxoZK72RH9xAa1NQ/tuZyBQ7dZVlRYtXWPvXtR8nTyNrOWZi+X0sL02dIMKyxYQQ
 yRNBCVJNtYCD810teII4erEur2QxgPe8U2S/9GMdGV8MXAHRctJ2rIIEcmtVo8B5iVn586wlHRQ
 8MWmbyA+RbjMljPfo5hjQQTZKk/HiMZjk80ilP1ScEBI8CYt8oUd6EVdIOT9PdAsJXNRoAhs4UR
 EAGpV5Hfmj6E+o+o3k5OQnEDLZ+rP3EYKgLKB2q05kvIBQXna8+noOxUR5kk4MC+f4SXSXnrBv9
 6d+uf3DKCThXJ6ttUa4ThrfGNu9bz4FGQSEkFwuCDpkNL7grtDmeUgRBUFGuH0Yo5K74s5SA
X-Proofpoint-GUID: SpXkZsJCwSL6BglDdvnVIGyxIpPbUwWq
X-Proofpoint-ORIG-GUID: SpXkZsJCwSL6BglDdvnVIGyxIpPbUwWq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_06,2025-06-09_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 mlxlogscore=999 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506090121
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rreyes@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Creates an object indicating that an AP configuration change event
has been received and stores it in a queue. These objects will later
be used to store event information for an AP configuration change
when the CHSC instruction is intercepted.

Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>
Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 hw/vfio/ap.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 93c74ebedb..681fd4a4f1 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -21,6 +21,7 @@
 #include "hw/s390x/css.h"
 #include "qemu/error-report.h"
 #include "qemu/event_notifier.h"
+#include "qemu/lockable.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
@@ -41,6 +42,15 @@ struct VFIOAPDevice {
     EventNotifier cfg_notifier;
 };
 
+typedef struct APConfigChgEvent {
+    QTAILQ_ENTRY(APConfigChgEvent) next;
+} APConfigChgEvent;
+
+static QTAILQ_HEAD(, APConfigChgEvent) cfg_chg_events =
+    QTAILQ_HEAD_INITIALIZER(cfg_chg_events);
+
+static QemuMutex cfg_chg_events_lock;
+
 OBJECT_DECLARE_SIMPLE_TYPE(VFIOAPDevice, VFIO_AP_DEVICE)
 
 static void vfio_ap_compute_needs_reset(VFIODevice *vdev)
@@ -74,12 +84,19 @@ static void vfio_ap_req_notifier_handler(void *opaque)
 
 static void vfio_ap_cfg_chg_notifier_handler(void *opaque)
 {
+    APConfigChgEvent *cfg_chg_event;
     VFIOAPDevice *vapdev = opaque;
 
     if (!event_notifier_test_and_clear(&vapdev->cfg_notifier)) {
         return;
     }
 
+    cfg_chg_event = g_new0(APConfigChgEvent, 1);
+
+    WITH_QEMU_LOCK_GUARD(&cfg_chg_events_lock) {
+        QTAILQ_INSERT_TAIL(&cfg_chg_events, cfg_chg_event, next);
+    }
+
     css_generate_css_crws(0);
 
 }
-- 
2.48.1


