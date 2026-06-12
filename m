Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EADD6CD8CA8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 12:17:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY0nT-0001VN-64; Fri, 12 Jun 2026 08:15:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wXvxJ-0002ZP-Q7; Fri, 12 Jun 2026 03:05:30 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wXvxG-0005yW-3M; Fri, 12 Jun 2026 03:05:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k0xpkfzDWpgQ/Eg7cU/12bfspE/DyW5gFfut4D9Lcs0hjgYyFVBkJghj+T55vGb1eUa0N1HQEooU6KVqBuq3uKOyJU95j3AUCU0dXX7UTaBAbZd7d+pRjen4q1wy+i2LmPQ0eYr7xjVYIrr9LAtfSSHEeJt2Zd2jiqxR7V/FbvfwouhxzMcXRInZ5Gd9cQwDKLd7KUFDt4LjpjwYm+Lq2ddw45sauZS0fPBP4fhKR0BKFfQKofK3Qcuw2NUwHD7Ur8E7TCwmnheh6rRwQqQE8vdshbOSFnKR81MTLPOwOZ3i1Qt7bCUwTYreJYKfFC9VY9eO8RWfCqEGp6Tt6ePKLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cv6y85Ij8+iOGfdipj/OMgxMOyVHR+4SbrsMKclQoQg=;
 b=Wj/9igpRrKqLZAE6d3ub2PXcVNHqy1PoZDfZthxdJ7nASnu64TJ99/I2OEhhpbKJdNucKIOSJIoRu/gXhZWIyXpg5kPkjmN+Ph7YIAP3uuyIdcN2bNJ/poCBApZiWTzp3m+SyrqRCLqXRKTGTM5GSsy/BDPm1trbLae7zKUijqXDUQ3VNesv5ZB1Lp1bibc0TqIGqj3PGfPpCqVyJNBdvXClP4/CEhw8VeDupO3E6ei8Qt7vtcEO7qKU1hT9LZvxIl31VeeGGPZYLag/p/56xFOS2D/fQmg6YmEjvJL/VvXgnuNKXaoKRNaCATQajTia721Ut8kEyQVhiAeyNdDdqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cv6y85Ij8+iOGfdipj/OMgxMOyVHR+4SbrsMKclQoQg=;
 b=rcZKDFXZnHAVJkWuWvm/dZHoWwMCSc7vvUWmugRwh+Qi6LhzTXAFPj52uv00scEnlUA5/8+3zdbWEHT8RuuB+YRmqcDRi3CoAj0mrktvSoYUaQMYsN8ogcwZqKZkHwKm39GI9avrWB+G/RcX6MsTAphYmos/RtouebkmFkgwWw0ypP+Ol9T3z4jivg4mN85aFCLjUTYwOcq2z30UNFSSAdLKaz+jIMD5sDE80CZ+J1ARFWj9TVjFH8/Va5Ur3juLdy/h0Hjk2ACF06mD5GkUuyIux7u1KJ3S13KmPprI0vOdlWOuEyrbrb8LJKrAIMLkBn2Z5GtEa4zt9kpmSH1GdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by SEYPR02MB6457.apcprd02.prod.outlook.com (2603:1096:101:13b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 07:05:10 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0092.017; Fri, 12 Jun 2026
 07:05:10 +0000
From: Chao Liu <chao.liu@processmission.com>
To: Alistair Francis <alistair.francis@wdc.com>
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Peng Jiang <3160104094@zju.edu.cn>
Subject: [PATCH v8 2/5] hw/riscv: add k230 board initial support
Date: Fri, 12 Jun 2026 15:04:05 +0800
Message-ID: <a161697a249b896e44e2748435f6c0caec12c9f4.1781246408.git.chao.liu@processmission.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1781246408.git.chao.liu@processmission.com>
References: <cover.1781246408.git.chao.liu@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR07CA0046.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::24) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|SEYPR02MB6457:EE_
X-MS-Office365-Filtering-Correlation-Id: 44e7a51f-be17-479b-6eeb-08dec850f114
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|34096008|366016|7416014|586017|376014|56012099006|6133799003|13003099007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: doMO6m77j5/B2vhzu3iHo77yVNMFCgoYoAUU3LfJRJl+Nun7qpuds003AJ6k1Qk9dERu6vs3HnUSrjCmyqkOXE3qk0qMo1RlnOY8s6nkCEmXKxKG61j3eqnlHYU+pYaN3NTb3mnbVerNx2c7pLoUxkGLDXX5gqsuKiv0iGbjNGlrW09uW4lJiVfH9ICpVXl90ejc69YiGzCaT+D+wT8cOQN42UJAKv+1tbkshcVn+UzA77Tq6ANcYQmlDMuP3rRjliLojK2t8WGXDptGkb5L2K9R50zUelQ2b3VNcxW2+1QmKNJtoI/+pl+dcZiuOSpr1QrU0So5hR4Z11YGXVw3mS0O9JxoH7YuC2TVl72BP0QXI9DWRY7GOmoRQo4qmkKmdi6UkEVeJi1VrOQv8xLCeQaQBbaQfbgKlD6rQWLybiYoZRhyy8vgkDcDW++2FkipkQRyewtK9xXbcYRZQRLCq6c85ZA9R9gOcfRrW1C8rdwqwtDnpBcqJ9F0Tsci19BYOZcolLDYUndPGRfrXeAPFDeOuGHuzvEqqGAvo/JHYK5d02KG4yvegxOkGa+DIEb4GbpUtw7cqf2FtduVb/W3qbfMXHmUTbUTYDxX8Ssk/jT3e2CodbK4R7vSJVvWCPXntqxExUZ9wX4uDn0k+qB+lw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(34096008)(366016)(7416014)(586017)(376014)(56012099006)(6133799003)(13003099007)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wVznV5muzpwxnHus+5M18iEWWFg7C22yL15oNknzky7hvWDMxDhb+JxFWO9E?=
 =?us-ascii?Q?4yv40VGhGrPJ5RVwkOqJheCjpZODczyxflH689MFnDRW0M/yvtwVWVFrhvPl?=
 =?us-ascii?Q?koaf9FUhwdbBwEq6Ad2xl/PsdKcCKrJoh2qBkTdkhpS6+Z7hLsDjm5YDSQ+W?=
 =?us-ascii?Q?EY4FGF4b9mbAm/fx2KtLOhkZmgCvinWWjAW8WJ1cMJX2qRXdaJkBKwVeBm5c?=
 =?us-ascii?Q?u0BHxNISEoamZVG3CGSl+1uKWl8FuGJgSWhvcPT6EWktV7oOdbgjL+gGlzMC?=
 =?us-ascii?Q?7ZGv4pQQAhbiU8tqW5UHXUEd1V5/QVnBP+ech0c383VuH2PnqSB4q9w2w1OM?=
 =?us-ascii?Q?2nx6VGPfZmPuhuN1khSpcBTx28XHurjQqh8hAWXn4PV7DfIU3PFKHHr41/P5?=
 =?us-ascii?Q?sIUfrN5KllYnaPOSmRVnRvAVYFhCWEUtdjAcZg4VlFn9XB7ke3EHH7PjRVoz?=
 =?us-ascii?Q?6pmyxHqgVHQRVlG34nFjZ2BYotmgABqoNXdg83FTNQsXgx4BCF8mwvntl3Iw?=
 =?us-ascii?Q?giZwsFkDs9OrJ1V5D1ErrCMXW8+Btpw5XOqdwAQfwfWMAhxAlTNxkP4wjJ1U?=
 =?us-ascii?Q?NbjbjmNtGmhhDrjE6QQlCxkUouvK8hko8rTiFGnYtFf8Y4HTDxL7L1Gmoqxi?=
 =?us-ascii?Q?JGrgJHBWq18hogkeszEPVun8CVpooimuhEN8t+8J/Pg+cB7CnVzmAH8xjMDv?=
 =?us-ascii?Q?DZ9dgsj6Nn8OpA+KJTckypoLfyS6lw63ZA85gk08mYBed8DjXXec7DXm9E/g?=
 =?us-ascii?Q?U2AXa0NYjOcyaH+rJGyHMBE+EWGSMTRXW6QXjlPThtnxE9q737dOSSQrufx1?=
 =?us-ascii?Q?BYHwLmSOqzd/HsgC/nLEOk7KCR6CKdyjo8fP4Lo9olN+Rd0/AAmJhDnKKz/I?=
 =?us-ascii?Q?2VUlqJ2IiNO2QbkSVTP+vkXzQr1dBAyDcovYvV50vU1goo4Hc/tsBlvHQVhJ?=
 =?us-ascii?Q?A8h7Hy/24JCdbJREm9kkDYkkWQ/VLgYq0k4TprWh6XCDlvnFmL7ns3OhgIaA?=
 =?us-ascii?Q?bcv2dpd1ZYj52FPh1N/agBVMbqgrvLooqSrVOL2h/DnxtdV06L7XgPuH0y9P?=
 =?us-ascii?Q?KjJMhefmgp5HpilAkDE8A133QUsxOUysodIziHlg7x86bA45o0MZlcQJAKn3?=
 =?us-ascii?Q?3eOInWFWDX9DRp//poM+4s0LjYndd1Opbv8O/Ro25Eu1guCSt5zPw0+bD7nC?=
 =?us-ascii?Q?vKCBWmiECDQx0OugoDdYEnZzRGKk9QsEOknr23dRwHXkA/nj7dgbde/0L+oP?=
 =?us-ascii?Q?4fl4/rsHeXJX55aLI89Sb3/ckv3sYbcjXOb/W5DskRntHmokqYe2vwB8PUCB?=
 =?us-ascii?Q?LwZ47lC3mrs7sUXJQViOjAEZAuKeeM5PZ7l0GyqCdbFTePOWk757850Kw5hB?=
 =?us-ascii?Q?XOV1q85DKJmVMO8XKWbwXk5l5eJgH0XYA0dCNiQp81O0IOqzWe7Y8e4FeLWB?=
 =?us-ascii?Q?Ht5rC/3XxWsJie+hlfTNOTp3y1yNxJzi1TwyzJO6qkhOg2a1BBWtu7+OErII?=
 =?us-ascii?Q?dQN5yFsLvXdr5ehTstkVq5AW0BVokZFmXNyqKH9WpgKgVEg0EsBZngjlYhGR?=
 =?us-ascii?Q?JQJzy0as4dymkjgBD77A7k4NbNC6R4HLmVSdo0MREpB6jiW4anCSklZeKgG3?=
 =?us-ascii?Q?KC+H+hD/vPhMDpOopHZzucBt9jk08n8LS6q3NsWIcNYzwfnYRe/j3A4FWyyH?=
 =?us-ascii?Q?EaGkn4KGq6/xvGTrWlqYpUhirfcJ32Yopc8jWwiNuYGrov+QksA9fcZB41nT?=
 =?us-ascii?Q?yIluqu0wYG8RAgK8W/wkLvil0uAtYwA=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44e7a51f-be17-479b-6eeb-08dec850f114
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 07:05:10.2181 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tC18y7Yi7T0zO/JJvHVUV1n4Wpq8Bco8whlD5nN6pILJDeb9ZYkznsoUlfK9a72jNaycaTqjPnWkQKaETOhhn9fx438nQYs/Z3+LXp2XRV4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB6457
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=chao.liu@processmission.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 12 Jun 2026 08:15:35 -0400
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

