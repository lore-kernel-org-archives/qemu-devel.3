Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89200C531F7
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 15:21:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmvCr-0003vt-1q; Thu, 23 Jul 2026 11:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wmvCq-0003sq-4n; Thu, 23 Jul 2026 11:19:28 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wmvCo-00081v-HN; Thu, 23 Jul 2026 11:19:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y25bWUUHd2yHpylR1zeRMPUpdlc1A0XeSKehHWyTdh/7iAVCNvv54u2K2Izs4U9+YOAnzLe96eWhnys/SObuyqrNq/diXNMxpLJ2HSkkSZAFm5nIoU39tcUT5VL55P1TSMwrU/SSbKl6VOJ5ztrt2ogdpxlV63DoPFe12MQPAH7ge+dFoWfkdZcDAsoa/7dtI1keYseDea122H1EvS3QFX9SgzsEQOPqfA/zSvHFWg02IPyPpbI+XKPZINCKcuOlm846RvUq32HOX2KjDCRtyqzKHnMzRkSI2NPQZlxjNrhn6WXmgW2XRbexFYl6GqW4vBUiHQ4q5iMNJ70rvuYGpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DxsAvt+6fkUAG9dDgqIBO8WZCQmt2HNRBv4jRz+7EPk=;
 b=Lhc+yzTl7poeBvu/hLvFCf6Y9RESrSoRf4XbYjKJqgykGkD5KW18ic61UvGpvOCAzPmyATmYnP8iDos01xyvn34MSijPVfVBG0F29rxBEij7NcxoR7CNupepFpGqRsqiQ701v6PPpxvVVW/UdvpfcDTB2U1wDpJ7Bp2s6bcw2cmddFBGf/H4H9ohZyw75v38OiHAk9pbzkjCXnWaMGLWsZFhoM66lmCbNTdSY83sa49eizCTFSbOYdLL1yOPx+sQIY9BtJ/6BOggOwpke9IILTYaa/oc+CvIKDHdsrak4+gKduofCLtV9G0RPI2Zo6TdLSuJT+Oj9ClFXCbP6C1exA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DxsAvt+6fkUAG9dDgqIBO8WZCQmt2HNRBv4jRz+7EPk=;
 b=VRfpHZ5s4wV+b60A6/DpB3cf8VtDdLdfnCTWXphUb6GQsH/rQif5ejm0f796iixOj60UJGkTfmnmHysov4/+QgpCXdJnUfPNU7gqi9mj0uHLxwpVsgigPK0uzm4QungBMnu6j5wl1sNUgJeeTzjNcLjnoqTcWODOONWmzhf5/uRzz7kkGQlP3zulWThKpPlvdXCSQLBvfErV26Se9WcBxbaBMS3HbAG80la+TzdPgVl//9O/Jaz23hS9MKeSjuYR1fZu5h3OUHcpgnK53rCySHHrX/q0VoS0EQOAdw8215ypbm86urk57+hMTYU5uBkH7V5E+xn2M29hhVyjH5D8ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by KL1PR02MB6215.apcprd02.prod.outlook.com (2603:1096:820:9f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 15:19:14 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 15:19:14 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Chao Liu <chao.liu@processmission.com>, Conor Dooley <conor@kernel.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org
