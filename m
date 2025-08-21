Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7520CA0EEB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 13:54:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up5k9-0006Vw-0H; Thu, 21 Aug 2025 09:54:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Edgar.Iglesias@amd.com>)
 id 1up5k6-0006V2-Ek; Thu, 21 Aug 2025 09:54:15 -0400
Received: from mail-bn8nam11on20631.outbound.protection.outlook.com
 ([2a01:111:f403:2414::631]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Edgar.Iglesias@amd.com>)
 id 1up5k2-0001sA-IF; Thu, 21 Aug 2025 09:54:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DL8tsrA/XrHft+FRj8gqDuPV4rm9JVd4/G5xy7G829Eo4B3kV/X/bO19jOqzvM6aemSn6smJmxxB1gAJsTHv9NTpyE+lCyrZa3E5XYuo1+lNk4e7cOmtX5HQBnfvQoi5vWTWNEquKrVYy1WwTL0/jfetyFz0EPGXUvu7vFcXEb9acjFTSY3LGxDUrrNqXZzj+mqY1dQaaxLGz4490rRqnhxg9XADlcXRezFj7tFwqqcvvsyVZmZSpJxDjgfv8yqueGoJjA/+xDJl34s9cZNuaEdhHZA92MpeTg2sCxZT88CO7MWWVSZKB8PsZngue90HPU3cbC25L+MiBDQA5As4Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fDy/vUYVqJNzjK/+7X/nv20cRaBDgU35pkPuGXdA85w=;
 b=v3xD3lseuoyi8e4EvXYBJFP5G3SOrevHRJEHesmWWrd5WV7eFBcdB0r9DyuUmQpIzhRKac0yvn+mymWslEgnvRX/MRyiKL7Loi4AoS+iz4W/kaxvIOUrzG6yK7ZNaokCQEBpj8XlgswAVhT3jaOvRsIxYqJsVvd0qY7Pr4uN4H7l3Rad25/+csDk4uRoPOqHOOidUYM2hSqp/TWYaWGfRaMuuK4YUVPleY+yOthahLaEdB2HTTp15cmvceAw8vibfzTLM1RFaSNy5wo+PewiqlAMbDsa6hGXOz3wlGx+R/lYlfHEN1gjEEzzkqTNlxb7uOp0/aWBKvcG9vI4qAjjjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDy/vUYVqJNzjK/+7X/nv20cRaBDgU35pkPuGXdA85w=;
 b=aCdUB8YOEww+gTa23/R3he1BHRTD/R/L+WXckny7aGZxxVUdFfXiKKeECihGarJv6ttY5KdzTo8aUsTkRVE6bFAtNRz6tsfOnGayO8oKfeN50Qu/Hhm3CBrd982v3tyGxY+xNONbG+SzN3lGlOzhOuPAt/sLV5gsSiMXBg1005s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4090.namprd12.prod.outlook.com (2603:10b6:5:217::11)
 by CH1PPF0B4A257F6.namprd12.prod.outlook.com (2603:10b6:61f:fc00::605) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.24; Thu, 21 Aug
 2025 13:54:04 +0000
Received: from DM6PR12MB4090.namprd12.prod.outlook.com
 ([fe80::671d:f94e:1c92:2f5d]) by DM6PR12MB4090.namprd12.prod.outlook.com
 ([fe80::671d:f94e:1c92:2f5d%3]) with mapi id 15.20.9052.014; Thu, 21 Aug 2025
 13:54:04 +0000
