Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 600DEC83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 20:35:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWhgJ-0002B7-2d; Tue, 01 Jul 2025 16:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <etanous@nvidia.com>)
 id 1uWhgF-0002A0-R4; Tue, 01 Jul 2025 16:34:15 -0400
Received: from mail-bn7nam10on20606.outbound.protection.outlook.com
 ([2a01:111:f403:2009::606]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <etanous@nvidia.com>)
 id 1uWhgE-0000h4-A6; Tue, 01 Jul 2025 16:34:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I6IXc8A5c14EweK3vJJEXSBC1WseSy2tQTdQaWUxO/zOY7jry742PhQ3l/JAwodhxVc0HArJmTbf63YlD26qVBWp2Ou/EcRjPEy6OeKZ9fVAQkvQPvYOImnaZgcqgt9yL9WWOjwQMbku/AXL74yb0rmLCPS9D0mV63OxSHyeweV0M4iEwSjDY/3y/jMHv5uvcKjM5Km46OeTL56uGtTYCIOw9yM3VeTbarQrNO8MN3LW3cMb7BdjmrcqSGJOiav+RPJeOFiHmXTbdIew2gdwbUj67lEcf7q8M6ksXHa0It5pE4sNQPdcyQq+KvNfm0dYVBiaWrKfiFfs6kUmTlOWZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rcH1E2ZK9pMDGZzdHyVZF+vURoJ31zRQbSlMRo/QOd8=;
 b=anQWo3VdCPGDatMoj66jqIM0eFagqjdWwcY2yk04ay+me35KDdBQKf4+Ol5aeRxpc+AfblYN0q0VYEZx2nBCGpoFCoJKrpgTF0RPtzitFtDUSV3YxoowuAFu53nlsDdD73rMKinKNW3zuitLC4kLNTF3g4iAVvNRle96sFsyAjAB0B+LaJrgFy6zJcOfuv2ruiIuWFc+8as2qG6TQHhqEDnbBZfmZIXmXHG7p23Lxwa/+/d1DLeqMf74YaTlCB5D3NfQftSuYCMR2qFNPMADes3UMBjAiMOE6Le0W3ZdDqUzDsNOAGZd195w38fJjIxptUHJu9lEYfiEfCcvTwgZAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rcH1E2ZK9pMDGZzdHyVZF+vURoJ31zRQbSlMRo/QOd8=;
 b=VVY5fN8FPx8D8XVko12jINYwjDuwxXbVm5s1lbQjQjoW1wY51yuLhed/KgGB1FrjTlpR3VWWQVOQ0l/+dSAc9uICJlI3XvAvwxyuBTT3xWx2i4ZrBrMlQKxTcCc9F1G6WV14ZC/Jpm1WTwVsF/nbXu7niGupmIyFJMtiHHd/bzkq+yg5nc1yejVmbeQ5ieTT2obkhX5R3QuvQzxU20nvsz3/zcKKZNhrnWDxXl/mzSzlE95jArKceHl5mFwMB2I0lhwM/s7awg+O39teQn7PtcdXM9oj70KtRpG5c0DHvDYVSiHzBtMSZE7YYr+Pkki7Suv0eO2TNV4g7aNNWNPSBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4277.namprd12.prod.outlook.com (2603:10b6:610:ae::23)
 by BN7PPF0FD1DEA27.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6c8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 1 Jul
 2025 20:34:05 +0000
Received: from CH2PR12MB4277.namprd12.prod.outlook.com
 ([fe80::8857:98e9:8b64:787]) by CH2PR12MB4277.namprd12.prod.outlook.com
 ([fe80::8857:98e9:8b64:787%4]) with mapi id 15.20.8880.021; Tue, 1 Jul 2025
 20:34:05 +0000
From: Ed Tanous <etanous@nvidia.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Troy Lee <leetroy@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>, qemu-arm@nongnu.org,
 Ed Tanous <etanous@nvidia.com>
