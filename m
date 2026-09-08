Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F9DC79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 10:43:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3tHs-00087s-OT; Tue, 08 Sep 2026 06:42:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x3tHr-00087M-ED; Tue, 08 Sep 2026 06:42:47 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x3tHp-0006ZW-VH; Tue, 08 Sep 2026 06:42:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gJ1qUvzEMoz2dDWzp5KG9wcqhGVN7c2ijTVRoLuYKu2jYy0DXDHNoedUX53YX008P+sD0aoy+TwA+VLLzdmUfURvd2J2JwMI/QHfSsqUWvwxQc0OrhVVVcIZGswAcIQkPPDXJXln4sQTFL2lBxEqmD/Zrp+oRdYZQ5CPyYd3z0V5Eg6rU07SyDx+tZkP4znjlezOeLW5oNowe23RMGyfFtRQs0858VJvG7L6YENN4MbFlkbsA4f341Urq5v/x54smLiJoq50lRFWMs4I2j4fPYL/4oBpjf2pFO/B+P76v3WhAQW9s42qDFolYUZtFBUs26cHDvqLNplXzoceMvj7kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3sVUpoBK3a0UOMNTayMU8TRAgrqRxmgn+jwY8hIxxcU=;
 b=ay4wlsWSAYq9Uuz73CPl6v1J1Xf8PqUUB4DWXkkFNWlnLtLj4ZDwyenPMt2ltZvOG1kb5lyoWVJuMBbwbencU1TDU6jqLlbCl3Vi9mW3N48opAW2xmqG3FX8qWjsK3qpRPVOWOgcc6nL/0sZKda47S47aGTbHTaY3/Yga1aqkTqRwkLJflnAu4SCOuu3XlezZaCgS8hMa7dMDB+8RqZxKyh41X4EjDFgod111Eqk5Kb/g5cqAQEbtIuDRnczISp5CIRRmEodolXM7Slce+zDj5PkvJZUiGlnKvSVxB5a3c1dWSTcBPNZtBefh4rystjphpiqBcAxNKU5XTAjHgFhbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3sVUpoBK3a0UOMNTayMU8TRAgrqRxmgn+jwY8hIxxcU=;
 b=TgzbQnvOmshsDm3Qyox4BqEhFWLldnqNoANESeWV3Lx5C4uT8cL5jObRFsodWerwdiDaCqmOpOt1gjrFs7dZzigvD3fKIHZHSH0IC8P0uVJhJDknBBQ0yfqmB2ItHAKeGtIOswHVQQN9Wlpcz62Ljc9SxG6xbRTF3h/dKLUJSy2AhBX1y+ReLvGYrI2lT7SG6aoc25Z8fJTk6N3jajFaSnxfXTzoozomIVMKEVy3j0Og22KXARFeMg23CxDBlkW1Kj7jbMd7FhyKXltfYBGFEbDnbVqbkcdVXgXAsaU1EJG9JAt/plcH8tjeu8VjPzk1FoDotalSGeZTkRo1c4Bhag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from PSAPR02MB4984.apcprd02.prod.outlook.com (2603:1096:301:78::7)
 by OSQPR02MB7928.apcprd02.prod.outlook.com (2603:1096:604:291::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 10:42:33 +0000
Received: from PSAPR02MB4984.apcprd02.prod.outlook.com
 ([fe80::fd75:bbda:6f27:c616]) by PSAPR02MB4984.apcprd02.prod.outlook.com
 ([fe80::fd75:bbda:6f27:c616%6]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 10:42:33 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org
Subject: [PATCH v2 09/32] hw/arm: phytium: Connect the Phytium E2000 DDR
 controller
Date: Tue,  8 Sep 2026 18:41:18 +0800
Message-ID: <20260908104159.1621764-10-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908104159.1621764-1-bin.meng@processmission.com>
References: <20260908104159.1621764-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0041.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::15) To PSAPR02MB4984.apcprd02.prod.outlook.com
 (2603:1096:301:78::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR02MB4984:EE_|OSQPR02MB7928:EE_
X-MS-Office365-Filtering-Correlation-Id: 49677342-bfba-4f42-5b5c-08df0d95e3a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|6133799003|3023799007|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: OwTlsXMoHiWz/tnN/sw89OQ2fZnSXN6FAKSVixwTEMv0N9Dbk/1CKRpkedu5qqQ3+aO8kAh1gXifpsEzcysOHKdXNmh7L0/AFJKCM9CnM241dHaqZY817I3PyHQipP2YLAgbMo5nNH3fCWG9jyxwPV/wtqEK5yC+nC8xpGa2/Wsx5uUq5EmBavQdUrlCaoyTEUSfaMqIKS1mcN3BQC4Glja709NujDwMKJmJvL8ZBUyK0dxVpmWvdoUWtG+8myDt7pQ9OBB+iwO8bRWacgihpTdTYAgo9TWWql6HMm6kZIhfqZVlh25l5hSznHr2eR+DnSVhS/FKVKByD61UYaCoL1IJfWwzo5U1Xv9E9g5pD2R5qoUKnUAK+piBPmF70h9xCREnu32NjgyCXlRIyA7HFX8kc3HbrufA0PvRD4jBxObRuX1rcWowY6pdIGAdUDyF7n886HBRB7JsBAh8PFwhxTf6j/eHNR4S9VRRn+Hf5CgOhZEDrZd1w6HOxpVOTr6LcBBeprd1+GDj2xVB2tCX+l2XJJrLZUmkhH0bgq/0Dgipp1s81Y4RoLdJ+YUiHvQq7Dw8dApNgPyoUKz/caIe+yxS0enkGR+K/T+GcLGxu/spiw6ufAxSzl6Sm2DKMcgVFndKY6AZeijaegtl5AaU0Snu0JG5A8muCUBwsmp7Yes=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PSAPR02MB4984.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(6133799003)(3023799007)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xjxem+BoBjhu7pSZlm5rW+426rsuJpLyDaPh1HhSBjWJeqQ2exENsYrtJe02?=
 =?us-ascii?Q?HI4YJHLZPljR5qX3MqXYZLg1XJef4ZLxGHef56w9dQIoT2mcg31QFB7N8nxI?=
 =?us-ascii?Q?1ppC5cY4IpI5/jHXSsSC9k4kaqCCnlAfgzRuxA2CfzFaesm61afMTrKBJfvG?=
 =?us-ascii?Q?RKFU+D1viRopdDy8nreBjnHy9vsPAbHuFpKvR3EqFrZfWQmeAaayZu2oEclZ?=
 =?us-ascii?Q?4URw2mbs2uQgNU5AI7YR/0dqBcp8hYZ2zMp4oVOPYA2lerYwHV2TLJ7aOODW?=
 =?us-ascii?Q?Qpvd7r+d29I0bmT3jyOq6SoMSO4UFwsItRSUkFVKz7pvBhHXYYfbPuf97Ssx?=
 =?us-ascii?Q?29b+z+Jz7OhYG6IdfqdPkrvo4eMhR+jNY64P8TyDxTLt8CE15Psrbp14LZJp?=
 =?us-ascii?Q?sjVxuikoISMNrTVAGYFy1XhhvGR5WH9tCIuay4GMiJGAjoqkN17PQSdjuP4z?=
 =?us-ascii?Q?OdB1+IW6/OYugnH9k7UTe5mQN+garjcmoJUYSNsWCPjQ37FmDBh5PwFhkKbJ?=
 =?us-ascii?Q?/WOZmouJqWeays5DZBv46Bq5lygsixHpn1Aw96wc+lGRRYZHe2xDQ1/Wskzk?=
 =?us-ascii?Q?dC7VLw5rUWeluh08Ca2i+lenDKazpVRMWn2osHS91MREfo6fHvNiDJa5AQ6w?=
 =?us-ascii?Q?BLSdPBxVENKK6j22bqydIl+3rSuGVCJg/D15dlwTPBNCAxFTrFFSUQyod5sQ?=
 =?us-ascii?Q?ZmECcWAvhOXprsq1s3J4K508D6CDRiWUZTBQc7Z90jdygeNpd8Mkof6lkll2?=
 =?us-ascii?Q?edJNc2P1nRpW/toLY0I4zS4D8eX/MfuaHWc6tyf9WYyAaCJD4ohXrpZdDEhS?=
 =?us-ascii?Q?oKxavL4h7ILcmfWGxcNmHb9w2Q25dPsWw1RgscnA74KOztA0BTRTHPPwTmcp?=
 =?us-ascii?Q?67lyqkw9psjcYaBIPzWU6Ia2xqtgVqAtV09Rd1xIPvK5wWBI+MRE0XBV4wd3?=
 =?us-ascii?Q?hLSzfSmb6zZImgQSkClU7jUyQ0UM6+C4FrqP1kxq3yECZGcj5iHnAXPFIXJf?=
 =?us-ascii?Q?Cjwkl+UVlWPcJKWRevhDhq52G0yg53AcwDeei3CiBSlMMWbBbGxQP3orFxTD?=
 =?us-ascii?Q?uikKLcT8vZv1OV7p5Y5S15vbnC1fIqTCx+B2p/wo87jicGwJMaaYt2hfN8vi?=
 =?us-ascii?Q?zC0eVhseQNLPZf4ljgIG5QakYjAfcPUH7F+zXhdusz94onhn1SKRppNT8hQo?=
 =?us-ascii?Q?zCMfmOnou4obzXKcMy4w7IHMPQw+mc0LVZ676opkLlTWdoOCTNXgVoDO8fQN?=
 =?us-ascii?Q?EZdyheyRzbwtX476GAfgVJ6Vn2cH0qGGTe+MEBGqdmIXohyggNZqEe6EjUxJ?=
 =?us-ascii?Q?Qg9JK6CgNcTFHaGy9ZoBxZ9Ghootuo9JKjO7mtNtUxz9amjY5AiO6D0u/+KT?=
 =?us-ascii?Q?0x+xJDz3OT3KkwxnL/cdGBMyLdeLES3MgjAOkqm/h8ivxlWEktymdGhNiqyQ?=
 =?us-ascii?Q?nektU8wCuoLI658w8RUstm9hIkZaVbNvAOd7QajQaYz+jH8fQLUrZh4Q/qoA?=
 =?us-ascii?Q?34XFSR3YrdA9faQbU52FR1+lcLqge637GneVMk28LHQajnrozyCK29vfu1SN?=
 =?us-ascii?Q?0HjRg16N+eVwJz1aSmXfSV6cv0CtdY7C7r+HJWk9DHY6pFrDaRLGLkrfQA7D?=
 =?us-ascii?Q?KisasZfeFmM/PFcAJi3nfCEJxLso4ytvBAl6VHzRJrMGAIx/0CFKjOyyqfYR?=
 =?us-ascii?Q?vjKqNc1yCQ8rj7POm6HCdkOkvlrE0+x4rXQCDuEgRQlWlecp1dxNDtiqCyyx?=
 =?us-ascii?Q?sWUORGWqH1zCc9gAnMC7diVdeZY2SxY=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49677342-bfba-4f42-5b5c-08df0d95e3a9
X-MS-Exchange-CrossTenant-AuthSource: PSAPR02MB4984.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 10:42:33.1511 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9g0GJ8YnBVWSRzkTMYVLsTzSqEJYb1FCQpn/Box9804KjEQPVwKiYuUwyXOLFJmvzXLobNPJaSdwSy2Oz7XF/Wh5u/SMmOh2MOHsbCmdEtk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR02MB7928
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=bin.meng@processmission.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Instantiate the E2000 DDR controller device and map it over the
board-control placeholder. PBF and early U-Boot poll this selector
window while firmware coordinates DRAM initialization from EL3.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

Changes in v2:
- Move the DDR status device into the E2000 SoC

 hw/arm/phytium_e2000.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/hw/arm/phytium_e2000.c b/hw/arm/phytium_e2000.c
index da8313d61f..9a0cc00c91 100644
--- a/hw/arm/phytium_e2000.c
+++ b/hw/arm/phytium_e2000.c
@@ -21,6 +21,7 @@
 #include "hw/core/qdev-properties.h"
 #include "hw/intc/arm_gicv3_common.h"
 #include "hw/intc/arm_gicv3_its_common.h"
+#include "hw/misc/phytium_e2000_ddr.h"
 #include "hw/misc/unimp.h"
 #include "hw/net/cadence_gem.h"
 #include "hw/pci/pci.h"
@@ -39,6 +40,8 @@
 
 #define PHYTIUM_E2000_NUM_UARTS       7
 
+#define PHYTIUM_E2000_DDR_STATUS_BASE 0x32b33000
+
 #define PHYTIUM_E2000_GTIMER_HZ       50000000
 
 /*
@@ -462,6 +465,21 @@ static void phytium_e2000_create_mci(PhytiumE2000SoCState *s, int index)
         qdev_get_gpio_in(s->gic, phytium_e2000_mci_irqmap[index]));
 }
 
+static void phytium_e2000_create_ddr_status(PhytiumE2000SoCState *s)
+{
+    DeviceState *dev = qdev_new(TYPE_PHYTIUM_E2000_DDR);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+    /*
+     * The selector window is embedded in the board-control aperture. It must
+     * override the placeholder because early U-Boot polls it while PBF is
+     * still coordinating DRAM initialization from EL3.
+     */
+    object_property_add_child(OBJECT(s), "ddr-status", OBJECT(dev));
+    sysbus_realize_and_unref(sbd, &error_fatal);
+    sysbus_mmio_map_overlap(sbd, 0, PHYTIUM_E2000_DDR_STATUS_BASE, 2);
+}
+
 static void phytium_e2000_create_unimplemented(PhytiumE2000SoCState *s)
 {
     /*
@@ -584,6 +602,8 @@ static void phytium_e2000_soc_realize(DeviceState *dev, Error **errp)
     phytium_e2000_create_cpus(s);
     phytium_e2000_create_gic(s);
 
+    phytium_e2000_create_ddr_status(s);
+
     for (i = 0; i < PHYTIUM_E2000_NUM_MCIS; i++) {
         phytium_e2000_create_mci(s, i);
     }
-- 
2.53.0


