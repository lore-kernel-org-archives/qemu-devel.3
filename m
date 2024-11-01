Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 606CEE6F07D
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 18:59:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6wr9-0000In-Ud; Fri, 01 Nov 2024 14:58:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dantan@linux.vnet.ibm.com>)
 id 1t6wqn-0008Nk-VR; Fri, 01 Nov 2024 14:58:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dantan@linux.vnet.ibm.com>)
 id 1t6wqk-0000hS-F8; Fri, 01 Nov 2024 14:58:24 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A1ADeBq020395;
 Fri, 1 Nov 2024 18:58:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Pv72VnSejRlgiFSQY
 1UG+jF1ibI3kQUHGKtfcEkpqEQ=; b=J9WK/x12GbGxMSPKV2b/qM+Uhci128Vkb
 XUceNF53ynEA6laLWd7X6Y1zaAuj0wa7quUpwgmBve/x8nke0EwW9C9tgUv/Mh8A
 tztTZqG5pU5gBL/DzsNjacmSBWqvJJgbcrbYGrmpoxrjFK8EnN1m88lIbcvhWtqi
 cCXD8wHL6q0zT3lIRlXCynRgS8XwOdRy8gn1SKWvi22bsxzt7JPGF2jQxoyXVE1R
 2aMcjgZqUcZHpGKJh524xW3ODSeoC9BLmhavGM11/6/CXuweqVfhbMRP3wKNV8Wv
 0wzzm6pG4ZwEwf/7khe+aHVQuZoxBpZrElp7DkuxszRivTIs4IdiA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42mvp221e8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 Nov 2024 18:58:12 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A1HeNvk024554;
 Fri, 1 Nov 2024 18:58:12 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42hcyjtsx6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 Nov 2024 18:58:12 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4A1IwBkG41222580
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 1 Nov 2024 18:58:11 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 69CA758053;
 Fri,  1 Nov 2024 18:58:11 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0374D58043;
 Fri,  1 Nov 2024 18:58:11 +0000 (GMT)
Received: from gfwa829.aus.stglabs.ibm.com (unknown [9.3.84.19])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  1 Nov 2024 18:58:10 +0000 (GMT)
From: dan tan <dantan@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, stefanb@linux.vnet.ibm.com, pbonzini@redhat.com,
 farosas@suse.de, lvivier@redhat.com, clg@kaod.org
Subject: [PATCH v3 5/5] tests/qtest/tpm: add unit test to tis-spi (rev 3)
Date: Fri,  1 Nov 2024 13:57:18 -0500
Message-Id: <20241101185718.5847-6-dantan@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241101185718.5847-1-dantan@linux.vnet.ibm.com>
References: <20241101185718.5847-1-dantan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: l8KHWzL8Gff07GQEjc7CBSe0I1Y-hbmF
X-Proofpoint-GUID: l8KHWzL8Gff07GQEjc7CBSe0I1Y-hbmF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 impostorscore=0 mlxlogscore=999 spamscore=0 clxscore=1015 malwarescore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411010134
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=dantan@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

- removed the function prototypes declaration
- fixed code format to comply with convention
- changed function names and variable names to be the same
  as the tpm-tis-i2c test.
- change hard coded numbers to #define's with meaningful
  names that are identifiable with spec documentation

Signed-off-by: dan tan <dantan@linux.vnet.ibm.com>
---
 tests/qtest/tpm-tis-spi-pnv-test.c | 220 +++++++++++++++--------------
 tests/qtest/meson.build            |   1 +
 2 files changed, 116 insertions(+), 105 deletions(-)

diff --git a/tests/qtest/tpm-tis-spi-pnv-test.c b/tests/qtest/tpm-tis-spi-pnv-test.c
index a367564dda..2d6e1186cf 100644
--- a/tests/qtest/tpm-tis-spi-pnv-test.c
+++ b/tests/qtest/tpm-tis-spi-pnv-test.c
@@ -19,6 +19,9 @@
 #define SPI_TPM_BASE            0xc0080
 #define SPI_SHIFT_COUNTER_N1    0x30000000
 #define SPI_SHIFT_COUNTER_N2    0x40000000
+#define SPI_RWX_OPCODE_SHIFT    56
+#define SPI_RWX_ADDR_SHIFT      32
+#define SPI_CMD_DATA_SHIFT      56
 
 #define CFG_COUNT_COMPARE_1     0x0000000200000000
 #define MM_REG_RDR_MATCH        0x00000000ff01ff00
