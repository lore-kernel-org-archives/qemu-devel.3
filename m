Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC5DC41513
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 12:50:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7E4Z-0005am-NI; Wed, 15 May 2024 08:49:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s7E4Y-0005ad-3N
 for qemu-devel@nongnu.org; Wed, 15 May 2024 08:49:30 -0400
Received: from mail-bn7nam10on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2009::601]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s7E4W-0008BB-8X
 for qemu-devel@nongnu.org; Wed, 15 May 2024 08:49:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KiyEj4rslQnt6rglKerKiyqbque5jsr82TXG0QhB7AXCAnaCY0Tpu6BPd6LKNjyqlv/2jLkEL18xQKKvF7X1K67tqO9ZqyGGaS295rShO2FTp3vC2sUNcBfiGesavzlxp7bHBsxin3guEx0rfx02jw4eh2YS7okvmAunzk9Ohfjib/i4JC+RbL8y265Oh7zD385w+ba6FDEzYxX316NFgtDgsz4n/tQn/YCsyZjKlPSawZqFFjSOlsAnWxz4xzf7ekEDBAKJRkZntymNQgwL0ZquX74pJ68U6DGX4uTns2jTeZ7ZA8zvwt87PbwhCB7G7rkd9JWgBhbhbZ1bB/ue+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZreInqs40i0p1ilT0TI0214yqJGuD8WQiV1lxTFIvGc=;
 b=jbxxhGjA2HXkRCYRpzyT5uIzAAfjMbiHicAvFtNlcMCekgzUJpJe/4IRhmvvJr7L4B7tho4ATR0riJYAjbtHAPwilGnnjCfc9bNencX4nddqOrFzChgX7AVYvgfd6M5AxJxtApae0mA681/tsQjGrHvdgJslmhqgniMAb/BaYQHKiJ+oUvH9u6lGAX5pkH9W2XetRSZDcWkHmC+S2v60kCyIvL1mf1N4XW0m0X2QLB8NQd5fkEJT34dQ8qSeuEq136SSh9pdxO7rhGSNO6XJWAwM0VVE78drjIjdzBuLc+BsAPPd/lQyyYSzw0xa9B0HE/OD3aIid8X12XZcmksJ8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZreInqs40i0p1ilT0TI0214yqJGuD8WQiV1lxTFIvGc=;
 b=nwGCIhthhCdkyE9cLHkAUgy4QWh9sNIpzIaecebg92ZRTIbAvDXoiurA8GUpl9AQ2jquW0WcD0lonYXc2IzCkbjGAwiCZEv57xWsb0idsjjQ5pcOC4OeTnmI4lBj0Wh5j8tBZHY8DlymJ/ACkiIxrRqtfhgI6RT0jGMyIZviTDB4W+G9MT470UWpuikpmqD6oPY/tRC/fh8+zflDXXU4qFKn6huXtCms0iIjQwMT2s7pHy900reZNs3Q5k9pJDteBG41/7eIAwVINOt17s4Oz53CDmZUmiwqGzXsnSrDoMgSKHEKOX26rjwxbeZ/LIpj4q6SKqKFOfF23zwVKD0QUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by SJ0PR12MB8113.namprd12.prod.outlook.com (2603:10b6:a03:4e0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 15 May
 2024 12:49:24 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%5]) with mapi id 15.20.7587.025; Wed, 15 May 2024
 12:49:23 +0000
Message-ID: <ba013025-84a8-41ea-a978-e9c4e34f84c6@nvidia.com>
Date: Wed, 15 May 2024 15:49:20 +0300
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
 <c7d95391-551d-4d32-aaab-d2e0a47acddb@nvidia.com>
 <d450c8c1-f23f-40e8-9e9c-26c8a161b4e0@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <d450c8c1-f23f-40e8-9e9c-26c8a161b4e0@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0136.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::12) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|SJ0PR12MB8113:EE_
