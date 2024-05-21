Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE706C25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 09:10:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9LUp-0006Vr-F8; Tue, 21 May 2024 05:09:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1s9LUm-0006VA-Re; Tue, 21 May 2024 05:09:21 -0400
Received: from mail-db8eur05on20706.outbound.protection.outlook.com
 ([2a01:111:f400:7e1a::706]
 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1s9LUd-0004bW-D1; Tue, 21 May 2024 05:09:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SpPI0AmT88a+Eajrap8MxjG4Lwwb8ickmkk4bNZDV+A5mYpkIQoSZznlwHNR5UxWUY05b+fLNbFFJs7fRbbQJIBwi443FuEl5dFpLtcrQ7PkrBNqyvfzmMv4u1l7sSvEQ728TiwBsP1EBk+u2ySAumJC6eIp76Vd5UiqvFWMMhrfLGymIpaOUe3ejnbckahHEan8XbPqVUEzdDvBturEiWwd+jFw0QEYJro4EYaMTZelw714370Np0l6CQqJ3q1jBu66ab3X559jyacOCOPFoQHDWEcAV7uTJjjN2Hm2vGcJ1qIhXOVobRQtHjAsf3iPHbcL9gyaa/nIStNTsb0sbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X9yMkeNu8MD+mZE6ioSqUXX+Tf2LC6MWrwErFjLUaBg=;
 b=Yocwbe09Z6OTRaGkYn1KdUIWcIZf33N5f1RiKJoK20rEr3UHdJO9S/i9UNhvNFp3scorKo0KJi22Vmc5jLpu5FKbTEoWKEuEpC7aqRjiiYIPRriZP7uOaDfQ4C1FB8FKtaweS2jFi2Uoh0cwpgPT/xvTzpWEQ4kEIOE7tAvDd6d18OQF0e17mxcjlwm0WbqrrGnitMxzcFFZq99dH6QEYkyHDcQcnvBI2T4Jhxe3/1Z04TIqQ1LAglACJGLFLwBpJxxkM33x+7Tv7myMxAUOjNKUwGd0pfTyYyWiqAo3yKVhCcpuj1JfqP9M2OwuOoM1/xohlzeKHN5KuvKhoc1oYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9yMkeNu8MD+mZE6ioSqUXX+Tf2LC6MWrwErFjLUaBg=;
 b=pj956JKz0rC7oSVxrFm7Pn/cnL1NSKzFKt0rvDrqt6ulgKlIttJ0isuJKSfFfNdioU8VLjJrFFOWBL97G21q3ymS+EqA/NA3mSC18DRTH8hU0bBvCABmM41Tiuwxbzi9hXXC2gn3D77rhrzRgz07pp8EH5pEo7rjerjKVFT7e3jP1Nig0kCG5Nj6OfgA4EFBYpKmVLJzVB2K6tfVROaU6Y64VbP7gjdHGqOzFeTp3QRsgnUFoGfQd1X7piM8DqiPohzyUVkZueSWXVO5SzMGailrglQ7Fy4hgboo18B0wT26JN39s7PWTaJSDQGq9zXp1b4dCvxONdoTJeEVw2OmAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by GV2PR08MB8099.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 09:09:06 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::cebf:31ab:1e25:cfb5]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::cebf:31ab:1e25:cfb5%6]) with mapi id 15.20.7587.030; Tue, 21 May 2024
 09:09:05 +0000
Message-ID: <f2c882a8-77c0-4d62-bf9b-cf36802049d8@virtuozzo.com>
Date: Tue, 21 May 2024 11:09:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/11] iotests/290: add test case to check
 'discard-no-unref' option behavior
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, berto@igalia.com, jean-louis@dupond.be, den@virtuozzo.com
References: <20240513063203.113911-1-andrey.drobyshev@virtuozzo.com>
 <20240513063203.113911-7-andrey.drobyshev@virtuozzo.com>
