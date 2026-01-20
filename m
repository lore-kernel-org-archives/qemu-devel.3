Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9360ECA5FB7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 17:27:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viFVf-0004Dq-Qi; Tue, 20 Jan 2026 12:27:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1viFVe-0004Cm-35
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 12:27:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1viFVc-0003gp-Ee
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 12:27:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768930035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OcQiv4lops/ZOpkEMgCqQpkHXCyLg9K6MmaOo2hr3Fg=;
 b=L03BCmLmo0lKhwQi9ti7S0yadPGy62PLJS27PX9oH+KUB8UhZhgoK+cVsWFaXjBGrMvzx4
 +LO9EV8GsbsfL91yAGnRVGHxGT7+lWiplqxkWRCVXtZvDdr9VEnFcdNUU7C/TO9QDod5AV
 0UnTYNiSk+7PJ5WWQhitJV/DyCKo8cI=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-KJRKanOnMKu1za_dkdm2aQ-1; Tue, 20 Jan 2026 12:27:14 -0500
X-MC-Unique: KJRKanOnMKu1za_dkdm2aQ-1
X-Mimecast-MFC-AGG-ID: KJRKanOnMKu1za_dkdm2aQ_1768930034
Received: by mail-yx1-f72.google.com with SMTP id
 956f58d0204a3-647119b06a3so7716858d50.2
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 09:27:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768930034; cv=none;
 d=google.com; s=arc-20240605;
 b=LYN7/EPaZrU/+ntcv3Zpt8nt52eJj9/X8JFxggxGiInI5iBvEgajq+IpYLESitCcg7
 Wu3pVCuK7313bsl1jcy40Cs2BiZyFmqlb7TZWcBT8aBN9hEgs+sVt6MWuY1fAIDD3nUd
 Uq6TBBri59ytRh9UjSw4vlLmScCN7qswDq5/P283XoKo3MtjnmiFYa0Bq89OXfSFx63E
 dnWcrKwQWZTNIOosTCckEpJGJfFUgGClZKUjIo834YzXQL8mQ4pLhbRMFMUgBuaIo9QQ
 sD02wlF1CQCR4fK2wyLyY87J/47Uz8z0WKGTRCE4CzOH6PbOvf8nQVI+0XiLGyK8MNqG
 ixYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=OcQiv4lops/ZOpkEMgCqQpkHXCyLg9K6MmaOo2hr3Fg=;
 fh=ABFaPHFUGftIDeuiwfhdCvWwlDIqwEOXtW9ZV6M/MzU=;
 b=UjOGGv3xLpFim96Eq1GwgoXhnx0rKcg7lmln8aPRbf7/tIRIFYsAKZSKEFMMCmwu9d
 YJr7UvWU9EPc559LCj/pCi/G/fAPum9v95FOHyCBFvvlJ2xbwRqCL4nxsJJmyz7fEXaS
 ZA9basm+xzxLAtoVw2XAOqWMMvB794vvAFZWbGpSYhpVlDd8ziKtmK/Hw79DvbKOc5rP
 wi+o61NbwygV6kRdivatKxXp6fkvLxgFL6D/3AZ2LDT+bEHmpXyYWGSx0niaIloyc2LI
 wTH1SpRFWX3pbHSyyP+l+Um3GttX5xtnYf5DX5K8+JonXa0RyG8csOT+5VqOPuy/MlXk
 G+jw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768930034; x=1769534834; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OcQiv4lops/ZOpkEMgCqQpkHXCyLg9K6MmaOo2hr3Fg=;
 b=ZWFZ2jGZR5cK4nnt+aMknscy6xGV+si5VXv3GEzNOEodSLW7X7N3hITbNboX/5qOo0
 ADJGR6L4CKfxwYF37c9XmvetsFyohWh9AoNKpfgyYBM66K0ZLB6rZJxF4hW8OWsdtWX2
 ITDQvB9B5wjsJ6X0iYvOaelgv3NdCNDcTi3OtQTvT9fz0bPbOA9q8ZAEl/v5KH9fuc/y
 VaJoA2yDJxXKQFieuWrYcVSZ74U4Wu+sDO+KhyL/Ch6+UUYhzmmrURSdCA3UXw71R+dj
 CawM5gVjMAW/5jt3WmFik0rQO9eqS2Fltz3KpezQDjSAB2j79ClAWBUvlSlkFzdeg4M2
 O4NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768930034; x=1769534834;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OcQiv4lops/ZOpkEMgCqQpkHXCyLg9K6MmaOo2hr3Fg=;
 b=qYuUjadOskYhri5E5eEAGxwqyw1bf2qYcqCMHMWw2fS/qXd58oYZ08OJJHeRpAzx6P
 IK87Qc5FMDFvvt/Je2zE8wmN9lL6uOPq5hZF4t5f11ol6edLx/r+F+lT5S3B/5km5jO1
 mTtneHIJF6CrURu5TBcFm8JKeVklsZjJ0iTfVXG5OHjjc3c0bE9crLMCOfeWuvxcVnhZ
 Y/FuEoX98iNbkSuw9vd+vcjynGxW3evS75NvBTWZEo7yNO6Kyvx45h4xRY+yvZxpoP/Z
 H/9VaIUg4No6xglDtOfeNAdJZwMLwP/7nu2EtxPjs7BLD28/hl/HuF/64hPvT1xV+nT9
 GAPQ==
