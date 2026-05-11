Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C54BDCD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 14:23:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMRXA-0002HX-Ix; Mon, 11 May 2026 10:23:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wMRWr-0001hw-Bh
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:22:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wMRWo-0002rp-I4
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:22:39 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BBeIrP151140; Mon, 11 May 2026 14:22:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=HuYx1Eu24m+KXk2Ul
 GjvNZWDdPLVTN5BBsfgIQvnzK8=; b=TQABCQoHxNcP96T1UP+I+geO/XssvWKsa
 FQ2R4xPTCgU/I6Hod5/LoEw7TF9f5CaTrlXWoatQH6aeHYO/ywZ7Aa2DK9ICETF/
 rkFqjIwNvaALsa49ghovRuFAzWMV0QcjmWJfQIZdP+UpF1CaMzYR+bLakE5soY9C
 vgT51MgnbGETue+kO5zZ6bpicBJ44r9Z0mpvl74Uo92ZZCSh5+uPT7rAFPSSHFGg
 knDe8cCCoWH0T1znVHSUupdVuLcNiv2jyFNa9RXQVtl2BY1DSw4JVQZR8MuZEiPd
 icRegNzLj5ocO8d5XG588PEeO87c+ZhbLsueKXnFjQxqs9hXqkzog==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1ubdr6w8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 May 2026 14:22:36 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64BE9MEb022002;
 Mon, 11 May 2026 14:22:36 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e2hfg5erj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 May 2026 14:22:36 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64BEMZVK31064608
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 May 2026 14:22:35 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 692AF5804B;
 Mon, 11 May 2026 14:22:35 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D011C58055;
 Mon, 11 May 2026 14:22:34 +0000 (GMT)
Received: from mycroft-2.pok.ibm.com (unknown [9.47.158.226])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 11 May 2026 14:22:34 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, armenon@redhat.com, philmd@linaro.org,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v4 2/2] tpm_emulator: Disconnect if response exceeds
 negotiated buffer size
Date: Mon, 11 May 2026 14:22:18 +0000
Message-ID: <20260511142219.797048-3-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260511142219.797048-1-stefanb@linux.ibm.com>
References: <20260511142219.797048-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=BezoFLt2 c=1 sm=1 tr=0 ts=6a01e62c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=ZkoTrUv0hqWFqrPu6skA:9
X-Proofpoint-GUID: oPbaRD7336gSaSIv0GAPcPA3K0s7Pvhb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE1NiBTYWx0ZWRfX7DdPxyz14fAv
 RgHNHfLXBkwLbQFrf13pImKMlcrfS3o222mSxgJvPC//2BA9vRH9sjuNtd0KF8FvIweZqzFzCzn
 +d3FCkQeb6B4L/gtkj5f9S9cwWy0ZaHi24YcmlW7Mc9cc5osSFoeY0vdX9iH63Ing4+Z8Z43q3I
 7SXcWR/jOdFilmRS2TmtmQwiditrLv34MyZ93ju8RtFgG33jXi/WwHwYrDFpT4gNKwBrJxWBgdv
 LNaz7zwllcI5PS4Xq1uLQQ7V0TbAumYPZVSLsnbnjD21ODZoo0aw+/unZx3nW+v2iCPLwgIB7cu
 gw1DYKPJNI+us13n6dd+PuOjCw6XfXwdkpZpEGzNcupspWYbPd64S03B9PLisJEGp7IVXfcp3pF
 r7RSThrx4Zi8QkGVbDjLGdRTctWsWUmZ2Qog2hXFmWwgjNxHCOZPCjMNSEE2j/tyrlD9OTUU3Wy
 nSleGdgEfFqXMz4XafQ==
X-Proofpoint-ORIG-GUID: oPbaRD7336gSaSIv0GAPcPA3K0s7Pvhb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_04,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110156
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

Disconnect from the emulator if a response was to exceed the negotiated
buffer size.

The TPM TIS and SPAPR use 4096 bytes and the CRB 3968 bytes. There are
currently no TPM 2 responses using this size of a buffer and therefore
no response will be sent that is exceeding this size.

Fixes: f4ede81eed29 ("tpm: Added support for TPM emulator")
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
2.53.0


