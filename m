Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 425CAFF8877
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 12:19:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI3rk-0004Hq-1k; Wed, 29 Apr 2026 08:18:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wI3ra-0004Fx-2w
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 08:17:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wI3rV-0000qQ-TZ
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 08:17:57 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63T9Hg1x2930935; Wed, 29 Apr 2026 12:17:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=TMACQ2wuCxGdCWYVE
 6bc69xLlQ6Vo/Xg3Dq9YW4Inp4=; b=hcxQWr/XEX+/G+mc0Jq85qg2syn7bDGJQ
 /vmWmBNUpL0SMpcyR9s8Rx/lQKElewIH3PrigWtKAf7/1XdeOtqVg6BdV/yGizXF
 tfJ4dD8G8m7sSSalfbiLzOwWXwY2vKvgwX6rgcnmF7Ag6iGf3HYlApZ9OyaSGzBI
 9GFHQg+Hz/nuiIlelU4xeiuy5uC7Cinf/whCtZhCldSq6GOS9tfGyQFx0N5k+7EZ
 8XmwVDdwrlFNYo6JqSBeFeaJxp/rlqepJtzDoADId7L1MPkg1hZ75ryV5ZO2/q5P
 h++khXrWJ2E554ZAo0hGEu74PFggjhzSvoAFeh63cf7xlQQ4AZ9gw==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn9rabuu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Apr 2026 12:17:52 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63TBrpWf008018;
 Wed, 29 Apr 2026 12:17:51 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds9ehe47t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Apr 2026 12:17:51 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63TCHoY54653612
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Apr 2026 12:17:50 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 18D3A58045;
 Wed, 29 Apr 2026 12:17:50 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8980D58050;
 Wed, 29 Apr 2026 12:17:49 +0000 (GMT)
Received: from mycroft-2.pok.ibm.com (unknown [9.47.158.222])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 29 Apr 2026 12:17:49 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, armenon@redhat.com,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 2/6] tests: Have TPM I2C read/write functions take
 QTestState as first parameter
Date: Wed, 29 Apr 2026 12:17:39 +0000
Message-ID: <20260429121743.1346635-3-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429121743.1346635-1-stefanb@linux.ibm.com>
References: <20260429121743.1346635-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hVqizKvslkGfehkej5ixB34V7T3jTNKc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDEyNSBTYWx0ZWRfX68YulezzR91m
 nb0+Za/d3qscsuRe1YAlsP1sNr2SYxSuganpBgGZlR8b/d3Z3MEbsvmT/fJc0IaYD24YAzfkaeO
 /68cH0ecQqmeLltYu49nUKyZ2sTi9rbpnFLapcT54W+teYWdlf6Lemr7rnU5fXSQpA+3cJ2zL/9
 H5pQK5MO+LSh18ywx2ASpnueyYvwthtMki+HW0iqBvgKZyiqGbJTY58aD2LmBhXQd8QMgF1iAOR
 GIdHFsHoMCKN3esrBT1mIuKCd+e12zaKBCA3IhGIwE0ubGGZspWJuPB8/dBygOTwdn4r4OUYt1E
 5RgQqG9h1xlO0OboDSrEkvxkuo6JHvIk4UXn490/jANfKV0zLfNDrUv8FHVrGfvJRgRiOFDDXMf
 GIuBKX5Q7a1ynS5CZNJ64KS9Hs+0g9Drrt974J1f1M0nzOQtHvIWknm3Xw/MpSYEkhagAZZJ0Bg
 mURuE57gvdvgGXCuYmA==
X-Authority-Analysis: v=2.4 cv=Kc7idwYD c=1 sm=1 tr=0 ts=69f1f6f0 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=cp_pve3XC55RmFQTQzQA:9
X-Proofpoint-ORIG-GUID: hVqizKvslkGfehkej5ixB34V7T3jTNKc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290125
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

Pass the QTestState as first parameter to the TPM I2C functions. Use
global_qtest in existing test cases.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Arun Menon <armenon@redhat.com>
---
 tests/qtest/tpm-tis-i2c-test.c | 171 +++++++++++++++++----------------
 tests/qtest/tpm-tis-i2c-util.c |  32 +++---
 tests/qtest/tpm-tis-i2c-util.h |  10 +-
 3 files changed, 110 insertions(+), 103 deletions(-)

diff --git a/tests/qtest/tpm-tis-i2c-test.c b/tests/qtest/tpm-tis-i2c-test.c
index 02ddf76c2c..f614f888f3 100644
--- a/tests/qtest/tpm-tis-i2c-test.c
+++ b/tests/qtest/tpm-tis-i2c-test.c
@@ -50,62 +50,64 @@ static void tpm_tis_i2c_test_basic(const void *data)
      * All register accesses below must work without locality 0 being the
      * active locality. Therefore, ensure access is released.
      */
