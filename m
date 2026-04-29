Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B34E9FF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 12:19:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI3rb-0004GH-1H; Wed, 29 Apr 2026 08:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wI3rX-0004Ex-Bh
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 08:17:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wI3rV-0000pu-FR
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 08:17:55 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63T9Jn4E3538290; Wed, 29 Apr 2026 12:17:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=JsTIvCSFlcUXPSgx2
 xxGQMJKzlpH+LPV/wPmsQGXzT0=; b=NCgkeoS3WQNRAzzAqQii+5Y+kfM3G0ewq
 EkJYxujdm2LUNergpNqdAr6vz1TaelXUrgiu8ge6+pMWKJ3yWLfY3GD9/P8e9wI9
 PFakxjBR+v5wjR2VFCs7ZkVmWPq6WPBrN9lF7/yCPyy5tmsbIre8g89ChVULylkT
 T6mAJIbxFuy/yPmNauEPf688JXT+8XtIHdZ2tBjmP9RgMZd7SolpuluHz3CHcn//
 oWmUnvJDOiEmuOtMwf2md5m1SPugzbFmsF2n4Mkl8Z3+WRgRgKawWDht+JRbSy2v
 PNZtKZZ5XWNAiTsZ/wSloe5z+flyT1nkOx5zPeuN9Za7sTR52NCZA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drm1e0ydv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Apr 2026 12:17:52 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63TC8iNh027713;
 Wed, 29 Apr 2026 12:17:51 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8xk66hb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Apr 2026 12:17:51 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63TCHo8m4653620
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Apr 2026 12:17:51 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AC77B58045;
 Wed, 29 Apr 2026 12:17:50 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3C32E58050;
 Wed, 29 Apr 2026 12:17:50 +0000 (GMT)
Received: from mycroft-2.pok.ibm.com (unknown [9.47.158.222])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 29 Apr 2026 12:17:50 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, armenon@redhat.com,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 3/6] tests: Convert string arrays to byte arrays
Date: Wed, 29 Apr 2026 12:17:40 +0000
Message-ID: <20260429121743.1346635-4-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429121743.1346635-1-stefanb@linux.ibm.com>
References: <20260429121743.1346635-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oPIYXqv3RPRYT5v7oTPsvwqo9IBt4LFU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDEyNSBTYWx0ZWRfX29aHwTo30VVN
 NPlrOD4htaMYsoybYFPT1OQixSFoOibuO3OAaVj/VTFo2sominV6Zy1OsQE02KUAbTmx0q/V1Ch
 k94C9WJOJGAuvMC0Jdjl17pOJUraX4gAv8945NSPHoRWwY7+g5gmjGuc+tU04peiuihHfeSjCRf
 Th7QhwW5o1QkCVsJQ5rA2jzEzREx1dCOboZe83r+1X4O9KOiX/9p7TjxOPYCwmJsPCkWlPsPjf6
 bWYOftSLW53hbzAFqEJ6ko1UTT3+lDRp169my4e4+0do7BwRkC8GrrBo7FdIZOrqeIIHUr1AZxX
 /zJrn0hDlWoSwzRdCBLPf2nfUVYuGlJytxEEqK8TubT+nkKO51TiL3ramdF6jAp2KMDgTzea3hj
 7Si7aLJG2GkIADLywoBO0hzCN/YoU1pk44gwpjxn/EZvaPZxkYCzChfUi7xUEraAsDiLbMRGJvP
 HWojhciNy436zVdUzVA==
X-Authority-Analysis: v=2.4 cv=VZLH+lp9 c=1 sm=1 tr=0 ts=69f1f6f0 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=LORrTqdot4XOhRVC2oUA:9
X-Proofpoint-GUID: oPIYXqv3RPRYT5v7oTPsvwqo9IBt4LFU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290125
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

Convert the TPM command and response string arrays to byte arrays.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 tests/qtest/tpm-tests.c | 30 ++++++++++++++++++---------
 tests/qtest/tpm-util.c  | 45 ++++++++++++++++++++++++++---------------
 2 files changed, 49 insertions(+), 26 deletions(-)

