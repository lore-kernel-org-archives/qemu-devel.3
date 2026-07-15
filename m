Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58FA0C44501
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 12:12:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjyT0-0005CE-2K; Wed, 15 Jul 2026 08:11:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wjySy-0005C5-FT
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 08:11:56 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wjySv-0001yB-WA
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 08:11:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OVfB0FcQc4jbMSL79BkdmKlyz3OotiAjgcInneEBh5I=;
 b=jNYh2NNekIWtQ3CIZrBZOvVJJPNUNy4+qGUUStORFMzKu73OjIUEZxOd6X9bgCMKsQfbkIEANtGcHLfdGPPAQ/BpWwin/J3W4i7Ts8Zx6wLiP1Ku30aY87cvFGOoqJJgisHDsbMNvQPK7BLdyVWzKGS/Rg0mDSoNwwK+1z5kNlv0/5kX0xy4TDcqAe5A/3Y4zaqt5TFOuj5TPrSofYo5SaZmbtxqFZVlV9g0b8C9yG9W8RrDsrlTnEWnF6vyl6uRvVjSvr1h2aaAkx+TfjN6aKtxQ3RMXadeeKgFjJ6xK8u/xuSPzJZVW6J2ESajYjBT1avfYk6E51YWkIKtn9MnZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS2PR08MB8747.eurprd08.prod.outlook.com
 (2603:10a6:20b:55f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.20; Wed, 15 Jul
 2026 12:11:50 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0202.014; Wed, 15 Jul 2026
 12:11:50 +0000
Message-ID: <a2f3622d-acd0-4d31-8111-ae34643e614c@virtuozzo.com>
Date: Wed, 15 Jul 2026 15:11:48 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] migration/cpr: support vhost-vsock devices
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-devel@nongnu.org
Cc: mst@redhat.com, sgarzare@redhat.com, farosas@suse.de, peterx@redhat.com,
 dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, bchaney@akamai.com,
 mark.kanda@oracle.com, den@openvz.org
References: <20260626164643.2526-1-andrey.drobyshev@virtuozzo.com>
 <e8cb2e45-b58b-41f8-a69c-4f3e0f3cdd8d@yandex-team.ru>
 <d22dfbcc-b2ea-43cc-a612-589d5764423b@virtuozzo.com>
 <db23c15d-cfb2-49a8-b748-5195a36a50d9@yandex-team.ru>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <db23c15d-cfb2-49a8-b748-5195a36a50d9@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0345.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::6) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS2PR08MB8747:EE_
