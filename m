Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F15CFC61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 15:19:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzbrx-0008Bk-Qr; Thu, 27 Aug 2026 11:18:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wzbru-0008BD-S6; Thu, 27 Aug 2026 11:18:18 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wzbrp-0003cC-DV; Thu, 27 Aug 2026 11:18:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hBctnuCO0iNKnjjZqol9oS6Q8b2pmbtYDXdVo+fhlW6unrI2bEynj4pWBkv/9jjssMydLFBmBAjd2XWxxsqj7tVODq6JTd8QnoQ7uH/BdGKG6D9FoehYPuDYT7HiEkvWMg0gnVuFGUp5qCwkw1v+67ZxqNZF9EsC34TQZG08O9RFptfc0LALLVGWY+QiKi+SsLHGe9vvSeldNj1F1h6mJRCWJCk55UwTOxicOiCO2gf5Bu8fVw35BIoRmotwsQ6act82nUo2kFoENCgZVQEyudwXq5lrkT8uwMDWj42M4M4mVRZZ8Yq3akyY0aA1EeIkBqGURB/r1mUXdd/qqsqiJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GejiuSLICLitDmPtqzFUnXsWFaMoCIqHXzSaZZItUbc=;
 b=KdUCNUpGv1S+rEQLf1zPQR64VMjoDCtj5d2Xe28Zjtuvp9ihj9I+2mf/U0FszKHEGB+Lyd651ohR5oOUZjYYcPYL0ZJvrHFx/DEAOa4QgNMNcG3RhYnN/YhJ7z8F7BpN0vXtsKVeya4r3qZxGAC+jBKLXxIymTIkKooDi2/YY9uW8N9uoyjQVPVBOSpFbBYVrGlf14eNVp/lgl8TLxEWkYiYZ9uMelO1MP8TYPL3pOB/EZazPtHJMQ7GfUpM/0UL0eRQIc/KBLddtT5FlMUP+EO0Au6vZc6cq2ttzV+rKP4p71LeI6aaqamjMXw1f5FYddXsktj+E7D6FthHkDj/bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GejiuSLICLitDmPtqzFUnXsWFaMoCIqHXzSaZZItUbc=;
 b=FhJqBSbRJG3BOgPdCS0hCE38HLmoyDK++7FfiDALu9tiBK6YBXchHtKrFqmyc4gyzMF7y0hOqXbyp6Gc3e0YNe95g5xNeEmBKBzAkSA/cms5woBN8qJICHMvVPN0zi4kNCLykf19Qx2ZjxTAxD/AjQXC+bZty6cWV2ftsHKUzy4/jTyt91x5Ol1PWIIZqECKfmqcOVe9D1ox76cWZ0gwtb30fa7JXnfZ3xl9K3TOTXoSj12Z2iRct8EYD2golm0exmZZh7j5ybGgo2U0R/VTYbKLVPQAEia1lqaVLqYwg5the9fuPgMn3h9/P6dOcnGZBSTjOAMQ/hGJdVh4o0dngg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by DU0PR08MB7858.eurprd08.prod.outlook.com (2603:10a6:10:3b2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.8; Thu, 27 Aug
 2026 15:18:05 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0382.007; Thu, 27 Aug 2026
 15:18:05 +0000
Message-ID: <17f8e415-ef5d-4bfe-99fa-8f0a9ebebcc4@virtuozzo.com>
Date: Thu, 27 Aug 2026 17:18:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] iotests: add coverage for NBD transmission commands
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>
References: <20260826165747.3768674-1-den@openvz.org>
 <20260826165747.3768674-2-den@openvz.org>
 <190d2826-4053-426e-8bef-99118ee7e239@yandex-team.ru>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <190d2826-4053-426e-8bef-99118ee7e239@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0135.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::33) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|DU0PR08MB7858:EE_
