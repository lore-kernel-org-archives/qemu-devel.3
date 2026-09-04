Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3993C624DE
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 16:15:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2WZe-00047W-8t; Fri, 04 Sep 2026 12:15:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WZR-0003rF-UL; Fri, 04 Sep 2026 12:15:18 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WZQ-0008SI-AR; Fri, 04 Sep 2026 12:15:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L31O4c+F7ttvtpAuxcllrsLfV1VwC18prAYmb9XeEwe8gVnD2YA/+m/kXn0xeBhOWmRhbxcnjuonPLMzmSnYrnYr61v7crpJ50n8rm40yCaqoGtKNhb8Y0qSlBVNt+H5QGS+XDXBX5tBaSVhwf1eZBbzPb01TzER8noSIIW2lzM/ZKpogY8RFicv+AHVM9nJvKWITnmTNH6TTDfaRAlN9ovjgZHom5MwhL5zTUhnHTzcHISoqrwlHkev+J0zoQKDnulKsRDuCEOd5WXPalZ8F5x6PDKe3GurVy3D8LsdmidxdcnkEiyMQFtxumD2MD+GqjRyhCgdO243lGTbrNVaTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFkH+FxzzXdpSNXj7I6qAD6vZ7uTcOgjP293Bd191pI=;
 b=kvoLQlzs3f0Sci3SIwtHyT2clXV/VEri3f+KegVbLG5hOJHImqDFzqN/Jduv173VnZ4qHIEFoe3mmOJQKpkZkejp8AhdAp3z15Lo8R/FjFkEwQvxO0wC3YaP6hDs3DaEpHa5fIsGIQe0YwOkDyd9OUomQlrXhcwhtyh9F6GgfdmzYJnmuomWpQwZPJD3+2a1yVEoiqek1a03Wwk4THoPRBAr3bTDNimgT9mTAyy0vGkJSRSRybhw34/qIIsU3WSIpbnj46O5PHnSpcOrFIc32VGtXrMRRhqK3CVbF29obQ6VNDf0iMN4wyXhGosPzy2nr7RNZartjiJpHsmDJgWzXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFkH+FxzzXdpSNXj7I6qAD6vZ7uTcOgjP293Bd191pI=;
 b=GxFPe39Gu0lO7o8neJ//UGwCUBxpRq850MNpfeycBgOAoF/2yhtgji/AxTEPi50rutvu+WAjGIYLSCMIIJw63lUiGWDieDq9NdU0fgnNbIFfAqAfjgxK6Uqm+n6/lo5B7MRjATWElxvkxMQO6Ps6z7rOvc8/2jyGFKj3585iw6hDok7ke1mnkwLc8vy0wJXvluta4U0IjbVxfpuH4GFJskeOeeIYwzoawZix+IQ6Is6lbmCoGFvyr0YeVfdbc8CWOBtpsJAXgRXbcDRAILyyVAOeXZl6DkFOYhZkyx3GdkMHZWyxme8adoGBidd8ia9/XtuoTlg64LDptE6Hf8TcMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by KU2PPFE04A6CE19.apcprd02.prod.outlook.com (2603:1096:d18::46b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 16:15:08 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0382.007; Fri, 4 Sep 2026
 16:15:08 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH v2 02/10] hw/misc: imx6ul_ccm: Update PMU_MISC0 reset value
