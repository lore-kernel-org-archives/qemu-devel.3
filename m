Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BBD21090222
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 12:58:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Cvs-0005Wk-GW; Thu, 19 Mar 2026 08:57:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ycliang@andestech.com>)
 id 1w38tL-0003IZ-Pi
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 04:38:09 -0400
Received: from exmail.andestech.com ([60.248.187.195]
 helo=Atcsqr.andestech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ycliang@andestech.com>)
 id 1w38tJ-0001X3-GV
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 04:38:07 -0400
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTP id 62J8bJtp017663;
 Thu, 19 Mar 2026 16:37:19 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Mar
 2026 16:37:18 +0800
To: <u-boot@lists.denx.de>
CC: <pbonzini@redhat.com>, <trini@konsulko.com>, <rick@andestech.com>,
 <ycliang@andestech.com>, <jerome.forissier@arm.com>,
 <xypron.glpk@gmx.de>, <ilias.apalodimas@linaro.org>,
 <kory.maincent@bootlin.com>,
 <eric.schikschneit@novatechautomation.com>, <sputnik@on-the-web.ch>,
 <michal.simek@amd.com>, <cnoize@andestech.com>, <qemu-devel@nongnu.org>
Subject: [PATCH 6/6] configs: ae350: Enable noncached memory support
Date: Thu, 19 Mar 2026 16:37:13 +0800
Message-ID: <20260319083713.3456894-4-ycliang@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260319083713.3456894-1-ycliang@andestech.com>
References: <20260319083713.3456894-1-ycliang@andestech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 62J8bJtp017663
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

Enable CONFIG_SYS_HAS_NONCACHED_MEMORY and set
CONFIG_SYS_NONCACHED_MEMORY to 1MB (0x100000) on all AE350
S-mode defconfigs where SBI is available:

  ae350_rv{32,64}_spl_defconfig
  ae350_rv{32,64}_spl_xip_defconfig
  ae350_rv{32,64}_falcon_defconfig
  ae350_rv{32,64}_falcon_xip_defconfig

Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
 configs/ae350_rv32_falcon_defconfig     | 2 ++
 configs/ae350_rv32_falcon_xip_defconfig | 2 ++
 configs/ae350_rv32_spl_defconfig        | 2 ++
 configs/ae350_rv32_spl_xip_defconfig    | 2 ++
 configs/ae350_rv64_falcon_defconfig     | 2 ++
 configs/ae350_rv64_falcon_xip_defconfig | 2 ++
 configs/ae350_rv64_spl_defconfig        | 2 ++
 configs/ae350_rv64_spl_xip_defconfig    | 2 ++
 8 files changed, 16 insertions(+)

diff --git a/configs/ae350_rv32_falcon_defconfig b/configs/ae350_rv32_falcon_defconfig
index 659be8287ba..08d27d7c823 100644
--- a/configs/ae350_rv32_falcon_defconfig
+++ b/configs/ae350_rv32_falcon_defconfig
@@ -53,6 +53,8 @@ CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
 CONFIG_SYS_FLASH_CFI=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_FTMAC100=y
+CONFIG_SYS_HAS_NONCACHED_MEMORY=y
+CONFIG_SYS_NONCACHED_MEMORY=0x100000
 CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_ATCSPI200_SPI=y
diff --git a/configs/ae350_rv32_falcon_xip_defconfig b/configs/ae350_rv32_falcon_xip_defconfig
index 93b80ef789d..42f0d5f4e60 100644
--- a/configs/ae350_rv32_falcon_xip_defconfig
+++ b/configs/ae350_rv32_falcon_xip_defconfig
@@ -55,6 +55,8 @@ CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
 CONFIG_SYS_FLASH_CFI=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_FTMAC100=y
+CONFIG_SYS_HAS_NONCACHED_MEMORY=y
+CONFIG_SYS_NONCACHED_MEMORY=0x100000
 CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_ATCSPI200_SPI=y
diff --git a/configs/ae350_rv32_spl_defconfig b/configs/ae350_rv32_spl_defconfig
index 4b0f52ff42b..146e3650708 100644
--- a/configs/ae350_rv32_spl_defconfig
+++ b/configs/ae350_rv32_spl_defconfig
@@ -53,6 +53,8 @@ CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
 CONFIG_SYS_FLASH_CFI=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_FTMAC100=y
+CONFIG_SYS_HAS_NONCACHED_MEMORY=y
+CONFIG_SYS_NONCACHED_MEMORY=0x100000
 CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_ATCSPI200_SPI=y
diff --git a/configs/ae350_rv32_spl_xip_defconfig b/configs/ae350_rv32_spl_xip_defconfig
index f076f36c73c..c994331e75f 100644
--- a/configs/ae350_rv32_spl_xip_defconfig
+++ b/configs/ae350_rv32_spl_xip_defconfig
@@ -54,6 +54,8 @@ CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
 CONFIG_SYS_FLASH_CFI=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_FTMAC100=y
+CONFIG_SYS_HAS_NONCACHED_MEMORY=y
+CONFIG_SYS_NONCACHED_MEMORY=0x100000
 CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_ATCSPI200_SPI=y
diff --git a/configs/ae350_rv64_falcon_defconfig b/configs/ae350_rv64_falcon_defconfig
index c7c44671419..5dd58047aeb 100644
--- a/configs/ae350_rv64_falcon_defconfig
+++ b/configs/ae350_rv64_falcon_defconfig
@@ -53,6 +53,8 @@ CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
 CONFIG_SYS_FLASH_CFI=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_FTMAC100=y
+CONFIG_SYS_HAS_NONCACHED_MEMORY=y
+CONFIG_SYS_NONCACHED_MEMORY=0x100000
 CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_ATCSPI200_SPI=y
diff --git a/configs/ae350_rv64_falcon_xip_defconfig b/configs/ae350_rv64_falcon_xip_defconfig
index ae9c7cfd933..78e1ea118ac 100644
--- a/configs/ae350_rv64_falcon_xip_defconfig
+++ b/configs/ae350_rv64_falcon_xip_defconfig
@@ -55,6 +55,8 @@ CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
 CONFIG_SYS_FLASH_CFI=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_FTMAC100=y
+CONFIG_SYS_HAS_NONCACHED_MEMORY=y
+CONFIG_SYS_NONCACHED_MEMORY=0x100000
 CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_ATCSPI200_SPI=y
diff --git a/configs/ae350_rv64_spl_defconfig b/configs/ae350_rv64_spl_defconfig
index af000ca58ce..22c710661e0 100644
--- a/configs/ae350_rv64_spl_defconfig
+++ b/configs/ae350_rv64_spl_defconfig
@@ -53,6 +53,8 @@ CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
 CONFIG_SYS_FLASH_CFI=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_FTMAC100=y
+CONFIG_SYS_HAS_NONCACHED_MEMORY=y
+CONFIG_SYS_NONCACHED_MEMORY=0x100000
 CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_ATCSPI200_SPI=y
diff --git a/configs/ae350_rv64_spl_xip_defconfig b/configs/ae350_rv64_spl_xip_defconfig
index 8c6e2773723..d2b29c19397 100644
--- a/configs/ae350_rv64_spl_xip_defconfig
+++ b/configs/ae350_rv64_spl_xip_defconfig
@@ -54,6 +54,8 @@ CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
 CONFIG_SYS_FLASH_CFI=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_FTMAC100=y
+CONFIG_SYS_HAS_NONCACHED_MEMORY=y
+CONFIG_SYS_NONCACHED_MEMORY=0x100000
 CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_ATCSPI200_SPI=y
-- 
2.34.1


