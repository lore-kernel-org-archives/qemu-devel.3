Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CBC6E77180
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 12:44:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM51d-000378-TU; Fri, 13 Dec 2024 07:44:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1tM51W-00034Z-9X; Fri, 13 Dec 2024 07:44:02 -0500
Received: from mail-dm6nam10on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2413::600]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1tM51S-0008Cv-3j; Fri, 13 Dec 2024 07:44:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iEqRWgPUI/hAe+gWxFYi2khnZ+acSkUfikimDQxOmYPMC3LSOG7aHkUBw0zE8zuNXHO4SNyyX7qps3uV/vo6wYlkh24HOcTbUa2mkYGrFzWLkxHKnstBs8puI72DAwOaurJTdu5p9GdK4neVJ3tNZ5axSYtOFWkBSIEnQ2uTz31X760udDXk0k8nHHw/8z+B0L9y4jK3OeuKTGi93fBQOlP6pI8nh1zrH6hvduUg7Oyx54sQyVHa93hEO0cfqHzOONpgMT/nlNnnMq3RE2uYHPuBoLglw/QF13ZxNeg+iQq0chTQMyih9FKIN74WCS8YlkMym91P86lSpFgdeu7Oog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pg0wn5ataQgXUIkN9W9eYDxXV+d8piNOkUpHaNYiua4=;
 b=qdyYyti72QwriR662I+EWr9NHSiSLg9ZFj9RcqOnsDrTODnK3g0SH6Y8vO9xTrNC97OgCSAEA5bG6f4csHwyFwtf9tuccYMVvPnjjQcm+JAQG1uqygw+KVCrO04nuGQXZs0nYhuyI6f8BXhpxxWML6QNM3M0CUZqXbAzGKzQpcrAsgodyW4NirOHBANapC9NEqSH50Me8ROtTerLngzvzchMTmHpqa/4xTvNCaP+rHYjvr9j0DFDkH0p4/XlU5IviinD7FK0WBTZj4bmbp37Jv337gzNK+AQQWCRz+hETrGVPduAqHt8ztGe3yuFpUOasw0WlOjsBJRW2Q/GJJr10g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pg0wn5ataQgXUIkN9W9eYDxXV+d8piNOkUpHaNYiua4=;
 b=eE1iM38fS7ZFWuuqJmMwuaFhfF92OAotB6Mw/5sxbEtQvsZ8/WJ+sOTlZvwjQTvEAywtTtRp1mdWMnI4EIvZfbcjKuvq1hjInNylDVxgAloDXpwsTMteBIgnT2ZVWCxfI0bhJ0L30IcFA2C5zDOclPeFSzFTxMhb1WkGK+SzOfzdmMZrQfVJLt80aj6eljH57t5QKqQFbRefe/XfXZCo4323UXxBmFxu2FFdVkbH/UbuR2uknTM89TLBBYJEXo7uYwn6btGq6J4q4T1cF56I90e8ICMiS7mAiab6XpT0xxfHrm9+qqUwWGTV8BlsvocMG7CzWf/jDcolh+7TKQ4n/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH8PR12MB7028.namprd12.prod.outlook.com (2603:10b6:510:1bf::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 12:43:47 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8251.008; Fri, 13 Dec 2024
 12:43:47 +0000
Date: Fri, 13 Dec 2024 08:43:46 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Nathan Chen <nathanc@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "ddutile@redhat.com" <ddutile@redhat.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Message-ID: <Z1wsAkZ7LUTv4HRv@nvidia.com>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <ZzPd1F/UA2MKMbwl@Asurada-Nvidia>
 <2a61079f-a919-43b1-906a-bae8390bf733@nvidia.com>
 <04024d09ebad4d83ab0679f6bb3b3774@huawei.com>
 <d2bc4fdb-3188-4063-8ead-f2ccefec9c81@nvidia.com>
 <4f657876547f4001935f7314ecb8f8ca@huawei.com>
 <Z1whSkMS_TVyYGsW@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z1whSkMS_TVyYGsW@redhat.com>
X-ClientProxiedBy: YQXP288CA0032.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::42) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH8PR12MB7028:EE_
X-MS-Office365-Filtering-Correlation-Id: 831e3d30-762c-4966-13ed-08dd1b73c9ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UjNLYTNXYTlVNFNSZndabndNcXJzblU5QXJtTUs2MlJWYnlZYzN2UDJ1Tjg3?=
 =?utf-8?B?STVVelZTOUdaOUo0Q1NicTdFNWppMlZPeHZOV01wTGl4ZGxmVVNZa1BVVk9h?=
 =?utf-8?B?NE4xUTJiY04xSlZkSEdwTFUvSGZQYUZDUVoySnpFQTZneGlLUG0vRUcvV216?=
 =?utf-8?B?OU5GeG5iRzhBSDY4dGpLcWtYcjJudVBxWFlrWDU0VGhBcE9IVjBvV01PYU1p?=
 =?utf-8?B?MW10ckdKSVJOMlVCbFFmakNxQktCcE5wRjhyQUNMZG0wazNnRVZqSFVCTk9J?=
 =?utf-8?B?aHlkcTFzQ1JNRWNrdm13SWNZb2JTb2pIMWZQOUpPTys1UmVrSTFKUVhHcTZt?=
 =?utf-8?B?NW5FRm0vby9Ud2FreDQvMVV1VlZEZEM1d2k0UGYvb0ttNFY3d3VmTHl5andp?=
 =?utf-8?B?TTlaQ3RqMEpBK1NhTzRtcDl2bzZnT2JVdDhCcnlMK281Rm0vUGJrSVNHanJl?=
 =?utf-8?B?dlIyVEJkRXlFU1U1RXRmVE11NWFGY2REWjJheDd2RlNQenFvTVRBOXlISHZh?=
 =?utf-8?B?aS9uM3Rnak5CbG5CbFRhN2pzOHplUC90MjZUUjRpRUkrQTA5N2N4bTY2UzF2?=
 =?utf-8?B?ajk5SmovNkpENXAxSWJwdGlVUmcxdlBheU5uUkRnb1FYWEhrSTd5OWFvUTZQ?=
 =?utf-8?B?WWdCYnRhQ0xyVmJYeEEvUTVENSsxTm5aM2Z0S2Q4KzkwZUNwUDNUUnQ0Y3lp?=
 =?utf-8?B?b0p4MWtUbzl5Y2JkMjVnOGFCK0xmRTZyU25adXdsL0RzNlJTYlhTOWtOWG4r?=
 =?utf-8?B?NHZtRDM2WHJXcnBuMElHSmc2ZTBVbjE0aGRhTWhDTGVYYWI4ZkpVQ2c0MUVR?=
 =?utf-8?B?eUVDNWlDMU1BMzJKR3luelQ3blFNVm9WY3lMaHZyalU0dHBLbEszbkVIVWNX?=
 =?utf-8?B?VmwzZ0pZQ0ZCWUt3Ykw0MTFDTzh2SkhCbWNoTm5PZFFqQW8yWmlQZXJDOHhR?=
 =?utf-8?B?cHFYWDNIZWFRRG9QSWV4aGdzcE4wSFVoaGt2UFk4cUZ3enRxQzlNbE9sVWxX?=
 =?utf-8?B?U2ZObmVtR04wMmdXa1lrTHdSU3N0NzdPVG45bE1SSXpTTnlvV1A3TjZ6dU5S?=
 =?utf-8?B?Tm42RUwzc3RUVWJReVdsMytpSUhIK1RoMjZpdUQxQkhlemhmdXJMYUhVSFdu?=
 =?utf-8?B?VXhIdHNxTFBUcGs2RVZOWHpFU1UwVFJZQmo2ZXk5TUZ6UEdPdzk0QUFHWmZJ?=
 =?utf-8?B?Wkh6RFU4OE1CbW5JMitKNzJvOUN6SVR2MXpXUWN4eTVMWlM5V3AyZUhGZ2NS?=
 =?utf-8?B?SFZvNHRrcDBIcG92OUgrLzluVW4yTDJVeTZ4d3hNbmtXalk1UWJSZHZkeEo5?=
 =?utf-8?B?WEdINWZYbU9neUhIL2RGY1lMR0cyZ1pjYS92NGFKc1FoekRIWHJEWEhtaDQ3?=
 =?utf-8?B?OXd1RE80SVJ4UWIxSzRVYVRjek9YWS82N0VEUE9Kc2p1cEc3ZlBsSEZZNjlG?=
 =?utf-8?B?SU9Wa09XZXdxWXpxOVZFVk95dVZhUmdiV0M1RHpvQWsyM05vR2IrdnlySk9D?=
 =?utf-8?B?bTRSWjZ1bFBqRVl4d2ZRMHJuM1FhelpyQldVMGNUekVodWVZNzRHdmJFbkFD?=
 =?utf-8?B?ZzdXZWZsV1VDeVhVVHdkUHRmWjBkQlhmTUZ4WmxLMURkb0NEMFlWQmNzU1JN?=
 =?utf-8?B?WDdEdklHVER6eUdVbUxuOXJOSURYVU9yaTRUbzc3WGpZQ0FBYm5NZ3VSeGdI?=
 =?utf-8?B?QlJOWDBaem5sUkwwaEwxd1RMbzV6ZFRxaWpWVHRLRlNHL3dudEJJeWgvOEds?=
 =?utf-8?B?VW5kQld5eFJVeFJjWVlnMk1MaXBiUzZpT3F5SkxJZjQyNlhZSk5GemhlSE5t?=
 =?utf-8?B?eVhkbk9QN1ArUlZoK1p2Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8659.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGJNUUJBVC9jT2pNSG43REJLZVdwdkJySFk3SzFxODc5cWEvaDJBU1JGSjRs?=
 =?utf-8?B?bytReTZqTjZPSm41Rk5ZdWJBQkFjVEpKTWVJTnh5SHJpWlM4cmpGQnJlcWp3?=
 =?utf-8?B?bldQdUhKOVl3eHpWRnBiK2xKOFNnby9ZZm8zQzhxbnVvc2ZNaGl2UWtISDFv?=
 =?utf-8?B?aTlhS01VVXZhOGIwcmVOYnI2WXdxZExWeTY3SGVjWUhNQVQvSTFwY0hMaUtV?=
 =?utf-8?B?dHFyb0V3R3E3NzJNQWlWMzB1cU1kTGdNeWVxLzVad05laW51YW5tdGtybnB1?=
 =?utf-8?B?WDJLbFFBZmRLZGYvY2xnLzJaTDZ0R213YVRUejJreGVHd2NUekh3KzY3U2Q3?=
 =?utf-8?B?dDNldnVkOFhvUTltUktWblVvZTBSOUVoWGRQMFhtb2tJUjNqM1ppSURVUnEw?=
 =?utf-8?B?UjJOVXF4RUxUdW1TRWl1VWRpOFBHd0pTMk5LMTBDZ0EvN0JpZjBsd205ajgy?=
 =?utf-8?B?VVpiMEZkbklOWVRkb0YycVdKN05LZkhLZXV4cHFySXhsSlRUQkV5SFNQaHpj?=
 =?utf-8?B?cExxRzNXTmFjaERSMFhLR05wazZIOEorbnkyTCtSMVhGcWJPSEJpdWE4Nkp1?=
 =?utf-8?B?TnA0WGR6QlU0RWdUR0Q1QlQvWEcwdkpWOUNtdzFRM3g2YTIyTzJEOFdoR1Rt?=
 =?utf-8?B?Sm1TaDlHajlVdFNtY2JUWURJMmZDWE1ZRXBQOVF0VDR3Sno4YTluWkxGVG83?=
 =?utf-8?B?NTRBV25lSlNSNkdOZTVrNnQyTTRGZmpZUmhVRytpaHIxQWpnUnV3YXJxZ3Z6?=
 =?utf-8?B?TWVHaE1mY1BtWkF3V0ZUWm9DNEVqOExOUFhmS1h3bkw1VmNPUmgzOEdySFh6?=
 =?utf-8?B?SGI2bVp3UG0wRzBSV1RtNWZvNFRJdTgrZW91TEpRMjBOM25SaGNkVzRQODBq?=
 =?utf-8?B?R2ZyV1g4b2p0WG1nRTlzZXRsMHpIa0FLSnppTnlHblJMdlBxTnlvMVk2WVRB?=
 =?utf-8?B?MElTNlBacUw4aCszSSt1Y2thSE15R1FOc09hM2xHWXo3OWt0K1FSbGNnUkZu?=
 =?utf-8?B?cDF0S2k4YjBxSWZpaHlhdWkrV0ZiYWJZQnJSYllsZmNwbGNueGFaQnkyalJk?=
 =?utf-8?B?UWZRRDUzTjBXTytEVGtxRHFUU3d1cWRqRlc0Y0VVR1cxYk5Hc3g0OVczMUQ2?=
 =?utf-8?B?bnJGL1JVWTNLLzN3QU1TWG5hb2MwZGk2cDdCeCtKWk0zcGl1eFA2aFFyc1JV?=
 =?utf-8?B?YSt2UVczRkFYUjNJcmNNeXorL2cwL2VTQklibFhRVkluQm9qbER3S2EwZlB6?=
 =?utf-8?B?MHVuTWJHZ280Nzk0dmlUcmRvL1Jxc0NDcUVSSThZOU9KMllobkx0R1JENW1j?=
 =?utf-8?B?SGpFYWxBMDRKNHpESHNmOUFRZnlBRWgrOEpQUDV4Q3EzdjVza1h5V0ZST0Qv?=
 =?utf-8?B?cW9nWUlqTWV3TE5ibnQ0b3FvbmVPTUJwb3k4c3d1WFhjbXBUSFBValZWYURu?=
 =?utf-8?B?WGhlVTh1Z0dkeDJ0OUxxZjdzVGl2OHVSRTV2UW55UjAwWllYMXpId3grT3JQ?=
 =?utf-8?B?U2ZnVUdQdWdIN1h6WCtsa3cxZUEvcy9DYTB4eTQwNFdsckt5RXNQa1dsYlFY?=
 =?utf-8?B?cXJRbHpxSTZCK2ZkQ2JZMGJ2eHNTK1ZBbkZOWmxqdnFYVk43Q21PVlNHMmVZ?=
 =?utf-8?B?SlBuRHFhdnd4TG1jSyt5WlBmWjFvZVVGa0NpaVdPMzJoUWwvVVluWjBFUkpV?=
 =?utf-8?B?a1ZUMUgyQ2wweG1PaFBDYzAvY0o4MHhFRG9nZHRMejJjY2ZUbTFZYW5ZUkxm?=
 =?utf-8?B?VUFUUEl5Tmp1YTd0QlRiUEJtUlhHTE1sdlBMemFKMEZGdStaUWhiTFhOeUpO?=
 =?utf-8?B?WURrYmVCVXppUDFIWllzZXhqQk1sOVlObCtSL0dRTUFKcUNBelM3dTFtRm1N?=
 =?utf-8?B?eHZiRkxrNG52NWdiZHFpdWVIUUZEc2UwMW5hOVJkWG5lZmtXMzlEWkhZK1VK?=
 =?utf-8?B?VWVwWkZ2d2R3TzVndGJsNW9JM2M4MEZ4ZXgyUmJsaEp2RS9Kd1V2VnNKUjRM?=
 =?utf-8?B?TjdremlHaUZEWDlhK2I4TEZVK2NhQk1sR2pZZllraTMzNnBKeVROdEFIb0Nh?=
 =?utf-8?B?d0cvZ1ZIL2NzZk85NS9lUnhCQ0xlYlhMVjlPbVZaRGdsZWFjR2tJOVhKbnZr?=
 =?utf-8?Q?VhPvRf+j42/Fxl7S68AAVyGlA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 831e3d30-762c-4966-13ed-08dd1b73c9ae
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 12:43:47.6557 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AsgAWSOwlBnYr+r+QSbgkEKTkhGNhK99iPhMP15oZCLQuGu3XhVKmqG8D0RDEqX/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7028
Received-SPF: softfail client-ip=2a01:111:f403:2413::600;
 envelope-from=jgg@nvidia.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.495,
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

On Fri, Dec 13, 2024 at 11:58:02AM +0000, Daniel P. Berrangé wrote:

> Libvirt does not rquire use of pcie-switch. It supports them, but in the
> absence of app requested configs, libvirt will always just populate
> pcie-root-port devices. switches are something that has to be explicitly
> asked for, and I don't see much need todo that.

If you are assigning all VFIO devices within a multi-device iommu
group there are good reasons to show the switch, and the switch has to
reflect certain ACS properties. We have some systems like this..

Jason

