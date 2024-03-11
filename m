Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B446BC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 22:06:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjngs-0000s9-DX; Mon, 11 Mar 2024 18:00:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rjngk-0000gc-EH
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 18:00:09 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rjngf-00043V-N6
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 18:00:05 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42BIYEl3028225; Mon, 11 Mar 2024 14:59:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-type:message-id:date:subject:to:cc:references:from
 :in-reply-to:mime-version; s=proofpoint20171006; bh=aOCek7Fniksf
 sfFnFNSU8FanHLFx59Dr4zfJxOw96DI=; b=HV5xcns9oeLmAvW/UF2xIQcy7j4r
 n8iYlx8eMcKJgLfUR3v0oyX74QwpAz0sSigIeNQr7e+mixe1SzxjV3p7PaFaAvnv
 enO3w/uxBQtYJeojcVLHithfqFseQzjui4ua2nF5axb8uPRQBnUgdlO3Twn/UOUV
 bw0c5bFZb18FxQlzOrbeQjG6YE3S5EzLODbv/VVQqpjHWxLseX7hUQvId75SCdYv
 UmbfNRaTmI+vy0vC9lHWh0rIXH/lbuTjWAjJdUKM8gQYvxMEUby3hWmV6T8Cxbat
 itE2IIm88DOoMaqT8JAsVL+Lag/Gx7bhpHuqvkPZHFJYdX8JYkryv5OPXg==
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3wrr70v5w7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Mar 2024 14:59:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Abbsb1L7lP5fLVT+sWiyOrCuADAlK7VwxHXVO3m00r+/11yH3EoLFIeMYNNbZ0xR8CXsAHN2FWsmqjRMvmbqfLNSb+PR8YaLbHaqygKTu3+382VtG67iM24iM4rHLykdXTtcfgzpi4i70AD41PQ17OBdT6NnLd2Et4vG7M5Oe3AwKlIATb3Z2HyDkYgWh2PcG3pFAQtMv2Cf165S54R3u8HWe+ZpNS7cjvMaQDC/fuLh+7F7YK/6cnhlKDGg+fSub+ofYsEyoLRJlsq7ViXTKtfKu/O7EzpN/qOydSmzzQd00NH6dPqsylBAF2XAXL+/rj1MjD764HQDyheVcARoDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOCek7FniksfsfFnFNSU8FanHLFx59Dr4zfJxOw96DI=;
 b=TNJYJWJkEHdrRJIMrU6cudqP2eJmKzBjFmlY83hWTBlYeRF7yn+mYtdCbEkl5eMPNIxAO4pdIfKQU4Ll4DTJPZNrkUOiU0PpMFxXtfGU4dhnG0kc29YijRpjdvoD12hQ2qx1UV6KjnI9FxBLjy2u2clYJLTGc9oYBJt9uxh2+Wi/iG6hpD04qo2qkfSroEP5/MhUgN5hWxBIKzbWkftuFQDw6Cn+VcIIqUGpV28yTgCUr7dkfSO9jCGlqUCF/jAXm5eMVTDVAweVpsyu3eH+mTktT/odKk8GH0wHpca/Fz6g4dQAcxTb6bNxB4bG4unC3+5oNRi3OJqGeHfFV0U19g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOCek7FniksfsfFnFNSU8FanHLFx59Dr4zfJxOw96DI=;
 b=GOga0MTImF88M/75YC2ybAlsUZxqACABH++VKysu3OsLt3CLaPvYfg1CgWJ/HQQSYary++umrNtEm+7bUsOqo7VLaYTScKAkNl0Jkk5TYb028KC4KP9VXwJdxyAK6EyZmtv3f9hrjEAZ41DfFAc8A9RDf6bqOkNnWpJjNXWI+sBJqAE1t2x57TgKsyPHMc5Xuy2zt7ozjfKPMFXZkAUOIA7ugwofUn1meSV95yPN6H2wEQbo4k/Lfem093zUhA9JQZ6rqJkMeowoFX3fkXxz4slD22ERRnxNNqjVO3iTj8ZsllnbsU08f4cDp1tJv8ALYG42Qp3y2BtmlJdJx5g9Yg==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by PH0PR02MB8678.namprd02.prod.outlook.com (2603:10b6:510:107::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Mon, 11 Mar
 2024 21:59:56 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 21:59:55 +0000
Content-Type: multipart/alternative;
 boundary="------------0Kz5JysdtEx54l6Gy7Pp1ycT"
Message-ID: <0e1a418e-9dba-42dd-8e88-d391be913bc6@nutanix.com>
Date: Tue, 12 Mar 2024 03:29:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/8] qtest: migration: Add tests for introducing
 'channels' argument in migrate QAPIs
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, pbonzini@redhat.com
References: <20240308205951.111747-1-het.gala@nutanix.com>
 <1db9b780-a83d-4794-8ddd-1547615cdd9b@nutanix.com> <Ze920doZYn99aLCn@x1n>
 <66416dbd-9038-4762-b39a-9395b778ea56@nutanix.com> <Ze956ZixU-vaWPbM@x1n>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <Ze956ZixU-vaWPbM@x1n>
