Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4726E77183
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 07:16:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNoHA-0007IY-2v; Wed, 18 Dec 2024 02:15:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tNoH5-0007Hh-Hp
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 02:15:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tNoH3-0004qh-I2
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 02:15:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734506110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U93TQgLLoIkTtKTdI5e4laR1MCFfdfiDRfXPf0A7ixo=;
 b=F0B+O40UvZjFet2mZnKFVrojrkzv+drk5lTa8wDEUyU1vG+TW3mRH64FaCDFRZqsdv+Nh6
 fghWx66yUVgCDDwFYG5Q0FUYPiQo2X2vlDKoJibsnz/x6Vx99Y3+wCyfnou0RQY+PM2S9f
 QYO2WVnX9TNC7vIiPRPeM1Y9eyDiVoA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-60dxmsVVNLWxxLQOULJTrg-1; Wed, 18 Dec 2024 02:15:09 -0500
X-MC-Unique: 60dxmsVVNLWxxLQOULJTrg-1
X-Mimecast-MFC-AGG-ID: 60dxmsVVNLWxxLQOULJTrg
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-385d80576abso4208331f8f.3
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 23:15:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734506108; x=1735110908;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U93TQgLLoIkTtKTdI5e4laR1MCFfdfiDRfXPf0A7ixo=;
 b=Acwo4s0ZnfWFLRIVBZRvYILLX59DlD7G0G2pc23zqharxdpHv/m7eLB+NKyS/GCUt7
 gnzgpqKAyIGOFspzxN4hGuwUPPlI8WJkSwY55H8sILfPqvDTcugb5jdW6FpCEBUFe1Y7
 QRssIJ5XvU30nve14RC+zf2w7dENnNJPZl6VgE5u8QRp5IR5OWuQ0bqK4hUppthF0GYz
 HdEIZxA0Mmbcgg1BJiizcbumdhast/wY42tGAUPYmtQBnBFBneb+KFSDN8bMeqdl17nO
 7AZGOMJ0+pVtdnWXqbUcmZS4uv4tUuh6txiCNyz8ovys2VTsjPzKfPwqjrMUJ90PqjYj
 mb3g==
X-Gm-Message-State: AOJu0YzZJsILskYcf+MUFuCEOIBs1sUz+9UfAgqe8s5IgMeRoPyJCYKp
 CfUdNf+AE9E5IOhoPEwziBR8kPHS0yTdxkYZ26GrfeeIHi4vCbgMumI4GZN2oK+UR+iFlB9FECy
 lfSCLmOc3WwKmzVmPe1Ksdt+CX4UAPOb8WwHRBZgbYCd2lCJ5sgku7JT6PGESY5JK90tmHdWaSS
 bQOOTz+xjKF8oLw/6zBF9tEa/sOnM=
X-Gm-Gg: ASbGncvCWeq2rJZCu8R/sxhpnkvug8YmmIzSqJdnfwMgyWmzGsL8M1RFuaocCUr36pu
 cozqWnUsfQzuCGCs+NU4QCjVzJYBNyQBy+PiP
X-Received: by 2002:a05:6000:156b:b0:385:fb34:d5a0 with SMTP id
 ffacd0b85a97d-388e4d8ddaamr921453f8f.29.1734506107955; 
 Tue, 17 Dec 2024 23:15:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrRBplRshwaG8OO0AO/RA6RvB4L/wJY2adAYeDU+p5IAJVtHPQawwZXKspavDSgQJTUmTX9H3mWvtCfe3sKMI=
X-Received: by 2002:a05:6000:156b:b0:385:fb34:d5a0 with SMTP id
 ffacd0b85a97d-388e4d8ddaamr921434f8f.29.1734506107607; Tue, 17 Dec 2024
 23:15:07 -0800 (PST)
MIME-Version: 1.0
References: <20241209123717.99077-1-pbonzini@redhat.com>
 <20241209123717.99077-25-pbonzini@redhat.com>
 <Z2D2zk2Wdlqc5q2k@intel.com>
 <CABgObfY=jyu96eZ+ZcU9GXU+amt2wRm53vpvubHYTaeY9MWd2A@mail.gmail.com>
 <Z2JycooziPsfV8vX@intel.com>
In-Reply-To: <Z2JycooziPsfV8vX@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 18 Dec 2024 08:14:44 +0100
Message-ID: <CABgObfboJFTRMsuqO055g11ZWNx1qKNxrLgvYLc-Hh6RcmWtOw@mail.gmail.com>
Subject: Re: [PATCH 24/26] rust: qom: move device_id to PL011 class side
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org, 
 Junjie Mao <junjie.mao@hotmail.com>
Content-Type: multipart/alternative; boundary="00000000000067bcf20629862c14"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--00000000000067bcf20629862c14
Content-Type: text/plain; charset="UTF-8"

Il mer 18 dic 2024, 07:39 Zhao Liu <zhao1.liu@intel.com> ha scritto:

