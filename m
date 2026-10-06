Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47F7BCA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:52:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEN8d-0005FI-R8; Wed, 07 Oct 2026 04:36:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xEI4t-0001GQ-A1; Tue, 06 Oct 2026 23:12:33 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xEI4T-0000iz-P3; Tue, 06 Oct 2026 23:12:18 -0400
Received: from SI3PR02MB9388.apcprd02.prod.outlook.com (2603:1096:4:2a6::8) by
 KUZPR02MB9164.apcprd02.prod.outlook.com (2603:1096:d10:61::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.15; Tue, 6 Oct 2026 20:56:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yTUeZwodjciXUOtyyWxhsu4AEd65nVQakqILslkYau5Iihm0CUr6XheEQWPCwsxcBfHh5kfcxWPQOA9H9R/Xh3b0ynzyFM75O2EU9PBz/tuh+aqYmrF6b1dO+liogkLxjR7Q15Y7x2cpFrRoiLnuf11A9nzI0T02ENhrkX+f0jlWNCJ1hGShRi1eAIatzy97vXOiP4FbPOocenSExW5RWMNoeUQMV1QP4tqHueOJBoVFjs8Q7pMhH0PqRDEEqC+LTOlIaD9nlifaGYPbuRh1uEJfP5u/Ap3Gai/nNWSW7dsjUXtN/ZwPuOOn8qzk0C7mIILCEJ/EYmylEmkuIEYysg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ttaX2V3rulJC8JuORF/9zSkrNZLdTaBnHNJSBgJCeLI=;
 b=kOufS40Lt1FDECbqgoVEFYCqIoEEyHcmqguf3ipwMlHaJzXkN7YYV2hOHtxmuGyjOdMe/xXS+qNkv7eWHMI9FGWjeW7ycnWNxeIHSFdRZ3vHBm6ezD60tgCOSvjk0WGCU47gLh/1TyibVHfH9MdZadt2r4FmArr4o3lSlWiVxgXfT5AQcx7ezBzQTQjKzU0XNmEq8o0vLS/ML/TMCEDWyUYFYpvtpnvZ42BFqCXMUsEx3sTmTDZ1R2YUfXOHVvrn3NCQe1dzjcW0RqDYAeIwjXKoXQ9BEA3Vr7JxbfEvrzeJP4KSWPBBXO6ZyufdCHQRldpUbaLG3R4bEHQZPni1CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ttaX2V3rulJC8JuORF/9zSkrNZLdTaBnHNJSBgJCeLI=;
 b=BwE0nBMHjciDZwsCrzZJ/wvX3QLugEJGJTTedTVDjOoIX5pGpq9U3yg4OzGm/+QwvyhwsESEKZnaDQRRi+EYBxWg0/UaF3OjNqtCN+OCElm7z5ul1dorVD32CaCUiCXYgsHvLG3tPUWuOND0O9kVkt+nZoS+781I0YyQg5gZVzY4bmB2MfyLOc6/p2IdC/ymrvzXMN6QsXCvl/XInMTobdi+qv/nAflb54mcU5gKmjbppnY/hHci0rn2vDQHJSpmuhScp41/NtY8npuj0PjOfeR7Srf3yH/zqVXB3DozX0usgNvL3WDxkT8BEVgEja0xE5GnMjfUj+aEaqGfIP9xKg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by SI3PR02MB9388.apcprd02.prod.outlook.com (2603:1096:4:2a6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 09:50:27 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 09:50:27 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: [PATCH 08/17] target/ppc: Register L2CFG0 and L2CSR1 on e500mc and
 e5500
Date: Tue,  6 Oct 2026 17:49:03 +0800
Message-ID: <20261006094921.110871-9-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: d6fdd4e1-017c-402b-b44e-08df238f4018
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|18002099003|22082099003|6133799003|10067099003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info: suG6OtgF9Z5PQ1zRgjE3zJhe/e+pOd6FTfri6dyTPBx6oK/2/Y0hFw49kXD4mj3lsRTEldV2GPEA8LBa33rwfAjGt1gveP/c1dYrCxCeozrwAdYbfL4c64QNEjczEwoKtLAN0OEzY2JCX96Ok3L0+slkZaFfyhoOzUMuqTbOojwZWI/9WYI3VNvTX9WWwhIuHb/lomW/pNEiiBfavdp1YgnvuyDkhWS3WrUOVFtb/Gfdym8aJKfH9PLz7V3uUbJSCrcfB0vGyynGG/T1I+AMY9KxahW2KFUr7R7HqHZtDRw9MJBeo6dNW18pTlgSDqc2yq9WRcbWbsu8PvSygp5nvMR6nTCMxWjOKsyx8i5oNj2jUgis8iFQYAxyJ/09pXnF4W9XDfGRO6Dk8vlp89SShADMYkttWqnY8AfMNmkXI6jX1JpotWIYg12ktBRUC45ID+s1uw3HG0iP9F0rdg5SnhkHpcs+NOfpAUu/rZOaduupDmclI/sNtJeC2zJAtSasLBfC2kB+qE/Dy5Bg+YkfVR9CAyty+PUihZa08BKNOp4I+IezBv3q9CMnSopyn47E9GTGLDn+nMEvFevOtK5uabs1k5fl+scjf4BOTHzuBtV3pMpgqh0i4OKcblwiTHfj1U90l4ZBON+Y6bMW/gWDZ10I8FLfm7pR4NX4misS7PA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(22082099003)(6133799003)(10067099003)(3023799007)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y8c/4HvGhIqIHjuU8HRAlKiFLarcSwpgBqk4/bL1AfSiV0y+0Xwo5+rw+hZj?=
 =?us-ascii?Q?rvS+F2DSjk2KzPbWRzuTgGGvffNjQJprkKGoxxgwBLmpLC8NZOVp8ZwRhnh3?=
 =?us-ascii?Q?1uWciAJjDY+prnymgH/LJ5/w6eMlnYyCBoTTaGjoIIVfXTudM8KTRdIDhHJL?=
 =?us-ascii?Q?QRH/g1HTMaEGzE3J2fDn6Zdyk3zAmtIDrYmII1xC5DiB3rG9OS/RNUSLEFAg?=
 =?us-ascii?Q?zfM9vD+biU0VyPuQsQ/DNuxNf5NUt1hC//3BjK5IZZ7dVCwlbn3rHNHvFhmy?=
 =?us-ascii?Q?mCyfWm/REPW7jNArif6P0I9LZvYGxRmOrBXBDDPidg+NRRIqWTLauyZP4l5m?=
 =?us-ascii?Q?Jkj1+cyWWYgv/7maoQlwF2D84e+UogsN4j7gXsgOd6t97GZutr4JtsL+X6sG?=
 =?us-ascii?Q?cXlPpgjHvYffj/J5kb6DJugq24GeGFeudf/6GYou7pHDj2wCqYjrHcFzcAsL?=
 =?us-ascii?Q?orYNkju+oMtODI4ttfTINLrT6FT2O1A4X7Ms2p5NQK0bgbm3uykUf9G2c2tI?=
 =?us-ascii?Q?NRgp5MmubLQ/ttOahMjmDiiKq48rQv4Kpd4hyCPf3mZxeOE51es9HkVWRvyS?=
 =?us-ascii?Q?U6mKK7o3+LinuFZFjgOANZHuvdBVz9yUxOuQoqDUqJcLMjIXjz9iBeTgUx0B?=
 =?us-ascii?Q?SOuLGE6IkZqmb1E5dtQMdEvuyyFwxvsv3X1o7u3li0cUZwcxdYTXG2Oass4y?=
 =?us-ascii?Q?MiuStLwjv+0AiP0+6YNoWszroVxoO9LNG6KBSzvlOt3jFxQB37EQ46ffqCy2?=
 =?us-ascii?Q?cQHFzj1BilvYQXID+DnkwOWTGv+bnjX4+XkqbOTiltAI4xa58KfWB66yGIh2?=
 =?us-ascii?Q?2dlXfasWWrf7dczcb9Wf3g818Dd0tQAN8gWP0bWhT/WYo4LslX+wNDHmOfAe?=
 =?us-ascii?Q?JY6LdZp8zHT9CEkpuZPbks2Giz9LHJxsq6ARblPAPzizrUPDE1Gi+b/VGSpC?=
 =?us-ascii?Q?xKB6I4wbRo6A5PYvlgRF1eiupE+d1w85rfpgyVFUP01eEaTbxXvedZTYuDsi?=
 =?us-ascii?Q?q3xHzObU23d8wb7oND5K8fC8Yjo2zQ4imLFKE2DNfx2GXwWKglCdeZ5PLhwz?=
 =?us-ascii?Q?zH4nrxd9R/OUAweY/mp2BMyYwmlpQNzofHiqXXfaAU7INHPOYFurAvNN3HQg?=
 =?us-ascii?Q?a8+uukGtfse1rYLJOLh5x2/Mf/9WwJJ7NpWKQeqpwlVcrtRu18vmIbYW8CAx?=
 =?us-ascii?Q?9p0ebnRpacMSHdGiP8ZOBlzbbJkFkmls/rTPVGQj9pK3KEFSAcEcOms7izHu?=
 =?us-ascii?Q?z56mfu066dGfHDN2uM4XXE0MJRb0HRas3efj1F/dFvdtRePl6Nb8XHadUpAH?=
 =?us-ascii?Q?rII2pp0hskMkK0rKn56yN/bgXcY0uUaxEGxeyAT8UEusoQ6IY2ZfppqMK+rG?=
 =?us-ascii?Q?TQXF/XbUYTCq5Zj6bhRnTW2Q8o2q30zyzOobI91RzbApMTbzw4vJSKlbGLtS?=
 =?us-ascii?Q?uDKQjOgIP2n22cOVMdsEo4GE+nZa/8ZEzlcUYZsP3/5Xrdcl/O6yosypeCkx?=
 =?us-ascii?Q?CqpG2E4gPytE1sC2gFnam1iN6wkk7EHBU2mLIkMLJEXL25O2gGTqKappKhXW?=
 =?us-ascii?Q?QPK7WVWXV2UYW9VLGKKAXByXrtmJkOqtCUwHuHO/g9YcolYvPdDNB5WCyxVk?=
 =?us-ascii?Q?wv/lCt3mjn7vSIpPY38kEHkkur22IljofnrW/5XOEIJvPOncXvMn1DaTsAxO?=
 =?us-ascii?Q?SKNpMFkYpF++auH2wniifZrSjRc761b7IocyBOH74d/2kr+i9CITRIcyjFaU?=
 =?us-ascii?Q?FO6jrizhWwZ5nXx7GhHGJw/nQ/j5gjw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d6fdd4e1-017c-402b-b44e-08df238f4018
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 09:50:27.4757 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LbucrsnmYgtY/bl9mNe2xTHLMaRcfh676Oyuw7vWjjgRZ0eQe7CP+GIoTIT65NIdqLycameFsy6KNNMx+LeI2JqNtT7Wc45U8WzA9q3xvzE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI3PR02MB9388
X-OriginatorOrg: processmission.com
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

The e500mc and e5500 core manuals define L2CFG0 as read-only SPR 519
(0x207) and L2CSR1 as writable SPR 1018 (0x3fa). U-Boot reads the
former to discover the private L2 cache and programs the latter to
select its stash ID. Missing registrations leave cache discovery
and stash setup incomplete.

Expose both registers on e500mc and e5500. Use the 128 KiB L2 geometry
specified by the e500mc manual and a 256 KiB default for e5500,
matching T1040/T1024. Other SoC integrations can override the capacity.

Note the e6500 shared L2 uses memory-mapped registers, hence we do not
add these SPRs to that core.

Reference:
- E500MCRM (Rev.3), section 2.15.1 and 2.15.3
  https://www.nxp.com/docs/en/reference-manual/E500MCRM.pdf
- E5500RM (Rev.4), section 2.15.1 and 2.15.3
  https://www.nxp.com/webapp/Download?colCode=E5500RM
- E6500RM (Rev.0), section 2.12.1 and 2.12.3
  https://www.nxp.com/docs/en/reference-manual/E6500RM.pdf

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 target/ppc/cpu.h      |  2 ++
 target/ppc/cpu_init.c | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index d3f1c82730..498b505a96 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1976,6 +1976,7 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_Exxx_L1CFG0       (0x203)
 #define SPR_Exxx_L1CFG1       (0x204)
 #define SPR_Exxx_NPIDR        (0x205)
+#define SPR_Exxx_L2CFG0       (0x207)
 #define SPR_ATBL              (0x20E)
 #define SPR_ATBU              (0x20F)
 #define SPR_IBAT0U            (0x210)
@@ -2341,6 +2342,7 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_750_TDCH          (0x3FA)
 #define SPR_IABR2             (0x3FA)
 #define SPR_40x_DCCR          (0x3FA)
+#define SPR_Exxx_L2CSR1       (0x3FA)
 #define SPR_ICTC              (0x3FB)
 #define SPR_40x_ICCR          (0x3FB)
 #define SPR_THRM1             (0x3FC)
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index e5856b5b1d..21c6012fa1 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -2974,6 +2974,20 @@ static void init_proc_e500(CPUPPCState *env, int version)
                      &spr_read_generic, &spr_write_e500_l2csr0,
                      0x00000000);
     }
+    if (version == fsl_e500mc || version == fsl_e5500) {
+        /*
+         * L2CSIZE is in 64 KiB units. Use 128 KiB for e500mc and a
+         * 256 KiB default for e5500, matching the T1040/T1024 SoCs.
+         * Other SoC models can override the e5500 capacity.
+         */
+        spr_register(env, SPR_Exxx_L2CFG0, "L2CFG0",
+                     &spr_read_generic, SPR_NOACCESS,
+                     &spr_read_generic, SPR_NOACCESS,
+                     version == fsl_e500mc ? 0x3cb1c002 : 0x3cb1c004);
+        spr_register(env, SPR_Exxx_L2CSR1, "L2CSR1",
+                     SPR_NOACCESS, SPR_NOACCESS,
+                     &spr_read_generic, &spr_write_generic32, 0);
+    }
     spr_register(env, SPR_BOOKE_MCSRR0, "MCSRR0",
                  SPR_NOACCESS, SPR_NOACCESS,
                  &spr_read_generic, &spr_write_generic,
-- 
2.53.0


