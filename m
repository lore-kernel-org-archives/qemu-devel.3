Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05B98FD875F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 12:39:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Ti1-0004NK-NF; Tue, 17 Mar 2026 08:39:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1w2Thz-0004Lk-NC
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 08:39:40 -0400
Received: from mail-qk1-x734.google.com ([2607:f8b0:4864:20::734])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1w2Thy-0005SF-1L
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 08:39:39 -0400
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-8cb40149037so643994385a.2
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 05:39:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773751176; cv=none;
 d=google.com; s=arc-20240605;
 b=j3kZqqm243Gs1n6GdQZAwlJZ8TPWq51L0cHtLwfZ5M++5RyEpO6EfawZz6d1iN6Fzl
 Vcnv07VVPihhJWycWCetNSU0KFOV1DgY8wVjjv5hhWwgH1h4e324SVMEcW+UtX1ykpP4
 u/bfvRLtoRRFE79Y8kJuDZOTIDzPbAj7BC6+GHQyjzoIXAZ57+1rlP4vX22H/2bAE4/l
 Ogy4G5Q8csS6wKq+0ZkU6ARb5ukn/Cjyq1plngrZU3orXgqtUpOA4qyhfWGTDx1N6wU9
 eSYFoA3P60PAVQ48pN6ocBKhKUj9BNHt83bJO5xIKd4mF6JBUS8wuMbT3VEHf+h97gF4
 Wxjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=K/nIzC6V3cbsm1fDJPTt2AfQeUSz1mO0iIiCWf+u0Qs=;
 fh=QwYyyUxj49fE3r2/5S05Hg3zHNtF3HBjcsjpjamgaAA=;
 b=ALEhWRkWNwNhM1FlNgPy8MEjAzXLANBinMN/3o35tPi+VAD36XAZztdVhP7W0uXX0G
 2mF7DfLML/5XZy76mODvaK4w0Px5Bh08Dw/VlhFVBYg6Z/BvopKH84ROiiVw1i3Kiqf1
 KpDpI2aLkL76oFQ7nc70fEVfOBxMvEl73JOC8rZy4UZGMj7xwdyU/kJlPiqXXrzPxV1F
 w2hMLpIx/PI5IYJV32OTlhoSgRoByiGBQ3g0WduUeLYUQrgr4CoTG6ahajkGA8jfV76R
 kPbtxNqztdVB+YBh0cj9gF1gN09T6vYAdzly8GOAoVQM+CTu5AJYyxgfg2pm4OWJuSuS
 k4Kg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773751176; x=1774355976; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K/nIzC6V3cbsm1fDJPTt2AfQeUSz1mO0iIiCWf+u0Qs=;
 b=Wx0oua7rZl1+Mqh3Ad7o163TrcVOwJIJUJUU6k+rXVgkbPiQGlR2THh68Rwv8dlNdj
 MiJjhkgAxmL9FNUUhC3tLlY+hdgnS4u6cP/OvgFm7yP7Yx9Hws1FWNqSHBtzhqom9Im8
 mC0C0xzUYbtoF4DWp31Iqxhq9kJh0Yn8mGiNDhI2PaFcsv9zce0mV412mk/4+rLWDl0T
 YzhQj/6+0U9lguHjMgIAtJRYeQE6nnLLgJWxwgyDnsWuZ1gYqYt1cULspOiYeVuWr2iD
 bspM+TsUKaGXdfKAwtTF9XMkOr+W2zlY8RoVidpHM7YkkMm3sJWYT5Tw4L5AdA1/swXa
 Tllg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773751176; x=1774355976;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=K/nIzC6V3cbsm1fDJPTt2AfQeUSz1mO0iIiCWf+u0Qs=;
 b=QnHXpuGfxkn+CgK0utU8D8D7TGYcA70pqAcwHL58Ja5fN7oI/4styJBf4/m/4ahtCk
 JhfkcoJCunkfVt1m3l5CIJrtYU/4HJchGrzvLMM775fN79Q1ExdRkb9N4Et8LCpQxFeu
 QPxbhjDbZLYWt5xAQjbklv8rBiK/xabCKjT4idzSVa5wtbwPUd9f8+cbG3QAml01qIaf
 DCScVOEfMSf6pwBLMQADQvYO8lDnNFDMGTM1bIpGrR8ijIE2tJKfDbHYO5zM/b7MtMMC
 bH3O9l9+xuMr71FlsA1fgFHI2BmqAlOnYBLRZPHD1Jg9Qg/Ki7QcL9GoInAZLwKi1mEa
 VKnQ==
X-Gm-Message-State: AOJu0YyLbmyMmmPGSqFr7E7AQBQNyeCtdG0raUo0JxxnqzMmI5oWNZkJ
 WlUhkcPGJSAUp5SjNcQZiWTMVJ2qUpbBavnd5+Hq2DocigtCnYGlDBKR40Oa1Lr7dwV3V5fERqq
 tRFnMaPla0hvco4J5TQ69YIpAz+I+j24=
X-Gm-Gg: ATEYQzzD3dfddvVBoduEIf2n37zYRwcOfbM9cL/40j9FNqHRvP0olC5rmM2cX/M2HSi
 n4OnYCAkBq1qYLjV6fW/b8SgmVDwF9jCLykREcY+yVL2p7YZgmL0dYj7n5I6mV8tl+YvaoB2x3U
 O3GqyveG1Tpom5O1XJ0xDI5cacpXu0B/hh24tmRsR8fnb7Y49w3W1pqIsFJoAPj03xato5HmdyX
 csnb3rvq9jf4RDcpO3zZ3T1PW6qIgBT3gc/5i2JLm3Y8bToVuRoOsYOGONHFmZe44RwzHLqNNap
 7AO8tg6o
