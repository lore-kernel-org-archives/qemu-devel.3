Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 382C7C54EFC
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 05:35:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woDzI-0008OY-Hl; Mon, 27 Jul 2026 01:34:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1woDyf-0008GD-7v; Mon, 27 Jul 2026 01:34:45 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1woDyd-0002w7-FF; Mon, 27 Jul 2026 01:34:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gN87LZgiqehIHt4RkH9wxl10moU9z4ciI1usPvGDkurxzei2vRYqq5CKDPZv2efGgHuH16DppPz/iQDFUrhyGUvhvSAUWJl+twluKpgTfG5bDPARMWImNSlZAQ1YAXntFVYqQevrrfibuqVad2A7ZqNSx5Dlrb/JTa69H4+kCr0sbqFz2VL+n014I41Wf76OnuPEPVc+Cb3+6u30NGgRk+nUg0QlRQ0qjbPxpJkiQgadYHdB10z4b+nNFdCUW4v+fvkiGOHGHaNETnJlCRRTQZZh0M4wLVC/RioeXVd5SD8H9C6yRjM8UnwObs9pZj1ULsO/ItqzLzzYbB5YzHQKiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SKNDjsCpTxy2lxvGVytDUKU224gEsxazeI2mKpxaKNU=;
 b=bUpns4B4VZA/MHZvFbzNRZXou5+SozftCdxz8NDttAuI9e1x498CoK8jmCtQr0d8LCIKLPi/S6O3zPOzLFPy+oDeRYmfH5WmBqyadl7pBwpTCUi0VOu220/n+qWT8FBHzG/G73tR36e87KgBQsZQgM+du2Jz70rFtRkxeMLeiTKqGjrB4d9B4D8lJdIxPmZzSipXpVpbZSKzlvQU8eq3K0Dkmv3543DIgKniMmtX+/hbOBppnbLokmEqb30xX64iWy8Izt7PUz40kWGkKnJbntTPuDB/WfgiVw3J9TDClTEZqJPb4m9mauLrHgTCsd/qOhYl85CpawDa/MltyZUObQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKNDjsCpTxy2lxvGVytDUKU224gEsxazeI2mKpxaKNU=;
 b=vKqluWQl0mpTBqWCeV+6O/39IE8jNxJ8duP0E/rxhClmROXYkERj+aBfTjUhPGMJlw//eWM2/su7yDOy/kWujAaBHIga3KV5fyysdMkVjVITJu6tKMbFsVUIdMmrhD2o0btQKoc3kS2TD/GR3zjNiXUj3/kuzLfVi3gCF5ewC7Mdll8hLo/LiDvrVG+V/1TM/ktXW/pQYFQqW5oDYEenAiXUcBl9lYwDy5rCo4YBPHVtliHMjDjFYL5ZN3U05BSeQj/ZlSov3S890oXaxxUfT/stkUKHDkfhZFMaqzeoA4v+JryaIGIQ6hQJiG/KlPBAUUYdyNQwo2OBVIHzr/3Jjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by SG2PR02MB6022.apcprd02.prod.outlook.com (2603:1096:4:1dc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 05:34:05 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 05:34:05 +0000
Date: Mon, 27 Jul 2026 13:33:58 +0800
From: Chao Liu <chao.liu@processmission.com>
To: Bin Meng <bin.meng@processmission.com>
Cc: QEMU <qemu-devel@nongnu.org>, 
 Alistair Francis <alistair.francis@wdc.com>, Conor Dooley <conor@kernel.org>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org
Subject: Re: [PATCH 21/26] hw/riscv: pfsoc: Fix Icicle Kit RAM size at 2 GiB
Message-ID: <ambtvQUfNDmzUTDT@ChaodeMacBook-Pro.local>
References: <20260723151853.2143177-1-bin.meng@processmission.com>
 <20260723151853.2143177-22-bin.meng@processmission.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723151853.2143177-22-bin.meng@processmission.com>
