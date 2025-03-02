Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52121C19F32
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Mar 2025 14:19:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tokAO-0005B1-3E; Sun, 02 Mar 2025 09:19:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tokAF-000510-U2
 for qemu-devel@nongnu.org; Sun, 02 Mar 2025 09:19:35 -0500
Received: from mail-bn8nam11on2061c.outbound.protection.outlook.com
 ([2a01:111:f403:2414::61c]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tokA5-0001LD-Ss
 for qemu-devel@nongnu.org; Sun, 02 Mar 2025 09:19:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N1NZFuLJ9PsUDLna8ZQgbQkIjyjQueW8k3tWwGAWXG58lyD2A4W/4kyI9jI7PYqbhYDbpym5dhXlS6UE5x52DjE84vrHyETWIskkNP7bH+2rAXGcwX98mu0hs61uKYXT69vpf/NumnVuwkfPyqAcpDGARhBEY7lN0OcKLjq6/Hc78OJgaVOtkr4rZpDZr2MURrP2mlpNk5m9wnDNozLCZKLZFcWqkM4lHeKqi1ngGEhWU+fTtjVPFdkF8KjqGNBr8vJON/Mb926KEHgSMzILM+iYAx+0gVwXsLb6be9BDLqQ3rk60U86zYrpc5CS0pQwH6XpZVvOxF40E0BbWMrtQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5H8j1SRPl82nlJF8yQO+MuGzXpFESDJopzpsG94LQvs=;
 b=iJDeySy8e1tqthA0yiuPUJ4xRPiUIVkwWFMwIPApsW6wIDo/6n5I+3TPRAwRBvgnsNowASOSehnI5Gc8JwRmwq6ZQlOy6cWKyGpCGUZ7nH6XjQQFlvRT19kOw8dO8hWuX0hDlbmEFn9tS62jnEOqSWUYQ8DnAeNU5G0A1C45TxiwCqhZwsY60nChE6rkCMEcUsgJEHhnTBPAlrdTSZNMpUGYpIVaGJq4/SQA0wJWvTSphbScSidgL8ixc5IdCAv2cH+IUCl15kP8ZGoGtEN84GvgGrxs5sEWNJbSqEYHlKi9U2GP7wNRp+rKlaeRTgYEvNEtaXmTVdXEY8TS8Yg+pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5H8j1SRPl82nlJF8yQO+MuGzXpFESDJopzpsG94LQvs=;
 b=cHKvZ6kbXeurK9mKa50RHWwi7Azz9jBboETU5iu3hw9BwEeOOxbFveQUHUIAO7jt50k0S/u8TAR7miVUkbImDdaNGRokwi7AGS6TXE4JQZAYPj/OYhNtm3rFNQneOSxfDwswKTcuqDN/QuU4koeeyUGVzN4czFbJgxIx6LB9J7zBJAE1uhyv2mnCZs0xJb5kO92YcqMSLxgyl/x8uGQXOCqt7JMy8ckj4HKeeBjB0B64ZOtZ0ZhlX5/J83OwVohTiBkbm/OIe5Hb2ulRhedOeNLhk5XgdR2CCYUfEFqzv4L1mtNgkVhni5Sp/PvvyWILOQ98xb0ruwM/XR0qV4j7ZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by IA0PR12MB8895.namprd12.prod.outlook.com (2603:10b6:208:491::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Sun, 2 Mar
 2025 14:19:16 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%6]) with mapi id 15.20.8489.025; Sun, 2 Mar 2025
 14:19:16 +0000
Message-ID: <4d6d6a25-74c3-427c-983a-c3c1579fdbb6@nvidia.com>
Date: Sun, 2 Mar 2025 16:19:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 27/36] vfio/migration: Multifd device state transfer
 support - load thread
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1739994627.git.maciej.szmigiero@oracle.com>
 <9be8882ea2189c1a827bdf09835d6c65488d2ca6.1739994627.git.maciej.szmigiero@oracle.com>
 <573fab5e-4c0f-416c-bbd0-4786ad25e18f@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <573fab5e-4c0f-416c-bbd0-4786ad25e18f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0081.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::11) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|IA0PR12MB8895:EE_
