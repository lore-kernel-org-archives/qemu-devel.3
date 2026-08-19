Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC0A3C5DF6D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 10:00:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwd4l-0002hh-K6; Wed, 19 Aug 2026 05:59:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wwd4j-0002hB-Po; Wed, 19 Aug 2026 05:59:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wwd4h-0008Nk-UC; Wed, 19 Aug 2026 05:59:13 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67J6VunL2666956; Wed, 19 Aug 2026 09:59:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=T/ppg8Anzgedb9vBNGFRVtGlKeo/UVv4YHOk7LhLW
 pk=; b=tp+SSwH6SFnNJIYArh+3VzBuMcsPkJMLuz2ZGSBACRGSk3LR5zO1CISsX
 rT7S6eXRwsY3bJbWlVUqRlrRHVO3TbFQWQUBrqznCOWTc5Zeri9MXdNqMawzbBfD
 TZWpG4geD+Y5ukuNHMiQ34SV/KPES6ijx7FWZiuyhw38/IS47MAIj+zkSLcFPBAK
 FZebv4ilVoG7d6+wJtBiWuLSsbKY9q9cmYr2bpxi46Jb9QIgYNGY1vNHqPSsZlbg
 SIZAXLZxL//h32oHMkJLOhiPlmRu/IeYH7eaaQF1QDOVsIWWTjEyU1TVw/RW4gqj
 uqZfWQn4lZuc7q9E3curvDLT6pjuw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0ax67-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Aug 2026 09:59:07 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67J9uR6x024683;
 Wed, 19 Aug 2026 09:59:06 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g32tw8cy1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Aug 2026 09:59:06 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67J9x2Ag46662108
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Aug 2026 09:59:02 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9FD9620043;
 Wed, 19 Aug 2026 09:59:02 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 71FE620040;
 Wed, 19 Aug 2026 09:58:59 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.39.17.179]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 19 Aug 2026 09:58:58 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, fam@euphon.net,
 pbonzini@redhat.com, amachhiw@linux.ibm.com,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH] hw/scsi: validate IU buffer bounds in vscsi_preprocess_desc()
Date: Wed, 19 Aug 2026 15:28:55 +0530
Message-ID: <20260819095855.115823-1-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=MthiLWae c=1 sm=1 tr=0 ts=6a857e6c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=p0WdMEafAAAA:8 a=VnNF1IyMAAAA:8
 a=gtT2MXwoUA80MS-wKdUA:9
X-Proofpoint-ORIG-GUID: 6ZwmomVaAx7SN6qCEJIof8PbgGOvQQhs
X-Proofpoint-GUID: XemyoWyfIKYGIox3oOA6N2sQyYglQjrn
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDA3MiBTYWx0ZWRfX/SSUV3b0B1vw
 PlxWLrAWUAW31cTwpSLRYZvYE9ifMK4Pqi8o6xl5J3Yaw3HLA7qu5DKcGzdCVT14laeVm9VHbVV
 ZHhKUDvEcHzFo7narj7xgjEzi5nyBT4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDA3MiBTYWx0ZWRfX6spD8IB9MvTI
 xhMnPkIKyT1Fy2GHBCRafRUohwZM1x6h54YxVgI9cUTxaNhuH0+T3ZPQtHg3HCHV1tNPviARdbj
 3ByIHL7K9noHxrzucChI8PC2W2m5NqCuMuttzwNVf6thY0aAp4eL81/SCUNZ/vpZz8NLJkKWB/Z
 rnobe2iXjH1Ze7WFBqZKteLdjW2JAltdGFcB0kYjDrKfEljNpwtO7aYASHAQSf46KkAs7aYfDg4
 N8CnsFV61+Am04sTyxtTdGZZ3FDxNr68f/8kgpk0OqoQoxJejIHr0M4/2Zcep7qIeNKFOOwUoxJ
 AHTuFoM2s8Vsobh30hbS/EC8ParQgIlThUVZ7FDnFVnK5/r5O4XNNzzwObknLTtIL46Js88gXsP
 zvKdCb6/0dUp0c0s/ES7YJAQQ5sy0LX5mgIVE732kBMEv8wmaEzk90RwzSswuC1PCu0aH+J6WvX
 ldZeDpYuP5X5/q3C6bQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1011
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190072
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
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

cdb_offset and local_desc values are dependent on the guest. If the value
is large enough, it can lead to an out-of-bounds read in vscsi_fetch_desc().

