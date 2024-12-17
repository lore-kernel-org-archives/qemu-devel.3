Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB7E4E7716A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 10:33:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNUt1-0007v3-2B; Tue, 17 Dec 2024 05:33:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tNUsx-0007ut-4d
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 05:33:03 -0500
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tNUsv-0007cF-3a
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 05:33:02 -0500
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-30039432861so57749661fa.2
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 02:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734431577; x=1735036377; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=onSAWxrU0QEG1l5XIhB7bBU9G8YbVRNLKOwm7dGDcf8=;
 b=lSJRwYz2oS/nz3cV1zmAsh/ddnrteBoMdOuHMHJCTbuUbDXsgRy9hu8qpbOhQ8hEnx
 vy8sO2VWvBuG72eyWZavj9FD6XLznIofujC11VKxQY1HVjS6GET3PIPfnWzR8StLUc7m
 avH3880p9sZNNtDATp6GHkrK3zXVRpykph/K5tLd04hKkBucDU+ypXc8GG6Qa1d/osT8
 Jzbw8RFhBWRohXww04SVyke5he8JhjBSCQA2litiTDUBDPvYKj2RjA2UsCjSSt4+IbLv
 8uns3s2Y6NOHqo6e/EXbiEv8QkmuCdQwM+O+a6XnpbIOp5vMNYIlFfLumKfCj7nLGTwu
 IPAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734431577; x=1735036377;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=onSAWxrU0QEG1l5XIhB7bBU9G8YbVRNLKOwm7dGDcf8=;
 b=W8JP+/+cvMCxXKFjAV9Tt93Htc/j5lGy2kI83YS96rEAkGo0WKywqNJt4clWgRiI02
 xdntmvhS0oktOQ8reI4OmBjye+dr1RRkoV/awA9XpwFouCbopAX3rGoD6VOP4kHCwjHw
 o1kDXs4AlrWno1QNyq7eJebowt82bzz4qZp42qnAgSzPx7bdSxlFBumgn3QVvB2G3mKT
 c1xdgJbVv0QVVzLHjFv8Gio8bqpb4l50yXbAj9SY4YPWtdFs9Zzp7qVDcUNhS+Xvl7ub
 TW9cTGiMqfDYF6zD7thhDIOArxyxwVBguGUP8nRu89kzwXgEHJHIV3PEjlEGRnIhRyhb
 Fd1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXi6frY6/+yk0cNsMJQPHADhDeqpswC2wdkjbkwfc9VqioEcqJYcld1j1gnUaL30vVMMq6hlUJJ/F8w@nongnu.org
X-Gm-Message-State: AOJu0YyWo0/8tuyAsp/DZkKxzUTqQJ+yk866MbuOGNzlIM/ooRZMu0ss
 Uc/NaI3UJUqTt7YEnCvFB16IbKkXktzMfBzPmlNkbzFP1jSqmbYCP7FrAv/Tf/7TFD8zjpMnRLh
 2/7gduJk6KagOCEZmNz9yJeE95hM=
X-Gm-Gg: ASbGncs4Ftrc5jL3NS7zb0xRppT3n7MOGBByX1OSerYYaLkLTUpubU3s3/BumdQB0I3
 HXXh6bxpcrH/hjxxI13PZ7HSuXhnFCXTZj+2+pQ==
X-Google-Smtp-Source: AGHT+IE6y225mLzj/xj1E6gPCREkvrCuJKrP1oz8fDXLZuDhr3kB+RQ0BE9htyojy5I5kVhhbg6oRUfUggwMvimczCw=
X-Received: by 2002:a2e:bea8:0:b0:300:33b1:f0e0 with SMTP id
 38308e7fff4ca-30254491c43mr53109751fa.10.1734431576953; Tue, 17 Dec 2024
 02:32:56 -0800 (PST)
MIME-Version: 1.0
References: <20241016102605.459395-1-r.peniaev@gmail.com>
 <20241016102605.459395-7-r.peniaev@gmail.com>
 <CAJ+F1CLkn2WcmJEmNpJwNcc5VPriDTdSFWcv44QWaYtvHycKcQ@mail.gmail.com>
 <87frmuwo6p.fsf@pond.sub.org>
