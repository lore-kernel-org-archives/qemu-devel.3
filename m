Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F3E5FF8873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 14:24:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wISJ3-0000m4-9D; Thu, 30 Apr 2026 10:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wISIu-0000Uh-5b
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 10:23:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wISIs-0007F0-Gu
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 10:23:47 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63UDgA9D2886656; Thu, 30 Apr 2026 14:23:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=NlF9Xl3XWS2Q+YNdj
 ZpzULvMACGRnxL54n6fkPjveCE=; b=F/dAYpBUes8KTAyhTDTKsqBvhzewySBKj
 aau+44c1xUrPYRSEuqX8KiZNx/D2oiFz63mbR1sGZDK2kgFrkReDti3NMrD28bLW
 uhBqRydVGJAhTZMZwWq5toOgjPQNwiB1YTNo4AyqBQwlOp4UaIvafZwrLW5IM+sZ
 RBKmsalrqOSbFs07mXZ/HcB8/ZBSjWBuPP0yQ2WFgn7A/gjIfTCQ91djT522cUn0
 858scOiJhE0U5HvBPMU+mZ5XZaLT9FnKmV+M1yE5hMjkI8bGo56/ijTJqP+Uqs+9
 6mml2vwK9ghK8859El5xCAMCH2pbeTuUpagGfdtXhfi+eMTWFtiDQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn9rg6cx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Apr 2026 14:23:44 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63UE8u6d013406;
 Thu, 30 Apr 2026 14:23:43 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8aw3dpx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Apr 2026 14:23:43 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63UENg7T64618990
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Apr 2026 14:23:43 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9551D58056;
 Thu, 30 Apr 2026 14:23:42 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 504C05805E;
 Thu, 30 Apr 2026 14:23:42 +0000 (GMT)
Received: from mycroft-2.pok.ibm.com (unknown [9.47.158.222])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 30 Apr 2026 14:23:42 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, armenon@redhat.com,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 2/2] tpm_emulator: Limit number of bytes read to negotiated
 buffer size
Date: Thu, 30 Apr 2026 14:23:37 +0000
Message-ID: <20260430142337.2104726-3-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430142337.2104726-1-stefanb@linux.ibm.com>
References: <20260430142337.2104726-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GiebQoxjPv2-VKsYJk_jtFthG5S3v4FF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDE0NyBTYWx0ZWRfX+ruDYzdRF0Ig
 just12hHRm02BwAG8cKGB+HF8Ompl1Hpt+1Lxk2hW+ORRuk17U5XZJXi0Qz0Y1gmKerIC4rc19I
 Zcixq0f2YjKyNve/BFGcDENysQkMBTjBptUp6jNZ+75wEFpFS8eO2hNlclSsaKhdExIqnSn25LL
 5+QgiWe2KL/Zxx31rq9YEu2lnTxo6rcT1b3vKr7j6GNg5QdFCPvbo0JWHrKl99hnKCYwzUBPtSI
 +BwodOJz+zbX2YMj3lldr2E5UmcAY1rHn8iZpE0Mmr5pckwt8hOWISRnpWsShyB0Tb/PqbLCJNV
 K+fYpDvqtAoGInIXYYa55RjO2HHf4EIEsYPjbXqJaVCwPxTHsuxYOdih/E+jEF9JyOUFwrCwvZe
 VSsTtvJb4UMeXbsCgHfXArOCZftsCNK2BZRv8NSn5Eg+h9Q/aapy9tLfiPxQX4LnBmvXm7mR4aM
 YzK2f0DshEjB8BGSq3g==
X-Authority-Analysis: v=2.4 cv=Kc7idwYD c=1 sm=1 tr=0 ts=69f365f0 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=R_BpO4H6iBiOJCEtfBAA:9
X-Proofpoint-ORIG-GUID: GiebQoxjPv2-VKsYJk_jtFthG5S3v4FF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604300147
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
index 10ab909474..b8ae113774 100644
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
+    to_read = MIN(tpm_cmd_get_size(out) - sizeof(struct tpm_resp_hdr), out_len);
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


