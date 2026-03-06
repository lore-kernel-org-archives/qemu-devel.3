Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3071FF0182F
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 12:21:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyUAb-0000Br-Bd; Fri, 06 Mar 2026 07:20:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1vyUAU-0000Ai-E0
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 07:20:35 -0500
Received: from mail-westusazon11020127.outbound.protection.outlook.com
 ([52.101.85.127] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1vyUAS-0000gD-05
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 07:20:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NI24q1oLU6IOCqZu108BbaSAuqwlHADCjXG9ubAwHebeTivNHxxuALXr24DhmIg+qJlsY/3euQpiW3vmRzMxGXJv3RidmIJ7PUao0otZHsxy+sHQu8mCs2ZM06mmhEYmo4normgx06ut3/kR5JNwrY3k+OHumfWybUMnZ0uNwHZR6eodDLj9xiRps9FdOYV+9RZuhqtLPCG+SUj++DVWzTiAFB/5G+3FGG0IA3Q43wHbeWHCDElI0A4j3g3jDOGkVoNJ7jBCL1olu7XvjYEdzHyfCuMy+oFiBPMjQTPd9dkI873b83gCWtYYakTQdPTUUmpJTF5QY5UjjnPpxQvG+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iv/6lhr0aDU0UYnEjhHhx5koSgVgigHXltmbsBKWSfo=;
 b=amCqEChIGNzl8PDrQFrPJDQoZ98uSulBJYcGJuh40ZA7wGxwZOD8wbAADVUNW1huAAirYJ71BD1HT7hZlccmXkD9/vdLgAy4aefnvmSgBmKMqCyqoC/+oSHCb6HQIJKBkhk8S+YBr4F/qcMUEiUxi3avt3X5566uH/mJxlBzItexRT7Hn8S8WePdgGnmKsCftLATCPPTG3PgQsVo4GmVD9nrodycwA5x/eUU+Im0oUGamlF1vQetcedHTK3Cllp6RDEy8pgUPNIl9kWHQBpJCneSTMWCxrlCPvTtyRg9BDc/7x+fJytW1/MOSsa7GQx8CZrYesXTaR5MGJbHSsHFjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iv/6lhr0aDU0UYnEjhHhx5koSgVgigHXltmbsBKWSfo=;
 b=HY23xkR5QLAbJIVvJL0hNZcYUnjlu8yHL+Sq+aOerbq2fB2tcda4A1B8bGlD+8eUtBVXVx8FhL00LiQ5Ok9RDSi84PGWu89RMmpT8svXmhrKi7B/6k81zJCHm2m+Tvx5BFaiO6YCR+gr+L+MaP4SoPYd0H1xW4c8Ti60zMC7nFGRG87FnM/5YZ5xliDGUIeETBsafMq/RAbB1wyvjaSvo/Hvccx51TozCzaH2Q0xlL+GGrK4hy+b+RfyjArFnBgXgmJDKmI6v230+ooJEt5m7mLYKXdRfLNcDxFg4KC+ZgdxmkbsuFlw4u0VYnNns8PNT6qIKbYzk5hCG9wjKMte5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com (2603:10b6:a03:37f::19)
 by IA2PR18MB5977.namprd18.prod.outlook.com (2603:10b6:208:4ba::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Fri, 6 Mar
 2026 12:15:27 +0000
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba]) by SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba%3]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 12:15:27 +0000
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: qemu-devel@nongnu.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v1 1/2] hw/arm: Add Axiado SoC AX3000
Date: Fri,  6 Mar 2026 04:15:10 -0800
Message-Id: <20260306121511.1781020-2-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260306121511.1781020-1-kchiu@axiado.com>
References: <20260306121511.1781020-1-kchiu@axiado.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH5P222CA0007.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:34b::13) To SJ0PR18MB4479.namprd18.prod.outlook.com
 (2603:10b6:a03:37f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR18MB4479:EE_|IA2PR18MB5977:EE_
X-MS-Office365-Filtering-Correlation-Id: c6b6d4f9-5953-4661-23f8-08de7b7a0d0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014|13003099007; 
X-Microsoft-Antispam-Message-Info: +iS3WC8fq5SgLbOinzQwiIpeyiLm0kZNOVihgI84a2MQKV7z9kzoZgHZv4YnAy/dG49ua98gaTlayBcnF9bO4GdmDl2ZsMGn8jCGghYd5AjU0PDH+2HHl2QaO0hMH9UU0bg7lzW3p1rU22rYk2p1yNXR80DBvvcYrA09+oX9jCP1/k4RV/mFHOui+21rsItAIapAdFZeTGX7+DhWHnfbyvMDZTKduo5VJpzTNPyd1QzX3ZTvW48wBvmlaep70R5IPHkl9/ORrO1J6kPM8mfS6PZncZtgQ4WgKsrxuXrUQoMs5qijjBTQNI2KmMpy1PfigpdApT5zSzwcyY6bOe/VQT5qS6I2OCaaM+Kj6SMTmquA8pqMoU2mou/mR3+DkLZRhRQhIpRhVbVOjhVx3Clz3VxlEu1LNCtdQYRt3bm8JiMPbf9qJMEYwHGDuDQ/umMY/wde6SLNyydrJZ8ErvC9JWG+PsJPUkVkp7aT2rJc3p4KUa20eu1rwA+DVyU/fYFLyjM/FfvTEoyWLgTB5t7ctjbNcwrdPgLFbvpqF6e7eN/gCJJ86kcMgZXgWvbpY9JohGwymQYd2e6xRd5rslKZFBxKlNeN/Ule0KQ96NpTRpgpITpm+7YfAGKXo6Rkyf2DM41yDVnUJ+7EivqmPrOAGz8FzEuJ4bCTNJ04I/eDO/HnlJSNR0oKmZsCgpWoY0F5fHznTtO7qGgW/etptvDiibuaueu/muUj+dS3ILgw5R2loEnuj4ZwAWJTsFnWrFgKi11iU46U53CI6nbSEnM20aDLnauRKZNuWBG/qRhBzG0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR18MB4479.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014)(13003099007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ep6FBwrFKT8oXQ6LIYHdf9P3gMDOFubtN2rGs4C4sPCzYPHlH6LhCOh/tOWN?=
 =?us-ascii?Q?Lo3lsIfa8tEjNQrWOnglm6kdGq3QzWnmlzBY3x/Q6niaN7T0Ftm5t/OwCkmC?=
 =?us-ascii?Q?obIwtFcBriVS4TskKV8X82qY1JhG8Y0a5PYU783NbgWJAiupCMu2Mmjj4qCZ?=
 =?us-ascii?Q?12fNd6ckrdPXnLQdPR3ptilWpBYcqo2XzFwTyU09gjYY5xeWF7UvU6jGDK4K?=
 =?us-ascii?Q?0Eo0RE+cL4DMGGwwRPOAvuCqXBp368a5SQfKLak9mJs28u0N+IM4MOUgnSqE?=
 =?us-ascii?Q?PthRmnDLEtU0qQ4+4v8HUIZ5UTvxo99trjy7igryLPuGbVCznYAJhpbb0d1w?=
 =?us-ascii?Q?BERl2MRc1I+asn9R2ASGrT8z01Cn0edY3US3Sud4azxWAaI6PStaSbyR0dWw?=
 =?us-ascii?Q?ekG/aKYAA82Jb6SGVedq1fD3O5emt/F7Sh0dE7OVe2p7NCXn06TxaWfTSN2U?=
 =?us-ascii?Q?u9+eJxmuEnMHWP97gXP2Cv1g4oOoEUPTHBtFgeE2vimA9hD799InV4szRz9f?=
 =?us-ascii?Q?fz6vXPm4L9eczRnHOob8g2L04+2eWliv0JrlgVfiJhERPk3AqHsbDlAxSAo5?=
 =?us-ascii?Q?Wh6pb4LzzdZ1hjYuBahfNzchtWobRIauf3OuyHmCOUWZPdxJEuyvrVi1qM90?=
 =?us-ascii?Q?7hQy2PPCILvHbmegPamoiC26wNaObTUnDVCO+sOrOs/JAf5f18iX/MbNVe5P?=
 =?us-ascii?Q?S2X0FCFL6bHbw73P/xLP4J9Azcr3W6iGRgbExltPiwP/Ct2OROruzdQm5m94?=
 =?us-ascii?Q?6pfo/WNI5VfhTuQOShG8A1qxVIylfYqbvYdHxYdN3KfJyUkwzx3hN+F3q908?=
 =?us-ascii?Q?jpcKYAYgOGbBcpmxOwwV4PkELFSdwutz4RY/8pxrkv/EOyMWqrgpLzTFqRbD?=
 =?us-ascii?Q?Fyjqq7xt3viOj3wTrZFzVwZ1Dhaw+1L/W7kGVEKjj9aMIUi2I9cQn+RPJ88a?=
 =?us-ascii?Q?mJExmwyhxk+vq5emQTw0l9OBGeRMsc9zwW8zW2YKJBjSJasraLiFBdqemyx6?=
 =?us-ascii?Q?aE/07czfK4nPfQtjDxK7fIMCpi+CBDniCTe1jFk0JqEoxzp9G7QKmfHR8ElC?=
 =?us-ascii?Q?3pn/6ExE3a3NEW5evddpwTJY5a8ZeqXRMrlIzHWWiUcdmr6Gml7y8CWwWywV?=
 =?us-ascii?Q?OBQbqjUDZcUCK/g72vRyEM7W7CdYh2DwAIVLV6wCNarMED41i62iQ39BGYRb?=
 =?us-ascii?Q?KnUpBMBuSfknG62Ht0BDuDB0LxiYbU0sDAiTNLdvTmiUhEq00wLQyool9kMa?=
 =?us-ascii?Q?t+mIgtYEWF13UOIBC+aTlvUZwmMd9BWO21DJZx8mwoHaWMdd82hL17HCYhhh?=
 =?us-ascii?Q?X6O6ADD9/H/jrgIgrBqE+a1AlKojA/5nGNeznXgOVoBYTMLMH9zUYyNQmAy/?=
 =?us-ascii?Q?rq/zaEV7RBC1L3Yom8rlIaHwQXmEnsnEXciNuvCKBWsXxzM0/wlvuXrRs+vx?=
 =?us-ascii?Q?oVdx7W2BOosdvsHMljp95i/mtaICqofdztqR7l1Bb0IyeyZUbFZeiWWq+D9c?=
 =?us-ascii?Q?smO/UsSTqtUECXeZWhOdzh8JQIEc8mZIKHaJkgJijlUMHS88SznwGN4YsBxW?=
 =?us-ascii?Q?SA39/te2QgaAGILWGHq6K7m9ZermvifoP0ehh3N9sYRniyWuA5k+TPpmuShb?=
 =?us-ascii?Q?lxr2uRmsXCkPH1T5ukNGy2nAkjrqqa8J/kysHWmzjBov2y4hY8GaEiL+qkoS?=
 =?us-ascii?Q?FAgNB8Q20/pFizz7n2ohLzUY/FP1e0eE0C3E/dq62KVbvSpFEZbFQ9XgeJVk?=
 =?us-ascii?Q?LF2HLLaDSQ=3D=3D?=
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b6d4f9-5953-4661-23f8-08de7b7a0d0c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB4479.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 12:15:27.0089 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TH88eEfkXjoo8a8R0cMY7ZHWxRBg+mLP5fSpjWNFRXUDVZuHVIjuEiqUoLx2FOHCRj5uxwvAMsrW1VIk3JYLHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA2PR18MB5977
Received-SPF: pass client-ip=52.101.85.127; envelope-from=kchiu@axiado.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This patch adds new model for Axiado SoC AX3000 which supports
    4 Cortex-A53 ARM64 CPUs
    Arm Generic Interrupt Controller v3
    4 Cadence UARTs
    1 SDHCI controller with PHY

Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
---
 hw/arm/Kconfig              |   8 +
 hw/arm/axiado-soc.c         | 287 ++++++++++++++++++++++++++++++++++++
 hw/arm/meson.build          |   2 +
 include/hw/arm/axiado-soc.h | 152 +++++++++++++++++++
 4 files changed, 449 insertions(+)
 create mode 100644 hw/arm/axiado-soc.c
 create mode 100644 include/hw/arm/axiado-soc.h

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index c66c452737..a91b81b298 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -699,3 +699,11 @@ config ARMSSE
     select UNIMP
     select SSE_COUNTER
     select SSE_TIMER
+
+config AXIADO_SOC
+    bool
+    default y
+    depends on ARM
+    select ARM_GIC
+    select CADENCE # UART
+    select SDHCI
diff --git a/hw/arm/axiado-soc.c b/hw/arm/axiado-soc.c
new file mode 100644
index 0000000000..e23410c147
--- /dev/null
+++ b/hw/arm/axiado-soc.c
@@ -0,0 +1,287 @@
+/*
+ * Axiado SoC AX3000
+ *
+ * Author: Kuan-Jui Chiu <kchiu@axiado.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 or
+ * (at your option) version 3 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "system/address-spaces.h"
+#include "hw/arm/bsa.h"
+#include "hw/arm/axiado-soc.h"
+#include "system/system.h"
+#include "qobject/qlist.h"
+#include "qom/object.h"
+
+static uint64_t sdhci_phy_read(void *opaque, hwaddr offset, unsigned size)
+{
+    uint32_t val = 0x00;
+
+    switch (offset) {
+    case REG_ID:
+        val = 0x3dff6870;
+        break;
+    case REG_STATUS:
+        // Make DLL_RDY | CAL_DONE
+        val =  (1u << 0) | (1u << 6);
+        break;
+    default:
+        break;
+    }
+
+    return val;
+}
+
+static void sdhci_phy_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
+{
+    /* TBD */
+}
+
+static const MemoryRegionOps sdhci_phy_ops = {
+    .read = sdhci_phy_read,
+    .write = sdhci_phy_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static uint64_t timer_ctrl_read(void *opaque, hwaddr offset, unsigned size)
+{
+    return 0x0;
+}
+
+static void timer_ctrl_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
+{
+    /* TBD */
+}
+
+static const MemoryRegionOps timer_ctrl_ops = {
+    .read = timer_ctrl_read,
+    .write = timer_ctrl_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static uint64_t pll_read(void *opaque, hwaddr offset, unsigned size)
+{
+    switch (offset) {
+    case CLKRST_CPU_PLL_POSTDIV_OFFSET:
+        return 0x20891b;
+    case CLKRST_CPU_PLL_STS_OFFSET:
+        return 0x01;
+    default:
+        return 0x00;
+    }
+}
+
+static void pll_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
+{
+    /* TBD */
+}
+
+static const MemoryRegionOps pll_ops = {
+    .read = pll_read,
+    .write = pll_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static void ax3000_init(Object *obj)
+{
+    AxiadoSoCState *s = AXIADO_SOC(obj);
+    AxiadoSoCClass *sc = AXIADO_SOC_GET_CLASS(s);
+    int i;
+
+    for (i = 0; i < sc->num_cpus; i++) {
+        g_autofree char *name = g_strdup_printf("cpu%d", i);
+        object_initialize_child(obj, name, &s->cpu[i], ARM_CPU_TYPE_NAME("cortex-a53"));
+    }
+
+    object_initialize_child(obj, "gic", &s->gic, gicv3_class_name());
+
+    for (i = 0; i < AX3000_NUM_UARTS; i++) {
+        g_autofree char *name = g_strdup_printf("uart%d", i);
+        object_initialize_child(obj, name, &s->uart[i], TYPE_CADENCE_UART);
+    }
+
+    object_initialize_child(obj, "sdhci0", &s->sdhci0, TYPE_SYSBUS_SDHCI);
+}
+
+static void ax3000_realize(DeviceState *dev, Error **errp)
+{
+    AxiadoSoCState *s = AXIADO_SOC(dev);
+    AxiadoSoCClass *sc = AXIADO_SOC_GET_CLASS(s);
+    SysBusDevice *gicsbd = SYS_BUS_DEVICE(&s->gic);
+    DeviceState *gicdev = DEVICE(&s->gic);
+    QList *redist_region_count;
+    int i;
+
+    /* CPUs */
+    for (i = 0; i < sc->num_cpus; i++) {
+        object_property_set_int(OBJECT(&s->cpu[i]), "cntfrq", 8000000,
+                                &error_abort);
+
+        if (object_property_find(OBJECT(&s->cpu[i]), "has_el3")) {
+            object_property_set_bool(OBJECT(&s->cpu[i]), "has_el3",
+                                     false, &error_abort);
+        }
+
+        if (!qdev_realize(DEVICE(&s->cpu[i]), NULL, errp)) {
+            return;
+        }
+    }
+
+    /* GIC */
+    qdev_prop_set_uint32(gicdev, "num-cpu", sc->num_cpus);
+    qdev_prop_set_uint32(gicdev, "num-irq",
+                         AX3000_NUM_IRQS + GIC_INTERNAL);
+
+    redist_region_count = qlist_new();
+    qlist_append_int(redist_region_count, sc->num_cpus);
+    qdev_prop_set_array(gicdev, "redist-region-count", redist_region_count);
+
+    if (!sysbus_realize(gicsbd, errp)) {
+        return;
+    }
+
+    sysbus_mmio_map(gicsbd, 0, AX3000_GIC_DIST_BASE);
+    sysbus_mmio_map(gicsbd, 1, AX3000_GIC_REDIST_BASE);
+
+    /*
+     * Wire the outputs from each CPU's generic timer and the GICv3
+     * maintenance interrupt signal to the appropriate GIC PPI inputs, and
+     * the GIC's IRQ/FIQ interrupt outputs to the CPU's inputs.
+     */
+    for (i = 0; i < sc->num_cpus; i++) {
+        DeviceState *cpudev = DEVICE(&s->cpu[i]);
+        int intidbase = AX3000_NUM_IRQS + i * GIC_INTERNAL;
+        qemu_irq irq;
+
+        /*
+         * Mapping from the output timer irq lines from the CPU to the
+         * GIC PPI inputs.
+         */
+        static const int timer_irqs[] = {
+            [GTIMER_PHYS] = ARCH_TIMER_NS_EL1_IRQ,
+            [GTIMER_VIRT] = ARCH_TIMER_VIRT_IRQ,
+            [GTIMER_HYP]  = ARCH_TIMER_NS_EL2_IRQ,
+            [GTIMER_SEC]  = ARCH_TIMER_S_EL1_IRQ
+        };
+
+        for (int j = 0; j < ARRAY_SIZE(timer_irqs); j++) {
+            irq = qdev_get_gpio_in(gicdev, intidbase + timer_irqs[j]);
+            qdev_connect_gpio_out(cpudev, j, irq);
+        }
+
+        irq = qdev_get_gpio_in(gicdev, intidbase + ARCH_GIC_MAINT_IRQ);
+        qdev_connect_gpio_out_named(cpudev, "gicv3-maintenance-interrupt",
+                                        0, irq);
+
+        sysbus_connect_irq(gicsbd, i,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
+        sysbus_connect_irq(gicsbd, i + sc->num_cpus,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
+        sysbus_connect_irq(gicsbd, i + 2 * sc->num_cpus,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
+        sysbus_connect_irq(gicsbd, i + 3 * sc->num_cpus,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
+    }
+
+    /* DRAM */
+    for (i = 0; i < AX3000_NUM_BANKS; i++) {
+        struct {
+            hwaddr addr;
+            size_t size;
+            const char *name;
+        } dram_table[] = {
+            { AX3000_DRAM0_BASE, AX3000_DRAM0_SIZE, "dram0" },
+            { AX3000_DRAM1_BASE, AX3000_DRAM1_SIZE, "dram1" }
+        };
+
+        memory_region_init_ram(&s->dram[i], OBJECT(s), dram_table[i].name,
+                               dram_table[i].size, &error_fatal);
+        memory_region_add_subregion(get_system_memory(), dram_table[i].addr,
+                                    &s->dram[i]);
+    }
+
+    /* UARTs */
+    for (i = 0; i < AX3000_NUM_UARTS; i++) {
+        struct {
+            hwaddr addr;
+            unsigned int irq;
+        } serial_table[] = {
+            { AX3000_UART0_BASE, AX3000_UART0_IRQ },
+            { AX3000_UART1_BASE, AX3000_UART1_IRQ },
+            { AX3000_UART2_BASE, AX3000_UART2_IRQ },
+            { AX3000_UART3_BASE, AX3000_UART3_IRQ }
+        };
+
+        qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", serial_hd(i));
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), errp)) {
+            return;
+        }
+
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->uart[i]), 0, serial_table[i].addr);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart[i]), 0,
+                           qdev_get_gpio_in(gicdev, serial_table[i].irq));
+    }
+
+    /* Timer control*/
+    memory_region_init_io(&s->timer_ctrl, OBJECT(s), &timer_ctrl_ops, s,
+                          "timer_ctrl", 32);
+    memory_region_add_subregion(get_system_memory(), AX3000_TIMER_CTRL,
+                                &s->timer_ctrl);
+
+    /* PLL control */
+    memory_region_init_io(&s->pll_ctrl, OBJECT(s), &pll_ops, s, "pll_ctrl",
+                          32);
+    memory_region_add_subregion(get_system_memory(), AX3000_PLL_BASE,
+                                &s->pll_ctrl);
+
+    /* SDHCI */
+    qdev_prop_set_uint64(DEVICE(&s->sdhci0), "capareg", 0x216737eed0b0);
+    qdev_prop_set_uint64(DEVICE(&s->sdhci0), "sd-spec-version", 3);
+
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdhci0), errp)) {
+        return;
+    }
+
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sdhci0), 0, AX3000_SDHCI0_BASE);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->sdhci0), 0,
+                       qdev_get_gpio_in(gicdev, AX3000_SDHCI0_IRQ));
+
+    memory_region_init_io(&s->sdhci_phy, OBJECT(s), &sdhci_phy_ops, s,
+                           "sdhci_phy", AX3000_SDHCI0_PHY_SIZE);
+    memory_region_add_subregion(get_system_memory(), AX3000_SDHCI0_PHY_BASE,
+                                &s->sdhci_phy);
+}
+
+static void ax3000_class_init(ObjectClass *oc, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    AxiadoSoCClass *sc = AXIADO_SOC_CLASS(oc);
+
+    dc->desc = "Axiado SoC AX3000";
+    dc->realize = ax3000_realize;
+    sc->num_cpus = AX3000_NUM_CPUS;
+}
+
+static const TypeInfo axiado_soc_types[] = {
+    {
+        .name           = TYPE_AXIADO_SOC,
+        .parent         = TYPE_SYS_BUS_DEVICE,
+        .instance_size  = sizeof(AxiadoSoCState),
+        .instance_init  = ax3000_init,
+        .class_init     = ax3000_class_init,
+    }
+};
+
+DEFINE_TYPES(axiado_soc_types)
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 47cdc51d13..c3c96c0a70 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -105,6 +105,8 @@ arm_common_ss.add(when: 'CONFIG_STRONGARM', if_true: files('strongarm.c'))
 arm_common_ss.add(when: 'CONFIG_SX1', if_true: files('omap_sx1.c'))
 arm_common_ss.add(when: 'CONFIG_VERSATILE', if_true: files('versatilepb.c'))
 arm_common_ss.add(when: 'CONFIG_VEXPRESS', if_true: files('vexpress.c'))
