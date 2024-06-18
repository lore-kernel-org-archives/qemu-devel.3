Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FD0FC2BA15
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 08:45:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJUSg-0007AZ-KW; Tue, 18 Jun 2024 04:45:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1sJUSe-000791-L8; Tue, 18 Jun 2024 04:45:04 -0400
Received: from mail-he1eur04on20727.outbound.protection.outlook.com
 ([2a01:111:f403:260f::727]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1sJUSb-0004PJ-Va; Tue, 18 Jun 2024 04:45:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NwKCx2TXZHPGoJeXhAlcjKa6xXFoAevbFuJJMtMnqD2lo2OZxB42KULGU/8D85ByUPR3G5KVEAVSTIJYUcVKBpFI5cMucNE80TGoFprLC7lLbXz2RhmUgrJ8/NoXOm7ccaQ3/6X/Z737CUDeMjDfrIFUjOj/Av0FCtlHiZVa1gzvAjG5m2FtSxTCwg72adkEgZUzipsawzmRhXLbeAo6hA35SNNa1dwl/E1cfi+36w10bMYPZjIdvhZnBIsvABMLAWUuY94tbnBdkh9AvL+eQAir2uKx1UrWRbC3XpG9SojpBfiaBFics1QImqQsk0pNlrgPBEooI4Mcgq7cRhCZKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vrPm8x5RJdGY8CIZryx+1NwDglH8KKJ5Kkof/Kv4eio=;
 b=UIGSZhqvuNtvojh4ocAVZhXeMKploknnll0K/CCU1epd2YflrayaXpWQnavZzn/wfnLsE1OPkgGTIQQJQGwUwzFnbK+Gt+j7sMQ/FuONDJBiMleY+zluK5NaEHR/XeD4cI3GDCAgby+ol3x6ZpNSg7Dk9bB+dYUR9jaSZEAqFzXCjRZAVOYmTF/NWjIu4KNAAqWBFsT9GxbzcRQSl3o7G8/pdSQU62vCRdVhzNEietDEPNsxgiAhg7NEWLoYf59PjIBpYwcD4x0fTB3g1uurz07S/obYHp5C8fkifDHMenG4P1s+a7703zjfM/XSe3f/9OQeWaQnJMpBAk6H7mflPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vrPm8x5RJdGY8CIZryx+1NwDglH8KKJ5Kkof/Kv4eio=;
 b=wysFsoFIB01cxVVYU/wCk2bY+YwH+BpJtBB8bX7s0HLvmJXJ40WkMfYgpNsxg/hY9/Rv6pJq+Zj/4oLPTOD9axvF0WyEQHAxUFKqEMw6ykfoI86M6L3KwodwRZBdwk3KVF+jOxagyiCixGsPmO0vjIa4CPN+UtoLBKYLgQw17kh8Jwfrk9qzbvmtUpSiVCCuA+spwxAri43c/9GKPijTTuxrfgibmbKlFDQ6JM3VmS9juDWy7yfZVKBquTPzeIc7NH645dQoi5zILtU8dnk2gKIq6p4zpymChHLD1Cnfk0a3+Wc/galSJ6iqknwoT3aVF/ErPP5wV7TJ6SVyToiNWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by PAVPR08MB9460.eurprd08.prod.outlook.com
 (2603:10a6:102:316::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 08:44:54 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::cebf:31ab:1e25:cfb5]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::cebf:31ab:1e25:cfb5%7]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 08:44:54 +0000
Message-ID: <6c103dec-cce7-4ff0-b337-21c130c495fe@virtuozzo.com>
Date: Tue, 18 Jun 2024 10:44:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nbd: Prevent NULL pointer dereference in
 nbd_blockdev_client_closed()
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, vsementsov@yandex-team.ru, kwolf@redhat.com,
 hreitz@redhat.com
References: <20240607150021.121536-1-alexander.ivanov@virtuozzo.com>
 <810e4bf9-ba9b-4bff-976e-047e8be467ba@virtuozzo.com>
 <ooczxb5vojkt6blp2hhyfqcvltgzemtmwmigvgeg4utngwrcpo@2rolx5gvqzlr>
