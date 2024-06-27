Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4289C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 22:21:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMxTv-0002S5-8r; Thu, 27 Jun 2024 18:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <venture@google.com>)
 id 1sMxTt-0002Rr-9F
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 18:20:41 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <venture@google.com>)
 id 1sMxTp-0001TW-UO
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 18:20:41 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-57d00a51b71so2423a12.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 15:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1719526835; x=1720131635; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ht7ydO3k+JGiIWt72Nwf9YsP9aPH13RrZXxwjelKt1w=;
 b=Z5X94pN7D4SHDC+nCD9IjefxNP9MgVEwqUn3luO898c1QefTRmoTsw0uxg8YZMmUr1
 ZEvGAMwK/WU2Q2NSMal7w6O9NYjirO9/g1lhkv70t5IXYfHeJgxkQbXvikgwyPsft9nX
 SkoIEYXlawTN1gQ+uFXYmTuffa7QAOIEoHVUPfCL7jGFUqAIvIelWjDDpNxdR0o56KWt
 9y8B6V7cftBCwbTpTUZUjS4U+TH2c/p7NHsC9131yIlj9dKPgHziSVmx5A+S6KVUbIbS
 InDqlsqJKzLvlSij7fDo8s4DRx1fAecRbOi5qKT2ym3z85pEepjZnncVXljByjPP9+Qx
 hBmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719526835; x=1720131635;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ht7ydO3k+JGiIWt72Nwf9YsP9aPH13RrZXxwjelKt1w=;
 b=Yn10r6FYSJ1kD3n2+CD0g6qwkeP3a0etlfWQIE6rvJl/TjdNUJJXDYlwv+hC8GZEMm
 8mgQYORwAf5oytcSwjoz6R2LI94AUf5wwP6U0jpGxH/vOIcKDnKfZanYuLtjwV4RS8vT
 Zf5hZOET1Z+9/h6uWLde8axDOwWLmwCEs9OdhVEgjU+b9Vo5j7ygbs+whJ1rTqvDlzGN
 zKpBqi5gMYteQ0eCsMNnqKJeSTDT7GX2cv5D8Cs/BYbz/aOvP/ecg3/IidiX2Ozry8YB
 qz8s+nchMIXDl8KREIkCiwPAu96KSNEly1phSYI7Gk4YfNsr8eVstPXn0ZWfq0BRlPTq
 qd6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX50qyGyhmSQWHgaOxkhS5NwUEI0d6iYd/6uCd4vwN2KCtwHH4N1GhA6XIVaulN4i/UxwEGyx6uovaH2zc7AZd+Zs5CfOU=
X-Gm-Message-State: AOJu0YxsUi+GzhMVehjBBNBk7AZjzATSiHSH5U0DiASr81Cb36ydql+i
 C2LiSLzNEuX/+qB8x2daIkcpRoXfidyTmchyppK2dfkmYxoouqyqh7+6hXE0kcn/WwjmZUhEuj+
 yqPitsrRanVXH5To6o0xhMY0jt/us/UyXDq/6
X-Google-Smtp-Source: AGHT+IE0PfHmnrDJzVy81HOj0aIZ4DlyxrheJJ3PQvMLoD+QZkTwS/fGtKf9F0TfPO28l4r5MAldwwf86ZOPVyEZ4YY=
X-Received: by 2002:a50:d712:0:b0:57c:cfa9:837b with SMTP id
 4fb4d7f45d1cf-586041b0a1amr90531a12.0.1719526834273; Thu, 27 Jun 2024
 15:20:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAO=notyY_Jc2_Xq0NeK-0zUORy1n-6yuP5M_WXWEQnaqTmVXkw@mail.gmail.com>
 <87ed8pxt98.fsf@pond.sub.org>