@@ -26,6 +29,7 @@
 
 #define TPM_TIS_8BITS_MASK      0xff
 #define SPI_TPM_TIS_ADDR        0xd40000
+#define SPI_EXTEND              0x03
 #define TPM_WRITE_OP            0x0
 #define TPM_READ_OP             0x80
 
@@ -50,53 +54,11 @@ static const uint8_t TPM_CMD[12] =
 #define DPRINTF_STS \
     DPRINTF("%s: %d: sts = 0x%08x\n", __func__, __LINE__, sts)
 
-static uint64_t pnv_spi_tpm_read(const PnvChip *chip, uint32_t reg);
-static void pnv_spi_tpm_write(const PnvChip *chip, uint32_t reg, uint64_t val);
-static uint64_t spi_read_reg(const PnvChip *chip);
-static void spi_write_reg(const PnvChip *chip, uint64_t val);
-static void spi_access_start(const PnvChip *chip, bool n2, uint8_t bytes,
-                             uint8_t tpm_op, uint32_t tpm_reg);
-
-static inline void tpm_reg_writeb(const PnvChip *c,
-                                  int locl,
-                                  uint8_t reg,
-                                  uint8_t val)
-{
-    uint32_t tpm_reg_locl = SPI_TPM_TIS_ADDR | (locl << TPM_TIS_LOCALITY_SHIFT);
-
-    spi_access_start(c, false, 1, TPM_WRITE_OP, tpm_reg_locl | reg);
-    spi_write_reg(c, bswap64(val));
-}
-
-static inline uint8_t tpm_reg_readb(const PnvChip *c, int locl, uint8_t reg)
-{
-    uint32_t tpm_reg_locl = SPI_TPM_TIS_ADDR | (locl << TPM_TIS_LOCALITY_SHIFT);
-
-    spi_access_start(c, true, 1, TPM_READ_OP, tpm_reg_locl | reg);
-    return spi_read_reg(c);
-}
-
-static inline void tpm_reg_writew(const PnvChip *c,
-                                  int locl,
-                                  uint8_t reg,
-                                  uint32_t val)
-{
-    int i;
-
-    for (i = 0; i < 4; i++) {
-        tpm_reg_writeb(c, locl, reg + i, ((val >> (8 * i)) & 0xff));
-    }
-}
-
-static inline uint32_t tpm_reg_readw(const PnvChip *c, int locl, uint8_t reg)
+static uint64_t pnv_spi_tpm_read(const PnvChip *chip, uint32_t reg)
 {
-    uint32_t val = 0;
-    int i;
+    uint32_t pcba = SPI_TPM_BASE + reg;
 
-    for (i = 0; i < 4; i++) {
-        val |= tpm_reg_readb(c, locl, reg + i) << (8 * i);
-    }
-    return val;
+    return qtest_readq(global_qtest, pnv_xscom_addr(chip, pcba));
 }
 
 static void pnv_spi_tpm_write(const PnvChip *chip,
@@ -104,40 +66,8 @@ static void pnv_spi_tpm_write(const PnvChip *chip,
                               uint64_t val)
 {
     uint32_t pcba = SPI_TPM_BASE + reg;
-    qtest_writeq(global_qtest, pnv_xscom_addr(chip, pcba), val);
-}
 
-static uint64_t pnv_spi_tpm_read(const PnvChip *chip, uint32_t reg)
-{
-    uint32_t pcba = SPI_TPM_BASE + reg;
-    return qtest_readq(global_qtest, pnv_xscom_addr(chip, pcba));
-}
-
-static void spi_access_start(const PnvChip *chip,
-                             bool n2,
-                             uint8_t bytes,
-                             uint8_t tpm_op,
-                             uint32_t tpm_reg)
-{
-    uint64_t cfg_reg;
-    uint64_t reg_op;
-    uint64_t seq_op = SEQ_OP_REG_BASIC;
-
-    cfg_reg = pnv_spi_tpm_read(chip, SPI_CLK_CFG_REG);
-    if (cfg_reg != CFG_COUNT_COMPARE_1) {
-        pnv_spi_tpm_write(chip, SPI_CLK_CFG_REG, CFG_COUNT_COMPARE_1);
-    }
-    /* bytes - sequencer operation register bits 24:31 */
-    if (n2) {
-        seq_op |= SPI_SHIFT_COUNTER_N2 | (bytes << 0x18);
-    } else {
-        seq_op |= SPI_SHIFT_COUNTER_N1 | (bytes << 0x18);
-    }
-    pnv_spi_tpm_write(chip, SPI_SEQ_OP_REG, seq_op);
-    pnv_spi_tpm_write(chip, SPI_MM_REG, MM_REG_RDR_MATCH);
-    pnv_spi_tpm_write(chip, SPI_CTR_CFG_REG, (uint64_t)0);
-    reg_op = bswap64(tpm_op) | ((uint64_t)tpm_reg << 0x20);
-    pnv_spi_tpm_write(chip, SPI_XMIT_DATA_REG, reg_op);
+    qtest_writeq(global_qtest, pnv_xscom_addr(chip, pcba), val);
 }
 
 static void spi_op_complete(const PnvChip *chip)
@@ -206,6 +136,89 @@ static uint64_t spi_read_reg(const PnvChip *chip)
     return val;
 }
 
