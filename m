Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6902C61DC2
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 09:48:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzAEj-0006UA-53; Wed, 26 Aug 2026 05:48:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wzAEh-0006Q9-Dz
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 05:47:59 -0400
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wzAEf-0005EG-PI
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 05:47:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z9bxTINlNR/sKuDZ9fW9ZJpTRS1/fCg14Zh3A+KI049VEHsAdRz3+2z1P1NK5NJUddyL8M+URR4U0CMag5gCn3waeGPr2bjWDyAWAlZZCCCttJpGqtUYwQcjE+IqtUnSL6HnlyWEE9sImCBcTMMDBAVKghN3eezH8BVvYpuEZktYjWVk8DN8bEOLPH7YsNuhl9TIqA1l4nm84WoMQRgymgvZ5umYKWfG2uMCjjDE/cE1ZspNmh1y90Zi2ydOh7TnuPFgigRG4b2OqhYK8U1E2YLy+r4rdPjToKr5SCzfMbvfDQA0yLjtOTKl7x6PuwcvQVf/FeEA7kWGoEb9p2JEbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s/Itnew+eI5i/4BFCx812xK+RY7Rs5TenCQRfJ5FZ3s=;
 b=Qp2OFytF2Y5JksvlgyHgcYM5MOhVLHiZxK94iSZkOtjgZnU2WD14ejNWKbzld21+v8GZmLG0VmaaA+KyjPsFa0QeRdNH+mQMHsjCWa43i//+LgON2dQRcdKcjSLutTxdyB8E1q+uP04m1M8QQSoL41DVHF6735LfDeprt1MXCAkGgVz49X4mnXKC4+LT0xC1JrXm3yiTVhNCoI8QvHINzE6PDwOFuzVcO8PyHMCYXRFlTU2/4GDJawS+YeudXiQS0/BA1MW/QzWYDqV+GHV1umruhBhGSBHe9osCWdmakj8b8MaMokwLnSticfnEQij5jzsb/oBVAuGYXsMUv7GrNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/Itnew+eI5i/4BFCx812xK+RY7Rs5TenCQRfJ5FZ3s=;
 b=TZGaM2M54GO3/PRDKCBkKMH1iilPPxXyWKwOiUDyv7tydznmrOz3y4d4TCvldhPgsrQKpGwIrlgbWcJHsXf0YgUA1k05Ek8W51xRdiiMe9Kj+1n4d/Y/I6tN70/OfRb2zfCcX5YHnExeZrm18EOSjRV02sDm5Avf4S5ZG/kgkpbZVxXvckG+bnOpGtyJTncwTFXRFPJYerjste+lQV3DX9Ww3Q1ySUzlsEEaWQ8+ErbAT+cJjS7KyezDFGyIlCXdDgUK/jAKskJp4GWS8ax7sQX4w9cbTLvZ2p1LtPwnlrYOS2OV2Dyur21G4iFfxj9vq+Y4qs32kDTK1Q1KdiSqhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DBBPR08MB10650.eurprd08.prod.outlook.com (2603:10a6:10:52d::7)
 by DB9PR08MB11363.eurprd08.prod.outlook.com (2603:10a6:10:60f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Wed, 26 Aug
 2026 09:47:53 +0000
Received: from DBBPR08MB10650.eurprd08.prod.outlook.com
 ([fe80::1b2a:832c:d136:a37c]) by DBBPR08MB10650.eurprd08.prod.outlook.com
 ([fe80::1b2a:832c:d136:a37c%5]) with mapi id 15.21.0382.004; Wed, 26 Aug 2026
 09:47:53 +0000
Message-ID: <9106512e-54cd-4513-963f-59e50063bfcc@virtuozzo.com>
Date: Wed, 26 Aug 2026 12:47:52 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] hw/display/qxl: Avoid crashing on stale guest
 addresses in qxl_post_load
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@oss.qualcomm.com, den@openvz.org
References: <20260825172051.435372-1-andrey.drobyshev@virtuozzo.com>
 <CAJ+F1CKwNr=6wVaO+tXa876EzoPjYfQC3qx=em3C4BSW7wRC8Q@mail.gmail.com>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <CAJ+F1CKwNr=6wVaO+tXa876EzoPjYfQC3qx=em3C4BSW7wRC8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0191.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::14) To DBBPR08MB10650.eurprd08.prod.outlook.com
 (2603:10a6:10:52d::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR08MB10650:EE_|DB9PR08MB11363:EE_
X-MS-Office365-Filtering-Correlation-Id: 09fea484-8f4a-476c-0d29-08df03571952
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|56012099006|4143699003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: EpQ17DXS7cd+frytDEmpEi3i17tg+VEvxVh3y9QEQXwPEH+eVYgxEQW21ZRzZyGkjJG5stl9VC+MIavo7bXVvWrL2eZgg1JvxcXZylkwllJwERzsxmMneW+6+kuftQob3h10bAR51Wlb7rNYiqZCRg8dXNLFZsCWNwPakxuvdQ6t7zS+oyjuaw6R6tXc0ea6fB3XmtSvmq++YAuPLCVfSZvWqmdEqnvYRD8Ymn5Vj2JWxnRS9k6KQodxUcw0OZs6Hf/uo7cihaFxJE+3TmHzAiLn7V4Kn3g1PvDDKhTbFuhDkg3fAxdi552OSh3gFeU9LDAnSi1owd7HAns50XWfjPWjSubb50WsxEEddLMakJoteN5L8R8tHMPXrRYDwt4cUshwzU6/14MvMVtqcsUq/79kuIhZk+33bcuQN+IxsHsAS7ISUWXf/ZQGMXq9ou3Fn9QHr4ORYk4PdPCZ2pdD80cwFq8LSBMxok9de8yGf2t16u4YUAQN7AFizb576NptVnNiIahmMU+nmmr1ULzRsr8248epHl1rCWh5GCb6cdIvDT+ILa/SrrOVNpUwM6SS32AfMLdxmohR+8b/E39b0GdaKdhP2YqHsHDLZJr/n1qJan0PJgRx47wO0NyM9V8yET69sKMLqH4zEM+89o0R7FCclIBfF9wCPCcAWS/p0Pw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR08MB10650.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(4143699003)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUdBZExTZGl4ZkJ4TWF2ZFZIdEdEdTdPREdCUDBzN0xMbFdaV1V2M1lFendG?=
 =?utf-8?B?V2M4QnpUMUJCbC9ENjFzWlhWeUV6QUl0Mm56eEV4MDd6Y1VsQ1BBRllvMDk5?=
 =?utf-8?B?OW9sMG1RUnJESmhYRXYxKzVQWTg3K2MyRktJd0UwTXp4NHltWDArdHhtL0pq?=
 =?utf-8?B?M3M1QUIyeTZYRWYzTGhvMHcvWk1WQ29tM0U2U2paSkVzQ1dNUm1nSlQ0d2g0?=
 =?utf-8?B?ZUF6SEVwa0lUNisxbklDeVRjNFdYeXFDd2hnN1UvMHdTOXZhc21KTU4wYldw?=
 =?utf-8?B?SFRqc1NNckc1Z3hqZVFrdzNzNjNnYU45RVRpTHdTRGh2bElIRXNHY1NYblJB?=
 =?utf-8?B?MjFGN25KdW8vMGFSSXVWNmp2QzdKcU9waE5HNTJQQ094cC9MR3g2ZGtYZVlD?=
 =?utf-8?B?RHc0eTdBUDVvckViSmtEa0lQODd1eDdpalhGbHkybkpqaDdmK3MyQjZFVlZ2?=
 =?utf-8?B?WnpaUE02a3JXVkJ4SjR5enBQdXAwb0YwTTZKOHIrUW1xdDRNelY3eGxIaGsx?=
 =?utf-8?B?czllNkNMYjh3WFJzOVBIYVU1T0h4ODd4bVgzUm44TzJuQmNISk00ODVkTWxO?=
 =?utf-8?B?RFUyekJZdlFwR2hIQTlubndCSW5XK056ZFNQK2lzTWZ1aUR6SU1Zd3hjK1F0?=
 =?utf-8?B?K25RNGlkTENNYy9yLzNsR2EwVmtURWxsWERYckU3UDd4YTFwS05NUmgrcHd6?=
 =?utf-8?B?YXF3MkRjMmoxZUk0RktOSmVNaGRVN2U0QWtSUXNMTDd0aSs5Ulp4TnphT1Fz?=
 =?utf-8?B?d2d5UnZBT3dZMkJMcmR1ODhhdWNmK0VCMjNrMi9qeFM4VVl0aGxibnFaTzRs?=
 =?utf-8?B?bVJIRVFMaXBCZEgvdEhlSnB0Z3VaNEt1bFduekhkQTQwNEd6Y2hZTmlTUFNK?=
 =?utf-8?B?V3RRY2s2VlhIOEo5RnovUTRxdjBPRm9sK1BlSXF3SVBWVUwrNWxNZTF2dnFz?=
 =?utf-8?B?SDJveTdsQlY1L0I4TGd1S3B1dTZkV0szdFhOaFpTN3BEeGtna1VWMy9td00y?=
 =?utf-8?B?dTdIM2pMOGFKaldXTXhJTHBtKzVFMm95bGZNc2ZIc0RTakk1U21IdDBPRGFH?=
 =?utf-8?B?aVlUUkprQjhhTFZVSkNMbnFzS2Jyd2VpT1VEaUtuVmZtbnFzOS9Dek9ubVFH?=
 =?utf-8?B?TWI0Y29aRXpJaTYvZHFjRkdwM2ZHMzZURGtSbm11MlJBa0gzOHFLYis3NWlV?=
 =?utf-8?B?WVlreEtlSlE2SGxvb1NJTVhOU1BPZUlxdmJKWWVsdHk3T3V6TmdhbWtpQmlV?=
 =?utf-8?B?cUs4Sk9vOTA0M3VqanVUajBBUHJmdWx6WDhBS3hoZHltVmVKTGV2dnZWOEc2?=
 =?utf-8?B?WFZoRlUyRjBJWDNDUFptYkU4M3pjUXFtOEdRYUxsMXpsUEdBL3VRZ1N4REZ4?=
 =?utf-8?B?bHQ4Wm5pN2lVMmdKOEdycndRR3ZROHdKWDltQ1NreVR4MWhJWHpYQXVHb3Vy?=
 =?utf-8?B?aVh3SC9zU1hPbHh1VWFCSDNzUExrMVV1NERjYkdPcnFGckUwNUhzZUlRNWpK?=
 =?utf-8?B?VkF5MWRvY25ZNDBjU3NkTktWUHc2S1dlSjc1cUYxZWQrS0ZQZHZ6Um5paldl?=
 =?utf-8?B?dUlPbk1UbVRGWE5PMVJnSVBkdFhMWlR2NStNSWliQjZveVBtR1BVNU9TbFlX?=
 =?utf-8?B?bzFYNUhEVU82V2xZcVkyS0dET0ZoQm5YallLOW8xbHo4YVV0SWltK2dpcTBy?=
 =?utf-8?B?anpmOG1KUmhwSmUxUGZpci9GTmV6blQ1c2ZYQTNXS2NWSHFoZ3hlL3lDVnVt?=
 =?utf-8?B?THZTU1B0V25mbGpiVnA2alZuNTlHWEVDWFNZYUdRa05wNkVNV2wwb3dNZjBa?=
 =?utf-8?B?UmxEbEZtQjF3cy93MmtKR3lVYmxKSWI4SHBEUytJSkxsNUc2NXYwZVN2QU1r?=
 =?utf-8?B?ZlNibmdTR2w2cXFkcHB1aG02MEg4cjFvVksvYzlhellEK2txMlFWTzZuUVRk?=
 =?utf-8?B?ZzlyYW83TkorK3E3cS85S1ErbkNPYTFrazVYY1NZR3ZMdjRXOUtCS3BjTkhO?=
 =?utf-8?B?MTZ4THVKaVIvakh0K2Z2Z2xZSXlyaVk5SEsrU2ErR2VMNnU0TVo4bHpXYmZn?=
 =?utf-8?B?VjhYbTFnV1o3b3NSTVQzOHFwMGNXUER4bzZHOVdmbFVZZ0ZoeDB5cVd2bVRZ?=
 =?utf-8?B?YkFQYkVlMngxckZOUEJvRyttRmJHdGRHM3VRWFBVY3FEVFRDM1RKU29pYzl6?=
 =?utf-8?B?V0kxRkVVTEx5S1ptMmJ5NHRmSWZCRmVybTJTZHZBeU5EU2pHTXNkSlFtL29y?=
 =?utf-8?B?Vmxpa2lESk9MMlJBQjh0NFh1K1BmeEtVemRzcldONTlsa2NOM1kyZXJjOVJV?=
 =?utf-8?B?algrN3gvV3NxdGRLSE5aVWR2Z2FjczlyRmJDdXdSQzJJVmNIbFpXSnlXQ1Bv?=
 =?utf-8?Q?KVheSvV6nvKmc9R0=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09fea484-8f4a-476c-0d29-08df03571952
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB10650.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 09:47:53.3678 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rLWoMmz/G1tyjsNubeVBfD6mtwedvJR9p+J3Z9THpLJdU858IHb4y+3xt38+m7cQZ49dRHqgi53BMAsK6qM0U4BAa/BdAlmUCXELeq0UnpE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB11363
Received-SPF: pass client-ip=2a01:111:f403:c20f::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=OSPPR02CU001.outbound.protection.outlook.com
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

On 8/26/26 11:10 AM, Marc-André Lureau wrote:
> Hi Andrey
> 
> On Tue, Aug 25, 2026 at 9:26 PM Andrey Drobyshev
> <andrey.drobyshev@virtuozzo.com> wrote:
>>
>> We've experienced crashes when spice-server aborts on migration target
>> when processing an invalid/stale guest address pointer.  While those are
>> hard to reproduce, it seems they can be fairly easily avoided by simply
>> skipping commands with invalid addresses in qxl_post_load.
> 
> I would rather try to find the root cause, rather than applying a
> post-load workaround. It may be related to this issue
> https://gitlab.com/qemu-project/qemu/-/work_items/3766 (confidential):
> there is a lack of resource tracking, when a guest release
> slot/cursors etc, the track commands may not be correctly updated - or
> preventing resource release. Unfortunately, spice/qxl is no longer
> maintained - we should clearly mark this device as unsecure imho.
> 
>> [...]
I agree on all points. AFAIU this is a use-after-free of a tracked guest
pointer.  I'm not sure whether we can reliably track whenever guest
frees a buffer, so we drop it from the cmd list.  Still, I'd argue that
my 2nd patch here adds some hardening:

1. Currently we consume guest-controlled bytes which reach
memslot_get_virt() in spice-server, which aborts on the migration
target.  So there's a potential for guest->host DoS.
2. Dropping invalid commands is cheap, as we just don't replay cursor
movements on the target - instead wait until guest sets it again.  IMHO
this kind of hardening would make sense even if we did remedy the root
cause.

Andrey

