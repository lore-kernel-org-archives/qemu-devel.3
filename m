Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 606F5CA0FF9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 15:49:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urIOO-0001Nr-Ef; Wed, 27 Aug 2025 11:48:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankeesler@google.com>)
 id 1urION-0001NY-7b
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 11:48:55 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ankeesler@google.com>)
 id 1urIOK-0004uR-9H
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 11:48:54 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-55ce5243f6dso7493775e87.2
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 08:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1756309729; x=1756914529; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BbuLO2coDQyaj7K2TF8p+6eb2pTXAry3II0nSqiYNqE=;
 b=LVdV83j9EG5+6I/d+JdIbp3ExU0HoLUBwx+faO6LLTZ7A5e/UHMMebEw9Upjtx/uUl
 oxjeEMFUqRsLEkD9dWUFhzfZxD+E/S4WgMxAdYadiG+8CLl5jItpOlc0dmE/qb8nv1i6
 AzYih9A40cNJCbdiSmvrAm3mT1L0RTZgp605dS3IXYJZO+0WdF8P1eUJlTtxZNWrRhQS
 YpFgTfuL302VS5OyamlwasZ/++H9g5diM86Xa376ATSDgAGDTEMOkUMzwc+BtOEs1JeN
 jbLfkzlR/EwXdiKhX7Sdm+YmOrh6Z/ji/S9IPQH+Vum++U3gJZ31Jb0pcMsd66qASeBZ
 nfKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756309729; x=1756914529;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BbuLO2coDQyaj7K2TF8p+6eb2pTXAry3II0nSqiYNqE=;
 b=JOC4QhC2mpt0KyccwoiFh9sIvpHYczMAHEhkc1uqjnVOzWoJSNzqQpOc5esjMI/wTP
 cImMBmePGPV4GIzpeEjKCQ48ZsO6KdCc7KEXz8gaK0q84dqUd0GidGx0iszY5L+vrRFw
 x09QARZdF6NThrj6AMAqv4bHufSKq4ih02HQSA/AnGjaLdkoR92FPCV2vBNk1Pvm/+hK
 SeqzTT0/pyGG32444QhlDJbVOAqqLNcw04gXhdVeyavNslBjlL/7Oo+C2fZ4EIVdVVsw
 3jdDwQA5i3pdUVN8HIPHYqMldUnBMoMv1h6PkdHK8rrPKlFXsrIDm0VuyktE3D7DUwxm
 hBpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLc0T3REYAXPP3kP60P0guxRM7IRsAdDZUR0PJmP+6kzmR2fsqmlcF3NJtvzJR1KET6ThhffzZ+tjN@nongnu.org
X-Gm-Message-State: AOJu0YwLp9CqWkLfcdn0lMEZZf8nkUNocs4xKak2JrYQmAnPx2epPPTc
 RKqHNwegpjnnurV9HP94/O42JDsszLVQ+hxKOU8G4hEqumV5d0NbP34MmQiPGttx6wMToy1Y6Pe
 LhTP4Vkqtl9m4dgzuisGnUmfQ1MAPviIE1LRTeIM=
X-Gm-Gg: ASbGncvKMkVFSpXKcYdUHTufP5HMFPiqoJtq6EqShSsQTVW2I7rEQEP8Mvb1HnK7Xgk
 4VDKNRpy+UkmRJca+rgJSkTDsVsMQtVR9ft3YaeuLlCYY7gLF3wgKUuwFtEGyuk3L19ezLF/LUc
 ss8eLVhJtD8FLLT19t7aXrU3jGnklF2iiBIxT/0+dMFYCGx+UWjNAvfJFgjIMsitxdKUE0wZ8Uh
 RKejzh8UM1UNay5Jp9i6lwECYPt+5xQJSU02ORW0A==