X-ClientProxiedBy: MA0P287CA0002.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::8) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|PH0PR02MB8678:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b5d9211-22cd-4ffa-1a15-08dc42169622
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iyKBBYqUjVCLnMBr/B1qOu04pNy5kAxd47tQ9LRMZUfycOHvWj4D95ObVJoFzQr6k20aUHqJWx0NRh6OzzBIjkotBeAYmsV6uzRPEi9Cy8yKNInVrkP0ZU4UfEsxPaQsdPUVj0E2SmU/rTF2tNGfY1/LMQQ6VX0pbcvMV3lke7/yhZMZh6vVlydaSHNuM3szEnCQMBviiv2CAj/woU0XoDvRK5zpV2I4lidRGv0eUv58K+StXP4BCn8kkfxLIvNzgTV+BRZ+U3fR9+dZWfU5mo42Qp8kH+UBb6JwIVaym++qNejUyRbvo1hkQ8N0UfJGQryOIv76LFatkFbvNz8+THWrSudvU0rq54DRFqVElYdtEZFYnEcXdYuU0EtDpoMxLTv3NThGc9DM7CZhNp8grbdk+EmHVIY+4W/8p31R9rPo2v1AaLLOALvo5+G0v6NSIWOHLfL4hDRyzvuKQO5uxIERVC8ovP9YmPLwx7ItwUzveYHHznqVE5Nr3S1LTzE9K3ZXTj0AdH/sTbTCJ/XGAvKgk1iERcv4T3iwag+73ZWp3llbC0Fl3KmfkCuu36FYFSRqqBVB5BnPU1YAnh4iXND/+4UialelL144Ws/TKMA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nlh5MnZPSnVQNDFZeWM3RnFqcmxMY2ZKbTF3T1F6RllDSWpPWTI3K0RrQURh?=
 =?utf-8?B?RDZFYlNTb2hhaDBSQTgvQm0xbGRtUHE1aUZibWUrb1FJenFMMFY0UkZERzdI?=
 =?utf-8?B?eDVncUlZOW9NbTR4cEd2MnhnYVliZlRqQ1Z3cjhqamJIRWp3TEhNcTVLT3Rp?=
 =?utf-8?B?eHlTUGZBeEpBbjBSU1paZnhtczhTeVYxbU9LWnc4QmRlcU5DRmt5dEJJa2pU?=
 =?utf-8?B?aGdYaCtlblhMRGNVeUpOb0FvVlMzN0JjcVdHL2ZBVG5QMVBDc0Zjb3R1QzR0?=
 =?utf-8?B?YWphaEFTUlpqRXpEWnIwNTFzNjRSK0o1UmlWR3I2ZC8yZC9BbTBjdDRRSEsv?=
 =?utf-8?B?UVJCSkVRSnM3UDNQc1NuOTVYT3lSTnFqa3pFRFRGMFNweGkrUVNZMmE4b2RU?=
 =?utf-8?B?NkpQZWF1YVdYdUZLa2dqcDM4K1hUelphUVdxN2RDVlNwYzJjNTZHblUra2xi?=
 =?utf-8?B?WUNHZmY0bkNFaEFlNFBrVlZveWdSTFRubzBwZzNJdkxCMithUWpjRHIvWlVO?=
 =?utf-8?B?ZFBIdW4rZVd1SEltdXFlUTdwTC9DMmlPT2ZaYTlHVjY4VGFCYUxMdWtXNjhJ?=
 =?utf-8?B?MlhUWkdvRVNpUTl0NjE3UjB0dUZ3UEpHb3ZlM05sM1FiOFBvTmFGYkkxV20z?=
 =?utf-8?B?eDh6RFhMS0JNdHZ2UFNveEdFZmZTbVE3SnJiSGlwV2RTWmlxY2tyR0JwRUo5?=
 =?utf-8?B?QUhwNS9NS2JuNWlGU3dLTksySk1URVkzYVphZGVxSzZPZU1Rc0kwRlc1UnZE?=
 =?utf-8?B?WmV3SjFmM3VsRC9wUityT1YvaVdubHNyTG9yNVlTOVZENkRKUmkwOHFmd2dq?=
 =?utf-8?B?VUdPY0svbnJxa2Q0TnIwSUdIa0x1MWNOWUN6a0doczgwUGhpWXArb2RGYzZv?=
 =?utf-8?B?dnRZQ0toVSs2UC91aHNCSUIrZHJXamVoNFpWVG9hTHRoMzloMkNiRE5la3ZN?=
 =?utf-8?B?RWIwR3Qrd2s2SGFSSGMwbnlySWEyZ3VOT1M0OXBZNmZTeTEyODViRmQrQ29t?=
 =?utf-8?B?SSsyVzYyTlNxeVpwby9HcGNxS0d2QURoN3ZaOEFnaVAvNm15YU9kUnY4N29l?=
 =?utf-8?B?VExFL0xLa3phZHBjY1Bmek8rSk0xRkxtYjJwVCtmc1VUSzlmM0N4eTB3bUVG?=
 =?utf-8?B?b0gyWGpDMEs5ejFwQ0x3SU02Ui8wTlFZK2ZSTDRVbGtjWktvZmUwSjhKZFVZ?=
 =?utf-8?B?cGU4ZElLMm53QTdXMU1MSk5VSjJ4Vk8rb3ovQ05CNTgzQzNXSVVXREtMRmRS?=
 =?utf-8?B?WFBIWG4xZ0doaFBJcW0xTjFiWHpGamdqLzNNSUxuMHZsaWFjbFh2aWhnaDFV?=
 =?utf-8?B?SFR6aVpodENVMWo4dEpuNEY2dlZsZGVPMWdkZ3JYUlRyZEhSN2R0SGNQQ3Zh?=
 =?utf-8?B?a0Uvb3ZkRndnQldNalhJeHlBQktRNnlxOURYRGtUbTZJOWEwTzEzcUJVUDBh?=
 =?utf-8?B?V3VMN2pEZWRTUzVNUFRqTVBVYlE2NkQzNCtyalJnZTBhVzBsUVRBdzVYRnFj?=
 =?utf-8?B?Zklqa3lHZE5ydTdtMWR5U2hMSkZnQms4SzZ1aE5hODJFVkxhcHdWOEljWU5O?=
 =?utf-8?B?eUNCNGpndXNibGYrUVV2T2xhN1kxTStSclhzS1FCWlc2MlVUb1M1T1dnTUZV?=
 =?utf-8?B?b2dSL240b2FWZ0xvSUFzYithamRNSFZETWFBM0RQbmVVRGRVeEFpeTJLcEtN?=
 =?utf-8?B?TUhXT01MVXBSOU9BdUNIZzJ5UkVTT1Bkc1hhdi85cXVpREtmdWdUYXM3K2pJ?=
 =?utf-8?B?Q0lnVFRCYncyQlhhOEUyL01abDJtcE1PcFNRVFpqVjE2cXJUa2tsa1hBZmdI?=
 =?utf-8?B?d3VtSnZuYjJ2VlR2WkU5Z2J3NENvdXBvbTdqMGl4ZUJDR1ZjOThmd3NnMHhL?=
 =?utf-8?B?ZE9GcVFaYTdpclhvbTdOWm56WEZ1L3l2SHBmTjBTelF6SSs3aTkzQ1VCeUN4?=
 =?utf-8?B?TExzckU1WE4rKzZOUzBwTXlaMFd3WDNDdFRFMWx5MXB1UXh1ekduL2RJYWlh?=
 =?utf-8?B?ZnBxcXNON3g3U3kwSW5RUU5VdVNaYnphdHNxL205RmMwbVBXSVRHVlBrR01R?=
 =?utf-8?B?UWFqRFpQY3FObVd3S1VDMCtMTHJDNVN5Ni83UHF3alFLa3BnZFpMZjdsc0p3?=
 =?utf-8?Q?E0ALHAskMm2Jga6H3VQkVKdvt?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b5d9211-22cd-4ffa-1a15-08dc42169622
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 21:59:55.8253 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W2drYLjOSWjcV1+DYzznqdNysniAVUMQNdKfBIGu6A+yXhVIpOU1aT/x2NiKffLxhjD3U78VAZx7GaNrw9ayAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8678
X-Proofpoint-ORIG-GUID: sLzqc19n4bcdl-ploTmokzcPT5FxbWHq
X-Proofpoint-GUID: sLzqc19n4bcdl-ploTmokzcPT5FxbWHq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_11,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--------------0Kz5JysdtEx54l6Gy7Pp1ycT
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 12/03/24 3:08 am, Peter Xu wrote:
> On Tue, Mar 12, 2024 at 03:01:51AM +0530, Het Gala wrote:
>> On 12/03/24 2:55 am, Peter Xu wrote:
>>> On Sat, Mar 09, 2024 at 01:11:45PM +0530, Het Gala wrote:
>>>> Can find the reference to the githab pipeline (before patchset) :
>>>> https://urldefense.proofpoint.com/v2/url?u=https-3A__gitlab.com_galahet_Qemu_-2D_pipelines_1207185095&d=DwIBaQ&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=y2xUaOwvRVC5eTpFNEdxb37JYDdxN61W406HlCyx3CWIVyBRgLwjJhAYALZLinoi&s=vZRNX33_DuLO1TsfTpYR_s9bf_EMFm3oHHH_eg57zE0&e=
>>>>
>>>> Can find the reference to the githab pipeline (after patchset) :
>>>> https://urldefense.proofpoint.com/v2/url?u=https-3A__gitlab.com_galahet_Qemu_-2D_pipelines_1207183673&d=DwIBaQ&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=y2xUaOwvRVC5eTpFNEdxb37JYDdxN61W406HlCyx3CWIVyBRgLwjJhAYALZLinoi&s=C73ka3k3ouAuRJYNVLPIBQiWx3jDFDDvVYDiEYqfE04&e=
>>> Het,
>>>
>>> Please still copy me for any migration patches.  In this case Fabiano is
>>> looking it'll be all fine, but it will still help me on marking the emails.
>>>
>>> Thanks,
>> So sorry about that Peter. I am aware that you and Fabiano are the go to
>> migration
>> maintainers. I thought I emailed or cc'd all the stakeholders that should be
>> involved
>> for this patchset series. Even in earlier series of this patchset, you were
>> cc'ed,
>> but somehow I just forgot to cc you for this patchset. Sure, will take care
>> from next
>> time. Again apologies for the mixup :)
> No problem at all.  As long as you have at least 1 maintainers copied,
> logically nothing will get lost.  It's just that it helps me in the routines.
>
> Are you managing cc list manually for each version?  In that case I suggest
> you have a look at Stefan's tool:
I used to earlier. But lately markus introduced me to
scripts/get_maintainers.pl -f <file>
It gives list of all the maintainers handling that particular file.
So that helped me for this patchset.
> https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_stefanha_git-2Dpublish&d=DwIBaQ&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=ydJfb02Wuk_NnlYl8-RkRkYXzWNpzlEht7yj5kakeAlz_WPoD6yvC7b-fVCeLzom&s=8KSe9MiMzmHda3uZ_uaGCIEjub4tSzpeDTpZZwq5knc&e=  
Thanks a lot Peter, looks cool. Will try to explore and use git-publish
and its different methods for next patchset.
> It might help a great deal in patch managements at least to me, and it
> definitely covers more than maintaining the cc list for a patchset.
>
Yes, it looks like there are a lot of useful methods that I can leverage
in future :)

