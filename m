Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F4C7CD8CA8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 12:17:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY0nR-0001U1-Mz; Fri, 12 Jun 2026 08:15:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wXvxO-0002kH-9G; Fri, 12 Jun 2026 03:05:34 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wXvxK-0005yW-To; Fri, 12 Jun 2026 03:05:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fCxdFy01qF7ymqunD5x0cuMerdHKkhcn9mF0ugtYahU1U7bCPHANKvW3azy9bJUj6ENEvX1myTo35Cca8zJinAvriO0ne1HRJN0dGMZ8XOmwqgylZOt5iWPkYg0Vw/YZcbleR78KV9Oh1qPE+Frgil/N6eJQDIfe79INAHAI/q6TcxXaULuuxEBO3OMcdyRl+E9fe0VDxF7mwRatX17ujliOZMiKu0Z4a9T0CdR43y8McHqQHg8JoSAgbMRdmYiULLwjiY9spjzdDMnhOG+eC/XTwVOXTYU/uiS8061lqNm4PVOOO5HE1nKwck9EYu0RxPhdNL901MQx2ocLbiAUNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=62m7hhWTstcB45G6mpdgTxwxIE9/qYsDOQo3+vXATI0=;
 b=DasHQ+E9K5YJyzw5Q39SZupk63LU+3J6o9++9GDOEAdtbaheX+UOP3FV/5XQeP+KB5tG0RIjiaQws/xDdMsKsE0wiyMSLNmiFTPdPiMwhRQc4xs/gAFGmovEXXI9koj7k1ilxi7MYOSPOH+41g2221AqKBlvzQWSKdJjHA/qugWx01DUtqz8UcgrHOPD5IXeNhotGCQEdtfzDsc2jxLL8ISIeYZppwLf+GhjDcJSxB/M74jBFX1xe5XB+Jv/fP0wKfoQMy7fC/QtfI3bYOejKJVm8VUZDDjziMq01CrTZkky8/6BAiXCDY4q/hzEeDtjLQwFewPcun2O5f38yT8Cpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62m7hhWTstcB45G6mpdgTxwxIE9/qYsDOQo3+vXATI0=;
 b=dAr+gjBJI6QP3X8qVv2CZhw/Rl7tbz0nMR4egvy1NT9IHTykd/yHqUKBL77RHyuj5NC/GknxsHUWmH6L6JGlAB7Ub8y8orI3FO4Ah/N3buJZkhU8j82gskgnbHeQOqaWwgn1Nb4Vy8QnxuZ+RwCh5Zc/7weOnSolAuXFKkK/ZKSU0lTS+JYO06bjgE6DF7oHx5cjEgSKwKu8aAWL5DGrSTEgy/Qpgcj6Imi9b+GPH/ny5xuUX/gsxywtrodX74L/RWyjoSYEredShiWdsWIvvT/mU8gRLOeHoSN5qE2i+mbSYZInGbc5RiuRjJNEP2iLf2SqtxPhyPlXVw553qg7hQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by SEYPR02MB6457.apcprd02.prod.outlook.com (2603:1096:101:13b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 07:05:15 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0092.017; Fri, 12 Jun 2026
 07:05:15 +0000
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
 Chao Liu <chao.liu@zevorn.cn>, Mig Yang <temashking@foxmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v8 3/5] hw/watchdog: add k230 watchdog initial support
