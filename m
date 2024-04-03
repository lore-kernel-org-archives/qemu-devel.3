Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF3B3C6FD1F
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 08:32:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrw24-0005Ig-ER; Wed, 03 Apr 2024 04:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rrw1y-0005Hd-4r; Wed, 03 Apr 2024 04:31:39 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rrw1t-0000vP-4q; Wed, 03 Apr 2024 04:31:35 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:6401:0:640:7e6f:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id B6F8C60C96;
 Wed,  3 Apr 2024 11:31:25 +0300 (MSK)
Received: from [IPV6:2a02:6b8:0:419:fa1c:23b:811e:f68a] (unknown
 [2a02:6b8:0:419:fa1c:23b:811e:f68a])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id MVOaKQ2IkKo0-xt4sloFc; Wed, 03 Apr 2024 11:31:25 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1712133085;
 bh=KYJyQIOEMwCoxa4vXAVCME7eBAgZRpeORCwXJCzZcXM=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=GIVmIq4252gF8Jr9FKlVSHFQqt1QHg8TplrqvWzHCRLn51zM2KW4YobQyLIH+DySc
 /ErTQbX2O65uSPhtK7aiBIWqiDkqwhfcL19zXo7fqfahws2igAijYrvqNph6rctY2r
 /wg5W7HWG8Sgbcvcu8Fn5GWCfQlK4OHwJRGS5eNU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <ba76742d-4fa1-4120-98ad-944845a37ad6@yandex-team.ru>
Date: Wed, 3 Apr 2024 11:31:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/19] block/stream: fix -Werror=maybe-uninitialized
 false-positives
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org,
 Hyman Huang <yong.huang@smartx.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, John Snow <jsnow@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Bin Meng <bin.meng@windriver.com>, Hanna Reitz <hreitz@redhat.com>,
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
 <0d7344c2-b146-44cf-a911-21fa5e556665@yandex-team.ru>
 <mzls26xlctld3fd5fl3h5wdrbh6hb5i3xcakeslwzny5tva7ch@w6wnruxtefkl>
 <3064bc69-3d8e-4d7c-b640-a7ab703f9575@yandex-team.ru>
 <CAJ+F1CLG+7BT8wLFmmJ0t8NvMu2a2Vp1+p6gUuBTch9haYP8LQ@mail.gmail.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <CAJ+F1CLG+7BT8wLFmmJ0t8NvMu2a2Vp1+p6gUuBTch9haYP8LQ@mail.gmail.com>
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

