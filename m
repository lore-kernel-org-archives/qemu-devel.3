Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADDFCCD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 14:23:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMRY1-0004RQ-J6; Mon, 11 May 2026 10:23:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wMRXq-0004Po-Vi
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:23:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wMRXp-0003AV-5t
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:23:42 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64B8DRgQ3092282; Mon, 11 May 2026 14:22:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=X5CPvpw2Y+EAzZUiX
 F3HEPlQWWyJKyhuC91fQcrjL/U=; b=Jm+1jVa1ONgwRwW9YkR5qh98XdLJfNdBS
 YgpowfOqRI/KN4H0FZpriiDmk11q8yLbiEqSC+OXjjloiee6sLQdt2r/vj/KR/qf
 2bA9b1OSTZTmvrQvE6heX7YzDlCR4gFuVwZh2OKDDi/TbWvxMDt2Ob9oqZCp4hAo
 wzjaVxrwyHZpziLx8wc1cargguJ5YgHgbieZHCCaFuOyuxk+CmusG4Ws1ugEf1HB
 W64bvdBJS/DPQrrKJt4NJapoDR1aRsup7whukj0ZEJWo1KIIsdFDRgb1Uxlq57rk
 OGJjI6mlMsAYKKTfKFbu8sZDaIBd6+ic4ibrzg68ogcllju8YA5dw==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1tbhrb9j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 May 2026 14:22:36 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64BE9N1Y019306;
 Mon, 11 May 2026 14:22:35 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e2grh5j2c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 May 2026 14:22:35 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64BEMYLo30147080
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 May 2026 14:22:35 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AB1E45804B;
 Mon, 11 May 2026 14:22:34 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 25BC258066;
 Mon, 11 May 2026 14:22:34 +0000 (GMT)
Received: from mycroft-2.pok.ibm.com (unknown [9.47.158.226])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 11 May 2026 14:22:34 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, armenon@redhat.com, philmd@linaro.org,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v4 1/2] tpm_emulator: Reject a buffer size different than what
 was requested
Date: Mon, 11 May 2026 14:22:17 +0000
Message-ID: <20260511142219.797048-2-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260511142219.797048-1-stefanb@linux.ibm.com>
References: <20260511142219.797048-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ZdQt8MVA c=1 sm=1 tr=0 ts=6a01e62c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=lp88FLx_Zl_lkmcsHRgA:9
X-Proofpoint-ORIG-GUID: Yic_Vyjo4fyq2qVc1i1y_26JBdQvnitt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE1NiBTYWx0ZWRfX4pIGwnWfX+kP
 GJQhiVgO6FmyF3gLFMn8CGcIMzYrcbefo9519NfdWvu8o/xlVv365L1goWEbknVO9T7GkOy9Zfh
 HZlTodA3FmuLGCX7Vno/vyBj440dkiNZ1G2J5xxcYxYatCEmimDWJhdfItVC1THdUKs7p6nMFr+
 UTU8rczrOJgw6z7Hme5zIv5hmCc+xdHnCIz50xjlKSfyKXfuJcNBZQZTLHrZ4L16VzSRxRYA9Ql
 rEDGl42DAv+CpLjB21IyZam7Ad7vS7YqQu0tCGn4abymeZ5kViDoLTkaRHdF5WLoS9mpINPDFKs
 E5AEzmrwgkvnrb46VkF3tf/02zcOjLfeMFTIBgQ9586c7h1P6hol54l/o++sTsbJNMZA2H1CP3a
 ffzkfStIn5w+PFVAuo4IyohD+hwQEM/efFCJD5l+ZttWMwtU9ayF5Scvn5GLNI+dHxZD6pRlkk2
 GqgiuRlbjhMbODEvLZw==
X-Proofpoint-GUID: Yic_Vyjo4fyq2qVc1i1y_26JBdQvnitt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_04,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0
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
2.53.0


