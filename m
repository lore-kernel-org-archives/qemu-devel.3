Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 041A0F3C9A9
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 16:02:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuurE-0001AP-EQ; Tue, 24 Feb 2026 11:01:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vuuqq-00012p-4U
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 11:01:33 -0500
Received: from
 mail-switzerlandnorthazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c213::5] helo=ZR1P278CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vuuqo-0001kk-3O
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 11:01:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pUqzuQRZJFOirXuOU8dfsSF2ODb26v2YmukbuLOR2rnGR+n4wcR5qVTb0l8xVmT5wZsd03y/hBzPN21/I8+qKvfUfnWQufRQ5cLcGonG6Hz4hGN8tvS9OgJDP6hIy8rtOjxmy0s5c9YyAVCYHbFm9J5EaX/inobSZ5CTvxHRzLJc6RBOj6pA/Nf1ouaJl2xqi3shkJpHnPW4fUDdIU8OUXRu1q2gW7pWVhxJPNc54DN7d9wWitMnW4QDDMivL79fOVXikyiuM/eHyMLvYDYOlvdy2ebuaFgytQfmWEzfUHDm07B4ARhs97EhH0Rwh7n9YCojYflHFj5UGYUKkwE5Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S6DfXDfhuroFuxhVAxX4MVTUfm2LCO68zdW0qY5Vh6E=;
 b=s0apR2wc7E3gzfj+UAQfY5qVoTvvdQxGNTWh2C75KhgeZzpHBy5NYX3CABeAoBVqllQDi/svKn/vPlnEPPX82j+I2T/PvAsn6Ljt9eJDKqp9pH/cFlHI7BR1ovD5FsWTBNwn1SEeJp2qz+Q9FpT9kohq6zFS+Ms4Ubl4aHpyFTysoOvTtg2r5fxdtmBHKdDo58gMIgRPV4YYNJbzBc66DYG/63b5gzMwF9XjU2CjCxyzONTUkLuDvumk43djWfTeTIeiwSc4W8AYChR4nbjVedQa3PbAdQkAwbuDCc5gvfvc3YeVCE2r9mCagbTbf1Yskvfe1G/+0vmPdGb+wwQjpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S6DfXDfhuroFuxhVAxX4MVTUfm2LCO68zdW0qY5Vh6E=;
 b=lECT0JUa4gCg4etLJwfQG0G1T3tn25WTpLfR95bwFiM2qbPb7d6ep4+RyLyGHrKjnaOgOmonT3TojQQ1z4qZz9tZ5lnY9m80s+8fqoEmY/iN138/55s0n6hbbz2GBcVPbA3QTmIxtUG+GwDTQHgikau/TVipnhIKakkE0hbMISU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by ZR3P278MB1305.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:72::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 16:00:34 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c%6]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 16:00:34 +0000
Message-ID: <cc5b7b1a-b562-4376-8e4c-f01607bbcf9b@epfl.ch>
Date: Tue, 24 Feb 2026 16:57:21 +0100
User-Agent: Mozilla Thunderbird
Subject: [PATCH v4 6/7] plugins: prohibit writing to read-only registers
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, pierrick.bouvier@linaro.org,
 richard.henderson@linaro.org, laurent@vivier.eu, imp@bsdimp.com,
 berrange@redhat.com
References: <909b0a4f-9759-4e27-bba8-997ae2f41bd6@epfl.ch>
Content-Language: en-US
Autocrypt: addr=florian.hofhammer@epfl.ch; keydata=
 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
 5hMMZIzTI4AtIcgA3xe4Ew==
