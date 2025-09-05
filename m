Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3624BCA1010
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 15:03:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuXx5-0003A1-23; Fri, 05 Sep 2025 11:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pefoley@google.com>)
 id 1uuXwk-0002yQ-IX
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 11:01:54 -0400
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pefoley@google.com>)
 id 1uuXwd-0003zt-AG
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 11:01:49 -0400
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-30ccea94438so1753123fac.2
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 08:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1757084497; x=1757689297; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Mti9ybuYu6wnXzRdmv1TH1+iTc4pPej5u/3yVdQR0FE=;
 b=zJduDG/ZZSq6UKkJnmpZOuQ/8GAfjkpIplBVDvkHhaxtQuQhrtydIMN3mO18ruNxfB
 zprC7EmSM6x13Nb6ExNkNT6BNXMQI+SP6yriOnUJZw87M9GGdCThX0uycXk+M4RT/R9O
 02g+ZgKuBC8IvBOltGzhpnT4QpR8jaH8G89zZyrPRULLJLmM7pEFrYoEO+TJS7U1m2Kr
 MTNvaL8g6m4qvFBNHXJZeZrVVhqewhEROJijW3OAQy11j74Kde4oai9MFeCbHrnBSgCB
 YAI1ECsJeN/K3hJcjSgRQ+RkgHMqWrXl+qXgfHPshXZT0Nguq35qCzPN7dqBIBY/hKkQ
 T4Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757084497; x=1757689297;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Mti9ybuYu6wnXzRdmv1TH1+iTc4pPej5u/3yVdQR0FE=;
 b=IGZ5UCk9D19kBwYVrH8XA7C9FJ6+sUkXNd5lBV+ibLRHIlZCHQ4OLztEmGUuCRdlaE
 vkS6R2dEI4ozD2xVfxX0HgVrnZR/NBojmvZ8q/f9NN6fjLO0PYaJR4+KzEetDljotCUu
 2H+CTV7viFvUvE6SIMwqsqPSO6hfNAQIWm4pssWDr0CEi2IK3SJ8/Thozx+qD5BbGFPg
 fIMGRWPjgvTSmvk4Uv34UHIgx0ZAhevmrMOtHf89JVFITD/rcJIpClQoyFExwA0BVoeb
 9x7n6ik+zHxwJZYskvnCno92U7rf6PDNCmaYdorBT8Vb6WQeOF0McN7BtTc8/6b25YHF
 zqZg==
X-Gm-Message-State: AOJu0YzLzhqJqSSsG2ekd+ZJS7iiak7f+ELKq+rR0sgVW/s5c5iXrzqo
 v6oP8uVkGy7Mlz4GsnPp43NlDjiFXkb4E9hCY4zFxVaaYKFBNQjv3k7OZQbpiJF7mSmEzKPRtzs
 qyaY+lgfr8dLTRJLmtpPBSV26iGWTYh7A4QV+HzTn
X-Gm-Gg: ASbGncu3Guuu6GlOUDIetr/plt8fqU4aQ6lpZ9Ie46Vm/sr9ygHzVNZ9sLwpthyhJfq
 x0RlqanLs2d3VPy2HQETAK8Z7tSPLYT+XT+BDRuFNtuWk3jl03QKD8qF1RU3/uPxA8YWHfjSGbb
 rxyxnPmbnBhQFzhE4I8M9qY3UMBseq4QTst2oB/wFRvBIi2gL5SYZLmtC4C/2glHSe98577bYPt
 DQ4cOKFgti4F+HQ7hcHHL7kQJz7UTcJwhc6w6MYu7/4
X-Google-Smtp-Source: AGHT+IGkDzvghBSiWuIMXV1gaVn5BCVQUfERDK2OUBTy6Zqh6XmISSoMB+iAXQAGGohbI9X4xe/gaP26jp79vZsWeI4=
X-Received: by 2002:a05:6870:a411:b0:315:3cdf:5ab9 with SMTP id
 586e51a60fabf-31963341431mr11610309fac.31.1757084496077; Fri, 05 Sep 2025
 08:01:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250904-python-v1-1-c43b3209a0cd@google.com>
 <6e43209d-645f-46e4-a23a-2a1ec149dfe8@redhat.com>
In-Reply-To: <6e43209d-645f-46e4-a23a-2a1ec149dfe8@redhat.com>
From: Peter Foley <pefoley@google.com>
Date: Fri, 5 Sep 2025 11:01:23 -0400
X-Gm-Features: Ac12FXxp1KO2_n1ZSAnKD5_kQMUzF0triXKrbVJy08fg1zrE3TDyDl4SFL3ExJE
Message-ID: <CAAAKUPM=vSJuc-jjPQufezBi_0GPeeTqEje05uSOgKj3_7dHtA@mail.gmail.com>
Subject: Re: [PATCH] Use meson's detected python installation
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-block@nongnu.org, 
 nabihestefan@google.com
