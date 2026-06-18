Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7425CD98F8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 13:31:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waCpL-0004yZ-Ee; Thu, 18 Jun 2026 09:30:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1waCpF-0004yB-Fn
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 09:30:33 -0400
Received: from mail-francesouthazon11021099.outbound.protection.outlook.com
 ([40.107.130.99] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1waCpD-0006rv-Hj
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 09:30:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ikT61Efjk7xJR1j13H+a2V7/8RtpZ1QSs7eyfB14nWOSUWCmXzhkqBxWChiK0OK02s24X45aKSLoVVApBu89qYGaCvN1zbnOU8/bfmM0qDb71EE5/oZ64H3ew3LcDKEszEXK2nHfh4rTO614Z64kmOiy4MCetq6JTyQRNtInUiuy5Fcht8lBeDUTqtqUdX+e7gQwOp/fJLGyUm330jDU+Tnf2NK0V+yzgAVC1jmtSsCvClWLyRWoDI+vbjPtFHF++DYSry+a6LP8+vrhsUMUTg/jw2MxWSZ0kzJWk2iu1yndjbkd2d/9f4xPGn8VAykMHklHPTtBW9qAShk0hBHe7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eaTeGuDp27M2U2AIa2+X+Czg7XzzFsgdh5KeEgTXRCo=;
 b=ZAikaaVhN3yLQsJmAFOLd1xH3RzPBtc5/WeuoILfacZWZyel5Dj9EPUvM1+qniqaQea0T0EB+4BdFSa9HrPeDH9i05bBLZXlpdWy5YwgIWThGEy9YlOp3vkxTLTerKn3Dmf3ddiJWJHXWfDDtU/R4nROeVg4IJrtulOYACLmBRJuePao2HBO18MIV77zDfcOMR3Dx4MmQo5X3RFaM6LzApDvtciXqFJWyxXRc2SF93qvERaRnEOksvGfi16ZZsO2X4eHSrwnC88gUy7VEP0q8dwRTI8nSy3UEIoMkuh8/6wHikir6WmO6vSg6q/OMOJQer1IZ76ZA2SS/tEmEZU7qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eaTeGuDp27M2U2AIa2+X+Czg7XzzFsgdh5KeEgTXRCo=;
 b=LtNkc/w8lia58U1XTCj3nsijrGhFQEovGSYYXby9Uypjld9CQOSBKZiiS8uPnrJqNuL8vlQL2kHxVhnNc2h5xvsEZsFqZ8tMubCSrQDUK6aG1hMJ7M4SqQXZSu4OK94CR72q1XHKMEy+ME1DQD2mrNIpTStoGYT0pUBn+CxsfZqvu7qeyzE16QzOwObXRWKFpxB45sfw5WITSVGVSmcH5RBpo2B3SEV7em7ae1YwQUF95fQ/M6z+VURP42elRinHL3nBXI/AP9sXupLhMWziydO8etDJUQ0niO8kYHzbwlQ9VB2PLEwaMGYTLqIafHXyWFtEnAXxJMpFT2dD54mIbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DU0PR08MB7485.eurprd08.prod.outlook.com
 (2603:10a6:10:355::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Thu, 18 Jun
 2026 13:25:23 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%5]) with mapi id 15.21.0139.011; Thu, 18 Jun 2026
 13:25:23 +0000
Message-ID: <35f0412b-94db-4ac0-a3d7-3bdf2c2d187e@virtuozzo.com>
Date: Thu, 18 Jun 2026 16:25:21 +0300
User-Agent: Mozilla Thunderbird
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: Re: [PATCH 1/5] migration: emit SETUP notification before CPR
To: Dongli Zhang <dongli.zhang@oracle.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, sgarzare@redhat.com, farosas@suse.de, peterx@redhat.com,
 maciej.szmigiero@oracle.com, bchaney@akamai.com, mark.kanda@oracle.com,
 den@openvz.org
References: <20260612165110.431376-1-andrey.drobyshev@virtuozzo.com>
 <20260612165110.431376-2-andrey.drobyshev@virtuozzo.com>
 <406d4a06-98b7-46cc-957a-d961daf96f72@oracle.com>
