Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52CEAD3409C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 16:19:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vklkI-000444-Ia; Tue, 27 Jan 2026 11:16:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vkljb-0003Yl-Ad; Tue, 27 Jan 2026 11:16:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vkljX-0000jy-Hc; Tue, 27 Jan 2026 11:16:07 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60R84DAm015187;
 Tue, 27 Jan 2026 16:15:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=tYoHcrVKQlbXUv0+S
 vce9bCCtTr9LoEegtEri++n/kc=; b=MSH0i+FMt+BMLzbhoJ0zh/lpXQp/YQUsE
 cCmqafXGMTv0O/blkghmGR2AzfWkByrlT6+O9/FCVbQwu1y+wCfwUQTjdSYlQJXW
 AMXxy419jHJWWgFc+h4ssIpY3WA7sChKa2z85PsfYZliBxuGRDbg94DQWXVXHYgH
 dG+6G92I4ChhjOjNlqZR8L2fxWNnKY4pWK4jnOZ9iW/WLXVAmvdLKtpIQDtPNJw6
 x7BiszHoiW5tc7zHtCu7IwWp63ZwxAF7Q5cygqsspgJ7M/g6/v1W/+AMEZ1d907k
 P57B1EtXGG3e1oaieOYaeOUeoc+hMCES1t2Gyja0dOggbUSqr3SOQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnt7pcxg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jan 2026 16:15:57 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60RD0r0o006737;
 Tue, 27 Jan 2026 16:15:56 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bw8sy9e2n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jan 2026 16:15:55 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60RGFsIm18678372
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Jan 2026 16:15:54 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 366E258064;
 Tue, 27 Jan 2026 16:15:54 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 154305805D;
 Tue, 27 Jan 2026 16:15:53 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.94.134])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 27 Jan 2026 16:15:52 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com,
 mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, jrossi@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH v3 01/14] pc-bios/s390-ccw: Fix misattributed function
 prototypes
Date: Tue, 27 Jan 2026 11:15:34 -0500
Message-ID: <20260127161547.459443-2-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260127161547.459443-1-jrossi@linux.ibm.com>
References: <20260127161547.459443-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9GsRb2LrNw6wSuSULy8ezbShrq26pC2N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEyOSBTYWx0ZWRfXxcqh5zEQ+/EE
 oI8v/yyWAA4iae0VUpAJ75IBYQGQQAXoBz8U3QaFmMBb54d6JHaUMIo49IYNbQZme3Vhajc1tn/
 xocWvv0sA0BzMg6saXrktPiWuWns7RvmCLmmghIMGRi6RYMWBXYRZRxj8mS/DekEiOqgHmoqzrN
 bm8kAd9FVkkUivGZrPQfh0h6hmzia+CAWhKHFaPiS8q1/ykOYoDn18jiiT6iK4GBcBSOuhc2Umu
 xEoB4svPvFx1m2pBD/CUP/vRVEjFHrvyZImoIRijtMWNBSQakftSP00ifNOQXxV/DMYGpySFo8z
 t3QPfieqZTpmI6yNzw9pMSxK4VsMwkUOsJLrqDCSRqbkOlv8zxxD4VfIz0Njq1wdirn6fLS6ZAv
 M9ABROZQF5EdDQFgiNPzdTmE6YgXfiDs6zPg2yQUtbP/4fW9iJYVJKyF/Q3TKd6HLWesxNaZYaI
 XvRmP06r6X46JldNk5Q==
X-Authority-Analysis: v=2.4 cv=Zs3g6t7G c=1 sm=1 tr=0 ts=6978e4bd cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=HoESQQHAtyuLEXRXYhEA:9
X-Proofpoint-ORIG-GUID: 9GsRb2LrNw6wSuSULy8ezbShrq26pC2N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601270129
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Jared Rossi <jrossi@linux.ibm.com>

The virtio-blkdev functions are incorrectly listed in s390-ccw.h as belonging to
virtio.c.  Additionally, virtio_load_direct() has an unused subchan_id argument.

Remove the unused argument and move the prototypes to virtio.h so that they are
independent from the CCW bus.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 pc-bios/s390-ccw/bootmap.c       | 2 +-
 pc-bios/s390-ccw/s390-ccw.h      | 4 ----
 pc-bios/s390-ccw/virtio-blkdev.c | 2 +-
 pc-bios/s390-ccw/virtio.h        | 7 +++++++
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index 0f8baa0198..420ee32eff 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -662,7 +662,7 @@ static int zipl_load_segment(ComponentEntry *entry)
                  */
                 break;
             }
-            address = virtio_load_direct(cur_desc[0], cur_desc[1], 0,
+            address = virtio_load_direct(cur_desc[0], cur_desc[1],
                                          (void *)address);
             if (!address) {
                 puts("zIPL load segment failed");
diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index b1dc35cded..47ea66bd4d 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -67,11 +67,7 @@ void sclp_get_loadparm_ascii(char *loadparm);
 int sclp_read(char *str, size_t count);
 
 /* virtio.c */
-unsigned long virtio_load_direct(unsigned long rec_list1, unsigned long rec_list2,
-                                 unsigned long subchan_id, void *load_addr);
 bool virtio_is_supported(SubChannelId schid);
-int virtio_blk_setup_device(SubChannelId schid);
-int virtio_read(unsigned long sector, void *load_addr);
 
 /* bootmap.c */
 void zipl_load(void);
diff --git a/pc-bios/s390-ccw/virtio-blkdev.c b/pc-bios/s390-ccw/virtio-blkdev.c
index 7b2d1e20f4..4b819dd80f 100644
--- a/pc-bios/s390-ccw/virtio-blkdev.c
+++ b/pc-bios/s390-ccw/virtio-blkdev.c
@@ -64,7 +64,7 @@ int virtio_read_many(unsigned long sector, void *load_addr, int sec_num)
 }
 
 unsigned long virtio_load_direct(unsigned long rec_list1, unsigned long rec_list2,
-                                 unsigned long subchan_id, void *load_addr)
+                                 void *load_addr)
 {
     u8 status;
     int sec = rec_list1;
diff --git a/pc-bios/s390-ccw/virtio.h b/pc-bios/s390-ccw/virtio.h
index 5c5e808a50..597bd42358 100644
--- a/pc-bios/s390-ccw/virtio.h
+++ b/pc-bios/s390-ccw/virtio.h
@@ -277,7 +277,14 @@ int virtio_run(VDev *vdev, int vqid, VirtioCmd *cmd);
 int virtio_reset(VDev *vdev);
 int virtio_setup_ccw(VDev *vdev);
 
+/* virtio-net.c */
 int virtio_net_init(void *mac_addr);
 void virtio_net_deinit(void);
 
+/* virtio-blkdev.c */
+int virtio_blk_setup_device(SubChannelId schid);
+int virtio_read(unsigned long sector, void *load_addr);
+unsigned long virtio_load_direct(unsigned long rec_list1, unsigned long rec_list2,
+                                 void *load_addr);
+
 #endif /* VIRTIO_H */
-- 
2.52.0


