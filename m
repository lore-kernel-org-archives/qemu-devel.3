Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CDC9CD6E55
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 21:55:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUAah-0006au-St; Mon, 01 Jun 2026 17:54:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wUAaf-0006Za-5O
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 17:54:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wUAac-0003q0-Ro
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 17:54:32 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 651FSGjp798759; Mon, 1 Jun 2026 21:54:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Ra8VkI3Tzcvvknk7p
 Nktwigads5kFCGOP5VDpjMOFh0=; b=WKfJ4t/KqIr8goykj4GwcNU2SCOcydzqd
 ys3YRdw8h0JVYv6ClHRBQjefNtWORdeGkeWuWWltTJ+7hV8kux1Iovftq7d1K5hR
 0FogMengScjFc+9ztKR22Z6+XZWR/ioFmkSslD3XG0I0nzViV1mCxoRH5YPdOABJ
 kCC0oq7gkkMVcAdET0CtI1ZTXt8DR1qcxJHxCjxwZMXhg0azYs8Xrp6RiIZf9WeH
 aaujaCpO51rsLjL5j2x50mVMP9HRK8scC59wjSBoK7ayahbzl5rp78khu2Le3HlU
 e7Rahjj6QJsvLee52Cm29WA/+3PSsfWADs2p7qz4is2DwS3GJMfaQ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqjq32cv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 01 Jun 2026 21:54:28 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 651Ls9ep029549;
 Mon, 1 Jun 2026 21:54:27 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egb7k09at-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 01 Jun 2026 21:54:27 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 651LruSv7143954
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 1 Jun 2026 21:53:56 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A411A5805C;
 Mon,  1 Jun 2026 21:54:26 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2CC2A58054;
 Mon,  1 Jun 2026 21:54:26 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  1 Jun 2026 21:54:26 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Stefan Berger <stefanb@linux.ibm.com>,
 Arun Menon <armenon@redhat.com>
Subject: [PULL v1 03/16] tests: Convert string arrays to byte arrays
Date: Mon,  1 Jun 2026 17:53:56 -0400
Message-ID: <20260601215410.517009-4-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601215410.517009-1-stefanb@linux.ibm.com>
References: <20260601215410.517009-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fGD4w8Nn1sZX8kNOFWUDTuB3Ajp6AHVo
X-Proofpoint-GUID: fGD4w8Nn1sZX8kNOFWUDTuB3Ajp6AHVo
X-Authority-Analysis: v=2.4 cv=bcVbluPB c=1 sm=1 tr=0 ts=6a1dff94 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=LORrTqdot4XOhRVC2oUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDIxMSBTYWx0ZWRfXwS1FWuNMVrBZ
 vratDmDkZ2UVz+hbjL/3ETnob7KWKwZuk0Kg8OgYZ+p/UB+/lYFOEt7awf2X61Hf40erw3rdNGj
 CWhZ+RjDXRlfL+O+NSwIEarh6/PJBnUfc4+p1+Sq8WtGmksjdT7CsBrU8WtBScQ8DQeI2uol4U9
 q+CqHCs6//Aco3qhkEm3aZ83PFYKCgFPLIMgIaMk6I9zOc9Qy++OFboN3O4SAwSI1vwof4HKetK
 Cvv7zq1WdUV18eEwJG/JiKVMOTW0+bvjDqWfLaIvjKXvQRlj6kc5d/FHT27t/MgVF1/VRxPvfV1
 Il4legdqcA+yRqnuC5rdOZ5/7YvlW8IiHyA8wVndoJB19YT+t3M/sEKNAF0cIQEkqFKYEMPLK/S
 Z/HhuVXRMZjUt7Ch5RvP7Q/2aa/XRV99i9JLcQ7OLILM3u6dElAmE/M6c5kY7QQcAgARw21OYjJ
 LUt3i0mAKp8NKQ3RR4w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010211
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

Convert the TPM command and response string arrays to byte arrays.

Reviewed-by: Arun Menon <armenon@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260429121743.1346635-4-stefanb@linux.ibm.com
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
2.54.0


