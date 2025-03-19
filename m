Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CEFFC35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 12:38:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tusgH-0001nv-2a; Wed, 19 Mar 2025 08:37:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tusg4-0001nP-Q8
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 08:37:46 -0400
Received: from mail-co1nam11on20611.outbound.protection.outlook.com
 ([2a01:111:f403:2416::611]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tusg0-0000y3-5f
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 08:37:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wxaOraIQzFQmQDIu7NJzTi2Uw9eK68MCuN6IIsSH+OJLFU3/vxfquRktgiiVjlNL1w1trEyNQqZQ9U67P+GwKJliysYRi8upi+4zcFE1mUbJgFeedwgBCx+Guh6gAbMQoVpC/FDqbJs8/9woytltnv4mXUmfSoVw5ZnIDfB0cPow8YgSlhbS9nIhLYdphEhTmzwSLLIxu/6jGeID52177eEYIRoIbTXmPXpXQcgKFiVMxOdaXl4EBd+xWvIdp3AlY/mlEfyu6qRWJTjLAIq8DbRlVnZiabz73vBnZcHFvaTHzxewgAxqdbRFIwHHgS091axCQEEDkER9PJv8kuv3UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PbquY8x3IpRyWGE3vMBvcbQPFTUVzvlb0CMih+zzQ4E=;
 b=ChPYGvXkWIbV1i0i5JMNdqHbwM47nhmazbXqa3sp3Was/8N+92jYhaftX+b3vbT7wZIX9CCUMmWZixmaIvKNkbb9St0JAJ/cp4lJN7YD8q6W+0Vo2f9lYyz8ss4+a3etVgl7rZZ5gaA/XNgZFdDAXc+o+bFtI2A4oDiU/QFaXkTuOQGwlBhwV1xlQi68MBwpZPZ0+nRsDlsMc485kL7NKKBJ4UeS8dHxZLTP01N+b5TrkXd6SZtGUg87qJLLl9Y11TFbWiOFuQ+a2jD3HA/lWxzoxC7LZmdg109J3SRuYhAkhw2n8ihOXxlOC43hWoql7z0RnJjhN1cwdOGKLgBMxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PbquY8x3IpRyWGE3vMBvcbQPFTUVzvlb0CMih+zzQ4E=;
 b=a6oQPsOxi/GDjJ6ae7V01sq+xxLZMhbk8zSbMa6qrTp3AZt2eq8OvD2vfUI9UtzKKGOGJPxYZvFKzwRruvWfFg8ehYucSAODMK6USjN3RBRjc+eoRA4Gj6sHq9/vib9rKJmbhcdB1741rCNQi2oIaPJtoI9/AQPeUbzRrhgDajPfDydFmU7XDLTjlJXCwqQf9FnrnyLL0TQOIJmhp0WQODYqH2gX3XOQORV0elsROXu0UMG+BalhLWVZYK04xpGfOZtjvqCMN6oVfPRTb07z+Z7CvciEEQpSmsL3CeLeKptQFeFTSzCBH1yOlilDActkgQg0J9Ui7mYsBQfP8i3KOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by IA0PR12MB8328.namprd12.prod.outlook.com (2603:10b6:208:3dd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 12:37:30 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%5]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 12:37:30 +0000
Message-ID: <df484075-f6a0-41b5-9c7f-c4817c160489@nvidia.com>
Date: Wed, 19 Mar 2025 14:37:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1 03/32] vfio: Introduce a new header file for
 external migration services
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
References: <20250318095415.670319-1-clg@redhat.com>
 <20250318095415.670319-4-clg@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20250318095415.670319-4-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0123.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::15) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|IA0PR12MB8328:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a42f6c0-7588-408b-6717-08dd66e2d05b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L04ySkRtWXFOQWZhZVAyay9HQm45blZjK2xTZkE2RURtMXlSWGxlbzhRVFh0?=
 =?utf-8?B?bWlBVzZ4OXVXM09qOXlwMXlqa3B4NDhWQm1CaGsvSmFRMkgwem9uaERQdk9a?=
 =?utf-8?B?NmNNMXNhUnhYRmV1ODZXVlNxNWdCWk9LSksrWG0rRW1lSmExVzBPQW5BRnA2?=
 =?utf-8?B?T3JyN0dDTHRMRWpZUjVoQUdwNWlZV29BeXphZkFPVmdIY3Rqb1I3QjB4bEor?=
 =?utf-8?B?QVY3V0NnSFcybHR5ZDhrQVFUYU1yUnFnQnduaWxUTE91TCtNNE9iL3JyY1ll?=
 =?utf-8?B?UlcycXZySDUyeTV2UldWa0d2ZDA5d240czVQTEM3czR1NlVsVUZyYmpqUDNB?=
 =?utf-8?B?RmdpRVZxdDVpakljSUw3MGdWMkRON0QySzdUYjJtVURvZ011aUkxUmo2eUpT?=
 =?utf-8?B?VFR0eEd1NEhsandiK05vU1JCWThwZk9VaDJHai8vSllrTWF3cGMvVUZqRjBi?=
 =?utf-8?B?Q1RRUVJidFV1b2YydmJpTVl2R2RCUE1SUmd4bHhFaDFSODJNSFpnZzY3SktU?=
 =?utf-8?B?dzBVeGVFZU5PZVhESGxoZG0rK21VdlF3MndhazM0L0IwN1NnMHRTQWd4VENU?=
 =?utf-8?B?SHFOSXYyWGlFQzFpZVp6WFVHOUxpZ2VWeWltblMxOVhyQWQ4VjRQNmV1ZkdW?=
 =?utf-8?B?bXFac0laVW1iREpFNjMwRTlRMFlNeExDdFR5WkxIR085SkwrNEM3ZUJiMmgy?=
 =?utf-8?B?YjdQZnJWKzZRRVJsZmVucnEwOGxISldiN0RJbmFSYUppQkdvd0lMMDN0ZUVr?=
 =?utf-8?B?RTdVWWlKcDNEOVk1NjNuQ01MdCtrb3dURXo0N3hZOFZJRlV4QklzUUpHdlBi?=
 =?utf-8?B?dTRESkE5dWFJQnFEOVR2QW5jMUlUZEU4cDFmS09aNzhTaWlHeXFneDBVK2hq?=
 =?utf-8?B?Q1h1VlI1Z0FTSlZCRW9RTXMwc1lQejNtTWhtLzRFTkt5a0tlK1dXdWxqV1lN?=
 =?utf-8?B?OXpZc1A4QVVuRSs2ZitCRU1paUlBNFRXOWdQcDI4bm8yWXJ3Y3FxUlBaNUpO?=
 =?utf-8?B?TWFSTzQ1QWdOTVVhcTc5MEpwSVErWTlicVFzelBQUHNGbEg5V0tFN241cGpp?=
 =?utf-8?B?RzJoZnJrM2dTbVc4VmsvZkc2cm8wV1JzRTg2a2lmNlIyZlVBd2ZHT0E5VHNv?=
 =?utf-8?B?K3RhdU1kRFN3UXoxdW8vOTBzeEFzb0FlZ3kzaERQckhxRjI2bllCMVhZWkhS?=
 =?utf-8?B?a0QxNENyNisybjF1a1dMdDdQamJHL2JDdXEvTytudG53YnVpYjVqdjM3azI3?=
 =?utf-8?B?WXQvc3ZTTmd5Z2UwQ0pTZTZCZDJoOFBUNDRaOXdvb29yZ0RjYnM1RE1jVXVR?=
 =?utf-8?B?MldyRzVia3EvQzVsQXdQZ1BEYWxONGV1Vmo5dDU4dXF3M1VoVndhQkRLT0Iv?=
 =?utf-8?B?eHNxdVVRd2VPZC8rNkEweGJ2dVdVQXJtSUtxTUFDSlRnTWV2TXJCcUlwSXMy?=
 =?utf-8?B?ZEE4cVVvWWo0MnVQNmZnMUxXZk5VV0FFMUtIQWVYclUydGRoSHZnVHFMUVVO?=
 =?utf-8?B?OTZpcGpKdnR4VFZUajhPd1lHc09ZRGV4SkRqckRaSnBqMkc3MnczSjBvdm56?=
 =?utf-8?B?eHBNT0xQazJHanhHaXZVUlYrQjR4V2tHZjIvVzh3K2hJcGxHNjYvaHpYSFhM?=
 =?utf-8?B?YU5XSENDZThwdzlpMHdBZHlDTGlqaTBmSDhmdWtXUklnZWxDSDRwbUJwaXFh?=
 =?utf-8?B?RDRUMDhQMHhjc2pEMWFoaFJXbWhoeFlFRDJtNjN1QzB6d2VpbVFXOEZabGxZ?=
 =?utf-8?B?ZkN6MHlteE5VV3dQcG9MMlNoRmVuUDQvZGFxS29MNkVzRnpyNWdvazdBMHlK?=
 =?utf-8?B?N0w3Y1g4bUFya2VPbXVLZDVLMGpkcXgwaVdLVmJCUE5aaHl6RFJreVNZeC9N?=
 =?utf-8?Q?GS/RmbvH+DNea?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vy9BUk50bm5OOHRFRVE0VGNxT1l5d3lHNFZXcDgwWW9UQU5oaW9MTzZocDdQ?=
 =?utf-8?B?TWNNVGJDM1BlQ1lIb1VYUnRDaEpMQ1A1S1dVMU00YlowcUZwanFSV2Zzems2?=
 =?utf-8?B?K2szbTRtcFJhQmY0amlnZFBTSWh0b1c4OWFSUnl0MlVtbUFlOU5VVkJQdlYv?=
 =?utf-8?B?bmtCdEVhYjVPMXVKYWs4YTZuazFjeFJQMmJORnEwNTFiVGxaSTQ3Y3Jhdmlw?=
 =?utf-8?B?bkVpRitSQ25pbDFRNzR2OXNOeU10Rmp2dXcwR0xDemlWK2N2elVldWdmalov?=
 =?utf-8?B?K1ZjU3ZreDgvTzJrVmxlaVV0Tko1ekRjQlltbmU3RHNIM3JFbEZTQmVXNWRt?=
 =?utf-8?B?WEpHbWd6WFdGRHdpSi9JbUlIekkxbFdoVHdkMjlmMkhnQVZ4b1daQklvZG1p?=
 =?utf-8?B?dHRFbXhaWWZYOCt0L1oxb3RUUDRQTmU5ZFNIUE5sUmZpOGZsUE9BOG9MbjZt?=
 =?utf-8?B?a1ZkZnkvVkxycTZoVTNOSnBaRVBINk05cnNQQ25kMVh0Ylo3TmI5ZGVMdm1G?=
 =?utf-8?B?eWo5UDFVM08zS3V0RXRqak1KQ2VmL3gyRXdyQmo3dmZKQVdlREpRSlpDSitT?=
 =?utf-8?B?dEJnaWp4RnJmUC9QbWhBTG9HejRyRUxoU0lWUDdJemxhWU9mY2szTkRjVjBU?=
 =?utf-8?B?STNFNUVLSlFSYlQxUzIrK1pFMURuVFc0aHhPMHlCWkQ0QmF0bnBDR3NuQmNW?=
 =?utf-8?B?VjJsUkJHLzJnYzZTZ3hqSUdiekp6WWZnWWpzVVoxMHArajZXd1pFRk9DblBI?=
 =?utf-8?B?Q2tldkFlUnVMV0VFV3NtMVh4Zjg1R1k5R1RQU1BmK1pBT2RXeGxkMWJnZ2I5?=
 =?utf-8?B?UkdPSzBqanZJT3NCd1Jzcjh3M3pBOEx4Tis3ajNwOGphVnNkaHF1ekthK1RG?=
 =?utf-8?B?eWQ3YTluZjhZUjJNNXRHY3lYYWM0VUhzSisxVXZpSTVVVXVNLys4QTNzbmRQ?=
 =?utf-8?B?TldBTmh6TDIvSUI1SHlVWm9LTzlhUlIzQUtKOHcvYlRvbFZBMkFidlR2U01Z?=
 =?utf-8?B?Q29QWFNTVHFSWWdWYWJINUJ3S3R2ODVCQWpLQXIwTDkrQ0FERjg1VkluNzNx?=
 =?utf-8?B?RlFhMUJmV1ZKbFc1QVpScGNIR3ViY0llZkt4Z08rWWVwUjAxQUloZXhuNGZi?=
 =?utf-8?B?OUpmalZjVDVHaS9vYXpITEVSdDFJMytCVXlHYjFGdlpJWWpQS3FDUGg2VEZz?=
 =?utf-8?B?OFVVRjhvQWVONjVRcjVocnNLUi8weVR3b2g4VTJYVkNFSGZaY0hMMUw3TWFa?=
 =?utf-8?B?d0QyaHdMRCtCUG5BdjN0WnR0Rmk3MUN4NE5CellmWnJNTnhaY1d2UGYwdkd3?=
 =?utf-8?B?VlY0Z2F5UHo2K0NaM3VKL2N4NGI4cHdIbUhwMFpqVkdINE1tdG53T1NUNk5M?=
 =?utf-8?B?Z0RYMDZzUVM4THRRdjMxakNFQVRPYlY3MGJQMmVUb3dFNTBia3FwZjBuMUc2?=
 =?utf-8?B?UDRZQVJzUGRvRDVSRktUYlVraUFLbHg4cmtOS1JpbUFmNCtsdFVzaE9YUnVQ?=
 =?utf-8?B?VEdTUGYxd01yNTkxUGlmSDFoV0NyRC8rZ0N2M1hnNE05eEYxb3FjdlZ4bXda?=
 =?utf-8?B?NVN0c3dHamVQUzFZOGQ1WEtoMlNuRVZ0UmhobWdtZCs4azNHOTIwRjdCaWdj?=
 =?utf-8?B?SjhLSW9GUFE4M1hNaFI2MnRPUnk1OHJ1ZzJzaVpHY296cHFVanM3MDN6clBH?=
 =?utf-8?B?ZDVnalZjd2RGNnp3M2wwVnBCb21ZVU9DYkJjcmx2M1BnUGtSaEtUa3l6L1Mr?=
 =?utf-8?B?VEtXVjZkbVI5ZHFHb1A2b2d2VnJVeHhQZkNab2xzZ1dsZmR4d0JQVHRBa2FO?=
 =?utf-8?B?NUl2NFptVU1SVDJJbGtQdUFCejM4dVNLWXd0aTN3dUR2TTFSNXNwd3dwaUtM?=
 =?utf-8?B?V1FQdGMveWxhek51ODE4dzZzcnVONFpIQzNzTGtLOFJTSVpBejV1SnRyMUEy?=
 =?utf-8?B?UVdCZWNUSzFyQnBwNlhldHRtbVpaYUFRczZDVkNxdnZxamhEM0c0ZFJUbDlh?=
 =?utf-8?B?WDQ4UUhndXlyOVlyMjdJV1pWb1FLZHZxeUxLZTdRNjc2RFJFNXpiWVRSZCtZ?=
 =?utf-8?B?VTl5WHdteEV2SlNQOWxHTzl1eUlISHRNemJod0wvM2ZINnJKYkJSOFNpbXRE?=
 =?utf-8?Q?fWIvBLxKPxNZ6m8o1NQ+5bqh1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a42f6c0-7588-408b-6717-08dd66e2d05b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 12:37:30.3252 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9GeN8edx9x4WJltE+118RJpUAuI5kvc7RPDefAlmTVUZ7poPlbkIMaATKDCsm1hhSIdUDIhr/jLRE3Z8IuxIPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8328
