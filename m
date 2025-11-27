Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C997D116F2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 03:01:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOSFy-00015i-EP; Wed, 26 Nov 2025 22:01:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vOSFv-00014w-Eo
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 22:01:15 -0500
Received: from mail-eastusazon11012020.outbound.protection.outlook.com
 ([52.101.53.20] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vOSFp-0006id-QK
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 22:01:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FiqqLqOqqNUnAdw7Sx5DyYP9903RtmtdaOB0dSGgAhVHOVd7Chcrjl7mK5Xyi2xoVHMiEmixtF+yWzbr5uGHHIA2oPupeTfX8I7gqjAq8Eg/AOM8X/1D8davBt3jkwAmvS4OjGlGXJ+R8G9XelujqiT3QxJUGwbLRzjw9NV7oqecufcxn2ZoZn/3QMRWDmrkQk68Oyyhtr4a2zpaAHCyKB0s70UI0Hrpl+R0TIKnyBf+e9WXQebTdlh3rhMAI64HXlI8eHLLbWov6gUqb7CWNrpyqGLwJKGylCkc40CK+PPxvT70MfZ5/JcwUT7XBXyl99ttlCaAmEcqw0jtfSEQfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iwFGfTO9IprRW83DB1MamUkv31W41jROt0tmCjxUnV4=;
 b=Cjcigm5HDoXKfusjyfdXY9LesA44yqGFJF4A4UWsibXvZSb/WC5mRCTbqPswKAcBNYwVbna6PxjQe7jgKR7scMnW/KXqyzlZAy0z78qfwn92y0Egf9H2QwfXnHbhnr2s3XEEHjFx2iufZwWwBHdvuBkoQ0Q93TQRK3Bt8tPBJdeMb5M7Nh1TmUScUxxWf1OmNJu3zJnWNj+l06SBil28gQmEDYSDuPVyddh6UgYL+B+qtKaGaOasef2QIrEUF0ewWyzPIZlRnmUyhZfSPEwDmMI3noPU6373l6uoSFRqDqY8AnMxcBYTs788f7t5HA8rHHc59kL2yW1+o5KIk8tP5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwFGfTO9IprRW83DB1MamUkv31W41jROt0tmCjxUnV4=;
 b=golPELgat44kGCCpFPcrGQOMfa44cfVT8Mj3glmPF6zk5k18kBw9sKnAZ2poSx3GdLWiK9eY3mtz4s/BlSknVE5VNLnkGnx1qAbS8zUWQEIvqDRto5p2WoR4q7zs/OuNROu529wEC6wodar5B+nqMCXer0VPVbAkER7TGM5sx54=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 by CH2PR12MB4183.namprd12.prod.outlook.com (2603:10b6:610:7a::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Thu, 27 Nov
 2025 02:55:57 +0000
Received: from IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::273a:80c9:35fc:6941]) by IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::273a:80c9:35fc:6941%3]) with mapi id 15.20.9343.009; Thu, 27 Nov 2025
 02:55:57 +0000
Message-ID: <80177b1d-54f6-4e88-847f-bf1e58d957a2@amd.com>
Date: Thu, 27 Nov 2025 10:55:51 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [v6 2/2] virtio-gpu: use consistent error checking for
 virtio_gpu_create_mapping_iov
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 odaki@rsg.ci.i.u-tokyo.ac.jp
Cc: mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org, Ray.Huang@amd.com, armbru@redhat.com,
 alex.bennee@linaro.org
References: <20251126020208.2449414-1-honghuan@amd.com>
 <20251126020208.2449414-3-honghuan@amd.com>
 <624b3a45-24f5-4802-801b-748e20442366@collabora.com>
