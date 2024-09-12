Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 242A5EE645D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 08:14:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soexe-0001cW-HF; Thu, 12 Sep 2024 04:13:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1soexc-0001V0-Sx
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 04:13:53 -0400
Received: from mail-dm6nam10on20618.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::618]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1soexa-00054E-2O
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 04:13:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FuFmkFiukTzBF0Mo1NSjeq5bmKEtWYuqarM03gEk0juNc9moJmS5t+WfUKoxzfa2vOKEGA9tkh2riXnalU7VumqbnoW6LT1bcvGTpKgs3PnlYQr19hbfTk2eZ2S9Ca+NV3yebSnIvUvB1WuxGn3021z+Hy6SrdHK0v4cSG5d4MInXQsC4yWtjLe9g0u24h6ntlfR207l9jx/H3vb1Vwi+9ijDYzgWkRXXBJ+eNHYjYMr+3YoF/h/9s0T++3LC7Rjte2Sqex0pL/3Ihvj/cyZn8vHUxxf8yxTU4rTsG1RXiPmu+Ru5lgE7gWJSKojDmcmxwpDk0Q9N8uOZrWO8ypqAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TtUtPJyPILtiIz6gXDXOrIPbA7rbPqW6Jp4yNq9KOIU=;
 b=YhqH97S1MNu7kGJ/eT2j5q1DRGnPSyLqoYXmsFLTNqUa68v03g3ZXx0sliJZ6uhsYfuZvscqLUt9rxfldkCl5uOBKgL1pvu3fKZfzEeiAeWCljDa8qUMEhUu1nTZ1xnjP8ZOR7QfIiFt7N50gXnjkxjYu5l900RtdcokFgeqiWJ3Bi/dTGO8jGOE/kTGUxPOaQRkeOHb5oA02uTQwj06QBe8/YnivU6a2RzEwIjLT6/h24ojdID/kNkoWPZ+R0pQTYX2DxO1KlM0cY4ucUmJTzDsiSpGf6SMto2hgc7/7taVwFYzahWyw1THB78MGx+QHa68ecjS3XfR1C0Ek9zpTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtUtPJyPILtiIz6gXDXOrIPbA7rbPqW6Jp4yNq9KOIU=;
 b=pzsVllLp9D4VHtFx3SNbnTs7NCzWpS5tCEBfcfBYmVdETiySrvgHPJm2j9r79Gt7j8XyduPi/IToWJ2wYEgnDiJ+OEybeLJhd8HeawAxOaBFfkZT7buavvW/fxx8e/G+6tmgBeohhs5rJ7m7Hae0O9kH64UrCqvc+HdlZiziKh2E49uGwFu2B5EVsJj1ntjvudjfnNPoPCWNt7Z8KXfAHcDd+ZeJlRdIuUJHsUdX6iYGwZD2o9jrOPDnpPo6I0ududbfMzJID+a5Ml83EbhtjozX60mSJazaJNNxtcZnYxx4f+MgEP4Bep3rDbPSEtZd1CKc7Yoh+cP7L6FkcGIDXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by DS7PR12MB8371.namprd12.prod.outlook.com (2603:10b6:8:e9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.20; Thu, 12 Sep
 2024 08:13:45 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%6]) with mapi id 15.20.7962.017; Thu, 12 Sep 2024
 08:13:45 +0000
Message-ID: <31954a8f-5182-49b4-9514-2839aaef77a3@nvidia.com>
Date: Thu, 12 Sep 2024 11:13:38 +0300
User-Agent: Mozilla Thunderbird
From: Avihai Horon <avihaih@nvidia.com>
Subject: Re: [PATCH v2 09/17] migration/multifd: Device state transfer support
 - receive side
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1724701542.git.maciej.szmigiero@oracle.com>
 <84141182083a8417c25b4d82a9c4b6228b22ac67.1724701542.git.maciej.szmigiero@oracle.com>
 <2a9d1c5d-6453-4b33-99cd-824f0002e305@nvidia.com>
 <c042036e-ff01-4adf-b9a6-090660887a2e@maciej.szmigiero.name>