Subject: [PATCH 01/26] hw/riscv: pfsoc: Correct the L2LIM maximum mapped size
Date: Thu, 23 Jul 2026 23:18:28 +0800
Message-Id: <20260723151853.2143177-2-bin.meng@processmission.com>
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
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|KL1PR02MB6215:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c208bb3-796d-4ac2-c943-08dee8cdc0eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34096008|23010399003|1800799024|376014|366016|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 1znknnqgsta/LPVti2jepukKEc+7DLSu3dkwa8LpgeIVuq9Hf3h2xbL5N7ixzm2yiU/AMFSXcQ6IzWHkudkIXh1IR/8Qaeh06D0vplpNSp3LMbaH8dWHIRbFQQ2JRruIqKB1b4HbHSZ0YgsqHwqTktamT43RlHzLhK74+4teeG/HxeK+I+I/7u/8HS+A60Cwib8u2XXfTDDphKDd730NSbEKG5LPpe6qFZA/+n2hJYOTldO6572tfbx99A6lSl1NSauPqyGihX2izTOo51QUPT/FxMTPQCkXh4wlzrsRRNpxVaIqQ/l0y2tDHc+stQmDz5+RVnJwLoXPuAiGl+oAQRhXNFDEHSDs4z21NfghZsmNOEccRc74edrQHmWiKy9fTzo0eKPlI2Yom8ytwqoXn00YVrV3CqR6lxmYaxEZ1R4JDAIBt8sbYUvDfeYatIcpTdH/45xuGKTlyx7ylAHKU69XXKyCcjs2DynGmIls0xDgxJiizchvVgIPcH5XA5W/4egd4VY6cEiQyK+ZI6SKT64pbz9O6bXSMIhIf3aICwVRAkq/nWudnt5r6rSYblBYNgQlypXvIiyrkquHNPR9nPTg7gJoVpaW6A0h5cIlXhNWZmOgiRBnbyZl0g+jHkoMda89kvTGdCizbLegrc+m7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(34096008)(23010399003)(1800799024)(376014)(366016)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5v+HsQvrPJCPv952Lz9k3jE4vNrTUPzrCWNCGitIzW9fTepQyMvDIANDdLQH?=
 =?us-ascii?Q?jtZa15YicOyx0Kbqifi9lWkfY3ZzDFuvGxxYeXPsQXG9nZd5CqP1ZkzL3xZM?=
 =?us-ascii?Q?yh2n6FqHx1Kt9Hw2gXuAnWc3LHZ6/6fh+iefFsKnJn+XkbN0vIc/rebvP9JF?=
 =?us-ascii?Q?422YsCa8rxvCkTzHtKdcnVeqHCYsx57nNPuVd3fd4ehiUyBnTN80lQaYZ3FI?=
 =?us-ascii?Q?wQLMB7Kz6YH+sBMWZL/kq8VIIOakY19TI/lN2070CskEQ7rsPpC3IDtcYktf?=
 =?us-ascii?Q?N56efy6fpOxJP/Ks5x54c+2S/GpPkeisUM1g2ka6T+sCQKsmHt/YGLSqML1E?=
 =?us-ascii?Q?CgzKBQqcbVUHlssEMvzE3QpDXI6X7YjqO2eJ0RTCoUh2BGV6XzO1YzsCi7po?=
 =?us-ascii?Q?HpNTk3UFTxtWMQaU5RWIsZE8oX+F5F652lCW2Gx4Dy9WQ3pfwobDsXowuzGh?=
 =?us-ascii?Q?dupT+TOBWXLnXJ7B5n1jI5RMr7aP1D2ngmf7mDVTOihhL6Qc8SSrCuYUZmXc?=
 =?us-ascii?Q?DqKOArQKYAz7cwv5vvjjRrxdbEZcV6KkSA3Xn2b2/fC67cGdC/dHTnETm98/?=
 =?us-ascii?Q?tHSyO0F648g9+Vrhm18mZgDNwGD1ni40jNOig0LMQ9cGsr1nJV4cW+a1dedQ?=
 =?us-ascii?Q?Co8sAt7qGP9WKWlQXr2RvD84TG3tzRgAlkey6u+gwywFtbj93KhntkWTMf9r?=
 =?us-ascii?Q?MPzSCKRA3PX7bMO84V8qzTD+AGE9JA6BpvVEnvMFW4HcKMr9A+ESqu2ArsOa?=
 =?us-ascii?Q?4vG6dyLOlvOziUnaz03iXA6i42a2JAaIZO6t4fwpvOnqIC8/LxnFYegLvUix?=
 =?us-ascii?Q?WgsJUjr/0zt2xqyapm4aKK3SsiBnqA+XJkkQYE5qXD2j7AANYPhgg/o2dVLn?=
 =?us-ascii?Q?Sf8rjRNzJJnrOLta37ISv9VSVKl8sjtsA4Oz/uCdHd389ilgftzpl+cTxalp?=
 =?us-ascii?Q?OOF4cO5xn7uoyg8K8VEo8UijXDlJMAH06LcNOzoEFNlRKPmVdFpO0vExlC/Z?=
 =?us-ascii?Q?oFoyodACiAZD2xKL52Zee/D7Lk18NiyEUbsRA/6TpKwlHbOSVmmCEDmqdFPs?=
 =?us-ascii?Q?C7ppiJ9hUkIFZbZz/2tvfDyLCt/iJxUBNWk+lgFDhZcEMUjhpK0Ct6WYIEcL?=
 =?us-ascii?Q?I8nfFdmPq/arephGh3OEFPJ/gtNxLiJJLsHEFYUmF7015bdG8uJOPn3vNIwP?=
 =?us-ascii?Q?xMe17dH8hg6amRP67ZDPIVtzoxWRgkA6NPioY8f6BVRwLx0TkSRurCdayn+p?=
 =?us-ascii?Q?V7dGpNMbM5s3OS5FukPBaH1reFKKfKmZjIssD2AdPR4cn7YfeSx+LaYvqc0B?=
 =?us-ascii?Q?pNWSehsASMMEMQTm+HOruX0raQYUE2/doMeEraAknaEoRyMeODGX2wDvK4A6?=
 =?us-ascii?Q?u77wFcZ1J4/tVjb32dLN9UM8Tu4ePj7HTfEtdI53R905tOliacukXcoNb+nn?=
 =?us-ascii?Q?zSAEoUBybeiHCIOnHaQG/dw49QZDOv6oHIenVPPALDsyESckWAX+7GYr0/ka?=
 =?us-ascii?Q?tJ7HT09XpxYTu+mG9B4P0JnkRfQWmizlbcvNac83fJ7lspDyNSmjMk2qY1Uu?=
 =?us-ascii?Q?Om/KNAAaneY85iF8tfDBgUn+a3Ok6eYYG8tN8suo9o+aSWNhJNJMFzDf09ym?=
 =?us-ascii?Q?bdhGwKqQx4TEHpLjBfhKBI4YaFB9NTb7yLeePQOrF35ptHYdDTtx6Kw5a/Bu?=
 =?us-ascii?Q?3HOncqBbLFXhL6OEWWUKluvd6IJ+lXxPugJweffAO5iR4Ec3naEFnaSLWxmy?=
 =?us-ascii?Q?xuKqbL5kJ1AwyLZEEs23FvO8qcecjI4=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c208bb3-796d-4ac2-c943-08dee8cdc0eb
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 15:19:14.3578 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fw+FUqgOyQNFUcofyeYGIElXpVs5JYTPEqZn9H2K7e+qin8KO5QoEytJA9VQr5HBWMxfcV94PIpzdPzVdCVvVazXEmaJpB737ZtTNjbGD1s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB6215
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=bin.meng@processmission.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

PolarFire SoC has a 2MiB L2 cache, so the maximum mapped size of
L2LIM should be set to 2MiB too.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/riscv/microchip_pfsoc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 4017129c83..218cccab69 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -96,7 +96,7 @@ static const MemMapEntry microchip_pfsoc_memmap[] = {
     [MICROCHIP_PFSOC_CLINT] =           {  0x2000000,      0x10000 },
     [MICROCHIP_PFSOC_L2CC] =            {  0x2010000,       0x1000 },
     [MICROCHIP_PFSOC_DMA] =             {  0x3000000,     0x100000 },
-    [MICROCHIP_PFSOC_L2LIM] =           {  0x8000000,    0x2000000 },
+    [MICROCHIP_PFSOC_L2LIM] =           {  0x8000000,     0x200000 },
     [MICROCHIP_PFSOC_PLIC] =            {  0xc000000,    0x4000000 },
     [MICROCHIP_PFSOC_MMUART0] =         { 0x20000000,       0x1000 },
     [MICROCHIP_PFSOC_WDOG0] =           { 0x20001000,       0x1000 },
-- 
2.34.1


