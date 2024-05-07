Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD330C25B4F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 08:42:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4GOD-0002Nw-0U; Tue, 07 May 2024 04:41:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s4GO6-0002Lj-I8
 for qemu-devel@nongnu.org; Tue, 07 May 2024 04:41:26 -0400
Received: from mail-dm6nam12on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2417::601]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s4GO0-0002xD-1t
 for qemu-devel@nongnu.org; Tue, 07 May 2024 04:41:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S0rtzgzs8ycHMGC65vW8p9etBaQcSfMrefXb5D2eaVEAHhp8j6Q0gXFAglOCEFebRqGMQSAHcj+8OT2FZ4liUM+cQoo1pqOvXT0Y6hBCgYolXVyg6QZFfyRl+5/8wsqlPT07EbSeKbjHnzkKLVksl8qdNeL2Iho5/rDDFnZjIagoU0Tzf9Qads0lgw3jjYUOWFWBOUQ1bQ98Qj6GFBEUPjA0D3zA2Sm+DVFLd42OyV/HmThgz1wsTD049/h0cpwp5Mxj0+cJowPGVo75CA4FtVd0/daxe+QjbcEIjaBLg3gRL2mvKNbSqu4LUx+OXZ8vtOSBpO1O4jJi7ruPhB48wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DeuBrc5MWRLeXXqijDYcmg7Hbo4SaKJ5GniQyqu8iTY=;
 b=UX8mMxqQ6R48X1qUwzgXccaz1krwVwQnxt+I4R1R4KXsmLslhBJhHGch/cnYhdKgCwMHTtsYI+0DFCWtnfxZlgs4SpPeQ53SboJW92rB0YN0FKsNQZ7s91aB8170ihimFNFvPbVhilZ/T4KOagYdIGLW+lm8s8iKXCi1ArO5xPbQMl2dRh41v/h4I9dUJTkE1+w1pYkFUggfqFceHSmG991wQimwzjo0PgrfLLsuM/WUlitxYaqkZKMH/6jk+njPr2cgj8otubQJCiRuQ+WIJcg/H158aKDkYbUocYz6kTIriEmRo/nqRR+qMUBk5FqaffYzPHnvDvPuUlwUE9pjkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DeuBrc5MWRLeXXqijDYcmg7Hbo4SaKJ5GniQyqu8iTY=;
 b=DJZRNZHefln6Lm9ddi+dVneerj8nvat5UqmhSd+XUrDwmK7HoYP7nyoZhbYVASLjKWx/F2PTxzZy+wdWrL+nltMmspvXrlxQqSLejbwGvqMjyp4/Jf+pwn4NRtcqkkHtsp1nuy7bQHN2yVpaN6GALN/SZt2RpsDu4fuZBXAtR4Wf0wNSQXNN/MNzsldae7389gXjd0sXgtONDKA+KHgH0DgZqTGIrmbiEGZfdjJVHr6D6tu3suMSVGyBcwrKYr883ePSnwVsuddGh+AZNecrNlnOwIbk1NG2qs0I5x0LSAqrvmxhEhk4nma/CwvX0V5AzEtKD8Z6l8eEdMcwdzHqtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by LV3PR12MB9186.namprd12.prod.outlook.com (2603:10b6:408:197::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Tue, 7 May
 2024 08:41:14 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::d830:10ba:ec9e:7b80]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::d830:10ba:ec9e:7b80%5]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 08:41:13 +0000
Message-ID: <7e855ccb-d5af-490f-94ab-61141fa30ba8@nvidia.com>
Date: Tue, 7 May 2024 11:41:05 +0300
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_RFC_00/26=5D_Multifd_=F0=9F=94=80_device_s?=
 =?UTF-8?Q?tate_transfer_support_with_VFIO_consumer?=
To: Peter Xu <peterx@redhat.com>,
 "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Alex Williamson
 <alex.williamson@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <ZiF8aWVfW7kPuOtn@x1n> <ZiJCSZvsekaO8dzO@redhat.com>
 <ZiKOTkgEIKo-wj5N@x1n>
 <d7d59001-0800-4073-9def-08327e904b7b@maciej.szmigiero.name>
 <Zig0IPofMCpJdGsn@x1n>
 <e88ecd55-14a2-4043-946b-9c2447fe9def@maciej.szmigiero.name>
 <Zig3vebacR4SfJLh@x1n>
 <1a0b3c24-fffd-4db3-a35e-e40ae2e0a074@maciej.szmigiero.name>
 <Zi-4FmjXv-gx7JH_@x1n>
 <fc0721e3-4932-40b8-a6eb-2584a475d8eb@maciej.szmigiero.name>
 <ZjkZyP9Ty0TpTCTx@x1n>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <ZjkZyP9Ty0TpTCTx@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0179.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::19) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|LV3PR12MB9186:EE_
