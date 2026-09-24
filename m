Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 468CCC98311
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 01:27:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9YDZ-00016f-Hn; Wed, 23 Sep 2026 21:25:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1x9YDW-000152-J4
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 21:25:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1x9YDU-0007Kx-Sn
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 21:25:42 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NNZZPC575705; Thu, 24 Sep 2026 01:25:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=rK5QLBeEyalydN+qA
 HOxnhLxrUTjEpJWdnQys/LNzik=; b=F1FbHHM+fKeXhMyJIJMfnrtJpfylgUpSZ
 jpOlKmIWRndVJFuZhO5cArvnI5RYcTMtb0k/ZWc9oBpTVHekVjky4rtge2R/VQRb
 oQTn1QwOueLGIA7lHcFSGbmQmmGqIzx5pBwwlqUt8YGFeny6vR1f2v4/ONBUcoFp
 wksG5rmmAFVglMpxh0+C60dj6Z3GlI9V9+0mR1Kp/fg8TLcMcG0mk6rPv9DMpkLN
 Yglp/N30H3YE4Qn5qTL+61sJuS5oxen7BWws9uv06i8v1H5M4G/66ykxJivVWxA1
 NK2KeZOkp1yGjO5ytkZlnaEHjegfUh1vnrOxbp6/2t8GkH8hguTOg==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg2pfh6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 01:25:38 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NNHXCL1132907; Thu, 24 Sep 2026 01:25:37 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvb8jukm8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 01:25:37 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68O1PatI24445484
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2026 01:25:36 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8F28458061;
 Thu, 24 Sep 2026 01:25:36 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1808058053;
 Thu, 24 Sep 2026 01:25:36 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Sep 2026 01:25:35 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: armenon@redhat.com, marcandre.lureau@gmail.com,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 01/10] tpm_util: Pass TPMVersion to function writing fatal
 error response
Date: Wed, 23 Sep 2026 21:25:18 -0400
Message-ID: <20260924012527.858527-2-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924012527.858527-1-stefanb@linux.ibm.com>
References: <20260924012527.858527-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: zoGU40poigFTYUf3KoBRtGP8yehlN6TK
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab47c12 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=ZdjYBk6P2T0J8aFbIr8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAwNiBTYWx0ZWRfX99WqA0ZY11Fm
 YhW9L4o/5x/bkYb97KHru/zPnCPnW+tRg+9FsjY3YibNh8pYjw8uz3ReD8uCIEvjkNCTmQntftU
 OJmTcb4UhevmekP4U0BDaDVz84OVUfO7RKO6GNIi/T/u1tDtO7unL/n3+wm3b+bSNIFQ2jrqAmp
 UOIHEKxVX/tatWdVxW9IDW0Ynq8TjFdRM5QidWJzPNDCcKgihtADRxIWv2m1ChTITZigkFccuyk
 DH+kgJkt1uUREWDdx7u5YzYS6UW4StC8qHYNKH08zZvu2hGOVFLdBBoNklyzb4Ya7t8VZjJcRkF
 cieqVqncFeeVSDzh3Azf3xK/jOasKJn/skXNSXCO5bTF78Zoi+IcJJRB3jfEUT8QLYP3jYtcMhD
 ylVgUsadis0xo4jU8cFMgJpA4hF4du5pvK/fA5YsQbGd3Eh22mdy2fQ4xtSmNyx054Nzi50voyc
 J0A7yHf1UEl8JbNMEEQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAwNiBTYWx0ZWRfX6q1rblwll/SH
 1AYoXBVZciVvtoopfnj6aWIOcsli9fuOWHvWXYrSpKIxOVOq1gIbs+LmkpY99VtZX0WlESQWwAI
 iVaks9A1OnQTOntCZIpSYyrt2T/WPhY=
X-Proofpoint-GUID: VspG0_H77QChzxHmC7eTDz30z6sldQG_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_08,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240006
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
 backends/tpm/tpm_util.c        | 12 +++++++++---
 include/system/tpm_util.h      |  3 ++-
 4 files changed, 14 insertions(+), 6 deletions(-)

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
index 264bff22a9..cdb7a48861 100644
--- a/backends/tpm/tpm_util.c
+++ b/backends/tpm/tpm_util.c
@@ -87,12 +87,18 @@ const PropertyInfo qdev_prop_tpm = {
 /*
  * Write an error message in the given output buffer.
  */
-void tpm_util_write_fatal_error_response(uint8_t *out, uint32_t out_len)
+void tpm_util_write_fatal_error_response(uint8_t *out, uint32_t out_len,
+                                         TPMVersion tpm_version)
 {
     if (out_len >= sizeof(struct tpm_resp_hdr)) {
-        tpm_cmd_set_tag(out, TPM_TAG_RSP_COMMAND);
+        if (tpm_version == TPM_VERSION_1_2) {
+            tpm_cmd_set_tag(out, TPM_TAG_RSP_COMMAND);
+            tpm_cmd_set_error(out, TPM_FAIL);
+        } else {
+            tpm_cmd_set_tag(out, TPM2_ST_NO_SESSIONS);
+            tpm_cmd_set_error(out, TPM_RC_FAILURE);
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