Date: Fri, 12 Jun 2026 15:04:06 +0800
Message-ID: <805a04d9467556ee6a5f4742c9eb4bbb6fc7898c.1781246408.git.chao.liu@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7c49ed54-df3b-4a45-28ac-08dec850f419
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|34096008|366016|7416014|586017|376014|3023799007|56012099006|6133799003|13003099007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: NpIw5ei4EHxvMpYHtakRO7TUuAtRbcnkaKBfT8y+7w2g+94TCLdupryk4NOBtZKIEoY5FIdb1ZrY61RHTo0AwXCvXIDifuSEmRJmODZGgIf7dLwO2ini1R3wlA2SBL9oTaV9n2SBfrFfj400f4OjPjP94lG2MrqdcynVtPgo1oCsSsmG6quk7SzD6syVclwLuDotoF2UIUc2RMVUeNuBvCAnzfydKLuVOAROLU0JDHknepGp04GpWKNKoGmxNWzdE+bg5UodYf7Qd7+otVZOIOQzuC99MF2/EAcjKJY4fIJZIkfDLiL5SZogP7p/CxH86K89D6mmj0jIxcKhVTTTqHsWKlyQ+zMj0IPJI7RJAgALl8TkbQAqPXIq1eD/1HybJrPrXDgCwGOKjrhqf+ROKesLr9KlBG1QkwqZuwlljLkATy8u5PbGiMQRk0qubxROoI7NWcgJ7vOKld7k6XjFluFZabttgxVP5dqJwbdPckgvVhebvw2URTvHOCsVmd8m3soD1AReDPVSVO6K570mUONatlygSQrrkfigMsHFCQ9dq0WovFZbTlJQmCMXjqqA63mTWm7yXl/jNkvs8ifzwzd305scpP16zxYA0QJLI5XlkvDUcAOQFsVb9azp6JuyN2fsGJFJFCzavjPWEMmXaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(34096008)(366016)(7416014)(586017)(376014)(3023799007)(56012099006)(6133799003)(13003099007)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sylc2pkQ++5O0QvW9Cp4BSKZxIojWszkhAmIbRam5SL5Ko2GfU1c19egWxCJ?=
 =?us-ascii?Q?eQ7RWAofBAQvwNxCMePpQdlrdZuBMt4YvnUHcTvRgD2YWr49S1JurbmKNDzk?=
 =?us-ascii?Q?KJwF89Lim7vnAFGAs7pFwQQPHLUvuoLLFtVgE2x8+wCeYWjwNxTgKodC14s7?=
 =?us-ascii?Q?+9S/ScQmgOy7vOU7JBffLe6E0sM8HISYSRdlnIiDGincMkHTyx9ABgFhDhkF?=
 =?us-ascii?Q?AhQ4XNBk8BwYgoOgHIwwfPhblFx21sz/dNtBxfzfW2OeVjjLMV+PVI748hN1?=
 =?us-ascii?Q?5hgyigrGhwExrfRpR1QrnZTeTIrxx3U8S88yJ7GECciR0sUnVYQrtO70dn9h?=
 =?us-ascii?Q?W3IBdcPwRmG+D7Eq4F5WguNKbPQBkMegGySVBPlsfishLcoiWup27t84HuUK?=
 =?us-ascii?Q?IiAwcNwF+U+J9Jh5UnZpbYjpUc7EEwEjIIDt2jC3iUj1pDDCXA/gcHsbDTVE?=
 =?us-ascii?Q?gGUVsjshm3+5IOGI9P7oOOSsR28PRCIEJZXjkIcvqqUNucmUUZ4c1UnacBKU?=
 =?us-ascii?Q?7XDSyOCMTTQiJ92nQj/pmjW288hUwd0hHeR5ieqld2PXBiz6I1E4+p5c37lE?=
 =?us-ascii?Q?CUwJLeauvVqxA0+1IUvOShS8TAecvFRbk811+lramw7C0NzSxtBuH/dL5WQX?=
 =?us-ascii?Q?V5XfWeC+ZUsF3gpAKS/bO0l75HOI+eiyda1z3CA0KaG2PX5Gtf4Ll3WLb/xB?=
 =?us-ascii?Q?OYLDJuE/0z3fZfdxh9oUWTHy4WYeMTbrtwFJ3ZNQ8J+bJYiUNfqa4B1d1gyd?=
 =?us-ascii?Q?jdKreGFPopn0qXACYd5xogBQYTUtaQpQxxXG9j2b5dY0qyd0921oxr+d5iUT?=
 =?us-ascii?Q?XrcKCYiog+upBQ7tCFw1h7pPe3KAzoSGCaXZbyCQd69qP6dhiEmyaiLRt5Gw?=
 =?us-ascii?Q?Tvw0xvwG10aYcY2o1883uOD75pJWOjw/5b+D2i/wLTQ155fh8cbTMqnd+ZKa?=
 =?us-ascii?Q?zOuitc58NSoq3tIcJp21tjYUMQRX3t9DaD86WiLxJxTfKftwgrpmC6wcbB0e?=
 =?us-ascii?Q?9+zIg+QwopTKCoaQivuIuvJp3n0xdo6l0wQ6tHrNCnCCq73MDd9PPhhYkmw1?=
 =?us-ascii?Q?eGkVx5Q7tiJ4Khh9KiDSC6UiKbARtRbOB16svCDoWR8Z5NUvM8sBFMNHaert?=
 =?us-ascii?Q?rxAEZKWxv7elHnq6y0EHSxRwMZVa+exR6zm2wqx0b/xzbraxXYxYIW5pI+jM?=
 =?us-ascii?Q?BvQiyYSFWAR30uJ05exBcvp4jsuO7yrlH4tvke7VUnZCIIN33LEgJMUHZCYk?=
 =?us-ascii?Q?7AV0cm2dfcFixBHET25F+brE4hYbMtoTmzCO2NHnTo+XAfbfadElGBRuc4b2?=
 =?us-ascii?Q?GxK0QNIU0bFaTEf2oUIl89ANfD0zuwYIb8/n7l/XOCvnGpptEdUhT6Tx8/Lf?=
 =?us-ascii?Q?64OW+3YxUIb/aN9EVcGmzrTxLNLlSoppwTdrImbz8Rqmv7Oj+Fa2QXGAHY3A?=
 =?us-ascii?Q?PLYGmQ5DpSvf1SfnrJtA1Yree3rsaX+BX+IwL0hs7CemCc0UUmou3/HY/6aY?=
 =?us-ascii?Q?L3E/8VGS9QaR5VZzY2pje/QnApPs28vP37HqEEzuWBcgMsSN0IwuPpad3aNd?=
 =?us-ascii?Q?i78QtyoxLSzZGvoGUWFQHs2a1HcXqTMyKf1kd1BJYrtSKO4PyPFk7igYhYXE?=
 =?us-ascii?Q?fEsz1Qu6QMONGT+CYD5OWF78owOFYhtacDEyGijRthPkSlEib/AtUTfMEMUh?=
 =?us-ascii?Q?VyYeRUnT4sHi5/KTwJb/ri34RlbmcXbaerLqO4l2OP7EO9uVP5cjFnKQw4Ta?=
 =?us-ascii?Q?VZk9gMvKy00T1wMYgxyUcBJu9QSSUIg=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c49ed54-df3b-4a45-28ac-08dec850f419
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 07:05:15.2965 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lBNSNNpP0afP0nALIZk1pL1sq9xGQnis4xTbVbpVQApEK+IAUl45ftJIc8eKhnbJH5xnIxO6rxFPucF/uqUt8rZ8Ies9T4A4RK/PGNpbClo=
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

