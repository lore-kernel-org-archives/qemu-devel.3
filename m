Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65417D49211
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 11:49:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD0Fb-0006sS-K6; Mon, 18 Nov 2024 06:49:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.yuan@jaguarmicro.com>)
 id 1tD0FZ-0006sC-U3; Mon, 18 Nov 2024 06:49:01 -0500
Received: from mail-psaapc01on20717.outbound.protection.outlook.com
 ([2a01:111:f403:200e::717]
 helo=APC01-PSA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.yuan@jaguarmicro.com>)
 id 1tD0FX-0003XH-MJ; Mon, 18 Nov 2024 06:49:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tO95k4XzBNvaSGOGqVKzpsLGkm7jFGq29+Vx0htRAYv524/1+FQ+0DPRlShY/Lel1ffwwknanpcYnl4J4GjYAJcPCZuu1EQ3nrQwgxpRoNPQjXzWgr6PEkJzp80KkqIc5h14InueCLjnP+ktpLfNw+kBSFu1u7k43Ty+0TcCALrI+7yiF2AmXQhaAThr0RSDZV1w8b7+zP/v+8S/IlaLvTS1ACxy317mtek67a0CMnoSgw+paFq8Xxpr3K6BKKalXug1/XK3YYm0MQs+l671XlIlCsHTSa7cI+krQAHCpUe21/eI2XnSRDG6Sw/23uFjYzU3StesIwgNhboIDWn0rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A1NWygWwr0X6XNGAjmwmU58VF9RftDRAT8j6yFpAoi0=;
 b=BOzyiVm7/UchzX832qZ1k46COXSVttUD+25rrEI8A510Rt/h8HluWtnEoixPqlC/xwgsq+KYAiP84pwnVtiEiEQDYpSVfZ0agii2Ply/ysHvFetvgnPJp+NtAnAxFz7mNDNrG5Smkk/V7Q5P65UjaTxexV8E4tnsgeJdqjo679wlT5dqkcgWBFYsNDyQLpdVg56geyn1hVmXacWP6n3PW/3KhEQ8WY6NlxkgXFZSg6ao3VxjEzc/9pYKvMLmTvZJdsTgq1d3H1K36RVoC5DoylXFFRcMDHlHfBwlQCVtOjPt9Nqa7aTFiPhGec8p5h06Kf/pPLAPQRqPpSVYjVuFqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1NWygWwr0X6XNGAjmwmU58VF9RftDRAT8j6yFpAoi0=;
 b=LMCsPzf0QJMnnHTtiReGIDjZjg00dV9vMEpdA3CLfl0rUCgJF8B2+0jRucpaDR0iwAmOa+ZXKTB2saR1L/N/3xBsS5B4vzSMZRAI6Hrv5h/lSsVtwxNSX2LSQesUCH+Hw4vlL4KbFe1LAnTyBWTGykwaoiSzE492xS1aBSDnAEvSfUaUhL0ckgPt8tEBTHAsDmGaLKaO8w4ok3Gav8gOF/B03jyXKyw07ljibd8V30u1DPvy6/b5rX3XDbGEm05tPPmGfbLPai+chfeq1eeFHjKFdpC4LsnM4g57eNfQ9tsKnxmASsxh0tS9s5iP116SFfV+das9kowcrdcsuQgGRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from KL1PR0601MB4891.apcprd06.prod.outlook.com (2603:1096:820:ae::7)
 by TYUPR06MB5925.apcprd06.prod.outlook.com (2603:1096:400:354::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.11; Mon, 18 Nov
 2024 11:48:42 +0000
Received: from KL1PR0601MB4891.apcprd06.prod.outlook.com
 ([fe80::8950:42de:2354:91b2]) by KL1PR0601MB4891.apcprd06.prod.outlook.com
 ([fe80::8950:42de:2354:91b2%3]) with mapi id 15.20.8182.013; Mon, 18 Nov 2024
 11:48:42 +0000
From: "Andrew.Yuan" <andrew.yuan@jaguarmicro.com>
To: edgar.iglesias@gmail.com, alistair@alistair23.me, jasowang@redhat.com,
 peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Andrew Yuan <andrew.yuan@jaguarmicro.com>
Subject: [PATCH] hw/net: cadence_gem: feat: add logic for the DISABLE_MASK bit
 in type2_compare_x_word_1
Date: Mon, 18 Nov 2024 19:48:06 +0800
Message-Id: <20241118114806.1119-1-andrew.yuan@jaguarmicro.com>
X-Mailer: git-send-email 2.37.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0242.apcprd06.prod.outlook.com
 (2603:1096:4:ac::26) To KL1PR0601MB4891.apcprd06.prod.outlook.com
 (2603:1096:820:ae::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4891:EE_|TYUPR06MB5925:EE_
X-MS-Office365-Filtering-Correlation-Id: 9478fc05-5be5-47a9-76b0-08dd07c6f359
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mYCksT8BdVlqI/NafcNJLcr2dWwz9R+vRF+4p8uaZsuFo+s7XBt/pAAkdqzl?=
 =?us-ascii?Q?jL1WZ1yYJdivDDErYp4+8NmLIwhmvsWhUGHgVW+LDYYKMnBHR/acat7+raM9?=
 =?us-ascii?Q?k+BborSWv2uNI15lPG5U8zaSSiYRiQOnWAq8t5pNv/5fJqsXkgHKHvvnai63?=
 =?us-ascii?Q?eMkfsM+BPZPY1cvDsS6eLrNOSTbWK7cwLy/jlp/5iggZCKsZ+ADH5/MeDLQr?=
 =?us-ascii?Q?IOxnJyJ6co+f+hA7s6cKGvtcRjadO7U9s31w0Y5UgAKMmg4oI53skOg8Bior?=
 =?us-ascii?Q?qQL1Ec2k9fMuDSfHe5bHdALS02yxTvoKMWSnU7NYXCJyMjHbkAw+nH/VvrXf?=
 =?us-ascii?Q?V7/wY4hbgSRvPujZWt+PRs9DE4pxjRtNbi0+WbhZ1ZfBRqB5NLiezKkv/OHu?=
 =?us-ascii?Q?/bHmUoaOIbSrERKoHhNIf+jLZfTH8wsLF2wpVE8yO3ZRE+LYY4mFLw7u+Zvu?=
 =?us-ascii?Q?tiTVcDPjknkgGGzxTtinZqYKjMTtHtwKzRt/2WAcAIoIR7kaBxexsdFUmfTh?=
 =?us-ascii?Q?rbW7Ky7kY35AUfnhZpYWCuppEpsp3urBsQxwubw7/ES/n+9QH/zNXKG6LoWC?=
 =?us-ascii?Q?c1/UVh+CeXlhGEI/4L2vP27VKc8aNCEO4aaBYBgn4DWGnxTlUjp7fHTxEYe8?=
 =?us-ascii?Q?adjUXHV64tB1TBCwcR1Weh1Qrsx9QkakLZV46UoIw1j4b3Q9XTRFy2sxuQMB?=
 =?us-ascii?Q?FDBtd2kpq1cohY5riAntdq0QFUWFl9Rj6Vg8ETF0CUwAbA+BatDGLpD8Y/FG?=
 =?us-ascii?Q?Z0Ek1Ue0+NXl5uk6Wx048l3hAl2jY2VrTr85MaN6YXiLXu1s+BSU/KKMdu5c?=
 =?us-ascii?Q?UnTcz1sjLjbnjDUbazbnZ1UJxA3HoIrlLAVo8mlSQJnel9By/usETETeHsT0?=
 =?us-ascii?Q?Shdc3ZPM4XOOV8fvCUlRGuaL7v2h32AfWWQs/YsV58nSQ84D3LqS/nf2cFb2?=
 =?us-ascii?Q?ToFeRYSRwdrnJ/nD3O2LCMdl8T4EevceVI2S6H1tJ4R+bYsJG1ZrP/kmK1OE?=
 =?us-ascii?Q?NA3u3Rj2lM81HCKLMvN2tvazEcENA5AcLtYwJ4/T9AZ3MGIE5Aeyns4/Rg44?=
 =?us-ascii?Q?eDr3MyqSFvhBWVHhVW2Qqzj9Wm43u+UlexzsKJ+7U6gyoFwNZ30QlV2Zad4Y?=
 =?us-ascii?Q?E84Tci/4wh6NmKUxgY3tdEkcVSwi9wTnzTMhvvMb9LAlzeFHt7jg2c7M82Fu?=
 =?us-ascii?Q?HTwXQBY/DjxX+5qwljHFpyGdFa5Is5QaTfdUNnQLwU6fNNU2xavwaiyLHAva?=
 =?us-ascii?Q?9IplPm0+UViqwFQui/Ibt5JZVepE6UUSCGfsa1r4ooNzhvwFIpp5W+NUcL1H?=
 =?us-ascii?Q?esbM7FRKgf4kkSlsqi4OkJUBq0KZbB9IFH0PzmEsPJ4eRfve/L4V7R3RmGUC?=
 =?us-ascii?Q?neqaIfI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR0601MB4891.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IDD/mASO06nPfVR+SeR7VO3XBufzQFch3+LjcpXo/OtMC596+1VQwvV3aXUB?=
 =?us-ascii?Q?skmmBq5rN4nHNjp6SWF7Yrr1neT/LNyv7OXrCglZ3U2V8gF+p+YpbLMZDAxy?=
 =?us-ascii?Q?WaKRzr3RHH8yVH8n34RTnzN4nUiWlG9yA3WY7vzv6kmBiJwR35KDNAR6mo1v?=
 =?us-ascii?Q?ebhboaCEROp57US/2LL/xAY6nXsw3PLHT06gek+OqJY45TRMemtHI+o3F2Lf?=
 =?us-ascii?Q?5sTKNiclvznCfPPZ9fbbIwTmWMykKOjb8HMwQi6POe1r+lQJC+2XKz+ukFaG?=
 =?us-ascii?Q?9DiyNWH/u41LHyJ4J/hHKAsNxUUlWs8ywCTTFTI4TpIC/dXgEGk5LTeIRFCb?=
 =?us-ascii?Q?LfamBEsGMqdX0oC+qWzwcsG+6l9gigtKe0qB9NWaqlS0EQbPw7aR0ecmRe0P?=
 =?us-ascii?Q?ShNshWRLoP38jJOg9ZBHu72Erx6xRcF7GNKTNXM8exzRq4eUTAk2ugkRi8Dr?=
 =?us-ascii?Q?AgEEwON2qPwYSATZzp9mSWoJc11/G6wTGdOs1SBVLvLskUnfEc+Sb2IjZhyB?=
 =?us-ascii?Q?Alahu73OFOCX1LTsflte0bpZY/wyYqC/F7CrKtovLo4Bdw3oKNNAFDrBOfTg?=
 =?us-ascii?Q?ADxONvgy6UDt1e7R00zxlnZvlfUSghW27PcFstegP85bFk+p/J/skDjQ3szv?=
 =?us-ascii?Q?bLB8x3P0Pl7OoIA69aKch3GzatqOInD2GT83ogKriGBZy6DnAMq0I7J4Mqjj?=
 =?us-ascii?Q?ikHVREhlSQE/QBFlEPzEUjmjg2qYL8tmR6b6Qt6CD0DHLx60y5Nsr/bnSaxA?=
 =?us-ascii?Q?O2jo1h82gmXsFpn0m2q3UrgQ4BlzAeXLVFUL4m4zLwzsHWinBzYB2YxhP5s/?=
 =?us-ascii?Q?G/hHIzIP/VW4LnLo4A1I3YOuV1AaB6PgCmPkh78rNBu8EoI9/Mubgr4MXJru?=
 =?us-ascii?Q?fvFoOflfMVdPoEEllVy2IUqpvZfs0vOEpPP0djC+Y1JPozlIW9IhROMz155f?=
 =?us-ascii?Q?EYA6Y0EQJwsAESCFH2yU8My3uYKz3wN0t6OFEQvWMcyn6Y5f55X9KgoD0NoZ?=
 =?us-ascii?Q?Ws0O4q8CHXaKjJi+XD4osyMPRmvCI8WoaeLv/CWw1h800AVw91rgxEKv2rPN?=
 =?us-ascii?Q?0msBio3ZW90RwmHOFYMBiJfxsNyqC0YL2TGE979sLmNvofVJcjwNQIQ5DyGq?=
 =?us-ascii?Q?TWfMPIicG/i2nn08rZGc0tSSH6z9lCqyNf6I76zbdrOZ7Xf1rftUSeeCBV1f?=
 =?us-ascii?Q?M+lrZDuLE8HldqRCqsq3PfBi1sBV14XqQ+qMs0K3qfXPrjDUrNQ/qpR+FDFl?=
 =?us-ascii?Q?k8KOtj0/vXvi+YnakXsv4flahw0cTWPde2rzN34i/MCLElA8PInWdjoUncsD?=
 =?us-ascii?Q?XBrbUm5VUgXWFbAmochyddDHaKSN9RV3MZdFWMhKwpLZGsugHvM11ljCjnBi?=
 =?us-ascii?Q?wONZTCdskjYUNi1PmlV7SWkTE8CePm2Hh6k03pfYSSoyLYCfVAvGPcbJcyih?=
 =?us-ascii?Q?86PaiRDdJrXjCRN4JKpp3VsBUTiLS2NLublwUyk3iLcCZP4QR1VJx2nLIVxl?=
 =?us-ascii?Q?jzcsVUqMjOMN+8tZuCWCGatJMdGkxHcczvwonthwz3m2EpVkVJuYLmaCD8H8?=
 =?us-ascii?Q?7H7cVRyTKyEbQei3CU/FfwNQVDy+cc+0+5OD4x2BxhAagtWnTNN3hF1tGLxh?=
 =?us-ascii?Q?wA=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9478fc05-5be5-47a9-76b0-08dd07c6f359
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4891.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 11:48:42.5786 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3NZ176UR0fnGxwlpnBrOI9pe06Luqz7cOS9SrPGzWV6YDVmFPNPqXDevmZLEC4ybRx4dyNGzAP2DLJ2/LoRENDut/+7UFWczmAzgS/0GS34=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB5925
Received-SPF: pass client-ip=2a01:111:f403:200e::717;
 envelope-from=andrew.yuan@jaguarmicro.com;
 helo=APC01-PSA-obe.outbound.protection.outlook.com
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

From: Andrew Yuan <andrew.yuan@jaguarmicro.com>

As in the Cadence IP for Gigabit Ethernet MAC Part Number: IP7014 IP Rev: R1p12 - Doc Rev: 1.3 User Guide,
if the DISABLE_MASK bit in type2_compare_x_word_1 is set,
mask_value in type2_compare_x_word_0 is used as an additional 2 byte Compare Value

Signed-off-by: Andrew Yuan <andrew.yuan@jaguarmicro.com>
---
 hw/net/cadence_gem.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 526739887c..7ec5dbaa9c 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -909,8 +909,8 @@ static int get_queue_from_screen(CadenceGEMState *s, uint8_t *rxbuf_ptr,
 
         /* Compare A, B, C */
         for (j = 0; j < 3; j++) {
-            uint32_t cr0, cr1, mask, compare;
-            uint16_t rx_cmp;
+            uint32_t cr0, cr1, mask, compare, disable_mask;
+            uint32_t rx_cmp;
             int offset;
             int cr_idx = extract32(reg, R_SCREENING_TYPE2_REG0_COMPARE_A_SHIFT + j * 6,
                                    R_SCREENING_TYPE2_REG0_COMPARE_A_LENGTH);
@@ -946,9 +946,24 @@ static int get_queue_from_screen(CadenceGEMState *s, uint8_t *rxbuf_ptr,
                 break;
             }
 
-            rx_cmp = rxbuf_ptr[offset] << 8 | rxbuf_ptr[offset];
-            mask = FIELD_EX32(cr0, TYPE2_COMPARE_0_WORD_0, MASK_VALUE);
-            compare = FIELD_EX32(cr0, TYPE2_COMPARE_0_WORD_0, COMPARE_VALUE);
+            disable_mask =
+                FIELD_EX32(cr1, TYPE2_COMPARE_0_WORD_1, DISABLE_MASK);
+            if (disable_mask) {
+                /*
+                 * If disable_mask is set,
+                 * mask_value is used as an additional 2 byte Compare Value.
+                 * To simple, set mask = 0xFFFFFFFF, if disable_maks is set.
+                 */
+                rx_cmp = rxbuf_ptr[offset + 3] << 8 | rxbuf_ptr[offset + 2] |\
+                         rxbuf_ptr[offset + 1] << 8 | rxbuf_ptr[offset];
+                mask = 0xFFFFFFFF;
+                compare = cr0;
+            } else {
+                rx_cmp = rxbuf_ptr[offset + 1] << 8 | rxbuf_ptr[offset];
+                mask = FIELD_EX32(cr0, TYPE2_COMPARE_0_WORD_0, MASK_VALUE);
+                compare =
+                    FIELD_EX32(cr0, TYPE2_COMPARE_0_WORD_0, COMPARE_VALUE);
+            }
 
             if ((rx_cmp & mask) == (compare & mask)) {
                 matched = true;
-- 
2.25.1


