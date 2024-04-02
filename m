Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 429DDCD1292
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 10:00:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rravZ-0004gj-6U; Tue, 02 Apr 2024 05:59:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rrav1-0004YB-5P; Tue, 02 Apr 2024 05:59:04 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rrauv-000722-FA; Tue, 02 Apr 2024 05:59:02 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c18:486:0:640:cf34:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 5121D60DD0;
 Tue,  2 Apr 2024 12:58:47 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b507::1:2e] (unknown
 [2a02:6b8:b081:b507::1:2e])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id hwO5wlCOdGk0-zaozjiZ4; Tue, 02 Apr 2024 12:58:46 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1712051926;
 bh=Tadl6nHpLXTtcmMhglCPBLLQSFYs/OqI+6+n6Lcdz0U=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=E+oDMlpNc3eNZ5VyAzcznvMSKiiUvyVLYYya1O1BbC+H4lizz2PH+U1qgLmZaXdcD
 BnZR6SIITSZUfSH6YstHtJffbJyRg3pfts5u/Lmg7XxuIv6tSBMoImBLh+5EX9gBDD
 Pg9ZIGKA3r4eXDy4ZmXlkf3z7lPJOX9GT/4hDpzs=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <0d7344c2-b146-44cf-a911-21fa5e556665@yandex-team.ru>
Date: Tue, 2 Apr 2024 12:58:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/19] block/stream: fix -Werror=maybe-uninitialized
 false-positives
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, Hyman Huang <yong.huang@smartx.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 John Snow <jsnow@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Fam Zheng <fam@euphon.net>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Bin Meng <bin.meng@windriver.com>,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Yuval Shaia <yuval.shaia.ml@gmail.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jesper Devantier <foss@defmacro.it>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Keith Busch <kbusch@kernel.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Peter Xu <peterx@redhat.com>
References: <20240328102052.3499331-1-marcandre.lureau@redhat.com>
 <20240328102052.3499331-7-marcandre.lureau@redhat.com>
 <65d791e4-6c68-4b6d-b181-bc3886745ce3@yandex-team.ru>
 <CAJ+F1CLbjZG24rMKwA20NFM=6sTE4CRAaGt4Vha+bP8i=+on-A@mail.gmail.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <CAJ+F1CLbjZG24rMKwA20NFM=6sTE4CRAaGt4Vha+bP8i=+on-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 02.04.24 12:12, Marc-André Lureau wrote:
> Hi
> 
> On Fri, Mar 29, 2024 at 12:35 PM Vladimir Sementsov-Ogievskiy
> <vsementsov@yandex-team.ru> wrote:
>>
>> On 28.03.24 13:20, marcandre.lureau@redhat.com wrote:
>>> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>>>
>>> ../block/stream.c:193:19: error: ‘unfiltered_bs’ may be used uninitialized [-Werror=maybe-uninitialized]
>>> ../block/stream.c:176:5: error: ‘len’ may be used uninitialized [-Werror=maybe-uninitialized]
>>> trace/trace-block.h:906:9: error: ‘ret’ may be used uninitialized [-Werror=maybe-uninitialized]
>>>
>>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>>
>> Again, same false-positives, because of WITH_GRAPH_RDLOCK_GUARD()..
>>
>> Didn't you try to change WITH_ macros somehow, so that compiler believe in our good intentions?
>>
> 
> 
> #define WITH_QEMU_LOCK_GUARD_(x, var) \
>      for (g_autoptr(QemuLockable) var = \
>                  qemu_lockable_auto_lock(QEMU_MAKE_LOCKABLE_NONNULL((x))); \
>           var; \
>           qemu_lockable_auto_unlock(var), var = NULL)
> 
> I can't think of a clever way to rewrite this. The compiler probably
> thinks the loop may not run, due to the "var" condition. But how to
> convince it otherwise? it's hard to introduce another variable too..


hmm. maybe like this?

#define WITH_QEMU_LOCK_GUARD_(x, var) \
     for (g_autoptr(QemuLockable) var = \
                 qemu_lockable_auto_lock(QEMU_MAKE_LOCKABLE_NONNULL((x))), \
          var2 = (void *)(true); \
          var2; \
          qemu_lockable_auto_unlock(var), var2 = NULL)


probably, it would be simpler for compiler to understand the logic this way. Could you check?


(actually, will also need to construct var2 name same way as for var)

> 
>> Actually, "unused variable initialization" is bad thing too.
>>
>> Anyway, if no better solution for now:
>> Acked-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>
>>> ---
>>>    block/stream.c | 6 +++---
>>>    1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/block/stream.c b/block/stream.c
>>> index 7031eef12b..9076203193 100644
>>> --- a/block/stream.c
>>> +++ b/block/stream.c
>>> @@ -155,8 +155,8 @@ static void stream_clean(Job *job)
>>>    static int coroutine_fn stream_run(Job *job, Error **errp)
>>>    {
>>>        StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
>>> -    BlockDriverState *unfiltered_bs;
>>> -    int64_t len;
>>> +    BlockDriverState *unfiltered_bs = NULL;
>>> +    int64_t len = -1;
>>>        int64_t offset = 0;
>>>        int error = 0;
>>>        int64_t n = 0; /* bytes */
>>> @@ -177,7 +177,7 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
>>>
>>>        for ( ; offset < len; offset += n) {
>>>            bool copy;
>>> -        int ret;
>>> +        int ret = -1;
>>>
>>>            /* Note that even when no rate limit is applied we need to yield
>>>             * with no pending I/O here so that bdrv_drain_all() returns.
>>
>> --
>> Best regards,
>> Vladimir
>>
>>
> 
> 

-- 
Best regards,
Vladimir