In-Reply-To: <909b0a4f-9759-4e27-bba8-997ae2f41bd6@epfl.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV0P278CA0016.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:26::26) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|ZR3P278MB1305:EE_
X-MS-Office365-Filtering-Correlation-Id: 118110e7-fe58-483a-1e89-08de73bdd6cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|786006|19092799006|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SGVIdU85Vkd4ckMxbjlJWTVqNS85MGFFVUR5S0Y2cW5LVmlXRUJLb2JiL01z?=
 =?utf-8?B?a2FDNVpraUluRHp3dS9EUVNSd2diLzd4R3Z4d3Jpb3ZEeFZ6U1FQVVQ4Nnhw?=
 =?utf-8?B?Q2pzQ3ZCQTh1NVh1TUdpU2x3bUxEM25FbStJQndnWHVHN0tpSW45RVBLL1hT?=
 =?utf-8?B?S0NhNzgzZ3d6MDJwam83R3VLaTl2aUVLUEhnK29WNFhBc29IS29YdlpBME03?=
 =?utf-8?B?R25CcXZtODB1VVo3eldsczBFSnFvL1puUEk0Z2RiYlQybDUwWXpFS3dpRmNX?=
 =?utf-8?B?OVN5aGNIYmEwRnFvRHNhclUvc0pwS0FmYVhKZFdETVhwV3hGcUlNcmU3eDBX?=
 =?utf-8?B?M0daMkpWMlRIWGUxTUxoSHJjNTBiYnlIRmdQazhxWjBJbmdSSnVHTFZtVmtZ?=
 =?utf-8?B?MmVrK3FDVlNuaVpja3I4K2FUT3BpVlNZU09NaDlCK0dFWEJEWm8xbDk1U1BO?=
 =?utf-8?B?RUFkRStXZFFsbEJkc3pCY0U4SU5seWhNaVFpZGYvM09OWHU0M0c2ZWs5S3Zy?=
 =?utf-8?B?cFRjakpaTTJQU21QbDFPcXV5WVJJSE92aVNwRkkwR1cxNTBaUGtkSjVYb0dv?=
 =?utf-8?B?d0JjeHoxYjhVa0lGYnNxd1lwMExaVjVIWjNweWVvQ1F4cENKMm4xRUdOd0Fx?=
 =?utf-8?B?NE5zdDVRa3RYSTZkeFdyMWxsNzlWTnBseXFLNmxpSmZvdXBOSGVEUm5jMjRm?=
 =?utf-8?B?TFdRdkZ1VFludUJOanJRNHJOK1IrNzV2TTFBWU1XK05kSlNVU2FEZHFSUStq?=
 =?utf-8?B?TjdVS1hPWGoyT2E5YVQ4bExJZTBOL25OMnZxRTVDdWMxcFhUSVkrRnpKN0VB?=
 =?utf-8?B?aTA2eWRyY2lvRDZaTHlMV0Y5b2M4ZUFRbDZNU2Uxb2paZWNWN1A2OHFVQ2k5?=
 =?utf-8?B?Z2hkNlBQRk5lM0Z5YUp6a25xU0VVb0wzSzEya1VCdGVoY0hwNmF3ZjhQSW90?=
 =?utf-8?B?SExQQ2Fjak9XVmJOcnRjcWlXVHhPZnBHcjMyK01PRmlWcjNCcWJOMS9nKzdS?=
 =?utf-8?B?czU5YUJMKzRoUnlxT1BmYlZHWHAxYXNHNXNGbXppS2xxZ2tTcjl0L0RpQ05L?=
 =?utf-8?B?SDlHa1pNZ1ZIeFJjSUEwOVNyU3Nka0tpWTI5ekQ0VVBnakZQZ3dkRmpsbW1H?=
 =?utf-8?B?eW9WZllSRFF4Z29lWko2Z2VLajZiRkR6RmxycC9Vc0M5T3lWNStTTkZUdjRZ?=
 =?utf-8?B?WmpjVm9ZUHpTUENYbHBLcWV4Y2hDMWxRenFTZ1VLTGNJcXBsSnQrSi9IVUVP?=
 =?utf-8?B?S01VQlV2dU04dzVIc0M2SDhjVTBmNS9wU2RLMm9RRTM2Q2VOTXg3MUxTMWU3?=
 =?utf-8?B?QmV2dSt0cWNCWm1rOWdDdmNKb0dqbXlKV1N0S1BUaXdrY0lTVGY5V0l6WlVw?=
 =?utf-8?B?TDJPV013RHJmaVdGR0xLSVlXUDJDZkh2UU40QjhoVjJvSzdaMGVoZS9vdkxw?=
 =?utf-8?B?ZHV4WjBDdHZ1K1g2VmtiQld1MFRKNWVrYjdPUmd1a09kdWM2NlVBSlN2dGNH?=
 =?utf-8?B?OTBvTTJYeC84d21CZEczTFI2cXByWFFLK0RkdHZhV0VKNk14b0NEODRLSVpH?=
 =?utf-8?B?YnVNZ28xU3VPdXhaN1JTTjNTRlM4ZzlDS2hWaXM1NzF3OVZJOHBIb2tzdm5m?=
 =?utf-8?B?VEVOOVB0SXVmdlI5RlVETGpRbDh4dWtKdFdPUkNPT0cxMVAvcFZGNnpKblNM?=
 =?utf-8?B?bG05Z1l5eUFxNjFEamhMQk9LQ09WdkZqWGo4a0ZONnNnWi8yN2NhWnk4cHVq?=
 =?utf-8?B?Unp6UDBmV0FueFJDb2lpQUhVR2J6YWNIR1lXTjMzeXQ4VWl3VzBDUTUxWXF0?=
 =?utf-8?B?SnpOUU0veVlPU3M4b3gvb0dQSS96OW42MGlVeUIwL3lpbzdIamgxNlhZZ2Y1?=
 =?utf-8?B?QVoxVEJMd0tnUmU1bjdBR2RYNHlwcG9QdWpvR0dKbTdpaVI1NEhtL0R1K0JU?=
 =?utf-8?B?UkcvM0RqbUFUK1hKdDRPNHFmb3Q3L1hPL1NZcDhPTTJIMFFscHkrcjY4Qk5t?=
 =?utf-8?B?SElkOG5GV0JuelUzbGRiakE2eUVKcGdTUkpDeC9EUTUxbm9oSGNabUxxSVhG?=
 =?utf-8?B?MHFlZkYrNkVrMTRqWnRsRVhDdmdNNTFWQVJ4aTRNRDdySWkwNlh1c1ZwdjJs?=
 =?utf-8?Q?yMOw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(786006)(19092799006)(1800799024); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUdyb0JCU3poQjMyRzQ3RnJpdnVRdkxZNDdURmhxY2VtRFhldCtaQTdzalFF?=
 =?utf-8?B?eEFnR0F2WFQzYjhLc3NUeU9lSUtJWFJoUUZkWThoWmgzQXh3WWZQVUJNUUkv?=
 =?utf-8?B?TWlMK1RtbXBja3NUWGNKSFp6dW5qWm1oS1ZzUzZreks2dnR3RzFhYnB0QVRK?=
 =?utf-8?B?YS9Td2NpSFJoSWFqL1RJSXZWRE1JeW1PNnNXMTJsM01QeU85eE11ZDZhYzlj?=
 =?utf-8?B?aU4rcS94TVc1eFNmb3AzUlBTcFlWQ3MxSWlQSlMxZkt4eVFVUTRveWY1c2tK?=
 =?utf-8?B?dWtzYy9WWStpVER5TlBDdlo5NHRpb0RiMTVsS1VRbUY5ZTRQNUZmRHBIMWgz?=
 =?utf-8?B?TFFQWVVDTVZsUm1zUzd5SXRaRmxOMDRYR1ZyblhhQnZYbVVtTDNLZVU5aktD?=
 =?utf-8?B?NlVCMitaWVFUTExnU1VjR0xPSUptdmRiOTVyZHNjUDJJaW5ZVlY0SVRRbEw0?=
 =?utf-8?B?M3hRTXgxTEJvMGh5dVpnVlNIZUpXS3dtM1ZQcDR0Y09tV0FXVVVHMC8weGNy?=
 =?utf-8?B?V0k4WXZoUWozY0lyMGxjSGRsajd5MjVCbXdSTUlPbldvd2swNndtOXdRNjRq?=
 =?utf-8?B?cjZ6bVduYk5xamcvQ1lpOGxuYnRxdU5TWE5tU1VoWWtsR1lydzBNaW1wZVhs?=
 =?utf-8?B?NVdtNytQeENmZ2ozV0FQSmd4T1greENBa05VRlhMcVlTWkdCdThVZHZFVk9Z?=
 =?utf-8?B?RVNpVUNvcExsejRpMWROdDVWelZVam9CalpMQmJTWEFCSHVROEJmT3FLVFVR?=
 =?utf-8?B?NFF4d3B5dVcvWUswTStiMDYxUWc4WXVaWjkwekQ5WkNHSUpQb3NoWlVZSTN0?=
 =?utf-8?B?NzVpYzYxRGszbTlueUczYlhtWWJUejZxb1lBZ0N0TFpJQzhSaEZmUmVmWUpy?=
 =?utf-8?B?QWJGMDhGd3l6U3lrblVidVloYkdGZlJRbjc2Q3lGeWF0U1ZZQ1RKd3RncmYz?=
 =?utf-8?B?S1U2WWpDMXlYcXU1eHB2V0dsT1hUdUg1OVJGeFhRSHVrM0NuSTJURms2NkJE?=
 =?utf-8?B?bjVFWTNOdDhleGNNbEpkeDlMcldNTHRZM1BXMmtRVDk0S1hPTGY1TDVjWi9I?=
 =?utf-8?B?MVJ2eTBYOXNZdG54Si9Bdk9wR25BcGtJTFlSb09qazVGQmZhR3VHc0phZlpY?=
 =?utf-8?B?K1dsVHNSMlM2SWhNTklzSjBtTEpJS2VLUWRMTGNmejNDZTZybXZLeVNGSEg5?=
 =?utf-8?B?bFN1dlFVNkhtdlB6bDZTMW83Ymt3bnptc09ocCt2Q2Eva3lZY3p3ZWVpcnpL?=
 =?utf-8?B?cnkwNDZGbUNYYWNYL2l4UE51OTAwamdGaXRDK21EODVpMFg4aE1ZMHJMT0hv?=
 =?utf-8?B?Y2pXRlE2WkpPMUdKWStmM3B3Yk1vNTNwMzVrZkhJaVYxZWoyc1oyc29yNndy?=
 =?utf-8?B?eDRKZHVDQlJUYjd1d3ZBMlpaV1IrSStvMVZORzZzQTRKaGdTQ3R0WC9KWFAz?=
 =?utf-8?B?ODB4aVBId3JPdm9jeEc1L2NsdXJiSU5qTERsb1RQNHAvRlF6aWNBN09kSW9t?=
 =?utf-8?B?WXk5dlV3emtiZ2NnY053eTU2ekhpZm0xNkdCSG1rYm1QYzU2eHUySzJQOGNS?=
 =?utf-8?B?eFdETnBhUG03cFFVNUs2RmxJTFBkVkxmYVhtMVdQd1REZUVBdlk0eUV1T1Vn?=
 =?utf-8?B?Z2IwTGtCc004d1VaNGdjWDNjY2ZKOU56T01DNkZXdFVpaXFrV3VqWjd1bm5n?=
 =?utf-8?B?THJ2bFM0WlplNGlwQ2wzMHVnOEJDTnFzaCthQittRTZQSG5YaitXcXo3LzAz?=
 =?utf-8?B?Tnp6dmYzZGV0ZHZwMHVFelp2cWJBNXdYeHRZZDM2WGNZaDl3dVBydlhWTG80?=
 =?utf-8?B?aEdoYWFobjU1Q3N4NnlmMVJOSExIOGpiSmUyLzI0SER2VjV2U3lPSXJpQTJa?=
 =?utf-8?B?Njh4OW90T1orVUFjTXFENE9WUTFKSkJqQkwzSE54RWljVFMyT3RiL0QrUW02?=
 =?utf-8?B?N3hiQmZkTldzamZFb3o3b1U1c1NVS1FaRTNSVmNycExacWdOdEZxZVgyWTZX?=
 =?utf-8?B?K3FsaTVkYVpSNUZOejVCZVFDV2NNZW9sRjBmL2Y2aUJqQkQ1bldOT2phWjdl?=
 =?utf-8?B?Q3kwYlJVcW50bkEzYUpTaHU4TnpJZkJ6cUxDR2JCMjVrOHoxZldOMmg4dHc4?=
 =?utf-8?B?UjlzaHJtVW9mVlZxNHBQd0tDL29oWk56S0ZlV0RTMmJ1cjF2M0M0RnpDQ3R0?=
 =?utf-8?B?UkVpcmhjK0UxTmUvbFVUTUV2OU1PWW8zMHMyY1JJa1ZtMEcwT1VmSkVNSjRu?=
 =?utf-8?B?SFlxUWZSb1BwbTI3VGJySVN2eExYaWI4KzJ4aCsyVjVoZWNycnRZQS9iYmh5?=
 =?utf-8?B?dmxxbEo4RUtNaUZ1TmZtMCswRHdpTkxaOXBjWWkwRnZGWHNnUzhGdz09?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 118110e7-fe58-483a-1e89-08de73bdd6cf
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 16:00:32.4505 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CLM6YWAgB5ks9A2ec9wuN2YxCFd0/9CcNSPNtZqzM7KaqWD8n+LoCusHddtMTL14Na8Ca3eTYsf7pOhqPnDr9IZyPLtP3zF54iq77yhmnuw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR3P278MB1305
Received-SPF: pass client-ip=2a01:111:f403:c213::5;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=ZR1P278CU001.outbound.protection.outlook.com
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