> I supposed a case, where there is such a QOM (QEMU Object Model)
> structure relationship:
>
> * DummyState / DummyClass: defined in Rust side, and registered the
>   TypeInfo by `Object` macro.
>
>   - So its class_init will be called by C QOM code.
>
> * DummyChildState / DummyChildClass: defined in Rust side as the
>   child-object of DummyState, and registered the TypeInfo by `Object`
>   macro. And suppose it can inherit the trait of DummyClass -
>   ClassInitImpl<DummyClass> (but I found a gap here, as detailed later;
>   I expect it should be able to inherit normally).
>
>  - So its class_init will be called by C QOM code. In C code call chain,
>    its parent's class_init should be called by C before its own
>    class_init.
>  - However, note that according to the Rust class initialization call
>    chain, it should also call the parent's class_init within its own
>    class_init.
>  - :( the parent's class_init gets called twice.
>

No, I don't think so. You have the same thing already with
PL011State/PL011Luminary.

There, you have

* object_class_init
* device_class_init
* sysbus_device_class_init
* <PL011State as ClassInitImpl<PL011Class>>::class_init
  * <PL011State as ClassInitImpl<SysBusDeviceClass>>::class_init
    * <PL011State as ClassInitImpl<DeviceClass>>::class_init
      * <PL011State as ClassInitImpl<ObjectClass>>::class_init
* <PL011Luminary as ClassInitImpl<PL011Class>>::class_init
  * <PL011Luminary as ClassInitImpl<SysBusDeviceClass>>::class_init
    * <PL011Luminary as ClassInitImpl<DeviceClass>>::class_init
      * <PL011Luminary as ClassInitImpl<ObjectClass>>::class_init

But note that these calls are all different and indeed the last three are
empty (all vtable entries are None). This is like a C class_init
implementation that does not set any of sdc, dc or oc.

Moving on to another topic, about the gap (or question :-)) where a
> child class inherits the ClassInitImpl trait from the parent, please see
> my test case example below: Doing something similar to SysBusDevice and
> DeviceState using a generic T outside of the QOM library would violate
> the orphan rule.
>

Ugh, you're right. Maybe ClassInitImpl should just be merged into
ObjectImpl etc. as a default method implementation. I will check.