From: Chao Liu <chao.liu@zevorn.cn>

Add programmable Watchdog Timer (WDT) peripheral for K230 machine.

Signed-off-by: Mig Yang <temashking@foxmail.com>
Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 MAINTAINERS                    |   2 +
 hw/riscv/Kconfig               |   1 +
 hw/riscv/k230.c                |  18 ++
 hw/watchdog/Kconfig            |   4 +
 hw/watchdog/k230_wdt.c         | 296 +++++++++++++++++++++++++++++++++
 hw/watchdog/meson.build        |   1 +
 hw/watchdog/trace-events       |   9 +
 include/hw/riscv/k230.h        |   4 +
 include/hw/watchdog/k230_wdt.h | 121 ++++++++++++++
 9 files changed, 456 insertions(+)
 create mode 100644 hw/watchdog/k230_wdt.c
 create mode 100644 include/hw/watchdog/k230_wdt.h

diff --git a/MAINTAINERS b/MAINTAINERS
index a21796ac6f..06db33a107 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1791,7 +1791,9 @@ M: Chao Liu <chao.liu.zevorn@gmail.com>
 L: qemu-riscv@nongnu.org
 S: Maintained
 F: hw/riscv/k230.c
+F: hw/watchdog/k230_wdt.c
 F: include/hw/riscv/k230.h
+F: include/hw/watchdog/k230_wdt.h
 
 RX Machines
 -----------
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index f512ed65ac..54e41a6afc 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -148,3 +148,4 @@ config K230
     select RISCV_IMSIC
     select SERIAL_MM
     select UNIMP
+    select K230_WDT
diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
index 26d1e20c99..502281c52c 100644
--- a/hw/riscv/k230.c
+++ b/hw/riscv/k230.c
@@ -108,6 +108,9 @@ static void k230_soc_init(Object *obj)
     RISCVHartArrayState *cpu0 = &s->c908_cpu;
 
     object_initialize_child(obj, "c908-cpu", cpu0, TYPE_RISCV_HART_ARRAY);