From: Chao Liu <chao.liu.zevorn@gmail.com>

K230 Board compatible with Kendryte K230 SDK.

Preliminarily supports the C908 small core, which can run U-Boot and
Linux kernels compiled by the K230 SDK.

The K230 boot flow provides its device tree from firmware or software.
QEMU does not generate a K230 DTB; users can pass one with -dtb for
direct Linux boot, or rely on firmware/kernel built-in DTB for other
payloads.

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
Tested-by: Peng Jiang <3160104094@zju.edu.cn>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 MAINTAINERS             |   7 +
 hw/riscv/Kconfig        |  10 +
 hw/riscv/k230.c         | 508 ++++++++++++++++++++++++++++++++++++++++
 hw/riscv/meson.build    |   2 +-
 include/hw/riscv/k230.h | 145 ++++++++++++
 5 files changed, 671 insertions(+), 1 deletion(-)
 create mode 100644 hw/riscv/k230.c
 create mode 100644 include/hw/riscv/k230.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 2b5b581e17..a21796ac6f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1786,6 +1786,13 @@ F: docs/system/riscv/xiangshan-kunminghu.rst
 F: hw/riscv/xiangshan_kmh.c
 F: include/hw/riscv/xiangshan_kmh.h
 
+K230 Machines
+M: Chao Liu <chao.liu.zevorn@gmail.com>
+L: qemu-riscv@nongnu.org
+S: Maintained
+F: hw/riscv/k230.c
+F: include/hw/riscv/k230.h
+
 RX Machines
 -----------
 rx-gdbsim
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 2518b04175..f512ed65ac 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -138,3 +138,13 @@ config MIPS_BOSTON_AIA
     select RISCV_MIPS_CMGCR
     select RISCV_MIPS_CPC
     select RISCV_MIPS_CPS