Date: Sat,  5 Sep 2026 00:14:25 +0800
Message-ID: <20260904161438.3838261-3-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: 16dda1ad-bc41-4248-8e7d-08df0a9fb03d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|22082099003|18002099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: UbGob8lXGZr8MRgTKJK6v6xh2xsfeUAnWrtYRBnG1p4y4KyZSBsZgD9AgUxWsuIkH5vsQz5XmbwD4YWDXXCbuGBM6ZlnIxIDkpXLsiOPGwWPi8BrONxBHYMWugG4/rlTEgwaGMMDPevtv0uHHrfDX+vlXOw9gWpqIywFDMYEdtSt+KDq1onc5xcqLt9qC50gqTHvkbR+tA/WKHz7s6xxnEMZmI6atxCIa99dCUZBNpPgT2NPi/Abeps3vbxCdRS/KfNw0Omtu0xXxwWZKfwYGCnRHUWCMforFnhIQVgpZtBRAzVN5A8bGUfuiriDJLOcCaZsyHIjp8gWbWNcyjFQ6meFMymYX47mo2X+GF4EQ3b3N8sG36liQ2Z/bGLkhlbnBkyOO431jNI0KkYkwMZJB0YhIaqcZbpdiiVDHZWENvWxv2eHTg5UehsdC/ofJPT3PhNu56/pdetJQO4CEfbSRO1w2C0T5grFQr+tbdf1EbH1VYOnUFOKPtAq3J7G89S7G1fXxhW9anEhvJNZ4j4ljh4I3qkt3Xf4mPOQMX3KLmnZhvumI9Ss+CbvreYvNFK9qEqrvW8rwzfREFjYYx1cH6f/rW55iiSxAQPy/FUsKBBepjmL8bnumvnh03U4I6DfDtR8UllvkKFmSoJ4G8v1H5t1zs9ycJ5iniDKtdV3m7Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O2vgiCmiQ6eapUs9X759hf2jHsNDFKG2bO8Qefd9VK6I036aUZ6a2ZrdqkpI?=
 =?us-ascii?Q?y0XERhDAFmAJ5kV49HZjS1JeTBRs8JcLn00EIhaEUJVNcgwSB9ztil/NCNaH?=
 =?us-ascii?Q?ixFq5LxX4ArF2knRC9ygP6VIopgYANL9l9CehjbI68baKJTJbkJ2vS4SV4yu?=
 =?us-ascii?Q?/XdHcKWMx5qcqILT5KDfilwbh5Y9jXAqKc6x6j3QQNxIdvZgyCTg6YDbmAiV?=
 =?us-ascii?Q?b8QjKyJh6MUOpECXMXedb5YqbotfKCV/j41+/duoMG3dVC3T/Zz7uuRcc46G?=
 =?us-ascii?Q?geH6VCKEYXwGoDWC19r+OGcI19jeDaAn7b7EDXj2AljtuVtHpm7zFdlHCMuf?=
 =?us-ascii?Q?+eHKxGtFsVKBuGfx7eQ0ZH+Uwilg7frd5mATRzwMGgxNMbGPb5m8NZ71q7Tk?=
 =?us-ascii?Q?vtsjaKFfUx8VTXp/WdEBrmUiBz7eqRChXkMUfd7q6PYycQn5zqtefK4nO+ew?=
 =?us-ascii?Q?Na/XyBd5VEsgLFg1uDbjvXXmN0dUt4H22X82JsaIGeLBo+GPQNZWZR2GivDH?=
 =?us-ascii?Q?bLEJ+2gtnyD4gGjoIJILDve8+RImJ2UXq8qEkWlLKWIJ7tWm989rOcIITeaU?=
 =?us-ascii?Q?KprI+2Ixsrb1E0vDUVIkds8iENh6GIDC2tQC46x+jv5U9ljSow2J2OdVE4ar?=
 =?us-ascii?Q?kz2GuYgkeDCVHIIT65kVcUpjea4xoPWKc5HdbIwCJ/ZMoW6ihycNl2lr1eO7?=
 =?us-ascii?Q?X/CWjHAp1BAoMkXkb72Y1Ui/xtMKLjgo1YfZPfdnYRAwskyf8G8I2M/XB7ok?=
 =?us-ascii?Q?3Ok7VZiXFfU8/vdIgdgvIw53La1tF+CsX73P6ZzTyWm/eQ6W6vah8MymkMiE?=
 =?us-ascii?Q?l8tdJBRD94fPGcGOrrTvRfDXGhH02ONzerIoIdidWtxqLhFE8XAtIlxtjjb3?=
 =?us-ascii?Q?yq4HJ8DpXo12LVSzZPWDr+2NxQquvU4qFff/TFWxpNOO1vDJKEyeeENpFAUa?=
 =?us-ascii?Q?+j6tSGaEyQQvcFVqbjoNl0964bXjVr3jo+5P8peQr7A+b/UOx6xGHNm9k6w6?=
 =?us-ascii?Q?GX37as7Z+IhEISf4kaSeOrYzft4tUTKzfy0YgVg3PrfMGQtg+j6XuSqGeOfS?=
 =?us-ascii?Q?mwR1XNe9aOVyKznBEUSDbHidNrhBZvMyesQX2zb682dP/QhbkdPVxtrHuOwi?=
 =?us-ascii?Q?ust+HFFjV/cTzr0JEhGQmiY4QtByTpoSER1sORLR0Aj/QG1KAYMitSOgfI8T?=
 =?us-ascii?Q?etf13+9m6TtT+YM55oM5HsaESVGG/1TygRWy/jm/TvT7SmSjMNkhw49hY2es?=
 =?us-ascii?Q?qUWPutcuuH2uYrPo9yQ2pcd4036CPbrNmlyLQlntb06NDzB9XH0IcXa/aV7/?=
 =?us-ascii?Q?RoXp3iRdCTr2xIT26XchGngrhoE75rEI1MrcdZKmtOgZJXVQRrf3ySo9zTK7?=
 =?us-ascii?Q?8WYBD1/U0mHFhmFNfYNrXAIjDeLM8rSmGyTcx0kOYLiJzGvHW66B2jcKxEwB?=
 =?us-ascii?Q?gncdCOza+v2beqRlzQZWVJoz9PZmyun+mUHL5tvolr0EwBwAfCsFiPL7n+8N?=
 =?us-ascii?Q?bzfT5IeYQHXLXzrn+UkpPBB+HrObDLiGld1L7+AqD7Hsm670y7tfdsOWfRSC?=
 =?us-ascii?Q?SXqx2lVzFU595Pfs3b93kMFfBfOTF2Y06uMj/HgLlGuOFMIHwY0AbqbiYfkJ?=
 =?us-ascii?Q?NVKDPmqpLf6gZm0W/Zxl3KmlRqD7Zz5V2rhEhO9SPQF6nrMoBcREuikw+EnL?=
 =?us-ascii?Q?/AWNZb7pbm+MPwQGu1KE6FvvEuh4iuVyr+dXXTA4iQLHfwaD5zaXCFZvXDWP?=
 =?us-ascii?Q?T3ZzmBJZPaEWtTYwLw2rqKn2kvMIh9s=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16dda1ad-bc41-4248-8e7d-08df0a9fb03d
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 16:15:08.5309 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dDpqPnz0wybss8dSdaOhApj5BBc3wPPIElmoohZOqLfqOb0Guja95DTIiaLms4v1NOha4NQBfA+Dm/QDN7BuJWL3IJNchKD8y/DTAUkVMjw=
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

