Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EB01C3ABC3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 16:38:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDQin-0002Bf-Uy; Fri, 09 May 2025 12:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uDQiW-00024g-KH; Fri, 09 May 2025 12:37:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uDQiU-0000CK-Jg; Fri, 09 May 2025 12:36:56 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 549AfNhc005310;
 Fri, 9 May 2025 16:36:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Aj6kFQ0EZN1GrkhPI
 HMJguSCyL4T1m3bwc+M2lQyeCU=; b=PIzfcJBuvIlsVntKkb8CexSwCOZvaFbir
 RGWi8dNOn/RUNeg04mbDBzA+0QgpbrUEeJXNnscKtAl8QzEzcYfVz2v2fjp+03iH
 1WjLzlF9fqoUIwlrZUTlXizzIi2501kZRCHDqJ5k+Wm2PQSIvkaizckIdhICDvxa
 tWIMjlLf2qStITihFQucFV0gmBsIjxckIEqt1J8Ubu3c3FP2EykIr58yLACP6BXs
 4IifgS9Q7yBj/3bWCZTspoePcdnJiuZZXXAx+aTUuAK0j/Nh/LOiV5zmvFiIhaqi
 NzIkKkT6PG7Yfpzs9/g5OIABE8sq80TdhfQYRLHj9f4w0yn+QVImA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46hg5shv0u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 May 2025 16:36:51 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 549EEM7P014082;
 Fri, 9 May 2025 16:36:50 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 46dypm46y5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 May 2025 16:36:50 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 549GaoHl19595858
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 9 May 2025 16:36:50 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EAF085805E;
 Fri,  9 May 2025 16:36:49 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 254A858043;
 Fri,  9 May 2025 16:36:49 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.241.92])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  9 May 2025 16:36:49 +0000 (GMT)
From: Rorie Reyes <rreyes@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, clg@redhat.com, thuth@redhat.com,
 akrowiak@linux.ibm.com, rreyes@linux.ibm.com
Subject: [RFC PATCH v8 4/6] hw/vfio/ap: store object indicating AP config
 changed in a queue
Date: Fri,  9 May 2025 12:36:43 -0400
Message-ID: <20250509163645.33050-5-rreyes@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250509163645.33050-1-rreyes@linux.ibm.com>
References: <20250509163645.33050-1-rreyes@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TwpVLMIkrk_a0yVl59kEHh0JvutETFhb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDE2NCBTYWx0ZWRfXzOKhSzy1/OfZ
 bokLISAn8iAP2hI9fH6/73SusuxDnJ6FK8wTCF/asMMWw3jW/sV0OcCs1rFBQI29NQRqPeyRmGb
 bM/l7NvVtbhKCaBdRAaOZCwwX4nsWgrTZrlpiMb6AxmXWKRc1cMWW90XYVqpjynJOPLsAiuApYs
 +e5/3SYPJ7Wc1i1o+J+AQ6EiAkZara12YcrFAEQ+8MIudSg9ZN8uHf4+BVoyCEpJnpw4t7rOF4t
 s0L3cH74Ve72yJ+IwYCxE5QMRui5yZE2cgN5UTG1g4aFh2LyRE7YO0ofpYAiGGgGZwV9GfAz/ix
 g369m/hhZpgYB/SebMoKULpvmav2pfJaGEn3K1W7mwGEhybxJhY8b1FD+xY054Vqa7QvX241UCf
 IT8tVXFepBGW1A+aeaasSatr1Ido5V/LJih1REQz1k1ZZ/pRl8T/gYG0CYNALi0n6xn30DoF
X-Proofpoint-ORIG-GUID: TwpVLMIkrk_a0yVl59kEHh0JvutETFhb
X-Authority-Analysis: v=2.4 cv=NrjRc9dJ c=1 sm=1 tr=0 ts=681e2f23 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=n_lu--N5RhutrOJcQFMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_06,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 phishscore=0 adultscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505090164
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rreyes@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Creates an object indicating that an AP configuration change event
has been received and stores it in a queue. These objects will later
be used to store event information for an AP configuration change
when the CHSC instruction is intercepted.

Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>
---
 hw/vfio/ap.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 3d0af7a54a..5ea5dd9cca 100644
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


