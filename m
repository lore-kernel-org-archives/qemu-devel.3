Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30FE3CA5FAB
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 03:20:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBONv-0000jh-Rn; Mon, 28 Sep 2026 23:20:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1xBONu-0000jM-AG; Mon, 28 Sep 2026 23:20:02 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1xBONs-00074n-3t; Mon, 28 Sep 2026 23:20:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VgT9g78l6DBopdzKpw7Z1J7oh9wGPecKrSNiTKnsJ/Aon8Q11CaKE0ltNHJp12pkyzOwGUGCuBt5het6ZEjpZh85Wp67MfJbZSYV7cU3gzpBr0ErSFUmkx+P3wOoWQmWr1Lr/9mHGCREZ9HyE70WcF/+WGKqIRacxXAwdR3D4hUBZ2tyIrl3DpZUc5BTfVBe/J6n/zw+9FknTFud8HY0Go3tLgrwJNtr7EeP665q9mGR/TqOH+ztvHKnPScdAa4dbpEHfdwKWPihzftzSa04SjkXJK+4PEkdZX37lAVt7K/Th/gCxlVU0a7bLE4/RGBKEpkbfd8Za78IXOk8t4UfpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tLjaQpPiGtkGlj0RfBFuS6ZvGt0M7hTwXEijZRFPQJM=;
 b=hOhPee2QKZpT/PpNwg4ryw0MrOgqkI1ME0fUebuuhI6QCn0kwvN6Q8li98B+wo3DH8vo9B83YoJprtghIP98RYy6IL8Dms5rV3SwxdD3oSI68dURWIHR7eIKEpao/UAgrn0SzeMljLSd7rReRc+HRaodeONE6rme4ouMN/tG49VyU8uK0CAN425NrOvUf5TO6uQoJ0uv+WJ1cHh5Hnl0tbWLr6M3jxqFJT8bvleQPmpmX4t3Ksl1N6Us8lprr6+QBNW82xku1QfPhMe7/sDfU0QxTqX5H1tdhjjLsDL8ZoYYxtEqe7h6mqC5jBkDJAiu03wumAodRijZ/oE0D3FbtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tLjaQpPiGtkGlj0RfBFuS6ZvGt0M7hTwXEijZRFPQJM=;
 b=e0JNs108cWLqowQqMuzvr0mmzv2BzEM0cZTf1k0E4BjiR+u81GWUVFCcglxNqXPSxwdEhm4BltbthuChY+mhuSlWaIxx9INwavun/HktkQKcKK0mtYHBv7P+UyKe5CRbxbNMBeQDxUSCnZdNzUbhqIk6x05MjjNzJFKGAjCAbTVtdYSEb5QySxS4CKDldXMjDPGQTZt95tvDMc6jKOhB+QrKLoW4Aoe8Vmry6r9WiSGmFFPPwJYDw3MPADzYwp8hVC+CLTTyTqg2klYpgtQTokup0Z0BvfD8wNZjIvhfV5hnAq/mJYOU0CkIzZCLH14ChI/xWOMRQTTIDqNCOyYmZQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com (2603:10b6:a03:37f::19)
 by IA3PR18MB365644.namprd18.prod.outlook.com (2603:10b6:208:70b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 03:19:54 +0000
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba]) by SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba%3]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 03:19:54 +0000
Message-ID: <348cfd20-66fd-42ed-b338-79dd39df6324@axiado.com>
Date: Tue, 29 Sep 2026 11:19:52 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/13] Add Axiado SoC AX3005 and EVB
To: mark.caveayland@nutanix.com, philmd@oss.qualcomm.com,
 163wangjack@gmail.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20260911051532.2378501-1-kchiu@axiado.com>
