Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7835C624D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 11:27:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x25aJ-0005Zw-Ph; Thu, 03 Sep 2026 07:26:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x25aH-0005Z8-If; Thu, 03 Sep 2026 07:26:21 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x25aF-0006f9-32; Thu, 03 Sep 2026 07:26:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H5wtvw2Zm3EhphL6fUinup89f+lWruBcmLLm891i6ieWNxY2zp+usRr5GXcoq89ds7xw1un7iwti0o7dJwl5wwAriUnRDLkrhFesta4qKErHrdqiYKXov8VIJxz5zNBxAZliEMpnkC/bQ4ZKOwBc4fiT44UyVwz+w7lC3UczNsmVgBCTzvwAMka1U4t1wTpzwD4GoE0LMU0c2rmiPIdMYDENKsy1Qeqg+p3gs40y9jCA92Mv+aMfhrPUSVDeF1suiK0iU+3xXE2li8sHqV0moYqYAwfKUo3tPCDw+TcLNX1LldKRhVkKsAoz16s+loIGKbrIdMyQ9xi08QQm8iIC8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RIXfz26wMs8qpMe+eyckF0vSRoNrJQKNNhNJMc0rPhE=;
 b=ssearvOJXfEYg8JZ4IBBfk28IQBNNxoFA60L8yyxd8L+dNGtMjCW6JIabodLafd99e+daMINqCKPEMMdAcQoEnv65t4IxO0dUt/kzAUr6qjA/YM3VIiJt25bW0b2E1v3cHbaZMhoPCiZT17sxoK5H9NNwq89sqqwMcIxOnLkQRo5dDSshulrizrs9lbZ7dpi3hWbpPAT2SfOcKVsTiL6EpGvYoP3IA6aiVVmNRZ+qehpD+0v1a5FlrBttHhei4H2PIfLcDcYfXbpp97vOzfn1Xr0iMfCHUXf2e8oeUXW/LiTM3PFvh6HH3rm606w5bUcnwGNdSq330v5bQUSuppmRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RIXfz26wMs8qpMe+eyckF0vSRoNrJQKNNhNJMc0rPhE=;
 b=VfZpve/xXCee5Z9pR5tAD+7GSaPx+QsHNk0eRkbGpQIbcDp7gQ/PHZr5PyRyTFQgMNm4GTBjMwv6dU1nepn+I6XkWnmsqWGqYfM/MmHleh3ltaJPD/py1QQ4fyQP0I00T+8EOP4Oow25b0A8xq1wubw2onV4Xaic4DVAPdqYL2/2S++U+obnrxulOAwEsEHBrnfUkSBmrY1SDCgEqaVkXVTeQbJlM/zom9+Asw0a31GgPD1sykh/MB+pPIWcR1nzb4H/gP9P2R6yd1muewKMzV6xWWqvmrRDGUrZHtVEROTljPsmbN0uad4bkBzgAl9Ylx71MtlxFmAkt2l6LE6npw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by TYZPR02MB6358.apcprd02.prod.outlook.com (2603:1096:400:419::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 11:26:06 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 11:26:06 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 qemu-block@nongnu.org
Subject: [PATCH 07/33] tests/qtest: Add Synopsys DesignWare MCI coverage
Date: Thu,  3 Sep 2026 19:24:47 +0800
Message-ID: <20260903112532.3276678-8-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903112532.3276678-1-bin.meng@processmission.com>
References: <20260903112532.3276678-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0026.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::11) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|TYZPR02MB6358:EE_
X-MS-Office365-Filtering-Correlation-Id: e69f1c2c-b608-4b58-fbb3-08df09ae24ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 3HqofjRaThmC9Q5JGtBXOhI8Ts+z/7xZO2xQjy0+10svOtHGR/u6YFauASP+o7NBBqc0WEIgxQcXD3ovqM7qRoe2KZdajPGSyWvyv1vgYFEzQNIplxn6g99asmMKYZVVTnq1bjIyrUDrxQGzkHCySNC1c8BoWCq8UQDpBTFaRUmGGFBLdQMKalPdkHeYI4q2mjNrVnZPuSNxCZi6r3FKAPsUfj3oka6LXU96AyRgLwOc5C2uiGgWVzszyr7N8B1iCTi71cvEML+dP1lO/qafMxURhdR/8yyHFiBPRpilFwS4NcZQeuhuE+gub+EW+EtKvXRV8LbbZSvJ9odNWZe0+uSgoGbTwVcAOCUncRBYQb0OUoP/vyQPdMj9LUtgM2zbVHPu1ihyKzYbGmQDt+4TZezRqP0dwa/aTuCGJb1tYupuJ5gLqGi6qBvAhcufG8mUPs/maTtw0OKYmXe/qOLnqjGzIl6xuAwvd/nJ+5d1ygjgevVtEv/vgZMc4T55jwB+6pdLcw5VNDJ1GI15v64d0+UMpdaP8z4NDwO9cIwHaHcFAm2k0cEIPq+sP87H+0WbUFhLWNEQ5dCnLqnNwDYL44PbAnZ79QvYYxVe9gWK3D4TZ90nERUvqxG4lpWb7qAcfqU3lKzuiwvOL8YzouePVCGn3r2T2mVXKA9BMJU27u8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r2shJpYOdHg9XAgm7vsqS8wnoSHi1kaGLiDNUWznb8PQc2HFk79kM90aMAEk?=
 =?us-ascii?Q?sPzkaOqjceN7e0rXjau828jDN89I/Oh8xSDJFoG73ommfll3oGM/A/Klp3m4?=
 =?us-ascii?Q?TiSrBs1wBRQ3Xb+3vEeppYonL5ei5tjmDftdzpiVDXe3BgfiZQcywCOW/ePl?=
 =?us-ascii?Q?fpnqApSWs25zQqKSZDXv6tKgOc+b66ypmlMwvn2R40c8sRbkh2L1cyp8bbHs?=
 =?us-ascii?Q?zu9TJRkAZC0etoWi4Gq6nJfS10feH+KCHzYub7vC3U4XmCYTR3hFockAwT6U?=
 =?us-ascii?Q?ELX8jjlmQL32uMoj1InNVjIiqnrwJj1CDNHpuqND7s26oTOh11dhLL9DUl+o?=
 =?us-ascii?Q?p9yMqIsE64yFxeWuY5qK7GPtneXfkSX2ZaVFqneJyfYeUuf7H34nfyBzh81H?=
 =?us-ascii?Q?rc7dKGsJ8uvuKsUStq5dUQ05unf9FMBV6sZPTCoiRUAtSs+SxPphP/6TFvSw?=
 =?us-ascii?Q?mx1fpZ4KKBdNzwtmko9xvP9wMiX4iE4w6L0i/4uKRKkD87Mc4IkJ/aQTa2S8?=
 =?us-ascii?Q?BngSMvYIIaF/db3zIdQlSaKtHpHq6S0QiEP98K5FrvDbAtlBfG3BpbKKoR1l?=
 =?us-ascii?Q?kYXNXGszyuyUbT+JWO/rPQlcWvKVMTNsdgKtfhtS3Krzuh8bwZNiSdtyXptW?=
 =?us-ascii?Q?Vqu07mrBiyilQg0kGvbI3Vx9o1hcqwu31++ayQdq3SdzFVra7VmjkAGVkw7x?=
 =?us-ascii?Q?rvRNa1jO3Sh/aku8ywGZfTCPdH8WWdgeZGlNdqsBGCt6zD0TLhmP/l7qwCA+?=
 =?us-ascii?Q?GQG4/wMy6Y3n73BaMGSL3kQw0VCPLQdc+i9a0IHQC0NYnX72dre74NLq7Lj9?=
 =?us-ascii?Q?/arKXHF64DcaytoY8XrV965N9H13DIjKJaBXqttdQKREnPB7J6Pxi8vsJhl1?=
 =?us-ascii?Q?QJohT+gcx2rYpLmuTYINbGtbwLHkIFcooPHrsMVfhKkuropVKO9Z1ZF2Xyw0?=
 =?us-ascii?Q?n4aB+ARlp7+C32jbdZRmC46oA6RNhZWO/xVT8eTzIby3FGr/hx4+98WMkOzF?=
 =?us-ascii?Q?M7hM1ywIeObylaROZ9xQXClaljXINea5CQt3btc0v1sIa9KKHFXf0Ti/us8x?=
 =?us-ascii?Q?g9Scnzm6NKNVHtDZLAmmDQHyVxqirBzLX4woApWaeehZ+wGxkJotOLwFPUKo?=
 =?us-ascii?Q?5dVwPbUvx4uBUk+9hmncxEp/FfonKUyRtDjyRIkq2TjW4UaLd6GUqpBu1YPo?=
 =?us-ascii?Q?035Fh8ZYAc+tX7MelFq/dZZZe+WKJ+TG+FkiFbDh+1MtYSxvRd/4axZEOz52?=
 =?us-ascii?Q?2+bXgqWuzu81nR6xCnx4FDhHYFtllql0UkPc/Opfk/IQ4TiLQWI/bVkDg+BP?=
 =?us-ascii?Q?DCTZzR3IW3TvlGN/KbsHU0hWYWqUNPzzkvpxFRC7EVH8JyW8gQGy5dn0z+e4?=
 =?us-ascii?Q?oTP+2WLAc74zdp06HQHKfht/3W14HqlZZyX/8gVMuryZGsDCNSZvGGEq6LXM?=
 =?us-ascii?Q?iLNFKzTkuhkBa59ykLB6Cmb2RBC/Iiw5HSp4BC3Rpy4WFe8hb/HTlf0ncR4j?=
 =?us-ascii?Q?cH93DtZ5yfuJP5/R8U9X2pQCztFaq70Bxt97+3lN2xOt62ZxOoEiBdDWG87Z?=
 =?us-ascii?Q?OWXb/AvuhVBbx/bxay9jvaG/YyjcODS2zVAilwGY+OHmXIbbuoOEQlqajIZY?=
 =?us-ascii?Q?Ij6TVWS42BUpFDpV6oTTeGxvIQ0xJeULdK0/efv5erRHHHGdwifkdx7Gswze?=
 =?us-ascii?Q?WO5KPxHLq1N99tS21abaU57g3OsBEJ/HQx69tE6fVlfwR5jvK7bNFjyNrlS8?=
 =?us-ascii?Q?I4heH2NXyGP88PnmOAQ9RcJ0Ncj+vcI=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e69f1c2c-b608-4b58-fbb3-08df09ae24ed
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 11:26:06.0224 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RVAMGS59wC9yTF3Z887iMz7sVpGgkaM7HQE8yBW7QrFhOuV0XYq2pqfbsTyl5OfaCaHK9wEHjBJ0SWMf3HNSYsbLqJDsEUP6GnA1wHj2C/s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB6358
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=bin.meng@processmission.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Exercise the reusable DesignWare MCI behavior through the Phytium Pi
board integration. Cover register reset and interrupt handling, 64-bit
IDMAC write/read and suspend/resume paths, and FIFO PIO transfers
against an SD image.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 MAINTAINERS               |   1 +
 tests/qtest/dw_mci-test.c | 417 ++++++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build   |   1 +
 3 files changed, 419 insertions(+)
 create mode 100644 tests/qtest/dw_mci-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1ea3af260f..c915c5f996 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2417,6 +2417,7 @@ F: hw/sd/core.c
 F: hw/sd/dw_mci.c
 F: hw/sd/sd*
 F: hw/sd/ssi-sd.c
