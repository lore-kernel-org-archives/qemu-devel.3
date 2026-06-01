Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF41FCD6E55
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 21:56:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUAap-0006fs-4h; Mon, 01 Jun 2026 17:54:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wUAam-0006dx-KU
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 17:54:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wUAak-0003t3-Ju
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 17:54:40 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 651F44V13293469; Mon, 1 Jun 2026 21:54:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=jeyhXa
 FdJY2BoFJuoMUUM6D/5c/d58X3M/k8NhX0gjw=; b=geT1n1ogBzzJu4IFVKDLJD
 QHre90eARtSmMaIFLs9SAWg09UH83whuWST05hLL2O6ItIrXgXVFiU9uC4WPo9yU
 aX2zFPfKpcOcmEKdD8N1cPkmklHVPKg/EDXEwlWwPQ5OtHT8VgOKS8+wk6mBvpZY
 eyqAwPLA0hzWZeCja8DBJe45jJGaau4nUvr7G2Fz3YG//R96W+sVXcyyM4fVS3a9
 iQL5GNr2jqnGta1db46v6VaYyvlGqcZwYdSfLl9GH1xMf7hmmM3cuV4/9EV1jL2b
 qbZftLgp7T1PTtVk0v9kPi2El5SV6SHrkuMTBrasEOtbTSjXT0CEnVkSbFt8huWQ
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efnahjwht-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 01 Jun 2026 21:54:37 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 651LsFMA029581;
 Mon, 1 Jun 2026 21:54:36 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egb7k09bc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 01 Jun 2026 21:54:36 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 651LsZos22282826
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 1 Jun 2026 21:54:36 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C6D8658054;
 Mon,  1 Jun 2026 21:54:35 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4F49658064;
 Mon,  1 Jun 2026 21:54:35 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  1 Jun 2026 21:54:35 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Stefan Berger <stefanb@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL v1 16/16] tpm_emulator: Disconnect if response exceeds
 negotiated buffer size
Date: Mon,  1 Jun 2026 17:54:09 -0400
Message-ID: <20260601215410.517009-17-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601215410.517009-1-stefanb@linux.ibm.com>
References: <20260601215410.517009-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDIxMSBTYWx0ZWRfXy7qm1Flmt1fh
 11einnNJAoZkvBHcnApm5hG65UV0ZyXQPL/r8KTsOwdN0TCPjdZjiLlP8TcrzUMSM09gqqWRwel
 MZmnkOMdhys5NT9p2kMlzbGQbJTdm9xB0zBl4TCbbIVUOf8MRPKtRZ4ISjPl1nE9fxxlLS/oZLi
 3A4NBi5QMkmvmj05oKDKTFiMS+Tjs62p+zF6En9Mdt8UT+xUfMlq4LwcxWLgqZK5MHyqFStusid
 TEcEdoOevBfD8Px4BsxC7jogQ4of0Cak05J2r0OJN4ev+IGdUetjX0H2PqYdma8QXNaKYnl1QMY
 vOCGDjqCOff/rG/oSIQninZZg92T+VdLo/zwwGdDHEJ6e49ZZke1i6sFxnOKf0l/oW16I6XxILx
 ilJOV18aDMNRge4SGgX4bgU/3OppUZC0CiHsfNDVsPNNkSsDWWFAeXJ72duvP4lffMH4vP0c3h7
 1loadQco6YSmRtTnJgg==
X-Proofpoint-ORIG-GUID: 8jycQKzV4q3aD6hyDkWufGbtATSkZlI7
X-Authority-Analysis: v=2.4 cv=cOzQdFeN c=1 sm=1 tr=0 ts=6a1dff9d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=ZkoTrUv0hqWFqrPu6skA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 8jycQKzV4q3aD6hyDkWufGbtATSkZlI7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010211
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

Disconnect from the emulator if a response was to exceed the negotiated
buffer size.

The TPM TIS and SPAPR use 4096 bytes and the CRB 3968 bytes. There are
currently no TPM 2 responses using this size of a buffer and therefore
no response will be sent that is exceeding this size.

Fixes: f4ede81eed29 ("tpm: Added support for TPM emulator")
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260511142219.797048-3-stefanb@linux.ibm.com
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 backends/tpm/tpm_emulator.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
index ac5427b84e..95d2de2f48 100644
--- a/backends/tpm/tpm_emulator.c
+++ b/backends/tpm/tpm_emulator.c
@@ -176,8 +176,10 @@ static int tpm_emulator_unix_tx_bufs(TPMEmulator *tpm_emu,
                                      bool *selftest_done,
                                      Error **errp)
 {
-    ssize_t ret;
     bool is_selftest = false;
+    Error *local_err = NULL;
+    uint32_t to_read;
+    ssize_t ret;
 
     if (selftest_done) {
         *selftest_done = false;
@@ -195,9 +197,25 @@ static int tpm_emulator_unix_tx_bufs(TPMEmulator *tpm_emu,
         return -1;
     }
 
+    /*
+     * Size of response from emulator must be <= out_len (= negotiated buffer
+     * size)
+     */
+    to_read = tpm_cmd_get_size(out);
+    if (to_read > out_len) {
+        if (qio_channel_shutdown(tpm_emu->data_ioc, QIO_CHANNEL_SHUTDOWN_BOTH,
+                                 &local_err) < 0) {
+            error_report_err(local_err);
+        }
+        error_setg(errp, "tpm-emulator: Disconnected after receiving "
+                   "unacceptable large response (%u > %u)",
+                   to_read, out_len);
+        return -1;
+    }
+
     ret = qio_channel_read_all(tpm_emu->data_ioc,
               (char *)out + sizeof(struct tpm_resp_hdr),
-              tpm_cmd_get_size(out) - sizeof(struct tpm_resp_hdr), errp);
+              to_read - sizeof(struct tpm_resp_hdr), errp);
     if (ret != 0) {
         return -1;
     }
-- 
2.54.0


