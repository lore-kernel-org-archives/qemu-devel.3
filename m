Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1482CA5FD4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 14:26:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCeCy-0001Li-9G; Fri, 02 Oct 2026 10:25:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1xCeCk-0001DF-W8
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 10:25:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1xCeCg-0001n2-TD
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 10:25:41 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692DZoA22997098; Fri, 2 Oct 2026 14:25:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=REmdsiGC4OC2z6yhQ
 yCLNOFDoN9r5JK/S7S8IO+uUqo=; b=aldLNRYxHtHPBhmmzqN5bSAgUM7gnUKCG
 sn24a4VHYEhizEobFM2i4iOtZ+aha+A0fafRrZr6bYqdSfOBqPQIbp3RFbaVg1Ik
 DFbt5VFU087uXbuoXmUDRFFadgPkgPZ5Rb8a55PdVtf8PeRbuP4Mwz1HmKrBIs0e
 7uvR0BIBZucq4UTzm5qLCZASLYvmiIAC5m5ZLEAjIUlZx/Ya8bKERK+RfNGlHaeP
 6NwrQ1kykAdiDWO5Et42x6hom4WKjkNO6H5pYFWywtR+XWjG+CCgg+VJKA0SEMdd
 sYtZflxkvbjdkQcX0cZhRS0XBhSbi5gSCEQVEqnnd2gU303dbtH4A==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5qrspcg-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 02 Oct 2026 14:25:28 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 692DHl8W1296353; Fri, 2 Oct 2026 14:25:27 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h0q4pmjg0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Oct 2026 14:25:27 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 692EPQHs1573840
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 2 Oct 2026 14:25:26 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A4EBC5805F;
 Fri,  2 Oct 2026 14:25:26 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 326135806A;
 Fri,  2 Oct 2026 14:25:26 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  2 Oct 2026 14:25:26 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: armenon@redhat.com, marcandre.lureau@gmail.com,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 01/10] tpm_util: Pass TPMVersion to function writing fatal
 error response
Date: Fri,  2 Oct 2026 10:25:07 -0400
Message-ID: <20261002142516.2063735-2-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002142516.2063735-1-stefanb@linux.ibm.com>
References: <20261002142516.2063735-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA1NiBTYWx0ZWRfX+/opWFXUFiQZ
 1NxbFOGeUF5lSw6fA6nNMhQitHeaoocfetA61S/tqfWr0UTH8+op/QBTLUXlowcdC/vsatVAEAQ
 xsuFsqySJh6rKnpMf6hERatgHLL7dBVkCYhZI67kOiQQ9kJLtReHGPEgg/erfL4wjUm5ydnad6F
 pRg+5avGTwHnphgyEQVt7diuEWAlkGsNu+ZXCT2LoNAqbsuhml//q6CjKeLlB4OV7wQf87A5gcV
 8L8T0WECkJodgnpnHizEowRhcnbWbDcGaWZ+H3SoR5qZ74BRA48JgMxvA8oTdqTrSGw4xbD7qsM
 23D+wj7ypPbeigghkAhf7jQSRDSs1XkNT9VS9rpUkiBqTzoqcvMyC5u4WuNGvxUAxnaoZxJf9h2
 OidhCk1tei8Oxsm+BYeMRoQumX05OW0p0bYGuXH0DUXXYFB/KkKYjTHQhsCNJkc5XMijgqgDLSX
 ARQDtZSaNza3OslPw8Q==
X-Authority-Analysis: v=2.4 cv=SPbXx+vH c=1 sm=1 tr=0 ts=6abfbed8 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=ZdjYBk6P2T0J8aFbIr8A:9
X-Proofpoint-ORIG-GUID: e0-3_fsamjgoIHyeA4kHuRsNSikN0tKC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA1NiBTYWx0ZWRfXzvBRDB1YMULq
 G2oRGivw0f85mp0WmsIrWyEZR5p0eyz39eFMfKeToeZoz+Cq9hN4OnQuiNLJ0BQvhxuWxl7235Z
 lV8eOxbPl8JdhqUGSc1MLtCgVTi4kq4=
