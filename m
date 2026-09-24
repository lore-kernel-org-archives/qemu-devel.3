Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C59C98315
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 14:41:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9kd6-0003WA-2A; Thu, 24 Sep 2026 10:40:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1x9kcq-0003SG-DI
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 10:40:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1x9kco-0004Xz-09
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 10:40:39 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OC62X32190425; Thu, 24 Sep 2026 14:40:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=VDXyzN
 sErWqBFruawXP7XM2kGjXa4HH5YRBaOWJo1WM=; b=d7w6Ct7Ky7ubQSZtuqorz8
 VNrHqKMToA9+bQiDvkNI+piuvJz6caKRrBzMqsM8eszhYTYFFtZ+rkRb6tRekzqC
 36LrqFQUkMPYWIUp+1cedc87mj56x1wv1uOSAmeOZ3I1B4sIPD2wplZkJLmxJRBR
 hmR/v09j2RWrioX+zCR81luLSJ40ev9zEkPXkoNKtfTbkq5Vfh4WPzQ+I7pnBPY2
 T8gyTcqx6zVhQ8+DbazPFE5NA+kwAIb8jn0K9Y7NMg8wexXwuEccolzi2671BGk+
 GrbFml0mXoxAgoQIhnJw0TvvqJpeyFLgV0MvvwWUFWo1tUIGISBSueWPqfL2uOOQ
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg2sshs-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 14:40:35 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OENgd12188223; Thu, 24 Sep 2026 14:40:34 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbu8x5hm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 14:40:34 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68OEeYqI14746296
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2026 14:40:34 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3274F58058;
 Thu, 24 Sep 2026 14:40:34 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 946F75805C;
 Thu, 24 Sep 2026 14:40:33 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Sep 2026 14:40:33 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: armenon@redhat.com, marcandre.lureau@gmail.com,
 Stefan Berger <stefanb@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v2 04/10] hw/tpm: tis: Only read from response buffer if
 rw_offset < len
Date: Thu, 24 Sep 2026 10:40:20 -0400
Message-ID: <20260924144026.953360-5-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924144026.953360-1-stefanb@linux.ibm.com>
References: <20260924144026.953360-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: cCb8QFDlKT8Oa-F1jQg5i92HHbE3_nza
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab53663 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=vkKK9v0PSp4LbjciNHkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA2MCBTYWx0ZWRfXxQwQoGYlKZL7
 0vfbZHKW8CvZpzgvz//4ifhcEXj+f/tpDMJF6Rq7fBcIWYPYQFIrXB0tT5+MGNfxRFamTL0d6G1
 n8sqG5By2jlU3kgesfqwbW2a1KTZCMt/TtDo+QERYSX0/4QGh0e5v9B9l77mr50hfFUz1n5DGVI
 ptxYdD1p5RaFA4P6jsf4d/3GD/V+Xh4lI2ydLcYHhqmkN4yXVtgRxcagF354+XrxGQiC6CTcJ2k
 Qra6xf3tgSNfIFfEgKt9Da9d3fjUMBART45txH1RdnAh6Khpt4auUES4mnIQTw1wCDJPpcpy/KP
 Zd+XVgn0eKqyWh2/sPsr6l/oRqLMukXGxrfl0DDxHWA+RRLbhHt4oY237h3wuOskOPplgAwjDio
 pMbtaqZ6Zctiy/We1iViw6px6CJPTrwqP1VZYTNmz0UCk6voG/J4H8DSjpj0j2bDMW2B0J3LhI2
 YL91s8Y86MbtkuBBKLg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA2MCBTYWx0ZWRfXw0+paNbZYefe
 nyrNOsbSnhn6pKPlyPnbreLXqR5YVxz3csjo7kDZIJ2gkkegLd85+ZCUHTotxYPoC3ELAPL6uAk
 WngBYAdWfY7qiCVe4G+F09GB8+NdDlI=
X-Proofpoint-GUID: hvWysxbYPo0gvcWUe89FDUJkqnWvhUdm
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

Only read a byte from the response buffer, if the rw_offset < len.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 hw/tpm/tpm_tis_common.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/tpm/tpm_tis_common.c b/hw/tpm/tpm_tis_common.c
index a134d5c205..4ba228116b 100644
--- a/hw/tpm/tpm_tis_common.c
+++ b/hw/tpm/tpm_tis_common.c
@@ -273,13 +273,15 @@ static uint32_t tpm_tis_data_read(TPMState *s, uint8_t locty)
         len = MIN(tpm_cmd_get_size(&s->buffer),
                   s->be_buffer_size);
 
-        ret = s->buffer[s->rw_offset++];
+        if (s->rw_offset < len) {
+            ret = s->buffer[s->rw_offset++];
+            trace_tpm_tis_data_read(ret, s->rw_offset - 1);
+        }
         if (s->rw_offset >= len) {
             /* got last byte */
             tpm_tis_sts_set(&s->loc[locty], TPM_TIS_STS_VALID);
             tpm_tis_raise_irq(s, locty, TPM_TIS_INT_STS_VALID);
         }
-        trace_tpm_tis_data_read(ret, s->rw_offset - 1);
     }
 
     return ret;
-- 
2.55.0


