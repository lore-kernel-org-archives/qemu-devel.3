Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CD2EEBFD38
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 10:57:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCEyI-00058H-AH; Mon, 13 Apr 2026 06:56:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wCEyG-00057q-Ny
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 06:56:48 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wCEy8-0006U7-U7
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 06:56:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dsIjtIxHwQhRHi+CyNXdSIFJcDc+RlmmL9Tft0wCRlnGrT110fdQxcSK+RlDP/Pty6konGCPJ3y3SfCQWyd6oY3aGgjykDr4hV8Y75TOTgMparC/pQQp9Xg+e2OeCfUmSKjbRSC/Cq42rgWabY+HsgInOYNRDBo1ZZbMGoIPLRFtFl8aIp/3EAbpxrf/YRvG7p2+RIs8P5sg4jZYk+0EdYppk4YfhERx7iQKJ1tUeusAoREkK7DUVbnl4aFnbztItu9hSSyrystg9IT8RAFglbXJ0xuk6KiACIp7ylmFdqAmzF+cjkTbjXm2XrH1OVvJ/oc2HVHDHvNHhTUaBtA8HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQMTuCSpBzFQiq0j0VxHm9kOSbTMKB35wiZjYRHyTos=;
 b=lWmC20aO2FQrzv5nzcfsQN+ZjoPPUUiw325pmGpF2WtImmU2W5tay11HsTc4zMzXmP+qFJVmwrO2spiXLN4tMsIYEntMb/8HFCQSSzt9NMHVNBUvg3R2dVsr8Q6EfS5sCgXbYQTd+a/qTqz1TTwHnE0yDUknrx1bccmZgY/kaFv0skJcl1TEQe13pPXkvxx07bISjmzfMtcDhrY8nhs4JNYceSQhxVch5VQgzIw8osOIYrXtTL5Pu04YLfNh3YhWrZkeF5IZ8d4qxSGohF9Vt5djxHviF++wnpoEwJO/dnoPyuOPBET/tFiKoFRm5oVbTuNXDKqjrjCJtCtZYD9lSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQMTuCSpBzFQiq0j0VxHm9kOSbTMKB35wiZjYRHyTos=;
 b=OTAtr7pLCXJ0rprHe+geNIZhPolBY43V+k/wWQ2bIaDvZWCl7HlJMSLUXSNcdXqiecclYcCjkbTMw/cxPdXHbHGBw1BeWw7gf8evk1hoqdDFVRIU5qHtMxDcq7lPuOn8o2AfHUX1E8ueHizGX5I94kxRlO+i1tX9KamTlI5O08fh61a+/O+r95aqW3QzSPC3xBtPe/+5lTduQmnOghKGGOzTg2sVLzYYmEv91LdMLIsbwKkjD5rdfpScboxlzLHSNgOBqwJnqQnE7tVQk4PXj7BhtSZaDc7rNz828RgPKSx+uesmH5bhgy4d21ILjbApb2Eff5ycSbCBWXud4US+xA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 by PH7PR12MB7353.namprd12.prod.outlook.com (2603:10b6:510:20c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.42; Mon, 13 Apr
 2026 10:56:34 +0000
Received: from BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da]) by BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da%7]) with mapi id 15.20.9818.014; Mon, 13 Apr 2026
 10:56:34 +0000
Message-ID: <3aa9911b-840a-4284-88ce-c9a5543932a3@nvidia.com>
Date: Mon, 13 Apr 2026 13:56:28 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/14] vfio/migration: Fix incorrect reporting for VFIO
 pending data
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Zhiyi Guo <zhguo@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Joao Martins <joao.m.martins@oracle.com>,
 Markus Armbruster <armbru@redhat.com>, Alex Williamson <alex@shazbot.org>
