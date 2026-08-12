Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65B65C5AC67
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 01:37:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtxuB-00086Y-Ng; Tue, 11 Aug 2026 21:37:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wtxu7-00083v-BF; Tue, 11 Aug 2026 21:37:16 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wtxu5-0001Wg-VN; Tue, 11 Aug 2026 21:37:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R6IyuKILNifaXX6S/YWyT22FL+4jWejkY5UD3uWMCqls9K7WqyP8KiZV0XbejgWK6bmmzBdTUBV/QBswaPP+BU4gL6CarvuGUaEcIkFaW8+lvUNDvW3EHWoBOwL7YTmmhRgOuPBZzS6t0x0YixEmTM6bHyQywWHW/xpIoCsldvVUQdwKPRQAhAMDDz9QXfbXVzGwclYjYNHmG5Ln/mDSZOQJSYV9UA51nPXkbaQjkEKhBe/KfmsFNv5jxyT0wzbWVOoclfDly0ufBxCMM6VbnK2AF61do8u4/MnmuF7wKNm/eBxWP6zGTldVcNJSkPP4VW5Boh1yi2NT48XW96VbEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0biXfwqWajW9m76unNrjEUlMjEZrc1JJ/PS94B59vlo=;
 b=HPjfxExA/FMA5zynN0dfFbf2jYt4ttgB8yC/vsMUotRJf/VyuUyXRHeoXgHQ1Jh7EpFxSSqT1j1Tt2eYOYiuKhPpaNLFneY4ci5uP7kzMf+lgU5OfHBgq/puQlVK2QpNoYGdEklUcjKfR75+T5lTVamD6C5RN3UEbs8r8+Y0Z1NRHdqCY32EYtx5aGN8mUqJJtX2UZlz+EffFNkhqs4nNUnUt8Tobn5a7H0a3+VevHf4yHLYuHNfNcKeohgNA2iQTdvUWCIggy44LBmdT3bFt+J0pOCxWavnTn/9lQQlfjJaEC91N1SYv9sxeksTiGyCqKNwzLpHs7uOJfWeRH7TAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0biXfwqWajW9m76unNrjEUlMjEZrc1JJ/PS94B59vlo=;
 b=CE2a3TZ7f5iwyVRBRGPDnk1FzvBw9U+k0bLSY/8qh6oZGQuGO2Rco+ZkR9emHz5gdXlKmMV1Y8z1pn4IqhWlrgTZSP9xOGHyRgrzKhv8QF2nChXbBliG7KeGsqqVw+zHykeApmw/lxWAxV3fxX9jsdQgT0oRknRMt/jdPCvhL3rP2dV+vBl9oxFT47WSkZ3EuydTI42wQaq3KGtUOe5omXQ2Lch7C+j5xFSpvNffOfP9OwSvyNJPCVSrrCHZpn7Hq0PqM33atyQMtJxjoFbfvhEDn6CeZjP1upQ9ql8OgzUrIXzfmUNL2LFnr5ZmZMpnfXpSTw6+OqN+SWHIVHh5OQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by KUXPR02MB9309.apcprd02.prod.outlook.com (2603:1096:d10:9f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 12 Aug
 2026 01:36:55 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0315.012; Wed, 12 Aug 2026
 01:36:55 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH 03/10] hw/arm: fsl-imx6ul: Map early firmware register
 placeholders