Content-Type: multipart/alternative; boundary="0000000000003b7a96063e0f1d65"
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=pefoley@google.com; helo=mail-oa1-x2d.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

--0000000000003b7a96063e0f1d65
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 3:25=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com> =
wrote:

> On 9/4/25 17:11, Peter Foley wrote:
> > Relying on `python3` to be avilable in $PATH doesn't work in some build
> > environments. Update the build files to use the found python binary
> > explicitly.
>
> Meson already does this, if the file is not executable.  See
> docs/devel/build-system.rst:
>
>    Meson has a special convention for invoking Python scripts: if their
>    first line is ``#! /usr/bin/env python3`` and the file is *not*
>    executable, find_program() arranges to invoke the script under the
>    same Python interpreter that was used to invoke Meson.  This is the
>    most common and preferred way to invoke support scripts from Meson
>    build files, because it automatically uses the value of configure's
>    --python=3D option.
>
> Using "[python, 'foo']" is only needed for scripts "where it is
> desirable to make the script executable (for example for test scripts
> that developers may want to invoke from the command line, such as
> tests/qapi-schema/test-qapi.py)".
>

Interesting, that's not what I'm seeing in practice.
For example, locally reverting the change to block/meson.build results in:
FAILED: block/module_block.h
/build/work/046b6fd7014012220d3de53b1bd62f6eb1e9/google3/third_party/qemu/b=
lock/../scripts/modules/module_block.py
block/module_block.h
/usr/bin/env: 'python3': No such file or directory

Where module_block.py is *not* executable:
-rw-rw-r-- 1 pefoley primarygroup 2751 Feb 10  2021
third_party/qemu/scripts/modules/module_block.py


