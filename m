Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6309CD11C2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 07:06:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruS1f-0001M3-Ip; Wed, 10 Apr 2024 03:05:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1ruS1c-0001JN-Vd; Wed, 10 Apr 2024 03:05:41 -0400
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1ruS1Z-0000ji-Uc; Wed, 10 Apr 2024 03:05:40 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:3b00:0:640:c3c9:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id 83EEA60B7C;
 Wed, 10 Apr 2024 10:05:29 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b434::1:2b] (unknown
 [2a02:6b8:b081:b434::1:2b])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id S5UEi52IbSw0-jfpHy93Q; Wed, 10 Apr 2024 10:05:29 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1712732729;
 bh=poSrrJlqRKRms3kxD2Phd7z/uwrKD7PZKhAIvzH4o3E=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=HXyPsxOU8y8TwBDaMQFwxJ0eDLwcckOpjC/a6Bti+dsdg+CZoedC4nSbbAWox6y8m
 Kip1Ba4qv4hiocFUg3X9WUp0YiREQVw5d+PuHKGAV3RGzUs2sgWY9zPuyBPwYcq0EV
 9MQ4WMhsS2endRBB6iZVvRkSMYoGdyY1S1czJT9M=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <67979e90-653b-410e-9ed4-02d37410dea1@yandex-team.ru>
Date: Wed, 10 Apr 2024 10:05:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] nbd/server: Mark negotiation functions as
 coroutine_fn
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Zhu Yangyang <zhuyangyang14@huawei.com>
References: <20240408160214.1200629-4-eblake@redhat.com>
 <20240408160214.1200629-6-eblake@redhat.com>
 <f00ac999-fb9b-4429-b5b9-be27153f77a5@yandex-team.ru>
 <eu34jjayqnpqsubkv4wpxogh6dwaok2t35udee4ojpvn5imcv3@n75m44kvv64u>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <eu34jjayqnpqsubkv4wpxogh6dwaok2t35udee4ojpvn5imcv3@n75m44kvv64u>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 09.04.24 18:49, Eric Blake wrote:
> On Tue, Apr 09, 2024 at 09:30:39AM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> On 08.04.24 19:00, Eric Blake wrote:
>>> nbd_negotiate() is already marked coroutine_fn.  And given the fix in
>>> the previous patch to have nbd_negotiate_handle_starttls not create
>>> and wait on a g_main_loop (as that would violate coroutine
>>> constraints), it is worth marking the rest of the related static
>>> functions reachable only during option negotiation as also being
>>> coroutine_fn.
>>>
>>> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>> ---
>>>    nbd/server.c | 102 +++++++++++++++++++++++++++++----------------------
>>>    1 file changed, 59 insertions(+), 43 deletions(-)
>>>
>>> diff --git a/nbd/server.c b/nbd/server.c
>>> index 98ae0e16326..1857fba51c1 100644
>>
>> [..]
>>
>>>    {
>>>        int rc;
>>>        g_autofree char *name = NULL;
>>> @@ -755,7 +764,8 @@ struct NBDTLSServerHandshakeData {
>>>        Coroutine *co;
>>>    };
>>>
>>> -static void nbd_server_tls_handshake(QIOTask *task, void *opaque)
>>> +static coroutine_fn void
>>
>> This is not, that's a callback for tls handshake, which is not coroutine context as I understand.
> 
> The call chain is:
> 
> nbd_negotiate() - coroutine_fn before this patch
>    nbd_negotiate_options() - marked coroutine_fn here
>      nbd_negotiate_handle_starttls() - marked coroutine_fn here
>        qio_channel_tls_handshake() - in io/channel-tls.c; not marked coroutine_fn, but
>                                      works both in or out of coroutine context
>          ...
>          nbd_server_tls_handshake() - renamed in 1/2 of this series
> 
>> without this hunk:
> 
> I can drop that particular marking.  There are cases where the
> callback is reached without having done the qemu_coroutine_yield() in
> nbd_negotiate_handle_starttls; but there are also cases where the IO
> took enough time that the coroutine yielded and it is that callback
> that reawakens it.

The key thing for me is that in this case (when coroutine yielded), nbd_server_tls_handshake() would finally be called from glib IO handler, set in

    qio_channel_tls_handshake()
       qio_channel_tls_handshake_task()
          qio_channel_add_watch_full()
             g_source_set_callback(source, (GSourceFunc)func, user_data, notify);   <<<

, which would definitely not be a coroutine context.


Do I understand correctly, that "coroutine_fn" means "only call from coroutine context"[1], or does it mean "could be called from coroutine context"[2]?

The comment in osdep.h says:

  * Mark a function that executes in coroutine context                                                     |}
  *                                                                                                        |
  * Functions that execute in coroutine context cannot be called directly from                             |
  * normal functions. ...

So I assume, we mean [1].

> 
>>
>>
>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> 
> Thanks.
> 

-- 
Best regards,
Vladimir


