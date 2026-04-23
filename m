Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D2AF9936C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:58:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFrl1-0000uY-Gr; Thu, 23 Apr 2026 06:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wFrkv-0000tB-A6
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:58:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wFrkt-000559-QB
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:58:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776941878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RY5j7jHOGxkGDi70dG5O6OtLWIXA4C1iW6USZ+Rp52c=;
 b=hxkihzkE6bIm+1Rxi8b9tjHQbNJoR51fliT4XdZtW4sNPZnVL46FiXc5fc9v/bMgUUO2hE
 waT5PczQzca2UgGKu7/Bg9tx8ItD3ReLuBXmOhfgvxWUUZ9bhOrOLl923GyLGn2RA2Rwqf
 LZ/6344nEs5WgdJvcBllzfEZHfEFUDs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-7PWjdNy8MHaOYdZwxZKLuw-1; Thu,
 23 Apr 2026 06:57:57 -0400
X-MC-Unique: 7PWjdNy8MHaOYdZwxZKLuw-1
X-Mimecast-MFC-AGG-ID: 7PWjdNy8MHaOYdZwxZKLuw_1776941876
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7E041195605A
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 10:57:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.30])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3D0171800351
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 10:57:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B53FD21E6A28; Thu, 23 Apr 2026 12:57:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] ui/console: remove console from global list on
 finalization
In-Reply-To: <CAMxuvaxryBmJ4+VL5qNv2pP3t9KoKS-jH45nY1hzvoxz-rCHXg@mail.gmail.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Thu, 23 Apr 2026
 12:02:16 +0400")
References: <20260422202646.272081-1-marcandre.lureau@redhat.com>
 <87v7dis20c.fsf@pond.sub.org>
 <CAMxuvaxCkJ7PeMxOXqDXPvWRdTst93ufwEOA8hqd40XKVCWGJA@mail.gmail.com>
 <87y0ieqhzz.fsf@pond.sub.org>
 <CAMxuvaxryBmJ4+VL5qNv2pP3t9KoKS-jH45nY1hzvoxz-rCHXg@mail.gmail.com>
Date: Thu, 23 Apr 2026 12:57:53 +0200
Message-ID: <87zf2undu6.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Hi
>
> On Thu, Apr 23, 2026 at 10:59=E2=80=AFAM Markus Armbruster <armbru@redhat=
.com> wrote:
>>
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>>
>> > Hi
>> >
>> > On Thu, Apr 23, 2026 at 9:02=E2=80=AFAM Markus Armbruster <armbru@redh=
at.com> wrote:
>> >>
>> >> marcandre.lureau@redhat.com writes:
>> >>
>> >> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> >> >
>> >> > This commit removes the QemuConsole from the global "consoles" list=
 when
>> >> > it is finalized.
>> >> >
>> >> > Previously, there was a TODO comment indicating this path needed
>> >> > checking. The assertions added ensure that `dcls`, `gl_block`, and =
the
>> >> > `dump_queue` are empty before removal, confirming the console is in=
 a
>> >> > clean state.
>> >> >
>> >> > Fix potential use-after-free crashes when a display console is remo=
ved.
>> >> >
>> >> > Reported-by: Markus Armbruster <armbru@redhat.com>
>> >> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> >> > ---
>> >> >  ui/console.c | 5 ++++-
>> >> >  1 file changed, 4 insertions(+), 1 deletion(-)
>> >> >
>> >> > diff --git a/ui/console.c b/ui/console.c
>> >> > index f445db11389..b64e2122f34 100644
>> >> > --- a/ui/console.c
>> >> > +++ b/ui/console.c
>> >> > @@ -394,10 +394,13 @@ qemu_console_finalize(Object *obj)
>> >> >  {
>> >> >      QemuConsole *c =3D QEMU_CONSOLE(obj);
>> >> >
>> >> > -    /* TODO: check this code path, and unregister from consoles */
>> >> > +    assert(c->dcls =3D=3D 0);
>> >> > +    assert(c->gl_block =3D=3D 0);
>> >> > +    assert(qemu_co_queue_empty(&c->dump_queue));
>> >>
>> >> Help me out: what ensures this?
>> >
>> > - No display change listener left
>> > - No GL lock left
>> > - No pending screendump
>>
>> Yes, but what ensures none of these are left / pending by the time we
>> finalize?
>
> Unfortunately, we don't have much support for unplugging display
> consoles. So those asserts are mostly there to remind us of further
> issues.. I should probably leave the TODO.
>
> In general graphics devices do not support hot-plugging. It looks like
> we are missing a couple of hotpluggable =3D false in hw/display.

I trust you'll take care of them.

>                                                                So, it
> should not be reachable today but by using low-level QMP/QOM like in
> this test.

Due to QOM's design, introspection must create and destroy a temporary
object.  This must not have observable side effects.

Devices have a life cycle supporting this:

    instance_init -+-> realize ---> unrealize -+-> instance_finalize.
                   |                           |
                   +---------------------------+

We can keep instance_init and instance_finalize free of side effects by
doing them in realize and unrealize instead.

Non-device objects lack realize / unrealize.  I believe the wheel has
been reinvented a few times there.

Back to qemu_console_finalize().  I guess the correctness argument goes
roughly like this:

1. After initialization, these assertions hold.

2. Therefore, immediate finalize works.  QOM introspection works.

3. Non-immediate finalization cannot happen.

Is this about right?

> Text console/VC is also poorly supported and leaks, so it will never
> reach qemu_console_finalize() either.
>
> I can try to improve the situation by sending a more complete series,
> so those assert() are unlikely to be reachable in the future.

I'm just trying to understand why this works :)

More complete patches are always nice, but I'm not demanding you do that
now.  Comments perhaps?

>> >> >      g_clear_pointer(&c->surface, qemu_free_displaysurface);
>> >> >      g_clear_pointer(&c->gl_unblock_timer, timer_free);
>> >> >      g_clear_pointer(&c->ui_timer, timer_free);
>> >> > +    QTAILQ_REMOVE(&consoles, c, next);
>> >>
>> >> Is @consoles only accessed from the main thread?
>> >
>> > Yes, the UI code is main thread only.
>>
>> Good, thanks!
>>