In-Reply-To: <87frmuwo6p.fsf@pond.sub.org>
From: Roman Penyaev <r.peniaev@gmail.com>
Date: Tue, 17 Dec 2024 11:32:46 +0100
Message-ID: <CACZ9PQUk7ZjwfYWVNq3z2Wp_pnkKO8ObhLc6uy5ABHq2yCL9Ag@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] chardev/char-mux: implement backend chardev
 multiplexing
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, 
 qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=r.peniaev@gmail.com; helo=mail-lj1-x22e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi Markus,

Thanks for the explicit info. But I have a lot to ask :)
Do I understand correctly that there are two ways to parse
arguments: classic, via qemu_opts_parse_noisily() and modern, via
qobject_input_visitor_new_str()? (for example, I look in
net/net.c, netdev_parse_modern()). My goal is not to create a
completely new option, but to add (extend) parameters for
chardev, namely to add a new type of backend device. This
complicates everything, since chardev uses
qemu_opts_parse_noisily() for parsing and bypasses the modern
way (I hope I'm not mistaken, maybe Marc can comment). And I'm
not sure that it's easy to replace the classic way of parsing
arguments with the modern way without breaking anything. I can,
of course, be wrong, but if I understand correctly, util/keyval.c
does not work with QemuOpts, and the entire char/* is very much
tied to this classic way of getting arguments. Is there a
transitional way to parse the arguments? Use the modern way, but
still represent the arguments as QemuOpts?

--
Roman

On Wed, Dec 11, 2024 at 10:42=E2=80=AFAM Markus Armbruster <armbru@redhat.c=
om> wrote:
>
> I'm awfully, awfully late.  My apologies!
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
>
> > Hi
> >
> > On Wed, Oct 16, 2024 at 2:29=E2=80=AFPM Roman Penyaev <r.peniaev@gmail.=
com> wrote:
> >
> >> This patch implements multiplexing capability of several backend
> >> devices, which opens up an opportunity to use a single frontend
> >> device on the guest, which can be manipulated from several
> >> backend devices.
> >>
> >> The idea of the change is trivial: keep list of backend devices
> >> (up to 4), init them on demand and forward data buffer back and
> >> forth.
> >>
> >> Patch implements another multiplexer type `mux-be`. The following
> >> is QEMU command line example:
> >>
> >>    -chardev mux-be,id=3Dmux0 \
> >>    -chardev socket,path=3D/tmp/sock,server=3Don,wait=3Doff,id=3Dsock0,=
mux-be-id=3Dmux0 \
> >>    -chardev vc,id=3Dvc0,mux-be-id=3Dmux0 \
> >>
> >
> > I am not sure about adding "mux-be-id" to all chardev. It avoids the is=
sue
> > of expressing a list of ids in mux-be though (while it may have potenti=
al
> > loop!)
> >
> > Markus, do you have a suggestion to take an array of chardev ids as a C=
LI
> > option? It looks like we could require QAPIfy -chardev from Kevin here.=
.
>
> We've developed a number of ways of array-shaped configuration bits.
> The most recent one relies on QAPI.  To not get bogged down in
> compatibility considerations, let me show a new option first.
>
> Create a QAPI type FooOptions for the option's argument, say
>
>     { 'struct': 'FooOptions',
>       'data': { 'ids': ['str'] } }
>
> Create the new option -foo, and use qobject_input_visitor_new_str() and
> visit_type_T() to parse its argument into a T.
>
> The new option now supports both JSON and dotted keys syntax for its
> argument.
>
> JSON example:
>
>     -foo '{"ids": ["eins", "zwei", "drei"]}'
>
> Same in dotted keys:
>
>     -foo ids.0=3Deins,ids.1=3Dzwei,ids.2=3Ddrei
>
> Note: dotted keys are slightly less expressive than JSON.  For instance,
> they can't do empty arrays.  Users need to fall back to JSON then.
> Peruse the big comment in util/keyval.c if you're curious.
>
> Things can get messy when QAPIfying an existing option argument.  Dotted
> keys are designed to be close to QemuOpts, but they're not identical.
> If existing usage of the option argument relies on funky QemuOpts
> features dotted keys don't replicate, we have a compatibility problem.
> For complicated arguments, we may not know whether we have a
> compatibility problem.
>
> We can sacrifice dotted key syntax to avoid compatibility problems: if
> the argument isn't JSON, fall back to the old option parsing code
> instead.  Ugly, because we then have effectively two interfaces instead
> of a single interface with a choice of syntax.
>
> Hope this still helps at least some.
>