Commit 56a11a9b7580 ("hw/misc: imx6_ccm: Update PMU_MISC0 reset value")
updated the i.MX6 CCM model so U-Boot sees PMU_MISC0[REFTOP_VBGUP]
set after reset. The i.MX6UL CCM model still returns this bit clear,
causing U-Boot init_bandgap() to wait for a state that the model
never reaches.

Apply the same reset behavior to the i.MX6UL CCM model so U-Boot
can observe that the bandgap has stabilized.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

(no changes since v1)

 hw/misc/imx6ul_ccm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/imx6ul_ccm.c b/hw/misc/imx6ul_ccm.c
index c4f6e372fe..4accbcbeed 100644
--- a/hw/misc/imx6ul_ccm.c
+++ b/hw/misc/imx6ul_ccm.c
@@ -592,7 +592,7 @@ static void imx6ul_ccm_reset(DeviceState *dev)
     s->analog[PMU_REG_3P0] = 0x00000F74;
     s->analog[PMU_REG_2P5] = 0x00001073;
     s->analog[PMU_REG_CORE] = 0x00482012;
-    s->analog[PMU_MISC0] = 0x04000000;
+    s->analog[PMU_MISC0] = 0x04000080;
     s->analog[PMU_MISC1] = 0x00000000;
     s->analog[PMU_MISC2] = 0x00272727;
     s->analog[PMU_LOWPWR_CTRL] = 0x00004009;
-- 
2.53.0


