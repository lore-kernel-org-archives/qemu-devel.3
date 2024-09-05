Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECB10CD5BCF
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 16:13:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smF6H-0003kc-Lj; Thu, 05 Sep 2024 12:12:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1smF6D-0003k5-K6
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 12:12:46 -0400
Received: from mail-dm6nam12on2061.outbound.protection.outlook.com
 ([40.107.243.61] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1smF6A-0006Zz-Ky
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 12:12:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VW3JGHMQcCYFQvkPniPBNtCKshIkAj9A0zCQn+VmM3zh1Tyu4EVn7FY9Iexhq9TL3FuLA//Aaka7aZbearq7+3X8BUejzj+vghZRnff0BcWSddVJRJPnh5gtRHWWCU5oo/7Rth0DUi0fyUsDFHAp/a1NCuue0fNo1rbQckEaO8SSqon9DsT6QQqnPNcMz1dPUHt9z41EY1MjUNWvNMtUqxN8rqL7wQog40CKnu5UwOrVN9nyhy+yTqF1t/CBxGIvsvNQKpApiVZTte/hMsVPB16dmLxoI5OQ0rbVS5cCTk7kZOj/vIQ+sbhYpAwE6uLVBLyhnZhO0/HrQ1osH6mYQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJUpjK1WFEcey7xll9MKFN6VuKoNWRGs7oCPOnVfbc0=;
 b=OGQt8HKTPwJbfhJXjdQIv7rzSG7l15571s+c+UKsdG8ziNMO5FUkN4ZT4FJ5zWeQ6mo+x/zmAea/+NHdB8ocldH5YYLJJ8KI8WtL41O6rFq3AXos/D9qTzXCZ6hyOPk4hLd3FxseCz0qfs8Ax4DOZXywtrrBA4xKD7Fefz7n0Sp6ZdwuVhIo3GkSVQ0sZSbA0v0HGwFQQxp9kRI6wdW6/OeQpPx/w8py2sMxTXw+aQqGUOVvjWNeiJh1CgeRXZ1Wah3QevTSC4bs8kQ2H/AM/Z/W4JoPnE7v6dpIbp2Dafzx5DcbueY977xuGXSGeLIJmgMiuWj8IYQ9Im4k2RWW1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJUpjK1WFEcey7xll9MKFN6VuKoNWRGs7oCPOnVfbc0=;
 b=ARZftJOE5+wENBrpMAzS5NCwJg27hSFUQg+b5D47QLUJok+saFmmsu8mthybyJVXooCFT0zAKQ6IKsy467EJ9gj+7hmrUByfhPdd9Hz1aQhB6FUJcYzT9mOV7Iu+XugULsjr42i/h7SlryBZbJ58Ngg+pHWI6Bv0Kedi0vgWcHWBxDnbsv3MyyNLsY4g33jkJYGxv3sfFwNHmg9MZ6t0s1BxwNogLkrzkPIvGGpVDnDG2KWovMAAwij5geb7ol0X0aq/Y3wqp+Uc1GZSx3mJ0t7/ngvOdvkOWhqHlr89xBiGmp3DoKvVNzEMQUJAss/URJQ1wVSgZpmigqjjZpc7Vw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by SA3PR12MB9178.namprd12.prod.outlook.com (2603:10b6:806:396::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Thu, 5 Sep
 2024 16:07:37 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%5]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 16:07:36 +0000
Message-ID: <812e89c4-35d8-4fc0-ac10-ec36d57f215c@nvidia.com>
Date: Thu, 5 Sep 2024 19:07:28 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 08/11] vfio/migration: Implement VFIO migration
 protocol v2
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Maor Gottlieb <maorg@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Tarun Gupta <targupta@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 Fabiano Rosas <farosas@suse.de>, Zhiyi Guo <zhguo@redhat.com>
References: <20230216143630.25610-1-avihaih@nvidia.com>
 <20230216143630.25610-9-avihaih@nvidia.com> <ZthZ1aW_JmO3V9dr@x1n>
 <95d10ed3-33ef-48a9-9684-3a8c402c5db9@nvidia.com> <ZtiHzQHJ4PgWc21e@x1n>
 <b8807171-567b-4e21-af83-bc2f6dbbf606@nvidia.com> <ZtnLhW-2eo8hA7bQ@x1n>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <ZtnLhW-2eo8hA7bQ@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0007.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::12) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|SA3PR12MB9178:EE_