Content-Language: en-US
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
In-Reply-To: <20240513063203.113911-7-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0157.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::14) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|GV2PR08MB8099:EE_
X-MS-Office365-Filtering-Correlation-Id: 3eb0d93e-ff82-4a17-1d7a-08dc7975aa68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UVJSdGdicS9xcG1mS3AvQWRKSmE5ODVEN3BWZUErV0h4cExuTlNCOTlVOVpj?=
 =?utf-8?B?R0dNbnZacTdJR1JsRWVCUE4vZXozVm8wYXVFaEhUTzlTQWkwN3FSSVJ4ek52?=
 =?utf-8?B?MVNxRHhPM1FPQzA2Wkt5OEo3ZitFWWhSdHI1Z3E0anJUTkt6WWl1c09UdHNM?=
 =?utf-8?B?OFluazNELzhpZjZDbDNkZzB1OXV3U25HMDlicTBCT3dlYnhNTzJxRW5sQThL?=
 =?utf-8?B?TTY0RHc1bnBLVGxFa0dvR015M3NtNnZnM3BJMHcybFNYNFFQaHovMU9nUWtn?=
 =?utf-8?B?ejJnemtlNTdwYm8vWUVVY1pXR1BKeTYrR05hZHZ2RkNPbml4eUxMVWpvMW44?=
 =?utf-8?B?MmdvZjIxdkJ4a09xNlRWdGJQZjkyYkVNS2xxcHVMRHFCVVgreS8ySkN2ZXNw?=
 =?utf-8?B?eVhwdW1JZHByNmZoV0IyNE9hU1JNdXAvUy9tMHBEOFZyWXpDWVdwTFRvNVRs?=
 =?utf-8?B?cVR3UWpjL1VidmpZOXlzSWhXck1Yd2VzbkJud2lqNXpZdFFnNU1QbnNhMXlu?=
 =?utf-8?B?Q2xLY1o4TDdvWWplMFUyVEZ5QmxqalZpZGYvVktSSDhISTlxWldMV2tZS0Rm?=
 =?utf-8?B?Wk0zSTlQaXI1R0doL0ErRGZYUGpmWHMyajB3djVkbUZ6bFJQeVY0VnZPWGlw?=
 =?utf-8?B?RWxGbjVsYzBTZEJqOFplMDQ5NzFRYlBpTXFpcXQ1VHNVZEdzcDNwbGRpM0E0?=
 =?utf-8?B?VU1ub3hRNnpITnp0RmpPWXcvRldZcGk5eFN3anVKcHZPdDIwMERKR2dncU0x?=
 =?utf-8?B?bWtra1J5azFIUmxudzdnRUZYcEtsZ1F3ZW4zc2RwUnA5b3IwYXM1UzlGdU4x?=
 =?utf-8?B?YXNSc1VOdUM0azhNZkRuMS9WeUpOSU1pdU1UVG8rZGF6cGdhRDN2b0hFeEMw?=
 =?utf-8?B?MnNFZ1U1aTV5MFNIUEg5cHhkMkxlMk5YbENKNHJ4NklFWjJmb3ZpODJ4R080?=
 =?utf-8?B?blNoRE1jMGZtcE5qUGlRd21vNG9kbTNnZTlPMnBxc1pibmtCVXZRMW9Ybjc4?=
 =?utf-8?B?S1hjdnBwUy8rN0lmVjlhWURYc1pWYjI5Nzg2RVJMZFk4dHhaaVcvR2Y4dlNx?=
 =?utf-8?B?NnhJV3Zna2t6cGZYSitsSzNqUi8rcHZBeFdvd0l6VzBTVHMzNmlkZVlIVWZx?=
 =?utf-8?B?UGY4U0FRSGtmNmFrYkg4RWE2bk9BNUxYdGsxbGpGelR4dHl1ZnVURXI5WHl4?=
 =?utf-8?B?ZjBUcVRlbnNqeFUyV1Nib3NmZXNRU1dhK2VySmhGcXJ5Vk85L0p1WmIzQjJD?=
 =?utf-8?B?cVA2MDlWeC9nTXJxRDcxZlBIeFMzU1EvNFF2a1lBUEJvZzFKRWpob3Mzb1R4?=
 =?utf-8?B?QjRoMWo4aExaUWlxL1VHZzNWV05wMWN5Q3YyVTEwOUM2R29vOGZPTTlraFlu?=
 =?utf-8?B?YnJDWTI0QW1hNExzeDMzY3dhR3Q1WjJFbmYyeEVyaHJBZ1k1KzMxQVBQNDZk?=
 =?utf-8?B?SUJ1alZlSE9mb0FiSm5UUlpGRlp4YWl5VlQ0TkxmZzZaQk9BZjhNQ2JValB6?=
 =?utf-8?B?V2VkWFZMakV6WmxmNGdlOFVIZ2tJaVc0WmViV3MwZ1VVMElPR1NTRnFMNWlh?=
 =?utf-8?B?YjNpT2NhbmM5K0JaUTVnU1FEMjQxMzNza3ZQRFc5Q2lyTlFuU1ZiWlJRUURh?=
 =?utf-8?B?WkJLeTN3SXVsWG5PdkxScG41M05XeFVBRVFXZjR0cVUvem91VlRMWnEzVDVm?=
 =?utf-8?B?WlN6emFBV2VrN1g4eldtM0dzMDJPV29LRW1PUmJTUm1JWUczcnNFdHJ3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWtTc3dFVEhMUGxYRjRNNHJYVng4cFM0VC82VUJUMjRSa2RTUUJnQUx2RWF1?=
 =?utf-8?B?NUdrbnZoZHh3TnRtQWF1R0p4ekNFSHJkcDhzb0h2b1cwTTZ0Sm9vT0Y2UnVK?=
 =?utf-8?B?TUVzdFRXc2F4YkIwTzlLVDNxWDJmVURBR1JRSlFybUZ2T3hCYTd3eUI4MXd6?=
 =?utf-8?B?Tmt5VGJCNHpOWkhYRUZHS1E4VHJKV2VPRnU5M2FVSnVUTS93ckFiMVZUK08r?=
 =?utf-8?B?ellnOFk3Wk1CYlpXc0g4Sit3bXQxQVE0Y1pMbDVKRlhuejN0L21JeVZPdTIz?=
 =?utf-8?B?YVBHVCsxZnVYemZFTTRnWEd5UjV1aWcydTB6ampwejVKWEpHak11TWRxbmlN?=
 =?utf-8?B?SFArODdoZDlXejg1SHpsMEdkOXFHcnFoUFRWTlMzZkFMc2VkMDZPNzNVTFhz?=
 =?utf-8?B?QXRvcXpFb1dFS1BQVkpHMTdubkFqVTROY01jUlhKbXhxSndjSzE5WXNCd29z?=
 =?utf-8?B?NkJCUGNySTJJSCtnWTNlVnZqNjhQT2RxblUwSStIa1RPYzU4dVprTThab0Ny?=
 =?utf-8?B?cTNYbTE0K0xoR2FxZDg2L2tDZGJpN2d4RzI2U0ErTVFEQ0pyNjkrVVpFUm1R?=
 =?utf-8?B?YVdLcjJIeE5vcWpqSGlKbXA4cEtlQjQ3cENUSkcvTm1Hei9iNTdHVjdiaFJj?=
 =?utf-8?B?WUo4Z00zdXdPSDRNK0sxNHpRZTdKK3ZvSktJTlJ3ZUd4alg2NWdjbktVOEN0?=
 =?utf-8?B?MkVZeVU2NGJSYlo5TlA2YldRUVllbFBBaCtoY09PM1hpZjF4bHBJTnIwRlZu?=
 =?utf-8?B?TmxFcUJVV1ZvTU1EcG5RVVlUTVUzREcyOFVSVW5ZVnl5eVNKZzAvc01kR0NJ?=
 =?utf-8?B?SEI3aU1FaWRXRStzN01MbDlpSmJvSnh2VWRwVjZHKzdvaUZZamlrT1FnM1RJ?=
 =?utf-8?B?T2ErMUxUZjZmZ2d1VFRUMWoydStxdnVNaVQ0cm5NRllhK2JkcVNFQzRySVpi?=
 =?utf-8?B?a0w1NFhRejNQNWVXT2oxM2JKaVRBem51T1pWaS9KVEk4NmVxUVl5VTRKaGFH?=
 =?utf-8?B?cUVscHVCR3ByV0xBdGsyRFhpUkZ4Y0pJWGs1Ykl5VkZIZzdFZDIyN2JMajBO?=
 =?utf-8?B?cEh0eldVMHpVWEZ4ZDJ4ZGNmOUR3RDR5OGxOL0FsMUYzK1hJRHN1WkdsbmE5?=
 =?utf-8?B?ZUVHODQrMmRCY3ZwYytTQVkzS1QvWUY1M09NOTNuVDdvdTRoa2tJZ0ZpMzNl?=
 =?utf-8?B?ZE0vUVlqV2RIRTNLRWlJeUFkTVpCZldBc0pTd2tOVGF2OGhsSjdzRFFMWUUr?=
 =?utf-8?B?UFhDeTJSN1UvNll0dWQzb3RvL2JGVUJiZ21hT3Y4NVZRaHgyU1ZoNDQvbVcr?=
 =?utf-8?B?VUxJTU9ydWt5WDhVWmlXL1VyNVpjdVJrSk5rbUtKallHTldVbHNvcVhUaDI0?=
 =?utf-8?B?SUVBMW9aeEtnTTNod1ROdlQ2M3V4QS9FK0FTVEIyamsxSzVNMlU5SWdjQy94?=
 =?utf-8?B?L2dEbFUyS0tTbFlVc2xWa3ZiZVVIL2VYeGZUU2N0QVJycXJWUEFreVlmZngr?=
 =?utf-8?B?QVg2SmF4bktlOUtLY2d4bHRjTi9ZT3NyWEpNV2lGSnM5cWhpSDZ5aGFqZUV1?=
 =?utf-8?B?U1RiTnF6NXRYRkt4U01PODRqT0ZLU1RTRTZibVM3azZsRlhwRVA2dEJoMUtR?=
 =?utf-8?B?c3liRElxTThlUjd2cUtkTVFkaDZzRGZiNXgzODVqZDBjSzhkVWNYeVlKb1Rk?=
 =?utf-8?B?dEdvV1RXVEx6U1ZJNnNrcVdVRlVHYkUzdzhiekVLZHdwbE5RLzBCTFRKT1dC?=
 =?utf-8?B?aEFzRHZHcXVnWFpiZlpicnFGeCtCN09DV0hyaHlZb3h2bGlNWm5XL0I5ZWZj?=
 =?utf-8?B?Zlc0Tm1FUmpXRzN2dGxvZkM1K3dpU202UGZmMHB0QmtrbVlmRkhjbGxVZ2sy?=
 =?utf-8?B?Zm85YWhpZ0N1dDVpaHl0MnVBbE4vcDRkdktsR1htQS9PdE51T1ZCMWhQNHdV?=
 =?utf-8?B?ZjlaRWhEdERaRElFcG8yQUovWDlZZGRYS0tqcVdUNlhXQXJzWGt6WFdxTllQ?=
 =?utf-8?B?cWZnWU5PdWYxMnErS1NwQllQR2FMbFhNVXRoemxUN2l4L2VHVkcySTlKejg5?=
 =?utf-8?B?VkhiT3d0elRDR1gwNEVvT3o2SVlqUE5ZN21ndEJCZ0RiWjZXUVoxR1VpamNT?=
 =?utf-8?B?VHR1THlQampBdSt2QXFINmliYjNUcTAvQVZjSzF1VzI0NzRsbXRFMTltejR1?=
 =?utf-8?Q?/Hbaqdlaw3eZeFZt1c6n7iw=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eb0d93e-ff82-4a17-1d7a-08dc7975aa68
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 09:09:05.7951 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ur+EJPJTTENGsd9IFugg47jEuLDo682vfKmkfvli9JinTwiN9iHkwP66hvCMWN1SmS0RJqa0SaY344KYocqTG/oenGy3IlneK15wI9ZqhaU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8099
Received-SPF: pass client-ip=2a01:111:f400:7e1a::706;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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



