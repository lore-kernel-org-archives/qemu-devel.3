Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23492C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 09:22:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubbrS-0001Ol-LN; Tue, 15 Jul 2025 05:22:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1ubbqw-0001Aw-Hi; Tue, 15 Jul 2025 05:21:38 -0400
Received: from mail-co1nam11on2061b.outbound.protection.outlook.com
 ([2a01:111:f403:2416::61b]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1ubbqs-00020C-Id; Tue, 15 Jul 2025 05:21:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ReWcmDMSLsCCC4gYb7P/5we4WtzSnD4aPaV1L4ETqBAkaCYW6eHKagwBVGTuS1pbW9c6fDgiA1G3rtphSGTAH6kqYm9IwdAmCnKPJSShK1J22Z+72o3taN9PG+TqV5V1JWmR1lQUd+8dRy790AvfB7VIV+nCsx0GKUTU8UQLd8QmTCMkQvp4pUHI7AEzmHMkiR7LPwvUompoPzeYXXM2c4Z5GkC5rRqB/JTRAtKYFZoMFEmieOrHver6ZsakNdTtAAsfz1lTjrpQ/uax3iWK4xh25s16LGF7dAUVorfsB6Aic0zl+M7hqZfnVV3yCKNvquscvygY61C0U/pGpfwy+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FoiVQ+IteSYRNa6sFzOnqikQ73AaWUrKLy8faE8QnyM=;
 b=O/M1qezdI4YchxsnKlIC1Kth7kfa4p9BPmf13Ve/aeBNpjx5/fcUVG643zcFKTwuI7cIQXuU6dJCRibasw7/4Z9aLdCDKLu/8AZGXZ0Zef8DICSo4mJXX+EBI9/rdLd2x7KiCaT/X5KUMoDVJmMkrn9b3ewqalIkp2WWlBUS7l8w67W2G4+5buKEntYszUbCvbfSFe48Ol/Z6PaPi+STIF3MzgElug6HYyk6eLJWNI7EIM+xYqFnCVLKuqEGmRYqqDmpoSt2F6AOoeUlwfxtYl3qaIno8K000MGBZZfNeBJlS/alOTQaXjlDo/kgfnq2bge2eBqLMD4RKbUyrESTNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FoiVQ+IteSYRNa6sFzOnqikQ73AaWUrKLy8faE8QnyM=;
 b=dkpQfLJ/1Xkqpn6ovqYozkfi8n88rkQOlp6N4gd/smddDBWcK1VKdkqo57dhFY0YVFJNOY2/w4XG4qYRDuaXnLigP+i8rlJP9B0rcIQWZRlhCyfltWBzJxBUZgY/RKzUFBcqXfdQymI8+t+iLuWq61KJ8bF1qxID6fnkxITxYE3d1ZL9yhJFmwNTZ4JGCDuOlP3SFfpqiio4mJEZSN2kYi6/fc7ntkDhYX5MCSuTaSMNHJ7iMcclueU/I1fXChEZPENRtkrJAOltg97G+dSw9od3nmpA7jsx20f/iiK2PFErJOTj/WiFwxSoF2rhyyinFQWl5jiDKx4D6bQvEaLubw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by CY5PR12MB6597.namprd12.prod.outlook.com (2603:10b6:930:43::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 15 Jul
 2025 09:21:23 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%6]) with mapi id 15.20.8901.021; Tue, 15 Jul 2025
 09:21:22 +0000
Message-ID: <714ba0a6-b620-49bc-bfe7-ed42b816df33@nvidia.com>
Date: Tue, 15 Jul 2025 12:21:15 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] vfio/migration: Add
 x-migration-load-config-after-iter VFIO property
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Alex Williamson <alex.williamson@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <cover.1750787338.git.maciej.szmigiero@oracle.com>
 <22e94f25448f9ff42b84c84df3960c4ecc94cbdc.1750787338.git.maciej.szmigiero@oracle.com>
 <6b85f85b-51e5-4e6e-9c78-788d9118ad9d@nvidia.com>
 <66037870-933f-4164-978e-3b92fa76b508@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <66037870-933f-4164-978e-3b92fa76b508@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0030.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::16) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|CY5PR12MB6597:EE_
