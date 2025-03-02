Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A4CC19F32
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Mar 2025 14:17:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tok6u-00037L-UT; Sun, 02 Mar 2025 09:16:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tok6p-00033M-KI
 for qemu-devel@nongnu.org; Sun, 02 Mar 2025 09:16:02 -0500
Received: from mail-dm6nam11on2060d.outbound.protection.outlook.com
 ([2a01:111:f403:2415::60d]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tok6m-0001Ba-E6
 for qemu-devel@nongnu.org; Sun, 02 Mar 2025 09:15:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gyf+WupXRompIuyLJDGQSu5KKQmR+c6RfyqOAXopaHHeUuX8tU7J/K7VcV2iCm75uiedMe0sYI+z7mfBTOHt+GjgsiGUIbyUwCw8BdMsJ9mI/WK9BXRDokLPh09ONdR0548ATghjqpiUmuDgDFmlF5NoRYYyp0IvNmwrqjd2p5F3eNJpOElpr0Q835wfLt/hpogzNuCQNFuzmR/cj11+flBwTyZ+pCZMkbZtEeCBge1ADMmsuq0Fd/eSdpAHo93b/OIn0E4mY/Obp5+cIvQSXU8XZ9HOAhraB0a8UKgdCAqmvBSA5I3kE5vmtnHnjyNivTol8RfaDfDZnp0ev4r15Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8neAS+udCdpP9CxagG8eXDGNLT/SDJg92o+GeCE9Zys=;
 b=YpnekPa+WBft04h0HgZvcegrliWyPfWFawLYzj0MS23yI58BcrqsGS35PyYQVSbXKXWFsIO2YyKt0c/KbWOxnKU3ENQCYOHvxnK0WxFfHA3B2nhv1wHHFqETEknlo2jpztYbhxGsFCVC3/0+M3gKN1GodCqDz+ZjM242zrp93WhiJGZTtOPnc0HXAtM/8GbSOmxHhsqpULZ0rVltzX0g2iE+or1nKd/XKW7BVrF6gJQq2AwwIxTXw75IBxkFQApvnowhlxhKw9/h4w3zGFnmprt4slVUnyK0nlZrDhDgtncm7Od/EoQey2TObFCFy4vKxXiDN/RPFIiMzjcO59pmgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8neAS+udCdpP9CxagG8eXDGNLT/SDJg92o+GeCE9Zys=;
 b=N+PbUUSmSTFTHKmDMsT0+j5VBCZZkCkSi7B16UJzKBA7YmHlI12o4HuaNt79l23c6znLl9GRS9S+9dwiOdhdVkHeKVSrDgzeQbG8cf6zc4jpbaHDRyIjvRtFy6IoiVxBROnjudv7mJBgMb9WqESyO8jIBTuzA+QYaWIO6b5VWkU5D+bgJZjUVOs3BQ0B4kqA4dwBS8Id9y3FgMDcNDmPTMMg/cm68mIjG0KPdepIO9ce6lp402qxZnZ1PjlYU40xnYeJMcrhAwYEApIpHPXpSIAnRaXwzrnCOOzq6bdSTCx+rqLYmLAk5dK0VCOsUOHNjZuTCMLMEx0CUPOOlcwhfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by IA0PR12MB8895.namprd12.prod.outlook.com (2603:10b6:208:491::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Sun, 2 Mar
 2025 14:15:50 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%6]) with mapi id 15.20.8489.025; Sun, 2 Mar 2025
 14:15:50 +0000
Message-ID: <2fe12099-be41-4ca3-8ede-add04cc76b19@nvidia.com>
Date: Sun, 2 Mar 2025 16:15:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 27/36] vfio/migration: Multifd device state transfer
 support - load thread
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1739994627.git.maciej.szmigiero@oracle.com>
 <9be8882ea2189c1a827bdf09835d6c65488d2ca6.1739994627.git.maciej.szmigiero@oracle.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <9be8882ea2189c1a827bdf09835d6c65488d2ca6.1739994627.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0060.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::20) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|IA0PR12MB8895:EE_
