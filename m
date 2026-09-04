Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A29C624DE
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 16:16:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2WZd-000445-Ko; Fri, 04 Sep 2026 12:15:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WZU-0003s9-Q1; Fri, 04 Sep 2026 12:15:24 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WZT-0008SI-CE; Fri, 04 Sep 2026 12:15:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kYib3KcyXIQ/KYkKnXZ3f1sJSeXZh/AhQvqNyNnCe0HhSgC2HmC+3jUW9f5CEBLLbTGZX5woZXmUf1D8kFTb+IAl/xgPQ8Yaez4wiwh/ATBCjL7luO2+2UhJXGGS31kktnCfl0ekcAMWzcD4txHxpXSRxoYOcICLDlzJP7UrE46icsueqKOCeHXDHWoHWD7+6pKIHpxLhTyXUFxJhXyuiyeWWiDItG1rbXj7oVlRp1dKt9xdjfbXaWbncvsSMjjyjDMzEadU7cILrAu3XqRM5pqAUlQO+Axha1KA4lwoOyNa0pbyOXEz16NjGIF0HqFXMEaIlumFIqE2WtwJVOWI2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UmLpjHWL5s0IGuMicUq4ZFFiIqvpi0EroJA818pn9Ro=;
 b=pagQ0PdDu/Kth3PRFAfdldjE9etihsRwv+K1+IUbxs9bLm6N60LTM8YAqbbEhEGFicul5Jp3f3dvq1iiuHSUYMQZov0zfc4DAEzbq9TMwgM1yuFFclf6Nf/tad+JXupvscgod5HcivL8R10kHPVzLrPVaVZzP+eijzRNPbBrr8gXv3Wgw+oa+Z3EJhqTpImWCYRmrEbBo8Ft1uXbNsajkpmCnbBC8x/su1umed/oLnwA+QTD2Lk4McicyFY/3URDzIztXZbnWGUt/7CPXAssjvMY4Hfde9KqaitVL8ZsTY989oAKo80ILG+et7lvbhNZ9lGH3dbCa911eo60aZhYCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmLpjHWL5s0IGuMicUq4ZFFiIqvpi0EroJA818pn9Ro=;
 b=dH09kEkWDrmk2lRAGoGAJdXA9LPvmjGxzafg8A+JnOAt3lW7mbj/k4X5PyVubQb15gEAbj4ai2+Wy8AIJs2xetupzzzYzS0/dYEq+LP0IlrbyE3MQIMbf1quYK0aYppPj6yaUaWT23Fet6h0ov2Uw3oI1HNFbqqe3MfWMDgbpYA6ITbr8BymrbvegXP6lNYwqRtPfJjxRVUfjGApjJE0DqyG5e485bF9a/BuVeV57wK0OHbwBrJk7c4rH3WYAgP4GKaxq7meCe3Be2Je9doQylW6LQEppTGUJdQLpTRFlTcqwURgrHzGq7WjPVx4vVkFWn1mA1hRhjmlG5cltQ8sjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by KU2PPFE04A6CE19.apcprd02.prod.outlook.com (2603:1096:d18::46b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 16:15:12 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0382.007; Fri, 4 Sep 2026
 16:15:12 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH v2 03/10] hw/arm: fsl-imx6ul: Map early firmware register
 placeholders
