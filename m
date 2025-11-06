Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66459CCFA05
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 17:49:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vH46D-00058z-0n; Thu, 06 Nov 2025 12:48:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vH466-000587-T6
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 12:48:37 -0500
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vH464-0001FS-6F
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 12:48:34 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1a8f:0:640:2fa2:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 98CAE807BE;
 Thu, 06 Nov 2025 20:48:26 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:95c::1:2] (unknown [2a02:6bf:8080:95c::1:2])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id OmqoLK0FGiE0-ItbOhPQU; Thu, 06 Nov 2025 20:48:25 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1762451305;
 bh=aVTgqwazdpJyb7kW51QfFml7QkHzWIOhgoTpGwExTOc=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=MM/m2TDxvoWmp/jLey24xexfmjPZ2GOxnBWJBlzR9s+cbH6Xnz5WOt1XVaVXiTRO3
 m6QOWG4vCi9+Oav6ezRvIRhvgam5kJZFaVMrR4buyoTml0g91IrjyyySAufA1bikqW
 SSzcfgkVLpNAmu7id04R0JBcjDGPzE3zhHZ003Y4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <e775fb07-651c-4f9f-be1a-cd80396586cd@yandex-team.ru>
Date: Thu, 6 Nov 2025 20:48:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/7] chardev: postpone connect
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 pbonzini@redhat.com, eduardo@habkost.net, qemu-devel@nongnu.org,
 raphael@enfabrica.net, armbru@redhat.com, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru
References: <20251104101715.76691-1-vsementsov@yandex-team.ru>
 <CAMxuvazmJ+0fUDae-W4ZFFKAgtZLBFrxtZCrTT8sgBCmNirW2g@mail.gmail.com>
 <aQnmW2NskQtEfsGe@redhat.com>
 <966c338b-8302-4583-be9b-bb683ce3f3c5@yandex-team.ru>
 <aQnn_n0AuBjl4qQ_@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aQnn_n0AuBjl4qQ_@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

On 04.11.25 14:48, Daniel P. Berrangé wrote:
> On Tue, Nov 04, 2025 at 02:44:49PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> On 04.11.25 14:41, Daniel P. Berrangé wrote:
>>> On Tue, Nov 04, 2025 at 03:35:17PM +0400, Marc-André Lureau wrote:
>>>> Hi Vladimir
>>>>
>>>> On Tue, Nov 4, 2025 at 2:17 PM Vladimir Sementsov-Ogievskiy <
>>>> vsementsov@yandex-team.ru> wrote:
>>>>
>>>>> Hi all!
>>>>>
>>>>> That's a preparation for backend-transfer migration of
>>>>> vhost-user-blk, and introduced DEFINE_PROP_CHR_NO_CONNECT()
>>>>> is unused now.
>>>>>
>>>>> v3 of "vhost-user-blk: live-backend local migration" is coming
>>>>> soon, and will be based on this series (and will use
>>>>> DEFINE_PROP_CHR_NO_CONNECT of course).
>>>>>
>>>>> changes in v6:
>>>>> 05: move connect() call into "if (s)"
>>>>> 07: - drop assertion
>>>>>       - improve doc comment, to cover @s==NULL relations with @connect
>>>>>       - add r-b by Marc-André
>>>>>
>>>>> Vladimir Sementsov-Ogievskiy (7):
>>>>>     chardev/char-socket: simplify reconnect-ms handling
>>>>>     chardev/char: split chardev_init_common() out of qemu_char_open()
>>>>>     chardev/char: qemu_char_open(): add return value
>>>>>     chardev/char: move filename and be_opened handling to qemu_char_open()
>>>>>     chardev/char: introduce .init() + .connect() initialization interface
>>>>>     chardev/char-socket: move to .init + .connect api
>>>>>     chardev: introduce DEFINE_PROP_CHR_NO_CONNECT
>>>>>
>>>>
>>>> Do you need this series in 10.2? We are at soft-freeze today, this is
>>>> closer to a feature than a simple refactoring, we may just wait for the
>>>> next dev phase.
>>>
>>> Back in v2, I had a request to convert the other chardev backends
>>> to the new model too, as IMHO it is undesirable to introduce the
>>> technical debt by only touching 1 backend:
>>>
>>>     https://lists.nongnu.org/archive/html/qemu-devel/2025-10/msg03272.html
>>>
>>
>> Right. I remember it, and have a draft converting series. It turned out to be more than expected,
>> about 24 commits, and personally I'm not sure, that it worth doing.. I'll send an RFC too look at.
> 
> Yep, I'd be interested to see what it looks like, even if it is not
> finished / not functional.
> 

Hmm. Looking through my draft, and in parallel, moving char-socket vmsd
into correct layer (into char-socket), I now see the following:

1. splitting open() logic into init() and connect() make sense only
if it done for and together with implementing vmsd for that chardev
(as we do the split exactly in a manner which makes implementing of
migration possible)

2. implementing backend-transfer for all chardevs is too much for me.

So, seems, correct way is to allow chardevs have only .init, without
.connect when no support for migration.

And, converting all chardevs would be simply rename .open() to .init().
And I'll keep .open() semantics for .init() (i.e. additional handling
.filename and CHR_EVENT_OPENED for chardevs that don't care of it)

So, I can do the rename as first patch of v7 of this series, and we'll
keep common interaface for all chadevs (except for that most of them
will not support migration, and therefore don't implement .connect()
and .vmsd)

-- 
Best regards,
Vladimir