X-Google-Smtp-Source: AGHT+IEiSCgHX2MjSDHEjmdWJYYRHhT1CWHrycwL5ApS+LVdJTC2RKfBr8+kXvrwSusjbWTEwjVEQaRsVmDfgRKGFd8=
X-Received: by 2002:a05:6512:6410:b0:55b:7582:28d0 with SMTP id
 2adb3069b0e04-55f0c6b4ed3mr5282966e87.21.1756309729023; Wed, 27 Aug 2025
 08:48:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250722190824.3419413-1-ankeesler@google.com>
 <20250722190824.3419413-2-ankeesler@google.com> <aK8MHGgp-Dm_Lkmb@redhat.com>
In-Reply-To: <aK8MHGgp-Dm_Lkmb@redhat.com>
From: Andrew Keesler <ankeesler@google.com>
Date: Wed, 27 Aug 2025 11:48:34 -0400
X-Gm-Features: Ac12FXy2ircp5It8o5FsCCNFm-pwb1KalSyjndggnkCxk4JaTh9XVy2lpi-OPDU
Message-ID: <CAGZECHOL=v50aV0vcCHdFxb69TmH7mXry2NEhu+EZZnWztRO-A@mail.gmail.com>
Subject: Re: [PATCH 1/1] hw/display: Support per-head resolutions with
 virtio-gpu
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: marcandre.lureau@gmail.com, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000083dd24063d5ab929"
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=ankeesler@google.com; helo=mail-lf1-x136.google.com
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

--00000000000083dd24063d5ab929
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sending again (replying all this time).

> IIUC from the current code, xres/yres are only set against the
> first head. The 2nd and later heads are left undefined by the
> virtio-gpu-base code at least - I'm unclear if something else
> in QEMU will fill in defaults later, or if they set to 0x0.

That is correct - xres/yres are only set against the first head in the
current code. The wording in my commit message (and cover letter) was
misleading. I will fix that to say that "If no
virtio_gpu_base_conf.outputs are provided,
virtio_gpu_base_conf.xres/virtio_gpu_base_conf.yres will still be
respected _for the first head_ for backwards compatibility".

The only way I could get QEMU to fill in xres/yres for a 2nd and later
head was to trigger virtio_gpu_ops.ui_info via a VNC client.

> Is it relevant to set xres/yres on outputs, even when they are
> not (yet) enabled ?  Perhaps we should have an explicit 'enabled: bool'
> property in the 'outputs' struct ?

Maybe you might want to set xres/yres on an output, but not enable it
yet? I don't have any concrete examples of when you might want to do
that, maybe you have some examples?

I feel like I could see a user setting xres/yres on an output,
forgetting to set enabled on that output, and then being confused why
their head is blank. Because of this, my vote would be to default to
enabling an output when it has configuration. I am easily swayed by
your guidance, though.

> I think we should probably report an error if xres / yres
> are set at the global level and also set against any individual
> output, so the two approaches are mutually exclusive.

ACK - fixed for the next patch.

> Sorry, we missed the boat for 10.1, so these two new properties
> will require an explicit "Since 10.2" tag against them, separate
> from the overall struct versrion below.

ACK - fixed for the next patch.

> This is a backcompat problem, because xres/yres are mandatory if
> 'outputs' is present.

ACK - fixed for the next patch.