Regards,
Het Gala
--------------0Kz5JysdtEx54l6Gy7Pp1ycT
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 12/03/24 3:08 am, Peter Xu wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:Ze956ZixU-vaWPbM@x1n">
      <pre class="moz-quote-pre" wrap="">On Tue, Mar 12, 2024 at 03:01:51AM +0530, Het Gala wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
On 12/03/24 2:55 am, Peter Xu wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">On Sat, Mar 09, 2024 at 01:11:45PM +0530, Het Gala wrote:
</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">Can find the reference to the githab pipeline (before patchset) :
<a class="moz-txt-link-freetext" href="https://urldefense.proofpoint.com/v2/url?u=https-3A__gitlab.com_galahet_Qemu_-2D_pipelines_1207185095&amp;d=DwIBaQ&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=y2xUaOwvRVC5eTpFNEdxb37JYDdxN61W406HlCyx3CWIVyBRgLwjJhAYALZLinoi&amp;s=vZRNX33_DuLO1TsfTpYR_s9bf_EMFm3oHHH_eg57zE0&amp;e=">https://urldefense.proofpoint.com/v2/url?u=https-3A__gitlab.com_galahet_Qemu_-2D_pipelines_1207185095&amp;d=DwIBaQ&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=y2xUaOwvRVC5eTpFNEdxb37JYDdxN61W406HlCyx3CWIVyBRgLwjJhAYALZLinoi&amp;s=vZRNX33_DuLO1TsfTpYR_s9bf_EMFm3oHHH_eg57zE0&amp;e=</a>

