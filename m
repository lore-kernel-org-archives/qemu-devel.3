Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CAE610775FE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 18:23:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2vXB-000569-Do; Wed, 18 Mar 2026 14:22:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w2vXA-00055t-6k; Wed, 18 Mar 2026 14:22:20 -0400
Received: from mail-westusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w2vX6-0000ey-9x; Wed, 18 Mar 2026 14:22:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KwDDVosGGtpojpeAtE1J0Wyh0zagFA1ZHkDbWRtnKAaB77t98b+o1DvNjPYIeaGBp3WUPWMjKdrPuNyTnGQLmqOi44rH+1jX08ZFhGPRmKpg58v1kmmTtVakUyAFIutWJwQXBoY9G5My4c2X2QHtd/4QsHbZos2ZCCdaKIeDS9hPubj0SMWMnCahbpLYp73P8KlxhRHdhXV3iF+tfZeTR6ZkwUdyu0nD8S7K/9ccLDwKFm7cv2xVX05e/Y5wjUSWNURc3yxNR+3nRe2r/M+KtVZkUYnofJrsz216NDQnQm6QToLTJPAYC1WpxBrQT6A4/YHyumdVK8uGGET3EuVDfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oN9solVxaEfe9PzeZMdfZpPr4QtmiibJRp8UVfJ91S8=;
 b=Fqc3yjEYC6LGq9xqimZzSWiymSM4XGP7+CnumLJGBgByemuv6aaSgyOmZ0StDoMGcpmw/RlASZ0qLC5zssyIb3cqAoowddYOS1DYb/4bPnaCgqYjB4YsC+IJycShWhyq2ipm377XWwmbzWagWtSQF9VUh9xCgjECwovXc2hdUmjxqtmKE+OZtJFi5howiEjQpEfAreO0EO98YxiX13h8akev5LUNwepve+5nqDw5JVFYs85NAV7VbqYuvkPipOV23Q0ya6yUCPbRy5JbTReCxP6WVjDpNoFlIEXIZIy4alTBmO65zZYgX7KRozrctOlTsCCgIFOWTmhGqeiTuz/NlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oN9solVxaEfe9PzeZMdfZpPr4QtmiibJRp8UVfJ91S8=;
 b=nuEDkD52SIFlmoAsgv8Pat+FfWAadyaPmSApS849ZZ2I6Rs4vzDfnUTJa83P6YiR2Vhvt+9MHCTy1SKAaKYa5SMr6AWodp4zrsHB0spDHmnZNz0PZHi3OLVxORxwHBempbYYHJS1oSZfmBYbVK2PlPi9DlZQ2KFuLnDivJrR+SJQNKdLVbmSXmIzcZSH1DjnZ8BRBezCPBH+RNWZNfhADkdy/zfNAsMagaU/nVQKiKX9SHkpt/5JrWNbkNL2F1dmLJ2gf8wC2+SGFi/kETvkwz6ETDYhJGvsN5KWAxpPBfa2TtLBVtcGc//M2mDCJrDvl1EmUj0lWvOZL0bOX3hzuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY3PR12MB9555.namprd12.prod.outlook.com (2603:10b6:930:10a::14)
 by CYYPR12MB9013.namprd12.prod.outlook.com (2603:10b6:930:c2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 18:22:06 +0000
Received: from CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e]) by CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e%6]) with mapi id 15.20.9745.007; Wed, 18 Mar 2026
 18:22:06 +0000
Message-ID: <a7e1bda5-f4cf-4761-b847-f07de996a12f@nvidia.com>
Date: Wed, 18 Mar 2026 11:22:04 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/8] hw/arm/smmuv3-accel: Change ATS property to
 OnOffAuto