X-MS-Office365-Filtering-Correlation-Id: ce60f706-772a-4c6f-29a9-08dee26a3fd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|366016|1800799024|56012099006|4143699003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: Qpwpnog+UalISx3ETnB0zyrcHd2U1d3N0aboOLSvVuw04y/LnUSEtLN3z0sPSoC1PT7WCXGfcehAbHTWMw8+2bpPdDSWqPDKGzRKHB+6I7GUPi/UkjXVyeM8tp5AQ7X9ZbviLnWAnFCZ2nYuouGHfmDsStu2mmwgPD/hBiyLYXQMERafoWKpci2zRHoLMTgS8VCZaqgUgcfCfGvqKXW92sKI5iVmYBTm/9Sg++m3wgleHCu5fsn0GQN9Gp8570XI8QsA4cNPGbmkSzpsDpyYGhOUorR50VRCqH60+/j3Bqo31gQHMDdfxNu1OU5b7Dngl4g74TGXQgNOL38iZq96jgcYD0ih1JOEh+S11xhqU1huoznIw7Wc3XbfGDSalVki7o228OpQBXubmmZLx+tgt/Mbk8hTxZ/mKD9FwKSjkD5TtOJgl2zZmxqVyE9h05VEw4WW2bFmXFsOJVOqXRJOEP+pu2Nl5IR7Df2HEup+YSwODoNihz2dexXuDek3o/aNn+wAza9O1rmoE0vaZi/adngTVetWx4fJhH3vyuilikTjZQ1QVptyiIoF99+spF8qcwiyc5gnwJRcnLLEg9RWXK8I1f+25fzenivW1V6osWWiRjN960mhoD+93lPP6nAK9oiXx3QmRpvaaRa8u+amEGljC8YAEVxGp+EpozGfzhQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(56012099006)(4143699003)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2VYVDV6bHByWmFOdmM4QXhZTU5OMFExSXNaUmhkNStYL2MzcWFna0hRa2tp?=
 =?utf-8?B?aDF3VVBuSXZlcWpMcDB2WnBTNXBvT2p0bjhJeWtrY3dRTkRTYWhSaWdBUlJ5?=
 =?utf-8?B?elpxY29rTnZSUmFlL1lhWU5qU0UwQ2dVNUc1Ti9mVHoyRVJrRXlEMEdEZXlK?=
 =?utf-8?B?MkhyZUpTbjJ2Q2VTeWQ0cDRUdWhJeTJTa0NPMVFhVDdsaUlpS29VY1J2YldE?=
 =?utf-8?B?M0IvYXB4Z0tlNDJEdE9lSkJLRHNzS283cHpHbkRlVktqZmpuZy9WZDF0TXhz?=
 =?utf-8?B?cXJ2L0IzbStDMk0vRGx1ejI1WWhoZUxzS0JUWnM0dS9FVnpQWThVNS9VL25C?=
 =?utf-8?B?S3FsMGNiYzVmaGRJZGU3VUhra2xyN1NTNTI4Sjd1NHMycmI3aFB0QXhIcEo0?=
 =?utf-8?B?eUZ3ZzMzN2h5K2tTRllGc0hFd3VuM3ozakgvWlBpS1Jic1NjcGxLOTFYZzlN?=
 =?utf-8?B?VHk1TE9ldFhFWm1oQjVNNmZYVVlXcVZuTlU1VEljWDE2RXBZU2hHOTZoYmdx?=
 =?utf-8?B?aTY4WTJSTXU5SzNCaXBNUmd4S2NLVVI5cUJwVnhqVVdQVE1DNkM1NEE1NURu?=
 =?utf-8?B?NHdtZTdzdzhqVjdTNmJUN3RoR2tCOTY3OHJtSDlhQ0lORjZaYXIyV1JHVCt1?=
 =?utf-8?B?djdOWTUzY1dya0syQS9DWDhaOEhRRW5tRjBRMTdCNzdnUmEwUmRIQmdFYzVj?=
 =?utf-8?B?ZmVIT2ZnR285ejhGWndHRTJsYW5LcXBXWnI5UlJldFhKMXVQOUxjdm5pNU5s?=
 =?utf-8?B?d1Q5RVJZRFZPZ2VWbVZROHMwNDJOcU1EMGoyUjNBclJZRk1XYU0vNzNsQ1BI?=
 =?utf-8?B?QUp6R2Fnemg4OWpHM2d2SUV6dzRXekx0RnZJZU82U2EyVlAxNnV6QmNxbjgx?=
 =?utf-8?B?ajQxQkNkaFJJWDVrK2dCVzVHM3U0Mmx3VHg4OStzVzVrTXBiOXptaGcyT0Jl?=
 =?utf-8?B?U01YaXB4WTA0M25FamE2cVNBYUFKbnp4RXd4L216ajRDT3lneHJOK1VZUzdu?=
 =?utf-8?B?Z0x3VlMrWUtVTjhIbE1Ub25valduY3hpYnJyck12T0p4eHRvcEwyVXJOTk9K?=
 =?utf-8?B?L25rcGgzQ0doSnJJdnFDM1Z5MHl2bHV2YXZrTTI4a0Ixd1VJcVd4QVVJc0Vp?=
 =?utf-8?B?ODNoN2tTQi9hRmNHOHA3WUpKb0dlMFB6OXZGc3dMVlFrL2NoV1RrUHNpSC9q?=
 =?utf-8?B?V1gxTS9GTkVDeS9ETTlxQXhJcVVIdDZiK1lUbE1ZWHozL1ZDN3VlUkhIc2tS?=
 =?utf-8?B?NVRTelVhZ2RvVmZ0aXlUb25yVkMvRUUzR1l1bWFZdXZtZWozcytEYVk1UkxU?=
 =?utf-8?B?ZXdBdDI4T09iRkJSZ0lBek1pbkR4Wmt3OHFidTBoK2lUenZVRitUU2ZwTko2?=
 =?utf-8?B?MXBwa3hReGhZU2RFc0JFSGdYVEpNTDZ3NVJHakdRQ2JzUGVXMFBiN1ZndEUv?=
 =?utf-8?B?L2I1NjdvSlBJR3FCTkx2a2dUN3c1Y2g5Ymt0VlQwWG00VDRGV213b1RuSFlE?=
 =?utf-8?B?YjlFeVhpc1NpelpiTjRkbGhtM0lkRlFYb0d4MlkybC9ick1ZTjZkR2I1RCtD?=
 =?utf-8?B?eWtrK3lSRm5zeHRVeGlCMFlxak5reXdCTGxpOUZuQlkrTnNwWWluUUFwUC80?=
 =?utf-8?B?Q3o5QzRvQUZqalEzT3UzSGM2ejhHOUg4Y29FS3lnMnFMQ3RScERKTVlrTmpD?=
 =?utf-8?B?Ymo0ZGdFQm9CZWlhN3JLVWQ4Ymk0OWFKZGlGNFNYMS9Nb2xTZHRIbkQxWlpF?=
 =?utf-8?B?cU1BdXZ6eG9QelVKR1hzeTJ5T0NFVDJsbHR2elBvb3NkaCt4aEdTaEFTK3JU?=
 =?utf-8?B?OHlBTUxRbzN5biswVXFUU0VYc2NRV1g1RzBuc3NZR0Q5U1Z5a3orTHF0cmd3?=
 =?utf-8?B?aFpvTUw3dVlzN24waFZNcEFjc2ZjYjl3TlhRaWx3Q3BydnBua0xHMUNDMUg5?=
 =?utf-8?B?SFI1bEJjQm4wa2d3UmRsalR2bWZvOFh3bUp3QWVPcFFpNlBjQ0xObWFKV1kv?=
 =?utf-8?B?UmYzOUp5VlJ3TC9qYnpSZjJldExuYzMzZ1FCVlJjU2VpdmFiUjFvOU5nVmlT?=
 =?utf-8?B?OFlEenQ0bWFER3ZJaXFQS21ScmNiQjhCdTFjbVEwVnBvYkMxNnRXZkIxa3FS?=
 =?utf-8?B?enVJV2FvL1c0c2luTGh4ZkM1UFpXdUZQTVprZTZtR1ZsNVM1dHcvK1JnQURq?=
 =?utf-8?B?Y1BSWTFqVFlvbkJ6TGY2a0h4Rk5HMC9UemRhc3FhTVBtTGZUMWR2NHRndXJI?=
 =?utf-8?B?U3dDc3d0SDVBL1BhaHZaVU1tczZGcXFGZG5UZCtHMDVnTHZOWW8zOVZqKzlR?=
 =?utf-8?B?SWFUNGRhR1JsaHpmVEhmUHF6YklMSjQyYm1ZTUxSam9qaERPNlhBSXp3S3NC?=
 =?utf-8?Q?cf7UnWfyyaiTiX5c=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce60f706-772a-4c6f-29a9-08dee26a3fd7
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 12:11:50.0446 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: veu841dcKw9SlvK0masx2bSEojh5nYHEDmQI7ivVqD8IaQrEqOigmIyCPINmtIuGfvfenivbJ5N2XlDiczwYF4ZJ73B3w05Pj1lbW9KeS3k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8747
Received-SPF: pass client-ip=2a01:111:f403:c200::3;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
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

