Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C1E5C61CE7
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 18:39:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNbwl-0004HK-FP; Fri, 06 Jun 2025 14:37:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uNbwX-0004Ef-O5; Fri, 06 Jun 2025 14:37:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uNbwS-0008J3-Iy; Fri, 06 Jun 2025 14:37:29 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 556ET4bI011178;
 Fri, 6 Jun 2025 18:37:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=FoieamDphR6BVN3AY
 Knz1tn0I6TeyjhiF6BeTGsmbaM=; b=b/hI5I4Hn26btWSeM+d+odWmZHHWaLs/H
 NliEO7vtpJuVSByYmE0wP68OeiO6uBslIciO5jmTDrD7vE72bEvLyi/2W+ZH7kTD
 YRffOgnGpnZQNUBGLFFuYK86gYwXlLVy/s63FpOqF+2BkFChO0wiUfa/1YbGRlHK
 3JyydKWHj8BH41Jj11NAGd5JJoTP3p09AOwUcCppQmmI3auH0symTbcQMxOtS1C1
 EUo9rXXs/rrCsFQ0mxmDXLzF6aOxwLiEv4MBIjmhXuXwriHhGSuIMH9XU2OnjpD7
 g1NDI+RjEokveRqGPHJPvOces3FohNo53vQT3IEA/0EHVyTjBaqyQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 471gf07t9v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Jun 2025 18:37:23 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 556GJpgk028452;
 Fri, 6 Jun 2025 18:37:22 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 470eakthwh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Jun 2025 18:37:22 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 556IbKk429426300
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 6 Jun 2025 18:37:20 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 808AE58043;
 Fri,  6 Jun 2025 18:37:20 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5987258059;
 Fri,  6 Jun 2025 18:37:19 +0000 (GMT)
Received: from MacBookPro.ibm.com (unknown [9.61.255.166])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  6 Jun 2025 18:37:19 +0000 (GMT)
From: Rorie Reyes <rreyes@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, clg@redhat.com, thuth@redhat.com,
 akrowiak@linux.ibm.com, rreyes@linux.ibm.com
Subject: [RFC PATCH v12 2/4] hw/vfio/ap: store object indicating AP config
 changed in a queue
Date: Fri,  6 Jun 2025 14:37:14 -0400
Message-ID: <20250606183716.26152-3-rreyes@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250606183716.26152-1-rreyes@linux.ibm.com>
References: <20250606183716.26152-1-rreyes@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: m7aC5jCkwrFIHPFgw11kiYaOORmbIsX-
X-Proofpoint-ORIG-GUID: m7aC5jCkwrFIHPFgw11kiYaOORmbIsX-
X-Authority-Analysis: v=2.4 cv=X4dSKHTe c=1 sm=1 tr=0 ts=68433563 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=n_lu--N5RhutrOJcQFMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDE1OSBTYWx0ZWRfX4GCPR7ef39gU
 bM9TpmtzQ42y1LqOyECrwZdSdEIP36clT9r3hZgSe/h/IgKQhdHZKbbKAtOJ4UOYFZFXneu0xaH
 TwxlmxxQV9Jbwa6uyjmC/2pgMQYU9k9pEFbqiKX7R/qIFcNBBXZ0jzJknUcS948RD+ceUJ/Mt+c
 S/KIU62uAs+CH+zsnjYXu+Dkb91cfjUjnp8kMaIBB+URfiHoeo/I/l1DpfHYiwnhaEtGegV3bwQ
 aCNjhvnNpVlQq2im+HQGOSitLOQ2ueaP2/sYvwWckZFvuHQaGXlu2biQtEsAPqVWogvOYsRgGuB
 Moq0/RiJ/WTCjgDIUmNRszuqpMOOrQAnksx8f4oX+sJuGDLYg3Y6fMNTi2aYdFH9gGgtE+fBbRG
 lzrvgXll3cfROBqOj94eFuE0YB730+UPzHc2Vz0ozgleg4vAjHRPew7UNLSizr11pmjZ8pXA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-06_07,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 clxscore=1015 phishscore=0 bulkscore=0
 malwarescore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506060159
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rreyes@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
---
 hw/vfio/ap.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 93c74ebedb..fc435f5c5b 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -41,6 +41,13 @@ struct VFIOAPDevice {
     EventNotifier cfg_notifier;
 };
 
+typedef struct APConfigChgEvent {
+    QTAILQ_ENTRY(APConfigChgEvent) next;
+} APConfigChgEvent;
+
+static QTAILQ_HEAD(, APConfigChgEvent) cfg_chg_events =
+    QTAILQ_HEAD_INITIALIZER(cfg_chg_events);
+
 OBJECT_DECLARE_SIMPLE_TYPE(VFIOAPDevice, VFIO_AP_DEVICE)
 
 static void vfio_ap_compute_needs_reset(VFIODevice *vdev)
@@ -74,12 +81,17 @@ static void vfio_ap_req_notifier_handler(void *opaque)
 
 static void vfio_ap_cfg_chg_notifier_handler(void *opaque)
 {
+    APConfigChgEvent *cfg_chg_event;
     VFIOAPDevice *vapdev = opaque;
 
     if (!event_notifier_test_and_clear(&vapdev->cfg_notifier)) {
         return;
     }
 
+    cfg_chg_event = g_new0(APConfigChgEvent, 1);
+
+    QTAILQ_INSERT_TAIL(&cfg_chg_events, cfg_chg_event, next);
+
     css_generate_css_crws(0);
 
 }
-- 
2.48.1


