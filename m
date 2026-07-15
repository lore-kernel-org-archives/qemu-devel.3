Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94FFAC44507
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 10:31:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjwt4-0003Vm-82; Wed, 15 Jul 2026 06:30:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wjwt2-0003VV-7x
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 06:30:44 -0400
Received: from mail-westeuropeazon11023136.outbound.protection.outlook.com
 ([52.101.72.136] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wjwsz-0000W0-QE
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 06:30:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G3ECEcHaGd2L0cEoYg7fYjFhJdQX11Z5BwSV+S1vGNqPx5AdVFO+/Km1ix/Rm9wfG0DNtcr5UhYHEJ0ttfwiM0tvqOORHyGqjSKGGT83Xo0iidRR3juvi1MeMkZKlGNeTwnv/VrGqZ2l5WtAI2YktQH3PCeLVbySRQq3MHJGO4Jg4s7yjvyUOyMDGb+Xwy1D6Fc4N/7C7KjOrZ6iJOGtGRBMrXhdjs48Vey41cldxmg6Nd8HCTvUM9TWscHKDZLALLyugVnI59B1GboQIxFwAfhDY9oLnV0Jn3hjZKjXDwKx5k4GcGmgdbBvBh7SHhZgeU9ql0ib/LkmDojEJ0Yguw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LGtJDsAAJ7OqEt0WDQqdUFdomfoLfd6wh1pSCsXCI3g=;
 b=BISyRNWmAXeSownUljfMcQ/24ivslNEOLJ54L9tC5Y12hET84XuLJ3H2XOO0Idfhtns1QP6vxsNPCqOesw6HwbnE7uWXWEz1lR6jmbJpYO6wfVEYeZobMGJtLbppEWXwhtvMqu/5Si9nbw+MnQeHQCPHaMFAzxjQc/jbpH/RAmWo2U6KD72bnm43UF7pzS3KOIz0o6pj5tZJ3cGjet5ufvyNpZZ9QdvNPYqsdCtGluok52mB8ramfQlGFB04qObTjvnssvuXpvvezVwQy7MrdkYZPce+5QCP9GoKKd7TOZY8SPk5/pqBREDNoEK/GGmL2Wze7IQb7TyrUvIn0vb1mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LGtJDsAAJ7OqEt0WDQqdUFdomfoLfd6wh1pSCsXCI3g=;
 b=auC6lEgz9zEI4cx9QGVXnz0qYH8SvqUZwaCG/bU10QKA9aZp12em0lNGPRgSkKgLc4ex79OnW/pb7SrZAVBh6J8NOAc7NngMX55nYi6gystTSqz/J2R8kI+JeeT/z1mK98iPdU1p/JDTfWf/qrCItb/W2GdVW8kibofYlQ5zEb1tUFwKHGJBZlOf0ETgktre025KGJ3el9qe8iqw+oijJa/ezLqafz13lNNcKRxPVe7JDP1mmAxmvrCEyJjas4pbZ6BaTJdJT9qdJLz6RC0kbXqh/Wq53gSGQYUwQW+Zy4dUXFRpRDDz/XJFhLEGVwH0BxcvujKW2ZFRciBxinmApQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AM9PR08MB6018.eurprd08.prod.outlook.com
 (2603:10a6:20b:2df::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.9; Wed, 15 Jul
 2026 10:25:35 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0202.014; Wed, 15 Jul 2026
 10:25:34 +0000
Message-ID: <d22dfbcc-b2ea-43cc-a612-589d5764423b@virtuozzo.com>
Date: Wed, 15 Jul 2026 13:25:32 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] migration/cpr: support vhost-vsock devices
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-devel@nongnu.org
Cc: mst@redhat.com, sgarzare@redhat.com, farosas@suse.de, peterx@redhat.com,
 dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, bchaney@akamai.com,
 mark.kanda@oracle.com, den@openvz.org
References: <20260626164643.2526-1-andrey.drobyshev@virtuozzo.com>
 <e8cb2e45-b58b-41f8-a69c-4f3e0f3cdd8d@yandex-team.ru>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <e8cb2e45-b58b-41f8-a69c-4f3e0f3cdd8d@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0148.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::23) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AM9PR08MB6018:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c611551-4743-4cd6-3747-08dee25b67a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|23010399003|10067099003|4143699003|18002099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: SFCEqKKInydbQ6b4rmUacXqscHHgEaeICdyqgUp5NhPMqfD1iuyojrJ+57Ynd/ypY20iREMTzRMspQkKCVbc8X1aS+VN4cQYGxVCyb6i8xdmd0KeGUIQuXlXci8qmq9U7mplUqJ69BzyS4tcRy4QxtlWPMj4QaQa3BhUqBws/dYknTuT7aK8AoNU2ZB3RZdjbaoziCSA1I+9tmlCt2UTXaH9X731UrZd3E8MVdDc4w0FhMgEjI/2gU358TD5tOWtgkuDsMF4svSitJUbM7hu7PABwzFiY79vju92nqdBKCsWmSukElXfuJAUFsQMR/xE7HAFHTIgKWzkF0w7c2E5EOzXMPPv+lhlP5/XW9/39fmxQ3RW+vHYf9d5p7ambIxbb1V/9zOUNfG4N/ODNzZiD6mJXifHuwFI0mQIG5mfp2CISrYVXeXeN9/pUtnGe1vW06E0M2rou8enCjHRekXORAkHhSyd1QgV8FupyYsDSPW9vA9t29lfzbrh37xSvQkQfdIOCyydFGOeIUX82vDeIr/uRRnB9BMbIUqhTQCyh/0l2W1wF3pGEntghFsaUH4+OYy7odvHT7ktHrS1wUjEhvbczcCoi/AiS2Xk4YyBDqvf0UjmBf7NByqSIWxKUD8Q3ftl3yAXfIUrmMmlZRPnlWjyKbTLW/me2sEtR77JEDw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(10067099003)(4143699003)(18002099003)(56012099006)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVBTeEwvMTAvaW9TNmZpejNwUko5SUQ4UHJ2cVlOeStXbzlabnhsT2t3UlIw?=
 =?utf-8?B?c0Ywa1FWSzFQSkdjWXA0UmpTWEVIaVFLUm1YT0dOSXpNa0dNdDViODd0enVk?=
 =?utf-8?B?SjJRcExUZzFPekNnNmM2V25DZnZLYkQ4VzBEQnREbkFkbmRZdjV2azM1akFJ?=
 =?utf-8?B?dVJ0aGk1akd1RnFDeW1HeThOWWZSUmtQLy9pSEJtTnJGRy9jb3BHaVFqeDdk?=
 =?utf-8?B?Q0d6R0huRGx1a0VHam1tUkt2K3dlU1g5VXl6NktDenRuc0dncXB1M3hzWkpE?=
 =?utf-8?B?S3B2N1I0UDNvUko3NEhmSVAzQ1V0MWpvcGZXakRraTdqbi96NkNSRzdVY0dq?=
 =?utf-8?B?TUtYNjdkYkQrS2hmV3ZoNTM1NEdUNG8xbi9iMThQcEtvd1did0k4MjRkN05h?=
 =?utf-8?B?VFdIdGlNSUNhckthTVZYNnFnOHc1b01sa1gyRTdoRXE0OGIvak1xYTI0cGxU?=
 =?utf-8?B?TEpaTXRtUjloSXFZRi9zSXZuNVJsUUloUWlvZXJLNDMzaUVlVGtvZEEzRFV1?=
 =?utf-8?B?NEs4YkVPMDVoeW45Zmk0djJWVmEyWW82cklLTytBS0F2T1o3S2s1MEljMFdp?=
 =?utf-8?B?L1l1Si9iK0dXdGFyNGh3cjdTNkZxVzhLaWRLWWJOV0dleXh3UVdUdDg3VVpV?=
 =?utf-8?B?bVhTOTVYOU5HU0xrdGE4WXZ5K3lOYk1zWXlWdHdjaVpoYUtDMWdRcUJ0UG9R?=
 =?utf-8?B?QnlFcjN6bVFsZVRPL0ZqdE8wVVBKS3cwZktXRjBEVWgyNkEwVXZXOTc4a3FY?=
 =?utf-8?B?Zi9FOE5VRmVGYkRXME13U3RrYjNWR3lSdStpUjFHS0tNTXd4VUNORm05OE1n?=
 =?utf-8?B?YlRLYXdoc09TZUw4Zmt0YkM2SlAvQkZ3RFYvMm1idkRJUG5lY1htWTFUWFZk?=
 =?utf-8?B?M2owOFVKMWJmVGZYK2Y5ZFBtd2xIb3hFMy9kZ1JmYWViUzNpUlZ6WUxIelVl?=
 =?utf-8?B?UWcwTzF3OHl1NDkxSzdKSnNSQ0pNdGpKVFlEMjFCOTZWWDY0YzQwMDhiYk5D?=
 =?utf-8?B?SXlxT3RpZlN6ek1meHBuN0luMnlnSktzK0xYc3ErK2MxdWRmdForN1lOdDNV?=
 =?utf-8?B?a0JlVC9CZlg1NDZ5RGlxYmM1SUhHV0tuV0t1V0ZVQXg5YVBOdm5vOS9OODZx?=
 =?utf-8?B?eVhwT1lMMms4NjNLSTJjb29yTlNwS3RhVlZJZG93azZzNkg4K0VVZkc2VVAz?=
 =?utf-8?B?MFVma3NxVDFwWVZOMGtHMHdVRXIxbEI4cTJXZmJiVzhUWE5xMTJsL2FTL2Fm?=
 =?utf-8?B?eW9RQ2FzOWJhQktaZ2hvZUlFK2FIZ2ZIMSt4SlZCM09Vd0RHRTk0cHJPcFJz?=
 =?utf-8?B?OXZwcWVBMEVNWGN1UXVscDQ3MHA4TXFzK3k3RFRwWnpsSjRrUDd2c2V5OGFi?=
 =?utf-8?B?YWdwTWRYcHk4dGRhbjZLem02QmxnMVJZamR0OG5LcGQ4RnF6cHh1WnVGa3dB?=
 =?utf-8?B?aExVdk16VVZ4ZXQrUC8rd2puQTNYM3RyUHI4T21kYUo5clY4c1U5OU1qZEt2?=
 =?utf-8?B?NTl3QjFHa1BMT0RpbVR1aVBFUUZ1a0tkT1VOdW15NWh0NWtDaXJnejRyMFY5?=
 =?utf-8?B?YkZmcHhxUytYZUxTSHFWT0IxTU14c3p4RFNGT1NWUTM3THBRbDhlOGZyRWov?=
 =?utf-8?B?NkluUEk4anBodnBTT08wNDRXeXMvWVBCRTV1eHZtdGZLQm0zZDRjbkVpQnM4?=
 =?utf-8?B?a2RxSmVLcUJnUGRZRHhSRzVGZHhKZ0sxNmYvYlF5c0lhcDdWNkVYbkhNVUwv?=
 =?utf-8?B?bnN2SzlLTmFoMThtZDRqc1pZNVRhRDFrNmhsSXpXbUZteUoxWUJreFRtd08r?=
 =?utf-8?B?ZEdnYzFOdkVndG05M0lpN0tFcU9ZNGFlbXNnN21rUVNUNDE5Mk1kTmVUUjNK?=
 =?utf-8?B?SGREZ25SV0U3dWdVb1ExTEdHamhBWERLb3VNbnh5c2ViL3FycG13SHF2OXVz?=
 =?utf-8?B?Ylk0N0ZTMWJTNnMwN1Y3SkdDeFNpZnhRcDVVdnljeG5XZlVlQXlPanRhU1dJ?=
 =?utf-8?B?c3B1VFROZzFSQTBqS0w0ZUY0eEZzZkUvT3BRY1FIbHgzR3N2Y1UvQnMyWDNs?=
 =?utf-8?B?cjZ3L1p2UnFNaWpmZHVJRUhWeDczcW5NdW13dkp1bHpqREtDTzZWYXRIVUI2?=
 =?utf-8?B?REl5RXRzOHhMbVVybXJlT0x4Nm5Cc2FCZGxTclFuNTdrL25tYnNwZmdFSlVi?=
 =?utf-8?B?U3h5OU9iTmZTa1U5MXJtME5ucHlQVUhrVDF5TFlCZlJzTkhmcjZFb3k2bVVs?=
 =?utf-8?B?YkVQUkY1bTJ4eVlOQ1dab0ExV0tuSnJEYnBMZzd1Qk9NaW5qd2twLzdoQzIv?=
 =?utf-8?B?OTBZa21Wak82dGVNaWZRelMxVEkyY3VJSVJVVytaVDE3bnBCbURpVG5Yak1T?=
 =?utf-8?Q?SRUgfzOhQujCVIJg=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c611551-4743-4cd6-3747-08dee25b67a7
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 10:25:34.4228 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iep9Aym4aYf/RmDiT94NZMj4JOpaglLlDfnotSH4ib3GC6+ky56BE8ts8s5bN3Z21FSaduhx3bkyJni+JY02KB7wT0gt0pSM1nRmmyYIdxQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6018
Received-SPF: pass client-ip=52.101.72.136;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=AM0PR02CU008.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
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

