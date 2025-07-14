Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46FB0C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 15:58:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubLZL-0001j5-F6; Mon, 14 Jul 2025 11:58:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1ubKbn-0004Jj-1g
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 10:56:48 -0400
Received: from mail-co1nam11on2047.outbound.protection.outlook.com
 ([40.107.220.47] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1ubKbi-0007Qd-2t
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 10:56:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=euXvK3kuvwkYiVAZW53yQNose04SBIx0u8KWMsjruUgGaf7G6YbkGhdZfL+EMxPIf5tABv4YPmwIxCcLNH36mqhVsj4lZct8At7ayRMZxvRrk78zCLR6lfAPIUqqyiZc5r7cwRtuCdbCQ5xe8oaKyxd25LHLQs8FsGe9g1BCE06a+6NqTVwfX7iX9Q47+7SLPgvclQROb10ylOSQXyCMGQ9mtSZvOvewqTToti9BdhLJgx/MekNZWapMAIQZIXkvHygWzkahtU81Ebp4MV56B9PFuV5dMbuWbg1qspx63S8AWsjHKBPw4gM3/bCDYaQGS3ia0ZS+hnnUmvbl4x404Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=er6OQ+zVSJC6QEesqnH1lr9kfAl5Uh/oDP5dFtynqgU=;
 b=TjZMqqF0xBUGqsCBkMWMEHQKSXQd/1Lv4i7LRly2h5BF2/bH5rInA8LRn67Sh0XSRRhDQSDhzjsF13T4n9nYWy9X9s05FC1gWZGddz6k3yaRgTiNnbAymuWpXZgu6dTzwZO7qJv7kwQCxACkKhK7W7FcT/ZN8xP6vQv7VpEdX5Xz2Lj1iGeuXEHRi+eNqa/qF1LOVQhVZX9vVTjNVWmp9Nv21zjTU9BxZdfhrP+3s1q4mQ8GcozSqkiLPfJwcOt4KjSnJVRljNB2yU0KBkS6aMLr2hFMA6FmJ1vW35bgRWfcInsdEqLk0Q28Xr5NB08qoEdfAT+LjHdh2jNz626xVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=er6OQ+zVSJC6QEesqnH1lr9kfAl5Uh/oDP5dFtynqgU=;
 b=TSwY4IjxbpaDVWT5OngPjEE55/9aETTNPgwd3FMQAQ05XDj2ldHDCWDh4f2L9twfHRu8k1l46Nut88xrqKx/soGGJ3q/1PLjrSgTmzRddnBNSAQriPexeVZqhfl1hu/7YnZC4Xti4LRbDWalFSAXIXXntlLG5vzxwwJVXpPcNvo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by BL1PR12MB5707.namprd12.prod.outlook.com (2603:10b6:208:386::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Mon, 14 Jul
 2025 14:51:30 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%3]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 14:51:30 +0000
Message-ID: <d19082cc-6662-4299-89c6-94657ce672f7@amd.com>
Date: Mon, 14 Jul 2025 09:51:25 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] i386/cpu: Honor maximum value for
 CPUID.8000001DH.EAX[25:14]
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Cc: Ewan Hai <ewanhai-oc@zhaoxin.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Tao Su <tao1.su@intel.com>, Yi Lai <yi1.lai@intel.com>,
 Dapeng Mi <dapeng1.mi@intel.com>, qemu-devel@nongnu.org
