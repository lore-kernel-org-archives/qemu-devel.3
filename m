Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6327EC531F8
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 15:21:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmvDj-0004v6-Dg; Thu, 23 Jul 2026 11:20:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wmvDX-0004Ya-2Y; Thu, 23 Jul 2026 11:20:14 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wmvDT-00081v-GP; Thu, 23 Jul 2026 11:20:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cP5Pe8FOLGv5nsXV9AEhxcHyBft2bAWcIGLpCU9gEwv8xcFAMOWYYoie0L4k4JONX5iYqJi3qTt/qkO+LJWQiimphHy+uEhYLGjyMh4h/OvZr6mr53e6bIHzBqHz8/6iTh1vUNWDaTQyErYiitcKvR7DPZf+bxImhmjgHU8Jymbpxr5a80KowqwjG/gN8g9osc8oYuT0SUgnzJrNzh7CuH8Ft7FTbmc1JrM/YjWWZyeRGcXTaRfMlwwlMT15H4D6jzOuKm++7PfEKNpJ5cNtSZQ/+TWqOunrAr09e8WcBUGGWDJoBPtyTL3tRbxBttMtQ22Zm9t2EeTYswP4svkenA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ojEfVgCrrlKpGIGftQBoVEj0rfBzqM2Rri0p8sf7to=;
 b=FRSzpXLTGIwpUDLUaVp3j71uJfOjUPktjr+RpC+sypCcQd/OMfjfJJbr3rK5zOLhcRyMN481H4z6Xb3btLg2oxNSMIG9Yaw/BwBF5ImvEJejiVfk13kGUWJLad49wOhWcsV/peRLJjg18gsdyjxH8mLUup4s5ppQSAoQiCXdwxEeNrbyDSqxFRbx4ZdItVajrGSuKKV9MKzZpBzF0/+qv1UX84vz0ywzyUD21ldC4DB1DCSFTX9RF2WGT5xf68MgSnWED2vxj0bocU3gXCNpyPR93lSMf3MoeVsff7qYW8frn31zJ4ytI2NKnrQ2kdXnRAn9tKhcsXAAqt3XKn0SCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ojEfVgCrrlKpGIGftQBoVEj0rfBzqM2Rri0p8sf7to=;
 b=FbXcW8g0rA9HuYBCAksobSHe2ZC4EXJ9R/62pJBsx/FBsTz26RXJ6J7aTUX2cW4K7xtsqyKPn3JFsLRP7vu3zgeWk9grs7hCR5PFGI/jJm1TEcrHYaET1veu4Pj5kl1B6AEE+r47gqUN2/j5RXSEdF57c2QQOgnaRgYW1Tz2LQ3np4dnce9hDXRDhPSl8KNoWjXA4SiIMb2LK+4HRtV1VVi7v9jEa2q7w2tFUoFtr2ybUatB8B0Tpnj5IX5sCivBoSFDI4xl4Hd6rwKasIj1KMy2iXuzJj0frLTH8/ff7K87idWEhQUjv+ZBDQDfpzlnD1rQepNXgHIRwjWXLhoUbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by KL1PR02MB6215.apcprd02.prod.outlook.com (2603:1096:820:9f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 15:19:31 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 15:19:31 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH 14/26] hw/sd: cadence: Advertise 64-bit system bus support
