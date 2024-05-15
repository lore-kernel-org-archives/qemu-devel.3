Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10438C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 12:30:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7Dm0-0004kT-Qw; Wed, 15 May 2024 08:30:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s7Dlt-0004fN-2S
 for qemu-devel@nongnu.org; Wed, 15 May 2024 08:30:19 -0400
Received: from mail-bn1nam02on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2407::601]
 helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s7Dle-0008Ug-B4
 for qemu-devel@nongnu.org; Wed, 15 May 2024 08:30:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aM8Z7uUU5565vHYRfUC8nO9VbclXhMBEXxRZKWP7Z22TUi6NF0gXC3PlrycUjxn1j9RaaeaMjHFlAwj7v/gFoIZy5JnoIavNiqBs5FcfVJXNyBHJ4N4bR8c427lUlw0QXTTmvtEoWbAXpZFu80dbVpZGlbzZwfkduWVmp9KbX0xe+78HBdqw4p8/hYkNGMORIZRP08Lo0NwLUI1Q1kDyvk1xaPGd8aNOIYLNOA0Fcw4rzP5FOWLkOcJ+0CxdNh/MNFtxv9AK/DEtaS+xkWj5F6UcmoIvPGB5kYq1+Ft78dTWGZpVEHrRC+F/i78oNUPu6pt7pbi8pIwyI1V3o/T/rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bdrcNN1MHQLs2qSxsZIULffoiJ1VBJlZgTGyYLoKHeM=;
 b=e6BDjZn+E2rPcdr4xWFc27HlFNuK0r7puXa6a9yKVAIP/roHCkSe50scT/BVO74PT22voYsjQMqD8FhA7s1IjvEeXSVpzTu9/xDTCMVyQKske1U10KwYdtZ23zvnBY4prm4w4WX7CfvK8CHU3ZaXUKqq147L/M6Q5g4MIB4l4bwmqFNePOmzP81D6CGNBBreLKfdd0YdmmqIjTbFcJgoppbX1S4+yXItKm1l8cvk+qyJgcOxdnPofrR4CAu4x0GEWuO5euSggKcuC9YN8IBm9L+uim00r7I0VQ2A4S5/B5aBSBEcDZGNrTEx/82oDaibibHoqWvt3oRw5SU/SwB80w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdrcNN1MHQLs2qSxsZIULffoiJ1VBJlZgTGyYLoKHeM=;
 b=VJeoce7jtQnlvvaFIAIOtLIUZNUjuqL86mAw2nygfwaew/GVwILIN7L8tPdIIKKSehzOf99hSKUxxEl+pJNqk4u8E8XHR/SYZ1QzdF3lHyynCJnIQ8NyyBR8NDvh9yJC+jZ8e7npM14zxu4P7qJTyu4IMWvpXlMsNmJYR5wXsaBCbOeGB3Tz8ZbgDG/KLVSYVpSNZt/Bp99eKXV7SpavIpJEbyNrkSZfivrfdOwhzds9woauWeBnQyemBesSmcveAmK5xYF5SJAkJuvinEZivWlNDzCkEYUC1axo99dEye564SLXiPRz/aGgfuFMGG24JDtsXCoO1+rVFTNyoxtjzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by CY8PR12MB7413.namprd12.prod.outlook.com (2603:10b6:930:5f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 15 May
 2024 12:29:52 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%5]) with mapi id 15.20.7587.025; Wed, 15 May 2024
 12:29:51 +0000
Message-ID: <c7d95391-551d-4d32-aaab-d2e0a47acddb@nvidia.com>
Date: Wed, 15 May 2024 15:29:48 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/10] vfio: Add Error** argument to
 .set_dirty_page_tracking() handler
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20240506092053.388578-1-clg@redhat.com>
 <20240506092053.388578-2-clg@redhat.com>
 <2e55e1ad-5c40-4ae5-a362-5f7fd610b0e9@nvidia.com>
 <2ef7b720-31a8-48b6-b825-a64b3fe87a1f@redhat.com>
 <020da629-845f-4599-92da-33cf41ad92f4@nvidia.com>
 <d8af0e9c-fa15-460b-b267-5e6a63d75f96@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <d8af0e9c-fa15-460b-b267-5e6a63d75f96@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0094.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::9) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|CY8PR12MB7413:EE_