Content-Language: en-US
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
In-Reply-To: <ooczxb5vojkt6blp2hhyfqcvltgzemtmwmigvgeg4utngwrcpo@2rolx5gvqzlr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0010.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::10) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|PAVPR08MB9460:EE_
X-MS-Office365-Filtering-Correlation-Id: 93370139-ede1-48f6-5147-08dc8f72ed03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|1800799021|376011;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OThaQW1ZTVNqdGYvRXJvT1M4OEVpSVJWa0ZhV0pURUJsN0VPNGNiOVJMZUZJ?=
 =?utf-8?B?YTV6ZURmVmc2TlhBY0dPdFZ2bmd5ckU0OW11blZwYmxBZHhORGlVMGprbnQ3?=
 =?utf-8?B?czdCQ0dOazdIM3JlWVZMZm1NL3dNRGg3N1d0bjhEbFMzUmhPZFVUZjlsMUw4?=
 =?utf-8?B?S0lESnZKQnh3T2JmYmx4L0VIdWZLTDdSYTVmMTRVb09YMjJNNEN3bzJ1OFpT?=
 =?utf-8?B?ZzAxK0ZHL014cVpQa3FmTW9SV1EzVjA4TnRDR2ZMR1c4Nnp0WlBxR05YWlF1?=
 =?utf-8?B?aURXVzdiclhiR3cxOWtPaCtVZ2dxM21UWjdhSTIrN2dsRVRwKzBTWm53czNu?=
 =?utf-8?B?ZU9QNDJpZUthVVlzV2hHVGcyazV2bkFRdVBKb2czZ2NxMW93S1A1TWpuU0RT?=
 =?utf-8?B?R1ZYZTRObUJ5Mnl0b1dXLzFIVzhKajJBemxlejJhRGswU3BUcXAxajFFY1NX?=
 =?utf-8?B?SklMUStBK3orMjdlZHlUbnZvVzdhMzhkQ2JUcVNKd2dCaUFDM0J1dWlNUUpk?=
 =?utf-8?B?Uk9UaGZxektPNHNIVzBRTVZSV05wdVNheFBVS2FQb1Rnam13a0p3Zm1zcDNC?=
 =?utf-8?B?QjVRaEMveTk5VCtBR25HeHZqSlFVWjFwQWcyVmE3cFZRTHVsakN6QlA2cXE2?=
 =?utf-8?B?MjhZejZaRzFUa1Rxc2l3UUVDcjN6Qm5qOXZRRnI3U0dtY2RpcWZwSWFFS0Y5?=
 =?utf-8?B?d1ZIMTVJMk5hRVp1aGZ4Ujg5N0d6NGZrWFhOaHBMc3YxaTcxY0RzbzdIRzc3?=
 =?utf-8?B?NUYyNUtZV292RWRBSmZUKzRqSFFYQnVCTEpQYk1zanRXTnFRUGk2NGw4ZjRa?=
 =?utf-8?B?d0ZiOEo2eEhzOG1vTllWVTZkc05iOUhsNmlmM3JKdGdZSEFVZGsxcm5EZXgv?=
 =?utf-8?B?MktCcTk4YXoxSTZNQ1UwTGltYVNRUlFlL2FWZ1VFWklveXpOTVQxTFJBeGdo?=
 =?utf-8?B?amhzWmp1NlNWNGhNbTRxY05UOTdHM3lnZXpNdCtRK24xcDR5a2lsU3FNY0hF?=
 =?utf-8?B?TjB1bnlGclY2WnVwOHN6KysrTGtNcG56R2d5TjFBdjB3eEJ0N25kT2VVSnBn?=
 =?utf-8?B?TXVNWEp6ZXd4bklGVDBIMUdLMkE5MWlMOGx5cThLcVp2bHpmc1p3Y2h1eTha?=
 =?utf-8?B?RG5wTWZ0YVJHMHJLYmlpbHk2bUJsT1J4Ni9ybzBlNmxGUFd3NjQ5VUFKVVRj?=
 =?utf-8?B?N0ZsRjRYZmhyZE1rd3crYWMxMG9kZ3hVNnZuS3VRZlVWYW1jMkxxT0pkQUh3?=
 =?utf-8?B?d1FpeDhpN0J2MVg4VjNtUzZaNnlScVJzU3N5WGhJalJNbm1IWmxLNDFUeDNi?=
 =?utf-8?B?RFhva2lHTUxHZkc3dkJKaWpNbUFFWTNrZkluVDVFOWNaMnJOeTArcVJlWStZ?=
 =?utf-8?B?eVo3ZmFmUXhrMDJYOFZBVDhaazNFZHFZd2YrUkpobmZNeDJzbHYvQ1hlSW9t?=
 =?utf-8?B?TjhiQlpROURxYXJYc3RWTlRHd3VlWUk5bHJxQ1E4eS9VbDRSTnBhRm4rRTY3?=
 =?utf-8?B?cjA0S2xHY0Rud0lsNzF5WnAvRithdDhyZThDRnplMG16b2J6VnpJZkFZSUVi?=
 =?utf-8?B?ZWc2bGtiNU9GelFwWnU5S3phejlzNy85ZzlLaXJTSU5UNnZGeFZmUFVESklB?=
 =?utf-8?B?UUttZEczenRZSmZpTnlYZVZJN21YaythSEtEVWxNRWU1NUZpV2JtQk55QXls?=
 =?utf-8?B?dmNlcUUzbklKT3hXc2IrdjFwbVZ3QmkvZHRaOGcrWjAvQmxBUkVnbGFveTdV?=
 =?utf-8?Q?tEqP7iWLOWdiQcaTo9Axk5vmI9KLrfJbFYqLvrI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(1800799021)(376011); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkdqNE5Ja0dJQkRPcVpCUEdmeGhZQ2orMXl3VjJWSlQwdFBrVlRGRUcwbmNx?=
 =?utf-8?B?OUNCWTBSUTNGOG91cjBOK1pPL21mQmsxdWZZZ2pvZHZGQS8zOVR2MG5pVnd5?=
 =?utf-8?B?ai9rck1sdXFKZ0VIWWV6Y3BHV001cU54MjNxSHVUN2pGMzh2NnRYWW9BSFJk?=
 =?utf-8?B?M2IvTVVKcGF4cER2VlhROHNIeFpmc3NEamhyRzZaSS9tdVBIQkN5SlNmVTVX?=
 =?utf-8?B?WDFRMVVjb3dPSVlSM0QySFcrdWp4OGJpUndtV084N3RCSlQwN21tTzB0Umo4?=
 =?utf-8?B?aStSWkpFc0RQYVl6TDdPVmQxc0NUazVMVkY0UHB3NElVUGRCaCs5NXUyeDd4?=
 =?utf-8?B?ZDMvK3JZTlBYV2NyMDFXMWxKWnBYcGgwVEh3cEFlTzR0YTk5eGZwbTdwZGhu?=
 =?utf-8?B?empZcmlGaGlnUWtXZ21XYmdFMDZGZDlSZGwwamFDZFRvV0FJQmZVRktERUhx?=
 =?utf-8?B?TjhsdTZHdDlBeVdSOVNlS1JYSlAveG1NSHhpUS9paG5FOTM2MERzL2N4Ky94?=
 =?utf-8?B?aVljYjhiZG5hSXl1dUNscmRpTHUwcmpYNCtOaVFaMG81QUE5TXRNbEk4WnFC?=
 =?utf-8?B?VnRVNVpiclRlNzFsRjRtWklqaFhaNGVTQkphZHhNTGZsRmlpSkFXWjdDOXNv?=
 =?utf-8?B?V0lEeG1LL0pJWTl6UXlVQW9aSjRjU1FjQlBGV2Y2VFpFT0pLdEVTVjJkM1Vs?=
 =?utf-8?B?cHRyOCtNUHBnQy85QWh5OGhYbC95QStWOHUxZjFUR0Nndm9uWU1sbHMwb3Ji?=
 =?utf-8?B?cWtTUlVpNENBSGZBRHBsZXZJZzNVQjZhSXM0RDVPVHZGZUpraFM3K0ZpZ3hu?=
 =?utf-8?B?UWc0MzIvTkMxQ1ZjRkJOZnowd2QrSzdTZlRDek5BMnJYTndEalRZam9xZVRK?=
 =?utf-8?B?TXNjeCsvUDBWblNGR3llRFdFd1ZTZWhaTVNIODRLc0s2TU13aUxIZUJHY2w1?=
 =?utf-8?B?cnFYZzdUekRlSVhkZlozT2N6ejRPQUl6dVdiaVFBWkNrQ2dsZ3c0MWRaUFZI?=
 =?utf-8?B?d1B3amhPaFF3NE1BWmxjYm80WVR5S2lPYWdPVDNhMTN3ZWVSV0t6R0hyeGlP?=
 =?utf-8?B?YUVsNklQOTJpSHZxSExKNWJIdlRzQUF5MkdwWlA2RzJZUmhNbWFWUysvNUxh?=
 =?utf-8?B?eWwyNjM5NHVDTmxncUdhazdTZXE4ZFM4YlhHc0lraER0L3RMNnNBRExnNzZI?=
 =?utf-8?B?N0pFUTJYVDlNU0JKT3M0aGNtRTdIYy9RS2tVa3RjTmtMcHZCUGdrM21SdVVk?=
 =?utf-8?B?eEVMdXQ4cDd1RERyNXNWQlJOSzk1SzJSY2YrNlVweExGSm1vSXUyTW5RUjA3?=
 =?utf-8?B?azUzZjVKWS9kTEhTOE9JVHVldFk4VC9sTWpWcVNhQTJIQ01iR21lZ3lkUzBO?=
 =?utf-8?B?VVYwN3cvMHA2MWVqNndkanNnYTBLVnQ0R2RBOWNUL2g2djdCMFhLSnZ6UWlW?=
 =?utf-8?B?WU5DQmdxU1hkbTYzY2wyQ2EzSWtRMVRMbnhlOXl4KzJFaFRhQmMxanhFR1Vz?=
 =?utf-8?B?dHA2eEhoVTJ5MkVaeGt4ZlFuOFU2N2RTMnFZd0ZuUURWd1hteFY5YlpFcGZp?=
 =?utf-8?B?bENxMmdPSnlwYnpDODBpbEJhaFVvNXk1S0Z3YS9LNXo5S2p0NHE3MytEcEM1?=
 =?utf-8?B?RDFTNFUzd1M0Ym1CWHBOWlZ2emN2eXpmU1JWQVZXVjJPdnJtd0xhK2ZsTFhO?=
 =?utf-8?B?RlVKODI0UUYxWlhVNWlzWmxISnRMakcxRHh1Y3NrY01vY2xNS2N2MjdKN0x2?=
 =?utf-8?B?R3IxM2JjdWd1UytsQzcxTkdrMnpBMEFjK2xyalMzZ3ZnTlRKRFJsUmpsWGxY?=
 =?utf-8?B?RVpwV2hHSS9PREJVWWdzNG50a2VFaUNFN29sRTVyS05ReXlRRmJtUzF5ZXRq?=
 =?utf-8?B?N2t0cXF5WjNIejZCUi9BM0dETm8zaDJ0Kzg5ODhaTS8yaDJscG5BQkxJV1Rn?=
 =?utf-8?B?OFAyUVZwQzhua21TUVRmQ2FObGdua2VJUDA5V2hBZXhWeUdoSVhneFIzcHBJ?=
 =?utf-8?B?Q2xSRUpjK2xzWW1KTmJiNXdhTzdickFwRk1MUnozQXRCbTd3S01LVDh6Zlha?=
 =?utf-8?B?NDZXbGdBRjVwdWh1OVplaVFhTVZRWHdvcVlOaHRZbUFDMVhJMWF3UW5EMjhx?=
 =?utf-8?B?Smt3VkdKaVd0NFg5MmZoV1RoUWpuZE9QSmhPaW16bGxpWCt0MmcrVHVqRkJL?=
 =?utf-8?Q?DX+evGGlj23jovgUVEQmOOQ=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93370139-ede1-48f6-5147-08dc8f72ed03
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 08:44:54.6638 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1QAjsmducIlWHmC5s/HbGLDlkmJfZI1MmC5KC7MONDvQs3iv7ZjXeUyjCoBUL+hQWZF3b9av/PpqN+VoGJDMGqylhIJmmCQK+7uZwZH/Vbk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9460
Received-SPF: pass client-ip=2a01:111:f403:260f::727;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Hello Eric,