+arm_common_ss.add(when: ['CONFIG_AXIADO_SOC', 'TARGET_AARCH64'], if_true: files(
+  'axiado-soc.c'))
 
 arm_common_ss.add(files('boot.c'))
 
diff --git a/include/hw/arm/axiado-soc.h b/include/hw/arm/axiado-soc.h
new file mode 100644
index 0000000000..2483bdd8c2
--- /dev/null
+++ b/include/hw/arm/axiado-soc.h
@@ -0,0 +1,152 @@
+/*
+ * Axiado SoC AX3000
+ *
+ * Author: Kuan-Jui Chiu <kchiu@axiado.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 or
+ * (at your option) version 3 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef AXIADO_AX3000_H
+#define AXIADO_AX3000_H
+
+#include "cpu.h"
+#include "hw/intc/arm_gicv3_common.h"
+#include "hw/char/cadence_uart.h"
+#include "hw/sd/sdhci.h"
+#include "hw/core/sysbus.h"
+#include "qemu/units.h"
+
+#define TYPE_AXIADO_SOC "ax3000"
+OBJECT_DECLARE_TYPE(AxiadoSoCState, AxiadoSoCClass, AXIADO_SOC)
+
+#define AX3000_RAM_START        0x3C000000
+#define AX3000_RAM_SIZE_MAX     (16 * GiB)
+
+#define AX3000_DRAM0_BASE       AX3000_RAM_START
+#define AX3000_DRAM0_SIZE       (1088 * MiB)
+#define AX3000_DRAM1_BASE       0x400000000
+#define AX3000_DRAM1_SIZE       (2 * GiB)
+
+#define AX3000_GIC_DIST_BASE    0x80300000
+#define AX3000_GIC_DIST_SIZE    (64 * KiB)
+#define AX3000_GIC_REDIST_BASE  0x80380000
+#define AX3000_GIC_REDIST_SIZE  (512 * KiB)
+
+#define AX3000_UART0_BASE       0x80520000
+#define AX3000_UART0_SIZE       (256)
+#define AX3000_UART1_BASE       0x805a0000
+#define AX3000_UART1_SIZE       (256)
+#define AX3000_UART2_BASE       0x80620000
+#define AX3000_UART2_SIZE       (256)
+#define AX3000_UART3_BASE       0x80520800
+#define AX3000_UART3_SIZE       (256)
+
+#define AX3000_SDHCI0_BASE      0x86000000
+#define AX3000_SDHCI0_PHY_BASE  0x80801C00
+#define AX3000_SDHCI0_PHY_SIZE  (256)
+
+#define AX3000_GPIO0_BASE       0x80500000
+#define AX3000_GPIO0_SIZE       (1024)
+#define AX3000_GPIO1_BASE       0x80580000
+#define AX3000_GPIO1_SIZE       (1024)
+#define AX3000_GPIO2_BASE       0x80600000
+#define AX3000_GPIO2_SIZE       (1024)
+#define AX3000_GPIO3_BASE       0x80680000
+#define AX3000_GPIO3_SIZE       (1024)
+#define AX3000_GPIO4_BASE       0x80700000
+#define AX3000_GPIO4_SIZE       (1024)
+#define AX3000_GPIO5_BASE       0x80780000
+#define AX3000_GPIO5_SIZE       (1024)
+#define AX3000_GPIO6_BASE       0x80800000
+#define AX3000_GPIO6_SIZE       (1024)
+#define AX3000_GPIO7_BASE       0x80880000
+#define AX3000_GPIO7_SIZE       (1024)
+
+#define AX3000_TIMER_CTRL        0x8A020000
+#define AX3000_PLL_BASE          0x80000000
+#define CLKRST_CPU_PLL_POSTDIV_OFFSET   0x0C
+#define CLKRST_CPU_PLL_STS_OFFSET       0x14
+
+
+enum Ax3000Configuration {
+    AX3000_NUM_CPUS     = 4,
+    AX3000_NUM_IRQS     = 224,
+    AX3000_NUM_BANKS    = 2,
+    AX3000_NUM_UARTS    = 4,
+    AX3000_NUM_GPIOS    = 8,
+};
+
+typedef struct AxiadoSoCState {
+    SysBusDevice        parent;
+
+    ARMCPU              cpu[AX3000_NUM_CPUS];
+    GICv3State          gic;
+    MemoryRegion        dram[AX3000_NUM_BANKS];
+    MemoryRegion        timer_ctrl;
+    MemoryRegion        pll_ctrl;
+    CadenceUARTState    uart[AX3000_NUM_UARTS];
+    SDHCIState          sdhci0;
+    MemoryRegion        sdhci_phy;
+} AxiadoSoCState;
+
+typedef struct AxiadoSoCClass {
+    SysBusDeviceClass   parent;
+
+    uint32_t            num_cpus;
+} AxiadoSoCClass;
+
+enum Ax3000MemoryRegions {
+    AX3000_GIC_DIST,
+    AX3000_GIC_REDIST,
+    AX3000_DRAM0,
+    AX3000_DRAM1,
+    AX3000_UART0,
+    AX3000_UART1,
+    AX3000_UART2,
+    AX3000_UART3,
+    AX3000_SDHCI0,
+    AX3000_GPIO0,
+    AX3000_GPIO1,
+    AX3000_GPIO2,
+    AX3000_GPIO3,
+    AX3000_GPIO4,
+    AX3000_GPIO5,
+    AX3000_GPIO6,
+    AX3000_GPIO7,
+};
+
+enum Ax3000Irqs {
+    AX3000_UART0_IRQ    = 112,
+    AX3000_UART1_IRQ    = 113,
+    AX3000_UART2_IRQ    = 114,
+    AX3000_UART3_IRQ    = 170,
+
+    AX3000_SDHCI0_IRQ    = 123,
+
+    AX3000_GPIO0_IRQ    = 183,
+    AX3000_GPIO1_IRQ    = 184,
+    AX3000_GPIO2_IRQ    = 185,
+    AX3000_GPIO3_IRQ    = 186,
+    AX3000_GPIO4_IRQ    = 187,
+    AX3000_GPIO5_IRQ    = 188,
+    AX3000_GPIO6_IRQ    = 189,
+    AX3000_GPIO7_IRQ    = 190,
+};
+
+enum SDHCI_PHY_REG {
+    REG_ID        = 0x00,   // ID
+    REG_STATUS    = 0x50,   // READY/LOCK/CAL_DONE bits
+};
+
+#endif /* AXIADO_AX3000_H */
-- 
2.34.1


