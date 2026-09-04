Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C33C2C79F89
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 15:59:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2WKF-000693-8B; Fri, 04 Sep 2026 11:59:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WKA-00063i-IT; Fri, 04 Sep 2026 11:59:30 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WK7-0004ae-UI; Fri, 04 Sep 2026 11:59:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zr9K4o2gN5kFRlEViUs42MZ0RDFtkm20B8Py43x3bGYoYtdJXWWsIxuDxvJxX+v0Atf8fRvg4CnibVVwgIR3K39lUlKhHl50vLRkpkAHFUv/rOmjovBHO5qCimipWO2Z0VlCBGBt1SktjEWtlTgEnLizSjKIWWO4e1oyFUw/JM+AinsCANytzfQJR8EkvO4uBMwLowvWUUE2kFe6QP6K01iT8Hx1c6dIR3AhxYwO7Fh2LbHpjKepdZJAkdCgHL66aBP7y1kd3oq/fIV0vBXnZIL0EBmPhsm0eQZm3TH30r08MpSmO3OwME5CHE3fQ3t7rH1r0KjSWce58N4mXzckLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eexUB50wZfJV8d6VyQm881m262EQI81TWPLw9DOR74Y=;
 b=e9MrpLIxahhtbSafdZcLtki+bvOCYpXQahNIw1LS44fAoMQHBVcV/ZH1h4KQtPym+q88iZwLCimMwB2av5s+w6VXSTeJI8SwCsQlBySJW6BXBB6ZFUAdPAF/sxtBe86xUBmEfXkBAlVTp8XXB2ppwKxSDKqzDeax2gMF05Cdeh4OhhGgj5EOh4O9Rm+L1moMUobdKaGtLMlof1a5WZ9F9cqLk+OAfuyWcY7DEFYmOtUY3XENqXNcz4KUZYIISDlo89KPcarJFnX3e/2nndZBMxNmoYr/vsqIsZFjT0DhUgoYcBCGlINH5qhM+tGIzM0j9evYW6m9TfEp/fZ6YwcnYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eexUB50wZfJV8d6VyQm881m262EQI81TWPLw9DOR74Y=;
 b=vJq2eusGPLu7o+4JqGs4xYcszCzPaZ+7r6Mv9b17bvZf4jF4Bs3IJr2hYIiQE/LW4EXcFBe8NQn99OhXy/igv8dUMsGGdUk84E95ezjCEBtmADYW2ZsA1yEQBC7F7iiZ2fH/2Iw+M/ivYZ23BQWw5voEYacapvXpdFgTgSM1zgArIaSHWlcdR/zHC9ix4blrf+TlGhTqmqV7s+TZsqzRnwZDD22B9vqMyOIc4jr3Mqz10iHpDAeeh+E3DNMKOgK6GcK1R3/Wrb/mSeq/UF/u5xasU5EeuACUeKDbpuiNrugCguZ7KWgHZbZ50LmCxTomUvaDRbnfJPirtsAkjKldqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by TYSPR02MB7490.apcprd02.prod.outlook.com (2603:1096:405:37::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 15:59:09 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0382.007; Fri, 4 Sep 2026
 15:59:09 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Conor Dooley <conor@kernel.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org
Subject: [PATCH v2 19/24] hw/riscv: pfsoc: Fix Icicle Kit hart count at five
Date: Fri,  4 Sep 2026 23:57:38 +0800
Message-ID: <20260904155758.3833179-20-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904155758.3833179-1-bin.meng@processmission.com>
References: <20260904155758.3833179-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0020.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::13) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|TYSPR02MB7490:EE_
X-MS-Office365-Filtering-Correlation-Id: 60371598-82e9-4dd8-2b75-08df0a9d745a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|1800799024|366016|6133799003|10067099003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: rHwk0hoevtBb0bkK/21wTKEli0IP0g/mb3ZCk9smY8i6ddmxsY8ixEupb1oP8xwmFnZfQQ7FiH7FP51fmIM55fPouZgMNkJD6bM7/tMdVprwFVDcZow6I63M9BRA/F/E9uwLu0iwB9dFFN6eNyj6bsNyp95SArmBQ6jtxrEDVv7+rt7VpuUNzi9BjNkRELlGtNduCLAOofk8mibuMvCEFT4Mb9bWJgWtE5F0qLbhfZ17s03nIXU3Y/w1H/+CsFdmLwUGHc6bQrq4yDMWUDRy/auKXZocFEghsdB8/+8lL62pI+wndY1r8qK/+qbk6NlL4I+h/3hbJqnMpJy+BDLDLD9K4JcpGjk/ZEG17VU9zWjm9AqalD0/KAG6+MoLpyXVjsYCgfDCX8rEaG0FVoSHuonsGaDBooxUnVvOgh74JdcReVaphFuvIjkVeacxkkAlM57C2f9yqLxZjXXKxs2+afTImorXPJzicv4HZOAoslp/NDjJVEROE1R4dgzuCuyUCQxvKHlpLPKOMdynLeQn7HD/LnTv7bKloMICZYYk8zenIfCwea+r5lQs2R+YCfE4Qv5CMU201z7PhdSw6ORktOGR/MxcaNLXrK5c1Ps1L6eTXRvcEGJza+RHap0KoE1qaRgpn4M1k7snX1F5cmHlCvs++HTHhizZigBAjbKWfuM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(6133799003)(10067099003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pcP1EtYZAa/Eh2CKD0LS1COC6moKYxjzcGOxiTlG1CzCCn+yd/5sMiRYi2xf?=
 =?us-ascii?Q?ybuonrH4F6rC2xIQvBgekgTdz1MafHgs2FOGp2AjSRGVQpq8YjXrMPNbiYj2?=
 =?us-ascii?Q?1wCDU7dHYtrqmgsxjHKkMCaQjE6gNiTpBKZC0ACt1IocgWD50WEKn1zGZOoS?=
 =?us-ascii?Q?cOYfoOKxzQaQZhYIV78JjDb/2oAGpP92MTe0AubTSi/4Yk7k8N96QEW9/dkN?=
 =?us-ascii?Q?kJJFKWb3ueVuLDXJrYeBZvpw29lzBfWi1nQ3sWmPKfq8YHECo05RJewUsrLs?=
 =?us-ascii?Q?3ec0mJVq0uVh5xkj31okgwpeJycKP+7sJd5aAQy19r1ch/cctvm6+nGUAdNP?=
 =?us-ascii?Q?F/ha05ufb4CdO9rkG1WgHGIQeFr6oioB+FnjCc9Q2E5U0XLW4WIvQKHyDM1O?=
 =?us-ascii?Q?Uf+6Ej0D35K3RjOTcYZLy5IVmFQC4s5NGAE1bWhxSeO2IQcaEnAO8NufVLMS?=
 =?us-ascii?Q?FFSBZ9sgxkC+yT/2G0T/Jpy8XtI7x4HKXibn5V7i0zIc42CfOLYOBDAAwIw+?=
 =?us-ascii?Q?lZx74spWpm/TCNw/HgM9guTI/fdrCIdJsCuv4vLq1DMNVPxWTkQK20Xw9oW1?=
 =?us-ascii?Q?vA0qfZ4aX3sTnTiSWX7YupwBbsYTFC9LscLAW7mc1PwAM8E2CL/8jkHTsobg?=
 =?us-ascii?Q?A4FQlJBy8brE/za/203ujdOExk6yrHKVCPW2T4alyIHPsiTYWFUF87di1isP?=
 =?us-ascii?Q?M3TXVr4G35f50c7PSdqI2O6/eilB6z1Z/a/yzugeoYQxaeNCswGKfzH9Ggmv?=
 =?us-ascii?Q?VElTd7ltydcbNlyos+NvhaFfzDATK8aZ3T/gkX4OyNXv7/uwFWVa01XAo+8z?=
 =?us-ascii?Q?PwOJSVhDyuC3h0GHOSHvWVxHRTIptF9MWJ5uYt/ovu6CMcmw4TmIhqgVHqD2?=
 =?us-ascii?Q?a0VlAScu8sQ+HpRIu4CwEJtwxASBPOZ5hmESoXHsy0ig1DvzNF9CbpqHTbpI?=
 =?us-ascii?Q?Q8rWo3iSioVQrLXroqTInmN87sqo/4oQB6SZU/52gBrtHcjSf3orNHcwXQqL?=
 =?us-ascii?Q?mu6qySXLLK1oNpkOKIzk7YgBLRVB/qY0EmdClPjGQaWe+HqXzGJyOJIe4ga+?=
 =?us-ascii?Q?DsbU92FvMlg3F57Xnd/fFV/QTN3y1AA5AIjgVBPDGlinN2rQVHz69zt6lMS+?=
 =?us-ascii?Q?42+AjjBvDhbPshzlmPvQD1OO9HKHpgTg+LLSLu4phTQGqGynsnE9AgXCFGUZ?=
 =?us-ascii?Q?GrWPtISHszeyHO50hhbdNgGtt2Je11JtlOb53NjseL9fImRrGL+DqWF0GDf3?=
 =?us-ascii?Q?8qmCv+O0Qjo0lWdZ//nG88/JEHiwaLinUYN+JXwIPx26gmQm0LNjDUQ3oC5P?=
 =?us-ascii?Q?E+rpM8Uzk80Zmt7IhUfbJdj2Bf7UFKMXuBjuZEDvQ2KHZMXyOR0GvEx9STVm?=
 =?us-ascii?Q?GNH7hR9Bv9xwhZG5Srk38miAOM9W9xkaG2XvxeYKlxsc4mozhT/mMPRlaNdX?=
 =?us-ascii?Q?IitrIVWpIb8TYHZMUrzsqanJ2P/ZqGAPt1C/rNnXXixCXDGKpZo2HXjy/u3S?=
 =?us-ascii?Q?Kypcp1PfJVpbobn6t7vbdu/vaHbKBSBZlKMRRXEDUc2ffhLAb4oTlcK5YUfb?=
 =?us-ascii?Q?R+9xg+Rn9CX+evnfJJf6RAWDfJPyvL91u1jOiXhC9esmLPfPnT6Tq0wi5n+4?=
 =?us-ascii?Q?T81K9XDc4E0bNf59qT4uCclkoKqwNFjW7ftIXUOq9ks+j9QrBkm8aM47NWFz?=
 =?us-ascii?Q?BqwlPII9o5RxINWMNlbUBR/6AFi071Y8ZGksxinuS5yTpS7Wnu4XBRzuoKbb?=
 =?us-ascii?Q?NyZUKgjlu3FRMV+0lWWZcs82nRUkopg=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60371598-82e9-4dd8-2b75-08df0a9d745a
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 15:59:08.9484 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZPnUx7QAekfCNhU9KA5t1+wBtrRcTJYgnAuDXtIY4P9NKA9MJtzpuEbzTmFlSUAKH9JwW6JdbfTnc004STMfBi5CU/M6xIBk6qqz+jmvg4A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR02MB7490
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

The Icicle Kit always contains one E51 management hart and four U54
application harts. The model currently accepts two to five harts and
defaults to two, allowing configurations that cannot match the board.

Set the minimum and default CPU counts to the five-hart maximum.
Update the documentation to state that other hart counts are rejected.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
---

(no changes since v1)

 docs/system/riscv/microchip-icicle-kit.rst | 1 +
 hw/riscv/microchip_pfsoc.c                 | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/docs/system/riscv/microchip-icicle-kit.rst b/docs/system/riscv/microchip-icicle-kit.rst
index 3db2b3c7e3..38352cc62b 100644
--- a/docs/system/riscv/microchip-icicle-kit.rst
+++ b/docs/system/riscv/microchip-icicle-kit.rst
@@ -27,6 +27,7 @@ The ``microchip-icicle-kit`` machine supports the following devices:
 * 1 SDHC storage controller
 
 The machine has a fixed 2 GiB of RAM. Other memory sizes are rejected.
+The machine always exposes all five harts. Other CPU counts are rejected.
 
 Boot options
 ------------
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 11403a6087..1238811ed8 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -768,8 +768,8 @@ static void microchip_icicle_kit_machine_class_init(ObjectClass *oc,
     mc->init = microchip_icicle_kit_machine_init;
     mc->max_cpus = MICROCHIP_PFSOC_MANAGEMENT_CPU_COUNT +
                    MICROCHIP_PFSOC_COMPUTE_CPU_COUNT;
-    mc->min_cpus = MICROCHIP_PFSOC_MANAGEMENT_CPU_COUNT + 1;
-    mc->default_cpus = mc->min_cpus;
+    mc->min_cpus = mc->max_cpus;
+    mc->default_cpus = mc->max_cpus;
     mc->default_ram_id = "microchip.icicle.kit.ram";
     mc->auto_create_sdcard = true;
 
-- 
2.53.0


