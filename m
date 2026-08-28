Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B67FC61DC4
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 02:55:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzmkP-0002aE-6w; Thu, 27 Aug 2026 22:55:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wzmkO-0002Xr-87; Thu, 27 Aug 2026 22:55:16 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wzmkM-0007pb-Lf; Thu, 27 Aug 2026 22:55:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RCCCcC6gXRqCuM2rt8RY9/jeF3UpuMhuviw1MKlMgWdeJsRTTMYuBifFQHwAS9R4jzjdBljekufLALVenFbh7Nf2HvvwJYlVMbGEIcS4vhV5nr+DKqoIAyi4k9VpuUfRjbE00zHX4MmWu12dBp5/E4pwdA7Hz1MxyP8GLGg8g3YM3RpkjoLqMbq/0u9wXQL4Dm5rWozaF9KKQ1jl19dzNB2t1yIyEei8Id822qx955j3FhwNLGBsWvnX3g3qiSsVF2Ko41SrLBt+PIu66TN066o+Q03VXFxrZ3sX77stPdqGxzcnXqZsjRKYZbGg8arO2ID1p3gLgAU1Vt4g8vhBtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ja3Hciab1+MsIC7JaFUWFpSHqrxltvfTX+Vc/b5gjR4=;
 b=p1oQfsQ3Wiexd58j74AFk1tDOAW7ZWIdxrQ5k8PeCQbfEGVESdqn6buV352Rhd/UETm6wv5Oim/wYNz9zNBcKmtWhKsGeIbdrZNyysUM1xovAUZk2X4t/RSLTDbb6pT6WQP+XJSmX8lall1HFjEUWvjalHaoo/IFHVOj5vdmUmuU9keQ1NTajACNlo+FD1Sy/AvlJnAWYy5ax2pfJv4187b+Zfje8SChlbzlsWel/CcUCA5I+NKaGfQjOkFtrURrzYA5V8n5nEXnJ5HG92M+IGyEAPyrOisSptPLKJgFHf2RCi6/Kqhe07ETb0oNEse6YeUNH9tbLGLrHjGPiEVYfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ja3Hciab1+MsIC7JaFUWFpSHqrxltvfTX+Vc/b5gjR4=;
 b=CGM8eN+tNdYNSnlN7qauXR91vDPOeTjQJyb6d1RxxbxBAe/rQluA0/5TAHX9xGqeux8XDC9vaJxUQMBVz0NJdhJe5aCBFAjBGee+Z/mxp83ALH3SFikcsHDU6zADxMg63fLIzkbRWVJ3H4T6Z06ihAN+2XlWEa6+X+xsAVutWUzSFNMb6lheJwJKzpSnrR5LreahCeWhps4TFRNKW7+gmdusXSTWPZryGkB/vnjtxhaEGeDV4wp2MXFApvkyRmG9AXomwUg/ZabUSE/t/W0OBICtbAj2vIWdidiME2vSlvJGYsV/VGwR+nU9zRSZ6ZBAL8pSbIkUqYGTBg+bF0mEuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by SEZPR02MB7685.apcprd02.prod.outlook.com (2603:1096:101:1f7::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 02:55:09 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 02:55:09 +0000
Date: Fri, 28 Aug 2026 10:55:04 +0800
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v4 02/14] hw/riscv/fdt-common, virt.c: add
 riscv_create_fdt_flash()
Message-ID: <apD4ftx8Fdz2WLm6@ChaodeMacBook-Pro.local>
References: <20260827222608.329788-1-daniel.barboza@oss.qualcomm.com>
 <20260827222608.329788-3-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260827222608.329788-3-daniel.barboza@oss.qualcomm.com>
