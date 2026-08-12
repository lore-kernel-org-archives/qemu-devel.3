Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3B34C5CFCF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 01:37:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtxu9-000856-Pu; Tue, 11 Aug 2026 21:37:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wtxu5-000833-1C; Tue, 11 Aug 2026 21:37:14 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wtxu3-0001Wg-MT; Tue, 11 Aug 2026 21:37:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u9W27oQFWJYRTJx0y5UuQFP6IZVumLVdjU8J/qUOWcXeNlTzWE7V98JnlVNtHVuE73ZMYlAydkCo8yoAev+4otNzpTLRZ/fBp8B860PWy9HHKVEM0LiR1xQnjNz1ae5f79C5Mcxbf1+y2m2E8mmzY1+ZtywHcg9szuQo3mirG69f+u6atKRRVS56s7RRUww+VmmGDJY6M+/eCtD6ptjsd6h+9QHFt+coWExy3DqPyDahB+frlR08LgZQHbppGa0VspeXMXfJH61Z9ut6bb1Nzex2ph0E+54TD+R2U9E9uEJHHyd5hzf2uRJIU4lmbPiJskgY/hWPtCI9fSMryw/A3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bucIR7NYPaZ+//pDV45Z1AJy0Vpm8qw5cGhAa98pCto=;
 b=Xf9k6ItqpcgZ1lb3JnsD6HiQICOVFXLtrl5y3KyAcXtRxU1Ak/c0uPvep01PHKr9JYOThfBbeXQNy43VMc1MWrhmIZLtTplqa19rCWOWKyXP1jUED7x3Kso+6hzK1BQwfcxnzUe7x7vQ5eeS1cHZVTVT4wqYx9HNA6GjHq+QRQmMRC6aGvFyuNBA3BbruyNJOLB5dvmaDVP25IhtEBGUaMakgfLwokeP1UnUY7P0+XnCzloM2aEykStA8s9eDDUX8I/TDgZeJcIGlPLT+o4ohUodcCc7MtNq6H6KJN+/YHrFll/xQ16KQYVtKoekBIO45CAsZcOP9UJsrCJrTpbDjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bucIR7NYPaZ+//pDV45Z1AJy0Vpm8qw5cGhAa98pCto=;
 b=iYskJdWzeTGEctONoye/jePhb6MoHXdxbUV0+QD181rceFqoebaeHzWg4dx8UftF0utFUJVc8rPL/F95eKwvJ0CUplAfHb8kQpVKKqsUKE4AHGsDYeJOAWkOyOEhc1edw8Ns2Naac6e54TuBT8vlHpEzOLkQ9bJss413Zw8Hk6fx6b1a4LjTZkIHVBBtBziDjmyGo7SLYK70r3RNWQASaUaWoJR/e0aFWjCHdyry3awXLdySssw/A+h1yJy4gS3NVilgUax9O4O7VhmvoIZ15FGt7Cw+3XZ+yPxdEdzGtTXG57Ds9aoULAP8A4PxEIgC9wMFpqgBBlYGtCAK0BZguA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by KUXPR02MB9309.apcprd02.prod.outlook.com (2603:1096:d10:9f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 12 Aug
 2026 01:36:51 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0315.012; Wed, 12 Aug 2026
 01:36:51 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH 02/10] hw/misc: imx6ul_ccm: Update PMU_MISC0 reset value
