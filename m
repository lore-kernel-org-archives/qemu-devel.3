Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C231CD13DA
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 15:52:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wITgZ-0001we-61; Thu, 30 Apr 2026 11:52:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wITgJ-0001sG-Ew
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 11:52:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wITgH-0004jB-SU
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 11:52:03 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63UEd5UO2932084; Thu, 30 Apr 2026 15:51:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=4X/nQS0TSCCirG4ZP
 McTDv7LT8fe4TTA12WwKMp3BOQ=; b=PvXZBs3QxczVDoPJMR7y5dhAMDOculoCJ
 uUwVy2pd/amZL4WyGEebt37a49J7Avc3pvyCLYrgiNilW67dM+uVCy8dFkOCHiTL
 +nfzRokAawZL+yX0tCv9In9y5Z6FF87iwyiikrS9ToQWuybuF7CRegApYXV7sPT/
 WrDgBKvNU3+BgCDew8DBBYWX23Kkfqg5iSr5QcFiNiwskFTwuqGk5kXowPKsO28l
 tomWKYEaJ1Ugqp1FrO2oEIrFPO/5jo+kejREGaWLhGmtpaxgxAMnoimR8IsxBsRT
 oc7N05THIqiVwGF0T8254wElBzLjkIHSPT1A6b3AAYIoMnPz8/EiQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn9rgksv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Apr 2026 15:51:57 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63UFNw2E030859;
 Thu, 30 Apr 2026 15:51:56 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8aw3r6e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Apr 2026 15:51:56 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63UFpu4D4457228
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Apr 2026 15:51:56 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4A7E05805A;
 Thu, 30 Apr 2026 15:51:56 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AE0FF58054;
 Thu, 30 Apr 2026 15:51:55 +0000 (GMT)
Received: from mycroft-2.pok.ibm.com (unknown [9.47.158.222])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 30 Apr 2026 15:51:55 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, armenon@redhat.com, philmd@linaro.org,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 2/2] tpm_emulator: Limit number of bytes read to negotiated
 buffer size
Date: Thu, 30 Apr 2026 15:51:50 +0000
Message-ID: <20260430155150.2139517-3-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430155150.2139517-1-stefanb@linux.ibm.com>
References: <20260430155150.2139517-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _mmg4HUeEy0rDppEzshFqFMtXUBdktPR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDE2MyBTYWx0ZWRfXxQxVwnX5+gFq
 Hx6xdbOUJTIai/RB2e+SrYG0161MHAHxTH+oGeRB/Thck35UjOHdLgBms3W2vnJNYhkSpHUrbDs
 QgT1Wg+FP+T9FxD3D6prbXJbKYfn9QNc5MHF+lqv3GJIIbuAgx9veucQcKArJHlRWGZOsGpLk0Q
 I1Y0LUv4cPPH8S/BufDG+aeN5EaxqnG7kuwALslC4W/V0ida+obi1LfB5q6NiojpfkdP/2bTw8M
 cAhPhNvuElAeBxcYCe6Gygc61egF/y38g3n/eSAtHisYZbUeF9c6M2upeGmzDQ43+epGUSrtcrP
 39AwAKbReiScqqkEEayFLZPGYhFFD8iPodMz5U3a8hqOl/VSJDgdhVqAsCdvjwzuWQXr7obH0Qu
 X1CgYEeX1tKQ00GlCu1javM2jUQPLIFT/o+CJekPlmtjhHBa2XN3lpW0GzirreGF2SEYlrz3xm0
 iWWZ1Ln5WVYmLg+FOFQ==
X-Authority-Analysis: v=2.4 cv=Kc7idwYD c=1 sm=1 tr=0 ts=69f37a9d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=R_BpO4H6iBiOJCEtfBAA:9
X-Proofpoint-ORIG-GUID: _mmg4HUeEy0rDppEzshFqFMtXUBdktPR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604300163
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

Limit the number of bytes read from the TPM response to the size of the
receiving buffer, which is the same as the size of the buffer negotiated
with swtpm.

The TPM TIS and SPAPR use 4096 bytes and the CRB 3968 bytes. There are
currently no TPM 2 responses using this size of a buffer and therefore
no response will be sent that is exceeding this size.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 backends/tpm/tpm_emulator.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
index 653989ac0e..050a1f4225 100644
--- a/backends/tpm/tpm_emulator.c
+++ b/backends/tpm/tpm_emulator.c
@@ -176,8 +176,9 @@ static int tpm_emulator_unix_tx_bufs(TPMEmulator *tpm_emu,
                                      bool *selftest_done,
                                      Error **errp)
 {
-    ssize_t ret;
     bool is_selftest = false;
+    size_t to_read;
+    ssize_t ret;
 
     if (selftest_done) {
         *selftest_done = false;
@@ -195,9 +196,13 @@ static int tpm_emulator_unix_tx_bufs(TPMEmulator *tpm_emu,
         return -1;
     }
 
+    /*
+     * Size of response from swtpm must be <= out_len (= negotiated buffer size)
+     */
+    to_read = MIN(tpm_cmd_get_size(out), out_len) - sizeof(struct tpm_resp_hdr);
+
     ret = qio_channel_read_all(tpm_emu->data_ioc,
-              (char *)out + sizeof(struct tpm_resp_hdr),
-              tpm_cmd_get_size(out) - sizeof(struct tpm_resp_hdr), errp);
+              (char *)out + sizeof(struct tpm_resp_hdr), to_read, errp);
     if (ret != 0) {
         return -1;
     }
-- 
2.43.0