X-MS-Office365-Filtering-Correlation-Id: 61597527-a577-4dbd-8bdd-08dc74dd724d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aWtDaFNGeFRvd2xkMWV0eGk0UFBKRGRUQTVyaDJCMDJtQkZ2d3kySWJraHRr?=
 =?utf-8?B?ZjRsZzhPWW9Gc1hPZUt4SmE0bVlJa0V2QVduRzY0UkZsREIwRVNmV0ExOWMz?=
 =?utf-8?B?RjFDckRzMFI1UXhzV3hmYlcrK0lmUGtpbmttOU1KQ1NtTkZFbXRFV1ZuWTVX?=
 =?utf-8?B?d09oRlc4T3ZpNUNXdXBGRHB5Vy82SklYTG8zam9qdWlaeWFwT2IrMXE4a1RR?=
 =?utf-8?B?aHliZXdzUUJic2p3NjRsWFRkd25vZ1luVXBDTHFGYXhNRjZ6L29JV2o0L0Ew?=
 =?utf-8?B?NVRyVW9sRzd6RVdtb0NKZTg1TnhIRW8vTUZ6Y05RMW1yRW5sald1OW9FMFFM?=
 =?utf-8?B?RDVXa3RyUGpsd01RKytaU0FyamlxcDBBZUNncS91NDFyMXNvNk9BN0o4RFhr?=
 =?utf-8?B?N1NUVTdYSlFIUVJZaXoyc3ZWVFJCREZLU2Q2ZnB4K0swNjcrNDZ0VXZsd1hT?=
 =?utf-8?B?ZEtuNjZQWmNGeVZ3L3IwbjdHNW5WQ3BHTlJJazJKaW4zMHNwRjRoVml6L2dy?=
 =?utf-8?B?d0IxY2pURC9BSlFMeDFYeW9WY0YwVHZFcVl0eW1xUW5wV3NLZmJWYzdVSkli?=
 =?utf-8?B?MmR4cUdvOUlqYnMxRW0veDI1TjBMWFBxYXM2c0JsdG5mSUZKTmlnRXNNNVBZ?=
 =?utf-8?B?QzFvTkY4MHZaWHlNVHFsQ3YzRlRBYmp5eVlZVFdEcmJaUHBwMm1TYzdjUjJI?=
 =?utf-8?B?WFN3eXZ0b0VSMHZ5WDU4WE1zYktuSkQ1UXlocWJlNVVBZXhPNTV3SlpBZDJ6?=
 =?utf-8?B?dW8veXJKdkZkTGlBM2R5amowMG9Jb0FrNVU4R3pIU3pLZkc3VDRackozUVA0?=
 =?utf-8?B?am5TcmZldXZzOTRRandKMFdXa2cvdEJYMHlUWTljOEFWbkh1aGUyTXVwV0NP?=
 =?utf-8?B?bGczYmthZHVNTk1ETEVWcmlpRWVjbDdVUFMvUkd4K3J6MWdvdHJCRk1yNkN4?=
 =?utf-8?B?d09RZTJ6bnRMMjRUMlQrcksyLzRkdWNSb3YrNWsyNkgxa2ZzcFhxSGRFUWVt?=
 =?utf-8?B?TFhwQkk3SmRqNDhZQ3l1MmJGUVJDWEk4SytCeVUrSVltbmRlZ1BWZWdFcm1y?=
 =?utf-8?B?c0EvNnR6OHpUZU9rS1FqNi9lbUdTOFhVMjZFT3owWTRvdXpEaTJpN1o3Ymdy?=
 =?utf-8?B?bTNHYlFGMkdBTFI1cmFBV0Z4eHpvV3NObG9QNHdxN0g3WTRkRGRnMGJnTVB2?=
 =?utf-8?B?eTRTb3hJQzRXU3JlUS8vZENFZXNjemdxblhsQ3MrVFJGTHBzR3hpMDBMSGs0?=
 =?utf-8?B?VXNZUzhjMHFJR1FxQmxoSzNwdlFtc1czY1p4blpwbkdSWDlrbktuZVNzY3ZD?=
 =?utf-8?B?emY2MWVkOWJhV2VTZzhGd1NTRk1JWG9QaFVZVlJma2lWSGdDcW9TMUM5UlRT?=
 =?utf-8?B?djlWUjNuY2JqenVvbFI4bTV0UW1aRnl3QUN3SU5ZRFRrN3JUSzlUbWdvMHpR?=
 =?utf-8?B?TkJoMFQ0cldVMXdxdktPMDZtN2tidXYrVm92S2t3MUU4WG5OQ1kyVHFyOSt2?=
 =?utf-8?B?YXhjdVllc05jZHdWcG1wUWdGK1hmSXE4MHZMZk04eGlkdDZYSCs0Q3hLVzFE?=
 =?utf-8?B?bUpBSUNOUXJuUTcxNHZTN0N6dloyVzNRdkxOTHh3bkZLSEFubm9wbEhtU1Bk?=
 =?utf-8?B?STUraVFzbFhIL0YxeXgrSE9NUmFidHdLOWJ4MFZLWnkrVCtCUnVjcll4Q0ll?=
 =?utf-8?B?NkVPYVdXVXA5TUc5bUgzM2JFcFYweDF6cnA0RUM2bCtUMFFqL1ZwZVdBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3lxZkxjblZna0RObTdxTU1Wdml6TUE1emJYbnY0MkNYdW9kQUVZM2NEY0JR?=
 =?utf-8?B?M29Ec0tWUWgxTEgzV2VXRDA5NFM0dnpzV2xIZnQ3cUVDUHpnYkhTTGRQa3V4?=
 =?utf-8?B?WUw0a3dMRmUxNnBsenRGZ3RjZXhIT1l6aDdGUTF5ditLNXZDdC9BeGxRd2hs?=
 =?utf-8?B?NzJnY0FTR1F1YzByWkFZSC9VSnpGb21IdjhyTU5mYUhnbFVqeTFJZ1ZhTGhS?=
 =?utf-8?B?UHJzenAxdFZISkFOdklVME5tQmdSTmJGdmJxTE40WC8zUmhCeDUydkt3a0Jj?=
 =?utf-8?B?ZnFBOHRVWmhlWUNWQVJ5Q0lqMjdyTlZVRDZKNDM2V0xvMFhMVEl5My9BTmFn?=
 =?utf-8?B?R2JOREZvVlVvcW9TRzV0Q1NOWVE5aG9UN2FQamE0S2ZtZ0lxUkhSY1ZvYW8x?=
 =?utf-8?B?T09qaG5aRXVxMFN1NkVITVZ1b2ppb0pnRkJxVmt3bzFkWnRCVmcwTFEyMUZ1?=
 =?utf-8?B?NkN1bmpITEdnc2JlWFJ0Wm56S1lmUnJ4QnBaYWpGUTBmNnM0SG1IODFjLzVa?=
 =?utf-8?B?NEhkUDM1NWhLM3ZsS2w0NXNyeWlHdjBZZjAyaDhlbVRIcVh5cTIyWW8yelBC?=
 =?utf-8?B?VkRRTCt5cDZNa20rdGVOZHVyM0lLS2FTSThmVjJIeEF2ZDdCWk8rdUttUVdk?=
 =?utf-8?B?dVNlQ3lXWHRkYklsN25rRHNvWTh3b00wNVR6SGpXWEovb3AvMFZITDdxVTRC?=
 =?utf-8?B?RnlFL3h3d3d5ZHFXaHNud29nZURKSmlkdUpBU0JTaUJZQWxSdmRPaWsvaFVs?=
 =?utf-8?B?Y0FMS2RQbGJGbFE2a1ZXMWF3K0s2MklMRzZGTjZWZENxdHBrcTBxS1pzbXhC?=
 =?utf-8?B?anptd1ZETFEycHVVa2pGQUl1NUgzeVRWVkFJcE9ka3N0SlNQVjFaTjE4eWc0?=
 =?utf-8?B?N3QyVHNnb1BtelNGMzFBWUZ6amJMSTVjL3piMDIyK2p6TDNPSGhKWlVXclpa?=
 =?utf-8?B?RTVFZmVGK1BTTHlhYy9FbmFNbGd1cE1kNmF6UG4rN1B4TWsxRzl4QWFHcFlX?=
 =?utf-8?B?UXFRY0QxSVNYc2RmZWtOWVk0ZHJGZ1JXWlJLN0NZWjk1TWVtMDdiK1pULzlE?=
 =?utf-8?B?L0o5eGpPMVZUeWQvWk5Rejk0cFNwWStFN1FZeWM4d1pyZU03TnZNVkxNQ2VW?=
 =?utf-8?B?TjJ1ZmN2TEFVdXl2b2tPdHh0ZG9XTm5kd3pmNGpVTmVvSEVaZXhwTnA5ZWhm?=
 =?utf-8?B?MTdkM2ZEUEJ1TjFVT2Q0WjNXdVZHSmdRS1E5RFl0b1pTaUlJcnRxbFJHcVJB?=
 =?utf-8?B?V21QOUhrNHpNdnF1NDRPVG1pMlB1MW5LaFgrb2NpV2w3WEwyQ1diMy9UZTJ1?=
 =?utf-8?B?UUhhaGtHYkN6RnpNWDhBNzkvbS9zenZCaHRkM3ZpSEJmUTFxVDFCWERpbmM4?=
 =?utf-8?B?eU01anRoYVZvTkZhT0FtSENQWXc5aExXTlRXZ2ZScGQvTDBveWZvR1dGRzlh?=
 =?utf-8?B?T08vMXZhRitkZTZpZXE2aFR1MTcyN1ZIWDFqcXZJeVV6K3ZXMWFWL0x3VmhD?=
 =?utf-8?B?d2ZFbDV1QnZsWHBKZkZ0NGFvZW1FY2U2M1pLOE1raDFMa0c3cjJqOXVkUU00?=
 =?utf-8?B?OXViTGRxOEMwaFJuaHJ1Skh5QnFLMkRnVE1jVVRLMi9MQXlPMzZudFhlUGtV?=
 =?utf-8?B?cE9leWpyUEFQQk0wUmRmUDVYdWcyd245RkV1eVdYb3dXeFM5ajg2OEJuUDFy?=
 =?utf-8?B?MzdMVUphY3lleG9XWjJVanIwNWRwK1pLSy9tczhNZFRScEV2bXo0VCtUNVBP?=
 =?utf-8?B?OGo3eGs3bk5pM3JBcHhXWWdWWmw2bFRxYjJxNnhFUnBpeStoNm8wK003QSty?=
 =?utf-8?B?TkEwSzlFL2lUTys4NHJNOE0wU2M0eEZZR0J3aWkrQ1ZKR0lRc09lbE5NZUxq?=
 =?utf-8?B?OWRYS3JFWkRzUDBMRXBaR29WVDZMcWtlblFZUTdtTTE5SnpDYk1Kdkc1N3Iw?=
 =?utf-8?B?bEYrNnMwT1p0c0c3VGxrNTVLRVdTa2RuYkpRYXpKaXZ4Nk5lS2puT213SEJ5?=
 =?utf-8?B?NlIzSHJSa1UyRWZaWVBiRVRCMjRsZW5Sb3NOeXlWdmd3Yjk0SENhZnFDMUFZ?=
 =?utf-8?B?MlNpSzVld0E1bnJkNXFxa3pyMmZ4V1NMOEVnYzIwRkRBRVBhM2NnRFBsZVZz?=
 =?utf-8?Q?YrARM9ZpqYwwLAIxgYMqDQXnq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61597527-a577-4dbd-8bdd-08dc74dd724d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 12:49:23.5938 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U+3KVmeqwxfM9Bjc6xfZyyz/dSMN057Z8/bDbAJK6D6QnUyEmC/IO4oOV4H5LRYy/JdYYLOlzON1+Prz3sRzQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8113