On 03.04.24 11:11, Marc-André Lureau wrote:
> Hi
> 
> On Tue, Apr 2, 2024 at 11:24 PM Vladimir Sementsov-Ogievskiy
> <vsementsov@yandex-team.ru> wrote:
>>
>> On 02.04.24 18:34, Eric Blake wrote:
>>> On Tue, Apr 02, 2024 at 12:58:43PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>>>>> Again, same false-positives, because of WITH_GRAPH_RDLOCK_GUARD()..
>>>>>>
>>>>>> Didn't you try to change WITH_ macros somehow, so that compiler believe in our good intentions?
>>>>>>
>>>>>
>>>>>
>>>>> #define WITH_QEMU_LOCK_GUARD_(x, var) \
>>>>>        for (g_autoptr(QemuLockable) var = \
>>>>>                    qemu_lockable_auto_lock(QEMU_MAKE_LOCKABLE_NONNULL((x))); \
>>>>>             var; \
>>>>>             qemu_lockable_auto_unlock(var), var = NULL)
>>>>>
>>>>> I can't think of a clever way to rewrite this. The compiler probably
>>>>> thinks the loop may not run, due to the "var" condition. But how to
>>>>> convince it otherwise? it's hard to introduce another variable too..
>>>>
>>>>
>>>> hmm. maybe like this?
>>>>
>>>> #define WITH_QEMU_LOCK_GUARD_(x, var) \
>>>>       for (g_autoptr(QemuLockable) var = \
>>>>                   qemu_lockable_auto_lock(QEMU_MAKE_LOCKABLE_NONNULL((x))), \
>>>>            var2 = (void *)(true); \
>>>>            var2; \
>>>>            qemu_lockable_auto_unlock(var), var2 = NULL)
>>>>
>>>>
>>>> probably, it would be simpler for compiler to understand the logic this way. Could you check?
>>>
>>> Wouldn't that attach __attribute__((cleanup(xxx))) to var2, at which
>>> point we could cause the compiler to call xxx((void*)(true)) if the
>>> user does an early return inside the lock guard, with disastrous
>>> consequences?  Or is the __attribute__ applied only to the first out
>>> of two declarations in a list?
>>>
>>
>> Oh, most probably you are right, seems g_autoptr apply it to both variables. Also, we don't need qemu_lockable_auto_unlock(var) separate call, if we zero-out another variable. So, me fixing:
>>
>> #define WITH_QEMU_LOCK_GUARD_(x, var) \
>>       for (QemuLockable *var __attribute__((cleanup(qemu_lockable_auto_unlock))) = qemu_lockable_auto_lock(QEMU_MAKE_LOCKABLE_NONNULL((x))), \
>>            *var2 = (void *)(true); \
>>            var2; \
>>            var2 = NULL)
>>
>> (and we'll need to modify qemu_lockable_auto_unlock() to take "QemuLockable **x" argument)
>>
> 
> That's almost good enough. I fixed a few things to generate var2.
> 
> I applied a similar approach to WITH_GRAPH_RDLOCK_GUARD macro:
> 
> --- a/include/block/graph-lock.h
> +++ b/include/block/graph-lock.h
> @@ -224,13 +224,22 @@ graph_lockable_auto_unlock(GraphLockable *x)
> 
>   G_DEFINE_AUTOPTR_CLEANUP_FUNC(GraphLockable, graph_lockable_auto_unlock)
> 
> -#define WITH_GRAPH_RDLOCK_GUARD_(var)                                         \
> -    for (g_autoptr(GraphLockable) var = graph_lockable_auto_lock(GML_OBJ_()); \
> -         var;                                                                 \
> -         graph_lockable_auto_unlock(var), var = NULL)
> +static inline void TSA_NO_TSA coroutine_fn
> +graph_lockable_auto_cleanup(GraphLockable **x)
> +{
> +    graph_lockable_auto_unlock(*x);
> +}
> +
> +#define WITH_GRAPH_RDLOCK_GUARD__(var) \
> +    GraphLockable *var \
> +        __attribute__((cleanup(graph_lockable_auto_cleanup))) G_GNUC_UNUSED = \
> +       graph_lockable_auto_lock(GML_OBJ_())
> +
> +#define WITH_GRAPH_RDLOCK_GUARD_(var, var2)                             \
> +    for (WITH_GRAPH_RDLOCK_GUARD__(var), *var2 = (void *)true; var2;
> var2 = NULL)
> 
>   #define WITH_GRAPH_RDLOCK_GUARD() \
> -    WITH_GRAPH_RDLOCK_GUARD_(glue(graph_lockable_auto, __COUNTER__))
> +    WITH_GRAPH_RDLOCK_GUARD_(glue(graph_lockable_auto, __COUNTER__),
> glue(graph_lockable_auto, __COUNTER__))
> 
> Unfortunately, it doesn't work in all cases. It seems to have issues
> with some guards:
> ../block/stream.c: In function ‘stream_run’:
> ../block/stream.c:216:12: error: ‘ret’ may be used uninitialized
> [-Werror=maybe-uninitialized]
>    216 |         if (ret < 0) {
> 
> 

So, updated macro helps in some cases, but doesn't help here? Intersting, why.

> What should we do? change the macros + cherry-pick the missing
> false-positives, or keep this series as is?
> 
> 

I think marco + missing is better. No reason to add dead-initializations in cases where new macros helps.
Still, would be good to understand, what's the difference, why it help on some cases and not help in another.


-- 
Best regards,
Vladimir


