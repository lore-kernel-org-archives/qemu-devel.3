Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E55CA5FB8
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 17:39:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viFgP-0003hH-35; Tue, 20 Jan 2026 12:38:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1viFgG-0003bn-CK
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 12:38:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1viFgE-0004tc-Hs
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 12:38:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768930693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l3QVUzz2HFfDGbd2p0l9VSyDygOkr+/Yh7SK4SY5Tfw=;
 b=dl/cdgPEl/4wl0ikT7acuXW/Ux1jm2+bbAr+emotBxw0t/+VjEERMd1b2BEVZLsAV5niD1
 us0gJSyB4EcTdtXY1AqVZbDR/mneqpMKF3SV+5WXo5tOGHny7CKRNgKm3mDK6NTumBsWRz
 FoieKg8Zwgsk8IjI70rjjGRuLlYzjd4=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-0OygHXcZMK-Rp3UIupfCxg-1; Tue, 20 Jan 2026 12:38:11 -0500
X-MC-Unique: 0OygHXcZMK-Rp3UIupfCxg-1
X-Mimecast-MFC-AGG-ID: 0OygHXcZMK-Rp3UIupfCxg_1768930691
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-6467b002cfeso9031159d50.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 09:38:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768930691; cv=none;
 d=google.com; s=arc-20240605;
 b=bXrQc18z/TUewdRJmyIMJ4aKE29cRS0pQjHFsWWlHQ/HVJDj0Epo1BUe4UsUWWecPB
 vWp/wJPs1dLUmcQBnrRA73x/rrWCgp17ERcvY63oltyjTRcA6WVFdOM5QSkyMoTAFDGe
 tklBc9UFMg8xYDU/Xsw9gPqNcefi/d1zFa2AmA9c6zefy1mxJNhTxNo6KfmeEh4igYRU
 Y9F5ZqFeyVnUHEx66GrpcljDexX/r1lVUJOOzCZnCNnMm8O4UdOwMez/BEvSdaeFXfIe
 dTzGAuOzQtoZB3s3nrzMAe8gMmJwn9PYzE8KCDHphrwdfo2wRjwyTL2EwvqnSHSuPSC7
 MjNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=l3QVUzz2HFfDGbd2p0l9VSyDygOkr+/Yh7SK4SY5Tfw=;
 fh=ABFaPHFUGftIDeuiwfhdCvWwlDIqwEOXtW9ZV6M/MzU=;
 b=P0w+16xNP5y5AechP26Ha8gky1JqWv7X9SxB6USUvr+LUNvYyTWVPMzMWXddz+T2uD
 0JAsEfm4vP9L4BGKhwMBzFEXs1u9HibiEnUoCqSY8RBGAgdWNeDYFEfSz0GKKltHachg
 ezoLLn6TcSWjTKrXxkVXj2eR/H+IKIj4GICeGJq9rR8SL/02WV+i3K9/4TPz/w1ERcS3
 T814OuuRjDrIouwdWNOF4FWqvxdwdXRkQZ1gntfb2KWog0/UPwQvPwlr5EWtxWCMETPa
 elB+K/9WVMrzjmWBbFud3d5hVgEx0fJl2oCcrgiIPevZqjFkq7Z3UfROB1gHOK4OS5ht
 KG/w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768930691; x=1769535491; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l3QVUzz2HFfDGbd2p0l9VSyDygOkr+/Yh7SK4SY5Tfw=;
 b=e29OZNgTDGmZHgqys1Elldobl8nic1f+R+qCvt/slJFqDaduDWqHaaRqcaTGU7aoHo
 WhrC2tGfKdi4U+3tJmG4itzN2edUh8xb8Nbssmc3ImP1hQoJ6G9Wwc+EC+BBTy9XqzfQ
 DvWF0wPBFkWga3fkFTFMpty5+9zIVBr2ubCgAvR/BT0XPVXRMUrQ2lnRgDteXWVZ9Y71
 dX5F2evqKQND9t7uvP573cAIiMBkLpO3FoI74pYgno4f/70cU31DttomuajOyb8iqd7r
 GokSthSfJB639jbmkI3jLcEoTNblTjytp1KPGiH7Fd1keFUdaNtruDW0AJVmq3uk9z7D
 50Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768930691; x=1769535491;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l3QVUzz2HFfDGbd2p0l9VSyDygOkr+/Yh7SK4SY5Tfw=;
 b=q56rKfgLLQ4Hfj84La0FSya+USbW7vokhauekD1rokP3Y9CxddYrhs7Cz/sLOWZqNp
 COp02JFO1bWadCm9r7TRXtSKJgMQhedsN55ajK+tESFcrpCllZ+rry0qGgqLKhiXikYf
 eaxxC9ZGPwv1z43gqmKSY6iEoKWTko2JL0JGEzotLpAWyTQMwMPTDzFjrWMQd7QD6ftw
 Jv/pbElkwoWl8abNMhruRkxX20FsAZe87loiv5LFCAF9E7eXswHuD8ZlC+CkqI30utJR
 B3pCRwpdRESv8cVmxiizr5e8DZ5OoM8U7/YSJ6pegLOJdetsr+HhlXI7wuUzHbvwkv/B
 DHCw==