+static void spi_access_start(const PnvChip *chip,
+                             bool n2,
+                             uint8_t bytes,
+                             uint8_t tpm_op,
+                             uint32_t tpm_reg)
+{
+    uint64_t cfg_reg;
+    uint64_t reg_op;
+    uint64_t seq_op = SEQ_OP_REG_BASIC;
+
+    cfg_reg = pnv_spi_tpm_read(chip, SPI_CLK_CFG_REG);
+    if (cfg_reg != CFG_COUNT_COMPARE_1) {
+        pnv_spi_tpm_write(chip, SPI_CLK_CFG_REG, CFG_COUNT_COMPARE_1);
+    }
+    /* bytes - sequencer operation register bits 24:31 */
+    if (n2) {
+        seq_op |= SPI_SHIFT_COUNTER_N2 | (bytes << 0x18);
+    } else {
+        seq_op |= SPI_SHIFT_COUNTER_N1 | (bytes << 0x18);
+    }
+    pnv_spi_tpm_write(chip, SPI_SEQ_OP_REG, seq_op);
+    pnv_spi_tpm_write(chip, SPI_MM_REG, MM_REG_RDR_MATCH);
+    pnv_spi_tpm_write(chip, SPI_CTR_CFG_REG, (uint64_t)0);
+    reg_op = ((uint64_t)tpm_op << SPI_RWX_OPCODE_SHIFT) |
+             ((uint64_t)tpm_reg << SPI_RWX_ADDR_SHIFT);
+    pnv_spi_tpm_write(chip, SPI_XMIT_DATA_REG, reg_op);
+}
+
+static inline void tpm_reg_writeb(const PnvChip *c,
+                                  uint8_t locty,
+                                  uint8_t reg,
+                                  uint8_t val)
+{
+    uint32_t tpm_reg_locty = SPI_TPM_TIS_ADDR |
+                             (locty << TPM_TIS_LOCALITY_SHIFT);
+
+    spi_access_start(c, false, 1, TPM_WRITE_OP, tpm_reg_locty | reg);
+    spi_write_reg(c, (uint64_t) val << SPI_CMD_DATA_SHIFT);
+}
+
+static inline uint8_t tpm_reg_readb(const PnvChip *c,
+                                    uint8_t locty,
+                                    uint8_t reg)
+{
+    uint32_t tpm_reg_locty = SPI_TPM_TIS_ADDR |
+                             (locty << TPM_TIS_LOCALITY_SHIFT);
+
+    spi_access_start(c, true, 1, TPM_READ_OP, tpm_reg_locty | reg);
+    return spi_read_reg(c);
+}
+
+static inline void tpm_reg_writel(const PnvChip *c,
+                                  uint8_t locty,
+                                  uint16_t reg,
+                                  uint32_t val)
+{
+    int i;
+
+    for (i = 0; i < 4; i++) {
+        tpm_reg_writeb(c, locty, reg + i, ((val >> (8 * i)) & 0xff));
+    }
+}
+
+static inline uint32_t tpm_reg_readl(const PnvChip *c,
+                                     uint8_t locty,
+                                     uint16_t reg)
+{
+    uint32_t val = 0;
+    int i;
+
+    /* special case for SPI xmit data reg set RWX bits */
+    if (reg == TPM_TIS_REG_DID_VID) {
+        spi_access_start(c, true, 4, TPM_READ_OP | SPI_EXTEND,
+                         locty | TPM_TIS_REG_DID_VID);
+        val = bswap32(spi_read_reg(c));
+    } else {
+        for (i = 0; i < 4; i++) {
+            val |= tpm_reg_readb(c, locty, reg + i) << (8 * i);
+        }
+    }
+    return val;
+}
+
 static void tpm_set_verify_loc(const PnvChip *chip, uint8_t loc)
 {
     uint8_t access;
@@ -226,7 +239,7 @@ static void tpm_set_verify_loc(const PnvChip *chip, uint8_t loc)
     g_test_message("\tACCESS REG = 0x%x checked", access);
 
     /* test tpm status register */
-    tpm_sts = tpm_reg_readw(chip, loc, TPM_TIS_REG_STS);
+    tpm_sts = tpm_reg_readl(chip, loc, TPM_TIS_REG_STS);
     g_assert_cmpuint((tpm_sts & TPM_TIS_8BITS_MASK), ==, 0);
     g_test_message("\tTPM STATUS: 0x%x, verified", tpm_sts);
 
@@ -239,6 +252,17 @@ static void tpm_set_verify_loc(const PnvChip *chip, uint8_t loc)
     g_test_message("\tRELEASED ACCESS: 0x%x, checked", access);
 }
 
