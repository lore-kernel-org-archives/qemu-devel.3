Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA8AC19F32
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 17:13:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnhRL-00019k-SH; Thu, 27 Feb 2025 12:12:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pankaj.Gupta@amd.com>)
 id 1tnhRC-0000z2-Pk
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 12:12:44 -0500
Received: from mail-mw2nam10on20616.outbound.protection.outlook.com
 ([2a01:111:f403:2412::616]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pankaj.Gupta@amd.com>)
 id 1tnhR8-0004cs-Hf
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 12:12:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L3pHjeuNK4XUYoJiyO0uMNHr9wmYXmSqlzTYebrSFtJ6S1HuEAnffuzY7rnlngpaM5cBiIROBXG8SEOL/yoDa5lzO+YyE7RffEaisOzztUp+CYi/Lj3gIzbT5/tWxl6LkmCyVBspujGkato3U+a5CaIrUZg0ot96fN0NiQvLm9LzzBhxfY/X8sN3R2r/jAqHecwGXO1EiE7YNnQFGVB0bBSteO8XHTS55fijX7vz/HNS/b7rFrEDs184YmAg7BnPCQVX09RfAnps/W3YYgfjZgvvrdWqExPAsE5atcF43aQXWZBJCnVKhpTyimk8MFavYuHLbIk2+tR+gMU9l983fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y7bnMxWT5w1YXrUlRa7K2/Ex/RGKia38qMwiEAXTcxQ=;
 b=yIDHqmazscsxs22WQCgTn2Ym3hmUCXd1yvZhsDmsqkfU75hcguOWqLUM/0U+UYPM/joJuIyyx3+FHRgOq5YGZhFTnqS6dxVWu04indWB8CSOctOJ30fTNd4hFJK0NF8/n31pFvVotubt8o/mz04t7h6mO98WTm2moR1o89EWG9vpfzT5ARY+zYXQD39noKj/TaYo5awCIrIdOevbpVh7+TxussGqpm31KHfge+R6On8zGEURG3TqagQ8XgLypNPF4tJpIc9Ki+JdSZQ413qYTuKncYD564MoKgkhLy6n9w5isPf9B2ERGkdc1YIVFYqVnde3BsH0p/HKZtXPLh99KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7bnMxWT5w1YXrUlRa7K2/Ex/RGKia38qMwiEAXTcxQ=;
 b=ihxOh+QX5cU7KgZUpYck8AxCHxNSF9aNAhbH1R6vzTJstBJig4DrvEZvDrPuLIMz+z15RRXI2kpZ7ZXcFz9s2as2frjbO4cf9XuKm3KzlnCIJjm/K5teW9F8vyRgxeimokHY/UNY7frub/o1jSxl2KYNxmnJQxb2Ri2TwWTquPA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB8189.namprd12.prod.outlook.com (2603:10b6:208:3f0::13)
 by DS7PR12MB6094.namprd12.prod.outlook.com (2603:10b6:8:9d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Thu, 27 Feb
 2025 17:12:30 +0000
Received: from IA1PR12MB8189.namprd12.prod.outlook.com
 ([fe80::193b:bbfd:9894:dc48]) by IA1PR12MB8189.namprd12.prod.outlook.com
 ([fe80::193b:bbfd:9894:dc48%7]) with mapi id 15.20.8489.021; Thu, 27 Feb 2025
 17:12:29 +0000
Message-ID: <2e477178-4ef0-4aa1-839f-d113e8855ea9@amd.com>
Date: Thu, 27 Feb 2025 18:12:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/16] docs/system: Add documentation on support for
 IGVM
To: Roy Hopkins <roy.hopkins@randomman.co.uk>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Sergio Lopez <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>,
 Ani Sinha <anisinha@redhat.com>, Joerg Roedel <jroedel@suse.com>
References: <cover.1740663410.git.roy.hopkins@randomman.co.uk>
 <633885c6.AXAAAGU1VIQAAAAAAAAAA9cBm3sAAYKJZwAAAAAAAC5ATwBnwHd1@mailjet.com>
