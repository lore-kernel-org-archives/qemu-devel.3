Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26927D7877C
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 15:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tE8kM-0007JG-21; Thu, 21 Nov 2024 10:05:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1tDubV-0006T4-Dk; Wed, 20 Nov 2024 18:59:27 -0500
Received: from mail-bn8nam11on2062c.outbound.protection.outlook.com
 ([2a01:111:f403:2414::62c]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1tDubT-0004TC-1c; Wed, 20 Nov 2024 18:59:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=svoQoQD2RlaskJzI4TgJBgsWRVZnGXH7nW/vUoBLSb7Unkd9AwDBgKN1Y9GPhu5/EosVMpcTVOKJsRY+mg9Nx1RRGxA9w0T/3k207wvN3dhsTGfRaN2dZcPCT0msoqwBwKjwyQpKuEg973XSclqUTytw2ICTqR8sQHBSwnhVM2BkI+jINB6FJL5KSjwEHK/GpJ+iqUJPLosj+f+lQox+atJ+byd6OUIM1bnsLTqq1NwcOZ3Q49uvJBdrNXyg9c0V4G+pjG8Xf+YAiSGofGQc8S7+bOCsHNQ9MKRX7ZqB9X5rSTqy2BtqDrp0zOfGV/mbGytIcVraFgv17Hhh1F1uPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dYqOT1+xaIU6V4A4RzO8AY2kSG90w/YymFhVypQvEW4=;
 b=KGhIq6wNf4iUo9T1QXTF8krwm05nO+hqChnZCPzAda9p0DcCo6YGRWINdFJg24yKO6EemRw+buy34MemVbWf0vaH+Gdu4AywfjL62xSHv5TYNZAJFNvTVz1zfXquCyqk2GVyt2j8epAmq6h4KBDJzB7BkqYqnGONa4xyZAerfJ8nS1wMbcDCBzVpGfTKlEx44trjl+Z3cuizOQzg7pMaQnXFTm3mn81359E91Grp08g7tZB0LfWo2x2zIndDKRiThzcy0PnwpnN4YwDmKTbKFmISKOUh6CSIAWQ33As+ZgbXz0xiaZprnXvdwzA2bzurcKsNFt+ebSXQhYbv5vo4PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dYqOT1+xaIU6V4A4RzO8AY2kSG90w/YymFhVypQvEW4=;
 b=k6ms0ZsoWytC9+k2Gohrw7I9haFeDV/8q5mXEYVelAeKGbwdBz8dl7OJVmoriCurGRsXb9pXIhcQQiqjC2qA4xwl46Gg42rALyuey/7sTfIKdNYhWpovKkyhVSLgFU2fK6H19AQvQ7/nr3O6+oWUincZTjESKl0U9/F2NGPLRj74QSxrlgrVWx2Ljlv0bO3g6quIj/tmXsFzoZKDQMsuL76Y3cJ6renJ3fxJznsKr9MJcGz16pvOPHV6eWrlSKgBudWDOYPerNLUFb8TeYFSIcpZi7F+s44iZrbXmsW3oBM0hR/yITJXYafb1X8fN9EoNH+Jy7YS+LuP9dAVrblr4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB6838.namprd12.prod.outlook.com (2603:10b6:806:266::18)
 by CH2PR12MB4038.namprd12.prod.outlook.com (2603:10b6:610:7b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.14; Wed, 20 Nov
 2024 23:59:14 +0000
Received: from SN7PR12MB6838.namprd12.prod.outlook.com
 ([fe80::529d:478:bc5d:b400]) by SN7PR12MB6838.namprd12.prod.outlook.com
 ([fe80::529d:478:bc5d:b400%4]) with mapi id 15.20.8158.021; Wed, 20 Nov 2024
 23:59:14 +0000
Message-ID: <2a61079f-a919-43b1-906a-bae8390bf733@nvidia.com>
Date: Wed, 20 Nov 2024 15:59:10 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, eric.auger@redhat.com,
 peter.maydell@linaro.org, jgg@nvidia.com, ddutile@redhat.com,
 linuxarm@huawei.com, wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org,
 Nicolin Chen <nicolinc@nvidia.com>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <ZzPd1F/UA2MKMbwl@Asurada-Nvidia>
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <ZzPd1F/UA2MKMbwl@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0016.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::29) To SN7PR12MB6838.namprd12.prod.outlook.com
 (2603:10b6:806:266::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB6838:EE_|CH2PR12MB4038:EE_
X-MS-Office365-Filtering-Correlation-Id: ce595341-ccce-41a7-1fd6-08dd09bf55b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dUtsam1pTm0vQWdBSytIanBwbzZ5TDZuWkdPa1U4STYweS9uRHRUWlZQWEFQ?=
 =?utf-8?B?Zjd3V3VHdjRHZm5PRlRUVm9wbnBBd0Fkc3QwcEs0RmlTTEFnN2o2TkNTaVRo?=
 =?utf-8?B?TkhDMnVhNVZzNkpBdFVCd3RwclZCTHEyaGNmeGJKMjA2VmNmRlFvSG1wNVUr?=
 =?utf-8?B?d2VMTGxKM0ROOTEyRmo4cmhQak1UU3lRMkEvbnpTRis4NnRZeTZzWWZ1bW4v?=
 =?utf-8?B?T1lXeE1rU3Bva3YrVjF0eWxYRHNNQTFENlZVenpxaGcxdzd4M0UwNW93TUE0?=
 =?utf-8?B?U0NMa212d2hDSFFEays3WmhkajA0UkhMRXhTTTROdW1qQ2pwbUNYVW4xYTNV?=
 =?utf-8?B?U2ozbEFTVHJBblI3KzBzd2R5TUhycjRSQUlSeFh4UDRmTDh0L3QxdUw4YjhW?=
 =?utf-8?B?cHF2ZjNsNnpCaGoyOWk3b2RBOXlxRFpEdkdCRGdhSWNqU3lhVXIwYml6U3Js?=
 =?utf-8?B?MGgwUWZKZDJPSlBlYWRuT1Nod2h5ZTFhUlM3RFN2LzJwNEJSdkd2aW13RlFh?=
 =?utf-8?B?b3VTclgxb0Uwai8rZDB4VjA4VS9UYUVpeEFPa3ByRE14S1F0bDY4SUJkbC9u?=
 =?utf-8?B?R21rTWdNaHVOKzJvQTFiTHMwQmM5cVR0cGZ3WUg3MHZ1Wk1QbDBYNk5hLzRC?=
 =?utf-8?B?N3RqekdpbVVvSkNPTFB4ZmhQRDZUbTJmMFBtc1luOHFCWkFLR1dMNUdJQ2NW?=
 =?utf-8?B?Vy8wd0cvYkdGVDFEL0wrM2FNRmZ1UmhTczAxeHFFTjZNRFI2ZERCN215Y2tK?=
 =?utf-8?B?RkFMb2dQbmdrU291L1ZTNzJVam00aHhCVUlYT1JGVEhmd1pJWUhINEIwVGJl?=
 =?utf-8?B?R1Bpblp1eE00OWR3cDRyZ3hMSkMveFZyY3A1ZkMrOERwd3VzbS9CZmprVWNQ?=
 =?utf-8?B?U3IvbldFTVZERzVjWHRiaElXR01VSWFiSjk5Uk8wR2dKcFgvcXZpRU5hNEVr?=
 =?utf-8?B?bzlZUjR5NXRZemF2OWd1c3hmYkwrZWlKRDI3a2l5NVpUNkxLdWxORTBBbk5t?=
 =?utf-8?B?bnF4cmZhRjUzRUp6ZVJaQ0dncHlTK2xBaDgybGZtbHZYbGl5eHNyUjlGZjdq?=
 =?utf-8?B?WFlPZTRCb0VEQjFaQWpXK01jNGZFZitvcFF0K2NqSk5lZisxemNyRGRPTk1y?=
 =?utf-8?B?dk1Bb1Q4cWdmdHcvSWI1bGhET3A3dTlwUW1PcC9wMndtQ1JVSlhyVzJkaWFi?=
 =?utf-8?B?Mjk0bnFsWEJHN2czc3Z0a3p6bm0vZG1odmVnSnNCbFlpaDZCOE9lU2NpelEw?=
 =?utf-8?B?VXV2b3NONGVNcGp1cXdjeU1oYksrNXpyWjB4RVhBMGlQWGp4MVd1N2U3Z0Fn?=
 =?utf-8?B?T1hGTVRPeG1BRXhpY1E1b2lBb3JleUxMblN0a3pEV28zY0NBM2pGcVRRTWZa?=
 =?utf-8?B?clF0UnlMUHIvek40RlY0SWZpb3EyN09VRzh6ejRQQlBBYjV6NUFNQ0I4dGgv?=
 =?utf-8?B?OEdzeUFNaHpKVWxwbFU2MGdpcHBLdXBUUU9qa1FrOWNiZkl0T1VUQ3lwRFJ0?=
 =?utf-8?B?bTRiOFZFQ2d6Wkh3TzVCdEFJZlMxVEF6cFVxZmZSbjJQSGRBV0ZxTC9iMzZE?=
 =?utf-8?B?b1FoQ25IeXJLOEYxOSsvNlpqMnZPZTBoY2NuQ2xIVFRuSE5oRUg3REFUZWcy?=
 =?utf-8?B?eWxCaDErczVnekU2UUxrZlh1aFNJMk91UHFPWmRqUTA5VW5UQTdoVTAvM2dx?=
 =?utf-8?B?bE1nTVNLOU96V1JYZk5oaXRDYndFNkhOKzQySW0vaTJxODI1empRcFltWmpK?=
 =?utf-8?Q?UfgmBPRaL1+h0WtjgY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB6838.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGpMRDBQRE5hcUJjamY0R29DYitreXU5c0tDUXFTM2ZJQkp2NmlsYkRxSGVJ?=
 =?utf-8?B?MkRsamIvTk50TUUwVHNoSERpZXMrNm5KMktWWENLc1lZcTMrdEQ5SGptb0wr?=
 =?utf-8?B?Zko0eklWWW4rR2paVWJweXhMU0xBMVcvUFBlYWxVNjlndWJkV0YzdkJPbWtO?=
 =?utf-8?B?Tkg0dnhPSktyVVJuZ0pKeklDb1JPekpUN2RCY0pmLzhqWnllOGtVdGhjQkE4?=
 =?utf-8?B?RC93a2FWTTc3ZEdQVFRYVjM2cTdOVnVVQjJ0K3c5THFjNndOVjFXUnk3cThC?=
 =?utf-8?B?SnhSa25rQ3NyN3labzBMcm9pUkx4RDJ1TUM2eG03aHEwMVNCTEJ5R3pjeEcy?=
 =?utf-8?B?WTFiejZ0Q3FYbDZHQVROUnF6Zm5BdmxTOTdzOGpDUEpCTmFBSXkvR09zMWNJ?=
 =?utf-8?B?V1gzbWJuS0I3TjZnNEJQcEdIRFp1VzBlNUJhYndqR0JnNnlWVDV3NFBOaXAv?=
 =?utf-8?B?Zk5iUjNQTnZMNzBxdDlMWDZLUDAvVlM4ZlBJaXlkMFZJNWszR2xUemRlQTdP?=
 =?utf-8?B?LzF3Q3ByS3pWSkpnanhpUnlGM01EaVg0VXVZeElLSjFkemVLMnpYNUJmUCtp?=
 =?utf-8?B?WHVkUk55Ym82bXlxUkJ5bVNDdzJrSWRmL2dUSkxjcmY3ME1rYW9XdkRPdVNz?=
 =?utf-8?B?VUh1L2wzd1NEaXpndEx5dkduV3lwbEpOYmhzZkhVU2dpVlQrWXRLK2FFaFJx?=
 =?utf-8?B?blFLdGJPOTZNaVFIUzE1Ykh5SDJiVmZXOUxaTndvN2taWTFNazVOOUQ0dS9I?=
 =?utf-8?B?UU9lWHdGZTIza1BWSlZwcFhrczlsQ1pkZDFPalpjL085cVRPWnprcVJoMktq?=
 =?utf-8?B?RmR3SjFTTmpSM2dLMnZta2t1RW85RmVCY09XWDYrVTdHVmdsTHF5TXEwSDVp?=
 =?utf-8?B?Zk5nblU2bnVTVlFBcVhOQ2k0ZnZwZVJUbFVGY1gvbUZZRExlYTVZUEUrWnEz?=
 =?utf-8?B?dGNzemNFdFRwaDJIbFNFSUpkU1JDanZRcVE3RHVadEozTVVqQ1kwejZYSElF?=
 =?utf-8?B?aWtDNmxsWEhsdnJacm5iNEpzNWNlU2t1NVFZalRGcUFKRVRlZ3IydGxCNFhW?=
 =?utf-8?B?SWxsUVZsMjFlcC82Q2ZLZkRxSHREYitFSHg5Wk1Xa29rV0hHbXg1T1VRcWEy?=
 =?utf-8?B?QWZZcHBlV2RlN2Zsb1ZncWVyQjByUWVZSTg5UjZEYzFobEpNK0xPNkZqTXMz?=
 =?utf-8?B?UW1jL0FlMGcvUERvYWt1RG5uQm5XOGdRbE8xNkNoS2RPa1pIZU9iM1Y5Tkt2?=
 =?utf-8?B?ck9DNzNZcmd3VzBET3o4YTZrY2h4TFo3ZmhlSnRZemNaSEtRTDZwWlhLU1VI?=
 =?utf-8?B?THB0OEpjWU04VFEvcjU5OFdGcDV0TGl6em5yRGYvMHBoTjd6T1IwSVdvUy9I?=
 =?utf-8?B?TDhNMnVLeW9qSk5yRjIySEEwdEx6NnU3NzJRRXlBanlaWE84Q0hiZzJsblpY?=
 =?utf-8?B?ZXdjMCtvdVNocHZES0I3U09sVVh0bnpncHJ2bFhOY1lSV2hHRVZENXpPY0o4?=
 =?utf-8?B?NUZnb0FmTXpFdVc5OTUyd1pLUVFHdXJFNitZcGpBSHlXNnpjOE5kUUErbkpD?=
 =?utf-8?B?bHk5ZFZuOFgrTjlFd3ovdS9qcWRlQUFwUkxZNEcxMDNzT1hLSTNwY2RlZHpO?=
 =?utf-8?B?cWluQWFZKzJtS09DaDBEZnNVdEkvY2dUVHFyZnh3ZWh2TkdKUnoyL21yZ0tX?=
 =?utf-8?B?anpBL3I5V2V3d3gwdGkzblRXZUFqRjd3cngyOGhDREdJeTJNREhNOU1CWnlv?=
 =?utf-8?B?WU9XbXcyV3d3Sk5ER3ZDOTVWK0ZDckVGSHhIdjEwa0k1ZC80LzZ4Q3kva1lC?=
 =?utf-8?B?U2dVZGJlSTNDT05PQ0RxNUtGaldmV2Q1dlRsTWVoc3FFTVV3b1A4bDZZMGlB?=
 =?utf-8?B?RWYvTzJCYk1qZW1IZ2h4aFJjWC84N0MwNlltTG0xL2RPc0hldWVKMjBsd05N?=
 =?utf-8?B?UUN5Tm95bXNjTEx6YXd3blNRd0NYMlJWMHdVQWFacjRsVUxza3RhQUF4ekpm?=
 =?utf-8?B?MlV4K002eUZkMWRhV0NySTVtVk91Y0o2VzcrNFlGUHg0RWhqVTdBb1YwTC9M?=
 =?utf-8?B?Si9KK0o4Y3hyNzNJbHduc0s0R3FZbmo4RmtJeDFvd2pvVGJLNlhacWE0U3Nr?=
 =?utf-8?Q?1u2HNKt/l8+3OE84KfDQ9v6Ct?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce595341-ccce-41a7-1fd6-08dd09bf55b8
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6838.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 23:59:13.9670 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ypBTBK+w8NGfLbWv/S3TB+dqpRLP5hfLvtyYoE4+FQ620o5Ars+b6p3u4W+QSnKBkMgCl0PsrYExbnj+jRH4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4038
Received-SPF: softfail client-ip=2a01:111:f403:2414::62c;
 envelope-from=nathanc@nvidia.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 21 Nov 2024 10:05:28 -0500
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

Hi Shameer,

 >  Attempt to add the HNS VF to a different SMMUv3 will result in,
 >
 > -device vfio-pci,host=0000:7d:02.2,bus=pcie.port3,iommufd=iommufd0: 
Unable to attach viommu
 > -device vfio-pci,host=0000:7d:02.2,bus=pcie.port3,iommufd=iommufd0: 
vfio 0000:7d:02.2:
 >    Failed to set iommu_device: [iommufd=29] error attach 0000:7d:02.2 
(38) to id=11: Invalid argument
 >
 > At present Qemu is not doing any extra validation other than the above
 > failure to make sure the user configuration is correct or not. The
 > assumption is libvirt will take care of this.
Would you be able to elaborate what Qemu is validating with this error 
message? I'm not seeing these errors when assigning a GPU's 
pcie-root-port to different PXBs (with different associated SMMU nodes).

I launched a VM using my libvirt prototype code + your qemu branch and 
noted a few small things:
1. Are there plans to support "-device addr" for arm-smmuv3-nested's 
PCIe slot and function like any other device? If not I'll exclude it 
from my libvirt prototype.
2. Is "id" for  "-device arm-smmuv3-nested" necessary for any sort of 
functionality? If so, I'll make a change to my libvirt prototype to 
support this. I was able to boot a VM and see a similar VM PCI topology 
as your example without specifying "id".

Otherwise, the VM topology looks OK with your qemu branch + my libvirt 
prototype.

Also as a heads up, I've added support for auto-inserting PCIe switch 
between the PXB and GPUs in libvirt to attach multiple devices to a SMMU 
node per libvirt's documentation - "If you intend to plug multiple 
devices into a pcie-expander-bus, you must connect a 
pcie-switch-upstream-port to the pcie-root-port that is plugged into the 
pcie-expander-bus, and multiple pcie-switch-downstream-ports to the 
pcie-switch-upstream-port". Future unit-tests should follow this 
topology configuration.

Thanks,
Nathan