X-MS-Office365-Filtering-Correlation-Id: f13815a2-3927-47ff-b8a5-08dc74dab7e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R3Z5UGxHUTF4ZEN4NWQybnlwQldLTVVpZjJxYVlQaXhISnJNTVA1QzJEZlVy?=
 =?utf-8?B?THF3bXBjczFDdDRyY0xZdlpWZ25TejQ3R0owZXBNdWc4TktIbUE3N0pYWmhk?=
 =?utf-8?B?NjdQVi9TUnU4bVZ3azdRU3liYUdvb1RISCtDRWE2aEhLdmRnaWVxNmJ4L1cy?=
 =?utf-8?B?LzFwQkgybk9NRGJIYUdnckRVRkV4VjBjUWVxT2VFVlB5K1pSOWRiRFRMU3JM?=
 =?utf-8?B?aW45WlJDTU9Cb0R3a1lONHV0MXBCL1FtUHc2YlF3RVdxdTJ0Q25lRHo4RjFN?=
 =?utf-8?B?NjcyKzRTWVh4ZHo2ZG9mZlRhSWU4RjlBajdhSjZRdjFQSklMNmYzWEs1L3VM?=
 =?utf-8?B?SkM3QkpFNVlETHJEbWszQmp6M3hYNEVSdFl3MEUyY2lTSHVvN1hqeFZ5Q2Nk?=
 =?utf-8?B?b3VPN3lKV3o1TGk1aWd4Nno0YWVaZlBSZmp4K29GTlRMYXRGTU56eGtkMUQy?=
 =?utf-8?B?TXRsRnVaVFlJcUJhRlZoZGQ5RmxDSXNuNEhUSENqbUJvTU01MHg4QnZ4Mm1X?=
 =?utf-8?B?cmFEaXF1NVAydE1CYWVVOXh1UlVCd3gyZmZDMGZiM2tiaWovTUQrRUJxbmQ3?=
 =?utf-8?B?L0ZLNnBoVE1zc05YdTBTdUJsbTl4ZlRDWm1ZN1BqNzY1cVFaU2VabWtFUnc2?=
 =?utf-8?B?Mk9xNGluckxXSDExVnVxb3pqNWVtQXNLYXhHcWlRc0RmM2h4ck5wek1wVHhM?=
 =?utf-8?B?UkZSNWVIZ2pYSVpTc1A5b1djelVGWUUzR3dPY1J1Y0NKOHRnejhKNmZIU2JZ?=
 =?utf-8?B?aCswZXRVK2d6Qm9IRmtpMTdRbGhmeVZQQlAxcmJBQ0R1VDB4T2E2WExYcklL?=
 =?utf-8?B?ZjB1RjlCVHkwUkV1RzUwNDdCNGMxdDQ1ZGN2WVlqbURmUllTL1ZPNlJZNll0?=
 =?utf-8?B?YzBISWgrYkEvQWhpN2s1MVdFRzVlaFpIN1RycmMvRG9qSnJybHNDVG9wdHI4?=
 =?utf-8?B?K0g3bnJoclpZazVSdFlQbTM1eDBDWnNtZHJJM1RxYzlZbSs5OTdWWlJUdERz?=
 =?utf-8?B?cUMvWDN2QnkraU1TN0FMQjk5dUZWVHZUQk9FT2k0TUtLdWM3M2hWb1JvOHVM?=
 =?utf-8?B?b2R5aVJGSUw2MWZCZFBXYTYyMHhWYlh2OG1uY0t1R1NjRmpFaUdsblNEM2Ro?=
 =?utf-8?B?K0xQdFZ5Q0xDNVFxL3FQN280aVZ5eTNkU1pPTndUY0NxREQwNjlCOG9peVVj?=
 =?utf-8?B?U1lHcEZReDBRUFMvZlBYL0pFemR0TzgzZDNucUZNWEl3aHdVcE1YTGdTVG1L?=
 =?utf-8?B?eGlLZzA3WTN6OEdYRnpPa1RxMGFyd1pyckNwR3UyUGRXZmxHaDJUU2JrUWM1?=
 =?utf-8?B?K2dQMkZ6ZVRVczNKQ1ZKamVtSlQ4R3h0aFhYaGpmVXQ2enljeGtsYVZnMGp4?=
 =?utf-8?B?ZTQzbkU3OVZ0UVZCUjlYNGVnNjNaRWRwQTE2TWNTMzg2aklwcHJxT0prVDhj?=
 =?utf-8?B?bmxTTzdTNklGMStSb0tMd1prejFWcHFBamJZeHA3U2Fzbit3Q0k4S0Nza2p6?=
 =?utf-8?B?R0FtS2VmbDdLWUhoWkppOEFSWUVyREpkeklmY2NCcEtHd0ZhY2F6dzUreEo4?=
 =?utf-8?B?THpRdGFGaERSRElLUEY3UmNaR2U3Sy8zaHlZOUJ3amM4bmtCT21ITGpsRU52?=
 =?utf-8?B?c0Z4d2lrZS9BZzZDY2JKY0VjRksrWlQ2MHNJc3JSWktKaWVKY2Z6cjlpdTVH?=
 =?utf-8?B?blB1WjJobWlwdUhZZFFUaHdlWUI0VUtwUTZjeldkbzJYZ1dja25lS2RBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnkvRlpKUkJ5VXVTTG1MWlJ6K2RnckVPVytQajg1OWd4OFFQc3Q0NUR6ek81?=
 =?utf-8?B?ZjB2eHRSVExUVXFPSm45b2Zwb3hPTDNxWFUwQW85YXF5aldyQldheVdTei8r?=
 =?utf-8?B?TnpSOFJTc2Ntckt0T2ZZVUFoMlkycmRvOXpYSHZjbWwvMlNid0RleXU1KytF?=
 =?utf-8?B?a2orODJoOHFJcmNnOXpvZEF0VXY4OWJENmVCb3UwVDZwRzdtNGRHaytSVld4?=
 =?utf-8?B?UWp2VkJGV09Xak1GT2t3d1IwUWZQUjNoRUR1bVVQWlZMbEVZbjBiSmUyYWhw?=
 =?utf-8?B?cGdBeXZ2eGp4S0xkUUtuV3NMSFVQdTY2cU9Wbk9jcVpqTlQwbHJCMkhRL2dw?=
 =?utf-8?B?S3BvSXFKNzdWeTZiUHNyenRDQWl5S3NYWUlpUnlDeDRQWXAvRXhkc0dLUS9P?=
 =?utf-8?B?RG9VY1E5dEJzQnQ0TWdzdVlZWm9ycngxVnFVdkhFQWpNNVhMSmJhTk1odmJ4?=
 =?utf-8?B?OVVDeVliSjVqbW9LMVp0UEtVNUZEckllZ3ZNWHliem02RXd2N1ZuVUxHcURy?=
 =?utf-8?B?OGVBa0tHdWx6TDFvNGRmWllkRkxUM04rZTBxL21pcVByVlZCY0lpTXM2dmdU?=
 =?utf-8?B?dnJZVHc3VmpQekFnS0RwTFBYc2hVbVg3TTBydWhSQS91TlJENkM4NjNReVdR?=
 =?utf-8?B?R2w3enBKYWpJTnB0K3k2eWdON3luMnAzMzVpVm9SaVo1TXNzVW93ZzBoRE84?=
 =?utf-8?B?SkpDb3FMRVQweGFwTzB1ZE14MlJzd3ZtRFFibzlKMGJSRS9jcndGNDdiUlZ0?=
 =?utf-8?B?L1NSV0JkMlREVW11YU1sRFJhdWl6ZXE0aDQ4NzBMWkxRQnEySkc3dG8xSVVm?=
 =?utf-8?B?RDZPVjR6NFR5Lys3dHUzUEpCWFJ0bm5qZlVlS21aeGgxd2htYW5BbmR4dWc0?=
 =?utf-8?B?M1ZidDRQbVROWmNjSDBwVTVBUUhYL1g3S3c4R2VOSXdjcFE1N1FmcGpaRU5s?=
 =?utf-8?B?ZnVwZG5CYm8rYWhiQkRsbEtZaDd6YlNyMk1yWkR1V0M4ak03UkJSM1NzT09F?=
 =?utf-8?B?UlZacis4MG01YWcrNGswcmNsVE1RTURtWEhuMkozRXlUczZ4aEVwY0hHUDNX?=
 =?utf-8?B?YkpubGRpOWFyTHJtSUVvM1I1bmRDMnRIa1oyZVpzOEdKV3Q0VlNqNkk3TEg5?=
 =?utf-8?B?emFTVFlTSXRDUURTeUZIbnRNVTc0aG9SeWp6L0NOTzhoK1k5V2VzUFNmdk5O?=
 =?utf-8?B?V0NGcW9NVEUzSzA0RFRHaFUwNXZVV09jM0Y0UFFOK1hFVXlWcENRTTkwZldw?=
 =?utf-8?B?VzAvSGlLVDhuYVFNS1JaUW9kanh3YllrNkFaQ1cvdUJMRFJaR1o3QTduRTlC?=
 =?utf-8?B?THhlYUxvSmJEaFhsZVZSOHo5VUl1UjZieXhQT0YvVUsrMGVxZ0h1MDNEOXRF?=
 =?utf-8?B?TkpoUWJYYzFhYnNOWkE3Y094MTE0VlZiVHgvR1JKaldFZFUxSTRSQUIxUVhF?=
 =?utf-8?B?QVdNcFdJV2VuS2J4S01iNGppNCs5S0wwTWJqM1pPSEJFUFEzNHhYczNWU1RC?=
 =?utf-8?B?WUFVeC85dVo2ZjJMNXdKSjRlN2tJcW8zSzZWa3NFNXlMN0FxdjhwZlRYaVdB?=
 =?utf-8?B?WmpPTkNUUUl6ZWJzOHlwazJrQmtpQmM1dmE5d2hTRThIQ3pvYzNlUk1zZVhU?=
 =?utf-8?B?TmhlZFV5NENRdXhoR1gzYXNyRUw0OUora1JEaEZaVmEvaUpONzhjQWpLeWl6?=
 =?utf-8?B?bmlreU5Lc3lLMHpvSy84U0huUEp6NTZia3puMGI4SVRxQyt1YXVIL1dFSm84?=
 =?utf-8?B?MG5mek9HaEVQVmVMYmw4ZWZ4YUYzRi9vVlBHeEFFRi8vdjJaM0RKTWg0bHhJ?=
 =?utf-8?B?ZEl5L3piR3hDYlo2Qkk1MEZzck54N3RZdy93TmpiSjFFVGQzcndaeGtxRnE2?=
 =?utf-8?B?NzBCMkZvcmxmb0RSc0ZGK3VXVEZ1QVVJamRLVHJiODQraE9TL2M1ejUrVW1H?=
 =?utf-8?B?OS9kVmd2YUluSUFVY3RCMlFyTW53YzRHL0VVYTJzbVc0NVhKZmNkaklJbjdV?=
 =?utf-8?B?dENTeXA2Y2hnTkltWmJRUlF0QlA3UnZLNGd4WHBLRUs2Smpvbi92ZUM2cFlz?=
 =?utf-8?B?NnVXbUdsWE9oUWE4SFZuZHVEdXowM1B5ODdWWS9MazBVQWFBVmE1ejJoT29C?=
 =?utf-8?Q?SsdmPLtHkEe4MJHFJEuHIF6dM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f13815a2-3927-47ff-b8a5-08dc74dab7e9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 12:29:51.9137 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B/0dLsrma9DDruD2wDzMTF+5XC/ST+2+SbYwBHiECjdc75PyOgVO5OGxMQ/0DP9ssBmTzu3OD2aPeRJ6uqvmLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7413
