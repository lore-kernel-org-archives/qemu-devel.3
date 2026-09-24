Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95DF1C9830D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 01:26:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9YDY-00015v-R2; Wed, 23 Sep 2026 21:25:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1x9YDW-00014z-BM
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 21:25:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1x9YDU-0007Kz-So
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 21:25:42 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NNZah0414133; Thu, 24 Sep 2026 01:25:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=C/8P1YTcPWWPBzT3e
 FseSEm1cLaHJbQIYnaSM2V9uuQ=; b=s2ZTF338smj/mQlzg1itxZYbmjEd30A+Z
 CS2ZwNnPNXrWy/wLCj20s0vPKR9bBdBVWw8TzqLcbNCnd21AO5AQI0tYQtkRn/dn
 tZG9zseqA2ALDV4yIl/m3RCZsQs82jhlu0Y/LjV5LPTNts9TeUMI2wPTEwtsJD8Q
 EMApYJBcLdI7aQPoaO9TT8YlCFR/aGlRiz4t8J4PPjbZMlpPiyj55oxnoOhulK31
 pQv2FHchLFPWYuGxMvMGjU/FNdcLQQaF5qAYIClf4nuRvfsNzUF0m1ioe6vGzSSR
 zRuIEikByXwJVuo65uZWHYu4cmEirxHZwS5KcPt4VDyekS6krNk2Q==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1nvpq-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 01:25:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NNHU8o1079976; Thu, 24 Sep 2026 01:25:37 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbt2uf30-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 01:25:37 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68O1PbtU28180992
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2026 01:25:37 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4216F58063;
 Thu, 24 Sep 2026 01:25:37 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B2F8858059;
 Thu, 24 Sep 2026 01:25:36 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Sep 2026 01:25:36 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: armenon@redhat.com, marcandre.lureau@gmail.com,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 02/10] tpm_emulator: Reject TPM responses whose size is too
 small
Date: Wed, 23 Sep 2026 21:25:19 -0400
Message-ID: <20260924012527.858527-3-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924012527.858527-1-stefanb@linux.ibm.com>
References: <20260924012527.858527-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: mta3H4-PohUHbmqPLTwMoTkO0Ln6hn7F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAwNiBTYWx0ZWRfX21hRMCv9Wfps
 nckx+HsQx6Jjf50Lw5dNOpF/Z9drjZ2xz42ewzQJUop1oCbTHsUEvoXODeBgpwecPza3TpENyg5
 BcwL6JeBRM9FkPDo69CnBt2TvLUZzFNcLK4fCgpKFDw/v2NZfpv0Bvecml2z5y4BM7HqSrStRMk
 GvFPw5G5MVmR3g7XyCEj57bWrtGpFKdyvAllpq6OLF1SdpoMdZ+DxA+8nhrn3X32mYPk8b5Kojv
 1yW1sLv5hyxI/TBKPqBpCTYr9r5dxxICLjRi8Kq3WB1BWv29cee6NQhdfpmfT3Gbwdoh9YrSVZ7
 I2QYBeV4FEZHqe1QB8vguudjxn29Hv5Yv7SX60TjBZbzOnRgAgXpX6qx7rk7x4qfUGQiygiOvK+
 upfI9G4O+8eaWRQGDRtTAPSHA+vxUioFmtjaRvCo0b4mnLUGrBKteesAAHM65r5/tz0+u3g22D8
 e3uCqkPpm9UuttTHDmw==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab47c12 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=luQVlvl-W8lCxKXVFxcA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAwNiBTYWx0ZWRfX+ouR1FUXhSGB
 Gu4mutYRh5ELFJFx7yFZu/48VeL1HpOrHQn3XtR7z/43DZMt95RUn/QVzqls9y4GzMFjWxZg/pU
 KyCDUgTpGKNaswpJzObfdLW0Vw5eVfs=
X-Proofpoint-GUID: UTJZm0n8j2iEZCY5rvWufLEWAdxW84B0
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

Reject a response from the TPM emulator whose size field indicates that the
response is smaller than the size of the header.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 backends/tpm/tpm_emulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
index 16ae44c8d7..9c95b4d878 100644
--- a/backends/tpm/tpm_emulator.c
+++ b/backends/tpm/tpm_emulator.c
@@ -202,13 +202,13 @@ static int tpm_emulator_unix_tx_bufs(TPMEmulator *tpm_emu,
      * size)
      */
     to_read = tpm_cmd_get_size(out);
-    if (to_read > out_len) {
+    if (to_read > out_len || to_read < sizeof(struct tpm_resp_hdr)) {
         if (qio_channel_shutdown(tpm_emu->data_ioc, QIO_CHANNEL_SHUTDOWN_BOTH,
                                  &local_err) < 0) {
             error_report_err(local_err);
         }
         error_setg(errp, "tpm-emulator: Disconnected after receiving "
-                   "unacceptable large response (%u > %u)",
+                   "unacceptable response size (%u max: %u)",
                    to_read, out_len);
         return -1;
     }
-- 
2.55.0


