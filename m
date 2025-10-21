Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E72BCCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 05:28:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB4uR-00052P-22; Tue, 21 Oct 2025 01:27:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Vasant.Hegde@amd.com>)
 id 1vB4uP-00051i-0P
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 01:27:45 -0400
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Vasant.Hegde@amd.com>)
 id 1vB4uM-0007Kq-6b
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 01:27:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pRZw4BRboUhI4b4ePcKmuEZblN7z3JAyijN8NIPY1rvv3IjyyFfahz1wa3al/1eGtP1d0VdhXtaTQIAenzVfJhrg22CiqA5Wq0FsusMohiMaSQ08J9+Ng3QtqE4KMXWG1tBv1C7S6mrdOw4NEhAZU9nU4z28nna+SlPFzQrUHtBXvyoZIuIbsC0ob6gCQxDTtnYkuOphtoVQno0dqwQY0tGH+zixVCPqAHIrdI0VNttKdH43dqrcvblOK0JmUy2mtLX0OFgbhdQAQTcdYRSDa1nJLwsgAWLG450B0tmH4G46eog1F0GxvGXohkEydG5t7VBD1bpi11smfS9WkQa5CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9YbOfYlVirOeL5B5VOOKZnkrA4cJGLpTacC7Pt6bwL8=;
 b=uz9k0WcvvxZwNlfgkJH9mXbfsgbEUXIxsssSyC9VEADTCgdNSAeD945+i4CmhgkLL/4/BhdKCRK1i8TkS/VP6xTCvFiMPsxa2RH/YeI7l7LlrOA65ND4c0IlQoKS0hYVZ2lvRo+uc05NuNMtQb/xp2rpBfSj8lbGLV77c95Lakq0MAdfmYsi5vfveIgyyN5fmHkINbiDTiyhBpLtLAhX46pQT5UZUfPMOhFgm2iyJLACT/iD1WwKMqBTo+PXK00hW0L1aUNytXVcsqec9aRis/4mVrKf9sFebnRF388+e13U4fvlgEOCa3f0i7aHiX37zts5Pr1gRbe9JwDnwgvTjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YbOfYlVirOeL5B5VOOKZnkrA4cJGLpTacC7Pt6bwL8=;
 b=SWPpDH9rHziEExVchaDoxQpO/qnrMKCzDTtz/1nFkZaQmfJW6KcyPJ7sjR8+12TxCgUuj0UMZEhYbkOwj0CUCVnVHQBdW6MoCR8BXPJTjkF6YrhFxsTGLe4/rNVO3HFJfvWupL0pWBWSffRTUZ9rkFuKi+qGmSGLmV03bZsHW/k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DS0PR12MB7925.namprd12.prod.outlook.com (2603:10b6:8:14b::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.12; Tue, 21 Oct 2025 05:27:34 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%7]) with mapi id 15.20.9228.015; Tue, 21 Oct 2025
 05:27:34 +0000
Message-ID: <d7281232-34bf-4319-ba0c-75328dccf223@amd.com>
Date: Tue, 21 Oct 2025 10:57:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] amd_iommu: Fix handling device on buses != 0
To: Sairaj Kodilkar <sarunkod@amd.com>, qemu-devel@nongnu.org,
 alejandro.j.jimenez@oracle.com
Cc: mst@redhat.com, pbonzini@redhat.com, richard.henderson@linaro.org,
 philmd@linaro.org, suravee.suthikulpanit@amd.com,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net, aik@amd.com
References: <20251017061322.1584-1-sarunkod@amd.com>
 <20251017061322.1584-2-sarunkod@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20251017061322.1584-2-sarunkod@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0057.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b8::11) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DS0PR12MB7925:EE_
