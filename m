Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2832DC9830E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 14:41:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9kdK-0003k2-Pa; Thu, 24 Sep 2026 10:41:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1x9kct-0003Sw-8z
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 10:40:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1x9kcq-0004Yu-KL
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 10:40:43 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OC6F1N1009604; Thu, 24 Sep 2026 14:40:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=6obO0Y
 0/nzKyGLLRCIa7C7WxFCgkgaTn097GJOWAVig=; b=SLzug00Y7M2954XIErebZb
 7KDo+Xpoc1PWpKBfodeV2hCTDPcNM9ZD9qnyltGzoZ1ltshgifKKm2kWUKY73VGQ
 +p1Y0Fi7XdtfKlLh8Yh6skLE2eGEcMqxl0voeFQIvqjxc8D/rLbo4e6MVVJWMSIq
 +cqPsFqKASF9BJySE99ZSW5odPUQ4YofUtAbVHtzc0K03f2YDc0DV9eUKE06p1sh
 9knqVPoW231PrRVzMolgviFfmAqJEeP8rZ/E35YiDNQm372//GDCQt+/24B0xg8B
 TFUmMV/IBTAnxsGATO1QhuAPgPewMtY+Ruv1+YFi1dz+DDu5i1amNp6+jt9Xklbg
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgqrx4b-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 14:40:39 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OENmYT2245773; Thu, 24 Sep 2026 14:40:38 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvb8jx9sr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 14:40:38 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68OEebHG31982328
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2026 14:40:38 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B893B58058;
 Thu, 24 Sep 2026 14:40:37 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 308275805D;
 Thu, 24 Sep 2026 14:40:37 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Sep 2026 14:40:37 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: armenon@redhat.com, marcandre.lureau@gmail.com,
 Stefan Berger <stefanb@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v2 09/10] hw/tpm: crb: Consider response_buffer->len of
 received response
Date: Thu, 24 Sep 2026 10:40:25 -0400
Message-ID: <20260924144026.953360-10-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924144026.953360-1-stefanb@linux.ibm.com>
References: <20260924144026.953360-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab53667 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=rD1lyLEvv5Bxigb_1PMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA2MCBTYWx0ZWRfX+wTQLBiYP4ej
 so8V+eowAvkhJKC2XaNFkdGRIPbaeKYWpryr0s2C/DS0v2u3claGsyrQzygnqSP4MVTrjDBBo7e
 s4pIb10LwVuFWhFKLee80YcqhGNaCOqaq5v2piaDsL62C+xJE+tK/lG0lVclZ6K2z3r0+CT4rXN
 3om4MFyFjgE7/9kB0MciX0hhNBI/+OFvu7rFGfn9h+lFhKG/d3g7Vx/OaTcXvmaEm6H2GGm5raX
 tD2BHl5LRekebqRfXVgk1+uAWU/2dpnlOmRWCSocZnigdKY3g8X+v+XMkYF7hwH8VAzATJiGIsm
 7Z8QzMBmL7PeGjGe4c9Fn7kWImOt/kZTI2UXTpoeO57Np51Ofnc+YkqDZ0t6844gT60wLdRq9rE
 UUaq0y3N/5ODOjOg9UADu6DbYVKHjDsufTlOlQazXyYSQVkAd1ypav/uQQ2KhOKo9B8yRpMO1UX
 Sr9onIIWmOtSltz8fgw==
X-Proofpoint-ORIG-GUID: HoWNwsBBNuaGEiUsbtHX39aC0xiBlZJ9
X-Proofpoint-GUID: OE2gRIX2WpN-i0AOpzzesvsWMaybVb-S
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA2MCBTYWx0ZWRfXwGjP3aF5xDpa
 8dl1g1GYDYpCdKsj0+QbBoI4J6bf11MQXASTOhMr4XSf2L4V9Yd7U57PwjcJZOzMNivU2Hmsg5B
 7LB/Gh6dBG7Nz6DAFXKj6TejW1PuZ2k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
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

When the CRB receives a TPM reponse from the backend, then reject responses
that are shorter than the TPM_HEADER_SIZE. When determining the size of the
reponse, also consider the length of the response_buffer as being possibly
shorter than the negotiated backend buffer size or the size indicated in
the response itself.

Fixes: 2a660ad67d15 ("hw/tpm: Implement TPM CRB chunking logic")
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 hw/tpm/tpm_crb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index 92d36608d0..5c6965f447 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -325,13 +325,15 @@ static void tpm_crb_request_completed(TPMIf *ti, int ret)
     CRBState *s = CRB(ti);
 
     ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, Start, 0);
-    if (ret != 0) {
+    if (ret != 0 || s->response_buffer->len < TPM_HEADER_SIZE) {
         ARRAY_FIELD_DP32(s->regs, CRB_CTRL_STS,
                          tpmSts, 1); /* fatal error */
         tpm_crb_clear_internal_buffers(s);
     } else {
         uint32_t actual_resp_size = tpm_cmd_get_size(s->response_buffer->data);
         uint32_t total_resp_size = MIN(actual_resp_size, s->be_buffer_size);
+
+        total_resp_size = MIN(total_resp_size, s->response_buffer->len);
         g_byte_array_set_size(s->response_buffer, total_resp_size);
         s->response_offset = 0;
     }
-- 
2.55.0


