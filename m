Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B66CDC9830D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 01:26:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9YDd-00018w-4g; Wed, 23 Sep 2026 21:25:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1x9YDa-00017D-05
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 21:25:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1x9YDY-0007Mp-JG
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 21:25:45 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NNZlTT414704; Thu, 24 Sep 2026 01:25:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=tLYEIblOzEmNHQuh3
 qn99Lmn7xhBPAFY8WYRwUa2fu4=; b=O6O8Qoee53RvIz6wJPadTbwXFZoSSPwod
 yjFSjtRUY0/Hic6NfTzo1ctHatefe0UZUQihhjAf8oZhDmBJ9F8tcW7KoXITWjm7
 AMIXso/alep+fGLDuvvfgv0WKd6th9uS3VUivqtziB7MYVMQ9Kgmq5NOibsOF+11
 wzbHcjDQQBf2AEBPmt3IE/RwZGqVkNGKb61QBjaZmluhuGsZqssQ0Ic/+0S7kCYz
 DeiRlL1oxHFdnx31KQ7XfljB+vqvuYM0w/xtPtPbYEcFucuO4bQvDN1A1K0ruu6e
 SPnBapeDb9AlsNwomvL6TT4amas7Zfn1wRy4/krDWUV1jTMnK43MA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1nvqd-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 01:25:43 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NNHlD14029827; Thu, 24 Sep 2026 01:25:42 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gu5bkkka7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 01:25:42 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68O1Pf0165732924
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2026 01:25:42 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D9CD658059;
 Thu, 24 Sep 2026 01:25:41 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 63D1D5805F;
 Thu, 24 Sep 2026 01:25:41 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Sep 2026 01:25:41 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: armenon@redhat.com, marcandre.lureau@gmail.com,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 09/10] hw/tpm: crb: Consider response_buffer->len of received
 response
Date: Wed, 23 Sep 2026 21:25:26 -0400
Message-ID: <20260924012527.858527-10-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924012527.858527-1-stefanb@linux.ibm.com>
References: <20260924012527.858527-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: RN2Pe6-yrt5HGEKwRAoCjHO37SlfzhKO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAwNiBTYWx0ZWRfX69ce0Dq+sED8
 E8y98VhtEbZREh62Cm/T4awC9a0wxTFHoW9MKBrC+tPV3sarMxhs4/gtsd5Xsu0utjcEo+6hI9v
 GlOb2nTBs1QHodHcRjwZz83in5/TADRKQ52LB5ANN4/TTvU9gzz/WV9gOUvARiCQjjqwYhQHgYB
 0pQFXpBXRBrlHDxWSUQUa9f03+PB3ht73tbiGcetdrCd2SdlZqWM+EkFV6l8WVeosCDNENu1nR3
 6Z6yEW+bk8L+L/7pygkv+9G1TAL3YixXT+pTX/ipgBVlRv7/7WTiMlEW9aDEGnrN4QDm62l2ggg
 zwXyEzs+y/VOEM2w1uSUtYrhwkRlzczCKl1CeCt8i/jR4iNEB7D/LjNOvifwv7uEHH6p1JIE9I1
 IDtWDj+XW9SUkAmh+1/X8p1M96xIWzSswdzziXDsHpj2kWzXR0LYZ9ERRev7pcg6NuYmHCOuQIv
 eFi2N9D83F+CaV6RKng==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab47c17 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=rD1lyLEvv5Bxigb_1PMA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAwNiBTYWx0ZWRfXxbc4AI4P+DAj
 kCjDsGu+SaoTBfmlcpt/9VGYUur0tLWF1wE3Ne86OKwNJLwXOjBUiigs550evrI2NKxDoTXUPag
 /3cpSNlkBVC61C7dAMAFeSYez9MiALs=
X-Proofpoint-GUID: xnIrTVGTHE_4jppvxA3CX992bpWzh9NB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_08,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
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

When the CRB receives a TPM reponse from the backend, then reject responses
that are shorter than the TPM_HEADER_SIZE. When determining the size of the
reponse, also consider the length of the response_buffer as being possibly
shorter than the negotiated backend buffer size or the size indicated in
the response itself.

Fixes: 2a660ad67d15 ("hw/tpm: Implement TPM CRB chunking logic")
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 hw/tpm/tpm_crb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index 4bd1919952..6ae2261b43 100644
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