Add an 'avail' constant in vscsi_preprocess_desc() representing the number of
bytes available in srp_cmd.add_data[] and use it to prevent out-of-bound reads.

Make all callers of vscsi_preprocess_desc() check its return value and
handle failure accordingly.

Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4162
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 hw/scsi/spapr_vscsi.c | 43 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
index b4c8f94d22..9fef224727 100644
--- a/hw/scsi/spapr_vscsi.c
+++ b/hw/scsi/spapr_vscsi.c
@@ -484,6 +484,8 @@ static int data_out_desc_size(struct srp_cmd *cmd)
 static int vscsi_preprocess_desc(vscsi_req *req)
 {
     struct srp_cmd *cmd = &req_iu(req)->srp.cmd;
+    /* bytes available for descriptors behind srp_cmd.add_data */
+    const unsigned avail = SRP_MAX_IU_LEN - offsetof(struct srp_cmd, add_data);
 
     req->cdb_offset = cmd->add_cdb_len & ~3;
 
@@ -498,16 +500,35 @@ static int vscsi_preprocess_desc(vscsi_req *req)
     case SRP_NO_DATA_DESC:
         break;
     case SRP_DATA_DESC_DIRECT:
+        if (req->cdb_offset + sizeof(struct srp_direct_buf) > avail) {
+            fprintf(stderr,
+                    "vscsi_preprocess_desc: direct desc out of bounds\n");
+            return -1;
+        }
         req->total_desc = req->local_desc = 1;
         break;
     case SRP_DATA_DESC_INDIRECT: {
-        struct srp_indirect_buf *ind_tmp = (struct srp_indirect_buf *)
-                (cmd->add_data + req->cdb_offset);
+        struct srp_indirect_buf *ind_tmp;
+
+        if (req->cdb_offset + sizeof(struct srp_indirect_buf) > avail) {
+            fprintf(stderr,
+                    "vscsi_preprocess_desc: indirect desc out of bounds\n");
+            return -1;
+        }
+        ind_tmp = (struct srp_indirect_buf *)(cmd->add_data + req->cdb_offset);
 
         req->total_desc = be32_to_cpu(ind_tmp->table_desc.len) /
                           sizeof(struct srp_direct_buf);
         req->local_desc = req->writing ? cmd->data_out_desc_cnt :
                           cmd->data_in_desc_cnt;
+
+        /* desc_list[] entries must also fit inside the IU buffer */
+        if (req->local_desc * sizeof(struct srp_direct_buf) >
+            avail - req->cdb_offset - sizeof(struct srp_indirect_buf)) {
+            fprintf(stderr,
+                    "vscsi_preprocess_desc: local_desc out of bounds\n");
+            return -1;
+        }
         break;
     }
     default:
@@ -725,7 +746,11 @@ static void vscsi_inquiry_no_target(VSCSIState *s, vscsi_req *req)
     memcpy(&resp_data[8], "QEMU    ", 8);
 
     req->writing = 0;
-    vscsi_preprocess_desc(req);
+    if (vscsi_preprocess_desc(req) < 0) {
+        vscsi_makeup_sense(s, req, HARDWARE_ERROR, 0, 0);
+        vscsi_send_rsp(s, req, CHECK_CONDITION, 0, 0);
+        return;
+    }
     rc = vscsi_srp_transfer_data(s, req, 0, resp_data, len);
     if (rc < 0) {
         vscsi_makeup_sense(s, req, HARDWARE_ERROR, 0, 0);
@@ -775,7 +800,12 @@ static void vscsi_report_luns(VSCSIState *s, vscsi_req *req)
         i += 8;
     }
 
-    vscsi_preprocess_desc(req);
+    if (vscsi_preprocess_desc(req) < 0) {
+        g_free(resp_data);
+        vscsi_makeup_sense(s, req, HARDWARE_ERROR, 0, 0);
+        vscsi_send_rsp(s, req, CHECK_CONDITION, 0, 0);
+        return;
+    }
     rc = vscsi_srp_transfer_data(s, req, 0, resp_data, len);
     g_free(resp_data);
     if (rc < 0) {
@@ -823,7 +853,10 @@ static int vscsi_queue_cmd(VSCSIState *s, vscsi_req *req)
         req->writing = (n < 1);
 
         /* Preprocess RDMA descriptors */
-        vscsi_preprocess_desc(req);
+        if (vscsi_preprocess_desc(req) < 0) {
+            scsi_req_cancel(req->sreq);
+            return 1;
+        }
 
         /* Get transfer direction and initiate transfer */
         if (n > 0) {
-- 
2.55.0