Date: Wed, 12 Aug 2026 09:36:06 +0800
Message-ID: <20260812013619.2134092-4-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812013619.2134092-1-bin.meng@processmission.com>
References: <20260812013619.2134092-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DU6P191CA0007.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::22) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|KUXPR02MB9309:EE_
X-MS-Office365-Filtering-Correlation-Id: be9e393e-eb15-4e2a-497e-08def8123121
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|6133799003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: xZbJ92EDSlCsSOr6z+H7Rl7waFmNicb6zC93pTmg1esAZd3OCglS8sS+SqUhq2riMvoUl1eNNJFLU7fL6e+NOgBBgB/xoM35jqwXtcZ5aEEfB+p2kMf/GI4l5C+yzS8B4hyjKRRCWmx4VDl0nVYNpWIJ+sm0oYfo0HODZ5RLnFyvwTwZ1dDFjUV1ImFIWLt6WyrM9bVNntgD47ISBKTK9CQ5tSPoHn0f3KlArQhd45yTfhHnOFI73HwlH4OuBHBfkSG1Rf0TNzMmeKHbuVlzrWWVF1pONNYOKMhpy+V09c2ypCxyuLlZnlNYt7Sj7/1eHiyhfElsMo9E9oTyEIdvS++fVeB2ZW/n7f4rDzy46ijAW6bGJRkW382OcSLyGi3OI6RR+jyMi7bvZETA/Hh3ks5UKxGjVfjfskyyffOrcMy1yntKqBP+PfQbVJs8KzeCn1pbsKQJcBGj6Qx1NDR2DD46X/arW6Cy8Dmpk5+Y3NHD395VL9HbICxc13gOzGT61od0XDpdXmDM5RHFg1MznYp1VVZXy6/maIhOYmD5GzE/MNtn3jefC+irT9mLy2XWOCUd3cwwHvVsrX33Ciw6/JX2vZSpkjWg0WaPuobH4nmAaetcvjbhIwzAxSNT4XKD+3qhAn8bjHbixPlS1xho3hh05ANhfhgswrveJJrJqNA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(6133799003)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l7mYncp59wSwzlsyRh0VyWijKoNQinjbYWYg/D1/m2TTKO9+9IQtBEaZ8O3N?=
 =?us-ascii?Q?U2Xs+2WDnmVoBpXf2MOlWN1kKh0eUwR5qp+zR8eozXgVYBMRbSoI4duAkN3Z?=
 =?us-ascii?Q?p99lsHaJyghB+NqX1lrEsY9NOcxjTfYzPgkNEfaKfaWn6GBYKqJaQaycERG+?=
 =?us-ascii?Q?2oeBBNz2kiwmGpbw/qN0ypVEC4zVCcTVseP9OM4tKWVjny+qEvYKlWlwjkSB?=
 =?us-ascii?Q?NzifPApKXE6ntmFuZ/23TAIT695wRRaHsSIyW/5HnFI74dbPTycHB7AIEbsU?=
 =?us-ascii?Q?9e/svVlBR00mnpW36jLSMVhSsZ4AizaskMCi0+ILuxNpg/KwDVG/wElWMwFt?=
 =?us-ascii?Q?cqPUXuFmXEo4KIm1kPUXBYlYSovJ1NFFw/eA4itHeoHadPouGT+Cj6eRClbX?=
 =?us-ascii?Q?A511XBNXOsl1U3LAQ3DlDqKgE08iWu0zyssas3AmeuQtOujOo8pFKcTsvBXl?=
 =?us-ascii?Q?Y6NGPtwOr9aaJMUhmpL9C1QsidvIfscF2w8+Qan1RpM4G5Sc/NKRtik4LvrR?=
 =?us-ascii?Q?9d02htegp0kRfgc00Uzq0Mc3oFAgDwiMuhydEU/eyQVsJIX6WuRP9Qf9FnBT?=
 =?us-ascii?Q?Z9/MnZVyebn7Cq11GyLPEYDLWrVmZlNfxrCBjVFY8NoIo2E/TXQtl6lTcVej?=
 =?us-ascii?Q?8WNxMEDRubcEdUzGXYthR+sXieq0ko5JxCLthyeb4te/GM6okYVtc7RFSvge?=
 =?us-ascii?Q?2MKfz4kTTKqGi3OvybeajURaqzk5keRvJ4onEYpLvgjuMs6lBHD0QKxB+CJJ?=
 =?us-ascii?Q?p4ioV0lBewBlKw2G/ejFQFWTXlr/pmVZRESF8Enun6X+ipqmO97079YWibuP?=
 =?us-ascii?Q?i5zf8xZCeQcyDSCbXC5j5ptyTmF2JSQ2yRPK7o1J+pLrO2PnW0gXR1DMy8lO?=
 =?us-ascii?Q?1cTqRAS6SE7kCIMOInGss0w6vLXL51nMd7fzMfetuB/mQEwWa2wwY73tbmaD?=
 =?us-ascii?Q?w1yLZsCMkwek4yLedOpgK9l/adVLijpWepjTTVYUJ40legzFTQzF2onWZDBz?=
 =?us-ascii?Q?Uj+uGiH6ZU3WcwV0xloaxEggQ6lC3kcCioLVxrkSFK3etxI8oSFsJzBfv7Y7?=
 =?us-ascii?Q?qDuUmOBP+GXllXmO2ELus92VRAR9h3jF0rwJlVAYqX2/j/iZuk5nxK5lxFoz?=
 =?us-ascii?Q?Od/D9IkRj3FQ+nG7otcsZWzl5lHX9DUbU9ZdPBZjXh4gZPLKa6G6FGUYa5V4?=
 =?us-ascii?Q?F87vKod06HaL+lYxbrc/Ghn37s7/wDT7DN4cDtWDAgyjEi1T+pJuCes0opi7?=
 =?us-ascii?Q?y+mZYMA2c+Yqg+gWiKsU9E0G1nsWk15vMWEXvUNUWefgxqCChRP/BLkAvvRK?=
 =?us-ascii?Q?W0m7GKuqcXGn0LQPJUGg3c2ToQtaD/BfC2VVHmuuExcToKTiaiQmM9qF8Zyh?=
 =?us-ascii?Q?WHyoNFzGG/wGhheB3nS8b31E+gjvJtDMx0tfPF+qGFekdp+zEg2Vh4JbZkb/?=
 =?us-ascii?Q?79Lr/cEOz6s3F/wwD3wAi+UwUkHhKJZbKK3ewPC6MCS2jB6M4l39Xl3ba7g3?=
 =?us-ascii?Q?CdjLCPivkQ6dgd4NrFslXJmqCMSVHXo9eyUUtGimWrNi5dqQCe2XHKMGoTkN?=
 =?us-ascii?Q?QauwYaqKkA/D6TJrHKygTksTS/CVRx0ujonJKOESf4oo0nDPEWMlZB81zMkL?=
 =?us-ascii?Q?0FCw016tmDAyzjEWnUW+MYw577qZ1UmXFnqCTJPNex6big8tiaug1Q3IbuJ3?=
 =?us-ascii?Q?6MGnnZ/KBkC3Ikq61dr/d0b+A/t4qb32mQFqfiwGBYSpKW81oaBGE8BrVuTi?=
 =?us-ascii?Q?1fv2Tl93hfUarnGdKOIrJqELbZRE3+A=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be9e393e-eb15-4e2a-497e-08def8123121
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 01:36:55.1361 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q63dhy+9hypqFtShzjptyTvv/ceH3jEJVVz5u1NBUxwinlvsCW4byMl/7V+MRgQU692RziVGmDiBMburNZUjeYu+WIeTrCW/l9O/G6Yxf7Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR02MB9309
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

