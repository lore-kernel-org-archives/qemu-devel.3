Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45FDDCCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 13:51:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE6Zf-0000mB-IL; Wed, 29 Oct 2025 09:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucas.kornicki@nutanix.com>)
 id 1vE6Zb-0000kM-RR
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 09:50:49 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucas.kornicki@nutanix.com>)
 id 1vE6ZS-0004AK-BO
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 09:50:47 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59T85jDD281342; Wed, 29 Oct 2025 06:50:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=NlwkrXnW5jII0Np
 rCYBQQ4J4PwHSsVeWF0RFMcjH0Sk=; b=xABRO1jL5ZKAEcxQVbkj0wcoi2P4jGE
 MfC0nVkub5R+6d8XiEO4/a/lnKVFVSoRP2j1+ECUZSi77e4cwVAKIr8j64XgzXjE
 HYa7JqHOVdwn9aS8socYujNLBkZsoTvgK2hMYV9HXaMz/zplMhSIHNBkLgeOICbL
 LNdKWMN9sCYJEmKcYdVfFjjsgqR1mhvw1A3wY//2aEohYN5Zps/R8FLZRznzM72z
 bBtrxPGydhsGdu7sNkwjNGhwHV77MAjZ24opCcJUsosVuYNtsA7tzKouIPrJMNUa
 NSMK4RcaRMtt1HVx7AvmX2+DyxVqOcGOK6M17jLdWRHcvkoLOsWetIw==
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11020107.outbound.protection.outlook.com [52.101.201.107])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4a349g9yrp-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 29 Oct 2025 06:50:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NahyUbkPXSgna5EE8FvMdcZDcIKhVho4THX4eAP9Wk/wYfnQLAoYsT+nTU+AG6adaSK8KfWl+RwfChz0zlhTRA6CChvSM5CsZjBHYpm5eiVlij38/Z6Z8aV5XeWicmFFQlie7rN1Tn+5pPV9mPnaMe2V7pZqjpaNlDhT/AY4bLI/ouGggwWUw1gz/TtAQ4O6YpG/qx0cFiE7Gk6+zHprcwa4QgGZfgJ8JJiHbmSqO6hbbuNLIEZ174f5MlfH4zVKTKUyzZ345JRrr9nRTiRMYETlZOqQuDwKCF2HonaIrzFa04Renl5ORxPskkOlH+6EaRMHUbZBJuo+ZQwSx53/Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NlwkrXnW5jII0NprCYBQQ4J4PwHSsVeWF0RFMcjH0Sk=;
 b=MY9atsqCuzquYx8AyycMlD4b3l0ys6VI3MqYPP34ze17JZUsLyYXboFScJHWmQRmipjsjLyFekMRUGrAfhvenkR/4AJBqTZHTtwjYXaKM0DG9/pCY7ecu6evJBmr3sUUUwL4XDhPWcgIAx3F5v6I5h74PrJmiQYDC4Ndt/ZfwyrGkTFZIO2xkCyHhwtVCi65r91ea3OZXxWuH2dbFoYeLwPD1V1mLfDixA7jcrA3e7D11eGENsfyo+QVjWuiPs08A7DMHtQ9NtOG/6095jTolvKNcvjhT8/Kt2iAsNvMpgzYLYVFJopUnSEZ12dPIJGoLaVxk4KneRFacu9M2tMDaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NlwkrXnW5jII0NprCYBQQ4J4PwHSsVeWF0RFMcjH0Sk=;
 b=iT/TPrl69CTHa3mQg8CHiSbusXr+aJBjRHb2S74KJS2o3hPLkaYfAVm6qb+ZgfSzp/Uw6VZJAQZTGLO9yvYKa3+Y6V0VMiFfBs4rZJJThvVb0VFTV+uT5YqIxmjFC3FRFcGtNDzZMxevkN7/eA6DqKkn1RX6yTk2MCRkx05N/yiL+YPl8pcJSI8JLghsrCrxl0Hg9Ko3ndxbqVEN060Q667QoL5qUNc6eJ8BvOCzXu9FHLUEFs0UWcQYsOTLxboAu5Wo2m4tG6XqBlk0xcmDeIUN13HiJWdXIR0wWYWeIq9G0W8VmDf3XuzIOrCTIuz1SUyPCTaX39MAxMthV2QESw==