>
> I think the only file you touched that is executable is
> scripts/qemu-plugin-symbols.py; so your issue can be fixed without code
> changes, and with a patch that only does "chmod -x
> scripts/qemu-plugin-symbols.py".  Please correct me if I'm wrong though!
>
> Thanks,
>
> Paolo
>
> > Signed-off-by: Peter Foley <pefoley@google.com>
> > ---
> >   block/meson.build   |  6 ++----
> >   meson.build         | 10 +++++-----
> >   plugins/meson.build |  2 +-
> >   3 files changed, 8 insertions(+), 10 deletions(-)
> >
> > diff --git a/block/meson.build b/block/meson.build
> > index
> 34b1b2a30630214959630d5543181bc82a54d2b3..67e9bee1210307ff15ca87ba0f5e7f7=
85df15042
> 100644
> > --- a/block/meson.build
> > +++ b/block/meson.build
> > @@ -139,14 +139,12 @@ if get_option('dmg').allowed()
> >     endforeach
> >   endif
> >
> > -module_block_py =3D find_program('../scripts/modules/module_block.py')
> >   module_block_h =3D custom_target('module_block.h',
> >                                  output: 'module_block.h',
> >                                  input: modsrc,
> > -                               command: [module_block_py, '@OUTPUT0@',
> modsrc])
> > +                               command: [python,
> files('../scripts/modules/module_block.py'), '@OUTPUT0@', modsrc])
> >   block_ss.add(module_block_h)
> >
> > -wrapper_py =3D find_program('../scripts/block-coroutine-wrapper.py')
> >   block_gen_c =3D custom_target('block-gen.c',
> >                               output: 'block-gen.c',
> >                               input: files(
> > @@ -158,7 +156,7 @@ block_gen_c =3D custom_target('block-gen.c',
> >
>  '../include/system/block-backend-io.h',
> >                                         'coroutines.h'
> >                                         ),
> > -                            command: [wrapper_py, '@OUTPUT@', '@INPUT@
> '])
> > +                            command: [python,
> files('../scripts/block-coroutine-wrapper.py'), '@OUTPUT@', '@INPUT@'])
> >   block_ss.add(block_gen_c)
> >
> >   block_ss.add(files('stream.c'))
> > diff --git a/meson.build b/meson.build
> > index
> fa6186db33435c26d06dce2971a9f536250607e0..6e8baf3deb13c172eecd371ea302b1c=
2539048d0
> 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -12,8 +12,6 @@ add_test_setup('slow', exclude_suites: ['thorough'],
> >   add_test_setup('thorough',
> >                  env: ['G_TEST_SLOW=3D1', 'SPEED=3Dthorough',
> 'RUST_BACKTRACE=3D1'])
> >
> >
> -meson.add_postconf_script(find_program('scripts/symlink-install-tree.py'=
))
> > -
> >   ####################
> >   # Global variables #
> >   ####################
> > @@ -76,6 +74,8 @@ have_user =3D have_linux_user or have_bsd_user
> >   sh =3D find_program('sh')
> >   python =3D import('python').find_installation()
> >
> > +meson.add_postconf_script([python, 'scripts/symlink-install-tree.py'])
> > +
> >   cc =3D meson.get_compiler('c')
> >   all_languages =3D ['c']
> >   if host_os =3D=3D 'windows' and add_languages('cpp', required: false,
> native: false)
> > @@ -3474,7 +3474,7 @@ foreach target : target_dirs
> >         output: config_devices_mak,
> >         depfile: config_devices_mak + '.d',
> >         capture: true,
> > -      command: [minikconf,
> > +      command: [python, minikconf,
> >                   get_option('default_devices') ? '--defconfig' :
> '--allnoconfig',
> >                   config_devices_mak, '@DEPFILE@', '@INPUT@',
> >                   host_kconfig, target_kconfig])
> > @@ -3545,8 +3545,8 @@ config_host_h =3D configure_file(output:
> 'config-host.h', configuration: config_ho
> >   genh +=3D config_host_h
> >
> >   hxtool =3D find_program('scripts/hxtool')
> > -shaderinclude =3D find_program('scripts/shaderinclude.py')
> > -qapi_gen =3D find_program('scripts/qapi-gen.py')
> > +shaderinclude =3D [python, 'scripts/shaderinclude.py']
> > +qapi_gen =3D [python, 'scripts/qapi-gen.py']
> >   qapi_gen_depends =3D [ meson.current_source_dir() /
> 'scripts/qapi/__init__.py',
> >                        meson.current_source_dir() /
> 'scripts/qapi/commands.py',
> >                        meson.current_source_dir() /
> 'scripts/qapi/common.py',
> > diff --git a/plugins/meson.build b/plugins/meson.build
> > index
> 62c991d87fcdd8bcde8edddcc73909c6133f5460..6bf72a69060414ba1b7c1857515eece=
b5a2c7b7c
> 100644
> > --- a/plugins/meson.build
> > +++ b/plugins/meson.build
> > @@ -6,7 +6,7 @@ qemu_plugin_symbols =3D configure_file(
> >     input: files('../include/qemu/qemu-plugin.h'),
> >     output: 'qemu-plugin.symbols',
> >     capture: true,
> > -  command: [files('../scripts/qemu-plugin-symbols.py'), '@INPUT@'])
> > +  command: [python, files('../scripts/qemu-plugin-symbols.py'), '@INPU=
T@
> '])
> >
> >   # Modules need more symbols than just those in
> plugins/qemu-plugins.symbols
> >   if not enable_modules
> >
> > ---
> > base-commit: baa79455fa92984ff0f4b9ae94bed66823177a27
> > change-id: 20250904-python-78ccebd0fded
> >
> > Best regards,
>
>

--0000000000003b7a96063e0f1d65
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Fri, Sep 5, 2025 at 3:25=E2=80=AFAM Pa=
olo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com<=
/a>&gt; wrote:</div><div class=3D"gmail_quote gmail_quote_container"><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">On 9/4/25 17:11, Peter Foley wr=
ote:<br>
&gt; Relying on `python3` to be avilable in $PATH doesn&#39;t work in some =
build<br>
&gt; environments. Update the build files to use the found python binary<br=
>
&gt; explicitly.<br>
<br>
Meson already does this, if the file is not executable.=C2=A0 See <br>
docs/devel/build-system.rst:<br>
<br>
=C2=A0 =C2=A0Meson has a special convention for invoking Python scripts: if=
 their<br>
=C2=A0 =C2=A0first line is ``#! /usr/bin/env python3`` and the file is *not=
*<br>
=C2=A0 =C2=A0executable, find_program() arranges to invoke the script under=
 the<br>
=C2=A0 =C2=A0same Python interpreter that was used to invoke Meson.=C2=A0 T=
his is the<br>
=C2=A0 =C2=A0most common and preferred way to invoke support scripts from M=
eson<br>
=C2=A0 =C2=A0build files, because it automatically uses the value of config=
ure&#39;s<br>
=C2=A0 =C2=A0--python=3D option.<br>
<br>
Using &quot;[python, &#39;foo&#39;]&quot; is only needed for scripts &quot;=
where it is <br>
desirable to make the script executable (for example for test scripts <br>
that developers may want to invoke from the command line, such as <br>
tests/qapi-schema/test-qapi.py)&quot;.<br></blockquote><div><br></div><div>=
Interesting, that&#39;s not what I&#39;m seeing in practice.</div><div>For =
example, locally reverting the change to block/meson.build results in:</div=
><div>FAILED: block/module_block.h <br>/build/work/046b6fd7014012220d3de53b=
1bd62f6eb1e9/google3/third_party/qemu/block/../scripts/modules/module_block=
.py block/module_block.h<br>/usr/bin/env: &#39;python3&#39;: No such file o=
r directory<br></div><div><br></div><div>Where module_block.py is *not* exe=
cutable:</div><div>-rw-rw-r-- 1 pefoley primarygroup 2751 Feb 10 =C2=A02021=
 third_party/qemu/scripts/modules/module_block.py</div><div>=C2=A0</div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">
<br>
I think the only file you touched that is executable is <br>
scripts/qemu-plugin-symbols.py; so your issue can be fixed without code <br=
>
changes, and with a patch that only does &quot;chmod -x <br>
scripts/qemu-plugin-symbols.py&quot;.=C2=A0 Please correct me if I&#39;m wr=
ong though!<br>
<br>
Thanks,<br>
<br>
Paolo<br>
<br>
&gt; Signed-off-by: Peter Foley &lt;<a href=3D"mailto:pefoley@google.com" t=
arget=3D"_blank">pefoley@google.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0block/meson.build=C2=A0 =C2=A0|=C2=A0 6 ++----<br>
&gt;=C2=A0 =C2=A0meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 10 +++++---=
--<br>
&gt;=C2=A0 =C2=A0plugins/meson.build |=C2=A0 2 +-<br>
&gt;=C2=A0 =C2=A03 files changed, 8 insertions(+), 10 deletions(-)<br>
&gt; <br>
&gt; diff --git a/block/meson.build b/block/meson.build<br>
&gt; index 34b1b2a30630214959630d5543181bc82a54d2b3..67e9bee1210307ff15ca87=
ba0f5e7f785df15042 100644<br>
&gt; --- a/block/meson.build<br>
&gt; +++ b/block/meson.build<br>
&gt; @@ -139,14 +139,12 @@ if get_option(&#39;dmg&#39;).allowed()<br>
&gt;=C2=A0 =C2=A0 =C2=A0endforeach<br>
&gt;=C2=A0 =C2=A0endif<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -module_block_py =3D find_program(&#39;../scripts/modules/module_block=
.py&#39;)<br>
&gt;=C2=A0 =C2=A0module_block_h =3D custom_target(&#39;module_block.h&#39;,=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 output: &#39;module_block.=
h&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 input: modsrc,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0command: [module_block_py, &#39;@=
OUTPUT0@&#39;, modsrc])<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0command: [python, files(&#39;../s=
cripts/modules/module_block.py&#39;), &#39;@OUTPUT0@&#39;, modsrc])<br>
&gt;=C2=A0 =C2=A0block_ss.add(module_block_h)<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -wrapper_py =3D find_program(&#39;../scripts/block-coroutine-wrapper.p=
y&#39;)<br>
&gt;=C2=A0 =C2=A0block_gen_c =3D custom_target(&#39;block-gen.c&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0output: &#39;block-gen.c&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0input: files(<br>
&gt; @@ -158,7 +156,7 @@ block_gen_c =3D custom_target(&#39;block-gen.c&#39=
;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&#39;../include/system/block-backend-io.h&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&#39;coroutines.h&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0),<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 command: [wrapper_py, &#39;@OUTPUT@&#39;, &#39=
;@INPUT@&#39;])<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 command: [python, files(&#39;../scripts/block-=
coroutine-wrapper.py&#39;), &#39;@OUTPUT@&#39;, &#39;@INPUT@&#39;])<br>
&gt;=C2=A0 =C2=A0block_ss.add(block_gen_c)<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0block_ss.add(files(&#39;stream.c&#39;))<br>
&gt; diff --git a/meson.build b/meson.build<br>
&gt; index fa6186db33435c26d06dce2971a9f536250607e0..6e8baf3deb13c172eecd37=
1ea302b1c2539048d0 100644<br>
&gt; --- a/meson.build<br>
&gt; +++ b/meson.build<br>
&gt; @@ -12,8 +12,6 @@ add_test_setup(&#39;slow&#39;, exclude_suites: [&#39=
;thorough&#39;],<br>
&gt;=C2=A0 =C2=A0add_test_setup(&#39;thorough&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env: [&#=
39;G_TEST_SLOW=3D1&#39;, &#39;SPEED=3Dthorough&#39;, &#39;RUST_BACKTRACE=3D=
1&#39;])<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -meson.add_postconf_script(find_program(&#39;scripts/symlink-install-t=
ree.py&#39;))<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0####################<br>
&gt;=C2=A0 =C2=A0# Global variables #<br>
&gt;=C2=A0 =C2=A0####################<br>
&gt; @@ -76,6 +74,8 @@ have_user =3D have_linux_user or have_bsd_user<br>
&gt;=C2=A0 =C2=A0sh =3D find_program(&#39;sh&#39;)<br>
&gt;=C2=A0 =C2=A0python =3D import(&#39;python&#39;).find_installation()<br=
>
&gt;=C2=A0 =C2=A0<br>
&gt; +meson.add_postconf_script([python, &#39;scripts/symlink-install-tree.=
py&#39;])<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0cc =3D meson.get_compiler(&#39;c&#39;)<br>
&gt;=C2=A0 =C2=A0all_languages =3D [&#39;c&#39;]<br>
&gt;=C2=A0 =C2=A0if host_os =3D=3D &#39;windows&#39; and add_languages(&#39=
;cpp&#39;, required: false, native: false)<br>
&gt; @@ -3474,7 +3474,7 @@ foreach target : target_dirs<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0output: config_devices_mak,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0depfile: config_devices_mak + &#39;.d=
&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0capture: true,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 command: [minikconf,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 command: [python, minikconf,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ge=
t_option(&#39;default_devices&#39;) ? &#39;--defconfig&#39; : &#39;--allnoc=
onfig&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0co=
nfig_devices_mak, &#39;@DEPFILE@&#39;, &#39;@INPUT@&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ho=
st_kconfig, target_kconfig])<br>
&gt; @@ -3545,8 +3545,8 @@ config_host_h =3D configure_file(output: &#39;co=
nfig-host.h&#39;, configuration: config_ho<br>
&gt;=C2=A0 =C2=A0genh +=3D config_host_h<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0hxtool =3D find_program(&#39;scripts/hxtool&#39;)<br>
&gt; -shaderinclude =3D find_program(&#39;scripts/shaderinclude.py&#39;)<br=
>
&gt; -qapi_gen =3D find_program(&#39;scripts/qapi-gen.py&#39;)<br>
&gt; +shaderinclude =3D [python, &#39;scripts/shaderinclude.py&#39;]<br>
&gt; +qapi_gen =3D [python, &#39;scripts/qapi-gen.py&#39;]<br>
&gt;=C2=A0 =C2=A0qapi_gen_depends =3D [ meson.current_source_dir() / &#39;s=
cripts/qapi/__init__.py&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 meson.current_source_dir() / &#39;scripts/qapi/commands.py&#3=
9;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 meson.current_source_dir() / &#39;scripts/qapi/common.py&#39;=
,<br>
&gt; diff --git a/plugins/meson.build b/plugins/meson.build<br>
&gt; index 62c991d87fcdd8bcde8edddcc73909c6133f5460..6bf72a69060414ba1b7c18=
57515eeceb5a2c7b7c 100644<br>
&gt; --- a/plugins/meson.build<br>
&gt; +++ b/plugins/meson.build<br>
&gt; @@ -6,7 +6,7 @@ qemu_plugin_symbols =3D configure_file(<br>
&gt;=C2=A0 =C2=A0 =C2=A0input: files(&#39;../include/qemu/qemu-plugin.h&#39=
;),<br>
&gt;=C2=A0 =C2=A0 =C2=A0output: &#39;qemu-plugin.symbols&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0capture: true,<br>
&gt; -=C2=A0 command: [files(&#39;../scripts/qemu-plugin-symbols.py&#39;), =
&#39;@INPUT@&#39;])<br>
&gt; +=C2=A0 command: [python, files(&#39;../scripts/qemu-plugin-symbols.py=
&#39;), &#39;@INPUT@&#39;])<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0# Modules need more symbols than just those in plugins/qem=
u-plugins.symbols<br>
&gt;=C2=A0 =C2=A0if not enable_modules<br>
&gt; <br>
&gt; ---<br>
&gt; base-commit: baa79455fa92984ff0f4b9ae94bed66823177a27<br>
&gt; change-id: 20250904-python-78ccebd0fded<br>
&gt; <br>
&gt; Best regards,<br>
<br>
</blockquote></div></div>

--0000000000003b7a96063e0f1d65--