Content-Language: en-US
In-Reply-To: <c042036e-ff01-4adf-b9a6-090660887a2e@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0256.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::9) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|DS7PR12MB8371:EE_
X-MS-Office365-Filtering-Correlation-Id: 561d659b-8ac3-4f4d-a6ef-08dcd302d257
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OTZxUXJTL0JjUm5PSFltQUN6RmljcHBpdXpyTHhlaEUzZkZVY2dmS0lGT0Nv?=
 =?utf-8?B?eDkvditDdHhGcGtXYmxPb3c1Y1MyaURLZUJHYkRGNlJCak5vZk1QNHNEM2Vo?=
 =?utf-8?B?YVdOWXArQzREdVErakJjYzd3UlpCbjNzTVdrZHpSTHpzK1kxWVo2WVhGS2xq?=
 =?utf-8?B?UkJXV3NxcENzVkpTdEtib05WV29JVGh5ejh1andIRUJwT0RYYzBrUHNGV2pE?=
 =?utf-8?B?SWNzWi95MUV0bUJEUVQ0ZEVlVTVPaFR5RUdTWFJvSktJNW5Ubit3L2dkMFlj?=
 =?utf-8?B?ZDh6TnF6SHpmZCtQVkhEZmp3S0dYSllYQytCZFlMeVVGR1dUVUNPanhPS2xw?=
 =?utf-8?B?NmpFa240d283YWdMQXFJTHZSTjV0aUFHaUM3RkNRS25SYTVra0pOMzJyNU5B?=
 =?utf-8?B?MkRWZTdXbGFCWVYyNFdJM1YrNnJPbjBuNmdDTktubG1JTXJMSExDQTIvNFNo?=
 =?utf-8?B?WVN6Tk0vUFVhZ21JZlNpTWFzZE5ReDI4QmtNS2NQdFNIQkpaVTVDeVNROVVn?=
 =?utf-8?B?SWJ6YTFrNXdobmQ0YksvajQ3ZUVVTHBiRm1QRWgwWVJLNGtoZTdITHVKamhI?=
 =?utf-8?B?eHJmOWdDSTAycjNPUHhXVVVzSlhlejBVL1dQZkFYMjJjaG1sV1MrZ3o0amVS?=
 =?utf-8?B?VW1MeTlFeit6Y3ZyNUt2MVFCdUZCV3VCZ1hpVGNUOGZRR1M5cXYyLy9FRThZ?=
 =?utf-8?B?dktCT3VWQVlaMldydWJIR1dCTXFjUDBxNjJoc0NRNFlPUjYwc3VycVpsNXVM?=
 =?utf-8?B?ekFXNzdMTEVBWVRUckxpSlNyTXRYYXpaeWpLckY3MHpHcmVTdmJORWNVRW9O?=
 =?utf-8?B?ZGdPTGJrZTV3OGQyY2RTOXpDUGcrNFVLQlRQZmExQkVKUFN5SHBqVTJVaVFy?=
 =?utf-8?B?N215MFdKcjhmcStqMFB2b01kaGZUNEQ1U1lqZkhlZ3huZXBsL01uSmEvU2J0?=
 =?utf-8?B?eWtvRERoMHcwZGVDeGFHRWhDb3ZOaFNNNG40TXZ1T1c0Um90YUQ0MFl0NElP?=
 =?utf-8?B?K0VwUGs4QS82OXl0ZlRaQ0RTQWlFZ1UzbmdMZ3FxamR0UkZ4WWhmWVFza0x6?=
 =?utf-8?B?Z3RhcW1jZnloTnZ2czhzVHhZNWJqTHR0VnVsT3p2Y0pHck8xTXAzRGNZZ1hQ?=
 =?utf-8?B?RzlVYzYzTWlON1BUbC9uN1dPUG1FM2VERGNVY0I5VnM3M2ZtMlF3ejhmM1Jz?=
 =?utf-8?B?ZWNmOHk1YllsZHZhdHZqNmgrTWNKTFlaK0RPdmYxZE5CQzNXcmQ5NmJiZlk0?=
 =?utf-8?B?T05lWllPS3NPWFNrNnlER3o5azZuWkVkZzNoSXJCUU5hU09TVGVTa014SWZ2?=
 =?utf-8?B?MEFQL3FwZlZ5N2FkNWtPQ1FQdVZraklMOXRMcHd5NHBhNk1HWWF2MlJOOEZV?=
 =?utf-8?B?OGF4WGdsL2hhcGdUVUxvVFNHTlZIUzFCYnFJQzU0QU5jZ1pKTmo0bHBCTmF5?=
 =?utf-8?B?bDJYRkdZOFRBNDRqd1BqdkdudFh2N29Qam4yQ1VJSjdzNjFKNlJxNnFnaVd6?=
 =?utf-8?B?aDZ4UzFlUHdXSlVGbDRkQXVnRGdibDlwcmxtdzB4U2YvbHVLYUxZaUxTV0lT?=
 =?utf-8?B?NWdKU0RNdjNwTTdNWDhwRUg0dE5YeUtYT2RMdmdNQW9XeFNDOHAySitxejJT?=
 =?utf-8?B?Q1FrS3QvZ0ZyOXRvZkk2QnpSUjRJNnhpRU1MY29hUWxtMm1MZ2JFSkVZWENz?=
 =?utf-8?B?ZmhZZzBNNUp3ZlM5OG5lWDBTRmJVK3M0UU9naFBua3RyeHNEWGlCdjRQeTJ0?=
 =?utf-8?B?QVFJQms5NU1Lb1VKRlcrNE8yZ2t6MzRIRzVLVjQ0T1dacTlpT3U1V0NoZDJM?=
 =?utf-8?B?UlFnTUN4UklSNVhBSnV1dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3NubGxxM3pFM2NLTGpaaTI5TmhreDJsb3FHSDV3YmFDKzJxa3c4Q3ZYd25G?=
 =?utf-8?B?SEdwY3docWczRXJwUC9zbEM4QmZCc2NzTkdLM1ZFNGIrVkxMQ0FlOVhJZ0lt?=
 =?utf-8?B?RGpqN2VwUGxrWmw5Z3NJZGphdFF1MXl1K01MMjZjWEZIZ3RHdVBzaDk3MGtk?=
 =?utf-8?B?UkhVTVVpeFNqd095MHRmZTJQLzgvZVVRUHdvSkRlcDN6ZWdUaDBuZnorb3V1?=
 =?utf-8?B?TDZWc0J3TURSbUhTdG1FRm0rVS9GeTUxbVoyakpBUmxZczNyWm1nTUNrNXBZ?=
 =?utf-8?B?OGprNTlFRWFIZ3d1VEVVeG1wbzZrUTJxVTJSc0JoUFF5MVRNLzFPWUpEL25x?=
 =?utf-8?B?TTNUb0J4SlF5NE96RlRXR3lnTWVYYlZpWnNPcmllNndScTVDSzNXeVMyNUFw?=
 =?utf-8?B?TzBTU21TVXd1d2ZqdU1TRVUrRlRjTGcva0tCTW5pZUZpNWFTandyZTI0cE9S?=
 =?utf-8?B?OUJGUWtSdndEeUUwSzJLU0NNUVRmMEdQVDZHOEJEQ0ZHTEFiWldiZURRMGEw?=
 =?utf-8?B?R3g2UVJKd3ZTY0VXbFVwTzFLRlVKZzd6MW1sSmVmZDZSOWdxWDkvajdScks0?=
 =?utf-8?B?cnJWOGkwV1NLejV2ZStSYy9Cb1BBUXNyd0hZK2xGWWp0UUpPOC9ONGlFV1c0?=
 =?utf-8?B?NWpsa09YeUFzdXBTTG5oWHlMTFZFZXhremxobjZiQ1Y1NEtTZmMxUUp5OVBP?=
 =?utf-8?B?bGZENW9URmNtdzRnUkhBNngvaHYxZElzWTJScVRBeXhlYzVVOWdpdnJCa2lq?=
 =?utf-8?B?TXZlNDV0bzRML0hCSEw4MU84dTlHNWhJKzR6dlhCOWoyaFhVRnRmTGhYdTFB?=
 =?utf-8?B?Znh2UWtuWSttdzAzVzMvSU1pZkFWTTRvZ2ZJSitDMnhEUlZMS3lvb25sREpi?=
 =?utf-8?B?eXY4cUhRVkV4WXRXTHpJV2FZZC9BRTZacHRxN25HZ0Q2dGc4bG9TL3ltRFUx?=
 =?utf-8?B?R2V1SjJFdFN5RVlzQy82bWxRblZNMkE1Zks0bzh4STg3MWdTWlk4KytlRmh6?=
 =?utf-8?B?QnhRaVhyNDRWSWsxdWV6bkhlMGNWZDJIOFkvTE5jOUVBMmcvNm9OS3VqQ1hi?=
 =?utf-8?B?NzlCOVBsMzRrSlVMUnBWVWZzTEVDeTFYSEVsUTFxcTlJMVZXNlRLcGwwdHNX?=
 =?utf-8?B?L01MeEZNSE56dUNCdmg3UXpZV2R5ZnYvZFExckY3UUZmL1ZKV1hOcWJSZGRZ?=
 =?utf-8?B?azJkZm0xSnRZRDdjVHF3WTZUa1RUWkVSTEJIazFab0lSSWh1aGRzRSs2ZVlq?=
 =?utf-8?B?aUtKcElnVlRWYjhlS2IwRVBuS3BmekpNeDE4aGs1b3V1SWVxYUdzZTUxUEox?=
 =?utf-8?B?bHJ2SHhDcDlydzVENlBXMmtHN0ZxelpVdnhCTENrUVBodlpXWjV1cVIweG1R?=
 =?utf-8?B?NVJhaG5qQXFkOEhMeWZxMXRzbEI2WUxjQkNPSXd4SGNwS3ZHQ3EyUGUrb3Iy?=
 =?utf-8?B?bkFKblRWdFlqYm9uMTZudXlhZ09SVTRrdk5NWUYyamc0ZGM1Tkd4STlPeHpD?=
 =?utf-8?B?bHdqY01UeE1ZTnhRT00vZDFOa3pmOEF1QS9uaFVhOHdHQUJUZVpnaW9JWTRI?=
 =?utf-8?B?ZWpOMVRsRWhRU2Q2YjNlUDVwUWtLVnN4UTJFOXpLUURaSE1EN3JheWUwNTNM?=
 =?utf-8?B?di96OGFQd3hIb0RiOVdqTmZVVUEwSmo4L3dYNUhQSUh1ZjdZR2MrUnMyNG02?=
 =?utf-8?B?NnpiL2w0VmgwajBmRjBkODZ5b0F5YlEycTYzY2VKM1dkVDZaQ1NZT2hHRUZh?=
 =?utf-8?B?Qmo0VEhJa0dUNnR3KzFlWTY5RG9TN1RWUlpyZDhsekNxdVl1YUpSbFJMdUl4?=
 =?utf-8?B?R2JvVk9taFJMc2pBTjVGRUtmSTlJRzByaHhJNUFlV3IrMEo0dGhnT3h2aFBM?=
 =?utf-8?B?MWVaWXBzaXRHSVp3UDhvUmQ2MG5sd21jRzQ1dXlpZkNyOEZObGRxZkE1cy9P?=
 =?utf-8?B?VGhWQ3RDUzFZOXJRLzJSd0NiN2R5T1phNng4T3BRTm9pN1BLRUdEbkxPcDBW?=
 =?utf-8?B?NVZwNFhHV3l2Vm9jRXdOSjhmSkZBYkJBSjIxU1NrVVQ4UW51MkN1eW00ZTBI?=
 =?utf-8?B?eVNsRFMzZUljbU1DSGRMR1I4YU9QWEFoV1ZaSFE0S3Q4REZaejdHY3Y0NnVj?=
 =?utf-8?Q?F1FXrnenuO+zNNulP9BAep/ix?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 561d659b-8ac3-4f4d-a6ef-08dcd302d257
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 08:13:45.4870 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ttI+bBre5O32zCqYvyhLkJ0PHB7wwN8VJsOOmhHpVl4C5c0ASK4itsdpNe0AZ1yR1D8FaIa8ltMqAoBBcPid+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8371
Received-SPF: softfail client-ip=2a01:111:f400:7e88::618;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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