The opaque register handle encodes whether a register is read-only in
the lowest bit and prevents writing to the register via the plugin API
in this case.

Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
---
 plugins/api.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/plugins/api.c b/plugins/api.c
index b2c52d2a09..3a8479ddce 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -424,6 +424,7 @@ static GArray *create_register_handles(GArray *gdbstub_regs)
     for (int i = 0; i < gdbstub_regs->len; i++) {
         GDBRegDesc *grd = &g_array_index(gdbstub_regs, GDBRegDesc, i);
         qemu_plugin_reg_descriptor desc;
+        gint plugin_ro_bit = 0;
 
         /* skip "un-named" regs */
         if (!grd->name) {
@@ -431,7 +432,6 @@ static GArray *create_register_handles(GArray *gdbstub_regs)
         }
 
         /* Create a record for the plugin */
-        desc.handle = GINT_TO_POINTER(grd->gdb_reg + 1);
         desc.name = g_intern_string(grd->name);
         desc.is_readonly = false;
         if (g_strcmp0(desc.name, pc_str) == 0
@@ -442,7 +442,9 @@ static GArray *create_register_handles(GArray *gdbstub_regs)
             || g_strcmp0(desc.name, rpc_str) == 0
            ) {
             desc.is_readonly = true;
+            plugin_ro_bit = 1;
         }
+        desc.handle = GINT_TO_POINTER((grd->gdb_reg << 1) | plugin_ro_bit);
         desc.feature = g_intern_string(grd->feature_name);
         g_array_append_val(find_data, desc);
     }
