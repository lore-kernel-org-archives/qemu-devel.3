Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90797EDF172
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 15:32:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqv96-00049P-LF; Fri, 13 Feb 2026 10:31:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vqv93-00048U-Tu; Fri, 13 Feb 2026 10:31:49 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vqv8y-0004G1-P3; Fri, 13 Feb 2026 10:31:48 -0500
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61D7mExD169960; Fri, 13 Feb 2026 07:31:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=JgbZnLPZIctb4PDQa2XlIXhvvmL7nxIzTr2nE1Ptt
 sY=; b=i5iXv2XokCVi+RB7jN8LAPFExB1t4ZDMjQ4lJ9n/dCv86sQvG8UzS5/K+
 +XdfnE9xGsFmH9MH1dOaIhRhCPLkq5FoPzte55VO4NaHeR22Qf+CGJ61YVRnlgBs
 wxGpRPtraF6X0mPcpC+LpLwhzpGU5RKms0b76xmTxg8amnYT7sUv0KK1vZjMV523
 v4HtUtx2zwdDztCO86bJvxOTDVhvrel46VfG5T3CLDq9WwVYic/PQb+F2nrRcZDy
 wHPMrR2i95NzZfRXrzQBC2C0r1AoFsQCLYdNTqVCftQibiHggon/vZU9RMZLuzZB
 r45iPNYx/HZN69vvN6TF46IJ1ZXiA==
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11020108.outbound.protection.outlook.com [52.101.61.108])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4c9yvvs295-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 13 Feb 2026 07:31:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yLPImF/IbDvy0NDbCuaToDYR6TZAZbQQdU4MYGCi39ERFayDyGiei0P5iYTLFWH6pAYxEV3ao8hHy4QeQ+tNsI0nw4QxnaxqCijlqYI6sRb1rpPa3NsK8eaDU1J8FprWlsfldO1rVZ2p+JWyZhXnglLrjXIFwrM6/zSUOLSAzt48dAbMNeNZrSGP7KO/ZduAbDLigjkMSPvS1Y3Ek6Uw399NOS2kZSRxFcZwBhIKZcByDV7IiQC1IojG7aDQ+Yi9p9Y0gQm+7z4fzxBW5u7PGJWgQ59LXHD9Ttts6FFg5We+M8h7GysilWMLMc+Ey7piR8av+hKU1SOG6icS87mJvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JgbZnLPZIctb4PDQa2XlIXhvvmL7nxIzTr2nE1PttsY=;
 b=NlJC1Al/j7d11M3FyMRVmHmJAgyPa51rAsq5G5Fz8W0AwCV+FvT0U0r6PSyaw7RbGGROaRjQaR0sKC6yA4JnmNEVyttIEo22luaB/v6DCvtQ7nWIHkOqQyqmssZKlETrBPYTbZbElDy4yqKJd4xiymbjiSdW6gyZwZg2QJiSJm7rQ8kg1ED3lQpgz5xLx1/IvOpcTHTxcyeo1PeGkp9d/gZr4+Tq+ZvvQdonSv/xfgfwy/HQeWSinB7p3O0DgJ5tUdF4RhRB6QOi/WouiDvOlc2VKtmz5tTn5YdpeX1SIs7eYRhUiUHB/LC1strHOyey8hX/z7t0XBJiMTx2VpbTqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JgbZnLPZIctb4PDQa2XlIXhvvmL7nxIzTr2nE1PttsY=;
 b=LYmcu82r8a9nWLqUeYNqxUteKqeiWZvmU1YtmKrfWLArM4M4cJXtvHt6HkDzssp5AAIEevWte4I06R6rK0C7exgOmUrER421A8Iqj4Gmx2XCgHKNoeM0noTyN2wVIxcoqQ8yUoCAtFgfbGu8hYu9dVmAPpaGmSqjiU8V40BY0h4JxkSj0+E+gj7cF3aK77EWyMoqriPrHwphfyx3gJ0N2u6HVuSU14y4IvzFryOHZxkT59uWb+K80+bJmrhf2dxmGSZFedQqhwy/+Dgm+KMr+Y9RAznVXjn7EMvQW1pnYJtZ1yTg5zFEoCv13wroH1Y+VAYHFSpk4ictUVGAoEJUHw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SA1PR02MB9830.namprd02.prod.outlook.com (2603:10b6:806:379::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Fri, 13 Feb
 2026 15:31:32 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%7]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 15:31:32 +0000
Message-ID: <757c69bc-1338-4aea-b4aa-9f1f2b242116@nutanix.com>
Date: Fri, 13 Feb 2026 15:31:26 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 32/43] audio: replace int endianness with bool big_endian
 in audsettings
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Thomas Huth <huth@tuxfamily.org>, Alexandre Ratchov <alex@caoua.org>,
 Laurent Vivier <laurent@vivier.eu>, "Michael S. Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "open list:Xilinx ZynqMP and..." <qemu-arm@nongnu.org>
References: <20260127182516.289834-1-marcandre.lureau@redhat.com>
 <20260127182516.289834-33-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260127182516.289834-33-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR11CA0016.namprd11.prod.outlook.com
 (2603:10b6:610:54::26) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SA1PR02MB9830:EE_
