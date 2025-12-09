Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95C22D3B98A
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 17:25:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT1R9-0000ns-B2; Tue, 09 Dec 2025 12:23:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vT1R5-0000nC-NK
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 12:23:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vT1R3-00081o-59
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 12:23:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765301015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6Wp0AwRkxKH3A3vPTl96wotJx2FsuyIkafeGlAIA314=;
 b=Edy68pH94Sy6ed+qM41US5VFhlYXviHEphH+66ggB+Tww43Jps7ba6mda0H5sG5DejA5y+
 +7hFnf+hsOSYH8pXawSrYwLdjeWe3cO9BVnUMicpgdsNvmJxmg6vYMb0n1WwYDgKRVi0iQ
 RIp0UYGnNPqvC4K70MufTRgm8MrIU0U=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-fkSv5wDsPRyK1iZuCGiZKQ-1; Tue, 09 Dec 2025 12:23:33 -0500
X-MC-Unique: fkSv5wDsPRyK1iZuCGiZKQ-1
X-Mimecast-MFC-AGG-ID: fkSv5wDsPRyK1iZuCGiZKQ_1765301013
Received: by mail-yx1-f70.google.com with SMTP id
 956f58d0204a3-6445421eed0so3997404d50.3
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 09:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765301013; x=1765905813; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6Wp0AwRkxKH3A3vPTl96wotJx2FsuyIkafeGlAIA314=;
 b=UNkAvwljpSjAouiJ1A8K+MPwU/BX3e4d4DcfsORIr87eEtWXbXnLk4d8lisfypnKVb
 wu7fzXENIYHMeovrFpzimjwZoLnTseVm9/V4S0Php0Yi0j4uUnE12BKjB7XWAajo7dUK
 Ta1axaAS+rcrPwXxlCqeqIo4S/os9T65aZEuf3/uKh5v4qyj3o8VZHCegGLiGsdFxsOb
 ejeTLKGb1Xbujc+dKjjHhR0mjXOOUKm6Vt/ST9TB8iJXcBNuGeiQk8b9BI6wiOg0I3A8
 TVGboYvoh7+9tHtfclShT8NtFG6br8O2Jhd3l6mzUbeJT/80DPUyKXea9TJAWU2qKPIh
 o+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765301013; x=1765905813;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Wp0AwRkxKH3A3vPTl96wotJx2FsuyIkafeGlAIA314=;
 b=bKU0z3xqnvWoz3ECwW26+/eqMq2UWDlfo6rZLVZ9lC7waOoCKjvKOZYuXYjmUOQi89
 M4pfz7ru8FTWiRJ7ReKI3s/e3+OxPt3bRS/5DowMB+DM82ZD5YBZFT65EwC4XC+XLh+f
 57U0aGkoO8nPoCxZS6CxF7gdEbToEZsPFOSbxOYp9H08ihQE8YF9cgB3ylz9JodEeLag
 oKP5urlIFjl5BONg5n/j6EPe8ID/81ymgXmx+Qy55z49fdFXTtwzt50HguAOrqxzwIwQ
 NCjW5mkRZTBGpo+hnnPCUW5czK/nH1h9bhmCRUCBJ7t5DyzwcjK4P3RbrS5ghR0HmyFI
 3zhw==
X-Gm-Message-State: AOJu0Yy9+fL/hi3GP+/5rkuVWQyJNBJ494+c2aAIQeSFignPFIMK7Mep
 RsA3jKocgwH+/DaJp2qa3Vq1ehKcMx49fmt/RCDuH3C03gw3QFPB4LZ1s44dITtJ98kPEboLmFN
 A14xyV3B3VfnWGTUQeuTgN9D//7lsGAgLakLBxmG3+5lBWfCToWuoBN7NOjKeJ6PfAvMvhT20yz
 2/5w5OL1CMWJaThaHKgzsYjzIDFHtE9o8=
X-Gm-Gg: AY/fxX4NWHp0Xx/tRrKrfqWhTqGKwct0CLCobCqQAf27UzZwjLHBRgFknk/q62wZRm8
 AKBCUvspNcbHtknciY8yLpmI29nhIR32DkjdidW3KW4wZrKFcsTpAkL0C7kCbjduJuGdek21Xhk
 US/rFqPyYPNFkRV81lKbjUyIoAdH41kLj4kkZmwrMWVVbkiuFsx/y1PGz5nHZVqz22jwhutl29h
 rpzED1+zT6OkkUGuFnaZUgs/A==