X-MS-Office365-Filtering-Correlation-Id: d971705a-8285-43e3-5bae-08dccdc4dbc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eWYzS3NwVkprWXN5Y0t2UUNUOEl2NTBnNm9yZUM3UXpQdHcrQWphUTcvUnlS?=
 =?utf-8?B?LzUwL2ltaTRnU3E2bzFKZUp1M3hpSDgzQkQ3N2FvcnlldWZ5WVdaa2p5ZitH?=
 =?utf-8?B?S1pyZXRUQWRoYUFZMFZQelBkNkJLVUNPVFJzV0RIK2V3YTEzYUUyUG8rSEtE?=
 =?utf-8?B?VVl2SWFjL04rN2xNUDRBa3pmNjh3YVlvb2Y5ckpkZkVZT1poZ21Ia2pNQUJY?=
 =?utf-8?B?SVpOODh5STA1ZW5qZWZFRFVIdmtTS1BabEFDcUtyR2FCYkVlMTUxMEhKY0Yr?=
 =?utf-8?B?dGo5ai9PWFRDUXAxTnBjV1J5YjFkdlRlMjJvajdPaytDRC9vZEwyUnd1RVRp?=
 =?utf-8?B?U0xkcklXb2JBNjE3KzJDZ0dOdnJKWkUrdDhYY3NTaTA0Q3d1T2QyVXRFRFRO?=
 =?utf-8?B?TWJTR3FEeEhsYXJ0dDROWllUcEMycUtJM2p2N3gyeEFydDBUUXdjZkl2SHh2?=
 =?utf-8?B?eHlQb3ZCc2wzbXl4aWZOVDhKZFRTejJ5aDFEWlJmZ01sTVQ0dUVkdVRhcjNy?=
 =?utf-8?B?b2QvUU9Ia1J1Vy9Dc3p4L3FKN2hvSnpEVGczNlQ3V2grenFpMU1zOHlZZzhN?=
 =?utf-8?B?bFBrVDV5ZEtFMXdIWEFvNGNFRUJzbjJVd09aNVpKVHBERXIwM1YvUmQ5OVJ2?=
 =?utf-8?B?WUR2Y0FsOG4wWGZhOUtQN08wM0R0SW0wQjVTNm1udWVUY01LcUR1eGVhNEww?=
 =?utf-8?B?OWNNK2I3U241YXZWR3VEWnBBUEI0SXBGQmJTUUYwdHFoMXYzdHphQ3M5T1g0?=
 =?utf-8?B?bzNRbDZQazRCK3RvOWNkcnBVT2o1blJVQW5Walp0cGpjSExJQStqeWNEVlF1?=
 =?utf-8?B?UDNma3lTVDFNenNjTXAza1VMUFhaME9UdVlMNlpoRy8xckdnKzFnZXQvNXdB?=
 =?utf-8?B?bmRKVzFIMm80UHowZ2hQL1hGVGlUS1RuL3dzUytUNXMwbStGZE9QRHJkSDNz?=
 =?utf-8?B?N2pnOEg0R1pCMFg3cEhXa3BnYnNGSzQ4bUF4b1hla0NMNWNiNHlZaFdnalVk?=
 =?utf-8?B?UkZZeGtjNVROWDcyM2VXREx1VFdNaHFaWlUya1FOT3FIWWpYUmVka2pjd0JT?=
 =?utf-8?B?MVFLczg0T0xUS3lqT2V4NTRVMXFhcmg1S2VRUlByNEpLL3VqMUl3cFE3M0hj?=
 =?utf-8?B?bFE5ZFhmY2RBS0wrNlRiVGUrQkc4TjBjM0ZwbzZZYnVPQm9PNHk2RHVsalZu?=
 =?utf-8?B?ZXg5aFlnS29HNzFSTWV1eTBiK3pISjh2RW4vcVRIalhZUVN4dFF1aXdMYktV?=
 =?utf-8?B?czRKUWl2TG5tRzVSMXdKL2s0ZDJoOEVhQVZRYmhhWXJNR2pHVnZ0Q2Q3dCtj?=
 =?utf-8?B?REZaTWVPMmFEaFp0NCtrNnVmT0tTS3ZsaU5BSEpqcUZJRWljVTYvZVQwQmJt?=
 =?utf-8?B?V2lvbnhUSktOZTQwQUJmSjltNlBuUUdWQVRwVnNRQjZjTkNPN1BIVU9WaEFP?=
 =?utf-8?B?S1ZHTGJtS1o3cnE5SjAxMmxUemp3aHRwbDhRdTBCSmdUNVM4MUZoVHNNTlBo?=
 =?utf-8?B?Qk4wZG5ycjhnWnFCc05GQTk5aGN6OVVpVnVNVVpFZC8yaW5QNUlHVjVyc0ll?=
 =?utf-8?B?ME1sdVAvT3VibzRaL241L1F2WW5lVmF0c3k2K0lmdXVjcno1Y1VMRUVTT3BY?=
 =?utf-8?B?VFZnaUx6czFIYnJ2ek5sbVBwVVZhdjU2VXREalNUQkdPRVliclU5dXM0ekJj?=
 =?utf-8?B?YTNMMjZJNUJRTnpEL3RjcFlTaVR5TVJxMTFqTU5wazNlcXZCMThwdlFTcUp4?=
 =?utf-8?B?M09EUE9jU09tL1NUVjNxbmZuZ0MwbERyMzlXZkwxZXIwUHR4eHdCOEVwM2JH?=
 =?utf-8?B?eGtGY2xNVTVLNVU0Z1Vadz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkdWMkRpN2R3RGNxQUZkWVZiUWxMOUhSbFpFS2ZqS3o0NXlKdEhCRWloeDcy?=
 =?utf-8?B?T09EelFOT0RveldCVDZ3VjB0ajhjTmswMUk0UEl3MEZjWHQ3UGhZKzhHaWJU?=
 =?utf-8?B?ZVA4a1JTekVqS1ZBaGxuVVRYUTE5aG1aeVhzNG9QQTN1Qk4xb3hEdTluMUcy?=
 =?utf-8?B?STh0N3VUdVFsL3NzSjN4NlhQL21tclFFT3ViOUo5am1IT1VXUXlaM0dGUjVh?=
 =?utf-8?B?dkt2MVE0bVMwT2hjSHE0L0JzYmVWTllrNjQwc0xSS01EOHlzQkhDaDBMVVhx?=
 =?utf-8?B?VkJPZFVVcCtlaEpSTHBDWHoyNm45YUtaMW9RS2cwYWg4UG04d09CYjZLbjgr?=
 =?utf-8?B?bEkyK1l4TlBtM0tZY0pZeXk5TmxIekk5ZjVnVDlSM3ZmRU53YmF6SFhqVHdW?=
 =?utf-8?B?ODZ6aFJKK0VYV2VBQjhDSzhKREgrR2h6T0JyeklsY3Z2cFNBRWpkRlVnK3Rq?=
 =?utf-8?B?MCt3ajQ0NnoyT1p6dk1LdFNYeUpMUjBLTzd5WVgwT3puZm1aWU1ZNEhtNGFk?=
 =?utf-8?B?OEswL1FiRkdzeGhGUXhnUy9JYjNIVVlqMVNSWEsyQ3NIeURjUGVlWktHYmNG?=
 =?utf-8?B?bVJiMlozeXNzeDBGYWRsaUo5MjV2RGppMEhHVFlIQXRLSm9BY2dUV3diUmxJ?=
 =?utf-8?B?NGlmQzYvNHozQi9ERWYvUWxlYnBWT20rUW5VNzU1OFBFZE8xVGlIUWJMVTNr?=
 =?utf-8?B?MTJJa1hOUzhnMFhVTHZ0VVFVdDROcWozNFUzbW92UnNvaVVFcThQWEdGejZk?=
 =?utf-8?B?L1RFNHUzTWs5SmxJT0dQMmF1VkxmSEQrZi83a3drNmtrWk5ISk53VWFJUFVD?=
 =?utf-8?B?eDFtNmZLcE1CekNvYWU4eWd0Nmo4R2JxQW1RUkdoek1VSmxwRWZFMDJZOTZV?=
 =?utf-8?B?N3h3UVltd3g1eHFEYmo5dzFYbWdYeDZJM1YrdlVqRFFRbnRna3k1RzNINm15?=
 =?utf-8?B?WHJ2M2Zad29Ec2ZsMUFoWUF6dHM2OWxCNk9sdDVmOTR0QlRzNDBMbnVTME9l?=
 =?utf-8?B?ZGR6WnVHWENtbWlHSTFCbHVLWGVJUVV3eWduMkMybVRsNlFiRnRNT1NFRG1S?=
 =?utf-8?B?N3FoRDNZdkpJcTN0OGNqWVZaRGxBS3kzVVFXcENWWHpiTDl5UXRBNXVERVVL?=
 =?utf-8?B?N1VlMG9HU3lxeUxnVmRXWXVRajBhUkR6clVKZXFMVyt3cFhHR1VUam5lTkdi?=
 =?utf-8?B?UEo4K2lpNkhTa3Rka0Q5OWVCSlprSU0yNnRPYzZVQS84cm9QVzF1TGNpMTNu?=
 =?utf-8?B?c3ovcFVCTDIyMUpicUJJMmhKQnRtVHFPWm9SbEtUTXlYK3dyRWQ1MHRtQ2lz?=
 =?utf-8?B?SDczSEJ3U0FCSWtzRXFGNHluQXc2UkowMEkrNzFRZ3RFTlZoMyt5WGxDRzl2?=
 =?utf-8?B?ZXpNZzFNRnBJTDVJNFYzays2M1lyWkV4RWU3VkZDYmJDL25FT1k5OE9oajJ2?=
 =?utf-8?B?alZ4NnFnSjdkN2FOaDdpdk1mKzdyNGZSNS9kMGtoUW9wY1J1NnhoTkFaOFEw?=
 =?utf-8?B?Q2REalZKRXdIRDdqZmZBdDRFWEF2L2lDVWFaR3AvcWx3a3FRakRMRFkvaE9Y?=
 =?utf-8?B?SEVEbjVZSjRkWDV0T3NDa1ZFSFU4a0pFOG5uN09QSFhWajk3NXluSUNjb2JR?=
 =?utf-8?B?SU1EaGJKeGswNk8wckJNbWRDSG02VjlkMWRvRlpoK05TQmVoMkFvWm9ESm5z?=
 =?utf-8?B?SGUvUi9xeEg1SS9kOGpVMnNON3RnSlhqK0dsMzRxRU0rRjJ2S0pTZm9waUhB?=
 =?utf-8?B?d0VGc1pHVlp3dFFLaTcxQ0Z6V0NhZitmYXZrY04vbitRMVlmQ0QwQy83VENy?=
 =?utf-8?B?NmE2NGRtN3RzdUM4UGFBU1pyTnJ5eDNYYmJrSHQ4anpqSHRNZzFKc0RPWU1o?=
 =?utf-8?B?aDFrWWVnVm4zYW5yNGhSd240MTFBeCtia0dqdDBiY2Z5aUY3SXkyRlRHdk8v?=
 =?utf-8?B?RDZkWXplcHd4bDlYV2tPY3djNUZydHJEM1liWEpaNll5cmZUOWFBd1MyZkNP?=
 =?utf-8?B?WkRHMTZhejQvNXc1VmsydUtteXZRUktLK25FbEdtSFlSRWppNm9TK1B3M3hM?=
 =?utf-8?B?SHJUTk84aWFUV3RCaGRQYllyREowM25WdFBzaXhqaFMzOVRxeStTR1lPUnl2?=
 =?utf-8?Q?SiLN79NFLD7Kw3ixAEu65s+ud?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d971705a-8285-43e3-5bae-08dccdc4dbc3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 16:07:36.7109 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IINnJ8+THJSCp//lWHME2lWtn1p+u0ndG1f/gHu/qPyF9k/ZDkK1m7Z84iWFl+cl7tEzjUAO2Wte/6WBUj9BmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9178
