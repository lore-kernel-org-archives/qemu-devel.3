Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26CC3C54ED0
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 16:05:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIUsV-00041p-H0; Fri, 23 May 2025 12:04:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uIUsH-0003tn-2o; Fri, 23 May 2025 12:04:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uIUsD-0002tr-Hc; Fri, 23 May 2025 12:03:56 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54NABuKC025467;
 Fri, 23 May 2025 16:03:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=FoieamDphR6BVN3AY
 Knz1tn0I6TeyjhiF6BeTGsmbaM=; b=VxZjs3QnnCm1bc4whoEnS0lsKY2rwEgIX
 xhagU7CB3BOFUzp4OCrs4cnsOs+dpO7fmZMqcq5au9I+g/lxaDheqyEdR8axFh3h
 qFpziYufWxkIYVBX1ddapw9B/eeiHTjxkApOwh19GoDv1mJzJRJxuncUWIoTwczC
 /4zX0wQFTg5J/WDRv6JWmg7rcCwwCduLEKvBcmZFn/gIzK/FWMy+k6MRd9diNnWq
 CUNPDHUWEipd46uo6u6C4zaILWZg/2XovuCjJtipWuqAJz6m9OkmVpEe30A45rAe
 ZXXPlneXFyxG9Pe/uYofpJSoLGtdMEmooRwK8TIhRFz5tQSJkM4Rg==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46t9j957xv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 May 2025 16:03:43 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54NE2Tpm010613;
 Fri, 23 May 2025 16:03:42 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46rwnmqa4u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 May 2025 16:03:42 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54NG3f2d61538614
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 May 2025 16:03:41 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 082345805E;
 Fri, 23 May 2025 16:03:41 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 484BF58051;
 Fri, 23 May 2025 16:03:40 +0000 (GMT)
Received: from MacBookPro.ibm.com (unknown [9.61.240.236])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 23 May 2025 16:03:40 +0000 (GMT)
From: Rorie Reyes <rreyes@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, clg@redhat.com, thuth@redhat.com,
 akrowiak@linux.ibm.com, rreyes@linux.ibm.com
Subject: [RFC PATCH v11 2/4] hw/vfio/ap: store object indicating AP config
 changed in a queue
Date: Fri, 23 May 2025 12:03:36 -0400
Message-ID: <20250523160338.41896-3-rreyes@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250523160338.41896-1-rreyes@linux.ibm.com>
References: <20250523160338.41896-1-rreyes@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hNNheqgr2PENIihr-ertB-VIOeGY3k3r
X-Authority-Analysis: v=2.4 cv=O6Y5vA9W c=1 sm=1 tr=0 ts=68309c5f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=n_lu--N5RhutrOJcQFMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDE0NSBTYWx0ZWRfXwW6BMtRVtKVo
 jGlQ1yWGS3QOsHDzgcnk+hBH6DhgvKQgUsDvCUKoeaCo4u0q/PcSEqeI3GmYEplI0xCEL+Ejf+N
 rnX1k76P9V3uA1eHSVjiljcWu8YErWTiX7+qpIHvEHfE7xp4UOcxIgcCgSYj6kmCNFdEMd/q0EX
 ajcO4vGdBqnqP7WyVl3Q+4ciHm5SUs0EjQxGT1VaQG0LdxWwy6mfsdws3eBULjlgGSTHM6Ev2Nn
 zdC8wUzNKCjBTCZnBAYU0oTgNqdGWNGz3UesmcnyYCD9qIZZI+9UEJxCdcwRh0GAVAa7N4NXwDR
 DREqkJYIES4fHlvHVBoVqMPfBh/49i7//ANO67DZveHp5z4peDAqUkdnIaLjHMBh/EfSSzEj7h9
 GhAXrxuuCoc62D8zi/UK0r3sVIZGhFLW5JfCBEk3g1O+UlnSVCsfrhRJwLOyH6cwERL+SATS
X-Proofpoint-ORIG-GUID: hNNheqgr2PENIihr-ertB-VIOeGY3k3r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_05,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015
 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505230145
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rreyes@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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