Received: from BYAPR02MB4838.namprd02.prod.outlook.com (2603:10b6:a03:48::29)
 by CH0PR02MB7897.namprd02.prod.outlook.com (2603:10b6:610:112::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 13:50:25 +0000
Received: from BYAPR02MB4838.namprd02.prod.outlook.com
 ([fe80::4292:5b12:892c:5222]) by BYAPR02MB4838.namprd02.prod.outlook.com
 ([fe80::4292:5b12:892c:5222%6]) with mapi id 15.20.9253.018; Wed, 29 Oct 2025
 13:50:25 +0000
Content-Type: multipart/alternative;
 boundary="------------yMgqeELCh0rL0WUvqrBB9vlX"
Message-ID: <855f387e-661a-44fa-a00f-6c84cf800c6c@nutanix.com>
Date: Wed, 29 Oct 2025 14:50:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ui/vdagent: fix windows agent regression
To: marcandre.lureau@redhat.com
References: <20251027130744.2714610-1-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Lucas Kornicki <lucas.kornicki@nutanix.com>
Cc: qemu-devel@nongnu.org
In-Reply-To: <20251027130744.2714610-1-marcandre.lureau@redhat.com>
X-ClientProxiedBy: FR4P281CA0200.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::9) To BYAPR02MB4838.namprd02.prod.outlook.com
 (2603:10b6:a03:48::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4838:EE_|CH0PR02MB7897:EE_
X-MS-Office365-Filtering-Correlation-Id: ac3bb6d0-6270-4c9a-e6c8-08de16f21ca0
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|8096899003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UEErRDlvKzZCeTQzUFNRS0JjVFNhRXpJNm91dExGamF4MGExd0tqamVDZXY1?=
 =?utf-8?B?eGt4Q1dsQlprc0Zxc0xjSDBsNWVaWDg4V0RPQ09rZlo0Uk9qUTZFcGJKOTFR?=
 =?utf-8?B?cXZZSlQzNktJVVBNQ0RyeUNyT05rN0QyV1ZKR2Qzc2tZT09nS09SUlNwZjJs?=
 =?utf-8?B?MEFjWUFaMkkzVzVBaGVwdDFpeGs5WEFkSklGK0VsUEZRNTBHMVZKRU1OM3A2?=
 =?utf-8?B?ZUlWNCtyRGtud3dkbWtTMW1HSkRWTDFvamVkTVBKRjdldGZpTmFocDMyM0tw?=
 =?utf-8?B?NTBKWmdua0svL3poSGZOd3Z5Y2ZwZE9GYkRYZk5YZVJBNEVTWktsb0VWdko4?=
 =?utf-8?B?QXhtbjRiRFViOVFpZlVXYVNyT1E2U00zV0tMaW42WUc0eERvV0JDZjY3b3ZB?=
 =?utf-8?B?ZnltcFJiT2pTaVlBVHJjbVZDY2FEU09URllLdWJsUWF6TjNGaXZ3M1BZaG9S?=
 =?utf-8?B?cEVaYzg3R3Ftd284SitvNGs1Mmg1MTlpZHdDQzdWeVVGb0laUHV2RHYzRW8z?=
 =?utf-8?B?aGt0aXFpVWQrV3JuVFk4NFZtVUw4YUVyMGpJbUJwb0thazdwejFOaFNjU1Nm?=
 =?utf-8?B?b3FabjJ6UlNjbG5mczFmSmtHRnpCUm9WWVZ2OVpGNmJld3o5aHljU3JFS2Yv?=
 =?utf-8?B?cHZrQ0g5QUFNaTd4b3NRNWtKM1M3dGlJQ3VOQUxnb2llRCtKVWl0L0pNRVZS?=
 =?utf-8?B?Q1dGcGZpbTcvQkdrL3RKMDZwRnNXRStJc002ZVhERUhoVmRkVCsvQmxldjl6?=
 =?utf-8?B?RjE0d0tMVG5LM0V6MXRQb3FUSGkzcmEwSytjcVZqaTl2MERqTm43V1ZkbWd1?=
 =?utf-8?B?dCtrSWR6ZlBSMXR2dDBTamwyOGkrYXMwTXAzcS9rUHNRa2JDbGhkZDBkTm51?=
 =?utf-8?B?UVdKbTFDL0R3eXZDR3dqdjNJM2QxYnVkN0lWb2U4VVo4dlQrU0tpdFcvYTBI?=
 =?utf-8?B?ck95RGdvMzhEMy9kZHpISDB1Nkh0OWNTMmVvRDYrU2d0NlVqbmNFQlpwUDlP?=
 =?utf-8?B?eGdhVy81UUFsa1hiSWEwYWx5Tm1NOXFxR3ZZelhrYWxPMitGOTJTS1FvZ3Zu?=
 =?utf-8?B?L1pJQjI0STVyWWIwUjZXTjJNNmM2SWNSUFRGS1k2cWI0bCt6MFMxWXhtSzNP?=
 =?utf-8?B?bmhlR1ZuM3Y5OVJUUzVVdkFsSUJqVWZvbXVvdE1RNkltZ2NVbFQvTXZqbUxU?=
 =?utf-8?B?RXQ5d1Rob0U2U21pK1pFWVBnSWRLYUw5TmlZZk9QY2lmUmdoUEc2eE9ybHBK?=
 =?utf-8?B?YVNZVldGNVhyVkwzWXM2MENIbnVTVlZlNXVHMUtHazVDZjlwWkt2MzVpSDF6?=
 =?utf-8?B?U2hodHlRVGFqRzgwV2MwMzI5VEtFSkJQRkdrVnRTOEJIZi90QkxSSjAzMnB5?=
 =?utf-8?B?TUNsazlOaFFYaVVQTUthQ3ZsVFdwRUNaM3NGOHp5MEsxMVdRVXc0cDJKdW9y?=
 =?utf-8?B?OXBsaUJCcmtIQ1I1a1p0UmtuUVRNK2Zqeitrc3dHTS9BMzR1QUovV1BXcWt1?=
 =?utf-8?B?NzZLazhTRVBYTWxEaVBtMi9JQXRBTVJybEZYdHBtTVpOUUwzWll6eTRyRHMy?=
 =?utf-8?B?UDdpeWpwTEdPOE5RZUZsOXpmUk1hdk03RWdUVnd4WldrQ1VLaEFFbHNORWZZ?=
 =?utf-8?B?bEY1K0hQaEpab3ZNUTNSZkpRd05JWDRNRzVHaGFCanVKdWoweGtMbEtCQlh0?=
 =?utf-8?B?RzBGSUhEY1laS2R3VjZmeFlLWm5mL1NjSS9UclQ4OFdqQjdtY2YzWm1TVGpB?=
 =?utf-8?B?WkZNNmRYTkFldHV0YU1aeTliai85R2dNczBVMHVGeThtTWR5NmxpME4vVTRz?=
 =?utf-8?B?K0lPNDU1NmVXOHh2QklMNVlyM1NyT0FTTlpJbG9hWXdnaUFNei95REpYeXlq?=
 =?utf-8?B?ZHJkNXA5WmhYMDdPQ3l6dFdtZGhJbUdpSTFueEd4c2l6NFNVaTBWUmZEQmZT?=
 =?utf-8?Q?eRG6hzrHdSFd8RD75SnGoupDuIFUcKRq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4838.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(8096899003); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFU3blE5UUMzV0RqckRGM21wb1dyUXpFbEhsOFlEVHpXNmE0N0RrUk8vdGV6?=
 =?utf-8?B?cTRnekFoVlJMMEZYUU44U1lRcXRxMTZQQ2ZlMUZtSjIzMyttZG9oWmhvelZk?=
 =?utf-8?B?biswczV2UjlOcjhaaEhTbWloeGhrV3FBNGEwMUpXMzFnYUc4d2pzTDJGOVpF?=
 =?utf-8?B?c1hCci9jSFRjNm1xTitBZ3VtSkZlb1NRYms1S1d0bW1ISGg2S05hR1p3c1Q5?=
 =?utf-8?B?a0x0M2x5MGNMTHp0RjFTb3RUNkd4ZTQ4ZEJlenJmdEM2ZzB6aEM5d2gxYUhM?=
 =?utf-8?B?akU3UzlRY2NKNy80VDBWQjhJTXZiczBMdjZGTjN3cjJ4MXNFSlBJSkcwNWp6?=
 =?utf-8?B?aXY4V0kxSmNPRTZCbEtUS0ZVUmdOUXZSaGxPdDR0RG9oUGY0UFhTaDRqTGJk?=
 =?utf-8?B?VitKLzZFT0NOY0dpOUdiQWI5ZlNEUVhLZHIweXYrN3grbVZoRG5ob20rVENn?=
 =?utf-8?B?WUp6VVRTajMreHk2MVVXREpZRDljNnYyTEUxaFI4d3hpWHJOc05Ib2NEVDB6?=
 =?utf-8?B?Z0JPTDM3dVY3Q25FWlpJeDFROU0vQmdqNTV4Q3RmR2R3a2RzRDc4dzhBM1pn?=
 =?utf-8?B?RTIrUGdoU29oMkgyOU1mV20rZGFoRThIYlJUbFJpQWJGKzJuK1BVV2treis0?=
 =?utf-8?B?UDR4VTNFQkRQNHZhYXdDSzBXMXVFQXhSTGhUV1dpNWZ3QnIwQ1JuMVFiU3ZM?=
 =?utf-8?B?SXFpYU85eDgvUTFaVllYZFpHM1pMeWZPSzlXaVE0ZGZLTytLNjRpejhiaXl6?=
 =?utf-8?B?VkNDNDBTakNLZEgzOUNzT2NjV3VjaSt3c0hCNFhGNndxQWRpZFRlaEZQYWFI?=
 =?utf-8?B?b01qN0JyRjRpVFkrci9RaE9tQ2tITnhuY0ZidWdCYWtaWHp5Zk5nTnJ4NWhV?=
 =?utf-8?B?OTZ6aTVKV3BWUGtkeGh4emhOMi9HU3ZwWjJobkx4VG1nM1g0MGdmdGZNdFh5?=
 =?utf-8?B?c0Q3K05sbGFnSUtYZXpmOXZ4Uko1aFlTcFJ6NHIrOEEreklEa3VEWDlpVXNH?=
 =?utf-8?B?Y3JwM0kzUFFhUHVyUjJhSmlpVUppRzgzdm13TDdraXFDem1OeVVub1VxNTIv?=
 =?utf-8?B?ZEc0UlVIMFJLRjIvMm92cFY4SmpIazk0Z0NCUFF0VFY2Mkl1bStBWjhiTjYr?=
 =?utf-8?B?OGcwU1paa005b09DR1JoZk0wdVJKNk9SVGh2YTVrVUMzTXpZb3VxUlg4cmJK?=
 =?utf-8?B?V3o5MElPUkNTZ3ZkcWMyamJvUm5qeEI5eGp3Z1lWdG9MTDRjNVpCb0Urdlkz?=
 =?utf-8?B?M3F3SENSUTBwNzVldWd0N1grZnJOUG5nTlh2SFNKQWlSSWltZWZ5SGc0ZmE2?=
 =?utf-8?B?RGhuMDg0blJoNWJWbytCaThZT3E3NW50S05peTlTbnB4WEUwQTZpa3VCMTZz?=
 =?utf-8?B?Y082VThONlZ6aTB3Y3RiLzJQam9XTWhKcEJaa0s2dXhqUm9QdkZjeVhCb2Rz?=
 =?utf-8?B?RjRsbm1pWnJxR3l3T2p2K1pLMmczcjFReHRPWE4rYTFraHNxMzZYWGwwUE9P?=
 =?utf-8?B?YW9zNkVkUXAzNVhHdGI3dkhjZzd4YTNLVCtTQkRVQm9HMy93T3pwK0pnakpH?=
 =?utf-8?B?QVFIU2M4YUwrc3p5RUZOSnNyc2c2SFhpUUlza2hPNTlha3hPeEphNnM0eGpD?=
 =?utf-8?B?eEhYMDJ3bVNNL0tpUy84L3dnNzJGbzNVWW5HYTFSLzIyYjhGRkM4YnR0eWsv?=
 =?utf-8?B?TDVOS2xNQ2tJQ2tNOWF1RTJKd2p5Zjd0ZC9XT2x0NVBJa01PVlJEekVFZzZE?=
 =?utf-8?B?SjIwVDh1MFFEbE80OVh2cmJoOWxVOE44ZC9mUDJ4ZGMxWGRscklRQVZ3R1Y1?=
 =?utf-8?B?NXFLZXQwazVRK0VhTmZmeXE5NTVOakQyTDVXczIzeDFteTMwRDdZVzBLUFdT?=
 =?utf-8?B?NGpvTDhjWWp2Qjl4SWQ0c2tNRXJna3FSOC91OGJ1NnFrVGVLMVB2WC9xaFU3?=
 =?utf-8?B?bGpGYTV1WnVjSmdDSnpJQlFvbHJwNVpLQTFaS0s2NTdYb2RvMnRlejEyaUR3?=
 =?utf-8?B?VmVSQUJoK3J5SGw1ZWZVSFVJem5yWWxUUnAzb2RnWUVYWVFxUm51ekdUYjk3?=
 =?utf-8?B?S0F4dzVOWDlRemx2UlJnMm1tcWt4aE0vL0lmYmhKb3hxK0pzY1pjR3h6VW9q?=
 =?utf-8?B?VHhvM1BYb05UTnBZYVpZSkRobTMxU1RRcVZMbVA2STVTRTRZcm85MTNhWkRT?=
 =?utf-8?B?SXc9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac3bb6d0-6270-4c9a-e6c8-08de16f21ca0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4838.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 13:50:25.3034 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 89uTcl8HhWvi86QI6OkNTIvAfqiEm6w6rLuI33C5kcmbx6QOom/1eT1Q34pQY2yfROLeiZGYENdKM2jHhsTyr9GHMTnPz/g5GmtM6lF4YtE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB7897
X-Proofpoint-ORIG-GUID: FbD72D5qYYhr2TsNAR-EqiMqTlnMX8iy
X-Authority-Analysis: v=2.4 cv=IukTsb/g c=1 sm=1 tr=0 ts=69021ba4 cx=c_pps
 a=hXZiUtiVoVCKrsLoS6Demw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8
 a=I_U8MGPSD8DFjRYTw6UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Rf-GCpn__4BelfZMpowA:9 a=_W_S_7VecoQA:10 a=lqcHg5cX4UMA:10
X-Proofpoint-GUID: FbD72D5qYYhr2TsNAR-EqiMqTlnMX8iy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDEwNiBTYWx0ZWRfX9+bvRv/VxBA5
 PqBd9RG0fDEC9QsN+2+EE06csZn+LLt+91ntoCn/O9QcA77/Kkhlswapobg/wef7QsNYdQjIa/F
 U3f6NAqqWl0sYMpIwJPJmc4RL3WKxUgyCHOKoloR9EfFU2jP1/qzlBwuKJPvsWhbC7W/DvkXLTS
 KKFPzlkQEVbLdy81fJCUFd5kSXi9LreHLZ6O0MmqaFX5xpWe5R3kYLRLzUS68hBd5XQGNjlcsbt
 J3w4luRWu1MWzATnBDcGCvi3Fwpo4Tto9AZBN2syDaBROHbDuQ/UoMX/7D8kuUi5LFsULWhNETK
 EmjQVPpLBQY7RZLJ5yp/NJU99j7XKezKYPxzjoyXoJk1+a7KQ/OYXh4250CODoo0Tr93+WyhI0S
 0Dk+LTINCoDfcsYwxOsrCrLax0rhnw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_05,2025-10-29_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=lucas.kornicki@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

--------------yMgqeELCh0rL0WUvqrBB9vlX
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I've tested this patch on windows 11 and windows server 2022. In both 
cases the device stays open after serial reset and clipboard operations 
work. Thanks a lot

Tested-by: Lucas Kornicki <lucas.kornicki@nutanix.com>

On 10/27/25 14:07, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau<marcandre.lureau@redhat.com>
>
> Since commit f626116f ("ui/vdagent: factor out clipboard peer
> registration"), the QEMU clipboard serial is reset whenever the vdagent
> chardev receives the guest caps. This triggers a CHR_EVENT_CLOSED which
> is handled by virtio_serial_close() to notify the guest.
>
> The "reconnection logic" is there to reset the agent when a
> client (dbus, spice etc) reconnects, or the agent is restarted.
> It is required to sync the clipboard serials and to prevent races or
> loops due to clipboard managers on both ends (but this is not
> implemented by windows vdagent).
>
> The Unix agent has been reconnecting without resending caps, thus
> working with this approach.
>
> However, the Windows agent does not seem to have a way to handle
> VIRTIO_CONSOLE_PORT_OPEN=0 event and do not receive further data...
>
> Let's not trigger this disconnection/reset logic if the agent does not
> support VD_AGENT_CAP_CLIPBOARD_GRAB_SERIAL.
>
> Fixes: f626116f ("ui/vdagent: factor out clipboard peer registration")
> Signed-off-by: Marc-André Lureau<marcandre.lureau@redhat.com>
> Reported-by: Lucas Kornicki<lucas.kornicki@nutanix.com>
> ---
>   ui/vdagent.c | 20 ++++++++++++++------
>   1 file changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/ui/vdagent.c b/ui/vdagent.c
> index ddb91e75c6..660686c9c0 100644
> --- a/ui/vdagent.c
> +++ b/ui/vdagent.c
> @@ -316,6 +316,15 @@ static bool have_selection(VDAgentChardev *vd)
>       return vd->caps & (1 << VD_AGENT_CAP_CLIPBOARD_SELECTION);
>   }
>   
> +static bool have_clipboard_serial(VDAgentChardev *vd)
> +{
> +#if CHECK_SPICE_PROTOCOL_VERSION(0, 14, 1)
> +    return vd->caps & (1 << VD_AGENT_CAP_CLIPBOARD_GRAB_SERIAL);
> +#else
> +    return false;
> +#endif
> +}
> +
>   static uint32_t type_qemu_to_vdagent(enum QemuClipboardType type)
>   {
>       switch (type) {
> @@ -345,8 +354,7 @@ static void vdagent_send_clipboard_grab(VDAgentChardev *vd,
>           return;
>       }
>   
> -#if CHECK_SPICE_PROTOCOL_VERSION(0, 14, 1)
> -    if (vd->caps & (1 << VD_AGENT_CAP_CLIPBOARD_GRAB_SERIAL)) {
> +    if (have_clipboard_serial(vd)) {
>           if (!info->has_serial) {
>               /* client should win */
>               info->serial = vd->last_serial[info->selection]++;
> @@ -356,7 +364,6 @@ static void vdagent_send_clipboard_grab(VDAgentChardev *vd,
>           data++;
>           msg->size += sizeof(uint32_t);
>       }
> -#endif
>   
>       for (q = 0; q < QEMU_CLIPBOARD_TYPE__COUNT; q++) {
>           type = type_qemu_to_vdagent(q);
> @@ -464,6 +471,9 @@ static void vdagent_clipboard_reset_serial(VDAgentChardev *vd)
>   {
>       Chardev *chr = CHARDEV(vd);
>   
> +    if (!have_clipboard_serial(vd)) {
> +        return;
> +    }
>       /* reopen the agent connection to reset the serial state */
>       qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
>       /* OPENED again after the guest disconnected, see set_fe_open */
> @@ -518,8 +528,7 @@ static void vdagent_clipboard_recv_grab(VDAgentChardev *vd, uint8_t s, uint32_t
>   
>       trace_vdagent_cb_grab_selection(GET_NAME(sel_name, s));
>       info = qemu_clipboard_info_new(&vd->cbpeer, s);
> -#if CHECK_SPICE_PROTOCOL_VERSION(0, 14, 1)
> -    if (vd->caps & (1 << VD_AGENT_CAP_CLIPBOARD_GRAB_SERIAL)) {
> +    if (have_clipboard_serial(vd)) {
>           if (size < sizeof(uint32_t)) {
>               /* this shouldn't happen! */
>               return;
> @@ -537,7 +546,6 @@ static void vdagent_clipboard_recv_grab(VDAgentChardev *vd, uint8_t s, uint32_t
>           data += sizeof(uint32_t);
>           size -= sizeof(uint32_t);
>       }
> -#endif
>       if (size > sizeof(uint32_t) * 10) {
>           /*
>            * spice has 6 types as of 2021. Limiting to 10 entries
--------------yMgqeELCh0rL0WUvqrBB9vlX
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>I've tested this patch on windows 11 and windows server 2022. In
      both cases the device stays open after serial reset and clipboard
      operations work. Thanks a lot</p>
    <p>Tested-by: Lucas Kornicki <a class="moz-txt-link-rfc2396E" href="mailto:lucas.kornicki@nutanix.com">&lt;lucas.kornicki@nutanix.com&gt;</a></p>
    <div class="moz-cite-prefix">On 10/27/25 14:07,
      <a class="moz-txt-link-abbreviated" href="mailto:marcandre.lureau@redhat.com">marcandre.lureau@redhat.com</a> wrote:<span style="white-space: pre-wrap">
</span></div>
    <blockquote type="cite" cite="mid:20251027130744.2714610-1-marcandre.lureau@redhat.com">
      <pre wrap="" class="moz-quote-pre">
From: Marc-André Lureau <a class="moz-txt-link-rfc2396E" href="mailto:marcandre.lureau@redhat.com">&lt;marcandre.lureau@redhat.com&gt;</a>

Since commit f626116f (&quot;ui/vdagent: factor out clipboard peer
registration&quot;), the QEMU clipboard serial is reset whenever the vdagent
chardev receives the guest caps. This triggers a CHR_EVENT_CLOSED which
is handled by virtio_serial_close() to notify the guest.

The &quot;reconnection logic&quot; is there to reset the agent when a
client (dbus, spice etc) reconnects, or the agent is restarted.
It is required to sync the clipboard serials and to prevent races or
loops due to clipboard managers on both ends (but this is not
implemented by windows vdagent).

The Unix agent has been reconnecting without resending caps, thus
working with this approach.

However, the Windows agent does not seem to have a way to handle
VIRTIO_CONSOLE_PORT_OPEN=0 event and do not receive further data...

Let's not trigger this disconnection/reset logic if the agent does not
support VD_AGENT_CAP_CLIPBOARD_GRAB_SERIAL.

Fixes: f626116f (&quot;ui/vdagent: factor out clipboard peer registration&quot;)
Signed-off-by: Marc-André Lureau <a class="moz-txt-link-rfc2396E" href="mailto:marcandre.lureau@redhat.com">&lt;marcandre.lureau@redhat.com&gt;</a>
Reported-by: Lucas Kornicki <a class="moz-txt-link-rfc2396E" href="mailto:lucas.kornicki@nutanix.com">&lt;lucas.kornicki@nutanix.com&gt;</a>
---
 ui/vdagent.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/ui/vdagent.c b/ui/vdagent.c
index ddb91e75c6..660686c9c0 100644
--- a/ui/vdagent.c
+++ b/ui/vdagent.c
@@ -316,6 +316,15 @@ static bool have_selection(VDAgentChardev *vd)
     return vd-&gt;caps &amp; (1 &lt;&lt; VD_AGENT_CAP_CLIPBOARD_SELECTION);
 }
 
+static bool have_clipboard_serial(VDAgentChardev *vd)
+{
+#if CHECK_SPICE_PROTOCOL_VERSION(0, 14, 1)
+    return vd-&gt;caps &amp; (1 &lt;&lt; VD_AGENT_CAP_CLIPBOARD_GRAB_SERIAL);
+#else
+    return false;
+#endif
+}
+
 static uint32_t type_qemu_to_vdagent(enum QemuClipboardType type)
 {
     switch (type) {
@@ -345,8 +354,7 @@ static void vdagent_send_clipboard_grab(VDAgentChardev *vd,
         return;
     }
 
-#if CHECK_SPICE_PROTOCOL_VERSION(0, 14, 1)
-    if (vd-&gt;caps &amp; (1 &lt;&lt; VD_AGENT_CAP_CLIPBOARD_GRAB_SERIAL)) {
+    if (have_clipboard_serial(vd)) {
         if (!info-&gt;has_serial) {
             /* client should win */
             info-&gt;serial = vd-&gt;last_serial[info-&gt;selection]++;
@@ -356,7 +364,6 @@ static void vdagent_send_clipboard_grab(VDAgentChardev *vd,
         data++;
         msg-&gt;size += sizeof(uint32_t);
     }
-#endif
 
     for (q = 0; q &lt; QEMU_CLIPBOARD_TYPE__COUNT; q++) {
         type = type_qemu_to_vdagent(q);
@@ -464,6 +471,9 @@ static void vdagent_clipboard_reset_serial(VDAgentChardev *vd)
 {
     Chardev *chr = CHARDEV(vd);
 
+    if (!have_clipboard_serial(vd)) {
+        return;
+    }
     /* reopen the agent connection to reset the serial state */
     qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
     /* OPENED again after the guest disconnected, see set_fe_open */
@@ -518,8 +528,7 @@ static void vdagent_clipboard_recv_grab(VDAgentChardev *vd, uint8_t s, uint32_t
 
     trace_vdagent_cb_grab_selection(GET_NAME(sel_name, s));
     info = qemu_clipboard_info_new(&amp;vd-&gt;cbpeer, s);
-#if CHECK_SPICE_PROTOCOL_VERSION(0, 14, 1)
-    if (vd-&gt;caps &amp; (1 &lt;&lt; VD_AGENT_CAP_CLIPBOARD_GRAB_SERIAL)) {
+    if (have_clipboard_serial(vd)) {
         if (size &lt; sizeof(uint32_t)) {
             /* this shouldn't happen! */
             return;
@@ -537,7 +546,6 @@ static void vdagent_clipboard_recv_grab(VDAgentChardev *vd, uint8_t s, uint32_t
         data += sizeof(uint32_t);
         size -= sizeof(uint32_t);
     }
-#endif
     if (size &gt; sizeof(uint32_t) * 10) {
         /*
          * spice has 6 types as of 2021. Limiting to 10 entries
</pre>
    </blockquote>
  </body>
</html>

--------------yMgqeELCh0rL0WUvqrBB9vlX--

