Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E97A1E9538A
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 11:36:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnbAi-0005K0-TJ; Wed, 04 Feb 2026 06:35:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vnbAh-0005Jj-67
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 06:35:47 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vnbAe-0002W5-En
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 06:35:45 -0500
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61462mh92991337; Wed, 4 Feb 2026 03:35:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=Kk2oSlllXCWreq3Wlk4rZkf1jQtt7I1xsICsFoP7S
 Ec=; b=irbHOX8ueBPQY5Cmh65p4ccEyqGaWa5M9LyTdnRIXjz932vqjRtgrtPTg
 JUPDqh9x61hsXRv345lBIcAzQ0mQ4h1lwTXH/gJsZugqG/dg7ri6j9wDuIuDuLaN
 VdVN490Ib1AweFEKkqAhQZI1/CA4b+wTUtcNYEe+Hv2YFuPu7sgz0lM25XZekw++
 mgclwmEkFV1svFOa+6+d2+m3giUJugqEceGo92FXZUMSIKtH7tBgWix1sCZgAlEc
 Lr4RzrbEW9CpVB71URZddL0qO1pIYet7nuGiR5vdw78vHTMrGFGBWkJn9O5kQZxx
 x1IVkEbACa+ifOEUxexLNeg1Wg7kg==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11020084.outbound.protection.outlook.com
 [40.93.198.84])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4c3ntja5w9-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 04 Feb 2026 03:35:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RSxiXi90BvX5oSFtOq35XyPqFS/zM566l5IVpjYfGe85MwuFtic5ZPg/eureTnH7npH8GumV1HGmz5pl6pDals264bD60NMYruPbZdXQKI/dq6BQnn79uVD8zlSHQIa3nXueaGL7drz+W22Wu8CU4CK6U0HvZWFmAWS5YSt3J0bXLU+MJ0tb1fpfXjN5kkEp6GYRITPRK8W1GX132oYpeIV2mY3fwOL/MFxfatl+ObQE+0emJXAcGxcJJhWmod2WyttPt1Dmnfw6I1eynyvqBNXPZ2ZbyzTU+mB+D5mQbWrtLnSzDJ8t6wbU7ZR+8qz2/O64Ph9E5OfIACiqpCZmwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kk2oSlllXCWreq3Wlk4rZkf1jQtt7I1xsICsFoP7SEc=;
 b=NUK7E3ke7RbZ/ynauneOjnZ8fzQkcBgGkK42212AA1oqOQ7BlZ70+J1xwhRhX9Mtbsgn3ZyzYT0h2gO+PGc0paBgVKZ0K1QUTRp7sd0sV1RPfD06fWwH0lTBy3wmGQCave/zK23sAAWa5r6ct0EZ3eFfclR+sFDLIiOKlTlJ4usj2AlzF+kJrZv8RMjzghS3/BGHBgy/FjjGyj3ncSxitaRFvcKQA2L8lBikri2244NWRAIi01oRh9EpvRqDz66CKUZ3uw9WYMncp9XPXohxocSAJpQFdwg+ALP97s1XGR/6zG4XbFglA6uOQ0YVPk1VPVKIct/DtUBwuF1X1CK9DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kk2oSlllXCWreq3Wlk4rZkf1jQtt7I1xsICsFoP7SEc=;
 b=JNYVuRyIIH/VADvbYWjk5sCxP1Hiq7YEFEfNk/Vrhi0oiqhRyQ+ekxtI/frCowYM2dMhdNxNFoxvEEGevZJ19Vy3OtdKmggk2mvfhhRD7qCNOrQK3vIMRXAL7tVL9ctF6d1vqi8zLmKnvjXf+imv2iECuKJhdUbbYYl9glscygZ3zJnngaY9aYPgI2ujurhPnzzww9622bzNXC4imM+bxtF3x0K7zOPZuIwYxsaqpPmSBySa9BYBJK2Spj+CkFSqGpHFb82H9+oSavF0X5bEKiQ4mdl6PuFCyymxZMyK6buO/CuiTrKfJpnb1qVKNMGarzRHEcwEDGQgZG4JgNNcgw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MN2PR02MB7007.namprd02.prod.outlook.com (2603:10b6:208:207::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 11:35:41 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%6]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 11:35:41 +0000
