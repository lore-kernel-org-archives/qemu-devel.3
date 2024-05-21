Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6E70C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 08:56:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9LI2-0003yo-Pa; Tue, 21 May 2024 04:56:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1s9LI0-0003xx-8N; Tue, 21 May 2024 04:56:08 -0400
Received: from mail-vi1eur05on20700.outbound.protection.outlook.com
 ([2a01:111:f403:2613::700]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1s9LHy-0002MH-HO; Tue, 21 May 2024 04:56:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QnRbldRtCojqU7kNXBQ/ee2DHwdpeEpEBQxqmR7Q5b+6V71Bn5nPcb1Dlpu51mQzOQsGjEbBp29AjckyJ22ScQJUHbMVF110XWvFuCk3M8Xf5yxgNx+nrhroqAHqZkUBeHS8FgkrKJc/+PyMJy1k7TeCgeYqV9MeedcYt7Rvvu3w6Iq1bBbHmXjv4j9033fahgayBU416IM3QIwfTtTtb4j12QP7PeQ7ocX+qaCVgaxGz3ynDNp4XJkSPzvPFwdkjhbxI3k35h9BmT0AyAL9cFbQpbzuH7ec1aX0iqnf3lWirSflW5NamrimsZuxfyZaUzSJAGyXV2Nx0bwjxAuuYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iSAxZTzhWyVkXV53BD8vPmShuPbttaR6IOndvKQxN3o=;
 b=QKoT6zVziuWGSq4TlhO7DPB/BOH8N0n4ukimmqnX6Fm6BEUFqi01aWY9c+6PYAWW1NpLtXhvyivpNCOq8eVWmYqw4tAap7rExrPEwAinG+eh5W7ZxKQrKxECBOLrgxwTII7HS/8tq5wTzYvMBNtIrH8bi71NerK7aKocvJO+UnJMLRoT1hheNhAmm2DAzt5u8BVT023cYkCodbgNsXcq6PNGvj6ewQecHJYWkim0jESKVZAXT5NbTTHdCORq0D0z6sfdF69aqd8kUSy0bVxkU8ABCXvPRT09PKL599bdRPkK9svpaByFseaPS2+g5MLGE54ZC8mhOFJSwNQnGfvjKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSAxZTzhWyVkXV53BD8vPmShuPbttaR6IOndvKQxN3o=;
 b=THCQqFvIKXgZvfkL7gAk43tlGGVYiJzj3MLroUTTEVNeSb1UKm2Xe50d+UJVPSBf0ZplIj76RnjYmTAt+1QDDKE+UgBqCq3x1LoYJ/n2ZOD5f9HITskcavjalPqUp5xqwwLIiFFPaXk/F+1st+GNHvQElVLIPH5ah5RG3SVd9a2BC93BrehTAAY7NiB/pY1FyF5X+ya15j26/ZRiTWRpN6HkJf4M1ixyvJ/o+26gZ3kMGz0M5FtwqGk1ZSeAXjsWMYO1mMzDT57UUnFHmxTWz1QbU967/rOOI1seP9j+l1BUwzV4mxpC1bB0QiwXKGmweqwAVwejE2gpRE104uxsNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by DBBPR08MB10554.eurprd08.prod.outlook.com
 (2603:10a6:10:52d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 08:56:02 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::cebf:31ab:1e25:cfb5]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::cebf:31ab:1e25:cfb5%6]) with mapi id 15.20.7587.030; Tue, 21 May 2024
 08:56:02 +0000
Message-ID: <fad77748-39db-479c-8f34-d070d8e8a044@virtuozzo.com>
Date: Tue, 21 May 2024 10:56:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/11] iotests/common.rc: add disk_usage function
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, berto@igalia.com, jean-louis@dupond.be, den@virtuozzo.com
References: <20240513063203.113911-1-andrey.drobyshev@virtuozzo.com>
 <20240513063203.113911-6-andrey.drobyshev@virtuozzo.com>
