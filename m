Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C069CA5FFC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 14:45:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xESt5-0002uQ-Dk; Wed, 07 Oct 2026 10:44:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1xESt1-0002tx-TP; Wed, 07 Oct 2026 10:44:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1xESt0-0002me-2n; Wed, 07 Oct 2026 10:44:51 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697BaBQv2400682; Wed, 7 Oct 2026 14:44:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=doSnuqmSQXZyqk/ACPWtO8pksLPMAyVvAeZvdVq06
 ak=; b=e8QZ2rlOYrLyV6GLT7gUik7+OmXQNimPiktncpSG5N9Kra22XtquQU9Lc
 Bopc3n7hMuRziIfxhhTDyxNjUFVOadVz+bB8+KQAkcYYiyzo4sjmOs+/pC0oVSsG
 4wMKffR1njyBbsQKp9ricJXhjtJvbaTLemLpxcQIVmBNYyeFr30CKYepGTkuDmoG
 8S1wp+AFkrOUEfGhwNdmaQur8wFaAT5WWAigtR4Y00Ie8MU0BV1BBj+6C+5jKimb
 tHG4wHWDZsw+0TKZkU7N9YFwvSl6IJQoUFz2VZfMY6B07aIQgOOnZN2+xLh4Ma1T
 0ikGQYUHBDBn1nJRxfXt6pboaK0lQ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2sbvcymj-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 07 Oct 2026 14:44:45 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 697BX7gA1852625; Wed, 7 Oct 2026 14:44:44 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3dhgxxrm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Oct 2026 14:44:44 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 697EieII44564906
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 7 Oct 2026 14:44:40 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7DF8F20040;
 Wed,  7 Oct 2026 14:44:40 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 559EE2004E;
 Wed,  7 Oct 2026 14:44:38 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.111.34.166]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  7 Oct 2026 14:44:38 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com
Cc: amachhiw@linux.ibm.com, pbonzini@redhat.com, fam@euphon.net,
 Chinmay Rath <rathc@linux.ibm.com>,
 Guthrie McAfee Armstrong <git@gmarmstrong.dev>
Subject: [PATCH] spapr-vscsi: clamp adapter info DMA write length to struct
 size
Date: Wed,  7 Oct 2026 20:14:30 +0530
Message-ID: <20261007144434.374749-1-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bWkj22YPfWoWBmCK-8CnjqNJESy76V_M
X-Authority-Analysis: v=2.4 cv=KJHPn1Fo c=1 sm=1 tr=0 ts=6ac65add cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=p0WdMEafAAAA:8 a=VnNF1IyMAAAA:8
 a=HFWUlIUfFqO2-xBDwmUA:9
X-Proofpoint-GUID: bWkj22YPfWoWBmCK-8CnjqNJESy76V_M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA1OCBTYWx0ZWRfX128Dr0GVZztm
 BAyrQhbh8v9IYjusnLHUGv2dbzNjbAaX0nlp08BlNDRPRLHzvCT62c6M5wG+Minn/hlxNQYhzSS
 nt63cX+mhSFF/4CKfT/OBvMwRcebyeLSGH3m7TO2jJt+e7dXDkzCFCYGWpjyeY4JuyYC5z4gnGg
 VTT0B49nz7CQ/8X7Bn3dqiuNuoNHZE0rNHF6lU0RZz2GGMJgpWjSPO0To8qaj3C3AnM1jsuOH0p
 wukLT3bJioETfiPMhJIJhpF2dsCg9CkiOQKTfPMiojKutcCAm68Io+bFL52CGnQTKDYt7enJ4Oe
 ot7QwfvNUQyJqKKmUAg+zU/aV45EGd4jMZSHgshjyouFaAGqBnyYkCo0bI2weKkCJXhBASH9+vD
 azJ0nt5faVQLbORv4jSV1rfTmrFuw0GKQSXaCuO/VSveIG/5Qnzbr5uUKWXH6qwe6NKuWYKl9Q4
 fJOX1RSlByzwgLizzzA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA1OCBTYWx0ZWRfXx+LxpuNpii43
 h5+rVl3QdZZP+UXTU7Vart4yqVBrCgB7P7poxqA4GHfUNjK/KAgxja6XgKhXQSQrO+JKVApuoVi
 TjdKKP0aUCh3F+NT0o8JqvoDAeRpq/A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_04,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0 clxscore=1011
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610070058
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rathc@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

vscsi_send_adapter_info() used the guest-supplied common.length
field directly as the size argument to spapr_vio_dma_write().
Since common.length is controlled by the guest, a value larger
than sizeof(struct mad_adapter_info_data) (148 bytes) caused
dma_memory_write() to read past the end of the stack-allocated info
struct, leaking arbitrary host stack contents into guest memory.

Fix this by clamping the write length to sizeof(info), then using
spapr_vio_dma_set() to zero-fill any remaining bytes the guest
requested beyond that size. This mirrors the existing pattern in
vscsi_send_capabilities().

Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4626
Reported-by: Guthrie McAfee Armstrong <git@gmarmstrong.dev>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 hw/scsi/spapr_vscsi.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
index b4c8f94d22..7ec780da79 100644
--- a/hw/scsi/spapr_vscsi.c
+++ b/hw/scsi/spapr_vscsi.c
@@ -966,6 +966,8 @@ static int vscsi_send_adapter_info(VSCSIState *s, vscsi_req *req)
 {
     struct viosrp_adapter_info *sinfo;
     struct mad_adapter_info_data info;
+    uint16_t len, req_len;
+    uint64_t buffer;
     int rc;
 
     sinfo = &req_iu(req)->mad.adapter_info;
@@ -985,11 +987,23 @@ static int vscsi_send_adapter_info(VSCSIState *s, vscsi_req *req)
     info.os_type = cpu_to_be32(2);
     info.port_max_txu[0] = cpu_to_be32(VSCSI_MAX_SECTORS << 9);
 
-    rc = spapr_vio_dma_write(&s->vdev, be64_to_cpu(sinfo->buffer),
-                             &info, be16_to_cpu(sinfo->common.length));
+    req_len = len = be16_to_cpu(sinfo->common.length);
+    buffer = be64_to_cpu(sinfo->buffer);
+    if (len > sizeof(info)) {
+        fprintf(stderr, "vscsi_send_adapter_info: adapter info size mismatch !\n");
+        /*
+         * Just read and populate the structure that is known.
+         * Zero rest of the structure.
+         */
+        len = sizeof(info);
+    }
+    rc = spapr_vio_dma_write(&s->vdev, buffer, &info, len);
     if (rc)  {
         fprintf(stderr, "vscsi_send_adapter_info: DMA write failure !\n");
     }
+    if (req_len > len) {
+        spapr_vio_dma_set(&s->vdev, (buffer + len), 0, (req_len - len));
+    }
 
     sinfo->common.status = rc ? cpu_to_be32(1) : 0;
 
-- 
2.55.0