U-Boot configures the AIPS bus access controls and the i.MX6UL SNVS
low-power registers before its console is available. Its timer setup
also enables the system counter through the control window on AIPS2.

These blocks are not modeled yet. Map unimplemented regions at their
documented addresses so early firmware accesses complete without
falling through to unmapped memory.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/arm/fsl-imx6ul.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
index d6f662efe4..74c1a30959 100644
--- a/hw/arm/fsl-imx6ul.c
+++ b/hw/arm/fsl-imx6ul.c
@@ -210,6 +210,21 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
     create_unimplemented_device("a7mpcore-dap", FSL_IMX6UL_A7MPCORE_DAP_ADDR,
                                 FSL_IMX6UL_A7MPCORE_DAP_SIZE);
 
+    /* AIPS bus configuration */
+    create_unimplemented_device("aips1-config", FSL_IMX6UL_AIPS1_CFG_ADDR,
+                                FSL_IMX6UL_AIPS1_CFG_SIZE);
+    create_unimplemented_device("aips2-config", FSL_IMX6UL_AIPS2_CFG_ADDR,
+                                FSL_IMX6UL_AIPS2_CFG_SIZE);
+
+    /* SNVS low-power general-purpose registers */
+    create_unimplemented_device("snvs-lp", FSL_IMX6UL_SNVS_LP_ADDR,
+                                FSL_IMX6UL_SNVS_LP_SIZE);
+
+    /* System counter control */
+    create_unimplemented_device("sys-counter-control",
+                                FSL_IMX6UL_SYS_CNT_CTRL_ADDR,
+                                FSL_IMX6UL_SYS_CNT_CTRL_SIZE);
+
     /*
      * MMDC
      */
-- 
2.53.0


