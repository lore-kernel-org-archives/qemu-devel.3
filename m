Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 880EAECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 09:01:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snaG8-0004CN-Fm; Mon, 09 Sep 2024 05:00:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1snaG0-0004B3-3R
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 05:00:25 -0400
Received: from mail-dm6nam12on2076.outbound.protection.outlook.com
 ([40.107.243.76] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1snaFx-0002XJ-0Q
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 05:00:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ch6AWTxWrSNDCzs5ZsBQXt+pG/qfoJ6QQIjVG0iAg4nbDWVHyOah6w6RLjodiEuxz7HxrQ/1qeLTf4xSq6aVmQ3MnjF3gJ0xdB9bwAFrNhaJYUw4ZAHdTRtdCtyrS4u0acFTGnmDxmPdmaEegObznNDtWao01UZlYahwj5JWyTbEGLdM0LXHhtGT/8BsWKbOk5EhPslG/h9anILeQTyWBwVo8nMsNbRtSU1z66JQvz4R4DM+qDXK81j4E5xpGJV3aPG768KME3ikNM9jdCCEJslLOm69noDMpX3LHTPEwoZs9CqoEepJwRFGLst5SRTd3pay8hkb1bBqlA3H4bjHlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EHMw3JeN9Db5L/ws78dA4iki6JbZdJdJe+fUiaJ3OY4=;
 b=bVh8XweHpQ9/X3+SIetyd7xLooGeD6ctMb5vLb2eSVC5tBFnAeEvg9zcpksw/nJzdojWtuiXbwnHzHsiah/vZsEGGrB7F3wHtqouTsONR4wJU7e1URRF2HLYVr+opLVmIzrHjc0oSnzy5FXDMWliTKS2Pei+pGVByvce0rWx3J5gdUTGJjn6RFOKRkipJLjdAyHAMFXcJ8adP+/vGA9z4cAdGRKow9ef4oxrHuouUWpoQhuhbWZMa91stFRotlmFbE0ZTALB95zKujZ6OJ1inmlMENDcc9y8st7AxtAM8ZW6JrXZ6949w3/6jI/rKD7olpMW1dF2uZi7FDdcZ6Wt9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHMw3JeN9Db5L/ws78dA4iki6JbZdJdJe+fUiaJ3OY4=;
 b=RUSL/9ygT2GnLn9En2/Ef1RWsuPScwczerMSrpaLSap5hc3iR8p8FyxGbaopN7mszV/RT0fRA9sKGcLS2QWKj/4X6qWsOPCGuQSgiQvpsBpPANW4W4e4gnJM9c60tnOwYBBuvlLTlFSZ6y/LBte2jJw6cvDZ9+C3WdFhj7pq20hrLwZXyIN0IYktJadZRX9MK0vXbeTJ2+buQSUIeWOcHiHyt+mnD84Uc8gIWqoNp/VB7IaIFgNa7hZgcaWGJn/KDYrRvIt85RVStI6Bk1Uyb6GppDvPcC8OHj2JrFowP0mVWZQ/wfLmTYWA8XsE75IFY8HOhXh5B20b2jz290l+iA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by SJ0PR12MB5675.namprd12.prod.outlook.com (2603:10b6:a03:42d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Mon, 9 Sep
 2024 08:55:13 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%5]) with mapi id 15.20.7918.024; Mon, 9 Sep 2024
 08:55:12 +0000
Message-ID: <12ebbb56-c2a7-42d0-8dad-9b459a490c39@nvidia.com>
Date: Mon, 9 Sep 2024 11:55:06 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/17] vfio/migration: Multifd device state transfer
 support - receive side
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1724701542.git.maciej.szmigiero@oracle.com>
 <4133ce80174fa3b81070adaeeb068554beba2854.1724701542.git.maciej.szmigiero@oracle.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <4133ce80174fa3b81070adaeeb068554beba2854.1724701542.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0127.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::6) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|SJ0PR12MB5675:EE_
