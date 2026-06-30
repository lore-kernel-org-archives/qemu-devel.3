Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2DDAC43602
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 13:59:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weYyh-000218-3m; Tue, 30 Jun 2026 09:58:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1weYyd-00020M-Us; Tue, 30 Jun 2026 09:58:16 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1weYyc-0003om-Ak; Tue, 30 Jun 2026 09:58:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fqeWR2/46P1Q850EOFmMZOUYer1tT8IucRGf4hAl1FutDkfDMeII8OhmSd2Rt6aD9OF0OvnY5pGOWpPsOMf9N0hLon+1onT8N/1VNOcqDIk+U2emKOUDx+TX5HA7Q6Q/qWyP6TL64R9eaoQ88kpy1uitDKwotUVy07auWJtRFyILOmvG9RI8lKnRoIXXYCg1uHMxYdCiI6Ow9/GADTKjgmDiyz8YSOC5yyLJWz6SOzTjJTYG+czUCw3VjYHG3HpcklLwm2VDE+3rdjncW2G0OpoyzYTzodtq3eACiU6sG0P5HjHQpi6bK8rM01/VDsWgHw1xTWclR4iLEVMGCxJCDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SHnw/B+4SGmk7uUK3XX9T+nDhUFaptf/jqhd8hx1JiM=;
 b=MUogkzPi7QTp1gyV7xsG5exeka3Xnp+tzWlzr6eWAh62uNB0/mWHyz9qqTwcUkYBTm8leftPQAS+FSDB0sBfHJzFPWN5Ce8aiwhfASOg+3MRTGojZkIj7d1iJsHqGtZ6VtHRHrVQCXqBFPQPusxmo6+nHwBzxI+f25lbRAtKHQYYjiNz7BTCVHfL3DxG1X7eWcczsbJIsbJcbhjPHCnmk7jrfawhNNv/epOZ+7BSaVOP4AAf/fE5yl3EnMkL5jAIQzxjy/D1bweflQph2Wm8Py0ZZ4ZtnGzM4thE/NB19G1shan2JMtLqCF802Pc3O1mxumDY53nxOdL/trvXGkKWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHnw/B+4SGmk7uUK3XX9T+nDhUFaptf/jqhd8hx1JiM=;
 b=iiZpuYPRCjQ4Iz5ZkmumRjYRJSevOUaclk+PG8TrpqIepUYrt1u5pxXPHJOKlpcCvfMiRhmaeyNiY1U2oEcoaKPEz/Sv9MbtVBZViJ8gSQ2u1qEsznxq6pZqyHSthN+YS2DEh99F6mxUMqVPGCpQ1taR6fwGPBUryBK2TjfWEUdkzm8xrSrj1BDPphBNVOcuV4y+GpopG28zOPpOoT+UWy3b6tHUcPXJLCen2eZ5O4ZkkLAfgJAHqi5KlfE+uDlyTc8XJs+HtRBCdnTJ/kgDufwy1xFz4iQi470Ep3Xsuyfv6S0SDgRPB5J4Cn6fH4TLc2izcARyjrsYj2/TLaq7zw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by TYPPR02MB8959.apcprd02.prod.outlook.com (2603:1096:405:382::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 13:58:03 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 13:58:03 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair@alistair23.me>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Subject: [PATCH 03/10] hw/block: m25p80: Fix dummy byte handling for Macronix
 flash
Date: Tue, 30 Jun 2026 21:57:22 +0800
Message-Id: <20260630135729.466264-4-bin.meng@processmission.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260630135729.466264-1-bin.meng@processmission.com>
References: <20260630135729.466264-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0161.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2cb::15) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|TYPPR02MB8959:EE_
X-MS-Office365-Filtering-Correlation-Id: fb597c56-f06e-405d-4550-08ded6af9a41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|34096008|23010399003|3023799007|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: ddtJql2dff036mivNRv2EuwMJRKZpZu70VbNW872VN6ptsKoVRfLlHvFer3/o0uVpi7KwPAet4dHgfX2u5oxeEYRBAsASlRbyRwk/Fo+l/gXiC57qoTqZzcq+hylUpHB3eNSFRGXxn9y2MMX0G9STrhXx8s2T92mCpRK0mLOSWWgquMwqND1zPo48SGEnYk9QNJD5wuu9l2Tjpwk58KOJzlWcRJ1N202iHlwFbyqphRw8vY8nKDbrxJW8D1koCRweJZeM2uWJDQWrK3mzqNH9QcNtT288onBi//Smf0pwCGtwHkddTAMALrshHtGRAeUs5DMplKRyiHpy2FBPkZN5rkg1az0OR0nWCKniwSTgZhPCu9iApHzzZcvWIgGf2zt8ExOwCykPLarfV7XmHTUAwcNdlbPZ9ZoSdjMlcGwMgbJbFE/aILGE/+25WQfCG4WOD8lODVF5BGur3Fuxo+eDDwKx27dzpgbRFO+599sEkjWxqaGg0yNRzV+gSAx5aTHCFBctQGUt06KuT5ikaxRBeY59JB+scd2RP6nplcP3xDO9/59FS23vDdm2OTo64A0RCSJYsA1t391gM7YupIVkhiJ1oyAq015QdGjjq4Bq//y2mAIUvr9iQPrJNSTNBXL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(34096008)(23010399003)(3023799007)(6133799003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EN5GFX/Rd3aqqay6QELEK7RNCnEZjkbUq/A8WkN+cA7aWLSjykyUMPCSfj5c?=
 =?us-ascii?Q?RhYduyTlARnJFJ04XYTVj/33hEIv/tL1Ms/DWC6LuJXO5GsPNb97YwSxdwv/?=
 =?us-ascii?Q?N0Ehe7GTt1bExDc4k31oyKUwbCRADCStRRRW0lr1PSpuqSa+B/swVZyrz+Nc?=
 =?us-ascii?Q?UR23QLN2rC7bMUJC8mkiPYopTRkOz2lXi/erWxIQMqoX8Z6R0ugcbs8JhOXe?=
 =?us-ascii?Q?ev9avZX4vKjV5g2aP+4x6ET4Z+RKVLHrB6yLy0v3e12cMCqBPDwVWM+2yvEW?=
 =?us-ascii?Q?u8YN0/F79hhyKkOYEZa3I+lpHvohH1IRzinFV9iChG/46//GzQRAQghaMuhG?=
 =?us-ascii?Q?cdf2pcrcwJ+RsvAwDcLj0SHN/X+/V9zRF4nEVIBavGmfh0LC3ePNzibkTpW6?=
 =?us-ascii?Q?AlPijx0d+DtHGhVOgP/nMnzdfXDZwkyJYPYeivSj+LA3brgxT4NMhUkQsdgn?=
 =?us-ascii?Q?ms00uMyS+ggJjEWS30h4VbEmsLUJksYwHf0YTEO3gpEwhIrU1kXW4IdvG0Pg?=
 =?us-ascii?Q?H6FLOqCPh2ia/bTvsjgQCkr+40JPXeke6vswu9/OjwDvzrY3ZerCSFL/iRnI?=
 =?us-ascii?Q?kQda4V6ig39mGMsvcwvve3/4A5dKBgWjdMhDcukdOm8YmvxAGFol+sBcP2BH?=
 =?us-ascii?Q?MvEz9YI2GQ8hOMOEuDXPaZHSQ40EsLMFV43gwPaJDZQea2UQ6t/KTnPppYo1?=
 =?us-ascii?Q?9QwX7DB2I7yPsJWpxx83MLNRhBrXjB5nioeL0gBtxCr7Zf2LT5qGO+Nb2817?=
 =?us-ascii?Q?oY3TROUyHrXusGvy8Sj40SEabingFvo4NifY7V9vTX2WLAfigjndbYejzbru?=
 =?us-ascii?Q?e8Mw+EFihZ6NkiuRtTV0DRrL4swuc4YKPYgxMJfgAOzZJsh9v5m9m7Xp2lEJ?=
 =?us-ascii?Q?xRHGmc5ruR6jlT18p6ayPyoukvPD+WjAgOXeJ4uRCLqw8A3AEqGmkPzMMhjl?=
 =?us-ascii?Q?JtZq7I7W47bubgfeBqw3tgNew1bK/4C4V0o2TnOngBF6oBRBEtbFFKNjPeuf?=
 =?us-ascii?Q?CbIYpdCQ0mUGTfFh0ZWP9kCV9Mb1hr/aHWuP9caWOIERJvc7onmOITo7bNeB?=
 =?us-ascii?Q?MSvL0dh8TGim6AMLoJNQCbaGDTaGD6y6d6nCI0T3uKZSc05sFrriEnlkLwAn?=
 =?us-ascii?Q?y54xpWS4BQnUuy1dNiKT+xUgWJqnNgfNtNSknwSqJPwp9tGK8DvD3Y0Ml2HU?=
 =?us-ascii?Q?0yyyX8DTWpQj5G0aD3zL5JJLmmzCuUa01zKu/1251aRhhQyD+9cw9saHf3ab?=
 =?us-ascii?Q?5tR51Dbl9X9RbOAVoJoMkFgJdnEWaZoADQjibbS0g5FNq/Fjzs+YfvkXto4B?=
 =?us-ascii?Q?3QJsClRZcyA6i2LaD6DlUt6Mqk/OmrLQNdOOd1karWPWZfsnVlBjo28f+M9v?=
 =?us-ascii?Q?kRTk2zIwOCj9n/bGl8qTZkU4WJR4hpkLYqcGOO93CIaIK0MUOJzsPl8btADF?=
 =?us-ascii?Q?FaY3Ub8LJJiM2gF+ANWllWSx1qKlhVinTXaY6cBlzlsLcfMH2R951cQQOVgu?=
 =?us-ascii?Q?qrgDhnOq+NjaJ5kWn6FcUWMwnh3w5pA+wgXdwryfLWcpuQSuPmPhhfms3fD8?=
 =?us-ascii?Q?DgfVpd58lNfGy9ckFQh24NfZsceP2+6InvcA4TS6280ileilqGwQpjmxnPDy?=
 =?us-ascii?Q?Ck2Ja+y3OgLNC5qo/ighP7Z7aoDowZXoI+Dk0Po3IlwrbegQJrX+lT2zGJ8V?=
 =?us-ascii?Q?vYVMyY2gnUSbMhzblfH8zA23moO1vzXrfY5HThDeODM2oJANsYGQzs/XQt0v?=
 =?us-ascii?Q?B9RFiwlD0UR0dEcdzeY8Q3V4cmhq+os=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb597c56-f06e-405d-4550-08ded6af9a41
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 13:58:03.0452 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ShH03Sm2iwxlE7t1+UBVU0iUqqtgAgMBGpA17mn9ODMMUECxr95Zh3KMiHOhQAYxcKqb6O4f2M76LQLN2Ieg525IHVXXPTyJYLzXOE3uNdc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR02MB8959
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