X-Gm-Message-State: AOJu0YxDxCuzbxa2PLq516mUxL800NHoOSt0RSV0O6JoPTmIi2y+ik79
 /zMtMGhbXNd8y2bPzeMZP+tEIAhcF8+K7ki6AUMlFFrxSDOVxxy6SWMDBnHbsMdT+tvNSRoErQx
 uFHTR1hYoq8X2B7jQo2Xq7F0MrJfjfr+2NPiLTtX6QM03IlPwifupaLOAvEvFUvm/zX/90VSQCc
 BHMu7Mxoyv+R9SQZjbd6wcDnql7gcwlcw=
X-Gm-Gg: AZuq6aI/0F86S3ERyCEx1fnnN906hwYlFA5levN3kkt9nVXtZJaxtLpoY1Ld0tYrzyC
 IcXI0SRqGVZXZ/fDCmTdxacXJFasoB6JEnstSxwS9gEzpJbmkqVATvJp8Fx6P3ad+dv22C04Wxl
 45/+xaLOckdyDsUd9f1vQah4JCWY6tGXia5i76PTTqNtIdCYP9XUr+aO+Q/32hDcpkq6By/T/sA
 XKxvxvaLR8Y4AL/3BjcG4xyTQ==
X-Received: by 2002:a05:690e:1447:b0:63e:30d0:61a0 with SMTP id
 956f58d0204a3-6493c7f3aa7mr1885797d50.26.1768930690740; 
 Tue, 20 Jan 2026 09:38:10 -0800 (PST)
X-Received: by 2002:a05:690e:1447:b0:63e:30d0:61a0 with SMTP id
 956f58d0204a3-6493c7f3aa7mr1885764d50.26.1768930690228; Tue, 20 Jan 2026
 09:38:10 -0800 (PST)
MIME-Version: 1.0
References: <20260119212744.1275455-1-jsnow@redhat.com>
 <20260119212744.1275455-6-jsnow@redhat.com>
 <aW9CkQul663wzsVd@redhat.com>
 <CAFn=p-bJ9utH13oKfxp3YFiQ0n3CPaY7dzA84gna-DG-SJK+Ow@mail.gmail.com>
 <aW-8aQPNysI45mYD@redhat.com>
In-Reply-To: <aW-8aQPNysI45mYD@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 20 Jan 2026 12:37:59 -0500
X-Gm-Features: AZwV_QhedPCz1enj3HjCmCZrIPuBZaOIwlIht5FX8etTlJ2U6aht7Wkg3lffrfI
Message-ID: <CAFn=p-ZY2o5Dg+6NzuUp6==H-KYu+s=sE1DVh+PSBxh3bnfW9A@mail.gmail.com>
Subject: Re: [PATCH v4 05/17] meson, mkvenv: add functests custom target
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, 
 Maksim Davydov <davydov-max@yandex-team.ru>, Li-Wen Hsu <lwhsu@freebsd.org>, 
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Hanna Reitz <hreitz@redhat.com>, 
 Cleber Rosa <crosa@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Yonggang Luo <luoyonggang@gmail.com>, Ed Maste <emaste@freebsd.org>,
 Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.087,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Jan 20, 2026 at 12:33=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com> wrote:
