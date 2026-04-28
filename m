Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCCF6FF885D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 13:08:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHiAG-0006Vb-Kt; Tue, 28 Apr 2026 09:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wHiA3-0006Rx-B3
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 09:07:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wHi9y-0001Jg-Qu
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 09:07:33 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63S6rbWJ3705253; Tue, 28 Apr 2026 13:07:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=arkGtvuBxPGsuc49P
 Jzg8dPUFOvRGwp5KxPfimG25hQ=; b=bmuO26f8HafDZr2vxWfxEntbpTu49HIWi
 xdvB1StDCh7LP5r1Z7nT9e63Fd4bLIkCp9L7NauV2VeCNAiVIfJszcdfv9wyl3oR
 /L15wnThgq6ixHcbVxZTWxubTxwcO7ETNGKXm7kgEwAyMRj98XItSAjmkPGJj536
 3tFZjm+auAZoob0TGn+o8k/XzlJCZOCDw6wHT3xh7oqxphwsXd58Zsvr5wFK/j8d
 gYy/95pZjS+aFQYbB+d3FQQfqz1jnsEN0QmClsh4jYLde0gJUUV0QfNbv+iy+aY8
 vD/slXeaGTGzfdEazXmZAGZmRhs3d8OpF9i7R+NLU3qdcxLFDFnjg==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drm1dvfty-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Apr 2026 13:07:29 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63SCwJD5006292;
 Tue, 28 Apr 2026 13:07:29 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds9eh9pj2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Apr 2026 13:07:29 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63SD7SFJ33620632
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Apr 2026 13:07:29 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A52EA58056;
 Tue, 28 Apr 2026 13:07:28 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 60C9658052;
 Tue, 28 Apr 2026 13:07:28 +0000 (GMT)
Received: from mycroft-2.pok.ibm.com (unknown [9.47.158.222])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 28 Apr 2026 13:07:28 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, armenon@redhat.com,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 3/6] tests: Set sizes for arrays of expected TPM responses and
 requests
Date: Tue, 28 Apr 2026 13:07:15 +0000
Message-ID: <20260428130718.1325177-4-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260428130718.1325177-1-stefanb@linux.ibm.com>
References: <20260428130718.1325177-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BxsYcDWTSJOeVmG8mebhPuC3eU5Eikv6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDExOCBTYWx0ZWRfX5Hf644nmEPpF
 XqxXtKjtlbSk3Xtpq43N9vesmj7AYcAWMDlKqIHLV7AFNuh4Z///LW4ezVxz/ithn5jnTXPTond
 2Ri5sjrUiUjnBMUg5qiJmGxLEcRpSJG1B5br7GAZWFuE2IeU0gM47dIhZ3NqH8GJcP2216cImDN
 AOAgC8qEFGc7H+9vDoRXwX1oAvcEdLMweDVKfoVnv2W+S/7rvr7AtYjJfV/EXMp8zZifWd963C7
 lOOpN3o6AhfezeD7Sw1dE/5YsIiEiqNg1ofIAiLNZCFHxlKNwc2JUdW0Eo6UZXgdUoezJGq6wFC
 EC7hl7mtU8gsZt7UnpubUDyDaH0wvkfOLLZZ2Vu6/wwV95TyurWo6paR/0NgEaOImLy/pAqX0vV
 ohbadE8aRsDbgNz/gn5qI5+6DpUrp5N1Wrmw7oU+Xhwp9eT/9sn9ujbwie1osw9tp6gDTdHDhR7
 kJQqtK+PyFOqtrmlhuQ==
X-Authority-Analysis: v=2.4 cv=VZLH+lp9 c=1 sm=1 tr=0 ts=69f0b111 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=E-MnKC11_1REocI9e9kA:9
X-Proofpoint-GUID: BxsYcDWTSJOeVmG8mebhPuC3eU5Eikv6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_04,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280118
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

Set the sizes of byte arrays holding TPM requests and responses to avoid a
terminating NUL byte to be added and to only compare the expected part of
responses.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 tests/qtest/tpm-tests.c |  4 ++--
 tests/qtest/tpm-util.c  | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/qtest/tpm-tests.c b/tests/qtest/tpm-tests.c