X-MS-Office365-Filtering-Correlation-Id: 766c01fd-89c8-4502-547a-08de6b14f726
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SThSMGRma1lUN0hKK0F4QTBTc0ZUb25nVG1RUmsvSjJvOFdWWmhkZmI2UTJI?=
 =?utf-8?B?ZUtLMXlVZWN6MmRLVHdMRFlPUVp6WTROTTl1cWVzV2tzRjdTY2k5R3pwT1d0?=
 =?utf-8?B?aFE0dlo0Z0I3akdPdjJ0L3dYMVZsRThyeDVybm5uVUROcWdmNlE4QXM4c2E4?=
 =?utf-8?B?My8xc3ZmTzIxNWJkTUlXaGdnSDlnUG5vMlR2RGNCZllFa1pXRTF1d1NKQlE0?=
 =?utf-8?B?Y3FSZys0cWNkTEhFMkZHc2Zmbk1vMzE4ekw1M2FqdUdvUEZUOFN2czJIZStn?=
 =?utf-8?B?WXRNOEE2ckFWM3orWXRqeWdzTTBBWXFlMGgyQ24rbktUamdubkt2a1J5ZVlT?=
 =?utf-8?B?cWxnTlkrTmhlbG1FcFlJQTB0azJtOGIrbnJCeG5SUkdWeFFpbVY1WWZMeGhE?=
 =?utf-8?B?anJKUjNVMEJ2NTJFVENpU2hQRXNLUFptV0hqWjE2d28vMkRYN3Y2NSswRDRz?=
 =?utf-8?B?Y0ZQODRoNXhRY1pWbUNtdTRmWW1HbS9PTFpoejU4c3NQbURnQXlzcUhnWmNO?=
 =?utf-8?B?WGFoQnF4Sjk0WmN4NjF5MGtaamZDUnJZV0lFbEFYUzQ5QW1oTW1ZeCtvR2lp?=
 =?utf-8?B?U1pYbjRJTDFkVFZ4RisrTURrY3NIYms4ajBhQ281QnA1eUxERFBLUDVQcDVI?=
 =?utf-8?B?ODhxVk5hWDdpZVZBOUJwRHQ4WHVqaXZjaklYZ01IdlpOSnlEa0dXMTZIL0dE?=
 =?utf-8?B?QXhUaWxuWmFUVjZEZWdwM2RmdXV2NVpFRkh5aUhRVUFFWHcyNmw2VElyQ1RH?=
 =?utf-8?B?YkJha2hhL0V2VUxVSmpmT2hpcGozeTN0ZHdpQUNXR1NSWng5OHQ1VlUrZzlR?=
 =?utf-8?B?WGNvNURDWXc1THlRWHFwVWNaSHpiU0dTSFY4Z1FxblgyRHlnYUcvUm1jaERR?=
 =?utf-8?B?Y2NsYjc4Z09CYUtGWlE5N25ZYVpOOWxPTUxHU3BHL1E0emk2QzRKZ3FrbFhi?=
 =?utf-8?B?Y3R4YTFyT0NYQkU4M04vYTlzVHFZaTU2eVZGbHdSSS9sMG44R2pnNDl4RUNi?=
 =?utf-8?B?ZzRkWVJPWnVWMnBtL3l3Z2ZkMk84N1dnTkV1OUNUQmgzTWxHazRwOXZvejF0?=
 =?utf-8?B?eGFBOFJnN2I2aGFodzJTUGNLdkJsSUNBOGdSTnQyaklDa25jTTFWSU1WU0VI?=
 =?utf-8?B?MTFibnVJa25xa2tMSjlWUy9uaTVqdWtQYlg2RGxMQmQ4cnZxNFowNmYwc2ND?=
 =?utf-8?B?NGhoaEdLNy9ib0ROVUVYZGNEQlg0MUR3TDJjeU9Cb0xlcnZiRC9EbkVUNFFL?=
 =?utf-8?B?QWI2N1l0QU44bElhQmtCbGtFNVJVVVNLcmVHT1hYMUlVNFBIU0hTdkxoSkc5?=
 =?utf-8?B?QXdVMGt6VGdkOUV2U1JKMDNYWWI4c2V4U0xqMGlXd2xMemFPR1pYak1hM0dC?=
 =?utf-8?B?a09FVDl6ZjZhcFcxRHRudTVsazBGQ2EzTjRBdXFEQWhjZUIvU25lOVZOdjBU?=
 =?utf-8?B?WWxvVytsMHRsOWlBeHdxejdscndRMGlZamg3M1BNWjQ0TXF1TmptZUJHa0VJ?=
 =?utf-8?B?cVB3OHM2d1dBcWc0WDBSL09mZmUvUVJUL0pSb0c5UXI3RTkrTGxERExFWFhD?=
 =?utf-8?B?ZEpKeTR6R1JHdURwdldPR0dVSlVHNUhwUXEvcnNvUzNJa3phYjhvbnk1UlRR?=
 =?utf-8?B?ako1TE9Pa0dVaUlhNzE3NUhvOUdnRTZLd24wNFo0Q0xDcVNmTmZvUmRKekRQ?=
 =?utf-8?B?MDNjWUlhOElIdXAyejhhY0NOaXpUS0ZUWmsraGVzMXJUaTdJL3VSbGlqNGlk?=
 =?utf-8?B?QytPalBZNjM5cHVzRWNiOWlVMVF0ZW42Z0pSQXZIVXMvWnN3b3ZicmRDcldF?=
 =?utf-8?B?UFVjTjQ4YW9vL1M2d29xQ3dOMTFORHVWREovUmxkczU2Q3JZTzNTa1FGNE9o?=
 =?utf-8?B?WXluYkZIUFNzdkVKbWsvKy9HdVFpNy90cUZhelpXdmIySlg2NmFuY3FkUzR5?=
 =?utf-8?B?VDdZckw1dkRuK0Q5TnVNWkVZaVZoUFprcnA2aTJmVVlOZVhsNGozVHdSNC9N?=
 =?utf-8?B?elhvTGNjanp1YUQzY2ZGQ1FQMGpraVRPYW84QzRCVmNxQ1lzdVVkVGdVb3o1?=
 =?utf-8?B?WEZuRGQ5eEEvcEpwd2VuUWwzNzg5cEZBSFc5R1lDaHFCQXlZR2pLelJoc1pj?=
 =?utf-8?Q?yqlY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGxlQlFDUVNoRVBmaWx2WTJRaXBWd1VlRk4xWHRZckJBaUZzQWhiRytMOThC?=
 =?utf-8?B?Q1RDdFBrckFyOHArWWlDVkxiYWd6NThWTWU4cUlPUytJcGJCSUdHUG5hNU5w?=
 =?utf-8?B?TmJHWG90eGpROWNRWEdudzk4LzVvd04wSmRva0ozVSs0d3RXZ3E0NlBCT2k5?=
 =?utf-8?B?QmxlZHdHYy9CY3hFcm92TTRYc1FLYWRKMnRVSGtmMDRXdXZrNSttREFXajI2?=
 =?utf-8?B?eHhyenM4ajdJTWR3MG5wUVhWeG54V29CSWsxVHNqTlV5OGtJSGRJQ2s4UDMz?=
 =?utf-8?B?b001RDNQTGswOGF4TS9nci9tbWhTTE5EVXlGMC9XYzFJa0hHNjI1VjFscnN1?=
 =?utf-8?B?TGpCTzQ3L3Y4bk50Z3VpVWJsY05yRnVtN3pmZit5MitQUTZaVE5zVEVBcy9X?=
 =?utf-8?B?dGJjU0s5QnJxcWp3SXFoN2pPcmMyaSszWGIrcFoveGVEZmlENG9hN1dSMmIw?=
 =?utf-8?B?dVZtUTE5TmZ1dTRycjdsOEtVTkg0TnZheEZ1b2RURDVvdkFyYmpEQ1ZNOTJY?=
 =?utf-8?B?RVIzM2VoNk9mRDZqMVd5OFhnM2pNUXpsMDhESmVrdWpaaG44T2tzaTI4UzRn?=
 =?utf-8?B?d1FFVmNucFEybTNMVEVTaWVWKy81WGlCYm1MMllDOE5LRXBBR1lTUEZGcXR2?=
 =?utf-8?B?bWVIV0NySkpSTFc0a0xZeUZYTTRId0lSNXppbDAwejBDY3VONE95RXVESTNR?=
 =?utf-8?B?VW1ISityN3cyTkVlK1Z5M01sQ3g2eFE4emF5Y1VqYnp5ajduZmNXc1VocW9v?=
 =?utf-8?B?dUgyZTFHTjhocWhBWElUSG9nei9scFhSb216ckQ5MlNsMkMrclZzb0pGaWlv?=
 =?utf-8?B?VFZqQi9KQldqdVJkNkszQjUxcExReWRkMmsrNjNzcXdOckZSQVJ5OUZhY2Ir?=
 =?utf-8?B?eWRLbGlZZWlDQVNwQnBadTFoQnFuV3hFZjZscytUblpPZlpYZEpjRTVQcjZE?=
 =?utf-8?B?L0ltdG9EMlJrNk5uaDFkVml5VDhLZXViSHFaYlBWclgvMkJHVTZuS09rUFpW?=
 =?utf-8?B?L0RDVXhEZ3lRd08rak83UFVIMVhIa3BZSFlIc2I3RytHU1RCam5HeXF6ZFB4?=
 =?utf-8?B?Uk95ak5Ka3R2WHppTFMvYnZsMkJyWnRqcTBqSUsrVkYrcWx1VE41Mjhaekxj?=
 =?utf-8?B?WkM0WGtMS2tNY1lwUjJaNWhmS1JKcXZmRVBqQmpPU01pY1NoekFQRU53dnRJ?=
 =?utf-8?B?alpxbHZtdXV2aTdZT2YrOUo0dUxYUHZSUnV2L1VGOCttbjdITmgvcXI3QVNw?=
 =?utf-8?B?K1RUSjVsMUluUUFqOXBrR2tLczdBTzV3UVc5V0pNOEhTVU1nUWsvVmJhSzZs?=
 =?utf-8?B?eDJVR0lWbGRRaXN0b3BrNXZHREV6ZEhsRnN6OTBKc3piVUlEQ01xekpSUnVS?=
 =?utf-8?B?cnVTRURUTkdqbWxTdldLOHhKYmU4VlFRRmI3eThFUkhvRW1oVVVmcURMY3Bs?=
 =?utf-8?B?N2JZZ0ZIZU90YkxCcVQ4Mm9zd21YcnM3Ynd0Q2paSG8vUVlEY3Mrc3hraGl1?=
 =?utf-8?B?eUZPMEV3aXdyaXNDMzh6S2ozbUFxTFhiRWpaZTd0TGdhUUI3K1NlSXA3Q2c1?=
 =?utf-8?B?UU9Na0xoWFdXazYwSldNZ2lueGdRRjZ5a0Fwd1Uza0ZqNDBlWmJ4Z1FPM1RK?=
 =?utf-8?B?WHZLbkhvNDZoZjFxS1VOOU5UTE8wYzRJTi9pQ2VDNVcvVDlyUmtreEFFemRu?=
 =?utf-8?B?TjNadC9BYmZ6ZEkyajdqRmpnK3Fna0NXMFYvUmpicmVIMlVMMDJyb1hjMHNw?=
 =?utf-8?B?MVQ5OUY1MmdnZVovZUw1aUFtRE5GdWIzZEtpdVpVbmp4aE1ubHNMU2VpQTZt?=
 =?utf-8?B?M3dwM1dVOVZrdk1JbjNnOVNkYkpWZHY5Sk1MSms2QkFFNVJIekMzcUhIRDJz?=
 =?utf-8?B?SWhRUVJqQUZCQUpmekhHYnY5L2hMMWlzaDdtRFNqMnhWY2xNVk92bjQ4NWxO?=
 =?utf-8?B?VkFsYmJrVUgrb3IyQWtGVEhtNE9CenltendFNGRwK2JrbjRHY3NsVDBlc0pC?=
 =?utf-8?B?MVIwdzZiSjhnelZwOU05SCthaGR2dElsYWpqaXYxejIxYkpQYzltMjFFVnVy?=
 =?utf-8?B?NjkzYURkN2k2bXRWS2pOWVJqZ3M5clh4a3JtaWJLS1NNakljVUhwUCs0RDlG?=
 =?utf-8?B?Q1l0eVdSRTFNajR0ek5XbDRtNUpSRmw1N2I1MURDb1ZEMnRmNmRFZnlFOE51?=
 =?utf-8?B?eGpYVnB2cXZXN1VtTFRZVXdTSGExZXRLR09tQ2NIZlVIL01HR2UrZjdIMEZ6?=
 =?utf-8?B?TisyaDFrbG1CZ0xYZFo5UjVkL0ptRVNwRFFFTk1HLzhSUlZUdEZUN3g1ZTNi?=
 =?utf-8?B?YTZIRWRlcjlrNmVrSVNOMXE5TUVCU3YzNUoyb0JIaE9SU1p0b0VqRE5DcGZZ?=
 =?utf-8?Q?Lny7kv2Gp3L6Ouac=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 766c01fd-89c8-4502-547a-08de6b14f726
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 15:31:32.4817 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FdBhqBtLmBlmROS/da8a5qMfvtW7eyQHfn9ii0PF6a010IlPThd/1Yef7K4pGaEy2O9rOb11CdYZm+L1I7OvYntbH6sg7Yd9JUg+yiyzwfU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB9830
X-Proofpoint-GUID: Eq8_BYyDTYCC0A_WmdPRrd3eKnDV54mg
X-Proofpoint-ORIG-GUID: Eq8_BYyDTYCC0A_WmdPRrd3eKnDV54mg
X-Authority-Analysis: v=2.4 cv=CegFJbrl c=1 sm=1 tr=0 ts=698f43d6 cx=c_pps
 a=W/yVf4yN/6DpLKuKUOvioQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=0lcSM53cyOudRORREfYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDEyMCBTYWx0ZWRfX4x5UGEnlG9Tb
 fS3zSLkS26aq/IBTleuawKlRaggzXvpmfUf5pHvHLAyRGDZL+GEA3je4i6r4j3XoA7NgETKNF3G
 5grbW0qDpog3x3HKLGv6AKSqIgU5RUCyHQ3EnhDd47wgLrqidZsud4/9ZAOGmxCMF2HOuSbeiJ3
 BbM2VfZw8VcNUsHzSwOE6hwbdfyt55IXAzs/jzCBtYvL/GqUBvMefyNSQJnYAoXMuSamELV38bl
 hbXV5BZBddXR2FOZgjZZ0oZawCT/vvXNWy2U2zi/SJ/uy7SUbITuvwmuN08uJFAvTXPaSdhwWZI
 GMvn7LHe4W1YdmY3a9m0wJc29F+bay0gXnvGxBkct2jc5d9FP9ufJY1RP/BQ19yirO8WKchn14q
 pXdngSEF31RMVVaNDOYhx2g2evXmt1pXmUQv+pjow0fwoYfagH8K8Mqbrgp5xj9qi37/o9gqY5m
 BAGXDcWwViKWV4X/4Gg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_03,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 27/01/2026 18:24, marcandre.lureau@redhat.com wrote:

> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> The endianness field used an int to represent a boolean concept, with
> 0 meaning little-endian and 1 meaning big-endian. This required runtime
> validation to reject invalid values and made the code less readable.
> 
> Replace with a bool big_endian field that is self-documenting and
> type-safe. The compiler now enforces valid values, eliminating the
> need for the validation check in audio_validate_settings().
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/dsound_template.h  |  2 +-
>   include/qemu/audio.h     |  2 +-
>   audio/alsaaudio.c        |  8 ++++----
>   audio/audio-mixeng-be.c  | 21 ++++-----------------
>   audio/jackaudio.c        |  4 ++--
>   audio/ossaudio.c         | 22 +++++++++++-----------
>   audio/paaudio.c          | 22 +++++++++++-----------
>   audio/pwaudio.c          | 30 +++++++++++++++---------------
>   audio/sdlaudio.c         | 26 +++++++++++++-------------
>   audio/sndioaudio.c       |  2 +-
>   audio/spiceaudio.c       |  4 ++--
>   audio/wavaudio.c         |  2 +-
>   audio/wavcapture.c       |  2 +-
>   hw/audio/ac97.c          |  2 +-
>   hw/audio/adlib.c         |  2 +-
>   hw/audio/asc.c           |  2 +-
>   hw/audio/cs4231a.c       |  6 +++---
>   hw/audio/es1370.c        |  2 +-
>   hw/audio/gus.c           |  2 +-
>   hw/audio/lm4549.c        |  6 +++---
>   hw/audio/sb16.c          |  8 ++++----
>   hw/audio/via-ac97.c      |  2 +-
>   hw/audio/virtio-snd.c    |  2 +-
>   hw/audio/wm8750.c        |  4 ++--
>   hw/display/xlnx_dp.c     |  2 +-
>   hw/usb/dev-audio.c       |  2 +-
>   tests/audio/test-audio.c |  2 +-
>   ui/vnc.c                 |  2 +-
>   28 files changed, 90 insertions(+), 103 deletions(-)
> 
> diff --git a/audio/dsound_template.h b/audio/dsound_template.h
> index af4019bcb34..f9761120875 100644
> --- a/audio/dsound_template.h
> +++ b/audio/dsound_template.h
> @@ -244,7 +244,7 @@ static int dsound_init_out(HWVoiceOut *hw, struct audsettings *as)
>       }
>   
>       ds->first_time = true;
> -    obt_as.endianness = 0;
> +    obt_as.big_endian = false;
>       audio_pcm_init_info (&hw->info, &obt_as);
>   
>       if (bc.dwBufferBytes % hw->info.bytes_per_frame) {
> diff --git a/include/qemu/audio.h b/include/qemu/audio.h
> index a2fbc286eb1..94d81a2a2ec 100644
> --- a/include/qemu/audio.h
> +++ b/include/qemu/audio.h
> @@ -38,7 +38,7 @@ typedef struct audsettings {
>       int freq;
>       int nchannels;
>       AudioFormat fmt;
> -    int endianness;
> +    bool big_endian;
>   } audsettings;
>   
>   typedef struct SWVoiceOut SWVoiceOut;
> diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
> index 3058af58e0b..a606ce0d4cd 100644
> --- a/audio/alsaaudio.c
> +++ b/audio/alsaaudio.c
> @@ -666,7 +666,7 @@ static int alsa_init_out(HWVoiceOut *hw, struct audsettings *as)
>       struct audsettings obt_as;
>       Audiodev *dev = hw->s->dev;
>   
> -    req.fmt = aud_to_alsafmt (as->fmt, as->endianness);
> +    req.fmt = aud_to_alsafmt (as->fmt, as->big_endian);
>       req.freq = as->freq;
>       req.nchannels = as->nchannels;
>   
> @@ -677,7 +677,7 @@ static int alsa_init_out(HWVoiceOut *hw, struct audsettings *as)
>       obt_as.freq = obt.freq;
>       obt_as.nchannels = obt.nchannels;
>       obt_as.fmt = obt.fmt;
> -    obt_as.endianness = obt.endianness;
> +    obt_as.big_endian = obt.endianness;
>   
>       audio_pcm_init_info (&hw->info, &obt_as);
>       hw->samples = obt.samples;
> @@ -752,7 +752,7 @@ static int alsa_init_in(HWVoiceIn *hw, struct audsettings *as)
>       struct audsettings obt_as;
>       Audiodev *dev = hw->s->dev;
>   
> -    req.fmt = aud_to_alsafmt (as->fmt, as->endianness);
> +    req.fmt = aud_to_alsafmt (as->fmt, as->big_endian);
>       req.freq = as->freq;
>       req.nchannels = as->nchannels;
>   
> @@ -763,7 +763,7 @@ static int alsa_init_in(HWVoiceIn *hw, struct audsettings *as)
>       obt_as.freq = obt.freq;
>       obt_as.nchannels = obt.nchannels;
>       obt_as.fmt = obt.fmt;
> -    obt_as.endianness = obt.endianness;
> +    obt_as.big_endian = obt.endianness;
>   
>       audio_pcm_init_info (&hw->info, &obt_as);
>       hw->samples = obt.samples;
> diff --git a/audio/audio-mixeng-be.c b/audio/audio-mixeng-be.c
> index 146026d0b39..e11c586c827 100644
> --- a/audio/audio-mixeng-be.c
> +++ b/audio/audio-mixeng-be.c
> @@ -135,19 +135,7 @@ static void audio_print_settings (const struct audsettings *as)
>           break;
>       }
>   
> -    AUD_log (NULL, " endianness=");
> -    switch (as->endianness) {
> -    case 0:
> -        AUD_log (NULL, "little");
> -        break;
> -    case 1:
> -        AUD_log (NULL, "big");
> -        break;
> -    default:
> -        AUD_log (NULL, "invalid");
> -        break;
> -    }
> -    AUD_log (NULL, "\n");
> +    AUD_log (NULL, " endianness=%s\n", as->big_endian ? "big" : "little");
>   }
>   
>   static int audio_validate_settings (const struct audsettings *as)
> @@ -155,7 +143,6 @@ static int audio_validate_settings (const struct audsettings *as)
>       int invalid;
>   
>       invalid = as->nchannels < 1;
> -    invalid |= as->endianness != 0 && as->endianness != 1;
>   
>       switch (as->fmt) {
>       case AUDIO_FORMAT_S8:
> @@ -180,7 +167,7 @@ static int audio_pcm_info_eq (struct audio_pcm_info *info, const struct audsetti
>       return info->af == as->fmt
>           && info->freq == as->freq
>           && info->nchannels == as->nchannels
> -        && info->swap_endianness == (as->endianness != HOST_BIG_ENDIAN);
> +        && info->swap_endianness == (as->big_endian != HOST_BIG_ENDIAN);
>   }
>   
>   void audio_pcm_init_info (struct audio_pcm_info *info, const struct audsettings *as)
> @@ -190,7 +177,7 @@ void audio_pcm_init_info (struct audio_pcm_info *info, const struct audsettings
>       info->nchannels = as->nchannels;
>       info->bytes_per_frame = as->nchannels * audio_format_bits(as->fmt) / 8;
>       info->bytes_per_second = info->freq * info->bytes_per_frame;
> -    info->swap_endianness = (as->endianness != HOST_BIG_ENDIAN);
> +    info->swap_endianness = (as->big_endian != HOST_BIG_ENDIAN);
>   }
>   
>   void audio_pcm_info_clear_buf(struct audio_pcm_info *info, void *buf, int len)
> @@ -1797,7 +1784,7 @@ audsettings audiodev_to_audsettings(AudiodevPerDirectionOptions *pdo)
>           .freq = pdo->frequency,
>           .nchannels = pdo->channels,
>           .fmt = pdo->format,
> -        .endianness = HOST_BIG_ENDIAN,
> +        .big_endian = HOST_BIG_ENDIAN,
>       };
>   }
>   
> diff --git a/audio/jackaudio.c b/audio/jackaudio.c
> index 547672f6d36..58b9d2f04e2 100644
> --- a/audio/jackaudio.c
> +++ b/audio/jackaudio.c
> @@ -531,7 +531,7 @@ static int qjack_init_out(HWVoiceOut *hw, struct audsettings *as)
>           .freq       = jo->c.freq,
>           .nchannels  = jo->c.nchannels,
>           .fmt        = AUDIO_FORMAT_F32,
> -        .endianness = 0
> +        .big_endian = false
>       };
>       audio_pcm_init_info(&hw->info, &os);
>   
> @@ -566,7 +566,7 @@ static int qjack_init_in(HWVoiceIn *hw, struct audsettings *as)
>           .freq       = ji->c.freq,
>           .nchannels  = ji->c.nchannels,
>           .fmt        = AUDIO_FORMAT_F32,
> -        .endianness = 0
> +        .big_endian = false
>       };
>       audio_pcm_init_info(&hw->info, &is);
>   
> diff --git a/audio/ossaudio.c b/audio/ossaudio.c
> index 8388f81343b..0f1c097a666 100644
> --- a/audio/ossaudio.c
> +++ b/audio/ossaudio.c
> @@ -160,36 +160,36 @@ static int aud_to_ossfmt(AudioFormat fmt, bool big_endian)
>       }
>   }
>   
> -static int oss_to_audfmt (int ossfmt, AudioFormat *fmt, int *endianness)
> +static int oss_to_audfmt (int ossfmt, AudioFormat *fmt, bool *big_endian)
>   {
>       switch (ossfmt) {
>       case AFMT_S8:
> -        *endianness = 0;
> +        *big_endian = false;
>           *fmt = AUDIO_FORMAT_S8;
>           break;
>   
>       case AFMT_U8:
> -        *endianness = 0;
> +        *big_endian = false;
>           *fmt = AUDIO_FORMAT_U8;
>           break;
>   
>       case AFMT_S16_LE:
> -        *endianness = 0;
> +        *big_endian = false;
>           *fmt = AUDIO_FORMAT_S16;
>           break;
>   
>       case AFMT_U16_LE:
> -        *endianness = 0;
> +        *big_endian = false;
>           *fmt = AUDIO_FORMAT_U16;
>           break;
>   
>       case AFMT_S16_BE:
> -        *endianness = 1;
> +        *big_endian = true;
>           *fmt = AUDIO_FORMAT_S16;
>           break;
>   
>       case AFMT_U16_BE:
> -        *endianness = 1;
> +        *big_endian = true;
>           *fmt = AUDIO_FORMAT_U16;
>           break;
>   
> @@ -475,7 +475,7 @@ static int oss_init_out(HWVoiceOut *hw, struct audsettings *as)
>   
>       oss->fd = -1;
>   
> -    req.fmt = aud_to_ossfmt (as->fmt, as->endianness);
> +    req.fmt = aud_to_ossfmt (as->fmt, as->big_endian);
>       req.freq = as->freq;
>       req.nchannels = as->nchannels;
>   
> @@ -483,7 +483,7 @@ static int oss_init_out(HWVoiceOut *hw, struct audsettings *as)
>           return -1;
>       }
>   
> -    err = oss_to_audfmt(obt.fmt, &obt_as.fmt, &obt_as.endianness);
> +    err = oss_to_audfmt(obt.fmt, &obt_as.fmt, &obt_as.big_endian);
>       if (err) {
>           oss_anal_close (&fd);
>           return -1;
> @@ -601,14 +601,14 @@ static int oss_init_in(HWVoiceIn *hw, struct audsettings *as)
>   
>       oss->fd = -1;
>   
> -    req.fmt = aud_to_ossfmt (as->fmt, as->endianness);
> +    req.fmt = aud_to_ossfmt (as->fmt, as->big_endian);
>       req.freq = as->freq;
>       req.nchannels = as->nchannels;
>       if (oss_open(1, &req, as, &obt, &fd, dev)) {
>           return -1;
>       }
>   
> -    err = oss_to_audfmt(obt.fmt, &obt_as.fmt, &obt_as.endianness);
> +    err = oss_to_audfmt(obt.fmt, &obt_as.fmt, &obt_as.big_endian);
>       if (err) {
>           oss_anal_close (&fd);
>           return -1;
> diff --git a/audio/paaudio.c b/audio/paaudio.c
> index bc6a8fa67b3..2a745ae38f9 100644
> --- a/audio/paaudio.c
> +++ b/audio/paaudio.c
> @@ -352,28 +352,28 @@ static pa_sample_format_t audfmt_to_pa(AudioFormat afmt, bool big_endian)
>       return format;
>   }
>   
> -static AudioFormat pa_to_audfmt (pa_sample_format_t fmt, int *endianness)
> +static AudioFormat pa_to_audfmt (pa_sample_format_t fmt, bool *big_endian)
>   {
>       switch (fmt) {
>       case PA_SAMPLE_U8:
>           return AUDIO_FORMAT_U8;
>       case PA_SAMPLE_S16BE:
> -        *endianness = 1;
> +        *big_endian = true;
>           return AUDIO_FORMAT_S16;
>       case PA_SAMPLE_S16LE:
> -        *endianness = 0;
> +        *big_endian = false;
>           return AUDIO_FORMAT_S16;
>       case PA_SAMPLE_S32BE:
> -        *endianness = 1;
> +        *big_endian = true;
>           return AUDIO_FORMAT_S32;
>       case PA_SAMPLE_S32LE:
> -        *endianness = 0;
> +        *big_endian = false;
>           return AUDIO_FORMAT_S32;
>       case PA_SAMPLE_FLOAT32BE:
> -        *endianness = 1;
> +        *big_endian = true;
>           return AUDIO_FORMAT_F32;
>       case PA_SAMPLE_FLOAT32LE:
> -        *endianness = 0;
> +        *big_endian = false;
>           return AUDIO_FORMAT_F32;
>       default:
>           error_report("pulseaudio: Internal logic error: Bad pa_sample_format %d", fmt);
> @@ -531,7 +531,7 @@ static int qpa_init_out(HWVoiceOut *hw, struct audsettings *as)
>       PAConnection *c = apa->conn;
>   
>       pa->g = apa;
> -    ss.format = audfmt_to_pa (as->fmt, as->endianness);
> +    ss.format = audfmt_to_pa (as->fmt, as->big_endian);
>       ss.channels = as->nchannels;
>       ss.rate = as->freq;
>   
> @@ -541,7 +541,7 @@ static int qpa_init_out(HWVoiceOut *hw, struct audsettings *as)
>       ba.maxlength = -1;
>       ba.prebuf = -1;
>   
> -    obt_as.fmt = pa_to_audfmt (ss.format, &obt_as.endianness);
> +    obt_as.fmt = pa_to_audfmt (ss.format, &obt_as.big_endian);
>   
>       pa->stream = qpa_simple_new (
>           c,
> @@ -582,7 +582,7 @@ static int qpa_init_in(HWVoiceIn *hw, struct audsettings *as)
>       PAConnection *c = apa->conn;
>   
>       pa->g = apa;
> -    ss.format = audfmt_to_pa (as->fmt, as->endianness);
> +    ss.format = audfmt_to_pa (as->fmt, as->big_endian);
>       ss.channels = as->nchannels;
>       ss.rate = as->freq;
>   
> @@ -592,7 +592,7 @@ static int qpa_init_in(HWVoiceIn *hw, struct audsettings *as)
>       ba.minreq = -1;
>       ba.prebuf = -1;
>   
> -    obt_as.fmt = pa_to_audfmt (ss.format, &obt_as.endianness);
> +    obt_as.fmt = pa_to_audfmt (ss.format, &obt_as.big_endian);
>   
>       pa->stream = qpa_simple_new (
>           c,
> diff --git a/audio/pwaudio.c b/audio/pwaudio.c
> index c30738c16ef..66ca1231541 100644
> --- a/audio/pwaudio.c
> +++ b/audio/pwaudio.c
> @@ -365,7 +365,7 @@ audfmt_to_pw(AudioFormat fmt, bool big_endian)
>   }
>   
>   static AudioFormat
> -pw_to_audfmt(enum spa_audio_format fmt, int *endianness,
> +pw_to_audfmt(enum spa_audio_format fmt, bool *big_endian,
>                uint32_t *sample_size)
>   {
>       switch (fmt) {
> @@ -377,43 +377,43 @@ pw_to_audfmt(enum spa_audio_format fmt, int *endianness,
>           return AUDIO_FORMAT_U8;
>       case SPA_AUDIO_FORMAT_S16_BE:
>           *sample_size = 2;
> -        *endianness = 1;
> +        *big_endian = true;
>           return AUDIO_FORMAT_S16;
>       case SPA_AUDIO_FORMAT_S16_LE:
>           *sample_size = 2;
> -        *endianness = 0;
> +        *big_endian = false;
>           return AUDIO_FORMAT_S16;
>       case SPA_AUDIO_FORMAT_U16_BE:
>           *sample_size = 2;
> -        *endianness = 1;
> +        *big_endian = true;
>           return AUDIO_FORMAT_U16;
>       case SPA_AUDIO_FORMAT_U16_LE:
>           *sample_size = 2;
> -        *endianness = 0;
> +        *big_endian = false;
>           return AUDIO_FORMAT_U16;
>       case SPA_AUDIO_FORMAT_S32_BE:
>           *sample_size = 4;
> -        *endianness = 1;
> +        *big_endian = true;
>           return AUDIO_FORMAT_S32;
>       case SPA_AUDIO_FORMAT_S32_LE:
>           *sample_size = 4;
> -        *endianness = 0;
> +        *big_endian = false;
>           return AUDIO_FORMAT_S32;
>       case SPA_AUDIO_FORMAT_U32_BE:
>           *sample_size = 4;
> -        *endianness = 1;
> +        *big_endian = true;
>           return AUDIO_FORMAT_U32;
>       case SPA_AUDIO_FORMAT_U32_LE:
>           *sample_size = 4;
> -        *endianness = 0;
> +        *big_endian = false;
>           return AUDIO_FORMAT_U32;
>       case SPA_AUDIO_FORMAT_F32_BE:
>           *sample_size = 4;
> -        *endianness = 1;
> +        *big_endian = true;
>           return AUDIO_FORMAT_F32;
>       case SPA_AUDIO_FORMAT_F32_LE:
>           *sample_size = 4;
> -        *endianness = 0;
> +        *big_endian = false;
>           return AUDIO_FORMAT_F32;
>       default:
>           *sample_size = 1;
> @@ -534,13 +534,13 @@ qpw_init_out(HWVoiceOut *hw, struct audsettings *as)
>   
>       pw_thread_loop_lock(c->thread_loop);
>   
> -    v->info.format = audfmt_to_pw(as->fmt, as->endianness);
> +    v->info.format = audfmt_to_pw(as->fmt, as->big_endian);
>       v->info.channels = as->nchannels;
>       qpw_set_position(as->nchannels, v->info.position);
>       v->info.rate = as->freq;
>   
>       obt_as.fmt =
> -        pw_to_audfmt(v->info.format, &obt_as.endianness, &v->frame_size);
> +        pw_to_audfmt(v->info.format, &obt_as.big_endian, &v->frame_size);
>       v->frame_size *= as->nchannels;
>   
>       v->req = (uint64_t)AUDIO_MIXENG_BACKEND(c)->dev->timer_period * v->info.rate
> @@ -581,13 +581,13 @@ qpw_init_in(HWVoiceIn *hw, struct audsettings *as)
>   
>       pw_thread_loop_lock(c->thread_loop);
>   
> -    v->info.format = audfmt_to_pw(as->fmt, as->endianness);
> +    v->info.format = audfmt_to_pw(as->fmt, as->big_endian);
>       v->info.channels = as->nchannels;
>       qpw_set_position(as->nchannels, v->info.position);
>       v->info.rate = as->freq;
>   
>       obt_as.fmt =
> -        pw_to_audfmt(v->info.format, &obt_as.endianness, &v->frame_size);
> +        pw_to_audfmt(v->info.format, &obt_as.big_endian, &v->frame_size);
>       v->frame_size *= as->nchannels;
>   
>       /* call the function that creates a new stream for recording */
> diff --git a/audio/sdlaudio.c b/audio/sdlaudio.c
> index bb667ef9525..b404adbc1e9 100644
> --- a/audio/sdlaudio.c
> +++ b/audio/sdlaudio.c
> @@ -107,56 +107,56 @@ static int aud_to_sdlfmt (AudioFormat fmt)
>       }
>   }
>   
> -static int sdl_to_audfmt(int sdlfmt, AudioFormat *fmt, int *endianness)
> +static int sdl_to_audfmt(int sdlfmt, AudioFormat *fmt, bool *big_endian)
>   {
>       switch (sdlfmt) {
>       case AUDIO_S8:
> -        *endianness = 0;
> +        *big_endian = false;
>           *fmt = AUDIO_FORMAT_S8;
>           break;
>   
>       case AUDIO_U8:
> -        *endianness = 0;
> +        *big_endian = false;
>           *fmt = AUDIO_FORMAT_U8;
>           break;
>   
>       case AUDIO_S16LSB:
> -        *endianness = 0;
> +        *big_endian = false;
>           *fmt = AUDIO_FORMAT_S16;
>           break;
>   
>       case AUDIO_U16LSB:
> -        *endianness = 0;
> +        *big_endian = false;
>           *fmt = AUDIO_FORMAT_U16;
>           break;
>   
>       case AUDIO_S16MSB:
> -        *endianness = 1;
> +        *big_endian = true;
>           *fmt = AUDIO_FORMAT_S16;
>           break;
>   
>       case AUDIO_U16MSB:
> -        *endianness = 1;
> +        *big_endian = true;
>           *fmt = AUDIO_FORMAT_U16;
>           break;
>   
>       case AUDIO_S32LSB:
> -        *endianness = 0;
> +        *big_endian = false;
>           *fmt = AUDIO_FORMAT_S32;
>           break;
>   
>       case AUDIO_S32MSB:
> -        *endianness = 1;
> +        *big_endian = true;
>           *fmt = AUDIO_FORMAT_S32;
>           break;
>   
>       case AUDIO_F32LSB:
> -        *endianness = 0;
> +        *big_endian = false;
>           *fmt = AUDIO_FORMAT_F32;
>           break;
>   
>       case AUDIO_F32MSB:
> -        *endianness = 1;
> +        *big_endian = true;
>           *fmt = AUDIO_FORMAT_F32;
>           break;
>   
> @@ -361,7 +361,7 @@ static int sdl_init_out(HWVoiceOut *hw, struct audsettings *as)
>           return -1;
>       }
>   
> -    err = sdl_to_audfmt(obt.format, &obt_as.fmt, &obt_as.endianness);
> +    err = sdl_to_audfmt(obt.format, &obt_as.fmt, &obt_as.big_endian);
>       if (err) {
>           sdl_close_out(sdl);
>           return -1;
> @@ -417,7 +417,7 @@ static int sdl_init_in(HWVoiceIn *hw, audsettings *as)
>           return -1;
>       }
>   
> -    err = sdl_to_audfmt(obt.format, &obt_as.fmt, &obt_as.endianness);
> +    err = sdl_to_audfmt(obt.format, &obt_as.fmt, &obt_as.big_endian);
>       if (err) {
>           sdl_close_in(sdl);
>           return -1;
> diff --git a/audio/sndioaudio.c b/audio/sndioaudio.c
> index be491895532..69fa9d8ba54 100644
> --- a/audio/sndioaudio.c
> +++ b/audio/sndioaudio.c
> @@ -387,7 +387,7 @@ static int sndio_init(SndioVoice *self,
>       }
>   
>       if (req.bits > 8) {
> -        req.le = as->endianness ? 0 : 1;
> +        req.le = as->big_endian ? 0 : 1;
>       }
>   
>       req.rate = as->freq;
> diff --git a/audio/spiceaudio.c b/audio/spiceaudio.c
> index 2547126994d..1b67fe2a540 100644
> --- a/audio/spiceaudio.c
> +++ b/audio/spiceaudio.c
> @@ -106,7 +106,7 @@ static int line_out_init(HWVoiceOut *hw, struct audsettings *as)
>   #endif
>       settings.nchannels  = SPICE_INTERFACE_PLAYBACK_CHAN;
>       settings.fmt        = AUDIO_FORMAT_S16;
> -    settings.endianness = HOST_BIG_ENDIAN;
> +    settings.big_endian = HOST_BIG_ENDIAN;
>   
>       audio_pcm_init_info (&hw->info, &settings);
>       hw->samples = LINE_OUT_SAMPLES;
> @@ -222,7 +222,7 @@ static int line_in_init(HWVoiceIn *hw, struct audsettings *as)
>   #endif
>       settings.nchannels  = SPICE_INTERFACE_RECORD_CHAN;
>       settings.fmt        = AUDIO_FORMAT_S16;
> -    settings.endianness = HOST_BIG_ENDIAN;
> +    settings.big_endian = HOST_BIG_ENDIAN;
>   
>       audio_pcm_init_info (&hw->info, &settings);
>       hw->samples = LINE_IN_SAMPLES;
> diff --git a/audio/wavaudio.c b/audio/wavaudio.c
> index 5c614ed3b51..217fb9937f8 100644
> --- a/audio/wavaudio.c
> +++ b/audio/wavaudio.c
> @@ -111,7 +111,7 @@ static int wav_init_out(HWVoiceOut *hw, struct audsettings *as)
>   
>       hdr[34] = bits16 ? 0x10 : 0x08;
>   
> -    wav_as.endianness = 0;
> +    wav_as.big_endian = false;
>       audio_pcm_init_info (&hw->info, &wav_as);
>   
>       hw->samples = 1024;
> diff --git a/audio/wavcapture.c b/audio/wavcapture.c
> index 69aa91e35f6..2dac9461710 100644
> --- a/audio/wavcapture.c
> +++ b/audio/wavcapture.c
> @@ -137,7 +137,7 @@ int wav_start_capture(AudioBackend *state, CaptureState *s, const char *path,
>       as.freq = freq;
>       as.nchannels = 1 << stereo;
>       as.fmt = bits16 ? AUDIO_FORMAT_S16 : AUDIO_FORMAT_U8;
> -    as.endianness = 0;
> +    as.big_endian = false;
>   
>       ops.notify = wav_notify;
>       ops.capture = wav_capture;
> diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
> index 5d442b7e067..fd74c249949 100644
> --- a/hw/audio/ac97.c
> +++ b/hw/audio/ac97.c
> @@ -313,7 +313,7 @@ static void open_voice(AC97LinkState *s, int index, int freq)
>       as.freq = freq;
>       as.nchannels = 2;
>       as.fmt = AUDIO_FORMAT_S16;
> -    as.endianness = 0;
> +    as.big_endian = false;
>   
>       if (freq > 0) {
>           s->invalid_freq[index] = 0;
> diff --git a/hw/audio/adlib.c b/hw/audio/adlib.c
> index ce17e21d5fd..52ee5cb6256 100644
> --- a/hw/audio/adlib.c
> +++ b/hw/audio/adlib.c
> @@ -254,7 +254,7 @@ static void adlib_realizefn (DeviceState *dev, Error **errp)
>       as.freq = s->freq;
>       as.nchannels = SHIFT;
>       as.fmt = AUDIO_FORMAT_S16;
> -    as.endianness = HOST_BIG_ENDIAN;
> +    as.big_endian = HOST_BIG_ENDIAN;
>   
>       s->voice = audio_be_open_out(
>           s->audio_be,
> diff --git a/hw/audio/asc.c b/hw/audio/asc.c
> index 35c7b5750d6..ea59bdde7b8 100644
> --- a/hw/audio/asc.c
> +++ b/hw/audio/asc.c
> @@ -648,7 +648,7 @@ static void asc_realize(DeviceState *dev, Error **errp)
>       as.freq = ASC_FREQ;
>       as.nchannels = 2;
>       as.fmt = AUDIO_FORMAT_U8;
> -    as.endianness = HOST_BIG_ENDIAN;
> +    as.big_endian = HOST_BIG_ENDIAN;
>   
>       s->voice = audio_be_open_out(s->audio_be, s->voice, "asc.out", s, asc_out_cb,
>                               &as);
> diff --git a/hw/audio/cs4231a.c b/hw/audio/cs4231a.c
> index e6cae9c988e..c589670e855 100644
> --- a/hw/audio/cs4231a.c
> +++ b/hw/audio/cs4231a.c
> @@ -289,7 +289,7 @@ static void cs_reset_voices (CSState *s, uint32_t val)
>       }
>   
>       as.nchannels = (val & (1 << 4)) ? 2 : 1;
> -    as.endianness = 0;
> +    as.big_endian = false;
>       s->tab = NULL;
>   
>       switch ((val >> 5) & ((s->dregs[MODE_And_ID] & MODE2) ? 7 : 3)) {
> @@ -305,12 +305,12 @@ static void cs_reset_voices (CSState *s, uint32_t val)
>           s->tab = ALawDecompressTable;
>       x_law:
>           as.fmt = AUDIO_FORMAT_S16;
> -        as.endianness = HOST_BIG_ENDIAN;
> +        as.big_endian = HOST_BIG_ENDIAN;
>           s->shift = as.nchannels == 2;
>           break;
>   
>       case 6:
> -        as.endianness = 1;
> +        as.big_endian = true;
>           /* fall through */
>       case 2:
>           as.fmt = AUDIO_FORMAT_S16;
> diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
> index e1658393c6a..ca7ad16df49 100644
> --- a/hw/audio/es1370.c
> +++ b/hw/audio/es1370.c
> @@ -407,7 +407,7 @@ static void es1370_update_voices (ES1370State *s, uint32_t ctl, uint32_t sctl)
>                   as.freq = new_freq;
>                   as.nchannels = 1 << (new_fmt & 1);
>                   as.fmt = (new_fmt & 2) ? AUDIO_FORMAT_S16 : AUDIO_FORMAT_U8;
> -                as.endianness = 0;
> +                as.big_endian = false;
>   
>                   if (i == ADC_CHANNEL) {
>                       s->adc_voice =
> diff --git a/hw/audio/gus.c b/hw/audio/gus.c
> index 5c2a34c09d2..196c4f72205 100644
> --- a/hw/audio/gus.c
> +++ b/hw/audio/gus.c
> @@ -256,7 +256,7 @@ static void gus_realizefn (DeviceState *dev, Error **errp)
>       as.freq = s->freq;
>       as.nchannels = 2;
>       as.fmt = AUDIO_FORMAT_S16;
> -    as.endianness = HOST_BIG_ENDIAN;
> +    as.big_endian = HOST_BIG_ENDIAN;
>   
>       s->voice = audio_be_open_out(
>           s->audio_be,
> diff --git a/hw/audio/lm4549.c b/hw/audio/lm4549.c
> index 14e15a844ba..a891e975106 100644
> --- a/hw/audio/lm4549.c
> +++ b/hw/audio/lm4549.c
> @@ -202,7 +202,7 @@ void lm4549_write(lm4549_state *s,
>           as.freq = value;
>           as.nchannels = 2;
>           as.fmt = AUDIO_FORMAT_S16;
> -        as.endianness = 0;
> +        as.big_endian = false;
>   
>           s->voice = audio_be_open_out(
>               s->audio_be,
> @@ -272,7 +272,7 @@ static int lm4549_post_load(void *opaque, int version_id)
>       as.freq = freq;
>       as.nchannels = 2;
>       as.fmt = AUDIO_FORMAT_S16;
> -    as.endianness = 0;
> +    as.big_endian = false;
>   
>       s->voice = audio_be_open_out(
>           s->audio_be,
> @@ -312,7 +312,7 @@ void lm4549_init(lm4549_state *s, lm4549_callback data_req_cb, void* opaque,
>       as.freq = 48000;
>       as.nchannels = 2;
>       as.fmt = AUDIO_FORMAT_S16;
> -    as.endianness = 0;
> +    as.big_endian = false;
>   
>       s->voice = audio_be_open_out(
>           s->audio_be,
> diff --git a/hw/audio/sb16.c b/hw/audio/sb16.c
> index c8fc7df8b44..1b5e452a29b 100644
> --- a/hw/audio/sb16.c
> +++ b/hw/audio/sb16.c
> @@ -213,7 +213,7 @@ static void continue_dma8 (SB16State *s)
>           as.freq = s->freq;
>           as.nchannels = 1 << s->fmt_stereo;
>           as.fmt = s->fmt;
> -        as.endianness = 0;
> +        as.big_endian = false;
>   
>           s->voice = audio_be_open_out(
>               s->audio_be,
> @@ -376,7 +376,7 @@ static void dma_cmd (SB16State *s, uint8_t cmd, uint8_t d0, int dma_len)
>           as.freq = s->freq;
>           as.nchannels = 1 << s->fmt_stereo;
>           as.fmt = s->fmt;
> -        as.endianness = 0;
> +        as.big_endian = false;
>   
>           s->voice = audio_be_open_out(
>               s->audio_be,
> @@ -877,7 +877,7 @@ static void legacy_reset (SB16State *s)
>       as.freq = s->freq;
>       as.nchannels = 1;
>       as.fmt = AUDIO_FORMAT_U8;
> -    as.endianness = 0;
> +    as.big_endian = false;
>   
>       s->voice = audio_be_open_out(
>           s->audio_be,
> @@ -1300,7 +1300,7 @@ static int sb16_post_load (void *opaque, int version_id)
>               as.freq = s->freq;
>               as.nchannels = 1 << s->fmt_stereo;
>               as.fmt = s->fmt;
> -            as.endianness = 0;
> +            as.big_endian = false;
>   
>               s->voice = audio_be_open_out(
>                   s->audio_be,
> diff --git a/hw/audio/via-ac97.c b/hw/audio/via-ac97.c
> index 84d137b41a3..9d61283542a 100644
> --- a/hw/audio/via-ac97.c
> +++ b/hw/audio/via-ac97.c
> @@ -237,7 +237,7 @@ static void open_voice_out(ViaAC97State *s)
>           .freq = CODEC_REG(s, AC97_PCM_Front_DAC_Rate),
>           .nchannels = s->aur.type & BIT(4) ? 2 : 1,
>           .fmt = s->aur.type & BIT(5) ? AUDIO_FORMAT_S16 : AUDIO_FORMAT_S8,
> -        .endianness = 0,
> +        .big_endian = false,
>       };
>       s->vo = audio_be_open_out(s->audio_be, s->vo, "via-ac97.out", s, out_cb, &as);
>   }
> diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
> index 89e24c0a8e0..8b949146468 100644
> --- a/hw/audio/virtio-snd.c
> +++ b/hw/audio/virtio-snd.c
> @@ -378,7 +378,7 @@ static void virtio_snd_get_qemu_audsettings(audsettings *as,
>       as->nchannels = MIN(AUDIO_MAX_CHANNELS, params->channels);
>       as->fmt = virtio_snd_get_qemu_format(params->format);
>       as->freq = virtio_snd_get_qemu_freq(params->rate);
> -    as->endianness = 0; /* Conforming to VIRTIO 1.0: always little endian. */
> +    as->big_endian = false; /* Conforming to VIRTIO 1.0: always little endian. */
>   }
>   
>   /*
> diff --git a/hw/audio/wm8750.c b/hw/audio/wm8750.c
> index 2a286515b14..e2507b0269a 100644
> --- a/hw/audio/wm8750.c
> +++ b/hw/audio/wm8750.c
> @@ -202,7 +202,7 @@ static void wm8750_set_format(WM8750State *s)
>           return;
>   
>       /* Setup input */
> -    in_fmt.endianness = 0;
> +    in_fmt.big_endian = false;
>       in_fmt.nchannels = 2;
>       in_fmt.freq = s->adc_hz;
>       in_fmt.fmt = AUDIO_FORMAT_S16;
> @@ -215,7 +215,7 @@ static void wm8750_set_format(WM8750State *s)
>                       CODEC ".input3", s, wm8750_audio_in_cb, &in_fmt);
>   
>       /* Setup output */
> -    out_fmt.endianness = 0;
> +    out_fmt.big_endian = false;
>       out_fmt.nchannels = 2;
>       out_fmt.freq = s->dac_hz;
>       out_fmt.fmt = AUDIO_FORMAT_S16;
> diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
> index 9aa4709b411..7d037b46a35 100644
> --- a/hw/display/xlnx_dp.c
> +++ b/hw/display/xlnx_dp.c
> @@ -1393,7 +1393,7 @@ static void xlnx_dp_realize(DeviceState *dev, Error **errp)
>       as.freq = 44100;
>       as.nchannels = 2;
>       as.fmt = AUDIO_FORMAT_S16;
> -    as.endianness = 0;
> +    as.big_endian = false;
>   
>       s->amixer_output_stream = audio_be_open_out(s->audio_be,
>                                              s->amixer_output_stream,
> diff --git a/hw/usb/dev-audio.c b/hw/usb/dev-audio.c
> index 7b758718c12..e18e0a1dfd6 100644
> --- a/hw/usb/dev-audio.c
> +++ b/hw/usb/dev-audio.c
> @@ -975,7 +975,7 @@ static void usb_audio_reinit(USBDevice *dev, unsigned channels)
>       s->out.as.freq       = USBAUDIO_SAMPLE_RATE;
>       s->out.as.nchannels  = s->out.channels;
>       s->out.as.fmt        = AUDIO_FORMAT_S16;
> -    s->out.as.endianness = 0;
> +    s->out.as.big_endian = false;
>       streambuf_init(&s->out.buf, s->buffer, s->out.channels);
>   
>       s->out.voice = audio_be_open_out(s->audio_be, s->out.voice, TYPE_USB_AUDIO,
> diff --git a/tests/audio/test-audio.c b/tests/audio/test-audio.c
> index e403f11f093..98e77cf542b 100644
> --- a/tests/audio/test-audio.c
> +++ b/tests/audio/test-audio.c
> @@ -49,7 +49,7 @@ static const struct audsettings default_test_settings = {
>       .freq = SAMPLE_RATE,
>       .nchannels = CHANNELS,
>       .fmt = AUDIO_FORMAT_S16,
> -    .endianness = 0,
> +    .big_endian = false,
>   };
>   
>   static void dummy_audio_callback(void *opaque, int avail)
> diff --git a/ui/vnc.c b/ui/vnc.c
> index d56fe2c180e..daf5b01d342 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -3372,7 +3372,7 @@ static void vnc_connect(VncDisplay *vd, QIOChannelSocket *sioc,
>       vs->as.freq = 44100;
>       vs->as.nchannels = 2;
>       vs->as.fmt = AUDIO_FORMAT_S16;
> -    vs->as.endianness = 0;
> +    vs->as.big_endian = false;
>   
>       qemu_mutex_init(&vs->output_mutex);
>       vs->bh = qemu_bh_new(vnc_jobs_bh, vs);

Agreed, this is a much clearer way of expressing the endianness of the data:

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