+static void test_spi_tpm_locality(const void *data)
+{
+    const PnvChip *chip = data;
+    uint8_t locality;
+
+    /* Locality 4 has special security restrictions, testing 0-3 */
+    for (locality = 0; locality < TPM_TIS_NUM_LOCALITIES - 1; locality++) {
+        tpm_set_verify_loc(chip, locality);
+    }
+}
+
 static void test_spi_tpm_basic(const void *data)
 {
     const PnvChip *chip = data;
@@ -247,11 +271,8 @@ static void test_spi_tpm_basic(const void *data)
 
     g_test_message("TPM TIS SPI interface basic tests:");
     /* vendor ID and device ID ... check against the known value*/
-    spi_access_start(chip, true, 4, 0x83,
-                     SPI_TPM_TIS_ADDR | TPM_TIS_REG_DID_VID);
-    didvid = spi_read_reg(chip);
-    g_assert_cmpint((didvid >> 16), ==, bswap16(TPM_TIS_TPM_VID));
-    g_assert_cmpint((didvid & 0xffff), ==, bswap16(TPM_TIS_TPM_DID));
+    didvid = tpm_reg_readl(chip, 0, TPM_TIS_REG_DID_VID);
+    g_assert_cmpint(didvid, ==, (1 << 16) | PCI_VENDOR_ID_IBM);
     g_test_message("\tDID_VID = 0x%x, verified", didvid);
 
     /* access register, default see TCG TIS Spec (v1.3) table-14 */
@@ -261,28 +282,17 @@ static void test_spi_tpm_basic(const void *data)
     g_test_message("\tACCESS REG = 0x%x, checked", access);
 
     /* interrupt enable register, default see TCG TIS Spec (v1.3) table-19 */
-    en_int = tpm_reg_readw(chip, 0, TPM_TIS_REG_INT_ENABLE);
+    en_int = tpm_reg_readl(chip, 0, TPM_TIS_REG_INT_ENABLE);
     g_assert_cmpuint(en_int, ==, TPM_TIS_INT_POLARITY_LOW_LEVEL);
     g_test_message("\tINT ENABLE REG: 0x%x, verified", en_int);
 
     /* status register, default see TCG TIS Spec (v1.3) table-15 */
-    tpm_sts = tpm_reg_readw(chip, 0, TPM_TIS_REG_STS);
+    tpm_sts = tpm_reg_readl(chip, 0, TPM_TIS_REG_STS);
     /* for no active locality */
     g_assert_cmpuint(tpm_sts, ==, 0xffffffff);
     g_test_message("\tTPM STATUS: 0x%x, verified", tpm_sts);
 }
 
-static void test_spi_tpm_locality(const void *data)
-{
-    const PnvChip *chip = data;
-    uint8_t locality;
-
-    /* Locality 4 has special security restrictions, testing 0-3 */
-    for (locality = 0; locality < TPM_TIS_NUM_LOCALITIES - 1; locality++) {
-        tpm_set_verify_loc(chip, locality);
-    }
-}
-
 /*
  * Test case for seizing access by a higher number locality
  */