X-ClientProxiedBy: PH5P222CA0011.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:34b::15) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|SEZPR02MB7685:EE_
X-MS-Office365-Filtering-Correlation-Id: f8c63013-ee1a-43b5-cc63-08df04afc5e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|10067099003|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: b7DnFQUdxoC/BS8x9ofg5FhFjO08I2sEhTlxjqslcj4D61G7vtZvju+oZoWSZ72oYofPQXzlSNrFbP3evSJjC89YTi0l3fnX+sQ6Ak7qQ4ISp2wc7x/gGPpjEJcmEmAExv1bvqh6artuqnIUk+zOHStmYR8W3erspN3EppXbBD0pWw4n0kx7p8NcZOHn2xOjDMr3AFfB4aLzG/WVIFdyXjU2n1SI7rQ2gSjqs3fNeNPZYbImuTlekb8yuG/i9YmRQzWVxEXWrGVkYAOogrmtgusydVKRQDVwforBnFddhZRDfwGxnwiO0tRu2ZxxMGdTVbrcerfLhpKcG2Q0Gmed6INHp8IIZElo8g0gRV/Wu5zyR6c+4NtM11BY4NUq7aHFaNEtGSLZGIb9YOVxajKlCFyZf/bs3tSFEBuiB+Ndv9jkD5YGvQkaeGRTXwRSw2E/BGDvcJTdWFZmJve7y0CvtVo9jwyBljRRNbeDsvJxv/JG8UgL7FZac/9WO1BebonNBt+ogw8na8DvXYxEbzMfp8jP1gto2Dg1YHRx0dso9fq539O2GqFHr7E06vuKPotZBuwT02dKzdUdFI7KBqEuKVOvUPPIgaAG7LVEW3otoWNlHxR4bO2vVXfq3o5+dCm4OwYOF6Z4H1Zbl4UbO0DeKm+GPhPfYAUvuXhPVwq5Nwc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?nWNVm1pGGgUPcBhHKmG6UyAm3bT8Ahe7NIAT16xy+YRYXS+ccHG+0GwFQi?=
 =?iso-8859-1?Q?hA5sLKKdvq+0XZ+DnmTZjFPt21whxTqVK9W0QGySijPMX3SEL7anCr/zRj?=
 =?iso-8859-1?Q?4B+xK52zA4WnMOsjYWYPKny1rVgLd7nj53bxePP/FvbVAf4uLX8KHweJEe?=
 =?iso-8859-1?Q?urDYjuQ9qcXWcKV+1tbbZB4dy9B37+Jr4nvW+oBHb12v+OFItNU2JXclmJ?=
 =?iso-8859-1?Q?p5r87RAba93sOKn6CtlThxCFGOia8sg7oBpF77e5Y34z2zUhU1+9Hnypdj?=
 =?iso-8859-1?Q?EHPmoVKrjO5haaDq2jnAMTLGm05SZFMfkdkdBtSJ2SBGc7oyhaNHNckNjH?=
 =?iso-8859-1?Q?GEMIwD5Ju4cPSDVXAfim8O2s+OQXDCXPiTAl0rmgI+hVI4nX+W5rb06JVk?=
 =?iso-8859-1?Q?ctS2H9qcLEsPXElrGNitNyfj8mXJQIlKK3kLlRTKIkVj7mKf5/clENwtta?=
 =?iso-8859-1?Q?8XMwxoqnfY1swqHCGPW4z3FY37kjdnlcTY1kvN/yXBh3jMK5pmGZAo5zZK?=
 =?iso-8859-1?Q?6kpthj09YQtIhaxeutbDzWimCTyPEq2fCDNMXWcdigDZHUCGX8xdMHXOzz?=
 =?iso-8859-1?Q?SXV85kWF/up01nTNPFeb+RJFVFfEWKo8srIuRZQjd2uVLGM/K9Y1taoIhd?=
 =?iso-8859-1?Q?vFNTvoMwj5CuUalh1YnijyxMm0IMuvm9GXJzaY85umDO9ONeqVCKB85n/3?=
 =?iso-8859-1?Q?YMBZHfJ3mlJ5Lfdjhnxmyp7KEhw1fKa4t8MBfSajVQaPr1JOFAfuSUMMC/?=
 =?iso-8859-1?Q?S/z61edA8OG0RXzyD/imkJFswKxpY1dyg2PbGgn9sQyWbi7e9Eksu4Twdq?=
 =?iso-8859-1?Q?lPnsioVRZ0XqLvmNyThAXEM7EcW7Rz0YaXTAaM6xOa3RPZf2h+9aEWIGIQ?=
 =?iso-8859-1?Q?gWjsAY9oUNKUBp8UndlhhafA/mvddRFLbVkq3psHabTdRbj+EfkuQEN2Mc?=
 =?iso-8859-1?Q?/YqeAtvxMThZEdh4lm1i++1tXn7QS6gERK10C664kLWVQY1A4fmuF/rebb?=
 =?iso-8859-1?Q?io3pZQMWn15O5rXTTQxtRA80WFJ8N+v1XYoVxZ59jY7wnKEPA1d6aO9qAk?=
 =?iso-8859-1?Q?jWl+XeFglIMD8Q3dDBK3uaGt+upEePFNjPwp+TV+Uu2xN2anVLrQ0BiMIj?=
 =?iso-8859-1?Q?se1EkIU1m6XkqKURY+So/7YGNgx4m895BcKmiNx5FoodfsrTwtnGlFmO/C?=
 =?iso-8859-1?Q?IwAhZ3sP0DhdahVZTLLPWrpNeCwBHGbLjCdjk9gswppzYVTG4WWJ54aKgd?=
 =?iso-8859-1?Q?qaNyd1iuILuJuEARI7DQ+6mtJU5/ofR3qu2x4a5mNB7zRRVKb22g3twmm1?=
 =?iso-8859-1?Q?o+Ro8WFULHwbdEV3UgP0CpGrkt2xqk0mLizXI8ct/Ds6+dFur6OcVvG4Zq?=
 =?iso-8859-1?Q?/2Et/Ah/e26868eWhwaMujfeBXA1zsjSr7fbiWtsMDIkQjmuNcXiISFUWX?=
 =?iso-8859-1?Q?p3r6an3bWGIk9yK6jntBM1laHWAsd6Yu3avmEVa0zRTF8bifJf0CMKWQ6e?=
 =?iso-8859-1?Q?T5khQAmCI0jd4wFqCw7jG9QEu70Qu8NYJbVRTOBEJn+Pck0u3DsfGq+Gc1?=
 =?iso-8859-1?Q?Lnv7IkAXRrDolRLRiieFu455BzTb/TqTmFpWWvEpWmnob5/Cx8PhxS9bs8?=
 =?iso-8859-1?Q?1nNi45IIcAFYnFW3ga/GiCAjCyRZABDA7s7pznzLp1tWTDH5E4hJsqRfEw?=
 =?iso-8859-1?Q?I/XkrMgjB4m2OOgYfWbipMi19pSeIRyvDLKr3S1m18maRVG5yV1MQHLlW3?=
 =?iso-8859-1?Q?xFpOvrhiHAagIeD3M+3QXMVD2Mfmf3B6cUz1hAmLygbtWpf57FNOj/VvNI?=
 =?iso-8859-1?Q?6WTwD4MVvK6A7w9CKTc26eYNYfGlvHY=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8c63013-ee1a-43b5-cc63-08df04afc5e6
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 02:55:09.7534 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yuTLgOrUo2J3RgnQe61D3wquwhhROhUoRb7xhvxNLBqMtr+7fqZONL9oP/MtpNDtPa9BHWMbd9fHWJyNYsM2FqHSK8xwU/BT3vbL8y5osIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB7685
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=chao.liu@processmission.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Chao Liu <chao.liu@processmission.com>
From:  Chao Liu via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Aug 27, 2026 at 07:25:55PM +0800, Daniel Henrique Barboza wrote:
> Add a common helper to create a cfi-flash compatible flash subnode.
> 
> This change only affects the existing 'virt' board for now but it will
> be used by the future 'riscv-server-ref' board in the future.
> 
> No FDT changes intended.
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
>  hw/riscv/fdt-common.c         | 12 ++++++++++++
>  hw/riscv/virt.c               | 18 ++----------------
>  include/hw/riscv/fdt-common.h |  1 +
>  3 files changed, 15 insertions(+), 16 deletions(-)
> 
> diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
> index 3a8da03cfb..6fcc1ce21f 100644
> --- a/hw/riscv/fdt-common.c
> +++ b/hw/riscv/fdt-common.c
> @@ -283,3 +283,15 @@ void riscv_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char *pmu_name)
>     qemu_fdt_setprop(fdt, pmu_name, "riscv,event-to-mhpmcounters",
>                      fdt_event_ctr_map, sizeof(fdt_event_ctr_map));
>  }
> +
> +void riscv_create_fdt_flash(void *fdt, hwaddr flashbase, hwaddr flashsize)
> +{
> +    g_autofree char *name = g_strdup_printf("/flash@%" PRIx64, flashbase);
> +
> +    qemu_fdt_add_subnode(fdt, name);
> +    qemu_fdt_setprop_string(fdt, name, "compatible", "cfi-flash");
> +    qemu_fdt_setprop_sized_cells(fdt, name, "reg",
> +                                 2, flashbase, 2, flashsize,
> +                                 2, flashbase + flashsize, 2, flashsize);
> +    qemu_fdt_setprop_cell(fdt, name, "bank-width", 4);
> +}
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index b796220fc2..e48337dfd9 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -867,21 +867,6 @@ static void create_fdt_rtc(RISCVVirtState *s,
>      }
>  }
>  
> -static void create_fdt_flash(RISCVVirtState *s)
> -{
> -    MachineState *ms = MACHINE(s);
> -    hwaddr flashsize = s->memmap[VIRT_FLASH].size / 2;
> -    hwaddr flashbase = s->memmap[VIRT_FLASH].base;
> -    g_autofree char *name = g_strdup_printf("/flash@%" PRIx64, flashbase);
> -
> -    qemu_fdt_add_subnode(ms->fdt, name);
> -    qemu_fdt_setprop_string(ms->fdt, name, "compatible", "cfi-flash");
> -    qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg",
> -                                 2, flashbase, 2, flashsize,
> -                                 2, flashbase + flashsize, 2, flashsize);
> -    qemu_fdt_setprop_cell(ms->fdt, name, "bank-width", 4);
> -}
> -
>  static void create_fdt_fw_cfg(RISCVVirtState *s)
>  {
>      MachineState *ms = MACHINE(s);
> @@ -1043,7 +1028,8 @@ static void create_fdt(RISCVVirtState *s)
>  
>      qemu_fdt_add_subnode(ms->fdt, "/aliases");
>  
> -    create_fdt_flash(s);
> +    riscv_create_fdt_flash(ms->fdt, s->memmap[VIRT_FLASH].base,
> +                           s->memmap[VIRT_FLASH].size / 2);
>      create_fdt_fw_cfg(s);
>      create_fdt_pmu(s);
>  }
> diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.h
> index 371971d79d..b422da6aef 100644
> --- a/include/hw/riscv/fdt-common.h
> +++ b/include/hw/riscv/fdt-common.h
> @@ -38,4 +38,5 @@ void riscv_create_fdt_plic(void *fdt, hwaddr addr, uint64_t size,
>                             uint32_t cells_size, uint32_t ndev_sources,
>                             bool numa_enabled, int socket);
>  void riscv_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char *pmu_name);
> +void riscv_create_fdt_flash(void *fdt, hwaddr flashbase, hwaddr flashsize);
>  #endif
> -- 
> 2.43.0
> 

