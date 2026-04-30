Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8949FF8873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 14:24:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wISJ5-000146-Pn; Thu, 30 Apr 2026 10:23:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wISIw-0000j1-68
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 10:23:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wISIs-0007El-NA
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 10:23:49 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63UCvmXq139212; Thu, 30 Apr 2026 14:23:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=zsWnJH5GgQCFiFn5C
 udQxKO1XJQhAqeJ98oS2wtcwiM=; b=TuzKhAUVzGr0F2bAeRJkBDREmKC18iGcL
 83+dEfIYz5wgXHPGCo2TvFRicwcAYx8yw9bMXsYo7AItqFjNOuXaGg0w576KaITu
 D5cNs3x5QE7q65ZbJmmZm/VL51Rp2hPM9UyokY72QdvPAi/CTGe6uNVevk6YfDaF
 UJI/nbYoNX2QLestBJ95cLiWBGOn/gfKP/cT/aFDgBB2EnrfDIkoUYjz5a61kcZ2
 YbG5eqK2Ont8953UoIpU+3DnExzzAtD+PEZy6ykrnzbKj++7lr7ndsvWycu29lTd
 qJN/XqUI87kJsViynX6rk5e0M/9DrecT6G2mO8qHI9pEV5J1YM10Q==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drk1jxn2k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Apr 2026 14:23:44 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63UE8p6L031991;
 Thu, 30 Apr 2026 14:23:43 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsamyk40p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Apr 2026 14:23:43 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63UENghh64618988
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Apr 2026 14:23:42 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3B2D05805A;
 Thu, 30 Apr 2026 14:23:42 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E242C58063;
 Thu, 30 Apr 2026 14:23:41 +0000 (GMT)
Received: from mycroft-2.pok.ibm.com (unknown [9.47.158.222])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 30 Apr 2026 14:23:41 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, armenon@redhat.com,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 1/2] tpm_emulator: Reject a buffer size larger than what
 was requested
Date: Thu, 30 Apr 2026 14:23:36 +0000
Message-ID: <20260430142337.2104726-2-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430142337.2104726-1-stefanb@linux.ibm.com>
References: <20260430142337.2104726-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDE0NyBTYWx0ZWRfX75WoeqzYsUSv
 G835lwKl0/rf/32WdHF+Z4lL2M0M9qCE7ssn0RqEHO9JdKw2BNlt5irOZawaH0AlvlK69PQ15US
 zbRG/D42tRSeJPARewkszKYQHxNZvClTz10zlRBMSepDkFQMKtoyFwTjhFS3GGcZ0MOdGsH5pXV
 uBbZU9UMlsggH+6cmBFLsIk5guTYkWcQ/uk/LJkF+JNdjhVjYQq6pGKI8n3qUEPy1+J38ZA1KSu
 9jMlbhuxY472kR+AhWljqag/FeVkMxK5NOI6P23SXgFqe6pzpNoieLvqTnriWWRGmvhxl79kkte
 T++RKw71DESOoVY3M75oEaqNiBq54fOoqfIPL74wnX6uSPByHxu3VuDAlWZHgZrAUFmecxBmiVG
 6GV52hVV7KQfAvvX6KWYUJmM0rH/pYsd4rzCDR+FNLco+xDh5LtSdFNOdbzhXQak2hgb1V1NghB
 i+3d4DSXIfCCV5ToHMA==
X-Proofpoint-GUID: _Vq3QSgZkElKKDzDW2aUjmNAzyWYU3Qy
X-Proofpoint-ORIG-GUID: _Vq3QSgZkElKKDzDW2aUjmNAzyWYU3Qy
X-Authority-Analysis: v=2.4 cv=MohiLWae c=1 sm=1 tr=0 ts=69f365f0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=lp88FLx_Zl_lkmcsHRgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604300147
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

When the TIS, SPAPR, or CRB frontends negotiate a buffer size with the
TPM backend, then the tpm_emulator (swtpm) could still adjust this size
of the buffer to within bounds supported by swtpm+libtpms if the chosen
size was outside the acceptable range. This could theoretically lead to
the TPM 2 using a bigger buffer than what was requested and memory
allocated for. In practice this would not happend since the requested size
of 4096 bytes for TIS and SPAPR and 3968 bytes for CRB are in the
(currently) supported range of ~2.5kb to 4096 bytes. With PQC support
the range will have an upper bound of 8kb and a lower bound that will
support the (pre-PQC) CRB with 3968 bytes.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 backends/tpm/tpm_emulator.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
index 75c33d290e..10ab909474 100644
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
+    /* Reject a bigger buffer used by the TPM than what was requested. */
+    if (wanted_size != 0 && wanted_size < tpm_buffersize) {
+        error_setg(errp,
+                   "tpm-emulator: TPM did not accept the requested buffer size "
+                   "of %zu bytes but adjusted it to %zu bytes\n",
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
2.43.0


