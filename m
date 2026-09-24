Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B829DC98304
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 01:26:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9YDe-000195-7g; Wed, 23 Sep 2026 21:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1x9YDY-000160-Rj
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 21:25:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1x9YDW-0007Lk-PX
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 21:25:44 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NNa0vp3589567; Thu, 24 Sep 2026 01:25:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=JZs5z3Or2QSDXmaDJ
 OhFmtgUyHDJhTe2ikwgwSoYk2c=; b=Kdm/mCoWWe3N7X+vjghvAoHKDx10C3XmP
 RGHZZrxAnmUlQvEmjaiFkgSmF8+9FK8+D1pyt1SI7CLoQ16gNfF5K3nw/TJosOHE
 tFAn4BBJPXCkgIeEYJT2OJfKcH426Qi+R3FjQNaAjSa5W3EwREe/dtfn/L63O78T
 HEl2lgUyzQDZnqe2unw40vYv2KIgnrCw/nsn9HEjnnVKJcsxiUKQ3X+YM6WJf6ac
 oM5q/Jt8H1Ma+PcYO0qlTRZSTY5S4dmKydkQG1ePTNuN7D9CgVmTAr8ji0gmG1Ir
 /no+DkT6HQ3TRVkJmgV58nHVwAJkQh96ANOnGvF3YBAD9m4nwQg/g==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgqnr85-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 01:25:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NNHjYI1117718; Thu, 24 Sep 2026 01:25:40 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbe1ujuq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 01:25:40 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68O1PeJ320316700
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2026 01:25:40 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E8F7B58053;
 Thu, 24 Sep 2026 01:25:39 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6902C58065;
 Thu, 24 Sep 2026 01:25:39 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Sep 2026 01:25:39 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: armenon@redhat.com, marcandre.lureau@gmail.com,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 06/10] hw/tpm: crb: Do not clear internal buffers when backend
 is busy
Date: Wed, 23 Sep 2026 21:25:23 -0400
Message-ID: <20260924012527.858527-7-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924012527.858527-1-stefanb@linux.ibm.com>
References: <20260924012527.858527-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab47c15 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=t2cqkf0TM92pdDbkWP8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAwNiBTYWx0ZWRfX83s64E9Uuffw
 86QCGqIQnH4HUid9Sr3GlDPpPG/r/lHcZDTWYHBaaWj+TM/ODMB3MzGGvfn8O3LfoFZUib7pBEe
 4YvIVPhzku6QfY7PHhKVg8axaEoGLvRLB/IuJtbspiWJXFXNaLtKUbzjR8t9bN5Z/IuV5rToll6
 fIVFcYDK3CzXiy/fSBrhPvmbM6miAx9v2S3xQ7yQK14obIG/CYX5EvRk1dcZidJEdrPiR3cb6Oo
 P1TagwYPzehai705xfwZuETfRVqrQQ99Iuq6TfiRMQTq25naTnrEwWO0FEjf0X+8QyZWfM5y1Hb
 VUdjBUfzvdM9ETOeWUkflDtfNgAo7RaURoRcY9rgf/ZbfKjZ7YvDQuTgnswmwx8mkvQijiAgmEJ
 dCAVXuk+U2kL8z4ptYBg8So0viArYiDTnfmzQJ5AKeC6vMQmlDbkAyU/J7qN/BBq7zlL85Zyfme
 wWpp+HL4gybk3TVom/Q==
X-Proofpoint-ORIG-GUID: z4af6tnU3UuRWbMcCI-eQihdPtQrfrnT
X-Proofpoint-GUID: pmwpNKiirUSq216Q4E5NmKqAxY4snsCU
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAwNiBTYWx0ZWRfXyPkczi8Po860
 JAfagvP57vL+g/di8yCm8JBRuM32nB/dDqR42fHshmPt/CT+9Ad91K+DZqHZyIVRUvj4W7w60qX
 dU39nb3LYYBmD41SpITEyXAZPT/PQeY=
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

While the backend (thread) is accessing the request and response buffers,
do not clear those buffers upon a command cancellation. Still clear them
in all other cases, though.

Fixes: 29315d22b259 ("hw/tpm: Add internal buffer state for chunking")
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 hw/tpm/tpm_crb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index 54fa2042b5..e5e33a3a2f 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -218,8 +218,9 @@ static void tpm_crb_mmio_write(void *opaque, hwaddr addr,
         if (val == CRB_CANCEL_INVOKE) {
             if (s->regs[R_CRB_CTRL_START] & CRB_START_INVOKE) {
                 tpm_backend_cancel_cmd(s->tpmbe);
+            } else {
+                tpm_crb_clear_internal_buffers(s);
             }
-            tpm_crb_clear_internal_buffers(s);
         }
         break;
     case A_CRB_CTRL_START:
-- 
2.55.0


