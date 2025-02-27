Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE722C19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 15:24:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnfjh-0001IB-Vo; Thu, 27 Feb 2025 10:23:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saveliy.motov@syntacore.com>)
 id 1tnf6L-0001sL-LP; Thu, 27 Feb 2025 09:43:01 -0500
Received: from m.syntacore.com ([178.249.69.228])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saveliy.motov@syntacore.com>)
 id 1tnf6J-0008Te-N2; Thu, 27 Feb 2025 09:43:01 -0500
Received: from pmg.syntacore.com (localhost.localdomain [127.0.0.1])
 by m.syntacore.com (Proxmox) with ESMTP id C5344B41D10;
 Thu, 27 Feb 2025 17:42:50 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:from:from:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=m; bh=d+XAQK1xiGQq17VjpVEtbaO
 swnov1e3zbeiyzXg+Eqc=; b=qUWEDldQqlXEcBPClh+U+fk/c6OyZUSGR8kz3ae
 Gv/XTasqSLC5/QCrnXKHIu62zXn8Q5oEwwYzW3KRYPowMgERIWcg4qPi92mEkPgF
 vUX27Bw/elrNjA/P2sUkmlHF96pBYZ7/4Pz4FTu8btxWjd0bq202WIQnUo/tT8v8
 9i+Bh2HIUULbyUZRCjq+arnAZ+svJWgJUBruAXcsAUO+CLjltrVAOnIvW2fNTiM5
 Fyf8BtCfE1YLRxsS9QqaUDhQWOTUpHxdV/MBlKPO1d+8sxtA9BuOPICjhR4PZFa9
 NajBv6JjwnkPGwd8Zor11sboXzhKmfhHIncgVVwkzKSfnmw==
Received: from S-SC-EXCH-01.corp.syntacore.com (mail.syntacore.com
 [10.76.202.20])
 by m.syntacore.com (Proxmox) with ESMTPS id B1BEBB41D05;
 Thu, 27 Feb 2025 17:42:50 +0300 (MSK)
Received: from le14u.yadro.com (172.17.5.46) by
 S-SC-EXCH-01.corp.syntacore.com (10.76.202.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 27 Feb 2025 17:41:40 +0300
From: Saveliy Motov <saveliy.motov@syntacore.com>
To: <palmer@dabbelt.com>
CC: <alistair.francis@wdc.com>, <bmeng.cn@gmail.com>, <liwei1518@gmail.com>,
 <dbarboza@ventanamicro.com>, <zhiwei_liu@linux.alibaba.com>,
 <qemu-riscv@nongnu.org>, <qemu-devel@nongnu.org>, Saveliy Motov
 <saveliy.motov@syntacore.com>
Subject: [PATCH 2/2] target/riscv/cpu_bits.h: Fix [63:32] bits in Zkr seed CSR
Date: Thu, 27 Feb 2025 17:42:00 +0300
Message-ID: <20250227144200.69270-3-saveliy.motov@syntacore.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250227144200.69270-1-saveliy.motov@syntacore.com>
References: <20250227144200.69270-1-saveliy.motov@syntacore.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.5.46]
X-ClientProxiedBy: S-SC-EXCH-01.corp.syntacore.com (10.76.202.20) To
 S-SC-EXCH-01.corp.syntacore.com (10.76.202.20)
Received-SPF: pass client-ip=178.249.69.228;
 envelope-from=saveliy.motov@syntacore.com; helo=m.syntacore.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 27 Feb 2025 10:23:37 -0500
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

According to:
RISC-V Cryptography Extensions Volume I. Version 1.0.1, 4.1. The seed CSR

On 64 bit machine 32 bit register must be extended with zeroes in higher bits
Previously status mask was formed by integer left bitshift with sign changing,
so higher 32 bits was 1.
Change type from int to ULL fix ZKR seed.

Signed-off-by: Saveliy Motov <saveliy.motov@syntacore.com>
---
 target/riscv/cpu_bits.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index f97c48a394..140b45bda7 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -878,11 +878,11 @@ typedef enum RISCVException {
     (HVICTL_VTI | HVICTL_IID | HVICTL_IPRIOM | HVICTL_IPRIO)
 
 /* seed CSR bits */
-#define SEED_OPST                        (0b11 << 30)
-#define SEED_OPST_BIST                   (0b00 << 30)
-#define SEED_OPST_WAIT                   (0b01 << 30)
-#define SEED_OPST_ES16                   (0b10 << 30)
-#define SEED_OPST_DEAD                   (0b11 << 30)
+#define SEED_OPST                          (0b11UL << 30)
+#define SEED_OPST_BIST                     (0b00UL << 30)
+#define SEED_OPST_WAIT                     (0b01UL << 30)
+#define SEED_OPST_ES16                     (0b10UL << 30)
+#define SEED_OPST_DEAD                     (0b11UL << 30)
 /* PMU related bits */
 #define MIE_LCOFIE                         (1 << IRQ_PMU_OVF)
 
-- 
2.34.1



