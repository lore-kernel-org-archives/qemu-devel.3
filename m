Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D8F1CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:39:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEN5B-000529-79; Wed, 07 Oct 2026 04:33:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xEHx3-0007wW-7c; Tue, 06 Oct 2026 23:04:33 -0400
Received: from mail-koreacentralazon11023112.outbound.protection.outlook.com
 ([40.107.44.112] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xEHwy-0007Rq-Tt; Tue, 06 Oct 2026 23:04:15 -0400
Received: from SI3PR02MB9388.apcprd02.prod.outlook.com (2603:1096:4:2a6::8) by
 KUZPR02MB9164.apcprd02.prod.outlook.com (2603:1096:d10:61::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.15; Tue, 6 Oct 2026 20:56:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DlPhOm0rTlOqdNNlRTFL0gmUNT8s1oV9hRlNbICosbhXcLpttLn2lJtrIDLGTAo5MCmnmqpWiJVlzSMwVqj3L0ahWCJTnUUWAiy+HIbuBxA82JkqiJHkCH54OYo2PdMVw2cHuzh4YJckWf+ieNIQsG678lILis7HJMs4edm9LwUXEPhDN4Apo4S8H3Tt7sB1hwRDw0IDoHxi+CPwaBk47JBiNWFYgf6aFOIlsvPa6ebqrvOgmxoOp3tWTQalAF6qpOghNseXGgwIqzSr378R+PGyvh/QF9NyIUCdntE7ezXI1FkJZAVXRBDtH/3iGRMoF/pPDE6LjDZSJU6lcvJhfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2/Jlp/hpm48z5rD4ze1wohMowsTXgjE3pmq8Gd+cSJM=;
 b=TkppN2dK5eXPCMrU4eHkJch1LWVBtXq8EwdKVIsNYeyolKiq45GX+ysVbOcr2ao5jBSiwUK6n7XbDT071yWhxfilvUHnHHX0Dt2JjtmoQPOE7DmzaV7WweYD97g9nXK9WqU1Y1o08P+zf7KYWZd3tlU5Sew8NbUrBcKL9gDl3jgEWbR7v8OnjWgDBbx59J7bpCC3NE0fcxP0SXMhPFCttv2gK4k3V0g598mBdx+OWNCVbdTmylu3dBrZW5Z33pHWUz+N33eqX/2GEtbyyxL9MnfSI9NxA35W5lWUacjTMgnzD3FXK4OTO5p8vkNqgp9SeSriU6rbXv6AZCt08LwtgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/Jlp/hpm48z5rD4ze1wohMowsTXgjE3pmq8Gd+cSJM=;
 b=vieT7S05r1hz6278nYHjO936WisgdzVYZ79eecEyYOU3BPjg7OUXC+c/MeBJBakXek/wxTEmYdJWYj+iJ67JCOJMqMlKrQBnOtovyLNL+DZ2m//ubfdzVitn/ZM+9Uk7N5EXOz18J32ZwoUU8DX/Mxqi06sC80vUPiWsvdGEUZncU3O1Li3MfD/dNiyzhzWJQIukLsNMbei8KZbVe3E7Vxa2tnUXRprjFdHaVFsdl1r5QmwaHWPLgYompeTl+VqpN9KEzw/ZL+Tw7HvLXlFmR9WfWLQrO+Y9jvcVGm0BCq4CgAzVicZmlOs0dCoRNJx68T0Nbsg/MWDllolSxO4KJg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by SI3PR02MB9388.apcprd02.prod.outlook.com (2603:1096:4:2a6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 09:50:30 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 09:50:30 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: [PATCH 09/17] target/ppc: Register MAS5 and MAS8 on e500mc/e5500/e6500
Date: Tue,  6 Oct 2026 17:49:04 +0800
Message-ID: <20261006094921.110871-10-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006094921.110871-1-bin.meng@processmission.com>
References: <20261006094921.110871-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0136.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::6) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|SI3PR02MB9388:EE_|KUZPR02MB9164:EE_
X-MS-Office365-Filtering-Correlation-Id: 88cfe50d-3ef0-46b3-f2d6-08df238f41cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|18002099003|22082099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: CH03gp6yzL0jezeFYEq+jHFA+Slh7Ur1xnCumxMn/zE6ebn954q/eimI+HgE0Sr2Z356kLBtSaCZhsG8/PBu+XL3khGe/ioFK3aKmJUddoc3N7NB36rU1iLuc+jRDT9FilBebqQk0S1LEeCaPBT9cZBQ3rfJROvAGWPy18LPIGe5IpG9piltsTys/okiHr9bOAYrI95QdzSeApn/tQpT8nuBesBGczXqbMce43Xs2vw8X18F4xYPxXJKD2He1l1eBufAfBR7IZsUGyYmazP4TwZSqRP9a0/phbXGUg4LcSco0ZYLGDG64cn3/UK/OGN16stkx0fQ7UfyWuoK167PFWa+wiC06AI95V2Co1kblO1S1GYVfwC2Byi7zH72TBdQxYFUzPW0dtHYlXG7ZYRw1QFagz4FqgdO+prNfIQY3FHYncwGXGxkF/Vzp4+2Y1EO72mSdHVXzqyW7b2pqtegSbdy2jEwYEtOcFwjEWI4hpp5GZmQbtUgSSDUg0fQTuj9+rmEZfvdwl6qoLemXHQmpBS1Abakv9ozeo/la9YSaLCZRs1OSIZJgvOvSSILySA/UPyz79/kyCB7qLzeHR0Wrgrxkhgtxpcjrp02qxu5Xojmj0sICS0T+93HeJEIlTLiK64TtOcy1IgMWkD/kjFhbEBtaZ9vvz52BIyH0MWpDrU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(22082099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uCxG4HUNMcypbGaIujzBW8KbaultVcAY/nV3GN6/kaJazYWqvaSsjjAEVHlv?=
 =?us-ascii?Q?mcJ5/uxDRADlZtZPkzp18ULDyACZehoS/j+cbbf2HuU0Gcw2sY52JOCo9PBz?=
 =?us-ascii?Q?q1X2ibq5SSJaE+xB4m+E4ARnfh4PyL6zfflCN7LjzU/SwGPzD/pZ4iltMU7q?=
 =?us-ascii?Q?mebzNaUudNNtF9coB3u+noO7wgEk0HGOIR3MPmjF6aMngiTY96GaTyEvU8PK?=
 =?us-ascii?Q?t858KmjDVghiMIcWHxyNEkD/QgZLELcRZdxuy9raoWYI5IgFkyzRfVkqt8+q?=
 =?us-ascii?Q?mQ3FLZLor4iwJR28B3oDLn8SKOVvZdivuO+Nosj/OXnlZp2KKkB9cbVKMtgm?=
 =?us-ascii?Q?dfzkxbRkLMmBBxeSnh53H/ITuTqPSxXdIP7caXuuJhwebGIfyYL80NV/ZNSx?=
 =?us-ascii?Q?F+8T82TUhmOUC+62Et6LUmFLPwAYC05R3QZxN9gjwo0Ug1O82Lke3n7/HkQs?=
 =?us-ascii?Q?Z/tGAnvcourB/P7rI7lD2lJGomfacCJGhIhxnfrq0D+kT9UOFnQL2OUsA+J2?=
 =?us-ascii?Q?18PNEFqUN8FPKAfW19lv2STLs6Y3wmG9oPjhT64VV7zqNcX1bdDUGJt1OdAu?=
 =?us-ascii?Q?UOjww46kC4kdwU9jFWlFCwcIz3RyTig0gLs9MMUVoa51+pvMZcCeaZ0cNHDv?=
 =?us-ascii?Q?epap6oyuLO8LoYUsrCt58PCAmkTXPPxgoqx1r6J6pL+1QWKNuP+A0MwERr9q?=
 =?us-ascii?Q?+1UxZppxOUta81l0LBU5c0UM5YSFG3JgcXOZtg3QEcriwWM8PQTTR6+LVyBs?=
 =?us-ascii?Q?Z9+5BMOmuLjs5PhEGNbiJy+txsUWBu5nsfFev/JIn+BEQmt5cbGdbehFf/Ov?=
 =?us-ascii?Q?Pw+m//IS2ojWAPsHytYN5HP4/r1tQetlHq19ky6jt3EcqvNtIX8DM5VwTPJy?=
 =?us-ascii?Q?HNV8FDSlPERT0LPkfK0DGZV8BOhS7Qa0IMbYrshArWlMRGxg6zYRcq3WXfO2?=
 =?us-ascii?Q?+HQfEUUoIHEfAF9IV4mLpwPTxVHeyHFsgrEoGgYkRjt3FMXDSVNP/fQeUkXD?=
 =?us-ascii?Q?mtvqgKxka7pGBbua1K8k6A7QCsO7TYXOQvFEpdFUxGo6gFcPej8QBJ7wW8xK?=
 =?us-ascii?Q?U84OgrKdbuA+thrEC3DF2pKTZ14FpQ6lh3hSCcnteNv8vD5W9G31StUB4vjW?=
 =?us-ascii?Q?70b4+JGSuJLKRSDcbp/8vKBzRnkOHdei3ZVIFpcW7LBGHL8bOlBADtR4WRVx?=
 =?us-ascii?Q?qXere5dwMd4ZbFFrNtcJMav2n0pBYzXmeLObmNCty8n/53fgbdLvTARUciNu?=
 =?us-ascii?Q?nlBnIL1tFT0NPmnqwCOoC1+RnCYTxFFWlXpO2jK6CuIk1A6J9swRh/0Gl9gs?=
 =?us-ascii?Q?W2lm44JxudHvBBYSYmoOb3ZB0IyGRBp2Q14aDWCPRkY5UESEd+j7/PQGrcxl?=
 =?us-ascii?Q?Gg0QTlgdyKqB9b+iQ1E5bpgcCaTgsVSNJatSXNDXfjcpd4f4JGqKfiARnRqn?=
 =?us-ascii?Q?5nvUC5aKmJcl+LPAczD0xgaD2Xtc/jBRsrVWFzf7yj4zQYPPmsXBao1/vH3X?=
 =?us-ascii?Q?zqTAdch1koXInp7K1BKpeT8ho8VgDlpnYFagCcyKU/6gBWWKaiSejhXJM09R?=
 =?us-ascii?Q?KFH0gF0nsGAEiMr9p58UpubuO/Q39RhfVtlmmuZv235pHd2UXkXyuccYmT10?=
 =?us-ascii?Q?gXLu4M2vBMRJ00m00zUXAdD1REcLyhBgdWCXnXmIKGhY+elz89zKakBYs6II?=
 =?us-ascii?Q?ITPSwwg/AvBo/GinYBFwn+FvTzDLEJPPP1AsgX96g5MdlPGfJ2lX/eSc7kxN?=
 =?us-ascii?Q?RGrAqMC6lPnfQgfo7Ntw8m0NFu/JqdM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 88cfe50d-3ef0-46b3-f2d6-08df238f41cf
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 09:50:30.2858 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LzS4/xqnD0CYHYbTkbYNzIms1p6641TY2UKIlYTHiCHuzKoTqvFFs3csIHuGtGZs8CHVOokqRW1BXnYJHh93oCOfxNFHOJlcEJFvz2ZsLL4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI3PR02MB9388
X-OriginatorOrg: processmission.com
Received-SPF: pass client-ip=40.107.44.112;
 envelope-from=bin.meng@processmission.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

The e500mc, e5500 and e6500 core manuals define MAS5 and MAS8 as
SPRs 339 (0x153) and 341 (0x155). MAS5 supplies GS and LPID values
for TLB searches and invalidations, while MAS8 holds guest-space
and LPID context for TLB entries.

Register both alongside the other BookE MMU assist registers using
the existing 32-bit SPR storage. Exclude e500v1 and e500v2, which
do not implement MAS5 or MAS8.

Reference:
- E500MCRM (Rev.3), section 2.16.6.6 and 2.16.6.9
  https://www.nxp.com/docs/en/reference-manual/E500MCRM.pdf
- E5500RM (Rev.4), section 2.16.6.6 and 2.16.6.9
  https://www.nxp.com/webapp/Download?colCode=E5500RM
- E6500RM (Rev.0), section 2.13.10.6 and 2.13.10.9
  https://www.nxp.com/docs/en/reference-manual/E6500RM.pdf

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 target/ppc/cpu.h      | 1 +
 target/ppc/cpu_init.c | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 498b505a96..9d3d27be91 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1931,6 +1931,7 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_BOOKE_MAS5        (0x153)
 #define SPR_BOOKE_TCR         (0x154)
 #define SPR_PPE42_TCR         (0x154)
+#define SPR_BOOKE_MAS8        (0x155)
 #define SPR_BOOKE_TLB0PS      (0x158)
 #define SPR_BOOKE_TLB1PS      (0x159)
 #define SPR_BOOKE_TLB2PS      (0x15A)
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 21c6012fa1..032b8b606e 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -2901,6 +2901,14 @@ static void init_proc_e500(CPUPPCState *env, int version)
                   env->spr[SPR_PVR]);
     }
     register_BookE206_sprs(env, 0x000000DF, tlbncfg, mmucfg);
+    if (version != fsl_e500v1 && version != fsl_e500v2) {
+        spr_register(env, SPR_BOOKE_MAS5, "MAS5",
+                     SPR_NOACCESS, SPR_NOACCESS,
+                     &spr_read_generic, &spr_write_generic32, 0);
+        spr_register(env, SPR_BOOKE_MAS8, "MAS8",
+                     SPR_NOACCESS, SPR_NOACCESS,
+                     &spr_read_generic, &spr_write_generic32, 0);
+    }
     register_usprgh_sprs(env);
 
     if (version != fsl_e500v1) {
-- 
2.53.0