Can find the reference to the githab pipeline (after patchset) :
<a class="moz-txt-link-freetext" href="https://urldefense.proofpoint.com/v2/url?u=https-3A__gitlab.com_galahet_Qemu_-2D_pipelines_1207183673&amp;d=DwIBaQ&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=y2xUaOwvRVC5eTpFNEdxb37JYDdxN61W406HlCyx3CWIVyBRgLwjJhAYALZLinoi&amp;s=C73ka3k3ouAuRJYNVLPIBQiWx3jDFDDvVYDiEYqfE04&amp;e=">https://urldefense.proofpoint.com/v2/url?u=https-3A__gitlab.com_galahet_Qemu_-2D_pipelines_1207183673&amp;d=DwIBaQ&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=y2xUaOwvRVC5eTpFNEdxb37JYDdxN61W406HlCyx3CWIVyBRgLwjJhAYALZLinoi&amp;s=C73ka3k3ouAuRJYNVLPIBQiWx3jDFDDvVYDiEYqfE04&amp;e=</a>
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">Het,

Please still copy me for any migration patches.  In this case Fabiano is
looking it'll be all fine, but it will still help me on marking the emails.

Thanks,
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">So sorry about that Peter. I am aware that you and Fabiano are the go to
migration
maintainers. I thought I emailed or cc'd all the stakeholders that should be
involved
for this patchset series. Even in earlier series of this patchset, you were
cc'ed,
but somehow I just forgot to cc you for this patchset. Sure, will take care
from next
time. Again apologies for the mixup :)
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
No problem at all.  As long as you have at least 1 maintainers copied,
logically nothing will get lost.  It's just that it helps me in the routines.

