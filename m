Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6723BC3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 16:07:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txpkc-0004QL-TW; Thu, 27 Mar 2025 12:06:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Thomas.Lendacky@amd.com>)
 id 1txpkb-0004Q1-No
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 12:06:37 -0400
Received: from mail-bn8nam12on20612.outbound.protection.outlook.com
 ([2a01:111:f403:2418::612]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Thomas.Lendacky@amd.com>)
 id 1txpkW-0001RG-4P
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 12:06:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BsdjeydXisOdV3yj3J3kVsPAPYeHQhLWgGZSOSQlceRtG9LKmz7VIFQY7q5LB/bNhQD0pR/VjommYSh6U2Hp/UbpXG+EuGqdbrMmRUvqP6cZqXPtqXoJwWRO+6tPZPPwQ2YCqFHi7mdeRXo2dt1AeRnqTE/w1OzVJJuAvuTpj+GZK3gr5dV6mPN5Ylsyxa0x4B4t/MJRI19XyUPVAIUskT2KKWulSv52ZOyrq+OqZqWLN0c2Rl5EnxAwdsU1zCPh/q7uKKXy2epmRBcdEasDf+fqyk8fD8u5BjIO3PUds2+Dil109F6EG7MelJo4L6LOBFJpIUniZoWWDYVNLI81wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLfca9q+sCJl0ilN6VjoDfl6eLY17gbvkbcTUA8x94c=;
 b=Tl4iBBZHDbRCQBxHbhLel4SXo/T10BY8OKMDFHz15JBPxQGo1w2tom2Hfm+g6qKXJ21AEm/yMIzxt2RJIvN6WiEClYY1eyPIMQmmS3PruuANM3jPcFBGJTpmYBftGVY21duVstniHPjl/eO8luKnwu+7sD+1NPJseNPdzyeM9dObNdbNG1cbfPOvizjcd1yMiBLwG6dBK/Fy9tVluhmP3hDwN9yT8mrqekg2iOYZtCgjTuaZGzsHYOOvWCZ/g2uarDJqjzpN5cmP6F9TyurXC+5xRf8DkSbgn0pOpPiGiYEZKJsK7M1LjaubZrXchw5xKGMhuVwLllmKfiCyuWAXeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLfca9q+sCJl0ilN6VjoDfl6eLY17gbvkbcTUA8x94c=;
 b=Cpwo6OsFdVmTePxUb6feiVQf2kb7roKrFNH8gqwX9BQi7pVkkNSGl8gWSEB4bLrbLIauYhwpXBbcaUFVUkDyAs56k+ojWgQ7YZJR19L2TrU/vmEkn9p2Mc7v7k+x/9hrIV0uUKfMQkM/AqKb5lmacy4BPCOfBuplGcVt9KK3tmo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by SA1PR12MB6894.namprd12.prod.outlook.com (2603:10b6:806:24d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 16:06:25 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 16:06:25 +0000
Message-ID: <5c565c76-669a-2235-0ffe-edffbc3f1d39@amd.com>
Date: Thu, 27 Mar 2025 11:06:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>, Michael Roth <michael.roth@amd.com>
References: <1743087130-429075-1-git-send-email-steven.sistare@oracle.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH V2] migration: cpr breaks SNP guest
In-Reply-To: <1743087130-429075-1-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR02CA0022.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::29) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|SA1PR12MB6894:EE_
X-MS-Office365-Filtering-Correlation-Id: b0e92ce6-9a24-4a96-de1b-08dd6d4952dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QnZLQWlFOXNvbm9KSEZvL0NnYVZyKzUyMWN4c21TYkJsK29vNUVFa2ptY2RR?=
 =?utf-8?B?UGZadVFTeEp1ZjdHTFhRTXpjZ2Z0NXVDdjRWWmtzQUI4WmlzcGRMWWxlOGUz?=
 =?utf-8?B?SmxoVlVKc280Mmh0eXdON2YyMDJESGE3YUZveVNqc1lOM2FxTTBlQ0RzNXVq?=
 =?utf-8?B?OTJVcno1TVV4QW8xVkdFWHM5Z2VjUG1LdTRKN3dUUEw5ZHJUQ0t5VHh5a2dQ?=
 =?utf-8?B?TWZKUGc0SXZzakV0T0Y0V0Jta1lpbVp4VlJ1ZWZmUCtJNVpkY2JudzJOUlgr?=
 =?utf-8?B?bzlhMWNYYit6N2JWQTNnQlVJUVNLdmMyR09aVVM2ZW9MYy9OTTBiV0h2Tk5F?=
 =?utf-8?B?akh3K2txZVM5dzhVNE5sZFFOTlZwVkxad3VOT1RySE9sY3FrdllJY01QRjA4?=
 =?utf-8?B?N1BKbXZJYldPSlJFWVBkdnJCMS9YZlpSaTd5WSt3R210dVMzU3ZXMVZuRmpk?=
 =?utf-8?B?M0cvUUZrQTgvWlZucWVPY2Q5eHVMSVlFUnVHRExhc1BiMWsvWHFHbU53aFRk?=
 =?utf-8?B?bEhQUXdQS1VxbEJQNG0yR3pYR1d1ZVZLay8rdXViemNsdFh5ZlFrcVZ5MzRZ?=
 =?utf-8?B?L1d4L1JOdW5hZmVmd0MvT3hrTjhjcFBpOXF1Vk1QZWVvSTlUL0RqbUQxY2Z1?=
 =?utf-8?B?bHVReTlrb0dLZEpYVmdqdmMzU0hBSkVDRzNzQ3RDTU1iVGxQOUVKdktJdUly?=
 =?utf-8?B?OGR6bm1nNjYrYVVVNjc5MnpYNnRQVzlYWS90RFdkYS9KTzhNN0pBK1l4SVUx?=
 =?utf-8?B?S0hVb3pPemlvL3MxRFBQTTUzYno1TlJCdVJmd1VpRldyQXNhNEdyZkRvN29r?=
 =?utf-8?B?Y1lod01kOERDemx6WVY0VG1kZ09WRTc2M1RsY2h6YjJvNDRVMWJRUVdOREdN?=
 =?utf-8?B?T2FFenNOSUhqSlNDYUdKZzZTNTRiSWFaWUw4aGFxTEZUK1hSMUlCbWdDZ1ls?=
 =?utf-8?B?cmJXSlpCNVZaKzNMdElraFFUTGV4eHFKdjVwZlQyZWZ5elpDY2dTK1NtOFZF?=
 =?utf-8?B?dysrRHJIcy9pVno3dFFocUFJVCtrL3ZsWUtJMUpqM0hTcXQwL05uSzB2dm00?=
 =?utf-8?B?Z1V6Y0F4R08yV0RQMW9QSmFzVUQrNkltektzVEZIbmxrenFnUTBrMFF3RmYx?=
 =?utf-8?B?RERaZjU3Q2k4RkF1dFE1cFJPR3VJanBSVEwyY29wZlpRR2tmbFdkQ3A3ZVlr?=
 =?utf-8?B?YzlnZ2krcmhlNE1jdU1zUHV1SVZ2T01hQ28ybzJNdjVxclhaRHMyeWcxbmV5?=
 =?utf-8?B?aFJQZDQ3bGVxSDVDY296K1duQjh6b3RETm45YlBPdEtyUEx5VWdRaDdyK0Y4?=
 =?utf-8?B?dElzS2ZMRlY3T0M0OU5admFKKzducFJNdnA4NU8wYzFIb3JvTjZjN2dnUWo0?=
 =?utf-8?B?OUhEUktMektTUUdJR204ekQ2dHgyUWRVbU5KeE1RWnRLMWxPK0ZqRUhIRHVF?=
 =?utf-8?B?YmkrQ2tvYUFCR2hLcG1XYytvdDM4NUROZ2R2WXhSQTdQeFUyWjlzY29heEdo?=
 =?utf-8?B?eE94c3NGTnM5VlhadFIwalNGeFhCek1MSmVQYXozZ1ZQdHdDbHhyY3hzeU81?=
 =?utf-8?B?QVVDSXZnS0MzOU9qcm9PSTZTeGFwMFJReVNpVWV1YkdjMkltd0JFd2YyL2tn?=
 =?utf-8?B?WmpEclNkK1EvbjlXS2ZvUzNYYzdNc2pHcC9LZC92NFFUc0RibTZvSENUNUFq?=
 =?utf-8?B?UnRFSmQzMmRPdHlnRS9sZ3NhcU1VWm9Ea3dtd3ZXWndmVythQXJJN083ZXRa?=
 =?utf-8?B?SVVibElFOEp4TmR2OXFkekI2dGpPZm1rK05VNkRXUTZlUC9NSDNOMnEyMjhX?=
 =?utf-8?B?L2tGY2hiSmxibDY3eTZjclgvdW9XeWswa1ZxOWtkN0NHZG81a045ckhKNG1X?=
 =?utf-8?Q?avEPrqpiGK5mU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5070.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1RjYnMrdTB6bWo3L05RT1NzWnVIT3p6eGpXYllaMDJWUEMrRjlwb0pPc2pp?=
 =?utf-8?B?c0RENkdsM25wdzRmUzV1OEFJbE8vV2pwZDlKZ1lJcllsU0RNMTNYbTh1c0Ez?=
 =?utf-8?B?NDV3bjI3eGNpMTMzRGdBL29FMW0zeUQvK3dVdjIyNHo5UFgyQ2VwK0VlYTgr?=
 =?utf-8?B?VE15YXlUaUZLTk5rN0k4Y0ZmdTlucCtyQ2xvd3pCaUo5TG1tcGFSNzN1emFP?=
 =?utf-8?B?R2F2SHo4aitmUUhvNnZZWTROYWNZQzhZbU5PY1ZJSkU4UXc0emd6MG40c3ho?=
 =?utf-8?B?RkFxV1E3TEU3WVNWQ1U2dkVkMHdrMHVQaEtoaDBTbE94T00wQi9HOFhrTkdN?=
 =?utf-8?B?aUh1T0pKNWkrRjRBNXpTbnpIME1GWWhKNmxzWlArOXFiN2ZjQnlydzBmTFgx?=
 =?utf-8?B?dGRFR1hySm10Sml2cW1mN1dZT1dmR2RlTHFSRHMyOTJHa3cxcTJyTXNiMks5?=
 =?utf-8?B?OTZ2THB6UEpCV1ZJUHE5blNIN2lWRUZpYmlYVHFzTzRWY2FiVkVKNnAvVEhX?=
 =?utf-8?B?MXpqczF2b28rNXEwOGR0djRHL3hESHgrclR3QU5sbjVEY3JGVlJyeVIrRjho?=
 =?utf-8?B?dnJWMjhuL2JvL2Z5QmhMMU1mMlZ1OFNnanBHaTg5aXd3ZjczeVlXOG1RQ1ZN?=
 =?utf-8?B?aHZZRk1xV3hidzRHK0hLN2lxN2ZSMU9KbTh0RStvVmk0L1k1OUFzeE5XY2VR?=
 =?utf-8?B?MzNnbVlBT0NZK3lyNEFDRHIxM2ZTeWFaVEFVMGx1Ty9JamF1dzl3YmxFdWF1?=
 =?utf-8?B?QTlCM0NSR2RieWFTa2luTzY1Q1hZdlF1QkRNWmtVUDdHaUNUN0xubmVjR2xP?=
 =?utf-8?B?N1ZjSE13UHAzV21sbDcrYkJQeE9TcjJ1Q3JjU0lHYWNNOUUxendhK1JHZlhx?=
 =?utf-8?B?em91eEtuSEdQVmFWbmdYU2NpUEpxQ3BlOU1JcDg0cEh1SDhKMVZYQ2Qzd1V4?=
 =?utf-8?B?bzczU3I5d2hwaGxiRjRvUFQ5SVF4T2RtVExmeHpaSGZ3Y1laQWNyWlpiZUhN?=
 =?utf-8?B?VkpBdHp6U05WYmhKc2pYZkV1NVpNaEFQZ2tvQ0ZhMFZ3dGJKLzRRQmwxbkh5?=
 =?utf-8?B?YUxHRlZvU0dHN2RBWnR3VWNETU05RmxseU1lTHQ2ckdCRHp1ZWl3aDR5bmEx?=
 =?utf-8?B?OER2ZHlReVBEYlRxbWprL0NGTlZmbjdaQ2F4TnJES3RabnBkNU1DZkoxTGgz?=
 =?utf-8?B?MldLV2VuZlAycUtaZ1NDbHhWd05naTVmbnF5TGZMb1R4ZE9QdWhGVnoyWm5p?=
 =?utf-8?B?STBjbk1FeFlFL2Zmdm1FOFJWWFUrMTNORUhGZ3JLbXluU2VxRXRPREhIckJG?=
 =?utf-8?B?Szh6UkF2Z2VMS010V0hJT1k3eTZ5bkRsQ3V0ZGhEWnNESUVJam1SMTA1emdr?=
 =?utf-8?B?YjBOQTJkMGtrb1VCOGdxQTQ4dW1GYVFmK0ZzOTlveERRTFppU0s0ZzZ5WXZ0?=
 =?utf-8?B?Q3hGSEIvZzBmMkFvVXJrME5XSStJK3lGT0o0czM5Rklaazc0UjlZc2hhYmcw?=
 =?utf-8?B?UlFaajErZENMM0ZwbXd3YUdoa3FXU083WHhQSEJZNWxNd0tKbVVpYmNRVnNl?=
 =?utf-8?B?MzZOaFFYbWpUU1EvYTVoYkZOT1RqK2dibEpIakhrTTBVOTJDRkhzVWZ5Q2RI?=
 =?utf-8?B?Q1U5NkF3MUpaS1RZVTUwZHNmOXVYTGRZbk1hVzlBQ21ybVp4M2EyVGR0b1dZ?=
 =?utf-8?B?MGF4OGtJM2RMWUNSbEo4TjhEMkhDTnB6aXBsQTU5WWgyYzhzRGNLZ1NvdEtu?=
 =?utf-8?B?MEFEUkgrdkwxWWJNRlFGQ05CcmgvNnVYakRPWDJBVUlIVWh3NU5jcHFHbmVC?=
 =?utf-8?B?SklSZHBEeGEyRS8rcE5XUU8rNHZNbzhpaHFQKzVXMjMya0Nvc2FzZDhTMm5I?=
 =?utf-8?B?ZVNjSldTTG4vM1hDaXJMc29WKzdabDdpUnV3WEMrZWlFWDFmM3RaU1JDcUNM?=
 =?utf-8?B?a3pqWHR6MTIwalE2a0IyT2xPM1ZhbUIvZzdYOVZXeDlXM29GbUdQbitUdzlY?=
 =?utf-8?B?dWlVUVEyck82THd5TDI0S01qQ2JnaGI2UFJXeTZ0NnZCV3Nvd0FIUmcwODNI?=
 =?utf-8?B?eEMrVHFtSURqMENFREh4Rnc4WCtsdmlqMmExZEE3amZrRk1laFVRQWd0a0Za?=
 =?utf-8?Q?BLDDDHK422hpGOmpa28ocYF/W?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0e92ce6-9a24-4a96-de1b-08dd6d4952dd
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 16:06:24.8481 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RgnNTyVUo7AbU9Gl8wCu075N/40XjPHkR7dCApEwg66XT8dZZC2exOy518793X462BKai4q0FsGrr4pSww/05w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6894
Received-SPF: permerror client-ip=2a01:111:f403:2418::612;
 envelope-from=Thomas.Lendacky@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.943, SPF_HELO_PASS=-0.001,
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