X-MS-Office365-Filtering-Correlation-Id: 60233134-d455-4d1e-c83d-08dc6e7173d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UzVXSUVyT1kxZThrWG9ac3NhSktIK0FhbUw4cmZUMUlNUzZIQ2c5RUJVOG8y?=
 =?utf-8?B?V3d1RkJCT1RhbXljODkrVUxDTkF1Q0gvY1B4bWtGN0xaS3pJeFlWV2N2Tll6?=
 =?utf-8?B?MGlBNnRnNkRrVGF3ZFl0Zm5DdXhYRWx3TEtrUm5BQ3FHVmNZNEd1NExqQzlB?=
 =?utf-8?B?emRSaDh0QzFtZnQ5Y2dUcldWTXRzOEhIVjE4UEhvQXlLaDBMY09ZWkNiWDM5?=
 =?utf-8?B?UW1LOXJPbUdCbjg5Y3M0QnFEVy9XbFJPaGJuMGUzK0pQcC95UWpFSTgwMmw1?=
 =?utf-8?B?dUJPaTFJT0RsWXdBT0E5eTlweDdmcGJWc20vT2pGUTZuZHQ0QmhWNTRyLzc5?=
 =?utf-8?B?OGxTa1dmVjVyNzBtRUtMb2F3R0JPS3kwQm1qNkowQzVwTlJRU1hzUFNoN2JF?=
 =?utf-8?B?aWVOemVJLzdjUWRzdnhRNWFINDMvNWR2TzNrYnUxN3AxRWhmQmhoMy9NTU1j?=
 =?utf-8?B?dEcrQUdHczJMeXBTaHl6OWFtaTlyYy93VThLdUtmZi9TcmRuTWpJcFJTQlZx?=
 =?utf-8?B?aDNlUDQvNzF2cFhuSUJvUGZKdzluWVoyZy94d3huTEpUSmF1TmtzWVFiN0ZR?=
 =?utf-8?B?SXFsWUVzMGpqRkFvYnVMMWxvN1RQZWRuNTJQbHFMMitVT2lBckQ1ZHdOS2I5?=
 =?utf-8?B?OUw1ZVFNL3pPbDRNZGVNOW1xcDNZL0Mrck9LdEx2bU94QlpFTGlxQzRsT2Nr?=
 =?utf-8?B?ejJoaEd5Vjd3WTdLaTcvUm5JSUhKZXFwQlRSSDRzaDVmZUN2N2UwaHhXUTFR?=
 =?utf-8?B?UUJ3aVN1TnFzVVMvRHdFYUZ4N3NzVklUWUFVdHU3bU0zU1U0Y0hrYUN1ZWdG?=
 =?utf-8?B?dWxoTVZsdHdyN2FDTGZOL3M5N2FpWXlzZXQ0WHZmenFuaDJPajh0UzVGNDB4?=
 =?utf-8?B?VXViRWFlcGpkNkk2UUQ4RXAvQXNuOVpnU1Z1ZHRzMXFTYXczbDZUS2xoOVR5?=
 =?utf-8?B?dXgzSG5WRVcveWlBQVFKakxUYzhCNytPalp5aHRtS3p2eGdtRzE0MFlkM0hQ?=
 =?utf-8?B?SWExWk96Y1ZsSllHd2s4cVFZVVc4Smhwb2VtMHJBZm5XTE5XRGRsbWhlNVQ4?=
 =?utf-8?B?djlKdXFSQXVMZWlMN29OemFSSHU3V2wwUG9ucGhKZDFtYTBsYmRKb3RqNlZQ?=
 =?utf-8?B?eXFPYXNwbDFmTHJqejdvMnduUm1zQ2QzUzlaTlpLMkVoa1dUeE1JVGxHOEpX?=
 =?utf-8?B?MkF5REpjUXZ3K1hBV0wvMlREQkN1aUhRTFJyY3JTck80NWJQdGVLcEh5M3Ja?=
 =?utf-8?B?ZUhRVHdZcVVrSUJwRTRFelMrQUtDNEl6OFRua1lDTUp2VDBYSGdraTdTblhP?=
 =?utf-8?B?SFNxOXd1U3plRjRSdlp4L2RzMnMvZCtZdUhuKytxeHgzbG5RWVNncE1Neisv?=
 =?utf-8?B?NElqalFUd3g4UldsRzI1ZTNlSHdwS2g0ejVVWjJNV1VFcmRSNGhUd0J4djFE?=
 =?utf-8?B?R2FTYkhOZ0l3RGdCYTM0dkNHNzlHbEVpL283SUxSd2xXWk4zKzZ4U3dZV29W?=
 =?utf-8?B?WmpBWFFyandXaDF1cVFjS3NpUXJFOFVXS01wZDRoTFkrandWMEZRRFdONmty?=
 =?utf-8?B?OWdpemg1bitVTlpRV1p2cW5rbXBMczZvM1pkRVdvSSsvODZRR0V1eDB3b1NY?=
 =?utf-8?B?YjhjUmtIS09EaVdkQlk3dk5vWWVQRk1TZzgxSndKMFpaTTlGSmtqVUZrUTJL?=
 =?utf-8?B?anYyVzVBZXQwQ3BTWTk4RXdqTTArZlZaQWtuNzN5VkhlREg5d0Jwb0FRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(7416005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eitHTTQvcStZeTFlSEtwcWd6QWQvb1ptbkNFQWpGT2w0UE1ZYXpWZ2hkM25t?=
 =?utf-8?B?WVRORkN3TmtWN1VDY2paU1VtTVN4emxVWXhtSjB5S1FtYU9acmR2VTlwbEpa?=
 =?utf-8?B?YmozY0FKZEJnRWUwNWtSbFNicEcrMnFLOTdnTXJQYnMycGtzUzF6UXFvdlRv?=
 =?utf-8?B?NW5jbXZBNHRtZmhoejFxSkdkbERtMHdMd3FCQ0NWS1g0bzJrSkJ4ZmxXUTZX?=
 =?utf-8?B?TTJjZGZkc2I0VUNsbnlIbFZTSXQ1NUlLVzRiSmtHNlB6ZGdlUWNWVmU5NFJL?=
 =?utf-8?B?WWZ2MUNZTlREYzJpVXV4ck45TWkvWkZQRXp4L25mSndrSkJZMnNmRjg5cWZi?=
 =?utf-8?B?ejFNOHBkOGlYU0FYcXBFL1N0S0w2QTI2SHhJaUd5UFk1S1crRGx6MzFkY1VL?=
 =?utf-8?B?SmVSREpSMEU3UkZ6dUpvVnVTbTN4VEhCMllldTRGVlhwM0xJWjlrMDFET0xG?=
 =?utf-8?B?RTZXdVRSVEx0QTJZRXpjbU1rbFJZeDhKYzMxRFZWS0VyMGVCclBkSmgxLzBM?=
 =?utf-8?B?SGZqaUxPMGwveFlESTFuVS9rS3FpbldxTlhPWjRUTEFJNThHRGJiRWE2Ulkz?=
 =?utf-8?B?eUxnRkdFdnFsb2JPT1dwZko2eGw3NXVyNTd3aldjQ1lsZzFMaTArVjlHRUdJ?=
 =?utf-8?B?clM4eXJRNnBZMzZGazRYYjRLdER6bHptV1ZKbkp2c3k2Rm13cWtDR3FvdXlx?=
 =?utf-8?B?d3ZOT2s4b2NsZTMwcVUyRlNrNFgwUVd4YVF2SFJGUU05RVZ5bU1LQ1Q3LytU?=
 =?utf-8?B?L1Y2V2pLMmx0aEFnLzJtZjFSbllzYUdhUElvWWlteWh2TjNhMmRoYWNGc2Jy?=
 =?utf-8?B?eGV4anBRNlF2MElMOUtKdjRyb2xESDBsa2h6MnVFZ0ZkZEZsTFphYXU3b2Z3?=
 =?utf-8?B?R3Nud1ZUejhDRzIwdzNQcmlTY01lNnRQdkM5aGFCTDk5L2IrWG81TjdxVGYr?=
 =?utf-8?B?SFlNYlJwcWlHeHBEWkN2Z2c3bzRiQ2lOM3ZHb2tYRCtYTTNNdmRnK1NQYmVZ?=
 =?utf-8?B?dzVZSDNRNG5wSWE1RUlvWDhiZlRGVk9TMm9Db2pBdjZWWUZmZmJXNWs1aUN4?=
 =?utf-8?B?VXBQQ2Y3ZmRvTGNESkFPYlp5UldvZ0t3UzJZZ05sNTVQTXJoaElpS251akpF?=
 =?utf-8?B?YUVUWUlYd2laSExUQURmY2gxNFR5Qkl3QUdMNlVOK0NqM0xIV3RleGR1L04v?=
 =?utf-8?B?cW9VSWVMQzd4NUZ6MUF3VTVQSUhhTlJZdldKb1UzcVFiWDg0b2Z3MWNkaTFm?=
 =?utf-8?B?TU8wbmEwL1dBNFlTbW1xSTBCWGFTQ3lEekc5dVZiSXA2dERNVTBEekhRUUtp?=
 =?utf-8?B?NjBIQ25TWGRKeG54UFRTQncvWTlyNStaSTFKU0RzaU1tc3NaNE9ETndhN3NK?=
 =?utf-8?B?ZVhKNXRLWHZnbmZXdHplUVFJSTRISm1zYWJuMUZFakQvSStuUExVYkF0Qk10?=
 =?utf-8?B?aFZSeVR6aDNIelArcU1tR2FobG9Ja0RWTEl5VWVrUmtsSHlVYndnZ0lLUnBk?=
 =?utf-8?B?Zm1RcDAwaExDYnRMZjMzcDc3YjVqWWpFejFvQmhLRldSaWNXQm1JeUxsN2JU?=
 =?utf-8?B?cXNOQUlzLzd4SjlUcTVrZU01VWRpUmVVYUw1cUt2MFhrVXJmd3JxbWdJajZK?=
 =?utf-8?B?aUFtNGViK0NiZ21NK0pWWlA0QjhNTnRwTHBpYkd4NGVadVVISHNsdTZkT3Ju?=
 =?utf-8?B?czlDaFAvdUJCR2N6TXJkamVJakpHcnFpd0VyWVZORktpblk0M0FnaldDM2Fq?=
 =?utf-8?B?VEwyUndDZEp5aVAxWUZCcERxY0VVMFQxeTFSa1dzV2V6aGVpRXVCUWdxV2F5?=
 =?utf-8?B?RmNUMFQxQnpzYTRydng3SVJuU08rV05KdGtORlgvSFBUeDdkeGR1MWhRcHgy?=
 =?utf-8?B?Yllzd1pkelcwY1hwTkNDaWJKd2laZUlpNlZuQk9KcWIwenhPZER2cHZOcmdR?=
 =?utf-8?B?ZDJIK0MxMGFLYjRXclIvcG5CR25uZHE2Vk1oZEFFRy95aTFCQ2ZQclZzNnIr?=
 =?utf-8?B?dGN4WXhnS1lURzMxLzJIV3FTZlk0RlRYMU9vaUJDOEVhTkdrSXV6dUkyVWEz?=
 =?utf-8?B?UnpEYWlXTXdOVDJZQXZXWWRRRTRkLzRwdVk3SENPc0NxdVBJYTlualNzMnpM?=
 =?utf-8?Q?INQGFN+RbzonaqiXqFpaofQZ4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60233134-d455-4d1e-c83d-08dc6e7173d1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 08:41:13.5697 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KqUGzkX/pgj/C7xeb4ExjSd8QLJG77j9nkzoxLKyzaG/6lzmGNppoz9oHT8H4dEoNdMEM+WzLR2Bwpz933N9Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9186
Received-SPF: softfail client-ip=2a01:111:f403:2417::601;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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


On 06/05/2024 20:56, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> On Mon, May 06, 2024 at 06:26:46PM +0200, Maciej S. Szmigiero wrote:
>> On 29.04.2024 17:09, Peter Xu wrote:
>>> On Fri, Apr 26, 2024 at 07:34:09PM +0200, Maciej S. Szmigiero wrote:
>>>> On 24.04.2024 00:35, Peter Xu wrote:
>>>>> On Wed, Apr 24, 2024 at 12:25:08AM +0200, Maciej S. Szmigiero wrote:
>>>>>> On 24.04.2024 00:20, Peter Xu wrote:
>>>>>>> On Tue, Apr 23, 2024 at 06:15:35PM +0200, Maciej S. Szmigiero wrote:
>>>>>>>> On 19.04.2024 17:31, Peter Xu wrote:
>>>>>>>>> On Fri, Apr 19, 2024 at 11:07:21AM +0100, Daniel P. Berrangé wrote:
>>>>>>>>>> On Thu, Apr 18, 2024 at 04:02:49PM -0400, Peter Xu wrote:
>>>>>>>>>>> On Thu, Apr 18, 2024 at 08:14:15PM +0200, Maciej S. Szmigiero wrote:
>>>>>>>>>>>> I think one of the reasons for these results is that mixed (RAM + device
>>>>>>>>>>>> state) multifd channels participate in the RAM sync process
>>>>>>>>>>>> (MULTIFD_FLAG_SYNC) whereas device state dedicated channels don't.
>>>>>>>>>>> Firstly, I'm wondering whether we can have better names for these new
>>>>>>>>>>> hooks.  Currently (only comment on the async* stuff):
>>>>>>>>>>>
>>>>>>>>>>>        - complete_precopy_async
>>>>>>>>>>>        - complete_precopy
>>>>>>>>>>>        - complete_precopy_async_wait
>>>>>>>>>>>
>>>>>>>>>>> But perhaps better:
>>>>>>>>>>>
>>>>>>>>>>>        - complete_precopy_begin
>>>>>>>>>>>        - complete_precopy
>>>>>>>>>>>        - complete_precopy_end
>>>>>>>>>>>
>>>>>>>>>>> ?
>>>>>>>>>>>
>>>>>>>>>>> As I don't see why the device must do something with async in such hook.
>>>>>>>>>>> To me it's more like you're splitting one process into multiple, then
>>>>>>>>>>> begin/end sounds more generic.
>>>>>>>>>>>
>>>>>>>>>>> Then, if with that in mind, IIUC we can already split ram_save_complete()
>>>>>>>>>>> into >1 phases too. For example, I would be curious whether the performance
>>>>>>>>>>> will go back to normal if we offloading multifd_send_sync_main() into the
>>>>>>>>>>> complete_precopy_end(), because we really only need one shot of that, and I
>>>>>>>>>>> am quite surprised it already greatly affects VFIO dumping its own things.
>>>>>>>>>>>
>>>>>>>>>>> I would even ask one step further as what Dan was asking: have you thought
>>>>>>>>>>> about dumping VFIO states via multifd even during iterations?  Would that
>>>>>>>>>>> help even more than this series (which IIUC only helps during the blackout
>>>>>>>>>>> phase)?
>>>>>>>>>> To dump during RAM iteration, the VFIO device will need to have
>>>>>>>>>> dirty tracking and iterate on its state, because the guest CPUs
>>>>>>>>>> will still be running potentially changing VFIO state. That seems
>>>>>>>>>> impractical in the general case.
>>>>>>>>> We already do such interations in vfio_save_iterate()?
>>>>>>>>>
>>>>>>>>> My understanding is the recent VFIO work is based on the fact that the VFIO
>>>>>>>>> device can track device state changes more or less (besides being able to
>>>>>>>>> save/load full states).  E.g. I still remember in our QE tests some old
>>>>>>>>> devices report much more dirty pages than expected during the iterations
>>>>>>>>> when we were looking into such issue that a huge amount of dirty pages
>>>>>>>>> reported.  But newer models seem to have fixed that and report much less.
>>>>>>>>>
>>>>>>>>> That issue was about GPU not NICs, though, and IIUC a major portion of such
>>>>>>>>> tracking used to be for GPU vRAMs.  So maybe I was mixing up these, and
>>>>>>>>> maybe they work differently.
>>>>>>>> The device which this series was developed against (Mellanox ConnectX-7)
>>>>>>>> is already transferring its live state before the VM gets stopped (via
>>>>>>>> save_live_iterate SaveVMHandler).
>>>>>>>>
>>>>>>>> It's just that in addition to the live state it has more than 400 MiB
>>>>>>>> of state that cannot be transferred while the VM is still running.
>>>>>>>> And that fact hurts a lot with respect to the migration downtime.
>>>>>>>>
>>>>>>>> AFAIK it's a very similar story for (some) GPUs.
>>>>>>> So during iteration phase VFIO cannot yet leverage the multifd channels
>>>>>>> when with this series, am I right?
>>>>>> That's right.
>>>>>>
>>>>>>> Is it possible to extend that use case too?
>>>>>> I guess so, but since this phase (iteration while the VM is still
>>>>>> running) doesn't impact downtime it is much less critical.
>>>>> But it affects the bandwidth, e.g. even with multifd enabled, the device
>>>>> iteration data will still bottleneck at ~15Gbps on a common system setup
>>>>> the best case, even if the hosts are 100Gbps direct connected.  Would that
>>>>> be a concern in the future too, or it's known problem and it won't be fixed
>>>>> anyway?
>>>> I think any improvements to the migration performance are good, even if
>>>> they don't impact downtime.
>>>>
>>>> It's just that this patch set focuses on the downtime phase as the more
>>>> critical thing.
>>>>
>>>> After this gets improved there's no reason why not to look at improving
>>>> performance of the VM live phase too if it brings sensible improvements.
>>>>
>>>>> I remember Avihai used to have plan to look into similar issues, I hope
>>>>> this is exactly what he is looking for.  Otherwise changing migration
>>>>> protocol from time to time is cumbersome; we always need to provide a flag
>>>>> to make sure old systems migrates in the old ways, new systems run the new
>>>>> ways, and for such a relatively major change I'd want to double check on
>>>>> how far away we can support offload VFIO iterations data to multifd.
>>>> The device state transfer is indicated by a new flag in the multifd
>>>> header (MULTIFD_FLAG_DEVICE_STATE).
>>>>
>>>> If we are to use multifd channels for VM live phase transfers these
>>>> could simply re-use the same flag type.
>>> Right, and that's also my major purpose of such request to consider both
>>> issues.
>>>
>>> If supporting iterators can be easy on top of this, I am thinking whether
>>> we should do this in one shot.  The problem is even if the flag type can be
>>> reused, old/new qemu binaries may not be compatible and may not migrate
>>> well when:
>>>
>>>     - The old qemu only supports the downtime optimizations
>>>     - The new qemu supports both downtime + iteration optimizations
>> I think the situation here will be the same as with any new flag
>> affecting the migration wire protocol - if the old version of QEMU
>> doesn't support that flag then it has to be kept at its backward-compatible
>> setting for migration to succeed.
>>
>>> IIUC, at least the device threads are currently created only at the end of
>>> migration when switching over for the downtime-only optimization (aka, this
>>> series).  Then it means it won't be compatible with a new QEMU as the
>>> threads there will need to be created before iteration starts to take
>>> iteration data.  So I believe we'll need yet another flag to tune the
>>> behavior of such, one for each optimizations (downtime v.s. data during
>>> iterations).  If they work mostly similarly, I want to avoid two flags.
>>> It'll be chaos for user to see such similar flags and they'll be pretty
>>> confusing.
>> The VFIO loading threads are created from vfio_load_setup(), which is
>> called at the very beginning of the migration, so they should be already
>> there.
>>
>> However, they aren't currently prepared to receive VM live phase data.
>>
>>> If possible, I wish we can spend some time looking into that if they're so
>>> close, and if it's low hanging fruit when on top of this series, maybe we
>>> can consider doing that in one shot.
>> I'm still trying to figure out the complete explanation why dedicated
>> device state channels improve downtime as there was a bunch of holidays
>> last week here.
> No rush.  I am not sure whether it'll reduce downtime, but it may improve
> total migration time when multiple devices are used.
>
>> I will have a look later what would it take to add VM live phase multifd
>> device state transfer support and also how invasive it would be as I
>> think it's better to keep the number of code conflicts in a patch set
>> to a manageable size as it reduces the chance of accidentally
>> introducing regressions when forward-porting the patch set to the git master.
> Yes it makes sense.  It'll be good to look one step further in this case,
> then:
>
>    - If it's easy to add support then we do in one batch, or
>
>    - If it's not easy to add support, but if we can find a compatible way so
>      that ABI can be transparent when adding that later, it'll be also nice, or
>
>    - If we have solid clue it should be a major separate work, and we must
>      need a new flag, then we at least know we should simply split the
>      effort due to that complexity
>
> The hope is option (1)/(2) would work out.
>
> I hope Avihai can also chim in here (or please reach him out) because I
> remember he used to consider proposing such a whole solution, but maybe I
> just misunderstood.  I suppose no harm to check with him.

Yes, I was working on parallel VFIO migration, but in a different 
approach (not over multifd) which I'm not sure is relevant to this series.
I've been skimming over your discussions but haven't had the time to go 
over Maciej's series thoroughly.
I will try to find time to do this next week and see if I can help.

Thanks.