+F: tests/qtest/dw_mci-test.c
 F: tests/qtest/fuzz-sdcard-test.c
 F: tests/qtest/sdhci-test.c
 
diff --git a/tests/qtest/dw_mci-test.c b/tests/qtest/dw_mci-test.c
new file mode 100644
index 0000000000..c8c8b9be93
--- /dev/null
+++ b/tests/qtest/dw_mci-test.c
@@ -0,0 +1,417 @@
+/*
+ * QTests for the Synopsys DesignWare Multimedia Card Interface
+ *
+ * Copyright (c) 2026 Process Mission
+ *
+ * Author:
+ *   Bin Meng <bin.meng@processmission.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/bitops.h"
+#include "qemu/bswap.h"
+#include "qemu/units.h"
+#include "libqtest.h"
+
+#define DW_MCI_BASE             0x28001000
+
+#define DW_MCI_CTRL             0x000
+#define DW_MCI_PWREN            0x004
+#define DW_MCI_TMOUT            0x014
+#define DW_MCI_BLKSIZ           0x01c
+#define DW_MCI_BYTCNT           0x020
+#define DW_MCI_INTMASK          0x024
+#define DW_MCI_CMDARG           0x028
+#define DW_MCI_CMD              0x02c
+#define DW_MCI_RESP0            0x030
+#define DW_MCI_MINTSTS          0x040
+#define DW_MCI_RINTSTS          0x044
+#define DW_MCI_STATUS           0x048
+#define DW_MCI_FIFOTH           0x04c
+#define DW_MCI_CDETECT          0x050
+#define DW_MCI_TCBCNT           0x05c
+#define DW_MCI_TBBCNT           0x060
+#define DW_MCI_DEBNCE           0x064
+#define DW_MCI_VERID            0x06c
+#define DW_MCI_HCON             0x070
+#define DW_MCI_RST_N            0x078
+#define DW_MCI_BMOD             0x080
+#define DW_MCI_PLDMND           0x084
+#define DW_MCI_DBADDRL          0x088
+#define DW_MCI_DBADDRU          0x08c
+#define DW_MCI_IDSTS            0x090
+#define DW_MCI_IDINTEN          0x094
+#define DW_MCI_DSCADDRL         0x098
+#define DW_MCI_DSCADDRU         0x09c
+#define DW_MCI_BUFADDRL         0x0a0
+#define DW_MCI_BUFADDRU         0x0a4
+#define DW_MCI_FIFO             0x200
+
+#define DW_MCI_CTRL_INT_ENABLE  BIT(4)
+#define DW_MCI_CTRL_USE_IDMAC   BIT(25)
+
+#define DW_MCI_CMD_RESP_EXP     BIT(6)
+#define DW_MCI_CMD_RESP_LONG    BIT(7)
+#define DW_MCI_CMD_DAT_EXP      BIT(9)
+#define DW_MCI_CMD_DAT_WR       BIT(10)
+#define DW_MCI_CMD_UPD_CLK      BIT(21)
+#define DW_MCI_CMD_START        BIT(31)
+
+#define DW_MCI_INT_CMD_DONE     BIT(2)
+#define DW_MCI_INT_DATA_OVER    BIT(3)
+#define DW_MCI_INT_RTO          BIT(8)
+
+#define DW_MCI_BMOD_ENABLE      BIT(7)
+
+#define DW_MCI_IDSTS_TI         BIT(0)
+#define DW_MCI_IDSTS_RI         BIT(1)
+#define DW_MCI_IDSTS_DU         BIT(4)
+#define DW_MCI_IDSTS_NI         BIT(8)
+#define DW_MCI_IDSTS_AI         BIT(9)
+
+#define DW_MCI_IDMAC_LD         BIT(2)
+#define DW_MCI_IDMAC_FS         BIT(3)
+#define DW_MCI_IDMAC_OWN        BIT(31)
+
+#define DW_MCI_DESC_ADDR        0x80010000
+#define DW_MCI_DATA_ADDR        0x80011000
+#define DW_MCI_READ_ADDR        0x80012000
+#define DW_MCI_BLOCK_SIZE       512
+#define DW_MCI_IMAGE_SIZE       (1 * MiB)
+
+static QTestState *dw_mci_start(const char *sd_path)
+{
+    if (sd_path) {
+        return qtest_initf("-machine phytium-pi -m 1G -display none "
+                           "-drive file=%s,format=raw,if=sd,index=1",
+                           sd_path);
+    }
+
+    return qtest_init("-machine phytium-pi -m 1G -display none");
+}
+
+static char *dw_mci_create_image(void)
+{
+    g_autoptr(GError) error = NULL;
+    char *path = NULL;
+    int fd;
+    int ret;
+
+    fd = g_file_open_tmp("dw-mci-XXXXXX", &path, &error);
+    g_assert_no_error(error);
+    g_assert_cmpint(fd, >=, 0);
+    ret = ftruncate(fd, DW_MCI_IMAGE_SIZE);
+    g_assert_cmpint(ret, ==, 0);
+    close(fd);
+
+    return path;
+}
+
+static uint32_t dw_mci_command(QTestState *qts, uint32_t index,
+                               uint32_t argument, uint32_t flags)
+{
+    uint32_t raw;
+
+    qtest_writel(qts, DW_MCI_BASE + DW_MCI_RINTSTS, UINT32_MAX);
+    qtest_writel(qts, DW_MCI_BASE + DW_MCI_CMDARG, argument);
+    qtest_writel(qts, DW_MCI_BASE + DW_MCI_CMD,
+                 DW_MCI_CMD_START | flags | index);
+    raw = qtest_readl(qts, DW_MCI_BASE + DW_MCI_RINTSTS);
+    g_assert_cmphex(raw & DW_MCI_INT_CMD_DONE, ==, DW_MCI_INT_CMD_DONE);
+    g_assert_cmphex(raw & DW_MCI_INT_RTO, ==, 0);
+
+    return qtest_readl(qts, DW_MCI_BASE + DW_MCI_RESP0);
+}
+
+static void dw_mci_init_card(QTestState *qts)
+{
+    uint32_t rca;
+
+    qtest_writel(qts, DW_MCI_BASE + DW_MCI_PWREN, 1);
+    dw_mci_command(qts, 0, 0, 0);
+    dw_mci_command(qts, 55, 0, DW_MCI_CMD_RESP_EXP);
+    dw_mci_command(qts, 41, 0x41200000, DW_MCI_CMD_RESP_EXP);
+    dw_mci_command(qts, 2, 0,
+                   DW_MCI_CMD_RESP_EXP | DW_MCI_CMD_RESP_LONG);
+    rca = dw_mci_command(qts, 3, 0, DW_MCI_CMD_RESP_EXP) & 0xffff0000;
+    g_assert_cmphex(rca, !=, 0);
+    dw_mci_command(qts, 7, rca, DW_MCI_CMD_RESP_EXP);
+    dw_mci_command(qts, 16, DW_MCI_BLOCK_SIZE, DW_MCI_CMD_RESP_EXP);
+}
+
+static void dw_mci_write_descriptor(QTestState *qts, uint32_t control,
+                                    uint32_t buffer)
+{
+    qtest_writel(qts, DW_MCI_DESC_ADDR, control);
+    qtest_writel(qts, DW_MCI_DESC_ADDR + 4, 0);
+    qtest_writel(qts, DW_MCI_DESC_ADDR + 8, DW_MCI_BLOCK_SIZE);
+    qtest_writel(qts, DW_MCI_DESC_ADDR + 12, 0);
+    qtest_writel(qts, DW_MCI_DESC_ADDR + 16, buffer);
+    qtest_writel(qts, DW_MCI_DESC_ADDR + 20, 0);
+    qtest_writel(qts, DW_MCI_DESC_ADDR + 24, 0);
+    qtest_writel(qts, DW_MCI_DESC_ADDR + 28, 0);
+}
+
+static void dw_mci_prepare_idmac(QTestState *qts, uint32_t interrupts)
+{
+    qtest_writel(qts, DW_MCI_BASE + DW_MCI_CTRL,
+                 DW_MCI_CTRL_USE_IDMAC);
+    qtest_writel(qts, DW_MCI_BASE + DW_MCI_BMOD,
+                 DW_MCI_BMOD_ENABLE);
+    qtest_writel(qts, DW_MCI_BASE + DW_MCI_BLKSIZ,
+                 DW_MCI_BLOCK_SIZE);
+    qtest_writel(qts, DW_MCI_BASE + DW_MCI_BYTCNT,
+                 DW_MCI_BLOCK_SIZE);
+    qtest_writel(qts, DW_MCI_BASE + DW_MCI_DBADDRL,
+                 DW_MCI_DESC_ADDR);
+    qtest_writel(qts, DW_MCI_BASE + DW_MCI_DBADDRU, 0);
+    qtest_writel(qts, DW_MCI_BASE + DW_MCI_IDINTEN, interrupts);
+}
+
+static void test_registers_and_irq(void)
+{
+    QTestState *qts = dw_mci_start(NULL);
+
+    qtest_irq_intercept_out_named(qts, "/machine/mci1", "sysbus-irq");
+
+    g_assert_cmphex(qtest_readl(qts, DW_MCI_BASE + DW_MCI_CTRL), ==,
+                    BIT(24));
+    g_assert_cmphex(qtest_readl(qts, DW_MCI_BASE + DW_MCI_STATUS) &
+                    (BIT(1) | BIT(2)), ==, BIT(1) | BIT(2));
+    g_assert_cmphex(qtest_readl(qts, DW_MCI_BASE + DW_MCI_TMOUT), ==,
+                    0xffffff40);
+    g_assert_cmphex(qtest_readl(qts, DW_MCI_BASE + DW_MCI_BLKSIZ), ==,
+                    DW_MCI_BLOCK_SIZE);
+    g_assert_cmphex(qtest_readl(qts, DW_MCI_BASE + DW_MCI_BYTCNT), ==,
+                    DW_MCI_BLOCK_SIZE);
+    g_assert_cmphex(qtest_readl(qts, DW_MCI_BASE + DW_MCI_FIFOTH), ==,
+                    0x01ff0000);
+    g_assert_cmphex(qtest_readl(qts, DW_MCI_BASE + DW_MCI_CDETECT), ==, 1);
+    g_assert_cmphex(qtest_readl(qts, DW_MCI_BASE + DW_MCI_DEBNCE), ==,
+                    0x00ffffff);
+    g_assert_cmphex(qtest_readl(qts, DW_MCI_BASE + DW_MCI_VERID), ==,
+                    0x280a);
+    g_assert_cmphex(qtest_readl(qts, DW_MCI_BASE + DW_MCI_HCON), ==,
+                    0x08000080);
+    g_assert_cmphex(qtest_readl(qts, DW_MCI_BASE + DW_MCI_RST_N), ==, 1);
+
+    /* Exercise the 64-bit IDMAC layout selected by HCON.ADDR_CONFIG */
+    qtest_writel(qts, DW_MCI_BASE + DW_MCI_DBADDRL,
+                 DW_MCI_DESC_ADDR + 3);
+    g_assert_cmphex(qtest_readl(qts, DW_MCI_BASE + DW_MCI_DBADDRL), ==,
+                    DW_MCI_DESC_ADDR);
+    qtest_writel(qts, DW_MCI_BASE + DW_MCI_DBADDRU, 1);
+    g_assert_cmphex(qtest_readl(qts, DW_MCI_BASE + DW_MCI_DBADDRU), ==, 1);
+    qtest_writel(qts, DW_MCI_BASE + DW_MCI_IDINTEN,
+                 DW_MCI_IDSTS_TI | DW_MCI_IDSTS_NI);
+    g_assert_cmphex(qtest_readl(qts, DW_MCI_BASE + DW_MCI_IDINTEN), ==,
+                    DW_MCI_IDSTS_TI | DW_MCI_IDSTS_NI);
+    g_assert_cmphex(qtest_readl(qts, DW_MCI_BASE + DW_MCI_DSCADDRU), ==, 0);
+
+    qtest_writel(qts, DW_MCI_BASE + DW_MCI_RINTSTS, UINT32_MAX);
+    qtest_writel(qts, DW_MCI_BASE + DW_MCI_CMD,
+                 DW_MCI_CMD_START | DW_MCI_CMD_UPD_CLK);
+    g_assert_cmphex(qtest_readl(qts, DW_MCI_BASE + DW_MCI_RINTSTS) &
+                    DW_MCI_INT_CMD_DONE, ==, 0);
+
+    qtest_writel(qts, DW_MCI_BASE + DW_MCI_CTRL,
+                 DW_MCI_CTRL_INT_ENABLE);
+    qtest_writel(qts, DW_MCI_BASE + DW_MCI_INTMASK,
+                 DW_MCI_INT_CMD_DONE | DW_MCI_INT_RTO);
+    qtest_writel(qts, DW_MCI_BASE + DW_MCI_CMD,
+                 DW_MCI_CMD_START | DW_MCI_CMD_RESP_EXP);
+    g_assert_cmphex(qtest_readl(qts, DW_MCI_BASE + DW_MCI_MINTSTS), ==,
+                    DW_MCI_INT_CMD_DONE | DW_MCI_INT_RTO);
+    g_assert_true(qtest_get_irq(qts, 0));
+    qtest_writel(qts, DW_MCI_BASE + DW_MCI_RINTSTS,
+                 DW_MCI_INT_CMD_DONE | DW_MCI_INT_RTO);
+    g_assert_false(qtest_get_irq(qts, 0));
+
+    qtest_system_reset(qts);
+    g_assert_cmphex(qtest_readl(qts, DW_MCI_BASE + DW_MCI_CTRL), ==,
+                    BIT(24));
+    g_assert_cmphex(qtest_readl(qts, DW_MCI_BASE + DW_MCI_RINTSTS), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, DW_MCI_BASE + DW_MCI_BMOD), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, DW_MCI_BASE + DW_MCI_DBADDRL), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, DW_MCI_BASE + DW_MCI_DBADDRU), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, DW_MCI_BASE + DW_MCI_IDINTEN), ==, 0);
+    qtest_quit(qts);
+}
+
+static void test_idmac_write_and_read(void)
+{
+    g_autofree char *sd_path = dw_mci_create_image();
+    uint8_t pattern[DW_MCI_BLOCK_SIZE];
+    uint8_t actual[DW_MCI_BLOCK_SIZE];
+    uint8_t zero[DW_MCI_BLOCK_SIZE] = { 0 };
+    QTestState *qts = dw_mci_start(sd_path);
+    uint32_t status;
+    size_t i;
+    ssize_t size;
+    int fd;
+
+    qtest_irq_intercept_out_named(qts, "/machine/mci1", "sysbus-irq");
+    dw_mci_init_card(qts);
+
+    for (i = 0; i < sizeof(pattern); i++) {
+        pattern[i] = i ^ 0xa5;
+    }
+    qtest_memwrite(qts, DW_MCI_DATA_ADDR, pattern, sizeof(pattern));
+    dw_mci_write_descriptor(qts,
+                            DW_MCI_IDMAC_OWN | DW_MCI_IDMAC_FS |
+                            DW_MCI_IDMAC_LD,
+                            DW_MCI_DATA_ADDR);
+    dw_mci_prepare_idmac(qts, DW_MCI_IDSTS_TI | DW_MCI_IDSTS_NI);
+    dw_mci_command(qts, 24, 0,
+                   DW_MCI_CMD_RESP_EXP | DW_MCI_CMD_DAT_EXP |
+                   DW_MCI_CMD_DAT_WR);
+
+    g_assert_cmphex(qtest_readl(qts, DW_MCI_DESC_ADDR) &
+                    DW_MCI_IDMAC_OWN, ==, 0);
+    status = qtest_readl(qts, DW_MCI_BASE + DW_MCI_IDSTS);
+    g_assert_cmphex(status & (DW_MCI_IDSTS_TI | DW_MCI_IDSTS_NI), ==,
+                    DW_MCI_IDSTS_TI | DW_MCI_IDSTS_NI);
+    g_assert_cmphex(qtest_readl(qts, DW_MCI_BASE + DW_MCI_DSCADDRL), ==,
+                    DW_MCI_DESC_ADDR);
+    g_assert_cmphex(qtest_readl(qts, DW_MCI_BASE + DW_MCI_DSCADDRU), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, DW_MCI_BASE + DW_MCI_BUFADDRL), ==,
+                    DW_MCI_DATA_ADDR);
+    g_assert_cmphex(qtest_readl(qts, DW_MCI_BASE + DW_MCI_BUFADDRU), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, DW_MCI_BASE + DW_MCI_RINTSTS) &
+                    DW_MCI_INT_DATA_OVER, ==, DW_MCI_INT_DATA_OVER);
+    g_assert_true(qtest_get_irq(qts, 0));
+    qtest_writel(qts, DW_MCI_BASE + DW_MCI_IDSTS,
+                 DW_MCI_IDSTS_TI | DW_MCI_IDSTS_NI);
+    g_assert_false(qtest_get_irq(qts, 0));
+
+    qtest_memwrite(qts, DW_MCI_READ_ADDR, zero, sizeof(zero));
+    dw_mci_write_descriptor(qts,
+                            DW_MCI_IDMAC_OWN | DW_MCI_IDMAC_FS |
+                            DW_MCI_IDMAC_LD,
+                            DW_MCI_READ_ADDR);
+    dw_mci_prepare_idmac(qts, DW_MCI_IDSTS_RI | DW_MCI_IDSTS_NI);
+    dw_mci_command(qts, 17, 0,
+                   DW_MCI_CMD_RESP_EXP | DW_MCI_CMD_DAT_EXP);
+    qtest_memread(qts, DW_MCI_READ_ADDR, actual, sizeof(actual));
+    g_assert_cmpmem(actual, sizeof(actual), pattern, sizeof(pattern));
+    status = qtest_readl(qts, DW_MCI_BASE + DW_MCI_IDSTS);
+    g_assert_cmphex(status & (DW_MCI_IDSTS_RI | DW_MCI_IDSTS_NI), ==,
+                    DW_MCI_IDSTS_RI | DW_MCI_IDSTS_NI);
+    qtest_quit(qts);
+
+    fd = open(sd_path, O_RDONLY);
+    g_assert_cmpint(fd, >=, 0);
+    size = read(fd, actual, sizeof(actual));
+    close(fd);
+    g_assert_cmpint(size, ==, sizeof(actual));
+    g_assert_cmpmem(actual, sizeof(actual), pattern, sizeof(pattern));
+    unlink(sd_path);
+}
+
+static void test_idmac_suspend_and_resume(void)
+{
+    g_autofree char *sd_path = dw_mci_create_image();
+    uint8_t pattern[DW_MCI_BLOCK_SIZE];
+    QTestState *qts = dw_mci_start(sd_path);
+    uint32_t status;
+    size_t i;
+
+    qtest_irq_intercept_out_named(qts, "/machine/mci1", "sysbus-irq");
+    dw_mci_init_card(qts);
+
+    for (i = 0; i < sizeof(pattern); i++) {
+        pattern[i] = i ^ 0x69;
+    }
+    qtest_memwrite(qts, DW_MCI_DATA_ADDR, pattern, sizeof(pattern));
+    dw_mci_write_descriptor(qts, 0, DW_MCI_DATA_ADDR);
+    dw_mci_prepare_idmac(qts,
+                         DW_MCI_IDSTS_TI | DW_MCI_IDSTS_DU |
+                         DW_MCI_IDSTS_NI | DW_MCI_IDSTS_AI);
+    dw_mci_command(qts, 24, 0,
+                   DW_MCI_CMD_RESP_EXP | DW_MCI_CMD_DAT_EXP |
+                   DW_MCI_CMD_DAT_WR);
+
+    status = qtest_readl(qts, DW_MCI_BASE + DW_MCI_IDSTS);
+    g_assert_cmphex(status & (DW_MCI_IDSTS_DU | DW_MCI_IDSTS_AI), ==,
+                    DW_MCI_IDSTS_DU | DW_MCI_IDSTS_AI);
+    g_assert_cmphex((status >> 13) & 0xf, ==, 1);
+    g_assert_cmphex(qtest_readl(qts, DW_MCI_BASE + DW_MCI_RINTSTS) &
+                    DW_MCI_INT_DATA_OVER, ==, 0);
+    g_assert_true(qtest_get_irq(qts, 0));
+
+    qtest_writel(qts, DW_MCI_BASE + DW_MCI_IDSTS,
+                 DW_MCI_IDSTS_DU | DW_MCI_IDSTS_AI);
+    g_assert_false(qtest_get_irq(qts, 0));
+    dw_mci_write_descriptor(qts,
+                            DW_MCI_IDMAC_OWN | DW_MCI_IDMAC_FS |
+                            DW_MCI_IDMAC_LD,
+                            DW_MCI_DATA_ADDR);
+    qtest_writel(qts, DW_MCI_BASE + DW_MCI_PLDMND, 0);
+
+    status = qtest_readl(qts, DW_MCI_BASE + DW_MCI_IDSTS);
+    g_assert_cmphex(status & (DW_MCI_IDSTS_TI | DW_MCI_IDSTS_NI), ==,
+                    DW_MCI_IDSTS_TI | DW_MCI_IDSTS_NI);
+    g_assert_cmphex((status >> 13) & 0xf, ==, 0);
+    g_assert_cmphex(qtest_readl(qts, DW_MCI_BASE + DW_MCI_RINTSTS) &
+                    DW_MCI_INT_DATA_OVER, ==, DW_MCI_INT_DATA_OVER);
+    g_assert_true(qtest_get_irq(qts, 0));
+
+    qtest_quit(qts);
+    unlink(sd_path);
+}
+
+static void test_fifo_data_port(void)
+{
+    g_autofree char *sd_path = dw_mci_create_image();
+    uint8_t pattern[DW_MCI_BLOCK_SIZE];
+    uint8_t actual[DW_MCI_BLOCK_SIZE];
+    QTestState *qts = dw_mci_start(sd_path);
+    size_t i;
+    ssize_t size;
+    int fd;
+
+    dw_mci_init_card(qts);
+    for (i = 0; i < sizeof(pattern); i++) {
+        pattern[i] = i ^ 0x3c;
+    }
+
+    qtest_writel(qts, DW_MCI_BASE + DW_MCI_BLKSIZ, DW_MCI_BLOCK_SIZE);
+    qtest_writel(qts, DW_MCI_BASE + DW_MCI_BYTCNT, DW_MCI_BLOCK_SIZE);
+    dw_mci_command(qts, 24, 0,
+                   DW_MCI_CMD_RESP_EXP | DW_MCI_CMD_DAT_EXP |
+                   DW_MCI_CMD_DAT_WR);
+    for (i = 0; i < sizeof(pattern); i += sizeof(uint32_t)) {
+        qtest_writel(qts, DW_MCI_BASE + DW_MCI_FIFO + (i % 64),
+                     ldl_le_p(pattern + i));
+    }
+    g_assert_cmphex(qtest_readl(qts, DW_MCI_BASE + DW_MCI_TCBCNT), ==,
+                    DW_MCI_BLOCK_SIZE);
+    g_assert_cmphex(qtest_readl(qts, DW_MCI_BASE + DW_MCI_TBBCNT), ==,
+                    DW_MCI_BLOCK_SIZE);
+    g_assert_cmphex(qtest_readl(qts, DW_MCI_BASE + DW_MCI_RINTSTS) &
+                    DW_MCI_INT_DATA_OVER, ==, DW_MCI_INT_DATA_OVER);
+    qtest_quit(qts);
+
+    fd = open(sd_path, O_RDONLY);
+    g_assert_cmpint(fd, >=, 0);
+    size = read(fd, actual, sizeof(actual));
+    close(fd);
+    g_assert_cmpint(size, ==, sizeof(actual));
+    g_assert_cmpmem(actual, sizeof(actual), pattern, sizeof(pattern));
+    unlink(sd_path);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("dw-mci/registers-and-irq", test_registers_and_irq);
+    qtest_add_func("dw-mci/idmac-write-and-read", test_idmac_write_and_read);
+    qtest_add_func("dw-mci/idmac-suspend-and-resume",
+                   test_idmac_suspend_and_resume);
+    qtest_add_func("dw-mci/fifo-data-port", test_fifo_data_port);
+
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 50a1a5272f..de47741ff1 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -279,6 +279,7 @@ qtests_aarch64 = \
    config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test', 'tpm-tis-i2c-swtpm-test'] : []) + \
   (config_all_devices.has_key('CONFIG_ASPEED_SOC') ? qtests_aspeed64 : []) + \
   (config_all_devices.has_key('CONFIG_NPCM8XX') ? qtests_npcm8xx : []) + \
+  (config_all_devices.has_key('CONFIG_PHYTIUM_E2000') ? ['dw_mci-test'] : []) + \
   (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
    config_all_devices.has_key('CONFIG_ARM_VIRT') ?
    ['iommu-smmuv3-test'] : []) + \
-- 
2.53.0