X-Received: by 2002:a05:690e:138e:b0:644:51a4:4f1a with SMTP id
 956f58d0204a3-64451a45c3emr9409682d50.46.1765301012809; 
 Tue, 09 Dec 2025 09:23:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEh6Hk5BqtEYNOlYc4CUM2yviEwCCBn5yUrDOCgEJQCDCNdObBE8dDH8oJ8NOmltXrB8e4zgajHvtbbkJX2TsQ=
X-Received: by 2002:a05:690e:138e:b0:644:51a4:4f1a with SMTP id
 956f58d0204a3-64451a45c3emr9409654d50.46.1765301012346; Tue, 09 Dec 2025
 09:23:32 -0800 (PST)
MIME-Version: 1.0
References: <20251205060058.1503170-1-jsnow@redhat.com>
 <aThVvP5vwfjVa-ka@redhat.com>
In-Reply-To: <aThVvP5vwfjVa-ka@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 9 Dec 2025 12:23:21 -0500
X-Gm-Features: AQt7F2rCz-Cr6iQalf3yL4ixh_sHWy7mZnEYuMxS7cSurVrME0AWDYqIYa5NiK8
Message-ID: <CAFn=p-aw1+BDuB1znFBdq_Z+V_qiuO-Vh69UZsS7LZKWZpPTuw@mail.gmail.com>
Subject: Re: [PATCH v3 00/15] python: drop qemu.qmp from qemu.git tree
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, 
 Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>, 
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Ed Maste <emaste@freebsd.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000c349e70645882b14"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--000000000000c349e70645882b14
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025, 12:00=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@red=
hat.com>
wrote:

> On Fri, Dec 05, 2025 at 01:00:42AM -0500, John Snow wrote:
> > Hello!
> >
> > This series drops the in-tree version of our python-qemu-qmp package
> > ("qemu.qmp") in favor of the version hosted on PyPI, whose repository i=
s
> > located at https://gitlab.com/qemu-project/python-qemu-qmp.
> >
> > GitLab CI: https://gitlab.com/jsnow/qemu/-/pipelines/2197613036
> >        (FreeBSD isn't my fault...!)
> >
> > The major effects of this patch series are:
> >
> > 1. qemu.qmp will be installed from PyPI or vendored packages instead of
> >    being utilized directly from the qemu.git tree.
>
> This is not getting installed in enough scenarios IMHO.
>

It's hard to trigger an install when you don't use the build system,
though... If you bypass make/meson/ninja entirely I'm not really sure what
I can do to bootstrap the test deps.


> My current workflow is commonly
>
>   $ ./configure --target-list=3Dx86_64-softmmu
>   $ make
>   $ ./scripts/qmp/qmp-shell-wrap
>    /var/home/berrange/src/virt/qemu/build
>   Traceback (most recent call last):
>     File "/var/home/berrange/src/virt/qemu/scripts/qmp/qmp-shell-wrap",
> line 7, in <module>
>       from qemu.qmp import qmp_shell
>   ModuleNotFoundError: No module named 'qemu.qmp'
>
> Even if I add in a call to 'source build/pyvenv/bin/activate'
> after 'make', I'm still missing the qemu.qmp python module.
>
> AFAICT, qemu.qmp only gets installed in the venv if you run
> 'make check', and IMHO that should not be expected for the
> above usage scenario.
>

"make check-venv", to do just the minimum setup. You don't have to run
check.

We could always add a flag to configure to front-load the testing
environment and scripts, but I thought it was best to avoid adding new
dependencies by default.

Like --with-python-tests or something? Then you'd always have it like you
do with meson and sphinx (with --enable-docs)


> Likewise I can no longer run any of the test programs directly
> without first having run 'make check'. eg what I would currently
> do is:
>
>    $ ./configure --target-list=3Dx86_64-softmmu
>    $ make
>    $ cd build/tests/qemu-iotests
>    $ ./check 300
>
> I don't generally run 'make check' as frequently as I
> 'configure && make' as it adds alot of time which is
> not needed usually.
>
> In general I find it tedious having to remember to run
> 'source build/pyvenv/bin/activate' in every terminal
> window where I might want to run a QEMU script that relies
> on python. It is also fairly undesirable too, as I use the
> same terminal window for various purposes, that activating
> the QEMU venv can interfere with non-QEMU python usage.
>

You can run one-offs with build/pyvenv/bin/python3 without activating the
environment,

but you're right that this does require an environment setup step (make
check-venv)


