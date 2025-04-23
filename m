Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9EF1C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 21:46:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7hvG-000687-DK; Wed, 23 Apr 2025 17:46:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1u7huB-0005BM-DL; Wed, 23 Apr 2025 17:45:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1u7hu9-0002me-GP; Wed, 23 Apr 2025 17:45:18 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53NJeRGK025243;
 Wed, 23 Apr 2025 21:45:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=5/BFVyl2dIV23uTjQ
 ps4yRlo0hXjrGLrECnKRja+Ets=; b=Ruz+Ym2QtXETtwAp/vNMdhGiRUmzEZUxo
 Is96m2+UtvGPF3bm/XDhK5b8/aHtoqJPPXIU+q3qbSnS2sEsKQ0LOD3DbddZpVv1
 jLUucHw7zTA53/y/Uwqjgz/LnFIHwTuigcQ1nCJiq38CLOL62K4HamR2VmvJ82CO
 To5XOaHU7FKAG3407KsJ0PcGmUe0WvN/j/kaL39kEECj1jp6n5pyQX523Z//p+4N
 0LFFcu3R6Xq2Wpyz9lzgaxRUDqWquYowWjk9Noccx36w5jD97yrHjbI2ypXFmAWA
 hHWSr7+WbrFzs1c0JkR2XjaHaymK6VPUkHHGg9pALRu4qUi4GZ/rg==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 466x4ju7g1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Apr 2025 21:45:14 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53NIgxFb000925;
 Wed, 23 Apr 2025 21:45:13 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 466jfxw4eg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Apr 2025 21:45:13 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53NLjChQ13894178
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Apr 2025 21:45:12 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 67AB458063;
 Wed, 23 Apr 2025 21:45:12 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3A1A558059;
 Wed, 23 Apr 2025 21:45:11 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.253.34])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 23 Apr 2025 21:45:11 +0000 (GMT)
From: Rorie Reyes <rreyes@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, clg@redhat.com, thuth@redhat.com,
 akrowiak@linux.ibm.com, rreyes@linux.ibm.com
Subject: [PATCH v6 3/7] hw/vfio/ap: store object indicating AP config changed
 in a queue
Date: Wed, 23 Apr 2025 17:45:02 -0400
Message-ID: <20250423214506.72728-4-rreyes@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250423214506.72728-1-rreyes@linux.ibm.com>
References: <20250423214506.72728-1-rreyes@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=eJ4TjGp1 c=1 sm=1 tr=0 ts=68095f6b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=n_lu--N5RhutrOJcQFMA:9
X-Proofpoint-GUID: owfGL3gMpO6sZlwHuromfKakTWdCvlYd
X-Proofpoint-ORIG-GUID: owfGL3gMpO6sZlwHuromfKakTWdCvlYd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDE0NSBTYWx0ZWRfX6mLYJ6z7vMRQ
 ckVETodVUj57BDV7Ahoe5lb4zfTHZ1kqZIiLQ4XH/o8L8ARLGYXu5IetrbJ2z3pauqmMw7tNgUe
 5gXF1Rx/8pXzis6hoKvpQjBnuUMOPcBZXglRqS8fgVBFKKwl6Sw6aZMIdJrd+khNpOJcr6zQnTZ
 cHdlliHR6vyUb47VrMPf3oj4nG+vlRFoZJPbRveUTwZMX5XYpjfH+3TfDJzIzYTt+FOHnX5gSc1
 glys7iBRIjABmIBSuY9xXCaodNsMbAZ9g+2wnI4RCONIyqk9+/AbtVxsb2SK7HWqFwLQiLf38zC
 SfGnt1Oed/z2y1vZA3GOMYU/ZADmPBK+kjH5d0lB/rcUC3wHGOADj3KA7Yt2MwgTSj0zM6N7Lo0
 UWUdTj8a8aa1pWYguTIiba742/c13WRxUPukXjVb7g2QVrd/QXXYIMlpk5pqKEA4BDaA7PW7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-23_12,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015
 bulkscore=0 adultscore=0 mlxscore=0 phishscore=0 priorityscore=1501
 spamscore=0 mlxlogscore=999 suspectscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504230145
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rreyes@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
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
index 3614657218..3fa986ca45 100644
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


