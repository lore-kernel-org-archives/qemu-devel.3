Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A204C5CFDB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 19:18:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuavp-0000Lf-Lt; Thu, 13 Aug 2026 15:17:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wuavE-00005B-Of; Thu, 13 Aug 2026 15:17:06 -0400
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wuavC-000307-O4; Thu, 13 Aug 2026 15:17:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZPou4mFlmVO5u6yfS2Fak3P5ht6yXXHTgqyRQy4fvZU2PbYwjw9uOH+doXo29jb09IZPmCH8EbLsLoxdJ2GGWiaUu3CXIq/mjDeFjlPDtDUTFW8DgvqxHmTxJ+sc1SQMX8WK/qlzgrWRJ/ITcpsCwlfHJQ4aDr/Tdq4jJqzAMhjhTav4bZQQ7i/LsNpTwq+ORbMaWRQWN5eI5t7DiECy8xzr4ZiqaYlmr4XChqz6/ZIL41HqW7T/QdwdbOhugnYmyM+qsneatneRAufb80OsK8pGC75ztlCJCELMM3RF10F8mq4XD0TW1IlKm1UYugYen6JPC8lHyKTY7raGplGlVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7iOsTxEPsbfjzU78azv7zdGCbLmWGkr3cSQJwhiuRg=;
 b=U62Ik8rjTvleNlqStyj60wLm5WRe8X1cxkAugIUN1d4bKNKDAO07YUq9t4+grnSv3dXjub6WiAJXImIAcw9SU++4LFYpV2UGAOvSOnFJwgl9R/ChhgL6F7GpzlbIH5MZRv7ZclULGwx7XSYmHPOtwOwUFFKBlNM2AkCi2U9DePCm8dYKZvi7F8NqSJsVDeeP892E9YOWMlBD52RZWogfE3GKbGMsaIDWS1upsv4Bkbw0ZQ3mbAG6LkrfKtY4RNZKadUpRwFysLv9j7/9v+XCCc50rUh8CUF2B9r6REc83G719HJTToKjZ4hSyVC63zqHXYzL6oCdIDYjzYAhVbaAAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7iOsTxEPsbfjzU78azv7zdGCbLmWGkr3cSQJwhiuRg=;
 b=s47nb1wRJPDWzhhxI5zlTbI5FpcHHdBVso5ZP0wyE6QAg6hhaeGzerXNbCpyf9mhGKv4gYex687l9v10z/o7SwMyHZ1NT+WIkOyN2mJEyb6Yo95QqpwvRGq9D2ei8PupHbr+dnvPAC7nZRCtgJANERSdoR9wR7Bwsnf8zPxgbaEU77tqh25WJuvJEjBksGXtts7ZfJVPJKe3yRrJiGxY9oOPXGBMcaj/I6yRsfEkucEB/Rt4ejzqVjJbn+a7lMJ/Xf/A5Pv5GdlNbbSvQfbjLcvIjGQsfYHnV0Xvb0Xf/KTob6Du0VC80xjfJnCoYahM/v9ywo6pEjaXXR2zFURxqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by AS8PR08MB9955.eurprd08.prod.outlook.com (2603:10a6:20b:639::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Thu, 13 Aug
 2026 19:16:53 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 19:16:53 +0000
Message-ID: <9e9c6f3a-0df2-4c08-93af-81f26bbda456@virtuozzo.com>
Date: Thu, 13 Aug 2026 21:16:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 0/7] IDE patches
To: Richard Henderson <richard.henderson@linaro.org>,
 "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260804170015.3128363-1-den@openvz.org>
 <a4771466-dd4b-49b0-ba84-9cd2edeeccb8@linaro.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <a4771466-dd4b-49b0-ba84-9cd2edeeccb8@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VIVP296CA0137.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:359::7) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|AS8PR08MB9955:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b421a5d-cd69-44cc-48d6-08def96f6efe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|376014|1800799024|23010399003|22082099003|18002099003|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: fk4cPyA0OEQwCPkwNmZhXl4bu+AThQ+Yhwg6JPMsi/+wJ19zF/pNK8IDjh/LwdVmYnGT39JXNVtmUO1OG88hQt07/pc5O/UtjJ4qrqY8yF2+l5hI7UK5Ab2ILATpJrln8MJ+Ty3K2vuJi2t0yw93Wg2dRbzU3IOdEViqsbvqS6awzt13C+czzHq0gPM6h9zbzX9XkDG+yxkZ0368JubMqkLju2Nc56AavBWbBEaLgiLRjxdv52aFpU3nujLog5wyKUfGEZO+q3assYyFz0mJThKbk01S+fZsmRH6pSA2QfOagJOsU4uVXsrG7b5BC31wkhU3w414uIV4Dq2ec4ShGh61cn95DaVmzfBxUypow8V8mexbQVCtk3agUlUHYTCuwczI+1sxBetSThGnVYmobGpNBYPUGczELlaXQb+cJfr+yqx0uxh0EFstZcg+GZgRWmrWYvAIneERWpociuJgANSoBoC1NYyRU6v6+rmlgK/p+lW0gbdEUNVe+LfwhNI7Hjd/vv4YkhuRynrz8u+dCMlZVTPfAe4CqVCTgjCXmmD1jrYKafppFz1hJUaw0lL5ZZJbNM99NNPzjju5pUUd1S3nYg8LxUQxpb4KAKfWfMxpD7EIx3dnV5s6KLSJR83k/MEQ/mfPF6akM8smWYZ0UT7zryAlWiStJw5PSqliw3Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(4143699003)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0h0OWk0ak9QVzgwcW5UL3YzUGc4VXllTDIwZHZOaStaN3dxMThlV3JhSzJ3?=
 =?utf-8?B?WTFjSHdBRnRDeGp6c0oyUHo5NmgyS043WHJ3OE04WnJuNWprZkNOclEreEVM?=
 =?utf-8?B?ZVRUL1RpM3JIL0FnVkxpVUl6M2JXb21vcjl1bVFqdHJ1Mm5qZkhiOTRKNnF5?=
 =?utf-8?B?dG5Fd3Npb05EWGZIWE9MMW5IN1RzTU9pcGc1djEzSURKdmZpRDJtQmRTY2VL?=
 =?utf-8?B?dTI5NGZybkEvR3doM3Z3Qko1MmtobGhNSFNnTkRTY0d4L2xnNVVSS2h5UUYv?=
 =?utf-8?B?TW85Mks4QStVenlDNmZsRmhwMk1nbVpwQnhpem90YU1SeW9OWGF2MytXamJC?=
 =?utf-8?B?bFljM05nVm5oUHRyQ0s4S3RYWWpURmdGT0xacEV3NWtubGo0bHR2YXJyQVpD?=
 =?utf-8?B?UEhwUUYxSEIwQllJVGpwUkZKWnlnUUNGejdhaktiREViMHBTS1JBNmtQb1Fm?=
 =?utf-8?B?RkZUS2pnWWpYUExOWnVKRUxXS1pIcXQ4L3BYMjBtNzZwQ3d5Tm5QN0xmamVX?=
 =?utf-8?B?RDB6Q2djVFIzd0V6djZXb1UvT1hqbWFPWDYydGNBQmtCNjVxbjdCcDR1TGM1?=
 =?utf-8?B?ODlFNUl0dGUyaWlGUHoyaEV5YVgwU0hOWWkyMldJdTRxZHpSYTdwZ2Nja3o1?=
 =?utf-8?B?dHBPMXV1ZFR6VTFxSFZ2b21DOG8vMmRqUWpWYmFKUXl2UFdQcXFvK20xUjBn?=
 =?utf-8?B?bWdST3ZnVTYyeVpyZjhhTWVDL2RWNGlLcFQ3NEJTYi96Z1RtUndUWlNpOFdk?=
 =?utf-8?B?Q3hMRk5YaTMvQmsrbGJ0UTBlK0FvdXVyMkpKeHgzNDFhSXB3WkRsL1NDU1lY?=
 =?utf-8?B?ZEhLRlVUb3VCMGZVN1pPckcrMnpnaEg0aXU4bThoSVlOTitXYnZqOGRYenVF?=
 =?utf-8?B?VkNIeThDR1hGaGpxcWNCMFRFVThORENNVFlrUk5RcFZnaktmcXZXZGhVUlJP?=
 =?utf-8?B?MFRkc2JBOHVPRGNEeFBSbmFqTkw2MGM2SXJsMU9ZRTVwL1UzUjJlcEd4dUlo?=
 =?utf-8?B?aXNSeGpEV1RJZkp5SUN3Y3BxRDl0M0tyR3ZZME1GZkNDd0psWWU3UUZ3elNm?=
 =?utf-8?B?S3VFK3RXZmFScktzKzhYOVJYNllpc01Gbi9ZQkl4b29USlhuWHFXYTd2Wmdx?=
 =?utf-8?B?WnQ0bVBzeTF0THBSUklzU1N0YzM4dTkzOUdrZkFGM1NTT3FMNG14NEtGVmFM?=
 =?utf-8?B?NTZ0L1pUZCtnSE9EeUIrTnNuaTY5b1o5Rlk3SUV4cDlLSE1HdE9KRVppbExN?=
 =?utf-8?B?bGpGQVpYQllCZU5IMmkzcjVyZkxvSE4yclpmWkdmb3dPYVN5OGowZ0hSVlY4?=
 =?utf-8?B?NGRVNkRmRkN6NEpvMDhMR1pxUmFaS2E0MHVwdE1aajBkOXV6YkxLVU9PZ3Rv?=
 =?utf-8?B?ZytTanBwakMyb0V2cEVqbUJMUHdENTJ3aDd6WGdZRGhJSVBZR2Q5cExSRFJx?=
 =?utf-8?B?Sm9nRkdKeUM1SVBaK3huczRLUHBra2RZWUdBSVVpeUZZdTRkQ3ZDb1ZmMytv?=
 =?utf-8?B?RmVMb0hqd09IMWU5RU9hNXArZFNRVm1XbzhjUHNDencxTlhnSEVUbzZsZnd4?=
 =?utf-8?B?dURoY3h6QkRwcEhUaFFOMFcrQnNtQkRZS0hQRnV3UDBVRWM5YXk1T1d6ZU1v?=
 =?utf-8?B?MnhNN2s2QXc3Y0FsQUNHQlVoc3d3ekFrNllnalV0amlpZEdxSnRGT2VKRWds?=
 =?utf-8?B?alUyRS9TdkxyVGltQW9YRXJNYm4rMzFVS3l5UkJCcDVhSzArQ2NiR3ppai8y?=
 =?utf-8?B?dzBRSzNXL0VYbUFyL0Q3a3BXc1IyQURTUWFYbXQwaXdMOGNSZm41RnZxWFBj?=
 =?utf-8?B?YXlWQjZvNTd1RCtoZDlNZnZyZ0J1Y0Z4VmVJTjh5dGl4eXNyVVlzeFcrclF4?=
 =?utf-8?B?ays5OUhuUXJlUlFmTE81RmVoY1kvN0RqdTZzeDhELysvOWVvN1l4TXZHd2d2?=
 =?utf-8?B?VEpQZHJBKzB1OXQxQ2xlRkFqR3o4RzBSQ3JzK0I3NTNLSm93V29oVUN5cUdl?=
 =?utf-8?B?M0hRRS9QRWVNWkJUMlkvcEEvb0tDVWhZWkhYWGg0aVJkMElSL2hWQXFzNWxw?=
 =?utf-8?B?N1Z5SjhjcFdTN1gzTjREbnRFbmhjYTg3cTJhSmgxc05LYjIzNnoya1pjaDE2?=
 =?utf-8?B?Vlc4WEVzNnNHemFPaXNkS25yRjdxRlhIcllTMWNNOFc2WHVuSkdXQWFQWHRK?=
 =?utf-8?B?LzRlZWZkNU1rYWFwM2Nxd0dPaDZvRGV5dlRzdHAyUlMyQ0hJdDFyd0lraWcr?=
 =?utf-8?B?VUJ1ZTRsbXIyeFFPTDZJVmdWK29iNDUvRmpOWk45N2RETmg5N3FDcTBSY1VC?=
 =?utf-8?B?RnBXQ05SeTRCeHhZc2ZvZ3hHUDRtZnUrL05EbGo1OXZMbERVVUZpMXdTcGhH?=
 =?utf-8?Q?cGvvcsLKl5eeSb4nt4/qUda34svQheyXKFfxcAS94Qga9?=
