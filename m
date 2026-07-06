Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36111C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 09:23:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgfWL-0005fb-M8; Mon, 06 Jul 2026 05:21:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1wgfWC-0005Zs-1f; Mon, 06 Jul 2026 05:21:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1wgfW6-00063K-Kq; Mon, 06 Jul 2026 05:21:33 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6669IQeD3133979; Mon, 6 Jul 2026 09:21:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=FbuJ2rJLVzdvqjlSI
 /azXZHPJJgG3my3AaOVOYwxWk8=; b=aJd5SIlJYNewOwI/mJ4tcZwTmxpRA6F7n
 1J+eqN2SekRdNW7CtpSsDK2VlJpbS6nnvzr05q67RjJg3+1jOFsLu5cg87JOFRg2
 GeFMOv9nVKWZ9O+8g2M1F3m5/eqV6yJpEmiDnAnhZ2Ezb32kFYf467Zd+oyr1h7U
 KtQd4Th/1EQtJeTl2qe72qpEjujv0RdL2K15QZPyM5Yb74ZSmwfT9RZX75ONWCYp
 JoVyj7blvRbB4zfMPxWSWXzIuy/aCX0/iJD3DUZcybmrVxX2lpSuILFOAo3aMTop
 fPQQ8Ucs4cOj3WZUUa0lgjLV5MEnocpk1DWE8PuejbFS0jG8Zw//g==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6stsh67q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 09:21:26 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6669Jexd014746;
 Mon, 6 Jul 2026 09:21:25 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6xvke6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 09:21:25 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6669KnSe48234932
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Jul 2026 09:20:49 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9486D5805B;
 Mon,  6 Jul 2026 09:21:23 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 51D075805D;
 Mon,  6 Jul 2026 09:21:21 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  6 Jul 2026 09:21:21 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>, qemu-stable@nongnu.org
Subject: [PATCH 4/5] s390x/ioinst: Require strict length and format for SEI
 CHSC handler
Date: Mon,  6 Jul 2026 11:19:08 +0200
Message-ID: <20260706091909.864405-5-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706091909.864405-1-borntraeger@linux.ibm.com>
References: <20260706091909.864405-1-borntraeger@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bQ0cIfI8YeKMzvBYOAK16YoFD-Fl34Wf
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA5NCBTYWx0ZWRfX31Woul3+hHQA
 SYR/REzO9UIdsiD+GXN8VFGtnx7V8k4q7ajGbjCeH/6SdnoXyca9Ex3MzgY4R6TGy5Q9EV2MVfN
 qHHKmU/H+xpfbGCxCuKGg3gIqXkDM2M=
X-Authority-Analysis: v=2.4 cv=DKW/JSNb c=1 sm=1 tr=0 ts=6a4b7396 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8
 a=VZH3qDeYady0DpGU8aQA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: bQ0cIfI8YeKMzvBYOAK16YoFD-Fl34Wf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA5NCBTYWx0ZWRfX8TZUCMTjbCSx
 9sddmQEz0NyLQt2Xq+q71FcdYIjPRTjcGBAGgbVxMmB9dIpaH5h29EQUWlbRgMf9+RsYr9Pu4zG
 ElT+0U/nZqpbvlixTwDbqp9j1u5TdtGEO4luWH2cJYjaq5mROAqKtNMPr3A4DjODux8Q52FYpzO
 pqoTZFSw12w1g34Gm0Q0xLf1Xr8roQ11FvjRDfIJjaJbJ+icdxq8MHYeb7+BeQz3/VlJw9C65Lu
 OXCQVuU7vlYgmzcqbRFd2x2qepkGU4I7b5fINmn/U16GAP9bRzac4IIzdlswnpswMatom/W0Ac7
 i0+97lpkCISlK2jArrQ473+UmPQAJT72EyfYx2ct5knPFCMrNjs4nNTjv+Tz4QxFuty9qFx304D
 QXwLBoLqgj8n+wWUeSPgpOFcHwgHvwFK9olfiHu4kqxyZhemGBIOCXqybmE/N+nkfC2uDd0qowc
 KH5vUpSe6840m4fPKkQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060094
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

From: Matthew Rosato <mjrosato@linux.ibm.com>

Ensure SEI commands that are received are of the appropriate length and
format before handling.

Cc: qemu-stable@nongnu.org
Fixes: 8cba80c3a0 ("s390: Add PCI bus support")
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
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