Macronix flashes expose DC[1:0] bits in the volatile configuration
register [1]. These bits select the number of dummy clock cycles
used by the fast-read command families.

Convert the Macronix dummy-cycle settings through per-command-family
tables and round up the non-byte-aligned cases that the byte-oriented
SSI model cannot represent exactly.

[1] https://www.macronix.com/Lists/Datasheet/Attachments/8657/MX66L51235F,%203V,%20512Mb,%20v1.1.pdf

Fixes: cf6f1efe0b57 ("m25p80: Fast read commands family changes")
Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/block/m25p80.c | 66 +++++++++++++++++++++++++++--------------------
 1 file changed, 38 insertions(+), 28 deletions(-)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index ba109cc055..745d13dff6 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -975,7 +975,6 @@ static uint8_t numonyx_extract_cfg_num_dummies(Flash *s)
 {
     uint8_t num_dummies;
     uint8_t mode;
-    assert(get_man(s) == MAN_NUMONYX);
 
     mode = numonyx_mode(s);
     num_dummies = extract32(s->volatile_cfg, 4, 4);
@@ -1029,6 +1028,41 @@ static uint8_t numonyx_extract_cfg_num_dummies(Flash *s)
     return num_dummies / 8;
 }
 
+static uint8_t macronix_extract_cfg_num_dummies(Flash *s, uint8_t bus_width)
+{
+    static const uint8_t dummy_cycles_fast[4] = { 8, 6, 8, 10 };
+    static const uint8_t dummy_cycles_dio[4] = { 4, 6, 8, 10 };
+    static const uint8_t dummy_cycles_qio[4] = { 6, 4, 8, 10 };
+    const uint8_t *dummy_cycles = dummy_cycles_fast;
+    uint8_t num_dummies;
+
+    assert(get_man(s) == MAN_MACRONIX);
+
+    switch (s->cmd_in_progress) {
+    case DIOR:
+    case DIOR4:
+        dummy_cycles = dummy_cycles_dio;
+        break;
+    case QIOR:
+    case QIOR4:
+        dummy_cycles = dummy_cycles_qio;
+        break;
+    default:
+        break;
+    }
+
+    num_dummies = dummy_cycles[extract32(s->volatile_cfg, 6, 2)];
+    num_dummies *= bus_width;
+
+    if (num_dummies % 8) {
+        qemu_log_mask(LOG_UNIMP,
+                      "M25P80: the number of dummy bits is not multiple of 8");
+        num_dummies = ROUND_UP(num_dummies, 8);
+    }
+
+    return num_dummies / 8;
+}
+
 static void decode_fast_read_cmd(Flash *s)
 {
     s->needed_bytes = get_addr_length(s);
@@ -1044,11 +1078,7 @@ static void decode_fast_read_cmd(Flash *s)
         s->needed_bytes += numonyx_extract_cfg_num_dummies(s);
         break;
     case MAN_MACRONIX:
-        if (extract32(s->volatile_cfg, 6, 2) == 1) {
-            s->needed_bytes += 6;
-        } else {
-            s->needed_bytes += 8;
-        }
+        s->needed_bytes += macronix_extract_cfg_num_dummies(s, 1);
         break;
     case MAN_SPANSION:
         s->needed_bytes += extract32(s->spansion_cr2v,
@@ -1096,17 +1126,7 @@ static void decode_dio_read_cmd(Flash *s)
         s->needed_bytes += numonyx_extract_cfg_num_dummies(s);
         break;
     case MAN_MACRONIX:
-        switch (extract32(s->volatile_cfg, 6, 2)) {
-        case 1:
-            s->needed_bytes += 6;
-            break;
-        case 2:
-            s->needed_bytes += 8;
-            break;
-        default:
-            s->needed_bytes += 4;
-            break;
-        }
+        s->needed_bytes += macronix_extract_cfg_num_dummies(s, 2);
         break;
     case MAN_ISSI:
         /*
@@ -1146,17 +1166,7 @@ static void decode_qio_read_cmd(Flash *s)
         s->needed_bytes += numonyx_extract_cfg_num_dummies(s);
         break;
     case MAN_MACRONIX:
-        switch (extract32(s->volatile_cfg, 6, 2)) {
-        case 1:
-            s->needed_bytes += 4;
-            break;
-        case 2:
-            s->needed_bytes += 8;
-            break;
-        default:
-            s->needed_bytes += 6;
-            break;
-        }
+        s->needed_bytes += macronix_extract_cfg_num_dummies(s, 4);
         break;
     case MAN_ISSI:
         /*
-- 
2.34.1