X-MS-Office365-Filtering-Correlation-Id: 0549ffda-c226-4be1-59c1-08dd5994bc21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TDRmWWNxYlVwUzBtRDhScklmcEVkSW5GUVVWd2twV21oZ2xacW9xaVZsN3Rj?=
 =?utf-8?B?SWNuRVNGR3djN0lzOW43MU8xR2hXRjlETjMzTTkzTWlHY1NQNFpaMy9wRkZJ?=
 =?utf-8?B?eitPR0x4WUd6RWlUcytkYUI1UFBReXcvV3hsYno2SXMyWVg4eHdJcFREaFVF?=
 =?utf-8?B?cS9MMU5FRWVGeDRaR1dqT1p2bnYwb1E0N1BCSnNBU05OTDJSajh1REZuMVJH?=
 =?utf-8?B?OEdoallDeDJtblpzMkc1TXF4d3luemdEeElUT2VvRWRNRzhUUHFUMW9FdXMy?=
 =?utf-8?B?R1pJMGRnRk15QnVsbnUvOTBwT1hjVVhKU05RelQ2L3R0cVNpM3VSZWRRb0tr?=
 =?utf-8?B?dHNybFdrbi9sQmhMWFdXR05oZUhoK0tOWkxZUGx6VHNpb25taFBsT1RoajRn?=
 =?utf-8?B?US9vNDNFTGV1c1ZYZU5oSGUyOFR0VXRsTUFidFJJcDVMTnVSeHF6YTFDdXVK?=
 =?utf-8?B?aEo3OXVrVGd0RGd2eHlIOXlSSVdzRzZBOG9heE5pOTNLd3BLQWtRVC9oU0U2?=
 =?utf-8?B?L1I3Z20vNlYxVmx2RlVWa3UwZDRkamVDa3E4Z1UvcE1nU0dFaXhiT1lZSDlR?=
 =?utf-8?B?RHZZTll1UmZteFhHNEh6RVZEc0RoR1hKRWRybVl2MW9WS21RcVZCb1M2dUVT?=
 =?utf-8?B?K3RzR0ZhYTlKZWZVRmlXajMwR2pCR1R4UmJFRGxRL1FYNnpqbVR3aDMzVTRr?=
 =?utf-8?B?VkJVZ3paZUZmZWUvQU44OFh2Y0VMUHBLT0o1NVordjN3UjVVakt6aUdTYkFu?=
 =?utf-8?B?V2JTMDVzZlFrcGZZZG5iMlJ2K3FGMmVvZkpyYlRBTHR1THhUQkMxeEpDK0t0?=
 =?utf-8?B?eEZiYktpSG9hTE1Jb0pIVjdZY2M3eG5sZHlXL1E5ckhkMk85Mnlwbm5ZNEdX?=
 =?utf-8?B?eGF1OTdJWm9zVHpVYUwvVTk1MVc1K3duVEVsNlNJK0o5WlJRQnc3R1BWcDlR?=
 =?utf-8?B?NG91SmdmMEZUWlV3czcxK0ZkVkxtNWVoU2M0dW9RNFV1UU1zdHgvcE9PQ0I2?=
 =?utf-8?B?UllsaXJmMTZMbkExajJDWmpEMlBJVWdjbndmWFlFVE9iYml4M0hMK0dNWk5R?=
 =?utf-8?B?WnkxZ1phUDRWSFNMSG9OdUE2Q05qTnQzSW5WWEliOTF2cXRxOWFORGxVUHRh?=
 =?utf-8?B?bGJJWEc4L0tQenBOUDBBZXBjRDVtYXFVZ0NDZDYwU21idEJmSXM0SjAwWklY?=
 =?utf-8?B?ZXdObnVpbEpyZW5vemYxMEw5d0QrU28xSm9wd1pKdjkrWnNVOUROZ2RsMVVC?=
 =?utf-8?B?bllteHZoa0M2Q0ZYTk5nUmxQU1lsdjBVOS9TMDJ5L2tXeVpnLy92RTFsOFFK?=
 =?utf-8?B?dGVvV2ZEMEFDV0Roa2JOSURkd2grNm0vOVNFTDBtV1RaY1dBdFR1N2RYeWhI?=
 =?utf-8?B?SjQ2QUpsQXpZZzNOYXZyb29wNUdlK2dyOFFuaFp3ejVWOVVGUkhIaFR2c3F0?=
 =?utf-8?B?eEpPTEgxZU0rRXU1K1NwcUhOYSt2VzBpWnNnTzFqaXdLREpBT3JOZTNZQlF4?=
 =?utf-8?B?N0RWZjdldzYyU3ZHS1VyVk1odWVGZERBRFlxVHgvVkNyTWhJRVVtNEhiWHdr?=
 =?utf-8?B?YS9zMFhja0pwZGphQ3JZcWNNNzkxTElJdkZTZDQwRTY0ck9MdFN4N2YwM2Nn?=
 =?utf-8?B?Z2VDYTJXOVU2a2VHa2lZakVwRUdYaFNETnBKRGN0NlJZS1VHNkE1NXh6Nktw?=
 =?utf-8?B?YkU2TmxTWmNYaGR5T1h2RTFNd25HeVdmVlJLMUhENHlNYUVZOW0zMjBMRW9s?=
 =?utf-8?B?eXdkdnhRRytuWjhHYldSNGhVeWdaaHBGeXNRdXdDbHVqUEpFUWdUcjlUUndo?=
 =?utf-8?B?RGk0czVYOS8rcHhxTDB3VVJNenpxczJ3UERQMmZjejA5UTNjNmhzbjU4empM?=
 =?utf-8?Q?cWfIURgxrY2n3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzBCVnhKcTFoMnRybzNYSnVpYkdGNFNFQkRwUEVBWTkwWXRzcEQ0R0hJNnM5?=
 =?utf-8?B?TjN2cXhBVWNCd0doeUp1UkJkV0pqTkxMS2VhQWZocUl3RXNXc3UwYW5xUHoz?=
 =?utf-8?B?emhLWnVjMk96QXZFWit4bFg5UWhlWVN5Mko3NlFsUFY3T0lObTVEMkhlWWdh?=
 =?utf-8?B?TXVaaVh6ekU4cUoxMXBCZlYyZldWeGpZWDRtcVNJZkUybGsyeW5SM2xnQ2gw?=
 =?utf-8?B?WXlROGtGZmJXRlpqeWNYSW5oSGVnYlpxMngzclVhTFlYSnNraXB1MFJGSG8w?=
 =?utf-8?B?aXlrQmpYRG1JWmdzbHZMVEQ3RmVTWWpXaGdhNEFLN2R6RTEwekhxWVNaaXFa?=
 =?utf-8?B?d2hHS3VlR2g0Tk0wdXdZNzZTSVpXcXdGakxtUWFIQUJUWDhCSE5mTllOL0hU?=
 =?utf-8?B?M0ZuS2ZMN3R0aEhhRmkzTUdhU2RidEdINjNRSnB6Wng3UjQzMUFjb1VBYWNo?=
 =?utf-8?B?bGJzelhlNGJTclFlVUtqMHA4T0hjZkdUbGxBRGtQUFlxbG1vdUN6cWxlZ1J4?=
 =?utf-8?B?eXV5T25RL2NObnAyaDFBS1VKS0lzMi9jbUlRak9aZmhJa3gyT1B1OVRPbjJH?=
 =?utf-8?B?M094QVpLT3RwMUhyeWVBVnltbExqYmE4NkNvS3N1UHQwdW15N3RzMlIyM05a?=
 =?utf-8?B?L0F6Lzh0OGtUQ1FhRUJoZWxkVG9hRjExWERwUS8vcHA4VGY3ZGZxODhieHh6?=
 =?utf-8?B?dkR1Nk5hT0ZSZ3ZZc244Vi93ZjNCU2R1RHNjbGJzQmpST215T1dQTi9tS3Bj?=
 =?utf-8?B?N28rNkdhU2VYaE5LdHQrWUlmQ2FmWUVVb2pFMWQ4L3hYL21MRDhydmRldDhq?=
 =?utf-8?B?bzluUDFmeUpVVjZwQWhuNFpma0w3MnZUUjU1RG9jZE9KZFRqWmlBVEFqajVX?=
 =?utf-8?B?cDZBalJidUZ1U3l6aHozd3NsSDVPbnBpeXJvSG9uWEl2S1hSQTQyRGZvSWxE?=
 =?utf-8?B?WklmRkVhcnJyZEJKT09WNWJQTUxMZEpCRmFaSE00SHhmYzlnVktDL1pBcEhz?=
 =?utf-8?B?YXdjaDNSZGNXbDRCelRHaTNNSlVFQXBsdGxnbHdTZ1I3ajArSlg3MStsWGF6?=
 =?utf-8?B?ekpYZ3M3TTV0cEIzbk1IU3lVaVd6Qk45Q0RVaHdBZmxWUytJaEhsL1ZIQzVP?=
 =?utf-8?B?SGJZNURPbWcwSmVkZjFNQXJEdHRkTjJqNmFQajRkUkNIS1lpTFg1Ly9rN016?=
 =?utf-8?B?Q1B0bUl2U1dIaGVNWi8zdXVzUUNUQ3RTRVkxWUxRMlFObTBUaG9WdVFRbFY2?=
 =?utf-8?B?TURsRklRYVpvLzJ5YlBQODVOeHFKdm02elloZXI4djdNbXkzaFJmZmY0VmRS?=
 =?utf-8?B?cUFHcFVoWEs0L01PWXZ0Qk52YU41QVlHT0JQK3RqamV1MXpVWWpMTXlMY1hL?=
 =?utf-8?B?KzltV1hSWkJaNDlOZEZwQjM0YVJKWjkrVVRMVCtPSEsvYmtQNWRDMFBGbFBN?=
 =?utf-8?B?Y3lZTzhjL3pGZm42d1RaVkpmZEdab1FLbEI0UlJFN3NEeFBENmxxOTc5K2VP?=
 =?utf-8?B?UVdSc3BMLzlhVUNQK1MySHo5K2ZQaEUvMlZXVExRWUhMR3BoVi8zczZnc0hy?=
 =?utf-8?B?aVYrYk5JRHV4aEFaZjNwc3lOczYxUnR2VGFZQ3hMdlROS3FlRWwxVjVsQVRD?=
 =?utf-8?B?dmtERWRCWGRCSFYxeGN2S0VFUEh3alJkVVBpaVNXZXF5VnkxYTdPQmVBRnRt?=
 =?utf-8?B?RU04cDYzQ2l6M2RSRkl5TmlFeFk2QUpmZHMrbVR6OTlrNENXTkJlWEIwZ0hm?=
 =?utf-8?B?bVBLZG5RL2NyOTNub3lOaDZSSS9SQ1QvTm03N1NjOEw1aU1UazJxY0l3L0VB?=
 =?utf-8?B?NjNiVEw5ZUhHM1piVnUxTXZaMld5RUZyQm1TcmVucFFZN1ZXajhmeW5HNnE1?=
 =?utf-8?B?ejVmd1BLS3NDYTI5blpyU2V1VWtPWHB4clhoUWxQbk9xWXVKdjU1ZWNackli?=
 =?utf-8?B?eE03cXhqbkNrVUYrdVlhUnFKRFNwa0xleFloT1ZiWGhNMGs2STNXYzA5VmRt?=
 =?utf-8?B?VHR5eHAxckJKbjhOaXdvUzlic2RiTHJ5ditDeThtN0xKelJzR09FSmd0Q0x4?=
 =?utf-8?B?R01OaFUxMHJ5d0I3YUdoWWtLRlJVOFAyckllMVpTNnE3bk9iSmhpMGJ1OGdh?=
 =?utf-8?Q?P2zDQ6cyuzTE/uzk2vwyc91Lv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0549ffda-c226-4be1-59c1-08dd5994bc21
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2025 14:15:50.5446 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RBe5zlaX+rzNx8syUuvU9iNVgsX8OpqtFWThd/HOWax1OgZgAkUflPiyGnkAwUEXqY2s80BV+DRKK7KKCeaoeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8895
Received-SPF: softfail client-ip=2a01:111:f403:2415::60d;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


