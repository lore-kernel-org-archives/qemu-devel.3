Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ACF3C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 21:01:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk9ES-0000rF-1G; Tue, 12 Mar 2024 17:00:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rk9EH-0000pI-Lc
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 17:00:12 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rk9E9-0004nI-Et
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 17:00:05 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42CHEURr009176; Tue, 12 Mar 2024 13:59:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=c+4r7UJ/LA2+y3lpBvuc7Ku0njQdantbA3PBa/HYK
 bk=; b=0uc9Nd4ixkUbZJSVusDeAqNrv/DZMcVKSflA2nOKC0YaaOEAHFlo2heRz
 lY3UN680Up+72lD9y/mhOjz8b2CH3CgXTuCT+YEFYts9/2hoZ4LedOV8p5gwpEmA
 zKJbOeQ/NxzmDAZ/9SP1VmB37gXpob9O2AoEibeVOA+JCMqGo1A1dXMsdqQvQYZL
 PqbAnYK7ngWfE8hmgj0V2io4oQKUdpvVE8Yn7G0WyjfZo+G9oQ3QylLKv584L06f
 GGvqHolsqPqJz0bPBNfYZDx3d0HmtQ6U5r1LT74Ckwhk6v2/GYBwxXFqvpMZErXy
 JJ60PeH/X2ohoXDPGtSUfOksOkfdQ==
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3wrmj9q4x9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 13:59:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jw/BvNfFSoHxTREBZStC3IBm17HNUY2oQDRzTVrw3oHo6q4dqR1K0VnjW6H97Wg1uzt22UUJ1aVVgAms9UbsYFHqW8JNPXZ6eb6ZKHJgH4jYi+dAAQkMGcDnsPQPr/V3RqzC+aUiMRPtRzC/3+PrK3dRfDQ1ANST5u4yVXy06ZHf3LGe/LqVIlT9jHXZZZjXsIcB9fyjQR1lm/bqpCsILW+QmmbnQHt4jXoXz9PP9VynVml1hqwQCvTP9SoMfnlDxUwVI8KmamUejUXH+QQBYai3xzYAPGcIUbYDK+qqAD4jeSc+cgO0URsAgJy2sChl/eO62axX3QMh0CDB1P5mIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+4r7UJ/LA2+y3lpBvuc7Ku0njQdantbA3PBa/HYKbk=;
 b=SkRN4fyqcM56DONDHibeHt6qpfOMAgG7tnrM2ZUmaDq6uwbDX7jNno7N948sWx3RQwygdjkfKVN9RHjAJaoHeYXblc2FJWoDXBPLFeuxtw8xPNQVNpcgZJ4sqGiAc2Yjbh3NF8GeVraeXMk6kgek4uOh5BPyyxAnzYx9akZ3XIEBMjOLFIGGcDfLbyCMZziUErEWHulOME4dQge/2BRvvb8Myhzq8/0Cam6GCbnaCqSPpTUOUDqcDyeCVrbRlzL999anbMSjrCcFpqOFiqEcVU21v/dNhgPm0vDl5t2Ijm8OTZ6KTEC/u1Vl3seMoKRLl6iKk80UHIkp5KO3uzpafQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+4r7UJ/LA2+y3lpBvuc7Ku0njQdantbA3PBa/HYKbk=;
 b=ukT7HytcbCKSMg2lX0xQwlEolW9/BHxC74HXaF/PXTI2mUVE2o+7DZhMgx5LEeAhXrnxXkab9+rXHFvwScBEuEapLd8PhKwn9rW78WeF+mw9aq/9yaTvg/Cotd8uKwmuDz62NnXcwDL8vrEzSRYB56BquS/gow9hsiWCjluO7yPnTf7DTwQn3GUQJ7gsM9q78+Bj3mg6XKZJE3cwotUbFOI3ZqWoIw+bE8AryWK/85ZJuO93s1ocXdN06e1Bkxq67hO/h7o0Af5Qe4Z+fqXwA6TLLKKx057+BZPgPWKcRdtNSkVtowsBqrEI8ydp/+rr+W3ajtYHFi+5A8EdTViXqQ==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by SA2PR02MB7724.namprd02.prod.outlook.com (2603:10b6:806:136::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 20:59:53 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 20:59:52 +0000
Message-ID: <39d49a71-635f-4ec2-b454-bfc6f9f8570c@nutanix.com>
Date: Wed, 13 Mar 2024 02:29:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/8] tests/qtest/migration: Add tests for introducing
 'channels' argument in migrate QAPIs
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com, farosas@suse.de
References: <20240312202634.63349-1-het.gala@nutanix.com>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <20240312202634.63349-1-het.gala@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXPR01CA0117.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::35) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|SA2PR02MB7724:EE_
X-MS-Office365-Filtering-Correlation-Id: 49485e6a-95c1-47c0-6070-08dc42d75cdd
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sRMmykKrusx/WpsErU9fKR1anzupsNzPW+qXVwCd27DbH0qMLs4VCo13c6ZfqEpLg7iu6A4vMBYvy+ZV8AvZocyLjv27nzS15Ek4l9vHII7vMGd5vb7kpeZ9JNhpidMU5b3bOg/TKsaUU+yH4doBzeWtRgMxjxquHST5PK2QBh+lerIUpqyBjFYq3DqWaOREdfpU8mUT/nmB23QXj7lN92+OpaUtHsK/AI3iSVwhH3WuTt9adUFYryIKJo9CYM0G09153DT4nei8mzZd3JFGGpkLFsDktCzzZhOQQg5BHthHeMy1u61pLFwhfxejl3xvD8U6K3l3hRR2RBrejNPxpIRKWd1HonreQPFYLASdIudwYxtVK6gyyPlO8ix1OSw0ubxDubGXjQ3iZU1fv6yu5C7xcN6fmAjrRcPdlBp+Vu2p7aoippFj3X+McV+tXgVTnxOm9wHv+EZQOcH932dTRUKMQykA5mQTmIG3FmPXeY5cdNFyTGKHp8I4XirLl24GAFKBmI/M5GGOVm3JIL9NvdvpY8tdCPW68ineQnK4iee8ft01xXdz7RSloUdEipnSzNI9PdAhM1X/stWCxYNsaEQ28gTflXk7IWnTnnmWQZc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vnc3N0ZYL3dxRWlYY1JHL0tGa3l4WWJGN2tUeS8vdTc3bE5iRTBHWkxmNnlr?=
 =?utf-8?B?YTVtLyswa3dLdDZVSUZiRG5Rek1obTJ6Y21Oc2JhcWxDZUJ1dmxkd0N0OGV1?=
 =?utf-8?B?VERJK0FvalNMbW94bVcrNjFsNytiS1d0MWJlZHhXSW5LS0NhMGtqL1g1TWZF?=
 =?utf-8?B?RkhteHZ1VmhOQnJhcDRiVW1od3ZFOEJqN3ZwT21CejREeTlUbVhPajVpV0Vi?=
 =?utf-8?B?ZGZxU1diV3lLZE5iWWhZUG1vS0ZJNklxUG5pVktiMnkyczZaZGptNlliMTlQ?=
 =?utf-8?B?b2p2NVNSbVhqdUxTMUo3TEJjZXBuQTA2b3hMbDdIZG9kVzYrWlN5Wmp0Q0Fv?=
 =?utf-8?B?VmlEZjl1UW94ZEFpT1lrTm54cUJ3YlZNKy9EN0hZZ0ZPcFhMT2VObFMwOWhp?=
 =?utf-8?B?aHhsZHNNTVBJK2d4Q2dYOXorNHdDc1dFYTAxOWZzcG9LOEdJRFhLRS9uWTR5?=
 =?utf-8?B?U0NYNDkwV2VtQ2pIcE9yRndKUUdpbmQrQ01hUUluWkFmWVZydW1XcjBqbDli?=
 =?utf-8?B?amZrd2kyRFJsd2xCSDI1WkZkRVJuY2EwaDF0TmpZTVQvWkFKRVN0R3NrMWk4?=
 =?utf-8?B?aDh4dlNvZmRMb3BVbFZRVUpOZFM1NUpWTHlNNjBVb0ZhbjdCb21oMHAxZTVN?=
 =?utf-8?B?d2JFcE5MdDJtd2lTcVBBY09jOHFXcmNzSkFDR0ErRjBSNC9UWDR6SlRpcGVR?=
 =?utf-8?B?R1hkQXl6TnVTOHEzV25VVGp0b2daUlJiRk9DS3BVb1AwN3dQd1lvQ2ljM0JJ?=
 =?utf-8?B?bFU5MTFKZStWNnJyVGJEblJ3UFZmdVlSWElibUdPLzRiSnVPUXNjMldNUVU2?=
 =?utf-8?B?NFlVbzZuV2xDeVozYmNMdkJWdEIwbElLZjgwSmJvOE45WGpyZTB1cmtBNnYz?=
 =?utf-8?B?cjlQbG1MSWxWMGRMMVBERC9uSFdrazQ0SVJLL3oxU1ZHZEVEb05Sa3hOaEdJ?=
 =?utf-8?B?Zm5YWEQ5ejhsYnk2bzRzNEpJazdmak1ienRFTnF4MklXeDhCTndvUDdmVkRQ?=
 =?utf-8?B?NW1hQ2NhNzZmdUM1YTQyTzNwSVFod0dLanlSR01QdWVMS1U1TkFpUjc0Znhi?=
 =?utf-8?B?cjB5ZkJ2eUFmVFZEODVuMzRtbEJLL2h5emhTZG1KL3FBNFVxL1NvdXM0UE1Q?=
 =?utf-8?B?NlNYV21yYmxoSEMrMFlPWEVVTVBtN0R0VVdRaDZJeGJjSHN5TTBVM3YyRDh2?=
 =?utf-8?B?eWpqaHNFRGxCS0ZwZ1FVSU5keWZ1VjU2NmdTUWNmcVhCQjE4YTJDSzZwWkd6?=
 =?utf-8?B?MHZRQXd3dDBPVUFtdkZuUmV0eFNVM0trenN4NDh2ZE1FN1MyR3AxeS9xT3Er?=
 =?utf-8?B?N05XNVhGR1BmcERuRVdMM2dCb0MxbzkzNzFzRXh6QVpxTkJLWkExMWJnQTE4?=
 =?utf-8?B?Y0g2N3JNZUh6dVU1aWEyZzNYUWVocEJLMjJMeWJ1Sk45VUJjWGh2LzUvc1Fa?=
 =?utf-8?B?QkxQaEN1R1NzdWRVcmk5c3FkUnZZVlI2VGZXRVBuQWFNemJiMW5XaEl1L2FF?=
 =?utf-8?B?K29zMWVUcUg5b2FlRHNzdTBXY2VIcUREZWpqSVVUWTYrNk10SE9QaTRRYkpS?=
 =?utf-8?B?T25EaFhlSW8wMFU3QnVOY3BWL3ZxWWs3eG1rZ0RnZmU0S2cvZU8zSDRqQW1S?=
 =?utf-8?B?VmFzVFlOMEkwOXlyZklRQzRiUnBPUnZMMTIzcjdPbWkwSkkrcVFHeGpPdXM5?=
 =?utf-8?B?dEVYdnFQY1Y5UzFySExaUStzMDdYUHJkeUJLblNHMkM2VDQ5T2xKZFN5Y3Y4?=
 =?utf-8?B?TDB5QTNpL2ZiYklvYklxb2U2UlZPWlpDMVljT3poc21BMTl2aDZTTEg3NllR?=
 =?utf-8?B?Tk14S2NaUnJRU3NJQTg2N3IrOFA4b1lHb2gyRzl6VVBqaUx4SzY5aDhrWGgx?=
 =?utf-8?B?ME1URXY2VGxFbk9YSi95WjluZVA4aW4xenB5Q3k1M2RoMklLWERjM1lTOWV6?=
 =?utf-8?B?RXFIL0FiQ1pTVGtjSW41aWRObmE3SEo0YnhicXNxLzBRbGFhOGhwaTBaQlVw?=
 =?utf-8?B?S080cWJkMFU4Q3dyaTJtbHBISG5UaVozY2JDbWFDL2dpNXRpYjVKUmNrV1JF?=
 =?utf-8?B?ekNpU1NwR0lOR0Y1ODFYanFwTUN5Wm9zVldkYTNwMWZKK0c0MzZEV3VYMWFD?=
 =?utf-8?Q?ByIJx/Pfw8317fJ2epOKwCq0s?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49485e6a-95c1-47c0-6070-08dc42d75cdd
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 20:59:52.6449 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 727yVTPNsE27ZpOUnPry0LIDLawDT1JLw1O8P/8gQ9yheVgFg2/iIvOCO7OG+CFKFZc33p2MRvvgRjRoTo+BoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7724
X-Proofpoint-GUID: 63T09ZV74kM6Sko8loKD7qcZ_Fj4km8F
X-Proofpoint-ORIG-GUID: 63T09ZV74kM6Sko8loKD7qcZ_Fj4km8F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_13,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Can find the passed build here: 
https://gitlab.com/galahet/Qemu/-/pipelines/1210931136