On 3/27/25 09:52, Steve Sistare wrote:
> With aux-ram-share=off, booting an SNP guest fails with:
> 
>   ../util/error.c:68: error_setv: Assertion `*errp == NULL' failed.
> 
> This is because a CPR blocker for the guest_memfd ramblock is added
> twice, once in ram_block_add_cpr_blocker because aux-ram-share=off so
> rb->fd < 0, and once in ram_block_add for a specific guest_memfd blocker.
> 
> To fix, add the guest_memfd blocker iff a generic one would not be
> added by ram_block_add_cpr_blocker.
> 
> Fixes: 094a3dbc55df ("migration: ram block cpr blockers")
> Reported-by: Tom Lendacky <thomas.lendacky@amd.com>
> Reported-by: Michael Roth <michael.roth@amd.com>
> Tested-by: Tom Lendacky <thomas.lendacky@amd.com>

Re-testing shows this still fixes the SNP launch failure. So Tested-by:
tag is still good.

Thanks,
Tom

> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  system/physmem.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/system/physmem.c b/system/physmem.c
> index e97de3e..333a5eb 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -158,6 +158,7 @@ static void io_mem_init(void);
>  static void memory_map_init(void);
>  static void tcg_log_global_after_sync(MemoryListener *listener);
>  static void tcg_commit(MemoryListener *listener);
> +static bool ram_is_cpr_compatible(RAMBlock *rb);
>  
>  /**
>   * CPUAddressSpace: all the information a CPU needs about an AddressSpace
> @@ -1908,13 +1909,18 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
>              goto out_free;
>          }
>  
> -        error_setg(&new_block->cpr_blocker,
> -                   "Memory region %s uses guest_memfd, "
> -                   "which is not supported with CPR.",
> -                   memory_region_name(new_block->mr));
> -        migrate_add_blocker_modes(&new_block->cpr_blocker, errp,
> -                                  MIG_MODE_CPR_TRANSFER,
> -                                  -1);
> +        /*
> +         * Add a specific guest_memfd blocker if a generic one would not be
> +         * added by ram_block_add_cpr_blocker.
> +         */
> +        if (ram_is_cpr_compatible(new_block)) {
> +            error_setg(&new_block->cpr_blocker,
> +                       "Memory region %s uses guest_memfd, "
> +                       "which is not supported with CPR.",
> +                       memory_region_name(new_block->mr));
> +            migrate_add_blocker_modes(&new_block->cpr_blocker, errp,
> +                                      MIG_MODE_CPR_TRANSFER, -1);
> +        }
>      }
>  
>      ram_size = (new_block->offset + new_block->max_length) >> TARGET_PAGE_BITS;

