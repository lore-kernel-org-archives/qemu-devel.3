Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC1CAC02198
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 17:08:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfMPJ-0004eM-4G; Tue, 04 Feb 2025 12:08:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1tfMPC-0004b5-Eb; Tue, 04 Feb 2025 12:08:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1tfMPA-0007Ny-Ro; Tue, 04 Feb 2025 12:08:10 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514GEnFr010739;
 Tue, 4 Feb 2025 17:08:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=bNzYzpaGa4HVQjxIG
 O0SCMx+GykusmFjflUjmi8fQec=; b=c8zHt5SVGy6Y2xYk2q7b1LXIO7X2/054Q
 V61ldJmCLLbSgO+qaOpqiVROpb6tUliyZMOX60vCJgvwB/g+745u60AGHz/d4DP+
 rit96bokUwga8AbiS+wBtUg9QGhaMB8kh2qpgf4UNNPf0qf7a7akxk1p7hdW3ukb
 SQ0IphBv/7H0DBmGvKtW8cnO6R2a7RLxXy6A95AO0EJ+V/Qn75cXnHLXLKR1IdQT
 I5YPFPIZrsv3xDR8Tq3fb6V1hAyMN00CO7yj3YHKyjTaraLHy0ommtgdfVwGfMUS
 YIthdevS/d2Zjou8/jTustcF5aA5cOZz+TnPIUoYuojRSbRHML8Iw==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44k9r0uusr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Feb 2025 17:08:07 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 514Gk6vA005266;
 Tue, 4 Feb 2025 17:08:06 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44j05jv9vw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Feb 2025 17:08:06 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 514H85Ia28770918
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 4 Feb 2025 17:08:05 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 38A435805F;
 Tue,  4 Feb 2025 17:08:05 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1BA8458043;
 Tue,  4 Feb 2025 17:08:04 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.255.239])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  4 Feb 2025 17:08:03 +0000 (GMT)
From: Rorie Reyes <rreyes@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, clg@redhat.com, thuth@redhat.com,
 akrowiak@linux.ibm.com
Subject: [RFC PATCH v2 3/5] hw/vfio/ap: store object indicating AP config
 changed in a queue
Date: Tue,  4 Feb 2025 12:07:57 -0500
Message-Id: <20250204170759.36540-4-rreyes@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250204170759.36540-1-rreyes@linux.ibm.com>
References: <20250204170759.36540-1-rreyes@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UTtmRB5gPAJ9b4uTj0LH5jotkorSxkJD
X-Proofpoint-GUID: UTtmRB5gPAJ9b4uTj0LH5jotkorSxkJD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_08,2025-02-04_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0
 clxscore=1015 adultscore=0 spamscore=0 mlxscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040131
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rreyes@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 hw/vfio/ap.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index a2b3735349..396fcf87de 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -41,6 +41,13 @@ struct VFIOAPDevice {
     EventNotifier cfg_notifier;
 };
 
+typedef struct APConfigChgEvent {
+    QTAILQ_ENTRY(APConfigChgEvent) next;
+} APConfigChgEvent;
+
+QTAILQ_HEAD(, APConfigChgEvent) cfg_chg_events =
+    QTAILQ_HEAD_INITIALIZER(cfg_chg_events);
+
 OBJECT_DECLARE_SIMPLE_TYPE(VFIOAPDevice, VFIO_AP_DEVICE)
 
 static void vfio_ap_compute_needs_reset(VFIODevice *vdev)
@@ -75,11 +82,16 @@ static void vfio_ap_req_notifier_handler(void *opaque)
 static void vfio_ap_cfg_chg_notifier_handler(void *opaque)
 {
     VFIOAPDevice *vapdev = opaque;
+    APConfigChgEvent *cfg_chg_event = g_new0(APConfigChgEvent, 1);
 
     if (!event_notifier_test_and_clear(&vapdev->cfg_notifier)) {
-        css_generate_css_crws(0);
+        return;
     }
 
+    QTAILQ_INSERT_TAIL(&cfg_chg_events, cfg_chg_event, next);
+
+    css_generate_css_crws(0);
+
 }
 
 static bool vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
-- 
2.39.5 (Apple Git-154)