X-MS-Office365-Filtering-Correlation-Id: 28249fae-9061-4d48-8248-08dcd0ad1d98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TERyR0N2OTJPeFdibVFQb2xDREJxeDJzeXVOQUhvQkZkdG96TTNYL2U0Y1VZ?=
 =?utf-8?B?QUxiaTZEdGMybjlncVVRd2lOOTBMQzVyaWxoT0duK2Y0VHFUb2FHdkFFMysz?=
 =?utf-8?B?M3oxYlVNaVQ1UmpvSERoS0tLTkpVVjlhM3QrUW10OENOOHErL1lXaC9DMGgx?=
 =?utf-8?B?T0E0Nk5GNytqNmdCdml4ckZPaC9rZDcrOUtOWThvSVFIdzIvU25DNWcxZmIr?=
 =?utf-8?B?Q2RPTFV6czN0RENRYmN1NC95U3pubDJmbDQ1WkFVVXMzYWhrTzFzUDd3bVEr?=
 =?utf-8?B?cy95VGtPMDNsd0VkVmpNWEdiV0ppODZMc2dwbzlzcTBPYWNsdnA4c3JxUU1J?=
 =?utf-8?B?WFU4UGJ0Y3NlNmNNOC9SdE4zRE1jdG53djBDSld5alcwMU84UjlKMUtNZ2sz?=
 =?utf-8?B?cC9Gd0JkTHVFM0RPakE3aWVscWM5MUFxWm1zVlpTYm5VaE5oajdKWVg1V0c1?=
 =?utf-8?B?aFFxM1BLNEprVVpCRS8zelpSbnlrSi9BbVd3Rm1aKzFHSlp4NmJwM2I3ME5l?=
 =?utf-8?B?U3Q3cm8wQlV4ck9IMFR4LzM3ZXBLcC9ZbWpDM1MzYUJ1R3BkUkR6eDdtaWU1?=
 =?utf-8?B?MmVoc2M4VUhCbisraytXVDhDL1dHSHhUZDlLbUxKWHI2U0ZoS09iKzVmWVFj?=
 =?utf-8?B?ZlFLTWVVK01CeHpHMitnZytqampHcDcyZWtLNWEvRk50UmtDV1dzM1hCNmpF?=
 =?utf-8?B?eWFpRFE2d2FqRjdwWlk4SE85eDFpNFdQUi81a05LUVF0VW1zTWdLaUVmVzFX?=
 =?utf-8?B?eFRydFM3bFlzOTdxbXlER0hONTFMV2tjbzBBZ1ZNUlhNTFRSaUgvUkMyRzZP?=
 =?utf-8?B?UmlvWFRqTkVERnRCS0xJdE1rUG9zSDdUamxlVy80VXV5QWZEMDN1bzBQTjVH?=
 =?utf-8?B?YkpUZG9va2M5QmVRSTd2VnZ0SE5KV0pKL1ZhTFIwRzE5UEpXbjRqL2JRTnFU?=
 =?utf-8?B?T1FRdjB4NUJyNXl4SU9SamFvVG1YWjlUSDlPRVlnR3dYNjd2OUdsckgxNjcx?=
 =?utf-8?B?WHhVcGhndm0vNHZDZEx5Z2xMMHpzUUozeU9rYnRYQU5UOG45VktMZEhTVEps?=
 =?utf-8?B?Q3l3eG9QQWY0MzJPYncvbTI2aTc4L2NBRjhpY2ZNak5LSUNoVW01eTFaWVpa?=
 =?utf-8?B?bEo0c3Aya2t2QzVLb0JaNTZuS3BDOFFKSE4vaEtKK2lScTdtcTNYNllyanhp?=
 =?utf-8?B?ekxReUpmS2EwUEtpVG9kOGthREQwTVBQMkdyWXFZS0RUSmdBaXp1NjNaNTVn?=
 =?utf-8?B?VnBENEVIRzZISWhEdTZ4TFhEL2lNaFpKeHpNQWVnanJQeTNwS041RXBkTWFs?=
 =?utf-8?B?c1c1QmdLcW5uZE9EdkM4Zk8zMk8wTDFDaUJkZUtHS0xsdGd6dEtKdVFQejgv?=
 =?utf-8?B?K3N1QXNmZlJjN1R5ejhNOUxhMEJka2Nza2ZvRC9jSFpacG9VWE5qVDRqZ0VF?=
 =?utf-8?B?aTQxSmh3U2lWSHdUcnluRDJlZHRtdVI1NU9kMjlpajZqTktwNXJ3ME5MRXg1?=
 =?utf-8?B?T0dVKzk5SzdkS1Y5UUwrQTIrZzVKcXlIdUR1dGxXNGlDNm5LTzYyRkR2Z1Nu?=
 =?utf-8?B?eVgvRWU5VkFoenpaY0JnZ21ZRzZibVkzckNXSjF5MG4vYXRBWWwrT0RVdWdv?=
 =?utf-8?B?UFE3UUYwYlVQbEtqSng3R1dzZHhma0R4WkpNNmg3ejBSZFhWcm9OYlU1YUlw?=
 =?utf-8?B?ZWwrUnVCc3VFYWhRME9uWXZLK3RiMWxiUzBEZXMzcGZhc1NUU1V4cUt0M1pw?=
 =?utf-8?B?RlNEODlMdFgvN1RqdUJWWVJoWVlDV1ZoOGJiUnF5U2M3S0pqL3I4V3NFczBR?=
 =?utf-8?B?R0pPTXR4MlloUjdQSlVrZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTVVaVVGRmpnTkVwbVJoQ2RDZ1FVMGlETmxKMUlmenVwTUVwMXB1dnpBdVZP?=
 =?utf-8?B?UGRPT3lkaC8zaDVWdW9jazhiekRyZ2FneG1XMHh0N25hNXhzckd3Uys2end0?=
 =?utf-8?B?empnNmlCMmhrZXpURm5vN2ZSSTRpcmRJRjBPMnpHSGEwNlpLVCsrOGRpZ0xk?=
 =?utf-8?B?UGNhbkFIQmZxeUZoS2UzYk9PNEdMUEc4eldrc2NSN2loVG40bnZBMlpvWlQr?=
 =?utf-8?B?dW1kcHRydjN0YlhQa2ZxVGpFN1RWWDJJdnlCVlhuM2haQzR2dkxNQnY2NEF0?=
 =?utf-8?B?VEtMdjRzWk9TbnBCNkNuN1FGQjVoa1hubHpxMS9PSitXeWJ0Y3V5SC9RVFQr?=
 =?utf-8?B?SDJLLzM2K1FMTlpiNFJMSHN2dmtvVmc4eGhMY05YYTVQb2pGYmx4dWdFVzNx?=
 =?utf-8?B?dndIZDllcklwcVZuZUthSFM1WDFNczRFbjhxeVBYOGR3VnQ4M29CZU10aVBu?=
 =?utf-8?B?S0lncW0raTYxKzg3a3dpdzhpRlpjUUJjTElWd1lYaElPcTE3ZzU3NHVZU3Zz?=
 =?utf-8?B?eDkyVEhjNkl2Q0RaVjRpVHp1VmRWRC9XSnpsTnJ2M1VwL25aUUhmaTd5Tk8r?=
 =?utf-8?B?Wm9LalRscGU0eUJqalRJbHhvREVTUWZYa2VzMThiUVFEaG1DNmdqak5leTZM?=
 =?utf-8?B?L1Vpam9lajhHeEVGajk3bmRmVXU1eUpTbWpTK0RRYW05b0ZBbHRmaENYV3or?=
 =?utf-8?B?SGcyWFNoM2VzVGVuOS9WNHVjWENiUitmK3VBd0xrR3dGTWhzNUxhQUM1UUt2?=
 =?utf-8?B?bFNGRmt4VFo0VVI5L2VyZ05jcmMxeW9zUG1LSmRTTUZZM3RhMElxTzQvQzEz?=
 =?utf-8?B?dTBUQ2JkWFBKWnV2dGNMRWNIUTJldThCUG5hZEtJR3ArcHdrNGExaGpxcXBt?=
 =?utf-8?B?UXZWM1lRK05ZT015WXBSekVmaSt3M3ZuZmkyYzU3VXVrR0VGVUNBVjVIVTdT?=
 =?utf-8?B?Qk5yVGk2VlJCUit2Q2daRUt2V0lRMlJkVU80eHc5RWw3aGVHZEk0RzY3R1Fa?=
 =?utf-8?B?K2VqUmhBQi82dDBUcVh0dFZwU2phN0N6ZGwzKzdWdmFHVDI3VXJkeXdxQlBZ?=
 =?utf-8?B?ZXozMmxQZHZZVUI2UFBSRTBrdXN6aDF2amNleUJoc2tKaHEyQ2RzelhKZ1Uz?=
 =?utf-8?B?MDAvVmNZVzhqZ1J5YUFnRGVFbG5zUkZPdlRaanUwK1ZLb2FoMUNOcTlTcnow?=
 =?utf-8?B?bTRDVmtqeHJVQWpLbDFlVUZKSVN2OU51cFdlNW1ET3dHY3M1YXVHL1h3dzZD?=
 =?utf-8?B?QkdZNUlxbkNESzcrWlNBcmNUUzZpRmN4RUFzQjhhUHBzUE9MbW1OcytGc2FV?=
 =?utf-8?B?WXFHVFkrWi9xdmQxamtYSkZCaFhQYXVPODlVVFpLN0pMU2dnN0pOdUFEUzlx?=
 =?utf-8?B?c015ODMySnBFSDN4bEZ0cFZzQzhPclZ1ajltemUrRzloMU5SS0tiTTNZMVcx?=
 =?utf-8?B?NDJpT0x6WUNoSmRlakpYN2M2a1JaVW41WmJIeWd4eWVIa0VnTVpuak9WTlV0?=
 =?utf-8?B?STI2NnkvdzRCVWk2NSt2SnFydEtyb2hPM3p2TTh0TGM1NmJSZHExSjVQRHND?=
 =?utf-8?B?cW9yZmV4OGsvTWVJeXBHSWlBNi9ldzh6NDVISm8waEZEZHo1VHFlMWdWV1JT?=
 =?utf-8?B?WWdQTW55VDBsVEloYlZ1WElhK1JZd09IZFZhaUV3aEtmRWJ2aWVybHFmMnVy?=
 =?utf-8?B?WGtrN3lNTnhlVGxENmJQVkxiWlVrS2pGbjlIZEVRSWY5Y2hWNkFidlo0dUlx?=
 =?utf-8?B?dE5NcFZjcklxM3Y0NmVENnA0RXc1RUloM240ekRhTzFvUi9Cb29YTFRwdE1x?=
 =?utf-8?B?cy9GMWlPOVZHbzErMlpjVWpIRXIvQVVyQjBVcjU0ZkJ2ZVpNNU14RzJNTjBO?=
 =?utf-8?B?bjRGUjZkYVJNZy8vRkIvb3ZiQW16aWNFOWRnZHhxMDNQaE5BY1BhN0hGVUIz?=
 =?utf-8?B?Qlk1aGNiaWRNVHhwaUdGNUxENXlLelBsNmJEOTd6TE5vbUNXcFVmblJQN1pE?=
 =?utf-8?B?RGYyOUEzUXRrWldIZnJhUllKaGsxY1lucURGTjl2czF4aUxhTXphL0VtWkN1?=
 =?utf-8?B?RE1pSnZDNGtUaVZoT0RxYS9pMHZPQjBUeXJiem5Dc3liRVJGTkhTWDlzMFAr?=
 =?utf-8?Q?PNvpQEmTF4tYjCzTtTe8+xSCr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28249fae-9061-4d48-8248-08dcd0ad1d98
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 08:55:12.6549 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mQwvqMp816prO7qt9jvoh9ybO6oQAu2//f2AzMF0uTlitRktUuSscAqfgxxfWbGKKgPnNscthzLULkS/dbq5JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5675
Received-SPF: softfail client-ip=40.107.243.76;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 27/08/2024 20:54, Maciej S. Szmigiero wrote:
> External email: Use caution opening links or attachments
>
>
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>
> The multifd received data needs to be reassembled since device state
> packets sent via different multifd channels can arrive out-of-order.
>
> Therefore, each VFIO device state packet carries a header indicating
> its position in the stream.
>
> The last such VFIO device state packet should have
> VFIO_DEVICE_STATE_CONFIG_STATE flag set and carry the device config
> state.
>
> Since it's important to finish loading device state transferred via
> the main migration channel (via save_live_iterate handler) before
> starting loading the data asynchronously transferred via multifd
> a new VFIO_MIG_FLAG_DEV_DATA_STATE_COMPLETE flag is introduced to
> mark the end of the main migration channel data.
>
> The device state loading process waits until that flag is seen before
> commencing loading of the multifd-transferred device state.
>
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>   hw/vfio/migration.c           | 338 +++++++++++++++++++++++++++++++++-
>   hw/vfio/pci.c                 |   2 +
>   hw/vfio/trace-events          |   9 +-
>   include/hw/vfio/vfio-common.h |  17 ++
>   4 files changed, 362 insertions(+), 4 deletions(-)
>
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 24679d8c5034..57c1542528dc 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -15,6 +15,7 @@
>   #include <linux/vfio.h>
>   #include <sys/ioctl.h>
>
> +#include "io/channel-buffer.h"
>   #include "sysemu/runstate.h"
>   #include "hw/vfio/vfio-common.h"
>   #include "migration/misc.h"
> @@ -47,6 +48,7 @@
>   #define VFIO_MIG_FLAG_DEV_SETUP_STATE   (0xffffffffef100003ULL)
>   #define VFIO_MIG_FLAG_DEV_DATA_STATE    (0xffffffffef100004ULL)
>   #define VFIO_MIG_FLAG_DEV_INIT_DATA_SENT (0xffffffffef100005ULL)
> +#define VFIO_MIG_FLAG_DEV_DATA_STATE_COMPLETE    (0xffffffffef100006ULL)
>
>   /*
>    * This is an arbitrary size based on migration of mlx5 devices, where typically
> @@ -55,6 +57,15 @@
>    */
>   #define VFIO_MIG_DEFAULT_DATA_BUFFER_SIZE (1 * MiB)
>
> +#define VFIO_DEVICE_STATE_CONFIG_STATE (1)
> +
> +typedef struct VFIODeviceStatePacket {
> +    uint32_t version;
> +    uint32_t idx;
> +    uint32_t flags;
> +    uint8_t data[0];
> +} QEMU_PACKED VFIODeviceStatePacket;
> +
>   static int64_t bytes_transferred;
>
>   static const char *mig_state_to_str(enum vfio_device_mig_state state)
> @@ -254,6 +265,188 @@ static int vfio_load_buffer(QEMUFile *f, VFIODevice *vbasedev,
>       return ret;
>   }
>
> +typedef struct LoadedBuffer {
> +    bool is_present;
> +    char *data;
> +    size_t len;
> +} LoadedBuffer;