diff --git a/tests/qtest/tpm-tests.c b/tests/qtest/tpm-tests.c
index 197714f8d9..8bd3288f80 100644
--- a/tests/qtest/tpm-tests.c
+++ b/tests/qtest/tpm-tests.c
@@ -59,11 +59,16 @@ void tpm_test_swtpm_test(const char *src_tpm_path, tx_func *tx,
     tpm_util_startup(s, tx);
     tpm_util_pcrextend(s, tx);
 
-    static const unsigned char tpm_pcrread_resp[] =
-        "\x80\x01\x00\x00\x00\x3e\x00\x00\x00\x00\x00\x00\x00\x16\x00\x00"
-        "\x00\x01\x00\x0b\x03\x00\x04\x00\x00\x00\x00\x01\x00\x20\xf6\x85"
-        "\x98\xe5\x86\x8d\xe6\x8b\x97\x29\x99\x60\xf2\x71\x7d\x17\x67\x89"
-        "\xa4\x2f\x9a\xae\xa8\xc7\xb7\xaa\x79\xa8\x62\x56\xc1\xde";
+    static const unsigned char tpm_pcrread_resp[] = {
+        0x80, 0x01, 0x00, 0x00, 0x00, 0x3e, 0x00, 0x00,
+        0x00, 0x00, 0x00, 0x00, 0x00, 0x16, 0x00, 0x00,
+        0x00, 0x01, 0x00, 0x0b, 0x03, 0x00, 0x04, 0x00,
+        0x00, 0x00, 0x00, 0x01, 0x00, 0x20, 0xf6, 0x85,
+        0x98, 0xe5, 0x86, 0x8d, 0xe6, 0x8b, 0x97, 0x29,
+        0x99, 0x60, 0xf2, 0x71, 0x7d, 0x17, 0x67, 0x89,
+        0xa4, 0x2f, 0x9a, 0xae, 0xa8, 0xc7, 0xb7, 0xaa,
+        0x79, 0xa8, 0x62, 0x56, 0xc1, 0xde
+    };
     tpm_util_pcrread(s, tx, tpm_pcrread_resp,
                      sizeof(tpm_pcrread_resp));
 
@@ -105,11 +110,16 @@ void tpm_test_swtpm_migration_test(const char *src_tpm_path,
     tpm_util_startup(src_qemu, tx);
     tpm_util_pcrextend(src_qemu, tx);
 
-    static const unsigned char tpm_pcrread_resp[] =
-        "\x80\x01\x00\x00\x00\x3e\x00\x00\x00\x00\x00\x00\x00\x16\x00\x00"
-        "\x00\x01\x00\x0b\x03\x00\x04\x00\x00\x00\x00\x01\x00\x20\xf6\x85"
-        "\x98\xe5\x86\x8d\xe6\x8b\x97\x29\x99\x60\xf2\x71\x7d\x17\x67\x89"
-        "\xa4\x2f\x9a\xae\xa8\xc7\xb7\xaa\x79\xa8\x62\x56\xc1\xde";
+    static const unsigned char tpm_pcrread_resp[] = {
+        0x80, 0x01, 0x00, 0x00, 0x00, 0x3e, 0x00, 0x00,
+        0x00, 0x00, 0x00, 0x00, 0x00, 0x16, 0x00, 0x00,
+        0x00, 0x01, 0x00, 0x0b, 0x03, 0x00, 0x04, 0x00,
+        0x00, 0x00, 0x00, 0x01, 0x00, 0x20, 0xf6, 0x85,
+        0x98, 0xe5, 0x86, 0x8d, 0xe6, 0x8b, 0x97, 0x29,
+        0x99, 0x60, 0xf2, 0x71, 0x7d, 0x17, 0x67, 0x89,
+        0xa4, 0x2f, 0x9a, 0xae, 0xa8, 0xc7, 0xb7, 0xaa,
+        0x79, 0xa8, 0x62, 0x56, 0xc1, 0xde,
+    };
     tpm_util_pcrread(src_qemu, tx, tpm_pcrread_resp,
                      sizeof(tpm_pcrread_resp));
 
diff --git a/tests/qtest/tpm-util.c b/tests/qtest/tpm-util.c
index 2cb2dd4796..63cd5b69db 100644
--- a/tests/qtest/tpm-util.c
+++ b/tests/qtest/tpm-util.c
@@ -54,10 +54,14 @@ void tpm_util_crb_transfer(QTestState *s,
 void tpm_util_startup(QTestState *s, tx_func *tx)
 {
     unsigned char buffer[1024];
-    static const unsigned char tpm_startup[] =
-        "\x80\x01\x00\x00\x00\x0c\x00\x00\x01\x44\x00\x00";
-    static const unsigned char tpm_startup_resp[] =
-        "\x80\x01\x00\x00\x00\x0a\x00\x00\x00\x00";
+    static const unsigned char tpm_startup[] = {
+        0x80, 0x01, 0x00, 0x00, 0x00, 0x0c, 0x00, 0x00,
+        0x01, 0x44, 0x00, 0x00
+    };
+    static const unsigned char tpm_startup_resp[] = {
+        0x80, 0x01, 0x00, 0x00, 0x00, 0x0a, 0x00, 0x00,
+        0x00, 0x00
+    };
 
     tx(s, tpm_startup, sizeof(tpm_startup), buffer, sizeof(buffer));
 
@@ -68,16 +72,23 @@ void tpm_util_startup(QTestState *s, tx_func *tx)
 void tpm_util_pcrextend(QTestState *s, tx_func *tx)
 {
     unsigned char buffer[1024];
-    static const unsigned char tpm_pcrextend[] =
-        "\x80\x02\x00\x00\x00\x41\x00\x00\x01\x82\x00\x00\x00\x0a\x00\x00"
-        "\x00\x09\x40\x00\x00\x09\x00\x00\x00\x00\x00\x00\x00\x00\x01\x00"
-        "\x0b\x74\x65\x73\x74\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
-        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
-        "\x00";
+    static const unsigned char tpm_pcrextend[] = {
+        0x80, 0x02, 0x00, 0x00, 0x00, 0x41, 0x00, 0x00,
+        0x01, 0x82, 0x00, 0x00, 0x00, 0x0a, 0x00, 0x00,
+        0x00, 0x09, 0x40, 0x00, 0x00, 0x09, 0x00, 0x00,
+        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00,
+        0x0b, 0x74, 0x65, 0x73, 0x74, 0x00, 0x00, 0x00,
+        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+        0x00
+    };
 
-    static const unsigned char tpm_pcrextend_resp[] =
-        "\x80\x02\x00\x00\x00\x13\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
-        "\x01\x00\x00";
+    static const unsigned char tpm_pcrextend_resp[] = {
+        0x80, 0x02, 0x00, 0x00, 0x00, 0x13, 0x00, 0x00,
+        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+        0x01, 0x00, 0x00
+    };
 
     tx(s, tpm_pcrextend, sizeof(tpm_pcrextend), buffer, sizeof(buffer));
 
@@ -89,9 +100,11 @@ void tpm_util_pcrread(QTestState *s, tx_func *tx,
                       const unsigned char *exp_resp, size_t exp_resp_size)
 {
     unsigned char buffer[1024];
-    static const unsigned char tpm_pcrread[] =
-        "\x80\x01\x00\x00\x00\x14\x00\x00\x01\x7e\x00\x00\x00\x01\x00\x0b"
-        "\x03\x00\x04\x00";
+    static const unsigned char tpm_pcrread[] = {
+        0x80, 0x01, 0x00, 0x00, 0x00, 0x14, 0x00, 0x00,
+        0x01, 0x7e, 0x00, 0x00, 0x00, 0x01, 0x00, 0x0b,
+        0x03, 0x00, 0x04, 0x00
+    };
 
     tx(s, tpm_pcrread, sizeof(tpm_pcrread), buffer, sizeof(buffer));
 
-- 
2.43.0