X-MS-Office365-Filtering-Correlation-Id: 379fcc6e-7b4d-4dab-9bee-08dd599536f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K1drQjdrNSs0cFFXYWhQS3BydDNUamlTT0J4aytRTGF3YlBwSm5aTDVNdnF2?=
 =?utf-8?B?YitzaHB4MkRST0IwU0svaVcxRG0rWXpsamcxWG04ZjdXZkVwcElTUmI3aFE2?=
 =?utf-8?B?ZG1haFg4NzlzZURzZWxmNkF5UTMyZDJTWFF2VldlWmpNRWRhNDR4S0xQUFhV?=
 =?utf-8?B?Yzc2bk5JZUV2WUpncXpkcmdCczZBbW04VnljdCtPbUVhVldWUno1NDFGQjZO?=
 =?utf-8?B?SElyNTJkZkRxZWM5VG5qbVhpdHJNNFREQjFkODJKY2xZSk5hOWt4dFlIOFZx?=
 =?utf-8?B?elhVUU5yb3NmdHh2c2t5OGxpWkZ1Wkk4TTJTMkg4SzA0czk1b0xSSzgwSjV4?=
 =?utf-8?B?RWxoNlRwbkRERDFZaFRVUGc3Z1JVMDhkMnFMRUhRUVQwL1ZnWnB3V3lHL1hi?=
 =?utf-8?B?UC8yV0o4WnJZbWdJUHRtYTB3SHB4MFVib0JtNjQ4WDdXekREMmgrWXJtV1Zn?=
 =?utf-8?B?bjdhQVBIWlNMOWlzT3pFeG1pRWpNT1ZWUUdsUnNQQ2xhWkxLTkdDL0dyd2I2?=
 =?utf-8?B?aXE2Vmk4MGcxWFgvSm44WmhKcjNNQ3dnSmZSUWdYYjJFL2lFZ01yWldScmE3?=
 =?utf-8?B?RnZ1UUVvcXV4OHFsMEd5L25YQmgwTXMvTXgwU29ydjd4ODVMRVlVK09OR1pP?=
 =?utf-8?B?Sy96em1ZaGlxblozRDVIUXBEZVlYcS8ra2xGRlNXL1ptSVlPazUxTDR0RkIw?=
 =?utf-8?B?cmJ6U1hpZWFJeWd2bkM3WUF2dWJDR0xXdk5CcHJ6MkRkdWpBSDZFZFJROVFR?=
 =?utf-8?B?aTNlR2MyRENnd3hlb2Zaei92emMreGpaNmMvQjVSZzBZSW1WSXlTSnpmZzla?=
 =?utf-8?B?Qk8wOGVvcmQxL3BHay9lWVRneVlnUXVKM3RPVDB6OVpXWkc5YU91aEZteGZr?=
 =?utf-8?B?UzJxaytHK2ZUMExmVW1yY3RSaGgzclRSdklWdWw2MXRRM3dLcnBGTHYvd2l3?=
 =?utf-8?B?WWo5SXI5VUl5NTZqMSt5YW9QZHVTTC9melFTUkJnRVRzY0g1OWJsS1JLMjZw?=
 =?utf-8?B?SDFubVNQWXlDNm9teDFndTlXd1BjRUpyTkpqem1pelFHaUlnWkl5WUhDbXBz?=
 =?utf-8?B?S0xNeEVqSzcxV25ocXBDR3BFUjV1NlNvVkxxMTQ5dGpMV2tnRzBYMHhnekRX?=
 =?utf-8?B?SE05NElsaEE3MkZ2SzV1cXR6cDZtdVNNVVNzQndXL2l1blpXT2JTR1RTajVJ?=
 =?utf-8?B?Z2ZvK3I0MUduclR0OVpqRFAxVU41TTdaQ3FRWUEyVlNEOWNBblJSMStVREIy?=
 =?utf-8?B?a09oL3l2cWJ4K3VLRXFNSkFXUWQwb1lsVHc4bWlWbkN3WDFVOEpzWkpLT2Ir?=
 =?utf-8?B?SXdKTUpSMFdiUmZRUWVEU2FtWlBhRi9QdmtSSVBqa09aOEtTL0ZOOGdxMSt3?=
 =?utf-8?B?OG5CM1JsSGNEYjAxMkhMV05qMVVJeVk3bUVabmQ5M2FVMk5WYVhYZFRldVZI?=
 =?utf-8?B?ZkJGQlNKQVh0QjJXeDBmWDFML3V2Wi8zbmJMWUlhVE12OFA2OTlUbVZhZUw5?=
 =?utf-8?B?elpPdUVlNjM1WGszZmM3SjdJVUlXaTkzaUlWYm9YSmtnRW9VS3NBTDY1Q0ZY?=
 =?utf-8?B?SHBISkQ3aHBJY3M1WUxKd1pDb0lwQldIbS81cnAxQXM2U2x5OU1sRjhlVWlL?=
 =?utf-8?B?L051amg2dVpDTWQ5aCtINlhFNTVrZ1FtK0tnN01BL1lzT2s1R2VoVFh3Y0ZY?=
 =?utf-8?B?eGNJc1puakh4TE4rZUpLOTBzNjZhUER0MzE0b1lNdEpLa0RneXBWSTM0M3Bq?=
 =?utf-8?B?SnZ4R01MK0tJdEk2Ykd2N3NibHZXYkpNb0RyTGFYZGxSdmo2SzZNZ3JHeDZi?=
 =?utf-8?B?SCtLWUVTam80VjVlVGRmUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmI1alVaNHVRVEhXQmtoYlp0TnNRUDhzUXppNFptQ3BhVDFDUFpDZGxyYTdD?=
 =?utf-8?B?eTljbmxQQkZYSTI4YVNIN2NkcmQyMkxZcHllS25Edys1WllDNDFxL0xpVTZt?=
 =?utf-8?B?NHk2N0ZsZU13NFhhek84YS9yQ2F4bGhjNkZKWFFFSWwzcmxqdUo4cFJ3QnRq?=
 =?utf-8?B?KytKVHFQMmM4Y0xKd200N0tDSVBpam1FcGVvbjUvM1ZHV2RYRnM4ckNIbXl0?=
 =?utf-8?B?aHVWZ3MxRENrTDZaVUJIVmtqOTBjK2xMQS9QNWp5ZkdiUVZLUURrMXBzQ2NS?=
 =?utf-8?B?MTM3SjIyN2hLODFNSmFHTU1LbFpEd0RkK0E0U3h6S1p3eGJNQ2JlRWM4MDVh?=
 =?utf-8?B?aUpvWWRXNENSa201QkpyWUc2bzF5UUsyUW9hQWFUK3RrSnpNQ2o3dEs0RlhI?=
 =?utf-8?B?aFFjM2c1Q0V2NWlrVmhmTDlHREFpemZOSUY1MVFyYmFzWlNabkZ0dkhlUzlN?=
 =?utf-8?B?M1pPWTJnUCtHdjNhbllTOFYzbWs3b0kwVklONGVRU2xmOThIWDJZc3RsVUNq?=
 =?utf-8?B?b2Nja2w4YlNENTFhWWNRMm0rVkdQTFVSRkdLTVplUlp6OFBqRHdFUTBHbHFi?=
 =?utf-8?B?UUV0RVdRdEJFRUZTOGNtK1Nodm9iTUF6eVhMOGx4bUpHbGZURExFVGhJOTZ3?=
 =?utf-8?B?UWYxRTRJTFkyR2k3NWpsU3YvbEVuTUtCWjFTZ0NBRVFZRlp3QTFFcnFBSzNa?=
 =?utf-8?B?TlBlWHFwZHlFYWgwWk5DVFV1Z2s2dHhxT2FoTW0vcGNtekFObGdaSGJHOFhZ?=
 =?utf-8?B?TTJFUjZwNjdaTU9hekF2RWRKMm5sOGM5Z05BMzRlMkx4N0FJRmNIZzg0dHVz?=
 =?utf-8?B?ZUcwWFB6aVdRSXFCTk5FU2djYkJPK01FajhwN1I0cmVKdEVqaXR0YWkwdW4r?=
 =?utf-8?B?Z1I4Z3R3L0ZDeGpic0tpdUQzWmg5V01RU0dkenZEcDlCaThMSG14V1BZdEQw?=
 =?utf-8?B?UTVvZStKY3ZES3BqcmhwcmppQm5Demo2eGFhTHB5bzV2ci95L2ZPUU56RGpG?=
 =?utf-8?B?Y21KcURKVXpiaStsdWdRTGEvTjRvS2loS1UyaG5JRWFUMXV6Sis4aWJsNC9x?=
 =?utf-8?B?QzdScXc3dmFRZXVYelV2R2RVZ2JsbTA3dXRKVlRvTGhrN0l2dmRTM0kxbXRR?=
 =?utf-8?B?YUhmOEFaYTFiSkZMS1ByQXNkVndnb2loR2ovdHFqa0RDUldKeHcyZUxPZHhh?=
 =?utf-8?B?QXJjL01uK2Zub2NBdmozRjhrWW95L2VwakYzQjZzcWdZdmNjRzdWNi82dE1C?=
 =?utf-8?B?QTRsVDYvekE1V0Z1bVoyMHcwL0Y4OTFYbGNLV1NWV1ozNDlyTk1RMWpvRkJX?=
 =?utf-8?B?bk1sQWVzZWE4VmNjclQwZmZBR0xqdmNNa1U4UXluT1J4U2k3QWUrMTBnZjZX?=
 =?utf-8?B?Sk05S1ltNUZxUHVtc1grVEZoODFiRTFZSjQ1bGIycktrWlNqNlBad2I5azlN?=
 =?utf-8?B?eU5Qd1FIQ0dNZEpmNTBkRG1YR2syQkF0OVBTOW80NFhSdUlGdjF5SDNoZVdF?=
 =?utf-8?B?L05DNlJRWlo4RFhSMmFvbGNVL0VBbisydnA2cU8xSkExdEhwRS9sODQ5VmNX?=
 =?utf-8?B?UDJ6azJpK094MnY2VktQVDlMU2lDTks2K216VEJOMmgrTUlVb1ZGeGI3bVBL?=
 =?utf-8?B?aDBHVWczRU5rcXUxczlXc1JNYVc1Qk93akZIYXo2cHBBdm9BRTBNcTIxcnhI?=
 =?utf-8?B?NHBjc2JFdFFoYVQ3YSsyVzV4bmNhQWEvNzhCWndOM2paWm9oM0NRMngxVlRD?=
 =?utf-8?B?dzRyd3J1aUdNSTlLMGo5TkhzaUJsNDdjOGtrcnMwMU9pQzJXT2lUQ0duamI5?=
 =?utf-8?B?OTJGalJrVitvUS9kVENmVm83TDVJZVRIRWM3VFo0UmYrbCtiNGxBOGF2N2Vk?=
 =?utf-8?B?cWwwV28reG03RHJhVTg1QmRzclhkaWE1bC9BUmxSZ0FKcm9MWVhwYkkyeisx?=
 =?utf-8?B?V0pMVEJYSSt5WkkrUkJQMUQySW9xalBEL1BHMktMRUhNVE9WdXhqbDFoaGJa?=
 =?utf-8?B?VGQ3UGEyNXNmWW5YRXhsSzYzWUNoQUxIV08xLzBkN3JNV2YyamluV3lrWVRz?=
 =?utf-8?B?R3V3Wk9oRHZNRGUzLzJUU00wNmFqUDdUbE1jUnc2YkREWXZ5VU82bG5iUDhh?=
 =?utf-8?Q?eiVixkR2GYkBgaBA3FN9PhhwB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 379fcc6e-7b4d-4dab-9bee-08dd599536f3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2025 14:19:16.5744 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M50piHoaXYa8N2LcPAzUTpLigfZ8fc/WOQ3YJBQsViXvFMboWhVAFvHw2YDHwD3bSTDUxzJF+6EOaNZm/tNqAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8895
