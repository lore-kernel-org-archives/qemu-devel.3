Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A27E5EA854A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 00:37:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzObY-0006Hk-2J; Sun, 08 Mar 2026 20:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vzObV-0006G7-9m; Sun, 08 Mar 2026 20:36:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vzObT-0001dU-GA; Sun, 08 Mar 2026 20:36:13 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 628MKqjs1553765; Mon, 9 Mar 2026 00:36:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=JcclZk37WuGb3QtwM
 eyrB8lSeuhdys3LQmg5oj2Y5QM=; b=oSguednjBcyMPGTADAgkh3HCDrk982KeA
 gl/2eWqaSBpwG3gK/y4l4o5B8aVbWU/Qpjm/vWoNUviCwRBOTDuMS6XlVpZcp+h/
 OkGojk2q6+eVpGdg9sGB0Bm/atiBhQjeGJlDMI+DdEeRYHJLVUc7tgg22rqhMhRb
 HG/Jd8p3uWqkTo4zrTZTR/fie2rq0+YnF+4UaOk5nxlgS2p7OuqVE2JVoeJ/Xgg4
 C+Xj13zIokjlruCaAVV8XHG+I7IWn8yMHmJVks4KbN/CPTjTh90jqnon41WImxhg
 QxyqvLLtFR6NtHx5mTyEQXJZnfz6So4wl3RR2KQNoF6S1CdyuRytQ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcvr4em5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 00:36:08 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 628LeewZ015652;
 Mon, 9 Mar 2026 00:36:08 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4crybn2yug-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 00:36:08 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6290a6Ch41419286
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Mar 2026 00:36:06 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C2D1D58054;
 Mon,  9 Mar 2026 00:36:06 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ABA1F58052;
 Mon,  9 Mar 2026 00:36:05 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.180.105])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Mar 2026 00:36:05 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com,
 mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, jrossi@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH v5 01/15] pc-bios/s390-ccw: Fix misattributed function
 prototypes
Date: Sun,  8 Mar 2026 20:35:47 -0400
Message-ID: <20260309003601.242634-2-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260309003601.242634-1-jrossi@linux.ibm.com>
References: <20260309003601.242634-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDAwMyBTYWx0ZWRfX9TRWo6l3UWHW
 FqY8ji77Qw2QwZodOhQuS4Gdc1xjG0Cc7Out5soxGZjqxvE8qNOullgF4pXzc+C1PLB3w8Qtxpp
 CG+Qz/mjeT3lCncqUVs4R/PRQUrnNsJ3UjdNScaZ00GQb0zQ9OAELgOom5sRe8JxXwWmSjKJ62z
 RKRdXiHc6/tT/Jme/Ku9TfPj4A0PB4NZxAGyVFRjdJsquFN6MMYuZL6AIObvrR+jtFii1YuaRa+
 jT91QVG2JXreta06ql2yUSi5veXWBF/WuggowAiynPt77iNzHLbDK/2Lx1aNbOjftq6oaKuhvBQ
 lfnf/H1TMH5Ycahg602B9m+burmF1VMC+PBd2F7PywAF0cj2tgIkp8nPxcWGLPqaPhsW1YhPL3u
 hc6ni3qLFt7DaOY+1bwWOwzsvh4p2AqPA08DI9f5J/P/fzDv8jOWa9jxlKEzJmbJ8Btjt3OxcEC
 ebQ6Rp1wLAhkwQCZ+yA==
X-Proofpoint-GUID: yVJwr4SQkNFBbDtRkfya00YnuLknc54F
X-Proofpoint-ORIG-GUID: yVJwr4SQkNFBbDtRkfya00YnuLknc54F
X-Authority-Analysis: v=2.4 cv=QoFTHFyd c=1 sm=1 tr=0 ts=69ae15f8 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=HoESQQHAtyuLEXRXYhEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-08_07,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603090003
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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


