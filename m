Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C72AC531F7
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 15:25:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmvDn-0005HO-9x; Thu, 23 Jul 2026 11:20:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wmvDN-0004NT-1b; Thu, 23 Jul 2026 11:20:02 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wmvDL-00084Z-9g; Thu, 23 Jul 2026 11:20:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xkAvaA4IujZbfEEHBfULHim//3Y1mEBiETLVPf9KH2eZVZ4FEC3i6LDmCA1u8gIiLCYMyWvQKBTgcXFvkY/4kHSt0tYiA1lPCF7EhV1zS/8av/Cmj79R2EaHiHTa2esurhbwr7i650JlNxV3/eqVPwVqzpUD1hPV878lZeWuD+2l95o4DymA9EPJe/T+MUhiIYWDiibbhQ/iJ/CeGAwWKCnu2MPelBU2Cp9nobPmnfrazG2obh5cY3wpBfLCOhh3ymK7kyomqeZYPnXiG0kJLhK4tBUb2TiB1+9bXai1ZzXZoPt93JSQa0Pg6SQgaxr+uDgUSXMAqv0rQX1GjAWv6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xVxG9LusGwObsmg1FgHMpBS+nQpGUFdg75hulxmQJsQ=;
 b=M/MDGyVg5IEE6wGg/J0F7XYe8uheFa1dsrqnpOfR03k/y85M3mmK0WnsDJEWZ4XB8Fg11RQ/HSlzakf9pzSlfwq5B8w6+8rtm1o4TrAHUj/LtO5hBXNSx7qlD7wcyExqhIzKfJnEOE/Soy9SFfc2UO18h/b03ZgDnRNJW3YV60mCuSkITMmIS/0YI3fP6BzfKBOu2vlciv29nd0w8oNoQe67+4nsU630VXe5Vl4P6pcphiNUaS5iAVcRporDo8EuoqKMTn/IoDYB9c0n+oeDch+PeVrD0iJGretbyIM99GozffV2D7dvEOVqYDIS/8qUZ9UhDgGY9gOZbqrkAWFB/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xVxG9LusGwObsmg1FgHMpBS+nQpGUFdg75hulxmQJsQ=;
 b=qZeqomNHseDwH89Sz8UJtxXNTTFq2qKyddlv3WWoPNjTWoyyObaoUUqqSdWjhKPlIGkga+7SN9+Iz14Ip3VR+Vk+Lio/Ps+POlJb7R+4OT2DC5cD/TxW6TK29j6qY5n+addaTZmozSrYXFfP//OD7SAxqkTLqku3mPkZeYxweAg35oTwZTy++VPvQ6bYWEMdr8+kXAhOxYmzSN6ehrOr/c5Vd54VUoElXw4sgA3AmHL0f2dwlp0D2z3lS9pw1tioH7VZfKz9EU5DKCrq0hy1/CB4uxFzPPDXTwKxnBOo3+2xvlxPytgw75blcqPqzU14xdChGbh3nyGmwtr14njeiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by SEYPR02MB7097.apcprd02.prod.outlook.com (2603:1096:101:1a3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 15:19:43 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 15:19:43 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Chao Liu <chao.liu@processmission.com>, Conor Dooley <conor@kernel.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org