Received-SPF: softfail client-ip=2a01:111:f403:2407::601;
 envelope-from=avihaih@nvidia.com;
 helo=NAM02-BN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.935,
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


On 15/05/2024 15:25, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> On 5/15/24 14:17, Avihai Horon wrote:
>>
>> On 13/05/2024 19:27, Cédric Le Goater wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On 5/13/24 15:03, Avihai Horon wrote:
>>>> Hi Cedric,
>>>>
>>>> On 06/05/2024 12:20, Cédric Le Goater wrote:
>>>>> External email: Use caution opening links or attachments
>>>>>
>>>>>
>>>>> We will use the Error object to improve error reporting in the
>>>>> .log_global*() handlers of VFIO. Add documentation while at it.
>>>>
>>>> First of all, I think commit 3688fec8923 ("memory: Add Error** 
>>>> argument to .log_global_start() handler") forgot to set errp in 
>>>> vfio_listener_log_global_start() in case of error.
>>>
>>> yes. This is unfortunate. There has been a few respins, the series
>>> was split and I was hoping to upstream this part sooner. My bad.
>>>
>>>> This causes a null pointer de-reference if DPT start fails.
>>>> Maybe add a fix for that in the beginning of this series, or as a 
>>>> stand-alone fix?
>>>
>>> Since it is fixed by patch 1+2 of this series, we should be fine ?
>>
>> A fix could be useful to be backported to QEMU 9.0, no?
>
> These changes were only merged in 9.1 with the migration PR.
> Am I missing something ?

Oh, my bad. I thought they were merged in 9.0.
So patches 1+2 should cover it.

Thanks.

>
> Thanks,
>
> C.
>
>
>>
>>>
>>>> Back to this patch, personally, I found the split of patch #1 and 
>>>> #2 a bit confusing.
>>>> Maybe consider squashing patch #1 and #2 so container based and 
>>>> device based DPT start/stop are changed in the same patch? Like you 
>>>> did in patch #8?
>>>> Whatever you think is better.
>>>
>>> ok. Let's see how v5 goes. I might just send a PR with it if
>>> no major changes are requested.
>>>
>>>>
>>>> In any case:
>>>> Reviewed-by: Avihai Horon <avihaih@nvidia.com>
>>>
>>>
>>> Thanks,
>>>
>>> C.
>>>
>>>
>>>>
>>>>>
>>>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>>>> ---
>>>>>
>>>>>   Changes in v5:
>>>>>
>>>>>   - Fixed typo in set_dirty_page_tracking documentation
>>>>>
>>>>>   include/hw/vfio/vfio-container-base.h | 18 ++++++++++++++++--
>>>>>   hw/vfio/common.c                      |  4 ++--
>>>>>   hw/vfio/container-base.c              |  4 ++--
>>>>>   hw/vfio/container.c                   |  6 +++---
>>>>>   4 files changed, 23 insertions(+), 9 deletions(-)
>>>>>
>>>>> diff --git a/include/hw/vfio/vfio-container-base.h 
>>>>> b/include/hw/vfio/vfio-container-base.h
>>>>> index 
>>>>> 3582d5f97a37877b2adfc0d0b06996c82403f8b7..326ceea52a2030eec9dad289a9845866c4a8c090 
>>>>> 100644
>>>>> --- a/include/hw/vfio/vfio-container-base.h
>>>>> +++ b/include/hw/vfio/vfio-container-base.h
>>>>> @@ -82,7 +82,7 @@ int 
>>>>> vfio_container_add_section_window(VFIOContainerBase *bcontainer,
>>>>>   void vfio_container_del_section_window(VFIOContainerBase 
>>>>> *bcontainer,
>>>>> MemoryRegionSection *section);
>>>>>   int vfio_container_set_dirty_page_tracking(VFIOContainerBase 
>>>>> *bcontainer,
>>>>> -                                           bool start);
>>>>> +                                           bool start, Error 
>>>>> **errp);
>>>>>   int vfio_container_query_dirty_bitmap(const VFIOContainerBase 
>>>>> *bcontainer,
>>>>>                                         VFIOBitmap *vbmap,
>>>>>                                         hwaddr iova, hwaddr size);
>>>>> @@ -121,9 +121,23 @@ struct VFIOIOMMUClass {
>>>>>       int (*attach_device)(const char *name, VFIODevice *vbasedev,
>>>>>                            AddressSpace *as, Error **errp);
>>>>>       void (*detach_device)(VFIODevice *vbasedev);
>>>>> +
>>>>>       /* migration feature */
>>>>> +
>>>>> +    /**
>>>>> +     * @set_dirty_page_tracking
>>>>> +     *
>>>>> +     * Start or stop dirty pages tracking on VFIO container
>>>>> +     *
>>>>> +     * @bcontainer: #VFIOContainerBase on which to de/activate dirty
>>>>> +     *              page tracking
>>>>> +     * @start: indicates whether to start or stop dirty pages 
>>>>> tracking
>>>>> +     * @errp: pointer to Error*, to store an error if it happens.
>>>>> +     *
>>>>> +     * Returns zero to indicate success and negative for error
>>>>> +     */
>>>>>       int (*set_dirty_page_tracking)(const VFIOContainerBase 
>>>>> *bcontainer,
>>>>> -                                   bool start);
>>>>> +                                   bool start, Error **errp);
>>>>>       int (*query_dirty_bitmap)(const VFIOContainerBase *bcontainer,
>>>>>                                 VFIOBitmap *vbmap,
>>>>>                                 hwaddr iova, hwaddr size);
>>>>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>>>>> index 
>>>>> 8f9cbdc0264044ce587877a7d19d14b28527291b..485e53916491f1164d29e739fb7106c0c77df737 
>>>>> 100644
>>>>> --- a/hw/vfio/common.c
>>>>> +++ b/hw/vfio/common.c
>>>>> @@ -1076,7 +1076,7 @@ static bool 
>>>>> vfio_listener_log_global_start(MemoryListener *listener,
>>>>>       if (vfio_devices_all_device_dirty_tracking(bcontainer)) {
>>>>>           ret = vfio_devices_dma_logging_start(bcontainer);
>>>>>       } else {
>>>>> -        ret = vfio_container_set_dirty_page_tracking(bcontainer, 
>>>>> true);
>>>>> +        ret = vfio_container_set_dirty_page_tracking(bcontainer, 
>>>>> true, NULL);
>>>>>       }
>>>>>
>>>>>       if (ret) {
>>>>> @@ -1096,7 +1096,7 @@ static void 
>>>>> vfio_listener_log_global_stop(MemoryListener *listener)
>>>>>       if (vfio_devices_all_device_dirty_tracking(bcontainer)) {
>>>>>           vfio_devices_dma_logging_stop(bcontainer);
>>>>>       } else {
>>>>> -        ret = vfio_container_set_dirty_page_tracking(bcontainer, 
>>>>> false);
>>>>> +        ret = vfio_container_set_dirty_page_tracking(bcontainer, 
>>>>> false, NULL);
>>>>>       }
>>>>>
>>>>>       if (ret) {
>>>>> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
>>>>> index 
>>>>> 913ae49077c4f09b7b27517c1231cfbe4befb7fb..7c0764121d24b02b6c4e66e368d7dff78a6d65aa 
>>>>> 100644
>>>>> --- a/hw/vfio/container-base.c
>>>>> +++ b/hw/vfio/container-base.c
>>>>> @@ -53,14 +53,14 @@ void 
>>>>> vfio_container_del_section_window(VFIOContainerBase *bcontainer,
>>>>>   }
>>>>>
>>>>>   int vfio_container_set_dirty_page_tracking(VFIOContainerBase 
>>>>> *bcontainer,
>>>>> -                                           bool start)
>>>>> +                                           bool start, Error **errp)
>>>>>   {
>>>>>       if (!bcontainer->dirty_pages_supported) {
>>>>>           return 0;
>>>>>       }
>>>>>
>>>>> g_assert(bcontainer->ops->set_dirty_page_tracking);
>>>>> -    return bcontainer->ops->set_dirty_page_tracking(bcontainer, 
>>>>> start);
>>>>> +    return bcontainer->ops->set_dirty_page_tracking(bcontainer, 
>>>>> start, errp);
>>>>>   }
>>>>>
>>>>>   int vfio_container_query_dirty_bitmap(const VFIOContainerBase 
>>>>> *bcontainer,
>>>>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>>>>> index 
>>>>> 77bdec276ec49cb9cd767c0de42ec801b4421572..c35221fbe7dc5453050f97cd186fc958e24f28f7 
>>>>> 100644
>>>>> --- a/hw/vfio/container.c
>>>>> +++ b/hw/vfio/container.c
>>>>> @@ -209,7 +209,7 @@ static int vfio_legacy_dma_map(const 
>>>>> VFIOContainerBase *bcontainer, hwaddr iova,
>>>>>
>>>>>   static int
>>>>>   vfio_legacy_set_dirty_page_tracking(const VFIOContainerBase 
>>>>> *bcontainer,
>>>>> -                                    bool start)
>>>>> +                                    bool start, Error **errp)
>>>>>   {
>>>>>       const VFIOContainer *container = container_of(bcontainer, 
>>>>> VFIOContainer,
>>>>> bcontainer);
>>>>> @@ -227,8 +227,8 @@ vfio_legacy_set_dirty_page_tracking(const 
>>>>> VFIOContainerBase *bcontainer,
>>>>>       ret = ioctl(container->fd, VFIO_IOMMU_DIRTY_PAGES, &dirty);
>>>>>       if (ret) {
>>>>>           ret = -errno;
>>>>> -        error_report("Failed to set dirty tracking flag 0x%x 
>>>>> errno: %d",
>>>>> -                     dirty.flags, errno);
>>>>> +        error_setg_errno(errp, errno, "Failed to set dirty 
>>>>> tracking flag 0x%x",
>>>>> +                         dirty.flags);
>>>>>       }
>>>>>
>>>>>       return ret;
>>>>> -- 
>>>>> 2.45.0
>>>>>
>>>>
>>>
>>
>

