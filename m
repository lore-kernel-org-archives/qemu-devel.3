Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DBD6CA5FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 15:26:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBwAb-0008Fn-Gn; Wed, 30 Sep 2026 11:24:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xBwAX-00089w-D1; Wed, 30 Sep 2026 11:24:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xBwAV-0001z9-KB; Wed, 30 Sep 2026 11:24:29 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UE5NIr3203128; Wed, 30 Sep 2026 15:24:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=tXKNRgTTq7jtJMm/M
 r6igQPo0Bq+NyCO+YrZawOK9jc=; b=FZQGyp4Yt3sM/zvGBkPGbC2G4kBXp13nx
 D92bViHFqq2wRBipnkMlvsQY8pdIz+xcfntDq4sP7CKrC17ZrhGKLpy1ZOtGyyJC
 1lS5cswakOPFSBDbD8vGY++cZignnUMem04Yb1qWAktW2JDA9ylsgpGYxlrpgeED
 XUXqrz+42pQpuNaYpMCD/MHXxKzFK+urIIwZHdlGkky0YSEX46uA0NLHDTeeZiEI
 Yn/zqzSiMFuwbX7M8t1XKcY6ou2nHLrYguvl9JLE4FjTY8MkwZytExwicXIKagT5
 bWxbP/vl99M4zND09Ldv503HqOqDg6A5G44jbTOWC0+QzmWwTKm/g==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5j5dyjr-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 15:24:25 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UE34AD3605823; Wed, 30 Sep 2026 15:24:24 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxsvhq2ew-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 15:24:24 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68UFONeA17695364
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Sep 2026 15:24:23 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 457555805A;
 Wed, 30 Sep 2026 15:24:23 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CE0FF5805F;
 Wed, 30 Sep 2026 15:24:22 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.5.156]) by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 30 Sep 2026 15:24:22 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 qemu-stable@nongnu.org
Subject: [PULL 03/23] virtio-ccw: Fix rc check in read configuration path
Date: Wed, 30 Sep 2026 11:24:00 -0400
Message-ID: <20260930152420.1956230-4-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930152420.1956230-1-farman@linux.ibm.com>
References: <20260930152420.1956230-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA2MCBTYWx0ZWRfX0h+Zcsldd2H5
 RXzzjRlWpzVo2z5npbrFSE4Lq9qVNgAZkPrJR7LQTPscpTx2YOMd6I1TFh0xcO4NIIe0RQndM7H
 FZTLr2vxywtbgCNMZk67r4hi4tlSI9A=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA2MCBTYWx0ZWRfX5wFGrSgJBnX2
 Qe4DZXY8Vo5HmlkPttSpMKyyoc6fGzHb4U9weUoJryCPK02Ooisv0BIL8iS1m/sizWkkLOSkG+7
 +7vUXNquD/1iVMu48Esz6ZVGOxBvjsVx5QDbDXm/YjYe9IRFzAeESGV57iTjpPVa1pAbUAamlOg
 3YMR8387KgMtAO8jdeS7Sf12IUT/PMU3q4e2rhobzLix9gtWVztVN7Vit+XZ465wA4AjDxMhwWP
 jDgGnMNFprRCuKkbxH55jx43HsnmS4pd180VcxD2iG2AimJc4D7BYWjtt9TwUXRr4KWXYxcVl2e
 n3/RAl9nwbuco5ylOXMKoMRfPaFRkvzRIxEmquwJpYsyw2a3BXzAqNbomBYiU0RMN0zF4CyREc2
 YUBaUyOTDTGWNCqGubX4KNfrAymj3vrvFr367Bcz/6tP9Btzyr+4ssQ8h2LSuyA4vAjtm0zTo4Y
 zeCa6KL8qiZInAMbQ6g==
X-Proofpoint-GUID: 53vPhlCWXERcKELjfLD0fvDBMMB7KCGV
X-Authority-Analysis: v=2.4 cv=RKcmjIi+ c=1 sm=1 tr=0 ts=6abd29a9 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8
 a=uiMiztMkydEs4ieJCJEA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: 53vPhlCWXERcKELjfLD0fvDBMMB7KCGV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300060
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Both the read and write config paths use wrappers around cds->op_handler,
depending on the direction the I/O is flowing. But they expect opposite
values in the returned variable to indicate success.

Fix this by unifying those checks, where CCW_CMD_READ_CONF needs to
see !ret as success. The end result is some erroneous data in the
SCSW response data, but the overall success/failure is correct.

Cc: qemu-stable@nongnu.org
Fixes: d895d25ae2 ("s390x: css: report errors from ccw_dstream_read/write")
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260922201526.2383047-4-farman@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 hw/s390x/virtio-ccw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index f46f936150..11441e56c1 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -475,7 +475,7 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
         } else {
             virtio_bus_get_vdev_config(&dev->bus, vdev->config);
             ret = ccw_dstream_write_buf(&sch->cds, vdev->config, len);
-            if (ret) {
+            if (!ret) {
                 sch->curr_status.scsw.count = ccw.count - len;
             }
         }
-- 
2.55.0