X-MS-Office365-Filtering-Correlation-Id: c41bc6c9-9dd3-4a42-dfb5-08ddc380f70f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WCtSWmtUZ01TNlRUeEhmdldmWG94cDZDcmVON293S09CckhkQjlqVTR1aVZ5?=
 =?utf-8?B?cFBndWJ0RTZPRmhBd2lCYjA0Wk1WQVRmVXU1bnZRZmdXMkJVcGMyTEg4OEVE?=
 =?utf-8?B?ZDcvZ2lYWkhhMTN3eENZcmU3eUFKTUppc08rbFNoTGhCVENxVW1PQnNqcU1Z?=
 =?utf-8?B?cy82MW1OTEJVNy96YVExQ1hMem1ZSTNtRHNqOVRzYVV4a3FERWtmOTNsMi9Y?=
 =?utf-8?B?cGxnL09LYzFxMlZ3ZlAwbjhlNTZzUjR2c1NBL2QzR2k5SDNPMVJRd0dzVUVN?=
 =?utf-8?B?MlNlODdWakhJWXhSdDdZdlgyK2E2YnVHMDg2bHJrQ0RhNnFsOXpJUlhUYktL?=
 =?utf-8?B?ZGdvUmlHM1MvM3J4UDRaK2R4dk5mTDZzZ05icXo0R2pvWG5xNG9KRGdabHU2?=
 =?utf-8?B?TXNJd3J3V3BHdW5tdXpaR3FGenI3UTJFaUhGYWxSUjY3b3VkOTQzOERKTlNo?=
 =?utf-8?B?em1LVU4yd1RSTTFGMGVaZVk2NTBBZ1ljU0pJd3YydDUvbkxoWEdYVC9Hc2xy?=
 =?utf-8?B?cHM1bXc4N2hsemllY1A4c2lENGJhMS9CZFE5Y2ZzbXBYWHNGR3hBeU93enkv?=
 =?utf-8?B?TEs2VmNIcU0wbk1ra1hLMWFTRUFVMTRZcTBUT0hXMVdISklqT0hxbnVKV2lR?=
 =?utf-8?B?bkc1UXFFcm1GWTI5ZXBPSHRnb244ZWNoMVk4Yng5bmxROVlmQUV4TjAvRHpD?=
 =?utf-8?B?cGh2T2pHT3JDV0pZeHFGSXFjb1ZLSlZRc0hSd2pjUWp1ZEludGtyTk1xZHFI?=
 =?utf-8?B?UnB1M3lMMTV1MG41UzlSNGdsWkdDN0VPTmF1cENWRUhneXNYWFZmbDdpd2Ev?=
 =?utf-8?B?RVJMWmtMQjZtK3NTU0FlUFl3VHZqdHozbHMwUnVVY2NHdFVwNlhadW82dmtH?=
 =?utf-8?B?MVpiWXArMTlMbVI0Tlh5b3dGSk1tQjRoaEJLWTk4R2oyWjV4K2JoSDdyN05Z?=
 =?utf-8?B?SWdnRUp4UUQxY3Z5eVljaDR2UkF5ZE1NS0NyMjZwM3Y0OEpmQ0dUTk04QTBL?=
 =?utf-8?B?NTAxQ1dROVdxU2Q5N0Q1Smd3UXcyWmJmOExqWDhHYTFzVjZSbVZtcVlTNWhv?=
 =?utf-8?B?cTIybExOemVrbTFGVjhYdUpuV3RrWENsTXNxdElnOWovTHphZC9pZDBCc3p1?=
 =?utf-8?B?OEtUKzM2bzZLSHZvaU1oNit6NDdPSkxnbVIwdGttMzZ1NWVQWjhHYVMwWElq?=
 =?utf-8?B?dUdjNmxiNXRjRGJudUhkOU9TaG41djFZbUx6Sm9tT2RwN2I5UXNLeWtEeXlX?=
 =?utf-8?B?UzJWMCtFdU02Y1h0UXkvVGpONnIrTFJtczZLemFud0VwdUdQZ0ZmRG9WR1g1?=
 =?utf-8?B?RzkvTGdZZjZvWEVJOFJvVXNua2ZvNGFiaEZhN0NVSXhyYUtSL3l0d2ZvNXNU?=
 =?utf-8?B?YzMrMGtWU3o5alRQSmIwRTJSYXBCMXJaQkJGdXArNXR1UUUwZkY3cWF3WnE0?=
 =?utf-8?B?T3dycjQxQjJoYTZNL1JzUC81SjZvMGx3eXNvMThRcEY2aFRlYk42ZlIvWG9M?=
 =?utf-8?B?UTZoNmpDOG9nREpyY1dFYk9VWUtCVE9wUVJFMWNLbmVMdTFXMmRaeFBRQzJR?=
 =?utf-8?B?MFovYlNRMSt3UXJpT3BYVm9RREw0LzF3ZWw0RWRGM3hjSGN2c2F5WFUzNHBV?=
 =?utf-8?B?NytIbjJQYmEwNUV0dEJFTmhlZE5ndGlhQmRRWndlQi8wcUp0MGM4NGNkeE9s?=
 =?utf-8?B?TXoxLzRCMitxMC8vZEpmemFFN0o4N1gwNHFvRE55TDgvOG5ucGlPNHhMZ2Np?=
 =?utf-8?B?cnA2dVV2dnpnK0gzS2hNOXM2b1I0aWVGbjh0Zk5WeUZGT1FYTWI4QWc5OE9w?=
 =?utf-8?B?RFVtSWd3SDhaZHZ4eDB6TXpGOUFMU1RZTWlFa2F2a2tYaG9CVlhmKzBMcURG?=
 =?utf-8?B?cDFpeDAwYnBKbVUxWDRYalRYTm9Db1cvbUliaTA5MWtuK2ZlMWlJa1FWa3h6?=
 =?utf-8?Q?RnXan9/LYyc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWZKZVZCRjAxbHdVUHk5T0FUcDZZdyt1TGtpVkpmc3oyQU4rY0QxVmg2ZzBD?=
 =?utf-8?B?d0hVbjZQc0g1eUpoZStNa253MHNnclJGcmsxdy9JQmhiRE5VakFHaDVBTXJJ?=
 =?utf-8?B?dkRlbUlLNG5QMWN3UE42V2NLRXBLbnVnSEozbUJZQ2pKQkVKNHB0ZXNhQXJ4?=
 =?utf-8?B?aDcxdkJVWWRvWmFkbWY0TzR6YWZKVGxRZHM5NDA0eTM3UFIxejVpMzY4U3BN?=
 =?utf-8?B?S0cya0l3bENaSmRSUTl1TVdpNVd1UWJDaVp1SnRreXdZdmhrc0VFK0R6OStT?=
 =?utf-8?B?Z2IvTVpsUW8rWnFKWGJzZm9iVzBxQ1hiZ3ViVUM5ZlBrZHpXSWZSY04vbW9H?=
 =?utf-8?B?Z25vd0F2TzdiVWhYQUFENXZUaDhDODNzZHZMNlMvSDZGRDN2MUxVby8zM2hr?=
 =?utf-8?B?TXV3bnN0MisyTjNpYjJoSGNadHg5QjNuTHpQZDNMei9VaTdRRXRyOE9UTWoy?=
 =?utf-8?B?dmtmQ0lOWWIvcklGMmwzYUVsdE9lNEY3eTdUL1pubXNQcnR5UEhVZHJQR2lP?=
 =?utf-8?B?bnNQTjVGYWhHU1BXTDNqdnZJNzBvOWVNUXdpTWdnR1M0TU1sWTgvLzRLSkNV?=
 =?utf-8?B?NEJYNnlpWXRjb3FOUUtNKzZTczJLWm9WUDBiVWJZUUw1REwzWDhqL2U5Snh6?=
 =?utf-8?B?T3lYeU5CWVBOYURzT0VWVjBkWFl1cDFsTGpOeUpFYzlaS2I2WU9sR1B4YW04?=
 =?utf-8?B?VXl3b3V0bEx4TXUrTnd0QngxRGtqeDV1ZmM5SThBeUNXdHZraXcxSzNzbXVX?=
 =?utf-8?B?OTQ5V21SWndPd2d6WVpYQ1h0cDFGQk9Ya0VZMEk5S3lOc0NBM1hHT20xaXIr?=
 =?utf-8?B?dEd1dHFML0FFOVoreHZvakF0REZTVFV5UjBYTEttb2IrWUE0ekc3MlpwcTk5?=
 =?utf-8?B?cjRzaXU4WGhjcys3Vlg4MkI5bVJvRWVzY0lQSHpiSHkrS1pSWVBTVHFaODFp?=
 =?utf-8?B?TmM5eHZwM00wSExZSjR1eDlkUmhEcWp2UkFKdTBJbWtNU0I4NHcxUWwyL3J4?=
 =?utf-8?B?QWpjckJEejZzVVdtbFIzSnRJcityYzhmclErbEgzUVQ1NU95UTljc3E1c1Nw?=
 =?utf-8?B?NVE4ZlhPdmxIWFZwci9VVUwyMWlDYlZyRDRYTVdZRjE1dyt2cGlBMndqS09T?=
 =?utf-8?B?TG5rMDAwTUcxcEFyZ3dzUDVlNnFsNFZaQTF4eklWaTUvYzk1Zmd3cHFLN1Rv?=
 =?utf-8?B?V3lGdDJkSW5WYjd5SFprMlE2WUdCaUJVSHQyYWhPTUJVZG54RHQ5SDBvZTJx?=
 =?utf-8?B?M01wNlZya1ZNUE9UbUQrZ3h6bHQ4cmFBVHJwL3hVY2N0UU1uTlJsYzdNYkNO?=
 =?utf-8?B?OHJ4SnZZOENzYXJJQVZTRmxMVElCeCs5Z2pGdk55YlN2Ulh1Y0xxRVBUL21m?=
 =?utf-8?B?YS9zNldvTTV3a2hmcXU0amY2MHFSa05PM3N2Tzc4VzQ5b1psUjBwbTEyRGhU?=
 =?utf-8?B?NFVYV0d5enNtNkliR3prMmhPVW9XUzlidGlZM3ViZDB2dVhTNndQbWVkL3VN?=
 =?utf-8?B?R2VZWVN5QnNhNzZIT0NGUWhOV3R6dHVDdURDeFJmRmhCNHEwc3N2aEs5dCtG?=
 =?utf-8?B?TWMrWURpV2FweGthYkFGbDNBNWlHUis3aHhrR25HdlQrT29pYTIyYmk5RDl2?=
 =?utf-8?B?akc1MWVRU0tuRzd5bkxuMTRzMnQzeG1Pb2lONGg5NFJocStBVWNoMEppNlNk?=
 =?utf-8?B?NWlBSncwVXhiVlJpQlJESkpGTWs5QWZUT2Y4YkFnMFIvUUJGY3lMYk4wby9P?=
 =?utf-8?B?WU91WjdtZnFrTVFUVG1rZy9IV1lIYVlNT0VNMW5QWnRQOVJBd3M1dkVQUThN?=
 =?utf-8?B?ZStEMkR3ck1qanVhYXBQaEl1cW12VzFaL0NkVDU2K1FVdkt3SlBSTVVRbERu?=
 =?utf-8?B?WjVkcGFkVjQvbUNJaEQvMTZQVnFjNVJ0dkNYWU5zMTZjcnhYYTJzRXpiNHVi?=
 =?utf-8?B?ZG94LzVIbzFxdXIrOEtML2w1ZHlESnBoVTdnZmJ5VFpUMktwbkNTT0Vma3Nt?=
 =?utf-8?B?bms3ZjErOFFobzRPN3Arc0FJOFp0NDB6elY1SHJ6UW1BdVE0amN4emJWZUxx?=
 =?utf-8?B?Y1FCVHhWcEVhUG14YXV4WnFzQU9JSXE5RnBSVVpYZGJsVGxSeWZMWCszT0tx?=
 =?utf-8?Q?/klCCEkDY7LoFwm7UofDNBHtU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c41bc6c9-9dd3-4a42-dfb5-08ddc380f70f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 09:21:22.8094 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jIAqygAe4g9Ekz9dndXimabLGfl97Do4AbEF2twsTOAPvbL6ceN8kqrKIG5VRXom8C7qqXiT69txPqjwHuaSeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6597
Received-SPF: permerror client-ip=2a01:111:f403:2416::61b;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
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


On 15/07/2025 12:08, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> On 7/8/25 10:34, Avihai Horon wrote:
>>
>> On 24/06/2025 20:51, Maciej S. Szmigiero wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>
>>> This property allows configuring whether to start the config load only
>>> after all iterables were loaded.
>>
>> Nit: maybe, to be more accurate, mention that it is loaded as part of 
>> the non-iterables:
>> This property allows configuring whether to start the config load 
>> only after all iterables were loaded, during non-iterables loading 
>> phase.
>> (We can also mention this in docs/code comment)
>>
>> Anyway:
>>
>> Reviewed-by: Avihai Horon <avihaih@nvidia.com>
>
>
> Avihai,
>
> Have you had a chance to test this series on ARM?

Unfortunately no, I don't have such setup. I did test it on x86 though.


