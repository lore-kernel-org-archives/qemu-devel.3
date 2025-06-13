Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63715C7114A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 18:20:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ8zr-0005hD-M5; Fri, 13 Jun 2025 14:19:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tan@siewert.io>)
 id 1uQ8zo-0005gZ-0W; Fri, 13 Jun 2025 14:19:20 -0400
Received: from mail-germanynorthazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c20b::1] helo=BEUP281CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tan@siewert.io>)
 id 1uQ8zm-0001kU-DA; Fri, 13 Jun 2025 14:19:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DCt7qQnerWaWNfR/jfINqjt/LZeeH0EnQCdhAbsb+HBTwLWXv7HTxYaQM9MASRaPAgDy7AXqe7w60c5DeeqSThTWxjK/J+gtzvukOhmZYhSJB/exqdBIHln0UaxnNdG8KU81SenKuYaWLR+IyOY7+HJkyqkzMl0438hiHREM2fllRCXkgTudMzIZkC4Mx1t1NcmJqkPl/B534HrsIkraQVrQmwzypzVxJWc4eMjZQKqMQNCwkcGjQRsxrwXDI0xnW9k7OszsvSHjLPsjYEfp5icRyss3qaou3At578FOhyUxl4r0xhfKqYdzoh4JmFOSnd2sVt1+laTQK3hWIG9tfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f3f+mn4A94PYh8AF5TKA1j3K8Ev1N3QYOmavMZACKCM=;
 b=KriRS3A+TPtswCAWaktrdLiX5yb4pMcs3dV50nux/Zl4jIludsHavpxm1s1YmmIFA43lmUxWHkiZS8ciMR1ZKK9/A/x24ca+QGs3yyR3wD3tsp9xSHo3mMPbNulHyEfdbtSbAIYcvS0GZ5fq/EoKiNNTzECbKLYwuBfCRevtmZOpsydRoin//xnDu3HjPwYNUAMj1IFFjqeeZMq0Ta+wHTF6+bIPtATGkNnQTR12TxEETVbSMJh6Hn+49UkpSvlbhBXb5BIde9WKcro6fuXnEsosyl2eXddyyor6yWdWg5zBa06Jwawx7lb518kQp4QdG36tDMCK1W9/wEfXRn9j8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siewert.io; dmarc=pass action=none header.from=siewert.io;
 dkim=pass header.d=siewert.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siewert.io;
Received: from FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::182)
 by BEZP281MB2865.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:70::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.26; Fri, 13 Jun
 2025 18:19:10 +0000
Received: from FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
 ([fe80::6ec7:ece3:1787:5e48]) by FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
 ([fe80::6ec7:ece3:1787:5e48%6]) with mapi id 15.20.8835.019; Fri, 13 Jun 2025
 18:19:09 +0000
From: Tan Siewert <tan@siewert.io>
To: qemu-devel@nongnu.org
Cc: Tan Siewert <tan@siewert.io>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org
Subject: [PATCH v3] hw/misc/aspeed_scu: Handle AST2600 protection key
 registers correctly