Content-Language: en-US
From: Honglei Huang <honghuan@amd.com>
In-Reply-To: <624b3a45-24f5-4802-801b-748e20442366@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY4PR01CA0034.jpnprd01.prod.outlook.com
 (2603:1096:405:2bd::19) To IA1PR12MB6435.namprd12.prod.outlook.com
 (2603:10b6:208:3ad::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6435:EE_|CH2PR12MB4183:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c82e72a-4675-43c4-309e-08de2d607d1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OE1nWFR1cE5CcHVWSVdYRmJlRS8vNGtkS3RwUEMvL012ZGY3cHN1blFmTDRl?=
 =?utf-8?B?SDUrQmhrZ1ZjenZrR05xNzF5ZFRYV1Boamg1WkVtYmd2dHA3S1FGL2ppK1Fs?=
 =?utf-8?B?OVI4L0ROSWJZd2ZYR1E3c3lVZTBGcDd4RVU5ajdxSXJaaFJkNFFiVEtsMFl6?=
 =?utf-8?B?QXJXekNrZ0VFdHhUM2FDa1BzWDIvdm1uMVdQT3YrbENaOWNSbGNCd3NKMURw?=
 =?utf-8?B?cUtuenp3QjdRT280NU9CYzZ6ZytYRFA1VWh0RlJOTzMzWklpWlRTNFVjM0JK?=
 =?utf-8?B?QjVVMkNwcDZUNWIzYVJZVXc0K1Z5bmhMV2ZHeGRjdmFiVkp6MWZtTGJOL29q?=
 =?utf-8?B?N0VmdEtHMXBMT0Vxd2N4QWJ6U1gzZTU5cTF0YUh0ZVhxdDVJRUZoblVMRlZt?=
 =?utf-8?B?eVdpWm5kRWNJVkpFMWhqL1JobGUzTFZCNWtoMTVBazAwWjEwSUpFRUoyUnNk?=
 =?utf-8?B?MWNnd0VNbWkyS0QrdWxrZk94SFFXZUNvek9JQ1Q5Nmo1RWVLSzFzOEVSQVRL?=
 =?utf-8?B?MmlwZHpRb3MxQTRZcDRZNzBzNkMyYi80cUZHNmdNcTF2SGlBRUVjV3B5TStY?=
 =?utf-8?B?cWhUd0l4aG0yWmxOTjRTdzMyM0QvZ0t3QjFwWGN0eExJS3d2ZjJCY1dSZ296?=
 =?utf-8?B?NmY2S2tIZzJWdS9kK0NLcGc1bTJ3OUhMT3VoMkRDWWk4aytmRzE1V2ljRmF1?=
 =?utf-8?B?VTlJdW55S2RyMVhDeEJPMVdmOEZLcTgyS3pwcjlreHZweHpwYUo4VGhXR1Nn?=
 =?utf-8?B?U3ZFZTlqdm9NYnpoNWZBRDBJVnFqT0FnWU1jVWdNUkpwNEtlVVgvWUR1aHlS?=
 =?utf-8?B?ZnRCbmNMWFNxOXVKK0xpUC9taCtyOHdUWkJRTEZ4NUhqbUJYZE9wN011N2ZV?=
 =?utf-8?B?eXgzeWs2MTNoejZGVWk3OVl4K05DT1lOT0RQUWNLVU9KdXdPNWp5RjZ2eUpR?=
 =?utf-8?B?a0VKeFRSY0laWEhVc3ZYTHAwdE83M3Q0ZEd1b0p0YkcveHFFOVgzeXNCZlFQ?=
 =?utf-8?B?aHkrcDFJaDRVUWpkRkt2RzNHSG5JcFdLWmNqMU9vZkgxTjVwckN3aTZIR2FT?=
 =?utf-8?B?REtwR1o1NDd2VkNtNVZIaFhsZEF6UXJ5OWpXZHcwcWdmL3FsWFVpL2tkRmpn?=
 =?utf-8?B?RldCTFh2ZUFyZDY3NDgzOFp2dStydUsvS2dCcnh2WVFUZjVjZjk5dU8xNCsy?=
 =?utf-8?B?U0hrMnVJbnRmS2lnbWhBbXRidmpLSnREdmF3VW1jM0Q2K0llT0VmdzRzYjla?=
 =?utf-8?B?c0E4b1pJb3VEQWVoZ2JOVVV3VmFkMmYzWDNtYVV5V3gxd3lxS2ZUcXVsZDc1?=
 =?utf-8?B?TVhZTnNDbjNYZVZvWGc5KzU5ZDFOeElCNmd2RCszbktNV1ZRMXdVLzBzQWFX?=
 =?utf-8?B?NE1ZNzZoWkZIUFhVZDkxQVNLSTNuZkpWcWwyaHJOM21pNlZRMEdIVnUwQjUv?=
 =?utf-8?B?bzhTbmZTcC9JQnI3L1l6QnpXUUgzTlRlUzJaZE9Xd08zVlVQZDgvellNMmJk?=
 =?utf-8?B?eGlOa1dHU2M3ZkZlQ0Q2LzZ6R0c0WGJoOHo1UDUxdEx4OThldG81U2toRmk4?=
 =?utf-8?B?STJSVksyNHpKWCtiZlB1cHM2Wkk1RXRqNlVYU1dRa2k3em4yNVRPVFFERytE?=
 =?utf-8?B?ZEhiUzRTNmZRWmhybjRVMGtKQmF3dG4zdGljSEVpS2FDMVBja3hIa3F6YTdT?=
 =?utf-8?B?VE16WEVRMklQTUNUcmRRakJxL2lnMjd3KzhsOXBWQlZrVWxqQSs0V01rZ2xC?=
 =?utf-8?B?SmgyaGxWU20yNEVEUm9DSzVDNHJNQklQTXY0ZWdicW01alNCMkx1TG54MWhU?=
 =?utf-8?B?bGF0RGhwZW9OUTFieEZOckJFZjFXdUtzdkR6SlBoZkdLa05MeTI2UkFKWENE?=
 =?utf-8?B?Y3VpVWFvVVJ4RXFWUk00ZUlaZDdMeHJ0dXBIZ0s2c1VWMU03NEVhK2xaS3Ar?=
 =?utf-8?Q?L3U7C/Cfef5JjQo8mZzCNLPyzSSq6dUr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVhudGc2NGpHZUs5VHdMdlVja01ndVY2QUUvekF0QVRCQUNWY2NBSkVSOFpn?=
 =?utf-8?B?RHE1VVFnKzJRaXg1dFFIWTZBZXhmRGxycG1Xc0lGNEc5bWJWRk9LR1hYMzlq?=
 =?utf-8?B?ckNVREZ4L2JZYURtU2tKdUVXTkFraEcyWWF3Y2pVcTdLNGpCOExhWCtNV09Y?=
 =?utf-8?B?RUZuaVR0QzdzeTZoT3lFOEs5VmJpWUU5ZnBHUHBzMFNDU2ZQclYyK2VJYVlW?=
 =?utf-8?B?VThNL2MvZ1c5SlhmYTZyWVpDOVVCZEl1aU5MSTY2b0pCVVBVdnNhWGdPK0Jy?=
 =?utf-8?B?ZkJKeXkrdVZTYThnTHkzL1JDVHkvQk9uTjlIRmtZRGRWeTBqL1NXUkdXa2Vt?=
 =?utf-8?B?WlpLUUxGM0R5dzJjekFLbzJBWm1NamZBbHdtekpTSmpXWmw0d2sva0o1U3Rl?=
 =?utf-8?B?VE5PeG9DRGwxMHpWZUFlU3VpS090eHV4NTMrd1cyeDdoamRCVHhsOVMwNlRP?=
 =?utf-8?B?ZGVVenNBbDl4TU5Zck16M2s2QXdhMS9pMEtKY2J4SjFUWDVWN2NOQmpvMVUv?=
 =?utf-8?B?Y3hhczFJTWJUMnlDNk9aOGRBQStNUXhyeWo0K1B6dDJCL1o1UTNsWGs4Sk5Q?=
 =?utf-8?B?K0ErTXpQNXFpY3B3TnFYRWYrL05MdUlvOFFUVDROekdIUG12UVZoSWRVRzlz?=
 =?utf-8?B?Njdub2pnbSsvVmcrTXlhVG00eVBzOVVSSUY2dlRoRlo4LzgydHJuUjZyRSt5?=
 =?utf-8?B?NjFlWGY1TVQ2amJqVWcyVWROTTJvdDVueHYvVWVkcTE4R25hTzd5dUVRb2hU?=
 =?utf-8?B?UWhDMEo2R2FwdUtUczhBMEkvc3FNUlZ6dHhtYWxJYzY1RTdqRFdvODFSZk5Z?=
 =?utf-8?B?UHNNSjA4UjdqRGxEVmtOY1RoUW45MmxWank5MVVKZXNWTElOVWVMU3gxSS9Z?=
 =?utf-8?B?aGdubHZ5djEyb1NsRHFEdWd0cGgrVlJsUlhDUDFxZzBUZFhxNXdHRnpRQVQw?=
 =?utf-8?B?bFNOQjFiQnFRYzFjMlVPQ1BaaHB6cjNLNFEwN2JzRitqR3J4bE1QSFdMZjhS?=
 =?utf-8?B?SnJTMDA4MXhHK3U5TFl3QXcrUU14a2VCb0ZIb1VXRkNzRlNrQVdSRWhuckVU?=
 =?utf-8?B?a1BmS2MzRXllRjJUMEdaS29UYlhOWUFVWUd1dnI2ZzZhak9FTWpJY1RweUdy?=
 =?utf-8?B?QXdxTXRPVWhkUXlJNGNhdU5GTy8yYlhLY0lOb1o2K21uYnVOZk1HVytUeWtz?=
 =?utf-8?B?TTJ0MnFKUVVxSTVROUx4ZUt3d25lcU0rYURPQnJwbXZZS0Z1ZHl3bzR1SEJX?=
 =?utf-8?B?d0JmL2M1ZWlPOWczRzhsMWYxOFpHL1ZGU0JJeDlLcERRK3I2SlJNYmwzTlVl?=
 =?utf-8?B?d29nR25kK2VNUEVlRnhUODFFN2VwOWcyTFRZS2ovRit4WW1xbjZ5ZXExbER3?=
 =?utf-8?B?ZDhyNHN0T2FMelhTeFFsS0h5WVlQSjVPTjhMOGtaM0ZiM2kyVDI2M2NnNnpa?=
 =?utf-8?B?ZFdKTmUzYmIwTjljR0tjUzVmOHZocXBnS2VOb0tUcVhoa3pmUStlZkNkS21o?=
 =?utf-8?B?REdzWjB5TnVOSEZUdnpZUUdFbENnbHBYa1loMXhsdkg2VUcwcjhVQ2RZMHNV?=
 =?utf-8?B?bWZCSldWVEN2ZlVmQ0N2QlhPYUhKdWF6WDF0cVFWb0V3YnZmS3psU0JFRTRR?=
 =?utf-8?B?eG5IODNYTFZtSTRyamkxamhOaXJRc3JTbGQ4Tm1zNHIwRTdxYXNHeG9MUk5P?=
 =?utf-8?B?dkg2ekFxTkxjQlIwY0g5SERsY1NmZkdXckM5TTFxL0p4MmNKQjk4b3FpTmt5?=
 =?utf-8?B?L3F5UG0za0pORzJnNXBWK1Q1aTd3MjRhY25HK3hTMWtITTFKTGplc2w4QU5T?=
 =?utf-8?B?Q3F3d2poNWZpb1hNUTVOeVBjSlI5RXk4OFhJcDBGZUcwa3Fxc013eVVVNlB1?=
 =?utf-8?B?OTh1OC9zWXNvYlVyczgyL2czS1cyWlkwdS9mSlB5V0ZQUEl4ZWlBVzN3Q1Zo?=
 =?utf-8?B?NHErR3FnNkYxYmpEYm1PYnRTSEdDUHdObDMrWGRLS3p5ZGFPa1B5TkNNcCtG?=
 =?utf-8?B?anBQS3ZaRjB3WTBnM0UwTzFaQ0x2OXlHekluWXdhY085SW9VcTNmTVVOWTNu?=
 =?utf-8?B?U3d3UWNxQVdIa0ZVcHcrWE45Um4zdmhRWGFMYXhGak5FNlFmdzJxWldpVmQ5?=
 =?utf-8?Q?xwq4A8QxSxIZAgHZZmtONPPaA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c82e72a-4675-43c4-309e-08de2d607d1d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 02:55:57.5332 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z8P7/fDS7jwaoZsaIS9rHgmj3Kv2bXzOkkDd9WAdoj9uYEW39O8VYRZD00558NkWMtNGanaJPubRkDxkbENdOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4183
Received-SPF: permerror client-ip=52.101.53.20;
 envelope-from=Honglei1.Huang@amd.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 2025/11/26 20:08, Dmitry Osipenko wrote:
> On 11/26/25 05:02, Honglei Huang wrote:
>> Unify error checking style for virtio_gpu_create_mapping_iov() across the
>> codebase to improve consistency and readability.
>>
>> virtio_gpu_create_mapping_iov() returns 0 on success and negative values
>> on error. The original code used inconsistent patterns for checking errors:
>> - Some used 'if (ret != 0)' in virtio-gpu-virgl.c and virtio-gpu.c
>> - Some used 'CHECK(!ret, cmd)' in virtio-gpu-rutabaga.c
>>
>> For if-statement checks, change to 'if (ret < 0)' which is the preferred
>> QEMU coding convention for functions that return 0 on success and negative
>> on error. This makes the return value convention immediately clear to code
>> readers.
>>
>> For CHECK macro usage in virtio-gpu-rutabaga.c, keep the original
>> 'CHECK(!ret, cmd)' pattern as it is more concise and consistent with other
>> error checks in the same file.
>>
>> Updated locations:
>> - hw/display/virtio-gpu-virgl.c: virgl_resource_attach_backing()
>> - hw/display/virtio-gpu-virgl.c: virgl_cmd_resource_create_blob()
>> - hw/display/virtio-gpu.c: virtio_gpu_resource_create_blob()
>> - hw/display/virtio-gpu.c: virtio_gpu_resource_attach_backing()
>>
>> Signed-off-by: Honglei Huang <honghuan@amd.com>
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   hw/display/virtio-gpu-virgl.c | 4 ++--
>>   hw/display/virtio-gpu.c       | 4 ++--
>>   2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
>> index e60e1059df..6ebd9293e5 100644
>> --- a/hw/display/virtio-gpu-virgl.c
>> +++ b/hw/display/virtio-gpu-virgl.c
>> @@ -557,7 +557,7 @@ static void virgl_resource_attach_backing(VirtIOGPU *g,
>>   
>>       ret = virtio_gpu_create_mapping_iov(g, att_rb.nr_entries, sizeof(att_rb),
>>                                           cmd, NULL, &res_iovs, &res_niov);
>> -    if (ret != 0) {
>> +    if (ret < 0) {
>>           cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
>>           return;
>>       }
>> @@ -701,7 +701,7 @@ static void virgl_cmd_resource_create_blob(VirtIOGPU *g,
>>           ret = virtio_gpu_create_mapping_iov(g, cblob.nr_entries, sizeof(cblob),
>>                                               cmd, &res->base.addrs,
>>                                               &res->base.iov, &res->base.iov_cnt);
>> -        if (ret != 0) {
>> +        if (ret < 0) {
>>               cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
>>               return;
>>           }
>> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
>> index 0a1a625b0e..1038c6a49f 100644
>> --- a/hw/display/virtio-gpu.c
>> +++ b/hw/display/virtio-gpu.c
>> @@ -352,7 +352,7 @@ static void virtio_gpu_resource_create_blob(VirtIOGPU *g,
>>       ret = virtio_gpu_create_mapping_iov(g, cblob.nr_entries, sizeof(cblob),
>>                                           cmd, &res->addrs, &res->iov,
>>                                           &res->iov_cnt);
>> -    if (ret != 0) {
>> +    if (ret < 0) {
>>           cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
>>           g_free(res);
>>           return;
>> @@ -931,7 +931,7 @@ virtio_gpu_resource_attach_backing(VirtIOGPU *g,
>>   
>>       ret = virtio_gpu_create_mapping_iov(g, ab.nr_entries, sizeof(ab), cmd,
>>                                           &res->addrs, &res->iov, &res->iov_cnt);
>> -    if (ret != 0) {
>> +    if (ret < 0) {
>>           cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
>>           return;
>>       }
> 
> Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> 

Really thanks for the review and patience.

Regards,
Honglei