X-Received: by 2002:a05:620a:710c:b0:8cb:3a1d:79f2 with SMTP id
 af79cd13be357-8cdb5b71480mr2154367685a.71.1773751176264; Tue, 17 Mar 2026
 05:39:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
 <20260317-qemu-vnc-v1-58-48eb1dcf7b76@redhat.com> <87ms06r668.fsf@suse.de>
In-Reply-To: <87ms06r668.fsf@suse.de>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 17 Mar 2026 16:39:24 +0400
X-Gm-Features: AaiRm51hsCEk12FCKx3AEXkc9lo8YtfUAkLko2lf63Dj-6IE5jzeibMLu00Yb3w
Message-ID: <CAJ+F1CKwizBkU7TRXGWcDj9d7qEOaxjD5=13Jp-+y7M+50tQSQ@mail.gmail.com>
Subject: Re: [PATCH 58/60] tests/qtest: fix dbus-vmstate-test compilation
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::734;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qk1-x734.google.com
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

Hi

On Tue, Mar 17, 2026 at 4:29=E2=80=AFPM Fabiano Rosas <farosas@suse.de> wro=
te:
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > The test is still disabled, and trying to compile it will fail now.
> >
> > Fix it, and remove the G_TEST_DBUS_DAEMON setting, since it is passed b=
y
> > meson test. Fwiw, the test passes here.
> >
>
> Hi, I have a series re-enabling this test and doing a few fixes, take a
> look whether it helps you. I'm a bit short on time right now, but I
> could rebase and post it after the freeze.
>
> https://gitlab.com/farosas/qemu/-/commits/migration-test-dbus-vmstate?ref=
_type=3Dheads

Ok, let's get your series merged first. This can indeed wait for the
freeze period, but feel free to send it and ping me!

thanks

>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  tests/qtest/dbus-vmstate-test.c | 11 ++---------
> >  tests/qtest/meson.build         |  3 ++-
> >  2 files changed, 4 insertions(+), 10 deletions(-)
> >
> > diff --git a/tests/qtest/dbus-vmstate-test.c b/tests/qtest/dbus-vmstate=
-test.c
> > index 6c990864e3e..ed4a52d0255 100644
> > --- a/tests/qtest/dbus-vmstate-test.c
> > +++ b/tests/qtest/dbus-vmstate-test.c
> > @@ -3,7 +3,7 @@
> >  #include <gio/gio.h>
>
> I remember some CI job failed due to the test not declaring this
> dependency.
>
> >  #include "libqtest.h"
> >  #include "dbus-vmstate1.h"
> > -#include "migration-helpers.h"
> > +#include "migration/migration-qmp.h"
> >
> >  static char *workdir;
> >
> > @@ -229,7 +229,7 @@ test_dbus_vmstate(Test *test)
> >
> >      thread =3D g_thread_new("dbus-vmstate-thread", dbus_vmstate_thread=
, loop);
> >
> > -    migrate_qmp(src_qemu, uri, "{}");
> > +    migrate_qmp(src_qemu, dst_qemu, uri, NULL, "{}");
>
> This works, however I have patches queued for the hardfreeze that change
> some details in the migration tests infra:
>
> - dst cmdline should use -incoming defer
> - migrate_incoming_qmp needs to be called
> - no more setting: qtest_set_expected_status(dst_qemu, EXIT_FAILURE);
>
> >      test->src_qemu =3D src_qemu;
> >      if (test->migrate_fail) {
> >          wait_for_migration_fail(src_qemu, true);
> > @@ -342,15 +342,8 @@ int
> >  main(int argc, char **argv)
> >  {
> >      GError *err =3D NULL;
> > -    g_autofree char *dbus_daemon =3D NULL;
> >      int ret;
> >
> > -    dbus_daemon =3D g_build_filename(G_STRINGIFY(SRCDIR),
> > -                                   "tests",
> > -                                   "dbus-vmstate-daemon.sh",
> > -                                   NULL);
> > -    g_setenv("G_TEST_DBUS_DAEMON", dbus_daemon, true);
> > -
> >      g_test_init(&argc, &argv, NULL);
> >
> >      workdir =3D g_dir_make_tmp("dbus-vmstate-test-XXXXXX", &err);
> > diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> > index b735f55fc40..5f8cff172c8 100644
> > --- a/tests/qtest/meson.build
> > +++ b/tests/qtest/meson.build
> > @@ -130,7 +130,8 @@ if dbus_daemon.found() and gdbus_codegen.found()
> >                                  input: meson.project_source_root() / '=
backends/dbus-vmstate1.xml',
> >                                  command: [gdbus_codegen, '@INPUT@',
> >                                            '--interface-prefix', 'org.q=
emu',
> > -                                          '--generate-c-code', '@BASEN=
AME@']).to_list()
> > +                                          '--generate-c-code', '@BASEN=
AME@',
> > +                                          '--output-directory', meson.=
current_build_dir()]).to_list()
> >  else
> >    dbus_vmstate1 =3D []
> >  endif
>


--=20
Marc-Andr=C3=A9 Lureau