-    tpm_tis_i2c_writeb(0, TPM_I2C_REG_ACCESS,
+    tpm_tis_i2c_writeb(global_qtest, 0, TPM_I2C_REG_ACCESS,
                        TPM_TIS_ACCESS_ACTIVE_LOCALITY);
-    access = tpm_tis_i2c_readb(0, TPM_I2C_REG_ACCESS);
+    access = tpm_tis_i2c_readb(global_qtest, 0, TPM_I2C_REG_ACCESS);
     g_assert_cmpint(access, ==, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
                                 TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
 
     /* read interrupt capability -- none are supported */
-    v = tpm_tis_i2c_readl(0, TPM_I2C_REG_INT_CAPABILITY);
+    v = tpm_tis_i2c_readl(global_qtest, 0, TPM_I2C_REG_INT_CAPABILITY);
     g_assert_cmpint(v, ==, 0);
 
     /* try to enable all interrupts */
-    tpm_tis_i2c_writel(0, TPM_I2C_REG_INT_ENABLE, 0xffffffff);
-    v = tpm_tis_i2c_readl(0, TPM_I2C_REG_INT_ENABLE);
+    tpm_tis_i2c_writel(global_qtest, 0, TPM_I2C_REG_INT_ENABLE, 0xffffffff);
+    v = tpm_tis_i2c_readl(global_qtest, 0, TPM_I2C_REG_INT_ENABLE);
     /* none could be enabled */
     g_assert_cmpint(v, ==, 0);
 
     /* enable csum */
-    tpm_tis_i2c_writeb(0, TPM_I2C_REG_DATA_CSUM_ENABLE, TPM_DATA_CSUM_ENABLED);
+    tpm_tis_i2c_writeb(global_qtest, 0, TPM_I2C_REG_DATA_CSUM_ENABLE,
+                       TPM_DATA_CSUM_ENABLED);
     /* check csum enable register has bit 0 set */
-    v = tpm_tis_i2c_readb(0, TPM_I2C_REG_DATA_CSUM_ENABLE);
+    v = tpm_tis_i2c_readb(global_qtest, 0, TPM_I2C_REG_DATA_CSUM_ENABLE);
     g_assert_cmpint(v, ==, TPM_DATA_CSUM_ENABLED);
     /* reading it as 32bit register returns same result */
-    v = tpm_tis_i2c_readl(0, TPM_I2C_REG_DATA_CSUM_ENABLE);
+    v = tpm_tis_i2c_readl(global_qtest, 0, TPM_I2C_REG_DATA_CSUM_ENABLE);
     g_assert_cmpint(v, ==, TPM_DATA_CSUM_ENABLED);
 
     /* disable csum */
-    tpm_tis_i2c_writeb(0, TPM_I2C_REG_DATA_CSUM_ENABLE, 0);
+    tpm_tis_i2c_writeb(global_qtest, 0, TPM_I2C_REG_DATA_CSUM_ENABLE, 0);
     /* check csum enable register has bit 0 clear */
-    v = tpm_tis_i2c_readb(0, TPM_I2C_REG_DATA_CSUM_ENABLE);
+    v = tpm_tis_i2c_readb(global_qtest, 0, TPM_I2C_REG_DATA_CSUM_ENABLE);
     g_assert_cmpint(v, ==, 0);
 
     /* write to unsupported register '1' */
-    tpm_tis_i2c_writel(0, 1, 0x12345678);
-    v = tpm_tis_i2c_readl(0, 1);
+    tpm_tis_i2c_writel(global_qtest, 0, 1, 0x12345678);
+    v = tpm_tis_i2c_readl(global_qtest, 0, 1);
     g_assert_cmpint(v, ==, 0xffffffff);
 
     /* request use of locality */
-    tpm_tis_i2c_writeb(0, TPM_I2C_REG_ACCESS, TPM_TIS_ACCESS_REQUEST_USE);
+    tpm_tis_i2c_writeb(global_qtest, 0, TPM_I2C_REG_ACCESS,
+                       TPM_TIS_ACCESS_REQUEST_USE);
 
     /* read byte from STS + 3 */
-    v = tpm_tis_i2c_readb(0, TPM_I2C_REG_STS + 3);
+    v = tpm_tis_i2c_readb(global_qtest, 0, TPM_I2C_REG_STS + 3);
     g_assert_cmpint(v, ==, 0);
 
     /* check STS after writing to STS + 3 */
-    v = tpm_tis_i2c_readl(0, TPM_I2C_REG_STS);
-    tpm_tis_i2c_writeb(0, TPM_I2C_REG_STS + 3, 0xf);
-    v2 = tpm_tis_i2c_readl(0, TPM_I2C_REG_STS);
+    v = tpm_tis_i2c_readl(global_qtest, 0, TPM_I2C_REG_STS);
+    tpm_tis_i2c_writeb(global_qtest, 0, TPM_I2C_REG_STS + 3, 0xf);
+    v2 = tpm_tis_i2c_readl(global_qtest, 0, TPM_I2C_REG_STS);
     g_assert_cmpint(v, ==, v2);
 
     /* release access */
-    tpm_tis_i2c_writeb(0, TPM_I2C_REG_ACCESS,
+    tpm_tis_i2c_writeb(global_qtest, 0, TPM_I2C_REG_ACCESS,
                        TPM_TIS_ACCESS_ACTIVE_LOCALITY);
 
     /* select locality 5 -- must not be possible */
-    tpm_tis_i2c_writeb(0, TPM_I2C_REG_LOC_SEL, 5);
-    v = tpm_tis_i2c_readb(0, TPM_I2C_REG_LOC_SEL);
+    tpm_tis_i2c_writeb(global_qtest, 0, TPM_I2C_REG_LOC_SEL, 5);
+    v = tpm_tis_i2c_readb(global_qtest, 0, TPM_I2C_REG_LOC_SEL);
     g_assert_cmpint(v, ==, 0);
 }
 
@@ -118,11 +120,12 @@ static void tpm_tis_i2c_test_check_localities(const void *data)
     uint32_t rid;
 
     for (locty = 0; locty < TPM_TIS_NUM_LOCALITIES; locty++) {
-        access = tpm_tis_i2c_readb(locty, TPM_I2C_REG_ACCESS);
+        access = tpm_tis_i2c_readb(global_qtest, locty, TPM_I2C_REG_ACCESS);
         g_assert_cmpint(access, ==, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
                                     TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
 
-        capability = tpm_tis_i2c_readl(locty, TPM_I2C_REG_INTF_CAPABILITY);
+        capability = tpm_tis_i2c_readl(global_qtest, locty,
+                                       TPM_I2C_REG_INTF_CAPABILITY);
         i2c_cap = (TPM_I2C_CAP_INTERFACE_TYPE |
                    TPM_I2C_CAP_INTERFACE_VER  |
                    TPM_I2C_CAP_TPM2_FAMILY    |
@@ -131,15 +134,15 @@ static void tpm_tis_i2c_test_check_localities(const void *data)
                    TPM_I2C_CAP_DEV_ADDR_CHANGE);
         g_assert_cmpint(capability, ==, i2c_cap);
 
-        didvid = tpm_tis_i2c_readl(locty, TPM_I2C_REG_DID_VID);
+        didvid = tpm_tis_i2c_readl(global_qtest, locty, TPM_I2C_REG_DID_VID);
         g_assert_cmpint(didvid, ==, (1 << 16) | PCI_VENDOR_ID_IBM);
 
-        rid = tpm_tis_i2c_readl(locty, TPM_I2C_REG_RID);
+        rid = tpm_tis_i2c_readl(global_qtest, locty, TPM_I2C_REG_RID);
         g_assert_cmpint(rid, !=, 0);
         g_assert_cmpint(rid, !=, 0xffffffff);
 
         /* locality selection must be at locty */
-        l = tpm_tis_i2c_readb(locty, TPM_I2C_REG_LOC_SEL);
+        l = tpm_tis_i2c_readb(global_qtest, locty, TPM_I2C_REG_LOC_SEL);
         g_assert_cmpint(l, ==, locty);
     }
 }
@@ -151,23 +154,23 @@ static void tpm_tis_i2c_test_check_access_reg(const void *data)
 
     /* do not test locality 4 (hw only) */
     for (locty = 0; locty < TPM_TIS_NUM_LOCALITIES - 1; locty++) {
-        access = tpm_tis_i2c_readb(locty, TPM_I2C_REG_ACCESS);
+        access = tpm_tis_i2c_readb(global_qtest, locty, TPM_I2C_REG_ACCESS);
         g_assert_cmpint(access, ==, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
                                     TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
 
         /* request use of locality */
-        tpm_tis_i2c_writeb(locty, TPM_I2C_REG_ACCESS,
+        tpm_tis_i2c_writeb(global_qtest, locty, TPM_I2C_REG_ACCESS,
                            TPM_TIS_ACCESS_REQUEST_USE);
 
-        access = tpm_tis_i2c_readb(locty, TPM_I2C_REG_ACCESS);
+        access = tpm_tis_i2c_readb(global_qtest, locty, TPM_I2C_REG_ACCESS);
         g_assert_cmpint(access, ==, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
                                     TPM_TIS_ACCESS_ACTIVE_LOCALITY |
                                     TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
 
         /* release access */
-        tpm_tis_i2c_writeb(locty, TPM_I2C_REG_ACCESS,
+        tpm_tis_i2c_writeb(global_qtest, locty, TPM_I2C_REG_ACCESS,
                            TPM_TIS_ACCESS_ACTIVE_LOCALITY);
-        access = tpm_tis_i2c_readb(locty, TPM_I2C_REG_ACCESS);
+        access = tpm_tis_i2c_readb(global_qtest, locty, TPM_I2C_REG_ACCESS);
         g_assert_cmpint(access, ==, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
                                     TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
     }
@@ -186,14 +189,14 @@ static void tpm_tis_i2c_test_check_access_reg_seize(const void *data)
     for (locty = 0; locty < TPM_TIS_NUM_LOCALITIES - 1; locty++) {
         pending_request_flag = 0;
 
-        access = tpm_tis_i2c_readb(locty, TPM_I2C_REG_ACCESS);
+        access = tpm_tis_i2c_readb(global_qtest, locty, TPM_I2C_REG_ACCESS);
         g_assert_cmpint(access, ==, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
                                     TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
 
         /* request use of locality */
-        tpm_tis_i2c_writeb(locty,
+        tpm_tis_i2c_writeb(global_qtest, locty,
                            TPM_I2C_REG_ACCESS, TPM_TIS_ACCESS_REQUEST_USE);
-        access = tpm_tis_i2c_readb(locty, TPM_I2C_REG_ACCESS);
+        access = tpm_tis_i2c_readb(global_qtest, locty, TPM_I2C_REG_ACCESS);
         g_assert_cmpint(access, ==, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
                                     TPM_TIS_ACCESS_ACTIVE_LOCALITY |
                                     TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
@@ -201,14 +204,14 @@ static void tpm_tis_i2c_test_check_access_reg_seize(const void *data)
         /* lower localities cannot seize access */
         for (l = 0; l < locty; l++) {
             /* lower locality is not active */
-            access = tpm_tis_i2c_readb(l, TPM_I2C_REG_ACCESS);
+            access = tpm_tis_i2c_readb(global_qtest, l, TPM_I2C_REG_ACCESS);
             DPRINTF_ACCESS;
             g_assert_cmpint(access, ==, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
                                         pending_request_flag |
                                         TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
 
             /* try to request use from 'l' */
-            tpm_tis_i2c_writeb(l,
+            tpm_tis_i2c_writeb(global_qtest, l,
                                TPM_I2C_REG_ACCESS,
                                TPM_TIS_ACCESS_REQUEST_USE);
 
@@ -216,7 +219,7 @@ static void tpm_tis_i2c_test_check_access_reg_seize(const void *data)
              * requesting use from 'l' was not possible;
              * we must see REQUEST_USE and possibly PENDING_REQUEST
              */
-            access = tpm_tis_i2c_readb(l, TPM_I2C_REG_ACCESS);
+            access = tpm_tis_i2c_readb(global_qtest, l, TPM_I2C_REG_ACCESS);
             DPRINTF_ACCESS;
             g_assert_cmpint(access, ==, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
                                         TPM_TIS_ACCESS_REQUEST_USE |
@@ -227,17 +230,17 @@ static void tpm_tis_i2c_test_check_access_reg_seize(const void *data)
              * locality 'locty' must be unchanged;
              * we must see PENDING_REQUEST
              */
-            access = tpm_tis_i2c_readb(locty, TPM_I2C_REG_ACCESS);
+            access = tpm_tis_i2c_readb(global_qtest, locty, TPM_I2C_REG_ACCESS);
             g_assert_cmpint(access, ==, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
                                         TPM_TIS_ACCESS_ACTIVE_LOCALITY |
                                         TPM_TIS_ACCESS_PENDING_REQUEST |
                                         TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
 
             /* try to seize from 'l' */
-            tpm_tis_i2c_writeb(l,
+            tpm_tis_i2c_writeb(global_qtest, l,
                                TPM_I2C_REG_ACCESS, TPM_TIS_ACCESS_SEIZE);
             /* seize from 'l' was not possible */
-            access = tpm_tis_i2c_readb(l, TPM_I2C_REG_ACCESS);
+            access = tpm_tis_i2c_readb(global_qtest, l, TPM_I2C_REG_ACCESS);
             DPRINTF_ACCESS;
             g_assert_cmpint(access, ==, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
                                         TPM_TIS_ACCESS_REQUEST_USE |
@@ -245,7 +248,7 @@ static void tpm_tis_i2c_test_check_access_reg_seize(const void *data)
                                         TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
 
             /* locality 'locty' must be unchanged */
-            access = tpm_tis_i2c_readb(locty, TPM_I2C_REG_ACCESS);
+            access = tpm_tis_i2c_readb(global_qtest, locty, TPM_I2C_REG_ACCESS);
             g_assert_cmpint(access, ==, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
                                         TPM_TIS_ACCESS_ACTIVE_LOCALITY |
                                         TPM_TIS_ACCESS_PENDING_REQUEST |
@@ -264,14 +267,14 @@ static void tpm_tis_i2c_test_check_access_reg_seize(const void *data)
          */
         for (l = locty + 1; l < TPM_TIS_NUM_LOCALITIES - 1; l++) {
             /* try to 'request use' from 'l' */
-            tpm_tis_i2c_writeb(l, TPM_I2C_REG_ACCESS,
+            tpm_tis_i2c_writeb(global_qtest, l, TPM_I2C_REG_ACCESS,
                                TPM_TIS_ACCESS_REQUEST_USE);
 
             /*
              * requesting use from 'l' was not possible; we should see
              * REQUEST_USE and may see PENDING_REQUEST
              */
-            access = tpm_tis_i2c_readb(l, TPM_I2C_REG_ACCESS);
+            access = tpm_tis_i2c_readb(global_qtest, l, TPM_I2C_REG_ACCESS);
             DPRINTF_ACCESS;
             g_assert_cmpint(access, ==, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
                                         TPM_TIS_ACCESS_REQUEST_USE |
@@ -282,7 +285,7 @@ static void tpm_tis_i2c_test_check_access_reg_seize(const void *data)
              * locality 'l-1' must be unchanged; we should always
              * see PENDING_REQUEST from 'l' requesting access
              */
-            access = tpm_tis_i2c_readb(l - 1, TPM_I2C_REG_ACCESS);
+            access = tpm_tis_i2c_readb(global_qtest, l - 1, TPM_I2C_REG_ACCESS);
             DPRINTF_ACCESS;
             g_assert_cmpint(access, ==, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
                                         TPM_TIS_ACCESS_ACTIVE_LOCALITY |
@@ -290,10 +293,11 @@ static void tpm_tis_i2c_test_check_access_reg_seize(const void *data)
                                         TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
 
             /* try to seize from 'l' */
-            tpm_tis_i2c_writeb(l, TPM_I2C_REG_ACCESS, TPM_TIS_ACCESS_SEIZE);
+            tpm_tis_i2c_writeb(global_qtest, l, TPM_I2C_REG_ACCESS,
+                                TPM_TIS_ACCESS_SEIZE);
 
             /* seize from 'l' was possible */
-            access = tpm_tis_i2c_readb(l, TPM_I2C_REG_ACCESS);
+            access = tpm_tis_i2c_readb(global_qtest, l, TPM_I2C_REG_ACCESS);
             DPRINTF_ACCESS;
             g_assert_cmpint(access, ==, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
                                         TPM_TIS_ACCESS_ACTIVE_LOCALITY |
@@ -301,7 +305,7 @@ static void tpm_tis_i2c_test_check_access_reg_seize(const void *data)
                                         TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
 
             /* l - 1 should show that it has BEEN_SEIZED */
-            access = tpm_tis_i2c_readb(l - 1, TPM_I2C_REG_ACCESS);
+            access = tpm_tis_i2c_readb(global_qtest, l - 1, TPM_I2C_REG_ACCESS);
             DPRINTF_ACCESS;
             g_assert_cmpint(access, ==, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
                                         TPM_TIS_ACCESS_BEEN_SEIZED |
@@ -309,10 +313,10 @@ static void tpm_tis_i2c_test_check_access_reg_seize(const void *data)
                                         TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
 
             /* clear the BEEN_SEIZED flag and make sure it's gone */
-            tpm_tis_i2c_writeb(l - 1, TPM_I2C_REG_ACCESS,
+            tpm_tis_i2c_writeb(global_qtest, l - 1, TPM_I2C_REG_ACCESS,
                                TPM_TIS_ACCESS_BEEN_SEIZED);
 
-            access = tpm_tis_i2c_readb(l - 1, TPM_I2C_REG_ACCESS);
+            access = tpm_tis_i2c_readb(global_qtest, l - 1, TPM_I2C_REG_ACCESS);
             g_assert_cmpint(access, ==, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
                                         pending_request_flag |
                                         TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
@@ -330,22 +334,22 @@ static void tpm_tis_i2c_test_check_access_reg_seize(const void *data)
         /* release access from l - 1; this activates locty - 1 */
         l--;
 
-        access = tpm_tis_i2c_readb(l, TPM_I2C_REG_ACCESS);
+        access = tpm_tis_i2c_readb(global_qtest, l, TPM_I2C_REG_ACCESS);
         DPRINTF_ACCESS;
 
         DPRINTF("%s: %d: relinquishing control on l = %d\n",
                 __func__, __LINE__, l);
-        tpm_tis_i2c_writeb(l, TPM_I2C_REG_ACCESS,
+        tpm_tis_i2c_writeb(global_qtest, l, TPM_I2C_REG_ACCESS,
                            TPM_TIS_ACCESS_ACTIVE_LOCALITY);
 
-        access = tpm_tis_i2c_readb(l, TPM_I2C_REG_ACCESS);
+        access = tpm_tis_i2c_readb(global_qtest, l, TPM_I2C_REG_ACCESS);
         DPRINTF_ACCESS;
         g_assert_cmpint(access, ==, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
                                     pending_request_flag |
                                     TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
 
         for (l = locty - 1; l >= 0; l--) {
-            access = tpm_tis_i2c_readb(l, TPM_I2C_REG_ACCESS);
+            access = tpm_tis_i2c_readb(global_qtest, l, TPM_I2C_REG_ACCESS);
             DPRINTF_ACCESS;
             g_assert_cmpint(access, ==, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
                                         TPM_TIS_ACCESS_ACTIVE_LOCALITY |
@@ -353,7 +357,7 @@ static void tpm_tis_i2c_test_check_access_reg_seize(const void *data)
                                         TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
 
             /* release this locality */
-            tpm_tis_i2c_writeb(l, TPM_I2C_REG_ACCESS,
+            tpm_tis_i2c_writeb(global_qtest, l, TPM_I2C_REG_ACCESS,
                                TPM_TIS_ACCESS_ACTIVE_LOCALITY);
 
             if (l == 1) {
@@ -363,7 +367,7 @@ static void tpm_tis_i2c_test_check_access_reg_seize(const void *data)
 
         /* no locality may be active now */
         for (l = 0; l < TPM_TIS_NUM_LOCALITIES - 1; l++) {
-            access = tpm_tis_i2c_readb(l, TPM_I2C_REG_ACCESS);
+            access = tpm_tis_i2c_readb(global_qtest, l, TPM_I2C_REG_ACCESS);
             DPRINTF_ACCESS;
             g_assert_cmpint(access, ==, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
                                         TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
@@ -384,14 +388,14 @@ static void tpm_tis_i2c_test_check_access_reg_release(const void *data)
     for (locty = TPM_TIS_NUM_LOCALITIES - 2; locty >= 0; locty--) {
         pending_request_flag = 0;
 
-        access = tpm_tis_i2c_readb(locty, TPM_I2C_REG_ACCESS);
+        access = tpm_tis_i2c_readb(global_qtest, locty, TPM_I2C_REG_ACCESS);
         g_assert_cmpint(access, ==, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
                                     TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
 
         /* request use of locality */
-        tpm_tis_i2c_writeb(locty, TPM_I2C_REG_ACCESS,
+        tpm_tis_i2c_writeb(global_qtest, locty, TPM_I2C_REG_ACCESS,
                            TPM_TIS_ACCESS_REQUEST_USE);
-        access = tpm_tis_i2c_readb(locty, TPM_I2C_REG_ACCESS);
+        access = tpm_tis_i2c_readb(global_qtest, locty, TPM_I2C_REG_ACCESS);
         g_assert_cmpint(access, ==, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
                                     TPM_TIS_ACCESS_ACTIVE_LOCALITY |
                                     TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
@@ -405,9 +409,9 @@ static void tpm_tis_i2c_test_check_access_reg_release(const void *data)
              * request use of locality 'l' -- we MUST see REQUEST USE and
              * may see PENDING_REQUEST
              */
-            tpm_tis_i2c_writeb(l, TPM_I2C_REG_ACCESS,
+            tpm_tis_i2c_writeb(global_qtest, l, TPM_I2C_REG_ACCESS,
                                TPM_TIS_ACCESS_REQUEST_USE);
-            access = tpm_tis_i2c_readb(l, TPM_I2C_REG_ACCESS);
+            access = tpm_tis_i2c_readb(global_qtest, l, TPM_I2C_REG_ACCESS);
             DPRINTF_ACCESS;
             g_assert_cmpint(access, ==, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
                                         TPM_TIS_ACCESS_REQUEST_USE |
@@ -416,7 +420,7 @@ static void tpm_tis_i2c_test_check_access_reg_release(const void *data)
             pending_request_flag = TPM_TIS_ACCESS_PENDING_REQUEST;
         }
         /* release locality 'locty' */
-        tpm_tis_i2c_writeb(locty, TPM_I2C_REG_ACCESS,
+        tpm_tis_i2c_writeb(global_qtest, locty, TPM_I2C_REG_ACCESS,
                            TPM_TIS_ACCESS_ACTIVE_LOCALITY);
         /*
          * highest locality should now be active; release it and make sure the
@@ -427,16 +431,16 @@ static void tpm_tis_i2c_test_check_access_reg_release(const void *data)
                 continue;
             }
             /* 'l' should be active now */
-            access = tpm_tis_i2c_readb(l, TPM_I2C_REG_ACCESS);
+            access = tpm_tis_i2c_readb(global_qtest, l, TPM_I2C_REG_ACCESS);
             DPRINTF_ACCESS;
             g_assert_cmpint(access, ==, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
                                         TPM_TIS_ACCESS_ACTIVE_LOCALITY |
                                         pending_request_flag |
                                         TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
             /* 'l' relinquishes access */
-            tpm_tis_i2c_writeb(l, TPM_I2C_REG_ACCESS,
+            tpm_tis_i2c_writeb(global_qtest, l, TPM_I2C_REG_ACCESS,
                                TPM_TIS_ACCESS_ACTIVE_LOCALITY);
-            access = tpm_tis_i2c_readb(l, TPM_I2C_REG_ACCESS);
+            access = tpm_tis_i2c_readb(global_qtest, l, TPM_I2C_REG_ACCESS);
             DPRINTF_ACCESS;
             if (l == 1 || (locty <= 1 && l == 2)) {
                 pending_request_flag = 0;
@@ -460,22 +464,24 @@ static void tpm_tis_i2c_test_check_transmit(const void *data)
     size_t i;
 
     /* enable csum */
-    tpm_tis_i2c_writeb(0, TPM_I2C_REG_DATA_CSUM_ENABLE, TPM_DATA_CSUM_ENABLED);
+    tpm_tis_i2c_writeb(global_qtest, 0, TPM_I2C_REG_DATA_CSUM_ENABLE,
+                       TPM_DATA_CSUM_ENABLED);
     /* check csum enable register has bit 0 set */
-    v = tpm_tis_i2c_readb(0, TPM_I2C_REG_DATA_CSUM_ENABLE);
+    v = tpm_tis_i2c_readb(global_qtest, 0, TPM_I2C_REG_DATA_CSUM_ENABLE);
     g_assert_cmpint(v, ==, TPM_DATA_CSUM_ENABLED);
     /* reading it as 32bit register returns same result */
-    v = tpm_tis_i2c_readl(0, TPM_I2C_REG_DATA_CSUM_ENABLE);
+    v = tpm_tis_i2c_readl(global_qtest, 0, TPM_I2C_REG_DATA_CSUM_ENABLE);
     g_assert_cmpint(v, ==, TPM_DATA_CSUM_ENABLED);
 
     /* request use of locality 0 */
-    tpm_tis_i2c_writeb(0, TPM_I2C_REG_ACCESS, TPM_TIS_ACCESS_REQUEST_USE);
-    access = tpm_tis_i2c_readb(0, TPM_I2C_REG_ACCESS);
+    tpm_tis_i2c_writeb(global_qtest, 0, TPM_I2C_REG_ACCESS,
+                       TPM_TIS_ACCESS_REQUEST_USE);
+    access = tpm_tis_i2c_readb(global_qtest, 0, TPM_I2C_REG_ACCESS);
     g_assert_cmpint(access, ==, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
                                 TPM_TIS_ACCESS_ACTIVE_LOCALITY |
                                 TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
 
-    sts = tpm_tis_i2c_readl(0, TPM_I2C_REG_STS);
+    sts = tpm_tis_i2c_readl(global_qtest, 0, TPM_I2C_REG_STS);
     DPRINTF_STS;
 
     g_assert_cmpint(sts & 0xff, ==, 0);
@@ -484,21 +490,22 @@ static void tpm_tis_i2c_test_check_transmit(const void *data)
     g_assert_cmpint(bcount, >=, 128);
 
     /* read bcount from STS + 1 must work also */
-    bcount2 = tpm_tis_i2c_readw(0, TPM_I2C_REG_STS + 1);
+    bcount2 = tpm_tis_i2c_readw(global_qtest, 0, TPM_I2C_REG_STS + 1);
     g_assert_cmpint(bcount, ==, bcount2);
 
     /* ic2 must have bits 26-31 zero */
     g_assert_cmpint(sts & (0x1f << 26), ==, 0);
 
-    tpm_tis_i2c_writel(0, TPM_I2C_REG_STS, TPM_TIS_STS_COMMAND_READY);
-    sts = tpm_tis_i2c_readl(0, TPM_I2C_REG_STS);
+    tpm_tis_i2c_writel(global_qtest, 0, TPM_I2C_REG_STS,
+                       TPM_TIS_STS_COMMAND_READY);
+    sts = tpm_tis_i2c_readl(global_qtest, 0, TPM_I2C_REG_STS);
     DPRINTF_STS;
     g_assert_cmpint(sts & 0xff, ==, TPM_TIS_STS_COMMAND_READY);
 
     /* transmit command */
     for (i = 0; i < sizeof(TPM_CMD); i++) {
-        tpm_tis_i2c_writeb(0, TPM_I2C_REG_DATA_FIFO, TPM_CMD[i]);
-        sts = tpm_tis_i2c_readl(0, TPM_I2C_REG_STS);
+        tpm_tis_i2c_writeb(global_qtest, 0, TPM_I2C_REG_DATA_FIFO, TPM_CMD[i]);
+        sts = tpm_tis_i2c_readl(global_qtest, 0, TPM_I2C_REG_STS);
         DPRINTF_STS;
         if (i < sizeof(TPM_CMD) - 1) {
             g_assert_cmpint(sts & 0xff, ==,
@@ -509,21 +516,21 @@ static void tpm_tis_i2c_test_check_transmit(const void *data)
         g_assert_cmpint((sts >> 8) & 0xffff, ==, --bcount);
     }
     /* read the checksum */
-    csum = tpm_tis_i2c_readw(0, TPM_I2C_REG_DATA_CSUM_GET);
+    csum = tpm_tis_i2c_readw(global_qtest, 0, TPM_I2C_REG_DATA_CSUM_GET);
     g_assert_cmpint(csum, ==, 0x6733);
 
     /* start processing */
-    tpm_tis_i2c_writeb(0, TPM_I2C_REG_STS, TPM_TIS_STS_TPM_GO);
+    tpm_tis_i2c_writeb(global_qtest, 0, TPM_I2C_REG_STS, TPM_TIS_STS_TPM_GO);
 
     uint64_t end_time = g_get_monotonic_time() + 50 * G_TIME_SPAN_SECOND;
     do {
-        sts = tpm_tis_i2c_readl(0, TPM_I2C_REG_STS);
+        sts = tpm_tis_i2c_readl(global_qtest, 0, TPM_I2C_REG_STS);
         if ((sts & TPM_TIS_STS_DATA_AVAILABLE) != 0) {
             break;
         }
     } while (g_get_monotonic_time() < end_time);
 
-    sts = tpm_tis_i2c_readl(0, TPM_I2C_REG_STS);
+    sts = tpm_tis_i2c_readl(global_qtest, 0, TPM_I2C_REG_STS);
     DPRINTF_STS;
     g_assert_cmpint(sts & 0xff, == ,
                     TPM_TIS_STS_VALID | TPM_TIS_STS_DATA_AVAILABLE);
@@ -534,8 +541,8 @@ static void tpm_tis_i2c_test_check_transmit(const void *data)
     g_assert_cmpint(sizeof(tpm_msg), ==, bcount);
 
     for (i = 0; i < sizeof(tpm_msg); i++) {
-        tpm_msg[i] = tpm_tis_i2c_readb(0, TPM_I2C_REG_DATA_FIFO);
-        sts = tpm_tis_i2c_readl(0, TPM_I2C_REG_STS);
+        tpm_msg[i] = tpm_tis_i2c_readb(global_qtest, 0, TPM_I2C_REG_DATA_FIFO);
+        sts = tpm_tis_i2c_readl(global_qtest, 0, TPM_I2C_REG_STS);
         DPRINTF_STS;
         if (sts & TPM_TIS_STS_DATA_AVAILABLE) {
             g_assert_cmpint((sts >> 8) & 0xffff, ==, --bcount);
@@ -544,9 +551,9 @@ static void tpm_tis_i2c_test_check_transmit(const void *data)
     g_assert_cmpmem(tpm_msg, sizeof(tpm_msg), s->tpm_msg, sizeof(*s->tpm_msg));
 
     /* relinquish use of locality 0 */
-    tpm_tis_i2c_writeb(0,
+    tpm_tis_i2c_writeb(global_qtest, 0,
                        TPM_I2C_REG_ACCESS, TPM_TIS_ACCESS_ACTIVE_LOCALITY);
-    access = tpm_tis_i2c_readb(0, TPM_I2C_REG_ACCESS);
+    access = tpm_tis_i2c_readb(global_qtest, 0, TPM_I2C_REG_ACCESS);
 }
 
 int main(int argc, char **argv)
diff --git a/tests/qtest/tpm-tis-i2c-util.c b/tests/qtest/tpm-tis-i2c-util.c
index 07b1eeba69..6e724a4a47 100644
--- a/tests/qtest/tpm-tis-i2c-util.c
+++ b/tests/qtest/tpm-tis-i2c-util.c
@@ -20,45 +20,45 @@ uint32_t aspeed_bus_addr;
 
 static uint8_t cur_locty = 0xff;
 
-static void tpm_tis_i2c_set_locty(uint8_t locty)
+static void tpm_tis_i2c_set_locty(QTestState *s, uint8_t locty)
 {
     if (cur_locty != locty) {
         cur_locty = locty;
-        aspeed_i2c_writeb(global_qtest, aspeed_bus_addr, I2C_SLAVE_ADDR,
+        aspeed_i2c_writeb(s, aspeed_bus_addr, I2C_SLAVE_ADDR,
                           TPM_I2C_REG_LOC_SEL, locty);
     }
 }
 
-uint8_t tpm_tis_i2c_readb(uint8_t locty, uint8_t reg)
+uint8_t tpm_tis_i2c_readb(QTestState *s, uint8_t locty, uint8_t reg)
 {
-    tpm_tis_i2c_set_locty(locty);
-    return aspeed_i2c_readb(global_qtest, aspeed_bus_addr, I2C_SLAVE_ADDR, reg);
+    tpm_tis_i2c_set_locty(s, locty);
+    return aspeed_i2c_readb(s, aspeed_bus_addr, I2C_SLAVE_ADDR, reg);
 }
 
-uint16_t tpm_tis_i2c_readw(uint8_t locty, uint8_t reg)
+uint16_t tpm_tis_i2c_readw(QTestState *s, uint8_t locty, uint8_t reg)
 {
-    tpm_tis_i2c_set_locty(locty);
+    tpm_tis_i2c_set_locty(s, locty);
     return aspeed_i2c_readw(global_qtest, aspeed_bus_addr, I2C_SLAVE_ADDR, reg);
 }
 
-uint32_t tpm_tis_i2c_readl(uint8_t locty, uint8_t reg)
+uint32_t tpm_tis_i2c_readl(QTestState *s, uint8_t locty, uint8_t reg)
 {
-    tpm_tis_i2c_set_locty(locty);
-    return aspeed_i2c_readl(global_qtest, aspeed_bus_addr, I2C_SLAVE_ADDR, reg);
+    tpm_tis_i2c_set_locty(s, locty);
+    return aspeed_i2c_readl(s, aspeed_bus_addr, I2C_SLAVE_ADDR, reg);
 }
 
-void tpm_tis_i2c_writeb(uint8_t locty, uint8_t reg, uint8_t v)
+void tpm_tis_i2c_writeb(QTestState *s, uint8_t locty, uint8_t reg, uint8_t v)
 {
     if (reg != TPM_I2C_REG_LOC_SEL) {
-        tpm_tis_i2c_set_locty(locty);
+        tpm_tis_i2c_set_locty(s, locty);
     }
-    aspeed_i2c_writeb(global_qtest, aspeed_bus_addr, I2C_SLAVE_ADDR, reg, v);
+    aspeed_i2c_writeb(s, aspeed_bus_addr, I2C_SLAVE_ADDR, reg, v);
 }
 
-void tpm_tis_i2c_writel(uint8_t locty, uint8_t reg, uint32_t v)
+void tpm_tis_i2c_writel(QTestState *s, uint8_t locty, uint8_t reg, uint32_t v)
 {
     if (reg != TPM_I2C_REG_LOC_SEL) {
-        tpm_tis_i2c_set_locty(locty);
+        tpm_tis_i2c_set_locty(s, locty);
     }
-    aspeed_i2c_writel(global_qtest, aspeed_bus_addr, I2C_SLAVE_ADDR, reg, v);
+    aspeed_i2c_writel(s, aspeed_bus_addr, I2C_SLAVE_ADDR, reg, v);
 }
diff --git a/tests/qtest/tpm-tis-i2c-util.h b/tests/qtest/tpm-tis-i2c-util.h
index dfe626b43d..3289545f61 100644
--- a/tests/qtest/tpm-tis-i2c-util.h
+++ b/tests/qtest/tpm-tis-i2c-util.h
@@ -20,11 +20,11 @@ extern uint32_t aspeed_bus_addr;
 #define I2C_SLAVE_ADDR   0x2e
 #define I2C_DEV_BUS_NUM  10
 
-uint8_t tpm_tis_i2c_readb(uint8_t locty, uint8_t reg);
-uint16_t tpm_tis_i2c_readw(uint8_t locty, uint8_t reg);
-uint32_t tpm_tis_i2c_readl(uint8_t locty, uint8_t reg);
+uint8_t tpm_tis_i2c_readb(QTestState *s, uint8_t locty, uint8_t reg);
+uint16_t tpm_tis_i2c_readw(QTestState *s, uint8_t locty, uint8_t reg);
+uint32_t tpm_tis_i2c_readl(QTestState *s, uint8_t locty, uint8_t reg);
 
-void tpm_tis_i2c_writeb(uint8_t locty, uint8_t reg, uint8_t v);
-void tpm_tis_i2c_writel(uint8_t locty, uint8_t reg, uint32_t v);
+void tpm_tis_i2c_writeb(QTestState *s, uint8_t locty, uint8_t reg, uint8_t v);
+void tpm_tis_i2c_writel(QTestState *s, uint8_t locty, uint8_t reg, uint32_t v);
 
 #endif /* TESTS_TPM_TIS_I2C_UTIL_H */
-- 
2.43.0


