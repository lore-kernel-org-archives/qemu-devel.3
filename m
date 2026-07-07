Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0301FC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 07:09:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgzuR-0005pY-48; Tue, 07 Jul 2026 03:07:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1wgzuI-0005ms-KJ; Tue, 07 Jul 2026 03:07:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1wgzuF-00035W-R7; Tue, 07 Jul 2026 03:07:49 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6674IGji2725500; Tue, 7 Jul 2026 07:07:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=BSZw2cQng3/0+qs7b
 +ZmdDiN/bOLGUp2n3/lnDj30b8=; b=f/sEIkOtBr6EDx/WAmMAkeF9XyVtaqApX
 TLor3LRw1zLLIM6Q0+spQA0zw5TD6goZ3OXvtRcy9OkIRvVKB6SvF9CjuNUSJo9q
 dLMs8MQEwvwGjIjf2awWMZtIxL/I113+9q51KPG6axAuXuF4ajgSfwhTrviSq4Ht
 hUwYJlpIHQhIr384/yp/hYT8Fd7/RVlRoU0xpIlCQf2Ry5gCeZ8nxQWsrysy+ACz
 JUz0ox/ptCs4NVW+yvRYP5TPR4ZQgLvPPytxq10Jl2VxlOCUr60nLQFkVhjXIawe
 f5Mtz3fBkdnwzyLhNmQg58LPEMXIwwlxTfI3RJuSm4drI3ccOPSDg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6suqnend-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 07:07:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66774ZAM006779;
 Tue, 7 Jul 2026 07:07:43 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqg17bn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 07:07:43 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66777gga29164126
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Jul 2026 07:07:42 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 522E658057;
 Tue,  7 Jul 2026 07:07:42 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 236AD58058;
 Tue,  7 Jul 2026 07:07:40 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  7 Jul 2026 07:07:39 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Hendrik Brueckner <brueckner@linux.ibm.com>, qemu-stable@nongnu.org,
 Farhan Ali <alifm@linux.ibm.com>
Subject: [PATCH v2 4/5] s390x/ioinst: Require strict length and format for SEI
 CHSC handler
Date: Tue,  7 Jul 2026 09:07:27 +0200
Message-ID: <20260707070728.147203-5-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707070728.147203-1-borntraeger@linux.ibm.com>
References: <20260707070728.147203-1-borntraeger@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA2NCBTYWx0ZWRfX36MaLTek/+xI
 XGnLujTHwXA9YzAFcR2ZvXsRz3nQpVOjLCisAm1QOMI6wjY/9pmmL4xWGB/2EhwAn1HtsGwN6v+
 XZ+QQLYXNlJp0A3stmV1GnZ/9ETfPBw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA2NCBTYWx0ZWRfX1OjzBkwjRqhz
 CKilNP930PMMA6wN8pOwSTxugMTGsrbxc+iRFTFiJWahTt3QwlPvOnsHtdpkKNru8NL60rdWA8t
 Mpe9lAg2FKZ0WDWUKCc+ZhaEvxw/Vw0gtcC2iUt3OkfyIgaFyrlc4jmJkUi/4W7rlP6oUWHxcHy
 IFoasYG2sjnbgK7sGCC1kHuJlbySFCN1fuKvqp3QmorSUcZt9dleRHi7fkwiZpXr8Rf8yomGy88
 idY1CNzA+GNRNDiTcKE1i+hUk1sMCWrR11O7o0v4Wua6TacKp1dL5fl6ePm2tIf6uaPGAaHN1c6
 X9a4HbChs5Od6PKSujvXvE1HbMcD1tDIb94bjWfp/P/BNzFiGWZb365U0l7aiKRg7R1pUGEO0Np
 wlg6HzXv0VeERD/quy4Qay8oBNxpXhENK5fzzAAvekkeh4cc42XQSdreC66B6xJUdZoizqHbnkM
 agJZKaivj78CqrE+QKA==
X-Proofpoint-GUID: QBoGxaAh8M8m45nW6HMXywgWIm8qcBdS
X-Authority-Analysis: v=2.4 cv=Oot/DS/t c=1 sm=1 tr=0 ts=6a4ca5c0 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8
 a=VZH3qDeYady0DpGU8aQA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: QBoGxaAh8M8m45nW6HMXywgWIm8qcBdS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070064
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

From: Matthew Rosato <mjrosato@linux.ibm.com>

Ensure SEI commands that are received are of the appropriate length and
format before handling.

Cc: qemu-stable@nongnu.org
Fixes: 8cba80c3a0 ("s390: Add PCI bus support")
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Farhan Ali<alifm@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 target/s390x/ioinst.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
index 2320dd4c12..94619f9215 100644
--- a/target/s390x/ioinst.c
+++ b/target/s390x/ioinst.c
@@ -609,13 +609,27 @@ static int chsc_sei_nt2_have_event(void)
 
 #define CHSC_SEI_NT0    (1ULL << 63)
 #define CHSC_SEI_NT2    (1ULL << 61)
+#define CHSC_SEI_0_FMT 0x0f000000
 static void ioinst_handle_chsc_sei(ChscReq *req, ChscResp *res)
 {
     uint64_t selection_mask = ldq_be_p(&req->param1);
+    uint32_t param0 = be32_to_cpu(req->param0);
     uint8_t *res_flags = (uint8_t *)res->data;
+    uint16_t len = be16_to_cpu(req->len);
+    uint16_t resp_code;
     int have_event = 0;
     int have_more = 0;
 
+    if (len != 0x0010) {
+        resp_code = 0x0003;
+        goto out_err;
+    }
+
+    if (param0 & CHSC_SEI_0_FMT) {
+        resp_code = 0x0007;
+        goto out_err;
+    }
+
     /* regarding architecture nt0 can not be masked */
     have_event = !chsc_sei_nt0_get_event(res);
     have_more = chsc_sei_nt0_have_event();
@@ -642,6 +656,12 @@ static void ioinst_handle_chsc_sei(ChscReq *req, ChscResp *res)
         res->code = cpu_to_be16(0x0005);
         res->len = cpu_to_be16(CHSC_MIN_RESP_LEN);
     }
+    return;
+
+ out_err:
+    res->code = cpu_to_be16(resp_code);
+    res->len = cpu_to_be16(CHSC_MIN_RESP_LEN);
+    res->param = 0;
 }
 
 static void ioinst_handle_chsc_unimplemented(ChscResp *res)
-- 
2.53.0