On 09/09/2024 21:05, Maciej S. Szmigiero wrote:
> External email: Use caution opening links or attachments
>
>
> On 5.09.2024 18:47, Avihai Horon wrote:
>>
>> On 27/08/2024 20:54, Maciej S. Szmigiero wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>
>>> Add a basic support for receiving device state via multifd channels -
>>> channels that are shared with RAM transfers.
>>>
>>> To differentiate between a device state and a RAM packet the packet
>>> header is read first.
>>>
>>> Depending whether MULTIFD_FLAG_DEVICE_STATE flag is present or not 
>>> in the
>>> packet header either device state (MultiFDPacketDeviceState_t) or RAM
>>> data (existing MultiFDPacket_t) is then read.
>>>
>>> The received device state data is provided to
>>> qemu_loadvm_load_state_buffer() function for processing in the
>>> device's load_state_buffer handler.
>>>
>>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>> ---
>>>   migration/multifd.c | 127 
>>> +++++++++++++++++++++++++++++++++++++-------
>>>   migration/multifd.h |  31 ++++++++++-
>>>   2 files changed, 138 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/migration/multifd.c b/migration/multifd.c
>>> index b06a9fab500e..d5a8e5a9c9b5 100644
>>> --- a/migration/multifd.c
>>> +++ b/migration/multifd.c
>>> @@ -21,6 +21,7 @@
>>>   #include "file.h"
>>>   #include "migration.h"
>>>   #include "migration-stats.h"
>>> +#include "savevm.h"
>>>   #include "socket.h"
>>>   #include "tls.h"
>>>   #include "qemu-file.h"
>>> @@ -209,10 +210,10 @@ void 
>>> multifd_send_fill_packet(MultiFDSendParams *p)
>>>
>>>       memset(packet, 0, p->packet_len);
>>>
>>> -    packet->magic = cpu_to_be32(MULTIFD_MAGIC);
>>> -    packet->version = cpu_to_be32(MULTIFD_VERSION);
>>> +    packet->hdr.magic = cpu_to_be32(MULTIFD_MAGIC);
>>> +    packet->hdr.version = cpu_to_be32(MULTIFD_VERSION);
>>>
>>> -    packet->flags = cpu_to_be32(p->flags);
>>> +    packet->hdr.flags = cpu_to_be32(p->flags);
>>>       packet->next_packet_size = cpu_to_be32(p->next_packet_size);
>>>
>>>       packet_num = qatomic_fetch_inc(&multifd_send_state->packet_num);
>>> @@ -228,31 +229,49 @@ void 
>>> multifd_send_fill_packet(MultiFDSendParams *p)
>>>                               p->flags, p->next_packet_size);
>>>   }
>>>
>>> -static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error 
>>> **errp)
>>> +static int multifd_recv_unfill_packet_header(MultiFDRecvParams *p,
>>> + MultiFDPacketHdr_t *hdr,
>>> +                                             Error **errp)
>>>   {
>>> -    MultiFDPacket_t *packet = p->packet;
>>> -    int ret = 0;
>>> -
>>> -    packet->magic = be32_to_cpu(packet->magic);
>>> -    if (packet->magic != MULTIFD_MAGIC) {
>>> +    hdr->magic = be32_to_cpu(hdr->magic);
>>> +    if (hdr->magic != MULTIFD_MAGIC) {
>>>           error_setg(errp, "multifd: received packet "
>>>                      "magic %x and expected magic %x",
>>> -                   packet->magic, MULTIFD_MAGIC);
>>> +                   hdr->magic, MULTIFD_MAGIC);
>>>           return -1;
>>>       }
>>>
>>> -    packet->version = be32_to_cpu(packet->version);
>>> -    if (packet->version != MULTIFD_VERSION) {
>>> +    hdr->version = be32_to_cpu(hdr->version);
>>> +    if (hdr->version != MULTIFD_VERSION) {
>>>           error_setg(errp, "multifd: received packet "
>>>                      "version %u and expected version %u",
>>> -                   packet->version, MULTIFD_VERSION);
>>> +                   hdr->version, MULTIFD_VERSION);
>>>           return -1;
>>>       }
>>>
>>> -    p->flags = be32_to_cpu(packet->flags);
>>> +    p->flags = be32_to_cpu(hdr->flags);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int 
>>> multifd_recv_unfill_packet_device_state(MultiFDRecvParams *p,
>>> +                                                   Error **errp)
>>> +{
>>> +    MultiFDPacketDeviceState_t *packet = p->packet_dev_state;
>>> +
>>> +    packet->instance_id = be32_to_cpu(packet->instance_id);
>>> +    p->next_packet_size = be32_to_cpu(packet->next_packet_size);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int multifd_recv_unfill_packet_ram(MultiFDRecvParams *p, 
>>> Error **errp)
>>> +{
>>> +    MultiFDPacket_t *packet = p->packet;
>>> +    int ret = 0;
>>> +
>>>       p->next_packet_size = be32_to_cpu(packet->next_packet_size);
>>>       p->packet_num = be64_to_cpu(packet->packet_num);
>>> -    p->packets_recved++;
>>>
>>>       if (!(p->flags & MULTIFD_FLAG_SYNC)) {
>>>           ret = multifd_ram_unfill_packet(p, errp);
>>> @@ -264,6 +283,19 @@ static int 
>>> multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
>>>       return ret;
>>>   }
>>>
>>> +static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error 
>>> **errp)
>>> +{
>>> +    p->packets_recved++;
>>> +
>>> +    if (p->flags & MULTIFD_FLAG_DEVICE_STATE) {
>>> +        return multifd_recv_unfill_packet_device_state(p, errp);
>>> +    } else {
>>> +        return multifd_recv_unfill_packet_ram(p, errp);
>>> +    }
>>> +
>>> +    g_assert_not_reached();
>>
>> We can drop the assert and the "else":
>> if (p->flags & MULTIFD_FLAG_DEVICE_STATE) {
>>      return multifd_recv_unfill_packet_device_state(p, errp);
>> }
>>
>> return multifd_recv_unfill_packet_ram(p, errp);
>
> Ack.
>
>>> +}
>>> +
>>>   static bool multifd_send_should_exit(void)
>>>   {
>>>       return qatomic_read(&multifd_send_state->exiting);
>>> diff --git a/migration/multifd.h b/migration/multifd.h
>>> index a3e35196d179..a8f3e4838c01 100644
>>> --- a/migration/multifd.h
>>> +++ b/migration/multifd.h
>>> @@ -45,6 +45,12 @@ MultiFDRecvData *multifd_get_recv_data(void);
>>>   #define MULTIFD_FLAG_QPL (4 << 1)
>>>   #define MULTIFD_FLAG_UADK (8 << 1)
>>>
>>> +/*
>>> + * If set it means that this packet contains device state
>>> + * (MultiFDPacketDeviceState_t), not RAM data (MultiFDPacket_t).
>>> + */
>>> +#define MULTIFD_FLAG_DEVICE_STATE (1 << 4)
>>> +
>>>   /* This value needs to be a multiple of qemu_target_page_size() */
>>>   #define MULTIFD_PACKET_SIZE (512 * 1024)
>>>
>>> @@ -52,6 +58,11 @@ typedef struct {
>>>       uint32_t magic;
>>>       uint32_t version;
>>>       uint32_t flags;
>>> +} __attribute__((packed)) MultiFDPacketHdr_t;
>>
>> Maybe split this patch into two: one that adds the packet header 
>> concept and another that adds the new device packet?
>
> Can do.
>
>>> +
>>> +typedef struct {
>>> +    MultiFDPacketHdr_t hdr;
>>> +
>>>       /* maximum number of allocated pages */
>>>       uint32_t pages_alloc;
>>>       /* non zero pages */
>>> @@ -72,6 +83,16 @@ typedef struct {
>>>       uint64_t offset[];
>>>   } __attribute__((packed)) MultiFDPacket_t;
>>>
>>> +typedef struct {
>>> +    MultiFDPacketHdr_t hdr;
>>> +
>>> +    char idstr[256] QEMU_NONSTRING;
>>
>> idstr should be null terminated, or am I missing something?
>
> There's no need to always NULL-terminate a constant-size field,
> since the strncpy() already stops at the field size, so we can
> gain another byte for actual string use this way.
>
> RAM block idstr also uses the same "trick":
>> void multifd_ram_fill_packet(MultiFDSendParams *p):
>> strncpy(packet->ramblock, pages->block->idstr, 256);
>
But can idstr actually be 256 bytes long without null byte?
There are a lot of places where idstr is a parameter for functions that 
expect null terminated string and it is also printed as such.

Thanks.


