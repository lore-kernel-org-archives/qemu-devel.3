Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE43C98315
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 14:41:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9kd9-0003Yu-Qu; Thu, 24 Sep 2026 10:41:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1x9kco-0003Qc-VF
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 10:40:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1x9kcm-0004Xq-83
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 10:40:38 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OC6Qmf2183769; Thu, 24 Sep 2026 14:40:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=IAH3CO
 OHbUwd/msYhDNKJmyyzPJ13MIZ3bHbPT6lAfY=; b=PRSwn0eRpibMM5VCFobWEu
 Fknf+62F6WCnfKcHdtKPLv5nzWfKOz6iPoQSqk7dDySsl/G72WlKxPM5k1kb7+o/
 Va4F0V+CGcpXGFNRRB2iApUF5xnbVmUQosxPxOtQKpydWAwLoCDZ6fiXi1+L6s9Y
 N3FwGs0OEiPsAdo7T2HkBMToyispxXWVRf4zHa/7zaAKUqfpRvfRE3fLh3ml0EQO
 gcXDuvOGo+MK7SC2EjIg421YmZn5IokfQ6Fzuzm4TXd9LKpXClQDuixbqn2zY706
 KiGaMzAim/hfE4/YmJ1xcwL54Jq2UGrrPiuA074eU2UYzuu42Pa73U1Mrx9Oh/NA
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgshp20-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 14:40:34 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OENofa905541; Thu, 24 Sep 2026 14:40:33 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvu7eag3g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 14:40:33 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68OEeWoo29950500
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2026 14:40:33 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AA6C05805B;
 Thu, 24 Sep 2026 14:40:32 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 18C5258058;
 Thu, 24 Sep 2026 14:40:32 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Sep 2026 14:40:31 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: armenon@redhat.com, marcandre.lureau@gmail.com,
 Stefan Berger <stefanb@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v2 02/10] tpm_emulator: Reject TPM responses whose size is too
 small
Date: Thu, 24 Sep 2026 10:40:18 -0400
Message-ID: <20260924144026.953360-3-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924144026.953360-1-stefanb@linux.ibm.com>
References: <20260924144026.953360-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab53662 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=luQVlvl-W8lCxKXVFxcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: oHNPlYPnWiGznFAmhZQI5PBRs6e6Jlap
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA2MCBTYWx0ZWRfX7/Al4N+9DsYS
 uNxJDADaT74h7YV+RmcMrj6mgVgrxYiZP8shCCuHG5YNIr+0b9cdym8t9OIWyKGh+x64XONFlyL
 0RoCHxLR7oPDx5S3LbJitWd+MuXTzTcgXxBt0tYnBQBVk1Bnu32+ng1NeIQHHJUUnod8fohDKvs
 QmE9g4wnlccyu0pa2jYlF6aE8EXV+d6osPyyETEZ9Bf1MNY7H2BY5chYQ5aRYP8AWeoYCvoH/RX
 +dBvL+UZnDykv7/2/RVYkDKCiRdrcWNMVQIc8J6nQYIXTeov4N3P3QqmFttApp1JNEa1zyQdfK8
 QIIUBzv2Qne70ErT6WszNq5cOxbAkq2a2MA/uomAbgNh/kByWk8z4p/XrsAXH/9J2fP40D9ZlVO
 rdS8q79LHtyQJTUeTEY40eiyD0/fwI/jcvjOQDuKm8hDiDShGVFShTDld9s1VNI2B6sWqGLm/C0
 TbLpVLWdAjL5LJnPxtg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA2MCBTYWx0ZWRfX4/uSFJqgQ56H
 dhnmfChfTjxT91jwc8m66WlCNRUOnsOVUB2wBFu6m8js4YD9oCVPv1U4lcOkZan3fgBPvCgtibd
 eBBufPFn7Iyt2o9WCcKSMVZwhBfD1fQ=
X-Proofpoint-GUID: Sb2_YY68dMrEdcvOssvNWkbO_7ZPCFOm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
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

Reject a response from the TPM emulator whose size field indicates that the
response is smaller than the size of the header.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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