Received-SPF: softfail client-ip=40.107.243.61;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


On 05/09/2024 18:17, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> On Thu, Sep 05, 2024 at 02:41:09PM +0300, Avihai Horon wrote:
>> On 04/09/2024 19:16, Peter Xu wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On Wed, Sep 04, 2024 at 06:41:03PM +0300, Avihai Horon wrote:
>>>> On 04/09/2024 16:00, Peter Xu wrote:
>>>>> External email: Use caution opening links or attachments
>>>>>
>>>>>
>>>>> Hello, Avihai,
>>>>>
>>>>> Reviving this thread just to discuss one issue below..
>>>>>
>>>>> On Thu, Feb 16, 2023 at 04:36:27PM +0200, Avihai Horon wrote:
>>>>>> +/*
>>>>>> + * Migration size of VFIO devices can be as little as a few KBs or as big as
>>>>>> + * many GBs. This value should be big enough to cover the worst case.
>>>>>> + */
>>>>>> +#define VFIO_MIG_STOP_COPY_SIZE (100 * GiB)
>>>>>> +
>>>>>> +/*
>>>>>> + * Only exact function is implemented and not estimate function. The reason is
>>>>>> + * that during pre-copy phase of migration the estimate function is called
>>>>>> + * repeatedly while pending RAM size is over the threshold, thus migration
>>>>>> + * can't converge and querying the VFIO device pending data size is useless.
>>>>>> + */
>>>>>> +static void vfio_state_pending_exact(void *opaque, uint64_t *must_precopy,
>>>>>> +                                     uint64_t *can_postcopy)
>>>>>> +{
>>>>>> +    VFIODevice *vbasedev = opaque;
>>>>>> +    uint64_t stop_copy_size = VFIO_MIG_STOP_COPY_SIZE;
>>>>>> +
>>>>>> +    /*
>>>>>> +     * If getting pending migration size fails, VFIO_MIG_STOP_COPY_SIZE is
>>>>>> +     * reported so downtime limit won't be violated.
>>>>>> +     */
>>>>>> +    vfio_query_stop_copy_size(vbasedev, &stop_copy_size);
>>>>>> +    *must_precopy += stop_copy_size;
>>>>> Is this the chunk of data only can be copied during VM stopped?  If so, I
>>>>> wonder why it's reported as "must precopy" if we know precopy won't ever
>>>>> move them..
>>>> A VFIO device that doesn't support precopy will send this data only when VM
>>>> is stopped.
>>>> A VFIO device that supports precopy may or may not send this data (or part
>>>> of it) during precopy, and it depends on the specific VFIO device.
>>>>
>>>> According to state_pending_{estimate,exact} documentation, must_precopy is
>>>> the amount of data that must be migrated before target starts, and indeed
>>>> this VFIO data must be migrated before target starts.
>>> Correct.  It's just that estimate/exact API will be more suitable when the
>>> exact() gets the report closer to estimate(), while the estimate() is only
>>> a fast-path of exact().  It'll cause some chaos like this if it doesn't do
>>> as so.
>>>
>>> Since we have discussion elsewhere on the fact that we currently ignore
>>> non-iterative device states during migration decides to switchover, I was
>>> wondering when reply on whether this stop-size could be the first thing
>>> that will start to provide such non-iterable pending data.  But that might
>>> indeed need more thoughts, at least we may want to collect more outliers of
>>> non-iterative device states outside VFIO that can cause downtime to be too
>>> large.
>> Ah, I see.
>>
>>>>> The issue is if with such reporting (and now in latest master branch we do
>>>>> have the precopy size too, which was reported both in exact() and
>>>>> estimate()), we can observe weird reports like this:
>>>>>
>>>>> 23411@1725380798968696657 migrate_pending_estimate estimate pending size 0 (pre = 0 post=0)
>>>>> 23411@1725380799050766000 migrate_pending_exact exact pending size 21038628864 (pre = 21038628864 post=0)
>>>>> 23411@1725380799050896975 migrate_pending_estimate estimate pending size 0 (pre = 0 post=0)
>>>>> 23411@1725380799138657103 migrate_pending_exact exact pending size 21040144384 (pre = 21040144384 post=0)
>>>>> 23411@1725380799140166709 migrate_pending_estimate estimate pending size 0 (pre = 0 post=0)
>>>>> 23411@1725380799217246861 migrate_pending_exact exact pending size 21038628864 (pre = 21038628864 post=0)
>>>>> 23411@1725380799217384969 migrate_pending_estimate estimate pending size 0 (pre = 0 post=0)
>>>>> 23411@1725380799305147722 migrate_pending_exact exact pending size 21039976448 (pre = 21039976448 post=0)
>>>>> 23411@1725380799306639956 migrate_pending_estimate estimate pending size 0 (pre = 0 post=0)
>>>>> 23411@1725380799385118245 migrate_pending_exact exact pending size 21038796800 (pre = 21038796800 post=0)
>>>>> 23411@1725380799385709382 migrate_pending_estimate estimate pending size 0 (pre = 0 post=0)
>>>>>
>>>>> So estimate() keeps reporting zero but the exact() reports much larger, and
>>>>> it keeps spinning like this.  I think that's not how it was designed to be
>>>>> used..
>>>> It keeps spinning and migration doesn't converge?
>>>> If so, configuring a higher downtime limit or the avail-switchover-bandwidth
>>>> parameter may solve it.
>>> Yes, this is the only way to go, but it's a separate issue on reportings of
>>> estimate()/exact().  More below.
>>>
>>>>> Does this stop copy size change for a VFIO device or not?
>>>> It depends on the specific VFIO device.
>>>> If the device supports precopy and all (or part) of its data is
>>>> precopy-able, then stopcopy size will change.
>>>> Besides that, the amount of resources currently used by the VFIO device can
>>>> also affect the stopcopy size, and it may increase or decrease as resources
>>>> are created or destroyed.
>>> I see, thanks.
>>>
>>>>> IIUC, we may want some other mechanism to report stop copy size for a
>>>>> device, rather than reporting it with the current exact()/estimate() api.
>>>>> That's, per my undertanding, only used for iterable data, while
>>>>> stop-copy-size may not fall into that category if so.
>>>> The above situation is caused by the fact that VFIO data may not be fully
>>>> precopy-able (as opposed to RAM data).
>>>> I don't think reporting the stop-copy-size in a different API will help the
>>>> above situation -- we would still have to take stop-copy-size into account
>>>> before converging, to not violate downtime.
>>> It will help some other situation, though.
>>>
>>> One issue with above freqeunt estimate()/exact() call is that QEMU will go
>>> into madness loop thinking "we're close" and "we're far away from converge"
>>> even if the reality is "we're far away". The bad side effect is when this
>>> loop happens it'll not only affect VFIO but also other devices (e.g. KVM,
>>> vhost, etc.) so we'll do high overhead sync() in an extremely frequent
>>> manner.  IMHO they're totally a waste of resource, because all the rest of
>>> the modules are following the default rules of estimate()/exact().
>>>
>>> One simple but efficient fix for VFIO, IMHO, is at least VFIO should also
>>> cache the stop-size internally and report in estimate(), e.g.:
>>>
>>> /* Give an estimate of the amount left to be transferred,
>>>    * the result is split into the amount for units that can and
>>>    * for units that can't do postcopy.
>>>    */
>>> void qemu_savevm_state_pending_estimate(uint64_t *must_precopy,
>>>                                           uint64_t *can_postcopy)
>>> {
>>> }
>>>
>>> If it's justified that the stop-size to be reported in exact(), it should
>>> also be reported in estimate() per the comment above.  It should also fall
>>> into precopy category in this case.
>>>
>>> Then with that we should avoid calling exact() frequently for not only VFIO
>>> but also others (especially, KVM GET_DIRTY_LOG / CLEAR_DIRTY_LOG ioctls),
>>> then we know it won't converge anyway without the help of tuning downtime
>>> upper, or adjust avail-switchover-bandwidth.
>> Yes, it will solve this problem, but IIRC, the reason I didn't cache and
>> return stop-copy-size in estimate from the first place was that it wasn't
>> fully precopy-able, and that could cause some problems:
>> Once we cache and report this size in estimate, it may not decrease anymore
>> -- we can't send it during precopy and we might not be able to call get
>> stop-copy-size again from the exact path (because estimate might now reach
>> below the threshold).
>>
>> For example, assume the threshold for convergence is 1GB.
>> A VFIO device may report 2GB stop-copy-size (not precopy-able) in the
>> beginning of the migration.
>> If the VFIO device stop-copy-size changes in the middle of migration (e.g.,
>> some of its resources are destroyed) and drops to 900MB, we will still see
>> 2GB report in estimate.
>> Only when calling the exact handler again we will get the updated 900MB
>> value and be able to converge. But that won't happen, because estimate size
>> will always be above the 1GB threshold.
>>
>> We could prevent these situations and call the get stop-copy-size once every
>> X seconds, but it feels a bit awkward.
> IMHO the confusion is caused by an unclear definition of stop-size and
> precopy-size in VFIO terms.
>
> What I would hope is the stop-size reported should be constant and not be
> affected by precopy process happening.  Whatever _can_ change at all should
> be reported as precopy-size.
>
> So I wonder why stop-size can change from a driver, and whether that can be
> reported in a more predictable fashion.  Otherwise I see little point in
> providing both stop-size and precopy-size, otherwise we'll always add them
> up into VFIO's total pending-size.  The line on provision which data falls
> into which bucket doesn't seem to be clear to me.