Do you have any ideas about the bug?

Thank you.

On 6/10/24 14:33, Eric Blake wrote:
> On Sat, Jun 08, 2024 at 11:36:59AM GMT, Alexander Ivanov wrote:
>> There is a bug reproducer in the attachment.
> Summarizing the reproducer, you are repeatedly calling QMP
> nbd-server-start/nbd-server-stop on qemu as NBD server in one thread,
> and repeatedly calling 'qemu-nbd -L' in another, to try and provoke
> the race where the server is stopped while qemu-nbd -L is still trying
> to grab information.
>
>>
>> On 6/7/24 17:00, Alexander Ivanov wrote:
>>> In some cases, the NBD server can be stopped before
>>> nbd_blockdev_client_closed() is called, causing the nbd_server variable
>>> to be nullified. This leads to a NULL pointer dereference when accessing
>>> nbd_server.
> Am I correct that the NULL pointer deref was in qemu-nbd in your
> reproducer, and not in qemu-kvm?
>
>>> Add a NULL check for nbd_server to the nbd_blockdev_client_closed()
>>> function to prevent NULL pointer dereference.
>>>
>>> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
>>> ---
>>>    blockdev-nbd.c | 3 +++
>>>    1 file changed, 3 insertions(+)
>>>
>>> diff --git a/blockdev-nbd.c b/blockdev-nbd.c
>>> index 213012435f..fb1f30ae0d 100644
>>> --- a/blockdev-nbd.c
>>> +++ b/blockdev-nbd.c
>>> @@ -52,6 +52,9 @@ int nbd_server_max_connections(void)
>>>    static void nbd_blockdev_client_closed(NBDClient *client, bool ignored)
>>>    {
>>>        nbd_client_put(client);
>>> +    if (nbd_server == NULL) {
>>> +        return;
>>> +    }
>>>        assert(nbd_server->connections > 0);
> While this does indeed avoid the NULL dereference right here, I still
> want to understand why nbd_server is getting set to NULL while there
> is still an active client, and make sure we don't have any other NULL
> derefs.  I'll respond again once I've studied the code a bit more.
>
>>>        nbd_server->connections--;
>>>        nbd_update_server_watch(nbd_server);
>> -- 
>> Best regards,
>> Alexander Ivanov

-- 
Best regards,
Alexander Ivanov


