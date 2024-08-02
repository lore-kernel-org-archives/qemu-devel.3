Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F639C3DA49
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 08:36:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZnkN-0007SO-ND; Fri, 02 Aug 2024 04:34:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pankaj.Gupta@amd.com>)
 id 1sZnkL-0007Ki-MX
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 04:34:45 -0400
Received: from mail-mw2nam10on2059.outbound.protection.outlook.com
 ([40.107.94.59] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pankaj.Gupta@amd.com>)
 id 1sZnkJ-0006QJ-Jb
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 04:34:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jOTlNxCO65+45z3YFJTYgsREkvpRd5LK3mHZmwBqU7dJ7evc3FLDrfjFTQBkniv1NDVKZ96K9c2YCdD+/kq3A0HEpjRCLUhSdNonEYpc24AXQKocCAJrB9vhHjPuv/4iEIDvNoA6IxBtQvGvFwl6ZobA31TVZGvMme9Xc7EiFxX17UTJDghPuIeDeAVSUINCRO+ZtNn8Rr0EsSGidntJGbxd7QPN4uuabMoLy3TY2/kc9zw5KjmasEzp87gs5k0yQHZHHte9yqAoyfCt4CNTeoZOk0UaXvZenzWfYTTqECQU4pBoe8JcL8PBBadpktRXCO1acxdk0H5zb1/gtnTXBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBA8GUWQE5qPMusOe0iYHFPprDpxlHQgMyAZk0jLwFw=;
 b=oqJ7/hnZnZELDrhOZ8ah7Bg/5Yyg9HOznSbHX8aukYw4zTpLEJQD6LMixVm2/K94DTz4W2I7ouWt7jEFCsET58OObHP7AgbVR/+xaYSqzjxlFJArAx4uPpE/lIMpBWpbtj98EWs7B5UT9S67GbQV9aKLPuL8unHAh4OS8+9+2DdH1P30JzMbfmYQ54sUyxNEeDtrDRlo+Q5+JCfu4U7tpiBvrCJb3SXrM7vyY3HWf1si1IQhMmukXv9UYnvDOtqKUyKovD9Jr8faVxfdl11V6CDixJkLmaqqRWG7YCZgGF4zip6bWokuDzJ0Qu8w0NHfx0fWrSE614BWWZzmxxM+wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBA8GUWQE5qPMusOe0iYHFPprDpxlHQgMyAZk0jLwFw=;
 b=2qsNBWeGuLMvqB28aeprn5KBfFmPvXqlg6XrCKlNVkVM9WKFGEQ1NiO/6Ik+dnO40KmW0nVnYytPfFLd1BqGjy3PNXMOmmC4JRHtaqp75CYYaaggB8/2CLJ0vPFhDdVYKVaw4/0EMPf/pRgBdK7VCFSWoSr5et33MnB/8FoX1go=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB8189.namprd12.prod.outlook.com (2603:10b6:208:3f0::13)
 by PH7PR12MB7284.namprd12.prod.outlook.com (2603:10b6:510:20b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Fri, 2 Aug
 2024 08:29:35 +0000
Received: from IA1PR12MB8189.namprd12.prod.outlook.com
 ([fe80::193b:bbfd:9894:dc48]) by IA1PR12MB8189.namprd12.prod.outlook.com
 ([fe80::193b:bbfd:9894:dc48%6]) with mapi id 15.20.7807.026; Fri, 2 Aug 2024
 08:29:35 +0000
Message-ID: <de1d3350-152f-9424-bc03-05bf216739be@amd.com>
Date: Fri, 2 Aug 2024 10:29:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] target/i386: SEV: fix mismatch in vcek-disabled property
 name
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Zixi Chen <zixchen@redhat.com>
References: <20240801234345.355447-1-pbonzini@redhat.com>
From: "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <20240801234345.355447-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0124.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::15) To IA1PR12MB8189.namprd12.prod.outlook.com
 (2603:10b6:208:3f0::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB8189:EE_|PH7PR12MB7284:EE_
X-MS-Office365-Filtering-Correlation-Id: 04371347-6a8f-45d9-e717-08dcb2cd3d6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z2dTTE96eCtzb09kZEFiU3VXOTc0eWVIVXFuVzZYNlExUlphNUE1RjNYRUdx?=
 =?utf-8?B?NFB6SWNjb21OVXlTRzRDTnFSMVRnc0tHZndwdkl5eXVJTkRTRmZiaG43aHBa?=
 =?utf-8?B?NkRITVdrVUlMMFFlMDlmQ0ErTkhPRDBMc3VnNk4wc0lFblVxVEkwekY0Rmsr?=
 =?utf-8?B?VU9SL2YrQ2duNzQ1RmNoMXBBbmQ4Q2poY2VVTVE3U05GOG15eXY5Wi9peEM3?=
 =?utf-8?B?ajBBL0pZNmRnT2w4eFZIb0xNTzJUZkMwZ2FHa21SMURPeTRiQXpXcjVyTzVD?=
 =?utf-8?B?djZ2QWlSQnVvbVVaRjdyQmkxcG4xSTUrWHg4Z0I2dmRtS2kzcTFvdGFIK0Mw?=
 =?utf-8?B?aDhzdk9xYW54SThoV1ZJQ0RQeU5taFRoRTJ1UGtMajQwbW9NbTVjc2RNY0Z0?=
 =?utf-8?B?bkM2dTQ1Mnh6RjRaYUMzd0l1enhpZmpXTWcybUxJSGNVUEpCdEp0N2lDR0ZD?=
 =?utf-8?B?SWNhSWxrb1pCc1BoZVRWcjV5b3N2ZThWY3I3T3VuVEV3cnJkbXFyVTVhWVVF?=
 =?utf-8?B?blRQUTF2Sllsc213R1I4a1d5ajNWTkFmR09hc0xrTTdWSVJnWUZzY2kyWXFn?=
 =?utf-8?B?SkQxczVrMC9xckpIaCtTbEVjc1RNUTBHZ1BBVzEvblNUZCs1TnhpdmhkeVFX?=
 =?utf-8?B?VkFOZjBiT0NuRFNneGhuWVdhNmpUWmNWRGZYbENucHFCQ21qZUw4R2RnN2NF?=
 =?utf-8?B?azJqc0prbzd6QWtSdnNrNDBNaG9DakVWdENDcHg3bmJJSS9uWFlma3l1amJG?=
 =?utf-8?B?bEhJVTFOZTlOTGt0eTU5RE13YU11WE1rNE94ek4rNlhaRGJlS3JoaENuMUJY?=
 =?utf-8?B?bmxBdWVMVkpzNU1IOWVxL0dnbTNvWXhBSm8vZEs0ekZ0UTlMMlcyTkxrUlBF?=
 =?utf-8?B?ZlZSQzhvajd1UGI5WGZFSkozV2gvL0thd3o0OGhyTmhFanNKdUoyL0Z2T1Q0?=
 =?utf-8?B?MFVzUHlGWHhxQ3RiY0dKWjB0MzVYclJBRUx4bi9qeG5mNW1HRUw5MVo2ODll?=
 =?utf-8?B?blhaR2ZobCtiRW5CbXEyZS9adkdhczlSeVhpZXIyMjA0QlZKcEI1N2xlbU5u?=
 =?utf-8?B?OVJPRURhdW5xV0h3Znh4SGhvZ1RYcWlFTlpEaSs4MmhnbHM1WUp3UEVPSmd0?=
 =?utf-8?B?US9CUnJpb3Y1M0tMWDUwM1g1bEtJQkFQK0FRNk9nMUpRbmVYOG5YYkdQMnpq?=
 =?utf-8?B?RWJEaGF5d2h5dEZ3RUtCYUVScHFHd1pkTERBVEdzeWlwbmRrMHY0NGNtTTdD?=
 =?utf-8?B?V0QrTjEwdGtLMnQ4SHkzaEo5czIzMHNPb1FEOWtSTW52WkJvMTg4TmptU21Q?=
 =?utf-8?B?UUpBY09rTHNBMEQyNFJCZTF5SFZjcExRdzFyYjdHWERHTm9vSVZzQTlmb2dM?=
 =?utf-8?B?R1pMVElXNGVHUzJsUkRkTXk0L0tIVlNYazZIejlHNTBrVHJHaUlFSEEyOGRV?=
 =?utf-8?B?ME5pSjFCRWJJdjNOeFdKdk1QVzBrN3JJbnFmZnB4YmdQN3VqbG1TaDNYZEFM?=
 =?utf-8?B?OXArTzRGVHZWOUtXY1FqQ3VuQTF3QXRsc3NhZVRMNFNVblRPL2JybnRDWmpz?=
 =?utf-8?B?UXRVY2dLK1ppYjlNVUNTTFZyZi9BeVA1UCtFV3hrNm5oSlFkVDdwU3MyNEFw?=
 =?utf-8?B?a0padjUwZHhiRVJwRFAwVHlURy9NSldLRTg0MmI3eSs4MTNMcndNc2RYUTJa?=
 =?utf-8?B?K1NKMWpWUlU0NFlTYjhseUVpa0FXSXIzNEFpSTZRZXorUzhleUs5bDV3cjVl?=
 =?utf-8?B?Y1dJN21MdUZ3cjYwQXlEb3AzcCtleVo4VkdoVE9NeU9MWkpzeWtaeDNUNXZD?=
 =?utf-8?B?N0FtYm52SHdnSjA2TmNuQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB8189.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEtPSURtaVBiWWYyQjJkMWdjU0IxT1FZQzZSTFpLNXlwZHhDNU9lM05PaW9E?=
 =?utf-8?B?aytVYVhDKytVWm5zNTJNV2RNV0FjeGZXVFp3OTBWU1laU2xIVlVxN1Y4QkM5?=
 =?utf-8?B?c1daS20zejR3VTA4WEQ1SmFFem9yTjdQeVhHK0VIT3JsOWovZVhpajlsM0ti?=
 =?utf-8?B?UWJkQ3FSODN4bFBoMkx1RUlsMlRUcDM0bTlvdXBOc24yTWVqOWsvWmlMNHhp?=
 =?utf-8?B?cVV5U1lDVjhyK3lBeFJlZ0tjZ2JCdVBBY2tybFBxdlBsZXVsMmFYc1FISkRR?=
 =?utf-8?B?cEhOS2NiVC9FSm5NNTcxRC9KcEhIUXZrM0pMckhrTnZ5ZlQ2eTF0ZlJuMXZM?=
 =?utf-8?B?K29vUkROK3ovdU4zWFAxNGp3aXRFOEw5MWR3WkR2QWNJYStPSkRneDhISEZ6?=
 =?utf-8?B?bHFnY3orUUQ2SWtSL05taExvOXRKWDI2UERpZ2NZMW5JVDd2R3JMN0cyQ2t5?=
 =?utf-8?B?TU84Rmt3U3lzQlc3K0c2SzNwVGVUNFNiaVdXL2dLUE83ZHBVN0l0L1JYcTBW?=
 =?utf-8?B?bmRaZld4SjBkZjMzakkxdHJMVG5GQUsrWm5RRDNKZlF1bGVDc2tibE8zRnVR?=
 =?utf-8?B?RnRVakMwYzYrVGIxVklzVnVQTXptZlFZa1lVVUo2bjd5ZUNhd2o3TmxkdDMy?=
 =?utf-8?B?WjFIR3ZvMHkvY29kUUpUaFoyYjRsOU5ZUGRUa01iODJoUUozWGZRa1UrZUJY?=
 =?utf-8?B?akRIS0lRMGVIQ0JtR0pUdlhXWG9hWUx6RUtZZWhMSXU3Q2h5MUlpSUU0OFNI?=
 =?utf-8?B?S3N4Umdlc1ZRNTIrU2k5WU1hV2lnYWZtT1Q0emEzOUkvcFk5REN5MllCUExC?=
 =?utf-8?B?VTNRaElYZ21uZEMvYnMxS3dRMkcwSHhxWmRnUG9wSDBjdzVaMzY1SWlicWNJ?=
 =?utf-8?B?VG5ESzJMNjNCYmlrWG80cUFERHQvbElYeEdacTl1MTdHbGwwTDJSZENkNDlj?=
 =?utf-8?B?Mm14cGI1dS9XSnd0dGtjZUM2NjhRRm9sV2MwTFdnZVRObDBXTnhYVm91T2pH?=
 =?utf-8?B?SjBiZ3c4dFJJWi9jTUpLdDJ3Wkl3QUxoczVEUTRsUFZDc2lBc29samlkKzJt?=
 =?utf-8?B?TXczMk1zM0F6MFRJUno2U25ObDZHK0puU2FqaEsrUVluL2NuRll3ekIvVmlY?=
 =?utf-8?B?YitoTkdKWFFOV0RFejlCVUhKOEZ0QjA4d0hjd0k1RmVaTkh6Zk5sN0VtK2FM?=
 =?utf-8?B?U1hESVFUYTRMK21tWGRqak9ZamNRSmFwS0F2N2xtZ01hRDRia3EzNVhUV0xZ?=
 =?utf-8?B?OUdQNDhvMTZudGh5TzFjazFYUlFtck1oYjB6QUptTVNNQm9HaDdmNkR5QUYy?=
 =?utf-8?B?eW5sNGR2ZmU0bkJPRVNFV1dBN0xpMDNweVRJNjRqTkRpTE43TjhzOG45ZEJN?=
 =?utf-8?B?ZTJsMlFkSHR5Y3FaUlpEWVRydDJWd3BOREp0OTdtSFVPSnJLN2dJdjFoWmFD?=
 =?utf-8?B?U0tjaWZVQUEyQlRSZ3pXRDRQOVZ1OHVCQk1yVlM5QWcvSjk0bllhSm1xVVQ0?=
 =?utf-8?B?YTZoTzFQQmZUaU8xSzJHbUx3NnoyZ1hFc2kyTStOckxkdFI2Q1h5MUxhSkhX?=
 =?utf-8?B?NGJCRmhobUxJdWdnYUJTL0pTUlJLYTNZQjY4b0dqakU4ZitQeE1RaVZZQnor?=
 =?utf-8?B?YVBXTFYxOHYxczlOTFJSa2xFeHRUakR5VjVKQ3EyS29kcUNHaEhSNmVxWk1F?=
 =?utf-8?B?aUhmRlVZWkk5MnBVSGpjcjg3SnRncVRIU0JVazNiSFNKbDlKeGhnTXhQSjlj?=
 =?utf-8?B?bnhqa3RVVFBqa3k0WCswMmEvaWNJYXIwUmhteW1TcFFmQjVKdWE4T3o3bjFI?=
 =?utf-8?B?UXA5ZjY5Rlh2RlkrVW82a1JsVkVoQ3AydnkzbG4yZ0hyaTBlOFZCUW1hSnhF?=
 =?utf-8?B?bXRGWWlZb2crV2NaMnVmdklIQ05NajVFTVdoYXI4QUtBakRpR0lJWGtQRElU?=
 =?utf-8?B?ZHRyc2lDS09WdnpucTlpN2hHUERtb1BLbHVpQ2ZMczkwV0V3aG40SG0yNDBG?=
 =?utf-8?B?TmUwYmJIQkFaeHNYTXVXSGs1NnRKOFZDN2FVeGJWeVNmSXJlcWtnckUvdGd0?=
 =?utf-8?B?RnQ1dnJZWGY3YVJBWVloS3E0anI2MitSNGpmNFo4TDgxOVR5OVUvdmJYM1o0?=
 =?utf-8?Q?opxRaljMSt+DA3Ah7WPtNaxoj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04371347-6a8f-45d9-e717-08dcb2cd3d6d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 08:29:35.0105 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VxhxLVbu9A/i8O8JUG7Fixh9XoEqKuOPaNFZmkqUxkt4Q0dC5CREdhPiUBpiR/hBWKqBP2kIn3rUbjA4eS9gDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7284
Received-SPF: permerror client-ip=40.107.94.59;
 envelope-from=Pankaj.Gupta@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.288, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 8/2/2024 1:43 AM, Paolo Bonzini wrote:
> The vcek-disabled property of the sev-snp-guest object is misspelled
> vcek-required (which I suppose would use the opposite polarity) in
> the call to object_class_property_add_bool().  Fix it.
> 
> Reported-by: Zixi Chen <zixchen@redhat.com>
> Cc: Pankaj Gupta <pankaj.gupta@amd.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/sev.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index a1157c0ede6..a0d271f8986 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -2422,7 +2422,7 @@ sev_snp_guest_class_init(ObjectClass *oc, void *data)
>       object_class_property_add_bool(oc, "author-key-enabled",
>                                      sev_snp_guest_get_author_key_enabled,
>                                      sev_snp_guest_set_author_key_enabled);
> -    object_class_property_add_bool(oc, "vcek-required",
> +    object_class_property_add_bool(oc, "vcek-disabled",
>                                      sev_snp_guest_get_vcek_disabled,
>                                      sev_snp_guest_set_vcek_disabled);
>       object_class_property_add_str(oc, "host-data",

Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>

