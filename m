Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4247CC9830E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 14:41:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9kdC-0003bO-3o; Thu, 24 Sep 2026 10:41:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1x9kcr-0003Sm-Uw
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 10:40:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1x9kcq-0004Ye-BJ
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 10:40:41 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OC6PO62192169; Thu, 24 Sep 2026 14:40:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=lLwvKw
 vWU0J5sh7K92OO1NzDIdKRGuLYzKIPZBaXKdc=; b=LgIZo9XQlo1Z5jHoI3zRBk
 3iPrcV0YWvf64Kc9pSCtckNYQ+hG/+9kwMEQiphhImD5iuHctK1BmfV2Mn3gvr5a
 mQTbHOYrfNzr1mnWgcSdFP/o+yF9hdHSqSWL8oBBsJkbeSl359hpNy5Z15ZG8rpc
 7FqDb7oLiu2JaGXuHUElEBLw9LNQ7SLELOtV6aatsdaEfJjSrebNTqPEqJlsgWG1
 5/2nEAw0f95oITwxY8rosueiR7mYV+4qwJGLTNCez1mtkpKKRONCeFhJo2aecPOp
 TYrsoyvQHTC+qfY9DjErpEpGR5DRn7QjO9pozb3UrXiMUuepsHt4szJ4JjX6ESQQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg2ssj1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 14:40:38 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OENkPp2232310; Thu, 24 Sep 2026 14:40:37 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbe1x977-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 14:40:37 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68OEea0E7078402
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2026 14:40:36 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 65F1F58059;
 Thu, 24 Sep 2026 14:40:36 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D150658058;
 Thu, 24 Sep 2026 14:40:35 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Sep 2026 14:40:35 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: armenon@redhat.com, marcandre.lureau@gmail.com,
 Stefan Berger <stefanb@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v2 07/10] hw/tpm: crb: Avoid potential integer underflow
Date: Thu, 24 Sep 2026 10:40:23 -0400
Message-ID: <20260924144026.953360-8-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924144026.953360-1-stefanb@linux.ibm.com>
References: <20260924144026.953360-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: sF4FEwXizcKLsamlcAtbaCr4Y9v457vD
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab53666 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=c1_1-GllvHXUlFLDVV0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA2MCBTYWx0ZWRfX8CJwQOIT2hs3
 QCxb268wx0MTypTDYF2KdJ/JYFRZzX5X41laJ3WS0cq5gpeSmRL/wST2Y313lWzRTxYCm4wQslM
 BTXs4g4b+NOSN4qHcV/ZEEV9V9khJjhn2deYuXJLUZ7uBbEM8WmtoSYKqVAUNe76+6cfJyOSvTt
 KnBx0OGs+liELutaUfcYBpu/qbnicR1AXhfeG7vmNbHRn20c1cxh5+9nw371G6+hGI1OPoCdhg6
 F4l/PFHno3MEGqvZKFwMPpyq5oRHtIJ7WjGt2Fq5mgUcmbFeJh/pmKrlwZ45AlvuUk7KNscVXct
 ljCRVFxvmMMMA6mtp8lZI42RcsOWyXt98rmt/kqaP000YaHpkVpAz9di4jMReDoFQ18NSMKSxOJ
 fhMgyD6WZWPxQWE8aym16dPLTl1YZwqXGBFFMPjrh1XtoNC2eBKTmSARZnO4WYe08deNfI8Z0rr
 HKiE3Zjs9awA92VC+0A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA2MCBTYWx0ZWRfX4dKuPG7PH0rd
 iADFuzrtAF0JiYF1Yyojq2oA4M92bON6EndNiIUs5ttVtmDd70hxLI2/PUSZ3tqhb5bsPrqw4Ex
 taE+KiTP8vxPc10yPUQ1WPr+BxHNv6I=
X-Proofpoint-GUID: 4xzOKpYL7p86J0toHR5TBk5J_N9qcCuA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240060
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
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

Avoid a potential integer underflow in tpm_crb_fill_command_response
that could occur if s->response_offset > s->response_buffer->len and
the function's call sites were to change.

tpm_crb_fill_command_response currently has 3 callers that either test
that 's->response_offset < s->response_buffer->len' is true or ensure that
s->response_offset = 0 and s->response_buffer->len >= 0. Therefore, the
integer underflow cannot currently occur. In the worst case the subtraction
would lead to a '0'.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 hw/tpm/tpm_crb.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index e5e33a3a2f..9a9677db6b 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -180,10 +180,17 @@ static void tpm_crb_fill_command_response(CRBState *s)
      * to the linux guest in chunks by writing it back to MMIO region.
      */
     void *mem = memory_region_get_ram_ptr(&s->cmdmem);
-    uint32_t remaining = s->response_buffer->len - s->response_offset;
-    uint32_t to_copy = MIN(CRB_CTRL_CMD_SIZE, remaining);
+    uint32_t remaining = 0;
+    uint32_t to_copy;
 
-    memcpy(mem, s->response_buffer->data + s->response_offset, to_copy);
+    if (s->response_offset < s->response_buffer->len) {
+        remaining = s->response_buffer->len - s->response_offset;
+    }
+    to_copy = MIN(CRB_CTRL_CMD_SIZE, remaining);
+
+    if (to_copy) {
+        memcpy(mem, s->response_buffer->data + s->response_offset, to_copy);
+    }
 
     if (to_copy < CRB_CTRL_CMD_SIZE) {
         memset((guint8 *)mem + to_copy, 0, CRB_CTRL_CMD_SIZE - to_copy);
-- 
2.55.0