Content-Language: en-US
In-Reply-To: <406d4a06-98b7-46cc-957a-d961daf96f72@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0076.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::6) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DU0PR08MB7485:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ad731b7-8f5f-46f1-ded0-08decd3d0d31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|366016|1800799024|56012099006|6133799003|22082099003|18002099003|4133799003|4143699003;
X-Microsoft-Antispam-Message-Info: YxUun3bBv8cQfT+Duz9zgsaeyy5Bg9F0uINikS3M4mGpzGVOzYd+7nsxxKvb0k3E2ueNshuC04SeHpwZQ6K6Jk09HPz0eocok4AH7ylZcLnsaEDJwRDGv/QL7nP5u0PwSxYjMJTJziGrduFINirh9zpm35ib8PWHgZhEfMWFrYkY+5LRksD/9Ca5NVHE2QP7phIetXGgJY50XgkpjMQh9jZqNGRMYZdTEOCaP/1DBDgTqYyh7Z5OgPdTbfVJ3BAylMD7U80T5OsDEinoA/qu8sfgCjCVve+SFCopVr8Zc/VZiMjFqNSM3TKy/iiCnF4lbL2U9yr6FQWn+KwJSlUqwz2aGohIboIXX8K75LGVRMfPOp+h7ezwwkRd2y04WjV9jzRQJ9MvNKgDtP+0WvMuT37pJ09BZK1KHQ7NgPy0XrJSDp5fNSFNzQSlmD+uNr+07lHgO1YBgHbblgsfHn/cPMYCK2TsMidRo0ys3HvXHHJmGhz1irGlqpxam9wiF9xGGH58XMfyhuZRtmfYMWz7NV2cLxAbKugSwD7Ik1AmROlqFtDlSjUngywcmEtiYL9sNuPB8Fe2GzhRMmwSuJsmv2l0gyxVOTBujDtI0gXbJf5yc9qgYerIJ0fC3PNomO4R1orvk4owJtZwd1j986NO20pb4jMPEAhL0Zv7sYCK0dZshGaoXLYZ+cC3+C1c9jbOr55IvlwXtv06jVHlXPX1Mg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(56012099006)(6133799003)(22082099003)(18002099003)(4133799003)(4143699003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VExRTGFac2hzSTlRVlZ5RjdCV0NHczFVUWNDVGE2RWFvSmw4SWZHU2NVcklW?=
 =?utf-8?B?ZnRDcmRQL1J2N1FMRzNpZHNsUkFCSmhvU1hvZXFtT2FVbzZFbXNmeW5ES0dx?=
 =?utf-8?B?S3ZCbTFiNkppRFRUSmVFODRaWEE1dGtZWldaa0Y4aXVDK3doWks5RVRNa3lT?=
 =?utf-8?B?TTRTc21PbERWNXVtRlU0YW9ab2lyVTNXQ3Q5cG12Z0lpMi8zUWkvT2lXTS80?=
 =?utf-8?B?eWRoZzhSbks3aHdhMW9zWktpckUyNHBwUDR2Z1ZCa0VpS21CbTBHYjQ3OHFD?=
 =?utf-8?B?cjBYS2pCMVB4aEd1dWZGQUh5bFlyRFZJREN4c1AyQml0SnE4S05idXorLzFX?=
 =?utf-8?B?SEpJUStYMDQxMDA2MGVIbGRGUytLOTVpd2NUM3Z2cTl2Q3VqWDhsL3JEQXQz?=
 =?utf-8?B?THBGUUExektVWFRXRk9xZ2VsKy8xa1dCaWZhSVBURllINnU2dnMwL3Bka2ZT?=
 =?utf-8?B?OTdKWEw0T1NvS1dqT1lRUnI5OEZSVHErOVRKTUc2NnpOZzFjVmZyckhxRVNB?=
 =?utf-8?B?dlBnNjJPLzFUdGkwTzBQMXBpZGxEYkhxSURBdGhMcEduZFJyWXV0enV0NXd6?=
 =?utf-8?B?QjdrcGplRmhYOEpEM3B1YVRUdy9BVmpueGtaMGxQNXFwSXRDTk9WWS9mK1Z1?=
 =?utf-8?B?VjJRbUliUWtPOGFJc0hQV1VUbVBPNmlvWUQyRnpjc0V4blIrWkVVKzllemE4?=
 =?utf-8?B?SmlsaXJVMlE4VzdHbEZXbWdWQytRM1F3OUtSakxlaEdabU1ZTGxzS0tybkdH?=
 =?utf-8?B?VUZXdTVuaGhuMVY2OHBucGhwcXR1UWk2VVZPVmR0SlFvQW9OUi9yb0xidHBp?=
 =?utf-8?B?VWpuYkk5a1lHSzJsWEdpdVNEWHp0OEJNeHNPY0ovZDZOSkhiWGZjMlpvVVRy?=
 =?utf-8?B?OUtsUGt0YVVCM3hNOGVXdW5zQVpSaGxOUjhpSlVRbUFVaUlXb0lmTDlyc3Rp?=
 =?utf-8?B?czVHOHJ2eElNLzUyaTBGZ3F0QXBNeGpYOW4xUkJETElWNktRZ2N4WDROd1lP?=
 =?utf-8?B?SnBFS0FJT0RETWdHY0I1YUUyWFJiV0V2czVYUmV2WFFZSnA4Qmt4a2ZBRVhR?=
 =?utf-8?B?UURJZVI4SElGdnZYSS9qQ3U5QjgzbG9SU1JzbWd3a0c3OTFQeVB6Rk83WU4w?=
 =?utf-8?B?Sjh3NkkzZDZJY2xXa1ZTM0l0VENxbFVFdHEzRTlVWTJlck92R2x6ek05d1dn?=
 =?utf-8?B?Q09UZlNlQktOYjN5OStNeDUrR1BvRzc4eXBpNUZTOGNvWkNBTWkrbEJzVFRK?=
 =?utf-8?B?QkU2VVcrTkZsOUdTTmc4YXlLMEx0NThRb1dNUWNBVGRMaFFZclk5UXNlQUV6?=
 =?utf-8?B?N1RPbzhYSU52c3Q5b1ZIRGJ4ajFaWWU3V3RWMmZZbmVvZWdja1hqMDJRMGFv?=
 =?utf-8?B?cFVrdlMvNytzTjFteVh5eis3K2Q2SGp4ZWNDeFdYeEQrOXFha1RjWFBDb0U4?=
 =?utf-8?B?MXQzWFF3d0FlTEsrak55QjR2OFRZNDBLYzduTWRiWStDSGhPVFhxRHpZb2py?=
 =?utf-8?B?cldNeWNXMk9XR0c1VGJ2MkFKYVNTaU83WUJxeHg3UW9GcFhSM1k3VHNKY1ZC?=
 =?utf-8?B?dXQyK3hzZDdVNkVwRkhZUkdmTnFGa2U5dUZYUFhiM1FnUkJPM21IcXg1UmFK?=
 =?utf-8?B?dzJPcXZLdG1yc0xlK1JGcHEvL1ZZWjY1SSsyaVhVRVdRYU1TV2xXY3FlM2FW?=
 =?utf-8?B?QmF5N1kyZFE4Z1Q2MVE0K0NXYkozRlpqRGFVVjhqU2tEa0dpcE5US2VLSnlx?=
 =?utf-8?B?QmxqeU5DQ21zdTZKODBJcENJWUFDQU5reFpJVHdYdGF5VG9oemc2ZkkxZjlK?=
 =?utf-8?B?WkNvMTRUN1J0akJITWFSTkU4YWdzMGpNMzZEeklzUnMyWUNlVEs1VE9jaHRY?=
 =?utf-8?B?NkdmWlZPVUZkdzM2M3EzUEZwS2MzV1J5dGpjOUZPajkwL3lrRjVYSFlsQkxK?=
 =?utf-8?B?eGtEOGFVaHRMdTFBS0tYbSt4bzloZzAwNGZkS0xjZ1JPZVJhT1h3UHBLYjBn?=
 =?utf-8?B?ZzdSeXk3a04wZlptR0ptaGQwd08xTUF0S2dJNEpwdlhGSU0vcWV6am42RUxn?=
 =?utf-8?B?bjA2dmhhUEg1bVNJMmcyRGpGMVc0RysvWVBTWDdvN2kwV2VWY3ZxTzNURlNH?=
 =?utf-8?B?KzFLVkRmWWVPcUhsNndNUUpQTURHQm5oZHV2MkNoeVZXdzNZb1hLczRtSWs0?=
 =?utf-8?B?RGNqaVVNd25KS01WbUFEb1Qwb004QjhVVVoyU1lReStaRzdrN3BiOUJUU0p2?=
 =?utf-8?B?LzR6MFBtSWM5VkloMkVWU0pRa2xVWjRNUFhCUmlIYWJqZWRSMTRZKzdDSG84?=
 =?utf-8?B?UWdqaUduOHdmQjdLYjBFS05ITXplb1RXaUc2aHBUdTAyemREekh0Z0wwWnpv?=
 =?utf-8?Q?ruGTz6HbGpJ6PYSo=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ad731b7-8f5f-46f1-ded0-08decd3d0d31
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 13:25:23.3407 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QhCe3cGL3Crm1NBTFLTCmn0clVi+S5WsgsyEjeeqN+iJFdRSKr/QqFgbLzzj6ZPPEtoob5v9BTZ4LkCuv/a/VYwUmMJ2CdK/qSBRLM1C9CU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7485
Received-SPF: pass client-ip=40.107.130.99;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On 6/16/26 9:05 AM, Dongli Zhang wrote:
> 
> 
> On 2026-06-12 9:51 AM, Andrey Drobyshev wrote:
>> Devices register their own callbacks to MIG_EVENT_* notifications and
>> process them accordingly.  But some devices, especially during CPR-style
>> migration, might need to be aware and process SETUP event earlier on.  One
>> such example is vhost-based devs, as they need to call RESET_OWNER ioctl
>> before the target (in the cpr-transfer case) tries to call SET_OWNER.
>>
>> Let's move SETUP notification to an earlier place in qmp_migrate().  Before
>> this change, SETUP was firing shortly before migration thread creation, and
>> FAILED notification balancing it was only fired from
>> migration_iteration_finish() (ran in the thread).  But now by moving SETUP
>> to earlier we widen the window.  Hence let's also add FAILED to
>> migration_connect_error_propagate() and the special CPR-related case in
>> migration_cancel(), to balance things out.
>>
>> This patch is a rework of the change originally proposed by Steve and
>> Ben at [0].
>>
>> [0] https://urldefense.com/v3/__https://lore.kernel.org/qemu-devel/20260128-cpr-tap-v4-0-48e334d4216b@akamai.com__;!!ACWV5N9M2RV99hQ!PqTirI0SC9ktAapICP7w1YqQ7Fwlq0iPjHspIeoQU_M2xXPnQ1X5CJSCrLZEs5H-7rWU1DU_s-tNL6DD8riRAcMWPwp49pQVqQ$ 
>>
>> Originally-by: Steve Sistare <steven.sistare@oracle.com>
>> Originally-by: Ben Chaney <bchaney@akamai.com>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
>>  migration/migration.c | 23 ++++++++++++++++++-----
>>  1 file changed, 18 insertions(+), 5 deletions(-)
>>
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 074d3f2c697..3c70467d314 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -1471,6 +1471,13 @@ void migration_connect_error_propagate(MigrationState *s, Error *error)
>>      migrate_error_propagate(s, error);
>>  
>>      if (!resume) {
>> +        /*
>> +         * Emit FAILED for every pre-thread failure/cancel that ends up here,
>> +         * to balance the SETUP sent in qmp_migrate().
>> +         */
>> +        if (migration_has_failed(s)) {
>> +            migration_call_notifiers(MIG_EVENT_FAILED, NULL);
>> +        }
>>          migration_cleanup(s);
>>      }
>>  }
>> @@ -1530,6 +1537,12 @@ void migration_cancel(void)
>>      if (cpr_transfer_source_active(s)) {
>>          assert(migrate_mode() == MIG_MODE_CPR_TRANSFER);
>>          assert(setup && !s->to_dst_file);
>> +        /*
>> +         * This path bypasses both migration_iteration_finish() and
>> +         * migration_connect_error_propagate(), so emit FAILED here to balance
>> +         * the SETUP sent in qmp_migrate(), before the VM is resumed.
>> +         */
>> +        migration_call_notifiers(MIG_EVENT_FAILED, NULL);
>>          migration_cleanup(s);
>>          /* Now all things should have been released */
>>          assert(!cpr_transfer_source_active(s));
>> @@ -2117,6 +2130,11 @@ void qmp_migrate(const char *uri, bool has_channels,
>>       */
>>      Error *local_err = NULL;
>>  
>> +    /* Notify before starting migration thread and before starting CPR */
>> +    if (migration_call_notifiers(MIG_EVENT_SETUP, &local_err)) {
>> +        goto out;
>> +    }
>> +
> 
> This affects not only CPR, but also regular live migration and postcopy recovery
> (i.e. when resume=true). Even with resume=true, qmp_migrate() now triggers
> MIG_EVENT_SETUP unconditionally at the beginning. If recovery fails,
> migration_connect_error_propagate() treats it as the resume case and does not
> trigger MIG_EVENT_FAILED.
> 
> Have you tested regular live migration with resume==true?
> 
> Thank you very much!
> 
> Dongli Zhang
>

Hello Dongli,

I just tried that exact case - postcopy recovery with resume=true.
Although this doesn't lead to immediate migration failure, I can see
with some extra instrumentation that we indeed have 2 SETUP events vs 1
DONE, i.e. events become unbalanced in this case.

Since in migration_start_outgoing() the SETUP event was gated by "if
(resume)", I believe the fix should be as simple as:

>      /* Notify before starting migration thread and before starting CPR */
> -    if (migration_call_notifiers(MIG_EVENT_SETUP, &local_err)) {
> +    if (!(has_resume && resume) &&
> +        migration_call_notifiers(MIG_EVENT_SETUP, &local_err)) {
>          goto out;
>      }


Thank you for pointing that out!  Will adjust in v2.

Andrey

>>      if (!cpr_state_save(cpr_ch, &local_err)) {
>>          goto out;
>>      }
>> @@ -3893,11 +3911,6 @@ void migration_start_outgoing(MigrationState *s)
>>      } else {
>>          /* This is a fresh new migration */
>>          rate_limit = migrate_max_bandwidth();
>> -
>> -        /* Notify before starting migration thread */
>> -        if (migration_call_notifiers(MIG_EVENT_SETUP, &local_err)) {
>> -            goto fail;
>> -        }
>>      }
>>  
>>      migration_rate_set(rate_limit);
> 


