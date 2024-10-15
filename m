Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D0AD216A2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 13:27:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0hZS-00043l-0R; Tue, 15 Oct 2024 09:26:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1t0hZP-00043A-FM; Tue, 15 Oct 2024 09:26:39 -0400
Received: from mail-bn8nam11on2061b.outbound.protection.outlook.com
 ([2a01:111:f403:2414::61b]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1t0hZN-0002Rz-83; Tue, 15 Oct 2024 09:26:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PCjwDsHkpEmwr6CZwWJ9h9rOxmNkBIyEDUGl9X0xzuqo0wjyuNHoiu+BPkhPb7k3aw/1ndxlJQ7clLZ1OQNs+LUbuadBHR4zs/TvYu3SHQo3w25S3oM2e8DW5kaSZv/Y889o6TQpV9kPajXKGcqsiKcvNSgTN60d5CjzIB0IGVMN5AinGe6GNHclfaqAgb+W6P10Uc0ET7BjyXgk03YabbZm5oJ3THCg8/O4zdVcwSh/EVe4opofFzlaYmf2VJFweQPYTTd5ozmS/pR+ocvaS0NxWXBi7mGYrB5vnF+OdBwlbnJd4+tUqOubnX3eQi+xLNiT7/4FeI0SF2Q8biG9KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iRzH9j94V4sn35+LKq4qSOjDpH2+taA5FLAIRPlunng=;
 b=jmv5AfzJ4GzVBOA5JUp9xmodMeP/ohTxqtLuHABypm+eLwxDUlBCJOS8gkOpt6vkBe/W2sXDvOGwrNln912nHZDhjguZdwQuGcqMCqY5UmbW/eYoLRKrXRvzHNyyroPm196+J4caluJKALX/zEl7cj72nJZX7D+JkpLvV4Q36u+P0rFbouGYR5C1Jk+yHbsqeuyTemdArFJ2wkEovLmoY+5uHv4XykT7/UBtCVfQW9bVaMl5maX0z9/WK5KRZGB5wCvqtMfysgm7czy5CVjLaMaRw1FXVfQ2cDXnu0soJVD04kbrzTz8aYYcF9mt9eEs2DHo7RRz/9sQaGz/jYtggg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iRzH9j94V4sn35+LKq4qSOjDpH2+taA5FLAIRPlunng=;
 b=3gaUiSKZnMOjqsTw4Ld+wn9uyGTDrM5i9mxmmc5qxLMGkafFWW5TZmMNGaguU8R2jLn6ep6L6aCZ17ZyyaMi4LYTMCaNJnPhCeYI7BcDvKzoPIWYR8bxbY43JiHF7d3JL2LTyCPqP63skCEWfx/kgyqXXFtDnO8Y3Cfbf8ozFEw=
Received: from PH8PR07CA0017.namprd07.prod.outlook.com (2603:10b6:510:2cd::28)
 by IA0PR12MB7650.namprd12.prod.outlook.com (2603:10b6:208:436::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.29; Tue, 15 Oct
 2024 13:26:29 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:510:2cd:cafe::b4) by PH8PR07CA0017.outlook.office365.com
 (2603:10b6:510:2cd::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Tue, 15 Oct 2024 13:26:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 13:26:28 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Oct
 2024 08:26:28 -0500
Received: from xhdsaipava41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Tue, 15 Oct 2024 08:26:26 -0500
From: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis
 <alistair@alistair23.me>, Peter Maydell <peter.maydell@linaro.org>, "Jason
 Wang" <jasowang@redhat.com>, Francisco Iglesias <francisco.iglesias@amd.com>
Subject: [PATCH] hw/net: Extend ethernetlite driver with PHY layer
Date: Tue, 15 Oct 2024 18:56:22 +0530
Message-ID: <20241015132622.3468066-1-sai.pavan.boddu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: sai.pavan.boddu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|IA0PR12MB7650:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b0f80fe-bb6d-4291-34e1-08dced1cfa0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AKaDQDkXLEjwxBXdz7Jno+BsPOi7l/d8dtW/zdTWLZr0Tbg4Cz322EQeE9l9?=
 =?us-ascii?Q?s/i0HhcRS+R6X/bxZk0xoGIAK43OLCOsA32l/8z0SAwfnK0tdgYqoIV+FFwh?=
 =?us-ascii?Q?eeAI389Q/btbiDuYjrMlpu4gd32tQMpbIowCwSaxdrTekp+tKLsAHHknnxAu?=
 =?us-ascii?Q?f+W295SlOWKNInveoBVJu8oO91ZWl4yp6J+K9P71czFQZfmgZfX+xnC7b/dQ?=
 =?us-ascii?Q?OioXI1at76JEgd4IvnjobJAuyjsucMOKFJrgUd9ijkT767ObyS07p4UNlnHW?=
 =?us-ascii?Q?fz0zwwBx4IYOdV6AZIwmFwKLmlEu3pdS9sBEn/+u77ME+kXO24th9K/EWlCV?=
 =?us-ascii?Q?JrnoRpkmF4fsM4RIV0r/FC1CGGCCE0SURgnWkhuTQ1Ouo4ytuRm1ZVLlP2Vv?=
 =?us-ascii?Q?RVzD+DT2AGrJJkUOP+SEwwGwaxp1fqbFzMgu21fnn/UFG5iIMolai4y2bpj1?=
 =?us-ascii?Q?LEqoD5Umumkv4zwfsTIQz+TEfWtHB2QMQvI0Qww8Rvt9vqVV6AIj106FF538?=
 =?us-ascii?Q?h91JEDqTQ5CFCOJhEMC2C6mL2UX8PAs4gXZcnWHJkvMTclP1HCkeHAIjEkUb?=
 =?us-ascii?Q?20aUsQSCEaolV1XlLcf8cs7TAcOpg82C7eWvqUg2PYMAyu5NYKZvyxpKSbbN?=
 =?us-ascii?Q?LZPB/70fCD0fFX+pMCN8Y4ltpKd8yXiwPbI/FTP3GpcrNOidxN3aUPvkVaz/?=
 =?us-ascii?Q?WcJOcOCJU0AK6y4ImroEE9k6h/btT3rrHHpaX9RyV+UklnpGdtfVDqk5fAiG?=
 =?us-ascii?Q?Bs3i2mxznKcB1tEEXHCr4154jFTsJNAwyepIAdQh93oi0o29vs3zeryy5R5y?=
 =?us-ascii?Q?Ov3JyE15ai3e/m/SJPyNPxksDDpbVx3rXBVFgnTVp5uFiz5MNluIkz2GVqUT?=
 =?us-ascii?Q?5bP4ud9Wlih4w5Lh5kguz+YNE2s6yKzkg/tug+qcQnHpFTBvn4TeqvRUa9pw?=
 =?us-ascii?Q?nrgplHqn9XR6tT+D6ja+k5DgbU/PrCTT8Ox3U10GtMEByeehuATWCPoyERr5?=
 =?us-ascii?Q?0qoLzhi5Q3gGst9qYzD2H8QKFRbWu74lQqfNsBG0cggkSvMIHx1lfl4EHvC3?=
 =?us-ascii?Q?shX77fWTH6HXBJrbPiunt67KfvhyiI8CfnMnYPupJc6+1LQBhyR55RliUI+D?=
 =?us-ascii?Q?fNdXPrEX8BA8XPs5iyJsh4BUQg9Z4KdTrJ1KE96RtAEHMp23rSrdpelRt+zK?=
 =?us-ascii?Q?xX4eEYOrNgb90CUxb5u7uKOUNK4cDXTyjUe8G1VA8a7VJM7pCS2XpMsPMKqb?=
 =?us-ascii?Q?hxoQDUbt75VxFNN5+uAlLtlnFQcHNYi7yaznTQMLCegO6AVlXe0tEFgrxGyH?=
 =?us-ascii?Q?xJvLzk6+AmR36DDe6QIS5/Na7u4xDLC1CnXhHaLUHyVVXbFLKrsMA8qgbgiR?=
 =?us-ascii?Q?dsjIqJKwHxhSUxZa2QOPe/PRtmZF?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 13:26:28.8110 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b0f80fe-bb6d-4291-34e1-08dced1cfa0b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7650
Received-SPF: permerror client-ip=2a01:111:f403:2414::61b;
 envelope-from=sai.pavan.boddu@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: 3
X-Spam_score: 0.3
X-Spam_bar: /
X-Spam_report: (0.3 / 5.0 requ) AC_FROM_MANY_DOTS=2.499, BAYES_00=-1.9,
 DKIMWL_WL_HIGH=-0.063, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Michal Simek <michal.simek@amd.com>

Add missing optional MDIO lines. Without it U-Boot is not working.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---
 hw/net/xilinx_ethlite.c | 240 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 240 insertions(+)

diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index bd812908085..5b129ca7e4e 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -56,6 +56,215 @@
 DECLARE_INSTANCE_CHECKER(struct xlx_ethlite, XILINX_ETHLITE,
                          TYPE_XILINX_ETHLITE)
 
+#define R_MDIOADDR (0x07E4 / 4)  /* MDIO Address Register */
+#define R_MDIOWR (0x07E8 / 4)    /* MDIO Write Data Register */
+#define R_MDIORD (0x07EC / 4)    /* MDIO Read Data Register */
+#define R_MDIOCTRL (0x07F0 / 4)  /* MDIO Control Register */
+
+/* MDIO Address Register Bit Masks */
+#define R_MDIOADDR_REGADR_MASK  0x0000001F  /* Register Address */
+#define R_MDIOADDR_PHYADR_MASK  0x000003E0  /* PHY Address */
+#define R_MDIOADDR_PHYADR_SHIFT 5
+#define R_MDIOADDR_OP_MASK      0x00000400    /* RD/WR Operation */
+
+/* MDIO Write Data Register Bit Masks */
+#define R_MDIOWR_WRDATA_MASK    0x0000FFFF /* Data to be Written */
+
+/* MDIO Read Data Register Bit Masks */
+#define R_MDIORD_RDDATA_MASK    0x0000FFFF /* Data to be Read */
+
+/* MDIO Control Register Bit Masks */
+#define R_MDIOCTRL_MDIOSTS_MASK 0x00000001   /* MDIO Status Mask */
+#define R_MDIOCTRL_MDIOEN_MASK  0x00000008   /* MDIO Enable */
+
+/* Advertisement control register. */
+#define ADVERTISE_10HALF        0x0020  /* Try for 10mbps half-duplex  */
+#define ADVERTISE_10FULL        0x0040  /* Try for 10mbps full-duplex  */
+#define ADVERTISE_100HALF       0x0080  /* Try for 100mbps half-duplex */
+#define ADVERTISE_100FULL       0x0100  /* Try for 100mbps full-duplex */
+
+#define DPHY(x)
+
+struct PHY {
+    uint32_t regs[32];
+
+    int link;
+
+    unsigned int (*read)(struct PHY *phy, unsigned int req);
+    void (*write)(struct PHY *phy, unsigned int req,
+                  unsigned int data);
+};
+
+static unsigned int tdk_read(struct PHY *phy, unsigned int req)
+{
+    int regnum;
+    unsigned r = 0;
+
+    regnum = req & 0x1f;
+
+    switch (regnum) {
+    case 1:
+        if (!phy->link) {
+            break;
+        }
+        /* MR1.  */
+        /* Speeds and modes.  */
+        r |= (1 << 13) | (1 << 14);
+        r |= (1 << 11) | (1 << 12);
+        r |= (1 << 5); /* Autoneg complete.  */
+        r |= (1 << 3); /* Autoneg able.  */
+        r |= (1 << 2); /* link.  */
+        r |= (1 << 1); /* link.  */
+        break;
+    case 5:
+        /*
+         * Link partner ability.
+         * We are kind; always agree with whatever best mode
+         * the guest advertises.
+         */
+        r = 1 << 14; /* Success.  */
+        /* Copy advertised modes.  */
+        r |= phy->regs[4] & (15 << 5);
+        /* Autoneg support.  */
+        r |= 1;
+        break;
+    case 17:
+        /* Marvel PHY on many xilinx boards.  */
+        r = 0x4c00; /* 100Mb  */
+        break;
+    case 18:
+        {
+            /* Diagnostics reg.  */
+            int duplex = 0;
+            int speed_100 = 0;
+            if (!phy->link) {
+                break;
+            }
+            /* Are we advertising 100 half or 100 duplex ? */
+            speed_100 = !!(phy->regs[4] & ADVERTISE_100HALF);
+            speed_100 |= !!(phy->regs[4] & ADVERTISE_100FULL);
+            /* Are we advertising 10 duplex or 100 duplex ? */
+            duplex = !!(phy->regs[4] & ADVERTISE_100FULL);
+            duplex |= !!(phy->regs[4] & ADVERTISE_10FULL);
+            r = (speed_100 << 10) | (duplex << 11);
+        }
+        break;
+
+    default:
+        r = phy->regs[regnum];
+        break;
+    }
+    DPHY(qemu_log("\n%s %x = reg[%d]\n", __func__, r, regnum));
+    return r;
+}
+
+static void
+tdk_write(struct PHY *phy, unsigned int req, unsigned int data)
+{
+    int regnum;
+
+    regnum = req & 0x1f;
+    DPHY(qemu_log("%s reg[%d] = %x\n", __func__, regnum, data));
+    switch (regnum) {
+    default:
+        phy->regs[regnum] = data;
+        break;
+    }
+
+    /* Unconditionally clear regs[BMCR][BMCR_RESET] */
+    phy->regs[0] &= ~0x8000;
+}
+
+static void
+tdk_init(struct PHY *phy)
+{
+    phy->regs[0] = 0x3100;
+    /* PHY Id.  */
+    phy->regs[2] = 0x0141;
+    phy->regs[3] = 0x0cc2;
+    /* Autonegotiation advertisement reg.  */
+    phy->regs[4] = 0x01E1;
+    phy->link = 1;
+
+    phy->read = tdk_read;
+    phy->write = tdk_write;
+}
+
+struct MDIOBus {
+    /* bus.  */
+    int mdc;
+    int mdio;
+
+    /* decoder.  */
+    enum {
+        PREAMBLE,
+        SOF,
+        OPC,
+        ADDR,
+        REQ,
+        TURNAROUND,
+        DATA
+    } state;
+    unsigned int drive;
+
+    unsigned int cnt;
+    unsigned int addr;
+    unsigned int opc;
+    unsigned int req;
+    unsigned int data;
+
+    struct PHY *devs[32];
+};
+
+static void
+mdio_attach(struct MDIOBus *bus, struct PHY *phy, unsigned int addr)
+{
+    bus->devs[addr & 0x1f] = phy;
+}
+
+#ifdef USE_THIS_DEAD_CODE
+static void
+mdio_detach(struct MDIOBus *bus, struct PHY *phy, unsigned int addr)
+{
+    bus->devs[addr & 0x1f] = NULL;
+}
+#endif
+
+static uint16_t mdio_read_req(struct MDIOBus *bus, unsigned int addr,
+                  unsigned int reg)
+{
+    struct PHY *phy;
+    uint16_t data;
+
+    phy = bus->devs[addr];
+    if (phy && phy->read) {
+        data = phy->read(phy, reg);
+    } else {
+        data = 0xffff;
+    }
+    DPHY(qemu_log("%s addr=%d reg=%d data=%x\n", __func__, addr, reg, data));
+    return data;
+}
+
+static void mdio_write_req(struct MDIOBus *bus, unsigned int addr,
+               unsigned int reg, uint16_t data)
+{
+    struct PHY *phy;
+
+    DPHY(qemu_log("%s addr=%d reg=%d data=%x\n", __func__, addr, reg, data));
+    phy = bus->devs[addr];
+    if (phy && phy->write) {
+        phy->write(phy, reg, data);
+    }
+}
+
+struct TEMAC  {
+    struct MDIOBus mdio_bus;
+    struct PHY phy;
+
+    void *parent;
+};
+
 struct xlx_ethlite
 {
     SysBusDevice parent_obj;
@@ -70,6 +279,9 @@ struct xlx_ethlite
     unsigned int txbuf;
     unsigned int rxbuf;
 
+uint32_t c_phyaddr;
+    struct TEMAC TEMAC;
+
     uint32_t regs[R_MAX];
 };
 
@@ -101,11 +313,15 @@ eth_read(void *opaque, hwaddr addr, unsigned int size)
             r = s->regs[addr];
             D(qemu_log("%s " HWADDR_FMT_plx "=%x\n", __func__, addr * 4, r));
             break;
+        case R_MDIOCTRL:
+            r = s->regs[addr] & (~R_MDIOCTRL_MDIOSTS_MASK); /* Always ready.  */
+            break;
 
         default:
             r = tswap32(s->regs[addr]);
             break;
     }
+    D(qemu_log("%s " HWADDR_FMT_plx "=%x\n", __func__, addr * 4, r));
     return r;
 }
 