> I would find it helpful if we provided a "run" script in the
> root dir of the build directory that contained the following
>
>   $ cat build/run
>   #!/bin/sh
>
>   set -e
>
>   HERE=3D$(realpath $(dirname $0))
>   source $HERE/pyvenv/bin/activate
>   exec "$@"
>
> Which would be used as a wrapper to execute scripts with the
> right environment. That would let us keep the simpler workflow,
> and avoid polluting the global terminal environment with the
> qemu venv.
>
> eg to be used as
>
>    $ ./configure --target-list=3Dx86_64-softmmu
>    $ make
>    $ cd build/tests/qemu-iotests
>    $ ../../run ./check 300
>
> or
>
>   $ ./configure --target-list=3Dx86_64-softmmu
>   $ make
>   $ ./build/run ./scripts/qmp/qmp-shell-wrap


Shouldn't be too hard to add, honestly. Maybe adding in a "meson compile
pyvenv/pyvenv_tests_group" line at the start to trigger the dep
installation if it hasn't occurred already?

Or maybe just directly invoking mkvenv ensuregroup to avoid ninja
re-configuring things while you develop.

Something like that.



>
>
>
> > 2. There are no new python dependencies checked or installed during
> >    configure.  All test dependencies are installed post-hoc on an
> >    as-needed basis.
> > 3. "make check-venv" is no longer required to be run manually before an=
y
> >    test that is integrated with meson; this includes "make check" and
> >    "make check-functional".
> > 4. "make check-venv" no longer installs functional test dependencies: i=
t
> >    installs only the core suite of python test dependencies.
> > 5. "make check-venv" is now required as a pre-requisite for running
> >    device-crash-test and manually executed iotests.
> > 6. Unfortunately, python3-wheel and python3-setuptools are now required
> >    on the host system if tests are to be executed and >=3D Python 3.13 =
is
> >    used.
> > 7. An awful lot of deleted lines of code, and a lot fewer headaches
> >    managing two nearly-identical copies of this source code. O:-)
> >
> > Patches 1-5 are build system focused; they set up new pythondeps.toml,
> > mkvenv, and meson systems in preparation for relying on an external
> > qemu.qmp library, but does not yet make the switch.
> >
> > Patches 6-9 are testing and CI focused; they add necessary preparation
> > steps to keep tests running happily once the in-tree qemu.qmp library i=
s
> > removed.
> >
> > Patches 10-15 are build system focused again; they implement the actual
> > switchover to the external qemu.qmp library.
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-
> https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
> https://www.instagram.com/dberrange :|
>
>

--000000000000c349e70645882b14
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Dec 9, 2025, 12:00=E2=80=
=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">be=
rrange@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On=
 Fri, Dec 05, 2025 at 01:00:42AM -0500, John Snow wrote:<br>
&gt; Hello!<br>
&gt; <br>
&gt; This series drops the in-tree version of our python-qemu-qmp package<b=
r>
&gt; (&quot;qemu.qmp&quot;) in favor of the version hosted on PyPI, whose r=
epository is<br>
&gt; located at <a href=3D"https://gitlab.com/qemu-project/python-qemu-qmp"=
 rel=3D"noreferrer noreferrer" target=3D"_blank">https://gitlab.com/qemu-pr=
