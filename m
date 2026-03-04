Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7097EDEC01
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 03:00:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxcSU-0002Lv-B8; Tue, 03 Mar 2026 21:59:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vxcSQ-0002Jp-Cb; Tue, 03 Mar 2026 21:59:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vxcSN-0000Tm-VP; Tue, 03 Mar 2026 21:59:30 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 623KGadB2165137; Wed, 4 Mar 2026 02:59:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=JcclZk37WuGb3QtwM
 eyrB8lSeuhdys3LQmg5oj2Y5QM=; b=H8ljOr7cbuA8QPSHCghvC2KA4kgCa4WSz
 TwWVoXukDnSZm0qoOwd69Xzg8KuRajifZ9BxKWyocyylkywkXZyzSkbLwFvSi6bB
 gfW2lo2uXvc6Wy1adSh0K2ncinEc2RyGpcbR+imy5YFPems+mSDmFmMKnsBUEc8k
 +aQBwLVajM9V9NFY7suY74wMDa8ou+VTmAsk0boJ/SFjvdwpB904c/XCJuxwVdTH
 hM0PxPPt48hBgX3qTXzdQnp7hB2BfsACHaOI0uMjwqoKfLfAd1Mu6fAJvHkJXyad
 llmTfwUhnruxG3XCCGkK+aB6eFT/aE0aiBH5KjhKWNcjeHBLxi5Fw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksjddq70-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Mar 2026 02:59:25 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6241FEXJ008779;
 Wed, 4 Mar 2026 02:59:24 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmdd1cpx1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Mar 2026 02:59:24 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6242xNSU17367688
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Mar 2026 02:59:23 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 923E158059;
 Wed,  4 Mar 2026 02:59:23 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 70E9158043;
 Wed,  4 Mar 2026 02:59:22 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.180.105])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  4 Mar 2026 02:59:22 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com,
 mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, jrossi@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH v4 01/15] pc-bios/s390-ccw: Fix misattributed function
 prototypes
Date: Tue,  3 Mar 2026 21:59:03 -0500
Message-ID: <20260304025917.2157032-2-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260304025917.2157032-1-jrossi@linux.ibm.com>
References: <20260304025917.2157032-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M9BA6iws c=1 sm=1 tr=0 ts=69a7a00d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=HoESQQHAtyuLEXRXYhEA:9
X-Proofpoint-ORIG-GUID: b1GOnDIocx7HRp3ysIrDTFuTplj-OsYp
X-Proofpoint-GUID: b1GOnDIocx7HRp3ysIrDTFuTplj-OsYp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDAyMSBTYWx0ZWRfX2Q4l1GxhGP0n
 OKkJaquF4GIk0w/MnKOlS9ZuTYivmjD5+E9Abgsi2uMp1MMZpZ6Ze+f8Q5AJPGNlQw9rTEpW8OK
 lamVxkkLK97M+qpjQ0H8WWfe3CLq5OxVmBYSw9GtLNW/BY37jvlnJrzGim/hH+50b9uJtPdPf7d
 4D6bW2B/GD/Z7lTYGcgld8ab8Ptkgdy0Nvsf+Bnro/n8C0bbKbQbzRfvOFb/eDky78eqtCioYGH
 5rZfMbjsrgaNyCk2uSqQGuL82w+Zy4SHQmCsE5rT7qZTVwIHPcq1dDvOQuEc7fMjbDSrm1KVU4e
 JwBaoqBgWHkeDvbM2XqeaSibEbRi8ZNbeHbhKcES8pjKbE/5amqmg8+Die5BwkxhQIt7XcVWxS0
 vBnJsU8+4pofUxbhL+7mwIAAENDv6GTgRpkcXmh2aJVC570oKuMSLauRK9pQSEX7AUYwJ//ri2b
 DK4Kih5clyIzPvbxV7g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_01,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040021
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
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


