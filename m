Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A28ACA6016
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 21:31:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEvhe-0000hA-F4; Thu, 08 Oct 2026 17:31:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1xEveY-0000Mq-Qr
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 17:27:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1xEveR-0002pM-7M
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 17:27:46 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698L5MOw2404585; Thu, 8 Oct 2026 21:27:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=V/AW9K
 pTFcK5sdrWXmW77PRj2bpt+aHLmYbZhD5jx98=; b=FfJwrWaj+pS4ioLlBNNZr2
 xyoXrRs/yQoOsKFlcm7UZzSFlpf21RG6whxv7jDa4sPUr5ADrbvMhzkAnO1M6zz8
 OyEhXnoJTYXY9GIfy1ltk9MMXuLhD0VURYuiEwkCZdX92mUn87OuRWBh1ubALSB3
 HFjk6Bi7LAQF3gJNvVwyzNCyQTXUQ32TgKavLdIpMxV/GD4/hehjJXqO56OyFwlN
 XzQmMTjalMcxEbmCrrAhfutPbiGNBu2e+jLOsVSfHI0d1GrH3iMqQE2TqhVn+v39
 /QKiS/o9yjENEL9wdoFVNy+AfF0Mlz9Mle5L0oXcbM9ysL17sXB5JIKGzf/Ol9SQ
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjvepr8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 08 Oct 2026 21:27:31 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 698L2Wii4019440; Thu, 8 Oct 2026 21:27:30 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h58d5sgun-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 Oct 2026 21:27:30 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 698LRTRp5833276
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 8 Oct 2026 21:27:30 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A06A25805A;
 Thu,  8 Oct 2026 21:27:29 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0DED558054;
 Thu,  8 Oct 2026 21:27:29 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  8 Oct 2026 21:27:28 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Stefan Berger <stefanb@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Arun Menon <armenon@redhat.com>
Subject: [PULL v1 06/10] hw/tpm: crb: Do not clear internal buffers when
 backend is busy
Date: Thu,  8 Oct 2026 17:27:19 -0400
Message-ID: <20261008212723.3679685-7-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261008212723.3679685-1-stefanb@linux.ibm.com>
References: <20261008212723.3679685-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: A5SQq5c3E8daQiVDF-kns2qoxWyfIjAF
X-Proofpoint-ORIG-GUID: A5SQq5c3E8daQiVDF-kns2qoxWyfIjAF
X-Authority-Analysis: v=2.4 cv=H8NOUOYi c=1 sm=1 tr=0 ts=6ac80ac3 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=BuBLyuNp-ztxktVGuZUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA4NCBTYWx0ZWRfX8W6Uzjw92BhM
 rvCLV1yHKMKCBP7jChNUjR0xCEoA7C1DcdN9plZNH1eOQ8Z6x5W+Meo7wKnjrYJyNK/lBmxuO3s
 NQkz6CyS+kq4XLvLuBzmtCoyULfdwj0gpHbxvY45O9PhKdOZ9Z32TEx01saGM3ZGcD8Njp+KX9R
 fWzyvEYYEo7c9x+XnTaR5im2OgFYlAJGnURy/OIvDkPKtQwAN+WBiNgI2+5B24B2FAamRh8YHUy
 tisWrlLl5F/7rslAMG9iW6TKn5U2/MRlxgfDg22yIGb1pfGGHmfx0FJlv/gufCKGw5CZ5GPDO6z
 xQv2z7bCzNPkmfJGy4cD83SUVCW4QT9rYiia5o1Z5X7jMEGxmBprAcsemofk9X0PVy1lJd7SYIK
 oPIl2oEGuhWwe/hl8tvxXfE22vSyBHaPGX4CKHgcV9PhPrV6sCz2YZX4giFo3Vbv5s96CuBAO0N
 CdtVsVJprjxnPz+0FEQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA4NCBTYWx0ZWRfX4mlhb3HMgpUs
 oYfmXi2Vl+5/0oiYRGDbP8spa65V55JbhMBf3IvPAFFRCQCF0lS1yA2pEVJW2GvUkfpKMJ2pt+i
 fVWRDdwVo5gg9nmxk2ODc3Dh4zafUbU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_07,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080084
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

While the backend (thread) is accessing the request and response buffers,
do not clear those buffers upon a command cancellation. Also, per CRB spec
the TPM is expected to either return a normal command response (command
could not be cancelled) or an error response indicating TPM_RC_CANCELED.
So the response buffer must be able to receive a response as normal.

Fixes: 29315d22b259 ("hw/tpm: Add internal buffer state for chunking")
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Arun Menon <armenon@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20261002142516.2063735-7-stefanb@linux.ibm.com
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 hw/tpm/tpm_crb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index 54fa2042b5..daf451aa56 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -219,7 +219,6 @@ static void tpm_crb_mmio_write(void *opaque, hwaddr addr,
             if (s->regs[R_CRB_CTRL_START] & CRB_START_INVOKE) {
                 tpm_backend_cancel_cmd(s->tpmbe);
             }
-            tpm_crb_clear_internal_buffers(s);
         }
         break;
     case A_CRB_CTRL_START:
-- 
2.55.0


