Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88551CD98D9
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 12:17:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY0nR-0001Tb-5d; Fri, 12 Jun 2026 08:15:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wXvxD-0002VC-TQ; Fri, 12 Jun 2026 03:05:25 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wXvx8-0005yW-VE; Fri, 12 Jun 2026 03:05:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xwKrDIsJyNWL1LCCALkQQc+wvy5MkPOXLTTkjOdk5IQS2IMmiS9YSpRDtaJ9nny8PNIuDMLcZ5bR8o6F5uu/qMbHqP57mh5JBE4/tDSNfJvatNixlhXmbkyREgix669Y8/ShvFiHcycKcvdEmIkFT34KQNgubZ6seet3fH5trqOTm8dmAR5wo4UU70NWurzTVkQDJbqA5fxPI/hw7pfUf4Dpoce84B7FAtcXsSMoG6nabtNqLqbXTZkdzIcuJLUl+HPoW3Z2EViP/3/99HOu5x9Ebp00T01wBqCJQFL2M2JZLy+0ndyw2TNy+cHyiB0xe6jrrlhUqr2W9VbkHdHFUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kOPwvlW4x2dfC8mWahWncUMlIYyUWIfZwJKNZKQzCig=;
 b=OEoUuFoksc8hYwJ7+4DFL0W5YPBrmK5dSUPSFbGX26gMerA0gWMBNXSmBWY9G2xla9iGauxeY4oa4ZjghqELMm1GkMNhEQKmPyTXIW6AY9+2DQhaK9MeSH/cDjwJINMkjfCSqjH0RolpVsn7uo/wlFAm2a2vtH0bLOM3/zoe6xpECCOftD5aCw3uj4Hvaio7REsRUX3c6cZJnlHlnbzYCCdktYjeBalQefCqu/e0oRCXlq7bjLerWEYIbH4pBEcAwFBPIBv8SJMKCTi8PVKLnBKyFmstqb9Hsnql1QXdHfAmWMABfx4yfry5BBc7pYs1M+ri5GheNmmdaFWx75gWtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOPwvlW4x2dfC8mWahWncUMlIYyUWIfZwJKNZKQzCig=;
 b=YZNFJKhmx3M/VUPQRhok/MOMfTJ6h6FTSq813p62oL6xtxFcmOqRZwGaaOpCR6VZ+DkRZ1jqcERwA7SASrBbBTUPHwhNUHCnOj7zeP72+rHezizpffrjufly13BFWPsY7MrZKmJbsUAqA6Px2qHpPnNgH2TP8bmnQKuLzXifw2CCxwVxvH3ERgWR3hqsiibDywuf3SpNP2FWUb0bUIyFZwKjC+p850Tonud7g5lNcC+Cq9KTzRKdbKzy6afZAqT++979524J6Z77C0yEkSvUwpN+ipEf54t8LE+op8p6ZcZ0GAsbILeTx1KyJJq9C2u58cLWP5KyxzAeU0JgADhGUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by SEYPR02MB6457.apcprd02.prod.outlook.com (2603:1096:101:13b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 07:05:05 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0092.017; Fri, 12 Jun 2026
 07:05:05 +0000
From: Chao Liu <chao.liu@processmission.com>
To: Alistair Francis <alistair.francis@wdc.com>
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Chao Liu <chao.liu@zevorn.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Peng Jiang <3160104094@zju.edu.cn>
Subject: [PATCH v8 1/5] target/riscv: add thead-c908 cpu support
Date: Fri, 12 Jun 2026 15:04:04 +0800
Message-ID: <a3e232ace12afd93adb60aed198cac3284daa56c.1781246408.git.chao.liu@processmission.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1781246408.git.chao.liu@processmission.com>
References: <cover.1781246408.git.chao.liu@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR07CA0046.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::24) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|SEYPR02MB6457:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b65daac-e9b0-4186-7c68-08dec850ee2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|34096008|366016|7416014|586017|376014|3023799007|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: cDLNHFEXkYwA95eQ0+PWTCcqGOpIuZYk30azCO8UPLxk92rtt8glvA92sWkZbSK660jKCZF3QLEKAU6sLDuO5Os6P5pafwqZ++9d/MsputegB/Qtj6VXYoUqmdlcmFdY6lGuTZKPuDtDPg3hkbIXZfdjN0G1zuvVlkTfJHBo1XCWHdDqUyL+y79vPup35mEA154EvX4orWxQjxcaHuFlsIyU/5cHOpd9CY0wYs86e6a68qcWRMsy88BfLz1N5IFOsUV7Rncto8VwjoXvW5hF7javT71z6ZUeAASaTQt4c3Fm/E2XMCwr+JS6TFXTG4c/WnhPIEt6ZKcQs6ZAd0QKJlXoffUjs3DrL52BUQlADaQPzGtwOkgjGBItY4rN564fHgmJ+WzWx+PK4JQgibAd3NOJ/BMExV3dWKdNh/KADEMK79JQHIFb2jsZDaNnBCLE0KIb3APr39lbSlxoV8KYdk8xSBbyRlZoHud5pwcaQd18p1zLu4WutHfh2FMDb8QINHerjtivRLesGMHIH/BnY+9xZmsMlN8yCedXBe+hHaC2P5n2yTfGxxdnDHBzJyPd8QI0a5JTZ6ejNkAurMDFV+M5426OI+VTGbp2im9NptfOV9OJCssBHcDW6UeauOVcVFyYYOFInpbYiDzEmfe2mubDeCGhOIY+dDmAb8/9GPppynuZtgSRynDShIt3Rm2p
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(34096008)(366016)(7416014)(586017)(376014)(3023799007)(56012099006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ztmtw+sNK7TiG/zN3nO/KFZ8l1/6gmyuhpMYrwdccDD6YM/yBsxSUm9nB5Bx?=
 =?us-ascii?Q?Gfj9nZm4/uW1sfXfyeM/xGAAySsxKbcwNeTM1c5sZIuTFAC2cqZBUhC6Cncn?=
 =?us-ascii?Q?n0Y1wT7Y5tWrI2O7MjyVafa2srPyGBBFlmi69vtzy2VpAQ/bHrH0T0TmPbzn?=
 =?us-ascii?Q?g4ANK687vLObVvYGPYnpugvZ6to9QbaTTJ6nNFQ4t7/zzZ5SyhWNPzStmuKf?=
 =?us-ascii?Q?O0MvUjt2I5qrt3KugziM9Fo9nL3X/r08XtxykVOYafdauEsy3VlRPIiCSmFA?=
 =?us-ascii?Q?Uet/fbCCvrnjIbRaRokgV6CuSzMVhkLvlLmmEic7GT2kmA4mNb1kSt2gmXiK?=
 =?us-ascii?Q?M3WbMDBmpv6jiPt82fJ9dFw9JMeqWr/F52Drp+FcEXDH6uR0A5LuZEuJyTmu?=
 =?us-ascii?Q?kCY58VhY1Rkc/tezylllssKOLhV/FdXC7RAIPXt1a4B9vLWkBIUTzDjef055?=
 =?us-ascii?Q?dgVoh3hmM0vk1YxsMjuJoTtjR5WM7D2TtbmtADAZghkjg97KEd8GCCsJF3Ba?=
 =?us-ascii?Q?mwfUiK+w/AnmsAgw2RebphtLdUgOp7nopP6a2v6/vgIBtEKDAehOKfu7zWBT?=
 =?us-ascii?Q?WnnFoUvoimdRKtIH5prUJe28U603MEDhLPTX4BW6Q7KgeyElDAycdKd7VVxE?=
 =?us-ascii?Q?fcJVAchQyyCpfczYl3w/5ybGjRbQUntDxG3FJ65Okz4ePQAt1Ldo5E9Ae+FW?=
 =?us-ascii?Q?as0RODkL9ESvc6Om8tpZU9XgKrv6PK6dQ9CueArFEUcKjtohsU+A3wkYhoFy?=
 =?us-ascii?Q?01iVKSNIpkB3/TcQ1uIlHdvVRomG/gm0JTlDmUpwwpUULwvD2WxkACXb7j0b?=
 =?us-ascii?Q?+ukTWoWvtdEhxvIo51K1POHmdzOrgaK96O1Kug4SYwqrj3MiKtjLtYCKBdwx?=
 =?us-ascii?Q?r+uUACr5pJOrjgCMnHWVqySYlS2KNOkFUtINfTBnO6fq0FqyxZUCisiYb0xN?=
 =?us-ascii?Q?P1Xx8/KQut2aB+pzeD6NS1wXaia9PtwFdXY1u7uS4bJ7vhrZ6lCx4oj9+Jo+?=
 =?us-ascii?Q?rC1gdhyLC7TiJBT1ZvdO4XJ9Vil3ytBIFfdYjDbHxN0dVq+RWQtzaHYvIBT/?=
 =?us-ascii?Q?PVGqpWiRk+Shh98Ue59w4JhdeXJnaFgfGvc7aMrqveuYvituGLfreKwisLk4?=
 =?us-ascii?Q?PYirXpJ0qDtKGipYcL6T+ogY7AUBDXLjXsgnGg2YOO/WvoB+CYWjV2iqrCHV?=
 =?us-ascii?Q?g8XQaxGrUL6VQDCjlrW1/9xa3zZ+/ihMs5KEhcn0pfhNQaSKseR22g5qXL/+?=
 =?us-ascii?Q?TNrFpZK1DEuunlqBTW3MuZ4QyLQf5TDQGhcjYM72DrSwD8m3EGJprXSds5Bf?=
 =?us-ascii?Q?lnGZ3Faicg9Ilk1PEdp4WPPAzt9UCRfe3TYFKZOGeCLuXAxvNt0fY0XFAH5S?=
 =?us-ascii?Q?SHyOS8yP2l1Ix/i0A5p884EXI84xlf0IB5Nc73OfW+xK4IoFMvF1wZxuwcLX?=
 =?us-ascii?Q?Swg94bCQASv3jO0z3utLjyUo717fY+jQgX3VEFmhxBU0XgcIxopX2xu5xTuu?=
 =?us-ascii?Q?WVbD2I8qTx6lqs6xY+PRRd7HFrMuIDfq8fgMATwMb6+CDmhvJ/Xu91kfbNdM?=
 =?us-ascii?Q?MS939iG0Up+1iMytEHO0QJxQWrlpHlW5tpbjZHkqPb/lX8TCQH90lfBaF9rK?=
 =?us-ascii?Q?CMuRhWJm5jOStai/5WKH8rdqpvst4P9dn60/z3EGtJpx2co77IwQkv+2udZ2?=
 =?us-ascii?Q?yoOVxhD0HypMsAVTpvhi3+lDiab/WwWufwLPD4MwmjQi2JGUIwcBFxbjp8EP?=
 =?us-ascii?Q?3hYTO3OJEABdGo9Z3LMrfo1SnVggli4=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b65daac-e9b0-4186-7c68-08dec850ee2e
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 07:05:05.4948 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8rl0XT3/HFJNkfjB/lar+Gx06KOyIFhDW9XxeEy4WNGVo9lqUnNANMT6NrMz4+dKRGVhISMr4qbYfedAET05JbBnTZuv1+GHGOLaV0QKKZ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB6457
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=chao.liu@processmission.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 12 Jun 2026 08:15:35 -0400
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

From: Chao Liu <chao.liu@zevorn.cn>

The C908 processor is based on the RV64GCB[V] instruction
set, compatible to RVA22 Profile and implements the XIE
(XuanTie Instruction Extension) technology.

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
Suggested-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Tested-by: Peng Jiang <3160104094@zju.edu.cn>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu-qom.h |   2 +
 target/riscv/cpu.c     |  51 ++++++
 target/riscv/th_csr.c  | 376 ++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 428 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index 30dcdcfaae..1a28f1369c 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -52,6 +52,8 @@
 #define TYPE_RISCV_CPU_SIFIVE_U34       RISCV_CPU_TYPE_NAME("sifive-u34")
 #define TYPE_RISCV_CPU_SIFIVE_U54       RISCV_CPU_TYPE_NAME("sifive-u54")
 #define TYPE_RISCV_CPU_THEAD_C906       RISCV_CPU_TYPE_NAME("thead-c906")
+#define TYPE_RISCV_CPU_THEAD_C908       RISCV_CPU_TYPE_NAME("thead-c908")
+#define TYPE_RISCV_CPU_THEAD_C908V      RISCV_CPU_TYPE_NAME("thead-c908v")
 #define TYPE_RISCV_CPU_VEYRON_V1        RISCV_CPU_TYPE_NAME("veyron-v1")
 #define TYPE_RISCV_CPU_TT_ASCALON       RISCV_CPU_TYPE_NAME("tt-ascalon")
 #define TYPE_RISCV_CPU_XIANGSHAN_NANHU  RISCV_CPU_TYPE_NAME("xiangshan-nanhu")
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a74384a091..fa497e5e8a 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3121,6 +3121,57 @@ static const TypeInfo riscv_cpu_type_infos[] = {
 #endif
     ),
 
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_THEAD_C908, TYPE_RISCV_VENDOR_CPU,
+        .misa_mxl_max = MXL_RV64,
+        .misa_ext = RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU,
+        .priv_spec = PRIV_VERSION_1_12_0,
+
+        /* ISA extensions */
+        .cfg.ext_xtheadba = true,
+        .cfg.ext_xtheadbb = true,
+        .cfg.ext_xtheadbs = true,
+        .cfg.ext_xtheadcmo = true,
+        .cfg.ext_xtheadcondmov = true,
+        .cfg.ext_xtheadfmv = true,
+        .cfg.ext_xtheadfmemidx = true,
+        .cfg.ext_xtheadmac = true,
+        .cfg.ext_xtheadmemidx = true,
+        .cfg.ext_xtheadmempair = true,
+        .cfg.ext_xtheadsync = true,
+        .cfg.ext_smepmp = true,
+        .cfg.ext_sscofpmf = true,
+        .cfg.ext_sstc = true,
+        .cfg.ext_svpbmt = true,
+        .cfg.ext_svinval = true,
+        .cfg.ext_svnapot = true,
+        .cfg.ext_zba = true,
+        .cfg.ext_zbb = true,
+        .cfg.ext_zbc = true,
+        .cfg.ext_zbs = true,
+        .cfg.ext_zkt = true,
+        .cfg.ext_zbkc = true,
+        .cfg.ext_zicsr = true,
+        .cfg.ext_zifencei = true,
+        .cfg.ext_zihintpause = true,
+        .cfg.ext_zicbom = true,
+        .cfg.ext_zicboz = true,
+
+        .cfg.pmp = true,
+        .cfg.mmu = true,
+        .cfg.max_satp_mode = VM_1_10_SV48,
+
+        .cfg.marchid = 0x8d143000,
+        .cfg.mvendorid = THEAD_VENDOR_ID,
+#ifndef CONFIG_USER_ONLY
+        .custom_csrs = th_csr_list,
+#endif
+    ),
+
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_THEAD_C908V, TYPE_RISCV_CPU_THEAD_C908,
+        .misa_ext = RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU | RVV,
+        .vext_spec = VEXT_VERSION_1_00_0,
+    ),
+
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_TT_ASCALON, TYPE_RISCV_VENDOR_CPU,
         .misa_mxl_max = MXL_RV64,
         .misa_ext = RVG | RVC | RVS | RVU | RVH | RVV,