Maybe rename LoadedBuffer to a more specific name, like VFIOStateBuffer?

I also feel like LoadedBuffer deserves a separate commit.
Plus, I think it will be good to add a full API for this, that wraps the 
g_array_* calls and holds the extra members.
E.g, VFIOStateBuffer, VFIOStateArray (will hold load_buf_idx, 
load_buf_idx_last, etc.), vfio_state_array_destroy(), 
vfio_state_array_alloc(), vfio_state_array_get(), etc...
IMHO, this will make it clearer.

> +
> +static void loaded_buffer_clear(gpointer data)
> +{
> +    LoadedBuffer *lb = data;
> +
> +    if (!lb->is_present) {
> +        return;
> +    }
> +
> +    g_clear_pointer(&lb->data, g_free);
> +    lb->is_present = false;
> +}
> +
> +static int vfio_load_state_buffer(void *opaque, char *data, size_t data_size,
> +                                  Error **errp)
> +{
> +    VFIODevice *vbasedev = opaque;
> +    VFIOMigration *migration = vbasedev->migration;
> +    VFIODeviceStatePacket *packet = (VFIODeviceStatePacket *)data;
> +    QEMU_LOCK_GUARD(&migration->load_bufs_mutex);

Move lock to where it's needed? I.e., after 
trace_vfio_load_state_device_buffer_incoming(vbasedev->name, packet->idx)

> +    LoadedBuffer *lb;
> +
> +    if (data_size < sizeof(*packet)) {
> +        error_setg(errp, "packet too short at %zu (min is %zu)",
> +                   data_size, sizeof(*packet));
> +        return -1;
> +    }
> +
> +    if (packet->version != 0) {
> +        error_setg(errp, "packet has unknown version %" PRIu32,
> +                   packet->version);
> +        return -1;
> +    }
> +
> +    if (packet->idx == UINT32_MAX) {
> +        error_setg(errp, "packet has too high idx %" PRIu32,
> +                   packet->idx);
> +        return -1;
> +    }
> +
> +    trace_vfio_load_state_device_buffer_incoming(vbasedev->name, packet->idx);
> +
> +    /* config state packet should be the last one in the stream */
> +    if (packet->flags & VFIO_DEVICE_STATE_CONFIG_STATE) {
> +        migration->load_buf_idx_last = packet->idx;
> +    }
> +
> +    assert(migration->load_bufs);
> +    if (packet->idx >= migration->load_bufs->len) {
> +        g_array_set_size(migration->load_bufs, packet->idx + 1);
> +    }
> +
> +    lb = &g_array_index(migration->load_bufs, typeof(*lb), packet->idx);
> +    if (lb->is_present) {
> +        error_setg(errp, "state buffer %" PRIu32 " already filled", packet->idx);
> +        return -1;
> +    }
> +
> +    assert(packet->idx >= migration->load_buf_idx);
> +
> +    migration->load_buf_queued_pending_buffers++;
> +    if (migration->load_buf_queued_pending_buffers >
> +        vbasedev->migration_max_queued_buffers) {
> +        error_setg(errp,
> +                   "queuing state buffer %" PRIu32 " would exceed the max of %" PRIu64,
> +                   packet->idx, vbasedev->migration_max_queued_buffers);
> +        return -1;
> +    }

I feel like max_queued_buffers accounting/checking/configuration should 
be split to a separate patch that will come after this patch.
Also, should we count bytes instead of buffers? Current buffer size is 
1MB but this could change, and the normal user should not care or know 
what is the buffer size.
So maybe rename to migration_max_pending_bytes or such?

> +
> +    lb->data = g_memdup2(&packet->data, data_size - sizeof(*packet));
> +    lb->len = data_size - sizeof(*packet);
> +    lb->is_present = true;
> +
> +    qemu_cond_broadcast(&migration->load_bufs_buffer_ready_cond);

There is only one thread waiting, shouldn't signal be enough?

> +
> +    return 0;
> +}
> +
> +static void *vfio_load_bufs_thread(void *opaque)
> +{
> +    VFIODevice *vbasedev = opaque;
> +    VFIOMigration *migration = vbasedev->migration;
> +    Error **errp = &migration->load_bufs_thread_errp;
> +    g_autoptr(QemuLockable) locker = qemu_lockable_auto_lock(
> +        QEMU_MAKE_LOCKABLE(&migration->load_bufs_mutex));

Any special reason to use QemuLockable?

> +    LoadedBuffer *lb;
> +
> +    while (!migration->load_bufs_device_ready &&
> +           !migration->load_bufs_thread_want_exit) {
> +        qemu_cond_wait(&migration->load_bufs_device_ready_cond, &migration->load_bufs_mutex);
> +    }
> +
> +    while (!migration->load_bufs_thread_want_exit) {
> +        bool starved;
> +        ssize_t ret;
> +
> +        assert(migration->load_buf_idx <= migration->load_buf_idx_last);
> +
> +        if (migration->load_buf_idx >= migration->load_bufs->len) {
> +            assert(migration->load_buf_idx == migration->load_bufs->len);
> +            starved = true;
> +        } else {
> +            lb = &g_array_index(migration->load_bufs, typeof(*lb), migration->load_buf_idx);
> +            starved = !lb->is_present;
> +        }
> +
> +        if (starved) {
> +            trace_vfio_load_state_device_buffer_starved(vbasedev->name, migration->load_buf_idx);
> +            qemu_cond_wait(&migration->load_bufs_buffer_ready_cond, &migration->load_bufs_mutex);
> +            continue;
> +        }
> +
> +        if (migration->load_buf_idx == migration->load_buf_idx_last) {
> +            break;
> +        }
> +
> +        if (migration->load_buf_idx == 0) {
> +            trace_vfio_load_state_device_buffer_start(vbasedev->name);
> +        }
> +
> +        if (lb->len) {
> +            g_autofree char *buf = NULL;
> +            size_t buf_len;
> +            int errno_save;
> +
> +            trace_vfio_load_state_device_buffer_load_start(vbasedev->name,
> +                                                           migration->load_buf_idx);
> +
> +            /* lb might become re-allocated when we drop the lock */
> +            buf = g_steal_pointer(&lb->data);
> +            buf_len = lb->len;
> +
> +            /* Loading data to the device takes a while, drop the lock during this process */
> +            qemu_mutex_unlock(&migration->load_bufs_mutex);
> +            ret = write(migration->data_fd, buf, buf_len);
> +            errno_save = errno;
> +            qemu_mutex_lock(&migration->load_bufs_mutex);
> +
> +            if (ret < 0) {
> +                error_setg(errp, "write to state buffer %" PRIu32 " failed with %d",
> +                           migration->load_buf_idx, errno_save);
> +                break;
> +            } else if (ret < buf_len) {
> +                error_setg(errp, "write to state buffer %" PRIu32 " incomplete %zd / %zu",
> +                           migration->load_buf_idx, ret, buf_len);
> +                break;
> +            }
> +
> +            trace_vfio_load_state_device_buffer_load_end(vbasedev->name,
> +                                                         migration->load_buf_idx);
> +        }
> +
> +        assert(migration->load_buf_queued_pending_buffers > 0);
> +        migration->load_buf_queued_pending_buffers--;
> +
> +        if (migration->load_buf_idx == migration->load_buf_idx_last - 1) {
> +            trace_vfio_load_state_device_buffer_end(vbasedev->name);
> +        }
> +
> +        migration->load_buf_idx++;
> +    }
> +
> +    if (migration->load_bufs_thread_want_exit &&
> +        !*errp) {
> +        error_setg(errp, "load bufs thread asked to quit");
> +    }
> +
> +    g_clear_pointer(&locker, qemu_lockable_auto_unlock);
> +
> +    qemu_loadvm_load_finish_ready_lock();
> +    migration->load_bufs_thread_finished = true;
> +    qemu_loadvm_load_finish_ready_broadcast();
> +    qemu_loadvm_load_finish_ready_unlock();
> +
> +    return NULL;
> +}
> +
>   static int vfio_save_device_config_state(QEMUFile *f, void *opaque,
>                                            Error **errp)
>   {
> @@ -285,6 +478,8 @@ static int vfio_load_device_config_state(QEMUFile *f, void *opaque)
>       VFIODevice *vbasedev = opaque;
>       uint64_t data;
>
> +    trace_vfio_load_device_config_state_start(vbasedev->name);

Maybe split this and below trace_vfio_load_device_config_state_end to a 
separate patch?

> +
>       if (vbasedev->ops && vbasedev->ops->vfio_load_config) {
>           int ret;
>
> @@ -303,7 +498,7 @@ static int vfio_load_device_config_state(QEMUFile *f, void *opaque)
>           return -EINVAL;
>       }
>
> -    trace_vfio_load_device_config_state(vbasedev->name);
> +    trace_vfio_load_device_config_state_end(vbasedev->name);
>       return qemu_file_get_error(f);
>   }
>
> @@ -687,16 +882,70 @@ static void vfio_save_state(QEMUFile *f, void *opaque)
>   static int vfio_load_setup(QEMUFile *f, void *opaque, Error **errp)
>   {
>       VFIODevice *vbasedev = opaque;
> +    VFIOMigration *migration = vbasedev->migration;
> +    int ret;
> +
> +    ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RESUMING,
> +                                   vbasedev->migration->device_state, errp);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    assert(!migration->load_bufs);
> +    migration->load_bufs = g_array_new(FALSE, TRUE, sizeof(LoadedBuffer));
> +    g_array_set_clear_func(migration->load_bufs, loaded_buffer_clear);
> +
> +    qemu_mutex_init(&migration->load_bufs_mutex);
> +
> +    migration->load_bufs_device_ready = false;
> +    qemu_cond_init(&migration->load_bufs_device_ready_cond);
> +
> +    migration->load_buf_idx = 0;
> +    migration->load_buf_idx_last = UINT32_MAX;
> +    migration->load_buf_queued_pending_buffers = 0;
> +    qemu_cond_init(&migration->load_bufs_buffer_ready_cond);
> +
> +    migration->config_state_loaded_to_dev = false;
> +
> +    assert(!migration->load_bufs_thread_started);