+    object_initialize_child(obj, "k230-wdt0", &s->wdt[0], TYPE_K230_WDT);
+    object_initialize_child(obj, "k230-wdt1", &s->wdt[1], TYPE_K230_WDT);
+
     qdev_prop_set_uint32(DEVICE(cpu0), "hartid-base", 0);
     qdev_prop_set_string(DEVICE(cpu0), "cpu-type", TYPE_RISCV_CPU_THEAD_C908);
     qdev_prop_set_uint64(DEVICE(cpu0), "resetvec",
@@ -188,6 +191,21 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
         k230_create_uart(sys_mem, DEVICE(s->c908_plic), i);
     }
 
+    /* Watchdog */
+    for (int i = 0; i < 2; i++) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), errp)) {
+            return;
+        }
+    }
+
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[0]), 0, memmap[K230_DEV_WDT0].base);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->wdt[0]), 0,
+                       qdev_get_gpio_in(DEVICE(s->c908_plic), K230_WDT0_IRQ));
+
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[1]), 0, memmap[K230_DEV_WDT1].base);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->wdt[1]), 0,
+                       qdev_get_gpio_in(DEVICE(s->c908_plic), K230_WDT1_IRQ));
+
     /* unimplemented devices */
     create_unimplemented_device("kpu.l2-cache",
                                 memmap[K230_DEV_KPU_L2_CACHE].base,
diff --git a/hw/watchdog/Kconfig b/hw/watchdog/Kconfig
index 861fd00334..55f77c5c84 100644
--- a/hw/watchdog/Kconfig
+++ b/hw/watchdog/Kconfig
@@ -18,6 +18,10 @@ config WDT_DIAG288
 config WDT_IMX2
     bool
 
+config K230_WDT
+    bool
+    select PTIMER
+
 config WDT_SBSA
     bool
 
diff --git a/hw/watchdog/k230_wdt.c b/hw/watchdog/k230_wdt.c
new file mode 100644
index 0000000000..1f83b499e8
--- /dev/null
+++ b/hw/watchdog/k230_wdt.c
@@ -0,0 +1,296 @@
+/*
+ * K230 Watchdog Compatible with kendryte K230 SDK
+ *
+ * Copyright (c) 2025 Mig Yang <temashking@foxmail.com>
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
+#include "qemu/osdep.h"
+#include "qemu/bitops.h"
+#include "qemu/module.h"
+#include "system/watchdog.h"
+#include "migration/vmstate.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/watchdog/k230_wdt.h"
+#include "trace.h"
+
+static void k230_wdt_timeout(void *opaque)
+{
+    K230WdtState *s = K230_WDT(opaque);
+
+    trace_k230_wdt_timeout();
+
+    /* Set interrupt status if in interrupt mode */
+    if (s->cr & K230_WDT_CR_RMOD) {
+        s->stat |= K230_WDT_STAT_INT;
+        s->interrupt_pending = true;
+        qemu_set_irq(s->irq, 1);
+        trace_k230_wdt_interrupt();
+    } else {
+        /* Direct reset mode */
+        trace_k230_wdt_reset();
+        watchdog_perform_action();
+    }
+
+    /* Restart counter */
+    s->current_count = s->timeout_value;
+    ptimer_set_count(s->timer, s->current_count);
+    ptimer_run(s->timer, 1);
+}
+
+static void k230_wdt_reset(DeviceState *dev)
+{
+    K230WdtState *s = K230_WDT(dev);
+
+    trace_k230_wdt_reset_device();
+
+    ptimer_transaction_begin(s->timer);
+    ptimer_stop(s->timer);
+    ptimer_transaction_commit(s->timer);
+
+    /* Reset registers to default values */
+    s->cr = 0;
+    s->torr = 0;
+    s->ccvr = 0xFFFFFFFF;
+    s->stat = 0;
+    s->prot_level = 0x2;
+
+    s->interrupt_pending = false;
+    s->enabled = false;
+    s->timeout_value = 0;
+    s->current_count = 0xFFFFFFFF;
+}
+
+static uint64_t k230_wdt_read(void *opaque, hwaddr addr, unsigned int size)
+{
+    K230WdtState *s = K230_WDT(opaque);
+    uint32_t value = 0;
+
+    switch (addr) {
+    case K230_WDT_CR:
+        value = s->cr;
+        break;
+    case K230_WDT_TORR:
+        value = s->torr;
+        break;
+    case K230_WDT_CCVR:
+        if (s->enabled) {
+            value = ptimer_get_count(s->timer);
+        } else {
+            value = s->current_count;
+        }
+        break;
+    case K230_WDT_STAT:
+        value = s->stat;
+        break;
+    case K230_WDT_PROT_LEVEL:
+        value = s->prot_level;
+        break;
+    case K230_WDT_COMP_PARAM_5:
+        value = 0; /* Upper limit of Timeout Period parameters */
+        break;
+    case K230_WDT_COMP_PARAM_4:
+        value = 0; /* Upper limit of Initial Timeout Period parameters */
+        break;
+    case K230_WDT_COMP_PARAM_3:
+        value = 0; /* Derived from WDT_TOP_RST parameter */
+        break;
+    case K230_WDT_COMP_PARAM_2:
+        value = 0xFFFFFFFF; /* Derived from WDT_RST_CNT parameter */
+        break;
+    case K230_WDT_COMP_PARAM_1:
+        /* Component parameters */
+        value = (32 << K230_WDT_CNT_WIDTH_SHIFT) |  /* 32-bit counter */
+                (0 << K230_WDT_DFLT_TOP_INIT_SHIFT) |
+                (0 << K230_WDT_DFLT_TOP_SHIFT) |
+                (K230_WDT_RPL_16_CYCLES << K230_WDT_DFLT_RPL_SHIFT) |
+                (2 << K230_WDT_APB_DATA_WIDTH_SHIFT) | /* 32-bit APB */
+                K230_WDT_USE_FIX_TOP; /* Use fixed timeout values */
+        break;
+    case K230_WDT_COMP_VERSION:
+        value = K230_WDT_COMP_VERSION_VAL;
+        break;
+    case K230_WDT_COMP_TYPE:
+        value = K230_WDT_COMP_TYPE_VAL;
+        break;
+    default:
+        /* Other registers return 0 */
+        break;
+    }
+
+    trace_k230_wdt_read(addr, value);
+    return value;
+}
+
+static void k230_wdt_update_timer(K230WdtState *s)
+{
+    ptimer_transaction_begin(s->timer);
+
+    if (s->enabled && s->timeout_value > 0) {
+        ptimer_set_count(s->timer, s->current_count);
+        ptimer_run(s->timer, 1);
+    } else {
+        ptimer_stop(s->timer);
+    }
+
+    ptimer_transaction_commit(s->timer);
+}
+
+static uint32_t k230_wdt_calculate_timeout(uint32_t top_value)
+{
+    /* Calculate timeout based on TOP value */
+    /* For fixed timeout mode: 2^(16 + top_value) */
+    if (top_value <= 15) {
+        return 1 << (16 + top_value);
+    }
+    return 1 << 31; /* Maximum value for 32-bit counter */
+}
+
+static void k230_wdt_write(void *opaque, hwaddr addr,
+                           uint64_t value, unsigned int size)
+{
+    K230WdtState *s = K230_WDT(opaque);
+
+    trace_k230_wdt_write(addr, value);
+
+    switch (addr) {
+    case K230_WDT_CR:
+        s->cr = value & (K230_WDT_CR_RPL_MASK << K230_WDT_CR_RPL_SHIFT |
+                         K230_WDT_CR_RMOD | K230_WDT_CR_WDT_EN);
+
+        /* Update enabled state */
+        s->enabled = (s->cr & K230_WDT_CR_WDT_EN) != 0;
+
+        /* Update timer */
+        k230_wdt_update_timer(s);
+        break;
+
+    case K230_WDT_TORR:
+        s->torr = value & K230_WDT_TORR_TOP_MASK;
+
+        /* Calculate new timeout value */
+        s->timeout_value = k230_wdt_calculate_timeout(s->torr);
+        s->current_count = s->timeout_value;
+
+        /* Update timer if enabled */
+        if (s->enabled) {
+            k230_wdt_update_timer(s);
+        }
+        break;
+
+    case K230_WDT_CRR:
+        /* Restart counter with magic value 0x76 */
+        if ((value & 0xFF) == K230_WDT_CRR_RESTART) {
+            trace_k230_wdt_restart();
+            s->current_count = s->timeout_value;
+
+            /* Clear interrupt if pending */
+            if (s->interrupt_pending) {
+                s->stat &= ~K230_WDT_STAT_INT;
+                s->interrupt_pending = false;
+                qemu_set_irq(s->irq, 0);
+            }
+
+            /* Update timer */
+            k230_wdt_update_timer(s);
+        }
+        break;
+
+    case K230_WDT_EOI:
+        /* Clear interrupt */
+        s->stat &= ~K230_WDT_STAT_INT;
+        s->interrupt_pending = false;
+        qemu_set_irq(s->irq, 0);
+        break;
+
+    case K230_WDT_PROT_LEVEL:
+        s->prot_level = value & 0x7;
+        break;
+
+    default:
+        /* Read-only registers, ignore writes */
+        break;
+    }
+}
+
+static const MemoryRegionOps k230_wdt_ops = {
+    .read  = k230_wdt_read,
+    .write = k230_wdt_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+        .unaligned = false,
+    },
+};
+
+static const VMStateDescription vmstate_k230_wdt = {
+    .name = "k230.wdt",
+    .fields = (const VMStateField[]) {
+        VMSTATE_PTIMER(timer, K230WdtState),
+        VMSTATE_UINT32(cr, K230WdtState),
+        VMSTATE_UINT32(torr, K230WdtState),
+        VMSTATE_UINT32(ccvr, K230WdtState),
+        VMSTATE_UINT32(stat, K230WdtState),
+        VMSTATE_UINT32(prot_level, K230WdtState),
+        VMSTATE_BOOL(interrupt_pending, K230WdtState),
+        VMSTATE_BOOL(enabled, K230WdtState),
+        VMSTATE_UINT32(timeout_value, K230WdtState),
+        VMSTATE_UINT32(current_count, K230WdtState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void k230_wdt_realize(DeviceState *dev, Error **errp)
+{
+    K230WdtState *s = K230_WDT(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+    memory_region_init_io(&s->mmio, OBJECT(dev),
+                          &k230_wdt_ops, s,
+                          TYPE_K230_WDT,
+                          K230_WDT_MMIO_SIZE);
+    sysbus_init_mmio(sbd, &s->mmio);
+    sysbus_init_irq(sbd, &s->irq);
+
+    s->timer = ptimer_init(k230_wdt_timeout, s,
+                           PTIMER_POLICY_NO_IMMEDIATE_TRIGGER |
+                           PTIMER_POLICY_NO_IMMEDIATE_RELOAD |
+                           PTIMER_POLICY_NO_COUNTER_ROUND_DOWN);
+
+    ptimer_transaction_begin(s->timer);
+    ptimer_set_freq(s->timer, K230_WDT_DEFAULT_FREQ);
+    ptimer_transaction_commit(s->timer);
+}
+
+static void k230_wdt_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = k230_wdt_realize;
+    device_class_set_legacy_reset(dc, k230_wdt_reset);
+    dc->vmsd = &vmstate_k230_wdt;
+    dc->desc = "K230 watchdog timer";
+    set_bit(DEVICE_CATEGORY_WATCHDOG, dc->categories);
+}
+
+static const TypeInfo k230_wdt_info = {
+    .name          = TYPE_K230_WDT,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(K230WdtState),
+    .class_init    = k230_wdt_class_init,
+};
+
+static void k230_wdt_register_type(void)
+{
+    type_register_static(&k230_wdt_info);
+}
+type_init(k230_wdt_register_type)
diff --git a/hw/watchdog/meson.build b/hw/watchdog/meson.build
index 15370565bd..5edae65a36 100644
--- a/hw/watchdog/meson.build
+++ b/hw/watchdog/meson.build
@@ -6,5 +6,6 @@ system_ss.add(when: 'CONFIG_WDT_IB700', if_true: files('wdt_ib700.c'))
 system_ss.add(when: 'CONFIG_WDT_DIAG288', if_true: files('wdt_diag288.c'))
 system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('wdt_aspeed.c'))
 system_ss.add(when: 'CONFIG_WDT_IMX2', if_true: files('wdt_imx2.c'))
+system_ss.add(when: 'CONFIG_K230_WDT', if_true: files('k230_wdt.c'))
 system_ss.add(when: 'CONFIG_WDT_SBSA', if_true: files('sbsa_gwdt.c'))
 specific_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr_watchdog.c'))
diff --git a/hw/watchdog/trace-events b/hw/watchdog/trace-events
index ad3be1e9bd..d85b3ca769 100644
--- a/hw/watchdog/trace-events
+++ b/hw/watchdog/trace-events
@@ -33,3 +33,12 @@ spapr_watchdog_expired(uint64_t num, unsigned action) "num=%" PRIu64 " action=%u
 # watchdog.c
 watchdog_perform_action(unsigned int action) "action=%u"
 watchdog_set_action(unsigned int action) "action=%u"
+
+# k230_wdt.c
+k230_wdt_read(uint64_t addr, uint32_t data) "K230 WDT read: [0x%" PRIx64 "] -> 0x%" PRIx32
+k230_wdt_write(uint64_t addr, uint64_t data) "K230 WDT write: [0x%" PRIx64 "] <- 0x%" PRIx64
+k230_wdt_timeout(void) "K230 WDT timeout"
+k230_wdt_interrupt(void) "K230 WDT interrupt"
+k230_wdt_reset(void) "K230 WDT system reset"
+k230_wdt_restart(void) "K230 WDT restart"
+k230_wdt_reset_device(void) "K230 WDT device reset"
diff --git a/include/hw/riscv/k230.h b/include/hw/riscv/k230.h
index dcfde39096..592e1c26bf 100644
--- a/include/hw/riscv/k230.h
+++ b/include/hw/riscv/k230.h
@@ -17,6 +17,7 @@
 
 #include "hw/core/boards.h"
 #include "hw/riscv/riscv_hart.h"
+#include "hw/watchdog/k230_wdt.h"
 
 #define C908_CPU_HARTID   (0)
 
@@ -31,6 +32,7 @@ typedef struct K230SoCState {
     /*< public >*/
     RISCVHartArrayState c908_cpu; /* Small core */
 
+    K230WdtState wdt[2];
     MemoryRegion sram;
     MemoryRegion bootrom;
 
@@ -125,6 +127,8 @@ enum {
     K230_UART2_IRQ  = 18,
     K230_UART3_IRQ  = 19,
     K230_UART4_IRQ  = 20,
+    K230_WDT0_IRQ   = 107,
+    K230_WDT1_IRQ   = 108,
 };
 
 #define K230_UART_COUNT 5
diff --git a/include/hw/watchdog/k230_wdt.h b/include/hw/watchdog/k230_wdt.h
new file mode 100644
index 0000000000..ba194abebe
--- /dev/null
+++ b/include/hw/watchdog/k230_wdt.h
@@ -0,0 +1,121 @@
+/*
+ * K230 Watchdog Timer
+ *
+ * K230 Technical Reference Manual V0.3.1 (2024-11-18):
+ * https://github.com/revyos/external-docs/blob/master/K230/en-us/K230_Technical_Reference_Manual_V0.3.1_20241118.pdf
+ *
+ * Copyright (c) 2025 Mig Yang <temashking@foxmail.com>
+ * Copyright (c) 2025 Chao Liu <chao.liu.zevorn@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef K230_WDT_H
+#define K230_WDT_H
+
+#include "qemu/bitops.h"
+#include "hw/core/sysbus.h"
+#include "hw/core/irq.h"
+#include "hw/core/ptimer.h"
+#include "qom/object.h"
+
+#define TYPE_K230_WDT "riscv.k230.wdt"
+OBJECT_DECLARE_SIMPLE_TYPE(K230WdtState, K230_WDT)
+
+#define K230_WDT_DEFAULT_FREQ (32768)
+
+/* K230 Watchdog Register Map */
+enum K230WdtRegisters {
+    K230_WDT_CR      = 0x00,  /* Control Register */
+    K230_WDT_TORR    = 0x04,  /* Timeout Range Register */
+    K230_WDT_CCVR    = 0x08,  /* Current Counter Value Register */
+    K230_WDT_CRR     = 0x0c,  /* Counter Restart Register */
+    K230_WDT_STAT    = 0x10,  /* Interrupt Status Register */
+    K230_WDT_EOI     = 0x14,  /* Interrupt Clear Register */
+    K230_WDT_PROT_LEVEL = 0x1c, /* Protection Level Register */
+    K230_WDT_COMP_PARAM_5 = 0xe4, /* Component Parameters Register 5 */
+    K230_WDT_COMP_PARAM_4 = 0xe8, /* Component Parameters Register 4 */
+    K230_WDT_COMP_PARAM_3 = 0xec, /* Component Parameters Register 3 */
+    K230_WDT_COMP_PARAM_2 = 0xf0, /* Component Parameters Register 2 */
+    K230_WDT_COMP_PARAM_1 = 0xf4, /* Component Parameters Register 1 */
+    K230_WDT_COMP_VERSION = 0xf8, /* Component Version Register */
+    K230_WDT_COMP_TYPE = 0xfc, /* Component Type Register */
+};
+
+#define K230_WDT_MMIO_SIZE 0x100
+
+/* Control Register (WDT_CR) definitions */
+#define K230_WDT_CR_RPL_MASK    0x7        /* Reset Pulse Length */
+#define K230_WDT_CR_RPL_SHIFT   2
+#define K230_WDT_CR_RMOD        BIT(1)     /* Response Mode */
+#define K230_WDT_CR_WDT_EN      BIT(0)     /* Watchdog Enable */
+
+/* Reset Pulse Length values */
+#define K230_WDT_RPL_2_CYCLES   0x0
+#define K230_WDT_RPL_4_CYCLES   0x1
+#define K230_WDT_RPL_8_CYCLES   0x2
+#define K230_WDT_RPL_16_CYCLES  0x3
+#define K230_WDT_RPL_32_CYCLES  0x4
+#define K230_WDT_RPL_64_CYCLES  0x5
+#define K230_WDT_RPL_128_CYCLES 0x6
+#define K230_WDT_RPL_256_CYCLES 0x7
+
+/* Timeout Range Register (WDT_TORR) definitions */
+#define K230_WDT_TORR_TOP_MASK  0xf        /* Timeout Period */
+
+/* Interrupt Status Register (WDT_STAT) definitions */
+#define K230_WDT_STAT_INT       BIT(0)     /* Interrupt Status */
+
+/* Counter Restart Register (WDT_CRR) magic value */
+#define K230_WDT_CRR_RESTART    0x76       /* Restart command */
+
+/* Component Parameters Register 1 (WDT_COMP_PARAM_1) definitions */
+#define K230_WDT_CNT_WIDTH_MASK 0x1f000000 /* Counter Width */
+#define K230_WDT_CNT_WIDTH_SHIFT 24
+#define K230_WDT_DFLT_TOP_INIT_MASK 0xf00000 /* Default Initial Timeout */
+#define K230_WDT_DFLT_TOP_INIT_SHIFT 20
+#define K230_WDT_DFLT_TOP_MASK  0xf0000    /* Default Timeout */
+#define K230_WDT_DFLT_TOP_SHIFT 16
+#define K230_WDT_DFLT_RPL_MASK  0x7        /* Default Reset Pulse Length */
+#define K230_WDT_DFLT_RPL_SHIFT 10
+#define K230_WDT_APB_DATA_WIDTH_MASK 0x3   /* APB Data Width */
+#define K230_WDT_APB_DATA_WIDTH_SHIFT 8
+#define K230_WDT_USE_FIX_TOP    BIT(6)     /* Use Fixed Timeout Values */
+#define K230_WDT_HC_TOP         BIT(5)     /* Hard-coded Timeout */
+#define K230_WDT_HC_RPL         BIT(4)     /* Hard-coded Reset Pulse Length */
+#define K230_WDT_HC_RMOD        BIT(3)     /* Hard-coded Response Mode */
+#define K230_WDT_DUAL_TOP       BIT(2)     /* Dual Timeout Period */
+#define K230_WDT_DFLT_RMOD      BIT(1)     /* Default Response Mode */
+#define K230_WDT_ALWAYS_EN      BIT(0)     /* Always Enabled */
+
+/* Component Type Register value */
+#define K230_WDT_COMP_TYPE_VAL  0x44570120
+
+/* Component Version Register value */
+#define K230_WDT_COMP_VERSION_VAL 0x3131302a  /* "110*" */
+
+struct K230WdtState {
+    /* <private> */
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    MemoryRegion mmio;
+    qemu_irq irq;
+
+    struct ptimer_state *timer;
+
+    /* Register state */
+    uint32_t cr;           /* Control Register */
+    uint32_t torr;         /* Timeout Range Register */
+    uint32_t ccvr;         /* Current Counter Value Register */
+    uint32_t stat;         /* Interrupt Status Register */
+    uint32_t prot_level;   /* Protection Level Register */
+
+    /* Internal state */
+    bool interrupt_pending;
+    bool enabled;
+    uint32_t timeout_value;
+    uint32_t current_count;
+};
+
+#endif /* K230_WDT_H */
-- 
2.54.0


