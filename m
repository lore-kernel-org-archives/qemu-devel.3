Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 504EAD59D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 20:55:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFg6p-0006gl-0i; Mon, 25 Nov 2024 15:55:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankeesler@google.com>)
 id 1tFg6j-0006dW-0E
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 15:55:00 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ankeesler@google.com>)
 id 1tFg6g-0005U3-4X
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 15:54:56 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-724d8422dbaso3746366b3a.0
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 12:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1732568092; x=1733172892; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YRBtVNibKHBvYFYFWpdZzXMwsskbSFfl42hu+opEYmE=;
 b=eoaZAV6LKBrACqN6qkMmEychqXk62T/VGc9DnNMHaK3CphGhq+wbl2crdKMh9MXIUQ
 ZMURZKxPpWxpKIBK3Mo6YFyexdi9I7oXsPOrBEPog4qCN7QG5PUmTflt6Lf0p/7+qcOl
 nvCvOcRW+SLCTI7NjrkkRXAzeebtq1n65onkbqcAy7XyqTwbYjLV63dGV/rp+vcM+ieZ
 VGnzN/FhF2ikXgHf0TGdX38+bjAONl8m2UZW6X8vrfDyCYK2/436CoXchafpq9o5Y3B5
 QxSwJ4lVItzrGwxnc6BQp8J/6en3qXf6lrNc1dpZGFp5IjYoZ71Nb+HIV9Ft/bdA0X/H
 krqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732568092; x=1733172892;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YRBtVNibKHBvYFYFWpdZzXMwsskbSFfl42hu+opEYmE=;
 b=stdP6DowAmjzgqTL7ivrHzko8RVMuOYXISbUMQJPYxNisBtVVNLbgASa0t9jTr1bpk
 RUn7sEuz9bGE0tImJqzS+LQcOh6WGZSlnIQLU9+YATUC2PNAE8D7CX/rB/8xsvvhRlEs
 FClTRUWrOiXEvkT6ibEehJjoD16yZ3eDwJ8rF5bzlujB6Bv3IHhagrq6kkgtShKuwPah
 LmGvU0PHvNI5Abmm1smMzk5dfVJyNluKlUCtXL6N5h3LSOYM6KP2RRTKCyAi9kwXi18z
 /MwC5yvOauAgt4PZhdyoQvh3a/muV+8NqJgYOztPGCmM7M9MwtNOcO+FZBb6s/VK2Ucc
 l3Lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/tcJXVhJMg53ECJ2TReq8kKOgsgfrocVTwXYubba5je++QYGF4F0p2qbn/BYfrIUeoABmVh/ey2AL@nongnu.org
X-Gm-Message-State: AOJu0YwLBMRVfL9x4tATMX4ys8+M1yRWp8xkHgyjhOXTIfj9S8+hLRXW
 4dsZmRqqr0wekD+ddrMulWQcJpaMqE2bSq+AzhtwMxoOCMTBJR0FU9PoCrfkVrfI2Yz4nu1s4uz
 1fOi2c4l0njSugDDhpmHj80aMY2g9d9SEjMM=
X-Gm-Gg: ASbGnctUGS1VuvzYCNMxo2hut5pY0yD1mj2F0u3dit+RpXZ/j2db99MzxX1qzm8KO36
 GC75RJmWycUfVcEEy1pK+rJ3Gmo4yCXcOE31BQ15twwm63ESzRK9PAzDTB/cRWBRO
X-Google-Smtp-Source: AGHT+IF0ezPTI+Q4N++H5M7PL+dhmiWLbnpxbjgS0O7RdoI1m97bwbF39ownVLJ7MdsqAElJ8ePG/VmRzx0sFuCIupY=
X-Received: by 2002:a05:6a00:21d0:b0:71e:f4:dbc with SMTP id
 d2e1a72fcca58-724df6b7f7bmr20125105b3a.25.1732568091558; Mon, 25 Nov 2024
 12:54:51 -0800 (PST)