Maybe do all these allocations (and de-allocations) only if multifd 
device state is supported and enabled?
Extracting this to its own function could also be good.

>
> -    return vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RESUMING,
> -                                    vbasedev->migration->device_state, errp);
> +    migration->load_bufs_thread_finished = false;
> +    migration->load_bufs_thread_want_exit = false;
> +    qemu_thread_create(&migration->load_bufs_thread, "vfio-load-bufs",
> +                       vfio_load_bufs_thread, opaque, QEMU_THREAD_JOINABLE);

The device state save threads are manged by migration core thread pool. 
Don't we want to apply the same thread management scheme for the load 
flow as well?

> +
> +    migration->load_bufs_thread_started = true;
> +
> +    return 0;
>   }
>
>   static int vfio_load_cleanup(void *opaque)
>   {
>       VFIODevice *vbasedev = opaque;
> +    VFIOMigration *migration = vbasedev->migration;
> +
> +    if (migration->load_bufs_thread_started) {
> +        qemu_mutex_lock(&migration->load_bufs_mutex);
> +        migration->load_bufs_thread_want_exit = true;
> +        qemu_mutex_unlock(&migration->load_bufs_mutex);
> +
> +        qemu_cond_broadcast(&migration->load_bufs_device_ready_cond);
> +        qemu_cond_broadcast(&migration->load_bufs_buffer_ready_cond);
> +
> +        qemu_thread_join(&migration->load_bufs_thread);
> +
> +        assert(migration->load_bufs_thread_finished);
> +
> +        migration->load_bufs_thread_started = false;
> +    }
>
>       vfio_migration_cleanup(vbasedev);
> +
> +    g_clear_pointer(&migration->load_bufs, g_array_unref);
> +    qemu_cond_destroy(&migration->load_bufs_buffer_ready_cond);
> +    qemu_cond_destroy(&migration->load_bufs_device_ready_cond);
> +    qemu_mutex_destroy(&migration->load_bufs_mutex);
> +
>       trace_vfio_load_cleanup(vbasedev->name);
>
>       return 0;
> @@ -705,6 +954,7 @@ static int vfio_load_cleanup(void *opaque)
>   static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
>   {
>       VFIODevice *vbasedev = opaque;
> +    VFIOMigration *migration = vbasedev->migration;
>       int ret = 0;
>       uint64_t data;
>
> @@ -716,6 +966,7 @@ static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
>           switch (data) {
>           case VFIO_MIG_FLAG_DEV_CONFIG_STATE:
>           {
> +            migration->config_state_loaded_to_dev = true;
>               return vfio_load_device_config_state(f, opaque);
>           }
>           case VFIO_MIG_FLAG_DEV_SETUP_STATE:
> @@ -742,6 +993,15 @@ static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
>               }
>               break;
>           }
> +        case VFIO_MIG_FLAG_DEV_DATA_STATE_COMPLETE:
> +        {
> +            QEMU_LOCK_GUARD(&migration->load_bufs_mutex);
> +
> +            migration->load_bufs_device_ready = true;
> +            qemu_cond_broadcast(&migration->load_bufs_device_ready_cond);
> +
> +            break;
> +        }
>           case VFIO_MIG_FLAG_DEV_INIT_DATA_SENT:
>           {
>               if (!vfio_precopy_supported(vbasedev) ||
> @@ -774,6 +1034,76 @@ static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
>       return ret;
>   }
>
> +static int vfio_load_finish(void *opaque, bool *is_finished, Error **errp)
> +{
> +    VFIODevice *vbasedev = opaque;
> +    VFIOMigration *migration = vbasedev->migration;
> +    g_autoptr(QemuLockable) locker = NULL;

Any special reason to use QemuLockable?

Thanks.

> +    LoadedBuffer *lb;
> +    g_autoptr(QIOChannelBuffer) bioc = NULL;
> +    QEMUFile *f_out = NULL, *f_in = NULL;
> +    uint64_t mig_header;
> +    int ret;
> +
> +    if (migration->config_state_loaded_to_dev) {
> +        *is_finished = true;
> +        return 0;
> +    }
> +
> +    if (!migration->load_bufs_thread_finished) {
> +        assert(migration->load_bufs_thread_started);
> +        *is_finished = false;
> +        return 0;
> +    }
> +
> +    if (migration->load_bufs_thread_errp) {
> +        error_propagate(errp, g_steal_pointer(&migration->load_bufs_thread_errp));
> +        return -1;
> +    }
> +
> +    locker = qemu_lockable_auto_lock(QEMU_MAKE_LOCKABLE(&migration->load_bufs_mutex));
> +
> +    assert(migration->load_buf_idx == migration->load_buf_idx_last);
> +    lb = &g_array_index(migration->load_bufs, typeof(*lb), migration->load_buf_idx);
> +    assert(lb->is_present);
> +
> +    bioc = qio_channel_buffer_new(lb->len);
> +    qio_channel_set_name(QIO_CHANNEL(bioc), "vfio-device-config-load");
> +
> +    f_out = qemu_file_new_output(QIO_CHANNEL(bioc));
> +    qemu_put_buffer(f_out, (uint8_t *)lb->data, lb->len);
> +
> +    ret = qemu_fflush(f_out);
> +    if (ret) {
> +        error_setg(errp, "load device config state file flush failed with %d", ret);
> +        g_clear_pointer(&f_out, qemu_fclose);
> +        return -1;
> +    }
> +
> +    qio_channel_io_seek(QIO_CHANNEL(bioc), 0, 0, NULL);
> +    f_in = qemu_file_new_input(QIO_CHANNEL(bioc));
> +
> +    mig_header = qemu_get_be64(f_in);
> +    if (mig_header != VFIO_MIG_FLAG_DEV_CONFIG_STATE) {
> +        error_setg(errp, "load device config state invalid header %"PRIu64, mig_header);
> +        g_clear_pointer(&f_out, qemu_fclose);
> +        g_clear_pointer(&f_in, qemu_fclose);
> +        return -1;
> +    }
> +
> +    ret = vfio_load_device_config_state(f_in, opaque);
> +    g_clear_pointer(&f_out, qemu_fclose);
> +    g_clear_pointer(&f_in, qemu_fclose);
> +    if (ret < 0) {
> +        error_setg(errp, "load device config state failed with %d", ret);
> +        return -1;
> +    }
> +
> +    migration->config_state_loaded_to_dev = true;
> +    *is_finished = true;
> +    return 0;
> +}
> +
>   static bool vfio_switchover_ack_needed(void *opaque)
>   {
>       VFIODevice *vbasedev = opaque;
> @@ -794,6 +1124,8 @@ static const SaveVMHandlers savevm_vfio_handlers = {
>       .load_setup = vfio_load_setup,
>       .load_cleanup = vfio_load_cleanup,
>       .load_state = vfio_load_state,
> +    .load_state_buffer = vfio_load_state_buffer,
> +    .load_finish = vfio_load_finish,
>       .switchover_ack_needed = vfio_switchover_ack_needed,
>   };
>
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 2407720c3530..08cb56d27a05 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3378,6 +3378,8 @@ static Property vfio_pci_dev_properties[] = {
>                       VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
>       DEFINE_PROP_ON_OFF_AUTO("enable-migration", VFIOPCIDevice,
>                               vbasedev.enable_migration, ON_OFF_AUTO_AUTO),
> +    DEFINE_PROP_UINT64("x-migration-max-queued-buffers", VFIOPCIDevice,
> +                       vbasedev.migration_max_queued_buffers, UINT64_MAX),
>       DEFINE_PROP_BOOL("migration-events", VFIOPCIDevice,
>                        vbasedev.migration_events, false),
>       DEFINE_PROP_BOOL("x-no-mmap", VFIOPCIDevice, vbasedev.no_mmap, false),
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 013c602f30fa..9d2519a28a7e 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -149,9 +149,16 @@ vfio_display_edid_write_error(void) ""
>
>   # migration.c
>   vfio_load_cleanup(const char *name) " (%s)"
> -vfio_load_device_config_state(const char *name) " (%s)"
> +vfio_load_device_config_state_start(const char *name) " (%s)"
> +vfio_load_device_config_state_end(const char *name) " (%s)"
>   vfio_load_state(const char *name, uint64_t data) " (%s) data 0x%"PRIx64
>   vfio_load_state_device_data(const char *name, uint64_t data_size, int ret) " (%s) size 0x%"PRIx64" ret %d"
> +vfio_load_state_device_buffer_incoming(const char *name, uint32_t idx) " (%s) idx %"PRIu32
> +vfio_load_state_device_buffer_start(const char *name) " (%s)"
> +vfio_load_state_device_buffer_starved(const char *name, uint32_t idx) " (%s) idx %"PRIu32
> +vfio_load_state_device_buffer_load_start(const char *name, uint32_t idx) " (%s) idx %"PRIu32
> +vfio_load_state_device_buffer_load_end(const char *name, uint32_t idx) " (%s) idx %"PRIu32
> +vfio_load_state_device_buffer_end(const char *name) " (%s)"
>   vfio_migration_realize(const char *name) " (%s)"
>   vfio_migration_set_device_state(const char *name, const char *state) " (%s) state %s"
>   vfio_migration_set_state(const char *name, const char *new_state, const char *recover_state) " (%s) new state %s, recover state %s"
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 32d58e3e025b..ba5b9464e79a 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -76,6 +76,22 @@ typedef struct VFIOMigration {
>
>       bool save_iterate_run;
>       bool save_iterate_empty_hit;
> +
> +    QemuThread load_bufs_thread;
> +    Error *load_bufs_thread_errp;
> +    bool load_bufs_thread_started;
> +    bool load_bufs_thread_finished;
> +    bool load_bufs_thread_want_exit;
> +
> +    GArray *load_bufs;
> +    bool load_bufs_device_ready;
> +    QemuCond load_bufs_device_ready_cond;
> +    QemuCond load_bufs_buffer_ready_cond;
> +    QemuMutex load_bufs_mutex;
> +    uint32_t load_buf_idx;
> +    uint32_t load_buf_idx_last;
> +    uint32_t load_buf_queued_pending_buffers;
> +    bool config_state_loaded_to_dev;
>   } VFIOMigration;
>
>   struct VFIOGroup;
> @@ -134,6 +150,7 @@ typedef struct VFIODevice {
>       bool ram_block_discard_allowed;
>       OnOffAuto enable_migration;
>       bool migration_events;
> +    uint64_t migration_max_queued_buffers;
>       VFIODeviceOps *ops;
>       unsigned int num_irqs;
>       unsigned int num_regions;