+
+config K230
+    bool
+    default y
+    depends on RISCV64
+    select RISCV_ACLINT
+    select RISCV_APLIC
+    select RISCV_IMSIC
+    select SERIAL_MM
+    select UNIMP
diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
new file mode 100644
index 0000000000..26d1e20c99
--- /dev/null
+++ b/hw/riscv/k230.c
@@ -0,0 +1,508 @@
+/*
+ * QEMU RISC-V Virt Board Compatible with Kendryte K230 SDK
+ *
+ * Copyright (c) 2025 Chao Liu <chao.liu.zevorn@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Provides a board compatible with the Kendryte K230 SDK
+ *
+ * K230 Technical Reference Manual V0.3.1 (2024-11-18):
+ * https://github.com/revyos/external-docs/blob/master/K230/en-us/K230_Technical_Reference_Manual_V0.3.1_20241118.pdf
+ *
+ * For more information, see <https://www.kendryte.com/en/proDetail/230>
+ */
+
+#include "qemu/osdep.h"
+#include "cpu-qom.h"
+#include "qemu/cutils.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
+#include "system/device_tree.h"
+#include "system/system.h"
+#include "system/memory.h"
+#include "target/riscv/cpu.h"
+#include "hw/core/loader.h"
+#include "hw/core/sysbus.h"
+#include "hw/riscv/k230.h"
+#include "hw/riscv/boot.h"
+#include "hw/riscv/machines-qom.h"
+#include "hw/intc/riscv_aclint.h"
+#include "hw/intc/sifive_plic.h"
+#include "hw/char/serial-mm.h"
+#include "hw/misc/unimp.h"
+
+/* Align K230_SDK k230_canmv_defconfig */
+#define K230_DIRECT_OPENSBI_ADDR 0x8000000
+#define K230_DIRECT_KERNEL_ADDR  0x8200000
+#define K230_DIRECT_DTB_ADDR     0xa000000
+
+static const MemMapEntry memmap[] = {
+    [K230_DEV_DDRC] =         { 0x00000000,  0x80000000 },
+    [K230_DEV_KPU_L2_CACHE] = { 0x80000000,  0x00200000 },
+    [K230_DEV_SRAM] =         { 0x80200000,  0x00200000 },
+    [K230_DEV_KPU_CFG] =      { 0x80400000,  0x00000800 },
+    [K230_DEV_FFT] =          { 0x80400800,  0x00000400 },
+    [K230_DEV_AI_2D_ENGINE] = { 0x80400C00,  0x00000800 },
+    [K230_DEV_GSDMA] =        { 0x80800000,  0x00004000 },
+    [K230_DEV_DMA] =          { 0x80804000,  0x00004000 },
+    [K230_DEV_DECOMP_GZIP] =  { 0x80808000,  0x00004000 },
+    [K230_DEV_NON_AI_2D] =    { 0x8080C000,  0x00004000 },
+    [K230_DEV_ISP] =          { 0x90000000,  0x00008000 },
+    [K230_DEV_DEWARP] =       { 0x90008000,  0x00001000 },
+    [K230_DEV_RX_CSI] =       { 0x90009000,  0x00002000 },
+    [K230_DEV_H264] =         { 0x90400000,  0x00010000 },
+    [K230_DEV_2P5D] =         { 0x90800000,  0x00040000 },
+    [K230_DEV_VO] =           { 0x90840000,  0x00010000 },
+    [K230_DEV_VO_CFG] =       { 0x90850000,  0x00001000 },
+    [K230_DEV_3D_ENGINE] =    { 0x90A00000,  0x00000800 },
+    [K230_DEV_PMU] =          { 0x91000000,  0x00000C00 },
+    [K230_DEV_RTC] =          { 0x91000C00,  0x00000400 },
+    [K230_DEV_CMU] =          { 0x91100000,  0x00001000 },
+    [K230_DEV_RMU] =          { 0x91101000,  0x00001000 },
+    [K230_DEV_BOOT] =         { 0x91102000,  0x00001000 },
+    [K230_DEV_PWR] =          { 0x91103000,  0x00001000 },
+    [K230_DEV_MAILBOX] =      { 0x91104000,  0x00001000 },
+    [K230_DEV_IOMUX] =        { 0x91105000,  0x00000800 },
+    [K230_DEV_TIMER] =        { 0x91105800,  0x00000800 },
+    [K230_DEV_WDT0] =         { 0x91106000,  0x00000800 },
+    [K230_DEV_WDT1] =         { 0x91106800,  0x00000800 },
+    [K230_DEV_TS] =           { 0x91107000,  0x00000800 },
+    [K230_DEV_HDI] =          { 0x91107800,  0x00000800 },
+    [K230_DEV_STC] =          { 0x91108000,  0x00000800 },
+    [K230_DEV_BOOTROM] =      { 0x91200000,  0x00010000 },
+    [K230_DEV_SECURITY] =     { 0x91210000,  0x00008000 },
+    [K230_DEV_UART0] =        { 0x91400000,  0x00001000 },
+    [K230_DEV_UART1] =        { 0x91401000,  0x00001000 },
+    [K230_DEV_UART2] =        { 0x91402000,  0x00001000 },
+    [K230_DEV_UART3] =        { 0x91403000,  0x00001000 },
+    [K230_DEV_UART4] =        { 0x91404000,  0x00001000 },
+    [K230_DEV_I2C0] =         { 0x91405000,  0x00001000 },
+    [K230_DEV_I2C1] =         { 0x91406000,  0x00001000 },
+    [K230_DEV_I2C2] =         { 0x91407000,  0x00001000 },
+    [K230_DEV_I2C3] =         { 0x91408000,  0x00001000 },
+    [K230_DEV_I2C4] =         { 0x91409000,  0x00001000 },
+    [K230_DEV_PWM] =          { 0x9140A000,  0x00001000 },
+    [K230_DEV_GPIO0] =        { 0x9140B000,  0x00001000 },
+    [K230_DEV_GPIO1] =        { 0x9140C000,  0x00001000 },
+    [K230_DEV_ADC] =          { 0x9140D000,  0x00001000 },
+    [K230_DEV_CODEC] =        { 0x9140E000,  0x00001000 },
+    [K230_DEV_I2S] =          { 0x9140F000,  0x00001000 },
+    [K230_DEV_USB0] =         { 0x91500000,  0x00010000 },
+    [K230_DEV_USB1] =         { 0x91540000,  0x00010000 },
+    [K230_DEV_SD0] =          { 0x91580000,  0x00001000 },
+    [K230_DEV_SD1] =          { 0x91581000,  0x00001000 },
+    [K230_DEV_QSPI0] =        { 0x91582000,  0x00001000 },
+    [K230_DEV_QSPI1] =        { 0x91583000,  0x00001000 },
+    [K230_DEV_SPI] =          { 0x91584000,  0x00001000 },
+    [K230_DEV_HI_SYS_CFG] =   { 0x91585000,  0x00000400 },
+    [K230_DEV_DDRC_CFG] =     { 0x98000000,  0x02000000 },
+    [K230_DEV_FLASH] =        { 0xC0000000,  0x08000000 },
+    [K230_DEV_PLIC] =         { 0xF00000000, 0x00400000 },
+    [K230_DEV_CLINT] =        { 0xF04000000, 0x00400000 },
+};
+
+static void k230_soc_init(Object *obj)
+{
+    K230SoCState *s = RISCV_K230_SOC(obj);
+    RISCVHartArrayState *cpu0 = &s->c908_cpu;
+
+    object_initialize_child(obj, "c908-cpu", cpu0, TYPE_RISCV_HART_ARRAY);
+    qdev_prop_set_uint32(DEVICE(cpu0), "hartid-base", 0);
+    qdev_prop_set_string(DEVICE(cpu0), "cpu-type", TYPE_RISCV_CPU_THEAD_C908);
+    qdev_prop_set_uint64(DEVICE(cpu0), "resetvec",
+                         memmap[K230_DEV_BOOTROM].base);
+}
+
+static DeviceState *k230_create_plic(int base_hartid, int hartid_count)
+{
+    g_autofree char *plic_hart_config = NULL;
+
+    /* Per-socket PLIC hart topology configuration string */
+    plic_hart_config = riscv_plic_hart_config_string(hartid_count);
+
+    /* Per-socket PLIC */
+    return sifive_plic_create(memmap[K230_DEV_PLIC].base,
+                              plic_hart_config, hartid_count, base_hartid,
+                              K230_PLIC_NUM_SOURCES,
+                              K230_PLIC_NUM_PRIORITIES,
+                              K230_PLIC_PRIORITY_BASE, K230_PLIC_PENDING_BASE,
+                              K230_PLIC_ENABLE_BASE, K230_PLIC_ENABLE_STRIDE,
+                              K230_PLIC_CONTEXT_BASE,
+                              K230_PLIC_CONTEXT_STRIDE,
+                              memmap[K230_DEV_PLIC].size);
+}
+
+static void k230_create_uart(MemoryRegion *sys_mem, DeviceState *plic,
+                             int index)
+{
+    int uart_dev = K230_DEV_UART0 + index;
+    g_autofree char *name = g_strdup_printf("uart%d", index);
+
+    /* Cover the non-16550 part of the SDK's 0x1000 UART window. */
+    create_unimplemented_device(name, memmap[uart_dev].base,
+                                memmap[uart_dev].size);
+
+    serial_mm_init(sys_mem, memmap[uart_dev].base, 2,
+                   qdev_get_gpio_in(plic, K230_UART0_IRQ + index),
+                   399193, serial_hd(index), DEVICE_LITTLE_ENDIAN);
+}
+
+static void k230_soc_realize(DeviceState *dev, Error **errp)
+{
+    K230SoCState *s = RISCV_K230_SOC(dev);
+    MemoryRegion *sys_mem = get_system_memory();
+    int c908_cpus;
+
+    sysbus_realize(SYS_BUS_DEVICE(&s->c908_cpu), &error_fatal);
+
+    c908_cpus = s->c908_cpu.num_harts;
+
+    /* SRAM */
+    memory_region_init_ram(&s->sram, OBJECT(dev), "sram",
+                           memmap[K230_DEV_SRAM].size, &error_fatal);
+    memory_region_add_subregion(sys_mem, memmap[K230_DEV_SRAM].base,
+                                &s->sram);
+
+    /* BootROM */
+    memory_region_init_rom(&s->bootrom, OBJECT(dev), "bootrom",
+                           memmap[K230_DEV_BOOTROM].size, &error_fatal);
+    memory_region_add_subregion(sys_mem, memmap[K230_DEV_BOOTROM].base,
+                                &s->bootrom);
+
+    /* PLIC */
+    s->c908_plic = k230_create_plic(C908_CPU_HARTID, c908_cpus);
+
+    /* CLINT */
+    riscv_aclint_swi_create(memmap[K230_DEV_CLINT].base,
+                            C908_CPU_HARTID, c908_cpus, false);
+    riscv_aclint_mtimer_create(memmap[K230_DEV_CLINT].base + 0x4000,
+                               RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
+                               C908_CPU_HARTID, c908_cpus,
+                               RISCV_ACLINT_DEFAULT_MTIMECMP,
+                               RISCV_ACLINT_DEFAULT_MTIME,
+                               RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ, true);
+
+    /* UART */
+    for (int i = 0; i < K230_UART_COUNT; i++) {
+        k230_create_uart(sys_mem, DEVICE(s->c908_plic), i);
+    }
+
+    /* unimplemented devices */
+    create_unimplemented_device("kpu.l2-cache",
+                                memmap[K230_DEV_KPU_L2_CACHE].base,
+                                memmap[K230_DEV_KPU_L2_CACHE].size);
+
+    create_unimplemented_device("kpu_cfg", memmap[K230_DEV_KPU_CFG].base,
+                                memmap[K230_DEV_KPU_CFG].size);
+
+    create_unimplemented_device("fft", memmap[K230_DEV_FFT].base,
+                                memmap[K230_DEV_FFT].size);
+
+    create_unimplemented_device("2d-engine.ai",
+                                memmap[K230_DEV_AI_2D_ENGINE].base,
+                                memmap[K230_DEV_AI_2D_ENGINE].size);
+
+    create_unimplemented_device("gsdma", memmap[K230_DEV_GSDMA].base,
+                                memmap[K230_DEV_GSDMA].size);
+
+    create_unimplemented_device("dma", memmap[K230_DEV_DMA].base,
+                                memmap[K230_DEV_DMA].size);
+
+    create_unimplemented_device("decomp-gzip",
+                                memmap[K230_DEV_DECOMP_GZIP].base,
+                                memmap[K230_DEV_DECOMP_GZIP].size);
+
+    create_unimplemented_device("2d-engine.non-ai",
+                                memmap[K230_DEV_NON_AI_2D].base,
+                                memmap[K230_DEV_NON_AI_2D].size);
+
+    create_unimplemented_device("isp", memmap[K230_DEV_ISP].base,
+                                memmap[K230_DEV_ISP].size);
+
+    create_unimplemented_device("dewarp", memmap[K230_DEV_DEWARP].base,
+                                memmap[K230_DEV_DEWARP].size);
+
+    create_unimplemented_device("rx-csi", memmap[K230_DEV_RX_CSI].base,
+                                memmap[K230_DEV_RX_CSI].size);
+
+    create_unimplemented_device("vpu", memmap[K230_DEV_H264].base,
+                                memmap[K230_DEV_H264].size);
+
+    create_unimplemented_device("gpu", memmap[K230_DEV_2P5D].base,
+                                memmap[K230_DEV_2P5D].size);
+
+    create_unimplemented_device("vo", memmap[K230_DEV_VO].base,
+                                memmap[K230_DEV_VO].size);
+
+    create_unimplemented_device("vo_cfg", memmap[K230_DEV_VO_CFG].base,
+                                memmap[K230_DEV_VO_CFG].size);
+
+    create_unimplemented_device("3d-engine", memmap[K230_DEV_3D_ENGINE].base,
+                                memmap[K230_DEV_3D_ENGINE].size);
+
+    create_unimplemented_device("pmu", memmap[K230_DEV_PMU].base,
+                                memmap[K230_DEV_PMU].size);
+
+    create_unimplemented_device("rtc", memmap[K230_DEV_RTC].base,
+                                memmap[K230_DEV_RTC].size);
+
+    create_unimplemented_device("cmu", memmap[K230_DEV_CMU].base,
+                                memmap[K230_DEV_CMU].size);
+
+    create_unimplemented_device("rmu", memmap[K230_DEV_RMU].base,
+                                memmap[K230_DEV_RMU].size);
+
+    create_unimplemented_device("boot", memmap[K230_DEV_BOOT].base,
+                                memmap[K230_DEV_BOOT].size);
+
+    create_unimplemented_device("pwr", memmap[K230_DEV_PWR].base,
+                                memmap[K230_DEV_PWR].size);
+
+    create_unimplemented_device("ipcm", memmap[K230_DEV_MAILBOX].base,
+                                memmap[K230_DEV_MAILBOX].size);
+
+    create_unimplemented_device("iomux", memmap[K230_DEV_IOMUX].base,
+                                memmap[K230_DEV_IOMUX].size);
+
+    create_unimplemented_device("timer", memmap[K230_DEV_TIMER].base,
+                                memmap[K230_DEV_TIMER].size);
+
+    create_unimplemented_device("wdt0", memmap[K230_DEV_WDT0].base,
+                                memmap[K230_DEV_WDT0].size);
+
+    create_unimplemented_device("wdt1", memmap[K230_DEV_WDT1].base,
+                                memmap[K230_DEV_WDT1].size);
+
+    create_unimplemented_device("ts", memmap[K230_DEV_TS].base,
+                                memmap[K230_DEV_TS].size);
+
+    create_unimplemented_device("hdi", memmap[K230_DEV_HDI].base,
+                                memmap[K230_DEV_HDI].size);
+
+    create_unimplemented_device("stc", memmap[K230_DEV_STC].base,
+                                memmap[K230_DEV_STC].size);
+
+    create_unimplemented_device("security", memmap[K230_DEV_SECURITY].base,
+                                memmap[K230_DEV_SECURITY].size);
+
+    create_unimplemented_device("i2c0", memmap[K230_DEV_I2C0].base,
+                                memmap[K230_DEV_I2C0].size);
+
+    create_unimplemented_device("i2c1", memmap[K230_DEV_I2C1].base,
+                                memmap[K230_DEV_I2C1].size);
+
+    create_unimplemented_device("i2c2", memmap[K230_DEV_I2C2].base,
+                                memmap[K230_DEV_I2C2].size);
+
+    create_unimplemented_device("i2c3", memmap[K230_DEV_I2C3].base,
+                                memmap[K230_DEV_I2C3].size);
+
+    create_unimplemented_device("i2c4", memmap[K230_DEV_I2C4].base,
+                                memmap[K230_DEV_I2C4].size);
+
+    create_unimplemented_device("pwm", memmap[K230_DEV_PWM].base,
+                                memmap[K230_DEV_PWM].size);
+
+    create_unimplemented_device("gpio0", memmap[K230_DEV_GPIO0].base,
+                                memmap[K230_DEV_GPIO0].size);
+
+    create_unimplemented_device("gpio1", memmap[K230_DEV_GPIO1].base,
+                                memmap[K230_DEV_GPIO1].size);
+
+    create_unimplemented_device("adc", memmap[K230_DEV_ADC].base,
+                                memmap[K230_DEV_ADC].size);
+
+    create_unimplemented_device("codec", memmap[K230_DEV_CODEC].base,
+                                memmap[K230_DEV_CODEC].size);
+
+    create_unimplemented_device("i2s", memmap[K230_DEV_I2S].base,
+                                memmap[K230_DEV_I2S].size);
+
+    create_unimplemented_device("usb0", memmap[K230_DEV_USB0].base,
+                                memmap[K230_DEV_USB0].size);
+
+    create_unimplemented_device("usb1", memmap[K230_DEV_USB1].base,
+                                memmap[K230_DEV_USB1].size);
+
+    create_unimplemented_device("sd0", memmap[K230_DEV_SD0].base,
+                                memmap[K230_DEV_SD0].size);
+
+    create_unimplemented_device("sd1", memmap[K230_DEV_SD1].base,
+                                memmap[K230_DEV_SD1].size);
+
+    create_unimplemented_device("qspi0", memmap[K230_DEV_QSPI0].base,
+                                memmap[K230_DEV_QSPI0].size);
+
+    create_unimplemented_device("qspi1", memmap[K230_DEV_QSPI1].base,
+                                memmap[K230_DEV_QSPI1].size);
+
+    create_unimplemented_device("spi", memmap[K230_DEV_SPI].base,
+                                memmap[K230_DEV_SPI].size);
+
+    create_unimplemented_device("hi_sys_cfg", memmap[K230_DEV_HI_SYS_CFG].base,
+                                memmap[K230_DEV_HI_SYS_CFG].size);
+
+    create_unimplemented_device("ddrc_cfg", memmap[K230_DEV_DDRC_CFG].base,
+                                memmap[K230_DEV_DDRC_CFG].size);
+
+    create_unimplemented_device("flash", memmap[K230_DEV_FLASH].base,
+                                memmap[K230_DEV_FLASH].size);
+}
+
+static void k230_soc_class_init(ObjectClass *oc, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->realize = k230_soc_realize;
+}
+
+static const TypeInfo k230_soc_type_info = {
+    .name = TYPE_RISCV_K230_SOC,
+    .parent = TYPE_DEVICE,
+    .instance_size = sizeof(K230SoCState),
+    .instance_init = k230_soc_init,
+    .class_init = k230_soc_class_init,
+};
+
+static void k230_soc_register_types(void)
+{
+    type_register_static(&k230_soc_type_info);
+}
+
+type_init(k230_soc_register_types)
+
+static void k230_direct_boot(K230MachineState *s, MachineState *machine)
+{
+    const char *firmware_name = riscv_default_firmware_name(&s->soc.c908_cpu);
+    RISCVBootInfo boot_info = {0};
+    hwaddr start_addr = K230_DIRECT_OPENSBI_ADDR;
+    hwaddr firmware_end_addr = 0;
+    hwaddr kernel_entry = 0;
+    int fdt_size = 0;
+
+    if (machine->firmware && !strcmp(machine->firmware, "none")) {
+        error_report("K230 direct boot requires OpenSBI firmware; omit "
+                     "-bios none or pass OpenSBI with -bios");
+        exit(EXIT_FAILURE);
+    }
+
+    if (!machine->dtb) {
+        error_report("K230 direct boot requires -dtb");
+        exit(EXIT_FAILURE);
+    }
+
+    machine->fdt = load_device_tree(machine->dtb, &fdt_size);
+    if (!machine->fdt) {
+        error_report("load_device_tree() failed");
+        exit(EXIT_FAILURE);
+    }
+
+    qemu_fdt_add_path(machine->fdt, "/chosen");
+
+    riscv_boot_info_init(&boot_info, &s->soc.c908_cpu);
+    riscv_load_kernel(machine, &boot_info, K230_DIRECT_KERNEL_ADDR, true, NULL);
+    kernel_entry = boot_info.image_low_addr;
+
+    riscv_load_fdt(K230_DIRECT_DTB_ADDR, machine->fdt);
+
+    firmware_end_addr = riscv_find_and_load_firmware(machine, firmware_name,
+                                                     &start_addr, NULL);
+    if (firmware_end_addr > K230_DIRECT_KERNEL_ADDR) {
+        error_report("K230 firmware overlaps kernel address 0x%x",
+                     K230_DIRECT_KERNEL_ADDR);
+        exit(EXIT_FAILURE);
+    }
+
+    riscv_setup_rom_reset_vec(machine, &s->soc.c908_cpu, start_addr,
+                              memmap[K230_DEV_BOOTROM].base,
+                              memmap[K230_DEV_BOOTROM].size, kernel_entry,
+                              K230_DIRECT_DTB_ADDR);
+}
+
+static void k230_firmware_boot(K230MachineState *s, MachineState *machine)
+{
+    const char *firmware_name = riscv_default_firmware_name(&s->soc.c908_cpu);
+    hwaddr start_addr = memmap[K230_DEV_DDRC].base;
+
+    if (machine->dtb || (machine->kernel_cmdline && *machine->kernel_cmdline)) {
+        error_report("K230 firmware boot does not support -dtb or -append");
+        exit(EXIT_FAILURE);
+    }
+
+    riscv_find_and_load_firmware(machine, firmware_name, &start_addr, NULL);
+
+    riscv_setup_rom_reset_vec(machine, &s->soc.c908_cpu, start_addr,
+                              memmap[K230_DEV_BOOTROM].base,
+                              memmap[K230_DEV_BOOTROM].size, 0, 0);
+}
+
+static void k230_machine_done(Notifier *notifier, void *data)
+{
+    K230MachineState *s = container_of(notifier, K230MachineState,
+                                       machine_done);
+    MachineState *machine = MACHINE(s);
+
+    if (machine->kernel_filename) {
+        k230_direct_boot(s, machine);
+    } else {
+        k230_firmware_boot(s, machine);
+    }
+}
+
+static void k230_machine_init(MachineState *machine)
+{
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
+    K230MachineState *s = RISCV_K230_MACHINE(machine);
+    MemoryRegion *sys_mem = get_system_memory();
+
+    if (machine->ram_size < mc->default_ram_size) {
+        char *sz = size_to_str(mc->default_ram_size);
+        error_report("Invalid RAM size, should be %s", sz);
+        g_free(sz);
+        exit(EXIT_FAILURE);
+    }
+
+    /* Initialize SoC */
+    object_initialize_child(OBJECT(machine), "soc", &s->soc,
+                            TYPE_RISCV_K230_SOC);
+    qdev_realize(DEVICE(&s->soc), NULL, &error_fatal);
+
+    /* Data Memory */
+    memory_region_add_subregion(sys_mem, memmap[K230_DEV_DDRC].base,
+                                machine->ram);
+
+    s->machine_done.notify = k230_machine_done;
+    qemu_add_machine_init_done_notifier(&s->machine_done);
+}
+
+static void k230_machine_instance_init(Object *obj)
+{
+}
+
+static void k230_machine_class_init(ObjectClass *oc, const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->desc = "RISC-V Board compatible with Kendryte K230 SDK";
+    mc->init = k230_machine_init;
+    mc->default_cpus = 1;
+    mc->default_ram_id = "riscv.K230.ram"; /* DDR */
+    mc->default_ram_size = memmap[K230_DEV_DDRC].size;
+}
+
+static const TypeInfo k230_machine_typeinfo = {
+    .name       = TYPE_RISCV_K230_MACHINE,
+    .parent     = TYPE_MACHINE,
+    .class_init = k230_machine_class_init,
+    .instance_init = k230_machine_instance_init,
+    .instance_size = sizeof(K230MachineState),
+    .interfaces = riscv64_machine_interfaces,
+};
+
+static void k230_machine_init_register_types(void)
+{
+    type_register_static(&k230_machine_typeinfo);
+}
+
+type_init(k230_machine_init_register_types)
diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index 533472e22a..09cf855984 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -14,8 +14,8 @@ riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files(
 	'riscv-iommu.c', 'riscv-iommu-pci.c', 'riscv-iommu-sys.c', 'riscv-iommu-hpm.c'))
 riscv_ss.add(when: 'CONFIG_MICROBLAZE_V', if_true: files('microblaze-v-generic.c'))
 riscv_ss.add(when: 'CONFIG_XIANGSHAN_KUNMINGHU', if_true: files('xiangshan_kmh.c'))