References: <20260408165559.157108-1-peterx@redhat.com>
 <20260408165559.157108-8-peterx@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20260408165559.157108-8-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0016.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::18) To BL1PR12MB5063.namprd12.prod.outlook.com
 (2603:10b6:208:31a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:EE_|PH7PR12MB7353:EE_
X-MS-Office365-Filtering-Correlation-Id: 624f6e84-f217-4dff-2da0-08de994b53f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: QWExCpgIHNY20cHS6ewkY7+XSioLAxpDZs7+Pmp6zSRpNQw9d57SzLvTREqQzdYFfkHbiHiHm6eis82F0GJmcKT2QTneFC3hZtrneRlnYcSFp0UX9bqAD7h/v+xxN70o9z86BjLivs9eh4qs8C415UdsLFGKfQEPddhgDmCv+yrDhvc5KnEJoi9wJ97MVyyyZVBj1qTFzJ/Qww6MmXxTF17aVKx1upu8ndfdDJjgYXy9H0S+1kz8kmDMlYSOXJ5zbmzazSdFjyyffpI7xySGF4Q8LLhsYsD/LIm6XLUjK3TL4GFaSGkoms25dyIgMl4/CkDN3wC0D2eTF52OgVUPJRWCuQdH8FL0XEoVM5YwFmpMbf/FSbVTbMjc5dgFX4HFPoz+woijFRyM5gVIitXMHTXXv2F4SOA3Ua54Cwx0TFW3QjYZOC/QF/eF2HZPDs106cD2gNZoE0Ld9AaLT3hhM/GqJNf08Fe9CCUbexhM6SLaQgl6ECRopnX+mWQNL9cAhFmbHelRud8evWadnD1QB2+sjcZ4iiF6NbFLd2TtzZkD0aqa+qH5w6ozNsQZg70HJN24GqxyRTOPZRydNkR4C2iryjg5gUTO5iWwK73VQ7golYesRNUZiD1Us36NnpX6Lmparv/gDrZsi8Tzn6z58d9ncEQJwI5BwByzMQdk8W4T9Av5Bnnp5LIP5Xcshzmo2XZYJgrJX0d3d8Y7PInFB3IlZs6RyKXIl4mWjDBp4lM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlpxYTFOSldCRXB6ZFppQjVJTUFDQnZ1cW12aHpVbVI4UTgwcDY2N1kzRi9Y?=
 =?utf-8?B?T2VUKy9lbm9sbDZkWE5qLzY3Vkp3cHZtUWpqZUxzQTUzdGxRSkhLOGkxdzM0?=
 =?utf-8?B?OVpEeEJaZ2hFZ2pqU3dIUk92bU92Qm1ScjNxcllIUnhEdUNuYnVhOGlsODRv?=
 =?utf-8?B?ZzRtaW52NWYrSitrZUtjME9FUHZDWHgxS1A3bTdkdWpvWHAzL3lKRTlaaVo0?=
 =?utf-8?B?NHJPMWh1ZkFPVFk4RmpGd3lGeFUrR2R6ZzNuOW5Vcy84dkdYUTN0MWRjQW1L?=
 =?utf-8?B?aFR2cVg4NFdod1Zia1oxcVRySDFuWHpmc2RtaXFGeWFXVkhWNkxRdFlFS2VX?=
 =?utf-8?B?WlpwR2F6S2lEUW9RVzN6TzVRVmI5clFUMFB1K3ZLTktDZ0h4UnZDV0Q2TTJN?=
 =?utf-8?B?eDUxcjBRYzJ4VUdnbTFudnhIZG5iNmpYQkNRMEdzUVgxOGs3NHhWV2FWVkZl?=
 =?utf-8?B?dUVzL1REaVVvaWtQOFk1OG95QkJ5VndRbW9GUGFGNEdqeDR1N0lRZlR2RXVT?=
 =?utf-8?B?dnBraW9mNnpHU2FRNDhiU2lQeE11U2lFL0dtOGNwTnVUY2xSZVVBN2lZd2J5?=
 =?utf-8?B?UFBCVkNEa2U5YXl2V1g5bTRXZDA2blI2MmpnRno3L2M5OHZ0bDJHM3BtNVlG?=
 =?utf-8?B?T08za3VwMFc1SWZ4SXJvcldKaUl4eGM4bUpUeUJVU0UxcGduVlNVUnRxWEo0?=
 =?utf-8?B?NjUrQ1QxanNFYTJDekRpblZzMnV3TkRKd3k1RVFmZEhOT0R6VHBtZjhwOE15?=
 =?utf-8?B?MG1XMGt1OTlHb3lKT3F4bWZsQ0xjWjUwNlRjY2ZsYk52VGordlJYanBRYnFH?=
 =?utf-8?B?SXE1cmU4Sy85UGxCcmJTUzNxcXBteGJpcFIxMjVqU2FYSmNTUTZxMUFjQzVs?=
 =?utf-8?B?Tzd0YXkzUTlxZ1MyUmVUZmZFTDVlM0xoV0dxT1NXY2pCSEwvTEhJaTlzNlpD?=
 =?utf-8?B?N0VJeUJNUzFFeGdQRkZCTDdXSzkzY1JpcEJZZUgyc0tPaXRMbHk1UDN1dlps?=
 =?utf-8?B?bTdUWXNZb1BHWmxZZm9jYTJLTEVZNGdwODVINkxRUGRwcnNETmZTS01HVmZN?=
 =?utf-8?B?Yys4TTNaZFlXZDAxK0hvcmR6bEV1cFVJaWRhOWc1eS9ydU1zcE1JL3RDUzhB?=
 =?utf-8?B?NG1hNUZ0Q1NNWllqcW11alRkT091clpZRlA4R2RSay9oTkJaYTVtN3pBS21M?=
 =?utf-8?B?RFZFTW1KR1dYSURVcTJQTzVKM3FoSFhJM25RVU5pUW1HTFMvUWkvUFpzZXhp?=
 =?utf-8?B?MEZLMWFRTHd1S0wxT0h3enNKMlIxVVdhKzRNenNnMkpNNVZickpMdm45eWs0?=
 =?utf-8?B?L1ZVWHpLNGp3VENSUWwrbnZnd3kyZzBiVEEycHg1UHA4aWs5NUpvSUMzczRH?=
 =?utf-8?B?NWZTaHpFazJCNVB2ak1ObmZQVDZKUkp0Z3FxMEVjeUlpNFJBb3R5cG5jRXND?=
 =?utf-8?B?Rk1YVlczS2VtUUhWTkcrTzFiRm1peGI1U2s4TklSMHZub2pRVzQvcXZsd3Vp?=
 =?utf-8?B?WWFoazFLcTIzOVRrbjR0Q0JGa2RjaVZxZ0dHZk1rNTc0bWE2a25YY1AwcHVj?=
 =?utf-8?B?WE9BcUZENmVUeElFM1pCQlFJNHkrWXdxb0ExQzc4MzVXdG1ub1pzQUFXL0Js?=
 =?utf-8?B?QzJFZkFQbC9FbVUvd0thcy9pM3JqU1d3cmkyelJGN0VOWjVZYW8xMVNxRTM2?=
 =?utf-8?B?d1pWRHVWcEZRMlhGMFJVTU1pYm5qYjBPbjhkVTZRQWxhdURKRDlQOVBvNFBT?=
 =?utf-8?B?WFNaU1YxYkRSNkVVVzR1TUFYd3lyakRlYnU0SGdmNXByd1ZHaXVkYmVBTUxK?=
 =?utf-8?B?VS8ydXI3aUFkcWM4RG5pcE5BakRqVHVWYkh0U0s2R1B3QUs5eU9sdkxNMDd0?=
 =?utf-8?B?bFQvQjJNa1FORFJ2alV5K1FpdWdYeTFCWkhFSzJrbnU1a0VnV2VnelJ3QnYx?=
 =?utf-8?B?Nm9SZFRqTk1RdmlWT3NSQ01ISG9RMGZ2bkQxMGR4SkVmbnd3NHI4OXlhQnF1?=
 =?utf-8?B?bkNyanB5d0xhcmJhK1ZPSWd2dnp2OUsxRStIUGlYOENpL0dLQUllNkk1ZkY4?=
 =?utf-8?B?VXpkUHRLNkZybDBkeGQyTWgyTHcyQXZXNkV3Sjd1cUNpV2R3NFVxWEtwS295?=
 =?utf-8?B?WU1VT3V1UjRaRWV0Sit5Q3F6Q1Q3bnRqd2JHVjJheGNGZEFvOE80TnN6RmJX?=
 =?utf-8?B?eEpPbU0veXRIeVlNb3BKWERiSUdteHRCREswTmM2bmRTT0RXS0V6TTlNYjlz?=
 =?utf-8?B?YnFxcUFvRWxLalB5UC9ZRmp5VFYxcHYycjlTU2F6SXd0Sko0UHBWVUQzeTFT?=
 =?utf-8?B?SStQbVJjNUZ1UDM0TStsYmMvOTVncVc1Yk01RllIZXB1cSthT1JyQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 624f6e84-f217-4dff-2da0-08de994b53f7
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 10:56:34.4941 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bpOpy08O9hHoxeAiWewOjAglTa9yRgekrXR6z9xvQT8VfXb7Da7PdPuoRotzFjCuycrEhe0bGVMhE5/OT4UN5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7353
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=avihaih@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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


On 4/8/2026 7:55 PM, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> VFIO reports different things in its fast/slow version of query pending
> results.  It was because it wants to make sure precopy data can reach 0,
> which is needed to make sure sync queries will happen periodically over
> time.
>
> Now with stopcopy size reporting facility it doesn't need this hack
> anymore.  Fix this by reporting the same values in fast/slow versions of
> query pending request, except that the slow version will do a slow sync
> with the hardwares.
>
> When at it, removing the special casing for vfio_device_state_is_precopy()
> which may reporting nothing in a fast query.  Then ther reporting will be
> consistent to VFIO devices that do not support precopy phase.
>
> Copy stable might be too much; just skip it and skip the Fixes.
>
> Cc: Avihai Horon <avihaih@nvidia.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   hw/vfio/migration.c | 18 +++++++++++-------
>   1 file changed, 11 insertions(+), 7 deletions(-)

Reviewed-by: Avihai Horon <avihaih@nvidia.com>

I also tested it with mlx5 VFIO device, similar to your test scenario 
(and some other variations of this test):
mlx5 VFIO device with 4GB stopcopy size, configured 
avail-switchover-bandwidth, downtime_limit too low, increased 
downtime_limit, migration converged successfully -- exp_down/Remaining 
values seem correct.

So feel free to also add:

Tested-by: Avihai Horon <avihaih@nvidia.com>


