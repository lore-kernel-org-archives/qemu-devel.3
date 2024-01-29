Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F619C48285
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 02:16:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUHBM-0006Ay-A4; Sun, 28 Jan 2024 21:15:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1rUHBF-00067c-8o; Sun, 28 Jan 2024 21:15:25 -0500
Received: from mail-bjschn02on20617.outbound.protection.partner.outlook.cn
 ([2406:e500:4440:2::617]
 helo=CHN02-BJS-obe.outbound.protection.partner.outlook.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1rUHBD-0002cP-Jq; Sun, 28 Jan 2024 21:15:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2OLsWlSY0PeWF16jEtTecAjVWgKuK+1CIdBi4PXwwsjTI8BpmEw7dcYHRiCdozY8HGbSYE1vuk5bDBBcnEG3iNhSTXR1crx5RaqkrPYAxwOIyz74egyc7qx0oWDsHSwR70IkAP2ERjLfO5wXmRdzVyAZDkxhY6tFU5VOncYIS8sIdtb7NuKyXLE0tr1+UmOQo+aTkcZgNpMiOsKin8puPDgScuiZCEYWYb/hwnsrjsXXFCmRranBA5ipogGPMWdgjTVqs+2n8H49qlEkSHJwQZu14eUHGRPPHYLs5eQhFfYQ5FM3YTt8j5YB4SYX69uGvMWWyzws4HJWTVNvjc8dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SWgcDjUyZMtL9DFUEv4cj7M9P0hs02oxETW145rxLtg=;
 b=jDDdva1Ft85ShabV/0yd0PFJPfjfwwXMxyltcJUGyNGo/nhqZZ42deuhw6aOuJ8l2788yDCv66u9GigIharX6VE7oZyr9Ar1WpUoxG7HnYtyp4nAf5xxsBZKv2fobwFVxv4Tft88fSkZQFwJLI6NkfvlAAkCwnzH86h+3aDCapPDrbOIQ4eqHfGHvjW0woxjb+GNhYFRf0+wVSDyDcjh0cEYPGVANgnwR2aUnqfF1EdaT7ijWtMMSQMXAbX6WHMIXfxBlqpwCRIm0VQ9jq3AGrLXvNsk6SruzWr+iD2GZsqqYU06Y+WJn8kOS7J0pxQd/zw9bZiEWIyjoNW0kKw/4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:f::16) by BJSPR01MB0852.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Mon, 29 Jan
 2024 02:15:06 +0000
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 ([fe80::3862:65b4:c857:c4a6]) by
 BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn ([fe80::3862:65b4:c857:c4a6%4])
 with mapi id 15.20.7228.029; Mon, 29 Jan 2024 02:15:06 +0000
From: Sia Jee Heng <jeeheng.sia@starfivetech.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 peter.maydell@linaro.org, jeeheng.sia@starfivetech.com,
 shannon.zhaosl@gmail.com, sunilvl@ventanamicro.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
