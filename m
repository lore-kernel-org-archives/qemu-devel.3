Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C3EECAC583
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 12:05:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvx50-0000DE-Cy; Tue, 09 Sep 2025 08:04:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankeesler@google.com>)
 id 1uvx4u-0000CX-Fd
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 08:04:04 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ankeesler@google.com>)
 id 1uvx4p-0003Dx-7K
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 08:04:04 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-336cdca64e6so38780871fa.0
 for <qemu-devel@nongnu.org>; Tue, 09 Sep 2025 05:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1757419431; x=1758024231; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FEUOPj7NuKAVnDRtEWWuaRTIv9+nskvHZzVfDKdp7Ag=;
 b=hIBmV4ODEYHowyJwdbiNOvBsFWuJw0nUg6V/OwXv0FYn0fw4iMA3kBKi5uD7fisRRM
 KlJRgS3wBzo6Tm1VVRAcOlAtJNkExyK9EXiM2lcVuNvligcuZzsttqD7kFJl4Qk7w11D
 lF/nHbawO3THuMvAt9y7fPU9syEYFRiRYgpNQtm7+4sOuj0yIC/gH+ufALEQg7+/Ig5N
 9SMwKPjWgl2zUFnC251VB62mkCpx78Z9CyDlePW2LL2uJsd+68OeUD2Qtm2PiluX7qR0
 5c1gO2lih/wT/9BH3MOo1QUTMz/0JDofv+CJsSNP8v+jDqQYQ1w00RX1Z130EQGZwyg8
 CNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757419431; x=1758024231;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FEUOPj7NuKAVnDRtEWWuaRTIv9+nskvHZzVfDKdp7Ag=;
 b=Ut8ZcvsYfyy03GDzBAOF8JQ1qn67ZD+PhiMvMKMaZTveUOHrQAakEFg4O45fFqjpjr
 jpaQfvzjt7vsXE899+ovyt+ItsaTZVjTGXlWBIJFu1kdwO48H65ZVJwywQAaaWYtBL/q
 Ayz64UXeePhaUdsvujcRos40ORRMvHtGL4DUl0nQMGK5rNjxm7vS97UiVpua6XfGBTEk
 QSnD1fOy2FDgSjCPhekpwjMi9b7N1l2p611nc82xzPsuvvqUdEisf0RACeQkda0oNhEQ
 R+wGt9Xz2sIHiHkFM3ZitZWW8boXRNvsopQ3fIABtuVygXztYBmN61CZzFbGL34Z+9Yt
 Ca7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUso5BGFumtUgwEsEpxY/raZsdqi/jmgtBPFHto7WyOS+nS+jOrgOpVJcMxbBCplZWTVMOWy0LaONXA@nongnu.org
X-Gm-Message-State: AOJu0YyD+7apq8bUY1Xr6c58aaovyReXLrI5Om87IXLPU1PULIr9Ri48
 Z+5Enzp19TqOiBGCkK1FsdRA7vKybQLxiWaYUgKrZC+Xr9ZyiX+J/MhjCV2VcEOsPbzmJZj+kfF
 CWD6DJpnwy9XObs0sYM5GuyexyaZyr5U0aF+EeEk=
X-Gm-Gg: ASbGnctv4sGKM8SBuca9G26OgpbBMVqYTKVrt9ayY4+87KjEOI8vtSUZFIm3i6DIHR6
 nXzOynISAEpQ3uX7m2z+/GzmCJ96KRXQJrREIb9KEj66TyhwcP09B18tZkxogjIFiHzITwhXftL
 lElnrqyhCIkagonRnG4OImdXBCUj6NFeuEeFTeKG2kilgYR0NMWWWLW1d8nmABXlU8Xt2O5UjIO
 CVlm3yQxGOwbYRLgHJCeH/E2PoTF8/OiHvA9nNfJTH1B5/ayolZRXA=
X-Google-Smtp-Source: AGHT+IH/zE0N4zndZiY1rKsnid8mn/WHgnb2txsrYqfJzB97ou8VpqdWWiPuaobCg6idzPIPYJmCOBY/iCIoqVDsPuM=
X-Received: by 2002:a2e:a99e:0:b0:336:dde8:2cbb with SMTP id
 38308e7fff4ca-33b61638a43mr25589551fa.42.1757419430709; Tue, 09 Sep 2025
 05:03:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250902141312.750525-1-ankeesler@google.com>
 <20250902141312.750525-2-ankeesler@google.com>
 <aL_xJCxOMQdIkH9S@redhat.com>