> > But, when there is deeper class inheritance, it seems impossible to
> > > prevent class_init from being called both by the C side's QOM code and
> by
> > > this kind of recursive case on the Rust side.
> > >
> >
> > Note that here you have two parameters: what class is being filled (the
> > argument C of ClassInitImpl<C>) *and* what type is being initialized
> > (that's Self).
> >
> > The "recursion" is only on the argument C, and matches the way C code
> > implements class_init.
>
> For Rust side, PL011Class' class_init calls SysBusDeviceClass' class_init,
> and SysBusDeviceClass will also call DeviceClass' class_init. So this is
> also recursion, right?
>

No, Self is not PL011Class. Self is PL011State (or PL011Luminary/ and it
always remains the same. What changes is *what part* of the class is
overwritten, but the order of calls from qom/object.c follows the same
logic in both C and Rust.

> Maybe the confusion is because I implemented class_init twice instead of
> > using a separate trait "PL011Impl"?
>
> Ah, yes! But I think the Rust call chain should not use class_init anymore
> but should use a different method. This way, the original class_init would
> only serve the C QOM. A separate trait might break the inheritance
> relationship similar to ClassInitImpl.
>

Do you still think that this is the case? I will look into how to avoid the
problem with the orphan rule, but otherwise I think things are fine.

Paolo

>

--00000000000067bcf20629862c14
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il mer 18 dic 2024, 07:39 Zhao L=
iu &lt;<a href=3D"mailto:zhao1.liu@intel.com">zhao1.liu@intel.com</a>&gt; h=
a scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">I sup=
posed a case, where there is such a QOM (QEMU Object Model)<br>
structure relationship:<br>
<br>
* DummyState / DummyClass: defined in Rust side, and registered the<br>
=C2=A0 TypeInfo by `Object` macro.<br>
<br>
=C2=A0 - So its class_init will be called by C QOM code.<br>
<br>
* DummyChildState / DummyChildClass: defined in Rust side as the<br>
=C2=A0 child-object of DummyState, and registered the TypeInfo by `Object`<=
br>
=C2=A0 macro. And suppose it can inherit the trait of DummyClass -<br>
=C2=A0 ClassInitImpl&lt;DummyClass&gt; (but I found a gap here, as detailed=
 later;<br>
=C2=A0 I expect it should be able to inherit normally).<br>
<br>
=C2=A0- So its class_init will be called by C QOM code. In C code call chai=
n,<br>
=C2=A0 =C2=A0its parent&#39;s class_init should be called by C before its o=
wn<br>
=C2=A0 =C2=A0class_init.<br>
=C2=A0- However, note that according to the Rust class initialization call<=
br>
=C2=A0 =C2=A0chain, it should also call the parent&#39;s class_init within =
its own<br>
=C2=A0 =C2=A0class_init.<br>
=C2=A0- :( the parent&#39;s class_init gets called twice.<br></blockquote><=
/div></div><div dir=3D"auto"><br></div><div dir=3D"auto">No, I don&#39;t th=
ink so. You have the same thing already with PL011State/PL011Luminary.</div=
><div dir=3D"auto"><br></div><div dir=3D"auto">There, you have</div><div di=
r=3D"auto"><br></div><div dir=3D"auto">* object_class_init</div><div dir=3D=
"auto">* device_class_init</div><div dir=3D"auto">* sysbus_device_class_ini=
t</div><div dir=3D"auto">* &lt;PL011State as ClassInitImpl&lt;PL011Class&gt=
;&gt;::class_init</div><div dir=3D"auto">=C2=A0 * &lt;PL011State as ClassIn=
itImpl&lt;SysBusDeviceClass&gt;&gt;::class_init</div><div dir=3D"auto">=C2=
=A0 =C2=A0 * &lt;PL011State as ClassInitImpl&lt;DeviceClass&gt;&gt;::class_=
init</div><div dir=3D"auto">=C2=A0 =C2=A0 =C2=A0 * &lt;PL011State as ClassI=
nitImpl&lt;ObjectClass&gt;&gt;::class_init</div><div dir=3D"auto">* &lt;PL0=
11Luminary as ClassInitImpl&lt;PL011Class&gt;&gt;::class_init</div><div dir=
=3D"auto">=C2=A0 * &lt;PL011Luminary as ClassInitImpl&lt;SysBusDeviceClass&=
gt;&gt;::class_init</div><div dir=3D"auto">=C2=A0 =C2=A0 * &lt;PL011Luminar=
y as ClassInitImpl&lt;DeviceClass&gt;&gt;::class_init</div><div dir=3D"auto=
">=C2=A0 =C2=A0 =C2=A0 * &lt;PL011Luminary as ClassInitImpl&lt;ObjectClass&=
gt;&gt;::class_init</div><div dir=3D"auto"><br></div><div dir=3D"auto">But =
note that these calls are all different and indeed the last three are empty=
 (all vtable entries are None). This is like a C class_init implementation =
that does not set any of sdc, dc or oc.</div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">Moving on to another topic, about t=
he gap (or question :-)) where a<br>
child class inherits the ClassInitImpl trait from the parent, please see<br=
>
my test case example below: Doing something similar to SysBusDevice and<br>
DeviceState using a generic T outside of the QOM library would violate<br>
the orphan rule.<br></blockquote></div></div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto">Ugh, you&#39;re right. Maybe ClassInitImpl should just be m=
erged into ObjectImpl etc. as a default method implementation. I will check=
.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_qu=
ote gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">&gt; &gt; But, when there is deeper class inheritance, it seems impossibl=
e to<br>
&gt; &gt; prevent class_init from being called both by the C side&#39;s QOM=
 code and by<br>
&gt; &gt; this kind of recursive case on the Rust side.<br>
&gt; &gt;<br>
&gt; <br>
&gt; Note that here you have two parameters: what class is being filled (th=
e<br>
&gt; argument C of ClassInitImpl&lt;C&gt;) *and* what type is being initial=
ized<br>
&gt; (that&#39;s Self).<br>
&gt; <br>
&gt; The &quot;recursion&quot; is only on the argument C, and matches the w=
ay C code<br>
&gt; implements class_init.<br>
<br>
For Rust side, PL011Class&#39; class_init calls SysBusDeviceClass&#39; clas=
s_init,<br>
and SysBusDeviceClass will also call DeviceClass&#39; class_init. So this i=
s<br>
also recursion, right?<br></blockquote></div></div><div dir=3D"auto"><br></=
div><div dir=3D"auto">No, Self is not PL011Class. Self is PL011State (or PL=
011Luminary/ and it always remains the same. What changes is *what part* of=
 the class is overwritten, but the order of calls from qom/object.c follows=
 the same logic in both C and Rust.</div><div dir=3D"auto"><br></div><div d=
ir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
&gt; Maybe the confusion is because I implemented class_init twice instead =
of<br>
&gt; using a separate trait &quot;PL011Impl&quot;?<br>
<br>
Ah, yes! But I think the Rust call chain should not use class_init anymore<=
br>
but should use a different method. This way, the original class_init would<=
br>
only serve the C QOM. A separate trait might break the inheritance<br>
relationship similar to ClassInitImpl.<br></blockquote></div></div><div dir=
=3D"auto"><br></div><div dir=3D"auto">Do you still think that this is the c=
ase? I will look into how to avoid the problem with the orphan rule, but ot=
herwise I think things are fine.</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Paolo=C2=A0</div><div dir=3D"auto"><div class=3D"gmail_quote gmai=
l_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
</blockquote></div></div></div>

--00000000000067bcf20629862c14--