X-MS-Office365-Filtering-Correlation-Id: 0800f991-4d02-472b-7a33-08de10628a54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UXNHU1Bud0FydWhmWE12OW93TmdkOGtDTTZ6V3h4U0ZRczZjMHhUaHc5OEVm?=
 =?utf-8?B?cWtFOTFRR20ydXk2aWNRVFQ4TXN3bWZpSzB4TU1FQUVtaVI1V1NVbFY3Qy9n?=
 =?utf-8?B?TUJZUVZLbFRCMXNNY0Z4bXlVYndZK3N1eG1KWkpWTHZUUkZOQXd2ckVEWkZI?=
 =?utf-8?B?MGJMeFhqdlJGQlVwOW8wdjZBQW5MVlNsM2htZm54NFZZaDlwQUtxakFYUGdW?=
 =?utf-8?B?dnNxblRmSnc2a3BvWDNsM082bzNGb2ZzZVN2ZjR4T3lqeS9LbUs0MWUwOGVp?=
 =?utf-8?B?MGgvd3Y1TE8zeFl2Zkx3ZG5CSkJCMmU3WGsyNEZmOUQrLzFJdU0rUHR4MDln?=
 =?utf-8?B?VDJWMnlLSHFQODdpajIxN0NnMzQ1MlBqeStDakhhVkpjR05wcVVGenlRZFRX?=
 =?utf-8?B?RmFxVFd4RFNUdDAxM0VVWjNPMTF2SzJjUk9mT0dKbnpQUkdDRjg2SkhPNjd5?=
 =?utf-8?B?SXpFdEU0eFV4SnFFYVBXa1pIM3JlWWEyWkhIYzJ2YXE5MVlKUHQyekpxa2kv?=
 =?utf-8?B?OTROejY3NVNlUDhxYTJIQ1pLclFMVmZUSlQ2SmwwYkl5anFzRmRMYTZGbjJJ?=
 =?utf-8?B?eUpPN29RV1hnaWgwRTZ4c1cxM3dYczJUY0J5dlBDc2FJZng0ZVQzS3Fuektv?=
 =?utf-8?B?Sm1ITEhuWDd4QnY0clYxZFlkMUxjMmhSOTZVdTJZMnYzdFJPaXBlaTluWldN?=
 =?utf-8?B?MmJBS3JxK2RIN2xmMzJzd3ROM1VNVDZkL05SY1JvaFBxWk4wYkdTNENqYmtY?=
 =?utf-8?B?dkEycFhRMGx5K3NTZG1GY0QyTDhJTTNqb2xTWW1KSktKZFREdlhSaHRTb3FW?=
 =?utf-8?B?Mm41RTdneEZEQ2ZkdkxRYzBFa2U1a0YwZ3ZOV1FvaEhZU0g0MFh1OVJLTzd4?=
 =?utf-8?B?TnFYczhqdVpOUFZLak11TGMwbWZVaGlEVG9EMENNRFpZVzhmZlRmMjJGUlpw?=
 =?utf-8?B?NFQxdmZkdG00ZFptMFFnVEFTZjlqNE1xcHVRbFVFSEhuc29xcklvSXg0T3ZD?=
 =?utf-8?B?cVptK3EwVUlqc24rUk5UcVlNeGlwaXZkeHE0Y1hValRJc2tEUDZmNWhoQjlL?=
 =?utf-8?B?dTV1N2VSUmc2T29xZ2t3RzlGQmxrbjFvWlNJdmJYWWRpUmFYNmlrNGx1UExH?=
 =?utf-8?B?cHJSVlQzSUl1eGtObThRMGdBMDZhSnFseEZya0FJWkhNUUw5YWFiVzR2T0hW?=
 =?utf-8?B?MEdrL3M4VmJTU2JJMFF0ZW9hU0lvNE5tRjhLVW0xS3MyazNqSlFBdWc2ZHpz?=
 =?utf-8?B?STZJYVc1N3krb25TOFBhVmx0cGxVNGdDQ245RWdrNFJQYVo3U2lXYWRrOUtI?=
 =?utf-8?B?SnNCOUYwK0pTSFMrYjNlUGl0R3N5MUQrSnJiV1NLaWQ1dGp2L2ZRdkM1Y1g3?=
 =?utf-8?B?QjJpQ2l5eTZtVGFLLzBpendIUldOcVVCYXBnV3BxUG5SemNlT0hTZk5zT1hl?=
 =?utf-8?B?OG5TK2V2WHFZYkVTQU9JZlZMTEUydXd6Q01WT1VlbjdjdnE1R3BDeTQ5RWdp?=
 =?utf-8?B?Rk05QkNOcVNLWCs3cDIvbitRYjBwWDg0ZUE0Nm80R0dsaGJwT25TcUxxWUhy?=
 =?utf-8?B?WXpPd1VBQXVDRWE0OXIrdnV3Y1ZhYmswSWEzOFNzczNMako2NjBMWXg0UCtF?=
 =?utf-8?B?SkZKc1k2UkJqNEE4cVJRTjNyaXQ2bVVpVXZBcWdPc0E3YisrU2NuYnNYaTkz?=
 =?utf-8?B?dTdXM0QweG1XTi9vSWFORjNtQ0ZMb3BkRXBYYm5VWlh6elNyTWNlUVlnckdU?=
 =?utf-8?B?Wi92QnpWUXZIb1d2Z2dyeDluVVVTK1BEU3FualdaVFMraXR1elY1ODFaWHl5?=
 =?utf-8?B?cE1qbmxjQ29EQWVMN0tuaWQwZG5xTlFSMllpYitLa1RuYmhSdFlLUS9pQnQv?=
 =?utf-8?B?czN2YXdsOCtVRlhRd2RpTk5RaWw5N0pMQlFjbCszV0pQbFlEbDF2UEYrVWpH?=
 =?utf-8?Q?+Jqjjj8XRS/wWDIMilz2Sl8t01cYD6pa?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6048.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHlDUVV2WVMvbzFWejJ2dGswMUdLYlhESHQzUm9XV3FhNS8yN2Y0bm1GZ3M2?=
 =?utf-8?B?ZEt1aVBnV1I5OS9jQ0ZoeGpybStHZDQxWHA1WFZwZUhoSUJlUnF5MUxDdGxl?=
 =?utf-8?B?eFR4L2EyMnVTd0c2cm4yWlpkL1JSVS9ObnZpUXBXaGZzeEw5cEc4NHB6ZGc4?=
 =?utf-8?B?cU1mVHZIZmxxR1haZ1NEVnVuR3FGTkZRRXd4emNwUGQ5NE5EV2dQZlZFK1NY?=
 =?utf-8?B?N0lvOS82WFZEL2FlMFdZcW1OdWVXOEd1UUVyNGVuVzRSTmtOak5ib1c1eFRC?=
 =?utf-8?B?ZnpoS0F5ZTRzREllSDBmKzV6dEpjNkhCVjVXTFNqdnlxenUzL214TzhaeXZz?=
 =?utf-8?B?bzQydUJsZEN1aXdiNC8wT3RlZzlwVnpnVlBxSDVoQ3J2UVd5bHdJSkxOYnZS?=
 =?utf-8?B?d0FtckVNRlpaMHJscUs0dlBTWUhvM3JDZTFIeE9IbGlxcmczRGFEaUp4OTB2?=
 =?utf-8?B?M3NUUjlCcTJYRU0vclNvVCtLdC9mcDloVWtLb2ZFazBJRHBmSGN6eDdpZ280?=
 =?utf-8?B?Y05vTFlONjlFbkJIaTVybTNpbHF0ZEJSNno5R3F1QXJtTGN2TG1QSElNZFZl?=
 =?utf-8?B?ektPOTVHN0RCMkRGQmNaKzVSMWI0a0ZNOW5VYStqUHRqVFhkVWhFRWpUUUZN?=
 =?utf-8?B?SzZHUjNEdEhaTURvRnUxU1JoWDF4K3VucWlEVk41VitVNGFQb0YvdzB4SDZr?=
 =?utf-8?B?RUJUZmtCcjRVdnNLRGtSWVE0REtNRVc4R3htNGY0YlVhNCtrNW45Q0pXTGZl?=
 =?utf-8?B?NHRLSWtxMk43SEZTNWtCaUsvOFhMRmJyQm5XZGhOQjFTNFhuSy9jUTNTMDFC?=
 =?utf-8?B?dzZSRDJEMjRaMVN3b1VJenI2ZWpXVzNuREc3R2dqVzVWMXdFRmg1NzlYNHFi?=
 =?utf-8?B?Z3hncFF2cFp1ckUyTW1GT0JtYzVnRjVLNHZDY0hUOEQxWGl4d1lFM1RGVEVz?=
 =?utf-8?B?aHdtUkdqWG8xUU0vNlprL1ZwZXpCOGpFaDl0clJHY1hVSFY0MmQwSDNtT3Y5?=
 =?utf-8?B?UWpHZEU5MFNsbStPZmc5T1NISjBSdGVrbk5zUXlxa3BDa01UTS8ycGpuSE5U?=
 =?utf-8?B?TGY0R0k1b0FYNWxWdkh2MUk0V1YzcDA1SjNaaCtGYVpnUzBSK3RQYnZzV2pE?=
 =?utf-8?B?d1ZaSTZXZmpMN093eVFPdk80cGRHdVRQQURDT1Q1R215RDBIR2lYa2wrOWNo?=
 =?utf-8?B?Y3l1VVc3MjRoWlhuTXZjb3hrMW1oTEp3eXcrQTgrdDZCRlRDd3dZdDBuS1pV?=
 =?utf-8?B?RllaQm1wRFZxd21RRzZJTVNSZ0pwWWRBZTk3dzJHUis4SXBzWGord0w3UWRE?=
 =?utf-8?B?dW5PRlREcDBUbjNXYkMzRmFzVW1vemFESk5MK25WRWJIRDhwSDMvNHpkVVFJ?=
 =?utf-8?B?VUNIU0t4SEt3blJRUnl5bTh6Njg5cGFFazBuclB1blZ2WDZ5eHlPRUw5K0RG?=
 =?utf-8?B?MEEvbXlkenRIVmdKZGJwb2MvUHF4aGNVZGZocHFlQlJhUGdCb3F2bXJ5aEFE?=
 =?utf-8?B?UDUyZGZQOHlQOHFEbkJ1ZDFxYm1qZDF2MStyK3QrWjBIL0VhSm5wcDNhbWdC?=
 =?utf-8?B?SFFRTGZzcGFBYlh1QjM3Z3RlVTFkQXNjWnROLzNzVTZSUWF2d0doM0s0TlV4?=
 =?utf-8?B?ZEtJV2NPaWFsRUFHNzBQRDVUdEJBcDd2VlNxMk1JdVdJQXNZR0N1NTM0VDYz?=
 =?utf-8?B?NnFZRTNhbUFRZVlzYmlKelg1N1Yyd01lYnFybGhBVVZyM1VZbkNNbHB0VWQ2?=
 =?utf-8?B?aDVUeWF2ZGo2M3JiWTh3V2tOVldlRVpCMSs0Rlk3d0RlYXhnRE9INUplNFBr?=
 =?utf-8?B?N2thNDU3WjJKc1VFWGZsZ1pqbkF0RnBjWUNWRmxWb2N4RzVJeWNQSjBhZ2do?=
 =?utf-8?B?SWsvMFp5MVh0Q05LT09mQktTMU1kK1Rqd1FHTHk5d3ZMZThiOGZpQlZlUzkx?=
 =?utf-8?B?Mk42S2Q0QnRnMTR0V0F4TkVXUytaTUpHTjhuZ2NBMjZBbEI1SzRIVkl4QzRB?=
 =?utf-8?B?K0RCQkhXTjJ2cEdPZStuQ1g5ZXdrbGFnbkdJMjBQWlU5VjB2anV4cERaUURZ?=
 =?utf-8?B?TWlzS0tybFBDUm4rWHYyNmFGZXpwR243NUZHeEZpSlNpOTAxTk56ZUFrNTFZ?=
 =?utf-8?Q?h3IFjKCHYpwYjg5BN/q+f66GF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0800f991-4d02-472b-7a33-08de10628a54
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 05:27:34.8620 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ag6x7Xp/YObo6+rvfJ5Rnueuah76DwEyDoRclJnt2vLc46r/QZriSqyDpynXsFUmT1yvmS1jH3QtDPH2+oGEsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7925
Received-SPF: permerror client-ip=2a01:111:f403:c112::5;
 envelope-from=Vasant.Hegde@amd.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
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