Stopcopy-size is reported by VFIO_DEVICE_FEATURE_MIG_DATA_SIZE ioctl, 
which states that this is "[...] the estimated data length that will be 
required to complete stop copy".
So by this definition, stopcopy-size can change during precopy (it can 
also change if device resources are created or destroyed).

Precopy-size is reported by VFIO_MIG_GET_PRECOPY_INFO ioctl, which 
states that this is "[...] estimates of data available from the device 
during the PRE_COPY states".

Maybe the confusion was caused by this line in vfio_state_pending_exact():
     *must_precopy += migration->precopy_init_size + 
migration->precopy_dirty_size;

Which I think should be removed, as stopcopy-size should already cover 
precopy data.

Thanks.

>
>>> This may improve situation but still leave one other issue, that IIUC even
>>> with above change and even if we can avoid sync dirty bitmap frequently,
>>> the migration thread can still spinning 100% calling estimate() and keep
>>> seeing data (which is not iterable...).  For the longer term we may still
>>> need to report non-iterable stop-size in another way so QEMU knows that
>>> iterate() over all the VMState registers won't help in this case, so it
>>> should go into sleep without eating the cores.  I hope that explains why I
>>> think a new API should be still needed for the long run.
>> Yes, I get your point.
>> But is the spinning case very common? AFAIU, if it happens, it may indicate
>> some misconfiguration of the migration parameters.
> Agreed.
>
> It's just that our QE actively tests such migrations and there're always
> weird and similar reports on cpu spinning, so it might be nice to still fix
> it at some point.
>
> This shouldn't be super urgent, indeed.  It's just that it can start to
> make sense when we have other discussions where reporting non-iteratble
> pending data might be pretty useful on its own as an idea.  It's just that
> we need to figure out above on how VFIO can report predicatble stop-size in
> the drivers, and I wonder whether the drivers can be fixed (without
> breaking existing qemu; after all they currently always add both
> counters..).
>
>> Anyway, I think your idea may fit VFIO, but still need to think about all
>> the small details.
> Thanks,
>
> --
> Peter Xu
>