On 19/02/2025 22:34, Maciej S. Szmigiero wrote:
> External email: Use caution opening links or attachments
>
>
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

Maybe add a sentence talking about the load thread itself first? E.g.:

Add a thread which loads the VFIO device state buffers that were 
received and via multifd.
Each VFIO device that has multifd device state transfer enabled has one 
such thread, which is created using migration core API 
qemu_loadvm_start_load_thread().

Since it's important to finish...

> Since it's important to finish loading device state transferred via the
> main migration channel (via save_live_iterate SaveVMHandler) before
> starting loading the data asynchronously transferred via multifd the thread
> doing the actual loading of the multifd transferred data is only started
> from switchover_start SaveVMHandler.
>
> switchover_start handler is called when MIG_CMD_SWITCHOVER_START
> sub-command of QEMU_VM_COMMAND is received via the main migration channel.
>
> This sub-command is only sent after all save_live_iterate data have already
> been posted so it is safe to commence loading of the multifd-transferred
> device state upon receiving it - loading of save_live_iterate data happens
> synchronously in the main migration thread (much like the processing of
> MIG_CMD_SWITCHOVER_START) so by the time MIG_CMD_SWITCHOVER_START is
> processed all the proceeding data must have already been loaded.
>
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>   hw/vfio/migration-multifd.c | 225 ++++++++++++++++++++++++++++++++++++
>   hw/vfio/migration-multifd.h |   2 +
>   hw/vfio/migration.c         |  12 ++
>   hw/vfio/trace-events        |   5 +
>   4 files changed, 244 insertions(+)
>
> diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
> index 5d5ee1393674..b3a88c062769 100644
> --- a/hw/vfio/migration-multifd.c
> +++ b/hw/vfio/migration-multifd.c
> @@ -42,8 +42,13 @@ typedef struct VFIOStateBuffer {
>   } VFIOStateBuffer;
>
>   typedef struct VFIOMultifd {
> +    QemuThread load_bufs_thread;

This can be dropped.

> +    bool load_bufs_thread_running;
> +    bool load_bufs_thread_want_exit;
> +
>       VFIOStateBuffers load_bufs;
>       QemuCond load_bufs_buffer_ready_cond;
> +    QemuCond load_bufs_thread_finished_cond;
>       QemuMutex load_bufs_mutex; /* Lock order: this lock -> BQL */
>       uint32_t load_buf_idx;
>       uint32_t load_buf_idx_last;
> @@ -179,6 +184,175 @@ bool vfio_load_state_buffer(void *opaque, char *data, size_t data_size,
>       return true;
>   }
>
> +static int vfio_load_bufs_thread_load_config(VFIODevice *vbasedev)
> +{
> +    return -EINVAL;
> +}
> +
> +static VFIOStateBuffer *vfio_load_state_buffer_get(VFIOMultifd *multifd)
> +{
> +    VFIOStateBuffer *lb;
> +    guint bufs_len;
> +
> +    bufs_len = vfio_state_buffers_size_get(&multifd->load_bufs);
> +    if (multifd->load_buf_idx >= bufs_len) {
> +        assert(multifd->load_buf_idx == bufs_len);
> +        return NULL;
> +    }
> +
> +    lb = vfio_state_buffers_at(&multifd->load_bufs,
> +                               multifd->load_buf_idx);
> +    if (!lb->is_present) {
> +        return NULL;
> +    }
> +
> +    return lb;
> +}
> +
> +static bool vfio_load_state_buffer_write(VFIODevice *vbasedev,
> +                                         VFIOStateBuffer *lb,
> +                                         Error **errp)
> +{
> +    VFIOMigration *migration = vbasedev->migration;
> +    VFIOMultifd *multifd = migration->multifd;
> +    g_autofree char *buf = NULL;
> +    char *buf_cur;
> +    size_t buf_len;
> +
> +    if (!lb->len) {
> +        return true;
> +    }
> +
> +    trace_vfio_load_state_device_buffer_load_start(vbasedev->name,
> +                                                   multifd->load_buf_idx);
> +
> +    /* lb might become re-allocated when we drop the lock */
> +    buf = g_steal_pointer(&lb->data);
> +    buf_cur = buf;
> +    buf_len = lb->len;
> +    while (buf_len > 0) {
> +        ssize_t wr_ret;
> +        int errno_save;
> +
> +        /*
> +         * Loading data to the device takes a while,
> +         * drop the lock during this process.
> +         */
> +        qemu_mutex_unlock(&multifd->load_bufs_mutex);
> +        wr_ret = write(migration->data_fd, buf_cur, buf_len);
> +        errno_save = errno;
> +        qemu_mutex_lock(&multifd->load_bufs_mutex);
> +
> +        if (wr_ret < 0) {
> +            error_setg(errp,
> +                       "writing state buffer %" PRIu32 " failed: %d",
> +                       multifd->load_buf_idx, errno_save);

Let's add vbasedev->name to the error message so we know which device 
caused the error.

> +            return false;
> +        }
> +
> +        assert(wr_ret <= buf_len);

I think this assert is redundant: we write buf_len bytes and by 
definition of write() wr_ret will be <= buf_len.

> +        buf_len -= wr_ret;
> +        buf_cur += wr_ret;
> +    }
> +
> +    trace_vfio_load_state_device_buffer_load_end(vbasedev->name,
> +                                                 multifd->load_buf_idx);
> +
> +    return true;
> +}
> +
> +static bool vfio_load_bufs_thread_want_exit(VFIOMultifd *multifd,
> +                                            bool *should_quit)
> +{
> +    return multifd->load_bufs_thread_want_exit || qatomic_read(should_quit);
> +}
> +
> +/*
> + * This thread is spawned by vfio_multifd_switchover_start() which gets
> + * called upon encountering the switchover point marker in main migration
> + * stream.
> + *
> + * It exits after either:
> + * * completing loading the remaining device state and device config, OR:
> + * * encountering some error while doing the above, OR:
> + * * being forcefully aborted by the migration core by it setting should_quit
> + *   or by vfio_load_cleanup_load_bufs_thread() setting
> + *   multifd->load_bufs_thread_want_exit.
> + */
> +static bool vfio_load_bufs_thread(void *opaque, bool *should_quit, Error **errp)
> +{
> +    VFIODevice *vbasedev = opaque;
> +    VFIOMigration *migration = vbasedev->migration;
> +    VFIOMultifd *multifd = migration->multifd;
> +    bool ret = true;
> +    int config_ret;
> +
> +    assert(multifd);
> +    QEMU_LOCK_GUARD(&multifd->load_bufs_mutex);
> +
> +    assert(multifd->load_bufs_thread_running);
> +
> +    while (true) {
> +        VFIOStateBuffer *lb;
> +
> +        /*
> +         * Always check cancellation first after the buffer_ready wait below in
> +         * case that cond was signalled by vfio_load_cleanup_load_bufs_thread().
> +         */
> +        if (vfio_load_bufs_thread_want_exit(multifd, should_quit)) {
> +            error_setg(errp, "operation cancelled");
> +            ret = false;
> +            goto ret_signal;

IIUC, if vfio_load_bufs_thread_want_exit() returns true, it means that 
some other code part already failed and set migration error, no?
If so, shouldn't we return true here? After all, vfio_load_bufs_thread 
didn't really fail, it just got signal to terminate itself.

> +        }
> +
> +        assert(multifd->load_buf_idx <= multifd->load_buf_idx_last);
> +
> +        lb = vfio_load_state_buffer_get(multifd);
> +        if (!lb) {
> +            trace_vfio_load_state_device_buffer_starved(vbasedev->name,
> +                                                        multifd->load_buf_idx);
> +            qemu_cond_wait(&multifd->load_bufs_buffer_ready_cond,
> +                           &multifd->load_bufs_mutex);
> +            continue;
> +        }
> +
> +        if (multifd->load_buf_idx == multifd->load_buf_idx_last) {
> +            break;
> +        }
> +
> +        if (multifd->load_buf_idx == 0) {
> +            trace_vfio_load_state_device_buffer_start(vbasedev->name);
> +        }
> +
> +        if (!vfio_load_state_buffer_write(vbasedev, lb, errp)) {
> +            ret = false;
> +            goto ret_signal;
> +        }
> +
> +        if (multifd->load_buf_idx == multifd->load_buf_idx_last - 1) {
> +            trace_vfio_load_state_device_buffer_end(vbasedev->name);
> +        }
> +
> +        multifd->load_buf_idx++;
> +    }
> +
> +    config_ret = vfio_load_bufs_thread_load_config(vbasedev);
> +    if (config_ret) {
> +        error_setg(errp, "load config state failed: %d", config_ret);

Let's add vbasedev->name to the error message so we know which device 
caused the error.

> +        ret = false;
> +    }
> +
> +ret_signal:
> +    /*
> +     * Notify possibly waiting vfio_load_cleanup_load_bufs_thread() that
> +     * this thread is exiting.
> +     */
> +    multifd->load_bufs_thread_running = false;
> +    qemu_cond_signal(&multifd->load_bufs_thread_finished_cond);
> +
> +    return ret;
> +}
> +
>   VFIOMultifd *vfio_multifd_new(void)
>   {
>       VFIOMultifd *multifd = g_new(VFIOMultifd, 1);
> @@ -191,11 +365,42 @@ VFIOMultifd *vfio_multifd_new(void)
>       multifd->load_buf_idx_last = UINT32_MAX;
>       qemu_cond_init(&multifd->load_bufs_buffer_ready_cond);
>
> +    multifd->load_bufs_thread_running = false;
> +    multifd->load_bufs_thread_want_exit = false;
> +    qemu_cond_init(&multifd->load_bufs_thread_finished_cond);
> +
>       return multifd;
>   }
>
> +/*
> + * Terminates vfio_load_bufs_thread by setting
> + * multifd->load_bufs_thread_want_exit and signalling all the conditions
> + * the thread could be blocked on.
> + *
> + * Waits for the thread to signal that it had finished.
> + */
> +static void vfio_load_cleanup_load_bufs_thread(VFIOMultifd *multifd)
> +{
> +    /* The lock order is load_bufs_mutex -> BQL so unlock BQL here first */
> +    bql_unlock();
> +    WITH_QEMU_LOCK_GUARD(&multifd->load_bufs_mutex) {
> +        while (multifd->load_bufs_thread_running) {
> +            multifd->load_bufs_thread_want_exit = true;
> +
> +            qemu_cond_signal(&multifd->load_bufs_buffer_ready_cond);
> +            qemu_cond_wait(&multifd->load_bufs_thread_finished_cond,
> +                           &multifd->load_bufs_mutex);
> +        }
> +    }
> +    bql_lock();
> +}
> +
>   void vfio_multifd_free(VFIOMultifd *multifd)
>   {
> +    vfio_load_cleanup_load_bufs_thread(multifd);
> +
> +    qemu_cond_destroy(&multifd->load_bufs_thread_finished_cond);
> +    vfio_state_buffers_destroy(&multifd->load_bufs);

vfio_state_buffers_destroy(&multifd->load_bufs); belongs to patch #26, no?

Thanks.

>       qemu_cond_destroy(&multifd->load_bufs_buffer_ready_cond);
>       qemu_mutex_destroy(&multifd->load_bufs_mutex);
>
> @@ -225,3 +430,23 @@ bool vfio_multifd_transfer_setup(VFIODevice *vbasedev, Error **errp)
>
>       return true;
>   }
> +
> +int vfio_multifd_switchover_start(VFIODevice *vbasedev)
> +{
> +    VFIOMigration *migration = vbasedev->migration;
> +    VFIOMultifd *multifd = migration->multifd;
> +
> +    assert(multifd);
> +
> +    /* The lock order is load_bufs_mutex -> BQL so unlock BQL here first */
> +    bql_unlock();
> +    WITH_QEMU_LOCK_GUARD(&multifd->load_bufs_mutex) {
> +        assert(!multifd->load_bufs_thread_running);
> +        multifd->load_bufs_thread_running = true;
> +    }
> +    bql_lock();
> +
> +    qemu_loadvm_start_load_thread(vfio_load_bufs_thread, vbasedev);
> +
> +    return 0;
> +}
> diff --git a/hw/vfio/migration-multifd.h b/hw/vfio/migration-multifd.h
> index d5ab7d6f85f5..09cbb437d9d1 100644
> --- a/hw/vfio/migration-multifd.h
> +++ b/hw/vfio/migration-multifd.h
> @@ -25,4 +25,6 @@ bool vfio_multifd_transfer_setup(VFIODevice *vbasedev, Error **errp);
>   bool vfio_load_state_buffer(void *opaque, char *data, size_t data_size,
>                               Error **errp);
>
> +int vfio_multifd_switchover_start(VFIODevice *vbasedev);
> +
>   #endif
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index abaf4d08d4a9..85f54cb22df2 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -793,6 +793,17 @@ static bool vfio_switchover_ack_needed(void *opaque)
>       return vfio_precopy_supported(vbasedev);
>   }
>
> +static int vfio_switchover_start(void *opaque)
> +{
> +    VFIODevice *vbasedev = opaque;
> +
> +    if (vfio_multifd_transfer_enabled(vbasedev)) {
> +        return vfio_multifd_switchover_start(vbasedev);
> +    }
> +
> +    return 0;
> +}
> +
>   static const SaveVMHandlers savevm_vfio_handlers = {
>       .save_prepare = vfio_save_prepare,
>       .save_setup = vfio_save_setup,
> @@ -808,6 +819,7 @@ static const SaveVMHandlers savevm_vfio_handlers = {
>       .load_state = vfio_load_state,
>       .load_state_buffer = vfio_load_state_buffer,
>       .switchover_ack_needed = vfio_switchover_ack_needed,
> +    .switchover_start = vfio_switchover_start,
>   };
>
>   /* ---------------------------------------------------------------------- */
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 042a3dc54a33..418b378ebd29 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -154,6 +154,11 @@ vfio_load_device_config_state_end(const char *name) " (%s)"
>   vfio_load_state(const char *name, uint64_t data) " (%s) data 0x%"PRIx64
>   vfio_load_state_device_data(const char *name, uint64_t data_size, int ret) " (%s) size %"PRIu64" ret %d"
>   vfio_load_state_device_buffer_incoming(const char *name, uint32_t idx) " (%s) idx %"PRIu32
> +vfio_load_state_device_buffer_start(const char *name) " (%s)"
> +vfio_load_state_device_buffer_starved(const char *name, uint32_t idx) " (%s) idx %"PRIu32
> +vfio_load_state_device_buffer_load_start(const char *name, uint32_t idx) " (%s) idx %"PRIu32
> +vfio_load_state_device_buffer_load_end(const char *name, uint32_t idx) " (%s) idx %"PRIu32
> +vfio_load_state_device_buffer_end(const char *name) " (%s)"
>   vfio_migration_realize(const char *name) " (%s)"
>   vfio_migration_set_device_state(const char *name, const char *state) " (%s) state %s"
>   vfio_migration_set_state(const char *name, const char *new_state, const char *recover_state) " (%s) new state %s, recover state %s"

