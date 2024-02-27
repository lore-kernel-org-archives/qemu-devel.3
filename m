Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81501C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 12:38:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rewil-000453-1E; Tue, 27 Feb 2024 07:38:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rewid-00043V-Dm
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 07:37:59 -0500
Received: from mail-dbaeur03on20700.outbound.protection.outlook.com
 ([2a01:111:f403:260d::700]
 helo=EUR03-DBA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rewia-0000Qi-8D
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 07:37:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZnN8Ri+OS0Q/FiJNNuRyG1kaZiC4m0bVlLt/dLuj5JBY60X0EEUvmfIxzs4CBFyi9ZmUD6cPVADSzU7U41ccC2KHmqa8N44sccfCXq7BiRfzU/YSgqmMeil1UZEvL7877fL3oLHrISSKev6Mg/DZihDXaFPScOS3Sqq0rm9Tyi6vo+tHNyp6XUb/tLYPjhMfpjkOjavlDFa/+/JyBsbu4qJyNsxCvsoPFxpH6tgMt9nptv6XzHaQ2aV7q/zffZwfMfGfYZF8siaBmAENjeli79oUfR3NJ/B0btYsZqZn56v4uaPrGOUsRbhP12fEpc0tqh+1aAsgs5yR/AWAyUEpDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VimhYcDXHNrK9Msb2J5/2rPJv2RDCiT1/yJLz8pA1Go=;
 b=hvj7cRUvfvoSOa5ufJTBhSc7xgVI4+x1BhnLoge0KkdThr6gZKzpNE7O7JfUSdMP9Iw/+YnBeL9K9u7MSeaEb3SUQQ3PVvO3EBJLMPYXgBavku//htiMZrZ9ygUTpvy+JWDGXvAK7KIqst5Qpi+R9SQbwUa68K64LAqG8tSDRSjg8RnKzlFL3LvlaFOOPz6ET6TYQ49g2/Iyg/4LgHtBIM7oMA6hGzQuWtKDBBMZr4juyuhdYB/rWYfPUJh0mfy+QuL8aGMi6Nk6002cPygRGQsyECf1Vo6nBy3UFl1yXDqzJdJ6smVxNnG+/rB+RXk0ydwMRG1EvdAepcwzLoQd3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VimhYcDXHNrK9Msb2J5/2rPJv2RDCiT1/yJLz8pA1Go=;
 b=aaNwunNBDMwbJcJG00pSNFurx6KYu0LX/n59CH8ofKB+Dx2lkl93XBS1rqIGoyuh5jZ18RD/d+CjBeGnIIrReecZ5mbHEYfhaKsaRZ3JUc1E+xe9e9EnfcbQh7teFHRe8rA6LtJfhI1Bq7Q9JB/yKthMo+BW0rA7aAvMVjZ6L+LvanC/X8rIkk6yGbfLovfejwk89MJpNtrJd8WN9UfkGahqkFunTN2ujunf5FsUUjOkHa62mPigo+lJRhK6vEE/dFV8NqFuEiVLu6ZsVkYyV2lnCuSm1I9+/S96TXv9nV9VIO2YOulmYAjaQpYVg+kqNcjXfm68dJixwOfR4Kik9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by PAWPR08MB9494.eurprd08.prod.outlook.com
 (2603:10a6:102:2e3::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Tue, 27 Feb
 2024 12:37:51 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::dbee:6dba:615b:bfdb]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::dbee:6dba:615b:bfdb%7]) with mapi id 15.20.7316.034; Tue, 27 Feb 2024
 12:37:51 +0000
Message-ID: <51cd548f-856e-402b-96b4-c8cfe1db30ef@virtuozzo.com>
Date: Tue, 27 Feb 2024 14:38:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] qga/commands-posix: return fsinfo values directly as
 reported by statvfs