Are you managing cc list manually for each version?  In that case I suggest
you have a look at Stefan's tool:</pre>
    </blockquote>
    <font face="monospace">I used to earlier. But lately markus
      introduced me to<br>
      scripts/get_maintainers.pl -f &lt;file&gt;<br>
      It gives list of all the maintainers handling that particular
      file.<br>
      So that helped me for this patchset.</font><span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:Ze956ZixU-vaWPbM@x1n">
      <pre class="moz-quote-pre" wrap="">
<a class="moz-txt-link-freetext" href="https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_stefanha_git-2Dpublish&amp;d=DwIBaQ&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=ydJfb02Wuk_NnlYl8-RkRkYXzWNpzlEht7yj5kakeAlz_WPoD6yvC7b-fVCeLzom&amp;s=8KSe9MiMzmHda3uZ_uaGCIEjub4tSzpeDTpZZwq5knc&amp;e=">https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_stefanha_git-2Dpublish&amp;d=DwIBaQ&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=ydJfb02Wuk_NnlYl8-RkRkYXzWNpzlEht7yj5kakeAlz_WPoD6yvC7b-fVCeLzom&amp;s=8KSe9MiMzmHda3uZ_uaGCIEjub4tSzpeDTpZZwq5knc&amp;e=</a> </pre>
    </blockquote>
    <font face="monospace">Thanks a lot Peter, looks cool. Will try to
      explore and use git-publish<br>
      and its different methods for next patchset.</font><span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:Ze956ZixU-vaWPbM@x1n">
      <pre class="moz-quote-pre" wrap="">
It might help a great deal in patch managements at least to me, and it
definitely covers more than maintaining the cc list for a patchset.

</pre>
    </blockquote>
    <font face="monospace">Yes, it looks like there are a lot of useful
      methods that I can leverage<br>
      in future :)<br>
      <br>
      Regards,<br>
      Het Gala</font><br>
  </body>
</html>

--------------0Kz5JysdtEx54l6Gy7Pp1ycT--

