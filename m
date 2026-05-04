Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 074E9FF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 20:34:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJzyH-0004C7-Nl; Mon, 04 May 2026 16:32:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wJzyC-0004Ax-UD
 for qemu-devel@nongnu.org; Mon, 04 May 2026 16:32:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wJzy6-0000Oo-Tr
 for qemu-devel@nongnu.org; Mon, 04 May 2026 16:32:47 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 644AO8Y92228785; Mon, 4 May 2026 20:32:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=gtB9oG+r8aujbjNBj
 xARxnNC5Lg2TEP6VN7NIzdUWOo=; b=Zbc3d4MIH0vs7aWULRk4jl9ox940yWMwC
 QZlPBmNtqIn87A28PWeIgsbN/NL2tG4+047GLNoVb8deI9x5n7rY/LId3gAScVbT
 +zHqUNP7YIfJdlktoOS+G6ImP+nE5ILWjEyKK+OzR5FQ5v7D5jAviefOenqiL+pf
 MUtqIKyGFQNA2y1oJ8Vwh0+/GW+/dI+Lv35nLgOV03OH+sjxpT7PI7U4rDNEINWT
 0JmQZgAo7NzphMjJvHUNc1J/0QnAc4jmHk7ct9h9DH18gAB+GHCb/n44bVR1RA9A
 4FKal2m+9WhTkSkHPJBpcaf5dX16mbg5Bp8+3KD1gZvYNYUG+c96A==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9xxghju-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 May 2026 20:32:41 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 644KOP2T000721;
 Mon, 4 May 2026 20:32:41 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwuyvxu6x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 May 2026 20:32:41 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 644KWeBq63242714
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 4 May 2026 20:32:40 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 70AD958055;
 Mon,  4 May 2026 20:32:40 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2307A58043;
 Mon,  4 May 2026 20:32:40 +0000 (GMT)
Received: from mycroft-2.pok.ibm.com (unknown [9.47.158.222])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  4 May 2026 20:32:40 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, armenon@redhat.com,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 4/5] tests: Use ML-DSA-87 operations to cause large TPM
 transfers with TIS
Date: Mon,  4 May 2026 20:32:27 +0000
Message-ID: <20260504203228.886578-5-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260504203228.886578-1-stefanb@linux.ibm.com>
References: <20260504203228.886578-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDE4NSBTYWx0ZWRfX164PIuvigy7D
 lpZdm+iPXodW/0lsR5RQ0Rcf3BPUPEMK26jJO2KcxHSRr//wWixgh57Nj41XW7wXePMiTXOjAET
 oPMM9OZxRp4AHTCbPgVkhtZk2YEilJ5bNi3iRU31jYrHRy6pGcHdfjQiWJJv7bDfu1zAxubB/Gn
 cAxrEXm0Xys80ZI2FHIMsbnxxmjsXUnOXUdU5waRJRKFsmD4bR4N+NbJb16oNc8ARtsVHQfp2IG
 mPZqeUIv+EaluUZmj0z8u/wrruwVt00qcmtu9PkJmEzOCtKEC1bne0vDMo9f5hjmB35zK+G0XJp
 m/ReQuNnPBXPuZh6NSs41td06JfZUUVOQqeUolmPdhOlanJGKsxO/FuNAS4r4Lcz3qV8KxTasot
 2QvTfpxxqnCAVCYH545qSDjr2OL2icTnSFwW958tyzTCIEnTNMhHRlqQ/GExevmMt9C1jl5aFO0
 ewUH30iKUux7tXFfcgg==
X-Proofpoint-ORIG-GUID: G98x5kVBDG-qaOJyCePuHqvn5lj9nmI6
X-Proofpoint-GUID: G98x5kVBDG-qaOJyCePuHqvn5lj9nmI6
X-Authority-Analysis: v=2.4 cv=ctWrVV4i c=1 sm=1 tr=0 ts=69f90269 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=TkI2L72SlmUIzsoL6scA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_05,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605040185
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

Test large data transfers with the TPM TIS over MMIO and I2C interfaces.
To do this, first create an ML-DSA-87 key and sign some data with it.
Then receive the 4627 bytes signature and subsequently send the
signature back to the TPM to have the TPM verify the signature.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 tests/qtest/tpm-tis-i2c-swtpm-test.c | 10 ++++++++++
 tests/qtest/tpm-tis-swtpm-test.c     | 10 ++++++++++
 2 files changed, 20 insertions(+)

diff --git a/tests/qtest/tpm-tis-i2c-swtpm-test.c b/tests/qtest/tpm-tis-i2c-swtpm-test.c
index 50d32a960b..9fbc000b59 100644
--- a/tests/qtest/tpm-tis-i2c-swtpm-test.c
+++ b/tests/qtest/tpm-tis-i2c-swtpm-test.c
@@ -36,6 +36,14 @@ static void tpm_tis_i2c_swtpm_test(const void *data)
                         ts->ifmodel, ts->machine_options);
 }
 
+static void tpm_tis_i2c_large_tx_swtpm_test(const void *data)
+{
+    const TestState *ts = data;
+
+    tpm_test_swtpm_large_tx_test(ts->src_tpm_path, tpm_tis_i2c_transfer,
+                                 ts->ifmodel, ts->machine_options);
+}
+
 static void tpm_tis_swtpm_migration_test(const void *data)
 {
     const TestState *ts = data;
@@ -67,6 +75,8 @@ int main(int argc, char **argv)
     aspeed_bus_addr = ast2600_i2c_calc_bus_addr(I2C_DEV_BUS_NUM);
 
     qtest_add_data_func("/tpm/tis-i2c-swtpm/test", &ts, tpm_tis_i2c_swtpm_test);
+    qtest_add_data_func("/tpm/tis-i2c-large-tx-swtpm/test", &ts,
+                        tpm_tis_i2c_large_tx_swtpm_test);
     qtest_add_data_func("/tpm/tis-i2c-swtpm-migration/test", &ts,
                         tpm_tis_swtpm_migration_test);
     ret = g_test_run();
diff --git a/tests/qtest/tpm-tis-swtpm-test.c b/tests/qtest/tpm-tis-swtpm-test.c
index 105e42e21d..d81fc32c1d 100644
--- a/tests/qtest/tpm-tis-swtpm-test.c
+++ b/tests/qtest/tpm-tis-swtpm-test.c
@@ -36,6 +36,14 @@ static void tpm_tis_swtpm_test(const void *data)
                         "tpm-tis", NULL);
 }
 
+static void tpm_tis_large_tx_swtpm_test(const void *data)
+{
+    const TestState *ts = data;
+
+    tpm_test_swtpm_large_tx_test(ts->src_tpm_path, tpm_tis_transfer,
+                                 "tpm-tis", NULL);
+}
+
 static void tpm_tis_swtpm_migration_test(const void *data)
 {
     const TestState *ts = data;
@@ -57,6 +65,8 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
 
     qtest_add_data_func("/tpm/tis-swtpm/test", &ts, tpm_tis_swtpm_test);
+    qtest_add_data_func("/tpm/tis-large-tx-swtpm/test", &ts,
+                        tpm_tis_large_tx_swtpm_test);
     qtest_add_data_func("/tpm/tis-swtpm-migration/test", &ts,
                         tpm_tis_swtpm_migration_test);
     ret = g_test_run();
-- 
2.53.0