Subject: [PATCH 2/4] hw/arm/aspeed: Add second SPI chip to Aspeed model
Date: Tue,  1 Jul 2025 13:33:58 -0700
Message-ID: <20250701203400.71677-3-etanous@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701203400.71677-1-etanous@nvidia.com>
References: <20250701203400.71677-1-etanous@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::27) To CH2PR12MB4277.namprd12.prod.outlook.com
 (2603:10b6:610:ae::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4277:EE_|BN7PPF0FD1DEA27:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a8c4239-20d5-4f7c-4544-08ddb8de9f86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CUbTSdqn//4cfyHmoXkENIxVQUAo9KsNOarnCj9QxADbltPV9U0cmLU8keNA?=
 =?us-ascii?Q?4qYPwlIqi7Q5ObwxQqGvFtad6SKGysjL9Z6PvbBr1p4683weBsr4L48noymj?=
 =?us-ascii?Q?8+GDYUL2LsofEdDkQFvf3qxWML3ixj2KN/pKbmycaZLNc8l9r53tqzozih9r?=
 =?us-ascii?Q?6d8xtXRPbrGX9//CGZ0v0Qrcg64ndR0GdZ/1MUo+CU3r2PIkNrodTqvNWpl5?=
 =?us-ascii?Q?5IldkNjmR+Dl+H2gve6UoUOztYebS6xs0MbNqoImVpcCyS/qm51G+zeRsD7z?=
 =?us-ascii?Q?9/NAQZUIngz+4mBmnG8RxVuY//Scc9fz2Supzbsn/YZM5qeHCmMrtqEj8kRg?=
 =?us-ascii?Q?M5zkJsYHBkw8hDYPkac04sA/A414pNDRrgyknVI9UhRedg2eQiFX/cWjqTe3?=
 =?us-ascii?Q?b/BdYipQdV0u8Zq8TGmI0gKK4nkY0+1bVbP449h2fXugP1jMBvdidV0i+6DZ?=
 =?us-ascii?Q?pfZVqx2bxieK+9QUA2aT+dWtm+KbqgeySSHt5HWNJWQLmonDXOm6LBIbGxhR?=
 =?us-ascii?Q?t7CEcKHYErjVtJdr8cgWplT4kHmQHTWq4iv00q1VgIRgvTNrgJRDw5e9A8fW?=
 =?us-ascii?Q?wKkxShecZvFVlepK0vmMA3LKZ5bgDEpxAtqFnifiP4xSjyd/IKxQSK5Agkix?=
 =?us-ascii?Q?cKbuoxUhvk9ntb2KiNxAo0Jevr3SCEiQFzv/yKZwhm03RYe3l1K5hQ1pUb8Y?=
 =?us-ascii?Q?EHKDi+erB5N0+l/LSJi6ZxznGgwPgdi1dE2JesaomhcJmuKCwE8EXYnqQ5Ue?=
 =?us-ascii?Q?OVWPq4T1vrbmt8s77xQhcwxJC58155+q4nLhX1u9Bpd1JVMXhyi6eWU5Pot3?=
 =?us-ascii?Q?s/WdtoeZE6kKJNVix+nvQrN5dFMsFyLXG3uPbWzA0tTI2f2q/LC+3MNw/4+y?=
 =?us-ascii?Q?eD2AoOhzNlfr1UsfaLus//bweqPW4RIprQTBYBPj8v8V7dpvcYAfujLmVhDF?=
 =?us-ascii?Q?+Vf9FV3Wf7QJ0IyXMmU4d8ywWfNfh/MBMiol/JJiVUMNyNxYBFtOJqUSe0R0?=
 =?us-ascii?Q?YErGHCn0jeMtG7jSXUwD2fGUgOBCNlwW1ssSmpIY6WBTejwRmZggy0j882z2?=
 =?us-ascii?Q?fPiBUxG7E+3zoq6LOWgohFwfxKrxjzzdUUIPZO5msWQHzeghdCJ9+Xaxt570?=
 =?us-ascii?Q?/xvM2FQrSsAhv5yK2HTQaSzmSFymXihWVd/sQZ+AUVHwfNA6ewga8xvfdkuE?=
 =?us-ascii?Q?Lq7zEwCgp5NnVfzxSmbKQI77/d3L+ROf6nojvl0a9lWRjQHtI2sxIYKFNbn+?=
 =?us-ascii?Q?ArBgdaUrzYfdgM72cJYz+qBAMYVBVLVYae22jipmINlEHGKKzTmGjbXHy48M?=
 =?us-ascii?Q?3puUybsG/h+M7zO09WliBTKK6jP28phhatGvg3lAxGooUETlaHJOzjRzaKCu?=
 =?us-ascii?Q?FxiRy2Ln5MYAIE8vWOVrGvMSnFwtQLGym9HryGFnh9RL8hJ25SlKrb8Ik3KS?=
 =?us-ascii?Q?SELfSloaEx0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4277.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3qjLufXUKZyDdvXmFrdYNRkX6e98TaZxwXgRbmIqrgZcXW6Q2RJoIc+h3qd9?=
 =?us-ascii?Q?dW1Q58WRAMmEdB8v3ibFXWSYRHdHF7LA3cFG7l5VtmgOxLS6B0r9tN0EUHjz?=
 =?us-ascii?Q?zerruLImShGnAaa9Lina/yscTxYDBtO5YCiN3lnQms8t/p8x1Rgfv51yD8gO?=
 =?us-ascii?Q?VTk76WroKTjv5wJ1aEXDu8Yb10OAnYpHSCpwKFIf8SH5Jhpzc4p5Rf9lzfLd?=
 =?us-ascii?Q?FOceU5CkYDpBm1D3ZMaM2lkQE5MZAIdFjy+HyHPAGfN3ctc8PPFQChQ4cDYj?=
 =?us-ascii?Q?frQYow9/70c/KeOdbrHK+07mIbuOXgd93Hmsqz2MOUzi3Hjd1jZcaCZi06as?=
 =?us-ascii?Q?4qU77zLFRNsIgYLkOmTYSXmebpkiy1TvJmLfB2ASqHaTVldONTTAbeyLzPb5?=
 =?us-ascii?Q?SzsoRNL1AeodMqfD8ekCzUa1SgJHh91/XN7qGZnpk/ByE2bR4RAO8wgYXH+j?=
 =?us-ascii?Q?wIhJ7hIF64Mj1RHAJVbKgY58NWuSZVcT86qX8W0NnjjThZASHkv+PLtFPNSI?=
 =?us-ascii?Q?IzPBBp8vmzHAi05eoD12hkCMdZwaJnagtNygARiSgWYQ4f2r5nM+HY2MF+4P?=
 =?us-ascii?Q?SeWACPuYBLGLd4tIS0u4UmbdVy3FG53sFeCII48bas0Yn4k9LKjLeEfZigg0?=
 =?us-ascii?Q?8oVdBLj5OWgfY/Bp8bqTL+ZlCBRmg9KM+3HVE/Qt8mXGUV36D3WrWIPeyFCP?=
 =?us-ascii?Q?udgs9G3EFU78qR1s9rpH0HDVLhmPPe2STl5JbTbf6Vgs7VH/YRAbzY3TXLZw?=
 =?us-ascii?Q?8c1Krcbs5VDmaUnnoopuoaqaWeJoE+dZ8jCWgGedgAGoHUEne06iTpJ60GKl?=
 =?us-ascii?Q?eYk7pSd6gARAQObnoY7Pjkb9f4YI2PxJOO5rz0eojot3nZyumLZPGxZXHwYJ?=
 =?us-ascii?Q?wV2xpPZr6/qLaIGrx/k98SVIXAcIOuJuN39jPUak8VUhW1Es8rw+dqX+Kewu?=
 =?us-ascii?Q?DAr3ak5YTj7VjkMIULBR7tbXQ+UjnnOEYOnUzN/iCNdYzX4M4HOQkpLvXzfX?=
 =?us-ascii?Q?S7nvQOFF1zGPlYaLIUVzfpI5ZBF0ciEGzHoZA7kCFAorNgDwLmlXmSGyZa4q?=
 =?us-ascii?Q?GNUXzZOaqkoIG7FcNmK/AVEA/4j6Ge8jPD5hB4qZLrq7obmn/tqBfNHRBPOI?=
 =?us-ascii?Q?GVrdtE5NsgLfuZbqALM57GklUgyXdX5nWWu0jYkB686Ml8AvUeirn8bd0e08?=
 =?us-ascii?Q?WtqQbCJkjQpPaZEDC23p9kV8QCjaLHWXLer2CNe2n1ELij4t3nZk99+JP9LS?=
 =?us-ascii?Q?vjS1kXl5k0KKMlqhQqxU6CnyU9whshDn3yddPswf8asEmA6eu0STV816YliU?=
 =?us-ascii?Q?otA7VXyAf7lYNRDoOUsthTCmcRKu8tPnWZHn/8cMsP0osZVqfXzd71mHUcnu?=
 =?us-ascii?Q?30g2+7TAMmaq35EX6C+5F7IFaCNLhL5zUNWeyz5FnihhUMT7P9XtcASrTBEr?=
 =?us-ascii?Q?eWVJEFzmzwQzIDgnTR5x13HmzCUy5Sps2mKva5k8bkL+SJJP+XH6aMFr38Ox?=
 =?us-ascii?Q?2AOPFQa4qvdtGhpM/gMOSna+npjzStwAocfqDtzkTqULOWyUTtHMJC8tBS2H?=
 =?us-ascii?Q?DseoCZt/dhxR0SEamdIlz0I8NfoJC8miAz2maQm0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a8c4239-20d5-4f7c-4544-08ddb8de9f86
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 20:34:05.6701 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DCCXUxTBiYVNV8H/Rk9gz1x9oN/vP0ueIl8gvATkt9fR4PVJvfsTmGKq35ixYIriB6GFvzXoeheCe+mpm5MVuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF0FD1DEA27
Received-SPF: permerror client-ip=2a01:111:f403:2009::606;
 envelope-from=etanous@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Aspeed2600 has two spi lanes;  Add a new struct that can mount the
second SPI.

Signed-off-by: Ed Tanous <etanous@nvidia.com>
---
 hw/arm/aspeed.c         | 2 ++
 include/hw/arm/aspeed.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index d0b333646e..3ef7f6c5b2 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -465,6 +465,8 @@ static void aspeed_machine_init(MachineState *machine)
         aspeed_board_init_flashes(&bmc->soc->spi[0],
                               bmc->spi_model ? bmc->spi_model : amc->spi_model,
                               1, amc->num_cs);
+        aspeed_board_init_flashes(&bmc->soc->spi[1],
+                                  amc->spi2_model, 1, amc->num_cs2);
     }
 
     if (machine->kernel_filename && sc->num_cpus > 1) {
diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
index 973277bea6..6c36455656 100644
--- a/include/hw/arm/aspeed.h
+++ b/include/hw/arm/aspeed.h
@@ -35,7 +35,9 @@ struct AspeedMachineClass {
     uint32_t hw_strap2;
     const char *fmc_model;
     const char *spi_model;
+    const char *spi2_model;
     uint32_t num_cs;
+    uint32_t num_cs2;
     uint32_t macs_mask;
     void (*i2c_init)(AspeedMachineState *bmc);
     uint32_t uart_default;
-- 
2.43.0