diff --git a/target/riscv/th_csr.c b/target/riscv/th_csr.c
index a4ea4ce391..431f4cc286 100644
--- a/target/riscv/th_csr.c
+++ b/target/riscv/th_csr.c
@@ -2,6 +2,9 @@
  * T-Head-specific CSRs.
  *
  * Copyright (c) 2024 VRULL GmbH
+ * Copyright (c) 2025 Chao Liu <chao.liu.zevorn@gmail.com>
+ *
+ * For more information, see XuanTie-C908-UserManual_xrvm_20240530.pdf
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
@@ -21,13 +24,84 @@
 #include "cpu_vendorid.h"
 #include "target/riscv/csr.h"
 
-#define CSR_TH_SXSTATUS 0x5c0
+/* Extended M-mode control registers of T-Head */
+#define CSR_TH_MXSTATUS        0x7c0
+#define CSR_TH_MHCR            0x7c1
+#define CSR_TH_MCOR            0x7c2
+#define CSR_TH_MCCR2           0x7c3
+#define CSR_TH_MHINT           0x7c5
+#define CSR_TH_MRVBR           0x7c7
+#define CSR_TH_MCOUNTERWEN     0x7c9
+#define CSR_TH_MCOUNTERINTEN   0x7ca
+#define CSR_TH_MCOUNTEROF      0x7cb
+#define CSR_TH_MCINS           0x7d2
+#define CSR_TH_MCINDEX         0x7d3
+#define CSR_TH_MCDATA0         0x7d4
+#define CSR_TH_MCDATA1         0x7d5
+#define CSR_TH_MSMPR           0x7f3
+#define CSR_TH_CPUID           0xfc0
+#define CSR_TH_MAPBADDR        0xfc1
+
+/* TH_MXSTATUS bits */
+#define TH_MXSTATUS_UCME        BIT(16)
+#define TH_MXSTATUS_MAEE        BIT(21)
+#define TH_MXSTATUS_THEADISAEE  BIT(22)
+
+/* Extended S-mode control registers of T-Head */
+#define CSR_TH_SXSTATUS        0x5c0
+#define CSR_TH_SHCR            0x5c1
+#define CSR_TH_SCER2           0x5c2
+#define CSR_TH_SCER            0x5c3
+#define CSR_TH_SCOUNTERINTEN   0x5c4
+#define CSR_TH_SCOUNTEROF      0x5c5
+#define CSR_TH_SCYCLE          0x5e0
+#define CSR_TH_SHPMCOUNTER3    0x5e3
+#define CSR_TH_SHPMCOUNTER4    0x5e4
+#define CSR_TH_SHPMCOUNTER5    0x5e5
+#define CSR_TH_SHPMCOUNTER6    0x5e6
+#define CSR_TH_SHPMCOUNTER7    0x5e7
+#define CSR_TH_SHPMCOUNTER8    0x5e8
+#define CSR_TH_SHPMCOUNTER9    0x5e9
+#define CSR_TH_SHPMCOUNTER10   0x5ea
+#define CSR_TH_SHPMCOUNTER11   0x5eb
+#define CSR_TH_SHPMCOUNTER12   0x5ec
+#define CSR_TH_SHPMCOUNTER13   0x5ed
+#define CSR_TH_SHPMCOUNTER14   0x5ee
+#define CSR_TH_SHPMCOUNTER15   0x5ef
+#define CSR_TH_SHPMCOUNTER16   0x5f0
+#define CSR_TH_SHPMCOUNTER17   0x5f1
+#define CSR_TH_SHPMCOUNTER18   0x5f2
+#define CSR_TH_SHPMCOUNTER19   0x5f3
+#define CSR_TH_SHPMCOUNTER20   0x5f4
+#define CSR_TH_SHPMCOUNTER21   0x5f5
+#define CSR_TH_SHPMCOUNTER22   0x5f6
+#define CSR_TH_SHPMCOUNTER23   0x5f7
+#define CSR_TH_SHPMCOUNTER24   0x5f8
+#define CSR_TH_SHPMCOUNTER25   0x5f9
+#define CSR_TH_SHPMCOUNTER26   0x5fa
+#define CSR_TH_SHPMCOUNTER27   0x5fb
+#define CSR_TH_SHPMCOUNTER28   0x5fc
+#define CSR_TH_SHPMCOUNTER29   0x5fd
+#define CSR_TH_SHPMCOUNTER30   0x5fe
+#define CSR_TH_SHPMCOUNTER31   0x5ff
+#define CSR_TH_SMIR            0x9c0
+#define CSR_TH_SMLO0           0x9c1
+#define CSR_TH_SMEH            0x9c2
+#define CSR_TH_SMCIR           0x9c3
+
+/* Extended U-mode control registers of T-Head */
+#define CSR_TH_FXCR            0x800
 
 /* TH_SXSTATUS bits */
 #define TH_SXSTATUS_UCME        BIT(16)
 #define TH_SXSTATUS_MAEE        BIT(21)
 #define TH_SXSTATUS_THEADISAEE  BIT(22)
 