>
> On Tue, Jan 20, 2026 at 12:27:01PM -0500, John Snow wrote:
> > On Tue, Jan 20, 2026 at 3:53=E2=80=AFAM Daniel P. Berrang=C3=A9 <berran=
ge@redhat.com> wrote:
> > >
> > > On Mon, Jan 19, 2026 at 04:27:31PM -0500, John Snow wrote:
> > > > add the "pyvenv_functests_group" target to meson. This target will
> > > > invoke mkvenv.py to install the associated dependency group to the
> > > > build/pyvenv directory.
> > > >
> > > > A "pyvenv_tooling_group" is not included here as it is the plan to
> > > > always install this group by default, so it will not need an on-dem=
and
> > > > trigger.
> > > >
> > > > Signed-off-by: John Snow <jsnow@redhat.com>
> > > > ---
> > > >  meson.build        |  1 +
> > > >  pyvenv/meson.build | 28 ++++++++++++++++++++++++++++
> > > >  2 files changed, 29 insertions(+)
> > > >  create mode 100644 pyvenv/meson.build
> > > >
> > > > diff --git a/meson.build b/meson.build
> > > > index 3108f01e887..245f1bc2ec9 100644
> > > > --- a/meson.build
> > > > +++ b/meson.build
> > > > @@ -4551,6 +4551,7 @@ subdir('scripts')
> > > >  subdir('tools')
> > > >  subdir('pc-bios')
> > > >  subdir('docs')
> > > > +subdir('pyvenv')
> > > >  # Tests are disabled on emscripten because they rely on host featu=
res that aren't
> > > >  # supported by emscripten (e.g. fork and unix socket).
> > > >  if host_os !=3D 'emscripten'
> > > > diff --git a/pyvenv/meson.build b/pyvenv/meson.build
> > > > new file mode 100644
> > > > index 00000000000..2bfddeb4a52
> > > > --- /dev/null
> > > > +++ b/pyvenv/meson.build
> > > > @@ -0,0 +1,28 @@
> > > > +# Note that this file only controls "optional" dependency groups; =
groups
> > > > +# *required* for the build are handled directly in configure inste=
ad:
> > > > +# namely, meson and sphinx.
> > > > +
> > > > +# NB: This command may or may not include the "--online" flag, dep=
ending
> > > > +# on the results of configure.
> > > > +ensuregroup_cmd =3D config_host['MKVENV_ENSUREGROUP'].split()
> > >
> > > I'm confused because this implies that "ensuregroup_cmd" use of the
> > > --online flag is supposed to be controlled by configure
> > >
> > >
> > > > +
> > > > +pyvenv_common_deps =3D files(
> > > > +    meson.project_source_root() + '/pythondeps.toml',
> > > > +    meson.project_source_root() + '/python/scripts/mkvenv.py'
> > > > +)
> > > > +pyvenv_wheel_dir =3D meson.project_source_root() + '/python/wheels=
'
> > > > +
> > > > +
> > > > +# This group is allowed to rely on internet, to fetch from PyPI.
> > > > +# If --online was not passed to configure, this could fail.
> > >
> > > ...and this also suggests --online is supposed to be controlled
> > > by configure, but...
> > >
> > > > +pyvenv_functests_group =3D custom_target(
> > > > +    'pyvenv_functests_group',
> > > > +    output: 'functests.group',
> > > > +    input: pyvenv_common_deps,
> > > > +    command: ensuregroup_cmd + [
> > > > +        '--online',
> > >
> > > now we just go ahead and hardcode use of --online regardless.
> >
> > Whoops, leftover from when I had both groups. What is now the tooling
> > group used to obey the flags, and I garbled the comments. My gut tells
> > me that we should force --online here, and if it fails because we're
> > actually in an isolated environment, then so be it.
> >
> > On the other hand, if we were configured offline, the error message
> > you get from mkvenv might be better.
> >
> > Do you have an opinion?
>
> IIUC, the later patch only adds pyvenv_functests_group to the thorough
> functional tests, NOT the quick tests.  Given that the thorough tests
> mandated online access to download assets, it feels reasonable to also
> hardcode --online here for their code prereqs.

Works for me; will fix my mumbled comments.

>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>