X-Proofpoint-GUID: FHm8xMbdMO56FzqIJZn6S4QszDPGYF-R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610020056
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

Have tpm_util_write_fatal_error_response write a TPM version specific
error response with error code TPM_FAIL for a TPM 1.2 and TPM_RC_FAILURE
for a TPM 2. Adjust the callers.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 backends/tpm/tpm_emulator.c    |  3 ++-
 backends/tpm/tpm_passthrough.c |  2 +-
 backends/tpm/tpm_util.c        | 17 ++++++++++++++---
 include/system/tpm_util.h      |  3 ++-
 4 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
index 95d2de2f48..16ae44c8d7 100644
--- a/backends/tpm/tpm_emulator.c
+++ b/backends/tpm/tpm_emulator.c
@@ -270,7 +270,8 @@ static void tpm_emulator_handle_request(TPMBackend *tb, TPMBackendCmd *cmd,
         tpm_emulator_unix_tx_bufs(tpm_emu, cmd->in, cmd->in_len,
                                   cmd->out, cmd->out_len,
                                   &cmd->selftest_done, errp) < 0) {
-        tpm_util_write_fatal_error_response(cmd->out, cmd->out_len);
+        tpm_util_write_fatal_error_response(cmd->out, cmd->out_len,
+                                            TPM_EMULATOR(tb)->tpm_version);
     }
 }
 
diff --git a/backends/tpm/tpm_passthrough.c b/backends/tpm/tpm_passthrough.c
index a9f35ab7d6..8a4f8183c7 100644
--- a/backends/tpm/tpm_passthrough.c
+++ b/backends/tpm/tpm_passthrough.c
@@ -118,7 +118,7 @@ static void tpm_passthrough_unix_tx_bufs(TPMPassthruState *tpm_pt,
 
 err_exit:
     if (ret < 0) {
-        tpm_util_write_fatal_error_response(out, out_len);
+        tpm_util_write_fatal_error_response(out, out_len, tpm_pt->tpm_version);
     }
 
     tpm_pt->tpm_executing = false;
diff --git a/backends/tpm/tpm_util.c b/backends/tpm/tpm_util.c
index 264bff22a9..7019f7fd3e 100644
--- a/backends/tpm/tpm_util.c
+++ b/backends/tpm/tpm_util.c
@@ -87,12 +87,23 @@ const PropertyInfo qdev_prop_tpm = {
 /*
  * Write an error message in the given output buffer.
  */
-void tpm_util_write_fatal_error_response(uint8_t *out, uint32_t out_len)
+void tpm_util_write_fatal_error_response(uint8_t *out, uint32_t out_len,
+                                         TPMVersion tpm_version)
 {
     if (out_len >= sizeof(struct tpm_resp_hdr)) {
-        tpm_cmd_set_tag(out, TPM_TAG_RSP_COMMAND);
+        switch (tpm_version) {
+        case TPM_VERSION_1_2:
+            tpm_cmd_set_tag(out, TPM_TAG_RSP_COMMAND);
+            tpm_cmd_set_error(out, TPM_FAIL);
+            break;
+        case TPM_VERSION_2_0:
+            tpm_cmd_set_tag(out, TPM2_ST_NO_SESSIONS);
+            tpm_cmd_set_error(out, TPM_RC_FAILURE);
+            break;
+        default:
+            g_assert_not_reached();
+        }
         tpm_cmd_set_size(out, sizeof(struct tpm_resp_hdr));
-        tpm_cmd_set_error(out, TPM_FAIL);
     }
 }
 
diff --git a/include/system/tpm_util.h b/include/system/tpm_util.h
index 1858693225..3ab2fe693d 100644
--- a/include/system/tpm_util.h
+++ b/include/system/tpm_util.h
@@ -25,7 +25,8 @@
 #include "system/tpm.h"
 #include "qemu/bswap.h"
 
-void tpm_util_write_fatal_error_response(uint8_t *out, uint32_t out_len);
+void tpm_util_write_fatal_error_response(uint8_t *out, uint32_t out_len,
+                                         TPMVersion tpm_version);
 
 bool tpm_util_is_selftest(const uint8_t *in, uint32_t in_len);
 
-- 
2.55.0