On Wed, Aug 27, 2025 at 9:46=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> On Tue, Jul 22, 2025 at 07:08:24PM +0000, Andrew Keesler wrote:
> > In 454f4b0f, we started down the path of supporting separate
> > configurations per display head (e.g., you have 2 heads - one with
> > EDID name "AAA" and the other with EDID name "BBB").
> >
> > In this change, we add resolution to this configuration surface (e.g.,
> > you have 2 heads - one with resolution 111x222 and the other with
> > resolution 333x444).
> >
> >   -display vnc=3Dlocalhost:0,id=3Daaa,display=3Dvga,head=3D0 \
> >   -display vnc=3Dlocalhost:1,id=3Dbbb,display=3Dvga,head=3D1 \
> >   -device '{"driver":"virtio-vga",
> >             "max_outputs":2,
> >             "id":"vga",
> >             "outputs":[
> >               {
> >                  "name":"AAA",
> >                  "xres":111,
> >                  "yres":222
> >               },
> >               {
> >                  "name":"BBB",
> >                  "xres":333,
> >                  "yres":444
> >               }
> >             ]}'
> >
> > If no virtio_gpu_base_conf.outputs are provided, then
> > virtio_gpu_base_conf.xres/virtio_gpu_base_conf.yres will still be
> > respected, preserving backwards compatibility.
>
> IIUC from the current code, xres/yres are only set against the
> first head. The 2nd and later heads are left undefined by the
> virtio-gpu-base code at least - I'm unclear if something else
> in QEMU will fill in defaults later, or if they set to 0x0.
>
> > Otherwise, if any virtio_gpu_base_conf.outputs are provided, then
> > virtio_gpu_base_conf.outputs.xres/virtio_gpu_base_conf.outputs.yres
> > will take precedence. In this case,
> > virtio_gpu_base_conf.outputs.xres/virtio_gpu_base_conf.outputs.yres
> > must be non-zero.
>
> Makes sense.
>
> > Signed-off-by: Andrew Keesler <ankeesler@google.com>
> > ---
> >  hw/display/virtio-gpu-base.c | 12 ++++++++++++
> >  qapi/virtio.json             |  6 +++++-
> >  2 files changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.=
c
> > index 7269477a1c..1fc879cc93 100644
> > --- a/hw/display/virtio-gpu-base.c
> > +++ b/hw/display/virtio-gpu-base.c
> > @@ -206,6 +206,10 @@ virtio_gpu_base_device_realize(DeviceState *qdev,
> >                         node->value->name, EDID_NAME_MAX_LENGTH);
> >              return false;
> >          }
> > +        if (node->value && !(node->value->xres && node->value->yres)) =
{
> > +            error_setg(errp, "invalid resolution =3D=3D 0");
> > +            return false;
> > +        }
> >      }
> >
> >      if (virtio_gpu_virgl_enabled(g->conf)) {
> > @@ -233,6 +237,14 @@ virtio_gpu_base_device_realize(DeviceState *qdev,
> >      g->req_state[0].width =3D g->conf.xres;
> >      g->req_state[0].height =3D g->conf.yres;
> >
> > +    for (output_idx =3D 0, node =3D g->conf.outputs;
> > +         node && output_idx < g->conf.max_outputs;
> > +         output_idx++, node =3D node->next) {
> > +        g->enabled_output_bitmask |=3D (1 << output_idx);
>
> This change means that all heads are enabled by default if the 'outputs'
> property array is set, which is a semantic difference from the previous
> behaviour before xres/yres are added as properties.
>
> Is it relevant to set xres/yres on outputs, even when they are
> not (yet) enabled ?  Perhaps we should have an explicit 'enabled: bool'
> property in the 'outputs' struct ?
>
> > +        g->req_state[output_idx].width =3D node->value->xres;
> > +        g->req_state[output_idx].height =3D node->value->yres;
> > +    }
>
> For head 0, this is overwriting the defaults set a few lines
> earlier.
>
> I think we should probably report an error if xres / yres
> are set at the global level and also set against any individual
> output, so the two approaches are mutually exclusive.
>
> >      g->hw_ops =3D &virtio_gpu_ops;
> >      for (i =3D 0; i < g->conf.max_outputs; i++) {
> >          g->scanout[i].con =3D
> > diff --git a/qapi/virtio.json b/qapi/virtio.json
> > index 9d652fe4a8..36581690c7 100644
> > --- a/qapi/virtio.json
> > +++ b/qapi/virtio.json
> > @@ -970,11 +970,15 @@
> >  #
> >  # @name: the name of the output
> >  #
> > +# @xres: horizontal resolution of the output in pixels
> > +#
> > +# @yres: vertical resolution of the output in pixels
> > +#
>
> Sorry, we missed the boat for 10.1, so these two new properties
> will require an explicit "Since 10.2" tag against them, separate
> from the overall struct versrion below.
>
> >  # Since: 10.1
> >  ##
> >
> >  { 'struct': 'VirtIOGPUOutput',
> > -  'data': { 'name': 'str' } }
> > +  'data': { 'name': 'str', 'xres': 'uint16', 'yres': 'uint16' } }
>
> This is a backcompat problem, because xres/yres are mandatory if
> 'outputs' is present.
>
> $ ./qemu-system-x86_64 -device
> '{"driver":"virtio-vga","outputs":[{"name":"AAA"},{"name":"BBB"}],"max_ou=
tputs":2,"id":"v0"}'
> qemu-system-x86_64: -device
> {"driver":"virtio-vga","outputs":[{"name":"AAA"},{"name":"BBB"}],"max_out=
puts":2,"id":"v0"}:
> Parameter 'outputs[0].xres' is missing
>
> These need to be marked optional, to be compatible with existing use
> of 'outputs' from the 10.1.0 release.
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

--00000000000083dd24063d5ab929
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Sending again (replying all this time).</div><div><br=
></div>&gt; IIUC from the current code, xres/yres are only set against the<=
br>&gt; first head. The 2nd and later heads are left undefined by the<br>&g=
t; virtio-gpu-base code at least - I&#39;m unclear if something else<br>&gt=
; in QEMU will fill in defaults later, or if they set to 0x0.<br><br>That i=
s correct - xres/yres are only set against the first head in the<br>current=
 code. The wording in my commit message (and cover letter) was<br>misleadin=
g. I will fix that to say that &quot;If no<br>virtio_gpu_base_conf.outputs =
are provided,<br>virtio_gpu_base_conf.xres/virtio_gpu_base_conf.yres will s=
till be<br>respected _for the first head_ for backwards compatibility&quot;=
.<br><br>The only way I could get QEMU to fill in xres/yres for a 2nd and l=
ater<br>head was to trigger virtio_gpu_ops.ui_info via a VNC client.<br><br=
>&gt; Is it relevant to set xres/yres on outputs, even when they are<br>&gt=
; not (yet) enabled ?=C2=A0 Perhaps we should have an explicit &#39;enabled=
: bool&#39;<br>&gt; property in the &#39;outputs&#39; struct ?<br><br>Maybe=
 you might want to set xres/yres on an output, but not enable it<br>yet? I =
don&#39;t have any concrete examples of when you might want to do<br>that, =
maybe you have some examples?<br><br>I feel like I could see a user setting=
 xres/yres on an output,<br>forgetting to set enabled on that output, and t=
hen being confused why<br>their head is blank. Because of this, my vote wou=
ld be to default to<br>enabling an output when it has configuration. I am e=
asily swayed by<br>your guidance, though.<br><br>&gt; I think we should pro=
bably report an error if xres / yres<br>&gt; are set at the global level an=
d also set against any individual<br>&gt; output, so the two approaches are=
 mutually exclusive.<br><br>ACK - fixed for the next patch.<br><br>&gt; Sor=
ry, we missed the boat for 10.1, so these two new properties<br>&gt; will r=
equire an explicit &quot;Since 10.2&quot; tag against them, separate<br>&gt=
; from the overall struct versrion below.<br><br>ACK - fixed for the next p=
atch.<br><br>&gt; This is a backcompat problem, because xres/yres are manda=
tory if<br>&gt; &#39;outputs&#39; is present.<br><br>ACK - fixed for the ne=
xt patch.</div><br><div class=3D"gmail_quote gmail_quote_container"><div di=
r=3D"ltr" class=3D"gmail_attr">On Wed, Aug 27, 2025 at 9:46=E2=80=AFAM Dani=
el P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@red=
hat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">On Tue, Jul 22, 2025 at 07:08:24PM +0000, Andrew Keesler wrote:<br>
&gt; In 454f4b0f, we started down the path of supporting separate<br>
&gt; configurations per display head (e.g., you have 2 heads - one with<br>
&gt; EDID name &quot;AAA&quot; and the other with EDID name &quot;BBB&quot;=
).<br>
&gt; <br>
&gt; In this change, we add resolution to this configuration surface (e.g.,=
<br>
&gt; you have 2 heads - one with resolution 111x222 and the other with<br>
&gt; resolution 333x444).<br>
&gt; <br>
&gt;=C2=A0 =C2=A0-display vnc=3Dlocalhost:0,id=3Daaa,display=3Dvga,head=3D0=
 \<br>
&gt;=C2=A0 =C2=A0-display vnc=3Dlocalhost:1,id=3Dbbb,display=3Dvga,head=3D1=
 \<br>
&gt;=C2=A0 =C2=A0-device &#39;{&quot;driver&quot;:&quot;virtio-vga&quot;,<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;max_outputs&quot;=
:2,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;id&quot;:&quot;vg=
a&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;outputs&quot;:[<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;na=
me&quot;:&quot;AAA&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;xr=
es&quot;:111,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;yr=
es&quot;:222<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;na=
me&quot;:&quot;BBB&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;xr=
es&quot;:333,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;yr=
es&quot;:444<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0]}&#39;<br>
&gt; <br>
&gt; If no virtio_gpu_base_conf.outputs are provided, then<br>
&gt; virtio_gpu_base_conf.xres/virtio_gpu_base_conf.yres will still be<br>
&gt; respected, preserving backwards compatibility.<br>
<br>
IIUC from the current code, xres/yres are only set against the<br>
first head. The 2nd and later heads are left undefined by the<br>
virtio-gpu-base code at least - I&#39;m unclear if something else<br>
in QEMU will fill in defaults later, or if they set to 0x0.<br>
<br>
&gt; Otherwise, if any virtio_gpu_base_conf.outputs are provided, then<br>
&gt; virtio_gpu_base_conf.outputs.xres/virtio_gpu_base_conf.outputs.yres<br=
>
&gt; will take precedence. In this case,<br>
&gt; virtio_gpu_base_conf.outputs.xres/virtio_gpu_base_conf.outputs.yres<br=
>
&gt; must be non-zero.<br>
<br>
Makes sense.<br>
<br>
&gt; Signed-off-by: Andrew Keesler &lt;<a href=3D"mailto:ankeesler@google.c=
om" target=3D"_blank">ankeesler@google.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 hw/display/virtio-gpu-base.c | 12 ++++++++++++<br>
&gt;=C2=A0 qapi/virtio.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
|=C2=A0 6 +++++-<br>
&gt;=C2=A0 2 files changed, 17 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base=
.c<br>
&gt; index 7269477a1c..1fc879cc93 100644<br>
&gt; --- a/hw/display/virtio-gpu-base.c<br>
&gt; +++ b/hw/display/virtio-gpu-base.c<br>
&gt; @@ -206,6 +206,10 @@ virtio_gpu_base_device_realize(DeviceState *qdev,=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0node-&gt;value-&gt;name, EDID_NAME_MAX_LENGTH);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (node-&gt;value &amp;&amp; !(node-&gt;=
value-&gt;xres &amp;&amp; node-&gt;value-&gt;yres)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;inva=
lid resolution =3D=3D 0&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (virtio_gpu_virgl_enabled(g-&gt;conf)) {<br>
&gt; @@ -233,6 +237,14 @@ virtio_gpu_base_device_realize(DeviceState *qdev,=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g-&gt;req_state[0].width =3D g-&gt;conf.xres;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g-&gt;req_state[0].height =3D g-&gt;conf.yres;<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 for (output_idx =3D 0, node =3D g-&gt;conf.outputs;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0node &amp;&amp; output_idx &lt; g-&=
gt;conf.max_outputs;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0output_idx++, node =3D node-&gt;nex=
t) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g-&gt;enabled_output_bitmask |=3D (1 &lt;=
&lt; output_idx);<br>
<br>
This change means that all heads are enabled by default if the &#39;outputs=
&#39;<br>
property array is set, which is a semantic difference from the previous<br>
behaviour before xres/yres are added as properties.<br>
<br>
Is it relevant to set xres/yres on outputs, even when they are<br>
not (yet) enabled ?=C2=A0 Perhaps we should have an explicit &#39;enabled: =
bool&#39;<br>
property in the &#39;outputs&#39; struct ?<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g-&gt;req_state[output_idx].width =3D nod=
e-&gt;value-&gt;xres;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g-&gt;req_state[output_idx].height =3D no=
de-&gt;value-&gt;yres;<br>
&gt; +=C2=A0 =C2=A0 }<br>
<br>
For head 0, this is overwriting the defaults set a few lines<br>
earlier.<br>
<br>
I think we should probably report an error if xres / yres<br>
are set at the global level and also set against any individual<br>
output, so the two approaches are mutually exclusive.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g-&gt;hw_ops =3D &amp;virtio_gpu_ops;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; g-&gt;conf.max_outputs; i++) =
{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g-&gt;scanout[i].con =3D<br>
&gt; diff --git a/qapi/virtio.json b/qapi/virtio.json<br>
&gt; index 9d652fe4a8..36581690c7 100644<br>
&gt; --- a/qapi/virtio.json<br>
&gt; +++ b/qapi/virtio.json<br>
&gt; @@ -970,11 +970,15 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # @name: the name of the output<br>
&gt;=C2=A0 #<br>
&gt; +# @xres: horizontal resolution of the output in pixels<br>
&gt; +#<br>
&gt; +# @yres: vertical resolution of the output in pixels<br>
&gt; +#<br>
<br>
Sorry, we missed the boat for 10.1, so these two new properties<br>
will require an explicit &quot;Since 10.2&quot; tag against them, separate<=
br>
from the overall struct versrion below.<br>
<br>
&gt;=C2=A0 # Since: 10.1<br>
&gt;=C2=A0 ##<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 { &#39;struct&#39;: &#39;VirtIOGPUOutput&#39;,<br>
&gt; -=C2=A0 &#39;data&#39;: { &#39;name&#39;: &#39;str&#39; } }<br>
&gt; +=C2=A0 &#39;data&#39;: { &#39;name&#39;: &#39;str&#39;, &#39;xres&#39=
;: &#39;uint16&#39;, &#39;yres&#39;: &#39;uint16&#39; } }<br>
<br>
This is a backcompat problem, because xres/yres are mandatory if<br>
&#39;outputs&#39; is present.<br>
<br>
$ ./qemu-system-x86_64 -device &#39;{&quot;driver&quot;:&quot;virtio-vga&qu=
ot;,&quot;outputs&quot;:[{&quot;name&quot;:&quot;AAA&quot;},{&quot;name&quo=
t;:&quot;BBB&quot;}],&quot;max_outputs&quot;:2,&quot;id&quot;:&quot;v0&quot=
;}&#39;<br>
qemu-system-x86_64: -device {&quot;driver&quot;:&quot;virtio-vga&quot;,&quo=
t;outputs&quot;:[{&quot;name&quot;:&quot;AAA&quot;},{&quot;name&quot;:&quot=
;BBB&quot;}],&quot;max_outputs&quot;:2,&quot;id&quot;:&quot;v0&quot;}: Para=
meter &#39;outputs[0].xres&#39; is missing<br>
<br>
These need to be marked optional, to be compatible with existing use<br>
of &#39;outputs&#39; from the 10.1.0 release.<br>
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D"http=
s://www.flickr.com/photos/dberrange" rel=3D"noreferrer" target=3D"_blank">h=
ttps://www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer" target=3D"_blank">htt=
ps://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com" rel=3D"n=
oreferrer" target=3D"_blank">https://fstop138.berrange.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer" target=3D"_bla=
nk">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D=
"https://www.instagram.com/dberrange" rel=3D"noreferrer" target=3D"_blank">=
https://www.instagram.com/dberrange</a> :|<br>
<br>
</blockquote></div>

--00000000000083dd24063d5ab929--