MIME-Version: 1.0
References: <20241017215304.3916866-1-roqueh@google.com>
 <20241017215304.3916866-3-roqueh@google.com>
 <Z0RnuVKPHO1T2BfV@redhat.com>
In-Reply-To: <Z0RnuVKPHO1T2BfV@redhat.com>
From: Andrew Keesler <ankeesler@google.com>
Date: Mon, 25 Nov 2024 15:54:40 -0500
Message-ID: <CAGZECHOTT1bs0frj-QDyRtudFNb+VzD4tZsnk4Fj=Q0OH+1v3Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/display: Allow injection of virtio-gpu EDID name
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Roque Arcudia Hernandez <roqueh@google.com>, mst@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, venture@google.com
Content-Type: multipart/alternative; boundary="000000000000a6165d0627c2f191"
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=ankeesler@google.com; helo=mail-pf1-x434.google.com
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

--000000000000a6165d0627c2f191
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I follow what you are saying. I misunderstood what a "display" was in the
domain of QEMU. Yes, this makes more sense now.

> the user should give names for every output at startup

I see DEFINE_PROP_ARRAY exists. I can use that to define the new "outputs"
property. Any reason that each "output" would ever need to be an object
(rather than just a string)? Nothing comes to mind, I'm just taking a secon=
d
to think about API forwards compatibility.

> upto whatever they said for "max_outputs"

Where is the best place to perform this validation? I would imagine we woul=
d
want to fast-fail if the user provided more "outputs" than "max_outputs". I
can
perform the validation in virtio_gpu_base_get_features but that seems late.

Thanks for your help.

On Mon, Nov 25, 2024 at 7:04=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> On Thu, Oct 17, 2024 at 09:53:04PM +0000, Roque Arcudia Hernandez wrote:
> > From: Andrew Keesler <ankeesler@google.com>
> >
> > Thanks to 72d277a7, 1ed2cb32, and others, EDID (Extended Display
> Identification
> > Data) is propagated by QEMU such that a virtual display presents
> legitimate
> > metadata (e.g., name, serial number, preferred resolutions, etc.) to it=
s
> > connected guest.
> >
> > This change adds the ability to specify the EDID name for a particular
> > virtio-vga display. Previously, every virtual display would have the
> same name:
> > "QEMU Monitor". Now, we can inject names of displays in order to test
> guest
> > behavior that is specific to display names. We provide the ability to
> inject the
> > display name from the display configuration as that most closely
> resembles how
> > real displays work (hardware displays contain static EDID information
> that is
> > provided to every connected host).
> >
> > This new behavior must be enabled by setting the edid_name boolean
> property on
> > the display device (it is disabled by default).
> >
> > It should be noted that EDID names longer than 12 bytes will be
> truncated per
> > spec (I think?).
> >
> > Testing: verified that when I specified 2 outputs for a virtio-gpu with
> > edid_name set, the names matched those that I configured with my vnc
> display.
> >
> >   -display vnc=3Dlocalhost:0,id=3Daaa,display=3Dvga,head=3D0,name=3DAAA=
 \
> >   -display vnc=3Dlocalhost:1,id=3Dbbb,display=3Dvga,head=3D1,name=3DBBB=
 \