Date: Wed, 12 Aug 2026 09:36:05 +0800
Message-ID: <20260812013619.2134092-3-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6e6bcf05-8c18-4635-e124-08def8122ecc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 1EC7jLFY+Rhc77RmdSpoT9W9QAG30kWW6oSw5GVA7Yt3+fxkg8UUUv5aKIgoDTv4Yh0TM3GB8wOj9yVWwY2ZsI/RUIbhx1AJ8/8ySw/AiP7le3c/HFCfuWney3oEVuQCc4TH7201ZfMBlg2KZ4J8+C/QBdbzEGTaGGKa9wB2dtXb5TMU/iOc5ELG9fsrzQTKyb3YoIyFeebf/MV3s2WXujjlWL/H8Mrp266FnsymI8SmiRKekNJZ4pE9SEisH7LASTOs8eoQwq9wvG51RN07Io/rQMPsFkGy+vj0d/MsM5jDUoj7q1b9niLjyXY0WmHTkvFORPAplAVjk7A6p2QaQShboHAsoxK7WHzHLdEbvYsuLo+3D8WEFUd+GxsXc2dTbTeu0dxzSWq+kZ4s/Ib199muB8/LoQzgzDZqChGe6Qs6LLAxlBAuPL2OyGiSJHEMBk/R/w3W3ABGvRNKmxY5O8gjQz9dv/cNC03+THczmaHFbCHO2vmBjduxQMvc8FFiTOmMJEN0bbIlhTqTUXinOR9jCRFzzuXLU4wMImAWUjjnqGGQzKrPh/Rl/99gZCv11l++cEETGAHBIDnzDLh+QEuf4JyzxqPtztZqh0rUkLDvy1oWhPlTLxLhp6Rm6zoWQKMOaNY36O6x7mRtv2JGWgQPe5CiaEeLNlAcDJHkidw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?McMM9TxTBw0elUmzGmBOLcrnTKvoTX8axoW8Y7tMFxdRET6eT9Nmdl48IhI2?=
 =?us-ascii?Q?os/YAIJM5Sxzt+h+0QvDYtk0vLfrGVLwNEMQWQ6m3aqxOHbdSio4/gYzGMZq?=
 =?us-ascii?Q?UPALGqCzjouDwFO3fuppbS7oH9Ht6DzKvCPVsKL6t9IVk1Bwlz8BmKRCfK5k?=
 =?us-ascii?Q?KOCXg/sBSVzr5K2CGchYizV8EdtYAzCms470jUNYRM+thbUTrozWfMQ7vuK5?=
 =?us-ascii?Q?5rMjX+hqSuCZbHw/odb61VQVvmi8Btqw2NJK+U3vQNQH7MBR3PfHISr346te?=
 =?us-ascii?Q?z2Tl/JH9PaqmG4eVmU8xfFhBRLSeCY3qhs6tnDa4HgH5AwAVB1R9rhw3enI0?=
 =?us-ascii?Q?8On24RRhd676MTLUMyXUWsvlfs9RVu9v8oMBOi3DeT5Y7A4VsjxORkkhu8lR?=
 =?us-ascii?Q?Pz1QdmbhHIeWCw/m+gOwxQa/AFf61gaJQ8o0lJ82ClGkzVWmlPvNTR0EgDyO?=
 =?us-ascii?Q?P/+/NU2FaMCN8lwCg+ze1vxjZOss33fBZdTgs89DyESe1SGWlG4u0eRnuvcy?=
 =?us-ascii?Q?xFkTvS036ltTBvhS9aQWnO1lIYyRw8k2yolIZtz4gUoloupgcxgk67xDa3Vr?=
 =?us-ascii?Q?qX7lChiSvGPGnBmFCvrkPymWKxfmt8337u1LrY7BcgoMRnUdDTVSg5GVXHaM?=
 =?us-ascii?Q?HICjgpsOtCcQVFu23vxOl7+oD7exn2Rr4jfkrjC3u5ql1LPDO3wJZAutFNKV?=
 =?us-ascii?Q?NyreS+Otid8RSGzkwGBgVCrYsDGSC2erRYzXafANRsnVFV1C0hKXkWUR/tME?=
 =?us-ascii?Q?6bKfWCYEo18uuspJlnLV31xxmbP1Ad4UPt/VZ7XTHeY0ipa9BuwtGVaOCurl?=
 =?us-ascii?Q?K1nbkFRmerm4PiuY8EEywDwca+i6qGkXesCWe+m7I7siDWJi9DaY9osFPmLM?=
 =?us-ascii?Q?8Q6h3a1thRfWNj+Va2Pi9EmRNpbe5+Gnoz6qgnT8MU8NkxYF5xwvM+zDPfKm?=
 =?us-ascii?Q?+6+wdcDkkojgRJUSRoMpeHh86QJU54J3uxMTdgSPavA2+MYMwgx+wDmRbFt1?=
 =?us-ascii?Q?gh7ORso/9gaDSEpatCeeLWTScYwP0rgwRaoiiPfjF4N/jUdKPhv8+2HLku1S?=
 =?us-ascii?Q?IKFdZKQ0lq1Quk0wvc8RzrYV5BgvqkWHgoJCbRIZdEOhVwOcgHfvi2NKaLk0?=
 =?us-ascii?Q?C/X66gE1G4m84FCp3m7Mwgbp/7t8F+M7Z+LpsDv5xo9BJNo8Bsnh5IY5SYK4?=
 =?us-ascii?Q?mPj/MClo6pTBsc42Bt0it8M6sBAwy8tHvcPXgg3hZR+8KVke9LrOjqvSNmxc?=
 =?us-ascii?Q?ZhgeHWW0gadXlqlai6/RIyGDgnrggbEt3KuFa6oQYfNspd62wK7Q0V7IO56R?=
 =?us-ascii?Q?h+Bl78EZmikixD1L2z7Cx+o0tKmBLp4Hf3AmdlUrpe7DulSd6a657bnZik5P?=
 =?us-ascii?Q?LdSc9nEfocvxZPGS4MBGTXESaIXAVmti2fZayC+axffU+AXDnqct52RSDwIq?=
 =?us-ascii?Q?FyzhvyJBBLrz5M2HchOdbMGuYCcpuX0lA/zqY0cqGH4xZrb5xpssNtSSqMcR?=
 =?us-ascii?Q?/Ce3EPf8XnMFLU9IL0WkD2XXTGrJkZlPV4p8tNC+TkW9M0OL2PEFg7tyWhWt?=
 =?us-ascii?Q?1wGI9m3EXGKMuJvOEef3zM+hL9AJ7J6zOOoTfkAPXgsrB4V8UhzorZoAbOxE?=
 =?us-ascii?Q?IYOSQCWSNq9I3hOFDHGpaAXyA66gBxEsDBW3pYw57UAfAtnRUG6J+HuPTEG/?=
 =?us-ascii?Q?jio/lgHiNNfBPpbkh8u/+TGwRR7RaukYmGEWzatMnA1RBHFdL6J77M5aWhDI?=
 =?us-ascii?Q?wI/gthgPtzSR/CUr97KqazfDVNHz2gw=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e6bcf05-8c18-4635-e124-08def8122ecc
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 01:36:51.4826 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bI2dykLatuiSpLIm+44K7HEkbpO3JyoPmlJntsegcSrLOirrLpUI3OivRcUlzdyotZoD/enBKWfXt2ySakJgq/bsJpJnZDXr+P1Va0AgQLU=
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

Commit 56a11a9b7580 ("hw/misc: imx6_ccm: Update PMU_MISC0 reset value")
updated the i.MX6 CCM model so U-Boot sees PMU_MISC0[REFTOP_VBGUP]
set after reset. The i.MX6UL CCM model still returns this bit clear,
causing U-Boot init_bandgap() to wait for a state that the model
never reaches.

Apply the same reset behavior to the i.MX6UL CCM model so U-Boot
can observe that the bandgap has stabilized.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

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


