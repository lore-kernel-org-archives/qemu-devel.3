Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 327C0C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 15:49:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjIuB-0005NW-GG; Mon, 13 Jul 2026 11:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wjIuA-0005NI-De; Mon, 13 Jul 2026 11:49:14 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wjIu8-00036w-SJ; Mon, 13 Jul 2026 11:49:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RZnIG7bYM8x0jLTjVx8TN8gedNE7P+dCvrlwaBiSIk9bdwvuSilEQ+m2bM4FIaI07PbXqMekBOUuJqgrSaclVU3Cn0Zl3SRLvjafQEDduJvtiguH0HbLedk9MG7LnPRXCYgrRaGBT8nDrspW73dTdCvKlqoMpDjk964xpfCztf6yzg2alTwVCtngQUlmIYXYpmjtGw35ezO62dJgmlQYCePVV9C+0hn1RoY9DVfo8DkPnq+RKe7RNvxcloVgOYLszA+laP+oyxZ7xtYxYUCPdBz0YvL0ki0z3KVTEKw3eVdMBDhOeqD7CLJD0b/Al2Kf3wQUqddcv3wdX0IgQP69Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=STswuIPX2BTcNisG8hlPpRBKI9UID2jYHx74Y14bY7A=;
 b=K8HF4DInEpPJGRNLP3/7eBX+HkbVcaMGNDKaDsXS5IDx0B7dZxITg82eEppT9t3LrKHQROKeS/YpzP/FDIeGBMYTevhnapdNhpH4uORcWLfMKlls9H+hDkHkf7sA4LljQojLEsLNbTFJm1aOM5YoxuAbMFmmVNTnGeu9vbPOQDNJgXQ2Y0A7iGi6TNEtAizXQbtXswVxU86OtfmcYVHcMTPmJ4q2x81UIcqm8DmjyB6CQBZWZH2YxENustUyGojeDEaxn9xlTAYGvadrJsebiqHNW6asaZCYQi3jggnpdtoZ9U8pagisB2e9kP66ofzZX6uGmMeFVGxZHRI6FYPIfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=STswuIPX2BTcNisG8hlPpRBKI9UID2jYHx74Y14bY7A=;
 b=moCZVT9LoPP7qire/xkpUT0V2les9B2+K2oAc8cdruiK97pZQnDD1DWONI1yRzVXgIs5SDkrQGT/4bqFH19hYrBATAwVKur76FNcLA6dxzguxt/KaPR3GQRyPa7R5zZmngCXHHrL+1OEYt+wNubtEw4rkMOnKrlnqDK14K07xnDnldsNarbkiA3KbUliWRKfRFGfR3fxVaFWrajj5ZFene7YJ/pdhrRh3VCXkqZ6z+kvskZycLLOW0nokudS08frYOXihNP41WNdwk6pCuy/WiRlQfZHZCe2tWy9EuGibsFk5sO4f1rv+EPuyxtO+kwsSmrOW+I7cxoci9fz7JhP1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by TY0PR02MB6839.apcprd02.prod.outlook.com (2603:1096:405:10::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.19; Mon, 13 Jul
 2026 15:49:03 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0181.014; Mon, 13 Jul 2026
 15:49:03 +0000
Date: Mon, 13 Jul 2026 23:48:57 +0800
From: Chao Liu <chao.liu@processmission.com>
To: Bin Meng <bin.meng@processmission.com>
Cc: QEMU <qemu-devel@nongnu.org>, Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org
Subject: Re: [PATCH] tests/functional/riscv64: sifive_u: Fix kernel command
 line
Message-ID: <alUI0-8uDmNVSXGw@ChaodeMacBook-Pro.local>
References: <20260713120245.781959-1-bin.meng@processmission.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713120245.781959-1-bin.meng@processmission.com>
X-ClientProxiedBy: PH0P220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::33) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|TY0PR02MB6839:EE_
X-MS-Office365-Filtering-Correlation-Id: 85bc40de-ec92-4745-4d20-08dee0f64360
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|34096008|1800799024|22082099003|18002099003|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: 2F2Vgqd+z2uh8l+yBKHzEIZkpgawzMKYHf7z94nB8Mbi7Ztsihp7ugcyBIeTq9MbrAd0HKqFieAxG2TV89PZKKTxbhNSHQ9JWgSCeqCqYDi1tQAEaKccJKu5ibIikSE83/DdMkecwckMutiDVs6x5r1M+xqQZEMdwCrkeDqc+ziMwgFwD6/mvA5FmiFeLWFWLZbHwWKFS8UYIT58CI3NSoWYAKT/nnElrYCKpV12uiHY+74j7klmuwJqC6Y3TbfMhWXhN60A3L+gF3rM7BClbiVJL1azlRrcgP3WTci6dvUitZe5fa64JgX90NBb1jGry5bpFDvpxBJVaYyPmYE6P7hgvDojlLNaV1D7kiK6AGVpsk0D4Ur119J+Qqe5PvDKiVNocR4FNItkNpT46uIrl9d2JS7uhyoK4rIdMa6WqfBsGc0YQMWaIwTPXQi2XXXfSRUaFxa18hSzePnJOAqv0wAR0DOzkv28hjcI8h2WYbI1cojG0ZyuU6eHL4d+1S/ItoNdeJPG007NWSHmJ5jSR0/vG5tyChTbcqSFy5kqkrOYvnnwGktmFiDINXjT8y8BEqyG33FQ04m/7V4Zt4W6FQidd2aAyJTsmcEDXZWlpBvfGjDR2o4Pqpdv38lbkgtwXwK3iQz0H7/ngZr7z+7Kq+1eWSq84efsl0yJtgsTrbA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(34096008)(1800799024)(22082099003)(18002099003)(5023799004)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KZbWns4chraM7sxpdKgHfj6JkaBWg08pk5I7lMI4tovIaSjA9kp0ChpWCoDC?=
 =?us-ascii?Q?QNA5Gz2AoA5eq+Y9s8Z25Wr5tFfMqEF2zkYXX2AebfRnTtckJYm5IF9IqohA?=
 =?us-ascii?Q?iXRVaEm8z1So3/1aQxZTRSM7FxtwUOBE/M//T8QJdN/cYGzGKmzOespz5d4J?=
 =?us-ascii?Q?8EEnLc1/SSEwguSIvwsxYrTXsaJy7u6qkf8VQ6tHZDeGa8wXJ115Si0/+kwc?=
 =?us-ascii?Q?O6FyeEU2uq6vl/+RJEFnwZ9lqZg7dyMTTxYzDOxmsVy+mlQkjLffuGu8S65K?=
 =?us-ascii?Q?5UXv4SFQb+F5NTcyMrLWu5OJD76h8PXOy5hVtm2pdIH2JNwPv15G2Qy05xDc?=
 =?us-ascii?Q?QpnEJsKw0O+W/lyVL3t6cf0FBilXmTpnBZZSYGXufKmvyBb3P+qwG/3nQ0/3?=
 =?us-ascii?Q?V2/SI6CjiC27nSC7gxlkbpxSLsSPZ68rpupVGoXD3jcGm+tdfLXxa5YjIfPo?=
 =?us-ascii?Q?N/j1HjcDHEvjSY0YvJ4oPojhIpb/Vt71P1q6HBfLmft5uCgqEdiIYUDFQjSk?=
 =?us-ascii?Q?n7q4rfZ/aRCNjTyBNaowa/d5OdDLX7ywAuK0s1IXma4hdPruUHtuwI2QHkZp?=
 =?us-ascii?Q?Ib3V+KnqMWjt8hyiYU9k2+r0jlmX1ouo5XdlFyqSaO5v2zaBll5pKCcCs4PZ?=
 =?us-ascii?Q?6dparXhCG9pFPdoK37XM5fVZuebISKw4lqngrOXwqzwui2FsmT6sBn3mqixB?=
 =?us-ascii?Q?KaFSxFlUf7uxn6iIuSgGPj/3Jo31vHmgCLWoyiOhBrRm2v1f7CVEOrVs3hub?=
 =?us-ascii?Q?OqOi6fd4VD+IRvvmtvDNBQDJZJTK+qTt9aj8unXmGzRjJAfep1RihDyzfGnN?=
 =?us-ascii?Q?0ggW6W2XyjUVGO0Sp/CV6YE8F8Y385MVMkfp/WL6GWG7gqNZG1TzJPGwHU8U?=
 =?us-ascii?Q?5PYDnjuHjnypTGyO0le9LLPIzS1m+DWxjcaxzZpskhmu3A9TOXgSJQo7ZQ4j?=
 =?us-ascii?Q?kJtLh/Y1TsVp3l4471+S2UZIbGcZejYRDvGXhnXZVyH0QMLFvJ2D+FoKVRUX?=
 =?us-ascii?Q?zbNjB7x+jXcngG2gM+G7yZ4EfxG7PK91cP7wclecVCs2w15iMCpyeBK401NI?=
 =?us-ascii?Q?EqHEB50wurbktfzsXk6YddseTk6BkM0pFkhTZR7YrQPiKKibu0JvnBanSfTd?=
 =?us-ascii?Q?LkoLUITndsPXhhglTv6pAT6gW99/0TG6Pfmf3+6QzCWJoVJcAwG2twCNZNdR?=
 =?us-ascii?Q?aJN+Z74a3YzNe1r8uqUj82wsvrpLseOHSXw7s/ESx3Xd45mxEzJ8WV+9auGF?=
 =?us-ascii?Q?Wx3VbWUpe8wklpKfZFd2vVdCr14z5vSCePT15J45RlqzE0Yj4vyXp7gZdRqH?=
 =?us-ascii?Q?QnzawdqtJDdp1W7QNBSQvU0ksfHe9noUerf+Ipl4GXBKLizMvdYuTn8K908n?=
 =?us-ascii?Q?cgCuFVjWdZtzcUPtFCpKOrp3UL406ID/3xDpU/2MFx0a9YgRhHulrzOkLdId?=
 =?us-ascii?Q?dcBs4Aw+s/IdWFmnXsYPCLI/51g2SNOp8fNv2kn3onXugr4lvyW+limDz9RE?=
 =?us-ascii?Q?T5mwNsc/SOJCbvpe9n1yXLX8OaKcfQ2IvfZa0FGwSZmT9LDN3i4o0UXiniPH?=
 =?us-ascii?Q?NPDWoL64WtI6do0JVTOZ2YskCwsoQYyFnhkJjvX/eL7xwNZJKNkv6oLQL8jU?=
 =?us-ascii?Q?Tnx9Bzg1xW5nkTN9qaJkbNrNEP3zxxDOnMiA+sYWgpXTgovP1S4RLS6/F/8h?=
 =?us-ascii?Q?nPfND3Q6BpfMAPfuJWykebYujBeORxWHTbY+IIMVRAlK5yfec6yb5ypN5lOD?=
 =?us-ascii?Q?Xs4vz5hIuSFMHVgoTCMJU62ztkpRZV8=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85bc40de-ec92-4745-4d20-08dee0f64360
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 15:49:03.1726 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Y/Wg+0lreoj8Uv3NTPa9mcndxh7W2n99zg+sUMAbZFRy4FXqW9SuonMz8Qwvd3MCoyZ0nOl4V0OnKDpSXX7/3e4Z+vAJEX6DX2I6D5c2lE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR02MB6839
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=chao.liu@processmission.com;
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