Date: Thu, 23 Jul 2026 23:18:41 +0800
Message-Id: <20260723151853.2143177-15-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: 99e751d8-0fc0-401f-b665-08dee8cdcba3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34096008|23010399003|1800799024|376014|366016|56012099006|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: ZkvLx44hDCHTH1ygRdCoNnSTpNOoEJKBATgSpurzx/UUw/kUDFofPnnWfGKxG2zXOROKpm4kjnpSUUEyJnPUpdelg/k/HSuJnDA2Ipj3v/oUxSa59OuPgZXJDYvcdUOkBYoXIz6uqdXtnF2OxmXXQeAiuzxUBIVV4VKMFhFN3jCBrv7x4xQD7u3hE2qogTr6Hc1cxdFcDn/VmhLyFLWMg2tZ705sbwMypHe4D69g2QyBXxykWK4Y0VbX3RWCrdzXT5jDfftlteY/beqZfE2ZO6lQtKFtwGOvr/OFTXdiEGCM/KuV+4CJAD0kaC5UI7MnGxazuOG9Mfzj+Kbux38jw6kP6W1bVYlpg6aBSJQrSQyZvxPnHiPDenrAIW9cn3/NZ+DEly7YwfpLnok+8Eg0NdMU0jQmmt1+qL99l86v//KgJ+SV59oyjRb3ZemJOoN7WrfSGhuBNvnq2S+yyEaOwOynxgLHz7BdT/snWvdzozBr+39UIDRMVixnsAWm05V62+0/vTtqOkHFcL25wmLBwAjtktL9qdgLy9Tr+JiCMhNZXf7YeoRJJ+C2jpjV+bRG0RGJWy1NKfisjUXduBT3GwEGaRbHGI219BVk8fkeEvW81XTXFnNspLXm7PkPMVEPmonv2/0PPR/IFlfTGpRyOqIyAv7M1PDMQY7mdt74+j4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(34096008)(23010399003)(1800799024)(376014)(366016)(56012099006)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1WOhVy+CbIJM1JOcAB2Z7+zF+xEwt41US1Dem8m888PQdjtrr5s4xSC8GSCB?=
 =?us-ascii?Q?A1lbMQ76vCoJulz7zbGBlJ58vMZFpuJ9vPYGygU+vgpuEi3AJyfdaW33yC3+?=
 =?us-ascii?Q?u3QLt4zMOcX5+uNSz+gsQLrlWOHTsNmipZPD2rml9tdeuJxOdx6bEl7LCB3S?=
 =?us-ascii?Q?PGW+Tq3vRNa6aUUit+1aKoC9ePZIAFoeBiebTB2t+MRHIDo2v9TnfYPWyytv?=
 =?us-ascii?Q?cyyaubcoPu2FCBaKP12aNLBwZs2oeaz2BxJxzmhMqBqu5KB+pQ8JflbZ49rW?=
 =?us-ascii?Q?pIWCzVItwXxPAzaNrGhwHJqt+jtM/sicDQhrzMglH1jOfQxLy0wJa8NhjY7N?=
 =?us-ascii?Q?SvyksA1zwFPjYehsO8ly2hrr/+L1xyTAesGtPxZ88muRM+AmTcFR18sGlu6g?=
 =?us-ascii?Q?k2vISiNKC73m5pMEUJIzWxwIZV+xb/GRYmYSKuvs61224/Lx2FTmeCII8Hcw?=
 =?us-ascii?Q?aeG+ZtFZuB8fo8B9lJWH5g0Z/A9wGfyqVe5ynittYBFdgFJYsKDtUwytXZTM?=
 =?us-ascii?Q?rwID7l9wHel6uYro30iBeJDIWOsfIFGVQc+ZTVwGfAzCnwbFeY12SyqLYk7i?=
 =?us-ascii?Q?ONs1DkU1wDRfCOSvm2H9wfNuP4x2As6WdjlB++oVirVpJm2RGmIb0ZoqKU0a?=
 =?us-ascii?Q?Sdz/E7Txq17/sTheLe6c3hJ5vDItm0FASazIOke2atrKY7JgVvX8Z98t72wU?=
 =?us-ascii?Q?zNFa4u1hebJcNSgJ4tSXUb88tEZ22tGTdKcR1wq8Z9AI940KmT3cKYEcHOMo?=
 =?us-ascii?Q?s8J9jXC43Swdw8FGpk+411edVuFSOBkoegIUMjIGxbT7DbuhYVhGo67mxWGc?=
 =?us-ascii?Q?ZcubqfFAQUNhD8Pr4oPykSyaNv7teR8cNq4EpRqSUGomEsaUrT1RkqjTfUFZ?=
 =?us-ascii?Q?9wOF17zVYnQ2jECfGuPHF4TMOlKlZjjVBO6H4w+niqhiGkLrC4HYaOaRawvf?=
 =?us-ascii?Q?FRFG+0tX6jI3hdpo4Y+qbDIEl4qDJzgxVIvM89sogjnspx68ucNYutAkFirJ?=
 =?us-ascii?Q?yDnfAYenPUQU3aqSCoZUV9WQ/dlpH+rF2HozL9ZttNsyzLY+1ex/kbB/abva?=
 =?us-ascii?Q?vp8bMOmbnAKu2giaPFWd6LzMIRXM2CJFw8N30ls/DnxPPmKP1hlUig8NlFhU?=
 =?us-ascii?Q?H88qKTs0fIcPcOyYCO0QIig0pvgQt4Zf3GE51aF00BqcBvzPbjCZr0FTZnA3?=
 =?us-ascii?Q?Wtmsff7ORwWt05ohcCuesAMsCmjH/NbBuPvGbCtkhwYR6d1xYdvWaV/WStF1?=
 =?us-ascii?Q?oImxDwugn8N3hUYhwNbGNXkj4ArcUCI63h1OBNHzjVzLo/AuALhC7ujslIrx?=
 =?us-ascii?Q?gN/UsiQ4aaYEauT35oOheBnI3bHlxQ1K53ggQ/N4+hu/sdkU3EUwC1FX3L/z?=
 =?us-ascii?Q?SaNYegmVsBE57lhzjDdnN4YYqaQdgRkyaRzg3csZ6VRJGsTtRkVE27GGqRzO?=
 =?us-ascii?Q?yCiexjmSBMMDZI/MS8VUMkxVO1m4EEVy8zw/1rxTmFg6pSKCA+xazqq9TRUN?=
 =?us-ascii?Q?yXCPT0pIHxez7nJgPdi64DFhhDfFtcaYVuafhqPD5/1Ls3xd1nDjjkcTEY93?=
 =?us-ascii?Q?63FmyrV59ZWIH1iV9S2jr91Lla7txA32KuVko3HGLJpNn3CsV6kz7lNZPZln?=
 =?us-ascii?Q?Wfr9VEudOi43uVIIkcEhsLnmSPVgYg9l9FLMIqCiBhdtwL5FiyVHSjxNEowY?=
 =?us-ascii?Q?q0b9kAPOQoNc3WfE8nJ2EbVXJfAK0/nYponGtaRXxCmpYiqbIxvfVvaYUalm?=
 =?us-ascii?Q?1EZjkNZkRRhH9parfrgef6sF+GqF8bE=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99e751d8-0fc0-401f-b665-08dee8cdcba3
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 15:19:31.7493 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3dNvoXZUJTLvwuxHNM1+885+phVK/J+weK+omRsSCJ05yco8wcIajjmtUnSp4KKlI0yi48zRwEkDthSxTt9eSDXqWQG16JahBL0CR0aWthU=
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

PolarFire SoC software selects 64-bit ADMA descriptors for the Cadence
SDHCI controller. Advertise 64-bit system bus support so the existing
generic descriptor engine can execute those transfers.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/sd/cadence_sdhci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/sd/cadence_sdhci.c b/hw/sd/cadence_sdhci.c
index 8476baf67f..39c6e5d101 100644
--- a/hw/sd/cadence_sdhci.c
+++ b/hw/sd/cadence_sdhci.c
@@ -54,6 +54,9 @@ static void cadence_sdhci_instance_init(Object *obj)
 
     object_initialize_child(OBJECT(s), "generic-sdhci",
                             &s->sdhci, TYPE_SYSBUS_SDHCI);
+    object_property_set_uint(OBJECT(&s->sdhci), "capareg",
+                             SDHC_CAPAB_REG_DEFAULT |
+                             R_SDHC_CAPAB_BUS64BIT_MASK, &error_abort);
 }
 
 static void cadence_sdhci_reset(DeviceState *dev)
-- 
2.34.1