References: <20250714080859.1960104-1-zhao1.liu@intel.com>
 <20250714080859.1960104-8-zhao1.liu@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <20250714080859.1960104-8-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0101.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:35e::9) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|BL1PR12MB5707:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e1c0738-2b1b-4dcb-5281-08ddc2e5eb15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VVk3Yk0rRXpYS3VlNXRKa0lYUEwxWGpDdW1EU05DMVdRTCtNQUlFUExoNmRK?=
 =?utf-8?B?NXozQW1ISmJLYnRSclAwN3NEZFJ0U2IvbEZTU0R4TElybHVoem9BWEZKQUZq?=
 =?utf-8?B?eEZkNHhGUm1YTytjL0NLbzBuVXJMdlAvVXRKMklibGNBMjdwNTZMRzN5SDVV?=
 =?utf-8?B?SlgvbzBrbDJHTWZCSDZBMEhXenduVm5jcktWRFRnTDNHZFNrS1E1aUVXSkk4?=
 =?utf-8?B?QUZyRG1yY1hpeE0xY0JRdGQ0L3pFQ3NUMm42aS9yRmY5YkVlcHpaNGUxSTZm?=
 =?utf-8?B?aThCSUJlNFc4ZW1KK0psejM5OWVpaGZ1b29kT01NckpXTXJGWDdQcHBuanBp?=
 =?utf-8?B?TVFVSko1RmFjRU9CUEp3SkZPcEl1a2FFUlg1NEtCL00xa09yTUFkZXBsaUU1?=
 =?utf-8?B?OEhEQ0MvTURTYXZDOUtBQS9iNnIwRVZ3N1lwbllEaFY3Tm1QTXIwUGtYbVdo?=
 =?utf-8?B?Q1BPT3hyZ01VTEM0M3BRTDV1TXl4VEpRNk1OenlCZDB1bndJNXhOd1FwTDBF?=
 =?utf-8?B?Q0xYcDlITWs5N0lGSmdzMS9jU3NvdTJPanN1d0pucml4dFVUWVRyamxMdEp3?=
 =?utf-8?B?TVF0amx2ZlRwL0pWeGs2bkdlTmhZdUl0aVU3SjhSdTRZSXlPZ0pvcVhJOWs3?=
 =?utf-8?B?MDd1ZElDZGhZcEZTRlowMWhob0ZVM2xDeHRCb3RDSjQxb3JlL1h1MTN1WGdB?=
 =?utf-8?B?M0ZDenBKb0VQZ3JHUThMcnJmV2oyR0JWV01wU0g1SThSQUJTcGpPWW9GU2Nj?=
 =?utf-8?B?UWFLNEtDRWZWR2dyU0RPZWF5TFFEdUhQQi9Pd25iOXBGU2YxejdyRkI2Vy8r?=
 =?utf-8?B?SjlMbHZNSk50M3BGWDh6NytqYjJrdCsvL0NtZFdwTnNaM1p5a1Fja3paMTcw?=
 =?utf-8?B?M3hYbzVmOEdQWW55UWlMRXNYYTkwckVucHpQZnNlN3lsRVRZN3BSczJza25t?=
 =?utf-8?B?QVFGMlFvWExWWEVRRG1SVDArLzNiUTFCdlBINkpCbHgwSkhmOHFNZlFoMjY0?=
 =?utf-8?B?R3I0OS9MY3ZUaTlnTUgwOEFERkN2RXVhUDNnQ0JkZVRKODhPYzlNTUJ0SnEz?=
 =?utf-8?B?dXNyT0s3MStNa2FNbDN1a2NFZ2lyV3dkY3dwWHI4bTlqb0lkL1lqcVBpc0lF?=
 =?utf-8?B?TjVkYzZXNStyQWVyVVI0L1phRUNjbDE3cFMvVGRGdnBFaitucTdwdTJjaW5w?=
 =?utf-8?B?Z212ZUhvaE1qbmNaK3RVMUxROWVaZk13SjhaZXhUeEFFZkhFQkhFd0Zpc2Zv?=
 =?utf-8?B?YlZET25mUXpjbkUvSHZiNXNJVGFKUkd0aW1sc2d0MGlTUGpZTHRmcUFrMnJK?=
 =?utf-8?B?Si81T0lMMjNKYTFVVkM2UExTd1J6VUdyUlJwYTVKOC9QbldESTd3Ulc1UU1M?=
 =?utf-8?B?S0k5eGc1Qk1Yc0hZVDNBQ3FZRFVCZFhVTitjbVN6b0M2RDlmN0tDaURRdlBl?=
 =?utf-8?B?K1lUaDB6YmN6bFh6VGpIbVU4eWo1RWUrcFNsaHl6UzdwNkFYU3BhcGUvM0tJ?=
 =?utf-8?B?RlgvbnpKMGw4Q04vV2h4SzA3N1c3bC9iMDFhUkZmQlljbmRXNHJuUm1xSmxV?=
 =?utf-8?B?QTdmT2ErVFljeTVJcVRMNGk3Z0FQN2piaGQ1d3VZVnFCbUFOZzcvQUxEUklk?=
 =?utf-8?B?R1kvbWpNSjRwWjJMbURodlRmRDc1Vm9qZzBwYlhCUHZrczdsR2FaeVA3MEVF?=
 =?utf-8?B?S3lGd1FrR0pFc0R4SEJYTlh6TlhoT1pzdXUzaDYwRzBxNkNLa3lqQ3VUSnAz?=
 =?utf-8?B?TXBVbUZQWmhtd09EQWpJc3lOYzZrb1lmeHA0M1ZmWmtZRE14UmZyYm1sQmZU?=
 =?utf-8?B?ekNCSUZCZEdSSzhLMWFBb2ZyYkVEeDU1Vy96WHl1V1d0blNleFpxVUNoN2Na?=
 =?utf-8?B?aXhsbEt2MWUybndGWnFaYzZXZWp5bVVwcUo4UEhwaG5qUzN4TEk4aFRod0pv?=
 =?utf-8?Q?VkFun1Mn1v8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4553.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NytFVDhwZmhoeFFscnY2V0EveEhna3AvYzF6WkhzV2dxL1cwQUpidmM3Z1ZS?=
 =?utf-8?B?blZMeSttR0hkVTVsWE9XYmpXZUdhMWVGOWU3MGVXU1MrRUJRaDNZWCtIMTlD?=
 =?utf-8?B?TSs2T0pYelBiQWVlMVcyc3lodXhUS0ttV1ArL2tPU3ZwZU5ENEVXSFdQWGQx?=
 =?utf-8?B?elovaStReTg0SXh0UFBzazkvMk9rNXl5NG9XVmJMQWh5N2xyRlh2SlhIQllN?=
 =?utf-8?B?V29YcWNXV0pxZ3hERk83UXdyUGlId2pDNkVsVlloNHV4TG83LzNteElKRUtl?=
 =?utf-8?B?L0t5bGwvNFBtYWlHaDlaM3pBak13SkFyNFF6Z01Ha2cwY2hvaGpCMmNEdEV1?=
 =?utf-8?B?OUd2MjJ5YTNuTjVjdWFoOHAzakxvUkIrVmV4amdhTVRtT1RnQmJkYk54Vk5u?=
 =?utf-8?B?cnJlNGZQNW1VWkxOOG1LSkV4cW5uYWpWOXI4UUpjcjRUaE1BN3plcmRDWC83?=
 =?utf-8?B?cEM1T21VMXRrd1dLZFBFYVdHNUkzQ3ZxRjdBcW9hK3pZYW1WcFQrdk5nUk1Q?=
 =?utf-8?B?ZUxPbmZmRjdsTjFQaFc5cjBvellxOUd1QndPeGlBaTE1YkRQNnd4NjNmV0JC?=
 =?utf-8?B?eFplQ1U4WlRMbTRnR09qUFllK0UxUEx3WWhkNmhncUNYZnBwRDV4R2NQOFdY?=
 =?utf-8?B?TnIrVmZzdUtocXZqdUQxVkY2Yk1rMFV4OUx6QlZYZWE3OEtabVJqVDNzYzdY?=
 =?utf-8?B?c0E0OXNnbUJ2Z2VEVzZ1YkhuM1M3ZjgzMWZvdnU3cS9ZSnErSDE2clVQcHZW?=
 =?utf-8?B?SDBia01CMGJNREpjT2JnZ1EyZXdvNFZKL284ZW9DTThLdXZhVndIMWRpV1ZW?=
 =?utf-8?B?MnU2NURpd2hVNnN6eThSVWlLWUhEWitDRHgwSWtOWWs5cHhzRTZlMCtzT0s4?=
 =?utf-8?B?Z3A4K0dSektWK1ZwWGZIdjFoODNERkdGc0xTMllXN3dHK3Q0aVNEM2FwUVBh?=
 =?utf-8?B?K1l0UnllbktsVWFSMUNDVHFQVC8yT0ZiU3FiazA3VEZWd0Yxa0ErTDd6NS9n?=
 =?utf-8?B?a2lEK3FHbFdkZWlXWEczYmlBQ2RNWGU1c2tHNXBROW1xenJWQlJQNmhCZmlv?=
 =?utf-8?B?a0p5N09meHlpU3FtZU0vZzFGWnM3Um5MUDFwMG1icWlwY0ZxMSsyYkszbEFF?=
 =?utf-8?B?WGxOTHlpM3d4M05FQWlRWHExbVI1THBkc1VJYkkwZjM4UWlUTE5CUit6RXNx?=
 =?utf-8?B?ejE2NmttZUJGZndSeCtSdFFTTHJoZUw4SVRoY0NQeDdNWlQyMTBJNzdsZlVJ?=
 =?utf-8?B?N2VGTUVFVE54Q3ZQMHJjbEx5U1FaRHM4bTNiQ0piY0JYQmtTd1o4eEp6bVZ6?=
 =?utf-8?B?UHdtM1dMTGlnMmFPYy8wSWFLL1RjOEdSaDBzQ3JhLzRGSnNkdnFjYlpTN053?=
 =?utf-8?B?U3FPbmN5TnZoZDVHbmRLM2o5RUdVUnh1OXJVOENWbGNmSnNsNUxwSk5uQ0F6?=
 =?utf-8?B?K2J3b1czK0dvY2REWWkrdkRQN01qOHJIL2hEZ3A2a2RCYWN4bHU5LzNQVDJZ?=
 =?utf-8?B?aHZ3L1J0aHNUR1NMZ0dJTjFTNlI5QkhJNFR0RzZ2MklLVXdobG52UGFEUnJm?=
 =?utf-8?B?MXJneEpKR05saWVFdFJ3UFZ1c0M0U1lxS3NVL243UnkxTEVWYVdDZ2phT1Vx?=
 =?utf-8?B?Q2VDcFlmaGxJc09JVER6SXRUKzZKaG1INzlJSTdua3VLV2FIQzdUMTBwTCtF?=
 =?utf-8?B?Vy9EMXhvRDlPRzBGRFpwRVRsNHZuMnpQZmhtZXphM2NzR1duNXZhYjRpdjIx?=
 =?utf-8?B?bjlYZHV4MDZpbFYzenVxVVU3UEFETXNSOFJLNmJxQy9vc3hPUTA5Mm84bFFW?=
 =?utf-8?B?QzcxVWxkYkYvNFgzdkhvRFFycjFBUG4yK2ZlRHcwOHEvSkY0dEtWTEltL01l?=
 =?utf-8?B?dHNtaER4b3MzU1lHNU00ZHRlbUVRWDgvaVNlWmJQVXJKdDlrYU1kbHJ1OUJz?=
 =?utf-8?B?WEpYYWJyeVhYN0RPYkFqUlZkT25NQXNHTnBwNnZyNDVOU3duQjRUVWlQVmpC?=
 =?utf-8?B?bXdieTh0am5CZXRJUkJFMzYwa1ZjK0pPZ2NNbnJpdUtMRzEycmR3Zk9RVzda?=
 =?utf-8?B?YkNCNm5XR3Q5c0JlRGxoSDlrWVVldmx4bngvY3BmU0VoWC9UNGF5cEQ0TGM5?=
 =?utf-8?Q?Zwpo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e1c0738-2b1b-4dcb-5281-08ddc2e5eb15
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 14:51:30.5549 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: paPzOocI3FJQmCij5RbQvDpa3UtKNnPCBU5toOuctLJ4zRAFSm2uaDgUHCC0yEJV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5707
Received-SPF: permerror client-ip=40.107.220.47;
 envelope-from=Babu.Moger@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: babu.moger@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Zhao,

