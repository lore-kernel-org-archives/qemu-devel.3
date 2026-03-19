Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E39A61090222
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 12:59:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Cvu-0005X6-BV; Thu, 19 Mar 2026 08:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ycliang@andestech.com>)
 id 1w38m8-0006pj-Uk
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 04:30:40 -0400
Received: from exmail.andestech.com ([60.248.187.195]
 helo=Atcsqr.andestech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ycliang@andestech.com>)
 id 1w38m6-0000PR-Vd
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 04:30:40 -0400
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTP id 62J8TtpH014939;
 Thu, 19 Mar 2026 16:29:55 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Mar
 2026 16:29:55 +0800
To: <u-boot@lists.denx.de>
CC: <pbonzini@redhat.com>, <trini@konsulko.com>, <rick@andestech.com>,
 <ycliang@andestech.com>, <jerome.forissier@arm.com>,
 <xypron.glpk@gmx.de>, <ilias.apalodimas@linaro.org>,
 <kory.maincent@bootlin.com>,
 <eric.schikschneit@novatechautomation.com>, <sputnik@on-the-web.ch>,
 <michal.simek@amd.com>, <cnoize@andestech.com>, <qemu-devel@nongnu.org>
Subject: [PATCH 1/6] riscv: sbi: Add Andes vendor extension and PMA call
 wrappers
Date: Thu, 19 Mar 2026 16:29:46 +0800
Message-ID: <20260319082951.3310908-1-ycliang@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 62J8TtpH014939
Received-SPF: pass client-ip=60.248.187.195;
 envelope-from=ycliang@andestech.com; helo=Atcsqr.andestech.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 19 Mar 2026 08:56:52 -0400
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
Reply-to:  Leo Yu-Chi Liang <ycliang@andestech.com>
From:  Leo Yu-Chi Liang via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add support for the Andes SBI vendor extension (EXT_ID 0x0900031E)
with function IDs for PMA (Physical Memory Attribute) operations:
probe, set, and free.

These SBI calls allow S-mode software to configure memory attributes
through OpenSBI, which is needed for setting up noncached memory
regions on Andes RISC-V platforms.

Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
 arch/riscv/include/asm/sbi.h | 22 ++++++++++++++++
 arch/riscv/lib/sbi.c         | 51 ++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 47124dbaac8..8642954d272 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -37,6 +37,7 @@ enum sbi_ext_id {
 	SBI_EXT_FWFT = 0x46574654,
 	SBI_EXT_DBTR = 0x44425452,
 	SBI_EXT_MPXY = 0x4D505859,
+	SBI_EXT_ANDES = 0x0900031E,
 };
 
 enum sbi_ext_base_fid {
@@ -98,6 +99,23 @@ enum sbi_srst_reset_reason {
 	SBI_SRST_RESET_REASON_SYS_FAILURE,
 };
 
+enum sbi_ext_andes_fid {
+	SBI_EXT_ANDES_FID0 = 0,
+	SBI_EXT_ANDES_IOCP_SW_WORKAROUND,
+	SBI_EXT_ANDES_PMA_PROBE,
+	SBI_EXT_ANDES_PMA_SET,
+	SBI_EXT_ANDES_PMA_FREE,
+};
+
+/* Andes PMA configuration flags */
+#define ANDES_PMACFG_ETYP_OFFSET	0
+#define ANDES_PMACFG_ETYP_NAPOT	(3 << ANDES_PMACFG_ETYP_OFFSET)
+#define ANDES_PMACFG_ETYP_OFF		(0 << ANDES_PMACFG_ETYP_OFFSET)
+#define ANDES_PMACFG_ETYP_MASK		(3 << ANDES_PMACFG_ETYP_OFFSET)
+#define ANDES_PMACFG_MTYP_OFFSET		2
+#define ANDES_PMACFG_MTYP_MEM_NON_CACHE_BUF	(3 << ANDES_PMACFG_MTYP_OFFSET)
+#define ANDES_PMACFG_MTYP_DEV_NOBUF		(0 << ANDES_PMACFG_MTYP_OFFSET)
+
 enum sbi_ext_dbcn_fid {
 	SBI_EXT_DBCN_CONSOLE_WRITE = 0,
 	SBI_EXT_DBCN_CONSOLE_READ,
@@ -176,4 +194,8 @@ int sbi_get_mimpid(long *mimpid);
 void sbi_srst_reset(unsigned long type, unsigned long reason);
 int sbi_dbcn_write_byte(unsigned char ch);
 
+int sbi_pma_probe(void);
+int sbi_pma_set(unsigned long pa, unsigned long size, unsigned long flags);
+int sbi_pma_free(unsigned long pa);
+
 #endif
diff --git a/arch/riscv/lib/sbi.c b/arch/riscv/lib/sbi.c
index 35a7d3b12f5..f8a2da5c271 100644
--- a/arch/riscv/lib/sbi.c
+++ b/arch/riscv/lib/sbi.c
@@ -220,6 +220,57 @@ int sbi_dbcn_write_byte(unsigned char ch)
 	return ret.error;
 }
 
+/**
+ * sbi_pma_probe() - Probe for Andes PMA support
+ *
+ * Return: Number of PMA entries on success, SBI error on failure
+ */
+int sbi_pma_probe(void)
+{
+	struct sbiret ret;
+
+	ret = sbi_ecall(SBI_EXT_ANDES, SBI_EXT_ANDES_PMA_PROBE,
+			0, 0, 0, 0, 0, 0);
+	if (ret.error)
+		return ret.error;
+
+	return ret.value;
+}
+
+/**
+ * sbi_pma_set() - Set a PMA region
+ * @pa:		Physical address of the region
+ * @size:	Size of the region
+ * @flags:	PMA configuration flags
+ *
+ * Return: 0 on success, SBI error on failure
+ */
+int sbi_pma_set(unsigned long pa, unsigned long size, unsigned long flags)
+{
+	struct sbiret ret;
+
+	ret = sbi_ecall(SBI_EXT_ANDES, SBI_EXT_ANDES_PMA_SET,
+			pa, size, flags, 0, 0, 0);
+
+	return ret.error;
+}
+
+/**
+ * sbi_pma_free() - Free a PMA region
+ * @pa:		Physical address of the region to free
+ *
+ * Return: 0 on success, SBI error on failure
+ */
+int sbi_pma_free(unsigned long pa)
+{
+	struct sbiret ret;
+
+	ret = sbi_ecall(SBI_EXT_ANDES, SBI_EXT_ANDES_PMA_FREE,
+			pa, 0, 0, 0, 0, 0);
+
+	return ret.error;
+}
+
 #ifdef CONFIG_SBI_V01
 
 /**
-- 
2.34.1


