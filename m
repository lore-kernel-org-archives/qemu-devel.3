Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E035CD6E60
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 21:55:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUAaq-0006gT-Uk; Mon, 01 Jun 2026 17:54:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wUAam-0006dh-52
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 17:54:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wUAak-0003sa-3w
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 17:54:39 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 651F44V03293469; Mon, 1 Jun 2026 21:54:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=CypCTA
 6rtDwYIQsy3ezvj7pRxITACsiyRTalf4w3qX4=; b=tRZG1r67vYf3+HWVsqM7ev
 O+ymRLo5/t5GW9E4egxqar1NaTna8TXHkudEh5izC5ndBdG26KxJGTJeN5QLUtDx
 88m4uaiCdaI16lxw2TzpiHahwl6H5EM+ykoBGV5nDhepanEiP35AryAcPCMmMWuf
 NZr3SxdPxpTYJOzli8CDoZgr9L4VjW2TB9gW26DFXnij2Fl0d3yAE/4YW+gtzzON
 FhjYnaiLUoDt7vi+uoHNgqNTufxGGJt0YyfJ85Qn8gXySpIiUVufMi0DiL8DRYD1
 RxQpp8SJAUR4Koc6mWPZ4q5oVv9nyoRIC5UXP4R+N66MjX4hKgBChOxyeQBV2K/g
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efnahjwhs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 01 Jun 2026 21:54:36 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 651LsBL7029557;
 Mon, 1 Jun 2026 21:54:36 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egb7k09b9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 01 Jun 2026 21:54:36 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 651LsZ7t33161950
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 1 Jun 2026 21:54:35 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 298F658054;
 Mon,  1 Jun 2026 21:54:35 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A62345805A;
 Mon,  1 Jun 2026 21:54:34 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  1 Jun 2026 21:54:34 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Stefan Berger <stefanb@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL v1 15/16] tpm_emulator: Reject a buffer size different than
 what was requested
Date: Mon,  1 Jun 2026 17:54:08 -0400
Message-ID: <20260601215410.517009-16-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601215410.517009-1-stefanb@linux.ibm.com>
References: <20260601215410.517009-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDIxMSBTYWx0ZWRfX2MtpaLBsyaJx
 T6WpJR/xjFdas6P4qVymwTY9xM7jNcOmzjwArAiUK3Xgpo2VpsWRoSN9iuA2UvQqFlZVu3d1kea
 dJbAd/iiDf72SHOGPhsdY44ybajVppj5bKy2WqhESXWQQaGuOYYaoH28IdYr/zOZZ/5v3pWaWGa
 Pt+Z1y5iBjFdVBVGuvo3uEEMhowyoSdt3RTkUwVXw8luqAbninwdvrKX/wWeqwVnYqd88sIbNcp
 ajVrYfbxRPtL7Qr6G24RJY7pwr41qPgwcRjKLFIf70e8BueI3wDFe2R3g6SQBcSeYDz86WoTSk5
 90sJvGBj3xlhAURz9l3KEiKBNhxlZ9Seeu5Nr4CcYyqCzhJ7MYXk5tSdqBF/V0/tx702tH2YoEv
 6Okm7MLiKPaDX1r/MLmwQDYZsulaGHxNrj43Am+GaP4i6z4qzqsMqIMXLhqE/lAgfxhCXFaOzsf
 wUOnVDPKcyMex64xlDQ==
X-Proofpoint-ORIG-GUID: r30zmddj_sLcAmTUKmxCuTCEH9QFy8Yv
X-Authority-Analysis: v=2.4 cv=cOzQdFeN c=1 sm=1 tr=0 ts=6a1dff9c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=lp88FLx_Zl_lkmcsHRgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: r30zmddj_sLcAmTUKmxCuTCEH9QFy8Yv
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

When the TIS, SPAPR, or CRB frontends negotiate a buffer size with the
TPM backend, then the tpm_emulator (swtpm) could still adjust this size
of the buffer to within bounds supported by swtpm+libtpms if the chosen
size was outside the acceptable range. This could theoretically lead to
the TPM 2 using a bigger buffer than what was requested and memory
allocated for. In practice this would not happend since the requested size
of 4096 bytes for TIS and SPAPR and 3968 bytes for CRB happen in the
(currently) supported range of ~2.5kb to 4096 bytes. With PQC support
the range will have an upper bound of 8kb and a lower bound that will
support the (pre-PQC) CRB with 3968 bytes.

Fixes: 9375c44fdfc0 ("tpm: tpm_emulator: get and set buffer size of device")
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260511142219.797048-2-stefanb@linux.ibm.com
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 backends/tpm/tpm_emulator.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
index 75c33d290e..ac5427b84e 100644
--- a/backends/tpm/tpm_emulator.c
+++ b/backends/tpm/tpm_emulator.c
@@ -364,6 +364,7 @@ static int tpm_emulator_set_buffer_size(TPMBackend *tb,
 {
     TPMEmulator *tpm_emu = TPM_EMULATOR(tb);
     ptm_setbuffersize psbs;
+    size_t tpm_buffersize;
 
     if (tpm_emulator_stop_tpm(tb, errp) < 0) {
         return -1;
@@ -387,8 +388,18 @@ static int tpm_emulator_set_buffer_size(TPMBackend *tb,
         return -1;
     }
 
+    tpm_buffersize = be32_to_cpu(psbs.u.resp.buffersize);
+    /* Reject different buffer size used by the TPM than what was requested. */
+    if (wanted_size != 0 && wanted_size != tpm_buffersize) {
+        error_setg(errp,
+                   "tpm-emulator: TPM did not accept the requested buffer size "
+                   "of %zu bytes but adjusted it to %zu bytes",
+                   wanted_size, tpm_buffersize);
+        return -1;
+    }
+
     if (actual_size) {
-        *actual_size = be32_to_cpu(psbs.u.resp.buffersize);
+        *actual_size = tpm_buffersize;
     }
 
     trace_tpm_emulator_set_buffer_size(
-- 
2.54.0


