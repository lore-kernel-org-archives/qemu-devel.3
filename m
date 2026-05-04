Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1703DFF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 14:00:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJtqF-0004tg-TS; Mon, 04 May 2026 10:00:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <karolina.stolarek@oracle.com>)
 id 1wJtqD-0004rx-DN
 for qemu-devel@nongnu.org; Mon, 04 May 2026 10:00:09 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <karolina.stolarek@oracle.com>)
 id 1wJtqB-0002Jk-L3
 for qemu-devel@nongnu.org; Mon, 04 May 2026 10:00:09 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6448fcdr205214; Mon, 4 May 2026 14:00:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=iAIqv
 wpk94ahFSpRlKvUgQewX7PMm5ZhfDLvN1lniiU=; b=PXMjxPSFDLPlXC5ro7E37
 cD6DgG0VjfPjGVUt2iCH7xhTteU40Fxce+oPBec7FHxwvwU4lvmgam6p39Llz/Br
 9BGMUVXper3Dtmb9PLb6Ifz48lAm9WpsLfeiOetOhrkjGezSFPKjVdKfAFrz/N7B
 p9H4lNjwVfOudvJc3tGd73a9hTHwYiRz5FgeekUjVTB85gt3ceGe+uUgV5VMSg6+
 X6ud8q1q1M4ORIBOfS5zDlzNYX3fpB6A1/kPEQUC2thHeHrre6sEAJxhM6kgy3lt
 3ESvf3Tr2/qJbybKy+lRYgZxBJpZ7zu921REYLG5bplbahGcqw46USfkAhqbkZvy
 Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dw9tqtpd0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 May 2026 14:00:03 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 644DuT5m014323; Mon, 4 May 2026 14:00:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4dx5adk997-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 May 2026 14:00:02 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 644Dxvoi027094;
 Mon, 4 May 2026 14:00:02 GMT
Received: from kstolare-e5-ol8.osdevelopmeniad.oraclevcn.com
 (kstolare-e5-ol8.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.20])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4dx5adk954-4; Mon, 04 May 2026 14:00:01 +0000 (GMT)
From: Karolina Stolarek <karolina.stolarek@oracle.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>,
 Karolina Stolarek <karolina.stolarek@oracle.com>
Subject: [PATCH 3/5] virtio-scsi: Use errp in virtio_scsi_device_realize
Date: Mon,  4 May 2026 13:59:42 +0000
Message-ID: <0de3b571e0e47e83d5c9c9a42bd8521388844361.1777890280.git.karolina.stolarek@oracle.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1777890280.git.karolina.stolarek@oracle.com>
References: <cover.1777890280.git.karolina.stolarek@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0
 phishscore=0 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604200000 definitions=main-2605040145
X-Proofpoint-GUID: p2bCUZN-3_WEZFNgwrp9wlwRVTMvaUs8
X-Proofpoint-ORIG-GUID: p2bCUZN-3_WEZFNgwrp9wlwRVTMvaUs8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDE0NSBTYWx0ZWRfXzND3BQTAKzhi
 yKHWej9Mod6wxvg7HB6rDpz35nsccrd2ixSWaIV+KXhCMRJCYVfvyeSJQvJ0b2B78ar0rCs5oFu
 1Z3vVWPKEUBUx1mMj05CjnCe6V1XBXPH0EmLPVQiD3zh3SICmiELuhhAVLqpSdR/88Q0duNnZ19
 7UCs0RIHnH8igtEaq4Uo3fjrZ6YZy5NXMs2lvGcx0T+rFvyCrKp5W+krZXojws7xFm8AebGBW8c
 HwAAkQ1dZL5qwKuogELOuFEscAPoxlie3/01H4lLGkLtVxzLRZrGVZkVV8E+4ZnyHw45TzlxNrl
 TeMVH3u1jHTV9NQwzRXpDsnvKXnQWwNKub/bl3IyzyuIx+773MQB1RXXETXKdiTVnVka/15wEfi
 j7BQ1HldwT3Yf2Q38L5+en9KriTZ1xeOQR+E7HU+yVuQUfWN/a4S39O4stYIq1MUnoZg7GXAPia
 DdBvVqeKZX50HQGWa4ggZbb2z6826ruVBbsEnduA=
X-Authority-Analysis: v=2.4 cv=Os9/DS/t c=1 sm=1 tr=0 ts=69f8a663 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8 a=TquScrhIGmC-FQZoO0cA:9 cc=ntf
 awl=host:12306
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=karolina.stolarek@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Move away from using a local Error variable and check
errp to decide if the function has to return early.

Signed-off-by: Karolina Stolarek <karolina.stolarek@oracle.com>
---
 hw/scsi/virtio-scsi.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 8d2811d7fb..f9e4f6fc02 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -1328,18 +1328,19 @@ static void virtio_scsi_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIOSCSI *s = VIRTIO_SCSI(dev);
-    Error *err = NULL;
 
     qemu_mutex_init(&s->ctrl_lock);
     qemu_mutex_init(&s->event_lock);
 
+    ERRP_GUARD();
     virtio_scsi_common_realize(dev,
                                virtio_scsi_handle_ctrl,
                                virtio_scsi_handle_event,
                                virtio_scsi_handle_cmd,
-                               &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+                               errp);
+
+    if (*errp) {
+        /* don't initialize the bus, terminate early */
         return;
     }
 
-- 
2.47.1