@@ -582,7 +592,7 @@ static void test_spi_tpm_transmit_test(const void *data)
                                 TPM_TIS_ACCESS_ACTIVE_LOCALITY |
                                 TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
 
-    sts = tpm_reg_readw(chip, 0, TPM_TIS_REG_STS);
+    sts = tpm_reg_readl(chip, 0, TPM_TIS_REG_STS);
     DPRINTF_STS;
 
     g_assert_cmpint(sts & 0xff, ==, 0);
@@ -591,15 +601,15 @@ static void test_spi_tpm_transmit_test(const void *data)
     g_test_message("\t\tbcount: %x, sts: %x", bcount, sts);
     g_assert_cmpint(bcount, >=, 128);
 
-    tpm_reg_writew(chip, 0, TPM_TIS_REG_STS, TPM_TIS_STS_COMMAND_READY);
-    sts = tpm_reg_readw(chip, 0, TPM_TIS_REG_STS);
+    tpm_reg_writel(chip, 0, TPM_TIS_REG_STS, TPM_TIS_STS_COMMAND_READY);
+    sts = tpm_reg_readl(chip, 0, TPM_TIS_REG_STS);
     DPRINTF_STS;
     g_assert_cmpint(sts & 0xff, ==, TPM_TIS_STS_COMMAND_READY);
 
     /* transmit command */
     for (i = 0; i < sizeof(TPM_CMD); i++) {
         tpm_reg_writeb(chip, 0, TPM_TIS_REG_DATA_FIFO, TPM_CMD[i]);
-        sts = tpm_reg_readw(chip, 0, TPM_TIS_REG_STS);
+        sts = tpm_reg_readl(chip, 0, TPM_TIS_REG_STS);
         DPRINTF_STS;
         if (i < sizeof(TPM_CMD) - 1) {
             g_assert_cmpint(sts & 0xff, ==, TPM_TIS_STS_EXPECT |
@@ -611,17 +621,17 @@ static void test_spi_tpm_transmit_test(const void *data)
     g_test_message("\ttransmit tests, check TPM_TIS_STS_EXPECT");
 
     /* start processing */
-    tpm_reg_writew(chip, 0, TPM_TIS_REG_STS, TPM_TIS_STS_TPM_GO);
+    tpm_reg_writel(chip, 0, TPM_TIS_REG_STS, TPM_TIS_STS_TPM_GO);
 
     uint64_t end_time = g_get_monotonic_time() + 50 * G_TIME_SPAN_SECOND;
     do {
-        sts = tpm_reg_readw(chip, 0, TPM_TIS_REG_STS);
+        sts = tpm_reg_readl(chip, 0, TPM_TIS_REG_STS);
         if ((sts & TPM_TIS_STS_DATA_AVAILABLE) != 0) {
             break;
         }
     } while (g_get_monotonic_time() < end_time);
 
-    sts = tpm_reg_readw(chip, 0, TPM_TIS_REG_STS);
+    sts = tpm_reg_readl(chip, 0, TPM_TIS_REG_STS);
     DPRINTF_STS;
     g_assert_cmpint(sts & 0xff, == , TPM_TIS_STS_VALID |
                                      TPM_TIS_STS_DATA_AVAILABLE);
@@ -635,7 +645,7 @@ static void test_spi_tpm_transmit_test(const void *data)
 
     for (i = 0; i < sizeof(tpm_msg); i++) {
         tpm_msg[i] = tpm_reg_readb(chip, 0, TPM_TIS_REG_DATA_FIFO);
-        sts = tpm_reg_readw(chip, 0, TPM_TIS_REG_STS);
+        sts = tpm_reg_readl(chip, 0, TPM_TIS_REG_STS);
         DPRINTF_STS;
         if (sts & TPM_TIS_STS_DATA_AVAILABLE) {
             g_assert_cmpint((sts >> 8) & 0xffff, ==, --bcount);
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 6b1aed929e..74aa9f57e0 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -4,6 +4,7 @@ slow_qtests = {
   'bios-tables-test' : 910,
   'cdrom-test' : 610,
   'device-introspect-test' : 720,
+  'ide-test' : 120,
   'migration-test' : 480,
   'npcm7xx_pwm-test': 300,
   'npcm7xx_watchdog_timer-test': 120,
-- 
2.39.5