On 7/14/26 6:03 PM, Vladimir Sementsov-Ogievskiy wrote:
> On 26.06.26 19:46, Andrey Drobyshev wrote:
>> v2 -> v3:
>>
>> Re-design device ownership hand-off (suggested by Dongli).  Do not rely
>> on SETUP migration notifiers, as this approach forces us to reorder
>> generic migration code (see v2 discussion).  Instead:
>>
>>    * .pre_save() releases ownership on the source (RESET_OWNER) once VM
>>      is stopped;
>>    * .realize() is adjusted to defer device ownership acquisition for an
>>      incoming CPR;
>>    * .post_load() actually claims the device (VHOST_SET_OWNER);
>>    * FAILED migration event callback re-aquires the ownership on the
>>      source after re_save released it.
>>
>> v2:https://lore.kernel.org/qemu-devel/57c9c9b3-d758-489b-95b8-d16c258b9b0c@virtuozzo.com
> 
> Hi!
>

Hello Vladimir!

> Two notes:
> 
> 1. Did you consider migrating needed FDs through main migration channel, without
> use of CPR, like I do in (not yet landed) "[PATCH v19 00/15] virtio-net: live-TAP local migration" [1]
>

AFAIU you're doing local same-host migration as a way to update QEMU
binary.  With this approach transferring FDs through the main channel is
indeed cleaner.  However in our own downstream we use enhanced in-place
memory preservation which is based entirely on cpr-exec migration mode.