Content-Language: en-US
From: Kuan-Jui Chiu <kchiu@axiado.com>
In-Reply-To: <20260911051532.2378501-1-kchiu@axiado.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0018.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::19) To SJ0PR18MB4479.namprd18.prod.outlook.com
 (2603:10b6:a03:37f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR18MB4479:EE_|IA3PR18MB365644:EE_
X-MS-Office365-Filtering-Correlation-Id: 49e87aa7-48ab-4395-3f62-08df1dd88817
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: kpZbriSiEYi2tCAwYR5Y7ihpwVz+gDsw1B+mbPXfYJdkwBVmPMMT9LKv0gBL+fc2+cHo9KGCKrBe6mnwpBULDbck8LFA5Ic9xr1Js/HV8Ak0G4K0+tQKlQr2VIf0IhAhl7uo9VAeGPLNyHAubM7dnFAwmj4uEN/BbZa7rQbzzI6L5ybtvKpb1I1Y338KN6hz/JHZFOOFb1PshBrrc4BJbJGm0xqzECp+BW++sRrs+AFZ4wDSeoboTVdIaTLt+HbhYidoSfUDCf9WSPZG5yS8MsUWdoJDPvNdTFkOE7KCowcyF0d9fVeTvrSL2dmsqbX6+lV6Cvk2tvUaDPYyjp/7r566Zxaruf8AOmoFzwZA3/RDzzRFRYRyF122kUrT2RkP4cTw8FkZXMg0SjOuxe9an0AxtsxJm7iOc57sXXbekwQ8lE2XUnhBwKiXNQ+8iXb9ZEE+mzuavw3mxC22kTPOm0nRqCzaV6l/wXKiyliBIVOCMK+HmkzSC3dDwJSir7L+LnVGCJqym+Gz6qpgBhBJ2iKxWD9P07aolKigv1iGQguEQAb2fx3Ln3coxrU0LanJ6UR2wv6lXPlDDBlHzymYOcjcd8v1BpSWBxoYYLqMHkg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR18MB4479.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0g3c0d4UWdVdWVOUDBYQVFpR1k5Tmx3eFZwY1dCSjZqQWJ5VDZtajJZa1lI?=
 =?utf-8?B?cGNnSytqR0RPU0F2V25KRktRalZZak40bm5xMWIzcFpmQWJSV0tPdDhXcyta?=
 =?utf-8?B?Ym9VaVVvenhBMzNvY0ZkSmpqWjFqU09wU09xR2ZWSFlNaFFiaVIxbEFwblk4?=
 =?utf-8?B?YW5IQUYweFQ4TWRXY1QrNTlKZnA2Q2Z0Nnl3bTFOVHR6Umw0enFFbE44MnNv?=
 =?utf-8?B?V1AzVVZxQ2NYWnlYVXU2ZGRmbGpEdnUxblZGcHZWVjhkL2dTZzd0bmlQamw4?=
 =?utf-8?B?T0lMZTdsZEljTTFSdWg2RDg2bStkNWxWd1YwV0srNE01TWdGRE1Kb2gxVjBn?=
 =?utf-8?B?SjNPUzA1a3RUK1pQazVTRHVnelR1MUdVNkp5YXFwaytYUFZsKzJFSXRPSW1K?=
 =?utf-8?B?a1R5QVpFTkF1eHQ5a3M3K3VsUWd5RisrWm16TGNPclByS1h0a1VXa3Q4b0Fx?=
 =?utf-8?B?TnlsQ3NmcG5hR1NaZExhUmlUZG1mUDFkdnZ4UWtkQzRDclM5L0lMREtqUSty?=
 =?utf-8?B?Ni9zd09scWVhVyt4ZzIwMXhCaU4xcHplUHExL2g3Y2hpRnFheHA4cWY5RjhT?=
 =?utf-8?B?OElIVHhQVDdTWVl0Q2lPNTNvQVpnN3ZMTHVKMlRPZWRicndHVkdBNGtHMEFq?=
 =?utf-8?B?RWVnS0wwVWZ4TmpXdHZZamJkZ201bWlxUDZmakIvUWZQVjNzMEc3RWI3K0pu?=
 =?utf-8?B?SFVqQ3dORWtNY2FyMTRTdmQyLys4NjVtMy9pUVdsZWtYK2hPVmNKU29YMnNw?=
 =?utf-8?B?cUpKbU05cFNQV2Mwb1UwZ2dWSDBGQ1ZQT3VONlBtdkZoL3prTTBTQThvYmFE?=
 =?utf-8?B?NlUyR2RCZnZaaTVGcXgxdjdDdzBFL1JUWU9CbW13T2QzUEtCU1Q4bm9ud0s4?=
 =?utf-8?B?djlVTEM1Q2pObVBCTTlMcnEyZytKV1FRUGlMSkR1aEpyRkRkejNuTm5BblRJ?=
 =?utf-8?B?ZDZyd25Wajl6UVZvV2dsMjhmb0NWR0dQbW5TTFA5R1crMTltUEZ2V29iZTRF?=
 =?utf-8?B?YWZHeVZ1TWhpRzBCWGpEdmd2ZlNSd2pIR2V1cGFUdHF3MTlLelhCb3BEdUF2?=
 =?utf-8?B?UWt6VEl6a05TQjJ0Vkl2ZFBXeVBMTVFVbUJPc084ZnIyaGg4WFltVmc3ZXFm?=
 =?utf-8?B?QXFnTXZBNlh6WUlucHZETWkzNGJGRm1Ybzc3NGVkazBodjd4NE5Qa1I0NEx1?=
 =?utf-8?B?WXlrZzhRUzNrSE1qVEtWRkU2amxVakQ4Um5YMkZwUGplVk96TExCdHBKYjdT?=
 =?utf-8?B?MHJUV0RwOGtGSVBNc2ZnZ2tLMDlZaStFSTREWisvaVpMU0VUZXNKRVhxVS8v?=
 =?utf-8?B?K01hRDRGODZwd2J1dmc3bjJxVGZ2clpzMHQrY2lFdXhYWXJqYjVFZ0J6cHY4?=
 =?utf-8?B?N1NQd05raHphRUk0bEJjRGlkZWY0Q3JqcjJnQ2FHWVAvWFF4MzhkVnVCYk4y?=
 =?utf-8?B?TWFvRFVVbzJhWjBSNlNnOEoyVUZKdytTTFZjWHJlRllVVVRRVDVzeFg1NjhJ?=
 =?utf-8?B?QTlCTmQwT2h1a0FuWTFnYURtblhrelc5d2R4VWhhbnZGbFZlWFZwY3ltRlBE?=
 =?utf-8?B?RE9PMEoxU2hsWE4zZG9WVnFySy9uS01GeTRaOElwTE1GVDd6TGcrYWZ2Mlhk?=
 =?utf-8?B?MlhTTmIvaGVDQ21DU3B2TXhqTlh1NTJRQmMxRzRCeUVmbWI0cFNTeTBSd1Q0?=
 =?utf-8?B?YUM4eENxNUx0UVVzczJjSzZhV3hHWnZxR3JMRkpyV1kxMEVoKzlDV051NVBU?=
 =?utf-8?B?WW0wTG5DUytET1VoUVZKQnZhV21yTXMxcnp3aEwrMU56S3MzaURnT0YxaGlr?=
 =?utf-8?B?YytUQ1VXb203aXl2THdnRjZPK0UyNEZQdHc0bkNCOSsrOHF5bjQ3d0kvQzQ2?=
 =?utf-8?B?aWl3d2t3VVJpMU1XYmVwOGpZZVdsU2txcFJQRDlyZHJsejdUVlpzN245VGVr?=
 =?utf-8?B?Z0pkNmxGTGRQQS94N3NUNS9ZR2dPRThXU3NRdERMdEZGbzdKNTlWRW12ZGJY?=
 =?utf-8?B?azRydW9uSkJTYVRQaFUrY01kVW9ObHZxbyt4Y2s4MlV0dTNZaFNLTE5jZVQ4?=
 =?utf-8?B?WllaeU9UbDlid25HZVBING9kM0toVUErZ1N1UzBOaFZvcGZZRU1YcGFzKzBj?=
 =?utf-8?B?R2plS2lOVUZnSjU0KzA4UytsOXhiQjVDTXZIMldJVWhDL3hVSnhUUndacG04?=
 =?utf-8?B?THVvdkRoZDE1L0Z6dmgvaGxBZmhldGZwWnBiaitJR2RHSTFBNmF4OFlENXc0?=
 =?utf-8?B?czh4cGRGcHcyZG10T1h0K0lPcm9lVDNPRXUwZXVhd3E0Q2hjRkM1eHlFTER5?=
 =?utf-8?Q?FJkjtbfIfWbhjRiSvF?=
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49e87aa7-48ab-4395-3f62-08df1dd88817
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB4479.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 03:19:54.4965 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JiZ100nc05pNGOObdNYLV/hivQT80mcj6VLbEBQ3roUpS3oqZFAZpBwUe847Tmg1r0/ZpDUX3LmsWBsDZNCrwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR18MB365644
Received-SPF: pass client-ip=2a01:111:f403:c10c::1;
 envelope-from=kchiu@axiado.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, URIBL_SBL=1.623 autolearn=no autolearn_force=no
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

Hi reviewers

Please help to review this patch set
[v7] Add Axiado SoC AX3005 and EVB | Patchew 
<https://patchew.org/QEMU/20260911051532.2378501-1-kchiu@axiado.com/>

Kuan-Jui Chiu 於 2026/9/11 下午 01:15 寫道:
> This patchset introduces Axiado SoC AX3005 and evaluation board for emulation
> The model for Axiado SoC AX3005 supports
>    4 Cortex-A53 CPUs
>    Arm Generic Interrupt Controller v3
>    9 Cadence UARTs
>    1 SDHCI controller with PHY
>    8 Cadence GPIOs
>
> Refer Axiado website for more product information
> https://axiado.com/products/
>
> and minor changes for the compatibility with existing AX3000 SoC model
>
> Test plan:
> 1. Verified the machine "ax3005-evb" with following command
>
> qemu-system-aarch64 \
>      -machine ax3005-evb \
>      -device loader,file=bl31.bin,addr=0x88300000 \
>      -device loader,file=tee-raw.bin,addr=0x88400000 \
>      -device loader,file=u-boot.bin,addr=0x80000000 \
>      -device loader,file=fitImage,addr=0x80100000 \
>      -device loader,file=obmc-phosphor-image-evk-ax3005-qemu.squashfs-xz,addr=0x80B00000 \
>      -device loader,cpu-num=0,addr=0x88300000 \
>      -device loader,cpu-num=1,addr=0x88300000 \
>      -device loader,cpu-num=2,addr=0x88300000 \
>      -device loader,cpu-num=3,addr=0x88300000 \
>      -nographic \
>      -serial null \
>      -serial null \
>      -serial null \
>      -serial mon:stdio \
>      -drive if=sd,file=obmc-phosphor-image-evk-ax3005-qemu.wic.qcow2,format=qcow2
>
> 2. Run QEMU test suite
> make check
> Ok:                360
> Fail:              0
> Skipped:           21
>
> make check-functional
> Ok:                31
> Fail:              0
> Skipped:           6
>
> Changes in v7:
>    1. Add patch ("hw/arm/ax3000-soc: Revise variables accodring to QEMU idioms")
>       to revise the name of the first member in struct and remove redundant
>       typedef keyword
>    2. Add Prasad Bolisetty into maintainer list
>    3. Fix typo
>
> Changes in v6:
>    1. Drop patch ("hw/sd/axiado_sdhci: Add header guard") since it had been
>       merged
>    2. Remove redundant machines-qom.h
>
> Changes in v5:
>    1. Add patch ("hw/char/cadence_uart: Add BXRS register definition") to add
>       BXRS register into CADENCE UART model and add new property to control this
>       feature.
>    2. Drop patch ("hw/char/cadence_uart: Reserve MMIO with dynamic size")
>    3. Add patch ("hw/arm/ax3000-soc: Enable BXRS support of CADENCE UART") to
>       enable BXRS support in Ax3000 SoC
>    4. Add patch ("hw/char/cadence_uart: Reduce the size of MMIO to 0x80") to
>       change the MMIO size to 0x80 from 0x1000.
>    5. Add patch for Ax3000 SoC
>       ("hw/arm/ax3000-boards: Add modify_dtb for discontiguous memory") to fix
>       memory issue while -dtb option is applied
>    6. Add patch for Ax3000 SoC
>       ("hw/arm/ax3000-boards: Remove redundant pointer from struct") to create
>       SoC instance during init() and remove redundant pointer from struct
>    7. Add document for Axiado SoCs and EVKs
>    8. Add functional test for Axiado SoCs and EVKs
>
> Changes in v4:
>    1. Add patch ("hw/char/cadence_uart: Reserve MMIO with dynamic size") which
>       allow other models to revise the MMIO size of Cadence UART
>    2. Change the MMIO size of Cadence UART to 512 KiB in Ax3000/Ax3005 SoC to
>       resolve the overlapping region issue
>    3. Add memory guard in Ax3000/Ax3005 EVK to check the memory size specified by
>       -m option and set the default_ram_size to the RAM size supported by Axiado
>       SoC
>
> Changes in v3:
>    1. Remove patch ("hw/arm/ax3000-soc: Add missing class_size to TypeInfo")
>       because it was fixed by commit 4f50d637e2
>       ("hw/arm/ax3000-soc: fix heap overflow from missing class_size")
>
> Changes in v2:
>    1. Add patch "hw/arm/ax3000-soc: Add missing class_size to TypeInfo"
>       to fix incorrect class size
>    2. Add missing class_size "Ax3005SoCClass" to ax3005_soc_types
>
> Kuan-Jui Chiu (13):
>    hw/char/cadence_uart: Reduce the size of MMIO to 0x80
>    hw/char/cadence_uart: Add BXRS register definition
>    hw/arm/ax3000-soc: Enable BXRS support of CADENCE UART
>    hw/arm: Rename ax3000-boards as axiado-boards
>    hw/arm/ax3000: Specify SoC name in header and variable
>    hw/arm/ax3000-boards: Add memory guard
>    hw/arm/ax3000-boards: Add modify_dtb for discontiguous memory
>    hw/arm/ax3000-boards: Remove redundant pointer from struct
>    hw/arm/ax3000-soc: Revise variables accodring to QEMU idioms
>    hw/arm: Add Axiado SoC AX3005
>    hw/arm: Add Axiado Ax3005 EVB
>    docs/system/arm: Document Axiado boards
>    tests/functional/aarch64: Add functional test for Axiado EVKs
>
>   MAINTAINERS                                   |   6 +
>   docs/system/arm/axiado.rst                    | 128 ++++++++++
>   docs/system/target-arm.rst                    |   1 +
>   hw/arm/ax3000-boards.c                        |  71 +++++-
>   hw/arm/ax3000-evk.c                           |   4 +-
>   hw/arm/ax3000-soc.c                           |   5 +-
>   hw/arm/ax3005-evk.c                           | 115 +++++++++
>   hw/arm/ax3005-soc.c                           | 226 ++++++++++++++++++
>   hw/arm/meson.build                            |   6 +-
>   hw/char/cadence_uart.c                        |  17 +-
>   include/hw/arm/ax3000-soc.h                   |  13 +-
>   include/hw/arm/ax3005-soc.h                   | 102 ++++++++
>   .../arm/{ax3000-boards.h => axiado-boards.h}  |  10 +-
>   include/hw/char/cadence_uart.h                |   4 +-
>   tests/functional/aarch64/meson.build          |   4 +
>   tests/functional/aarch64/test_ax3005_evb.py   | 140 +++++++++++
>   .../functional/aarch64/test_axiado_scm3003.py |  62 +++++
>   17 files changed, 889 insertions(+), 25 deletions(-)
>   create mode 100644 docs/system/arm/axiado.rst
>   create mode 100644 hw/arm/ax3005-evk.c
>   create mode 100644 hw/arm/ax3005-soc.c
>   create mode 100644 include/hw/arm/ax3005-soc.h
>   rename include/hw/arm/{ax3000-boards.h => axiado-boards.h} (71%)
>   create mode 100755 tests/functional/aarch64/test_ax3005_evb.py
>   create mode 100755 tests/functional/aarch64/test_axiado_scm3003.py
>