X-MS-Exchange-AntiSpam-MessageData-1: kCap8elwfvpvdg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b421a5d-cd69-44cc-48d6-08def96f6efe
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 19:16:53.3306 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CxChW36qR40LrsGFQbsQ3yQKuZFFyfndzWBqKIT0Wf24ev5FzsriN1SbUELAKNmgnc23J1fMLh6Ao+rgv0f2aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9955
Received-SPF: pass client-ip=2a01:111:f403:c201::3;
 envelope-from=den@virtuozzo.com;
 helo=AS8PR04CU009.outbound.protection.outlook.com
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

On 8/12/26 18:19, Richard Henderson wrote:
> This email originated from an IP that might not be authorized by the domain it was sent from.
> Do not click links or open attachments unless it is an email you expected to receive.
> On 8/4/26 10:00, Denis V. Lunev wrote:
>> The following changes since commit e1705a25aff35635c360bbaba4c2731d019a422a:
>>
>>    Update version for v11.1.0-rc2 release (2026-07-29 06:16:08 -0400)
>>
>> are available in the Git repository at:
>>
>>    https://gitlab.com/dlunev/qemu tags/pull-ide-2026-08-04
>>
>> for you to fetch changes up to 9a249de6ae86124b436b5e839e285aeb333ea8c0:
>>
>>    tests/qtest/ahci: regression test for ATAPI read vs. drain (2026-08-04 18:40:34 +0200)
> fatal: couldn't find remote ref tags/pull-ide-2026-08-04
> fatal: remote error: upload-pack: not our ref 9a249de6ae86124b436b5e839e285aeb333ea8c0
>
> Did you remove the tag?  In any case, please resend.
>
>
> r~
Sorry, seems I have mistaken on this pull request.

Re-sent.

Thank you in advance,
    Den