Subject: [PATCH 21/26] hw/riscv: pfsoc: Fix Icicle Kit RAM size at 2 GiB
Date: Thu, 23 Jul 2026 23:18:48 +0800
Message-Id: <20260723151853.2143177-22-bin.meng@processmission.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260723151853.2143177-1-bin.meng@processmission.com>
References: <20260723151853.2143177-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KU0P306CA0037.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:29::8) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|SEYPR02MB7097:EE_
X-MS-Office365-Filtering-Correlation-Id: 1372d0a7-24ba-4d8d-a68a-08dee8cdd264
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|34096008|376014|366016|23010399003|1800799024|6133799003|22082099003|18002099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: O7AuEI8A9lvD1eJNm7w2Ci3pAIDkgTPARpkeaupcFeqDjSJB3+Jcwy8OdI4p+mTC6sR8INUr8s8ow+Wl5JKrdBDT+CqF2qOFXYbCf5J6fxRaDsbM6vsBK6s/qiyGUpDiILl8KlhRqcktkJAd65hyCvdcQeecgqRAye4hGgObRTApL8pa3UGDFpiS8aPY3eQwVUX0FHdlRLA7L4ompmkUay11e8sg80Sh9644tf9HJHAhthYvZnTg+kkxY52wBf1xNRjSRgb+/LZyV2JDQKR124ycgA4kMNWk9NhhiMto/5KRb9o5vzqD0txhpY77psLhbLAgShivZnCe3TvICpvGIfIoZ9AnROV0SP6P2gN+SRleUq3S8SCdPsQzxA/EznbtaZxGEYloqPQpYZ/ul8B0JJQnHYRJMO85IA6MLxQBIWoAA6wnn3DIQeSJV33q5dxK/Z468nj0lXia3kXU8UsZ+v6rGMwH8Jn5ZF21Ch+hTzKpOs2CzHihj8lARfoZRELmwsYI5RrRPThPIRsY++nTklbjYq31vHAxfnsU7+mYq4ROvW4zKh4LHv0Ef0YXXTS0r+FHup8aExcohhO1VH7qC59lXBf4vGbFDiKgkjU8wNxa+PWdqnbSdxPMHw1askP9nCqWD9SJVJVJRAH0i6Om3Aiqf3eTMAVn4JiNtnNjXao=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(34096008)(376014)(366016)(23010399003)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gGlSH/r6ubRwFExGNs6M8f+HuCz4LfOBBB2q6VP+f03gqLvKh5C6rBAOAcVu?=
 =?us-ascii?Q?r7x5W5kY6LOtU1IJ0jV88lWvV08L8oyI/e0W9KZ7OT/cgdXn2UMHjkRWqONB?=
 =?us-ascii?Q?Jom81BCj3Pr2BaOhdPGIj0LyhSTGGkoE/mpGk6O+NlyWqvvU4p5iP0YJ9OLL?=
 =?us-ascii?Q?z0G57ePdzh38qyoNbYboCSKlilvStZJiNxTT/1gX6UbqkemEK5ih6w0itZ59?=
 =?us-ascii?Q?qROaNkKXJetqS0Vzlltxt31jg6VtH2IIAmSKyJ4+ng/20HbkVy0DjBoTq6R5?=
 =?us-ascii?Q?wv2Gr8Toulo7wPL3EDS7erUI7+Zx8nv8XY+nVX/Zk2D2upUFSaPS4bQUupwo?=
 =?us-ascii?Q?MTLgxSWLYCjW1ldF57Ym76uHbAt66/3jpN9HF+2GxORMogkevPjK4NJHabmZ?=
 =?us-ascii?Q?wkwyf6G/EYPHu0rdhzmllcsPikx2MMzxt12m+1gSKyKbs1PZ4ILra3atexS/?=
 =?us-ascii?Q?Fx4RRg52Hd79XsmTpgm9QmvpxIWG7ms/2O2SKslQJrRfzVRPPg/ZscCsvotK?=
 =?us-ascii?Q?qsv3EwB10GYR20rhY7ntI4FWxbvl5HCfOan+Wm/VMWpY5oIPNea4SQarvuFd?=
 =?us-ascii?Q?g5QWKmUgSq9p3AvOVqszAxU2On4BcxIrjJfwtc/k3kbUE0n5LAwpWM2olrIG?=
 =?us-ascii?Q?83x/etc+cMMlk77HMkCbjwnMNg/DeMnSDcuL8RE7Np34+cHC7Nvt8wX//O/7?=
 =?us-ascii?Q?2GBGZuEfW2EjKOZdfOkOJOSnXUrpoweoHkg0w1Z71YzrwwztjJVsV4eRJztb?=
 =?us-ascii?Q?CFdy48YS6g/ofv4e+CXqjyLbkmBo6SfprbFxxIVcUFogwMhIj8SR3WXDovSc?=
 =?us-ascii?Q?IawKs0vkgNf9BrMUiHN+Sq3c7tdFJeS9kUV46nc4KQ/eTA/Y+8Ce6C1UnXOj?=
 =?us-ascii?Q?UtL4jRGeWz1K+aQ8TQUSri4rIcPkxwjOxJVh9Egf7v91Z090Bh6B5xaePbGi?=
 =?us-ascii?Q?QDXmBEq36slX9iQZq+YWzJatrPYaUhLAstUhvH2Ykcb0aOjJLi526x2r8vCN?=
 =?us-ascii?Q?VnnfxwKKWVkMb5QcA9AFpPBnPpRCjLdjHn7Qv3uXjbPvlDHGGvFhfgcC0ODc?=
 =?us-ascii?Q?2jdSuAA7FqMWTnyYIXWO+m8pMBe2oPCNXvOZuADB3x3YZKTpBzKFxym4Jfj3?=
 =?us-ascii?Q?Omfox278jUHCr84Sl5YRzZXYwLJQRdh4/C1ESKi7hXfETXJwR4T+k/Hm5koA?=
 =?us-ascii?Q?eZFlgai+e/f3aBjCdi9IJ0fTdnxCrGFRZquD86/0BGwuYyoAOWmCigUO6GYV?=
 =?us-ascii?Q?jRuQLGBfRWfXvUkTcKAXgBusF6gb169Ycr4uzYx65lO8t1Eeqm3ICTl0PwMN?=
 =?us-ascii?Q?R5akRpwsLjbeb3Z9PyyXz1hRRIEdPSAi5JMshCCAmbGq61RRcgsZI+j/dBis?=
 =?us-ascii?Q?MQAoZqGCopdyFqbxZUCqMZLX6oNDHsOKPTSR5bv70RDLSg96UEtz2FsT8TeR?=
 =?us-ascii?Q?zqzGWsiiwsNidFBQDzwuHOvO198zik0/kqRA2ynIB//K2NUyiSqXvRSc9tak?=
 =?us-ascii?Q?Z7br4j3AxPOwq05HZlzC80nChc+gG/AOhke+wj3upVu7o8yX7W0kYtyVY5eO?=
 =?us-ascii?Q?Nam/PvjKMWxCKgyOQLUAnuE8KaepRzz4h27lJWJR4oBAAMiY91rwHsQHRqZy?=
 =?us-ascii?Q?KV5fX7RkDDZZcX7xiiTI+k6PoQlAF87RXHJtSiarXyotRpTq29WIKaAxfBEh?=
 =?us-ascii?Q?HK8iJvwawbY7U8pkkaBBM6hLDiunuxrIclkP3B6ycFazT1Ni4T0+wFdizgnj?=
 =?us-ascii?Q?mqXmZBp/A05lcfxM6XfGA7JnfqchUUc=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1372d0a7-24ba-4d8d-a68a-08dee8cdd264
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 15:19:42.9637 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TlT8z8KpHq9iGJOFJEEQD6YpVponN5R97rs3GxxtaSaoO+lMBQdI5oUfcUUBWjWPaEB2KaPLyc1UB6oxO7QQmbgD5rLRth1upm4Dgmwe7jg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB7097
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=bin.meng@processmission.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