In-Reply-To: <87ed8pxt98.fsf@pond.sub.org>
From: Patrick Leis <venture@google.com>
Date: Thu, 27 Jun 2024 15:20:21 -0700
Message-ID: <CAO=notwuCVqAtGP0sV6i5tXxZOJ3GM7W0ZcenRNnsiBpXPBDNQ@mail.gmail.com>
Subject: Re: standardizing i2c device ids
To: Markus Armbruster <armbru@redhat.com>
Cc: Corey Minyard <cminyard@mvista.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Titus Rwantare <titusr@google.com>, QEMU Developers <qemu-devel@nongnu.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000002485e6061be68a19"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=venture@google.com; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -180
X-Spam_score: -18.1
X-Spam_bar: ------------------
X-Spam_report: (-18.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.454,
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

--0000000000002485e6061be68a19
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 22, 2024 at 1:43=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:

> Patrick Leis <venture@google.com> writes:
>
> > Corey and Peter,
> >
> > My team builds lots of configurations for Qemu boards, and one pain poi=
nt
> > has been that the qom path for a device depends on the device insertion
> > order, child[0], child[1] and the like.
>
> Yes.
>
> Discussed in my "Dynamic & heterogeneous machines, initial
> configuration: problems" memo, under "Problem 4: The
> /machine/unattached/ orphanage".
>
> Copy of the "Problem 4" part appended for your your convenience.  Full
> memo archived at
> https://lore.kernel.org/qemu-devel/87o7d1i7ky.fsf@pond.sub.org/
>
> >                                          I noticed that the qdev paths
> for
> > devices also exist by their device id property.  By default, this ends =
up
> > being the device type name.
>
> Which kind of devices?
>
> There are onboard devices and user-created devices.
>
> A user-created device's QOM path is "/machine/peripheral/ID" when it was
> created with a qdev ID, and "/machine/peripheral-anon/device[N]" (where
> N counts up from zero) when it was created without a qdev ID.  N depends
> on creation order, which is under the user's control.  Users can and
> should avoid relying on their order by supplying an ID.
>
> An onboard device's QOM path is chosen by board code.  For instance, q35
> puts the mch device at "/machine/q35/mch".  However, if the board code
> neglects to put the device anywhere, the system puts it at
> "/machine/unattached/device[N]" (where N counts up from zero).  N
> depends on creation order.
>
> N can change at the drop of a hat.  Whether "device[N]" is a stable
> interface is unclear.  It would clearly be a bad one.
>
> If (part of) your problem is "/machine/peripheral-anon/device[N]",
> supply IDs to bypass it.
>
> If (part of) your problem is "/machine/unattached/device[N]", all I can
> offer is the proper solution: fix the board code to put the device in
> its proper place instead of abandoning it to the "/machine/unattached/"
> orphanage.
>
> >                              I was wondering if it made sense to overri=
de
> > this with the device type plus the smbus address?  I did something
> similar
> > with the i2c mux device, to resolve part of this issue.
>
> I doubt it.
>
> Questions?
>
>
>
> =3D Problem 4: The /machine/unattached/ orphanage =3D
>
> Is it okay for a QOM object to have no parent?
>
> An object without a parent is not part of the composition tree; it has
> no canonical path, and object_get_canonical_path() returns null.
>
> Such objects can behave in wonky ways.  For instance,
> object_property_set_link() treats a target object without a parent as
> null.  If a linked object somehow loses its parent,
> object_property_get_link() will return null even though the underlying C
> pointer still points to the poor orphan.
>
> This strongly suggests QOM was designed with the assumption that objects
> always have a parent, except during initialization (before they are
> connected to anything) and finalization (when no longer connected to
> anything).  object_property_try_add_child()'s contract seems to confirm
> this:
>
>  * Child properties form the composition tree.  All objects need to be a
> child
>  * of another object.  Objects can only be a child of one object.
>
> Some functions to create objects take the new object's parent as a
> parameter.  Example: object_new_with_props(), object_new_with_propv(),
> clock_new(), ...
>
> Others set a fixed parent.  For instance, we always add character
> backends to "/chardevs/", objects created with object-add in
> "/objects/", devices created with device_add in "/machine/peripheral/"
> (with ID) or "/machine/peripheral-anon/" (without ID), ...
>
> There are also functions that don't set a parent: object_new(),
> object_new_with_class(), qdev_new(), qdev_try_new(), ...  Setting a
> parent is the callers job then.  Invites misuse.  I'm aware of one
> instance: @current_migration remains without a parent forever.
>
> Not all callers care to set a parent themselves.  Instead, they rely on
> the "/machine/unattached/" orphanage:
>
> * qdev_connect_gpio_out_named() needs the input pin to have a parent.
>   If it lacks one, it gets added to "/machine/unattached/" with a
>   made-up name.
>
> * device_set_realized() ensures realized devices have a parent by adding
>   devices lacking one to "/machine/unattached/" with a made-up name.
>
> * portio_list_add() adds a memory region.  If the caller doesn't specify
>   the parent, "/machine/unattached/" is assumed.
>
> * memory_region_init() adds a memory region, and may set the parent.  If
>   the caller requests setting a parent without specifying one,
>   "/machine/unattached/" is assumed.
>
> * qemu_create_machine() adds the main system bus to
>   "/machine/unattached/".
>
> Except for the last one, the child names depend on execution order.  For
> instance, device_set_realized() uses "device[N]", where N counts up from
> zero.
>
> These brittle, made-up names are visible in QMP QOM introspection.
> Whether that's a stable interface is unclear.  Better not.
>
> We don't rely on these names in C.  We follow pointers instead.
>
> When we replace C code by configuration, we switch from pointers to
> names.  Brittle names become a problem.
>

Thank you for the explanation and related documentation.

--0000000000002485e6061be68a19
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sat, Jun 22, 2024 at 1:43=E2=80=AF=
AM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">Patrick Leis &lt;<a href=3D"mailto:venture@google.com" target=3D"_blank=
">venture@google.com</a>&gt; writes:<br>
<br>
&gt; Corey and Peter,<br>
&gt;<br>
&gt; My team builds lots of configurations for Qemu boards, and one pain po=
int<br>
&gt; has been that the qom path for a device depends on the device insertio=
n<br>
&gt; order, child[0], child[1] and the like.<br>
<br>
Yes.<br>
<br>
Discussed in my &quot;Dynamic &amp; heterogeneous machines, initial<br>
configuration: problems&quot; memo, under &quot;Problem 4: The<br>
/machine/unattached/ orphanage&quot;.<br>
<br>
Copy of the &quot;Problem 4&quot; part appended for your your convenience.=
=C2=A0 Full<br>
memo archived at<br>
<a href=3D"https://lore.kernel.org/qemu-devel/87o7d1i7ky.fsf@pond.sub.org/"=
 rel=3D"noreferrer" target=3D"_blank">https://lore.kernel.org/qemu-devel/87=
o7d1i7ky.fsf@pond.sub.org/</a><br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 I noticed that the qdev paths for<br>
&gt; devices also exist by their device id property.=C2=A0 By default, this=
 ends up<br>
&gt; being the device type name.<br>
<br>
Which kind of devices?<br>
<br>
There are onboard devices and user-created devices.<br>
<br>
A user-created device&#39;s QOM path is &quot;/machine/peripheral/ID&quot; =
when it was<br>
created with a qdev ID, and &quot;/machine/peripheral-anon/device[N]&quot; =
(where<br>
N counts up from zero) when it was created without a qdev ID.=C2=A0 N depen=
ds<br>
on creation order, which is under the user&#39;s control.=C2=A0 Users can a=
nd<br>
should avoid relying on their order by supplying an ID.<br>
<br>
An onboard device&#39;s QOM path is chosen by board code.=C2=A0 For instanc=
e, q35<br>
puts the mch device at &quot;/machine/q35/mch&quot;.=C2=A0 However, if the =
board code<br>
neglects to put the device anywhere, the system puts it at<br>
&quot;/machine/unattached/device[N]&quot; (where N counts up from zero).=C2=
=A0 N<br>
depends on creation order.<br>
<br>
N can change at the drop of a hat.=C2=A0 Whether &quot;device[N]&quot; is a=
 stable<br>
interface is unclear.=C2=A0 It would clearly be a bad one.<br>
<br>
If (part of) your problem is &quot;/machine/peripheral-anon/device[N]&quot;=
,<br>
supply IDs to bypass it.<br>
<br>
If (part of) your problem is &quot;/machine/unattached/device[N]&quot;, all=
 I can<br>
offer is the proper solution: fix the board code to put the device in<br>
its proper place instead of abandoning it to the &quot;/machine/unattached/=
&quot;<br>
orphanage.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 I was wondering if it made sense to over=
ride<br>
&gt; this with the device type plus the smbus address?=C2=A0 I did somethin=
g similar<br>
&gt; with the i2c mux device, to resolve part of this issue.<br>
<br>
I doubt it.<br>
<br>
Questions?<br>
<br>
<br>
<br>
=3D Problem 4: The /machine/unattached/ orphanage =3D<br>
<br>
Is it okay for a QOM object to have no parent?<br>
<br>
An object without a parent is not part of the composition tree; it has<br>
no canonical path, and object_get_canonical_path() returns null.<br>
<br>
Such objects can behave in wonky ways.=C2=A0 For instance,<br>
object_property_set_link() treats a target object without a parent as<br>
null.=C2=A0 If a linked object somehow loses its parent,<br>
object_property_get_link() will return null even though the underlying C<br=
>
pointer still points to the poor orphan.<br>
<br>
This strongly suggests QOM was designed with the assumption that objects<br=
>
always have a parent, except during initialization (before they are<br>
connected to anything) and finalization (when no longer connected to<br>
anything).=C2=A0 object_property_try_add_child()&#39;s contract seems to co=
nfirm<br>
this:<br>
<br>
=C2=A0* Child properties form the composition tree.=C2=A0 All objects need =
to be a child<br>
=C2=A0* of another object.=C2=A0 Objects can only be a child of one object.=
<br>
<br>
Some functions to create objects take the new object&#39;s parent as a<br>
parameter.=C2=A0 Example: object_new_with_props(), object_new_with_propv(),=
<br>
clock_new(), ...<br>
<br>
Others set a fixed parent.=C2=A0 For instance, we always add character<br>
backends to &quot;/chardevs/&quot;, objects created with object-add in<br>
&quot;/objects/&quot;, devices created with device_add in &quot;/machine/pe=
ripheral/&quot;<br>
(with ID) or &quot;/machine/peripheral-anon/&quot; (without ID), ...<br>
<br>
There are also functions that don&#39;t set a parent: object_new(),<br>
object_new_with_class(), qdev_new(), qdev_try_new(), ...=C2=A0 Setting a<br=
>
parent is the callers job then.=C2=A0 Invites misuse.=C2=A0 I&#39;m aware o=
f one<br>
instance: @current_migration remains without a parent forever.<br>
<br>
Not all callers care to set a parent themselves.=C2=A0 Instead, they rely o=
n<br>
the &quot;/machine/unattached/&quot; orphanage:<br>
<br>
* qdev_connect_gpio_out_named() needs the input pin to have a parent.<br>
=C2=A0 If it lacks one, it gets added to &quot;/machine/unattached/&quot; w=
ith a<br>
=C2=A0 made-up name.<br>
<br>
* device_set_realized() ensures realized devices have a parent by adding<br=
>
=C2=A0 devices lacking one to &quot;/machine/unattached/&quot; with a made-=
up name.<br>
<br>
* portio_list_add() adds a memory region.=C2=A0 If the caller doesn&#39;t s=
pecify<br>
=C2=A0 the parent, &quot;/machine/unattached/&quot; is assumed.<br>
<br>
* memory_region_init() adds a memory region, and may set the parent.=C2=A0 =
If<br>
=C2=A0 the caller requests setting a parent without specifying one,<br>
=C2=A0 &quot;/machine/unattached/&quot; is assumed.<br>
<br>
* qemu_create_machine() adds the main system bus to<br>
=C2=A0 &quot;/machine/unattached/&quot;.<br>
<br>
Except for the last one, the child names depend on execution order.=C2=A0 F=
or<br>
instance, device_set_realized() uses &quot;device[N]&quot;, where N counts =
up from<br>
zero.<br>
<br>
These brittle, made-up names are visible in QMP QOM introspection.<br>
Whether that&#39;s a stable interface is unclear.=C2=A0 Better not.<br>
<br>
We don&#39;t rely on these names in C.=C2=A0 We follow pointers instead.<br=
>
<br>
When we replace C code by configuration, we switch from pointers to<br>
names.=C2=A0 Brittle names become a problem.<br></blockquote><div><br></div=
><div>Thank you for the explanation and related documentation.</div><div>=
=C2=A0</div></div></div>

--0000000000002485e6061be68a19--