-
 riscv_ss.add(when: 'CONFIG_RISCV_MIPS_CPS', if_true: files('cps.c'))
 riscv_ss.add(when: 'CONFIG_MIPS_BOSTON_AIA', if_true: files('boston-aia.c'))
+riscv_ss.add(when: 'CONFIG_K230', if_true: files('k230.c'))
 
 hw_arch += {'riscv': riscv_ss}
diff --git a/include/hw/riscv/k230.h b/include/hw/riscv/k230.h
new file mode 100644
index 0000000000..dcfde39096
--- /dev/null
+++ b/include/hw/riscv/k230.h
@@ -0,0 +1,145 @@
+/*
+ * QEMU RISC-V Virt Board Compatible with kendryte K230 SDK
+ *
+ * Copyright (c) 2025 Chao Liu <chao.liu.zevorn@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Provides a board compatible with the kendryte K230 SDK
+ *
+ * K230 Technical Reference Manual V0.3.1 (2024-11-18):
+ * https://github.com/revyos/external-docs/blob/master/K230/en-us/K230_Technical_Reference_Manual_V0.3.1_20241118.pdf
+ *
+ * For more information, see <https://www.kendryte.com/en/proDetail/230>
+ */
+#ifndef HW_K230_H
+#define HW_K230_H
+
+#include "hw/core/boards.h"
+#include "hw/riscv/riscv_hart.h"
+
+#define C908_CPU_HARTID   (0)
+
+#define TYPE_RISCV_K230_SOC "riscv.k230.soc"
+#define RISCV_K230_SOC(obj) \
+    OBJECT_CHECK(K230SoCState, (obj), TYPE_RISCV_K230_SOC)
+
+typedef struct K230SoCState {
+    /*< private >*/
+    DeviceState parent_obj;
+
+    /*< public >*/
+    RISCVHartArrayState c908_cpu; /* Small core */
+
+    MemoryRegion sram;
+    MemoryRegion bootrom;
+
+    DeviceState *c908_plic;
+} K230SoCState;
+
+#define TYPE_RISCV_K230_MACHINE MACHINE_TYPE_NAME("k230")
+#define RISCV_K230_MACHINE(obj) \
+    OBJECT_CHECK(K230MachineState, (obj), TYPE_RISCV_K230_MACHINE)
+
+typedef struct K230MachineState {
+    /*< private >*/
+    MachineState parent_obj;
+
+    /*< public >*/
+    K230SoCState soc;
+    Notifier machine_done;
+} K230MachineState;
+
+enum {
+    K230_DEV_DDRC,
+    K230_DEV_KPU_L2_CACHE,
+    K230_DEV_SRAM,
+    K230_DEV_KPU_CFG,
+    K230_DEV_FFT,
+    K230_DEV_AI_2D_ENGINE,
+    K230_DEV_GSDMA,
+    K230_DEV_DMA,
+    K230_DEV_DECOMP_GZIP,
+    K230_DEV_NON_AI_2D,
+    K230_DEV_ISP,
+    K230_DEV_DEWARP,
+    K230_DEV_RX_CSI,
+    K230_DEV_H264,
+    K230_DEV_2P5D,
+    K230_DEV_VO,
+    K230_DEV_VO_CFG,
+    K230_DEV_3D_ENGINE,
+    K230_DEV_PMU,
+    K230_DEV_RTC,
+    K230_DEV_CMU,
+    K230_DEV_RMU,
+    K230_DEV_BOOT,
+    K230_DEV_PWR,
+    K230_DEV_MAILBOX,
+    K230_DEV_IOMUX,
+    K230_DEV_TIMER,
+    K230_DEV_WDT0,
+    K230_DEV_WDT1,
+    K230_DEV_TS,
+    K230_DEV_HDI,
+    K230_DEV_STC,
+    K230_DEV_BOOTROM,
+    K230_DEV_SECURITY,
+    K230_DEV_UART0,
+    K230_DEV_UART1,
+    K230_DEV_UART2,
+    K230_DEV_UART3,
+    K230_DEV_UART4,
+    K230_DEV_I2C0,
+    K230_DEV_I2C1,
+    K230_DEV_I2C2,
+    K230_DEV_I2C3,
+    K230_DEV_I2C4,
+    K230_DEV_PWM,
+    K230_DEV_GPIO0,
+    K230_DEV_GPIO1,
+    K230_DEV_ADC,
+    K230_DEV_CODEC,
+    K230_DEV_I2S,
+    K230_DEV_USB0,
+    K230_DEV_USB1,
+    K230_DEV_SD0,
+    K230_DEV_SD1,
+    K230_DEV_QSPI0,
+    K230_DEV_QSPI1,
+    K230_DEV_SPI,
+    K230_DEV_HI_SYS_CFG,
+    K230_DEV_DDRC_CFG,
+    K230_DEV_FLASH,
+    K230_DEV_PLIC,
+    K230_DEV_CLINT,
+};
+
+enum {
+    /*
+     * K230 TRM v0.3.1 section 2.4 lists peripheral interrupt bits; SDK
+     * DTBs expose the corresponding PLIC IDs as bit + 16.
+     */
+    K230_UART0_IRQ  = 16,
+    K230_UART1_IRQ  = 17,
+    K230_UART2_IRQ  = 18,
+    K230_UART3_IRQ  = 19,
+    K230_UART4_IRQ  = 20,
+};
+
+#define K230_UART_COUNT 5
+
+/*
+ * Integrates with the interrupt controller (PLIC),
+ * which can process 208 interrupt external sources
+ */
+#define K230_PLIC_NUM_SOURCES 208
+#define K230_PLIC_NUM_PRIORITIES 7
+#define K230_PLIC_PRIORITY_BASE 0x00
+#define K230_PLIC_PENDING_BASE 0x1000
+#define K230_PLIC_ENABLE_BASE 0x2000
+#define K230_PLIC_ENABLE_STRIDE 0x80
+#define K230_PLIC_CONTEXT_BASE 0x200000
+#define K230_PLIC_CONTEXT_STRIDE 0x1000
+
+#endif
-- 
2.54.0


