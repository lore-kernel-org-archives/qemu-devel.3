Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D9E2C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 11:59:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tus5D-0004yv-6G; Wed, 19 Mar 2025 07:59:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tus4w-0004ef-6c
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 07:59:22 -0400
Received: from mail-dm6nam10on2043.outbound.protection.outlook.com
 ([40.107.93.43] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tus4t-0001pF-TT
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 07:59:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Me2phkUjbDAOI32e1DSnZx074L7YPhVh1Cas/eQcJZPZf+wgA4twD38IQWL48J7LtMRcf2AvEGYDvLGEI+dHnvYwEcpokWiIiGtJ2TGfyYaS8BARmm5oM422CxjfW/66VQRB24FH2vY5ylFFSEjaHqsLao2WSAlu9W6UDslcyQs6tr0nt5Pyc3LqpQgtO8kS7qEfOu5cxex8nVyATK7rOkdahw0aRR4Psn9y3vsiAzUbAGiTcwdj+7BaUFhgb6SIPyEvAh8UmUdTna0Kgskl72NsNdLyTtGXbtiEDhC+mZdGvLPuU5Pq/lPzFcpF5QYL+wiVzjm7u7hNUI47AlQdPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzrDNUvG92uHD+/eHKw7DLBP9Y+hUWKnRJRgDRdc7No=;
 b=cRlvDew0er9LsSAw1bYcSRbDjhbKz42PLDdXV0RSPdLS0jeGaQM40RgJTNjHoTk26vTNrCspf4LpEHK2PMfDP3038FLdqg3VLUxuaIshOCTEOYXKpeG5bdN2bpY4RsxjkVhlTXFHi5O7dAXwadHOry9FkIcbn+3O3LjPmNfaBSrVfUSVP19kz6slAkuq377aU3j8C/4YT9IS4fkJpgTaZx64eE4Fk4qDpBol1trie6JK3mbh4KNpIZQbeokmxtoVL/AcsL+4UlNWY0OYu/U1A0udN3la4SzmFgR1Xfn/wLC2nTawbt/7sw8PI3Q9MO22TVLSXlzoB6D1Qo7UrEr2tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzrDNUvG92uHD+/eHKw7DLBP9Y+hUWKnRJRgDRdc7No=;
 b=iwDMwnEUXWcDN6PgaMBvVhQ75GARZIV4W7dRYX6R0oNNpsiVNb3LLn4SLm7iXiAYjMGk9L8nu6kqfyZ6YO0zo5OFJV+7ZXXMu7ds4HDwHDo8EQ6ug2mskebxlwSZyfmja5nSCzyR2oM/tsMBIva3OmKj/n7dfpCBpJIXCq/Ls5PcjUjtdvdnkVdgiEOQoBS3/pBvHqEbf7sCt7H18dmqh8FK+sYuRn8IDArwMMtY5KJeiu3Hw5Q4mWyfaAO8EU7oQeJwzuUy4eRI+eREHc298BW5OhLgILVQ4mXgZ4WCou5mzHST9V0BDanNIslHWyN8h4ZNZOkgL5pZ0NFKgUP/gw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by SJ1PR12MB6337.namprd12.prod.outlook.com (2603:10b6:a03:456::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 11:54:12 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%5]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 11:54:12 +0000
Message-ID: <c676f3b7-97cf-4436-a4cd-3a9f0d0dfb99@nvidia.com>
Date: Wed, 19 Mar 2025 13:54:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1 01/32] vfio: Move vfio_mig_active() into
 migration.c
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
References: <20250318095415.670319-1-clg@redhat.com>
 <20250318095415.670319-2-clg@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20250318095415.670319-2-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0190.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::8) To BY5PR12MB5544.namprd12.prod.outlook.com
 (2603:10b6:a03:1d9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|SJ1PR12MB6337:EE_
X-MS-Office365-Filtering-Correlation-Id: 09e58548-4474-4ee4-6d02-08dd66dcc346
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Sm92TTFoeFdTTTQ4cWJ1WW9BRTl3aWorQTdvSDNndS9tTlBNVHdVNDFpb2Fi?=
 =?utf-8?B?K2RkRm1wb2VrQ0M1NnhtTnk3cm55OWd3WlpxRTFHR1A4cWNBM29WMTUxbTNH?=
 =?utf-8?B?bFBhR2tDTHZxb2JRbXovb1NSSi9QNzRPajF0M29senNSSDdUSVRoODNySk1v?=
 =?utf-8?B?OE93b2ZYbEJKcVVaN01nTGNIN2haUUNSNGFZTTQxYWUvRHpiblFUdzF3MERL?=
 =?utf-8?B?TmNqUTU2dytudzN6TkpDczJHb0lSUmpTYVVQVUNqWEVub2tnNHg0VjVMNi93?=
 =?utf-8?B?blprd3lNVUJTNjZKZndNZFFXMzBqZ0NIWEU1SU1ZbGRqa0RBOGt1amEwU2R3?=
 =?utf-8?B?NEtZK25rZXU4cXBjT0VJYzc1TGJUTGxNRTlzWDBEOEduM2tTazBTZjk4SWxl?=
 =?utf-8?B?UkhydEwrNzg2YktaclNXVlVscWNVK3l5OU92Mlo5cWNyMDdqV1R4V0J2RjRh?=
 =?utf-8?B?cVlZN3NIUWlLM2cwWGpUNWkvRHEvU2ZIZTk5T3JIN1l2dVFjQk9DWjBkbXZx?=
 =?utf-8?B?MnpoRDk2SzJ4NHdIZktYbldub2dhSEdQWkVsbDE5YkczNmdYY3g0V1hVYUVt?=
 =?utf-8?B?RnNuUDMyOFFCR083dWk3QVJDczZvV1hhUk1YZXVJTEg1QXR4VTV6ODUzUS9h?=
 =?utf-8?B?NFdXZlJXazRBR0tPYTVZYUNjUzhsOFRtNnh5SEJKa0JBaDdWWGwxdlozbFZO?=
 =?utf-8?B?ZGJWeVUwaTVRZHJrd2xVSkFTTHAyb3AyZHB5S1doNmVjY3Nrd3NLeEhCUVoy?=
 =?utf-8?B?czRDay9VemJRc1NQT1VKUXRtN0hyMGVJa1B5Nm9TTUxPUG40aEs0Y2pmdmlh?=
 =?utf-8?B?V01NMzFFRk5MZ09MU3RTbGdacC9BU0o5QU5NS1QrbjhlOG11SGZnb1g1THNY?=
 =?utf-8?B?MG9Vc0ZVeWRidEpRazNYMDgwdDB2ZXkxcmpvb3VJckZNWWptc1BOWlZySnZo?=
 =?utf-8?B?a09venVjckJXVHBNVmpTZ3BwQVFYc0RCdDM1d245bU9ha3dEcmU5RXg3eW5Q?=
 =?utf-8?B?am5GOFpQVkRiQ2UyTWRiYmZueXJYc0RZUGxLSG1JdUMwMXVSQk51aU9PcU5m?=
 =?utf-8?B?N1FDcyszSXlXY01xUEJrVXVFaDBuMVRVL1dHTFU2Ni9xTGxCWDIvUzhkVWdT?=
 =?utf-8?B?YmZSd2Jzc0tqaGt1WFM3U0RUZjQ5MTBCR3J5UjI4U2d3VDMxbVpZNmRGc1VD?=
 =?utf-8?B?d0pDY1B1VjQwWjRoTnlGRDdpZDZhdlpjaStrYWFQeEkyN011R2s4dTFwV05V?=
 =?utf-8?B?T2pzRVR1Z2NwN09pNElRYVk1dnRBaHNlcmZZekZnZWhpLy9tQjR2cDZId2Q0?=
 =?utf-8?B?bGxuQS9zMmZITno1TFBOb0RudTVvWHl6TDV0SUxMMW5GSDhGOVhiN1ZDdHNq?=
 =?utf-8?B?UEVOQ0dCUS9KblRvQzI0SXE4czVmS2h1dG5IYXp0N2JKVnN3OGQzZCs4MlBP?=
 =?utf-8?B?dks5TFdoVnZzOWcyeWFMekduenpHMmZ1enlROUhHK0NJRDVZUkRBY3RyTXgz?=
 =?utf-8?B?QUNVc0E2QXFGMXRsQ1RGQ09xSU9Mbmoxem5EWWQ1YzRkYWtIeWZwSmY5SWth?=
 =?utf-8?B?ZVJ0aTVydlhKbXFMZlRHTStqN2I5YWgzL1c5ZFdqM0htaVhsTkxMYTE1OHBa?=
 =?utf-8?B?MjdHMU9rbVpUNDJxZXh5czJucHlZS0pPZ2p1dlNOOUw3SmgzTytXQUFBQ1pR?=
 =?utf-8?B?cDhqQkw2L1VOS2xMUy9wU2xUb1ZkRGNkZlpNYTBvM3FkTC94Y29xV1JQNm9S?=
 =?utf-8?B?Y05CbUNWTlo0TlROb05HVUdrVmM3cS9CM2VOU0tFRnJocFV2b3RGTFM4Y2Iv?=
 =?utf-8?B?aEU2d1JrQmZzakpGOHZpQTdjaFYzcVpIUlB1ZEh0RUxjcmNYRGRPaHgvd2tk?=
 =?utf-8?Q?dLMoSF03a3MZy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjhIclYxRVBhcXlhSlZNaGEwREc4T1lXQTFDak1DaERvMXYxUzBxU3lDY1d4?=
 =?utf-8?B?VTlFR3hxUThVVWNzc29uNVZmdEZoM3ZqYmtrclgvemJPUmk3U0xJcTB6a2JB?=
 =?utf-8?B?SzVSMXZWTS9ZUUtmYVozSHpKS1R4RlQ1b1dSTEFUWWhFMUhaK0NuZ3RpVTFj?=
 =?utf-8?B?VjkrTzVDTlB6Zms0aENPWm1xOEZsVEx1b1JDaU9sUy9DQUUyUFVUa3krMjNv?=
 =?utf-8?B?RTlSaXo0ejhVUjN6LzhLLzBFR1QzbkhJM3crTjJ4U05qQlpva29sVEFJODRD?=
 =?utf-8?B?UzBDWnVPMm5JNCsxeC90Q2txdHlKTlJadU1VQXdsNE5ZK3VXOW5pbFN3Qy9H?=
 =?utf-8?B?L05JNHJaUUpsZEhhOXZJYUpwbnVJejVuREM1WERRZ2E1SlRnamozSm5pTFk5?=
 =?utf-8?B?dEVVcVBYU1VpQVNUd09zVGVzUi9ZYzI4RFNGZC9QNjU0ZVhLbTNsamRVTDJU?=
 =?utf-8?B?K2wrQVNYcFNWeGF4Slp4OFRpSTdXaUdjZXA5NkpuR05KRzJOajVIczdSSkds?=
 =?utf-8?B?aGRVbXE3YVpOQTdnQkc2MmswTUYzbTZEL1lSK09kWkFGY2lETTNXaGRXL0pT?=
 =?utf-8?B?VHlvRXhsbWVtVHFZRzlhZmNEanRhanNyZmdpdnVSdXk1Sjg3SDM3bmRqUi9M?=
 =?utf-8?B?REJHNmdjWmxuRzZwd2JkbGNVck9oemtXaVR5VDRCZVlINU1mR0pPRXBIV2JZ?=
 =?utf-8?B?RmRlL0FQTVVvK3FCL2pWVVhzT3ljSDJicmRrc3dCdEhEUnVwODBPcG5rNkVk?=
 =?utf-8?B?djU5SXFHR2dWV3J2QjlIWXBPRUl6MzVhTElyWXdaTExNRzRvSkg3QW4reitK?=
 =?utf-8?B?RjdGaHhrRHJmeWk5WGc2eHQzQlkwMFFWTmZCQ0lpZldQRTFWSlVJUi9QcTND?=
 =?utf-8?B?R09iNmE0Y2w0TzU2ayswT2lwbnBnRERCQ1dQemltYTZHU2pUR28xNGtnV0JI?=
 =?utf-8?B?YjgrM1pWY1ViWEtFdWZ2anN1RnNvdTluVlBEVkZTb0tucVhscldSNEUvZ3Rw?=
 =?utf-8?B?VUNqRkNubVJydkNuWEVWVS9RMkVSNE1PSi94SDFlUkRRTHp0OHVMbnJ1SGU2?=
 =?utf-8?B?cVQ4aXZHWjF5ajdCYTJIbXFERjl1a1JzMHhhMm9kUCtuVlY5Y0VWak1LOHRZ?=
 =?utf-8?B?c3JCUHlLdFBGUlR2SEQ2dHVuc1pCTzY5OWpKZXI3TGlQMFBITmVqQ1RHRGdZ?=
 =?utf-8?B?OHFWQkpuQnUrem9rQjRSSy9idWt2NXJCUGpHazJjOW5tWkFPTGNlMjdDVUNG?=
 =?utf-8?B?Z3RUTFFzV2NFRG5wVUxKNkt5UVpqZ2RMY0kvZEdrZTBMYm1kZnVlc01EL3pE?=
 =?utf-8?B?RkNqSVo2Rk13d0ZOZCtCMEVJYzN2TkNvYU94MlR1NUtwNTdhRTBvU3grbTFI?=
 =?utf-8?B?dWZyeXJGZGIzYVdkU1Y1UTZwcmMvSEtvUWh4QWxGWXR4dHlFUUo1Sm5EMkV3?=
 =?utf-8?B?UFk0RU5USzh5U2lFRWdMK0VWdFZuU2NMS0d5RFR5clBDVndLaXJjSVdSM1BJ?=
 =?utf-8?B?Y1l3SVJtT1ZjZUw4QVpjaEtaRCtTM2ZHTDRvbTdHbnExQnR5NUpQOG14dkF3?=
 =?utf-8?B?ZE1KZUlRaExQYStYY0lSa2pLaDZXcnRVMnRPUHo1SmE5SHM2dWgvbmVabVAy?=
 =?utf-8?B?N1JTUkRRNktKNEdJT0RkRklyQVZibzFUNHZQMnJUNC9CRmhxMDhENmNXOXB3?=
 =?utf-8?B?c2cwKzcya0xYQVpNaURZQkZkaXc1bTR0QktoYVlGMUxkNVpTSk40RUZCbit2?=
 =?utf-8?B?U3VtTTRaRHVKQzRmRWllZnhaNUZZMlRtRE5CM2Zhb1RORFcwU0RBL0EwSi80?=
 =?utf-8?B?TUdjSDVYZEpCSHdOTFZsc1JqM1QrWWo2RnRRU0JtOUxZTi9ZcmlQMVl4N3F3?=
 =?utf-8?B?S0UvLy8rUi9lVnhDdFlOeCttZi9nS1JFZFAzcDRPZjhTeE5ja0o4a2tDSW1E?=
 =?utf-8?B?YStma2pEOGI3WnFYS01jN3hrRUJGL0N6bjRvUkhlQWpYSkNvb0NGZmVTUjMv?=
 =?utf-8?B?dzQ0ZDUveEFHUGxsdVpISmlmUnJxaDh5OU1maXVjL2RHTzNteWdXUGQvNnB3?=
 =?utf-8?B?dFhCZHVOcUhJc1BtRWROZkJOQzRiVmpjZ2l6a2NPUkJFMHQrOHA3NVdjOUR3?=
 =?utf-8?Q?gntf3s4OTT96dQoN+4usaxJGL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09e58548-4474-4ee4-6d02-08dd66dcc346
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB5544.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 11:54:12.1324 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mEZrUHqpqbSWjJDeS7+3VfMk05RmLat+FUSc8VWgXue3UWkie4OkzLfOpu3BJQJqO3kA35YJRxS3P4dxfje6Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6337
Received-SPF: permerror client-ip=40.107.93.43;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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


On 18/03/2025 11:53, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> vfio_mig_active() is part of the VFIO migration API. Move the
> definitions where VFIO migration is implemented.
>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>

Reviewed-by: Avihai Horon <avihaih@nvidia.com>

One nit below though.

> ---
>   hw/vfio/common.c    | 16 ----------------
>   hw/vfio/migration.c | 16 ++++++++++++++++
>   2 files changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 1a0d9290f88c9774a98f65087a36b86922b21a73..4205f4f7ec87e1a2a5e4110eabc8fde835d39c7f 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -66,22 +66,6 @@ int vfio_kvm_device_fd = -1;
>    * Device state interfaces
>    */
>
> -bool vfio_mig_active(void)
> -{
> -    VFIODevice *vbasedev;
> -
> -    if (QLIST_EMPTY(&vfio_device_list)) {
> -        return false;
> -    }
> -
> -    QLIST_FOREACH(vbasedev, &vfio_device_list, global_next) {
> -        if (vbasedev->migration_blocker) {
> -            return false;
> -        }
> -    }
> -    return true;
> -}
> -
>   static Error *multiple_devices_migration_blocker;
>
>   /*
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index fbff46cfc35e0ee69e9599c9f8efc7437bbe3370..b5fb0d218808d010d8210612d3182dde8f33514b 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -1062,6 +1062,22 @@ void vfio_mig_add_bytes_transferred(unsigned long val)
>       qatomic_add(&bytes_transferred, val);
>   }
>
> +bool vfio_mig_active(void)

We already have vfio_migration_* prefix in this file.
I'd say let's use it and rename to vfio_migration_is_active?

Thanks.

> +{
> +    VFIODevice *vbasedev;
> +
> +    if (QLIST_EMPTY(&vfio_device_list)) {
> +        return false;
> +    }
> +
> +    QLIST_FOREACH(vbasedev, &vfio_device_list, global_next) {
> +        if (vbasedev->migration_blocker) {
> +            return false;
> +        }
> +    }
> +    return true;
> +}
> +
>   /*
>    * Return true when either migration initialized or blocker registered.
>    * Currently only return false when adding blocker fails which will
> --
> 2.48.1
>