Content-Language: en-US
To: Konstantin Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, marcandre.lureau@redhat.com, 
 den@virtuozzo.com, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20240226165642.807350-1-andrey.drobyshev@virtuozzo.com>
 <20240226165642.807350-2-andrey.drobyshev@virtuozzo.com>
 <CAPMcbCqf_fh67zRvarH2Y3tD-HPY=+O4nDC=6af+TGuMm1yj_Q@mail.gmail.com>
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <CAPMcbCqf_fh67zRvarH2Y3tD-HPY=+O4nDC=6af+TGuMm1yj_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0084.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::20) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|PAWPR08MB9494:EE_
X-MS-Office365-Filtering-Correlation-Id: b636f0b9-4320-4bd2-49f8-08dc3790e93d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w1Usvi3hRDDp5cq5MkWGXBxEIBhJWMwqM8IozU8B1f4JgUa32+mlb8fNMayWjEQcQ/5V77MHw0KOXJmcHV54CF7xtcRUSPfS/JAUtMhZ7mRfcyprz95G5jbZAagvhR59M7OWXfYNdZj5ZHvdhoY4lLYTXChGKD1W8RmhMR4QSWICLLOcuKZyIYCa1m6z782kjBAktdHbiS0AJYhr2nhW3QUVc+7goiX8wOTciz7G7uGit+6F8uiBMB+dTDECXAdLufb9TR20x0uLcvrrA6XUTvKmVurA1ijsitLUOMYe63nk3ay+Y1n5/Nc7nWEsEn7kM5AQ3D38tchAcsSuOv5XjNVV87NPWLxW3ZtEWaOBtrTmISqY5HZcZlwKPLqSRfUFPr6zBPmP1d15HnBA6TSS5pEqDebP8rQbxGE2xNmLucIg4n46/xylLq4i5fhXG8iiriC5o96sXzVGXBaCg69rjJW6uWUXEEcdtlrTlNDCqIaebXyuGPRMMhNze0a1doLAd3QrD9N2RumoXVSL/W0nk2YPDAcA0FHFUuvWwpnvM0+w98InnZ770pNUBULs+7dzllcEUKLf4gZ3NYa544h5ddxAu8m2ptEEw+Mt7cS9Fpv+bGZlUkplWz07qgCViNyz6WGOXsTFgp17+IfN9L1MRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(230273577357003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elhObUdqMDdUenlLUDlmeWs4aDRCWE9PSFBNd21Ib2gvMHBUc3JaRm9SQUVC?=
 =?utf-8?B?cXNhUDNoQkNOdVBrMHlKcEQyd3pPcnVsUTcrU3RXbTlFV1JMa3JsR094dkRT?=
 =?utf-8?B?VmZvaHU5SXFVejJ2YnFXeUplRTVRMTVZY0dCOWFSZnZheURwZEkzdEk3NzF3?=
 =?utf-8?B?L1gvTU15M0xBK0lTdmVOaVdENVowWDhtNVRUK3VoTlhiZW9rK2h6VVc5UTcy?=
 =?utf-8?B?eHRZdzlZRDRwSkF2b09vZTZ4NG5sL0lFM3FyRUxtb3Zadmh0cDh3anloek1o?=
 =?utf-8?B?ekVsMGw4WDJudkg2UWNHMHNzSm1qZXk1N29HMTdXTXNrWm81TWRDTVJXWlhu?=
 =?utf-8?B?bGw2dGxrdEdwN2hMSzJha05YV1lYYU4xQkJsNUtXcGxRd0RHbEZWWnJnRXpH?=
 =?utf-8?B?b21zd2g5ZGlNTDMxbDFRaVYyMGFVL2Q1a1BpbFEvOWpkb3pWL1ZxdjVoQWpR?=
 =?utf-8?B?MFpOZnpJYlE2N3NvbWZtUzZ4QTU0VnVUc2RnNFphbjg1L3I2dHVtajBJdXlT?=
 =?utf-8?B?WTR5cU9JQmwyeDJ1Tm05dkpuWVZhWTdBS0FuMThXS05wcERyUGxCMkVYelhO?=
 =?utf-8?B?NzUvK25nZjVyNmJ1RGdoalRYdys3MmgxR0FqT3ltaWpEQ1ZScDhjN2t0Ti92?=
 =?utf-8?B?dVBzR1NoYlpaM3VsMG1raHFGWHhwL0hLaU1jOG5YQ1pPNFVBYWdCZ1YxMWpI?=
 =?utf-8?B?THN2V1pCOER2eGZCRGk1bjhiSFBRN3l6dlptK1dla1lIeDRwbW1DRzlJTkt4?=
 =?utf-8?B?aHhnRWROdCtNOTEwWkZ2bStiSG1xczBuajRaTXVYZmFIb2hnNkhLRUtvZVRQ?=
 =?utf-8?B?dkZZYzdOMk9zNW5yd3BtNWhYR0tmbi95UUEwOXNpbnJEWmwwSGU5bWpQL2VX?=
 =?utf-8?B?MHdSejBaRy93a2pkZ1JpVWF1YXdwUDNJUEdwZWJueWw4YzhwMWlKVE9xRDhB?=
 =?utf-8?B?MEZRR3dzSEoyRFNsOTJxUk5lMm5qY2hkM2syRjdWVHRDcnIwSW53by94Vm1a?=
 =?utf-8?B?SHlWZGk1K2ZWdmJtOVB2WXo4aUxaRXJvOXBndFRXK3N3L2RWbThkS3lWYlFz?=
 =?utf-8?B?WDZETm00alM2MDNvYThsQi9qQ2dNZjlWa3RCNk5NeWYvYTE0L3Y4eFJZM2VD?=
 =?utf-8?B?U0dsam9ON2Q2TGUvTHhXV09rYXhxY2NSckdGTTdkRk5Zb1RnYkwyVWkxYkF4?=
 =?utf-8?B?dW1hUHZHaWkxSEdrNkR1YmZHQ2dGdkNZSzR2QnVCMEg0Zk5Bb0tzN25XOTIv?=
 =?utf-8?B?NFZYT2VjbHV0aG9UYlp3KzNQMk1PTWExd1BHUmxDMkFubld4aGRuZGVaT21B?=
 =?utf-8?B?TFMxbEJnYXhTdTNGdzNUdndRdnE4dFFuQTdobS9kYlR0L29NNERkanNQV2xw?=
 =?utf-8?B?RzZqdDk3dEJnT0ZZZnZPUlJSdWpwRm1HRi9QekFaVWI5ZVVERFN4NEhPOFU4?=
 =?utf-8?B?NU1hZktWQ21wRzRRYnplQTFJamsya2FmVTlDUUNiYkttR3g1TXpMWUJsWHpY?=
 =?utf-8?B?YzZnZm9na1Zzb0RMamJCMEhycy85NVBUNmxGcjJCSUlqM2FhaEVTMFFva3Iw?=
 =?utf-8?B?RDNlTU16eG8xWERtcnpxVXpwUEh5R0c2ZkVCL0U5QUhac3V2Yk9TcDhHU1Ny?=
 =?utf-8?B?OS9TekkzZks4SG81OUF4NlBxWTlrZFA3c3UvcEhkY0lDMk1oRlhuN2RIV2t0?=
 =?utf-8?B?NGEwZ1p6UnpuQy9rVkYxTTB2YjJ6RWIxakVEakF3TzNsdTZZNXNlQVQ4R0tZ?=
 =?utf-8?B?MTZQQmE0OWpwa2tJUjZ4T0UwemwrNDE2NExpbzE5R0RSU0o2L2FRditOL2FV?=
 =?utf-8?B?S2dDUnFaaTM4WGU0MUhjSmI4N29Gb1ZERVlYVUpJcW1lSTIxZDVsSVZDY1BH?=
 =?utf-8?B?aW1YSExpb1hFbGczNjBzUEhPZ2M4MTVha1ZKREJveTRZWHdkejNhcG9Gei83?=
 =?utf-8?B?QjFDWUhjSCtQUGgzdHJGQ2wyUHdMWC9lSHI4ZkxVdzRPb3BFRkFWQ1NRUmFm?=
 =?utf-8?B?bFNFM0NubFY3NFo4UEtFRVNZZHVDalF5cmhnWU1ISGRwRzF0R0xvemZwNWV1?=
 =?utf-8?B?TUdtVFJtYkoxWWpjM2FGaFF5emtkWkRaNVFEQlFUM2xSWXN4WmdlVWx2Q0dL?=
 =?utf-8?B?VzBhK1R5NFZMRnc2OUExU2NSK3lvaXZTd3RrR3lEYWR2ZTA1MVpOZzVNR0RZ?=
 =?utf-8?Q?qz7apEbKMOmHQ92G5UZOOhg=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b636f0b9-4320-4bd2-49f8-08dc3790e93d
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 12:37:50.9350 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hzwymzIUTxQog2f3HyADxmUfCXZ6Gv6JTamB88udBWp0HBy2hx7tyrlklOsukmVsNItg+QSQy1XaJp/tYTLhGgcO977seeLygzXeg+nNYrc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9494
Received-SPF: pass client-ip=2a01:111:f403:260d::700;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR03-DBA-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



On 2/26/24 20:50, Konstantin Kostiuk wrote:
> 
> Best Regards,
> Konstantin Kostiuk.
> 
> 
> On Mon, Feb 26, 2024 at 7:02 PM Andrey Drobyshev
> <andrey.drobyshev@virtuozzo.com <mailto:andrey.drobyshev@virtuozzo.com>>
> wrote:
> 
>     Since the commit 25b5ff1a86 ("qga: add mountpoint usage info to
>     GuestFilesystemInfo") we have 2 values reported in guest-get-fsinfo:
>     used = (f_blocks - f_bfree), total = (f_blocks - f_bfree + f_bavail).
>     These calculations might be obscure for the end user and require one to
>     actually get into QGA source to understand how they're obtained. Let's
>     just report the values f_blocks, f_bfree, f_bavail (in bytes) from
>     statvfs() as they are, letting the user decide how to process them
>     further.
> 
>     Originally-by: Yuri Pudgorodskiy <yur@virtuozzo.com
>     <mailto:yur@virtuozzo.com>>
>     Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com
>     <mailto:andrey.drobyshev@virtuozzo.com>>
>     ---
>      qga/commands-posix.c | 16 +++++++---------
>      qga/qapi-schema.json | 11 +++++++----
>      2 files changed, 14 insertions(+), 13 deletions(-)
> 
>     diff --git a/qga/commands-posix.c b/qga/commands-posix.c
>     index 26008db497..752ef509d0 100644
>     --- a/qga/commands-posix.c
>     +++ b/qga/commands-posix.c
>     @@ -1554,8 +1554,7 @@ static GuestFilesystemInfo
>     *build_guest_fsinfo(strua5a0239ce5ct FsMount *mount,
>                                                     Error **errp)
>      {
>          GuestFilesystemInfo *fs = g_malloc0(sizeof(*fs));
>     -    struct statvfs buf;
>     -    unsigned long used, nonroot_total, fr_size;
>     +    struct statvfs st;
>          char *devpath = g_strdup_printf("/sys/dev/block/%u:%u",
>                                          mount->devmajor, mount->devminor);
> 
>     @@ -1563,15 +1562,14 @@ static GuestFilesystemInfo
>     *build_guest_fsinfo(struct FsMount *mount,
>          fs->type = g_strdup(mount->devtype);
>          build_guest_fsinfo_for_device(devpath, fs, errp);
> 
>     -    if (statvfs(fs->mountpoint, &buf) == 0) {
>     -        fr_size = buf.f_frsize;
>     -        used = buf.f_blocks - buf.f_bfree;
>     -        nonroot_total = used + buf.f_bavail;
>     -        fs->used_bytes = used * fr_size;
>     -        fs->total_bytes = nonroot_total * fr_size;
>     +    if (statvfs(fs->mountpoint, &st) == 0) {
>     +        fs->total_bytes = st.f_blocks * st.f_frsize;
>     +        fs->free_bytes = st.f_bfree * st.f_frsize;
>     +        fs->avail_bytes = st.f_bavail * st.f_frsize;
> 
>              fs->has_total_bytes = true;
>     -        fs->has_used_bytes = true;
>     +        fs->has_free_bytes = true;
>     +        fs->has_avail_bytes = true;
>          }
> 
>          g_free(devpath);
>     diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
>     index b8efe31897..1cce3c1df5 100644
>     --- a/qga/qapi-schema.json
>     +++ b/qga/qapi-schema.json
>     @@ -1030,9 +1030,12 @@
>      #
>      # @type: file system type string
>      #
>     -# @used-bytes: file system used bytes (since 3.0)
>     +# @total-bytes: total file system size in bytes (since 8.3)
>      #
>     -# @total-bytes: non-root file system total bytes (since 3.0)
>     +# @free-bytes: amount of free space in file system in bytes (since 8.3)
> 
> 
> I don't agree with this as it breaks backward compatibility. If we want
> to get
> these changes we should release a new version with both old and new fields
> and mark old as deprecated to get a time for everyone who uses this
> API updates its solutions.
> 
> A similar thing was with replacing the 'blacklist' command line.
> https://gitlab.com/qemu-project/qemu/-/commit/582a098e6ca00dd42f317dad8affd13e5a20bc42 <https://gitlab.com/qemu-project/qemu/-/commit/582a098e6ca00dd42f317dad8affd13e5a20bc42>
> Currently, we support both 'blacklist' and 'block-rpcs' command line options
> but the first one wrote a warning.
>

I agree that marking the old values as deprecated does make sense.
Although my original intent with this patch is to make more sense of the
existing names (e.g. total-bytes to indicate true fs size instead of
just non-root fs).  If so, we'd eventually have to replace the original
total-bytes value with the one having new semantics.  Or we could rename
the existing value to smth like "total-bytes-nonroot".  But either way
breaks backward compatibility after all.  How would you suggest to
resolve it?

Andrey

> @Marc-André Lureau <mailto:marcandre.lureau@redhat.com> @Philippe
> Mathieu-Daudé <mailto:philmd@linaro.org> 
> What do you think about this?
>  
> [...]


