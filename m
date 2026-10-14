Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6767ACC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 06:11:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGsCR-0001pM-Un; Wed, 14 Oct 2026 02:10:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xGsCG-0001oY-Oo
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 02:10:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xGsCE-0005wa-NH
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 02:10:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791958237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8lBC5q7bkzOduP8N/IFRMaMdStqVLliWubMHIJ+B8WU=;
 b=igpYqNAP5AAjeqUXYRgqk+Y3kdlte4ouogHHNcmVokB3MSy9i+J2cgar+vlPSFvZpLXfs7
 DPnlZTfm8JXvbgnoEuhD19kRLaUXojsPcsQN3ravrB57N32BL0X2jgMrae8UEXwF7f5H9R
 ImgZ+YZ3iYu8ii7P12vNIo3bp63L5BA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-194-2k8DjijROLGLg0fKbCYVGg-1; Wed,
 14 Oct 2026 06:10:33 +0000
X-MC-Unique: 2k8DjijROLGLg0fKbCYVGg-1
X-Mimecast-MFC-AGG-ID: 2k8DjijROLGLg0fKbCYVGg_1791958232
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8D739180034C; Wed, 14 Oct 2026 06:10:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 31D3D300019F; Wed, 14 Oct 2026 06:10:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 92F8E21E6A04; Wed, 14 Oct 2026 08:10:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,  michael.roth@amd.com,  jsnow@redhat.com
Subject: Re: [RFC PATCH 0/6] qapi: Preliminary work for better QOM
 introspection
In-Reply-To: <CAMxuvaxyrOtn5uXuWSuRL4KUTyAVZFAinniG-YZQfo4_ngizrA@mail.gmail.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 13 Oct 2026
 19:20:52 +0400")
References: <20261009140431.3175479-1-armbru@redhat.com>
 <CAJ+F1CKqDbV0xVkL6Q_++qHk4iNstWC_y2raPXy8BovUyPQzdQ@mail.gmail.com>
 <871p9tya83.fsf@pond.sub.org>
 <CAMxuvaxyrOtn5uXuWSuRL4KUTyAVZFAinniG-YZQfo4_ngizrA@mail.gmail.com>
Date: Wed, 14 Oct 2026 08:10:29 +0200
Message-ID: <87o6cwu816.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
> On Tue, Oct 13, 2026 at 5:57=E2=80=AFPM Markus Armbruster <armbru@redhat.=
com> wrote:
>>
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>>
>> > Hi Markus
>> >
>> > On Fri, Oct 9, 2026 at 6:05=E2=80=AFPM Markus Armbruster <armbru@redha=
t.com> wrote:
>> >>
>> >> Marc-Andr=C3=A9 Lureau has patches to improve QOM introspection.  Lat=
est
>> >> version is
>> >>
>> >>     Subject: [PATCH v5 00/62] qom/qdev: associate properties with QAP=
I schema types
>> >>     Date: Fri, 11 Sep 2026 20:34:34 +0400
>> >>     Message-Id: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
>> >>     https://lore.kernel.org/qemu-devel/20260911-qom-qapi-v5-0-7732a55=
b7760@redhat.com/
>> >>
>> >> The first few patches make the QAPI code generator emit type
>> >> information for use by QOM introspection commands.  They refactor code
>> >> to gain access to masked type names, and to make query-qmp-schema not
>> >> elide types QOM introspection might want to refer to.
>> >>
>> >> My series does this in a different way I find simpler.  It is RFC
>> >> because merging it only makes sense if Marc-Andr=C3=A9 finds it usefu=
l.
>> >> Marc-Andr=C3=A9, please have a look.
>> >
>> > This is essentially doing the same introspection changes but at a
>> > different level. If you ask me, since it's essentially code cleanup at
>> > this point, I would rather merge my changes first and iterate on top.
>> > But you are the gate keeper, so I wouldn't hold it, we need to move
>> > on... I can rebase on top of your refactoring if you prefer.
>>
>> A rebase gives me a cleaner git history, which I like.  Asking you to do
>> it feels a bit unfair, so I did it:
>>
>>     https://repo.or.cz/qemu/armbru.git/shortlog/refs/heads/qom-props-qap=
i-types-v5-rebased
>
> Awesome, I am happy with that! If you want to resubmit on ML or send
> PR, up to you

Great!

I'd like to have a closer look at a few more patches.  They look
harmless at a glance.

> I think the only local change I had (with the collected review
> trailers), was BootCertificatesList conversion. But that can be a
> follow up.

Happy to squash it in, feel free to send me a delta, a revised patch, or
something to git-fetch.

There's also a temporary test breakage in PATCH 15.  Could you have a
look?

[...]


