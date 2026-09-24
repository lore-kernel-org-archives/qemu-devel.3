Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0C84C98315
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 14:41:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9kdI-0003iG-Pw; Thu, 24 Sep 2026 10:41:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1x9kcp-0003Qd-Ij
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 10:40:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1x9kco-0004YA-0F
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 10:40:39 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OC6QAn2028664; Thu, 24 Sep 2026 14:40:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=9bDV08
 Jmwh6JRh6rrYAlnyokrdxAuIEUpc1OuGF7CUw=; b=pDC5t/Gz0UlM0PT4R7Vzo0
 n5xNdTXFtJxxZP3hp+mVk6U7Fo8q8tUcHBcQHuXoUVYTZdJ6NtpPcq0qYbFcIqZc
 VC3Dcyi8i8zx4CN+L/d4G6qqc9ySjD36GU3d0++WuDjN5m5wdg+fbtsGMxEFwCId
 dId9X2FVzJRuSFSzo+fQUqpGxFNNONjaWmE2JEMpnspqWwcnGiCf9cfb1N5Bhu+J
 ls76HPLdDE2rKeNVKWw/T7HIxFCTaSIf4UzwgHmHFyDZg9MOdxz+qXnU0L7yAFN6
 /M0AZ7IWyQgw0WqdheZiZdVrgFLcvtFYgirWxWm1K4Gwo7+4oUA+M2X21LHmKoMg
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1s2vv-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 14:40:36 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OEOoY02194320; Thu, 24 Sep 2026 14:40:36 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbt2x5t7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 14:40:36 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68OEeZFj17826450
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2026 14:40:35 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ACE8358059;
 Thu, 24 Sep 2026 14:40:35 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1B43658058;
 Thu, 24 Sep 2026 14:40:35 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Sep 2026 14:40:34 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: armenon@redhat.com, marcandre.lureau@gmail.com,
 Stefan Berger <stefanb@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v2 06/10] hw/tpm: crb: Do not clear internal buffers when
 backend is busy
Date: Thu, 24 Sep 2026 10:40:22 -0400
Message-ID: <20260924144026.953360-7-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924144026.953360-1-stefanb@linux.ibm.com>
References: <20260924144026.953360-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: xggpW3WY5_hgcreYM31QC2hMV1A5tziA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA2MCBTYWx0ZWRfX5xQSM5t7e9mr
 NTn+qRkz/raTmnYTxmnr+7iG/5YZEAQz3l0TyB8wEJKQrE4WDuziD9EA1mhZSuR7nLN71mYj259
 tnYROrsEJuaiS8McVCkGpKuFQc1Zi9xN8U9IR8bO3oGRUfoZxdSJR/8mgQWjYY5YUnojk7gRTVd
 qpMJzlMrFSyO4he8cxrdVUqXrkRBPoje4EWkphVdwV1j1BR/el81S6L/W01B6514sc0G6HXRzZ9
 OkEzBEBT9V2X5fy2idw7jnT4Z+15BDMjj4kQLVriRT8PGiK9N9YkcTPjgPPXvp05ZUZka99uG8k
 93NpKtrGpp25SpsZzfk0nG6LxLnnTx1O4IVsDcF7xI8t9DVEGLS6zD2FEwZP2QKB0EpI58gqsyu
 o0aKjx012Ht6G/U2iSzwE6Dh6U9eXQ6RWBzf4LqtvRIuB97ZSruI2k6YB41ApjopyY6oMZvQd2l
 zH7E/Z9hO4Uglfu6yjA==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab53664 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=BuBLyuNp-ztxktVGuZUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA2MCBTYWx0ZWRfX/OW32f6A9ihy
 z0PAj86OLg3MLDoZ51qwvkxWxCD5MXtkf3q8iEVR7rhyPqqaCMYB0ZxKEJdQtQ4+pFvXA8Ppf3N
 WqWbZaZ1WDtn7Yn5YkuzMQciRDKsj/k=
X-Proofpoint-GUID: PCNljNAddMhqEnX9zvBTzejvrgqfSdFx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240060
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
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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


