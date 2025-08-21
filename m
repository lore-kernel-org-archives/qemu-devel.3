Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA5C7CA0EEB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 14:13:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up628-0005Sh-4Y; Thu, 21 Aug 2025 10:12:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Edgar.Iglesias@amd.com>)
 id 1up620-0005KM-0Z; Thu, 21 Aug 2025 10:12:44 -0400
Received: from mail-bn8nam12on2060b.outbound.protection.outlook.com
 ([2a01:111:f403:2418::60b]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Edgar.Iglesias@amd.com>)
 id 1up61v-0004Jn-Jc; Thu, 21 Aug 2025 10:12:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LX8Js/95Hq3JYrMstD/l9PgXQyh7K7PM+v1kVaEUONGLS9m1VsyV721eUPbSZ1ADXqpZbTh0cYYMVUg5Kc49eh3fqyXsLaoZjp+lSCIen3kkGEQRZXTUBQq7ioHuT1iKAMxNl01ZZZGWqtrUMc9uvjw3fXEqMHsxk3M7cDi07+mK96KyZ2/z8MGAKOTRSxgjz/1MoGotjlBGbuR2VpX/rqmOLgxNGNkXc5EQnynZcK+ulFkJ71rm1sTv2jNAo7qwYzBC+IywsfVAWW2IMmFMtmit1G5Yv1qrREQ3y+Wg5sU8W/vXHnoEz3b3HFIDAq9zkJD2j8dMniuCuDAxPUZDEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cKEtuv7jLsp5Zid3j3xcDRo3tXmBOgjmTYJEeQ0PSVg=;
 b=Ezxj73pNC3DnI7hCk20UyF7d/0gs9wP7mH4yVqVKtqugoIoTx3i/EO4ejFvk3T4q7oAqMpTz1ToKBywAKzL0wOSoSjDNJ6dwv2WZ0MWd+ARkSHnKn/C7jB7i9t7sM3VjYGaEMln6YahXBETNVK9MqEQUQ4hyDKi10SGW4luyZ33tPI18PHx9oJM2pPFTviUFhW37VcfRADAFNikjw3qoshAy+zil2QL1y5Tp+ZwRKwev3yeCQNYTmthHt3YbjuP2iVvSTbDzEpus/KlVoIoOcY30R2PJ2OCQ3PunwRTMh0AfGEMuEOrd9zCOBxfo/8L0MkLiAjbdsSh3dIG7leGj2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKEtuv7jLsp5Zid3j3xcDRo3tXmBOgjmTYJEeQ0PSVg=;
 b=kUi7AfjpMQIjuoo9xss0mBd8qEySGUpGBLeNwwhYWaA/MRc1St5nsYrZPcHcUnlmoKuSc/Tds4Gdi9IltLZHm6MSHyIr/c5naZnbk+Iy0iCl6hQ2BDLws36NPfi4qbFvUtekvS/BDB1JgjZ9BrxgCLEuPukeeKcA5uLdckiDjeM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4090.namprd12.prod.outlook.com (2603:10b6:5:217::11)
 by SJ0PR12MB6854.namprd12.prod.outlook.com (2603:10b6:a03:47c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Thu, 21 Aug
 2025 14:12:30 +0000
Received: from DM6PR12MB4090.namprd12.prod.outlook.com
 ([fe80::671d:f94e:1c92:2f5d]) by DM6PR12MB4090.namprd12.prod.outlook.com
 ([fe80::671d:f94e:1c92:2f5d%3]) with mapi id 15.20.9052.014; Thu, 21 Aug 2025
 14:12:30 +0000
Date: Thu, 21 Aug 2025 16:12:27 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: Re: [PATCH v3 03/47] hw/arm/xlnx-versal: uart: refactor creation
Message-ID: <aKcpS4pHAZvGJXqH@zapote>
References: <20250821130354.125971-1-luc.michel@amd.com>
 <20250821130354.125971-4-luc.michel@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821130354.125971-4-luc.michel@amd.com>
User-Agent: Mutt/2.2.14+84 (2efcabc4) (2025-03-23)
X-ClientProxiedBy: MM0P280CA0063.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::27) To DM6PR12MB4090.namprd12.prod.outlook.com
 (2603:10b6:5:217::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4090:EE_|SJ0PR12MB6854:EE_
X-MS-Office365-Filtering-Correlation-Id: d510dcdd-3dd2-4d18-4d09-08dde0bcc3da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zuRNrEwUyRVu8P8tkg5xMroKFn2DWWYXRyTnasV4ZkRSi2eRRDAS2mJlxc0q?=
 =?us-ascii?Q?xUKoqQw12FG2xhjsceJboQEBx2Fo+6qGST3Ti7kClAUlUcdKlSrFtxXeiG1x?=
 =?us-ascii?Q?Ix5ISu5f7cc6/+1/xrGkmblnQByFdkX4YmKLuTni3DpoFwMECEcRB5G7jx0w?=
 =?us-ascii?Q?c6YEG/If8HRODJBR9yjffHvLcYNDzazrdr+qxyG5RGBkXYkpxzzEX2coOGnQ?=
 =?us-ascii?Q?G5Vp0R5jQoXR7iyd52rWDfQeR7d6prjuP3Y2zSc+7uzclGixSMDVZB3qpwEZ?=
 =?us-ascii?Q?sbuez8Xax3m0oOX9mlBg50hGhezaNDevvAD7o22eHBojRldgpW7/uMpryRf1?=
 =?us-ascii?Q?plU3EnktAGnJpeAyAokaHqPiKxZPaVX382iCg8yLT6SOBgSQx9b0bC3xQs5f?=
 =?us-ascii?Q?PVVskig6E4xPvFkLdIwomzLQAzmnkrBabKMWmekHZ7BjuQ56XpGdOTdkwWzt?=
 =?us-ascii?Q?wRtVpVhxheL2UU7hqf6z1AGIt6jydfSkBjgGxEIz8eYRbivoRutgQEEUr6w4?=
 =?us-ascii?Q?iItvq2pdXkMNMOSXl/gACaA8PW4HPvPQcJj7QPcFDxmqY4xsqjKWEE2BMzs/?=
 =?us-ascii?Q?IyhOfn3jcZDQzTbAMgCyuDUUINl96VwCo32DzzLVNxxFGKTo3AuGpiNu7CHi?=
 =?us-ascii?Q?WQGf4l19TFfO0mPOzOtLcjRPhHGYyzHWfqw9msD4mQe1KKwYAV05EWcXFnl2?=
 =?us-ascii?Q?VVNVHInj0xJFx/sneiPeHrs9QfdeJYJpQ8ZXkIXlYmQLE1KJ8sJk3+5JpB5y?=
 =?us-ascii?Q?EYQ+jwP3dg6dLXfg/vAOZXG3T1gcskiKT49Q90Uo3WL5o3mU7w0SRx0rU2lG?=
 =?us-ascii?Q?Sb6zvd/YkLRRZj7Ad0OLUpwC20dhX1hH/TvGISyD0VM/g/GW6t+2wiWx/fxS?=
 =?us-ascii?Q?chKVYTJo7Q46fZ7UwXD3+Hi8JfGYAgCP04+bFswvRwpAPOa0CUMngpCIkUN/?=
 =?us-ascii?Q?Ib1ZxXviqJXj98+37co/qdpZlsaZ/Rapz152CCVi8IQw0tMuGEiFKpktF6Ly?=
 =?us-ascii?Q?SbLEHgH5ePOltu1qhlptfT9CT/UbyWpeykWBwRW6ZU2+BwAyqieAfxW5ccFc?=
 =?us-ascii?Q?CZtsS2Y+x2WqjpqzGDp5jT7qvOO7+ll6DNp5h1ve+Q0+97xOTxSqztDA9RzX?=
 =?us-ascii?Q?MwVt1S3Rt5u558NPeVohM4USkCD/2J3KO/lBmo2QN92ccT1VRI9DP27Dz60A?=
 =?us-ascii?Q?mRR1rxsv68R9gcIlBN7cKcreUOJk98z+YWZKsXgjniSp1525Et1JqullrBeo?=
 =?us-ascii?Q?cPZHe+K/8tOnopBDtekIpnNk555eKLI6TIOx5q9/4bFlhAsvovQGLLQC8NMQ?=
 =?us-ascii?Q?KVt2Nvy2Qz/K2z+GWXvGHBONecd/d8UULcKF9mYBwbqyxvg16xFKFPPNrJSK?=
 =?us-ascii?Q?HC3FaKHcZXxO0mj1q3A2ZQOpCl3cEfOnKBm9HWuKPSHDj0wPYqqmwP2YiBqO?=
 =?us-ascii?Q?4GTSzBVL9uc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4090.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ks5xJHeqj1H5IX+LrjA0qJUtB7s3XDnqgvDN2GpxuyuOcTtFkxFJtiKU7VSw?=
 =?us-ascii?Q?Xk/MomPO1yE4XoaGVbqwEnw903PhJ+o6QlReAbgfjgMwS9LAeh4sOy/3AvMs?=
 =?us-ascii?Q?044W/05iKwm0nGBowF+V5bOGds+7cwIKqhLuUIjkYQ7bzNF7xRGjxQlF6+2Q?=
 =?us-ascii?Q?smIAgBsAKpf52HAEttgb8tg9o3dkzxudNjMcLIL0uOV6olYiKkrPEyeOzwlz?=
 =?us-ascii?Q?dMSm+tBY7Iy8xJkhzNPkYaFpNKQNHEPbAEJa6WcY4cBsu/ruTEXzo7HmVVv3?=
 =?us-ascii?Q?Tfq+Z8OAvd7dKgZat4Pk/9mzoZdVllo8H2aECl3dQhEzc/keN3fi9MfYGYAt?=
 =?us-ascii?Q?OKfirKViU9AKnU3ZcNeRF/LuUcqzApJuVKi3Jhl4va3M30usoILC3ViXZkuY?=
 =?us-ascii?Q?i40yIv2ncsufyS3Y/5XEWpSXBX4dTu5eAphn6A4ysn6xojOlf7LdL2sU2p/y?=
 =?us-ascii?Q?F0UoCdHEwTaW9CC/uvXljGRLlPB3Bv9wq4Vwkyf2N7jEPXDMOV+Hp/S15jIK?=
 =?us-ascii?Q?TMERrIjVLbztGKR430qR6o6lurh9oe3k/FaWaS9qDkyRwq7XjsNeRWeM1fpm?=
 =?us-ascii?Q?i5HLJRmPgh/jDhybeQU6dmepTcEsyUCPiZ5viTxu3AeYFvBqJVpaGePsJWDw?=
 =?us-ascii?Q?damOvjQV2lJ0kukm6xXDkEzNAtYXI8fkRPtLbLeO+taoG9NWWpuokvTEFuFj?=
 =?us-ascii?Q?Y9/LxTKTqOm7y77RhAjIxdmH/qUL5bEn3R3R7/1PxQOhhky0C4CfXie6b4ED?=
 =?us-ascii?Q?XpnIHQrQR27JDgoEjbL1sUGQe1TRxvDwqnXykbfAnnWwPr4lftlBh4fgDRb2?=
 =?us-ascii?Q?m4nBGm+C4nfcAspWp84LlijdC+7sN4+hElpbqUwk4P2EVFH4+gJLbsnOkTrJ?=
 =?us-ascii?Q?bpqfgxyFZWgE8rdzi5aEAbCGuHPWn+tLEbl3CAC2z4py9BjTncukezxps9cM?=
 =?us-ascii?Q?yhAokCmP9kSxpgojj76qJiql6m3uPkxdK8WxjYDrUFRLAADcFRbUQRs3vyY/?=
 =?us-ascii?Q?mF8hIw8jzVNFm444DvW3WRR0WyMrwCXlmzYVnKvKtedXvy4V017bLVcA2RWc?=
 =?us-ascii?Q?Ta0nWiqEaMj1JyKhC0QiguIcL/vwvW5MPe8T4RKn5GyB29FFfg//Vb8r1KQt?=
 =?us-ascii?Q?Yq9audzXfHM7ZiZQEK+pLJmhUpAgqKOa5Qdu/QyKmZxwDekGEaAGx6PZDqTX?=
 =?us-ascii?Q?6P7YtwGatEKayrI/mP/OhHWTM47Yjj41n0ZzCCfKXe5K39csChxF2oomqffS?=
 =?us-ascii?Q?Pv1DHDp+ULpOqQFX3CC/1njRlLKDFV1pyYwUYUfUG5+QkjjPPcD1M7+IrYJI?=
 =?us-ascii?Q?7VXu+e/qIfeSRAokl5iRDuxscZvR0ssu8NMsgy7fE8muey5S6Qihy6JY+/j2?=
 =?us-ascii?Q?glfUSOY0yTcmEf6j51ustryASHbpyyuUEiyHkfth3z8oSJIEjYbn1Q89ZCyq?=
 =?us-ascii?Q?fYM207A34+4zU+y1Gj6bGj683gTkAze8GWctY1z0UDF7KbdjErfj3/9wIFdO?=
 =?us-ascii?Q?zk2WWSbE4F9YZ/KvOWLEvqFaZtdVmOYzp7Fx1BApQOqyHn5/hI6jBT/omTUK?=
 =?us-ascii?Q?4NOLbBb4p0coDJ/1eB0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d510dcdd-3dd2-4d18-4d09-08dde0bcc3da
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4090.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 14:12:30.2209 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MZOe7s035vEhzTjQywgqcOIvEzB89DbxI3y7gmSCdyrouaA2q+w8KQXICPt2afro
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6854
Received-SPF: permerror client-ip=2a01:111:f403:2418::60b;
 envelope-from=Edgar.Iglesias@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
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

On Thu, Aug 21, 2025 at 03:03:02PM +0200, Luc Michel wrote:
> Refactor the UARTs creations. The VersalMap struct is now used to
> describe the SoC and its peripherals. For now it contains the two UARTs
> mapping information. The creation function now embeds the FDT creation
> logic as well. The devices are now created dynamically using qdev_new
> and (qdev|sysbus)_realize_and_unref.
> 
> This will allow to rely entirely on the VersalMap structure to create
> the SoC and allow easy addition of new SoCs of the same family (like
> versal2 coming with next commits).
> 
> Note that the connection to the CRL is removed for now and will be
> re-added by next commits.


Hi Luc,

I see the following on this patch:
Starting program: /home/edgar/src/c/qemu/patchew/build/qemu-system-aarch64 -M xlnx-versal-virt -m 2g -serial stdio -display none -net nic,model=cadence_gem,netdev=n0 -netdev user,id=n0 -kernel Image -device virtio-blk-device,drive=d0 -drive format=qcow2,if=none,file=rootfs.qcow2,id=d0 -append root=/dev/vda1\ console=ttyAMA0
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
[New Thread 0x7ffff5a4c640 (LWP 130095)]
[New Thread 0x7ffff4889640 (LWP 130096)]

Thread 1 "qemu-system-aar" received signal SIGSEGV, Segmentation fault.
arm_cpu_mp_affinity (cpu=cpu@entry=0x0) at ../qemu/target/arm/cpu.c:1446
1446        return cpu->mp_affinity;
(gdb) bt
#0  arm_cpu_mp_affinity (cpu=cpu@entry=0x0) at ../qemu/target/arm/cpu.c:1446
#1  0x0000555555d8517d in fdt_add_cpu_nodes (psci_conduit=1, s=0x7ffff4a7b010)
    at ../qemu/hw/arm/xlnx-versal-virt.c:114
#2  versal_virt_init (machine=0x7ffff4a7b010) at ../qemu/hw/arm/xlnx-versal-virt.c:682
#3  0x00005555559b766d in machine_run_board_init
    (machine=<optimized out>, mem_path=<optimized out>, errp=<optimized out>,
    errp@entry=0x555557602858 <error_fatal>) at ../qemu/hw/core/machine.c:1694
#4  0x0000555555bfda6c in qemu_init_board () at ../qemu/system/vl.c:2710
#5  qmp_x_exit_preconfig (errp=0x555557602858 <error_fatal>) at ../qemu/system/vl.c:2804
#6  0x0000555555c013de in qemu_init (argc=<optimized out>, argv=<optimized out>) at ../qemu/system/vl.c:3840
#7  0x000055555590253d in main (argc=<optimized out>, argv=<optimized out>) at ../qemu/system/main.c:71
(gdb)



> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>
> Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
> ---
>  include/hw/arm/xlnx-versal.h |   2 -
>  hw/arm/xlnx-versal-virt.c    |  36 +--------
>  hw/arm/xlnx-versal.c         | 142 ++++++++++++++++++++++++++++-------
>  3 files changed, 117 insertions(+), 63 deletions(-)
> 
> diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
> index f2a62b43552..b01ddeb1423 100644
> --- a/include/hw/arm/xlnx-versal.h
> +++ b/include/hw/arm/xlnx-versal.h
> @@ -16,11 +16,10 @@
>  #include "hw/sysbus.h"
>  #include "hw/cpu/cluster.h"
>  #include "hw/or-irq.h"
>  #include "hw/sd/sdhci.h"
>  #include "hw/intc/arm_gicv3.h"
> -#include "hw/char/pl011.h"
>  #include "hw/dma/xlnx-zdma.h"
>  #include "hw/net/cadence_gem.h"
>  #include "hw/rtc/xlnx-zynqmp-rtc.h"
>  #include "qom/object.h"
>  #include "hw/usb/xlnx-usb-subsystem.h"
> @@ -78,11 +77,10 @@ struct Versal {
>  
>      struct {
>          MemoryRegion mr_ocm;
>  
>          struct {
> -            PL011State uart[XLNX_VERSAL_NR_UARTS];
>              CadenceGEMState gem[XLNX_VERSAL_NR_GEMS];
>              OrIRQState gem_irq_orgate[XLNX_VERSAL_NR_GEMS];
>              XlnxZDMA adma[XLNX_VERSAL_NR_ADMAS];
>              VersalUsb2 usb;
>              CanBusState *canbus[XLNX_VERSAL_NR_CANFD];
> diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
> index 69f3bb401b9..06cc5bae8b0 100644
> --- a/hw/arm/xlnx-versal-virt.c
> +++ b/hw/arm/xlnx-versal-virt.c
> @@ -75,10 +75,11 @@ static void fdt_create(VersalVirt *s)
>  
>      s->phandle.usb = qemu_fdt_alloc_phandle(s->fdt);
>      s->phandle.dwc = qemu_fdt_alloc_phandle(s->fdt);
>      /* Create /chosen node for load_dtb.  */
>      qemu_fdt_add_subnode(s->fdt, "/chosen");
> +    qemu_fdt_add_subnode(s->fdt, "/aliases");
>  
>      /* Header */
>      qemu_fdt_setprop_cell(s->fdt, "/", "interrupt-parent", s->phandle.gic);
>      qemu_fdt_setprop_cell(s->fdt, "/", "#size-cells", 0x2);
>      qemu_fdt_setprop_cell(s->fdt, "/", "#address-cells", 0x2);
> @@ -206,44 +207,10 @@ static void fdt_add_usb_xhci_nodes(VersalVirt *s)
>      qemu_fdt_setprop_cell(s->fdt, name, "phandle", s->phandle.dwc);
>      qemu_fdt_setprop_string(s->fdt, name, "maximum-speed", "high-speed");
>      g_free(name);
>  }
>  
> -static void fdt_add_uart_nodes(VersalVirt *s)
> -{
> -    uint64_t addrs[] = { MM_UART1, MM_UART0 };
> -    unsigned int irqs[] = { VERSAL_UART1_IRQ_0, VERSAL_UART0_IRQ_0 };
> -    const char compat[] = "arm,pl011\0arm,sbsa-uart";
> -    const char clocknames[] = "uartclk\0apb_pclk";
> -    int i;
> -
> -    for (i = 0; i < ARRAY_SIZE(addrs); i++) {
> -        char *name = g_strdup_printf("/uart@%" PRIx64, addrs[i]);
> -        qemu_fdt_add_subnode(s->fdt, name);
> -        qemu_fdt_setprop_cell(s->fdt, name, "current-speed", 115200);
> -        qemu_fdt_setprop_cells(s->fdt, name, "clocks",
> -                               s->phandle.clk_125Mhz, s->phandle.clk_125Mhz);
> -        qemu_fdt_setprop(s->fdt, name, "clock-names",
> -                         clocknames, sizeof(clocknames));
> -
> -        qemu_fdt_setprop_cells(s->fdt, name, "interrupts",
> -                               GIC_FDT_IRQ_TYPE_SPI, irqs[i],
> -                               GIC_FDT_IRQ_FLAGS_LEVEL_HI);
> -        qemu_fdt_setprop_sized_cells(s->fdt, name, "reg",
> -                                     2, addrs[i], 2, 0x1000);
> -        qemu_fdt_setprop(s->fdt, name, "compatible",
> -                         compat, sizeof(compat));
> -        qemu_fdt_setprop(s->fdt, name, "u-boot,dm-pre-reloc", NULL, 0);
> -
> -        if (addrs[i] == MM_UART0) {
> -            /* Select UART0.  */
> -            qemu_fdt_setprop_string(s->fdt, "/chosen", "stdout-path", name);
> -        }
> -        g_free(name);
> -    }
> -}
> -
>  static void fdt_add_canfd_nodes(VersalVirt *s)
>  {
>      uint64_t addrs[] = { MM_CANFD1, MM_CANFD0 };
>      uint32_t size[] = { MM_CANFD1_SIZE, MM_CANFD0_SIZE };
>      unsigned int irqs[] = { VERSAL_CANFD1_IRQ_0, VERSAL_CANFD0_IRQ_0 };
> @@ -700,11 +667,10 @@ static void versal_virt_init(MachineState *machine)
>                               &error_abort);
>  
>      fdt_create(s);
>      versal_set_fdt(&s->soc, s->fdt);
>      fdt_add_gem_nodes(s);
> -    fdt_add_uart_nodes(s);
>      fdt_add_canfd_nodes(s);
>      fdt_add_gic_nodes(s);
>      fdt_add_timer_nodes(s);
>      fdt_add_zdma_nodes(s);
>      fdt_add_usb_xhci_nodes(s);
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index 7bb55751e5c..87468cbc291 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -24,18 +24,96 @@
>  #include "qemu/log.h"
>  #include "target/arm/cpu-qom.h"
>  #include "target/arm/gtimer.h"
>  #include "system/device_tree.h"
>  #include "hw/arm/fdt.h"
> +#include "hw/char/pl011.h"
>  
>  #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
>  #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
>  #define GEM_REVISION        0x40070106
>  
>  #define VERSAL_NUM_PMC_APB_IRQS 18
>  #define NUM_OSPI_IRQ_LINES 3
>  
> +typedef struct VersalSimplePeriphMap {
> +    uint64_t addr;
> +    int irq;
> +} VersalSimplePeriphMap;
> +
> +typedef struct VersalMap {
> +    VersalSimplePeriphMap uart[2];
> +    size_t num_uart;
> +} VersalMap;
> +
> +static const VersalMap VERSAL_MAP = {
> +    .uart[0] = { 0xff000000, 18 },
> +    .uart[1] = { 0xff010000, 19 },
> +    .num_uart = 2,
> +};
> +
> +static const VersalMap *VERSION_TO_MAP[] = {
> +    [VERSAL_VER_VERSAL] = &VERSAL_MAP,
> +};
> +
> +static inline VersalVersion versal_get_version(Versal *s)
> +{
> +    return XLNX_VERSAL_BASE_GET_CLASS(s)->version;
> +}
> +
> +static inline const VersalMap *versal_get_map(Versal *s)
> +{
> +    return VERSION_TO_MAP[versal_get_version(s)];
> +}
> +
> +
> +static qemu_irq versal_get_irq(Versal *s, int irq_idx)
> +{
> +    return qdev_get_gpio_in(DEVICE(&s->fpd.apu.gic), irq_idx);
> +}
> +
> +static void versal_sysbus_connect_irq(Versal *s, SysBusDevice *sbd,
> +                                      int sbd_idx, int irq_idx)
> +{
> +    qemu_irq irq = versal_get_irq(s, irq_idx);
> +
> +    if (irq == NULL) {
> +        return;
> +    }
> +
> +    sysbus_connect_irq(sbd, sbd_idx, irq);
> +}
> +
> +static inline char *versal_fdt_add_subnode(Versal *s, const char *path,
> +                                           uint64_t at, const char *compat,
> +                                           size_t compat_sz)
> +{
> +    char *p;
> +
> +    p = g_strdup_printf("%s@%" PRIx64, path, at);
> +    qemu_fdt_add_subnode(s->cfg.fdt, p);
> +
> +    if (!strncmp(compat, "memory", compat_sz)) {
> +        qemu_fdt_setprop(s->cfg.fdt, p, "device_type", compat, compat_sz);
> +    } else {
> +        qemu_fdt_setprop(s->cfg.fdt, p, "compatible", compat, compat_sz);
> +    }
> +
> +    return p;
> +}
> +
> +static inline char *versal_fdt_add_simple_subnode(Versal *s, const char *path,
> +                                                  uint64_t addr, uint64_t len,
> +                                                  const char *compat,
> +                                                  size_t compat_sz)
> +{
> +    char *p = versal_fdt_add_subnode(s, path, addr, compat, compat_sz);
> +
> +    qemu_fdt_setprop_sized_cells(s->cfg.fdt, p, "reg", 2, addr, 2, len);
> +    return p;
> +}
> +
>  static void versal_create_apu_cpus(Versal *s)
>  {
>      int i;
>  
>      object_initialize_child(OBJECT(s), "apu-cluster", &s->fpd.apu.cluster,
> @@ -165,32 +243,48 @@ static void versal_create_rpu_cpus(Versal *s)
>      }
>  
>      qdev_realize(DEVICE(&s->lpd.rpu.cluster), NULL, &error_fatal);
>  }
>  
> -static void versal_create_uarts(Versal *s, qemu_irq *pic)
> +static void versal_create_uart(Versal *s,
> +                               const VersalSimplePeriphMap *map,
> +                               int chardev_idx)
>  {
> -    int i;
> +    DeviceState *dev;
> +    MemoryRegion *mr;
> +    g_autofree char *node;
> +    g_autofree char *alias;
> +    const char compatible[] = "arm,pl011\0arm,sbsa-uart";
> +    const char clocknames[] = "uartclk\0apb_pclk";
>  
> -    for (i = 0; i < ARRAY_SIZE(s->lpd.iou.uart); i++) {
> -        static const int irqs[] = { VERSAL_UART0_IRQ_0, VERSAL_UART1_IRQ_0};
> -        static const uint64_t addrs[] = { MM_UART0, MM_UART1 };
> -        char *name = g_strdup_printf("uart%d", i);
> -        DeviceState *dev;
> -        MemoryRegion *mr;
> +    dev = qdev_new(TYPE_PL011);
> +    object_property_add_child(OBJECT(s), "uart[*]", OBJECT(dev));
> +    qdev_prop_set_chr(dev, "chardev", serial_hd(chardev_idx));
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>  
> -        object_initialize_child(OBJECT(s), name, &s->lpd.iou.uart[i],
> -                                TYPE_PL011);
> -        dev = DEVICE(&s->lpd.iou.uart[i]);
> -        qdev_prop_set_chr(dev, "chardev", serial_hd(i));
> -        sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
> +    mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
> +    memory_region_add_subregion(&s->mr_ps, map->addr, mr);
>  
> -        mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
> -        memory_region_add_subregion(&s->mr_ps, addrs[i], mr);
> +    versal_sysbus_connect_irq(s, SYS_BUS_DEVICE(dev), 0, map->irq);
>  
> -        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[irqs[i]]);
> -        g_free(name);
> +    node = versal_fdt_add_simple_subnode(s, "/uart", map->addr, 0x1000,
> +                                         compatible, sizeof(compatible));
> +    qemu_fdt_setprop_cell(s->cfg.fdt, node, "current-speed", 115200);
> +    qemu_fdt_setprop_cells(s->cfg.fdt, node, "clocks",
> +                           s->phandle.clk_125mhz, s->phandle.clk_125mhz);
> +    qemu_fdt_setprop(s->cfg.fdt, node, "clock-names", clocknames,
> +                     sizeof(clocknames));
> +    qemu_fdt_setprop_cells(s->cfg.fdt, node, "interrupts",
> +                           GIC_FDT_IRQ_TYPE_SPI, map->irq,
> +                           GIC_FDT_IRQ_FLAGS_LEVEL_HI);
> +    qemu_fdt_setprop(s->cfg.fdt, node, "u-boot,dm-pre-reloc", NULL, 0);
> +
> +    alias = g_strdup_printf("serial%d", chardev_idx);
> +    qemu_fdt_setprop_string(s->cfg.fdt, "/aliases", alias, node);
> +
> +    if (chardev_idx == 0) {
> +        qemu_fdt_setprop_string(s->cfg.fdt, "/chosen", "stdout-path", node);
>      }
>  }
>  
>  static void versal_create_canfds(Versal *s, qemu_irq *pic)
>  {
> @@ -781,18 +875,10 @@ static void versal_create_crl(Versal *s, qemu_irq *pic)
>          object_property_set_link(OBJECT(&s->lpd.crl),
>                                   name, OBJECT(&s->lpd.iou.adma[i]),
>                                   &error_abort);
>      }
>  
> -    for (i = 0; i < ARRAY_SIZE(s->lpd.iou.uart); i++) {
> -        g_autofree gchar *name = g_strdup_printf("uart[%d]", i);
> -
> -        object_property_set_link(OBJECT(&s->lpd.crl),
> -                                 name, OBJECT(&s->lpd.iou.uart[i]),
> -                                 &error_abort);
> -    }
> -
>      object_property_set_link(OBJECT(&s->lpd.crl),
>                               "usb", OBJECT(&s->lpd.iou.usb),
>                               &error_abort);
>  
>      sysbus_realize(sbd, &error_fatal);
> @@ -955,11 +1041,15 @@ static void versal_realize(DeviceState *dev, Error **errp)
>      s->phandle.clk_125mhz = fdt_add_clk_node(s, "/clk125", 125 * 1000 * 1000);
>  
>      versal_create_apu_cpus(s);
>      versal_create_apu_gic(s, pic);
>      versal_create_rpu_cpus(s);
> -    versal_create_uarts(s, pic);
> +
> +    for (i = 0; i < map->num_uart; i++) {
> +        versal_create_uart(s, &map->uart[i], i);
> +    }
> +
>      versal_create_canfds(s, pic);
>      versal_create_usbs(s, pic);
>      versal_create_gems(s, pic);
>      versal_create_admas(s, pic);
>      versal_create_sds(s, pic);
> -- 
> 2.50.1
> 