On 7/14/25 03:08, Zhao Liu wrote:
> CPUID.8000001DH:EAX[25:14] is "NumSharingCache", and the number of
> logical processors sharing this cache is the value of this field
> incremented by 1. Because of its width limitation, the maximum value
> currently supported is 4095.
> 
> Though at present Q35 supports up to 4096 CPUs, by constructing a
> specific topology, the width of the APIC ID can be extended beyond 12
> bits. For example, using `-smp threads=33,cores=9,modules=9` results in
> a die level offset of 6 + 4 + 4 = 14 bits, which can also cause
> overflow. Check and honor the maximum value as CPUID.04H did.
> 
> Cc: Babu Moger <babu.moger@amd.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
> Changes Since RFC v1 [*]:
>  * Correct the RFC's description, now there's the overflow case. Provide
>    an overflow example.
> 
> RFC:
>  * Although there are currently no overflow cases, to avoid any
>    potential issue, add the overflow check, just as I did for Intel.
> 
> [*]: https://lore.kernel.org/qemu-devel/20250227062523.124601-5-zhao1.liu@intel.com/
> ---
>  target/i386/cpu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index fedeeea151ee..eceda9865b8f 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -558,7 +558,8 @@ static void encode_cache_cpuid8000001d(CPUCacheInfo *cache,
>  
>      *eax = CACHE_TYPE(cache->type) | CACHE_LEVEL(cache->level) |
>                 (cache->self_init ? CACHE_SELF_INIT_LEVEL : 0);
> -    *eax |= max_thread_ids_for_cache(topo_info, cache->share_level) << 14;
> +    /* Bits 25:14 - NumSharingCache: maximum 4095. */
> +    *eax |= MIN(max_thread_ids_for_cache(topo_info, cache->share_level), 4095) << 14;

Will this be more meaningful?

*eax |=
 max_thread_ids_for_cache(topo_info, cache->share_level) & 0xFFF << 14

>  
>      assert(cache->line_size > 0);
>      assert(cache->partitions > 0);

-- 
Thanks
Babu Moger