Content-Language: en-US
From: "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <633885c6.AXAAAGU1VIQAAAAAAAAAA9cBm3sAAYKJZwAAAAAAAC5ATwBnwHd1@mailjet.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::13) To IA1PR12MB8189.namprd12.prod.outlook.com
 (2603:10b6:208:3f0::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB8189:EE_|DS7PR12MB6094:EE_
X-MS-Office365-Filtering-Correlation-Id: ce5b449c-3e9a-4600-e820-08dd5751eaae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VEdlUzkyREJ3RXY4Q2ZIQlN1WHZRQXVHbmZvWWhsSC9Ba2FHKzBpMXJnNHF6?=
 =?utf-8?B?YXk3T0x6enloWWZGSE9XVkM2cTNHVTBieHk4MnpFRWxjNTZmT3BpeDl0V3lX?=
 =?utf-8?B?T1VuYWE1ZGRSbnEwRWJCcnlJTDNhOWVnYXpoakFkZFRoZThIVXUyS0U0RXQy?=
 =?utf-8?B?MHh3aUV3VW5Vd041M2xaQ2NqZEp1NzNoZEJjS2MyeEJLNDF5R0ZsdkM0L3ZM?=
 =?utf-8?B?WENLNXFYT3phNFhyRytVb2FNK21MSHNyODFmSkFZc0FRSElpRjRBSFVDTFZ5?=
 =?utf-8?B?blJ3cVJibjZJNnZLYkhFRHZrZVZFTGEyVVhLUzZURGwzRHFNSTZ2eEdLT0pi?=
 =?utf-8?B?RElraXdhWGdQSmtyWjBwMTBsWGEyRWNlRUlzSEpqcW9BSTI3MCtub244UzRh?=
 =?utf-8?B?K29GekhlV242c1FGdXdOTjVNSzBjdklmdWRaTVVPdmF5eDVvMjU3QWEzNlI4?=
 =?utf-8?B?eTY3MDJVVnZEQUw0OFFNRmVSSWUrOXNNVERCclFib1NFazlzQ0pJMU12UlhZ?=
 =?utf-8?B?ZSs5Q3pLdHp6T3FUelNVT1NNNFhRaWFhejJEOTg0Q3RoWFFUQytqeU40QTBn?=
 =?utf-8?B?OTB6QUwyQzUyUXRGN0JYRkxJNEV3VlhPS0V5ZnV1aFZDZkdVUndaOGZaQjJ5?=
 =?utf-8?B?TmJPd3FxVlI1dVhaRHdEak93eWNUY2F1bXpCMllvdlNqd1dheFdnbTB5dHVk?=
 =?utf-8?B?UmVCVWhUUjM3R1VIVXM4S3BLY0FENkVrbUFaTEpHZVFpTXpOdXBsR3kwRmZS?=
 =?utf-8?B?M2hpUStNcllVNTRHVUl2WCt6UEZseU5JemY1cnhTd241ZjBxNUtmaTBoYlIz?=
 =?utf-8?B?VEJ5NEFkTEk2ZmFCZUFNZWM2WEVIb2pNR3pwaENRcGI1SkEvRW5vckUwMDNk?=
 =?utf-8?B?RDFUZHZqWXJYM0kxR1UyODYwSDZCdDBYQ2RSS0ZHbHkwQWtZRER3YXRsM1Rv?=
 =?utf-8?B?cklsUkhLNDNOa0hWOTNxSk82bmxzVU9VTmszV0xtVElzYjFTN3djNGp0SHZa?=
 =?utf-8?B?bWZGVkcyVFdoaUh4NmpuRWI1UUIyZHFzZjVDWDFiRWlwR1htYW9sdXhTZWZw?=
 =?utf-8?B?UUpSRWxSQW5Hek1pMlFWcGpLbkIvcFVGcjM4cUJ2aS9jbitacVVUemEyNGxq?=
 =?utf-8?B?dFo3aWtuYzdxN09wS0NVM0dkQkxyYjVudkowc0tVOFJMek1tektVYmlMYld4?=
 =?utf-8?B?eHJjUGt2bnViSDNDZjFzMGFuaVdvZ1hQcFFPdEhmdldNMGoyR1Y3VHhydng4?=
 =?utf-8?B?b1cyT0dvNWtxYkpkczhVVmhkcEQwcXRKVk5Wc2VhSy9FUmhBdGF3UWIwU2Zl?=
 =?utf-8?B?c2tseHlvazJ3YzFUSHNlRWppM3pWYXZPRExRV2N4RmZQaStqRFJxQ3lPSUZn?=
 =?utf-8?B?Y3Z2clJZcTRDNDV0WVlKb3BaQ0Vob1ZYb0taelBLcDVGUmowdnd6N0V2SXI2?=
 =?utf-8?B?aDNOS2VaUGw5cDU5aXZNbE04eDdLQW9QVTFlTTBPUHI0emtCb2NCT09GTkhn?=
 =?utf-8?B?bnZkYVNnMC9tcVBWblRZaEQxWUZGaHRIRXc1aWFiQkF5UGhxd2VoeTlEd2FQ?=
 =?utf-8?B?MklFTjFFWE1EK0F6aHA2MUZTclVPRCtSZ1RKYVpLTXJBS1hieXFKemN4elky?=
 =?utf-8?B?ZWRDQU9lZ2w3SVptbW0wTU1Sdjg1UXBvb0xpNWUwRFlJQXF3VFQzYUFtdnNy?=
 =?utf-8?B?bXJBWllLQ3R3WDBjRDFKdTB6d3VDTVRpOGozcDROeUVyY04xSDRENTh3Rm4v?=
 =?utf-8?B?azRXZDREdy85R0V0UWRmSFM3NC91R2VNOUZUUjRnQTNEbEt3Rko2TFF6ak92?=
 =?utf-8?B?eVdPL2VPUmtMY3VJMWljWUhmTDVnU0ltZitYeHZXL0lzRi93MmxVNXJQVVJO?=
 =?utf-8?B?aFBnaFMxUzhRb0tEQ21VL1ZvbXMvWldpSXFyWlBYZVRDeFE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB8189.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHdZQTE4ZWQva3RpU1FBR2RqOGM5cU8rRnBKS3Y1YkcwaDgyTWZybU5EOSs5?=
 =?utf-8?B?NmZONGRmRG1LSXpBeEppRDd1ZVVlTEs5QXJobER6cFNEWlFlS3FEN2JlK3VF?=
 =?utf-8?B?Z1Jpdis0am9vMHBMajl2UVF6M214eEtyUzR5VXZvcTRESjhreXVSRHNSaUxW?=
 =?utf-8?B?UGdOR1dHNEx3UkpmWTR2NS9WMGNzVHBkRlBBZjJkaUdlZnRidXRPTlF5TWFZ?=
 =?utf-8?B?bEpCMmpGaENjNGpzMXF1VVQ2WUd0ZU9zUVhXOEI0TzN6cnhab09NbFZsRlJw?=
 =?utf-8?B?V0hTenJkQUE0a3Bxdng0bDZFRXppcmxoZzFHdWZQU3ZIZGh2c2xWVGZWSGxF?=
 =?utf-8?B?YTBSNytSS0ZZd1JkcUd3S1UzQ1VPZG95VTRlQnU5T2xjZDFBZEh2QmtiZnd5?=
 =?utf-8?B?NzZKVTZsYndDOEFGd3pzSHdHRGppYmhSM1JJTmpteEZKU1pWQkoyT0FlcVVG?=
 =?utf-8?B?b2h3Mjd5cWg5TEZqalFCU01BWVBMTHE5M3YwTFhZbVVmcVlIOEJRN1dOK3R2?=
 =?utf-8?B?WENRbDRVQ0x5b2tSaFFDOXRMU0RFOWVGMmY3bERrV1VONThCN3FsZm1wVzkr?=
 =?utf-8?B?OXlEekhvZlFrSHRCU0gwZnBXdDd2S3UzVGp1N3l4YitMdGVzSzNERXFnNmJJ?=
 =?utf-8?B?NE1zd0puL0FsckF3OFJKeHhyMUc3STJJa0tHVlJWaWd2ZTNXL24wV2hCbDFt?=
 =?utf-8?B?VmMzZk92MkJmSUNoRDZpc2swSUdKbXhYb3REYmE2VGdXaHdCRlRpbVU1LzRr?=
 =?utf-8?B?RlJZbzRJeHZFN3JtVjBUbnhiR3BwS29XQ1J6MVVMZEFTUlNpNGVsSGVzQ1Jk?=
 =?utf-8?B?R0U0QUVSRGtMMjJ1K25nMmhqcUFHelNscVR0Vi91ZlFyVEdGVGxsczhiTjBW?=
 =?utf-8?B?NnpLbVRMUFZCOHEwUGJQa3JQaXk2WmJlck9PUnBFODZmcHBUQ3hXTUdYbjlN?=
 =?utf-8?B?Y1IyREd2VTU2VmF5QmxkUDBNRy9MR05lUFhBdmlNTUdyL0UxaHQyL2ZQbStW?=
 =?utf-8?B?MDhzVVU1Qk1ySVNyK0tpYmY5aGlidnU2Qk81ZjV2T3J2Z1IxcTFzcWYyRXFS?=
 =?utf-8?B?NXJBcXZhbDYvdnE3WEVwcC9CVDdsVXlwK3dZSjZkb21KVE9XQjdBSDRhRnk5?=
 =?utf-8?B?MnV6WE1Rd1lpWXRvODZod3VQVW1vOS9aYjE3QTJyNG1xbnc5TFQ3SWNoMnRV?=
 =?utf-8?B?b1M1QVluK1ZOQjcxWXZ1aDBsV3RuRG1SajkrRHpFVDZVL2wvK0R3aXpFTzk5?=
 =?utf-8?B?Vyt5YUt5aTlsRnh0THNHakpuankzc3ppT3EwUlZrK2YyaE52YUdaTGZ2RWxx?=
 =?utf-8?B?bEVsZXYxaEo1VnpHcWRnb0huT293SDcrcHJBTi9oSG1PN0ZRUUxVcVRkTDQ3?=
 =?utf-8?B?MEpkemZqNmRBbENsVENQQkZYdm91dGNHSlNCS3hXOVMzeHBzZkFwQnJ1aHdH?=
 =?utf-8?B?eG5URkhaUWFuZHA1MUxhSGdNNnE3WEVoekwrWnFBa3hITUlqSnplL3lCYTdU?=
 =?utf-8?B?ckNsOHRKTVp2ajcvT1ZQWTZ6Qm9RMWFJbzRReGV3d2dzTVAwOGlSanlLaEZi?=
 =?utf-8?B?TmF0NlZHeEhYUU02TUQ3djBPdFVRY3FrOWRaYWtVc0xVcUJZcFBYTTlQS09m?=
 =?utf-8?B?dDFNSzVYT2lhTkovSFdvT2ZmeEwxemVWODUwR0k2NDNqMUVHRi93QzV1dlk0?=
 =?utf-8?B?NW1ta0JhNm9jZitUUVhDeEdBa1NUbUxVcEI4R0c3SUlQTHFlTzhPT3NSN0Yw?=
 =?utf-8?B?UVFoYTNOKzJ6TEp1NDhEOXdrOWQrdm0wbFhaNG5nbVRmalhDTDliOUtyeHEx?=
 =?utf-8?B?R3QyQ0dudUpNT3BZYUNta1RYUGc0UVI5WkQ1b2gyN1o0N3hKQkJ5OWVOcU5X?=
 =?utf-8?B?ZVBKQ0wyV3VGVE5rZTNOOFRRUTVYQWJIbkF4Q3B5eThUMitCSXNVbjNiZkJ4?=
 =?utf-8?B?QlRsU1c3UExsM3lRZmN6N0swdUtrUFRUN0cxaEZ5UEl3d2ZwVFVoV2JjSnBa?=
 =?utf-8?B?cGNqNC9wZHVmckttQUxqWk4zMnVIZmI3d0lJR1QwTE5heXpnd1V5bGMxdTNZ?=
 =?utf-8?B?Uk1IUlN2bmkvMDBMNjEwSXczYzZ1TnFKNGQwbm51UnBENFJFMHdCZmZ3M1hJ?=
 =?utf-8?Q?T9YYZtqb2wnCRXIbTmDfCLH/z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce5b449c-3e9a-4600-e820-08dd5751eaae
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 17:12:29.8942 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5C3PsT8BePTOm71DiKXUptE8FevZNQ5FxVau5NtSR62V5/QS1ORfeENeOBwBNE8u6/+cLHxefjy3wTHY1SV5lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6094
Received-SPF: permerror client-ip=2a01:111:f403:2412::616;
 envelope-from=Pankaj.Gupta@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
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

On 2/27/2025 3:29 PM, Roy Hopkins wrote:
> IGVM support has been implemented for Confidential Guests that support
> AMD SEV and AMD SEV-ES. Add some documentation that gives some
> background on the IGVM format and how to use it to configure a
> confidential guest.
> 
> Signed-off-by: Roy Hopkins <roy.hopkins@randomman.co.uk>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   docs/system/i386/amd-memory-encryption.rst |   2 +
>   docs/system/igvm.rst                       | 173 +++++++++++++++++++++
>   docs/system/index.rst                      |   1 +
>   3 files changed, 176 insertions(+)
>   create mode 100644 docs/system/igvm.rst
> 
> diff --git a/docs/system/i386/amd-memory-encryption.rst b/docs/system/i386/amd-memory-encryption.rst
> index 748f5094ba..6c23f3535f 100644
> --- a/docs/system/i386/amd-memory-encryption.rst
> +++ b/docs/system/i386/amd-memory-encryption.rst
> @@ -1,3 +1,5 @@
> +.. _amd-sev:
> +
>   AMD Secure Encrypted Virtualization (SEV)
>   =========================================
>   
> diff --git a/docs/system/igvm.rst b/docs/system/igvm.rst
> new file mode 100644
> index 0000000000..36146a81df
> --- /dev/null
> +++ b/docs/system/igvm.rst
> @@ -0,0 +1,173 @@
> +Independent Guest Virtual Machine (IGVM) support
> +================================================
> +
> +IGVM files are designed to encapsulate all the information required to launch a
> +virtual machine on any given virtualization stack in a deterministic way. This
> +allows the cryptographic measurement of initial guest state for Confidential
> +Guests to be calculated when the IGVM file is built, allowing a relying party to
> +verify the initial state of a guest via a remote attestation.
> +
> +Although IGVM files are designed with Confidential Computing in mind, they can
> +also be used to configure non-confidential guests. Multiple platforms can be
> +defined by a single IGVM file, allowing a single IGVM file to configure a
> +virtual machine that can run on, for example, TDX, SEV and non-confidential
> +hosts.
> +
> +QEMU supports IGVM files through the user-creatable ``igvm-cfg`` object. This
> +object is used to define the filename of the IGVM file to process. A reference
> +to the object is added to the ``-machine`` to configure the virtual machine
> +to use the IGVM file for configuration.
> +
> +Confidential platform support is provided through the use of
> +the ``ConfidentialGuestSupport`` object. If the virtual machine provides an
> +instance of this object then this is used by the IGVM loader to configure the
> +isolation properties of the directives within the file.
> +
> +Further Information on IGVM
> +---------------------------
> +
> +Information about the IGVM format, including links to the format specification
> +and documentation for the Rust and C libraries can be found at the project
> +repository:
> +
> +https://github.com/microsoft/igvm
> +
> +
> +Supported Platforms
> +-------------------
> +
> +Currently, IGVM files can be provided for Confidential Guests on host systems
> +that support AMD SEV, SEV-ES and SEV-SNP with KVM. IGVM files can also be
> +provided for non-confidential guests.
> +
> +
> +Limitations when using IGVM with AMD SEV, SEV-ES and SEV-SNP
> +------------------------------------------------------------
> +
> +IGVM files configure the initial state of the guest using a set of directives.
> +Not every directive is supported by every Confidential Guest type. For example,
> +AMD SEV does not support encrypted save state regions, therefore setting the
> +initial CPU state using IGVM for SEV is not possible. When an IGVM file contains
> +directives that are not supported for the active platform, an error is generated
> +and the guest launch is aborted.
> +
> +The table below describes the list of directives that are supported for SEV,
> +SEV-ES, SEV-SNP and non-confidential platforms.
> +
> +.. list-table:: SEV, SEV-ES, SEV-SNP & non-confidential Supported Directives
> +   :widths: 35 65
> +   :header-rows: 1
> +
> +   * - IGVM directive
> +     - Notes
> +   * - IGVM_VHT_PAGE_DATA
> +     - ``NORMAL`` zero, measured and unmeasured page types are supported. Other
> +       page types result in an error.
> +   * - IGVM_VHT_PARAMETER_AREA
> +     -
> +   * - IGVM_VHT_PARAMETER_INSERT
> +     -
> +   * - IGVM_VHT_VP_COUNT_PARAMETER
> +     - The guest parameter page is populated with the CPU count.
> +   * - IGVM_VHT_ENVIRONMENT_INFO_PARAMETER
> +     - The ``memory_is_shared`` parameter is set to 1 in the guest parameter
> +       page.
> +
> +.. list-table:: Additional SEV, SEV-ES & SEV_SNP Supported Directives
> +   :widths: 25 75
> +   :header-rows: 1
> +
> +   * - IGVM directive
> +     - Notes
> +   * - IGVM_VHT_MEMORY_MAP
> +     - The memory map page is populated using entries from the E820 table.
> +   * - IGVM_VHT_REQUIRED_MEMORY
> +     -

Is this '-' superflous? Or maybe you want to describe it here?

Other than that:

Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>


> +
> +.. list-table:: Additional SEV-ES & SEV-SNP Supported Directives
> +   :widths: 25 75
> +   :header-rows: 1
> +
> +   * - IGVM directive
> +     - Notes
> +   * - IGVM_VHT_VP_CONTEXT
> +     - Setting of the initial CPU state for the boot CPU and additional CPUs is
> +       supported with limitations on the fields that can be provided in the
> +       VMSA. See below for details on which fields are supported.
> +
> +Initial CPU state with VMSA
> +---------------------------
> +
> +The initial state of guest CPUs can be defined in the IGVM file for AMD SEV-ES
> +and SEV-SNP. The state data is provided as a VMSA structure as defined in Table
> +B-4 in the AMD64 Architecture Programmer's Manual, Volume 2 [1].
> +
> +The IGVM VMSA is translated to CPU state in QEMU which is then synchronized
> +by KVM to the guest VMSA during the launch process where it contributes to the
> +launch measurement. See :ref:`amd-sev` for details on the launch process and
> +guest launch measurement.
> +
> +It is important that no information is lost or changed when translating the
> +VMSA provided by the IGVM file into the VSMA that is used to launch the guest.
> +Therefore, QEMU restricts the VMSA fields that can be provided in the IGVM
> +VMSA structure to the following registers:
> +
> +RAX, RCX, RDX, RBX, RBP, RSI, RDI, R8-R15, RSP, RIP, CS, DS, ES, FS, GS, SS,
> +CR0, CR3, CR4, XCR0, EFER, PAT, GDT, IDT, LDTR, TR, DR6, DR7, RFLAGS, X87_FCW,
> +MXCSR.
> +
> +When processing the IGVM file, QEMU will check if any fields other than the
> +above are non-zero and generate an error if this is the case.
> +
> +KVM uses a hardcoded GPA of 0xFFFFFFFFF000 for the VMSA. When an IGVM file
> +defines initial CPU state, the GPA for each VMSA must match this hardcoded
> +value.
> +
> +Firmware Images with IGVM
> +-------------------------
> +
> +When an IGVM filename is specified for a Confidential Guest Support object it
> +overrides the default handling of system firmware: the firmware image, such as
> +an OVMF binary should be contained as a payload of the IGVM file and not
> +provided as a flash drive or via the ``-bios`` parameter. The default QEMU
> +firmware is not automatically populated into the guest memory space.
> +
> +If an IGVM file is provided along with either the ``-bios`` parameter or pflash
> +devices then an error is displayed and the guest startup is aborted.
> +
> +Running a guest configured using IGVM
> +-------------------------------------
> +
> +To run a guest configured with IGVM you firstly need to generate an IGVM file
> +that contains a guest configuration compatible with the platform you are
> +targeting.
> +
> +The ``buildigvm`` tool [2] is an example of a tool that can be used to generate
> +IGVM files for non-confidential X86 platforms as well as for SEV, SEV-ES and
> +SEV-SNP confidential platforms.
> +
> +Example using this tool to generate an IGVM file for AMD SEV-SNP::
> +
> +    buildigvm --firmware /path/to/OVMF.fd --output sev-snp.igvm \
> +              --cpucount 4 sev-snp
> +
> +To run a guest configured with the generated IGVM you need to add an
> +``igvm-cfg`` object and refer to it from the ``-machine`` parameter:
> +
> +Example (for AMD SEV)::
> +
> +    qemu-system-x86_64 \
> +        <other parameters> \
> +        -machine ...,confidential-guest-support=sev0,igvm-cfg=igvm0 \
> +        -object sev-guest,id=sev0,cbitpos=47,reduced-phys-bits=1 \
> +        -object igvm-cfg,id=igvm0,file=/path/to/sev-snp.igvm
> +
> +References
> +----------
> +
> +[1] AMD64 Architecture Programmer's Manual, Volume 2: System Programming
> +  Rev 3.41
> +  https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24593.pdf
> +
> +[2] ``buildigvm`` - A tool to build example IGVM files containing OVMF firmware
> +  https://github.com/roy-hopkins/buildigvm
> \ No newline at end of file
> diff --git a/docs/system/index.rst b/docs/system/index.rst
> index c21065e519..6235dfab87 100644
> --- a/docs/system/index.rst
> +++ b/docs/system/index.rst
> @@ -38,4 +38,5 @@ or Hypervisor.Framework.
>      security
>      multi-process
>      confidential-guest-support
> +   igvm
>      vm-templating