> >   -device virtio-vga,max_outputs=3D2,id=3Dvga,edid_name=3Dtrue
>
> Looking at this again, I'm thinking that it modelling this the wrong
> way around.
>
> On the QEMU side, we have a many<->many relationship between guest
> display devices and host / remote display outputs.
>
> If we assume every host / remote display output corresponds to a
> separate "window" though, then we can reduce that down to  a
> many:one relationship between host outputs and guest devices.
>
> Consider this valid config:
>
>   $ qemu-system-x86_64 \
>      -vnc :1 \
>      -spice port=3D5902,disable-ticketing \
>      -display gtk \
>      -device virtio-vga,max_outputs=3D2,id=3Dvga
>
> All three display outputs show the same guest display, so which
> of VNC, SPICE & GTK would the virtio-vga EDID data take its names
> from ?
>
> IMHO, the name is a property of the virtio-vga "output" and the
> various display backends should be honouring what that tells them
> ie your configuration above should instead be:
>
>    -display vnc=3Dlocalhost:0,id=3Daaa,display=3Dvga,head=3D0 \
>    -display vnc=3Dlocalhost:1,id=3Dbbb,display=3Dvga,head=3D1 \
>    -device '{"driver":"virtio-vga",
>              "max_outputs":2,
>              "id":"vga",
>              "outputs":[
>                {
>                   "name":"AAA",
>                },
>                {
>                   "name":"BBB",
>                },
>              ]}'
>
> ..whereupon we have to feed the EDID name from the device back to VNC,
> so VNC can tell the client of the head name.
>
> Note, I'm intentionally using JSON syntax for -device here, to illustrate
> handling of non-scalar properties.
>
> The set of active outputs can be turned on/off at runtime. We can declare
> that the user should give names for every output at startup, upto whateve=
r
> they said for "max_outputs". That way a name is available even when non-
> primary outputs are later turned on at runtime.
>
> The secondary reason why I think names ought to be handled with -device
> is that this is guest visible data, and as a general rule we aim for all
> guest visible data to be controlled via properties on the frontend, and
> not have the backend directly change what the guest sees.
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