oject/python-qemu-qmp</a>.<br>
&gt; <br>
&gt; GitLab CI: <a href=3D"https://gitlab.com/jsnow/qemu/-/pipelines/219761=
3036" rel=3D"noreferrer noreferrer" target=3D"_blank">https://gitlab.com/js=
now/qemu/-/pipelines/2197613036</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 (FreeBSD isn&#39;t my fault...!)<br>
&gt; <br>
&gt; The major effects of this patch series are:<br>
&gt; <br>
&gt; 1. qemu.qmp will be installed from PyPI or vendored packages instead o=
f<br>
&gt;=C2=A0 =C2=A0 being utilized directly from the qemu.git tree.<br>
<br>
This is not getting installed in enough scenarios IMHO.<br></blockquote></d=
iv></div><div dir=3D"auto"><br></div><div dir=3D"auto">It&#39;s hard to tri=
gger an install when you don&#39;t use the build system, though... If you b=
ypass make/meson/ninja entirely I&#39;m not really sure what I can do to bo=
otstrap the test deps.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><=
div class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex">
<br>
My current workflow is commonly<br>
<br>
=C2=A0 $ ./configure --target-list=3Dx86_64-softmmu<br>
=C2=A0 $ make<br>
=C2=A0 $ ./scripts/qmp/qmp-shell-wrap <br>
=C2=A0 =C2=A0/var/home/berrange/src/virt/qemu/build<br>
=C2=A0 Traceback (most recent call last):<br>
=C2=A0 =C2=A0 File &quot;/var/home/berrange/src/virt/qemu/scripts/qmp/qmp-s=
hell-wrap&quot;, line 7, in &lt;module&gt;<br>
=C2=A0 =C2=A0 =C2=A0 from qemu.qmp import qmp_shell<br>
=C2=A0 ModuleNotFoundError: No module named &#39;qemu.qmp&#39;<br>
<br>
Even if I add in a call to &#39;source build/pyvenv/bin/activate&#39;<br>
after &#39;make&#39;, I&#39;m still missing the qemu.qmp python module.<br>
<br>
AFAICT, qemu.qmp only gets installed in the venv if you run<br>
&#39;make check&#39;, and IMHO that should not be expected for the<br>
above usage scenario.<br></blockquote></div></div><div dir=3D"auto"><br></d=
iv><div dir=3D"auto">&quot;make check-venv&quot;, to do just the minimum se=
tup. You don&#39;t have to run check.</div><div dir=3D"auto"><br></div><div=
 dir=3D"auto">We could always add a flag to configure to front-load the tes=
ting environment and scripts, but I thought it was best to avoid adding new=
 dependencies by default.</div><div dir=3D"auto"><br></div><div dir=3D"auto=
">Like --with-python-tests or something? Then you&#39;d always have it like=
 you do with meson and sphinx (with --enable-docs)</div><div dir=3D"auto"><=
br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex">
<br>
Likewise I can no longer run any of the test programs directly<br>
without first having run &#39;make check&#39;. eg what I would currently<br=
>
do is:<br>
<br>
=C2=A0 =C2=A0$ ./configure --target-list=3Dx86_64-softmmu<br>
=C2=A0 =C2=A0$ make<br>
=C2=A0 =C2=A0$ cd build/tests/qemu-iotests<br>
=C2=A0 =C2=A0$ ./check 300<br>
<br>
I don&#39;t generally run &#39;make check&#39; as frequently as I<br>
&#39;configure &amp;&amp; make&#39; as it adds alot of time which is<br>
not needed usually.<br>
<br>
In general I find it tedious having to remember to run<br>
&#39;source build/pyvenv/bin/activate&#39; in every terminal<br>
window where I might want to run a QEMU script that relies<br>
on python. It is also fairly undesirable too, as I use the<br>
same terminal window for various purposes, that activating<br>
the QEMU venv can interfere with non-QEMU python usage.<br></blockquote></d=
iv></div><div dir=3D"auto"><br></div><div dir=3D"auto">You can run one-offs=
 with build/pyvenv/bin/python3 without activating the environment,</div><di=
v dir=3D"auto"><br></div><div dir=3D"auto">but you&#39;re right that this d=
oes require an environment setup step (make check-venv)</div><div dir=3D"au=
to"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_conta=
iner"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex">
<br>
I would find it helpful if we provided a &quot;run&quot; script in the<br>
root dir of the build directory that contained the following<br>
<br>
=C2=A0 $ cat build/run<br>
=C2=A0 #!/bin/sh<br>
<br>
=C2=A0 set -e<br>
<br>
=C2=A0 HERE=3D$(realpath $(dirname $0))<br>
=C2=A0 source $HERE/pyvenv/bin/activate<br>
=C2=A0 exec &quot;$@&quot;<br>
<br>
Which would be used as a wrapper to execute scripts with the<br>
right environment. That would let us keep the simpler workflow,<br>
and avoid polluting the global terminal environment with the<br>
qemu venv.<br>
<br>
eg to be used as<br>
<br>
=C2=A0 =C2=A0$ ./configure --target-list=3Dx86_64-softmmu<br>
=C2=A0 =C2=A0$ make<br>
=C2=A0 =C2=A0$ cd build/tests/qemu-iotests<br>
=C2=A0 =C2=A0$ ../../run ./check 300<br>
<br>
or<br>
<br>
=C2=A0 $ ./configure --target-list=3Dx86_64-softmmu<br>
=C2=A0 $ make<br>
=C2=A0 $ ./build/run ./scripts/qmp/qmp-shell-wrap</blockquote></div></div><=
div dir=3D"auto"><br></div><div dir=3D"auto">Shouldn&#39;t be too hard to a=
dd, honestly. Maybe adding in a &quot;meson compile pyvenv/pyvenv_tests_gro=
up&quot; line at the start to trigger the dep installation if it hasn&#39;t=
 occurred already?</div><div dir=3D"auto"><br></div><div dir=3D"auto">Or ma=
ybe just directly invoking mkvenv ensuregroup to avoid ninja re-configuring=
 things while you develop.</div><div dir=3D"auto"><br></div><div dir=3D"aut=
o">Something like that.</div><div dir=3D"auto"><br></div><div dir=3D"auto">=
<br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container=
"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex"> <br>
<br>
<br>
<br>
&gt; 2. There are no new python dependencies checked or installed during<br=
>
&gt;=C2=A0 =C2=A0 configure.=C2=A0 All test dependencies are installed post=
-hoc on an<br>
&gt;=C2=A0 =C2=A0 as-needed basis.<br>
&gt; 3. &quot;make check-venv&quot; is no longer required to be run manuall=
y before any<br>
&gt;=C2=A0 =C2=A0 test that is integrated with meson; this includes &quot;m=
ake check&quot; and<br>
&gt;=C2=A0 =C2=A0 &quot;make check-functional&quot;.<br>
&gt; 4. &quot;make check-venv&quot; no longer installs functional test depe=
ndencies: it<br>
&gt;=C2=A0 =C2=A0 installs only the core suite of python test dependencies.=
<br>
&gt; 5. &quot;make check-venv&quot; is now required as a pre-requisite for =
running<br>
&gt;=C2=A0 =C2=A0 device-crash-test and manually executed iotests.<br>
&gt; 6. Unfortunately, python3-wheel and python3-setuptools are now require=
d<br>
&gt;=C2=A0 =C2=A0 on the host system if tests are to be executed and &gt;=
=3D Python 3.13 is<br>
&gt;=C2=A0 =C2=A0 used.<br>
&gt; 7. An awful lot of deleted lines of code, and a lot fewer headaches<br=
>
&gt;=C2=A0 =C2=A0 managing two nearly-identical copies of this source code.=
 O:-)<br>