In-Reply-To: <aL_xJCxOMQdIkH9S@redhat.com>
From: Andrew Keesler <ankeesler@google.com>
Date: Tue, 9 Sep 2025 08:03:39 -0400
X-Gm-Features: Ac12FXxSiwmwLGnxcL7HqT570ksAXQlycQqLwoEnm1tdUSqekkGrNe8eFmODb7M
Message-ID: <CAGZECHN1CRqmL8MRLO1JToVpSxrhQ=wRkd1BWChvj2CjmpjtMg@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] Support per-head resolutions with virtio-gpu
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: marcandre.lureau@gmail.com, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000e4823a063e5d18fb"
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=ankeesler@google.com; helo=mail-lj1-x22b.google.com
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

--000000000000e4823a063e5d18fb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Andrew Keesler <ankeesler@google.com>


On Tue, Sep 9, 2025 at 5:19=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com>
wrote:

> On Tue, Sep 02, 2025 at 02:13:12PM +0000, Andrew Keesler wrote:
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
> > Here is the behavior matrix of the current resolution configuration
> > surface (xres/yres) with the new resolution configuration surface
> > (outputs[i].xres/yres).
> >
> > Case: !(xres || yres) && !(outputs[i].has_xres && outputs[i].has_yres)
> > Behavior: current behavior - outputs[0] enabled with default xres/yres
> >
> > Case: (xres || yres) && !(outputs[i].has_xres && outputs[i].has_yres)
> > Behavior: current behavior - outputs[0] enabled with xres/yres
> >
> > Case: !(xres || yres) && (outputs[i].has_xres && outputs[i].has_yres)
> > Behavior: new behavior - outputs[i] enabled with outputs[i].xres/yres
> >
> > Case: (xres || yres) && (outputs[i].has_xres && outputs[i].has_yres)
> > Behavior: new behavior - outputs[i] enabled with outputs[i].xres/yres
>
> This commit lacks the Signed-off-by line to assert compliance
> with the DCO. Assuming  you agree, can you just reply to this
> mail with your S-o-b and then I'll queue this.
>
> > ---
> >  hw/display/virtio-gpu-base.c | 10 ++++++++++
> >  qapi/virtio.json             | 10 ++++++++--
> >  2 files changed, 18 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.=
c
> > index 7269477a1c..6adb5312a4 100644
> > --- a/hw/display/virtio-gpu-base.c
> > +++ b/hw/display/virtio-gpu-base.c
> > @@ -233,6 +233,16 @@ virtio_gpu_base_device_realize(DeviceState *qdev,
> >      g->req_state[0].width =3D g->conf.xres;
> >      g->req_state[0].height =3D g->conf.yres;
> >
> > +    for (output_idx =3D 0, node =3D g->conf.outputs;
> > +         node && output_idx < g->conf.max_outputs;
> > +         output_idx++, node =3D node->next) {
> > +        if (node->value->has_xres && node->value->has_yres) {
> > +            g->enabled_output_bitmask |=3D (1 << output_idx);
> > +            g->req_state[output_idx].width =3D node->value->xres;
> > +            g->req_state[output_idx].height =3D node->value->yres;
> > +        }
> > +    }
> > +
> >      g->hw_ops =3D &virtio_gpu_ops;
> >      for (i =3D 0; i < g->conf.max_outputs; i++) {
> >          g->scanout[i].con =3D
> > diff --git a/qapi/virtio.json b/qapi/virtio.json
> > index 9d652fe4a8..9469c63e81 100644
> > --- a/qapi/virtio.json
> > +++ b/qapi/virtio.json
> > @@ -966,15 +966,21 @@
> >  ##
> >  # @VirtIOGPUOutput:
> >  #
> > -# Describes configuration of a VirtIO GPU output.
> > +# Describes configuration of a VirtIO GPU output. If both xres and
> > +# yres are set, they take precedence over root virtio-gpu
> > +# resolution configuration and enable the corresponding output.
> >  #
> >  # @name: the name of the output
> >  #
> > +# @xres: horizontal resolution of the output in pixels (since 10.2)
> > +#
> > +# @yres: vertical resolution of the output in pixels (since 10.2)
> > +#
> >  # Since: 10.1
> >  ##
> >
> >  { 'struct': 'VirtIOGPUOutput',
> > -  'data': { 'name': 'str' } }
> > +  'data': { 'name': 'str', '*xres': 'uint16', '*yres': 'uint16' } }
> >
> >  ##
> >  # @DummyVirtioForceArrays:
> > --
> > 2.51.0.338.gd7d06c2dae-goog
> >
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

--000000000000e4823a063e5d18fb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Signed-off-by: Andrew Keesler &lt;<a href=3D"mailto:a=
nkeesler@google.com">ankeesler@google.com</a>&gt;</div><div><br></div></div=
><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" clas=
s=3D"gmail_attr">On Tue, Sep 9, 2025 at 5:19=E2=80=AFAM Daniel P. Berrang=
=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@redhat.com</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Tue=
, Sep 02, 2025 at 02:13:12PM +0000, Andrew Keesler wrote:<br>
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
&gt; Here is the behavior matrix of the current resolution configuration<br=
>
&gt; surface (xres/yres) with the new resolution configuration surface<br>
&gt; (outputs[i].xres/yres).<br>
&gt; <br>
&gt; Case: !(xres || yres) &amp;&amp; !(outputs[i].has_xres &amp;&amp; outp=
uts[i].has_yres)<br>
&gt; Behavior: current behavior - outputs[0] enabled with default xres/yres=
<br>
&gt; <br>
&gt; Case: (xres || yres) &amp;&amp; !(outputs[i].has_xres &amp;&amp; outpu=
ts[i].has_yres)<br>
&gt; Behavior: current behavior - outputs[0] enabled with xres/yres<br>
&gt; <br>
&gt; Case: !(xres || yres) &amp;&amp; (outputs[i].has_xres &amp;&amp; outpu=
ts[i].has_yres)<br>
&gt; Behavior: new behavior - outputs[i] enabled with outputs[i].xres/yres<=
br>
&gt; <br>
&gt; Case: (xres || yres) &amp;&amp; (outputs[i].has_xres &amp;&amp; output=
s[i].has_yres)<br>
&gt; Behavior: new behavior - outputs[i] enabled with outputs[i].xres/yres<=
br>
<br>
This commit lacks the Signed-off-by line to assert compliance<br>
with the DCO. Assuming=C2=A0 you agree, can you just reply to this<br>
mail with your S-o-b and then I&#39;ll queue this.<br>
<br>
&gt; ---<br>
&gt;=C2=A0 hw/display/virtio-gpu-base.c | 10 ++++++++++<br>
&gt;=C2=A0 qapi/virtio.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
| 10 ++++++++--<br>
&gt;=C2=A0 2 files changed, 18 insertions(+), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base=
.c<br>
&gt; index 7269477a1c..6adb5312a4 100644<br>
&gt; --- a/hw/display/virtio-gpu-base.c<br>
&gt; +++ b/hw/display/virtio-gpu-base.c<br>
&gt; @@ -233,6 +233,16 @@ virtio_gpu_base_device_realize(DeviceState *qdev,=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g-&gt;req_state[0].width =3D g-&gt;conf.xres;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g-&gt;req_state[0].height =3D g-&gt;conf.yres;<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 for (output_idx =3D 0, node =3D g-&gt;conf.outputs;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0node &amp;&amp; output_idx &lt; g-&=
gt;conf.max_outputs;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0output_idx++, node =3D node-&gt;nex=
t) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (node-&gt;value-&gt;has_xres &amp;&amp=
; node-&gt;value-&gt;has_yres) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g-&gt;enabled_output_bitmas=
k |=3D (1 &lt;&lt; output_idx);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g-&gt;req_state[output_idx]=
.width =3D node-&gt;value-&gt;xres;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g-&gt;req_state[output_idx]=
.height =3D node-&gt;value-&gt;yres;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g-&gt;hw_ops =3D &amp;virtio_gpu_ops;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; g-&gt;conf.max_outputs; i++) =
{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g-&gt;scanout[i].con =3D<br>
&gt; diff --git a/qapi/virtio.json b/qapi/virtio.json<br>
&gt; index 9d652fe4a8..9469c63e81 100644<br>
&gt; --- a/qapi/virtio.json<br>
&gt; +++ b/qapi/virtio.json<br>
&gt; @@ -966,15 +966,21 @@<br>
&gt;=C2=A0 ##<br>
&gt;=C2=A0 # @VirtIOGPUOutput:<br>
&gt;=C2=A0 #<br>
&gt; -# Describes configuration of a VirtIO GPU output.<br>
&gt; +# Describes configuration of a VirtIO GPU output. If both xres and<br=
>
&gt; +# yres are set, they take precedence over root virtio-gpu<br>
&gt; +# resolution configuration and enable the corresponding output.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # @name: the name of the output<br>
&gt;=C2=A0 #<br>
&gt; +# @xres: horizontal resolution of the output in pixels (since 10.2)<b=
r>
&gt; +#<br>
&gt; +# @yres: vertical resolution of the output in pixels (since 10.2)<br>
&gt; +#<br>
&gt;=C2=A0 # Since: 10.1<br>
&gt;=C2=A0 ##<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 { &#39;struct&#39;: &#39;VirtIOGPUOutput&#39;,<br>
&gt; -=C2=A0 &#39;data&#39;: { &#39;name&#39;: &#39;str&#39; } }<br>
&gt; +=C2=A0 &#39;data&#39;: { &#39;name&#39;: &#39;str&#39;, &#39;*xres&#3=
9;: &#39;uint16&#39;, &#39;*yres&#39;: &#39;uint16&#39; } }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 ##<br>
&gt;=C2=A0 # @DummyVirtioForceArrays:<br>
&gt; -- <br>
&gt; 2.51.0.338.gd7d06c2dae-goog<br>
&gt; <br>
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

--000000000000e4823a063e5d18fb--