On 13/03/24 1:56 am, Het Gala wrote:
> With recent migrate QAPI changes, enabling the direct use of the
> 'channels' argument to avoid redundant URI string parsing is achieved.
>
> To ensure backward compatibility, both 'uri' and 'channels' are kept as
> optional parameters in migration QMP commands. However, they are mutually
> exhaustive, requiring at least one for a successful migration connection.
> This patchset adds qtests to validate 'uri' and 'channels' arguments'
> mututally exhaustive behaviour.
>
> Additionally, all migration qtests fail to employ 'channel' as the primary
> method for validating migration QAPIs. This patchset also adds test to
> enforce only use of 'channel' argument as the initial entry point for
> migration QAPIs.
[...]
>
> Het Gala (8):
>    tests/qtest/migration: Add 'to' object into migrate_qmp()
>    tests/qtest/migration: Replace connect_uri and move
>      migrate_get_socket_address inside migrate_qmp
>    tests/qtest/migration: Replace migrate_get_connect_uri inplace of
>      migrate_get_socket_address
>    tests/qtest/migration: Add channels parameter in migrate_qmp_fail
>    tests/qtest/migration: Add migrate_set_ports into migrate_qmp to
>      update migration port value
>    tests/qtest/migration: Add channels parameter in migrate_qmp
>    tests/qtest/migration: Add multifd_tcp_plain test using list of
>      channels instead of uri
>    tests/qtest/migration: Add negative tests to validate migration QAPIs
>
>   tests/qtest/migration-helpers.c | 158 +++++++++++++++++++++++++++-
>   tests/qtest/migration-helpers.h |  10 +-
>   tests/qtest/migration-test.c    | 180 +++++++++++++++++---------------
>   3 files changed, 257 insertions(+), 91 deletions(-)
>
Regards,
Het Gala