Date: Fri, 13 Jun 2025 20:19:06 +0200
Message-ID: <20250613181906.50078-1-tan@siewert.io>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0385.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:80::21) To FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d18:2::182)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FR3PPFB3D0CF1D2:EE_|BEZP281MB2865:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f4a0e3a-db51-48a7-e32b-08ddaaa6ca50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?E6Sf94dHTn/CiRtv/WFNyvZ/eeUj64WLqxVIIY7jbagCUi+wT05ozcbI5Oiv?=
 =?us-ascii?Q?dh2tangVhKe4fVrOjfzcNPt7fuxCEYmuoNJHUXJvbT57zVIiaqOy5pYPt+f+?=
 =?us-ascii?Q?ubl5O9LZYTnDcFOcDCo9fTg2njC/rszqM7JDnKPMBT2kZJEk/FZenwpI9CFm?=
 =?us-ascii?Q?VCcZe8BVrbg00TgXLjaMazcb95UpZf9Qk6D2CXIJKX1r7TXCMaRxGBN0UPZ5?=
 =?us-ascii?Q?9H6tG5PeB36wdCfkyU4Uq7yleXhUhfT9FcExdKSfNqQdGXyw7lDqsTcKjUV6?=
 =?us-ascii?Q?MAFNOZAjLjLtb1ztZSiTrKZnpb+6CUnNlYtsJyVFSoO5xghlhSoQol6sXe75?=
 =?us-ascii?Q?Ntveob+oN/zzWZUNupHZFy3iExQWAkS06WQ6SP4ksDArGyo8u4mDY+dFY2LG?=
 =?us-ascii?Q?wVdd1AemAhhvKNok0Z9ofpDkpqpw9KVQxfzAaQ/JH5nGzadwO4iPRrobCvP0?=
 =?us-ascii?Q?JtJHpv5fzSA1oJyKPAVCaZbaP6yG8GuU76Wks6SBDh9Fmx6ZrmYQVnFrOo29?=
 =?us-ascii?Q?4QrJSs4f33trB01tewHCzxZtImEqjXhZPy83hmoHY8ef/Q5D91QDDsy/WH1E?=
 =?us-ascii?Q?/dAb2EOG4H2HpXCpKqcF4Pi0fqtXIcz/Lms4/9OP1oiD3vX46UMtQY2w+gpS?=
 =?us-ascii?Q?t1vpYW6opKpnfgrfmbO1cw4QPCW56bKZd7EtB8mekPRRv9GsF/FIdsV9snwG?=
 =?us-ascii?Q?Ui6f1Yr277TQP4KroE1YIaQ1ezxIgouDSJlRbwx5gAc8zcwYAYy3TOASveMB?=
 =?us-ascii?Q?BvwYI6XGN3wnd+ZgS9Oo1xauNCdnsT78DDj9aY1cJV0tjM5YsJwEXWq5taeL?=
 =?us-ascii?Q?4MXw1VT8lNdrBY2VENl4PdYaStTVtcsi68xBAeYkBDAFySfX2rVpnNYY2tdg?=
 =?us-ascii?Q?My8vq/8BKfxus24TBj/F4EMqU9ukuIDKGkgj2Ug53W74OCU3tyke+v9uJM3h?=
 =?us-ascii?Q?r3taUgRHTkR6zd8UeXtaXxeLUXa2SjvDp2kVEcB3ddFkgNWbGP4V58smKEGd?=
 =?us-ascii?Q?EScdDYxxKAWgVSng6VhGjfuW1heVaCmXn0MlkILm0INlF0dDtwyGWpYVpjB8?=
 =?us-ascii?Q?yuKHDVj20k22n73IgyVKzH8wKW0swbGbTkM1RW7ju1qA6bHNwjjcjFhafhE+?=
 =?us-ascii?Q?sBsHAeifCaLR95YFmaylqZkn4WDKa3GJycfsMjnA699n8Xi8u4qhLjGjUGyg?=
 =?us-ascii?Q?NCs4HUzTlexrp7IA+1rdVdNkGYmTP8DxSURyWr6oZETl9g0/8kA8/fapC7qp?=
 =?us-ascii?Q?wkoks4fsBOFXEdluk8sqsXqdi8MEcC6eG/j5561y/t+AJst98kwR4CDjvsDF?=
 =?us-ascii?Q?FgErm1dJBqiJKX89BlqTjyJCVwp8lzgxzkxd9+fGum0yxSnnpLv0bv3zbEGW?=
 =?us-ascii?Q?dOjW9bQyTB8pK4Q1LAXTezi7O+ecpV8hcWQzq8UQqaq78yqcPPM4x3uGWsG9?=
 =?us-ascii?Q?kc04K5Tp7mCnoIBMqS8v+b/TXZxMCKKyvFNZWf21++MJ3ALpU5vbdA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8Nt5JOwxu2V0simiTc84L7EDI9ZrZJWwQJStJDgELulXOjXQ59CXXvPz5aJX?=
 =?us-ascii?Q?E12NIk5DVP/TcZdPCNF3YqlAtglCnlxPmNxDV0DOFEDY4COo+jGK6NG1OaIB?=
 =?us-ascii?Q?OoaiRBsnxrTTT0xwcipLTyNhXnHteEcR8NH7Dec0LXFFJFsdgAH5Zjs4cIEa?=
 =?us-ascii?Q?Ci9abjDChhiLIqkyYzn/rzbf8rs2sepuHq7qKUmPSEsWEe57MnXZwD8CHohg?=
 =?us-ascii?Q?POnrBcksClA8qbDM7wJ3TvqpCx2AzSWvvRi4lKheazibRr3u7N8uUJ7804NA?=
 =?us-ascii?Q?9yQIPuzFSk9zYlEpPUP7kmyr3H61RL0gmnmOcQTnRPmWDtA36b6+Kd9VIX7c?=
 =?us-ascii?Q?vTt3pqeRj3IJ63joYU3cayy4JZrKzGTynG/5FlbKQaJDk28oY5wzKHAvzSel?=
 =?us-ascii?Q?LA44LrKWjG5gxH9lue9jmU4jxRftSkJeUD38jwkMGNUyos/xq5fijCrXo1W9?=
 =?us-ascii?Q?ic6ZCI6/1Oi2oJdkgxbRYHsZ0gB0oZxJoG2nvZCGWFPEvNj3CFrNn2GmXAPx?=
 =?us-ascii?Q?Lmr+/wupQRZ9k8qndeBwUN5sfgrfCAJfAgYkGxpm9lcEVmPbv5tCHe13HQir?=
 =?us-ascii?Q?MgL/ZiKBS/V7+TvJQktATUQZyX6Ky8MDsfuoMALTvkx3aA6M86UuDBVPGaY6?=
 =?us-ascii?Q?FhSEP6fEbgxmfcnCSwh6vVN8gjndWOMKRJGXQmM9mUEVXc7gq2FPubatXwNC?=
 =?us-ascii?Q?8UJn4l8B2ZRMtUBaKOFgbOJAKGTzVPrPXjj34nBiwn5Sya8QDh2Gtqptaxcx?=
 =?us-ascii?Q?aL4cdgDWH47QCDZt86MzzXmZEoYtLP96f3jsxowlCa/s77gbEXX6pc5V7rGM?=
 =?us-ascii?Q?s5ITJrSOCpfzH3mWC/Cw+anxRGAkwp0y8y7TffolEAk2mzzqwEsHMZoR91uM?=
 =?us-ascii?Q?io9y/XBNV+TcB1oFXQBX0SIA2vQkR9Y45IgPGGGTHJj52AJjgJ7NUQRomDeG?=
 =?us-ascii?Q?7AgT896oE2KaMtTPRR0iL+jGFCH7PEJFyqJMqLhLu37UeRc/VKCd6IWgnsnr?=
 =?us-ascii?Q?BWAu8EALwr/aocKq7cBLIcSjMErSCVVAV5GvpZqJr1UQVaTnfoJxTKHCNkRO?=
 =?us-ascii?Q?rxOqIsEHFRgBXypufzOq9VpJUf5sFUtyePOP7SkRQHwGiI67mjWIgY8Ok/oM?=
 =?us-ascii?Q?0jqYQEBdehn1HeBS6AOnCzGkwAxvbEc5CToQ/lUSgXgksUHjAHiLmMjcdFI8?=
 =?us-ascii?Q?enI8D42zyNUqzC2s8F2xGL2OgI/NJuHi2+xD8WTx8SvSwO/NVPSMvJ1+V1gx?=
 =?us-ascii?Q?jWngoc6DISBYyOJEuy//1nWrgKSNm+7b7U4ZwG58ZB/uZfIp+SFMpT8O/00I?=
 =?us-ascii?Q?551xUq7+pFD0ZV2LZhzEK/ZkQ+bIvBzTt4veD3SJHiSdIabF5W0c1Peutdkp?=
 =?us-ascii?Q?Wi2JftDMXKK3xVNSKReE9UvauygNT/USR9Ex6w0vSGFyhkkIBZIWwLxktMa1?=
 =?us-ascii?Q?1BxA5hIkURupTfQWfu+leZRNZml1y/9YJLydpSNoz1dDaIxgEDLsuCFy5nn3?=
 =?us-ascii?Q?Ja+U9pbORqFC2Bkati7nYLn/2EMPpmg4scx7vM2z0S3l/3DqAmuQouyYTgVF?=
 =?us-ascii?Q?ik4QnUlOrYVeg2uYYR+jfyTag0ZEhGgPOy+Q8LWH?=