Received-SPF: softfail client-ip=2a01:111:f403:2414::61c;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
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


On 26/02/2025 15:49, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> On 2/19/25 21:34, Maciej S. Szmigiero wrote:
>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>
>> Since it's important to finish loading device state transferred via the
>> main migration channel (via save_live_iterate SaveVMHandler) before
>> starting loading the data asynchronously transferred via multifd the 
>> thread
>> doing the actual loading of the multifd transferred data is only started
>> from switchover_start SaveVMHandler.
>>
>> switchover_start handler is called when MIG_CMD_SWITCHOVER_START
>> sub-command of QEMU_VM_COMMAND is received via the main migration 
>> channel.
>>
>> This sub-command is only sent after all save_live_iterate data have 
>> already
>> been posted so it is safe to commence loading of the multifd-transferred
>> device state upon receiving it - loading of save_live_iterate data 
>> happens
>> synchronously in the main migration thread (much like the processing of
>> MIG_CMD_SWITCHOVER_START) so by the time MIG_CMD_SWITCHOVER_START is
>> processed all the proceeding data must have already been loaded.
>>
>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>> ---
>>   hw/vfio/migration-multifd.c | 225 ++++++++++++++++++++++++++++++++++++
>>   hw/vfio/migration-multifd.h |   2 +
>>   hw/vfio/migration.c         |  12 ++
>>   hw/vfio/trace-events        |   5 +
>>   4 files changed, 244 insertions(+)
>>
>> diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
>> index 5d5ee1393674..b3a88c062769 100644
>> --- a/hw/vfio/migration-multifd.c
>> +++ b/hw/vfio/migration-multifd.c
>> @@ -42,8 +42,13 @@ typedef struct VFIOStateBuffer {
>>   } VFIOStateBuffer;
>>
>>   typedef struct VFIOMultifd {
>> +    QemuThread load_bufs_thread;
>> +    bool load_bufs_thread_running;
>> +    bool load_bufs_thread_want_exit;
>> +
>>       VFIOStateBuffers load_bufs;
>>       QemuCond load_bufs_buffer_ready_cond;
>> +    QemuCond load_bufs_thread_finished_cond;
>>       QemuMutex load_bufs_mutex; /* Lock order: this lock -> BQL */
>>       uint32_t load_buf_idx;
>>       uint32_t load_buf_idx_last;
>> @@ -179,6 +184,175 @@ bool vfio_load_state_buffer(void *opaque, char 
>> *data, size_t data_size,
>>       return true;
>>   }
>>
>> +static int vfio_load_bufs_thread_load_config(VFIODevice *vbasedev)
>> +{
>> +    return -EINVAL;
>> +}
>
>
> please move to next patch.
>
>> +static VFIOStateBuffer *vfio_load_state_buffer_get(VFIOMultifd 
>> *multifd)
>> +{
>> +    VFIOStateBuffer *lb;
>> +    guint bufs_len;
>
> guint:  I guess it's ok to use here. It is not common practice in VFIO.

Glib documentation says that in new code unsigned int is preferred over 
guint [1].

Thanks.

[1] https://docs.gtk.org/glib/types.html#guint


