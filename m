Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB818C9830D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 01:26:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9YDg-00019l-6f; Wed, 23 Sep 2026 21:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1x9YDZ-00016Y-CO
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 21:25:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1x9YDX-0007Ly-OH
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 21:25:45 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NNZl9J3589538; Thu, 24 Sep 2026 01:25:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Yhl563lbS+17JVt2W
 jPafv4pfyV0UQGzs6/hin+8Pc8=; b=nU/OxFoQbNHaDqLfE7NfnkXvYD9fZpJLy
 gKJIrEuSuSp4PKNWCrUIO+RnecmkRv/Q5BO4UkW9X5hlk0rqGpyDRxk49j4yMh1b
 ITd86DMUbiXWgnGDAb8ktlGbHKiwsRfF16Kie/EuLPAtPsQ6XNw7vHGt1ThhalAD
 xlTnzvqnROLyph15FKK8lALRH7BQBhtjSEUp4otGIdVzlXknIdftfFFi4FOZBXbS
 VYP6NZQijWO4AFv715KjEn0bqGCbSzezIAivEwpbV7XhTxoxsD/POncMOfxSnCvI
 M9TMdjKOiAOXcgLzFcSKntWShislocGqv3sGEejhyLc9jHDIUpCXQ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgqnr89-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 01:25:41 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NNHTGH1079965; Thu, 24 Sep 2026 01:25:41 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbt2uf3g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 01:25:41 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68O1Peq415598096
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2026 01:25:41 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8F1B358053;
 Thu, 24 Sep 2026 01:25:40 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1926A58043;
 Thu, 24 Sep 2026 01:25:40 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Sep 2026 01:25:39 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: armenon@redhat.com, marcandre.lureau@gmail.com,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 07/10] hw/tpm: crb: Avoid potential integer underflow
Date: Wed, 23 Sep 2026 21:25:24 -0400
Message-ID: <20260924012527.858527-8-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924012527.858527-1-stefanb@linux.ibm.com>
References: <20260924012527.858527-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab47c16 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=c1_1-GllvHXUlFLDVV0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAwNiBTYWx0ZWRfXzNiaZLCJKr8A
 3E0PqV76VjOKkk3b05K1a5Op5E8JwBKQJdEn3Z2dAyC3tChuwWcfVwSW1rX7q7YvrvN22/zoLDg
 tgAGFXxZfXdN44ps0bf6DKhbfArZ8uAB9PzxZi9qTZHDSLgdJp9jJebcXsalABqjkp/fsMkA9RD
 j8dvT808H+YlWNAIv4m8pMK2gSeIUyeO5wNWhaZ2huQga8fQy0vkjfZZy2htM13CzqgDKF3xN+4
 iIGT+DYAoXRY7Vkf80yiXKXPcy75wGS+TE78bL1f1R2VgDJ2m4y/CIilksCxYAltGHhMjpfeWAH
 EKPNPxObMaGK1rL+XKEcLONPzCQmOgtYWH4UR2+1jizx6+1MQn+82lrU1OyrbNNfbibFgpVhkoD
 hY0v8xjIZcyai11EoOfo1TDDPvunT+MHQ0mnnq27APmskbMmUSUmqPr2+PlZGwR5gMS3wrCuwk1
 xTXVm4SXK7qeMZUr5kA==
X-Proofpoint-ORIG-GUID: GpIhF8nwIRsgzihqIr8MmbEJZTv7E0P5
X-Proofpoint-GUID: VEJB9996hBnxi_CJlm4qo8pslHh3nRzz
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAwNiBTYWx0ZWRfX1Ir3KLf6lm5b
 +yzde9/r7PIeloID90Wu84uJpaGpW0z/Ub0T0Lw+nMBNS+diA0GoKdbKGhHr/sXGHh1bqWarh6g
 z/q5It5MzmFA18jP1q73i6BfFu3tJpY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_08,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240006
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
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

Avoid a potential integer underflow in tpm_crb_fill_command_response
that could occur if s->response_offset > s->response_buffer->len and
the function's call sites were to change.

tpm_crb_fill_command_response currently has 3 callers that either test
that 's->response_offset < s->response_buffer->len' is true or ensure that
s->response_offset = 0 and s->response_buffer->len >= 0. Therefore, the
integer underflow cannot currently occur. In the worst case the subtraction
would lead to a '0'.

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