Content-Language: en-US
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
In-Reply-To: <20240513063203.113911-6-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0007.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::11) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|DBBPR08MB10554:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b1d3b92-da57-4847-c483-08dc7973d73c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R1FzdFdTSHl0WkVhQjZlYzZXOWdhMjcrU2NONmRZTUFlSVRMTG04R1puWEFj?=
 =?utf-8?B?YTV0Z0Ira1JrZVB0NUdIcFZvM3kvMFQ3VlpySCtZdkVtS0VFd0pXcklRVlRU?=
 =?utf-8?B?bjNSb1FLc2xSSTdHVHdaV2U0U1RkQ00zY25MQnJHNkZDOWlmR0ZscHRnSFM2?=
 =?utf-8?B?ZFFTMktiNFFoa1JRWmNLMEVJbXFZeHQwRUplNVN4S3doWHRtRDVUNit5NEt2?=
 =?utf-8?B?ZzhvQi9TMGNtSTZNN3NLdU1teXJhaWpVejhKZjY1VHJ0b0prUFh4aCtkWlpB?=
 =?utf-8?B?UGwxNVJ5bk56OHJzaTBkRTV6MGZCUDRLUXBSQ3ZSNWVaQWNYV2NCM2M3WXB5?=
 =?utf-8?B?blVud25jRG9Na05vdG5wOUFSeGxWQnltVUlDNlRoRU1maTNPMzVVdFdsaXBJ?=
 =?utf-8?B?Z1Z3NDNVeDVrWmUyYmgzd3FBMGFPSUN2U1FuNUlGb3RDZndPOS9JcGxjNEFz?=
 =?utf-8?B?bERpODh0WGdyQkFQc1NzZ3ArWm1zT283NWJSc1NCeEs1SEc2MVE2cE5UNUZV?=
 =?utf-8?B?SE9mVnJxVGV4dDd6ZE5VbFRUQUtmNGx4bWlKOFhXellZTGhjalhzYklDNEZL?=
 =?utf-8?B?V1h0TkhHSGNkTXBXaUtXbS9JV25ONG1RUDBJbFJkNFA2d1ZOUDkvMVJIMU9B?=
 =?utf-8?B?M3kxSVZleUY4RHBheGM4RjVYNUloMkFFMGpxczZRR21NR0kzMGR6VTZNYmUy?=
 =?utf-8?B?RmttKyt3MnY0NitvWnlMOWg1MzdLcTZzUENkUlVjZUwrQW1xQThsQVVudFNp?=
 =?utf-8?B?ck5OV0o1aXU4QWxhOFNOWjI4SjQzY3dqSlcvblBBaFVOT2lHcnk3ZUZyaWZ3?=
 =?utf-8?B?OGlkdkZ4NGJ2bVRDTWRveGp6OURXVmZYMUxiZW5ENVJwZ1QyWTRaNEs4RjJH?=
 =?utf-8?B?M1l3ZGg3OG1WeWppakkwZmN0bXU4dGFKNkNVZXZGNG9MajZ1K0xCeUFqYWRm?=
 =?utf-8?B?OHo3b2doM3M2MXUyRmNYK05DNTVvL25kQlJ3eWUweFdDR2l3QjhqVGJlbzFa?=
 =?utf-8?B?UVh3VVZCVmE5MXE4TmVQNnk0TjVFUitOWFZHSm5iSkFYSzZqWjRXRlkvVWxh?=
 =?utf-8?B?bzV6cEx2c0xWRmF6YmZuN0JSVFY4eGMzWGtiYUFWRDUvRmc2cXBiV2Y0ejN6?=
 =?utf-8?B?MUdxUmZLTEFXbVhrNzRvWHhsS0M5cmsxRktaMUhNQ2xtTmtKbWpXdHFwaGdT?=
 =?utf-8?B?TW5FT25uTllUdkNFVmpvMUdLeDcvcFl6U3ZHWUo2enNORWZGWStTenF4MUhQ?=
 =?utf-8?B?T1ZtTWtmN1hXTjdJUjUrQSs4U2pxeHZlRklGRm1xRUdJa0RzYnFrSVNCcy9y?=
 =?utf-8?B?UU4rbFIvcGgrWDM1eDVuei9jaVJhRXB1WnNHSXFMODZRUzY0cjB5NERUd0Uw?=
 =?utf-8?B?NDdxVDJzOFlIVFZaSlQ1alRISXF1RjJYVkQzQjlWYVlMcDhTSnQ4RXV0elpW?=
 =?utf-8?B?QWpVMGltRGJrNVUyZ2xkbFFsYjlkd2J2QTNLa09NelREUE5GcC9KVWFqSzNF?=
 =?utf-8?B?L0FKZWdhemxqV2VoaGlrT09hV2NPWWNnUXFHdE9sd1lwcTA2bGN6b0YwQmJN?=
 =?utf-8?B?cGsycmk0Z0MxM25iQTlKMGlucXBhb2Y3cE1GK1lnMFl0TlVRMHdXMG91RmJj?=
 =?utf-8?B?MjBRbVBoaEhZc05aS3JzMVRyL0hlTFRCTll5UUROamlUQjNpaXNERmw3azRv?=
 =?utf-8?B?YTBqendMWEN0eHVvckV1WU5YaTRVMHFJMDJ0V3RucDliQUIwbEpsNkZRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0ZnaUY0dnhFSmQrUUpBVFVSY1hGdTlRcnh6ckRHQmxsRGNhYkRBZnphR012?=
 =?utf-8?B?U3ZZV1VyaGdMOHJ1Z1BXRVBjUlFiZUlsMTBFd1VwSlViK3ZWZ0gwQXBIQ2oz?=
 =?utf-8?B?K3Nvc3NCcDgyS050YVhta1BaVmtNYXRkK0dReXVNZ1FaK095Y2VISUV6cWhi?=
 =?utf-8?B?dmVQSm1oK3REeXF6eVJMTjRkQVV2VUFCcjZ3M0RyOTljMm1UaTBsbkl6MUNE?=
 =?utf-8?B?OGVNSjdkRmZkRFBzaWswNWEwK1cwTjVlS3J1aGdIOGZjMHlaZ2QzRnMzbkph?=
 =?utf-8?B?OCtKcGNJblNFRXBFSDlvS080eHhDVmljL2g5UHRuMHFiWDVEMVk5bkxyL0xn?=
 =?utf-8?B?eTlwbFlQaWxvOHVENHpFaHBONGRIaVR0VklPK0JQZHVYY2lWVlFUem5sdExG?=
 =?utf-8?B?T0VSRXVyYnN0OHlRaEFwZTc4U2VWV0Uvd1B6MGg5MVJRZG1qTlR3MHFaZko3?=
 =?utf-8?B?TmMzakJXbUY5R2hBRzIyOTIrSXY2Z05IQXk3UVo0QndLeittM2I4STJ5bHhU?=
 =?utf-8?B?Nys2Vlgralg4cDlaZC9DUWp3cUxVZkU3R2ticzJXbS9IM09BaHhmTnN5Ukt1?=
 =?utf-8?B?N2dwNVdLN3dkMUZ3V1RwK1crUDNrUHV1L25BSnJ4OFJvckFPUHlKZExtKzRN?=
 =?utf-8?B?d0FtU3JRY1U2Ym9BM1lDVFdId0V2ZFZ1MHYwcVQvcjYyMmpVMVdKRGZFWGtQ?=
 =?utf-8?B?L2tlSlc3b09iVjhJaDBZUmRFL2djZ1pCQ1JLQUd0ekNKcmlFK1hBbm8rZmFF?=
 =?utf-8?B?UDFobCtmcXAzUVI3NUJhOTczKzVWT1BaZVh6S1p3MkFRemFZUFowNkNTd2Q3?=
 =?utf-8?B?R1F5UFNrYVdvVWYzUllraFgvLy9CaHdLMnREbndNeEFHWm1aT3N3NVgrbEN0?=
 =?utf-8?B?VmJCQ0J6dlFKWjE0ZDNONXZIa2xkdXVONUhZWlB2SnNUNkNNMVJIM3QwMjls?=
 =?utf-8?B?SGNqckEraGhVM1l4Q1RidUtLZWh5SjlzbUpQMmxmc3BYT3NlN09TanE3ZUhh?=
 =?utf-8?B?RWovWjV3NmdNZTJhelNGMHRLeUU2RnNDTXRRalhrSyt0Y002SHJQemxYa2Z0?=
 =?utf-8?B?aU5mdndOTWlRQVRCM0FsMkhDRDdoUEFvZlVsSENpL3BjakFESHV3andJY3JV?=
 =?utf-8?B?UXM1WHJpbVg4QWdnTDZOTWVKQTlGMUlIcUFsMXRnRHFaNDhvbnNUbERmR3NV?=
 =?utf-8?B?dUhKQVVWMWd3V0dqM1lPT2JoYmE0cFNWT2dnbHB1NzRWSVI0OVlrNGg5RUIw?=
 =?utf-8?B?WWFyd1hVbmp2UitWOEd0c0ZaaCthSXp0amJpMDZxamJRVTZsQkVMMDZldHpm?=
 =?utf-8?B?YUNwNWMxZHZrNitHUU1TVDNpRGRscmhnL0EwTXJxdnpKNFJOTVdSazlEZVNJ?=
 =?utf-8?B?YmpDWm94QXZWdGtOV0d4VElYTm4xWnM2MFpZNzVEOHVhUmxVeEdaeEFmSUh2?=
 =?utf-8?B?aW0zNEdnK3FJVHdZVHZidURHbTJQTDBIcWd5V2pQTXByK3RxMkRhcmJWSjF3?=
 =?utf-8?B?aDZtbEVkQ2hqdWhINXB2OTUvS1lnVCtQcjdHMngzcnkwWlNTQWN6UzFGTHdt?=
 =?utf-8?B?d0R5UGpMQTErU0hxUFhnYTNzcXduemJQMGZEQWtpcE1oQXBMUVhmc1c5N20z?=
 =?utf-8?B?Sm04YUxxSlF2MGRJdDkyV20vL3V6cHN4MmQ0REtmNkZaM0t4cEQrUlR6TG41?=
 =?utf-8?B?K3o3VHRqWmxwRWQ5R2tteDhkVzZLM1lBVDdPUHZPQTRNR1lXVkpzWlllRVJV?=
 =?utf-8?B?L3YwSzhFbE8xTngvajhmeno0SlJuYisyUEo0MnlLcVhBbXdMNlVMNm9Rd2R6?=
 =?utf-8?B?M25tM3NRS1JtV3dOSkNiU1FKdzBsVnpXYWhEOWRJTlNvazVxelJzdDAraElC?=
 =?utf-8?B?Z0NRbEQ4djVBN0lCWEdjSXFKNlE4cFFRTy92UCtabS9pbGhXOXBhSVlPY0Jq?=
 =?utf-8?B?RlJBUUF6WjBxZUpadnRVemliK014NEtiakJqQ1J3M1BZNE1USytvV0E0dk9W?=
 =?utf-8?B?cDdQUXhYTXZFTnVwVVhHM3JwVDRKd1hncTg1QkhBMkpuMnFjcEtFTWxMSlpj?=
 =?utf-8?B?c2t1dkdIb2w3aVoxbE1QbjVtdVZiWkcwa1ExbndhdWlFUEdhZVpqTVhZSnlQ?=
 =?utf-8?B?WHcxNWUyMVRQM2x2SFJBODMrWGFqU2MzdEhQYVJ1WWN5TkZvdmJ1Z2YwZlBR?=
 =?utf-8?Q?Aq6aW+Jd8kIsWBWEAciGcU0=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b1d3b92-da57-4847-c483-08dc7973d73c
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 08:56:02.0273 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 37a0Mz/mXAGG7ZCCQw71/g0McetfFjTxVi7pDEvLj+dwL1LfmEUvYt1pb6LKDBKzlLN48WlX/dzZOv/sHRMcyB1kWOKI4xUAmVwrvPEK/Wk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10554
Received-SPF: pass client-ip=2a01:111:f403:2613::700;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
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
> Move the definition from iotests/250 to common.rc.  This is used to
> detect real disk usage of sparse files.  In particular, we want to use
> it for checking subclusters-based discards.
>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>   tests/qemu-iotests/250       | 5 -----
>   tests/qemu-iotests/common.rc | 6 ++++++
>   2 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/tests/qemu-iotests/250 b/tests/qemu-iotests/250
> index af48f83aba..c0a0dbc0ff 100755
> --- a/tests/qemu-iotests/250
> +++ b/tests/qemu-iotests/250
> @@ -52,11 +52,6 @@ _unsupported_imgopts data_file
>   # bdrv_co_truncate(bs->file) call in qcow2_co_truncate(), which might succeed
>   # anyway.
>   
> -disk_usage()
> -{
> -    du --block-size=1 $1 | awk '{print $1}'
> -}
> -
>   size=2100M
>   
>   _make_test_img -o "cluster_size=1M,preallocation=metadata" $size
> diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
> index 95c12577dd..237f746af8 100644
> --- a/tests/qemu-iotests/common.rc
> +++ b/tests/qemu-iotests/common.rc
> @@ -140,6 +140,12 @@ _optstr_add()
>       fi
>   }
>   
> +# report real disk usage for sparse files
> +disk_usage()
> +{
> +    du --block-size=1 "$1" | awk '{print $1}'
> +}
> +
>   # Set the variables to the empty string to turn Valgrind off
>   # for specific processes, e.g.
>   # $ VALGRIND_QEMU_IO= ./check -qcow2 -valgrind 015
Reviewed-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>

-- 
Best regards,
Alexander Ivanov


