Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CB27FAD41B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 07:00:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFo2T-00023N-8E; Thu, 23 Apr 2026 02:59:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wFo2R-00023F-OF
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 02:59:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wFo2Q-0004Uk-2q
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 02:59:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776927589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WjayMlzyyOPL+OzR+Il2LwgLIx42+tBl/fWFCT7rBRc=;
 b=SETNKBpU3Jz2petZBci2uJ3nHvsbamrzgaklRY1WKc5rsExSxIqmHzpqWZLD3qUCFN0FPb
 EAT9LrAsJGzSJUQZGaj1veLxrK27LQPq6rj+cvkdP4/npYknI6girzVjDHdswg4S1YnDkg
 z50+mE/EtbpY+zPFoltz+1eMvd0P2QE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-64-Z-OF3t5aMs6Qu6mwqh_wiw-1; Thu,
 23 Apr 2026 02:59:47 -0400
X-MC-Unique: Z-OF3t5aMs6Qu6mwqh_wiw-1
X-Mimecast-MFC-AGG-ID: Z-OF3t5aMs6Qu6mwqh_wiw_1776927587
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E91E2180034D
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 06:59:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.30])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A8AB51943295
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 06:59:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2012321E6A28; Thu, 23 Apr 2026 08:59:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] ui/console: remove console from global list on
 finalization
In-Reply-To: <CAMxuvaxCkJ7PeMxOXqDXPvWRdTst93ufwEOA8hqd40XKVCWGJA@mail.gmail.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Thu, 23 Apr 2026
 10:28:00 +0400")
References: <20260422202646.272081-1-marcandre.lureau@redhat.com>
 <87v7dis20c.fsf@pond.sub.org>
 <CAMxuvaxCkJ7PeMxOXqDXPvWRdTst93ufwEOA8hqd40XKVCWGJA@mail.gmail.com>
Date: Thu, 23 Apr 2026 08:59:44 +0200
Message-ID: <87y0ieqhzz.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
> On Thu, Apr 23, 2026 at 9:02=E2=80=AFAM Markus Armbruster <armbru@redhat.=
com> wrote:
>>
>> marcandre.lureau@redhat.com writes:
>>
>> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> >
>> > This commit removes the QemuConsole from the global "consoles" list wh=
en
>> > it is finalized.
>> >
>> > Previously, there was a TODO comment indicating this path needed
>> > checking. The assertions added ensure that `dcls`, `gl_block`, and the
>> > `dump_queue` are empty before removal, confirming the console is in a
>> > clean state.
>> >
>> > Fix potential use-after-free crashes when a display console is removed.
>> >
>> > Reported-by: Markus Armbruster <armbru@redhat.com>
>> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> > ---
>> >  ui/console.c | 5 ++++-
>> >  1 file changed, 4 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/ui/console.c b/ui/console.c
>> > index f445db11389..b64e2122f34 100644
>> > --- a/ui/console.c
>> > +++ b/ui/console.c
>> > @@ -394,10 +394,13 @@ qemu_console_finalize(Object *obj)
>> >  {
>> >      QemuConsole *c =3D QEMU_CONSOLE(obj);
>> >
>> > -    /* TODO: check this code path, and unregister from consoles */
>> > +    assert(c->dcls =3D=3D 0);
>> > +    assert(c->gl_block =3D=3D 0);
>> > +    assert(qemu_co_queue_empty(&c->dump_queue));
>>
>> Help me out: what ensures this?
>
> - No display change listener left
> - No GL lock left
> - No pending screendump

Yes, but what ensures none of these are left / pending by the time we
finalize?

>> >      g_clear_pointer(&c->surface, qemu_free_displaysurface);
>> >      g_clear_pointer(&c->gl_unblock_timer, timer_free);
>> >      g_clear_pointer(&c->ui_timer, timer_free);
>> > +    QTAILQ_REMOVE(&consoles, c, next);
>>
>> Is @consoles only accessed from the main thread?
>
> Yes, the UI code is main thread only.

Good, thanks!