Subject: [RESEND v2 2/2] hw/riscv/virt-acpi-build.c: Generate SPCR table
Date: Sun, 28 Jan 2024 18:14:40 -0800
Message-Id: <20240129021440.17640-3-jeeheng.sia@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129021440.17640-1-jeeheng.sia@starfivetech.com>
References: <20240129021440.17640-1-jeeheng.sia@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJSPR01CA0015.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:c::27) To BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJSPR01MB0561:EE_|BJSPR01MB0852:EE_
X-MS-Office365-Filtering-Correlation-Id: 47df6c40-79cb-490b-e121-08dc20701c2e
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 613OgWcW8E8FytSyX4w9i3qQF2Kl+L3McXRvYQTeDy1G4UMRJA1psDpfcZPBlpuuQ8kN4akJVdDTQnhSxOL2OttiKQlgk6itRP2OdXYJP+WAZgy4HW6MXAQ+OHadadEn2GMKWS/pX8q2pQUYht9QlVb7Gka2/QtTO0PnNsZQicWTgi9cSMlowsY9kZOip04DKrEYSVzr0kV7er+vdH9CL/OaEVQIK6bLoz0iVKDuQLty+mNE0OFJ17lTmnSSHuXHrY5iwudG9Q6a4H4ZLYHfvnQ7MGXTJ9PgmZ6cuUEVo3N5S5358ipup8tufnVmJDr2Ki0nSMfiMCD6MMnlREPhNTxif8Uy0TijdHvb8Bpoubjxccy8vA64XBY6cbPSNLWYkcUYw9bPxgSQsSoBow5MYbtsylQXfOwSRj+C+a9eiUndxb5/W4zFC7cQT2vOJPraXGQLzzFaB34LWPArfVnf+uJH2FWZRDwOIDh/zMJLHwTdZFEdP6nu0Cl3PvkjEDZWCjhOfA+A2iU4jxCd9yAkzmsm58IlIYK/cb40FUDIoJL0NZC+QyT+JN5XWJ5DKKKq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230031)(366004)(346002)(396003)(136003)(39830400003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(6666004)(36756003)(40180700001)(7416002)(5660300002)(2906002)(40160700002)(38100700002)(8936002)(8676002)(52116002)(4326008)(1076003)(508600001)(41300700001)(86362001)(66476007)(66946007)(26005)(2616005)(66556008)(41320700001)(38350700005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?czNbn0d4GGWgaG4Fwc5qdODVw/8r/gala87EZX1vQ1HRli0AXUuNh8vc7six?=
 =?us-ascii?Q?Emj4Oy4Mf5FzCJUQbWVcRQtPFJsGfvRpW2onG6y3QvzrlbXQc9mKvH09jlge?=
 =?us-ascii?Q?RUarlrNgJ91P1xH06xicKQi3MJDhLNlFhxFNiC/gpnrb9jNs5fgTJLKQ3jfk?=
 =?us-ascii?Q?77L9aqNFIeDPg7JvMGm8/yFoAJckUFfa5jgmCh58CVyJjRVI14h/5CW5NKxT?=
 =?us-ascii?Q?Y0deEOsHpWqwvLNbKg90JKBKkRlJfvcuhMJtulDJo3i4DF6H2EmyJ1mjwrKY?=
 =?us-ascii?Q?nmLETeR/7gRouiDEVQ6bfqg3yCBxLm/eolgZmDRkmAKJyZv4RaB2LeWR2p8I?=
 =?us-ascii?Q?G8REoc9S7VGEWeehGXwEwbfLsgJS6pHShyOrulJHd5X5gBrUatO7ADVdkhxX?=
 =?us-ascii?Q?gu6KsA+Fjxg0Sc82vLvhDxn8PMUnN+DejHowjEmt23NqNRLoY+xPswwdZy4U?=
 =?us-ascii?Q?FOTw9ql4+dfYivLkyjTa3QgxsHbCgVQWPeTqeilr2+oNnX6hu8m6HUUHWbJ7?=
 =?us-ascii?Q?FZos8i6dFiu3eA7uFlHFvC1MkQp+GlgYdgHTf6vZg12AwrF8oFwu+as7fSMU?=
 =?us-ascii?Q?XpadSRaeM9wYwxwXCn88EBDi/zPx+0YFNHYouhGWai+D4JOWZE8ViSxDJLdI?=
 =?us-ascii?Q?HpESfVqeEgsgdNXbQMo81UqsmHMj0hjFy9KfspOyHpOvMpnzPcVRzfqcB0tN?=
 =?us-ascii?Q?8BtwU/ZBZ1JaQE87YWWcHiXed2v+Hi03qUzZiVZ8w37uePa7GkAlIV86rbgG?=
 =?us-ascii?Q?HKKR9NIHEuaqtEOgJ0Wx0BpGfGamUCsSvTVzdRO48lEBiRaeVxYhv67PQIHB?=
 =?us-ascii?Q?pjPlPqHKLB3zbbveUwUlN5HAlhici+q+q2yKd6JwycXcxCyd/ScXBoJ0I/XK?=
 =?us-ascii?Q?YNloTBW0KsTVaKcvARH8nzWq9VRFMinwanVdjP9/OKBzD1lb44lbeEe0X/9/?=
 =?us-ascii?Q?72mAiNpZ7p0smVwTmKkXXiIfTf8ozjQPtXFp75ASLXSaGGqMXFIPEbVaRoAg?=
 =?us-ascii?Q?apgiTPGH/FePx3bKFuZKenjuhOYaDOUcs2ZelL7lskh/Y4E+pyjcCygyMVh1?=
 =?us-ascii?Q?dOnHHvtesEU77UX54IUc7O4IZuSpsFppPt+ST38y806V2/D1aDqxLOM+NhWD?=
 =?us-ascii?Q?4Gh1AsLY9gZXW6ID0rsGIfhhSmzk4i3II7yrKWFDDS4e9bOzLhHaHBGdC3Zq?=
 =?us-ascii?Q?e5CzdbpmBRpVVRd7hKx0+IQVwXCg+OhWT/8Q/sdEmYuYTI3ayOzjrBcwDein?=
 =?us-ascii?Q?L7p3GnBqtoShGXzx9GOu5pryipLPoevdpYGP2IwWfAEXbcra04ZLuAGENDRN?=
 =?us-ascii?Q?Vp6F076u+QOf1LYG59+jJGfoibWtvgW1CDuBoBBTXLNWMXuNXIrL4T96UesX?=
 =?us-ascii?Q?G9UTdB+YI0cbDR4PtLR86HdLlfpgt8Sh3oHmE+xH2mw8rN4svISdW7oSYhJQ?=
 =?us-ascii?Q?qBuDDSgTW29fd2sX12VrU86ehcUDA0ZoEzHjt/uHlYOdaG2d3gqV8OQLH6uR?=
 =?us-ascii?Q?hgZn/jXbIVwLMeQprUUAw1iYFYXiR3e40XZqUZ/GpHQ2Y4Tm/VRYUbDAySsw?=
 =?us-ascii?Q?Z10+N/9AiDVLOARsjEI4HImi+oN+/V0TPicA8SUD5gM4KFscf4zRYVvaeZWE?=
 =?us-ascii?Q?jw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47df6c40-79cb-490b-e121-08dc20701c2e
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 02:15:06.3903 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zp1X2m5XJqo5CSADrXvsxyyoszLenzCnZiLsyZAjmIdN5VV3cYNGMUS0GmD8CyhN20Fr7QKcAoiVzidAQggMN7NhB1EW2a7+7GMH0yMS6yg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJSPR01MB0852
Received-SPF: pass client-ip=2406:e500:4440:2::617;
 envelope-from=jeeheng.sia@starfivetech.com;
 helo=CHN02-BJS-obe.outbound.protection.partner.outlook.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Generate Serial Port Console Redirection Table (SPCR) for RISC-V
virtual machine.

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/virt-acpi-build.c | 39 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 26c7e4482d..7fc5071c84 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -174,6 +174,42 @@ acpi_dsdt_add_uart(Aml *scope, const MemMapEntry *uart_memmap,
     aml_append(scope, dev);
 }
 
+/*
+ * Serial Port Console Redirection Table (SPCR)
+ * Rev: 1.07
+ */
+
+static void
+spcr_setup(GArray *table_data, BIOSLinker *linker, RISCVVirtState *s)
+{
+    AcpiSpcrData serial = {
+        .interface_type = 0,       /* 16550 compatible */
+        .base_addr.id = AML_AS_SYSTEM_MEMORY,
+        .base_addr.width = 32,
+        .base_addr.offset = 0,
+        .base_addr.size = 1,
+        .base_addr.addr = s->memmap[VIRT_UART0].base,
+        .interrupt_type = (1 << 4),/* Bit[4] RISC-V PLIC/APLIC */
+        .pc_interrupt = 0,
+        .interrupt = UART0_IRQ,
+        .baud_rate = 7,            /* 15200 */
+        .parity = 0,
+        .stop_bits = 1,
+        .flow_control = 0,
+        .terminal_type = 3,        /* ANSI */
+        .language = 0,             /* Language */
+        .pci_device_id = 0xffff,   /* not a PCI device*/
+        .pci_vendor_id = 0xffff,   /* not a PCI device*/
+        .pci_bus = 0,
+        .pci_device = 0,
+        .pci_function = 0,
+        .pci_flags = 0,
+        .pci_segment = 0,
+    };
+
+    build_spcr(table_data, linker, &serial, 2, s->oem_id, s->oem_table_id);
+}
+
 /* RHCT Node[N] starts at offset 56 */
 #define RHCT_NODE_ARRAY_OFFSET 56
 
@@ -555,6 +591,9 @@ static void virt_acpi_build(RISCVVirtState *s, AcpiBuildTables *tables)
     acpi_add_table(table_offsets, tables_blob);
     build_rhct(tables_blob, tables->linker, s);
 
+    acpi_add_table(table_offsets, tables_blob);
+    spcr_setup(tables_blob, tables->linker, s);
+
     acpi_add_table(table_offsets, tables_blob);
     {
         AcpiMcfgInfo mcfg = {
-- 
2.34.1