X-Gm-Message-State: AOJu0YxtCeyvgKJdnLO5D3hP/sMBQ6oJB/tIfAUcf4t2gdRUxUAsLkC3
 TWOnPkDf60bt20SBM8Y15bUNPfPc8z/MjJMh7iYNOCJGMlpD2pPX1+Vy7P7owxT63B/h07K+eZV
 1z+VYsqAfHw0JcOtdaqm2E92QaLamsjnSJ0uFSy1WiE8JCXWusTbThVYY6AxTeenXjZuejD0Jk/
 4UG3+NuBAE4CV3zmbPU+Wk3dUfnIEsmk8=
X-Gm-Gg: AZuq6aKR1lbMGIydLq1uq5Y7EhrRa/ABKq09sEKg2RMNGEMLKAFFbtCHTDGjxgcfT4T
 5gL8j1pZnoWMzkEHe1kAKSUts0TIu7exzSQWXM5EqOa8EYOIbwWT6eJBf4zqoWmF/Z4dWa3xbrh
 fQjHJ1ArVUytd7eTi1WL5ssgoPSEd7ttqEnMazPyaCUoESx0kcCGEBNudxrGpdBcjNKaLc1vyn7
 BuMwU6LWv5TDvbCLHDmemUCiQ==
X-Received: by 2002:a05:690e:1289:b0:649:3b50:f54f with SMTP id
 956f58d0204a3-6493b50f6f1mr2570927d50.72.1768930033546; 
 Tue, 20 Jan 2026 09:27:13 -0800 (PST)
X-Received: by 2002:a05:690e:1289:b0:649:3b50:f54f with SMTP id
 956f58d0204a3-6493b50f6f1mr2570869d50.72.1768930032844; Tue, 20 Jan 2026
 09:27:12 -0800 (PST)
MIME-Version: 1.0
References: <20260119212744.1275455-1-jsnow@redhat.com>
 <20260119212744.1275455-6-jsnow@redhat.com>
 <aW9CkQul663wzsVd@redhat.com>
In-Reply-To: <aW9CkQul663wzsVd@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 20 Jan 2026 12:27:01 -0500
X-Gm-Features: AZwV_QhJuOxcLbfYF1R9fGqLeQI2MVcxd6N8IBtTkt7WRVSx9J-zcW9vX-oeOz0
Message-ID: <CAFn=p-bJ9utH13oKfxp3YFiQ0n3CPaY7dzA84gna-DG-SJK+Ow@mail.gmail.com>
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

On Tue, Jan 20, 2026 at 3:53=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Mon, Jan 19, 2026 at 04:27:31PM -0500, John Snow wrote:
> > add the "pyvenv_functests_group" target to meson. This target will
> > invoke mkvenv.py to install the associated dependency group to the
> > build/pyvenv directory.
> >
> > A "pyvenv_tooling_group" is not included here as it is the plan to
> > always install this group by default, so it will not need an on-demand
> > trigger.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  meson.build        |  1 +
> >  pyvenv/meson.build | 28 ++++++++++++++++++++++++++++
> >  2 files changed, 29 insertions(+)
> >  create mode 100644 pyvenv/meson.build
> >
> > diff --git a/meson.build b/meson.build
> > index 3108f01e887..245f1bc2ec9 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -4551,6 +4551,7 @@ subdir('scripts')
> >  subdir('tools')
> >  subdir('pc-bios')
> >  subdir('docs')
> > +subdir('pyvenv')
> >  # Tests are disabled on emscripten because they rely on host features =
that aren't
> >  # supported by emscripten (e.g. fork and unix socket).
> >  if host_os !=3D 'emscripten'
> > diff --git a/pyvenv/meson.build b/pyvenv/meson.build
> > new file mode 100644
> > index 00000000000..2bfddeb4a52
> > --- /dev/null
> > +++ b/pyvenv/meson.build
> > @@ -0,0 +1,28 @@
> > +# Note that this file only controls "optional" dependency groups; grou=
ps
> > +# *required* for the build are handled directly in configure instead:
> > +# namely, meson and sphinx.
> > +
> > +# NB: This command may or may not include the "--online" flag, dependi=
ng
> > +# on the results of configure.
> > +ensuregroup_cmd =3D config_host['MKVENV_ENSUREGROUP'].split()
>
> I'm confused because this implies that "ensuregroup_cmd" use of the
> --online flag is supposed to be controlled by configure
>
>
> > +
> > +pyvenv_common_deps =3D files(
> > +    meson.project_source_root() + '/pythondeps.toml',
> > +    meson.project_source_root() + '/python/scripts/mkvenv.py'
> > +)
> > +pyvenv_wheel_dir =3D meson.project_source_root() + '/python/wheels'
> > +
> > +
> > +# This group is allowed to rely on internet, to fetch from PyPI.
> > +# If --online was not passed to configure, this could fail.
>
> ...and this also suggests --online is supposed to be controlled
> by configure, but...
>
> > +pyvenv_functests_group =3D custom_target(
> > +    'pyvenv_functests_group',
> > +    output: 'functests.group',
> > +    input: pyvenv_common_deps,
> > +    command: ensuregroup_cmd + [
> > +        '--online',
>
> now we just go ahead and hardcode use of --online regardless.

Whoops, leftover from when I had both groups. What is now the tooling
group used to obey the flags, and I garbled the comments. My gut tells
me that we should force --online here, and if it fails because we're
actually in an isolated environment, then so be it.

On the other hand, if we were configured offline, the error message
you get from mkvenv might be better.

Do you have an opinion?


>
> > +        '--dir', pyvenv_wheel_dir,
> > +        '@INPUT0@',
> > +        'functests',
> > +    ],
> > +)
> > --
> > 2.52.0
> >
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


