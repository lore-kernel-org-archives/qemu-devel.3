Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA28EC47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 16:37:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT2jT-0007Vn-5b; Thu, 25 Jan 2024 11:37:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rT2jQ-0007Ue-Mn; Thu, 25 Jan 2024 11:37:36 -0500
Received: from mail-he1eur04on20701.outbound.protection.outlook.com
 ([2a01:111:f403:260f::701]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rT2jP-0002sq-46; Thu, 25 Jan 2024 11:37:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iM2gnZTIO05EH5EHJe3SlPqYOkyApQ7OXgvxQ93jE+rOmfdhH1vjDy2l2BP4L2tri/mQ2coKBI6E2IGjbpLfs30prB+Vzpl1bE/8jABmvqcaGa08Iz4IierGp/0ioBAPQfvu4jA8pyCxzJZvgsznqwBtkYbK81ITJcLadFAv5EK2EfAxl3nmyDGHZOVjmXeZAWPkKGbpE1EMOm+GKXPeq72h16PiWUXSXXFgSrcf4pMl6Xv5ktqKw9U9jUJGGkDtvZ5VwY3l0zcImQ+ksW2Fzn+atQmYBrYZx8cLPwYEwxzqQP6enXJ6BBq6sUqTITd0wUV3R4eLRb2xh9rp3HhSTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=91Gp3A0Hq5iH0guz6b0BX4SRxLrIZfvsdlWHVwVQ3lY=;
 b=RF4wGnm7DH7EHgB3LcrM2tpzt6NYzEkEGJGwL8ajPnGUIH4VfNG2BSfRBwHJ/w84CXnar+Ra++iR0ox3qPP7PdmTE8sCxocBgY7RhJDwT3ED3k6BWBJ46POFP10WnyTH6R8MjkF15qr46Rc40qpQDeLcuuRncJH0fxJQWFNMNpjuJM2LZIZ4Bp+w+uasPeE3cKYNFWnH4Ws7s6EmXRm8GO4+jtF4hEECmOp5K1iHTyCGvRxXiViUE32RaeVdHm/+nc01wB2UFWOhEksJVv/9gV78mMWVblsAnCr/iTqFLrEmb/5dMJwC//xWXa6XrIZtzWz6VONczEnx8qYj+Vfciw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91Gp3A0Hq5iH0guz6b0BX4SRxLrIZfvsdlWHVwVQ3lY=;
 b=SAvYkq0gvMBjimOEqmYb4o1QYBmjwJxcsUpPumpW3ZFTYnZR6RFLviTq7U3Mwacd/y39Eb/h7DW8JJaSqCe6wJEbwa+Uo0zND0e9rpgE2po2qDTODauN7ADBRyJ0QGjAN0ayzz5KK1VVQ/MSheT4li1r/MHm7v24xJycPHvVqBldtvY1T4+1TJhVSgPhnkboAqYn4te3sjMVmfvfds8GtFllDegqfPxQb0z+N2ZfHHV1yItuIoUzQPcjnxu+6fyX7CgRLg0yak+464QBWijefnnTVFOKQpIgeZTd2XgK8gb8Ww2oy6H+/ZDbRjw3pRlzTNMbdFocoKP8CTuphOOt6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DBBPR08MB10650.eurprd08.prod.outlook.com (2603:10a6:10:52d::7)
 by PAWPR08MB9808.eurprd08.prod.outlook.com (2603:10a6:102:2ea::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 16:37:31 +0000
Received: from DBBPR08MB10650.eurprd08.prod.outlook.com
 ([fe80::d027:c96c:6bb1:d5c3]) by DBBPR08MB10650.eurprd08.prod.outlook.com
 ([fe80::d027:c96c:6bb1:d5c3%6]) with mapi id 15.20.7228.022; Thu, 25 Jan 2024
 16:37:31 +0000
Message-ID: <b0a2b7bb-7bb1-458d-abbe-cf9bb29c503d@virtuozzo.com>
Date: Thu, 25 Jan 2024 18:37:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: allocate aligned write buffer for 'truncate -m
 full'
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: "Denis V. Lunev" <den@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 vsementsov@yandex-team.ru, eblake@redhat.com
References: <20231211105559.316897-1-andrey.drobyshev@virtuozzo.com>
 <c197c97a-e296-45fb-ad8b-5ca5dff81ca8@virtuozzo.com>
 <78ef37d4-a4de-4481-8630-26ae9bbcdb63@virtuozzo.com>
In-Reply-To: <78ef37d4-a4de-4481-8630-26ae9bbcdb63@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::17) To DBBPR08MB10650.eurprd08.prod.outlook.com
 (2603:10a6:10:52d::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR08MB10650:EE_|PAWPR08MB9808:EE_
X-MS-Office365-Filtering-Correlation-Id: 58fc486e-8bd7-4d54-569d-08dc1dc3eceb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g7BCBwQJq3dlpK4fAfpoDqZNWNJCLSLtGVSW98/Dc6bisyY1EyzEJuVWIAby/JGSQuT8/4/8pTkK1EhoOF9IFnO+729Qbw7s6pGGZUQ8bL/ElQIAV1JB7Wx3iBeh7BRyftYM6xDJtzYaoUPwtjvDMfg/UgEJ4k7AIoGRAV0O8FxRSyiPd+igM7QND1ZDifW702W2Uzgg7z/7M9+J5UjNY+vjye3+sspbd74DmqWiZSPX7SdDNfVDuwg7xVewXVIv3kjAllUYwKcQOYr0q2ecm8AovxvcE123q13n99Va1pOH28UqzN08w/ekey+IdFofQYG8MyOyVVg2UK7+nyBKnBwJJ4ts1pGQYIoe5U5EtKYNaxIst9McCkXF+++kGaADWTMCPkf7jLP2zeX6o02O8FzqjOu4xGeg5Ubb8ccwXXq6qmwm0aV4V8V1hVcJxV6D45pzd3WYOARfWsfmcdWC6kolJFf4dATyX95EwpsWY8/nAaJCR1576BbbgokYyGW81mMDVXt/BQF8vpVfguwI62S7qIicErqWVNPDUHxhUFHXYd7aPmZD4gqyo48x3Wq2oE5Noelnw+dZRkHn59v4K+vzwU5Oso2SIkTdoRL/Wc1/pS5AiBDKigrzj+WmDOYAbCG2KuYYAgEctpXKpQyMhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR08MB10650.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(39850400004)(346002)(396003)(136003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(41300700001)(4326008)(38100700002)(31686004)(2616005)(66476007)(66556008)(31696002)(66946007)(316002)(44832011)(83380400001)(2906002)(8676002)(26005)(8936002)(53546011)(6512007)(6666004)(55236004)(86362001)(6486002)(6506007)(5660300002)(478600001)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWwyM1VXRExBcWEzZG5uc0VFOFBLeTNPUjQ0UTRrRitYZS9Qd1AvQ0QvZ2Zx?=
 =?utf-8?B?VlJYb1N6OGxCUExkdE5iTjVQa2lvY1R3Q0lYSVZ5UUxpYkFxV3F3VjIyL01F?=
 =?utf-8?B?YTdSVmJvYkhndk15Zjg0VHBiUGR5cWk2dUtTUkRacXloblN0RTNJZFd6SkNQ?=
 =?utf-8?B?K04wVEJxQlE2WEQ0bFg0eFBmOStSTVJzU3premt5SW9WTVNOQmV0dFd1bXgx?=
 =?utf-8?B?YnRVL0cwcHpYQlFuSzhub2FVT2RjY2xqMFFiVGVnTldUUVZqdEhoNEdKQXkv?=
 =?utf-8?B?YnJrNjVBZEFoN1BhVGdyWjRYcCt2cm9ta1dPeU55WTZGYk1WQk90K3RSTTIv?=
 =?utf-8?B?aXZqMVdONWx2dkJxeDAwYjFTRUlhTDdKQmdNcmlZd1ZmbmpmcFNnTGZHemN3?=
 =?utf-8?B?aWZZNEc0U0Y5K2RNcTgwQTA5ZTFvRDZTRks4eEtvSzFia1VKcDZKMVc2L1BJ?=
 =?utf-8?B?UEVNMVBLV2lWYXlwMDdCMXVKVTA0aFNra3g5cjBLZHd3WWoxOThjTENDcjF0?=
 =?utf-8?B?M1dzamRaRGREaHJGT2c3T0U5ZHdtbi9UMHB4S0RLWWRBV0ZlS00ySzNBaGE2?=
 =?utf-8?B?YTlPY3grK3NoQWQ2VUlCQ2VLZ3BiV2VsZzQ2Z0kzNC9PdUxoenhicVZ6QWFY?=
 =?utf-8?B?cXNRMzExUXorQkoxZ1laMEwxcnB3emZoaWRRU3RVMFFkWUZIMzN3YjZ5cjM4?=
 =?utf-8?B?d1pEREdDaEhteVhwcENVdEp3RHhOa3ZWbjUxQzEwaXJ4ZWNQTUh3akFHK1J3?=
 =?utf-8?B?bUlSeWJ5SVc4SFUwaGcyakxoWEdhY1hYSGJFWFEzOHZiTk1kU1JRMkNTT1F2?=
 =?utf-8?B?MnVuaDNQTTA4SWRFczdudlNLT3Y5TVMzMFRoSk52VmdXMFp3TnVWTDNEbkJT?=
 =?utf-8?B?dXd2RjdsWU80b0dMSUJTaHJUU0dac1pGUjBmSUlQLzRwRHRtMm1rVlgxQkxP?=
 =?utf-8?B?M2w1YTltVDhFT1ZPcjFyTFhEL3EzcXpaNXNRNUZrSlVsWVByOGFET2IzMVRz?=
 =?utf-8?B?a1lPbWUxaDR1YUV4OFlZZ283STZkQzd6RjRCZUF2aGtPelEraEZNVWdOYzZQ?=
 =?utf-8?B?SzVjUEF5ZXJSaXR4YjkrTE4rQ2RuRklSa0JyU21EQjkxc2RLNTVNK0pUOHl0?=
 =?utf-8?B?Q3F4eCtES1o5ODMzMUgrcE5ldVl5ejE5Qnl3QTdLRFY5bjdDdmdjTUQ5Skg4?=
 =?utf-8?B?K2E2SGxIUXNpVDNKdE0xMDNCdEpwbUZyWldpK0JydE85NlNZUmJjTmM3aUZy?=
 =?utf-8?B?M2IzRzZlaUtxQkFsK0t3VFpoVmhmTjdCa3VHci8yZVROSm5wNFgzZzR3VjVK?=
 =?utf-8?B?eUtZRURHQ01RUnlobldQbFU1Y2IwMXZwakFXZHQwcWtqMmllU0E4SG5yczgw?=
 =?utf-8?B?T0NZSUZKb1pCcnVtUUtaZXhMWE9hZDJ1TzQ4aDMrbEFyZDhEV0xMSi9LQkNL?=
 =?utf-8?B?YUFEWUFvVEs5c3VZYjdNWDF5Z0JRZFY0TjFLZUZxSXY2TEFVTHpwOHd4YVUz?=
 =?utf-8?B?MG0rWEJ6QWIyRmNRNzBCdEVhNHZudE9oR2FyV2tIa3dGaFo5SXFOVC9zVy9w?=
 =?utf-8?B?RWZ0eVlLR3RMVy9qZHRWTGZ5M3NycUNDWUF5b05mUkErS0RCTUcrRWlMV3Ev?=
 =?utf-8?B?VzdwYWZabWdLRit2ekRKajlvS0NNZks2c1gzUjNVYUxKZVUrclh1bFNDU0dX?=
 =?utf-8?B?SFVsK1p1QUlFQ2ZsYVIyMitRalFIZnRWaStTZE16QllMN3JiUEJVSlZYRmxB?=
 =?utf-8?B?Q256aFlzUUpjNUxhTVdwR2F2SnNpQ3FLY3g5L0hWMVFUVnIwVkRsU3ZQT3Ey?=
 =?utf-8?B?NTZqbWdPczcwMjNpUnlHQXRsSHlyRjMwdHVVcXNGeHFSZjJsV3UwV0ptNnBn?=
 =?utf-8?B?SlVEOTh1NUc5MXRBTFZGMDlhbU05UzIyZmMwT3hMVVdBY0lDTUo3SXRhNHV5?=
 =?utf-8?B?b1JtOGw4dEtBcEJXS2pvSWRWa3E1cjB2SXRhZm95dzgxbld4RFlESldNdFVi?=
 =?utf-8?B?dldlWjJBb1pVV0dSOWp3bDVBTyttSURmbDR0UDl1T0tJWmhvQ0JKMndhdjZY?=
 =?utf-8?B?dFlJMyt4bUVSMjBhK1dFbUQyQnQyd3hNMkxrU1JhYjVCeXBITDFTMW5kT3dm?=
 =?utf-8?B?U25xVWQxZmpGb0xrd2RhMGtzS2FnRllZZXV0b3FvMjFmbVI2MmlPQ2I2WjNH?=
 =?utf-8?B?ckE9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58fc486e-8bd7-4d54-569d-08dc1dc3eceb
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB10650.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 16:37:31.1384 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EH3PM6XvBE5lQcf6CO5gaApcZOQ0QHbnywfFBgD31p7Vu4b31bBCcGEhp4nGstUfTJLAPG2W5+lSHRPUZ+utxnCO/rS4l3c8MQKhsw+QKmc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9808
Received-SPF: pass client-ip=2a01:111:f403:260f::701;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/11/24 14:53, Andrey Drobyshev wrote:
> On 12/11/23 13:27, Denis V. Lunev wrote:
>> On 12/11/23 11:55, Andrey Drobyshev wrote:
>>> In case we're truncating an image opened with O_DIRECT, we might get
>>> -EINVAL on write with unaligned buffer.  In particular, when running
>>> iotests/298 with '-nocache' we get:
>>>
>>> qemu-io: Failed to resize underlying file: Could not write zeros for
>>> preallocation: Invalid argument
>>>
>>> Let's just allocate the buffer using qemu_blockalign0() instead.
>>>
>>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>> ---
>>>   block/file-posix.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/block/file-posix.c b/block/file-posix.c
>>> index b862406c71..cee8de510b 100644
>>> --- a/block/file-posix.c
>>> +++ b/block/file-posix.c
>>> @@ -2354,7 +2354,7 @@ static int handle_aiocb_truncate(void *opaque)
>>>               goto out;
>>>           }
>>>   -        buf = g_malloc0(65536);
>>> +        buf = qemu_blockalign0(aiocb->bs, 65536);
>>>             seek_result = lseek(fd, current_length, SEEK_SET);
>>>           if (seek_result < 0) {
>>> @@ -2413,7 +2413,7 @@ out:
>>>           }
>>>       }
>>>   -    g_free(buf);
>>> +    qemu_vfree(buf);
>>>       return result;
>>>   }
>>>   
>> Reviewed-by: Denis V. Lunev <den@openvz.org>
> 
> Ping

Ping

