Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B43BDC98304
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 01:26:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9YDb-00017q-LL; Wed, 23 Sep 2026 21:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1x9YDX-00015e-Us
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 21:25:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1x9YDV-0007LQ-Cs
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 21:25:43 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NNZSDt3589066; Thu, 24 Sep 2026 01:25:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=AZAtuypC0ntxk3hzW
 hwRNPxjszOzQm6rhrEZ8MK3qH8=; b=gqY2LdJBpZFjVeRNG1N2u/C61A8ita/Tu
 WsoYkg/rbBnu6lkikFDhR/nQS9m5Vtv/sByfvqjuZvrRYi6FT9dHzYtS+TIWQVoY
 8qrGYeSE7c/vR8Ufu6MfUQxddhC8hCxFkeGO8o+yVfbREIGsS06LNNPdH3/q8okV
 /qP7K4W7Hs/4fHDaxp2e5bhBkrQqe2sk0mo4z0TVFCg2gYS41Sjur8F+0shD36r+
 NNEy5dg/CRuYawZY/fHtgxNnDULFsJQ56CVw0gIQMo4BTfDc8q4yUhymWEvwOdBu
 tGmeT+IM7XQ6aHN1T/HnBwE3QrG/oG11S0PhpuYHqKBqk6jn33MTQ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgqnr7u-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 01:25:40 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NNHaIc1132960; Thu, 24 Sep 2026 01:25:39 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvb8jukmh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 01:25:39 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68O1PcIW51118504
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2026 01:25:38 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9480358059;
 Thu, 24 Sep 2026 01:25:38 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 13BA758053;
 Thu, 24 Sep 2026 01:25:38 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Sep 2026 01:25:37 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: armenon@redhat.com, marcandre.lureau@gmail.com,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 04/10] hw/tpm: tis: Only read from response buffer if
 rw_offset < len
Date: Wed, 23 Sep 2026 21:25:21 -0400
Message-ID: <20260924012527.858527-5-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924012527.858527-1-stefanb@linux.ibm.com>
References: <20260924012527.858527-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab47c14 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=vkKK9v0PSp4LbjciNHkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAwNiBTYWx0ZWRfX6aQZ93Csaqf1
 bmlKzAqq+kbRCwDch4h44AePaRbnHn/0nfOn5eaHK4FG4W1cgHVr25qMB/l5uE5TP7Ej+jkcvw0
 EskJPTVaC7o41ac2r9hyK3WRlFdD8aDFlHD5wAoyQLt99sN1rI/MD7QDrzpkU95nTHO+Sx67XRq
 ytXrEv5aZ1dXcwi/eoS5bjSdnZHJTWrOY86jZUzgiqPz519X0tsTOeL2CVSo5243Oue+lpCz6zc
 hqdnI3BZT7ji1Ouo8JGvUnntcNeri9NM4YSyNBTJKAU2FF3ifwFb58NDhtsXZB/KKELsokuuDLK
 tyCqWUsxO9z1hXIFdo79OOgT9518Q2nIFq1vxyFmK4uy6hMuaD65qk1Um5Uy0ND1ihImm1MZlin
 7cUeXd8bMyz9CbIS1akhLJtk7iNzhpgZ/OQ8ewYzAzWERZz0Z70QYfh2QYgsCmKXEwBy6hBpG54
 +kceqgEtYLcQ9PP/7Og==
X-Proofpoint-ORIG-GUID: QHIt2qrCwXv3LEm2aHB_EdNbd_bC1ywP
X-Proofpoint-GUID: 0WRTChAZSOfjM3QjVzxAcSeUOxE2YyjX
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAwNiBTYWx0ZWRfX6Gs0PvM1Zy/D
 Us5rDVzRMl7f8kibu7BHWF4aEw7ryclYkN+p5kuxqmyt5+PZTRj32X3pu4rkA/f9dNE7IzKNhmH
 Pg6f5VoWN1nosnH8VJg0uoBWQWd+mZo=
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

Only read a byte from the response buffer, if the rw_offset < len.

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