Message-ID: <5256c933-a0e2-457f-be29-44824d37de0a@nutanix.com>
Date: Wed, 4 Feb 2026 11:35:38 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 25/37] module: remove audio module support
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
 <20260123074945.2563196-26-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260123074945.2563196-26-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0177.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::32) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MN2PR02MB7007:EE_
X-MS-Office365-Filtering-Correlation-Id: b20251f8-4b70-4c98-f06f-08de63e186dc
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bHZlK29YVFpZU0QzZ1dHZkYvYlRTcW1EMjdkODdxVm1CQ3N1UVFTVGhydXpZ?=
 =?utf-8?B?ckJwWEpEb3NuSkpoUmI0c1BzSlZNN1F5TS9lLzhNeGFnek9kUHFJN21keVhB?=
 =?utf-8?B?R1JyWTRRYmptVGZKaCtpbzFKcG1TQTVoMXFuMkxYbWNIdzNsVFJtMDV4clp4?=
 =?utf-8?B?N2tHemx0bk1ocFNZeWpFRVp2ZHhxUGxkb3ZWRUFIb0RFQVArOWtVOFpzT2Zp?=
 =?utf-8?B?R1dSVWlVenJESjlpWTQ2SUEyWGcxWEQyZzdxOS9DV1R3ZjhXcUFTRUpwenU5?=
 =?utf-8?B?aVJQa1ZwUkpQcWNGVVE2MnV2MDlBc2t0d3RlZFRwa3REL1JwcnBiaWFzWm5G?=
 =?utf-8?B?UVFwZGpoc0hQaG52TENuem5LTitudUpjZnFNM1F1MTV2eEtZM0RzTEEzWjZu?=
 =?utf-8?B?RkZCdUlXb2Z3NVVsK0VlZ2FQSVRkTGpqdDZRUzhIV2U5MHF4L0lGL1o2MU90?=
 =?utf-8?B?RnowcjZ3bnkzQWFISDF2L2ZoY0lBcTczaVM2QTVuK3V4TkxYNzdTbklrWElZ?=
 =?utf-8?B?VC8wRGpGQk1URG40SnVtUjBJWEdqWktKZkVITVhpeFlqL2lpT3gra1Y4MVRV?=
 =?utf-8?B?b2htZ2o1NDVYWjFkc2k4blI2dzJqcEQ3N09nZE9VOWlhS2U3UkVQTkpqRDFl?=
 =?utf-8?B?WkFPT2V1Z0N4OFlNNWpXT3p1ckpHd1ZkZG0yanRmczZKeW5GdGpqcHJWZllt?=
 =?utf-8?B?N2tTRk1UajNYYkg0T3BaWGdsVWxBbDF5RXJoaXhGb0tVeTJFSkp6cFVtdGJK?=
 =?utf-8?B?VHZrRzVTLzZlV0oxazdSUjlvN3dTa09aamhTaTAvSzM0Wkh6UmsyKy9DZXZj?=
 =?utf-8?B?dHhmeXJ0ZTkvUHpsS3VRWlJqZS9iMXJEK2ZsUGozQlgyUEZNQklRdzR2OTN5?=
 =?utf-8?B?K3NDNEZNNmg2czlIQXdTeG5HbkZ6b3JpSGRlYzV2S3V2UllRQW1ZU0g0bHhT?=
 =?utf-8?B?Q0dFTkJacWp1VlBualNaTWtEUXJuME5uc1E2ek15aGdLa253ZTZGTUMzaUh4?=
 =?utf-8?B?OVpRK0lneURVK2RONDdmRk1DUGJjQzhHa1gwY2g5cnpSMHA4MUhhUXNrNjBJ?=
 =?utf-8?B?Q25kSTE5b1dCTFFoM0JLTkg4RGRYZzQzeE1ZMnQvN3RsS2p4Z3E4Qy92K2RJ?=
 =?utf-8?B?Vkx3M25OYWM2aHdOTjlUaDU0b010ZVUxalMyajN3akdzTTdodHgxNTAzQkVI?=
 =?utf-8?B?TU0zMGdDR1ZpVmpPUnBoMEVWZGtKTE5nZ0xNN2gwVE03RG5rcGxGRUk1RzhN?=
 =?utf-8?B?TU8zWUN2K1NrWm9hdzJxcVVremV5S2hxeGN5NTJLcFF6cy80WjNIMVZWc3Mx?=
 =?utf-8?B?UEl6K3RTK0dJL2l2ODdQQ1B5L3pDbnNRbGhtbXFOcWgwdmtlS1YvYmRmMDZ2?=
 =?utf-8?B?UW5RNDJQUFNnMkR5REljZjJ1bnYwVWg3L0Z1dkZvclhybVRMdHNjVHhZcFhw?=
 =?utf-8?B?ZVVJdW9hejZOMlVWUllhNm44aFpIYXR6b1pVcmRYNDg4SjNMVTVVMklSRklI?=
 =?utf-8?B?bDdNajNHVUtPdGozbXJPYjB0aHdwZnJDSDAzNXpaSlJNN3pHZ0VpSjcxdGls?=
 =?utf-8?B?MnRWT1lacG10aHhsSi9PTGprNUQ1QVJRUUxmaDVCVURUUUFXLzM4RjVsSnRr?=
 =?utf-8?B?Ync5UWhZQWowbittVXNkV3VON3dYNG1kaFZIajllV0gvdExWT1U4RzFYMnQv?=
 =?utf-8?B?bS9vMzJ4RWNBdmpQLzVPa2JKSmgyT2RrUmhOMUt4QjgwUGY1cWgwMUI0M3V5?=
 =?utf-8?B?K0FBMUg1NHZoZUl0VmxKdENXbDd6SkpXZjIzYUhWSlhSNHd0N1NSYytEU0VV?=
 =?utf-8?B?cHk3LzRrcVBlbzZJaThjSC9SM2FQR1VobkdkNlVRck5SL3JwWFZqa3hZWlEv?=
 =?utf-8?B?Mys0MHFQcUw2RjQxZkluWmNhSGZ4SHlqMlRjNG9VVGorSE8vWFdnV3RFWTg1?=
 =?utf-8?B?OGM0MnNiL2xBQXpydUtSVVJ3bUQ5MzZBc0Q1eVZXRE1Md3VWOXROUDlCN0t5?=
 =?utf-8?B?RnB3TUhVaEJNRXBWbWJhS0RxNytRNllSYnIwMGJHSjhmdlVHakd5TFRrRXN0?=
 =?utf-8?B?OTlRN3lYMkdWL0dXRjZqYVpOV1hueURkZFk4STZWLzhKTm10NEFORmw5aStw?=
 =?utf-8?Q?u7bs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnZPZG9kcG04c2VpZ2J3THhXSE9yc045R1EyeUNqd05yK0x5bE5vdS9rWEo4?=
 =?utf-8?B?aVQ4bkN3VExPZlVnZXhpU0hJTVJ0aTRrNXFOdVlubW1BTEpJZ1B4c0lZeGdJ?=
 =?utf-8?B?emdnczFkelpJQ3Y4cXhaOFVmNmNYZWFiY2FmSXdtZ0x4U1JNZEpvTmNyMHpZ?=
 =?utf-8?B?WHE4YnJXck9yb2JycnBwRnlyWnJ4Z21ycitMamNGZDRDdU05QzEwUGQ2MFBB?=
 =?utf-8?B?c25zSkd4ZzN6ZkxGZFVZNURoUjk4ODkwUzJabll6Uy9FU2pOcmgrZFRXWjJX?=
 =?utf-8?B?QnBqOFdqQ242dzdsWVYwbjVHNUJ3dzl2ZmtGWFhwTFlsUVh0R0IvMkZONG53?=
 =?utf-8?B?ckFqRktVU2FURnRvd3EzYmVYK3hQc1pmVjVhR0ZweVkvejMrYXFCZlJuU05m?=
 =?utf-8?B?bVNnMWtQOFhBaDIydWVnZDUyN243aDJ4K0ZKai8rOGM3ZUVSZlkwRmsrUzZh?=
 =?utf-8?B?NzBNZWFxQ0NsRVpyektTbXRqNlJuUUxIUlBqa2JRaTdCeDdraGFJMWFuUC9R?=
 =?utf-8?B?VjQxazNsd05sK2VBWGhQd3FhZnlkY3ZFZXdOdFZlais3WW92ck50K0U5cEt3?=
 =?utf-8?B?Q3JZb0krWlRGWWNZb1lKck9sLytaTVUwVUl1RjBGZXRGSFY0bkU4QWtVVTZT?=
 =?utf-8?B?TXZON21jc3lTekgxKzVRTUtiQVM3ZkhNZTFybkl5U3JxY0RhUUZOMkVFY2xu?=
 =?utf-8?B?YXZFWnFBTnFwSXp1YU1kN0JCTTJUVW85bHhWUU5qM0Y4V25GVWVTbmFJMXNE?=
 =?utf-8?B?eXF0SDZyZm5rOUUwb3FHbitIWElyQVNJNU1ST1BlK2x5SGJSUldjR0FkYVV5?=
 =?utf-8?B?NU1EZUh0UC8vTytGM0QvRC8rcGtkc1hNWWJTV0djUDZ3MU03SGlwSEpVKzVi?=
 =?utf-8?B?Q0c4aDNlRXQxRHFhNzBiY1FvdjRzZjUveHN5R0Q2aStSMm5US3RRaVF1SzVa?=
 =?utf-8?B?QzhydVY3UDF1MnJiR1VGWGNNQmNhbXlMRzQyREk4cjh1VlZobjRUekhkMGtq?=
 =?utf-8?B?bUNzd080RWo1YzJzb3dWNEFLbVBzYzFKVWh2UnMrRmI2bUpuaDZRWkRvTVFs?=
 =?utf-8?B?Q1Jhb1h3S094a3pkUDJhQTFaZk1FWTZBcDBub3dhdC82czIzb083Z242bmhI?=
 =?utf-8?B?cDBlZ01ROVZ3cHhZcmw3V25KdHpLRkNBMTBKeUVGL2dyODBqYVcxRzNORUlo?=
 =?utf-8?B?R2xtWUtGSUduRUZ4amZoMlJjVUNxR0tUM0pTSTBrVi85TE5nWi9nZVg0OTVp?=
 =?utf-8?B?SFh2NE9tQ2VNS2lWSUFHMkhrNEZ4V3JPYnR3bWFjSFZSd0FmZ3c4UnRObTEw?=
 =?utf-8?B?N3dVT2JRZjM0aDgzOFpPbVZNTlprVzR2ZFVCM1IzL2JlbVo5dzBtcTUwL2Uz?=
 =?utf-8?B?eUlHQjQvdklwYmNTN3hHL3ZQVTRxZTByVGwwdzFreEZOQWhEakZpK3FRai81?=
 =?utf-8?B?YmpjeWVPdDJMZVREbHN0YzU0UnR6eDVsVWpBVXcxQjhjcDN3YTZ2ZFIvYkdE?=
 =?utf-8?B?OU1uUjV0NW1RTjR0bWFNVDJtYWJLKzlSUU1FOEhCd2lwbm1tM0dxWnRjeFBL?=
 =?utf-8?B?ZTdxR0VSVGN1Y1M5TXBMWjZ2bTc2dkE3Wk5HdnpaQStMWUJjT0JBQ05hRzRO?=
 =?utf-8?B?ZXdPK1BSSGIrOFhCVktDR0dKc3BuSm1kamV3WUh0R3g2dGEzd25aV2VlMXAy?=
 =?utf-8?B?TllGY2Rqajg3Y0U0aXZVTmZVQnh4ekh3ejNWazF2YjBRclhaT2c5clVSS1Zy?=
 =?utf-8?B?bjF5aGZ6ZEdmT2ttcUxiZVovVmFPeVZnL2dGcGQ4ZU0yNGN3L29LbktHTzBG?=
 =?utf-8?B?T3lQUXBKTmlUS1ErT2JPcGhFZUgvMkRFQjhCcUdTNGh3VGszYXNOc1lKUXc1?=
 =?utf-8?B?QzRPbEhzQklpWEhkN1BRYXd0UVcraGNCZzJrazFIYXZFM284UGUvK0Z2YlpL?=
 =?utf-8?B?cTBnckk3VENhUUJsSjlQWVh5OHdoc2NMVzZUQWdCeW93Wmd2UGFsUVFtSGVM?=
 =?utf-8?B?emR4clVwMDNQMEJSdnQzRFJOcUZrVk5HZysyK1ZlY0pwZXhUQVdSMHQwL2NJ?=
 =?utf-8?B?Q0Nic0daTVY0WEZFRWRwci9Hdk94MXV0WGp1aE5ybjBESFNYVnl0VDlXUlJ4?=
 =?utf-8?B?bnhOZ3JWc0QyZVBEWW8xSXI3TTcyTk1MYUhBN1lGVW9Iay9SQmFBRXowd2Nk?=
 =?utf-8?B?Q1g1WGdoZWpDYjBML1hMYWMxU3o5YS9QdG81bHJUc3d5clBMY0hYd2llbzZq?=
 =?utf-8?B?c3dudVNRcHhTNE95Wkxjc2o2QkFQMmplQWFLNlc2N0R6bW0wSGQzZFZsU3JG?=
 =?utf-8?B?SmZ3L0ROSHlvYnppekhhUEdHcmNVSGh6TU4yeVNKcGd2aFBiS1JoMUVmY2Y5?=
 =?utf-8?Q?hYDl2dHytqCE/uIg=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b20251f8-4b70-4c98-f06f-08de63e186dc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 11:35:41.5395 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VPbRypzaQ2gt3/iQPeK/u9vo6cRZYVMThD2CnzKtcSBc3W8waOdZQPAdnZT8okLSHvc8InfhL9+6ejm6BxPOVY9vF8E6uduzpgq0PddUDFg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB7007
