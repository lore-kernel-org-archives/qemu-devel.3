Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7009ED5CCA9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 13:09:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t68R5-0008Ed-Qb; Wed, 30 Oct 2024 09:08:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michal.simek@amd.com>)
 id 1t61ep-0002kD-Km; Wed, 30 Oct 2024 01:54:15 -0400
Received: from mail-dm6nam12on20616.outbound.protection.outlook.com
 ([2a01:111:f403:2417::616]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michal.simek@amd.com>)
 id 1t61en-0000UH-C3; Wed, 30 Oct 2024 01:54:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yIc8kio67Bfhy82sbDxW+i/1lIdF6W/wbIJxQdc31MZAxqqQXTiZ15yD53DGDBIopHyhQaocQgF3c+xyjmE3eFz5dUboOzQZJht1lLEJ+YGH2GBRMDe55sWh/p7tW1FxIPfkaiFL+cS0tskDuTC/czDslYy9SlBM4phVAHFDZhzX1F1tcy/wGCxhprfDrHTQwbhpyyk/adni4j/xkuRqi3z0GbxauBaGhG/FzpxWUt8XZOnvh+z1DFlk53Za86IZOEPYfro2fEm6wjeSY3eIL1jSsXm19KYF8Qn+ru18kg/Ro7LkksDFVbLckH1dKO0EYEAgo1HjymwTz9yObnRovQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NLUCQEnGvkvDSs0ieSZrRhrQdzxTek573oFWc+6c9iQ=;
 b=sOFpF36tdYe0tkYo2l6I4gzUDkWalvjOZUWHwdOlRuyMkB4E6G+C52QHnxntwrmtJ45RtHvD9KbwQ9TfubYSzayPK+mdyffCWd1gDDsSuM6CzzQAE5gv5PNzFlsHjI0Q4Dx1mck8OpiarQpA66L/G97vNtCFwgoRMESVrtp+FCliR4l6YTV9qXACrsdqLfFao5x+DT4f1pgIQ4l84YtCGg4GcRcBSm22fgiVeBHBmCR3+REzCAaNG0OWC3zZzCfzig01c5aslfmf69cXql3gRfcqPG1KA5+hLO6wvht/SyXsTwTX6iARZRai70KJJm2vrjwusmMbFY1uihyVMreNcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NLUCQEnGvkvDSs0ieSZrRhrQdzxTek573oFWc+6c9iQ=;
 b=DTZa/fSQPNphrGcClFOavmt3brDPuH6Ei8jqaVDJ7EX2sgNvLibWxe0xpKGK7yWrxxQDiBWd1NpfGq93aU4P+uHXUpS+AdhRiTj7Y/u2tdP6fgmP8ju4JeN9y4Fy4SJ+UNq7ltA2vmKOzvCBoFqceuT0E+f82Vz61fn+j94HWWY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by BY5PR12MB4049.namprd12.prod.outlook.com (2603:10b6:a03:201::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Wed, 30 Oct
 2024 05:54:02 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 05:54:01 +0000
Message-ID: <7dbcb2de-89f9-445b-a096-2a3d03a2dfe7@amd.com>
Date: Wed, 30 Oct 2024 06:53:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/riscv: Add Microblaze V 32bit virt board
To: Alistair Francis <alistair23@gmail.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20241017072507.4033413-1-sai.pavan.boddu@amd.com>
 <CAKmqyKNfoakaJ66PCN49x5+=gVkAnQVV1UWTdPe7ARr3RA8ouA@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 xsFNBFFuvDEBEAC9Amu3nk79+J+4xBOuM5XmDmljuukOc6mKB5bBYOa4SrWJZTjeGRf52VMc
 howHe8Y9nSbG92obZMqsdt+d/hmRu3fgwRYiiU97YJjUkCN5paHXyBb+3IdrLNGt8I7C9RMy
 svSoH4WcApYNqvB3rcMtJIna+HUhx8xOk+XCfyKJDnrSuKgx0Svj446qgM5fe7RyFOlGX/wF
 Ae63Hs0RkFo3I/+hLLJP6kwPnOEo3lkvzm3FMMy0D9VxT9e6Y3afe1UTQuhkg8PbABxhowzj
 SEnl0ICoqpBqqROV/w1fOlPrm4WSNlZJunYV4gTEustZf8j9FWncn3QzRhnQOSuzTPFbsbH5
 WVxwDvgHLRTmBuMw1sqvCc7CofjsD1XM9bP3HOBwCxKaTyOxbPJh3D4AdD1u+cF/lj9Fj255
 Es9aATHPvoDQmOzyyRNTQzupN8UtZ+/tB4mhgxWzorpbdItaSXWgdDPDtssJIC+d5+hskys8
 B3jbv86lyM+4jh2URpnL1gqOPwnaf1zm/7sqoN3r64cml94q68jfY4lNTwjA/SnaS1DE9XXa
 XQlkhHgjSLyRjjsMsz+2A4otRLrBbumEUtSMlPfhTi8xUsj9ZfPIUz3fji8vmxZG/Da6jx/c
 a0UQdFFCL4Ay/EMSoGbQouzhC69OQLWNH3rMQbBvrRbiMJbEZwARAQABzSlNaWNoYWwgU2lt
 ZWsgKEFNRCkgPG1pY2hhbC5zaW1la0BhbWQuY29tPsLBlAQTAQgAPgIbAwULCQgHAgYVCgkI
 CwIEFgIDAQIeAQIXgBYhBGc1DJv1zO6bU2Q1ajd8fyH+PR+RBQJkK9VOBQkWf4AXAAoJEDd8
 fyH+PR+ROzEP/1IFM7J4Y58SKuvdWDddIvc7JXcal5DpUtMdpuV+ZiHSOgBQRqvwH4CVBK7p
 ktDCWQAoWCg0KhdGyBjfyVVpm+Gw4DkZovcvMGUlvY5p5w8XxTE5Xx+cj/iDnj83+gy+0Oyz
 VFU9pew9rnT5YjSRFNOmL2dsorxoT1DWuasDUyitGy9iBegj7vtyAsvEObbGiFcKYSjvurkm
 MaJ/AwuJehZouKVfWPY/i4UNsDVbQP6iwO8jgPy3pwjt4ztZrl3qs1gV1F4Zrak1k6qoDP5h
 19Q5XBVtq4VSS4uLKjofVxrw0J+sHHeTNa3Qgk9nXJEvH2s2JpX82an7U6ccJSdNLYbogQAS
 BW60bxq6hWEY/afbT+tepEsXepa0y04NjFccFsbECQ4DA3cdA34sFGupUy5h5la/eEf3/8Kd
 BYcDd+aoxWliMVmL3DudM0Fuj9Hqt7JJAaA0Kt3pwJYwzecl/noK7kFhWiKcJULXEbi3Yf/Y
 pwCf691kBfrbbP9uDmgm4ZbWIT5WUptt3ziYOWx9SSvaZP5MExlXF4z+/KfZAeJBpZ95Gwm+
 FD8WKYjJChMtTfd1VjC4oyFLDUMTvYq77ABkPeKB/WmiAoqMbGx+xQWxW113wZikDy+6WoCS
 MPXfgMPWpkIUnvTIpF+m1Nyerqf71fiA1W8l0oFmtCF5oTMkzsFNBFFuvDEBEACXqiX5h4IA
 03fJOwh+82aQWeHVAEDpjDzK5hSSJZDE55KP8br1FZrgrjvQ9Ma7thSu1mbr+ydeIqoO1/iM
 fZA+DDPpvo6kscjep11bNhVa0JpHhwnMfHNTSHDMq9OXL9ZZpku/+OXtapISzIH336p4ZUUB
 5asad8Ux70g4gmI92eLWBzFFdlyR4g1Vis511Nn481lsDO9LZhKyWelbif7FKKv4p3FRPSbB
 vEgh71V3NDCPlJJoiHiYaS8IN3uasV/S1+cxVbwz2WcUEZCpeHcY2qsQAEqp4GM7PF2G6gtz
 IOBUMk7fjku1mzlx4zP7uj87LGJTOAxQUJ1HHlx3Li+xu2oF9Vv101/fsCmptAAUMo7KiJgP
 Lu8TsP1migoOoSbGUMR0jQpUcKF2L2jaNVS6updvNjbRmFojK2y6A/Bc6WAKhtdv8/e0/Zby
 iVA7/EN5phZ1GugMJxOLHJ1eqw7DQ5CHcSQ5bOx0Yjmhg4PT6pbW3mB1w+ClAnxhAbyMsfBn
 XxvvcjWIPnBVlB2Z0YH/gizMDdM0Sa/HIz+q7JR7XkGL4MYeAM15m6O7hkCJcoFV7LMzkNKk
 OiCZ3E0JYDsMXvmh3S4EVWAG+buA+9beElCmXDcXPI4PinMPqpwmLNcEhPVMQfvAYRqQp2fg
 1vTEyK58Ms+0a9L1k5MvvbFg9QARAQABwsF8BBgBCAAmAhsMFiEEZzUMm/XM7ptTZDVqN3x/
 If49H5EFAmQr1YsFCRZ/gFoACgkQN3x/If49H5H6BQ//TqDpfCh7Fa5v227mDISwU1VgOPFK
 eo/+4fF/KNtAtU/VYmBrwT/N6clBxjJYY1i60ekFfAEsCb+vAr1W9geYYpuA+lgR3/BOkHlJ
 eHf4Ez3D71GnqROIXsObFSFfZWGEgBtHBZ694hKwFmIVCg+lqeMV9nPQKlvfx2n+/lDkspGi
 epDwFUdfJLHOYxFZMQsFtKJX4fBiY85/U4X2xSp02DxQZj/N2lc9OFrKmFJHXJi9vQCkJdIj
 S6nuJlvWj/MZKud5QhlfZQsixT9wCeOa6Vgcd4vCzZuptx8gY9FDgb27RQxh/b1ZHalO1h3z
 kXyouA6Kf54Tv6ab7M/fhNqznnmSvWvQ4EWeh8gddpzHKk8ixw9INBWkGXzqSPOztlJbFiQ3
 YPi6o9Pw/IxdQJ9UZ8eCjvIMpXb4q9cZpRLT/BkD4ttpNxma1CUVljkF4DuGydxbQNvJFBK8
 ywyA0qgv+Mu+4r/Z2iQzoOgE1SymrNSDyC7u0RzmSnyqaQnZ3uj7OzRkq0fMmMbbrIvQYDS/
 y7RkYPOpmElF2pwWI/SXKOgMUgigedGCl1QRUio7iifBmXHkRrTgNT0PWQmeGsWTmfRit2+i
 l2dpB2lxha72cQ6MTEmL65HaoeANhtfO1se2R9dej57g+urO9V2v/UglZG1wsyaP/vOrgs+3
 3i3l5DA=
In-Reply-To: <CAKmqyKNfoakaJ66PCN49x5+=gVkAnQVV1UWTdPe7ARr3RA8ouA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR07CA0254.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::21) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|BY5PR12MB4049:EE_
X-MS-Office365-Filtering-Correlation-Id: df480289-8df0-4e99-7da0-08dcf8a740f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QW5iemJUSGR2cHBqNkxDTUROSWt1VWlpRTZ2NTRKVXdoNndzVUxrdEF0RUhy?=
 =?utf-8?B?akJOTTg4RytURVZlUlI3T0xnMUJsblNQV3NCQVZLMGczRWlYclRkZHFMek5h?=
 =?utf-8?B?RUdhVHVqaXVJTm0vUDRvYTJodWZqTGFLNU9VVDlXdGlpMWIxeklYSVJNbGNT?=
 =?utf-8?B?UVBnOG9HNlZzclA5UEhzTWo0bFJTeTR4eTBGT2Q5ak5BdzVDclp6RnMzdGxN?=
 =?utf-8?B?dTNkV3c3T3FNUStRSUtEQitBZlloQUUrOVptaTFMSjVCTmt4OG9Zd2hlL09T?=
 =?utf-8?B?bll3eFNBTlFweUU3VEIvSnV3cGdpNVlsc0pGM3FMa3FrbWx6eTU4cDE1OXJH?=
 =?utf-8?B?TGl1cjMyMlBzOVRpRFllL1l2VWlFbzIwdEdPeFNnemdpYk82SWxoN0pnaXhM?=
 =?utf-8?B?eE1VVXhtQnFWdUxvZHFRdGpVZkVreWRiOStCZlBCR2lQWEVub3ZKYUV2L2p2?=
 =?utf-8?B?OFNEUGlhTmlnWThnT0d2VzdpemVYekFFRjVZc3F3YzVId2pKOGdnMEF4cTlM?=
 =?utf-8?B?MFdCWDhHZ1duN2ZxUTNzZ1ZWMWdVNVZhWDcwMU5ENkhmNmRJdjRsNnhsMjE4?=
 =?utf-8?B?eGNKYUdnRUZiUy95bHNIQTdraE5USThDOTFzNEw3K3gxQzNxUjFDRXJGc1pL?=
 =?utf-8?B?bzVmUDZIdEQzNS9LQWk0YkduU2ZxWHRSRiswMHdUR01leVhwaGZROWNvU3J3?=
 =?utf-8?B?NG9DSnFpRUpMcUFSdUlRQXQzMm9PQWhEdDFLRFh2Y0xmQWFwbTFMSWcxQVJw?=
 =?utf-8?B?WlJ2V3drS3Y5SERNTEJHekdCREZkOTYxZ3o4SURsL1VzcWJOdUtURmxyMVRk?=
 =?utf-8?B?K1QzYXBDdEtQdmw0SytuNVQwUWpKRVVLZGFuaGNZNHhZTURoR0oyUkg0L3FH?=
 =?utf-8?B?WkU1THorU3NqZ3ZZTWpmU2RpWmxidEMzVUhya0JtSEJOTlR6TGxnWU1hYUt4?=
 =?utf-8?B?bWsxTFBxL1BRM3pmZG8rTHRtWDdxSThVa20vYjduRjhzNWtta0JTKzVUaEpN?=
 =?utf-8?B?MklPZnJVTHdDdFY0SmswM0VLN1lIYlVTWHM3Qmd2K3hGNTZ2cEZvL2xDLzl2?=
 =?utf-8?B?Q0hXdm12VUI4NnNMaUM3MHNhQUdnZ2prTFU3Z3V4MzV0cmVvQzRwVWF3QW1x?=
 =?utf-8?B?aE5YMEZKa0hmbEgwYkZ4dVM2N2Q0N2dDY0tkWENIMmY4alRrUTFWVStzRFNT?=
 =?utf-8?B?RTB3Q29LTXR6M2l6bWltSUVwaGd1UjFYYlZHdkU3YWpuS3R3UWFMQ1NBNU55?=
 =?utf-8?B?NFg4bDN5SWRsRngxMWJMcit5L1AxUzVWTlRGU3NUSTBZVU8vRERWTU1saTFN?=
 =?utf-8?B?WlNtMGxxMlBtR3lZWEF2SW1xN1lWVE1qemhXbnFzSm9laGsxVjNOS1h3UWlC?=
 =?utf-8?B?c08rbTBPR2VrZ1MzeTlHL0diRG9aelZZeGcyY21HT2F4c2RZS3krK2dnZDds?=
 =?utf-8?B?TnVtaHBPZTJZSVJuM2ZmRzJsZUg5T0p4SmZiVDhJY2c3V0p5NHVoZ3g0ZFhZ?=
 =?utf-8?B?azZ2NW1zL3dZT1VyU3FIZEduMmVRSStVWlBveXdWdWJRR21PbkJvYWNsS2tL?=
 =?utf-8?B?L3ZaWHY1WGU0RHNDeHYrOCs5THY5MHVxdUd0blpiOWpKUFJxR2ZobFV2eVVt?=
 =?utf-8?B?L01Sc2VrbmhRa0pYVUxXdmdneG5mTWkxREhzVjRGUC9lck1JZU5FL1JsaUlS?=
 =?utf-8?B?KzZYRmREdlNDckdsbmd5UWJUOVA4d0Z6YVVIZnVnOWZCTlZMeWd0YUkxNmQr?=
 =?utf-8?Q?yQialWxDZYwtIPh60CCT03qNRibjz2oU2eWA/4p?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0xQMlNTaUdXNjlLdm9nV0FJU0tQZE41UVJ2aHQrS0JCWUQ2RDdOR2o5RTJj?=
 =?utf-8?B?V3dVc1dzV0MyZzJFaWpERW83WEpzOUhpSWJzeW4xbjF4NTRLdkJrdXpod3dL?=
 =?utf-8?B?TWdRQWVZa0hGZzd6VmxzcU5Zdlp6SWxZK2Q5RmljeCszSG9tTTZHR245VHFh?=
 =?utf-8?B?Q0FVcCtGU1h4VG5aT1hjQlVQdmdUTG5LNGVlTk5wOFJsVUNtUEh1ZWZlZkFs?=
 =?utf-8?B?NTEra3FuQmZac0dMd3RqR01BWGJtZ082WlVkQjhlcHdaNWJvZURsM0RjQ2ZP?=
 =?utf-8?B?dU5ZT1FIQURVVjdGbW5KOHZycHVnVUdKOGZrZ3ZMNzFNemJYTWdsQjVWdTJM?=
 =?utf-8?B?eXpBSzdRc09oUk9SUmNrZ3pvY2NlaFpPdWVBSTV1SlZ5MkdPajMzaUdER0J6?=
 =?utf-8?B?UnNDMnA1RXhXWUFlbHJsZU9SUE1QNjJqZ2pBQ0RuM3ExcmZpOTdDdTdwSDNm?=
 =?utf-8?B?RGRMUTFZMVpPaG9VcFVYN2RvYTlWU2V5RzRmampZMjBEY1VXZ2UxYS9CdjNS?=
 =?utf-8?B?NFVUeGFTSXBMRWhHenFVY3ZMMEZqRU13amF1M2p0VkxMdW5ObVcwMExTa1VS?=
 =?utf-8?B?OUN0SzVJUnU0aFo4QVl3TkpxZ3dNdUQ5ckRuRjVQOEd4Vk1pTDd1QlhJTEEz?=
 =?utf-8?B?d1lKdkUwSXJqTVpubU1BRTZYQzBObHFlYVBaamRvc0xIUVU1UTh6bEJEMDB5?=
 =?utf-8?B?c0RYSC9TdnF2ZU1XVWt3b2YrZ2JUdzhpeE1pQzdzUURhbEM3dTMzTTFLb212?=
 =?utf-8?B?RmNlaDdaMHRpaC93SlNvSDlMSjJFOGdtZmNsdEhWN0pLSGJ5M04zNlFtY1F0?=
 =?utf-8?B?WktCS1lxTTlUaVRBNCtXemVqajJpRE1oVlh4V2V2NWFGVC82TnpzQmdzRDBQ?=
 =?utf-8?B?Y1QzSmc5UlY5bVl4TURIeGFWVC9Ja3RBQUhDTmNZVWZCU0dQZlN3SGxxY0c3?=
 =?utf-8?B?UUkwSU5oZ0NHV3RDd09mVzJHbVgxeFNwaGp3QnRqbHh3NVlueVd6UWtFS1Ri?=
 =?utf-8?B?dk5GZkZ3aThDWkVyWUVoYkdyV1ljTENwMUNVVi9KbndWQ291Wi9FUW1YOXVp?=
 =?utf-8?B?bEtxQnhyeHc2SkJsYW9YS0VEdDJCVnlQWCs3N2FCVlMreWIxejNzMC9XYXpu?=
 =?utf-8?B?WE9RT1dXaERoYUw3anVFRkFXUDBod3pvTTlibGxzSUUramJvU2t2TzdaTkRH?=
 =?utf-8?B?SWVkRmkxb09XRUo5WUh0TVVCWWc4TG9veTJyQllYNHdocHJ5Mzdic3VkR0I4?=
 =?utf-8?B?a0VEUFh4TWhZbDlxOWhHTDFTNEhzTzd3YUtwU2M1RG52Zng0WXlxR1J5cEhn?=
 =?utf-8?B?SjZJOG8yTVhkTVdzcTZtSWR1NFVld0krc0RLZ2pwZmEyRmhoVlNHUlAzYkYr?=
 =?utf-8?B?MXFmdVExSlFxcFhQMmtzd2d6QzlXRHZzQ1BxN2UwSDlXenFYa01hYm1HRTlR?=
 =?utf-8?B?NmNpTXdwVE5vbGtYWW9XWVZrdEF5d3lhNW50dVdjOWZSSzFLVWM0MklXSEFm?=
 =?utf-8?B?TVZWakhWNlQwYWR4MWdKcUNESVRoQW1UcDhiNEN1ODVkWDhHMG41VVBTTHlN?=
 =?utf-8?B?aUpZZDR1QVB6YUs5UXNpV2VrRTJUNjc1TzYwVExFUjk3dVd5S2J0T1hYa0Vo?=
 =?utf-8?B?ZUFxMGI2R200amtVUmZFN3ZQU0c3TzdpTWU1QUlpNlRGcUxodVdGSHFKUk5l?=
 =?utf-8?B?aGZiYm9ubGcxV3ZFbFpVK0xnRlhiU3gxNnNQWVh2K1FrMytZM0lEdEI4a3RQ?=
 =?utf-8?B?b0FNcUNrb2p3a21wUjVxc1IxaS93Sll2VGFoYmNNS0t1Z2tKekFIUlFtNHVQ?=
 =?utf-8?B?VjJRUGEybzhFL2l3NTJxcmFhcUdRU3BvMnpUcUlPZjU0ME5DenFZRGtxbExP?=
 =?utf-8?B?MmlwN0psVVNmSVVwU040UnkyQy9zckhQZXdrS25HZjVUT3JxK2pZRXFPZmps?=
 =?utf-8?B?VG9qb1E5c2VJVEp3NmE3ZjI5SVUrdTVtU1RDazVUa0VkV0hlcURXQU55bVVl?=
 =?utf-8?B?aFRVWWJsVVhHL3FXQmZxS1VRdTdmQzVDdU9NbzNvNmhUOHhxUTVEV3kvb05E?=
 =?utf-8?B?VHlwQStxOXZjNC9SbENEdzR0U2ZYTkFXU1l3YkhmMmpiaWh4UzE3YjhmbTRs?=
 =?utf-8?Q?ftUk3yKmo7gYenRKhWA//iCp3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df480289-8df0-4e99-7da0-08dcf8a740f2
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 05:54:01.5192 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PvnGV+qk/rfm7tUGdc5MBaCgIkQxxkkJaIcdW+gPVTMPweQmtrwoW7Ah04fDoq/X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4049
Received-SPF: permerror client-ip=2a01:111:f403:2417::616;
 envelope-from=michal.simek@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.302,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 30 Oct 2024 09:08:29 -0400
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