On Mon, Jul 13, 2026 at 08:02:44PM +0800, Bin Meng wrote:
> Build the complete kernel command line before adding it to the QEMU
> arguments. This ensures the panic, noreboot and rootwait options are
> passed to the guest.
> 
> Fixes: 7db162fa0138 ("tests/functional: Test SPI-SD adapter without SD card connected")
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks
Chao

> 
> ---
> 
>  tests/functional/riscv64/test_sifive_u.py | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/functional/riscv64/test_sifive_u.py b/tests/functional/riscv64/test_sifive_u.py
> index 847f709da1..54a0f9c648 100755
> --- a/tests/functional/riscv64/test_sifive_u.py
> +++ b/tests/functional/riscv64/test_sifive_u.py
> @@ -35,9 +35,6 @@ def do_test_riscv64_sifive_u_mmc_spi(self, connect_card):
>          kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
>                                 'earlycon=sbi console=ttySIF0 '
>                                 'root=/dev/mmcblk0 ')
> -        self.vm.add_args('-kernel', kernel_path,
> -                         '-append', kernel_command_line,
> -                         '-no-reboot')
>          if connect_card:
>              kernel_command_line += 'panic=-1 noreboot rootwait '
>              self.vm.add_args('-drive', f'file={rootfs_path},if=sd,format=raw')
> @@ -46,6 +43,9 @@ def do_test_riscv64_sifive_u_mmc_spi(self, connect_card):
>              kernel_command_line += 'panic=0 noreboot '
>              pattern = 'Cannot open root device "mmcblk0" or unknown-block(0,0)'
>  
> +        self.vm.add_args('-kernel', kernel_path,
> +                         '-append', kernel_command_line,
> +                         '-no-reboot')
>          self.vm.launch()
>          self.wait_for_console_pattern(pattern)
>  
> ---
> base-commit: a759542a2c62f0fd3b65f5a66ad9868201014669
> branch: sifive_u
> 
> -- 
> 2.53.0
> 

