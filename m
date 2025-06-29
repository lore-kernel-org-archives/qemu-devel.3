Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D328C7EE30
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Jun 2025 13:55:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uVsUQ-0006XJ-60; Sun, 29 Jun 2025 09:54:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tan@siewert.io>)
 id 1uVsUO-0006X4-9n; Sun, 29 Jun 2025 09:54:36 -0400
Received: from
 mail-germanywestcentralazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c20c::1] helo=FR6P281CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tan@siewert.io>)
 id 1uVsUM-0002d5-6w; Sun, 29 Jun 2025 09:54:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vXB1pZG+BUeccXpsl3I2WKUzfEPf1UHx8eA6O8BWLyrhbEmfsQjnp00+MHnARqklgs9tEBeoeRTbeb8j8PciK9J9eay72/yvXcSs9Nw2d3ZA8ucAgoHMmrqkRzLhXaKJSO6lxPa6NNgyRKqt2MI12pECgfIHI8OA6OPgSzSP4xthyXqRFC9DYW3Qg/Enm4HUhT5wOn6c2xcnObFQ9TCnx7hoDRfTzsyT/NxTIreZvZEEmcKFY0NO3Kg5kkp0z1FjYKno9wFLSETo23Zlr7Kh6P0YatJ2EGfXTG0gi++aZt/11eal8PIgHlQlebYTlb8xCCKzNFHcUYZqxeWPEVt8VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dn7yRGkj3e8xZIBoPowL/Eq/VXIPntvu+PBifbE5PGM=;
 b=sHnDDsl+pdELxLopXBanGTMwxLA8oYGNF6F+YOo68210Lttn+HlaflmjZ+P1KPnMAfEFHBWjJwFa1UNB04msc6pL5wWXlNZA3kidsyFR6kLnbMDSCnZIoDEntUal1C/sg5t8FAcw18GZ4xCnhepSsUv4NPVUkYm24MYyEBxf2diaAfn1JnY83I24wdcUgKJUuhpBFDC0HYEQtOSyDXnxflXqrb7+xXC3G+6dJnOwzPgaWIF+YgBoiHdfwg5LTJ1dR8oWt6swuiyNyzuDJZOelTK7F3gtVkSO5xKVRd1DtocVe3Kr42cZrrNOtYOf66FFg1rPttc5efSgWAr8SiBYpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siewert.io; dmarc=pass action=none header.from=siewert.io;
 dkim=pass header.d=siewert.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siewert.io;
Received: from BE1PPF7DB70B163.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b18::65f)
 by FR6P281MB4223.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:12b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Sun, 29 Jun
 2025 13:54:28 +0000
Received: from BE1PPF7DB70B163.DEUP281.PROD.OUTLOOK.COM
 ([fe80::5c4:893c:2523:a442]) by BE1PPF7DB70B163.DEUP281.PROD.OUTLOOK.COM
 ([fe80::5c4:893c:2523:a442%3]) with mapi id 15.20.8880.021; Sun, 29 Jun 2025
 13:54:27 +0000