On 7/15/26 12:48 PM, Vladimir Sementsov-Ogievskiy wrote:
> On 15.07.26 13:25, Andrey Drobyshev wrote:
>> On 7/14/26 6:03 PM, Vladimir Sementsov-Ogievskiy wrote:
>>> On 26.06.26 19:46, Andrey Drobyshev wrote:
>>>> v2 -> v3:
>>>>
>>>> Re-design device ownership hand-off (suggested by Dongli).  Do not rely
>>>> on SETUP migration notifiers, as this approach forces us to reorder
>>>> generic migration code (see v2 discussion).  Instead:
>>>>
>>>>     * .pre_save() releases ownership on the source (RESET_OWNER) once VM
>>>>       is stopped;
>>>>     * .realize() is adjusted to defer device ownership acquisition for an
>>>>       incoming CPR;
>>>>     * .post_load() actually claims the device (VHOST_SET_OWNER);
>>>>     * FAILED migration event callback re-aquires the ownership on the
>>>>       source after re_save released it.
>>>>
>>>> v2:https://lore.kernel.org/qemu-devel/57c9c9b3-d758-489b-95b8-d16c258b9b0c@virtuozzo.com
>>>
>>> Hi!
>>>
>>
>> Hello Vladimir!
>>
>>> Two notes:
>>>
>>> 1. Did you consider migrating needed FDs through main migration channel, without
>>> use of CPR, like I do in (not yet landed) "[PATCH v19 00/15] virtio-net: live-TAP local migration" [1]
>>>
>>
>> AFAIU you're doing local same-host migration as a way to update QEMU
>> binary.  With this approach transferring FDs through the main channel is
>> indeed cleaner.  However in our own downstream we use enhanced in-place
>> memory preservation which is based entirely on cpr-exec migration mode.
>>
>> So, to answer your question: yes, we considered it, and it might work
>> for cpr-transfer where we're also doing same-host migration.  But in
>> cpr-exec case there's only one QEMU process involved => we can't use
>> UNIX socket for migration transport => no SCM_RIGHTS FDs passing => FDs
>> should be passed via additional transport, no way around it.
> 
> 
> Hmm. Looking at code for fd-passing through migration channel:
> 
> static bool load_fd(QEMUFile *f, void *pv, size_t size,
>                      const VMStateField *field, Error **errp)
> {
>      int32_t *v = pv;
> 
>      if (migrate_mode() == MIG_MODE_CPR_EXEC) {
>          qemu_get_sbe32s(f, v);
>          return true;
>      }
> ...
> 
> 
> Seems like passing FDs through main channel (like in my TAP-series) would
> work both for local migration (with two processes and UNIX socket) and for
> CPR_EXEC mode. So the FD is passed as simple number in case of cpr-exec.
> 
> So, if simply pass FDs through migration state, it should work both for
> CPR_EXEC and local migration.
> 
> (hmm, still, keeping in mind that TAP-series API still not negotiated,
> it's simpler to start from pure CPR approach, and add local-migration
> support in future)
>

Yes, my claim was too harsh - the FD passing mechanism itself probably
can be implemented via the main migration channel as well, even for
cpr-exec.  E.g. if it's not a UNIX socket but a plain file on file
system - we should be good.

But then the issue is timing: VMSTATE_FD delivers the FD during the
device's vmstate load, i.e. around post_load.  And cpr_state is loaded
early, before device realization, so the FD is available at realize
time.  And for instance our vhost-vsock case does need FD already during
realize to read the backend feature set:

vhost_vsock_device_realize() ->
  vhost_dev_init_backend() ->
    vhost_dev_init_features()

So for me the exact transport used underneath for FDs passing is not
that important.  I'm just exploiting the CPR API to get the passed FD at
an early .realize() stage.  If we can somehow guarantee an early FDs
delivery through the main channel - that'll work.

Andrey

>>
>>
>>> 2. I don't know how much vhost-vsock differs from vhost-net, but for vhost-net I remember
>>> that RESET_OWNER + SET_OWNER is effectively equal to simply recreating vhost device on target,
>>> because in kernel vhost device is hardly bound to the process itself, and can't be passed to
>>> another process. So, we can pass only "empty" FD, not the initialized vhost device.
>>> That's why in [1] I only pass tap-fds (and some additional state), but vhost fds are simply
>>> reopened on target (or passed by mgmt app).
>>> Does vhost-vsock work in a different way? Is there real sense in passing vhost fds here?
>>>
>>>
>>> [1] https://lore.kernel.org/qemu-devel/20260714154246.1242856-1-vsementsov@yandex-team.ru/
>>>
>>
>> I'm also not extremely keen on vhost-net internals, but as I understand
>> with vhost-net we have 2 FDs: TAP FD for the network endpoint and vhost
>> FD for the memory tables, vring addresses etc.  The TAP FD is
>> process-independent state - and we pass it via migration channel.  The
>> vhost FD is entirely per owning process - and we're able to close it on
>> source, reopen on target and bind to the passed TAP FD.
> 
> Yes, my understanding matches.
> 
>>
>> However with vhost-vsock there's only one FD.  It's used both for
>> plumbing and the endpoint.  At the very least, vhost device state holds
>> guest CID registration in the global vhost_vsock_hash.  If we go the
>> "recreate/reopen the device" path - CID is removed from the hash in
>> vhost_vsock_dev_release(), and then we're gonna get ECONNRESET for any
>> incoming packets => connections are dead.  We can't afford that.
>>
> 
> OK, thanks for explanation!
> 
> 