X-OriginatorOrg: siewert.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f4a0e3a-db51-48a7-e32b-08ddaaa6ca50
X-MS-Exchange-CrossTenant-AuthSource: FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 18:19:09.6112 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e8b4abbe-444b-4835-b8fd-87ac97451a7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gh2hv6xBs/vp6z46jnp54b6XpmhF2ujKhaBJ2aONBpfea7NLCFOWhhjzbc1IQced
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB2865
Received-SPF: pass client-ip=2a01:111:f403:c20b::1;
 envelope-from=tan@siewert.io;
 helo=BEUP281CU002.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The AST2600 SCU has two protection key registers (0x00 and 0x10) that
both need to be unlocked. (Un-)locking 0x00 modifies both protection key
registers, while modifying 0x10 only modifies itself.

This commit updates the SCU write logic to reject writes unless both
protection key registers are unlocked, matching the behaviour of
real hardware.

Signed-off-by: Tan Siewert <tan@siewert.io>
---
V3:
  - Change logic to unlock both registers on 0x00 write, while writing
    to 0x10 only modifies itself. [Jamin]

 hw/misc/aspeed_scu.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index 4930e00fed..993cb800a8 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -91,6 +91,7 @@
 #define BMC_DEV_ID           TO_REG(0x1A4)
 
 #define AST2600_PROT_KEY          TO_REG(0x00)
