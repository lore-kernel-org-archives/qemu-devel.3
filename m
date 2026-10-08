Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0040CA6015
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 21:40:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEvpx-0003es-GU; Thu, 08 Oct 2026 17:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1xEveY-0000Mo-LP
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 17:27:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1xEveR-0002pC-7d
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 17:27:47 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698L5e8u636427; Thu, 8 Oct 2026 21:27:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=JSvJrO
 81RqLObDStTCWet/pek3AOdj5tNqvFmWSaSTc=; b=rWcwRvBBREJzS/1eHgtfP8
 Mn4s6B1GDTdraVbfMO+vltqVDH7cEjfkvZtvCMuanoMT8NqqSUzb52Ia/W6yqjNE
 ePWyozBOabGJQMtMGXyWwa0HCZ9K+h2YuQZFCW2I0oTi/skhXdOpVtwYrakh37Wx
 6L6mAdFweg7L9EXdL88+btAHYCIS8uVAc3Sfs1bgBaz7laFSvoyxhO6r9Fv5lJh+
 SL93gv/pl9axAYcT5lynfpHjgkX9iZAXdEynNds1CiThcgGkcPCFeLKsvgEq0SQM
 dRym66zEMmWXRiiYrE/wrRAyIZFOrV9gj1rWjhTe1TtqJpzDn7WapV9sLzxAkspA
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjw6qxx-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 08 Oct 2026 21:27:29 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 698L2W372801360; Thu, 8 Oct 2026 21:27:28 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h5f3u07x7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 Oct 2026 21:27:28 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 698LRSYf19202562
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 8 Oct 2026 21:27:28 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 376C65805C;
 Thu,  8 Oct 2026 21:27:28 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AB89358054;
 Thu,  8 Oct 2026 21:27:27 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  8 Oct 2026 21:27:27 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Stefan Berger <stefanb@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL v1 04/10] hw/tpm: tis: Only read from response buffer if
 rw_offset < len
Date: Thu,  8 Oct 2026 17:27:17 -0400
Message-ID: <20261008212723.3679685-5-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261008212723.3679685-1-stefanb@linux.ibm.com>
References: <20261008212723.3679685-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aqASBWx3UtABMZ-jKi1s_6iXH94kJmsu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA4NCBTYWx0ZWRfXy4Szk7ouN9mb
 ZQw56q4vWTrwO/FMDYcWtMbehFlxq3qzIS/xaSSBjXLsWWzLsvywgvfc4jKieTZjPOH1qMcZmU+
 Z8kqd/vIfRskgclP7ABiQW3lLDSTDLX7yf1b7YaP+Qm5LzKRTRdIsz6tM8LiBD5xVVsFf3VMVKQ
 qrwZUTeJ3wwqSFezJLpIxxY2FkIlmgadyeDC9c1WwfD4Te7sHGpli+6SiR5+yI4WuAn6MhVSUUf
 q7JNjvhS6V44z+av1jLVGIcX4wo2neet2fttegKElNwEVW7kok4k+K7EQH4KwWMk7ynsWI7IkcD
 tgND6S9evxy7wQCt4mv0EZLFQrycGh0fEA9ITzxS2sNS7ndXOT7t0T/hyNCBcavOvg4jjgKzF7s
 C6f+1+tIcqhJA1KQKLKChVo9bPkWpmaSbTPPraPLCbgJTSLvozZabVs2Demq4UvOMIsAzFAbR95
 W1PO7PcSCACimIExdjA==
X-Authority-Analysis: v=2.4 cv=cIt1IVeN c=1 sm=1 tr=0 ts=6ac80ac1 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=vkKK9v0PSp4LbjciNHkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA4NCBTYWx0ZWRfX2CKy4AwiyPGa
 AvPp1J///pxNzPulscMfQXIeAc02X0UiAIg8CjkOFWqvVf1muSA2STSQlp/pYQSm5uGly4rS6Me
 Ax52FYKaR0J3jNM4QBGFIHKfgpeWhx8=
X-Proofpoint-ORIG-GUID: aqASBWx3UtABMZ-jKi1s_6iXH94kJmsu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_07,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0
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

Only read a byte from the response buffer, if the rw_offset < len.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20261002142516.2063735-5-stefanb@linux.ibm.com
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