Hi Alistair,

On 10/30/24 03:54, Alistair Francis wrote:
> On Thu, Oct 17, 2024 at 5:26 PM Sai Pavan Boddu <sai.pavan.boddu@amd.com> wrote:

>> diff --git a/hw/riscv/microblaze-v-virt.c b/hw/riscv/microblaze-v-virt.c
>> new file mode 100644
>> index 00000000000..6603e6d6b06
>> --- /dev/null
>> +++ b/hw/riscv/microblaze-v-virt.c
>> @@ -0,0 +1,181 @@
>> +/*
>> + * QEMU model of Microblaze V (32bit version)
>> + *
>> + * based on hw/microblaze/petalogix_ml605_mmu.c
> 
> Just a question, are you sure the virt board should be based on the
> petalogix_ml605_mmu?

It is definitely based on ml605 and it is fair to say it and keep origin 
copyrights around.

> This will be the reference Microblaze V implementation in QEMU, and
> the petalogix_ml605_mmu might be a bit old now. It also uses a lot of
> the Microblaze architecture components (like the interrupt controller)
> compared to the RISC-V architecture components which might cause
> issues for you in the future.
> 
> Just something to keep in mind

And the reason is that it is really design like that in design tool (Vivado).
There is no risc-v specific interrupt controller use but origin axi intc used in 
origin Microblaze designs. Timer is the same story.

ml605 board and it's chip is old but IPs which are used are still supported and 
used in new designs.

And regarding using virt in name. We can create design like it is described but 
it is not going to work on standard evaluation boards without extra fmc cards 
for example.
It means word virt is just description that it is not really target any specific 
board. Definitely name can change and suggestions are welcome.

Thanks,
Michal