+#define AST2600_PROT_KEY2         TO_REG(0x10)
 #define AST2600_SILICON_REV       TO_REG(0x04)
 #define AST2600_SILICON_REV2      TO_REG(0x14)
 #define AST2600_SYS_RST_CTRL      TO_REG(0x40)
@@ -722,6 +723,7 @@ static void aspeed_ast2600_scu_write(void *opaque, hwaddr offset,
     int reg = TO_REG(offset);
     /* Truncate here so bitwise operations below behave as expected */
     uint32_t data = data64;
+    bool unlocked = s->regs[AST2600_PROT_KEY] && s->regs[AST2600_PROT_KEY2];
 
     if (reg >= ASPEED_AST2600_SCU_NR_REGS) {
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -730,15 +732,25 @@ static void aspeed_ast2600_scu_write(void *opaque, hwaddr offset,
         return;
     }
 
-    if (reg > PROT_KEY && !s->regs[PROT_KEY]) {
+    if ((reg != AST2600_PROT_KEY || reg != AST2600_PROT_KEY2) && !unlocked) {
         qemu_log_mask(LOG_GUEST_ERROR, "%s: SCU is locked!\n", __func__);
+        return;
     }
 
     trace_aspeed_scu_write(offset, size, data);
 
     switch (reg) {
     case AST2600_PROT_KEY:
-        s->regs[reg] = (data == ASPEED_SCU_PROT_KEY) ? 1 : 0;
+        /*
+         * Writing a value to SCU000 will modify both protection
+         * registers to each protection register individually.
+         */
+        u32 value = (data == ASPEED_SCU_PROT_KEY) ? 1 : 0;
+        s->regs[AST2600_PROT_KEY] = value;
+        s->regs[AST2600_PROT_KEY2] = value;
+        return;
+    case AST2600_PROT_KEY2:
+        s->regs[AST2600_PROT_KEY2] = (data == ASPEED_SCU_PROT_KEY) ? 1 : 0;
         return;
     case AST2600_HW_STRAP1:
     case AST2600_HW_STRAP2:
-- 
2.49.0