&gt; <br>
&gt; Patches 1-5 are build system focused; they set up new pythondeps.toml,=
<br>
&gt; mkvenv, and meson systems in preparation for relying on an external<br=
>
&gt; qemu.qmp library, but does not yet make the switch.<br>
&gt; <br>
&gt; Patches 6-9 are testing and CI focused; they add necessary preparation=
<br>
&gt; steps to keep tests running happily once the in-tree qemu.qmp library =
is<br>
&gt; removed.<br>
&gt; <br>
&gt; Patches 10-15 are build system focused again; they implement the actua=
l<br>
&gt; switchover to the external qemu.qmp library.<br>
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer noreferrer" target=3D=
"_blank">https://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a h=
ref=3D"https://www.flickr.com/photos/dberrange" rel=3D"noreferrer noreferre=
r" target=3D"_blank">https://www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer noreferrer" target=3D"=
_blank">https://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com=
" rel=3D"noreferrer noreferrer" target=3D"_blank">https://fstop138.berrange=
.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer noreferrer" tar=
get=3D"_blank">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=C2=A0 =C2=A0=
 <a href=3D"https://www.instagram.com/dberrange" rel=3D"noreferrer noreferr=
er" target=3D"_blank">https://www.instagram.com/dberrange</a> :|<br>
<br>
</blockquote></div></div></div>

--000000000000c349e70645882b14--