X-MS-Office365-Filtering-Correlation-Id: adc3bf3a-2f03-4d8f-984d-08df044e6486
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10070799003|10067099003|56012099006|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: n1iGFcsGkvT7EuGeNFbc0cFFldpBdGGJLf/ff5BSLbjbBv2bv26yKqFbVDwYgOyyw80nYuUANtoZBvMM+yrIbfpZ3u9NFCWJwOOoveh5UnfJeOrQWI60I8Yt4VDkO+K62tDPy+bHuUpW2xWR7jbDNA8ka+QeBQjKLyCZngkyzBZsvDXTnqP5KJhziAiTis8+kKLGZA6QU0EoSJ5MeU9OD1K+WsEoCKTOgBZxm8CfMzNWPSNZUl8wlvmGOuWDfpXPAwaaRirIa4+Ac3J/a9q+oDpc5xXwrLKOCE+UZNFLip8Urip0/07XI5yVPqUD1opwnDAw0fTlphoMejsUE9kUR0CKmJzCBa/zN36ghT0UseMwJEAK551Mh3hOi4hwXbnMJ9pqJqA2g2ZiImOzKOLnrZOTWEpETvmnNCnxyxD6Qo2C9PDrCu0OQKllmF9gay1q9FC6DGGrod70IhKZodf3HVWVIa3wTYpkU2xyosIFnkeFWw71Lcao+WCNOw5hvp0HbPiikBxxUSACJ71lijimvAcJjdskP2r0ceoHkEC5EX3iOri5diIZo0RJixrPhDe8vq3hzqjWbJco6VcHb/VdsObXvW91CQXrDElL4bW27b8eBHXn43DHvB23l/JYTb43WkPXpdTOvuJWeQ9YZyM+pJXsySXSOw5wNBxh/MRxqwU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10070799003)(10067099003)(56012099006)(4143699003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFJBRjVpVHFYb21TdVpQZis0TDZLY2l1aWZsV1k2Qis0WDhRbFdMQlUzSU1i?=
 =?utf-8?B?c3BoN0NrQThDTlhWNGYxczJhbURvVGZwT2FubHUxM2h0dDRVOWNkVmVvRTgr?=
 =?utf-8?B?Wi91Y3c4RlhFR2VVbHc4eXdVdVhMUEhZRHZxYmtsdFZzeE4yQTZyWDVPSUxl?=
 =?utf-8?B?YWJGcmg2dGhNQy9PMUtPR2lkUndFNVg1U094K2k2N281NVpLTkg1dnlqd0pV?=
 =?utf-8?B?Y0xDQysvOE1KK3c1ZS93aG5qakw3cmF0RUYxczZZUG14ZjZ5Tk9mbXJaSTdt?=
 =?utf-8?B?dW5HQzNvV1E0THJSOU5nUmRmNGZxbUp1cmRFM3hTTXpkQUJnQlZMTnJRVVFT?=
 =?utf-8?B?L3BTYVVwWnBzYjlEVFhqaG5uKzQ0Z3UwOHA1WmhrZ1MvV0tJcEFEOFVDenRQ?=
 =?utf-8?B?STd0MWZ0cTFoSUxNZVRucFZPYVMzbG14dWd3VDRFL2IrRkFLMjErUjdhVTlx?=
 =?utf-8?B?RVEwNjhocEI1TVRuS296c1JvV2hxR0tHTk5ZQlpLVUU1d1JOK1dSVk9FU1Av?=
 =?utf-8?B?eDJMSVhyWDN1dlliQWRjSTU1Z0NQUC9CcVZjK3FaQ1dVVnBaZmlQaU1uSzVE?=
 =?utf-8?B?UW5IZGZUK0JBUG5qS0Q1UStxRHg1NWUrWkRkRGtiZ00yMGhid2hWZitFeTQr?=
 =?utf-8?B?STlBcFpJZ05Ka1hBM1FEWFB3UDhBVWhGdWFOOC93U21tYmdIdlh2M0g4TzMv?=
 =?utf-8?B?dG03ZUYyVHBjVURpM3g1UlA0akdBTFNRYzIxS1k2aHBLaFBBSzVOUTNMdStO?=
 =?utf-8?B?OG1JWGFVSzExT0h3a2wyb3loTkxFVzAyaHJsRXFON09EWnF6Z1dMNWlEUm03?=
 =?utf-8?B?Wk9Wa2pvVFhySjJ3TW1aaHpNZkRyTmNnUEwvTHhVNVpNMjcxVXdKd2dpU2hV?=
 =?utf-8?B?ODZsWE9ZUFFXQjdxbE96K2xWZnRXQUxvbEJOdllsb3JUSGw2TGxFbWxMTHFo?=
 =?utf-8?B?cWFwNXhBK3hGNG9panhxaTUwTlNoamZUMHlNd1lDMEZXNTROWFRVMVRvSEtn?=
 =?utf-8?B?VGp1akRPNktmalYySjJJK3NId3pEZ1VlcGVHODFIYXpsdjFnQTdpTXA2RU9L?=
 =?utf-8?B?RWhjeTc1WHViQWJoRWdkcUVKMlNxeWRuaHNESEFvbHQ2UG9hdmQ0VHZLL01u?=
 =?utf-8?B?d1B4R1lNR292ZFRmeThQdVcvZWpkU0QxWERpaWJjR3JwMkFkUkdXVnRBSjZu?=
 =?utf-8?B?UEVNcko3UkhTK1Y0R080OWNFemZoamtKbVdsRkpmdTFRM3JrN0dhdGFGRnV4?=
 =?utf-8?B?S3Byd1VqYWYxUlk2bG5iNjg1NHpNcSs0bWF4SmIrZHZ2WEF1ZjZFRDgwL2RH?=
 =?utf-8?B?Rmh6a0lCTlo4U1I5djF4amNreW1OVXMvMk13c1FBZXNybjdEeEtkR2VjbFFB?=
 =?utf-8?B?WVFsT2NjWWNZQ2F4a0F1SE51U3JDekk5bXFRak53Z1plSUMvb29xL1FYNzIw?=
 =?utf-8?B?RmhuN2IrOFFvcm1BZXUyTVN4YjBadE5KU01uaWpEY1RPQzhMcmE5THZlWU1S?=
 =?utf-8?B?MWFpdU8vdWhmUnF1S2ZuTVhxWnJsenU1RjdkdTB2b0NJd1ZhbkNTeTBxTkFq?=
 =?utf-8?B?MEhaZXJ6OUlzdUJHTmxRWHJLZzd1K2U5OXM5SlJXU3A5MUZGaDdzTjBZOGlK?=
 =?utf-8?B?aEFqblZCYzhVZkxwOVF1VHJWcVJnRVFycWVFcGxZNVhjbExVVGhNS3V1amda?=
 =?utf-8?B?ZWpVNXVPeS9lQ0JENUlDR0pCZXpwUjlMYlpyQW8vNWorMHdRMkhNME9ySDVa?=
 =?utf-8?B?eDhxRWdlcWYydG5vOWovZHExTUZoRFI1ODl4eHJvcFlJekJWR1pCU1dKV0No?=
 =?utf-8?B?cWtwbXpxZ0RQcEpsWVZlNWpFbG13SWFITkhqZmwyZ2dDenpzOGJmQ0FLNkoy?=
 =?utf-8?B?dW5MSCs2RmJRaEIyemREOFg5Z04wNDJxazU4N1VnSHlBTUpqcnJTYTJRN09P?=
 =?utf-8?B?eHFaM2lwQmRzWUo2ZlNadXFOaXFiZGNvdkFvb1J3RTFhRGdYaUI4TkdmRmVE?=
 =?utf-8?B?UG9kRUNPUHdDNjZlcHFxOFZsVjJLUUxrdEllWEx6ZytNczZaTWhvWWQ5R3Nt?=
 =?utf-8?B?Uk1RS3lVWVNabW5zY0JjdWJYWlF6Q3ViODFOeXJMdVFldmQ3cFpIMzZkZ2lJ?=
 =?utf-8?B?OS9aR2ZPM0tBeWV1V1RXSVMrZzRPSnl3RDFRT2s5cDNPdC9LQUllaUtKWHpO?=
 =?utf-8?B?bnFjWVBvNUw5eVBnY2Z4VkwxdGNrREcrb2xZaGpBZXdSekx4bVFZZmYwWTMv?=
 =?utf-8?B?Z2R4VW54VlBkcnFvM0xSN3hIb3paK2hIWkdlb1JEOVcweVdJdmRkZTNwaUZo?=
 =?utf-8?B?c3hXVHByQXNXZTNCaDVOTVE1WFBkZzliQkVQNkhJZ3c4NU9jcVloSEE2Vml1?=
 =?utf-8?Q?gtXf2w/PsWH1+IouFceyE9NZ04NFSEnge3WwmgI9ZfZGo?=
X-MS-Exchange-AntiSpam-MessageData-1: 4E+QWyKYYYJGTw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adc3bf3a-2f03-4d8f-984d-08df044e6486
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 15:18:05.1209 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zTR1cbNWi6gTc1SgOgnFGPv4zcq2CKAJTpPivAwtaCILhE6ROuW3i9Pp3CqQjlsbNe4ROM0SHv8641Buq0LQJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7858
Received-SPF: pass client-ip=2a01:111:f403:c200::1;
 envelope-from=den@virtuozzo.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 8/27/26 15:15, Vladimir Sementsov-Ogievskiy wrote:
> On 26.08.26 19:57, Denis V. Lunev wrote:
>> +
>> +    @contextmanager
>> +    def open_nbd(self, structured=True, extended=True):
>> +        h = nbd.NBD()
>> +        h.set_request_structured_replies(structured)
>> +        h.set_request_extended_headers(extended)
>> +        h.add_meta_context('base:allocation')
>> +        h.add_meta_context('qemu:allocation-depth')
>> +        # Let the server, not libnbd, reject the out of range requests below
>> +        h.set_strict_mode(h.get_strict_mode() &
>> +                          ~(nbd.STRICT_BOUNDS | nbd.STRICT_PAYLOAD))
>> +        try:
>> +            h.connect_uri(nbd_uri)
>> +            self.assertEqual(h.get_structured_replies_negotiated(), structured)
>> +            self.assertEqual(h.get_extended_headers_negotiated(), extended)
>> +            yield h
>> +        finally:
>> +            h.shutdown()
> Why not initialize self.h = nbd.NBD() in setUp(), and call self.h.shutdown()
> in tearDown()? This way we get rid of "with self.open_nbd() as h:" and
> extra indent in each testcase.
>
I will do that with in v2, will also fix nit for patch 5.

That is not a problem, really.

Thank you for a review.