On 5/13/24 08:31, Andrey Drobyshev wrote:
> We basically fill 2 images with identical data and perform discard
> operations with and without 'discard-no-unref' enabled.  Then we check
> that images still read identically, that their disk usage is the same
> (i.e. fallocate(FALLOC_FL_PUNCH_HOLE|FALLOC_FL_KEEP_SIZE) is called for
> both) and that with the option enabled cluster is still marked as
> allocated in "qemu-img map" output.  We also check that the option
> doesn't work with qcow2 v2 images.
>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>   tests/qemu-iotests/290     | 34 ++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/290.out | 28 ++++++++++++++++++++++++++++
>   2 files changed, 62 insertions(+)
>
> diff --git a/tests/qemu-iotests/290 b/tests/qemu-iotests/290
> index 776b59de1b..4eb929d15f 100755
> --- a/tests/qemu-iotests/290
> +++ b/tests/qemu-iotests/290
> @@ -92,6 +92,40 @@ for qcow2_compat in 0.10 1.1; do
>       $QEMU_IMG map "$TEST_IMG" | _filter_testdir
>   done
>   
> +echo
> +echo "### Test 'qemu-io -c discard' with 'discard-no-unref' option enabled"
> +echo
> +
> +echo "# Check that qcow2 v2 images don't support 'discard-no-unref' option"
> +NOUNREF_IMG="$TEST_IMG.nounref"
> +TEST_IMG="$NOUNREF_IMG" _make_test_img -o "compat=0.10" 128k
> +# This should immediately fail with an error
> +$QEMU_IO -c 'reopen -o discard-no-unref=on' "$NOUNREF_IMG" | _filter_qemu_io
> +
> +echo "# Create two compat=1.1 images and fill them with identical data"
> +_make_test_img -o "compat=1.1" 128k
> +TEST_IMG="$NOUNREF_IMG" _make_test_img -o "compat=1.1" 128k
> +$QEMU_IO -c 'write -P 0xaa 0 128k' "$TEST_IMG" | _filter_qemu_io
> +$QEMU_IO -c 'write -P 0xaa 0 128k' "$NOUNREF_IMG" | _filter_qemu_io
> +
> +echo "# Enable 'discard-no-unref' in one of them, discard 2nd cluster in both"
> +$QEMU_IO -c 'discard 64k 64k' "$TEST_IMG" | _filter_qemu_io
> +$QEMU_IO -c 'reopen -o discard-no-unref=on' \
> +         -c 'discard 64k 64k' "$NOUNREF_IMG" | _filter_qemu_io
> +
> +echo "# Compare disk usage of the 2 images"
> +# Don't check the exact disk usage values but rather that they're equal
> +echo "disk_usage(`basename $TEST_IMG`) - disk_usage(`basename $NOUNREF_IMG`)" \
> +     "= $(( `disk_usage $TEST_IMG` - `disk_usage $NOUNREF_IMG`))"
> +
> +echo "# Check that images are still identical"
> +$QEMU_IMG compare "$TEST_IMG" "$NOUNREF_IMG"
> +
> +echo "# Output of qemu-img map for the image with dropped reference"
> +$QEMU_IMG map --output=json "$TEST_IMG" | _filter_qemu_img_map
> +echo "# Output of qemu-img map for the image with kept reference"
> +$QEMU_IMG map --output=json "$NOUNREF_IMG" | _filter_qemu_img_map
> +
>   # success, all done
>   echo "*** done"
>   rm -f $seq.full
> diff --git a/tests/qemu-iotests/290.out b/tests/qemu-iotests/290.out
> index 22b476594f..f790feae81 100644
> --- a/tests/qemu-iotests/290.out
> +++ b/tests/qemu-iotests/290.out
> @@ -58,4 +58,32 @@ read 131072/131072 bytes at offset 0
>   128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   # Output of qemu-img map
>   Offset          Length          Mapped to       File
> +
> +### Test 'qemu-io -c discard' with 'discard-no-unref' option enabled
> +
> +# Check that qcow2 v2 images don't support 'discard-no-unref' option
> +Formatting 'TEST_DIR/t.IMGFMT.nounref', fmt=IMGFMT size=131072
> +qemu-io: discard-no-unref is only supported since qcow2 version 3
> +# Create two compat=1.1 images and fill them with identical data
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=131072
> +Formatting 'TEST_DIR/t.IMGFMT.nounref', fmt=IMGFMT size=131072
> +wrote 131072/131072 bytes at offset 0
> +128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +wrote 131072/131072 bytes at offset 0
> +128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +# Enable 'discard-no-unref' in one of them, discard 2nd cluster in both
> +discard 65536/65536 bytes at offset 65536
> +64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +discard 65536/65536 bytes at offset 65536
> +64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +# Compare disk usage of the 2 images
> +disk_usage(t.qcow2) - disk_usage(t.qcow2.nounref) = 0
> +# Check that images are still identical
> +Images are identical.
> +# Output of qemu-img map for the image with dropped reference
> +[{ "start": 0, "length": 65536, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
> +{ "start": 65536, "length": 65536, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false}]
> +# Output of qemu-img map for the image with kept reference
> +[{ "start": 0, "length": 65536, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
> +{ "start": 65536, "length": 65536, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false, "offset": OFFSET}]
>   *** done
Reviewed-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>

-- 
Best regards,
Alexander Ivanov