Date: Sat,  5 Sep 2026 00:14:26 +0800
Message-ID: <20260904161438.3838261-4-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904161438.3838261-1-bin.meng@processmission.com>
References: <20260904161438.3838261-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PAZP264CA0120.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1ef::19) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|KU2PPFE04A6CE19:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d1285f9-8a8c-4144-33f4-08df0a9fb264
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|22082099003|18002099003|56012099006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: tbiKGf5sNsY2d84oCTtiqO731eGz4wRr62ehb12jk43c1LksDuDPdkpdK61Luj1Ch7vrBNrVxv0pQi/1ydkNFcT53w0PTJ+z4s6ZPPAyLMyhtHeRr8X/mJQEBld1TBUBK8noYCEL1ZDCl0z4zelGr4WZ5pGhXxahvYRidbGvdn6ZR7glvxc5O2Q67KUE0+hD0gzzj3O9M/G5IRmdGqlQXxOECLCMuh1ZDm9Upc+vys8vp20szNNWbGJz8b3TfChVPUpjm8tAjb3hE2k92EDzVWfWfCzX/Flnj1e6Q7Gl+o13EDQHk1QValOuODKuuzWidyY/UIDV/GasVg5bXStaH1eKhO9Y0VSOwg5Q+K0UbyXWZFY2rDLmx8fL9274EZwIc+aad3+WMAFPL3rmXXsPKFZt1dNOlLJygpwmysTkuwkKV59SZbxL7qayUVTFnpqrWP57e1wKL17St1JzA+Yuu6McAeqzJrVdXeVxu3fyexVglS+eMaj+u1JFmjSHr2R8W9MQAiq1YvE3bwYosPExOBdrlKcPRz6K71LYX2ml8tAdgpg9kB8OvFfoKFa0ra7i01PrFQVyChQAM5ZHkKdL2v3w3AYYqrI+QKJo6t9NUb7hJwmAv8YKsLknMm9M/OArgH02tNHlKxj8s5cxWETs62W4IKeWW9LvM6Re+UEV2TA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(56012099006)(10067099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?07nmT55DACHPvif3SgHbFBCkukosFVlXs5W0RG0gXSfGpnEbfe0GymMUGQUj?=
 =?us-ascii?Q?hfv7sQUiO8JFGMoqUzC+azdOfvqMsglTwwpOQDeFr+FUcaw/exshJNH3GUKn?=
 =?us-ascii?Q?ClS6UJTrEuV7vG/MjEGWgfIDLWgVsgZgn1py/mz8KhbZDtFKPZcfyMBKi0bC?=
 =?us-ascii?Q?FeG90hvXOXfiE7laZfajvVf3+qUMkqrp6i6YvHmEbx2QVvMsQk2ID5PAlW2S?=
 =?us-ascii?Q?EufKIdJMtdNzhwilV64FH1HwH930blgUQ9ExlMXxXmCtOw0kUMpqU9WjpnyD?=
 =?us-ascii?Q?ZeTEcnTE6/lWq8CLgW6lk1h16ps4Aude7EilL7lRrBsAo4WS1Fb+CHw1jF8R?=
 =?us-ascii?Q?HOibE/jpwFTNpepExjqdIZXyCZejR7tbHOg9BKNMIQRg2qdsCtQChW9sErTq?=
 =?us-ascii?Q?KXgLrwZvtcB8INzOaL+muCgCzwT4Xeexemr1SNk5Q8VmOfaArJcIIvbIwrV2?=
 =?us-ascii?Q?SYOH6vbhfcww+95YrQIBFQnXq5szTsLJ5Je41nj0SW/+/XC+dfv0jJOF3xI9?=
 =?us-ascii?Q?GMawx4DNpQqNttu3d98HWap00gYcbufjXi0FzETAizYC1CQykXJdP7Vz/Ipm?=
 =?us-ascii?Q?NW2TUBgyb9375aSGPTCpJwXtEVvwtCcGsgZ2H+TZMNzsdIMMbVCZ92CcF4vM?=
 =?us-ascii?Q?IyyPyYxDDc+AAGIoz9/JsyV1iD8u3T1Ax/e+ihyIQUlHM1W/bGiYwvVj7hCg?=
 =?us-ascii?Q?DXEbt5wb1E0lGExKyG3e7wLKzeSuUba1xW61NuO0XcKMYKU+3agOWmVE92mu?=
 =?us-ascii?Q?Rzyu4lYf9N7uyXm/T9yEwOg1o23BSgieutBjH9KK8XVAm46QlyiUsVBtzK02?=
 =?us-ascii?Q?xUUhiEUvwbIiz6InnF9BbVOeWHAZ6Upwj4sfiYTPQdrOTQYo14mt7XFN0p9t?=
 =?us-ascii?Q?TlQqsQAnpd7JiyvEBKuau2TSLlc9XPGRQmVjeAPL9Y1u/8Hcc2EOm+B1KGiF?=
 =?us-ascii?Q?jVfOTCW1L2aLzPZY/p98thWCJZuTV9VdrTfw3H1Od+RhwKSMWJgJ6pDsk4Hz?=
 =?us-ascii?Q?VloIsZTx7+L6M6l3zElYPzanluuh181fwFmKjRikgHn+7AMegEKopcotjDZq?=
 =?us-ascii?Q?e8YIHVVMZt6PKA99peWM5ZMtYvQfF/am3bAUh7ZlRD684T6uT05FprD4hrUU?=
 =?us-ascii?Q?vRuA35nAJqguvOtkkyDGZWdklWqR5s5xy2iOPta6/7RGRnWBxcTrz3rqvExx?=
 =?us-ascii?Q?0X/qkwcSoHG/KMdBCarL40KyUxOjUbsJJkYbuliuwTW0f4Am50s9f0qxpJRO?=
 =?us-ascii?Q?dEicr/yqOAugSUpvhf8UfaBYYij786duhJBcfEF3dne6LHRmWn25GuXeF+Om?=
 =?us-ascii?Q?JzxBBbP4DEqSv6Qep3ZTePypfGAJcUxoDjqd2omQrHHZchbvCex7dLsOBw8T?=
 =?us-ascii?Q?zf7d70hu70pRFehylWO+DCkrar5YSuR2V5FKjyYCiynyR+LL1zZ0X38cGHlR?=
 =?us-ascii?Q?JdGG/jGZhc9onfOFB6iBPeU2yhAA8d5extNjn0jTc75Bkv79qdyTAs3uQ1cK?=
 =?us-ascii?Q?OrL6h9azkItuoslPG0QEPcZnbiwKSzjkkl3qh8G0xijx8b/RUJgiaJT9kfzy?=
 =?us-ascii?Q?ZzIMZH2Omd8FoyE/3F8Or4+NN8fUyMlBORgpWz1kAXEKiTHAkroMPXvhtJ/X?=
 =?us-ascii?Q?pebw2yvwZkNt0ogVFpol3btMbMaqUsrTsqzOxf0yy+GuevuacSM9WC45l7im?=
 =?us-ascii?Q?V5Obk8zuFQ6O0FZFZUOrpv+FvDxxDak/LKAEJxBbvv3Pigf8pVbRLh3ZlE1T?=
 =?us-ascii?Q?QtlZ5nElNtrCY2yWpm87PwVbj2Tz6g8=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d1285f9-8a8c-4144-33f4-08df0a9fb264
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 16:15:11.9631 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fzpbMvYdrNA3NVG1G7VTnd0/9ttxsuY4P2IJCX4fHfgFhlALCSdXRrsJWVe5GVBz9GhZmN/rv+dA/XvsScs9LchIeDZxdCnDIwZ8GrN1ijc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU2PPFE04A6CE19
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

U-Boot configures the AIPS bus access controls and the i.MX6UL SNVS
low-power registers before its console is available. Its timer setup
also enables the system counter through the control window on AIPS2.

These blocks are not modeled yet. Map unimplemented regions at their
documented addresses so early firmware accesses complete without
falling through to unmapped memory.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

(no changes since v1)

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