Date: Thu, 21 Aug 2025 15:54:01 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: Re: [PATCH v2 00/47] AMD Versal Gen 2 support
Message-ID: <aKck-Z7zjQd28cu5@zapote>
References: <20250820082549.69724-1-luc.michel@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820082549.69724-1-luc.michel@amd.com>
User-Agent: Mutt/2.2.14+84 (2efcabc4) (2025-03-23)
X-ClientProxiedBy: MM0P280CA0120.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::34) To DM6PR12MB4090.namprd12.prod.outlook.com
 (2603:10b6:5:217::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4090:EE_|CH1PPF0B4A257F6:EE_
X-MS-Office365-Filtering-Correlation-Id: 58699086-092f-4ccc-504f-08dde0ba30d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kdiuvsPolSAfmAY+hQdv+izfp+O6ht9sNYt1vtBhI7rJ5Xsw0Vb121XuyT3v?=
 =?us-ascii?Q?bWAPSf3anRj/U1ppP8O/zC3PNkZ1AcqYBitHr8ujmqb7mu2KDgciWBEIACpl?=
 =?us-ascii?Q?TREpNOwZPVp+2EiivvMj15dRmCrs5SNUV0VpuazpN/e5uMaJT0dFhGQ3z4CU?=
 =?us-ascii?Q?3kjSakZOlMtEbTmq1BAayYzU47+pvS8BNrK+iDLzdB0OVr05w8hgAjSWVZSK?=
 =?us-ascii?Q?VwYETyjQwl+dygGesDRAXbLWwtYx3qyvNqJo6UFBMBypMwEpoXebnG7ZYBeZ?=
 =?us-ascii?Q?ZGX7otoLWNc8n/DkTKuR4L/x7uqSHlpW1QHj6AoS1g2yQf7jEthHgaYIjF+2?=
 =?us-ascii?Q?nxhT10v2Bmg1fRls5/yk9Lj4Kb3Nwse3VxtI0O46R9+jq5qjiDJ68zoOLWzj?=
 =?us-ascii?Q?EFyOAmW1NMngGounb6jsw4fGBW+MITgQwt/nKaWpVrDFL6yfZKNzFvWW5/fM?=
 =?us-ascii?Q?Lohw42Psa3SupJVVln4nSF4pn1wTaWaJqtkgRAK4oTQiSmU8Y9DfX5K/N9GJ?=
 =?us-ascii?Q?yHJQhxUFzs7NVMOFO64VBys/DMjVK6iBzJuDNalVfooy2pASfTUwV3n964kC?=
 =?us-ascii?Q?a9b8Wloz606mVtEXlzQaTK05n/jypr77t278ja2Ae5GHuOx9qdF4BUerdzHc?=
 =?us-ascii?Q?0w30EswQXJXpSV+s77V53hnXyVF5k1NId7fF4M0UiMrvoOPEMeleoOcHHPB2?=
 =?us-ascii?Q?vaWql0abZMAjbEQioKDC49XUr/Nu3m+nVjz78ytRZ4Gx7fhsmC9onNroFaX9?=
 =?us-ascii?Q?oLYNMnFf/9Yasop6rCLpxwF4boVNJHTpRNO/f7ZKbcs3BC4Ty/2p8/m5B4DX?=
 =?us-ascii?Q?xgOIbfaraEur63CJYTuhTZDpEFPx4lY4+nRTHZ/RLRxV5MQtcusX5J8fIQYI?=
 =?us-ascii?Q?CkXXGLbOS2NnhIjbGo8wnykuq5P3SsTOdDuN4ThrsQscTqvtXf9c5GHcxezU?=
 =?us-ascii?Q?nYxWoJXK00vBIu0z5bVVL/sxr1y20fS0iVaCH22C2WnMmz//e2CVpiMHTwHy?=
 =?us-ascii?Q?6VnEWqqrFq1Yp+jq2AjS/wtzvxZUcA6+4EHBwd/ad6fAIRn2Ul4UtJZGgIX2?=
 =?us-ascii?Q?UT/FtPv4v5yNt87DeteV7NLh/KTtISXYsrzvIvLiv1nC5o052ri7GZQPlJ01?=
 =?us-ascii?Q?ckJeqt1u1wLLBLR5aNk/37nczRFKPTYtiYch/B4CplP8eJ1zmhf4bx4vAsRM?=
 =?us-ascii?Q?x3GKSr5QCUD/K0xSIBhvCiEOYtNu1jnkHXu7BEJ5S5o7Y2LnNWPUXu3XA4rZ?=
 =?us-ascii?Q?k+MtYEEIHqN/UySYSZglQ80rcNF4oQ7k58UTgKaAqL+2rClsMjuqbDi8xjmZ?=
 =?us-ascii?Q?0Fm33vCKyvP41ba5KCPAl2E09tCqRl0Zl+YTa/4dsMKx48Wce3I2tkJr4FhE?=
 =?us-ascii?Q?bQ+J05FglD5o0ALWhi9vdpbmWlhEGKEMj7Up4iw3JimbOyrhFTkay4BP/2fO?=
 =?us-ascii?Q?zdVUo6oJqmU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4090.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?refD69gLheAORD/sYRNyzFPgpelCdgZdu/s314bVydY6Evt8qON/+UM4H1Bg?=
 =?us-ascii?Q?qgNpCdXLjOwDy50u4IZpiCrJbiDiUKoD6EKcQj+cbRfByeqU1VvJvj2Z4hfG?=
 =?us-ascii?Q?7PhrkToJmyjLTKyNuO2alMnocDb/Al5vRdvrQlx2hOf7cRMsNuyJIdRvuVu3?=
 =?us-ascii?Q?Nu/kD22OWWlqwbtxfhw6Y4OwRF+Tv2W3zl9on82A91f8OW7kydEYfECkjGvT?=
 =?us-ascii?Q?UdSMfX6tNFMSwWYOU3ka4+5TWDfspYlsW1AxE+fvyAD2qyKxa0+9HlX6pv3v?=
 =?us-ascii?Q?KVzmAgtJjy6MU4WXejro0saeRExpDGRKwLkA6kXSWE6gf+5xVdluJ+atBZj5?=
 =?us-ascii?Q?G4vOamBgqXPMbhsPH6wVx/Cf2qiW+apNNSe0yXXMIFmQSo8lnEXM8d/D3Jrb?=
 =?us-ascii?Q?0ncRChE5UmEQlfRDihgXVAmByulNkKCwz3yt246E/WcZJJDxVliJnDENzBME?=
 =?us-ascii?Q?RYfCrB1xw9nCLammYwq89TKtAcb2Bug55VYyh32AB2VkpJzdr+I93IaH7IJX?=
 =?us-ascii?Q?Fzge3GAMEkKxxDrm3C1nrR27wUPU09qBwMhjBVFhbf5ENoQWybse5KKaCUch?=
 =?us-ascii?Q?033BWFZT3bZOQ3KhJqrT5cBIAD56v5zpEaOyjVvnoi7umSc3aOyxTbe+C/TW?=
 =?us-ascii?Q?55r2Yl/uKRMAiFC2dBMI6qkwtdy734dVSsbbV6i8IsKWj0/ogRH6AtBWuq27?=
 =?us-ascii?Q?SILypfKZpKR0nBcioFBM+1Qfg2a7Bakp3THAEHOIii3hsbWS74nhix3LExJx?=
 =?us-ascii?Q?aOMxuGliyaDtObe7VnbGlQcWyE+1nIUt1cRdBCQCKmO57yLfpiMBmJkO9gbS?=
 =?us-ascii?Q?wSG6Wx3ze6Bsrt4mE/zjcBuQAhFkuJ5jdSE+FI501zed2OXcFVlOHKlV6R5i?=
 =?us-ascii?Q?94g2Lw8STyRIyEWA6AptCpGfZMABgZxWzcBoZLpLBgTx4B4JbKblcExROKcE?=
 =?us-ascii?Q?NdgbbnFh8vIishPEcz+Q+Hj6Q75Lz3l+KCluPWwcAPglUuoy45MxLpPOnFuE?=
 =?us-ascii?Q?pTWiToWskNlzvjQRCLZgBadJp2Q0bv7i+TkR+Avpvo2C/1cvKUQ2THfrv2B2?=
 =?us-ascii?Q?ZC5J/nth5iD9dz6Bt983tucY53WyEb2ucIGLv7a1rcXnNKqcWa9Igu9bW9pq?=
 =?us-ascii?Q?sCM9jtW9EyTHTFLfJRvxQ/l60sHBKyQ8YzbpwqyYRgjfeUEnqz99bixchOWM?=
 =?us-ascii?Q?V1dyw2EklHEbtvBfj6akB2uUOVq6T98VkaVVc0CXLYS2M0Cf4z42bv5ThtFP?=
 =?us-ascii?Q?F12j6pSWh5ObnMom/LLl2X+ly3HAymdDrtmUFC/W5FLP3ECtqm6ueuBqKrKd?=
 =?us-ascii?Q?PsnF5/HAATtyhaWVBFWPbWl8zgyKhyoqu/Vf81DXXBG39XZoSaKdBdMhow7S?=
 =?us-ascii?Q?MtRrnFWAcS6ltYbjJOqPnOGcyu/6hfpz3hzfJBF0eQi8zcDi+a5aJnukOSYW?=
 =?us-ascii?Q?PNR+Qf6h8AJNqQ3IicwBKYDayXfrUpENFQrX/qbDT++NHiLllCQNb4nslVvB?=
 =?us-ascii?Q?asmDgYX28fEk2iUQ7Xh2tuioltv7bl2JX11ox5N2rdvs9ZnGqSaS5ovhNzET?=
 =?us-ascii?Q?JNps4RF7Ijpcu7HXsCw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58699086-092f-4ccc-504f-08dde0ba30d8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4090.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 13:54:04.6612 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iSR5A7TfeEFveZ8lVaee4nuyGFAPC/G8i3HJzm+H51gpSx1Z7c1JAuVJpmHZ56Gy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF0B4A257F6
Received-SPF: permerror client-ip=2a01:111:f403:2414::631;
 envelope-from=Edgar.Iglesias@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
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

On Wed, Aug 20, 2025 at 10:24:59AM +0200, Luc Michel wrote:
> v2:
>   - Addressed formatting/typo issues [Francisco]
>   - Patch 23: GICv3 first-cpu-idx: addressed the KVM case by bailing
>     out if not 0 at realize. I chose this path as I don't have a clear
>     view of what it means to implement that for KVM. It seems to make
>     sense anyway as this property is meant to be used for modeling of
>     non-SMP systems. [Peter]
>   - Patch 39: added a comment to clarify cortex-a78ae != cortex-a78 [Peter]
> 
> Hello,
> 
> This series brings support for the AMD Versal Gen 2 (versal2) SoC in
> QEMU. This SoC is the next iteration of the existing Versal SoC.
> 
> It is organized as follows:
>   - The first patch is a fix in the Cadence GEM model. Some registers
>     were badly initialized when the device was built with a number of
>     priority queues greater than 2. This was confusing the Linux driver.
> 
>   - The next and biggest part of the series performs refactoring of the
>     existing versal SoC implementation. This consists in:
>        - splitting existing device types into base/concrete classes,
>        - moving from an in-place to dynamic device creation approach in
>          the SoC code for flexibility,
>        - describing the SoC using a new structure called VersalMap,
>        - moving the DTB creation logic in the SoC code itself alongside
>          device creation.
>     Patches are split such that each device is individually converted to
>     use this new approach. Behaviour changes are minimal and are
>     emphasised in the commit messages. This gets the SoC code ready for
>     versal2 addition and leverage the fact that Versal family SoCs are
>     quite similar in term of architecture.
> 
>   - versal2 SoC support is then added by adding the corresponding
>     VersalMap description. This allows to reuse the existing code
>     without duplication and almost no special case.
> 
>   - The amd-versal2-virt machine is finally added, following the same
>     idea as amd-versal-virt. The documentation and tests are updated
>     accordingly.
> 
> Note that the xlnx-versal-virt machine is renamed amd-versal-virt to
> follow current branding guidelines and stay coherent with the new
> amd-versal2-virt machine. The xlnx-versal-virt name is kept as an alias
> to amd-versal-virt for command line backward compatibility.


Hi Luc,

I haven't looked at the details but overall it looks great!
Nice to see that you found a way to share code between both Versal
versions.

Cheers,
Edgar


> 
> Thanks
> 
> Luc
> 
> Francisco Iglesias (1):
>   hw/intc/arm_gicv3: Introduce a 'first-cpu-index' property
> 
> Luc Michel (46):
>   hw/arm/xlnx-versal: split the xlnx-versal type
>   hw/arm/xlnx-versal: prepare for FDT creation
>   hw/arm/xlnx-versal: uart: refactor creation
>   hw/arm/xlnx-versal: canfd: refactor creation
>   hw/arm/xlnx-versal: sdhci: refactor creation
>   hw/arm/xlnx-versal: gem: refactor creation
>   hw/arm/xlnx-versal: adma: refactor creation
>   hw/arm/xlnx-versal: xram: refactor creation
>   hw/arm/xlnx-versal: usb: refactor creation
>   hw/arm/xlnx-versal: efuse: refactor creation
>   hw/arm/xlnx-versal: ospi: refactor creation
>   hw/arm/xlnx-versal: VersalMap: add support for OR'ed IRQs
>   hw/arm/xlnx-versal: PMC IOU SCLR: refactor creation
>   hw/arm/xlnx-versal: bbram: refactor creation
>   hw/arm/xlnx-versal: trng: refactor creation
>   hw/arm/xlnx-versal: rtc: refactor creation
>   hw/arm/xlnx-versal: cfu: refactor creation
>   hw/arm/xlnx-versal: crl: refactor creation
>   hw/arm/xlnx-versal-virt: virtio: refactor creation
>   hw/arm/xlnx-versal: refactor CPU cluster creation
>   hw/arm/xlnx-versal: add the mp_affinity property to the CPU mapping
>   hw/arm/xlnx-versal: instantiate the GIC ITS in the APU
>   hw/arm/xlnx-versal: add support for multiple GICs
>   hw/arm/xlnx-versal: add support for GICv2
>   hw/arm/xlnx-versal: rpu: refactor creation
>   hw/arm/xlnx-versal: ocm: refactor creation
>   hw/arm/xlnx-versal: ddr: refactor creation
>   hw/arm/xlnx-versal: add the versal_get_num_cpu accessor
>   hw/misc/xlnx-versal-crl: remove unnecessary include directives
>   hw/misc/xlnx-versal-crl: split into base/concrete classes
>   hw/misc/xlnx-versal-crl: refactor device reset logic
>   hw/arm/xlnx-versal: reconnect the CRL to the other devices
>   hw/arm/xlnx-versal: use hw/arm/bsa.h for timer IRQ indices
>   hw/arm/xlnx-versal: tidy up
>   hw/misc/xlnx-versal-crl: add the versal2 version
>   hw/arm/xlnx-versal: add a per_cluster_gic switch to
>     VersalCpuClusterMap
>   hw/arm/xlnx-versal: add the target field in IRQ descriptor
>   target/arm/tcg/cpu64: add the cortex-a78ae CPU
>   hw/arm/xlnx-versal: add versal2 SoC
>   hw/arm/xlnx-versal-virt: rename the machine to amd-versal-virt
>   hw/arm/xlnx-versal-virt: split into base/concrete classes
>   hw/arm/xlnx-versal-virt: tidy up
>   docs/system/arm/xlnx-versal-virt: update supported devices
>   docs/system/arm/xlnx-versal-virt: add a note about dumpdtb
>   hw/arm/xlnx-versal-virt: add the xlnx-versal2-virt machine
>   tests/functional/test_aarch64_xlnx_versal: test the versal2 machine
> 
>  docs/system/arm/xlnx-versal-virt.rst         |   80 +-
>  include/hw/arm/xlnx-versal-version.h         |   16 +
>  include/hw/arm/xlnx-versal.h                 |  341 +--
>  include/hw/intc/arm_gicv3_common.h           |    1 +
>  include/hw/misc/xlnx-versal-crl.h            |  378 ++-
>  hw/arm/xlnx-versal-virt.c                    |  742 ++----
>  hw/arm/xlnx-versal.c                         | 2460 +++++++++++++-----
>  hw/intc/arm_gicv3_common.c                   |    3 +-
>  hw/intc/arm_gicv3_cpuif.c                    |    2 +-
>  hw/intc/arm_gicv3_kvm.c                      |    6 +
>  hw/misc/xlnx-versal-crl.c                    |  602 ++++-
>  target/arm/tcg/cpu64.c                       |   79 +
>  tests/functional/test_aarch64_xlnx_versal.py |   10 +-
>  13 files changed, 3060 insertions(+), 1660 deletions(-)
>  create mode 100644 include/hw/arm/xlnx-versal-version.h
> 
> -- 
> 2.50.1
> 