So, to answer your question: yes, we considered it, and it might work
for cpr-transfer where we're also doing same-host migration.  But in
cpr-exec case there's only one QEMU process involved => we can't use
UNIX socket for migration transport => no SCM_RIGHTS FDs passing => FDs
should be passed via additional transport, no way around it.


> 2. I don't know how much vhost-vsock differs from vhost-net, but for vhost-net I remember
> that RESET_OWNER + SET_OWNER is effectively equal to simply recreating vhost device on target,
> because in kernel vhost device is hardly bound to the process itself, and can't be passed to
> another process. So, we can pass only "empty" FD, not the initialized vhost device.
> That's why in [1] I only pass tap-fds (and some additional state), but vhost fds are simply
> reopened on target (or passed by mgmt app).
> Does vhost-vsock work in a different way? Is there real sense in passing vhost fds here?
> 
> 
> [1] https://lore.kernel.org/qemu-devel/20260714154246.1242856-1-vsementsov@yandex-team.ru/
> 

I'm also not extremely keen on vhost-net internals, but as I understand
with vhost-net we have 2 FDs: TAP FD for the network endpoint and vhost
FD for the memory tables, vring addresses etc.  The TAP FD is
process-independent state - and we pass it via migration channel.  The
vhost FD is entirely per owning process - and we're able to close it on
source, reopen on target and bind to the passed TAP FD.

However with vhost-vsock there's only one FD.  It's used both for
plumbing and the endpoint.  At the very least, vhost device state holds
guest CID registration in the global vhost_vsock_hash.  If we go the
"recreate/reopen the device" path - CID is removed from the hash in
vhost_vsock_dev_release(), and then we're gonna get ECONNRESET for any
incoming packets => connections are dead.  We can't afford that.

Andrey

