Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E8E8CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 19:25:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrjkA-0000ug-KE; Tue, 02 Apr 2024 15:24:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rrjk7-0000td-3z; Tue, 02 Apr 2024 15:24:23 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rrjk5-0003TJ-1Z; Tue, 02 Apr 2024 15:24:22 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:6401:0:640:7e6f:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 02C7860907;
 Tue,  2 Apr 2024 22:24:12 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b507::1:2e] (unknown
 [2a02:6b8:b081:b507::1:2e])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 8OY9LF2IjeA0-EbqumJvh; Tue, 02 Apr 2024 22:24:11 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1712085851;
 bh=ffyQuXzT6Rz4HSYl6Bj1mGTw4D2KYbyWOHmot+xs2oU=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=ok0Od7DYtw63obhXDJuJClXixCUtd5FvBVXEfqqghPNa6yjFe3YPgexExs5Q93PiA
 ketuYnbj2iMGZveR6X7CQcZNRMSXPV0MEvKbeIKU3Li4z/QXffq5W9YOSnN7voYsNA
 GNGlZHttd7nj2sipDhpJriU5Kz4tz3yXAoGf1Xa4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <3064bc69-3d8e-4d7c-b640-a7ab703f9575@yandex-team.ru>
Date: Tue, 2 Apr 2024 22:24:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/19] block/stream: fix -Werror=maybe-uninitialized
 false-positives
To: Eric Blake <eblake@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 qemu-devel@nongnu.org, Hyman Huang <yong.huang@smartx.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 John Snow <jsnow@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Fam Zheng <fam@euphon.net>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Bin Meng <bin.meng@windriver.com>,
 Hanna Reitz <hreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Jesper Devantier <foss@defmacro.it>,
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
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <mzls26xlctld3fd5fl3h5wdrbh6hb5i3xcakeslwzny5tva7ch@w6wnruxtefkl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
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

On 02.04.24 18:34, Eric Blake wrote:
> On Tue, Apr 02, 2024 at 12:58:43PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>>> Again, same false-positives, because of WITH_GRAPH_RDLOCK_GUARD()..
>>>>
>>>> Didn't you try to change WITH_ macros somehow, so that compiler believe in our good intentions?
>>>>
>>>
>>>
>>> #define WITH_QEMU_LOCK_GUARD_(x, var) \
>>>       for (g_autoptr(QemuLockable) var = \
>>>                   qemu_lockable_auto_lock(QEMU_MAKE_LOCKABLE_NONNULL((x))); \
>>>            var; \
>>>            qemu_lockable_auto_unlock(var), var = NULL)
>>>
>>> I can't think of a clever way to rewrite this. The compiler probably
>>> thinks the loop may not run, due to the "var" condition. But how to
>>> convince it otherwise? it's hard to introduce another variable too..
>>
>>
>> hmm. maybe like this?
>>
>> #define WITH_QEMU_LOCK_GUARD_(x, var) \
>>      for (g_autoptr(QemuLockable) var = \
>>                  qemu_lockable_auto_lock(QEMU_MAKE_LOCKABLE_NONNULL((x))), \
>>           var2 = (void *)(true); \
>>           var2; \
>>           qemu_lockable_auto_unlock(var), var2 = NULL)
>>
>>
>> probably, it would be simpler for compiler to understand the logic this way. Could you check?
> 
> Wouldn't that attach __attribute__((cleanup(xxx))) to var2, at which
> point we could cause the compiler to call xxx((void*)(true)) if the
> user does an early return inside the lock guard, with disastrous
> consequences?  Or is the __attribute__ applied only to the first out
> of two declarations in a list?
> 

Oh, most probably you are right, seems g_autoptr apply it to both variables. Also, we don't need qemu_lockable_auto_unlock(var) separate call, if we zero-out another variable. So, me fixing:

#define WITH_QEMU_LOCK_GUARD_(x, var) \
     for (QemuLockable *var __attribute__((cleanup(qemu_lockable_auto_unlock))) = qemu_lockable_auto_lock(QEMU_MAKE_LOCKABLE_NONNULL((x))), \
          *var2 = (void *)(true); \
          var2; \
          var2 = NULL)

(and we'll need to modify qemu_lockable_auto_unlock() to take "QemuLockable **x" argument)

-- 
Best regards,
Vladimir