Received-SPF: permerror client-ip=2a01:111:f403:2416::611;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
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


On 18/03/2025 11:53, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> The migration core subsytem makes uses of the VFIO migration API to
> collect statistics on the number of bytes transferred. These services
> are declared in "hw/vfio/vfio-common.h" which also contains VFIO
> internal declarations. Move the migration declarations into a new
> header file "hw/vfio/vfio-migration.h" to reduce the exposure of VFIO
> internals.
>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   include/hw/vfio/vfio-common.h    |  4 ----
>   include/hw/vfio/vfio-migration.h | 17 +++++++++++++++++
>   hw/vfio/migration-multifd.c      |  1 +
>   hw/vfio/migration.c              |  1 +
>   migration/target.c               |  2 +-
>   5 files changed, 20 insertions(+), 5 deletions(-)
>   create mode 100644 include/hw/vfio/vfio-migration.h
>
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 9cfb3fb6931e71395ef1d67b0a743d8bc1433fdc..5fc7ee76573375bc8464baee29ab88974fac3d3b 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -290,13 +290,9 @@ extern VFIODeviceList vfio_device_list;
>   extern const MemoryListener vfio_memory_listener;
>   extern int vfio_kvm_device_fd;
>
> -bool vfio_mig_active(void);
>   int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp);
>   void vfio_unblock_multiple_devices_migration(void);
>   bool vfio_viommu_preset(VFIODevice *vbasedev);
> -int64_t vfio_mig_bytes_transferred(void);
> -void vfio_mig_reset_bytes_transferred(void);
> -void vfio_mig_add_bytes_transferred(unsigned long val);
>   bool vfio_device_state_is_running(VFIODevice *vbasedev);
>   bool vfio_device_state_is_precopy(VFIODevice *vbasedev);
>
> diff --git a/include/hw/vfio/vfio-migration.h b/include/hw/vfio/vfio-migration.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..259c532f64bdd002d512375df3140f291a0ade85
> --- /dev/null
> +++ b/include/hw/vfio/vfio-migration.h
> @@ -0,0 +1,17 @@
> +/*
> + * VFIO migration interface
> + *
> + * Copyright Red Hat, Inc. 2025
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_VFIO_VFIO_MIGRATION_H
> +#define HW_VFIO_VFIO_MIGRATION_H
> +
> +bool vfio_mig_active(void);
> +int64_t vfio_mig_bytes_transferred(void);
> +void vfio_mig_reset_bytes_transferred(void);
> +void vfio_mig_add_bytes_transferred(unsigned long val);

IIUC, vfio_mig_add_bytes_transferred is not used externally. Maybe move 
it to the internal migration header?

Thanks.

> +
> +#endif /* HW_VFIO_VFIO_MIGRATION_H */
> diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
> index 378f6f3bf01f6a4155fb424f8028cb5380f27f02..fe84735ec2c7bd085820d25c06be558761fbe0d5 100644
> --- a/hw/vfio/migration-multifd.c
> +++ b/hw/vfio/migration-multifd.c
> @@ -11,6 +11,7 @@
>
>   #include "qemu/osdep.h"
>   #include "hw/vfio/vfio-common.h"
> +#include "hw/vfio/vfio-migration.h"
>   #include "migration/misc.h"
>   #include "qapi/error.h"
>   #include "qemu/bswap.h"
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 8bf65b8e11094b8363692dba3084b762362c7dd6..75096377ffecf62b3bab91102a00d723827ea4c7 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -17,6 +17,7 @@
>
>   #include "system/runstate.h"
>   #include "hw/vfio/vfio-common.h"
> +#include "hw/vfio/vfio-migration.h"
>   #include "migration/misc.h"
>   #include "migration/savevm.h"
>   #include "migration/vmstate.h"
> diff --git a/migration/target.c b/migration/target.c
> index f5d8cfe7c2a3473f4bd3f5068145598c60973c58..e1eacd1db7a471cba51b4e257a834eb7581f9671 100644
> --- a/migration/target.c
> +++ b/migration/target.c
> @@ -11,7 +11,7 @@
>   #include CONFIG_DEVICES
>
>   #ifdef CONFIG_VFIO
> -#include "hw/vfio/vfio-common.h"
> +#include "hw/vfio/vfio-migration.h"
>   #endif
>
>   #ifdef CONFIG_VFIO
> --
> 2.48.1
>

