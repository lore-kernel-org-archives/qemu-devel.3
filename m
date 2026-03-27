Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F5010ED65C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 11:48:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w65fk-0006nC-FE; Fri, 27 Mar 2026 07:48:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hongmianquan@bytedance.com>)
 id 1w65fi-0006ms-8D
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:48:14 -0400
Received: from va-1-115.ptr.blmpb.com ([209.127.230.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hongmianquan@bytedance.com>)
 id 1w65fg-0000Is-97
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:48:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1774612082; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=JsbOBj5i/lT4839SreJ+wtV51TnPNoLLGXFIaKDpXuU=;
 b=e9HO0P9mo9lddAybTwGhaUIoA+DDTWm8UjsvQcww8sYAJ1nf6pVuZTDWsyIXGx6BOkZBhN
 8OfDKG3TzxfdPfGBhWSKrh+T2dP4Byl67co9pl6jxXSSUqS0qDCY2I4I6FKrvF2BEJXl6s
 wCAaRPQ2YSQPENUqhulp3SVGu6Fx20/pOTMR6Y5vxChdiUmEbiVU6Xd37uRjBYlZhlNbWj
 2PSTTRUMnRFoCHZAuFVQRXo9qkD3W8SqTpUOFT3NgkIoCGTo5UTJSIliC4N4Wwr/8DG5/I
 o1A93es9e1rrSYisMSzx8PRJAiGhMksFEQ8AGWJKSI24sqBNNVL8YiF+6Vnhfg==
References: <20260323133744.46493-1-hongmianquan@bytedance.com>
 <acWJ1-aAmegtcOCv@redhat.com>
 <ac3b2678-e184-41b1-9fd3-92371e626ef3@bytedance.com>
 <acZe0gC1yvagJbP0@redhat.com>
X-Lms-Return-Path: <lba+269c66e71+ba24d9+nongnu.org+hongmianquan@bytedance.com>
From: "hongmainquan" <hongmianquan@bytedance.com>
Subject: Re: [RFC] monitor: Fix deadlock in monitor_cleanup
Mime-Version: 1.0
In-Reply-To: <acZe0gC1yvagJbP0@redhat.com>
X-Original-From: hongmainquan <hongmianquan@bytedance.com>
To: "Kevin Wolf" <kwolf@redhat.com>
Cc: <qemu-devel@nongnu.org>, <dave@treblig.org>, <armbru@redhat.com>, 
 <wubo.bob@bytedance.com>
User-Agent: Mozilla Thunderbird
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Mar 2026 19:47:51 +0800
Message-Id: <16bd902d-da8c-4601-bdf7-61d0a50e632b@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Received-SPF: pass client-ip=209.127.230.115;
 envelope-from=hongmianquan@bytedance.com; helo=va-1-115.ptr.blmpb.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

=E5=9C=A8 2026/3/27 18:41, Kevin Wolf =E5=86=99=E9=81=93:
> Am 27.03.2026 um 08:56 hat hongmainquan geschrieben:
>> =E5=9C=A8 2026/3/27 03:32, Kevin Wolf =E5=86=99=E9=81=93:
>>> Am 23.03.2026 um 14:37 hat hongmianquan geschrieben:
>>>> During qemu_cleanup, if a non-coroutine QMP command (e.g.,
>>>> query-commands) is concurrently received and processed by the
>>>> mon_iothread, it can lead to a deadlock in monitor_cleanup.
>>>>
>>>> The root cause is a race condition between the main thread's shutdown
>>>> sequence and the coroutine's dispatching mechanism. When handling a
>>>> non-coroutine QMP command, qmp_dispatcher_co schedules the actual
>>>> command execution as a bottom half in iohandler_ctx and then yields.
>>>> At this suspended point, qmp_dispatcher_co_busy remains true.
>>>> Subsequently, the main thread in monitor_cleanup(), sets
>>>> qmp_dispatcher_co_shutdown, and calls qmp_dispatcher_co_wake(). Since
>>>> qmp_dispatcher_co_busy is already true, the aio_co_wake is skipped.
>>>> The main thread then enters the AIO_WAIT_WHILE_UNLOCKED loop, it
>>>> executes the scheduled BH (do_qmp_dispatch_bh) via
>>>> aio_poll(iohandler_ctx, false), which attempts to wake up the
>>>> coroutine, aio_co_wake schedules a new wake-up BH in iohandler_ctx.
>>>> The main thread then blocks indefinitely in aio_poll(qemu_aio_context,
>>>> true), while the coroutine's wake-up BH is starved in iohandler_ctx,
>>>> qmp_dispatcher_co never reaches termination, resulting in a deadlock.
>>>
>>> If the real problem is that the aio_poll() in the main thread is never
>>> woken up, does this fix the problem? (Completely untested, and would
>>> need a comment if we commit it.)
>>>
>> After our reproduction tests, this change also resolves the issue and
>> proves to be a more appropriate solution.
>> Should we proceed with this commit based on our discussion, or do you
>> require further validation?
>=20
> If it works for you, let's move forward with this. I think we just
> should add a comment like "if we're in AIO_WAIT_WHILE_UNLOCKED() in
> monitor_cleanup(), make sure that it doesn't wait for an event in the
> main context, but iohandler_ctx is polled" in the real commit because
> it's not obvious why the aio_wait_kick() is needed here.
>=20
>> Thanks,
>>> diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
>>> index 9bb1e6a9f4a..0a0e9e07756 100644
>>> --- a/qapi/qmp-dispatch.c
>>> +++ b/qapi/qmp-dispatch.c
>>> @@ -128,6 +128,7 @@ static void do_qmp_dispatch_bh(void *opaque)
>>>        data->cmd->fn(data->args, data->ret, data->errp);
>>>        monitor_set_cur(qemu_coroutine_self(), NULL);
>>>        aio_co_wake(data->co);
>>> +    aio_wait_kick();
>>>    }
>=20
> Do you want to send a v2 patch that takes this approach, or would you
> prefer if I send it as a proper patch?
>=20
> Kevin
>=20
I will send a v2 patch adopting this approach later. Thank you for your=20
advice.