@@ -159,6 +375,26 @@ eth_write(void *opaque, hwaddr addr,
                        __func__, addr * 4, value));
             s->regs[addr] = value;
             break;
+        case R_MDIOCTRL:
+            if (((unsigned int)value & R_MDIOCTRL_MDIOSTS_MASK) != 0) {
+                struct TEMAC *t = &s->TEMAC;
+                unsigned int op = s->regs[R_MDIOADDR] & R_MDIOADDR_OP_MASK;
+                unsigned int phyaddr = (s->regs[R_MDIOADDR] &
+                    R_MDIOADDR_PHYADR_MASK) >> R_MDIOADDR_PHYADR_SHIFT;
+                unsigned int regaddr = s->regs[R_MDIOADDR] &
+                    R_MDIOADDR_REGADR_MASK;
+                if (op) {
+                    /* read PHY registers */
+                    s->regs[R_MDIORD] = mdio_read_req(
+                        &t->mdio_bus, phyaddr, regaddr);
+                } else {
+                    /* write PHY registers */
+                    mdio_write_req(&t->mdio_bus, phyaddr, regaddr,
+                        s->regs[R_MDIOWR]);
+                }
+            }
+            s->regs[addr] = value;
+            break;
 
         default:
             s->regs[addr] = tswap32(value);
@@ -238,6 +474,9 @@ static void xilinx_ethlite_realize(DeviceState *dev, Error **errp)
                           object_get_typename(OBJECT(dev)), dev->id,
                           &dev->mem_reentrancy_guard, s);
     qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
+
+    tdk_init(&s->TEMAC.phy);
+    mdio_attach(&s->TEMAC.mdio_bus, &s->TEMAC.phy, s->c_phyaddr);
 }
 
 static void xilinx_ethlite_init(Object *obj)
@@ -252,6 +491,7 @@ static void xilinx_ethlite_init(Object *obj)
 }
 
 static Property xilinx_ethlite_properties[] = {
+    DEFINE_PROP_UINT32("phyaddr", struct xlx_ethlite, c_phyaddr, 7),
     DEFINE_PROP_UINT32("tx-ping-pong", struct xlx_ethlite, c_tx_pingpong, 1),
     DEFINE_PROP_UINT32("rx-ping-pong", struct xlx_ethlite, c_rx_pingpong, 1),
     DEFINE_NIC_PROPERTIES(struct xlx_ethlite, conf),
-- 
2.34.1


