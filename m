Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 050E3C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 16:02:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taGhf-00051F-Es; Tue, 21 Jan 2025 11:02:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1taGhd-00050b-4X
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 11:02:09 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1taGhb-00031d-1p
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 11:02:08 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-385d7f19f20so2889842f8f.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 08:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737475325; x=1738080125; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ND4n8Eb2Ni5kkyI/4S4sUC8NJaQxEiMhlQ0dRJEEmRs=;
 b=YqD56jbQhhMX7TsTonAMg+mEAzZV1YJqCdMCsH16ShLGUjSki0gIsfkKVCr0M+v7pX
 O1U7ROlH/D0YZbmXK5v1opTQjkzf/3/MC9VP/cxsS8+7TbXGg74WfWSoM4tZMCL+pPTE
 IIo7JyerrByGz2wYVYFf0rH3MGlRvhPEHNSnOi/bAtiBASqvNtPw7iIUKarXvWKLC12r
 1l2g4aqGd9AzlCb32LqbHWnh9Fz3q/ywCm66UJPSUwO5NwdOFZTURR7gAZyhgJhIh2UY
 hFkFSm32dQMhJgjjl6MsA73yj0+Mdko+nJ8pqTleHDzmvetEfVGFFeFW+VNFF4UktxgN
 urcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737475325; x=1738080125;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ND4n8Eb2Ni5kkyI/4S4sUC8NJaQxEiMhlQ0dRJEEmRs=;
 b=fI6CkUQRJo8SUiL4eHnL07ydzEL8VWWZvDv0ngqLnhDZ7HHqASzSRb4gm1+4xZQjs3
 bT9uvH2O5M39rOPUkGGqY9AxE/zM4exsUg8xulGJXNyYwch0NRd/8Sg0mvRG/XBQpzTq
 +p0NPTPtvkz6v1FMNoYcFgd1pK0VGl+OFuX5Xvz/gyob1HQKmM4VpKzeOvEswvkLhp9J
 b9cSZkM+T+EhR885tYWk7rSN9z99uoFdhURXBjUo8rMIOvwajMmO4/gY972JBI45lDzo
 IrrZ3TieKs/V5vprg2gD31LA0U2QoMfd/ffQja7fwfQa7Wm1pyIQDCIDjC02K52AntGB
 fkCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWteJo0IVxd+SSvuzIXlTUdEvVbqWKdlKx6yag/Qf9Loifbuq5E8yV1ODfnjTkVeKWz3XeWzNEp/qDD@nongnu.org
X-Gm-Message-State: AOJu0YymVIzpzCXKU8PZXu2F7OJ5mO+KkoN3tZU4+xRK+GDgcfbYVGJ1
 1hJDHhyek7USkufLrF5l6wpQs8vQ2C+lG1iSRnWdj6Jub0s14p2W/jsPm6xtxNI=
X-Gm-Gg: ASbGncs+xRYMc0FWywv8/oJbej7tZ1naU6qvjMmdgEJc5RIXMFcZHrKVAdPrm6RQax6
 /gfpqpV9fcjyU5XZMsC+0TNqY7EPP20xqMCwm0wXOL9M5BjnmuUKrNooT0F16J0tjenWizegPCQ
 lVKBQyyqHadtRpuWoPqLcLBrP8DWsUMMvAr3TH/30pQwFJk3+4/h2AAVnPvUM2fUXUREXdnSJIk
 /2T/x9Bpy/m6WoSERXyjxNyNBr7vdd/2HI9tiahRQnupaOQXUsfxe5dYjDrXqA3k6lz
X-Google-Smtp-Source: AGHT+IG2oI4LUgCCm4aBrBVyV7tGojEnNAMi2MDYTe0ufX1f/IkTgWn6KKNyk3+UKl4lds1FWXPegg==
X-Received: by 2002:a5d:490b:0:b0:38b:ef22:d8ba with SMTP id
 ffacd0b85a97d-38bf57b3fdcmr13908641f8f.44.1737475324811; 
 Tue, 21 Jan 2025 08:02:04 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf322ab42sm13499128f8f.44.2025.01.21.08.02.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2025 08:02:04 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 332995F756;
 Tue, 21 Jan 2025 16:02:03 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Roman Penyaev <r.peniaev@gmail.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v7 4/4] qemu-options.hx: describe hub chardev and
 aggregation of several backends