X-Proofpoint-ORIG-GUID: 0nByT2yZRQYlfwVlbKQS8uTp3vrMGxpr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDA4OCBTYWx0ZWRfX65wnRavxjV0a
 U08ZSISCbrfo27bkbn4zvCOhoAAhOEbnuUM3qfLhZbFTbAIHNiI7ZsIQch2wFBZsHsRth+Z1z8w
 Pekvsv3THve/kxbdGOgx7dmRymRtG9njhe6oFleDyZpg8mm1S/qwp62LOF17Q1ZW+yoBK681gdb
 Rx5V0a+A6CQ4aCa3MFi+CZQ5V0mFetz+RN9bzFkBR7FT31e6rDJrWNUA033r7orPnw4QhLTgjTb
 SSS76e+wEWbrh6rtLYdlrZQM8I0U/HBVrwBJbOa653jHcu+c97YWv7XqQgxNwiTi/y61EKkIfIV
 o4tvsyGT8U6XnK0ixSiNC5R/llE9PH/w33o5lPFQYqLKfUrkMP85JxEw9NAvuNR15O/vu4hRy4o
 ugJeyDVFjfRy2AdXgAnNyfY4PTNqhcJvjVA276uiOyo7Mswro4/wEF3tLEfbIMGs4xVaNFVCW8b
 zYSF9UGtgrniVpMWhJA==