To: eric.auger@redhat.com, Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Matt Ochs <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
References: <20260317183755.3721625-1-nathanc@nvidia.com>
 <20260317183755.3721625-3-nathanc@nvidia.com>
 <CH3PR12MB7548D2B0E4C731983EFC8EFBAB4EA@CH3PR12MB7548.namprd12.prod.outlook.com>
 <de9279e9-3404-45b6-8df6-fbda6488bfbe@redhat.com>
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <de9279e9-3404-45b6-8df6-fbda6488bfbe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0166.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::21) To CY3PR12MB9555.namprd12.prod.outlook.com
 (2603:10b6:930:10a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY3PR12MB9555:EE_|CYYPR12MB9013:EE_
X-MS-Office365-Filtering-Correlation-Id: 31113309-d11d-492d-d0d7-08de851b42b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|56012099003|18002099003|22082099003|7053199007;
X-Microsoft-Antispam-Message-Info: gg3at+14k4w8n2wh9EZ2Tt1VYEcBI223JZSvWUlzaNWW4J74HUBcdy75YV7Dkt7BDaJ9nHckS5NdS/SPzf0T0HSsVU8axUl+5/NsR1rK+yVZtiqGlBqpGCvMgBCF85wsE1tKuOhEh1Ck0L4m2SjEVxpISq+goE5FcwSpz2p5sZbpJHwYeDfMvSS3rKeHFflo1CeE6yfwib6SZ9EEOVJkTH+k/Y88YFUx03Fh9fGBj7jrMfSROvj3KVFsdhWl83MQhL3ngSfRtIDhdID7n+xvj2IPuT1bRyu1n0HGfnPiLY5SBI+MNOa0Fiqg74S2k96gFsqQbaNDLzKK58T1V5hsHYXUEaMUny8IXC2Y3awOIDzGq51eEh2i0S5U/NwiiGxRtRzbTJLXHMQTXhJk3KBPZCwF93Dc5CbzkWdqr+KENVE/mwUi5Ek2mJyDL5R82z9QKl8puphKtEQJVcq9EgJmSdiSu4jzogkYQ3rgGyaunH2II7amfIBFKbDnYyluZa7NZhi4dbjwDFfeQ2IRU3NNBqXHyT9q12D+MoKyXaPcS3D1rQlephgT3ojYDkoeR6KK7D/pBNzueS5DbixXw9nyFhaqTEl3siyuSywAy5tQOSwa4P5FW9s52Q+A7BJ04Lt+PUCHq5Ewb2f5HwFDvFlnYvXT0HU5WGRUs/6JtgWa1P4ZlpwsgqMo59YChkgBSD6ZacMwrKl+MuN5+gc5Q7pglNsRCwJJwH9tzDtvF80pSuE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY3PR12MB9555.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(18002099003)(22082099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2M2UDN6bDBGNjI2c25oeHQxdFJXUWVER0RMcVhtUWN1QmhqdXh2ZWo3VnBs?=
 =?utf-8?B?K2F4aUJ3bVFnTFNDQ2ZvUjc3RTZKMUR2MjQ4dWVRY1R0elZEYzZKMDVLUGRO?=
 =?utf-8?B?N2dKcFYwTjlWSWhmQkpibzN5WjZMTHVka2RsbFVQQzE5VjlYeEZzRGZOVmpT?=
 =?utf-8?B?alJyR3VpREFpMW9wbDlTT1JGZm9ydDJUZ0RrZCtMNy9GWU5ObTNqSXYvRExJ?=
 =?utf-8?B?ZzZJYXV5Q1RNdnFKRXlzUXN5Q2JJalpvMEI2YU9YY1JhQ3UzZjYvVi9OdDNr?=
 =?utf-8?B?eStvRExrcE1OVnVoMWcyWHQ3Yy8zbTRJTm9sbTl2VXpoby9CbHVKcS8vYUJF?=
 =?utf-8?B?VjhVWlFSazAwMUN2YjBCdTRmbWQxdEtEeWRLMHVUQnI0L3NNZzcwcmdGWUNN?=
 =?utf-8?B?RWIvZ2lFZEZtNmFWUGJncnQ4Mi9IOHFmNGNBTlR4UTBvVDRBN1hBeDJSTDV3?=
 =?utf-8?B?YjUrYWY5OE44Qi85eDEyVFdiMllodGFPckxxbHlUczhhNHRpb1RHL1I5cmxi?=
 =?utf-8?B?M2NaV0ZJWU1yWmxBSTFCQzNXcTBDYjl3ak10dzR3cUhLaHFoam5rYzNuWFhZ?=
 =?utf-8?B?Z0pFM01YVkk3MHZ2U3ZwR2hSSTBLSzE4NWxGTmRaOFYrU2FEMXZTM09laGFi?=
 =?utf-8?B?UVd6amVyUWRmbjlvSUNiSmYxWTRGVzU3Nm1ZMy9oL2Y0Y01aZWhZMlRaUUVu?=
 =?utf-8?B?cU1HQnJCeXl0MW82YW5UK1oxSk5WbUpsSEJzR1oycmhjL1ZCcVkrUWsxRHAx?=
 =?utf-8?B?MG9QSG5zdXA1bkVvVTEzb1dMVmIwaGdQSzNGWlN6ekZ0MUcyM3NPdlY1V3Vr?=
 =?utf-8?B?YmtJSkZLTGxmRXFaK0RaRTBueUdsUXFEbGFTZG5FYTZTcGtJVWV3UVQ2NGIw?=
 =?utf-8?B?QTZMODc2QVJHckRHQW51RGFuMjBYWnFlTG8vL2k4N0dDdTEyY3NvYVNNTDNx?=
 =?utf-8?B?S3ZodmxrU1ZmNnpnNEhjdzFnTWh0SGVnMi90T3FFR3o1V09VcjVTOTRJZXRG?=
 =?utf-8?B?OWZoaU8zRUxOK0JuVG5wNXlaYVZtQUZyRG0zR25ucGtaS3JkNEFTaDg1N0ZS?=
 =?utf-8?B?SSs0NDNEdVZWbExxK0xjMHc1Wit5aWkvUTRZb1J5QWRMTzRUZ1VaeGp0ZHdQ?=
 =?utf-8?B?UE8wKzJ6dEtIQUFZMko1eVRnYnZ6Y29MZm94MzdJaDRKTVByRG1LZUo0NXFl?=
 =?utf-8?B?ampJSTNFcFhVSEw0MG5WZ0p0ZXJXVnpodE13bS9IKzlCdVRzdTZna2YxTFBt?=
 =?utf-8?B?endpMHBlRHRVYU1WbWUrS01GRGNTNUFaWlFOaU1QNitYQ05KWGo3UXN0QXJD?=
 =?utf-8?B?cG9RYXB3QWFRbmwxY2R4SG9hZVk0U3pvYm9PMjJvZ2Q3OFF3ck9NQTdXVlZ3?=
 =?utf-8?B?ZjNmc1NHenRIZXRGbXhaNndaQi9uOFhxVEY0c054YXZ5bTdQUFBheFQwZlcv?=
 =?utf-8?B?QWk3SzRRd0tQUGxQOGQ3Tnp6aFRFUlp0aXZsZmVNdm9rR1hxTkROQ1JrRUFr?=
 =?utf-8?B?VVVSdFRIQ3pnb2dnTEtGYUNzWERxRDMyZ3FONWFhRnB2ZmN5c3dXcngwNjRl?=
 =?utf-8?B?aWgxcjVmTnEzMk9aTWYvZXhTbDRIbThoUXRJYmtQODVBdHdialhXUHFNTkNL?=
 =?utf-8?B?d2QrRmt2WE1tOFBOZlpGeWRJaCtrTWJWUjdOdVBqalNyQmFLcmYxRWRZdU82?=
 =?utf-8?B?aXVtN3NvT3RxV0FNWFpjNXc2ajYxTG5vOEtocEx4SlBFUlo1RTFPTmJ5Y0I4?=
 =?utf-8?B?WFNCeUhRdlpiMkdJT3JoU2hySU05bzZpMmlMTlBlVkNVOTFLdnNLKzdaMVly?=
 =?utf-8?B?UTlEZXBCcWJYL3d6WTFETVp5UC9lbnNJYVBpZXN5UE1uK2pKTXBjTVlqZzMr?=
 =?utf-8?B?NWphVXdOdVNSVllJdjdCTGtzSEpyQ0dwRWl4a04yQ1hLM0ZlL2tCWG1udi85?=
 =?utf-8?B?TGJpWVdqZUM4VktqSHFEVXdoUnl6TW96bndrdkRocGNnSnVZZnkvRDRNeXZR?=
 =?utf-8?B?dWZLU0czaGVkc0tZUEFhQUhIcXgyTnoxNmtENE9ZT3JPVlRUaTJNYjRRcTkz?=
 =?utf-8?B?STVyakJIS1VSaS9McnNuL3djU2l0YTVVcncyMHRsU0VreDlUVm9xTEUyQjBN?=
 =?utf-8?B?dTlXWkxLcWZvcThTekdaTXo4NVlnN2Z3dG94UXNBcmNRRjhpZUcwS3pqM2t4?=
 =?utf-8?B?RGNLSTJRU3FxRjkra2x0UjUzcW50VFcvWFBFaE1hMjd2S0dkc0lFMi9jVjVG?=
 =?utf-8?B?cTJpU1NVWjl5QWVUeVJhWE84RTlLNkhXQ0RzK1NVdTU5N3drOW42ZVlTeGc0?=
 =?utf-8?B?Y2dPRytHMzNtREswWm92YzRONnBoaS8yWTlOS1Q4dTNYQWxGZ0lrZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31113309-d11d-492d-d0d7-08de851b42b9
X-MS-Exchange-CrossTenant-AuthSource: CY3PR12MB9555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 18:22:06.5214 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ModXfjVqlsQ0WqH305bD+Rm8Z5N8PbaAQ78LcPuZgH/63ZSVST4KC6DC/J5fci3y6/NXrZ6ZycB6qylTeANEBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9013
Received-SPF: permerror client-ip=2a01:111:f403:c000::1;
 envelope-from=nathanc@nvidia.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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



On 3/18/2026 6:38 AM, Eric Auger wrote:
> 
> On 3/18/26 10:31 AM, Shameer Kolothum Thodi wrote:
>>> -----Original Message-----
>>> From: Nathan Chen<nathanc@nvidia.com>
>>> Sent: 17 March 2026 18:38
>>> To:qemu-devel@nongnu.org;qemu-arm@nongnu.org
>>> Cc: Eric Auger<eric.auger@redhat.com>; Peter Maydell
>>> <peter.maydell@linaro.org>; Shannon Zhao<shannon.zhaosl@gmail.com>;
>>> Michael S . Tsirkin<mst@redhat.com>; Igor Mammedov
>>> <imammedo@redhat.com>; Ani Sinha<anisinha@redhat.com>; Paolo Bonzini
>>> <pbonzini@redhat.com>; Daniel P . Berrangé<berrange@redhat.com>; Eric
>>> Blake<eblake@redhat.com>; Markus Armbruster<armbru@redhat.com>;
>>> Shameer Kolothum Thodi<skolothumtho@nvidia.com>; Matt Ochs
>>> <mochs@nvidia.com>; Nicolin Chen<nicolinc@nvidia.com>; Nathan Chen
>>> <nathanc@nvidia.com>
>>> Subject: [PATCH v3 2/8] hw/arm/smmuv3-accel: Change ATS property to
>>> OnOffAuto
>>>
>>> From: Nathan Chen<nathanc@nvidia.com>
>>>
>>> Change accel SMMUv3 ATS property from bool to OnOffAuto. The 'auto'
>>> value is not implemented, as this commit is meant to set the property
>>> to the correct type and avoid breaking JSON/QMP when the auto mode is
>>> introduced. A future patch will implement resolution of the 'auto'
>>> value to match the host SMMUv3 ATS support.
>>>
>>> Fixes: f7f5013a55a3 ("hw/arm/smmuv3-accel: Add support for ATS")
>>> Signed-off-by: Nathan Chen<nathanc@nvidia.com>
>>> ---
>>>   hw/arm/smmuv3-accel.c    |  6 ++++--
>>>   hw/arm/smmuv3.c          | 14 ++++++++++++--
>>>   hw/arm/virt-acpi-build.c |  2 +-
>>>   include/hw/arm/smmuv3.h  |  4 +++-
>>>   4 files changed, 20 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
>>> index 2bb142c47f..621ac531a5 100644
>>> --- a/hw/arm/smmuv3-accel.c
>>> +++ b/hw/arm/smmuv3-accel.c
>>> @@ -826,8 +826,10 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
>>>       /* By default QEMU SMMUv3 has RIL. Update IDR3 if user has disabled it */
>>>       s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, s->ril);
>>>
>>> -    /* QEMU SMMUv3 has no ATS. Advertise ATS if opt-in by property */
>>> -    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS, s->ats);
>>> +    /* Only override ATS if user explicitly set ON */
>>> +    if (s->ats == ON_OFF_AUTO_ON) {
>>> +        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS, 1);
>>> +    }
>> Nit: I think we can keep the original comment.
>>
>>>       /* Advertise 48-bit OAS in IDR5 when requested (default is 44 bits). */
>>>       if (s->oas == SMMU_OAS_48BIT) {
>>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>>> index 068108e49b..3dead0bcd3 100644
>>> --- a/hw/arm/smmuv3.c
>>> +++ b/hw/arm/smmuv3.c
>>> @@ -317,6 +317,11 @@ static void smmuv3_init_id_regs(SMMUv3State *s)
>>>       smmuv3_accel_idr_override(s);
>>>   }
>>>
>>> +bool smmuv3_ats_enabled(SMMUv3State *s)
>>> +{
>>> +    return FIELD_EX32(s->idr[0], IDR0, ATS);
>>> +}
>>> +
>>>   static void smmuv3_reset(SMMUv3State *s)
>>>   {
>>>       s->cmdq.base = deposit64(s->cmdq.base, 0, 5, SMMU_CMDQS);
>>> @@ -1971,7 +1976,7 @@ static bool
>>> smmu_validate_property(SMMUv3State *s, Error **errp)
>>>               error_setg(errp, "ril can only be disabled if accel=on");
>>>               return false;
>>>           }
>>> -        if (s->ats) {
>>> +        if (s->ats == ON_OFF_AUTO_ON) {
>>>               error_setg(errp, "ats can only be enabled if accel=on");
>>>               return false;
>>>           }
>>> @@ -1993,6 +1998,11 @@ static bool
>>> smmu_validate_property(SMMUv3State *s, Error **errp)
>>>           return false;
>>>       }
>>>
>>> +    if (s->ats == ON_OFF_AUTO_AUTO) {
>>> +        error_setg(errp, "ats cannot be set to auto");
>>> +        return false;
>>> +    }
>>   Nit: Is "ats auto mode not supported" better?
>>
>> Also, should we do this before the if (!s->accel)  check above?
>> Otherwise, I think it will carry on for non-accel smmuv3 cases like,
>>
>> -device arm-smmuv3,primary-bus=pcie.1,accel=off,ats=auto
>>
>> I think this applies to other properties in this series as well.
>>
>>>       if (s->oas != SMMU_OAS_44BIT && s->oas != SMMU_OAS_48BIT) {
>>>           error_setg(errp, "OAS can only be set to 44 or 48 bits");
>>>           return false;
>>> @@ -2128,7 +2138,7 @@ static const Property smmuv3_properties[] = {
>>>       DEFINE_PROP_UINT64("msi-gpa", SMMUv3State, msi_gpa, 0),
>>>       /* RIL can be turned off for accel cases */
>>>       DEFINE_PROP_BOOL("ril", SMMUv3State, ril, true),
>>> -    DEFINE_PROP_BOOL("ats", SMMUv3State, ats, false),
>>> +    DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats,
>>> ON_OFF_AUTO_OFF),
>> I think we should update the description in object_class_property_set_description
>> to mention auto not supported.
> I agree with Shameer wrt all above comments

Yes, I will make these changes for the next refresh.

Thanks,
Nathan