index 197714f8d9..dcbf5457ed 100644
--- a/tests/qtest/tpm-tests.c
+++ b/tests/qtest/tpm-tests.c
@@ -59,7 +59,7 @@ void tpm_test_swtpm_test(const char *src_tpm_path, tx_func *tx,
     tpm_util_startup(s, tx);
     tpm_util_pcrextend(s, tx);
 
-    static const unsigned char tpm_pcrread_resp[] =
+    static const unsigned char tpm_pcrread_resp[62] =
         "\x80\x01\x00\x00\x00\x3e\x00\x00\x00\x00\x00\x00\x00\x16\x00\x00"
         "\x00\x01\x00\x0b\x03\x00\x04\x00\x00\x00\x00\x01\x00\x20\xf6\x85"
         "\x98\xe5\x86\x8d\xe6\x8b\x97\x29\x99\x60\xf2\x71\x7d\x17\x67\x89"
@@ -105,7 +105,7 @@ void tpm_test_swtpm_migration_test(const char *src_tpm_path,
     tpm_util_startup(src_qemu, tx);
     tpm_util_pcrextend(src_qemu, tx);
 
-    static const unsigned char tpm_pcrread_resp[] =
+    static const unsigned char tpm_pcrread_resp[62] =
         "\x80\x01\x00\x00\x00\x3e\x00\x00\x00\x00\x00\x00\x00\x16\x00\x00"
         "\x00\x01\x00\x0b\x03\x00\x04\x00\x00\x00\x00\x01\x00\x20\xf6\x85"
         "\x98\xe5\x86\x8d\xe6\x8b\x97\x29\x99\x60\xf2\x71\x7d\x17\x67\x89"
diff --git a/tests/qtest/tpm-util.c b/tests/qtest/tpm-util.c
index 2cb2dd4796..1a47099807 100644
--- a/tests/qtest/tpm-util.c
+++ b/tests/qtest/tpm-util.c
@@ -54,9 +54,9 @@ void tpm_util_crb_transfer(QTestState *s,
 void tpm_util_startup(QTestState *s, tx_func *tx)
 {
     unsigned char buffer[1024];
-    static const unsigned char tpm_startup[] =
+    static const unsigned char tpm_startup[12] =
         "\x80\x01\x00\x00\x00\x0c\x00\x00\x01\x44\x00\x00";
-    static const unsigned char tpm_startup_resp[] =
+    static const unsigned char tpm_startup_resp[10] =
         "\x80\x01\x00\x00\x00\x0a\x00\x00\x00\x00";
 
     tx(s, tpm_startup, sizeof(tpm_startup), buffer, sizeof(buffer));
@@ -68,14 +68,14 @@ void tpm_util_startup(QTestState *s, tx_func *tx)
 void tpm_util_pcrextend(QTestState *s, tx_func *tx)
 {
     unsigned char buffer[1024];
-    static const unsigned char tpm_pcrextend[] =
+    static const unsigned char tpm_pcrextend[65] =
         "\x80\x02\x00\x00\x00\x41\x00\x00\x01\x82\x00\x00\x00\x0a\x00\x00"
         "\x00\x09\x40\x00\x00\x09\x00\x00\x00\x00\x00\x00\x00\x00\x01\x00"
         "\x0b\x74\x65\x73\x74\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
         "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
         "\x00";
 
-    static const unsigned char tpm_pcrextend_resp[] =
+    static const unsigned char tpm_pcrextend_resp[19] =
         "\x80\x02\x00\x00\x00\x13\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
         "\x01\x00\x00";
 
@@ -89,7 +89,7 @@ void tpm_util_pcrread(QTestState *s, tx_func *tx,
                       const unsigned char *exp_resp, size_t exp_resp_size)
 {
     unsigned char buffer[1024];
-    static const unsigned char tpm_pcrread[] =
+    static const unsigned char tpm_pcrread[20] =
         "\x80\x01\x00\x00\x00\x14\x00\x00\x01\x7e\x00\x00\x00\x01\x00\x0b"
         "\x03\x00\x04\x00";
 
-- 
2.43.0