The Icicle Kit has 2 GiB of RAM, and its firmware device tree
describes that fixed capacity. The model currently defaults to
1537 MiB and accepts any larger size, allowing configurations
that do not match the board.

Set the default to 2 GiB and reject every other size. Update the
documentation and L2CC qtest command line accordingly.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 docs/system/riscv/microchip-icicle-kit.rst |  4 +---
 hw/riscv/microchip_pfsoc.c                 | 15 ++++-----------
 2 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/docs/system/riscv/microchip-icicle-kit.rst b/docs/system/riscv/microchip-icicle-kit.rst
index 9809e94b84..3db2b3c7e3 100644
--- a/docs/system/riscv/microchip-icicle-kit.rst
+++ b/docs/system/riscv/microchip-icicle-kit.rst
@@ -26,9 +26,7 @@ The ``microchip-icicle-kit`` machine supports the following devices:
 * 2 GEM Ethernet controllers
 * 1 SDHC storage controller
 
-The memory is set to 1537 MiB by default.  A sanity check on RAM size is
-performed in the machine init routine to prompt user to increase the RAM size
-to > 1537 MiB when less than 1537 MiB RAM is detected.
+The machine has a fixed 2 GiB of RAM. Other memory sizes are rejected.
 
 Boot options
 ------------
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index a2fbc89222..b604f7008b 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -557,10 +557,10 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
     DriveInfo *dinfo = drive_get(IF_SD, 0, 0);
     RISCVBootInfo boot_info;
 
-    /* Sanity check on RAM size */
-    if (machine->ram_size < mc->default_ram_size) {
+    /* The board has a fixed RAM size */
+    if (machine->ram_size != mc->default_ram_size) {
         char *sz = size_to_str(mc->default_ram_size);
-        error_report("Invalid RAM size, should be bigger than %s", sz);
+        error_report("Invalid RAM size, should be %s", sz);
         g_free(sz);
         exit(EXIT_FAILURE);
     }
@@ -770,14 +770,7 @@ static void microchip_icicle_kit_machine_class_init(ObjectClass *oc,
     mc->default_ram_id = "microchip.icicle.kit.ram";
     mc->auto_create_sdcard = true;
 
-    /*
-     * Map 513 MiB high memory, the minimum required high memory size, because
-     * HSS will do memory test against the high memory address range regardless
-     * of physical memory installed.
-     *
-     * See memory_tests() in mss_ddr.c in the HSS source code.
-     */
-    mc->default_ram_size = 1537 * MiB;
+    mc->default_ram_size = 2 * GiB;
 
     object_class_property_add(oc, "clint-timebase-frequency", "uint32_t",
                               microchip_icicle_kit_get_clint_timebase_freq,
-- 
2.34.1