X-Authority-Analysis: v=2.4 cv=K6cv3iWI c=1 sm=1 tr=0 ts=69832f0e cx=c_pps
 a=kHN3x5GyKc6C//KDRj4sJQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8
 a=ax7SXWsUMO3s0nO7GmIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 0nByT2yZRQYlfwVlbKQS8uTp3vrMGxpr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_02,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 23/01/2026 07:49, marcandre.lureau@redhat.com wrote:

> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> It relies on dynamic object loading support instead.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   include/qemu/module.h | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/include/qemu/module.h b/include/qemu/module.h
> index c37ce74b16f..9885ac9afb3 100644
> --- a/include/qemu/module.h
> +++ b/include/qemu/module.h
> @@ -63,7 +63,6 @@ typedef enum {
>   #define migration_init(function) module_init(function, MODULE_INIT_MIGRATION)
>   #define block_module_load(lib, errp) module_load("block-", lib, errp)
>   #define ui_module_load(lib, errp) module_load("ui-", lib, errp)
> -#define audio_module_load(lib, errp) module_load("audio-", lib, errp)
>   
>   void register_module_init(void (*fn)(void), module_init_type type);
>   void register_dso_module_init(void (*fn)(void), module_init_type type);
> @@ -78,7 +77,7 @@ void module_call_init(module_init_type type);
>    * - get_relocated_path(CONFIG_QEMU_MODDIR);
>    * - /var/run/qemu/${version_dir}
>    *
> - * prefix:         a subsystem prefix, or the empty string ("audio-", ..., "")
> + * prefix:         a subsystem prefix, or the empty string ("ui-", ..., "")
>    * name:           name of the module
>    * errp:           error to set in case the module is found, but load failed.
>    *

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