--000000000000a6165d0627c2f191
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I follow=C2=A0what you are saying. I misunderstood what a =
&quot;display&quot; was in the<div>domain of QEMU. Yes, this makes more sen=
se now.</div><div><br></div><div>&gt; the user should give names for every =
output at startup</div><div><br></div><div>I see=C2=A0DEFINE_PROP_ARRAY exi=
sts. I can use that to define the new &quot;outputs&quot;</div><div>propert=
y. Any reason that each &quot;output&quot; would ever need to be an object<=
/div><div>(rather than just a string)? Nothing comes to mind, I&#39;m just =
taking a second</div><div>to think about API forwards compatibility.</div><=
div><br></div><div>&gt; upto whatever they said for &quot;max_outputs&quot;=
</div><div><br></div><div>Where is the best place to perform this validatio=
n? I would imagine we would</div><div>want to fast-fail if the user provide=
d more &quot;outputs&quot; than &quot;max_outputs&quot;. I can</div><div>pe=
rform the validation in=C2=A0virtio_gpu_base_get_features but that seems la=
te.</div><div><br></div><div>Thanks for your help.</div></div><br><div clas=
s=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Nov 25, 202=
4 at 7:04=E2=80=AFAM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange=
@redhat.com">berrange@redhat.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">On Thu, Oct 17, 2024 at 09:53:04PM +0000, =
Roque Arcudia Hernandez wrote:<br>
&gt; From: Andrew Keesler &lt;<a href=3D"mailto:ankeesler@google.com" targe=
t=3D"_blank">ankeesler@google.com</a>&gt;<br>
&gt; <br>
&gt; Thanks to 72d277a7, 1ed2cb32, and others, EDID (Extended Display Ident=
ification<br>
&gt; Data) is propagated by QEMU such that a virtual display presents legit=
imate<br>
&gt; metadata (e.g., name, serial number, preferred resolutions, etc.) to i=
ts<br>
&gt; connected guest.<br>
&gt; <br>
&gt; This change adds the ability to specify the EDID name for a particular=
<br>
&gt; virtio-vga display. Previously, every virtual display would have the s=
ame name:<br>
&gt; &quot;QEMU Monitor&quot;. Now, we can inject names of displays in orde=
r to test guest<br>
&gt; behavior that is specific to display names. We provide the ability to =
inject the<br>
&gt; display name from the display configuration as that most closely resem=
bles how<br>
&gt; real displays work (hardware displays contain static EDID information =
that is<br>
&gt; provided to every connected host).<br>
&gt; <br>
&gt; This new behavior must be enabled by setting the edid_name boolean pro=
perty on<br>
&gt; the display device (it is disabled by default).<br>
&gt; <br>
&gt; It should be noted that EDID names longer than 12 bytes will be trunca=
ted per<br>
&gt; spec (I think?).<br>
&gt; <br>
&gt; Testing: verified that when I specified 2 outputs for a virtio-gpu wit=
h<br>
&gt; edid_name set, the names matched those that I configured with my vnc d=
isplay.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0-display vnc=3Dlocalhost:0,id=3Daaa,display=3Dvga,head=3D0=
,name=3DAAA \<br>
&gt;=C2=A0 =C2=A0-display vnc=3Dlocalhost:1,id=3Dbbb,display=3Dvga,head=3D1=
,name=3DBBB \<br>
&gt;=C2=A0 =C2=A0-device virtio-vga,max_outputs=3D2,id=3Dvga,edid_name=3Dtr=
ue<br>
<br>
Looking at this again, I&#39;m thinking that it modelling this the wrong<br=
>
way around.<br>
<br>
On the QEMU side, we have a many&lt;-&gt;many relationship between guest<br=
>
display devices and host / remote display outputs.<br>
<br>
If we assume every host / remote display output corresponds to a<br>
separate &quot;window&quot; though, then we can reduce that down to=C2=A0 a=
<br>
many:one relationship between host outputs and guest devices.<br>
<br>
Consider this valid config:<br>
<br>
=C2=A0 $ qemu-system-x86_64 \<br>
=C2=A0 =C2=A0 =C2=A0-vnc :1 \<br>
=C2=A0 =C2=A0 =C2=A0-spice port=3D5902,disable-ticketing \<br>
=C2=A0 =C2=A0 =C2=A0-display gtk \<br>
=C2=A0 =C2=A0 =C2=A0-device virtio-vga,max_outputs=3D2,id=3Dvga<br>
<br>
All three display outputs show the same guest display, so which<br>
of VNC, SPICE &amp; GTK would the virtio-vga EDID data take its names<br>
from ?<br>
<br>
IMHO, the name is a property of the virtio-vga &quot;output&quot; and the<b=
r>
various display backends should be honouring what that tells them<br>
ie your configuration above should instead be:<br>
<br>
=C2=A0 =C2=A0-display vnc=3Dlocalhost:0,id=3Daaa,display=3Dvga,head=3D0 \<b=
r>
=C2=A0 =C2=A0-display vnc=3Dlocalhost:1,id=3Dbbb,display=3Dvga,head=3D1 \<b=
r>
=C2=A0 =C2=A0-device &#39;{&quot;driver&quot;:&quot;virtio-vga&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;max_outputs&quot;:2,<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;id&quot;:&quot;vga&qu=
ot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;outputs&quot;:[<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;name&q=
uot;:&quot;AAA&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;name&q=
uot;:&quot;BBB&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0]}&#39;<br>
<br>
..whereupon we have to feed the EDID name from the device back to VNC,<br>
so VNC can tell the client of the head name.<br>
<br>
Note, I&#39;m intentionally using JSON syntax for -device here, to illustra=
te<br>
handling of non-scalar properties.<br>
<br>
The set of active outputs can be turned on/off at runtime. We can declare<b=
r>
that the user should give names for every output at startup, upto whatever<=
br>
they said for &quot;max_outputs&quot;. That way a name is available even wh=
en non-<br>
primary outputs are later turned on at runtime.<br>
<br>
The secondary reason why I think names ought to be handled with -device<br>
is that this is guest visible data, and as a general rule we aim for all<br=
>
guest visible data to be controlled via properties on the frontend, and<br>
not have the backend directly change what the guest sees.<br>
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

--000000000000a6165d0627c2f191--