In-Reply-To: <CACZ9PQU1GH2XEH7HX7YXX7UmtGhJbyZR5-F63339F+7yu3M1GA@mail.gmail.com>
 (Roman Penyaev's message of "Tue, 21 Jan 2025 16:23:49 +0100")
References: <20250118164056.830721-1-r.peniaev@gmail.com>
 <20250118164056.830721-5-r.peniaev@gmail.com>
 <87wmeonrar.fsf@draig.linaro.org>
 <CACZ9PQU1GH2XEH7HX7YXX7UmtGhJbyZR5-F63339F+7yu3M1GA@mail.gmail.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Tue, 21 Jan 2025 16:02:03 +0000
Message-ID: <87ldv4nojo.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Roman Penyaev <r.peniaev@gmail.com> writes:

> On Tue, Jan 21, 2025 at 4:02=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@lin=
aro.org> wrote:
>>
>> Roman Penyaev <r.peniaev@gmail.com> writes:
>>
>> > This adds a few lines describing `hub` aggregator configuration
>> > for aggregation of several backend devices with a single frontend
>> > device.
>> >
>> > Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
>> > Cc: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
>> > Cc: qemu-devel@nongnu.org
>> > ---
>> >  qemu-options.hx | 48 ++++++++++++++++++++++++++++++++++++++++++++----
>> >  1 file changed, 44 insertions(+), 4 deletions(-)
>> >
>> > diff --git a/qemu-options.hx b/qemu-options.hx
>> > index 7090d59f6f10..fdc46f7e68b3 100644
>> > --- a/qemu-options.hx
>> > +++ b/qemu-options.hx
>> > @@ -3720,7 +3720,7 @@ SRST
>> >  The general form of a character device option is:
>> >
>> >  ``-chardev backend,id=3Did[,mux=3Don|off][,options]``
>> > -    Backend is one of: ``null``, ``socket``, ``udp``, ``msmouse``,
>> > +    Backend is one of: ``null``, ``socket``, ``udp``, ``msmouse``, ``=
hub``,
>> >      ``vc``, ``ringbuf``, ``file``, ``pipe``, ``console``, ``serial``,
>> >      ``pty``, ``stdio``, ``braille``, ``parallel``,
>> >      ``spicevmc``, ``spiceport``. The specific backend will determine =
the
>> > @@ -3777,9 +3777,10 @@ The general form of a character device option i=
s:
>> >      the QEMU monitor, and ``-nographic`` also multiplexes the console
>> >      and the monitor to stdio.
>> >
>> > -    There is currently no support for multiplexing in the other
>> > -    direction (where a single QEMU front end takes input and output f=
rom
>> > -    multiple chardevs).
>> > +    If you need to aggregate data in the opposite direction (where one
>> > +    QEMU frontend interface receives input and output from multiple
>> > +    backend chardev devices), please refer to the paragraph below
>> > +    regarding chardev ``hub`` aggregator device configuration.
>> >
>> >      Every backend supports the ``logfile`` option, which supplies the
>> >      path to a file to record all data transmitted via the backend. The
>> > @@ -3879,6 +3880,45 @@ The available backends are:
>> >      Forward QEMU's emulated msmouse events to the guest. ``msmouse``
>> >      does not take any options.
>> >
>> > +``-chardev hub,id=3Did,chardevs.0=3Did[,chardevs.N=3Did]`` Explicitly=
 create
>> > +    chardev backend hub device with the possibility to aggregate input
>> > +    from multiple backend devices and forward it to a single frontend
>> > +    device. Additionally, `hub` device takes the output from the
>> > +    frontend device and sends it back to all the connected backend
>> > +    devices. This allows for seamless interaction between different
>> > +    backend devices and a single frontend interface. Aggregation
>> > +    supported for up to 4 chardev devices. (Since 10.0)
>> > +
>> > +    For example, the following is a use case of 2 backend devices:
>> > +    virtual console ``vc0`` and a pseudo TTY ``pty0`` connected to
>> > +    a single virtio hvc console frontend device with a hub ``hub0``
>> > +    help. Virtual console renders text to an image, which can be
>> > +    shared over the VNC protocol. In turn, pty backend provides
>> > +    bidirectional communication to the virtio hvc console over the
>> > +    pseudo TTY file. The example configuration can be as follows:
>> > +
>> > +    ::
>> > +
>> > +       -chardev pty,path=3D/tmp/pty,id=3Dpty0 \
>> > +       -chardev vc,id=3Dvc0 \
>> > +       -chardev hub,id=3Dhub0,chardevs.0=3Dpty0,chardevs.1=3Dvc0 \
>> > +       -device virtconsole,chardev=3Dhub0 \
>> > +       -vnc 0.0.0.0:0
>> > +
>> > +    Once QEMU starts VNC client and any TTY emulator can be used to
>> > +    control a single hvc console:
>> > +
>> > +    ::
>> > +
>> > +       # Start TTY emulator
>> > +       tio /tmp/pty
>> > +
>> > +       # Start VNC client and switch to virtual console Ctrl-Alt-2
>> > +       vncviewer :0
>> > +
>> > +    Several frontend devices is not supported. Stacking of multiplexe=
rs
>> > +    and hub devices is not supported as well.
>> > +
>>
>> Not sure why this breaks but I'm seeing:
>>
>>   FAILED: docs/docs.stamp
>>   /usr/bin/env CONFDIR=3Detc/qemu
>> /home/alex/lsrc/qemu.git/builds/all/pyvenv/bin/sphinx-build -q -W
>> -Dkerneldoc_werror=3D1 -j auto -Dversion=3D9.2.50 -Drelease=3D
>> -Ddepfile=3Ddocs/docs.d -Ddepfile_stamp=3Ddocs/docs.stamp -b html -d
>> /home/alex/lsrc/qemu.git/builds/all/docs/manual.p
>> /home/alex/lsrc/qemu.git/docs
>> /home/alex/lsrc/qemu.git/builds/all/docs/manual
>>
>>   Warning, treated as error:
>>   /home/alex/lsrc/qemu.git/qemu-options.hx:3884:'any' reference target n=
ot found: hub
>
> This is odd, my make is silent. Can you please check this?
>
> diff --git a/qemu-options.hx b/qemu-options.hx
> index fdc46f7e68b3..e6d9de142aaf 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -3880,7 +3880,8 @@ The available backends are:
>      Forward QEMU's emulated msmouse events to the guest. ``msmouse``
>      does not take any options.
>
> -``-chardev hub,id=3Did,chardevs.0=3Did[,chardevs.N=3Did]`` Explicitly cr=
eate
> +``-chardev hub,id=3Did,chardevs.0=3Did[,chardevs.N=3Did]``
> +    Explicitly create

No joy. I did replicate from the command line and s/-q/-v/

  writing output... [ 43%] specs/fsi .. specs/ppc-spapr-hotplug

  Traceback (most recent call last):
    File "/usr/lib/python3/dist-packages/sphinx/cmd/build.py", line 281, in=
 build_main
      app.build(args.force_all, args.filenames)
    File "/usr/lib/python3/dist-packages/sphinx/application.py", line 341, =
in build
      self.builder.build_update()
    File "/usr/lib/python3/dist-packages/sphinx/builders/__init__.py", line=
 310, in build_update
      self.build(to_build,
    File "/usr/lib/python3/dist-packages/sphinx/builders/__init__.py", line=
 376, in build
      self.write(docnames, list(updated_docnames), method)
    File "/usr/lib/python3/dist-packages/sphinx/builders/__init__.py", line=
 568, in write
      self._write_parallel(sorted(docnames),
    File "/usr/lib/python3/dist-packages/sphinx/builders/__init__.py", line=
 612, in _write_parallel
      doctree =3D self.env.get_and_resolve_doctree(docname, self)
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    File "/usr/lib/python3/dist-packages/sphinx/environment/__init__.py", l=
ine 591, in get_and_resolve_doctree
      self.apply_post_transforms(doctree, docname)
    File "/usr/lib/python3/dist-packages/sphinx/environment/__init__.py", l=
ine 637, in apply_post_transforms
      transformer.apply_transforms()
    File "/usr/lib/python3/dist-packages/sphinx/transforms/__init__.py", li=
ne 80, in apply_transforms
      super().apply_transforms()
    File "/usr/lib/python3/dist-packages/docutils/transforms/__init__.py", =
line 173, in apply_transforms
      transform.apply(**kwargs)
    File "/usr/lib/python3/dist-packages/sphinx/transforms/post_transforms/=
__init__.py", line 35, in apply
      self.run(**kwargs)
    File "/usr/lib/python3/dist-packages/sphinx/transforms/post_transforms/=
__init__.py", line 97, in run
      self.warn_missing_reference(refdoc, typ, target, node, domain)
    File "/usr/lib/python3/dist-packages/sphinx/transforms/post_transforms/=
__init__.py", line 204, in warn_missing_reference
      logger.warning(msg, location=3Dnode, type=3D'ref', subtype=3Dtyp)
    File "/usr/lib/python3.11/logging/__init__.py", line 1855, in warning
      self.log(WARNING, msg, *args, **kwargs)
    File "/usr/lib/python3/dist-packages/sphinx/util/logging.py", line 123,=
 in log
      super().log(level, msg, *args, **kwargs)
    File "/usr/lib/python3.11/logging/__init__.py", line 1887, in log
      self.logger.log(level, msg, *args, **kwargs)
    File "/usr/lib/python3.11/logging/__init__.py", line 1559, in log
      self._log(level, msg, args, **kwargs)
    File "/usr/lib/python3.11/logging/__init__.py", line 1634, in _log
      self.handle(record)
    File "/usr/lib/python3.11/logging/__init__.py", line 1644, in handle
      self.callHandlers(record)
    File "/usr/lib/python3.11/logging/__init__.py", line 1706, in callHandl=
ers
      hdlr.handle(record)
    File "/usr/lib/python3.11/logging/__init__.py", line 974, in handle
      rv =3D self.filter(record)
           ^^^^^^^^^^^^^^^^^^^
    File "/usr/lib/python3.11/logging/__init__.py", line 830, in filter
      result =3D f.filter(record)
               ^^^^^^^^^^^^^^^^
    File "/usr/lib/python3/dist-packages/sphinx/util/logging.py", line 426,=
 in filter
      raise exc
  sphinx.errors.SphinxWarning: /home/alex/lsrc/qemu.git/qemu-options.hx:388=
4:'any' reference target not found: hub

  Warning, treated as error:
  /home/alex/lsrc/qemu.git/qemu-options.hx:3884:'any' reference target not =
found: hub

So it appears deep in sphinx itself and not any of our config bits... I
can't work out why its looking up hub as a reference though.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