From: Tan Siewert <tan@siewert.io>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Tan Siewert <tan@siewert.io>
Subject: [PATCH] tests/qtest: Add test for ASPEED SCU
Date: Sun, 29 Jun 2025 15:54:03 +0200
Message-ID: <20250629135405.73117-1-tan@siewert.io>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0153.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::20) To BE1PPF7DB70B163.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b18::65f)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1PPF7DB70B163:EE_|FR6P281MB4223:EE_
X-MS-Office365-Filtering-Correlation-Id: e55d5f26-71a6-4056-bfaa-08ddb71476d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|1800799024|376014|7416014|10070799003|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mC9CXf9CXXxv/hHc+BzObv6PkuY9pnGCKsx92kYd1PbPS+kDWQBK4Q40fdXR?=
 =?us-ascii?Q?wjyBERnHMq5D7ReKhQfkcYI6XzDFZrOpQ5YUe0J9Ww38HO8Gc6MlDzOHA5n6?=
 =?us-ascii?Q?zku2cwX8g9KMwdJFxDTfawN3Juy0DTO77Mx/zIyLgDXQ+fzcxpHjAhFJn9dH?=
 =?us-ascii?Q?jHVubK3+H2/KZcP5/TeaA5741QHlKY7JXs9/G2WN8N3e7u4Qp7UABfHntZen?=
 =?us-ascii?Q?58D8b/zqAwDNNr9kmUO4jzVRRd85KcalCFeJeSpJXPMvNeWotm3zoX38QtGc?=
 =?us-ascii?Q?R6rmxeE4E33fbvEWN5tyZpB7ItjEAfCAvHtxN8JV4sKStYj9bvwM6QVwf4wU?=
 =?us-ascii?Q?DRdc8HnOSJaOEg/QcJvrrmrs70KIjNIUEzMuxUPVhEslNB8eYlfiS7zJSlyf?=
 =?us-ascii?Q?+gIWitOb/jY5RvwLWTNP+DlvsdF9VZbdq66lDVUHpr/OdI9s+giCBME6b0KL?=
 =?us-ascii?Q?qiE+0c+G+NP3qtT8+uQ5M8vTOsZf3eklCUkm5Pd4j74m8CvOTKn6UMKdCgVb?=
 =?us-ascii?Q?LQ68xPicfdYWWj024lz2dyFROaL5FTOYZhaWMc5umLDN40s95Fg0OfQiQYn8?=
 =?us-ascii?Q?/qlHHrI2uabIaoooqwFy7HTqxUoPD74qdDZ3xQwgqeIkGXKQx4Cvk7v8qVOR?=
 =?us-ascii?Q?7WoVFGYM5TdHU0GDDluQ3sf/SENHEZ1I5ZVS1QASD7uFLcooThVvyE02aU/c?=
 =?us-ascii?Q?eLteOjmj7xrFOr5oiznJfHk6I6TABOw/9CkdZzW3BV1gzbI1TxF6ZdgSu/zy?=
 =?us-ascii?Q?4nmO94acJeUSakijZBkl50XNCp545KvDiNm5Yjmr+cyhbxECK0R89SURWOMf?=
 =?us-ascii?Q?6uNFTYePFAjc6oyDG1nrYffYJUkAk6GhqWHnfpISLtW00JVnfUvXAo2pzq+P?=
 =?us-ascii?Q?uHx+QIR0AyCpDlpTd15icUt1Fuoxcefr7hqufYiKV8K0Wn/xE2jb7MmFmsnM?=
 =?us-ascii?Q?cjTbWFezLpnZzgbSETYMwmWrVKuS2fCu4niCiFojjuGYv/uLzFT1X2moYzis?=
 =?us-ascii?Q?VjKkKSkm8PGbMQkbuMEcsiaXhKYDdTO+1OQsS/BLkHGlUFpeyDwdDkzqaKBn?=
 =?us-ascii?Q?GemkDvGBAjXzP2IaRkgMwk1+Iy9C7P3AxFptqy2QqjQ+Fst5rsWgu/AlsI+k?=
 =?us-ascii?Q?PCjyTVwiDkYBPqa92G4pj52J5wlGiWroyMAQ9NeN+4pOB9ZwZuGSj1solOfV?=
 =?us-ascii?Q?5Sa22buFE2ahZ+sreKPbo6c/JY26oDwnVX5yXlDLBZgM5/61YIX6kLC4sgrX?=
 =?us-ascii?Q?AOQrkIrdrrDpPwQ7fpxg/9KwyZwMU1gzHrqWP9em5KH/7aQORiMn/H5L9/Lm?=
 =?us-ascii?Q?8UllubZoRKZXf8fO5Hoe0aVntZH1UZmCuNzGWNVaGoNYFlDaSmMLx6+zTJ3m?=
 =?us-ascii?Q?jKYdCDTYdxcU4cJamQwiWEfhl5P+O3eOr/sbnyfIlvvkK8KLgE429ZiaQV4i?=
 =?us-ascii?Q?9UqpBxii464iBlUOCbbUZqNkDK4/o+XpG4GIUm9bXs6HEj0y1Cdk2g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BE1PPF7DB70B163.DEUP281.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(1800799024)(376014)(7416014)(10070799003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qeaMyzsyLjNWlARBEP4urfUcFTi4/2fa9lx9bjT+qPjQ0iYbRsHnDB3A0WXx?=
 =?us-ascii?Q?c6EL2Le+kqkEC6rRYsi5LOsR/FCOs3FcQtdwxDn9URqYXyzHkzVvTXNQbI1G?=
 =?us-ascii?Q?xk0YT+ywrBJg9uVT/ZPMO8dFRF/j8ZM+HP4vygkJSakgb+WfNNUMLFtQZskx?=
 =?us-ascii?Q?4vaYiJhqoMkCYkGUBLUbBD2g1jMHbDLz8kp7wmDPDlEpvZ1UK8pcYSSp9wh2?=
 =?us-ascii?Q?X+GWxdGTjSnImmcQLtBb3UGeNJDTk6jHKi316uYwFDS5OrcuqOg75PfzpcU9?=
 =?us-ascii?Q?D+Ya2qGZODwLSQR6mNzmkbWDuxaVD3iniGBvhJZQUnNTR22Pj3eq1wtnr8Dj?=
 =?us-ascii?Q?OJykXwlq3Bo3jDoB7qsfi7w8rz4xHEJwN6eib2bRoLPZawC4/JnGFW6K3ahg?=
 =?us-ascii?Q?8OUeehTxlsIcZERuskkWr+RETzpw0h4f9jTGmsapkZh4hjinQucBxoNGm2+Y?=
 =?us-ascii?Q?fedgdEdwuTSFSLPbMMJcUnNhtNcd507limE/mwYPP1tBYbTbWWxhsY9wqg5a?=
 =?us-ascii?Q?3Wd6J4OAhLXQr68yypyirTnrwg+gEDRbsOASKiRTk4H1hqF348DpGdMhbomP?=
 =?us-ascii?Q?hTeu7cAYMrxi0bKHvZZZJ/U9kLBmR/b4MSfNqpOZSsBqArWcbhjXowtaMUD+?=
 =?us-ascii?Q?LMx2TbW5fxS3DWt9J0s1Gevpb5sHuZIRDMaEhNiiEHup4v1X78zLcFjoHMRx?=
 =?us-ascii?Q?7AKopmiGKNIdNFMwAVkBuEkprQExuUM4p9vN/RVjn4tzX4GbJxXcFmxCzP0r?=
 =?us-ascii?Q?o/1sUpstsCErUI036B3OMGUH91v4Mz9m5/xyn62aaTEW0Ml/VmfYmVLvTvQW?=
 =?us-ascii?Q?8/lIU4lFhn5RV3myVaP8JH5C8QyMX11Mhn4GRoMCl6woxEVN4lOD83drK7ss?=
 =?us-ascii?Q?/WUWmu0dD3+YieZ3PVr0VOxL3WYV7A0XDsZrOiY0CPU/B3KhCpT5xMAopEVX?=
 =?us-ascii?Q?cWCFIagQvbRTvuaLTcHc9UtmMwC6UFGV0mF1BJVxouuYVSwj3enlfbdSIP4Y?=
 =?us-ascii?Q?n3ty10P3NzYuQ3jwT7XtK1CdVP5sUnFQdwjqYnXGBodyUeVR9ViiXfR9S2JM?=
 =?us-ascii?Q?W/w1PXcV/wkKDAJg6/um7HAtcZ04EpTkEyEPWHh2IC+G7mViy9XWaQdm0ZSW?=
 =?us-ascii?Q?PI4IwSFmKa7oxr2KGb51ePsncczjh56/2mutQD0a5uU8Vn+uMFe08d+M3IIq?=
 =?us-ascii?Q?Ou0mLWoR4inH42XFSqGWvbbkbSlG28S8+N3Nd8d1W6CWsjbafgRb+d/Y4mte?=
 =?us-ascii?Q?EPIHRD8XhlqoqewaTNC0G2BOAqSxx+7M9SYkbqCde+dMG/y6ZeJymR+8RAjO?=
 =?us-ascii?Q?8PtxcJkS4IX72JWCbbILZFF/1F20T54ICsDmBbdH6Bxv8XGjiuVXSe1MBUfi?=
 =?us-ascii?Q?7Vig1B01K0qrOmvwTaG8wW/30vu/R74zz4KVsZ8u3svbu8AFAORN0uP7/Mm+?=
 =?us-ascii?Q?BlIYRRu4d0z9NEnjP637Sx5yj7OfFVmSXiPzGcTYqIPN+nQ14XvpQTLZMIUn?=
 =?us-ascii?Q?1gl4Q19txPkELjNF2/V40SqFDPjBXZ3iX3cdjahiHrl9n5bRL7R8M5Y3OKSy?=
 =?us-ascii?Q?3EKCUwbSUSU+UQKsa5+FV7ucvPPp1s6rR51VM0dRB/3fT/cFOt3QxaVfYLtu?=
 =?us-ascii?Q?rXYW0p+T19oRtrml11PdGoA=3D?=
X-OriginatorOrg: siewert.io
X-MS-Exchange-CrossTenant-Network-Message-Id: e55d5f26-71a6-4056-bfaa-08ddb71476d0
X-MS-Exchange-CrossTenant-AuthSource: BE1PPF7DB70B163.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2025 13:54:27.8630 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e8b4abbe-444b-4835-b8fd-87ac97451a7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YlSJ0LaxzbBylhCXPPlMVZlS7ueU5uslPORIreQ6jaicbrA5nYHuzX3NYIz9luxC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR6P281MB4223
Received-SPF: pass client-ip=2a01:111:f403:c20c::1;
 envelope-from=tan@siewert.io;
 helo=FR6P281CU001.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This adds basic tests for the ASPEED System Control Unit (SCU) and its
protection mechanism on the AST2500 and AST2600 platforms.

The tests verify:
  - That SCU protection registers can be unlocked and locked again
  - That modifying the primary protection register on AST2600 also
    affects the secondary one
  - That writes to protected SCU registers are blocked unless
    protection registers are unlocked explicitly

These tests ensure proper emulation of hardware locking behaviour
and help catch regressions in SCU access logic.

Signed-off-by: Tan Siewert <tan@siewert.io>
---
 tests/qtest/aspeed-scu-utils.c |  22 ++++
 tests/qtest/aspeed-scu-utils.h |  38 +++++++
 tests/qtest/aspeed_scu-test.c  | 197 +++++++++++++++++++++++++++++++++
 tests/qtest/meson.build        |   4 +-
 4 files changed, 260 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/aspeed-scu-utils.c
 create mode 100644 tests/qtest/aspeed-scu-utils.h
 create mode 100644 tests/qtest/aspeed_scu-test.c

diff --git a/tests/qtest/aspeed-scu-utils.c b/tests/qtest/aspeed-scu-utils.c
new file mode 100644
index 0000000000..9083827b98
--- /dev/null
+++ b/tests/qtest/aspeed-scu-utils.c
@@ -0,0 +1,22 @@
+/*
+ * QTest testcase for the ASPEED AST2500 and AST2600 SCU.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Copyright (C) 2025 Tan Siewert
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest-single.h"
+#include "aspeed-scu-utils.h"
+
+void assert_register_eq(QTestState *s, uint32_t reg, uint32_t expected)
+{
+    uint32_t value = qtest_readl(s, reg);
+    g_assert_cmphex(value, ==, expected);
+}
+
+void assert_register_neq(QTestState *s, uint32_t reg, uint32_t not_expected)
+{
+    uint32_t value = qtest_readl(s, reg);
+    g_assert_cmphex(value, !=, not_expected);
+}
diff --git a/tests/qtest/aspeed-scu-utils.h b/tests/qtest/aspeed-scu-utils.h
new file mode 100644
index 0000000000..9cc7e3e113
--- /dev/null
+++ b/tests/qtest/aspeed-scu-utils.h
@@ -0,0 +1,38 @@
+/*
+ * QTest testcase for the ASPEED AST2500 and AST2600 SCU.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Copyright (C) 2025 Tan Siewert
+ */
+
+#ifndef TESTS_ASPEED_SCU_UTILS_H
+#define TESTS_ASPEED_SCU_UTILS_H
+
+#include "qemu/osdep.h"
+#include "libqtest-single.h"
+
+/**
+ * Assert that a given register matches an expected value.
+ *
+ * Reads the register and checks if its value equals the expected value,
+ * without requiring a temporary variable in the caller.
+ *
+ * @param *s - QTest machine state
+ * @param reg - Address of the register to be checked
+ * @param expected - Expected register value
+ */
+void assert_register_eq(QTestState *s, uint32_t reg, uint32_t expected);
+
+/**
+ * Assert that a given register does not match a specific value.
+ *
+ * Reads the register and checks that its value is not equal to the
+ * provided value.
+ *
+ * @param *s - QTest machine state
+ * @param reg - Address of the register to be checked
+ * @param not_expected - Value the register must not contain
+ */
+void assert_register_neq(QTestState *s, uint32_t reg, uint32_t not_expected);
+
+#endif /* TESTS_ASPEED_SCU_UTILS_H */
diff --git a/tests/qtest/aspeed_scu-test.c b/tests/qtest/aspeed_scu-test.c
new file mode 100644
index 0000000000..75d6a800a6
--- /dev/null
+++ b/tests/qtest/aspeed_scu-test.c
@@ -0,0 +1,197 @@
+/*
+ * QTest testcase for the ASPEED AST2500 and AST2600 SCU.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Copyright (C) 2025 Tan Siewert
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest-single.h"
+#include "aspeed-scu-utils.h"
+
+/*
+ * SCU base, as well as protection key are
+ * the same on AST2500 and 2600.
+ */
+#define AST_SCU_BASE                    0x1E6E2000
+#define AST_SCU_PROT_LOCK_STATE         0x0
+#define AST_SCU_PROT_LOCK_VALUE         0x2
+#define AST_SCU_PROT_UNLOCK_STATE       0x1
+#define AST_SCU_PROT_UNLOCK_VALUE       0x1688A8A8
+
+#define AST2500_MACHINE                 "-machine ast2500-evb"
+#define AST2500_SCU_PROT_REG            0x00
+#define AST2500_SCU_MISC_2_CONTROL_REG  0x4C
+
+#define AST2600_MACHINE                 "-machine ast2600-evb"
+/* AST2600 has two protection registers */
+#define AST2600_SCU_PROT_REG            0x000
+#define AST2600_SCU_PROT_REG2           0x010
+#define AST2600_SCU_MISC_2_CONTROL_REG  0x0C4
+
+#define TEST_LOCK_ARBITRARY_VALUE       0xABCDEFAB
+
+/**
+ * Test whether the SCU can be locked and unlocked correctly.
+ *
+ * When testing multiple registers, this function assumes that writing
+ * to the first register also affects the others. However, writing to
+ * any other register only affects itself.
+ *
+ * @param *machine - input machine configuration, passed directly
+ *                   to QTest
+ * @param regs[] - List of registers to be checked
+ * @param regc - amount of arguments for registers to be checked
+ */
+static void test_protection_register(const char *machine,
+                                     const uint32_t regs[],
+                                     const int regc)
+{
+    QTestState *s = qtest_init(machine);
+
+    for (int i = 0; i < regc; i++) {
+        uint32_t reg = regs[i];
+
+        qtest_writel(s, reg, AST_SCU_PROT_UNLOCK_VALUE);
+        assert_register_eq(s, reg, AST_SCU_PROT_UNLOCK_STATE);
+
+        /**
+         * Check that other registers are unlocked too, if more
+         * than one is available.
+         */
+        if (regc > 1 && i == 0) {
+            /* Initialise at 1 instead of 0 to skip first */
+            for (int j = 1; j < regc; j++) {
+                uint32_t add_reg = regs[j];
+                assert_register_eq(s, add_reg, AST_SCU_PROT_UNLOCK_STATE);
+            }
+        }
+
+        /* Lock the register again */
+        qtest_writel(s, reg, AST_SCU_PROT_LOCK_VALUE);
+        assert_register_eq(s, reg, AST_SCU_PROT_LOCK_STATE);
+
+        /* And the same for locked state */
+        if (regc > 1 && i == 0) {
+            /* Initialise at 1 instead of 0 to skip first */
+            for (int j = 1; j < regc; j++) {
+                uint32_t add_reg = regs[j];
+                assert_register_eq(s, add_reg, AST_SCU_PROT_LOCK_STATE);
+            }
+        }
+    }
+
+    qtest_quit(s);
+}
+
+static void test_2500_protection_register(void)
+{
+    uint32_t regs[] = { AST_SCU_BASE + AST2500_SCU_PROT_REG };
+
+    test_protection_register(AST2500_MACHINE,
+                             regs,
+                             ARRAY_SIZE(regs));
+}
+
+static void test_2600_protection_register(void)
+{
+    /**
+     * The AST2600 has two protection registers, both
+     * being required to be unlocked to do any operation.
+     *
+     * Modifying SCU000 also modifies SCU010, but modifying
+     * SCU010 only will keep SCU000 untouched.
+     */
+    uint32_t regs[] = { AST_SCU_BASE + AST2600_SCU_PROT_REG,
+                        AST_SCU_BASE + AST2600_SCU_PROT_REG2 };
+
+    test_protection_register(AST2600_MACHINE,
+                             regs,
+                             ARRAY_SIZE(regs));
+}
+
+/**
+ * Test if SCU register writes are correctly allowed or blocked
+ * depending on the protection register state.
+ *
+ * The test first locks the protection register and verifies that
+ * writes to the target SCU register are rejected. It then unlocks
+ * the protection register and confirms that the written value is
+ * retained when unlocked.
+ *
+ * @param *machine - input machine configuration, passed directly
+ *                   to QTest
+ * @param protection_register - first SCU protection key register
+ *                              (only one for keeping it simple)
+ * @param test_register - Register to be used for writing arbitrary
+ *                        values
+ */
+static void test_write_permission_lock_state(const char *machine,
+                                             const uint32_t protection_register,
+                                             const uint32_t test_register)
+{
+    QTestState *s = qtest_init(machine);
+
+    /* Arbitrary value to lock provided SCU protection register */
+    qtest_writel(s, protection_register, AST_SCU_PROT_LOCK_VALUE);
+
+    /* Ensure that the SCU is really locked */
+    assert_register_eq(s, protection_register, AST_SCU_PROT_LOCK_STATE);
+
+    /* Write a known arbitrary value to test that the write is blocked */
+    qtest_writel(s, test_register, TEST_LOCK_ARBITRARY_VALUE);
+
+    /* We do not want to have the written value to be saved */
+    assert_register_neq(s, test_register, TEST_LOCK_ARBITRARY_VALUE);
+
+    /**
+     * Unlock the SCU and verify that it can be written to.
+     * Assumes that the first SCU protection register is sufficient to
+     * unlock all protection registers, if multiple are present.
+     */
+    qtest_writel(s, protection_register, AST_SCU_PROT_UNLOCK_VALUE);
+    assert_register_eq(s, protection_register, AST_SCU_PROT_UNLOCK_STATE);
+
+    /* Write a known arbitrary value to test that the write works */
+    qtest_writel(s, test_register, TEST_LOCK_ARBITRARY_VALUE);
+
+    /* Ensure that the written value is retained */
+    assert_register_eq(s, test_register, TEST_LOCK_ARBITRARY_VALUE);
+
+    qtest_quit(s);
+}
+
+static void test_2500_write_permission_lock_state(void)
+{
+    test_write_permission_lock_state(
+            AST2500_MACHINE,
+            AST_SCU_BASE + AST2500_SCU_PROT_REG,
+            AST_SCU_BASE + AST2500_SCU_MISC_2_CONTROL_REG
+    );
+}
+
+static void test_2600_write_permission_lock_state(void)
+{
+    test_write_permission_lock_state(
+            AST2600_MACHINE,
+            AST_SCU_BASE + AST2600_SCU_PROT_REG,
+            AST_SCU_BASE + AST2600_SCU_MISC_2_CONTROL_REG
+    );
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/ast2500/scu/protection_register",
+                   test_2500_protection_register);
+    qtest_add_func("/ast2600/scu/protection_register",
+                   test_2600_protection_register);
+
+    qtest_add_func("/ast2500/scu/write_permission_lock_state",
+                   test_2500_write_permission_lock_state);
+    qtest_add_func("/ast2600/scu/write_permission_lock_state",
+                   test_2600_write_permission_lock_state);
+
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 8ad849054f..7713fae885 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -215,7 +215,8 @@ qtests_npcm8xx = \
 qtests_aspeed = \
   ['aspeed_gpio-test',
    'aspeed_hace-test',
-   'aspeed_smc-test']
+   'aspeed_smc-test',
+   'aspeed_scu-test']
 qtests_aspeed64 = \
   ['ast2700-gpio-test',
    'ast2700-hace-test',
@@ -366,6 +367,7 @@ endif
 qtests = {
   'aspeed_hace-test': files('aspeed-hace-utils.c', 'aspeed_hace-test.c'),
   'aspeed_smc-test': files('aspeed-smc-utils.c', 'aspeed_smc-test.c'),
+  'aspeed_scu-test': files('aspeed-scu-utils.c', 'aspeed_scu-test.c'),
   'ast2700-hace-test': files('aspeed-hace-utils.c', 'ast2700-hace-test.c'),
   'ast2700-smc-test': files('aspeed-smc-utils.c', 'ast2700-smc-test.c'),
   'bios-tables-test': [io, 'boot-sector.c', 'acpi-utils.c', 'tpm-emu.c'],
-- 
2.49.0