Received-SPF: softfail client-ip=2a01:111:f403:2009::601;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
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


On 15/05/2024 15:36, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> On 5/15/24 14:29, Avihai Horon wrote:
>>
>> On 15/05/2024 15:25, Cédric Le Goater wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On 5/15/24 14:17, Avihai Horon wrote:
>>>>
>>>> On 13/05/2024 19:27, Cédric Le Goater wrote:
>>>>> External email: Use caution opening links or attachments
>>>>>
>>>>>
>>>>> On 5/13/24 15:03, Avihai Horon wrote:
>>>>>> Hi Cedric,
>>>>>>
>>>>>> On 06/05/2024 12:20, Cédric Le Goater wrote:
>>>>>>> External email: Use caution opening links or attachments
>>>>>>>
>>>>>>>
>>>>>>> We will use the Error object to improve error reporting in the
>>>>>>> .log_global*() handlers of VFIO. Add documentation while at it.
>>>>>>
>>>>>> First of all, I think commit 3688fec8923 ("memory: Add Error** 
>>>>>> argument to .log_global_start() handler") forgot to set errp in 
>>>>>> vfio_listener_log_global_start() in case of error.
>>>>>
>>>>> yes. This is unfortunate. There has been a few respins, the series
>>>>> was split and I was hoping to upstream this part sooner. My bad.
>>>>>
>>>>>> This causes a null pointer de-reference if DPT start fails.
>>>>>> Maybe add a fix for that in the beginning of this series, or as a 
>>>>>> stand-alone fix?
>>>>>
>>>>> Since it is fixed by patch 1+2 of this series, we should be fine ?
>>>>
>>>> A fix could be useful to be backported to QEMU 9.0, no?
>>>
>>> These changes were only merged in 9.1 with the migration PR.
>>> Am I missing something ?
>>
>> Oh, my bad. I thought they were merged in 9.0.
>> So patches 1+2 should cover it.
>
> yeah. I still would like to merge them asap, with your little series
> possibly, the one adding the event, plus the 2 cleanup series from
> ZhenZhong. I will update vfio-next when they are sufficiently reviewed.
>
Sure, I am going to post v3 of my series shortly and then review your v6.