+static RISCVException mmode(CPURISCVState *env, int csrno)
+{
+    return RISCV_EXCP_NONE;
+}
+
 static RISCVException smode(CPURISCVState *env, int csrno)
 {
     if (riscv_has_ext(env, RVS)) {
@@ -37,11 +111,31 @@ static RISCVException smode(CPURISCVState *env, int csrno)
     return RISCV_EXCP_ILLEGAL_INST;
 }
 
+static RISCVException any(CPURISCVState *env, int csrno)
+{
+    return RISCV_EXCP_NONE;
+}
+
 static bool test_thead_mvendorid(RISCVCPU *cpu)
 {
     return cpu->cfg.mvendorid == THEAD_VENDOR_ID;
 }
 
+static RISCVException read_th_mxstatus(CPURISCVState *env, int csrno,
+                                       target_ulong *val)
+{
+    /* We don't set MAEE here, because QEMU does not implement MAEE. */
+    *val = TH_MXSTATUS_UCME | TH_MXSTATUS_THEADISAEE;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException read_unimp_th_csr(CPURISCVState *env, int csrno,
+                                        target_ulong *val)
+{
+    *val = 0;
+    return RISCV_EXCP_NONE;
+}
+
 static RISCVException read_th_sxstatus(CPURISCVState *env, int csrno,
                                        target_ulong *val)
 {
@@ -51,10 +145,290 @@ static RISCVException read_th_sxstatus(CPURISCVState *env, int csrno,
 }
 
 const RISCVCSR th_csr_list[] = {
+    {
+        .csrno = CSR_TH_MXSTATUS,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.mxstatus", mmode, read_th_mxstatus }
+    },
+    {
+        .csrno = CSR_TH_MHCR,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.mhcr", mmode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_MCOR,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.mcor", mmode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_MCCR2,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.mccr2", mmode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_MHINT,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.mhint", mmode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_MRVBR,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.mrvbr", mmode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_MCOUNTERWEN,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.mcounterwen", mmode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_MCOUNTERINTEN,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.mcounterinten", mmode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_MCOUNTEROF,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.mcounterof", mmode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_MCINS,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.mcins", mmode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_MCINDEX,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.mcindex", mmode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_MCDATA0,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.mcdata0", mmode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_MCDATA1,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.mcdata1", mmode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_MSMPR,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.msmpr", mmode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_CPUID,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.cpuid", mmode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_MAPBADDR,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.mapbaddr", mmode, read_unimp_th_csr }
+    },
     {
         .csrno = CSR_TH_SXSTATUS,
         .insertion_test = test_thead_mvendorid,
         .csr_ops = { "th.sxstatus", smode, read_th_sxstatus }
     },
+    {
+        .csrno = CSR_TH_SHCR,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.shcr", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SCER2,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.scer2", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SCER,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.scer", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SCOUNTERINTEN,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.scounterinten", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SCOUNTEROF,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.scounterof", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SCYCLE,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.scycle", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SHPMCOUNTER3,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.shpmcounter3", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SHPMCOUNTER4,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.shpmcounter4", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SHPMCOUNTER5,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.shpmcounter5", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SHPMCOUNTER6,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.shpmcounter6", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SHPMCOUNTER7,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.shpmcounter7", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SHPMCOUNTER8,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.shpmcounter8", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SHPMCOUNTER9,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.shpmcounter9", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SHPMCOUNTER10,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.shpmcounter10", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SHPMCOUNTER11,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.shpmcounter11", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SHPMCOUNTER12,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.shpmcounter12", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SHPMCOUNTER13,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.shpmcounter13", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SHPMCOUNTER14,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.shpmcounter14", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SHPMCOUNTER15,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.shpmcounter15", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SHPMCOUNTER16,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.shpmcounter16", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SHPMCOUNTER17,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.shpmcounter17", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SHPMCOUNTER18,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.shpmcounter18", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SHPMCOUNTER19,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.shpmcounter19", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SHPMCOUNTER20,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.shpmcounter20", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SHPMCOUNTER21,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.shpmcounter21", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SHPMCOUNTER22,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.shpmcounter22", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SHPMCOUNTER23,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.shpmcounter23", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SHPMCOUNTER24,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.shpmcounter24", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SHPMCOUNTER25,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.shpmcounter25", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SHPMCOUNTER26,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.shpmcounter26", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SHPMCOUNTER27,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.shpmcounter27", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SHPMCOUNTER28,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.shpmcounter28", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SHPMCOUNTER29,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.shpmcounter29", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SHPMCOUNTER30,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.shpmcounter30", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SHPMCOUNTER31,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.shpmcounter31", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SMIR,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.smir", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SMLO0,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.smlo0", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SMEH,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.smeh", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_SMCIR,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.smcir", smode, read_unimp_th_csr }
+    },
+    {
+        .csrno = CSR_TH_FXCR,
+        .insertion_test = test_thead_mvendorid,
+        .csr_ops = { "th.fxcr", any, read_unimp_th_csr }
+    },
     { }
 };
-- 
2.54.0