X-ClientProxiedBy: BLAPR05CA0031.namprd05.prod.outlook.com
 (2603:10b6:208:335::12) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|SG2PR02MB6022:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b5e24b6-01b8-4e11-ec8a-08deeba0ac3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34096008|7416014|376014|366016|23010399003|1800799024|6133799003|18002099003|22082099003|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: AGYk73/VvEYnHQFdoSBcOQMMm+iKvus+Ex6K4VQzu5LU6VCaN5u3UmXyC2Tp5BtwYRf9CyDxmDVpOvHLTgji3wQexwCRimWuTSccSrACs2a5mRwefE9Y1rh7exFWJ9aBHBiRDCiTE826e0xcIP/IP1Kl1kE7Pe52qYGkerI29cWWErLOg4Vq4PC/PH8ASAfyrk9WV0wx9h++4s1kC7EeoGissmuocnmTNFWp0vWP6WAhQlpUb1Ww/RMOdj8tOOHs1Qg5I/8kWS3T3ycQn+Gw2956ZstF6bgGP3AbOqiU93pjZgdQA1dp+Ae4BXkYeZ3r7fZF5j5hU52kQkEv+4XVvGiGdVQoT4xSS/xUeSSEd0XS5flPFgrrfppRm3u6x+byM+W9Vunq6w9si9IBR9rzCm3Z3hiByWG2rXyekuy+fe6c5xOXlzWNExo5r/0Q9AgCH01eycCyYfRHzCGGGTuytPe+vtSpXiSy2t8ZSn56VMuXPKexk2fhv/RltxLjTii5bfhVkiUXp7wX5OxI/TUhU1I2n0fcsgbWTqPW8UggjlwWC/OWu5pp5VnOitTMOh58rc/Z00Dfp2E24hqKk7R9QeDYwtZ/NUhQt1wSVNPBFBprQOFafjWt4N9O6PaNYu11XSAoZr7o/LJIHbgeCPt9SYfAphBQ1DpXfnkuhRcAt2Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(34096008)(7416014)(376014)(366016)(23010399003)(1800799024)(6133799003)(18002099003)(22082099003)(56012099006)(4143699003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k/DIx+4XuzmSLfgcYkLZ//5kcxH9lku4AA38gB5B48OwVe35jkLpRv8ahtSW?=
 =?us-ascii?Q?fVjcFNidaaQSIHfJA2pYrUq2/4A+gnpFugE5EnP9CGMMAbv03tUzq4KsS7nX?=
 =?us-ascii?Q?4/3TyQ9qqOgV7RbQygSL3PpoJuc/xRls1EQRzYhKx7rCDxlWPlZvH74zbWFf?=
 =?us-ascii?Q?skV7CSOFI3p8NzfcPK31eGxgOp+U7oNjwOfN9K2t3uNNY7nZaHVdDoFKjJ5U?=
 =?us-ascii?Q?I26nez4ytKEF/8xFxCCLlNvbmrpzDvUYtmvwFaaabnZLmD5AlqdVZnlSTNfq?=
 =?us-ascii?Q?n+nx32H0n/zD1owMaxijhmDz5i32B5Ve10TysGNuwbjhw+niY3iJq0AI9crm?=
 =?us-ascii?Q?L+SMQI6UU4iR1C6V89O7knDPZAUArbomlxDQf6cyDJGYvJmzKCCxnJN9PmpS?=
 =?us-ascii?Q?mR0eG9Kzo4s62MqTKfAGcFfrfkq+9O4Zn47U0IC3Bih7P3dqHVhoFMqcOGNt?=
 =?us-ascii?Q?WozI3QUlauOWzHriTo+Rf/Toe34NrRsT9QqhuhRJfcr+HVZb8cy5xubFn3Gi?=
 =?us-ascii?Q?gBDKoJUPJrvY82hi2V31cZDFjgcPLH5wt5GA5QKlPh8W6eo7W5hkWGP+1yyB?=
 =?us-ascii?Q?gfWDAXHOC5iKSWBJRIKBScuOaiDuHXR4+1LWJXfJXqdQVgA28Kpgy2LKRNsA?=
 =?us-ascii?Q?b8V3z0cZNE41uO2TgJ9CwdWc22sY7eeOUoBHLmfNEV10tJ9LAEe3wqtEvT0s?=
 =?us-ascii?Q?DTFOj67Vmvy7JbW/bHE5jbCoAFfWZJHh/BRnoeCmkCr/SV+3vjVEUjL+d6ZK?=
 =?us-ascii?Q?Fv5M5GpSXJcUAdSShrRGCJC/7n8wdSF4xS9j6/yHe4y4Konk9pzoVw1ZPRgj?=
 =?us-ascii?Q?5AiV6Mdj7BquoE3Q+ldfHb1yoyW5vWTyJGrKHl5iyBXUFKoLFA3ZWo74h0og?=
 =?us-ascii?Q?+i7ZSltuIjz9LzuxVE9vBWNQh85Tqce3+0lqVjSUBRkmrVR2B4Lrq1YcoFH1?=
 =?us-ascii?Q?6NfgjfyO3Tuen1Oxwd4dzd7lhmngBHr9z+dlY2OXDjQ2O7my+z2m5dVoWIPh?=
 =?us-ascii?Q?/NzN0S8nPeE2G9xBvA57zMXwWnr0ccgGoYX5ES+3rQax3wjZIBSD0HSEkA6Z?=
 =?us-ascii?Q?RoOnLiFWAnuFtbSq7iatYqvvChpIihe3vucupTH6Dy89kdgT2wzIT5yD58HR?=
 =?us-ascii?Q?QndduPl9MH8p9doHWmfKTy3cIv1wrYULH0E8s4SDdRW7j3G5Q2mnq1X0ViqG?=
 =?us-ascii?Q?em77PncP3cI8Yfyf7rTy0A7ifVqIaze+brbx8ExCTnugulrREccCQghEnWOJ?=
 =?us-ascii?Q?YPRRB8Ewd9GYEev3TvLDqdcex54vcXKcDTAoo4W84n8INTKrsJRqlULNfeeh?=
 =?us-ascii?Q?2sbjDWKZXXXi0NPhQBReiIBq9NEezeT386RygIzEnGJW3C1SdKWPMEZc4+cz?=
 =?us-ascii?Q?4Q7JObCxeBrWEEdPyezLQnFISasH30SVCK1JLvO245/k4jrqNvfsJMeffM+G?=
 =?us-ascii?Q?qGEFp9XvpnuKqFJjcXQdfKiJyUbuZoAKzgWdwpOIig5qZXyQzfxN3gPv7/KK?=
 =?us-ascii?Q?SZwpT0lHj+Mw85NEBY68KAeF6zBOrsF//jJEcFANgu93DCQODNo4C/dCepUg?=
 =?us-ascii?Q?JH/bDpN6P8EyrITxX5XzXSUVf7HQxlfRuJxNdVPauD8UMo5bpDSOWwnahkvE?=
 =?us-ascii?Q?ZO/4CFXeV1M1OZMyhmaUg3dfq3h+Led9IPU4MZ/6we/EdLWuVH3UiSBAPEVE?=
 =?us-ascii?Q?JLslbuXil4K4ABKJGok+TdE0yeznhGOOQM1V//OZV15AQK6yUjjzWvpatlLf?=
 =?us-ascii?Q?piD0JmpYw124KNnK7OBFtJFeJxnqLiM=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b5e24b6-01b8-4e11-ec8a-08deeba0ac3b
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 05:34:05.2163 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1hq37xknEeUR2NYV/tyXHQSWSIyxBJQztB0idpVLNfqNsIA2j56CEc88o18BDVHKg2ddW3DAAjf9p6iej3Su2IQBciDEnm8vfX9HODlFF9w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB6022
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=chao.liu@processmission.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On Thu, Jul 23, 2026 at 11:18:48PM +0800, Bin Meng wrote:
> The Icicle Kit has 2 GiB of RAM, and its firmware device tree
> describes that fixed capacity. The model currently defaults to
> 1537 MiB and accepts any larger size, allowing configurations
> that do not match the board.
> 
> Set the default to 2 GiB and reject every other size. Update the
> documentation and L2CC qtest command line accordingly.
> 
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
> 
>  docs/system/riscv/microchip-icicle-kit.rst |  4 +---
>  hw/riscv/microchip_pfsoc.c                 | 15 ++++-----------
>  2 files changed, 5 insertions(+), 14 deletions(-)
> 
> diff --git a/docs/system/riscv/microchip-icicle-kit.rst b/docs/system/riscv/microchip-icicle-kit.rst
> index 9809e94b84..3db2b3c7e3 100644
> --- a/docs/system/riscv/microchip-icicle-kit.rst
> +++ b/docs/system/riscv/microchip-icicle-kit.rst
> @@ -26,9 +26,7 @@ The ``microchip-icicle-kit`` machine supports the following devices:
>  * 2 GEM Ethernet controllers
>  * 1 SDHC storage controller
>  
> -The memory is set to 1537 MiB by default.  A sanity check on RAM size is
> -performed in the machine init routine to prompt user to increase the RAM size
> -to > 1537 MiB when less than 1537 MiB RAM is detected.
> +The machine has a fixed 2 GiB of RAM. Other memory sizes are rejected.
>  
>  Boot options
>  ------------
> diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> index a2fbc89222..b604f7008b 100644
> --- a/hw/riscv/microchip_pfsoc.c
> +++ b/hw/riscv/microchip_pfsoc.c
> @@ -557,10 +557,10 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
>      DriveInfo *dinfo = drive_get(IF_SD, 0, 0);
>      RISCVBootInfo boot_info;
>  
> -    /* Sanity check on RAM size */
> -    if (machine->ram_size < mc->default_ram_size) {
> +    /* The board has a fixed RAM size */
> +    if (machine->ram_size != mc->default_ram_size) {
>          char *sz = size_to_str(mc->default_ram_size);
> -        error_report("Invalid RAM size, should be bigger than %s", sz);
> +        error_report("Invalid RAM size, should be %s", sz);
>          g_free(sz);
>          exit(EXIT_FAILURE);
>      }
> @@ -770,14 +770,7 @@ static void microchip_icicle_kit_machine_class_init(ObjectClass *oc,
>      mc->default_ram_id = "microchip.icicle.kit.ram";
>      mc->auto_create_sdcard = true;
>  
> -    /*
> -     * Map 513 MiB high memory, the minimum required high memory size, because
> -     * HSS will do memory test against the high memory address range regardless
> -     * of physical memory installed.
> -     *
> -     * See memory_tests() in mss_ddr.c in the HSS source code.
> -     */
> -    mc->default_ram_size = 1537 * MiB;
> +    mc->default_ram_size = 2 * GiB;
>  
>      object_class_property_add(oc, "clint-timebase-frequency", "uint32_t",
>                                microchip_icicle_kit_get_clint_timebase_freq,
> -- 
> 2.34.1
> 