On 10/17/2025 11:43 AM, Sairaj Kodilkar wrote:
> The AMD IOMMU is set up at boot time and uses PCI bus numbers + devfn
> for indexing into DTE. The problem is that before the guest started,
> all PCI bus numbers are 0 as no PCI discovery happened yet (BIOS or/and
> kernel will do that later) so relying on the bus number is wrong.
> The immediate effect is emulated devices cannot do DMA when places on
> a bus other that 0.
> 
> Replace static array of address_space with hash table which uses devfn and
> PCIBus* for key as it is not going to change after the guest is booted.
> 
> Co-developed-by: Alexey Kardashevskiy <aik@amd.com>
> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant

> ---
>  hw/i386/amd_iommu.c | 134 ++++++++++++++++++++++++++------------------
>  hw/i386/amd_iommu.h |   2 +-
>  2 files changed, 79 insertions(+), 57 deletions(-)
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 378e0cb55eab..c2cd5213eb1b 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -59,7 +59,7 @@ const char *amdvi_mmio_high[] = {
>  };
>  
>  struct AMDVIAddressSpace {
> -    uint8_t bus_num;            /* bus number                           */
> +    PCIBus *bus;                /* PCIBus (for bus number)              */
>      uint8_t devfn;              /* device function                      */
>      AMDVIState *iommu_state;    /* AMDVI - one per machine              */
>      MemoryRegion root;          /* AMDVI Root memory map region         */
> @@ -101,6 +101,11 @@ typedef enum AMDVIFaultReason {
>      AMDVI_FR_PT_ENTRY_INV,      /* Failure to read PTE from guest memory */
>  } AMDVIFaultReason;
>  
> +typedef struct AMDVIAsKey {
> +    PCIBus *bus;
> +    uint8_t devfn;
> +} AMDVIAsKey;
> +
>  uint64_t amdvi_extended_feature_register(AMDVIState *s)
>  {
>      uint64_t feature = AMDVI_DEFAULT_EXT_FEATURES;
> @@ -382,6 +387,44 @@ static guint amdvi_uint64_hash(gconstpointer v)
>      return (guint)*(const uint64_t *)v;
>  }
>  
> +static gboolean amdvi_as_equal(gconstpointer v1, gconstpointer v2)
> +{
> +    const AMDVIAsKey *key1 = v1;
> +    const AMDVIAsKey *key2 = v2;
> +
> +    return key1->bus == key2->bus && key1->devfn == key2->devfn;
> +}
> +
> +static guint amdvi_as_hash(gconstpointer v)
> +{
> +    const AMDVIAsKey *key = v;
> +    guint bus = (guint)(uintptr_t)key->bus;
> +
> +    return (guint)(bus << 8 | (uint)key->devfn);
> +}
> +
> +static AMDVIAddressSpace *amdvi_as_lookup(AMDVIState *s, PCIBus *bus,
> +                                          uint8_t devfn)
> +{
> +    const AMDVIAsKey key = { .bus = bus, .devfn = devfn };
> +    return g_hash_table_lookup(s->address_spaces, &key);
> +}
> +
> +static gboolean amdvi_find_as_by_devid(gpointer key, gpointer value,
> +                                       gpointer user_data)
> +{
> +    const AMDVIAsKey *as = key;
> +    const uint16_t *devidp = user_data;
> +
> +    return *devidp == PCI_BUILD_BDF(pci_bus_num(as->bus), as->devfn);
> +}
> +
> +static AMDVIAddressSpace *amdvi_get_as_by_devid(AMDVIState *s, uint16_t devid)
> +{
> +    return g_hash_table_find(s->address_spaces,
> +                             amdvi_find_as_by_devid, &devid);
> +}
> +
>  static AMDVIIOTLBEntry *amdvi_iotlb_lookup(AMDVIState *s, hwaddr addr,
>                                             uint64_t devid)
>  {
> @@ -551,7 +594,7 @@ static inline uint64_t amdvi_get_pte_entry(AMDVIState *s, uint64_t pte_addr,
>  
>  static int amdvi_as_to_dte(AMDVIAddressSpace *as, uint64_t *dte)
>  {
> -    uint16_t devid = PCI_BUILD_BDF(as->bus_num, as->devfn);
> +    uint16_t devid = PCI_BUILD_BDF(pci_bus_num(as->bus), as->devfn);
>      AMDVIState *s = as->iommu_state;
>  
>      if (!amdvi_get_dte(s, devid, dte)) {
> @@ -1011,25 +1054,15 @@ static void amdvi_switch_address_space(AMDVIAddressSpace *amdvi_as)
>   */
>  static void amdvi_reset_address_translation_all(AMDVIState *s)
>  {
> -    AMDVIAddressSpace **iommu_as;
> -
> -    for (int bus_num = 0; bus_num < PCI_BUS_MAX; bus_num++) {
> +    AMDVIAddressSpace *iommu_as;
> +    GHashTableIter as_it;
>  
> -        /* Nothing to do if there are no devices on the current bus */
> -        if (!s->address_spaces[bus_num]) {
> -            continue;
> -        }
> -        iommu_as = s->address_spaces[bus_num];
> +    g_hash_table_iter_init(&as_it, s->address_spaces);
>  
> -        for (int devfn = 0; devfn < PCI_DEVFN_MAX; devfn++) {
> -
> -            if (!iommu_as[devfn]) {
> -                continue;
> -            }
> -            /* Use passthrough as default mode after reset */
> -            iommu_as[devfn]->addr_translation = false;
> -            amdvi_switch_address_space(iommu_as[devfn]);
> -        }
> +    while (g_hash_table_iter_next(&as_it, NULL, (void **)&iommu_as)) {
> +        /* Use passhthrough as default mode after reset */
> +        iommu_as->addr_translation = false;
> +        amdvi_switch_address_space(iommu_as);
>      }
>  }
>  
> @@ -1089,27 +1122,15 @@ static void enable_nodma_mode(AMDVIAddressSpace *as)
>   */
>  static void amdvi_update_addr_translation_mode(AMDVIState *s, uint16_t devid)
>  {
> -    uint8_t bus_num, devfn, dte_mode;
> +    uint8_t dte_mode;
>      AMDVIAddressSpace *as;
>      uint64_t dte[4] = { 0 };
>      int ret;
>  
> -    /*
> -     * Convert the devid encoded in the command to a bus and devfn in
> -     * order to retrieve the corresponding address space.
> -     */
> -    bus_num = PCI_BUS_NUM(devid);
> -    devfn = devid & 0xff;
> -
> -    /*
> -     * The main buffer of size (AMDVIAddressSpace *) * (PCI_BUS_MAX) has already
> -     * been allocated within AMDVIState, but must be careful to not access
> -     * unallocated devfn.
> -     */
> -    if (!s->address_spaces[bus_num] || !s->address_spaces[bus_num][devfn]) {
> +    as = amdvi_get_as_by_devid(s, devid);
> +    if (!as) {
>          return;
>      }
> -    as = s->address_spaces[bus_num][devfn];
>  
>      ret = amdvi_as_to_dte(as, dte);
>  
> @@ -1783,7 +1804,7 @@ static void amdvi_do_translate(AMDVIAddressSpace *as, hwaddr addr,
>                                 bool is_write, IOMMUTLBEntry *ret)
>  {
>      AMDVIState *s = as->iommu_state;
> -    uint16_t devid = PCI_BUILD_BDF(as->bus_num, as->devfn);
> +    uint16_t devid = PCI_BUILD_BDF(pci_bus_num(as->bus), as->devfn);
>      AMDVIIOTLBEntry *iotlb_entry = amdvi_iotlb_lookup(s, addr, devid);
>      uint64_t entry[4];
>      int dte_ret;
> @@ -1858,7 +1879,7 @@ static IOMMUTLBEntry amdvi_translate(IOMMUMemoryRegion *iommu, hwaddr addr,
>      }
>  
>      amdvi_do_translate(as, addr, flag & IOMMU_WO, &ret);
> -    trace_amdvi_translation_result(as->bus_num, PCI_SLOT(as->devfn),
> +    trace_amdvi_translation_result(pci_bus_num(as->bus), PCI_SLOT(as->devfn),
>              PCI_FUNC(as->devfn), addr, ret.translated_addr);
>      return ret;
>  }
> @@ -2222,30 +2243,28 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
>  {
>      char name[128];
>      AMDVIState *s = opaque;
> -    AMDVIAddressSpace **iommu_as, *amdvi_dev_as;
> -    int bus_num = pci_bus_num(bus);
> +    AMDVIAddressSpace *amdvi_dev_as;
> +    AMDVIAsKey *key;
>  
> -    iommu_as = s->address_spaces[bus_num];
> +    amdvi_dev_as = amdvi_as_lookup(s, bus, devfn);
>  
>      /* allocate memory during the first run */
> -    if (!iommu_as) {
> -        iommu_as = g_new0(AMDVIAddressSpace *, PCI_DEVFN_MAX);
> -        s->address_spaces[bus_num] = iommu_as;
> -    }
> -
> -    /* set up AMD-Vi region */
> -    if (!iommu_as[devfn]) {
> +    if (!amdvi_dev_as) {
>          snprintf(name, sizeof(name), "amd_iommu_devfn_%d", devfn);
>  
> -        iommu_as[devfn] = g_new0(AMDVIAddressSpace, 1);
> -        iommu_as[devfn]->bus_num = (uint8_t)bus_num;
> -        iommu_as[devfn]->devfn = (uint8_t)devfn;
> -        iommu_as[devfn]->iommu_state = s;
> -        iommu_as[devfn]->notifier_flags = IOMMU_NOTIFIER_NONE;
> -        iommu_as[devfn]->iova_tree = iova_tree_new();
> -        iommu_as[devfn]->addr_translation = false;
> +        amdvi_dev_as = g_new0(AMDVIAddressSpace, 1);
> +        key = g_new0(AMDVIAsKey, 1);
>  
> -        amdvi_dev_as = iommu_as[devfn];
> +        amdvi_dev_as->bus = bus;
> +        amdvi_dev_as->devfn = (uint8_t)devfn;
> +        amdvi_dev_as->iommu_state = s;
> +        amdvi_dev_as->notifier_flags = IOMMU_NOTIFIER_NONE;
> +        amdvi_dev_as->iova_tree = iova_tree_new();
> +        amdvi_dev_as->addr_translation = false;
> +        key->bus = bus;
> +        key->devfn = devfn;
> +
> +        g_hash_table_insert(s->address_spaces, key, amdvi_dev_as);
>  
>          /*
>           * Memory region relationships looks like (Address range shows
> @@ -2288,7 +2307,7 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
>  
>          amdvi_switch_address_space(amdvi_dev_as);
>      }
> -    return &iommu_as[devfn]->as;
> +    return &amdvi_dev_as->as;
>  }
>  
>  static const PCIIOMMUOps amdvi_iommu_ops = {
> @@ -2329,7 +2348,7 @@ static int amdvi_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu,
>      if (!s->dma_remap && (new & IOMMU_NOTIFIER_MAP)) {
>          error_setg_errno(errp, ENOTSUP,
>              "device %02x.%02x.%x requires dma-remap=1",
> -            as->bus_num, PCI_SLOT(as->devfn), PCI_FUNC(as->devfn));
> +            pci_bus_num(as->bus), PCI_SLOT(as->devfn), PCI_FUNC(as->devfn));
>          return -ENOTSUP;
>      }
>  
> @@ -2510,6 +2529,9 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
>      s->iotlb = g_hash_table_new_full(amdvi_uint64_hash,
>                                       amdvi_uint64_equal, g_free, g_free);
>  
> +    s->address_spaces = g_hash_table_new_full(amdvi_as_hash,
> +                                     amdvi_as_equal, g_free, g_free);
> +
>      /* set up MMIO */
>      memory_region_init_io(&s->mr_mmio, OBJECT(s), &mmio_mem_ops, s,
>                            "amdvi-mmio", AMDVI_MMIO_SIZE);
> diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
> index daf82fc85f96..38471b95d153 100644
> --- a/hw/i386/amd_iommu.h
> +++ b/hw/i386/amd_iommu.h
> @@ -408,7 +408,7 @@ struct AMDVIState {
>      bool mmio_enabled;
>  
>      /* for each served device */
> -    AMDVIAddressSpace **address_spaces[PCI_BUS_MAX];
> +    GHashTable *address_spaces;
>  
>      /* list of address spaces with registered notifiers */
>      QLIST_HEAD(, AMDVIAddressSpace) amdvi_as_with_notifiers;