@@ -467,7 +469,7 @@ bool qemu_plugin_read_register(struct qemu_plugin_register *reg,
         return false;
     }
 
-    return (gdb_read_register(current_cpu, buf, GPOINTER_TO_INT(reg) - 1) > 0);
+    return (gdb_read_register(current_cpu, buf, GPOINTER_TO_INT(reg) >> 1) > 0);
 }
 
 bool qemu_plugin_write_register(struct qemu_plugin_register *reg,
@@ -476,11 +478,12 @@ bool qemu_plugin_write_register(struct qemu_plugin_register *reg,
     g_assert(current_cpu);
 
     if (buf->len == 0 || (qemu_plugin_get_cb_flags() != QEMU_PLUGIN_CB_RW_REGS &&
-                          qemu_plugin_get_cb_flags() != QEMU_PLUGIN_CB_RW_REGS_PC)) {
+                          qemu_plugin_get_cb_flags() != QEMU_PLUGIN_CB_RW_REGS_PC)
+        || (GPOINTER_TO_INT(reg) & 1)) {
         return false;
     }
 
-    return (gdb_write_register(current_cpu, buf->data, GPOINTER_TO_INT(reg) - 1) > 0);
+    return (gdb_write_register(current_cpu, buf->data, GPOINTER_TO_INT(reg) >> 1) > 0);
 }
 
 void qemu_plugin_set_pc(uint64_t vaddr)
-- 
2.53.0

