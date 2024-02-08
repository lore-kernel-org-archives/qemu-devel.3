Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0155AC4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 18:33:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY9Cg-0002oJ-RB; Thu, 08 Feb 2024 13:32:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rY9CZ-0002mP-OD; Thu, 08 Feb 2024 13:32:50 -0500
Received: from mail-ve1eur01on070f.outbound.protection.outlook.com
 ([2a01:111:f400:fe1f::70f]
 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rY9CW-00029I-PW; Thu, 08 Feb 2024 13:32:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dpyDiOeX0Jjv8MKEH4lpncNhPD7HbDdUVB8aSfy9uiqsgmsPwebuMkQWid/+oJ4XfVMo9bE3Oo5dR+CTYC1kilApjRDx1FNFHrkTo4bCLKESAUtf7pN7JxRyJR3TK7g00xJVajfdXXxPlDSG00JZ7Kp6tnxRhXJAZlMNh+kXQVNl8HZCEFYWMrXdIeulFNy5mOcej32MX/818ZrDMb3KKdWopDxl8j4U+FpP+7rCgadfVf1MKWXNh0p5RM0w2gnUFgRW50uTUjyv7QfjP8coYQqK2xDGk7WAq98KTcevhOz1F9ff0lB+dCRSJKHvVv/xeZMbxwo9ea2hj8hm5fGOyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JaWq9pA/kY1gGnNiaAIUENG5DMULw1euvALSrD/L4mw=;
 b=asGUy+Ft3oDI4+8xhIdarUEa4EV+6XsDbPsK+GOxbOkqUH3PjnpWHh8XfD/9vOyyxI1BPlBWLl/uxYXzIlTV9Z4gF+bfKtu6QlAcxmXxdJdZawYyU5obwZV+LnOCKpRxSaFWTgHYQgZcK5R1CPI/A4OzGo7AcRkwoBIRU906mBXT4u03rpV/3XQZ/QTXfqMBiw+qW0DuS1ER0I4eFe8mlRejlNh68KYizfnxiy3hygGMa6L56xvp8FbYoeVj1Eqq+O5tWKLCiUOiHSYT865MHNZTwUqdq2qAkfvU7TRAMSc8Ca/r1ahQpcVGSuhxXcPNJKRAw0//vUd82Z8ytk1otw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JaWq9pA/kY1gGnNiaAIUENG5DMULw1euvALSrD/L4mw=;
 b=IvP5ZI5BBOF1vA7QFzIcGGCuoSLQ/8cjcJSBsHn/FT6quF7g/7qcz63qKnUhWBSTzfJY//do6/Y1GMq4F1aYodqobPPwSnejCz2jE1MW5Bcl7ATx/Jx0Jqj2ZLwrDva1ZDqJHTH4Ef+n9G4N0Utb46PZ9JhFe5a+rMVoYwCWUoWl41LGIE03qj8cziQUbJlcOCE3HwU1bEySoNBPJ//H0Tk4jIuLLQUs/n1vjV2Aws6E/meKnaz/jPWLn76fHOdMcTKmDbvIF/fcotmZ0EU1Jo2uJn/Bl3OT+qsEGuVwQmF3uLITrEYnjVFWFBA+FiXUmC97Zr2TF8gRiqv7Rzwjmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DBBPR08MB10650.eurprd08.prod.outlook.com (2603:10a6:10:52d::7)
 by AS8PR08MB10098.eurprd08.prod.outlook.com (2603:10a6:20b:62a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.37; Thu, 8 Feb
 2024 18:32:08 +0000
Received: from DBBPR08MB10650.eurprd08.prod.outlook.com
 ([fe80::d027:c96c:6bb1:d5c3]) by DBBPR08MB10650.eurprd08.prod.outlook.com
 ([fe80::d027:c96c:6bb1:d5c3%6]) with mapi id 15.20.7249.039; Thu, 8 Feb 2024
 18:32:08 +0000
Message-ID: <a7e83294-cab1-4b28-b0cf-d00799d1d7a3@virtuozzo.com>
Date: Thu, 8 Feb 2024 20:32:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: allocate aligned write buffer for 'truncate -m
 full'
Content-Language: en-US
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 den@virtuozzo.com
References: <20231211105559.316897-1-andrey.drobyshev@virtuozzo.com>
 <6620975c-c962-4aff-9592-bb0ccad6c307@yandex-team.ru>
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <6620975c-c962-4aff-9592-bb0ccad6c307@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0218.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::14) To DBBPR08MB10650.eurprd08.prod.outlook.com
 (2603:10a6:10:52d::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR08MB10650:EE_|AS8PR08MB10098:EE_
X-MS-Office365-Filtering-Correlation-Id: 382f5247-4f36-4fa2-d616-08dc28d441da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mzpFbFFnCRWpq/cedtxOEeMjKZ2Ekgk6SQXiI6sqI08j2xkrsRJYEdAIKIksrOHeZgvxjUR4wCG5/0hSe1NKhzpp3renohplDv1FAs8nOPBII3MdIj2VzyTZoJxxa96scOJQxa3UfFdD2hBYOZrmXpTHLJV9UnzqKB1oofjx3Pl6znjemiw+f1Zl74ZG5lxDfQwYCo/w33z3Udoxm/Y/s5scO7kXo07awpXfMMvkz9liDTErGnd6gZoHq/oRt/Fhtk3eYOmQcYlQpCFu1WGbiPQ27SxJDq9njTt8E/whmLHMOFb/PjhryPl9Ki67xs1KkyKCb2W2ScBEf6UmIpxcmAbYufDp1nJRO4ewum7l0b1siwa6mFPPQi8oxVKSHIA6fUCyc8wQTaj/Dk6ywipClpW5lUj8HtsAyw214XYGhKribOt7Ag3PSbK0LjZ33TjLNzAhgzV+tn4tTw56ev2/i4s1kjdP4abMva5/7axDPiGooK6Z4v3Yneu2GukdS3/PI+9elQ7i+rnC67bGmqq5o7w+p2wW4rTkMj9c3jMkoJQnD5JbizwvHf9HncVG5dSV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR08MB10650.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(376002)(39850400004)(366004)(136003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(31686004)(2906002)(44832011)(5660300002)(41300700001)(83380400001)(31696002)(38100700002)(2616005)(26005)(107886003)(86362001)(55236004)(6512007)(66476007)(6486002)(6666004)(66946007)(6506007)(66556008)(478600001)(36756003)(8936002)(8676002)(53546011)(4326008)(316002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTIyeXN3YzhQQlFYOUUwNnFiUEloeXZMK0J1YTVUUHBDcmNJOFd2Ulp2QnBr?=
 =?utf-8?B?NTRaM3k3RWNvN3FkY1JERmpXbHRJMDBIc1kvZ1l4NGtMVjQzdUl3MC9YZUor?=
 =?utf-8?B?QU9QaDJtTGJhMFRQSTBOWmpVeVI1OGY4UmpVRHpZa0VZeU9Ib2RwcjFUS2VE?=
 =?utf-8?B?eVB1a0Zob3RteVBWaXljOURId0laRjIvTXEvQndjVGNreVBjcUhtSUVNSWRR?=
 =?utf-8?B?ZnRHT3ZCQWFvSittd3FOaVBrK2xOMUdaVVMxcEtvTVcwbUt1QTVxM21wRGJz?=
 =?utf-8?B?eENKN0VhSkNORGw0TW5ubG0wOHBlbzhSd0tHSjkyMjBORzVqVUtnSHFEWTFF?=
 =?utf-8?B?cTV0RlgxNzlqdjBxNW1CaHhDVWhoMERlV1ZQRmQvMmkyd29iNElPbC90WWtx?=
 =?utf-8?B?SDEvcTBrMm9EYmI2Q2psSHBCMG9yQlVxaHk2eHY3YmpQeHdTYmpDcWYzK2p2?=
 =?utf-8?B?RXgwcFlIRHk5cGJlV0xKUVFwV3ZQNWszNXVqaGY5ejgwWkE2bDhCRzV2M3pZ?=
 =?utf-8?B?Y0JBM3FoUlpvWThwdFB0cEhUSWU1WVFSQ3NGeHErUmhkUEFCZGo4NDZ2WUF4?=
 =?utf-8?B?S1pSS1lCYTJtc0lkWm1RYXpmZUxJMmdNNENBcStVRG1tZ0ppc1FKY3ZQc2VB?=
 =?utf-8?B?WTFwNk5HV2xPNEllU1lYQldKL1V1OWJyd2RiREVyL3ZVdlRxMjh0VjU0KzZL?=
 =?utf-8?B?UDQ0NHBFYTBjY2lJUXorTDEvblZDejhsTFZld1J5TUVtN0R1dDJDeTh3Rm5y?=
 =?utf-8?B?bmQwV0hFR2JweVF4RkF5UEREWkFHZE4wa29reFgrOHBwZnlmRGFpZHZ4NlZk?=
 =?utf-8?B?NC9TMnJlN1pRcmJLa0xLL0x1Q2R1RDlBMld5bHdlZHdoT0NQSVkyS2FBVFMz?=
 =?utf-8?B?Tkwvc213YWFOdU5PWjlQQWZRd1VPeHR0U2ovajduZUh1bG12c2kwb2NMa2lO?=
 =?utf-8?B?TGtta2RPcjA1UnN6R0p3S1FOVVN5TjV3TExZYStDRklhZHFkTU5MRXdDaEkz?=
 =?utf-8?B?SHRMMlliaUNsOFFSdGlFTmVXcFQxNWFzZjFsa29ZMXRSdG0wTXJrc3M0OC9U?=
 =?utf-8?B?eXV2RzVCY3JlOGtiSUlHMUhvYUFRRGVTMFNmcEM5Mno0RkMrSnYrOU5NKzhF?=
 =?utf-8?B?TFNLZTZHMWViRkU2aGVRSC9CWVJXZ3kwKy90ZkFrZWF4blRIUWYrSFIxVWhi?=
 =?utf-8?B?RlMrZ2hXRjRyQmdZbUtGNDlBZ1lWTkZwYlhDdjB1bjZPVEJRWngvQk5jb2Iw?=
 =?utf-8?B?VVVkRHBuei8yZzRmWnYyYjFXbHdCSU1aUDdUWFovQzBzcmxXVmk5UnF6ZU9H?=
 =?utf-8?B?Tk5ZNnJZUlM0QTVNUS9vOWNSV2ZIdTd6Z2NMQ05jb09LVFdrRGNhWXBxaFJZ?=
 =?utf-8?B?aUlTbWJzT0Q4TTZ6TXIzNnQ4dlRremQyWEVhSjkrbURJMjdzbE9Rc2RuWWw0?=
 =?utf-8?B?aGxEaVo0SVhLTGlUSUpwRW1YbjZkUUpBN3FIbTRuL0Z4cWkyUTlTQ003TFJp?=
 =?utf-8?B?bFVGWU5lcjhrLzgrZ1dsQzdPa2RwTDVPcDdPRmR5SVpXNHBKVmR4NUk4Yko5?=
 =?utf-8?B?UmRWRXBLTDlnV0ZxaWZDeEp6MWRFb0xMak9RUGx2L2FlTW15RkFDS0dwQnR2?=
 =?utf-8?B?cW1wS2tSR0w2azM5SisrYitjNEhwYThPYW5UU3dVTHRBNjIvVTRTZkd2Qm54?=
 =?utf-8?B?V2h0TEpvZlBGMVpmOVJtVFdJR1hYTlB5K1NNQ090NVkwUUplaDRlakN3dmlj?=
 =?utf-8?B?a2tZbWN6ckJmSEw2RXB5d3ppSnFQVDNpMlRqNXpCeFdidW9RS3BHYjlwUFQ1?=
 =?utf-8?B?eUQ4M0dSamF6c01aejgrS2VZamY2RzhrdVFoMHhESEE1bi9KNUdYTGQ1eGtZ?=
 =?utf-8?B?VFByWVhqbklEMGR0S25UaU5YUUZIdS9TaVdnaEdUTEt0RkpmUCtYWDV0Q1dX?=
 =?utf-8?B?OXBBanVpSVlueS9MUkJZMTVoZDJQclBDNkJSYjl3REx4RTloZWw3aDBoakM2?=
 =?utf-8?B?YnhNZ1lpNnNSNW85WSsyaUlNYUVLd2NJaHJ1V0NOcHdrVWpaa1dsZjFMTkFI?=
 =?utf-8?B?aDJ1SlliNk5zVzY3RzcxNnRKZFZXOXEybDlQL2FlRkY2WnlOUkxIUFk3VlhB?=
 =?utf-8?B?RlNiNTlzRE85c3dMdldid3BkQ1BFeHlSTUh3ZnhlT0piRWZoOGhlL2JMcG1U?=
 =?utf-8?B?cnc9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 382f5247-4f36-4fa2-d616-08dc28d441da
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB10650.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 18:32:08.3915 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2MH96JLQ396kmLVzLgfJ1atw8AJH5he5PTfUV8dbERI4VP0o4rPIzRUAUjaCL3hPN7ZHiaa6QwXXOORcmZTsRyArFGjvN5PWHHf7d6fchNg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10098
Received-SPF: pass client-ip=2a01:111:f400:fe1f::70f;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
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

On 1/25/24 18:46, Vladimir Sementsov-Ogievskiy wrote:
> On 11.12.23 13:55, Andrey Drobyshev wrote:
>> In case we're truncating an image opened with O_DIRECT, we might get
>> -EINVAL on write with unaligned buffer.  In particular, when running
>> iotests/298 with '-nocache' we get:
>>
>> qemu-io: Failed to resize underlying file: Could not write zeros for
>> preallocation: Invalid argument
>>
>> Let's just allocate the buffer using qemu_blockalign0() instead.
>>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> 
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> 
> I also suggest to use QEMU_AUTO_VFREE (keep my r-b if you do).
> 
>> ---
>>   block/file-posix.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/file-posix.c b/block/file-posix.c
>> index b862406c71..cee8de510b 100644
>> --- a/block/file-posix.c
>> +++ b/block/file-posix.c
>> @@ -2354,7 +2354,7 @@ static int handle_aiocb_truncate(void *opaque)
>>               goto out;
>>           }
>>   -        buf = g_malloc0(65536);
>> +        buf = qemu_blockalign0(aiocb->bs, 65536);
>>             seek_result = lseek(fd, current_length, SEEK_SET);
>>           if (seek_result < 0) {
>> @@ -2413,7 +2413,7 @@ out:
>>           }
>>       }
>>   -    g_free(buf);
>> +    qemu_vfree(buf);
>>       return result;
>>   }
>>   
> 

Yet another ping, just checking if any of the block maintainers is
interested

